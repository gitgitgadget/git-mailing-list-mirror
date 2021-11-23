Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1994CC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 16:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhKWQcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhKWQcu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 11:32:50 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA60C061748
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:29:41 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so3077989wmd.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=euXLgt5dNsQuyf6JHZPmWpS6lYkkqS/7B57d5fNenqg=;
        b=gcd0KMkmWSbvBgLEVTwdXEvxK8rHqjNLdnvb8kesHrUfyFy7qv4DfR3oMU2u/IW9qF
         gSEF67WkAQ4LCl3QkHJqEruBphqsgil+AbFTNfFzXcGgVE78pAix1p6npCzQHuOEc7JB
         Y/ZK1cYdWjLX+E+dX+lYpPmjx2FyQSDZVCQ11xkDZokk6Xx4i/Kj4IRA9wPb464O7tGg
         ZcC/7N4ltfRNulHrqu6n3eDXFRv6HnJ79gM5ijNvZazkRcZB5CPhXtm8N44oEtFzjCMK
         Z7c/aTEUJNpHVaWv27L/ZQbL7WzFE4thr6uA+iBR5DjYlg+clFSdEju/hd3qM4cNpOus
         ppGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=euXLgt5dNsQuyf6JHZPmWpS6lYkkqS/7B57d5fNenqg=;
        b=H4NVx/i6nRTWEXNgWkU+QcXihSk4bTdcxWhTLxhe9mTeVWyXTKytgnnj/oQWv+lK35
         NbrHzfjcQQ4vs7ZCP42taNP1ov9sW+nuFZtgZa1+kR0eR9SUkvndj8WZbX9JSojEuDG0
         IRiU15Rr0VDIKkiepgduNJZcYBq8rQM73DWRSoKqd2A5u/r9H+IMCKITfzDynzn0F0Kn
         eSeXr13447SF7iVv2hcJl21x7wJJ3+q7keG6fz3iAgM9dpzWpon0+E/yc9C9YGPUyLkT
         OzP13NjgzsbTm/1d9+8NIfzYVrqA78amZwrawUkvZeL4b/QZnXFXPOX4tDfG2I5fbtiX
         zOWg==
X-Gm-Message-State: AOAM531zYeYfVFx8hkunMoD/Ic1IrIqzK496zPfmemqXxiZo2ElCNZmY
        DT9SNHegnNnxCpBl1t+znrdEynVlLz3taw==
X-Google-Smtp-Source: ABdhPJwTixy+W+H3lSBPai/hs2RmR50g+QzHrcctnaCrMOh6KD/k7B3HJ3Wy8OAMlxJRorPOXKxHMQ==
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr4487199wmf.73.1637684979695;
        Tue, 23 Nov 2021 08:29:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h22sm2059940wmq.14.2021.11.23.08.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:29:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/5] CI: use "$runs_on_pool", not "$jobname" to select packages & config
Date:   Tue, 23 Nov 2021 17:29:11 +0100
Message-Id: <patch-v4-4.5-614a99f7b64-20211123T134300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.830.g6387a5d107e
In-Reply-To: <cover-v4-0.5-00000000000-20211123T134300Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20211123T134300Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the setup hooks for the CI to use "$runs_on_pool" for the
"$regular" job. Now we won't need as much boilerplate when adding new
jobs to the "regular" matrix, see 956d2e4639b (tests: add a test mode
for SANITIZE=leak, run it in CI, 2021-09-23) for the last such commit.

I.e. now instead of needing to enumerate each jobname when we select
packages we can install things depending on the pool we're running
in.

That we didn't do this dates back to the now gone dependency on Travis
CI, but even if we add a new CI target in the future this'll be easier
to port over, since we can probably treat "ubuntu-latest" as a
stand-in for some recent Linux that can run "apt" commands.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  4 ++++
 ci/install-dependencies.sh | 32 ++++++++++++++------------------
 ci/lib.sh                  | 21 +++++++++++----------
 3 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 91b565f75bb..d402402a18b 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -227,12 +227,14 @@ jobs:
             pool: ubuntu-latest
           - jobname: linux-gcc
             cc: gcc
+            cc_package: gcc-8
             pool: ubuntu-latest
           - jobname: osx-clang
             cc: clang
             pool: macos-latest
           - jobname: osx-gcc
             cc: gcc
+            cc_package: gcc-9
             pool: macos-latest
           - jobname: linux-gcc-default
             cc: gcc
@@ -242,7 +244,9 @@ jobs:
             pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
+      CC_PACKAGE: ${{matrix.vector.cc_package}}
       jobname: ${{matrix.vector.jobname}}
+      runs_on_pool: ${{matrix.vector.pool}}
     runs-on: ${{matrix.vector.pool}}
     steps:
     - uses: actions/checkout@v2
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 49a4ae7a988..dbcebad2fb2 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -11,17 +11,11 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
-case "$jobname" in
-linux-clang|linux-gcc|linux-leaks)
+case "$runs_on_pool" in
+ubuntu-latest)
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
-		$UBUNTU_COMMON_PKGS
-	case "$jobname" in
-	linux-gcc)
-		sudo apt-get -q -y install gcc-8
-		;;
-	esac
-
+		$UBUNTU_COMMON_PKGS $CC_PACKAGE
 	mkdir --parents "$P4_PATH"
 	pushd "$P4_PATH"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
@@ -36,7 +30,7 @@ linux-clang|linux-gcc|linux-leaks)
 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
 	popd
 	;;
-osx-clang|osx-gcc)
+macos-latest)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
@@ -50,15 +44,17 @@ osx-clang|osx-gcc)
 		brew install --cask --no-quarantine perforce
 	} ||
 	brew install homebrew/cask/perforce
-	case "$jobname" in
-	osx-gcc)
-		brew install gcc@9
-		# Just in case the image is updated to contain gcc@9
-		# pre-installed but not linked.
-		brew link gcc@9
-		;;
-	esac
+
+	if test -n "$CC_PACKAGE"
+	then
+		BREW_PACKAGE=${CC_PACKAGE/-/@}
+		brew install "$BREW_PACKAGE"
+		brew link "$BREW_PACKAGE"
+	fi
 	;;
+esac
+
+case "$jobname" in
 StaticAnalysis)
 	sudo apt-get -q update
 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
diff --git a/ci/lib.sh b/ci/lib.sh
index 0b3b0144882..cbc2f8f1caa 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -156,11 +156,15 @@ export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=true
 export SKIP_DASHED_BUILT_INS=YesPlease
 
-case "$jobname" in
-linux-clang|linux-gcc|linux-leaks)
+case "$runs_on_pool" in
+ubuntu-latest)
+	if test "$jobname" = "linux-gcc-default"
+	then
+		break
+	fi
+
 	if [ "$jobname" = linux-gcc ]
 	then
-		export CC=gcc-8
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
 	else
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
@@ -180,17 +184,17 @@ linux-clang|linux-gcc|linux-leaks)
 	GIT_LFS_PATH="$HOME/custom/git-lfs"
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
-osx-clang|osx-gcc)
+macos-latest)
 	if [ "$jobname" = osx-gcc ]
 	then
-		export CC=gcc-9
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 	else
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
 	fi
 	;;
-linux-gcc-default)
-	;;
+esac
+
+case "$jobname" in
 linux32)
 	CC=gcc
 	;;
@@ -200,9 +204,6 @@ linux-musl)
 	MAKEFLAGS="$MAKEFLAGS NO_REGEX=Yes ICONV_OMITS_BOM=Yes"
 	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
 	;;
-esac
-
-case "$jobname" in
 linux-leaks)
 	export SANITIZE=leak
 	export GIT_TEST_PASSING_SANITIZE_LEAK=true
-- 
2.34.0.830.gb9cdc59c8af

