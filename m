Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D8AC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 01:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344277AbiCOBu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiCOBu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 21:50:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C9510FFB
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:49:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so599964wmq.2
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LWmEPyjQEknN2QY2vzOViQzEy6QdEobAAj7TjaRFHDE=;
        b=pkRbzGHzk8vXXJ8zf3UMQJNCfWMB08MaVH2rUmIO0gUiyYqJv9J19SuLzoBuvoeDPh
         h5q1hE6McvdC66+E4h7yOYggscAoixxGSEOH4ZX+JgPbPhxSSjw5fJPc90TDt62ndKTL
         vQZJr++Bsgxo3ymYVMX/ZlyeoVkvsJ7Df2RkxVutTNup5HoI9rgEJYg+CCS3IWKj9wzt
         j39Ub1GQrD3F9VBYBfOypSfC1DJE1DFbjbwht/3y1ocMTmaTnliqzwECdZHXbAb6m4qj
         XVh1wKhMpcOfkto9OE+jgb/N5IJOsdHsn9n/YeI0iZMLZX6ki1oP8YpmWUxNX8sp0xw1
         1XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LWmEPyjQEknN2QY2vzOViQzEy6QdEobAAj7TjaRFHDE=;
        b=BjgdAlJ82m8s+1kThPr/WAYziyAlwmUlfVJeLDz02tc3Fm1fh/iKaluRyMcdC2lfKQ
         QFkALllOcEoLysyD4qdBW95ZOIPCbTaJASXkTg0RDe3v74Nbo3wEnTUYo+UUxJ7gEe5j
         xK22Qb5rrQn2dla9frIowSMchrWEqDkhg/HS/GzGw/0DKYDP/Mibs3bkVuqQV7STgzEC
         FyzTzZH4jE16OzHis0kOIK8yPjNtAHYWri0lSaV3UxUn4DHTKLA2HtTAX+6nMhirZ1Ma
         JTrvtLfqaXjxerxehG+Ehsul3loB1QVv9qgC/CITkhYSAhWTe7n/BjqbyWPGPojVBLhq
         Z3UA==
X-Gm-Message-State: AOAM532F+fbgCjKeir+QFo6Dmr2udAJUBkK11aEsjSZmvSjJqWJ+K9um
        78XpcOPzM0O47LQoUtLPm90c69/tcTY=
X-Google-Smtp-Source: ABdhPJyk011yd9XW5y/Os4WIVo/9wTcGLu+OysVJS7ehwEOGdsEMhGrW7cU1ne9hhDAgw9FsOOTQdQ==
X-Received: by 2002:a7b:c950:0:b0:389:5328:aaa8 with SMTP id i16-20020a7bc950000000b003895328aaa8mr1314873wml.181.1647308983345;
        Mon, 14 Mar 2022 18:49:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d6b43000000b001e317fb86ecsm14587619wrw.57.2022.03.14.18.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:49:42 -0700 (PDT)
Message-Id: <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
References: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 01:49:37 +0000
Subject: [PATCH v3 0/5] Allow 'reset --quiet' to refresh the index, use 'reset --quiet' in 'stash'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the process of working on tests for 'git stash' sparse index integration,
I found that the '--quiet' option in 'git stash' does not suppress all
non-error output when used with '--index'. Specifically, this comes from an
invocation of 'git reset' without the '--quiet' flag in 'reset_head()'. Upon
enabling that flag, though, I discovered that 1) 'reset' does not refresh
the index if '--quiet' is specified (as of [1]) and 2) 'git stash' needs the
index to be refreshed after the reset.

This series aims to decouple the "suppress logging" and "skip index refresh"
behaviors in 'git reset --mixed', then allow 'stash' to internally use reset
with logs suppressed but index refresh enabled. This is accomplished by
introducing the '--[no-]refresh' option and 'reset.refresh' config setting
to 'git reset'. Additionally, in the spirit of backward-compatibility,
'--quiet' and/or 'reset.quiet=true' without any specified "refresh"
option/config will continue to skip 'refresh_index(...)'.

There are also some minor updates to the advice that suggests skipping the
index refresh:

 * replace recommendation to use "--quiet" with "--no-refresh"
 * use 'advise()' rather than 'printf()'
 * rename the advice config setting from 'advice.resetQuiet' to to
   'advice.resetNoRefresh'
 * suppress advice if '--quiet' is specified in 'reset'

Finally, tests are added to 't7102-reset.sh' verifying whether index refresh
happens when expected and to 't3903-stash.sh' verifying that 'apply --quiet'
no longer prints extraneous logs.


Changes since V2
================

 * Rename 'test_index_refreshed' to 'test_reset_refreshes_index'
 * Move comments explaining the "reset refreshes index" test logic inline
   with execution
 * Replace 'git read-tree' with 'git diff-files' in
   'test_reset_refreshes_index' for a (hopefully) more future-proofed
   command verifying for index refresh
 * Add tests for ensuring the index is refreshed after 'git stash push
   --staged' and 'git stash apply --index'


Changes since V1
================

 * Update cover letter title
 * Squash 't7102' test fixes from patch 5 into patch 2
 * Refactor 't7102' tests to properly use inline config settings

[1] https://lore.kernel.org/git/20181023190423.5772-2-peartben@gmail.com/

Thanks! -Victoria

Victoria Dye (5):
  reset: revise index refresh advice
  reset: introduce --[no-]refresh option to --mixed
  reset: replace '--quiet' with '--no-refresh' in performance advice
  reset: suppress '--no-refresh' advice if logging is silenced
  stash: make internal resets quiet and refresh index

 Documentation/config/advice.txt |  8 ++--
 Documentation/git-reset.txt     |  9 ++++
 advice.c                        |  2 +-
 advice.h                        |  2 +-
 builtin/reset.c                 | 21 +++++++---
 builtin/stash.c                 |  5 ++-
 t/t3903-stash.sh                | 33 +++++++++++++++
 t/t7102-reset.sh                | 73 +++++++++++++++++++++++++++++----
 8 files changed, 133 insertions(+), 20 deletions(-)


base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1170%2Fvdye%2Fstash%2Fmake-reset-quiet-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1170/vdye/stash/make-reset-quiet-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1170

Range-diff vs v2:

 1:  7206ef8dd8a = 1:  7206ef8dd8a reset: revise index refresh advice
 2:  7f0226bc3e6 ! 2:  101cee42dd6 reset: introduce --[no-]refresh option to --mixed
     @@ Commit message
          whether logs are silenced and do not affect index refresh.
      
          Helped-by: Derrick Stolee <derrickstolee@github.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Documentation/git-reset.txt ##
     @@ t/t7102-reset.sh: test_expect_success 'resetting an unmodified path is a no-op'
       	git diff-index --cached --exit-code HEAD
       '
       
     -+test_index_refreshed () {
     -+
     -+	# To test whether the index is refresh, create a scenario where a
     -+	# command will fail if the index is *not* refreshed:
     -+	#   1. update the worktree to match HEAD & remove file2 in the index
     -+	#   2. reset --mixed to unstage the change from step 1
     -+	#   3. read-tree HEAD~1 (which differs from HEAD in file2)
     -+	# If the index is refreshed in step 2, then file2 in the index will be
     -+	# up-to-date with HEAD and read-tree will succeed (thus failing the
     -+	# test). If the index is *not* refreshed, however, the staged deletion
     -+	# of file2 from step 1 will conflict with the changes from the tree read
     -+	# in step 3, resulting in a failure.
     ++test_reset_refreshes_index () {
     ++
     ++	# To test whether the index is refreshed in `git reset --mixed` with
     ++	# the given options, create a scenario where we clearly see different
     ++	# results depending on whether the refresh occurred or not.
      +
      +	# Step 0: start with a clean index
      +	git reset --hard HEAD &&
      +
     -+	# Step 1
     ++	# Step 1: remove file2, but only in the index (no change to worktree)
      +	git rm --cached file2 &&
      +
     -+	# Step 2
     ++	# Step 2: reset index & leave worktree unchanged from HEAD
      +	git $1 reset $2 --mixed HEAD &&
      +
     -+	# Step 3
     -+	git read-tree -m HEAD~1
     ++	# Step 3: verify whether the index is refreshed by checking whether
     ++	# file2 still has staged changes in the index differing from HEAD (if
     ++	# the refresh occurred, there should be no such changes)
     ++	git diff-files >output.log &&
     ++	test_must_be_empty output.log
      +}
      +
       test_expect_success '--mixed refreshes the index' '
     @@ t/t7102-reset.sh: test_expect_success 'resetting an unmodified path is a no-op'
      -	test_cmp expect output
      +	# Verify default behavior (with no config settings or command line
      +	# options)
     -+	test_index_refreshed
     ++	test_reset_refreshes_index
      +'
      +test_expect_success '--mixed --[no-]quiet sets default refresh behavior' '
      +	# Verify that --[no-]quiet and `reset.quiet` (without --[no-]refresh)
      +	# determine refresh behavior
      +
      +	# Config setting
     -+	! test_index_refreshed "-c reset.quiet=true" &&
     -+	test_index_refreshed "-c reset.quiet=false" &&
     ++	! test_reset_refreshes_index "-c reset.quiet=true" &&
     ++	test_reset_refreshes_index "-c reset.quiet=false" &&
      +
      +	# Command line option
     -+	! test_index_refreshed "" --quiet &&
     -+	test_index_refreshed "" --no-quiet &&
     ++	! test_reset_refreshes_index "" --quiet &&
     ++	test_reset_refreshes_index "" --no-quiet &&
      +
      +	# Command line option overrides config setting
     -+	! test_index_refreshed "-c reset.quiet=false" --quiet &&
     -+	test_index_refreshed "-c reset.refresh=true" --no-quiet
     ++	! test_reset_refreshes_index "-c reset.quiet=false" --quiet &&
     ++	test_reset_refreshes_index "-c reset.refresh=true" --no-quiet
      +'
      +
      +test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
      +	# Verify that --[no-]refresh and `reset.refresh` control index refresh
      +
      +	# Config setting
     -+	test_index_refreshed "-c reset.refresh=true" &&
     -+	! test_index_refreshed "-c reset.refresh=false" &&
     ++	test_reset_refreshes_index "-c reset.refresh=true" &&
     ++	! test_reset_refreshes_index "-c reset.refresh=false" &&
      +
      +	# Command line option
     -+	test_index_refreshed "" --refresh &&
     -+	! test_index_refreshed "" --no-refresh &&
     ++	test_reset_refreshes_index "" --refresh &&
     ++	! test_reset_refreshes_index "" --no-refresh &&
      +
      +	# Command line option overrides config setting
     -+	test_index_refreshed "-c reset.refresh=false" --refresh &&
     -+	! test_index_refreshed "-c reset.refresh=true" --no-refresh
     ++	test_reset_refreshes_index "-c reset.refresh=false" --refresh &&
     ++	! test_reset_refreshes_index "-c reset.refresh=true" --no-refresh
      +'
      +
      +test_expect_success '--mixed --refresh overrides --quiet refresh behavior' '
      +	# Verify that *both* --refresh and `reset.refresh` override the
      +	# default non-refresh behavior of --quiet
     -+	test_index_refreshed "" "--quiet --refresh" &&
     -+	test_index_refreshed "-c reset.quiet=true" --refresh &&
     -+	test_index_refreshed "-c reset.refresh=true" --quiet &&
     -+	test_index_refreshed "-c reset.refresh=true -c reset.quiet=true"
     ++	test_reset_refreshes_index "" "--quiet --refresh" &&
     ++	test_reset_refreshes_index "-c reset.quiet=true" --refresh &&
     ++	test_reset_refreshes_index "-c reset.refresh=true" --quiet &&
     ++	test_reset_refreshes_index "-c reset.refresh=true -c reset.quiet=true"
       '
       
       test_expect_success '--mixed preserves skip-worktree' '
 3:  f869723d64f = 3:  eb5958194ee reset: replace '--quiet' with '--no-refresh' in performance advice
 4:  cffca0ea5c6 = 4:  548c9303c44 reset: suppress '--no-refresh' advice if logging is silenced
 5:  3334d4cb6f3 ! 5:  4c45351a0c4 stash: make internal resets quiet and refresh index
     @@ Commit message
          refreshing the index, but later operations in 'git stash' subcommands expect
          a non-stale index, enable '--refresh' as well.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## builtin/stash.c ##
     @@ t/t3903-stash.sh: test_expect_success 'apply -q is quiet' '
       test_expect_success 'save -q is quiet' '
       	git stash save --quiet >output.out 2>&1 &&
       	test_must_be_empty output.out
     +@@ t/t3903-stash.sh: test_expect_success 'drop -q is quiet' '
     + 	test_must_be_empty output.out
     + '
     + 
     ++test_expect_success 'stash push -q --staged refreshes the index' '
     ++	git reset --hard &&
     ++	echo test >file &&
     ++	git add file &&
     ++	git stash push -q --staged &&
     ++	git diff-files >output.out &&
     ++	test_must_be_empty output.out
     ++'
     ++
     ++test_expect_success 'stash apply -q --index refreshes the index' '
     ++	echo test >other-file &&
     ++	git add other-file &&
     ++	echo another-change >other-file &&
     ++	git diff-files >expect &&
     ++	git stash &&
     ++
     ++	git stash apply -q --index &&
     ++	git diff-files >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     + test_expect_success 'stash -k' '
     + 	echo bar3 >file &&
     + 	echo bar4 >file2 &&

-- 
gitgitgadget
