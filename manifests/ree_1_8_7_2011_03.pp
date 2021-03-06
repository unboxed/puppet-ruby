# Public: Install ree-1.8.7-2011.03 via rbenv.
#
# Usage:
#
#   include ree_1_8_7_2011_03

class ruby::ree_1_8_7_2011_03 {
  require gcc

  case $::osfamily {
    Darwin: {
      include homebrew::config

      $cc = $::macosx_productversion_major ? {
        '10.9'  => "${homebrew::config::installdir}/bin/gcc-4.8",
        default => "${homebrew::config::installdir}/bin/gcc-4.2",
      }

      $env = {
        'CC'       => $cc,
        'CPPFLAGS' => "-I${homebrew::config::installdir}/include -I/opt/X11/include",
      }
    }

    default: {
      $env = {
        'CC' => 'gcc'
      }
    }
  }

  ruby::version { 'ree-1.8.7-2011.03':
    env => $env
  }
}
