{
  package,
  pkgs,
  platform,
  on,
}:
package {
  name = "re2";
  uses = [ "cmake" ];
  cmake.defs = {
    RE2_TEST = true; # RE2_BUILD_TESTING also wants google benchmark
  }
  # mingw: the tests' `testing` DLL dllexports a few symbols (util/pcre.h), which ends lld's
  # auto-export of the rest the tests use. Upstream sets CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS for MSVC
  # only, and cmake implements it for MSVC-style toolchains only
  // on (platform.abi == "gnu" && platform.os == "windows") {
    CMAKE_SHARED_LINKER_FLAGS = "-Wl,--export-all-symbols";
  };
  dependencies = [
    pkgs.abseil-cpp
    pkgs.googletest
  ];
}
