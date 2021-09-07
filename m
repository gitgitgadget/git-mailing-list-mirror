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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE82C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DFC1610C9
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346189AbhIGVby (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347167AbhIGVbw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:31:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC0BC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:30:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so2586926wmh.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9TaZIK+ljQ5o1y6GmYgaiKWrlwb7OlhwNekRiKEdxc=;
        b=pktBdO1duN80aIBgN8+aBoKJpUcUxIEKLNcf3A7YGhO0mZfhWxCD5KN/CelWD4lfO1
         6W0NPmLmIfBrIlrTY/m2ZcCFWr8gzcNRlXgNlQKfGAwSSQjM9OCTJwQaatehs/q7+HvA
         tTJpFfZOHo03yrZaDvq0vKK2O2BpDIm59xCs6wLQnRHykVmJEezilheQadm+qsUqWdIy
         cUTLiLqD4CWsdulSgGmBwXPhI4qDR4AkCVQNU7bxwMLpzQ+PBHMm35wTmfMKflTKnV50
         +MGRxrrkCv6xgKLM8GUh3+pRBJCwxVBT5cSVbWfmadLhdo7mdOBouvJF1HMEjWeGsjs5
         iQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9TaZIK+ljQ5o1y6GmYgaiKWrlwb7OlhwNekRiKEdxc=;
        b=GxsVHmB1GFes2u46OqNURxU4p1b3VllHMcOobIqHe1d1sqee11ZrQyotgYLWr3D2t/
         ZMdNAL7+skC/Dl4CRc6M3ICm6W9S6BF7rLMlxw60etPL9toPS5QpDTtO3JZziccBR/Fs
         qAUmW8497kOj+JOG2G7qKP7c06d+45jsATXmBpBat0vfiy/yu90Ha+EomccrmhaJ5fT1
         gxlCigZ6spndsOipSv2tanf3EBiC2jHOXcq3+9kDGONJgZCSTnNM6gdfnzz1G+afqPGV
         ewonVtWgwSkwM2+3WQImuK7mm+rt6RiJlOWbEArtAemYX8jdW8Iysgx/RsWiaeNLHtX+
         K91w==
X-Gm-Message-State: AOAM53368K4+JoUmpXZDCLwzGdolsIRHtLkiVIk5Q9zMepPEGKBtw8Mt
        t2PvC1djRYi2GXcpaSGbOHiw5RW1oMNZkA==
X-Google-Smtp-Source: ABdhPJzLeLAs8fek8fPaxc0zx3/7uzXeGDBJsJkBkkmkU24/iIUQeFNI8RG9TTN+j/QFznnFdNsJ9Q==
X-Received: by 2002:a1c:3b41:: with SMTP id i62mr254570wma.38.1631050243191;
        Tue, 07 Sep 2021 14:30:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g11sm155734wrx.30.2021.09.07.14.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:30:42 -0700 (PDT)
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
Subject: [PATCH v5 0/3] add a test mode for SANITIZE=leak, run it in CI
Date:   Tue,  7 Sep 2021 23:30:36 +0200
Message-Id: <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.819.g59feb45f5e0
In-Reply-To: <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com>
References: <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can compile git with SANITIZE=leak, and have had various efforts in
the past such as 31f9acf9ce2 (Merge branch 'ah/plugleaks', 2021-08-04)
to plug memory leaks, but have had no CI testing of it to ensure that
we don't get regressions. This series adds a GIT_TEST_* mode for
checking those regressions, and runs it in CI.

Since I submitted v2 the delta between origin/master..origin/seen
broke even t0001-init.sh when run under SANITIZE=leak, so this series
will cause test smoke on "seen".

That failure is due to a bug in es/config-based-hooks [1] and the
hn/reftable topic, i.e. these patches are legitimately catching
regressions in "seen" from day 1.

Changes since v4 (see
https://lore.kernel.org/git/cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com/):

 * Renamed the jobs to linux-leaks and osx-leaks, per Jeff King's
   suggestion.

 * Took all the suggestions from Jeff King for commit message
   improvements, and tried to make some of my own fixing overly
   verbose wording/grammar errors etc.

 * Ditto the small typo fix Eric Sunshine pointed out. Thanks both!

See https://github.com/avar/git/runs/3538356269 for the CI run for
this version.

Ævar Arnfjörð Bjarmason (3):
  Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
  CI: refactor "if" to "case" statement
  tests: add a test mode for SANITIZE=leak, run it in CI

 .github/workflows/main.yml |  6 ++++++
 Makefile                   |  5 +++++
 ci/install-dependencies.sh |  6 +++---
 ci/lib.sh                  | 31 +++++++++++++++++++++----------
 ci/run-build-and-tests.sh  |  2 +-
 t/README                   |  7 +++++++
 t/t0000-basic.sh           |  1 +
 t/t0004-unwritable.sh      |  3 ++-
 t/test-lib.sh              | 21 +++++++++++++++++++++
 9 files changed, 67 insertions(+), 15 deletions(-)

Range-diff against v4:
1:  bdfe2279271 = 1:  bdfe2279271 Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
2:  6aaa60e3759 = 2:  6aaa60e3759 CI: refactor "if" to "case" statement
3:  fffbfc35c00 ! 3:  f3cd04b16d1 tests: add a test mode for SANITIZE=leak, run it in CI
    @@ Metadata
      ## Commit message ##
         tests: add a test mode for SANITIZE=leak, run it in CI
     
    -    While git can be compiled with SANITIZE=leak we have not run
    -    regression tests under that mode, memory leaks have only been fixed as
    +    While git can be compiled with SANITIZE=leak, we have not run
    +    regression tests under that mode. Memory leaks have only been fixed as
         one-offs without structured regression testing.
     
    -    This change add CI testing for it. We'll now build with GCC under
    -    Linux and test t000[04]*.sh with SANITIZE=leak, and likewise with GCC
    -    on OSX. The new jobs are called "linux-SANITIZE=leak" and
    -    "osx-SANITIZE=leak".
    +    This change adds CI testing for it. We'll now build and test
    +    t000[04]*.sh under both Linux and OSX. The new jobs are called
    +    "linux-leaks" and "osx-leaks".
     
         The CI target uses a new GIT_TEST_PASSING_SANITIZE_LEAK=true test
         mode. When running in that mode, we'll assert that we were compiled
    -    with SANITIZE=leak, and then skip all tests except those that we've
    -    opted-in by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
    -    test-lib.sh (see discussion in t/README).
    +    with SANITIZE=leak. We'll then skip all tests, except those that we've
    +    opted-in by setting "TEST_PASSES_SANITIZE_LEAK=true".
     
    -    The tests using the "TEST_PASSES_SANITIZE_LEAK=true" setting can in
    +    A test tests setting "TEST_PASSES_SANITIZE_LEAK=true" setting can in
         turn make use of the "SANITIZE_LEAK" prerequisite, should they wish to
         selectively skip tests even under
         "GIT_TEST_PASSING_SANITIZE_LEAK=true". In a preceding commit we
         started doing this in "t0004-unwritable.sh" under SANITIZE=leak, now
         it'll combine nicely with "GIT_TEST_PASSING_SANITIZE_LEAK=true".
     
    -    Now tests that don't set "TEST_PASSES_SANITIZE_LEAK=true" will be
    -    skipped under GIT_TEST_PASSING_SANITIZE_LEAK=true:
    +    This is how tests that don't set "TEST_PASSES_SANITIZE_LEAK=true" will
    +    be skipped under GIT_TEST_PASSING_SANITIZE_LEAK=true:
     
             $ GIT_TEST_PASSING_SANITIZE_LEAK=true ./t0001-init.sh
             1..0 # SKIP skip all tests in t0001 under SANITIZE=leak, TEST_PASSES_SANITIZE_LEAK not set
    @@ Commit message
         commit-graph tests). To be clear having a prerequisite could also be
         accomplished by using "LSAN_OPTIONS" directly.
     
    -    On the topi of "LSAN_OPTIONS": It would be nice to have a mode to
    +    On the topic of "LSAN_OPTIONS": It would be nice to have a mode to
         aggregate all failures in our various scripts, see [2] for a start at
         doing that which sets "log_path" in "LSAN_OPTIONS". I've punted on
    -    that for now, it can be added later, and that proposed patch is also
    -    hindered by us wanting to test e.g. test-tool leaks (and by proxy, any
    -    API leaks they uncover), not just the "common-main.c" entry point.
    +    that for now, it can be added later.
     
         As of writing this we've got major regressions between master..seen,
         i.e. the t000*.sh tests and more fixed since 31f9acf9ce2 (Merge branch
         'ah/plugleaks', 2021-08-04) have regressed recently.
     
    -    See the discussion at <87czsv2idy.fsf@evledraar.gmail.com> about the
    -    lack of this sort of test mode, and 0e5bba53af (add UNLEAK annotation
    -    for reducing leak false positives, 2017-09-08) for the initial
    -    addition of SANITIZE=leak.
    +    See the discussion at <87czsv2idy.fsf@evledraar.gmail.com>[3] about
    +    the lack of this sort of test mode, and 0e5bba53af (add UNLEAK
    +    annotation for reducing leak false positives, 2017-09-08) for the
    +    initial addition of SANITIZE=leak.
     
         See also 09595ab381 (Merge branch 'jk/leak-checkers', 2017-09-19),
         7782066f67 (Merge branch 'jk/apache-lsan', 2019-05-19) and the recent
         936e58851a (Merge branch 'ah/plugleaks', 2021-05-07) for some of the
         past history of "one-off" SANITIZE=leak (and more) fixes.
     
    -    The reason for using gcc on OSX over the clang default is because
    -    it'll currently fail to build with:
    +    The reason for using gcc on OSX over the clang default is because when
    +    used with clang on "macos-latest" it'll currently fail to build with:
     
             clang: error: unsupported option '-fsanitize=leak' for target 'x86_64-apple-darwin19.6.0'
     
         If that's sorted out in the future we might want to run that job with
         "clang" merely to make use of the default, and also to add some
         compiler variance into the mix. Both use the
    -    "AddressSanitizerLeakSanitizer" library[3], so in they shouldn't be
    -    have differently under GCC or clang.
    +    "AddressSanitizerLeakSanitizer" library[4], so in they shouldn't
    +    behave differently under GCC or clang.
     
         1. https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer
         2. https://lore.kernel.org/git/YS9OT%2Fpn5rRK9cGB@coredump.intra.peff.net/
    -    3. https://lore.kernel.org/git/YS9ZIDpANfsh7N+S@coredump.intra.peff.net/
    +    3. https://lore.kernel.org/git/87czsv2idy.fsf@evledraar.gmail.com/
    +    4. https://lore.kernel.org/git/YS9ZIDpANfsh7N+S@coredump.intra.peff.net/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ .github/workflows/main.yml: jobs:
                - jobname: linux-gcc-default
                  cc: gcc
                  pool: ubuntu-latest
    -+          - jobname: linux-SANITIZE=leak
    ++          - jobname: linux-leaks
     +            cc: gcc
     +            pool: ubuntu-latest
    -+          - jobname: osx-SANITIZE=leak
    ++          - jobname: osx-leaks
     +            cc: gcc
     +            pool: macos-latest
          env:
    @@ ci/install-dependencies.sh: UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl
      
      case "$jobname" in
     -linux-clang|linux-gcc)
    -+linux-clang|linux-gcc|linux-SANITIZE=leak)
    ++linux-clang|linux-gcc|linux-leaks)
      	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
      	sudo apt-get -q update
      	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
      		$UBUNTU_COMMON_PKGS
      	case "$jobname" in
     -	linux-gcc)
    -+	linux-gcc|linux-SANITIZE=leak)
    ++	linux-gcc|linux-leaks)
      		sudo apt-get -q -y install gcc-8
      		;;
      	esac
    @@ ci/install-dependencies.sh: linux-clang|linux-gcc)
      	popd
      	;;
     -osx-clang|osx-gcc)
    -+osx-clang|osx-gcc|osx-SANITIZE=leak)
    ++osx-clang|osx-gcc|osx-leaks)
      	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
      	# Uncomment this if you want to run perf tests:
      	# brew install gnu-time
    @@ ci/lib.sh: export GIT_TEST_CLONE_2GB=true
      
      case "$jobname" in
     -linux-clang|linux-gcc)
    -+linux-clang|linux-gcc|linux-SANITIZE=leak)
    ++linux-clang|linux-gcc|linux-leaks)
      	case "$jobname" in
     -	linux-gcc)
    -+	linux-gcc|linux-SANITIZE=leak)
    ++	linux-gcc|linux-leaks)
      		export CC=gcc-8
      		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
      		;;
    @@ ci/lib.sh: linux-clang|linux-gcc)
      	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
      	;;
     -osx-clang|osx-gcc)
    -+osx-clang|osx-gcc|osx-SANITIZE=leak)
    ++osx-clang|osx-gcc|osx-leaks)
      	case "$jobname" in
     -	osx-gcc)
    -+	osx-gcc|osx-SANITIZE=leak)
    ++	osx-gcc|osx-leaks)
      		export CC=gcc-9
      		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
      		;;
    @@ ci/lib.sh: linux-musl)
      esac
      
     +case "$jobname" in
    -+linux-SANITIZE=leak|osx-SANITIZE=leak)
    ++linux-leaks|osx-leaks)
     +	export SANITIZE=leak
     +	export GIT_TEST_PASSING_SANITIZE_LEAK=true
     +	;;
    @@ ci/run-build-and-tests.sh: esac
      make
      case "$jobname" in
     -linux-gcc)
    -+linux-gcc|linux-SANITIZE=leak)
    ++linux-gcc|linux-leaks)
      	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
      	make test
      	export GIT_TEST_SPLIT_INDEX=yes
    @@ t/README: excluded as so much relies on it, but this might change in the future.
     +themselves as passing with no memory leaks. Tests can be whitelisted
     +by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
     +"test-lib.sh" itself at the top of the test script. This test mode is
    -+used by the "linux-SANITIZE=leak" CI target.
    ++used by the "linux-leaks" CI target.
     +
      GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
      default to n.
-- 
2.33.0.819.g59feb45f5e0

