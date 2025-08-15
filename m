Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935D19004E
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220990; cv=none; b=nf3rpKvy7bjiQ4NiTkZzBXlCqY3STemJdtfgpQd6M4pGfmqs0GExBspPEd8xM3Z4x8NftZVKw9U13lgsxPCiIEvdos0QAboQyjDIoDGb+BrIbjF9X419UD1HcGbh5WLl83reruGErGtGevhJpITd9IPHDIRgWRLS8wJJsvIk+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220990; c=relaxed/simple;
	bh=CnzXYWCKfSKDlAX4iEfN4MnNJKyYrSs71J036SDkqxs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jO9ZSc/InVRDwYyPolcGSKuZVAuAyYA2uUJsCiLjGnoyIiLLNc5+ma50Vz3TA/PxOTbypFaRhac0rfBxijbzOJ7Wc/aHy/HlEUWlImPGFB4cLgP3WYjWGPsGvJN/zQv6Iyl/smQFTrDNUCtZUwWWFps+nO85fU01VWP9a2os20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+QwMeE8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+QwMeE8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso10573305e9.3
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220986; x=1755825786; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxH5KtLgKdBmLzqTH1M7zY3pURXytvhg8gSswLgff7I=;
        b=N+QwMeE8U1+5mGRsYTkMj1koEXsmseTVak/EbG0LvxRdM5CHHTHHwiWyjJWKiyjB+I
         CqCufD1uvHnQU5KZ6JqGPibaxPe+DNkll1yJoeE59QQneg74MwJhaC9fU4PPYwpxr2Pz
         H0qxIkm5o1nwNyCsp33ccbF2OCaMI4vFZN4AjOG3yB/aW9wRmIyy21S9MTVcJNZB1hd3
         Isg567LMZIpwkjMgX2fh1bdu73uS64JfA+qflC3/2MjCAZo9rEcmkI/GhM8gRNvlHF2r
         VbzWIQfKPMmuEI19ptTel3QlHzv7QEZ8Zk4BKfrvctXEtCzR9v1AFK5Q3HI5dPGZq/fc
         g0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220986; x=1755825786;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxH5KtLgKdBmLzqTH1M7zY3pURXytvhg8gSswLgff7I=;
        b=kdfdTyyw1sHSHmjP7Fh3iORj6x56Uat3Xj8xf/xX+L7I08cJXVNL2dT1faoOSoAeoC
         Ooa3tnxN38XxqL/KpdRMc+fp+DZSCX4/ya/eJhB22p/7svLNe7eIE7+5T5UiSr2Jnmvd
         VK6/EigS13Kc71AM/epGCNIQM18nIvsigugLrVax/uDhAEz2MfISJc1uyLJbIvvjH4U+
         OOotHzRgkJqOVpnwkbhJuths4iUx2JbOFca8FFYLRiE821k+iTu5uRm8Zb152SZr8hvo
         8QlC+9Ieog1zYbX0fN8xnxrzivnnT4n49zHbnutLDtyMt5AR3XMpQUKa0tOMmFEnn+s8
         KFzA==
X-Gm-Message-State: AOJu0Yzz8GazjXvF6wHTrwS8OgQ7VEFftNZkdSxAlLPgPN6v43l90Tkr
	+Xk7sOzRgYV/0Mn+NDHUVjW/DoQPIMiqGWGopkUwscjVdwAexjzHoB1hYegYYg==
X-Gm-Gg: ASbGnctDFgO9sO/G9ObaokOUXKpdKe+EN2tExKn/KXKG/R+GNpKvG1k3pQ4Y7n1lfC4
	Od/mI5AciQm9f6q5Dzza3qdZDEbOEbo2gK7adXe2xhZfyXVd77ChC21M/ucG5rLUMOuEfCLKK8R
	RhCJQjCpJkoXqUK+w1iNC8tYrx09kru29/m/gT95hRD54+WiWOVvBR8aENpYMxBW+ffRAhvvL2I
	tu4pBinjWhVK2wEys0oUF/Trrkw1FnjjgmcE1pVfghKEPvpV2waOcyjgsXmImY5PqdDG35DrtL7
	aMWNpMCpzFHpFDtFT21mMGYrL4BQuT1rzC2OAzcJTTKXeY8yFWiGdo7xysNbVeCV4cOpJYL+0xu
	p5jzVR6H/vVABeG8EtvF72Xc=
X-Google-Smtp-Source: AGHT+IFaOKdWaRx8lDsBVQV/NkfXGwgtkgNZvunvImwg7LSOO8TqMEDsnJVw2FsJtHeTdhfHBGrUgA==
X-Received: by 2002:a5d:5f42:0:b0:3b7:9bd2:7ad6 with SMTP id ffacd0b85a97d-3bb68fdd497mr71686f8f.38.1755220986176;
        Thu, 14 Aug 2025 18:23:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb680798fasm101507f8f.52.2025.08.14.18.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:23:05 -0700 (PDT)
Message-Id: <fffdb326710897fcc952dafad3d8cf600e5d7ff7.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:47 +0000
Subject: [PATCH v2 12/17] github workflows: define rust versions and targets
 in the same place
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Consolidate the Rust toolchain definitions in main.yaml. Prefer using
actions-rs/toolchain@v1 where possible, but for docker targets use
a script to install the Rust toolchain. Four overrides are used in
main.yaml:

  * On Windows: Rust didn't resolve the bcrypt library on Windows
    correctly until version 1.78.0. Also since rustup mis-identifies
    the Rust toolchain, the Rust target triple must be set to
    x86_64-pc-windows-gnu.
  * On musl: libc differences, such as ftruncate64 vs ftruncate, were
    not accounted for until Rust version 1.72.0. No older version of
    Rust will work on musl for our needs.
  * In a 32-bit docker container running on a 64-bit host, we need to
    override the Rust target triple. This is because rustup asks the
    kernel for the bitness of the system and it says 64, even though
    the container will only run 32-bit. This also allows us to remove
    the BITNESS environment variable in ci/lib.sh.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .github/workflows/main.yml | 34 +++++++++++++++++++++++++++++++++-
 build_rust.sh              | 11 +++--------
 ci/install-rust.sh         | 33 +++++++++++++++++----------------
 ci/lib.sh                  |  7 -------
 ci/make-test-artifacts.sh  | 12 ++++++------
 ci/run-build-and-tests.sh  |  8 +++++---
 meson.build                |  1 +
 7 files changed, 65 insertions(+), 41 deletions(-)
 mode change 100644 => 100755 ci/install-rust.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index aa18742f08c4..ef4d6348edcd 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -4,7 +4,6 @@ on: [push, pull_request]
 
 env:
   DEVELOPER: 1
-  RUST_VERSION: 1.87.0
 
 # If more than one workflow run is triggered for the very same commit hash
 # (which happens when multiple branches pointing to the same commit), only
@@ -27,6 +26,12 @@ jobs:
     outputs:
       enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
       skip_concurrent: ${{ steps.check-ref.outputs.skip_concurrent }}
+      rust_version_minimum: 1.61.0
+      rust_version_windows: 1.78.0
+      rust_version_musl: 1.72.0
+      ## the rust target is inferred by rustup unless specified
+      rust_target_windows: x86_64-pc-windows-gnu
+      rust_target_32bit_linux: i686-unknown-linux-gnu
     steps:
       - name: try to clone ci-config branch
         run: |
@@ -123,11 +128,19 @@ jobs:
           /c/Program\ Files/Git/mingw64/bin/curl -Lo libuserenv.a \
             https://github.com/git-for-windows/git-sdk-64/raw/HEAD/mingw64/lib/libuserenv.a
         }
+    - name: Install Rust
+      uses: actions-rs/toolchain@v1
+      with:
+        toolchain: ${{ needs.ci-config.outputs.rust_version_windows }}
+        target: ${{ needs.ci-config.outputs.rust_target_windows }}
+        profile: minimal
+        override: true
     - name: build
       shell: bash
       env:
         HOME: ${{runner.workspace}}
         NO_PERL: 1
+        CARGO_HOME: "/c/Users/runneradmin/.cargo"
       run: . /etc/profile && ci/make-test-artifacts.sh artifacts
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
@@ -269,6 +282,13 @@ jobs:
     steps:
     - uses: actions/checkout@v4
     - uses: actions/setup-python@v5
+    - name: Install Rust
+      uses: actions-rs/toolchain@v1
+      with:
+        toolchain: ${{ needs.ci-config.outputs.rust_version_windows }}
+        target: ${{ needs.ci-config.outputs.rust_target_windows }}
+        profile: minimal
+        override: true
     - name: Set up dependencies
       shell: pwsh
       run: pip install meson ninja
@@ -342,6 +362,12 @@ jobs:
     steps:
     - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
+    - name: Install Rust
+      uses: actions-rs/toolchain@v1
+      with:
+        toolchain: ${{ needs.ci-config.outputs.rust_version_minimum }}
+        profile: minimal
+        override: true
     - run: ci/run-build-and-tests.sh
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
@@ -402,9 +428,11 @@ jobs:
           cc: gcc
         - jobname: linux-musl-meson
           image: alpine:latest
+          rust_version_override: ${{ needs.ci-config.outputs.rust_version_musl }}
         # Supported until 2025-04-02.
         - jobname: linux32
           image: i386/ubuntu:focal
+          rust_target_override: ${{ needs.ci-config.outputs.rust_target_32bit_linux }}
         - jobname: pedantic
           image: fedora:latest
         # A RHEL 8 compatible distro.  Supported until 2029-05-31.
@@ -417,7 +445,11 @@ jobs:
       jobname: ${{matrix.vector.jobname}}
       CC: ${{matrix.vector.cc}}
       CI_JOB_IMAGE: ${{matrix.vector.image}}
+      CI_IS_DOCKER: "true"
       CUSTOM_PATH: /custom
+      RUST_VERSION: ${{ matrix.vector.rust_version_override || needs.ci-config.outputs.rust_version_minimum }}
+      RUST_TARGET: ${{ matrix.vector.rust_target_override || '' }}
+      CARGO_HOME: /home/builder/.cargo
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
diff --git a/build_rust.sh b/build_rust.sh
index 694d48d857a5..80ce7eae3b00 100755
--- a/build_rust.sh
+++ b/build_rust.sh
@@ -1,13 +1,8 @@
 #!/bin/sh
 
-if [ -z "$CARGO_HOME" ]; then
-  export CARGO_HOME=$HOME/.cargo
-  echo >&2 "::warning:: CARGO_HOME is not set"
-fi
-echo "CARGO_HOME=$CARGO_HOME"
 
-rustc -vV
-cargo --version
+rustc -vV || exit $?
+cargo --version || exit $?
 
 dir_git_root=${0%/*}
 dir_build=$1
@@ -55,7 +50,7 @@ dst=$dir_build/$libfile
 if [ "$dir_git_root" != "$dir_build" ]; then
   src=$dir_rust/target/$rust_target/$libfile
   if [ ! -f $src ]; then
-    echo >&2 "::error:: cannot find path of static library"
+    echo >&2 "::error:: cannot find path of static library $src is not a file or does not exist"
     exit 5
   fi
 
diff --git a/ci/install-rust.sh b/ci/install-rust.sh
old mode 100644
new mode 100755
index c22baa629ceb..133aa8cc878a
--- a/ci/install-rust.sh
+++ b/ci/install-rust.sh
@@ -1,36 +1,37 @@
 #!/bin/sh
 
+## github workflows actions-rs/toolchain@v1 doesn't work for docker
+## targets. This script should only be used if the ci pipeline
+## doesn't support installing rust on a particular target.
+
 if [ "$(id -u)" -eq 0 ]; then
   echo >&2 "::warning:: installing rust as root"
 fi
 
-if [ "$CARGO_HOME" = "" ]; then
-  echo >&2 "::warning:: CARGO_HOME is not set"
-  export CARGO_HOME=$HOME/.cargo
-fi
-
-export RUSTUP_HOME=$CARGO_HOME
-
 if [ "$RUST_VERSION" = "" ]; then
   echo >&2 "::error:: RUST_VERSION is not set"
+  exit 1
+fi
+
+if [ "$CARGO_HOME" = "" ]; then
+  echo >&2 "::error:: CARGO_HOME is not set"
   exit 2
 fi
 
+export RUSTUP_HOME=$CARGO_HOME
+
 ## install rustup
 curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y
 if [ ! -f $CARGO_HOME/env ]; then
   echo "PATH=$CARGO_HOME/bin:\$PATH" > $CARGO_HOME/env
 fi
+. $CARGO_HOME/env
+
 ## install a specific version of rust
-if [ "$BITNESS" = "32" ]; then
-  $CARGO_HOME/bin/rustup set default-host i686-unknown-linux-gnu || exit $?
-  $CARGO_HOME/bin/rustup install $RUST_VERSION || exit $?
-  $CARGO_HOME/bin/rustup default --force-non-host $RUST_VERSION || exit $?
+if [ "$RUST_TARGET" != "" ]; then
+  rustup default --force-non-host "$RUST_VERSION-$RUST_TARGET" || exit $?
 else
-  $CARGO_HOME/bin/rustup default $RUST_VERSION || exit $?
-  if [ "$CI_OS_NAME" = "windows" ]; then
-    $CARGO_HOME/bin/rustup target add x86_64-pc-windows-gnu || exit $?
-  fi
+  rustup default "$RUST_VERSION" || exit $?
 fi
 
-. $CARGO_HOME/env
+rustc -vV || exit $?
diff --git a/ci/lib.sh b/ci/lib.sh
index ad0e49a68dcb..a7992b22fdc9 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,13 +1,6 @@
 # Library of functions shared by all CI scripts
 
 
-export BITNESS="64"
-if command -v getconf >/dev/null && [ "$(getconf LONG_BIT 2>/dev/null)" = "32" ]; then
-  export BITNESS="32"
-fi
-echo "BITNESS=$BITNESS"
-
-
 if test true = "$GITHUB_ACTIONS"
 then
 	begin_group () {
diff --git a/ci/make-test-artifacts.sh b/ci/make-test-artifacts.sh
index 56aa7efb1d53..70d0dfbc0e8b 100755
--- a/ci/make-test-artifacts.sh
+++ b/ci/make-test-artifacts.sh
@@ -7,13 +7,13 @@ mkdir -p "$1" # in case ci/lib.sh decides to quit early
 
 . ${0%/*}/lib.sh
 
-## install rust per user rather than system wide
-. ${0%/*}/install-rust.sh
+if [ -z "$CARGO_HOME" ]; then
+  echo >&2 "::error:: CARGO_HOME is not set"
+  exit 1
+fi
 
-group Build make artifacts-tar ARTIFACTS_DIRECTORY="$1"
+export PATH="$CARGO_HOME/bin:$PATH"
 
-if [ -d "$CARGO_HOME" ]; then
-  rm -rf $CARGO_HOME
-fi
+group Build make artifacts-tar ARTIFACTS_DIRECTORY="$1"
 
 check_unignored_build_artifacts
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index dbab1cb2f936..0f1f704d583e 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,10 +5,12 @@
 
 . ${0%/*}/lib.sh
 
-## install rust per user rather than system wide
-. ${0%/*}/install-rust.sh
+## actions-rs/toolchain@v1 doesn't work for docker targets.
+if [ "$CI_IS_DOCKER" = "true" ]; then
+  . ${0%/*}/install-rust.sh
+fi
 
-rustc -vV
+rustc -vV || exit $?
 cargo --version || exit $?
 
 run_tests=t
diff --git a/meson.build b/meson.build
index af015f04763f..a2f9f063bef2 100644
--- a/meson.build
+++ b/meson.build
@@ -293,6 +293,7 @@ rust_build_xdiff = custom_target('rust_build_xdiff',
     meson.project_source_root() / 'build_rust.sh',
     meson.current_build_dir(), rust_target, 'xdiff',
   ],
+  env: script_environment,
   install: false,
 )
 
-- 
gitgitgadget

