Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5B2D3A93
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205857; cv=none; b=RbC7/BQhZ5mXSDj8MHZAZGYIvjz84JerUz1Ktrh0Gq6qg46YqLzlcIhYM4rMIjxXcbC7+ODOVaKqaNVC/NwHeZ9hR1T1BnEKYaD0KSbb3aKsHFNl+pTic0ur77tYG6BPCZaEGz45CM0Kk6RO7NagoDPluTWk2SR97EuCf24Pf+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205857; c=relaxed/simple;
	bh=2AsyYJzNoDhDh0H7oVqR+0USCIfd26+OZ+lAiXuLgHY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lUjmuntog5GJz4SSf26r9LL/ZIzd8CbkMvq58sqM35/HfCA/+Xgd2DpqybffB1ENg5LXRfehRMVJpz5k2zGa/v4k2g4GG2zyVsyofVlGCs6cDreQpPd919IzpNYkeTHI72MwQDmjbltmVSxovWPVWB8OxfesXt8zAEjYFUrbwOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9l5SCTf; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9l5SCTf"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-94905c3e2a4so64729239f.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205854; x=1764810654; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRX3uYaAdsLMo5U5W+y3RjnOtR9zf2y+/gNnyWVORk8=;
        b=L9l5SCTf6FY6XchDvCERMnQHPYxoU1Pkm2wFitUKzoquO+/JgQstfri+hyGYyi0Zt+
         clti7I4O81VCI1RUSmUTkBhLbz5MSjJo/320MUtBGQ6jbkjC20lbUFS5TP+IMxtraQHF
         /X34jRu4IQ7vjnsJOfHsVGJ1JS7Vx0MQ51zwQvnTSO9NY1ON1NGbR8vucrDiCpD6ZzUx
         1n09k03B8WuGMHZ7oV/iCXH35q79sHvINH1pWH9dyE2r5rB688INWBj9TR72UkPoHvHP
         bH0Rc33FK/89nfnI/79N/g0xcQwMiGgsoFr7/CI7unKHpM/dV9tBXt1TXnRKErSEek0/
         BkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205854; x=1764810654;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRX3uYaAdsLMo5U5W+y3RjnOtR9zf2y+/gNnyWVORk8=;
        b=hIT0E7Xo+7FgZVP7ubhLme8X8wO8+YhGkfRHCeY0fl2Ve9bLtMbJ4GtOMssoN6zraZ
         uaF7N8Lafa/Z3MEGWwjQ7SIYNOVMhsFyiIaA/Fi9nVJ+XeGkkJmC7LL2sfDyJU4bXJCQ
         EpQCdcUcv62S+U/3pL9sb+6O7tIPdiD7GNVrtoHse5IjCL4OR5jh1wbUg+Xsv+y5M+VJ
         j9poTCEynvDld45iAojY1iLBYXPkLuhYM6PzzaZvZ65U9gW0GS8mVZ+Bms7d/HwcDaXk
         phXrl7B7XaJQgnr8NM/BDoWlZSHZxtHVPtiVXe7ED3CprdFISgXMYBa6JXs3mgUasgxN
         uWeA==
X-Gm-Message-State: AOJu0Yxv9YfEgGuoL/3R3hugzjDMRivQXYG2o1QoFlupfNPqMA47CDYD
	EDpwBMJQfpQqaCRKZqXVT1G53z2OfA7dej4/lDnvsKIFzwyEvHftuMSMvvG+cbr5
X-Gm-Gg: ASbGncvisYNJkKR8GpwkeTWSUJnMRLlosBg4cLwpWDIlPsV8+rMQ01G5wwaM3KX2k/y
	cPuMyoIXAy6vDzmtBd9J8xkSNq6I1DYaG/zfhH8qpEsQa7VBnAomcHMGtSwa9NMeRTW9bv0Ou2R
	8aYUPahHjJeWA1TX+LJibryrvS2dXrDfg6NN7Qi4yeGZ4FSrnojiTvb8iSvfJX9hh38se8aM6b3
	Wn5j30tEr+H+OkGtjAdMohIY1mvx1XW5Xq6Xelgft9OoC9VbEx2Xr4ZSXlicUWws4uspVxQ8ZaU
	P6Vvp8h0Gk/7OaEUrlCurTlX6gfZqPNWW0hLPwfPh964lNBi7Op3sUC79oT90L+GjVRDqdLDBWY
	q9Q9Cf0CRLPi/sYTOkYtp5N/6U0Ty+HqxrGEXFUBHAUFmUtQXNIe22Gc/bSkFdIRAweGqMzuW72
	48P6RpEPq35KTEnw==
X-Google-Smtp-Source: AGHT+IE2fL9ofLllzEAHvkR1D6ibt4npR5QK6amsJeOsxADagR7F7GtB9vCFft5/K77JGpd3kcKB5w==
X-Received: by 2002:a05:6638:c74e:10b0:55e:794:3657 with SMTP id 8926c6da1cb9f-5b96594efb2mr16033643173.1.1764205854328;
        Wed, 26 Nov 2025 17:10:54 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954a5023csm8843618173.19.2025.11.26.17.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:53 -0800 (PST)
Message-Id: <20558a8e1e037227b194e9a04c0a9c461e214fb7.1764205835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
References: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:34 +0000
Subject: [PATCH 12/13] github workflows: install Rust
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

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .github/workflows/main.yml   | 62 +++++++++++++++++++++++++++++++++++-
 ci/install-dependencies.sh   | 14 ++++----
 ci/install-rust-toolchain.sh | 30 +++++++++++++++++
 ci/install-rustup.sh         | 25 +++++++++++++++
 ci/make-test-artifacts.sh    |  9 ++++++
 ci/run-build-and-tests.sh    | 13 ++++++++
 6 files changed, 145 insertions(+), 8 deletions(-)
 create mode 100755 ci/install-rust-toolchain.sh
 create mode 100755 ci/install-rustup.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index cc54824c38..396b0108a0 100644
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
     - uses: actions/checkout@v5
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
     - uses: actions/checkout@v5
     - uses: actions/setup-python@v6
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
     - uses: actions/checkout@v5
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
@@ -395,9 +445,11 @@ jobs:
           cc: gcc
         - jobname: linux-musl-meson
           image: alpine:latest
+          rust_version_override: ${{ needs.ci-config.outputs.rust_version_musl }}
         # Supported until 2025-04-02.
         - jobname: linux32
           image: i386/ubuntu:focal
+          rust_target_override: ${{ needs.ci-config.outputs.rust_target_32bit_linux }}
         # A RHEL 8 compatible distro.  Supported until 2029-05-31.
         - jobname: almalinux-8
           image: almalinux:8
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
index 50628ee2dd..f1b3ee2dd9 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -26,7 +26,7 @@ fi
 
 case "$distro" in
 alpine-*)
-	apk add --update shadow sudo meson ninja-build gcc libc-dev curl-dev openssl-dev expat-dev gettext \
+	apk add --update shadow sudo meson ninja-build gcc libc-dev curl curl-dev openssl-dev expat-dev gettext \
 		zlib-ng-dev pcre2-dev python3 musl-libintl perl-utils ncurses \
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
@@ -37,7 +37,7 @@ fedora-*|almalinux-*)
 		MESON_DEPS="meson ninja";;
 	esac
 	dnf -yq update >/dev/null &&
-	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo >/dev/null
+	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl curl-devel pcre2-devel $MESON_DEPS cargo >/dev/null
 	;;
 ubuntu-*|i386/ubuntu-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
@@ -61,8 +61,8 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 	sudo apt-get -q update
 	sudo apt-get -q -y install \
 		$LANGUAGES apache2 cvs cvsps git gnupg $SVN \
-		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
-		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
+		make libssl-dev curl libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
+		tcl tk gettext zlib1g zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
 		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
@@ -134,7 +134,7 @@ ClangFormat)
 	sudo apt-get -q -y install clang-format
 	;;
 StaticAnalysis)
-	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
+	sudo apt-get -q -y install coccinelle curl libcurl4-openssl-dev libssl-dev \
 		libexpat-dev gettext make
 	;;
 RustAnalysis)
@@ -149,8 +149,8 @@ RustAnalysis)
 	sudo chmod a+x "$CUSTOM_PATH/cargo-msrv"
 	;;
 sparse)
-	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
-		libexpat-dev gettext zlib1g-dev sparse
+	sudo apt-get -q -y install libssl-dev curl libcurl4-openssl-dev \
+		libexpat-dev gettext zlib1g zlib1g-dev sparse
 	;;
 Documentation)
 	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
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
index d4f7cbd15f..e87c5174c4 100755
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
 case "$jobname" in
 fedora-breaking-changes-musl|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
@@ -60,5 +69,9 @@ case "$jobname" in
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

