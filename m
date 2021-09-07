Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895E4C4332F
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EDA561100
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347191AbhIGVb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244484AbhIGVbz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:31:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23857C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:30:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n7-20020a05600c3b8700b002f8ca941d89so341256wms.2
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ybvUb99jgtl5DgV6dOCMiXfiZAjLc4XKcgxA1xzU1Fo=;
        b=kUr90RUg8OaYGscFBrlbGXliYERdvZ6REdmtEQDkNGNUQMG0rVm6TVvKnqmQtuGbnv
         Yrs13ZUUF960dk5k/biQqX/s6G5q+ScoOl+MpzgFGVrGbnDhDhQhV1/DTpJrbBgEfdz4
         DKFxD1PsdfGkLnVpO9+RQq94VWg/aPcKO1Dcxl5athZKamoh8+Otpjch6/zQD3nS9jtE
         tGNLEUXV+24cUfFGCpjB5hHu2O4s6gMpWXB9oROesridIF4yCftndrCUFvwJyObDoUo5
         vwidloF+jH3GRlu0VUInn6sN68RD8Ba0OeP/kGY/N9PqwrD/uKxpvtA+5jbx6vNxXqrP
         BA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybvUb99jgtl5DgV6dOCMiXfiZAjLc4XKcgxA1xzU1Fo=;
        b=tecaawnTS9ujLZbHWjbG2639n/UxfrMn06/qeLBLalnNimmjCyc/iFNgekAEhb6XU6
         Izy7tC/g4bxCoqrpEshpfYy+G6pTGi1oaO1fjPGHTknIfmwiUDdHaVvHLPv/xzlnhUq0
         xfn+p71566YmB6rOlq19RRqdGHL3fs1xxzIbyVb5Zv4DrCAONkrom+NPhV7NHZuVrkZs
         whzHChPH2QsE9dz6ASdTlq0uEvMD87eTHEpabj2Shh1XovP9OiOGRVKxM6Ny6nKkNheq
         w3dHtxQu6SsZUHjb/POsHkN9asO7wKOEAagFkCCSTF5K8Fu08VO1KDsrgTlsjCVxTU/I
         NcXQ==
X-Gm-Message-State: AOAM5312QO60CKotqxB+D9KGllkc8SGpTaleRoXMfY8PoYzoM4OY3t94
        3p8xzVlCg2Z+v4qDF4/cDZ7guHQRNs/hyQ==
X-Google-Smtp-Source: ABdhPJzm+dYjpk18fCVfpwnMs6nDXzJTlKqTWeQCCIzXKbCyS+67jI5CD8DwB+95pVgB/g6aClZoUQ==
X-Received: by 2002:a7b:cbcd:: with SMTP id n13mr289975wmi.49.1631050246364;
        Tue, 07 Sep 2021 14:30:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g11sm155734wrx.30.2021.09.07.14.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:30:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/3] tests: add a test mode for SANITIZE=leak, run it in CI
Date:   Tue,  7 Sep 2021 23:30:39 +0200
Message-Id: <patch-v5-3.3-f3cd04b16d1-20210907T212626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.819.g59feb45f5e0
In-Reply-To: <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com>
References: <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com> <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While git can be compiled with SANITIZE=leak, we have not run
regression tests under that mode. Memory leaks have only been fixed as
one-offs without structured regression testing.

This change adds CI testing for it. We'll now build and test
t000[04]*.sh under both Linux and OSX. The new jobs are called
"linux-leaks" and "osx-leaks".

The CI target uses a new GIT_TEST_PASSING_SANITIZE_LEAK=true test
mode. When running in that mode, we'll assert that we were compiled
with SANITIZE=leak. We'll then skip all tests, except those that we've
opted-in by setting "TEST_PASSES_SANITIZE_LEAK=true".

A test tests setting "TEST_PASSES_SANITIZE_LEAK=true" setting can in
turn make use of the "SANITIZE_LEAK" prerequisite, should they wish to
selectively skip tests even under
"GIT_TEST_PASSING_SANITIZE_LEAK=true". In a preceding commit we
started doing this in "t0004-unwritable.sh" under SANITIZE=leak, now
it'll combine nicely with "GIT_TEST_PASSING_SANITIZE_LEAK=true".

This is how tests that don't set "TEST_PASSES_SANITIZE_LEAK=true" will
be skipped under GIT_TEST_PASSING_SANITIZE_LEAK=true:

    $ GIT_TEST_PASSING_SANITIZE_LEAK=true ./t0001-init.sh
    1..0 # SKIP skip all tests in t0001 under SANITIZE=leak, TEST_PASSES_SANITIZE_LEAK not set

The intent is to add more TEST_PASSES_SANITIZE_LEAK=true annotations
as follow-up change, but let's start small to begin with.

It would also be possible to implement a more lightweight version of
this by only relying on setting "LSAN_OPTIONS". See
<YS9OT/pn5rRK9cGB@coredump.intra.peff.net>[1] and
<YS9ZIDpANfsh7N+S@coredump.intra.peff.net>[2] for a discussion of
that. I've opted for this approach of adding a GIT_TEST_* mode instead
because it's consistent with how we handle other special test modes.

Being able to add a "!SANITIZE_LEAK" prerequisite and calling
"test_done" early if it isn't satisfied also means that we can more
incrementally add regression tests without being forced to fix
widespread and hard-to-fix leaks at the same time.

We have tests that do simple checking of some tool we're interested
in, but later on in the script might be stressing trace2, or common
sources of leaks like "git log" in combination with the tool (e.g. the
commit-graph tests). To be clear having a prerequisite could also be
accomplished by using "LSAN_OPTIONS" directly.

On the topic of "LSAN_OPTIONS": It would be nice to have a mode to
aggregate all failures in our various scripts, see [2] for a start at
doing that which sets "log_path" in "LSAN_OPTIONS". I've punted on
that for now, it can be added later.

As of writing this we've got major regressions between master..seen,
i.e. the t000*.sh tests and more fixed since 31f9acf9ce2 (Merge branch
'ah/plugleaks', 2021-08-04) have regressed recently.

See the discussion at <87czsv2idy.fsf@evledraar.gmail.com>[3] about
the lack of this sort of test mode, and 0e5bba53af (add UNLEAK
annotation for reducing leak false positives, 2017-09-08) for the
initial addition of SANITIZE=leak.

See also 09595ab381 (Merge branch 'jk/leak-checkers', 2017-09-19),
7782066f67 (Merge branch 'jk/apache-lsan', 2019-05-19) and the recent
936e58851a (Merge branch 'ah/plugleaks', 2021-05-07) for some of the
past history of "one-off" SANITIZE=leak (and more) fixes.

The reason for using gcc on OSX over the clang default is because when
used with clang on "macos-latest" it'll currently fail to build with:

    clang: error: unsupported option '-fsanitize=leak' for target 'x86_64-apple-darwin19.6.0'

If that's sorted out in the future we might want to run that job with
"clang" merely to make use of the default, and also to add some
compiler variance into the mix. Both use the
"AddressSanitizerLeakSanitizer" library[4], so in they shouldn't
behave differently under GCC or clang.

1. https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer
2. https://lore.kernel.org/git/YS9OT%2Fpn5rRK9cGB@coredump.intra.peff.net/
3. https://lore.kernel.org/git/87czsv2idy.fsf@evledraar.gmail.com/
4. https://lore.kernel.org/git/YS9ZIDpANfsh7N+S@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  6 ++++++
 ci/install-dependencies.sh |  6 +++---
 ci/lib.sh                  | 15 +++++++++++----
 ci/run-build-and-tests.sh  |  2 +-
 t/README                   |  7 +++++++
 t/t0000-basic.sh           |  1 +
 t/t0004-unwritable.sh      |  1 +
 t/test-lib.sh              | 20 ++++++++++++++++++++
 8 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 68596f25927..a2d345fb00e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -232,6 +232,12 @@ jobs:
           - jobname: linux-gcc-default
             cc: gcc
             pool: ubuntu-latest
+          - jobname: linux-leaks
+            cc: gcc
+            pool: ubuntu-latest
+          - jobname: osx-leaks
+            cc: gcc
+            pool: macos-latest
     env:
       CC: ${{matrix.vector.cc}}
       jobname: ${{matrix.vector.jobname}}
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 5772081b6e5..bb88afd3699 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -12,13 +12,13 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
 case "$jobname" in
-linux-clang|linux-gcc)
+linux-clang|linux-gcc|linux-leaks)
 	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
 		$UBUNTU_COMMON_PKGS
 	case "$jobname" in
-	linux-gcc)
+	linux-gcc|linux-leaks)
 		sudo apt-get -q -y install gcc-8
 		;;
 	esac
@@ -37,7 +37,7 @@ linux-clang|linux-gcc)
 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
 	popd
 	;;
-osx-clang|osx-gcc)
+osx-clang|osx-gcc|osx-leaks)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
diff --git a/ci/lib.sh b/ci/lib.sh
index 33b9777ab7e..043c99d31cb 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -183,9 +183,9 @@ export GIT_TEST_CLONE_2GB=true
 export SKIP_DASHED_BUILT_INS=YesPlease
 
 case "$jobname" in
-linux-clang|linux-gcc)
+linux-clang|linux-gcc|linux-leaks)
 	case "$jobname" in
-	linux-gcc)
+	linux-gcc|linux-leaks)
 		export CC=gcc-8
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
 		;;
@@ -208,9 +208,9 @@ linux-clang|linux-gcc)
 	GIT_LFS_PATH="$HOME/custom/git-lfs"
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
-osx-clang|osx-gcc)
+osx-clang|osx-gcc|osx-leaks)
 	case "$jobname" in
-	osx-gcc)
+	osx-gcc|osx-leaks)
 		export CC=gcc-9
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 		;;
@@ -237,4 +237,11 @@ linux-musl)
 	;;
 esac
 
+case "$jobname" in
+linux-leaks|osx-leaks)
+	export SANITIZE=leak
+	export GIT_TEST_PASSING_SANITIZE_LEAK=true
+	;;
+esac
+
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 3ce81ffee94..23d2fa5565a 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -12,7 +12,7 @@ esac
 
 make
 case "$jobname" in
-linux-gcc)
+linux-gcc|linux-leaks)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	make test
 	export GIT_TEST_SPLIT_INDEX=yes
diff --git a/t/README b/t/README
index 9e701223020..8b5f86a46f3 100644
--- a/t/README
+++ b/t/README
@@ -366,6 +366,13 @@ excluded as so much relies on it, but this might change in the future.
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
+GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
+SANITIZE=leak will run only those tests that have whitelisted
+themselves as passing with no memory leaks. Tests can be whitelisted
+by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
+"test-lib.sh" itself at the top of the test script. This test mode is
+used by the "linux-leaks" CI target.
+
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
 
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index cb87768513c..54318af3861 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -18,6 +18,7 @@ swapping compression and hashing order, the person who is making the
 modification *should* take notice and update the test vectors here.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 try_local_xy () {
diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index fbdcb926b3a..37d68ef03be 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -2,6 +2,7 @@
 
 test_description='detect unwritable repository and fail correctly'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4ab18914a3d..3b7acfec23b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1379,6 +1379,26 @@ then
 	test_done
 fi
 
+# skip non-whitelisted tests when compiled with SANITIZE=leak
+if test -n "$SANITIZE_LEAK"
+then
+	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+	then
+		# We need to see it in "git env--helper" (via
+		# test_bool_env)
+		export TEST_PASSES_SANITIZE_LEAK
+
+		if ! test_bool_env TEST_PASSES_SANITIZE_LEAK false
+		then
+			skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
+			test_done
+		fi
+	fi
+elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+then
+	error "GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
+fi
+
 # Last-minute variable setup
 HOME="$TRASH_DIRECTORY"
 GNUPGHOME="$HOME/gnupg-home-not-used"
-- 
2.33.0.819.g59feb45f5e0

