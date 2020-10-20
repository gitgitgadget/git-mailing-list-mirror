Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056B8C388F7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C4021D7B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prJMATnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407544AbgJTNlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407508AbgJTNlI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 09:41:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89F3C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d3so1930569wma.4
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CiJXhuY7XNFMXRtjV/QTEgQiDYfUbTFKjRyPCg24m0o=;
        b=prJMATnpp+zp0GoXftvwrJ6EspikkItzLIr6O5LxleSnkltL81w9yHGBqCwU9mtpqR
         hb1pnMRKMUdRACCTgPpiBr8y3kNK2SrBARF22rGsly7FqhfjxMQYhucWAvx8lhV3qv7g
         gQNhIrpZ94mT6IzfatX793TwAYEMByuTiyKLeUTeqZY1CJ93WtgF47DVWtoTDsaKQ1P3
         5JkWrDgPcqp4vx992weFXn9n94FbOVCNp1c2SPnjvI4dJcWd174YnDLbiRpQMSbVXSj5
         d3xN29wOCP7zWEbP1w0jqUAAAP5HaFefGcbXF4uVfZ2lqgv8sV9OQXUEcrxWBapr2b4z
         FFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CiJXhuY7XNFMXRtjV/QTEgQiDYfUbTFKjRyPCg24m0o=;
        b=GNFAPRK60MjeT2CKj2N14rjAViuQbeH6VDVOHoEiG3qKd9YN3+B71iYhhgsVgyZ5S3
         P5WJDh6f/lEXDxIcB/2DQ8Iv57sOMmg/UyaYHihvyu1ggQeJT+3/uSuapHWXn/LJB9Fl
         OM3fkSmQuHCnttBmeuFLITkOGmwwBdzeIUKSepIGHqGlYI7CR7qaxIilcm2J3bfzIvTe
         FUTFNyUZlf/B3+9CyduSSgRORX8fTGGTT7L777nR+aF/YanAAMiS0C2/Wg+31ELJ9/jX
         /8dq3ljIRQK5cyqkPl/y/YJU/lKuuHU8DKr+xR2DYJROoH2u5DXxtABct7BDzYVqbPpm
         1kDA==
X-Gm-Message-State: AOAM532G7GiwCzZc2P1UF3tyjD02/HIHVWDInaFSErTbC9olLUfD3AMg
        lL8PjeFGCIneI7pvPXAn24cCgC1I4ys=
X-Google-Smtp-Source: ABdhPJxwtGt3tff8B3ExumkLoH/CoZ/NmlNrXTqB+lzypJ2yfirqQ3M7QamMzGKDJ8CjlD/ecFewSA==
X-Received: by 2002:a05:600c:cb:: with SMTP id u11mr2886212wmm.112.1603201266027;
        Tue, 20 Oct 2020 06:41:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm2659796wmj.31.2020.10.20.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 06:41:05 -0700 (PDT)
Message-Id: <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
References: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Oct 2020 13:40:57 +0000
Subject: [PATCH v4 0/7] use fsmonitor data in git diff eliminating O(num_files) calls to lstat
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Credit to alexmv who made this commit back in Dec, 2017 when he was at dbx.
I've rebased it and am submitting it now.

With fsmonitor enabled, git diff currently lstats every file in the repo
This makes use of the fsmonitor extension to skip lstat() calls on files
that fsmonitor judged as unmodified.

I was able to do some testing with/without this change in a large in-house
repo (~ 400k files).

-----------------------------------------
(1) With fsmonitor enabled - on master of git (2.29.0)
-----------------------------------------
../git/bin-wrappers/git checkout HEAD~200
strace -c ../git/bin-wrappers/git diff

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 99.64    4.358994          10    446257         3 lstat
  0.12    0.005353           7       764       360 open

(A subsequent call)
strace -c ../git/bin-wrappers/git diff

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 99.84    4.380955          10    444904         3 lstat
  0.06    0.002564         135        19           munmap
...

-----------------------------------------
(2) With fsmonitor enabled - with my patch
-----------------------------------------
../git/bin-wrappers/git checkout HEAD~200
strace -c ../git/bin-wrappers/git diff

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 50.72    0.003090         163        19           munmap
 19.63    0.001196         598         2           futex
...
  0.00    0.000000           0         4         3 lstat


-----------------------------------------
(3) With fsmonitor disabled entirely
-----------------------------------------

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 98.52    0.277085       92362         3           futex
  0.27    0.000752           4       191        63 open
...
  0.14    0.000397           3       158         3 lstat

I was able to encode this into a perf test in one of the commits.

Changes since Patch Series V1

 * Add git diff -- <pathspec> to perf tests
 * improve readability of bitwise ops

Changes since Patch Series V2

 * Add git add to perf tests
 * Refactor perf fsmonitor to simplify / remove redundancy
 * Add linting to perf tests
 * Added git diff -- <pathspec> for various sized pathspecs
 * Confirmed that refresh_fsmonitor was always being called / added to
   commit message

Changes since Patch Series V3

 * Move perf test linting to Makefile in perf/ directory

Alex Vandiver (1):
  fsmonitor: use fsmonitor data in `git diff`

Nipunn Koorapati (6):
  t/perf/README: elaborate on output format
  t/perf/p7519-fsmonitor.sh: warm cache on first git status
  t/perf: add fsmonitor perf test for git diff
  perf lint: add make test-lint to perf tests
  p7519-fsmonitor: refactor to avoid code duplication
  p7519-fsmonitor: add a git add benchmark

 diff-lib.c                | 15 +++++-
 t/Makefile                |  7 +--
 t/perf/Makefile           |  5 +-
 t/perf/README             |  2 +
 t/perf/p3400-rebase.sh    |  6 +--
 t/perf/p7519-fsmonitor.sh | 96 ++++++++++++++++++++++-----------------
 6 files changed, 81 insertions(+), 50 deletions(-)


base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-756%2Fnipunn1313%2Fdiff_fsmon-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-756/nipunn1313/diff_fsmon-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/756

Range-diff vs v3:

 1:  cba03dd40b = 1:  cba03dd40b fsmonitor: use fsmonitor data in `git diff`
 2:  1c7876166f = 2:  1c7876166f t/perf/README: elaborate on output format
 3:  401f696c81 = 3:  401f696c81 t/perf/p7519-fsmonitor.sh: warm cache on first git status
 4:  b3ad8faac4 = 4:  b3ad8faac4 t/perf: add fsmonitor perf test for git diff
 5:  28c1e488bf ! 5:  b534cd137a perf lint: check test-lint-shell-syntax in perf tests
     @@ Metadata
      Author: Nipunn Koorapati <nipunn@dropbox.com>
      
       ## Commit message ##
     -    perf lint: check test-lint-shell-syntax in perf tests
     +    perf lint: add make test-lint to perf tests
      
     -    Perf tests have some seq instead of test_seq. This
     -    runs the existing tests on the perf tests as well.
     +    Perf tests have not been linted for some time.
     +    They've grown some seq instead of test_seq. This
     +    runs the existing lints on the perf tests as well.
      
          Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
      
     @@ t/Makefile: CHAINLINTTMP_SQ = $(subst ','\'',$(CHAINLINTTMP))
       CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
       CHAINLINT = sed -f chainlint.sed
       
     -@@ t/Makefile: test-lint-executable:
     +@@ t/Makefile: test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
     + 	test-lint-filenames
     + 
     + test-lint-duplicates:
     +-	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
     ++	@dups=`echo $(T) $(TPERF) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
     + 		test -z "$$dups" || { \
     + 		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
     + 
     + test-lint-executable:
     +-	@bad=`for i in $(T); do test -x "$$i" || echo $$i; done` && \
     ++	@bad=`for i in $(T) $(TPERF); do test -x "$$i" || echo $$i; done` && \
     + 		test -z "$$bad" || { \
       		echo >&2 "non-executable tests:" $$bad; exit 1; }
       
       test-lint-shell-syntax:
     @@ t/Makefile: test-lint-executable:
       test-lint-filenames:
       	@# We do *not* pass a glob to ls-files but use grep instead, to catch
      
     + ## t/perf/Makefile ##
     +@@
     + -include ../../config.mak
     + export GIT_TEST_OPTIONS
     + 
     +-all: perf
     ++all: test-lint perf
     + 
     + perf: pre-clean
     + 	./run
     +@@ t/perf/Makefile: pre-clean:
     + clean:
     + 	rm -rf build "trash directory".* test-results
     + 
     ++test-lint:
     ++	$(MAKE) -C .. test-lint
     ++
     + .PHONY: all perf pre-clean clean
     +
       ## t/perf/p3400-rebase.sh ##
      @@ t/perf/p3400-rebase.sh: test_expect_success 'setup rebasing on top of a lot of changes' '
       	git checkout -f -B base &&
 6:  b38f2984f9 = 6:  3b20f4c76e p7519-fsmonitor: refactor to avoid code duplication
 7:  d392a523f2 = 7:  6f97439936 p7519-fsmonitor: add a git add benchmark

-- 
gitgitgadget
