Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5372223DE8
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071814; cv=none; b=p1OPcETOHaPgHL+h9FK9bltEUWiHCRTtR18IPeaRRrKGjINIGIo+kWCPgzMSAhOHjS2nujBIwNzE7s0B3a1EYMcRkTzqmNS+LGzUTFHumjQAvJAydqPar7U0qrxbXLEpZ9/+Veq/ctm8e46rkfS78axTNuizrpMMaVAZ9qYRhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071814; c=relaxed/simple;
	bh=VgP/kJzZZFH0LZLL8vkMCg0beRAyCKlX5/nh4JpYFEg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TuIY9E9ChOcojiJ7ZSqKJB3Lh8bGfMJJ/YWAGXV1LGNIHF9emBpBY9LeTQ+NIDHlPZqhAe30J2DSXcd0+185KLTCOXufiANCGF+ljTEhx8tIGDfUym9Utz2qQi1TgodpFjKplyyomKaZblW7IFyrfBpgAVqs86ByDMU9rC8CmAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZGD4XDY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZGD4XDY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso3879064b3a.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071811; x=1758676611; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWzJ3SY7sEWgSoOorT49bnC8ajR7IWZ4nHC0TXQ+lPI=;
        b=nZGD4XDYxsNq4dN9SbI/SkMhBUmNIzXtMc4/YB8RaeJ6acrPNtlS0IAx7nt8eas1/K
         S2cnyzIDNVx0wDbbXc82aGJ9NvIJKjOd6VseaxD5/Qyhs49O9mAtv8XKwUBS3DsRATEx
         0I7AjkY6JZOMSBsMij6bEo3qSUPS1On3lD9FMkYJuMWC5F18bSiC1BrtGsBW2Ufc+6vq
         kWTA9+fyqCPb7f/k7IR9+yuvmKSzTQ41Y3FGEjqwdhuoUhcTNc5fotG1ZWT/xurxifBq
         8+sBlGQwjpIhVyYhYCDDE2+2qTuqeaU51dR1++i0paeNllPD5QldYH0xQkMBfZ62Uq8c
         hm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071811; x=1758676611;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWzJ3SY7sEWgSoOorT49bnC8ajR7IWZ4nHC0TXQ+lPI=;
        b=DMN+RQlrHUwPluOYFIe+69XZSj6NY6iqrMhYm6ZLH9Q15fWhNI0A2q8/6IoL025t0G
         D20+x4nHnLLV23kNFZLd/VqpK0wcyvEDLWFabb3PViCWQtizvbr3UnlrXUYvL6xKyF5U
         KipxY3aOUDXXO/SztAcGJqORQCtGL8u3hjMK2MaE+WdXp7fS1EwUr7YK7MAmdBeRDCdQ
         qBCKbbrPia3cy1ZOAvs4RB4njeP9TyAR5ga4yaPuUWRh5Xlb5bGrWaUq/O4OBULxWWRt
         6cC+gC9rwxExaS/xsIgY44/aXjEoly84XPYLUpCzYKuaEzBS3EwqqUakNQhDw2lxc+xD
         JASw==
X-Gm-Message-State: AOJu0YyqoBamASvp0KPUq8/E2zIS1J5Q26roIgwoV/w5MShtLEnmzb4O
	ZJmzdL7aKb/vWl5EnxoQe3mH+OmCcndXjHEkVSEctCXH7O2UzBUnYKNQCC0r0g==
X-Gm-Gg: ASbGnct+TddmMdg9SkxS49gYVyNol1JW7ZtqbPp7r8m2ptvRHzd0ZDpfTTiv0Qt26i0
	ZTLr3EhtfuAhazyPEeRP2vQ3sU2FhwekB+E8z92UE9Z2Rf0vtPtmpaZCplTrc5kYhYS3WX//R1P
	mu0UoJ8X6VpQpOxMBX6M8yVdz6g/26j46Rf+HTM6s90fgVN0v/fvj3ebIjEB7e+ZVnUxncCs/RT
	iME+dxJi5yKEL7XWbzmyczEydhoyQHJOb0hqCvUIu6IhpdIISs/3AF7w+RNh3196OsI0X4h4K0z
	XViEBNhOuhQ9rNLVYaZ8uU6GRtmL6zbU3q/74J4/+V3thqm48VZznkEjSMZeLWbHBm/dA57AojM
	4l6Bf+xqmAY31Y8vrekd0jAhX+xOAarawUtu7Sg==
X-Google-Smtp-Source: AGHT+IGZ04SuPtg+RdaTtvLU+d76g/k2OB/chnZgvtSGsW4b9fx1RqVMSYnfvRImpo18G2lTv/lLfg==
X-Received: by 2002:a05:6a20:7293:b0:249:467e:ba73 with SMTP id adf61e73a8af0-27ab06e78d2mr360460637.55.1758071811225;
        Tue, 16 Sep 2025 18:16:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b6b1sm17316946b3a.20.2025.09.16.18.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:50 -0700 (PDT)
Message-Id: <fcdfc55fb7d7da7d65405486f5eec10e5892a028.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:29 +0000
Subject: [PATCH v2 09/18] github workflows: install rust
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Prefer using actions-rs/toolchain@v1 where possible to install rustup,
but for docker targets use a script to install rustup. Consolidate the
Rust toolchain definitions in main.yaml. Use install-rust-toolchain.sh
to ensure the correct toolchain is used. Five overrides are used in
main.yaml:

  * On Windows: Rust didn't resolve the bcrypt library on Windows
    correctly until version 1.78.0. Also since rustup mis-identifies
    the Rust toolchain, the Rust target triple must be set to
    x86_64-pc-windows-gnu for make (win build), and
    x86_64-pc-windows-msvc for meson (win+Meson build).
  * MSVC builds: Rearrange PATH to look in /mingw64/bin and /usr/bin
    last.
  * On musl: libc differences, such as ftruncate64 vs ftruncate, were
    not accounted for until Rust version 1.72.0. No older version of
    Rust will work on musl for our needs.
  * In a 32-bit docker container running on a 64-bit host, we need to
    override the Rust target triple. This is because rustup asks the
    kernel for the bitness of the system and it says 64, even though
    the container is 32-bit. This also allows us to remove the
    BITNESS environment variable in ci/lib.sh.

The logic for selecting library names was initially provided in a patch
from Johannes, but was reworked and squashed into this commit.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .github/workflows/main.yml   | 62 +++++++++++++++++++++++++++++++++++-
 ci/install-dependencies.sh   | 14 ++++----
 ci/install-rust-toolchain.sh | 30 +++++++++++++++++
 ci/install-rustup.sh         | 25 +++++++++++++++
 ci/lib.sh                    |  1 +
 ci/make-test-artifacts.sh    |  9 ++++++
 ci/run-build-and-tests.sh    | 13 ++++++++
 7 files changed, 146 insertions(+), 8 deletions(-)
 create mode 100755 ci/install-rust-toolchain.sh
 create mode 100755 ci/install-rustup.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index d122e79415..e986684a2f 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -26,6 +26,13 @@ jobs:
     outputs:
       enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
       skip_concurrent: ${{ steps.check-ref.outputs.skip_concurrent }}
+      rust_version_minimum: 1.63.0
+      rust_version_windows: 1.78.0
+      rust_version_musl: 1.72.0
+      ## the rust target is inferred by rustup unless specified
+      rust_target_windows_make: x86_64-pc-windows-gnu
+      rust_target_windows_meson: x86_64-pc-windows-msvc
+      rust_target_32bit_linux: i686-unknown-linux-gnu
     steps:
       - name: try to clone ci-config branch
         run: |
@@ -108,12 +115,28 @@ jobs:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
+    env:
+      CARGO_HOME: "/c/Users/runneradmin/.cargo"
     concurrency:
       group: windows-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: actions/checkout@v4
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
+      with:
+        flavor: full
+    - name: Install rustup via github actions
+      uses: actions-rs/toolchain@v1
+      with:
+        toolchain: stable
+        profile: minimal
+        override: false
+    - name: Install Rust toolchain
+      shell: bash
+      env:
+        RUST_VERSION: ${{ needs.ci-config.outputs.rust_version_windows }}
+        RUST_TARGET: ${{ needs.ci-config.outputs.rust_target_windows_make }}
+      run: ci/install-rust-toolchain.sh
     - name: build
       shell: bash
       env:
@@ -254,12 +277,26 @@ jobs:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
+    env:
+      CARGO_HOME: "/c/Users/runneradmin/.cargo"
     concurrency:
       group: windows-meson-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: actions/checkout@v4
     - uses: actions/setup-python@v5
+    - name: Install rustup via github actions
+      uses: actions-rs/toolchain@v1
+      with:
+        toolchain: stable
+        profile: minimal
+        override: false
+    - name: Install Rust toolchain
+      shell: bash
+      env:
+        RUST_VERSION: ${{ needs.ci-config.outputs.rust_version_windows }}
+        RUST_TARGET: ${{ needs.ci-config.outputs.rust_target_windows_meson }}
+      run: ci/install-rust-toolchain.sh
     - name: Set up dependencies
       shell: pwsh
       run: pip install meson ninja
@@ -329,11 +366,24 @@ jobs:
       jobname: ${{matrix.vector.jobname}}
       CI_JOB_IMAGE: ${{matrix.vector.pool}}
       TEST_OUTPUT_DIRECTORY: ${{github.workspace}}/t
+      CARGO_HOME: "/Users/runner/.cargo"
     runs-on: ${{matrix.vector.pool}}
     steps:
     - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
-    - run: ci/run-build-and-tests.sh
+    - name: Install rustup via github actions
+      uses: actions-rs/toolchain@v1
+      with:
+        toolchain: stable
+        profile: minimal
+        override: false
+    - name: Install Rust toolchain
+      shell: bash
+      env:
+        RUST_VERSION: ${{ needs.ci-config.outputs.rust_version_minimum }}
+      run: ci/install-rust-toolchain.sh
+    - name: Run build and tests
+      run: ci/run-build-and-tests.sh
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       run: ci/print-test-failures.sh
@@ -393,9 +443,11 @@ jobs:
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
@@ -409,6 +461,7 @@ jobs:
       CC: ${{matrix.vector.cc}}
       CI_JOB_IMAGE: ${{matrix.vector.image}}
       CUSTOM_PATH: /custom
+      CARGO_HOME: /home/builder/.cargo
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
@@ -433,6 +486,13 @@ jobs:
     - run: ci/install-dependencies.sh
     - run: useradd builder --create-home
     - run: chown -R builder .
+    - name: Install rustup via script
+      run: sudo --preserve-env --set-home --user=builder ci/install-rustup.sh
+    - name: Install Rust toolchain
+      env:
+        RUST_VERSION: ${{ matrix.vector.rust_version_override || needs.ci-config.outputs.rust_version_minimum }}
+        RUST_TARGET: ${{ matrix.vector.rust_target_override || '' }}
+      run: sudo --preserve-env --set-home --user=builder ci/install-rust-toolchain.sh
     - run: sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d061a47293..7801075821 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -24,14 +24,14 @@ fi
 
 case "$distro" in
 alpine-*)
-	apk add --update shadow sudo meson ninja-build gcc libc-dev curl-dev openssl-dev expat-dev gettext \
+	apk add --update shadow sudo meson ninja-build gcc libc-dev curl curl-dev openssl-dev expat-dev gettext \
 		zlib-ng-dev pcre2-dev python3 musl-libintl perl-utils ncurses \
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
 	;;
 fedora-*|almalinux-*)
 	dnf -yq update >/dev/null &&
-	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl curl-devel pcre2-devel >/dev/null
 	;;
 ubuntu-*|i386/ubuntu-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
@@ -55,8 +55,8 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 	sudo apt-get -q update
 	sudo apt-get -q -y install \
 		$LANGUAGES apache2 cvs cvsps git gnupg $SVN \
-		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
-		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
+		make libssl-dev curl libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
+		tcl tk gettext zlib1g zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
 		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
@@ -121,13 +121,13 @@ ClangFormat)
 	;;
 StaticAnalysis)
 	sudo apt-get -q update
-	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
+	sudo apt-get -q -y install coccinelle curl libcurl4-openssl-dev libssl-dev \
 		libexpat-dev gettext make
 	;;
 sparse)
 	sudo apt-get -q update -q
-	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
-		libexpat-dev gettext zlib1g-dev sparse
+	sudo apt-get -q -y install libssl-dev curl libcurl4-openssl-dev \
+		libexpat-dev gettext zlib1g zlib1g-dev sparse
 	;;
 Documentation)
 	sudo apt-get -q update
diff --git a/ci/install-rust-toolchain.sh b/ci/install-rust-toolchain.sh
new file mode 100755
index 0000000000..06a29c4cfa
--- /dev/null
+++ b/ci/install-rust-toolchain.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+if [ "$CARGO_HOME" = "" ]; then
+  echo >&2 "::error:: CARGO_HOME is not set"
+  exit 2
+fi
+export PATH="$CARGO_HOME/bin:$PATH"
+rustup -vV || exit $?
+
+## Enforce the correct Rust toolchain
+rustup override unset || true
+
+## install a specific version of rust
+if [ "$RUST_TARGET" != "" ]; then
+  rustup default --force-non-host "$RUST_VERSION-$RUST_TARGET" || exit $?
+else
+  rustup default "$RUST_VERSION" || exit $?
+fi
+
+rustc -vV || exit $?
+
+RE_RUST_TARGET="$RUST_TARGET"
+if [ "$RUST_TARGET" = "" ]; then
+  RE_RUST_TARGET="[^ ]+"
+fi
+
+if ! rustup show active-toolchain | grep -E "^$RUST_VERSION-$RE_RUST_TARGET \(default\)$"; then
+  echo >&2 "::error:: wrong Rust toolchain, active-toolchain: $(rustup show active-toolchain)"
+  exit 3
+fi
diff --git a/ci/install-rustup.sh b/ci/install-rustup.sh
new file mode 100755
index 0000000000..0036231aee
--- /dev/null
+++ b/ci/install-rustup.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+## github workflows actions-rs/toolchain@v1 doesn't work for docker
+## targets. This script should only be used if the ci pipeline
+## doesn't support installing rust on a particular target.
+
+if [ "$(id -u)" -eq 0 ]; then
+  echo >&2 "::warning:: installing rust as root"
+fi
+
+if [ "$CARGO_HOME" = "" ]; then
+  echo >&2 "::error:: CARGO_HOME is not set"
+  exit 2
+fi
+
+export RUSTUP_HOME=$CARGO_HOME
+
+## install rustup
+curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y
+if [ ! -f $CARGO_HOME/env ]; then
+  echo "PATH=$CARGO_HOME/bin:\$PATH" > $CARGO_HOME/env
+fi
+. $CARGO_HOME/env
+
+rustup -vV
diff --git a/ci/lib.sh b/ci/lib.sh
index f561884d40..a7992b22fd 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,6 @@
 # Library of functions shared by all CI scripts
 
+
 if test true = "$GITHUB_ACTIONS"
 then
 	begin_group () {
diff --git a/ci/make-test-artifacts.sh b/ci/make-test-artifacts.sh
index 74141af0cc..e37ed7030c 100755
--- a/ci/make-test-artifacts.sh
+++ b/ci/make-test-artifacts.sh
@@ -7,6 +7,15 @@ mkdir -p "$1" # in case ci/lib.sh decides to quit early
 
 . ${0%/*}/lib.sh
 
+## ensure rustup is in the PATH variable
+if [ "$CARGO_HOME" = "" ]; then
+  echo >&2 "::error:: CARGO_HOME is not set"
+  exit 2
+fi
+export PATH="$CARGO_HOME/bin:$PATH"
+
+rustc -vV
+
 group Build make artifacts-tar ARTIFACTS_DIRECTORY="$1"
 
 check_unignored_build_artifacts
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 01823fd0f1..22b61e2812 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,6 +5,15 @@
 
 . ${0%/*}/lib.sh
 
+## ensure rustup is in the PATH variable
+if [ "$CARGO_HOME" = "" ]; then
+  echo >&2 "::error:: CARGO_HOME is not set"
+  exit 2
+fi
+. $CARGO_HOME/env
+
+rustc -vV || exit $?
+
 run_tests=t
 
 case "$jobname" in
@@ -72,5 +81,9 @@ case "$jobname" in
 	;;
 esac
 
+if [ -d "$CARGO_HOME" ]; then
+  rm -rf $CARGO_HOME
+fi
+
 check_unignored_build_artifacts
 save_good_tree
-- 
gitgitgadget

