Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673CAC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 19:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349516AbhK2TiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 14:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhK2TgS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 14:36:18 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC45C0617A1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:46 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i12so15056782wmq.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A/RlkiyYnWxE+LxUovszYrmVMFfWfEHi9Lt0h949vw4=;
        b=NOwWGuhdlMxxe9mk6CCMZY5lJnehY46oxA7FGrilgyhcTMOxvTgg3eaum7bwsXfaEt
         rwQBB/PdBx70nkDO8iJKEEUlGJdbhum14G39gXP4a3pwTPrGJ7DmVKsdYs2qjVd9+uoK
         cfKif7o/mTXTfopR4eJF1QAXBvasZunbW7FYcGO0oA4taX3i4RbKTxvs7li07rxO2eZE
         H1iU4lvUmih9JckTMjBk1odVUmcoLtzHamS6JXi+txzVmFo+FK969UFvONYlv70G/OFA
         GLEmhmHaZC5qltyqdeFt6hAPFupIzVPsfHkJq9PXJg67wSaUHWr04Gp2Sesd0JOOklV3
         uCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A/RlkiyYnWxE+LxUovszYrmVMFfWfEHi9Lt0h949vw4=;
        b=UgAztadDp7ogbV/k564kHBHgpmj5Y7xPKCQB/IQUyUd3DugMpsD9xB4tW5VdKtOBPs
         Iqzr/uFcsai9zn3Vazbi5/E5cS1q8CXyN67+XEY+0kg5hj6n8CZY5s1rymHOziHWpYS5
         PYPcKI0c0x77P19A3xtGiSVESWbk6iieAkNWG9nVEHrBMZX8OqMgP3f4AUKD+5s9OoFP
         3D0Mxs83JhdK6ujtWXCDA30LKN/DMT47rULrfze+7vH+a2gL9tOK1w7oBp2ccY8XNx2q
         1e2tFAwtT3n8+x3wUKdSA1AKMYiMqS/va0aPLtYHT9IrX9iR6f37apXTu+2IMnsGTmzP
         0Lcg==
X-Gm-Message-State: AOAM531YZqg61uUOW7XBm4GD3SqVH6968UugQG8ODlPtVN3nRHfREvLm
        36cBl7FYtVv7n0JKvhm08nZeF8eSFV4=
X-Google-Smtp-Source: ABdhPJyLcY8zAArnfvaxglj8iPC4SWKSbviB1a5G2obkn1dfL0Lo+ex8sD8cs0BmT3V4qQCmJXaN1w==
X-Received: by 2002:a05:600c:a55:: with SMTP id c21mr37898907wmq.191.1638201165099;
        Mon, 29 Nov 2021 07:52:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j40sm22484302wms.19.2021.11.29.07.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:52:44 -0800 (PST)
Message-Id: <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
References: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 15:52:35 +0000
Subject: [PATCH v6 0/8] Sparse Index: integrate with reset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series integrates the sparse index with git reset and provides
miscellaneous fixes and improvements to the command in sparse checkouts.
This includes:

 1. tests added to t1092 and p2000 to establish the baseline functionality
    of the command
 2. repository settings to enable the sparse index with ensure_full_index
    guarding any code paths that break tests without other compatibility
    updates.
 3. modifications to remove or reduce the scope in which ensure_full_index
    must be called.

The sparse index updates are predicated on a fix originating from the
microsoft/git fork [1], correcting how git reset --mixed handles resetting
entries outside the sparse checkout definition. Additionally, a performance
"bug" in next_cache_entry with sparse index is corrected, preventing
repeatedly looping over already-searched entries.

The p2000 tests demonstrate a ~70% execution time reduction in git reset
using a sparse index, and no change (within expected variability [2]) using
a full index. Results summarized below [3, 4]:

Test                           base              [5/8]                 
-----------------------------------------------------------------------
git reset --hard (full-v3)     1.00(0.50+0.39)   0.97(0.50+0.37) -3.0% 
git reset --hard (full-v4)     1.00(0.51+0.38)   0.96(0.50+0.36) -4.0% 
git reset --hard (sparse-v3)   1.68(1.17+0.39)   1.37(0.91+0.35) -18.5%
git reset --hard (sparse-v4)   1.70(1.18+0.40)   1.41(0.94+0.35) -17.1%

Test                           base              [6/8]   
-----------------------------------------------------------------------
git reset --hard (full-v3)     1.00(0.50+0.39)   0.94(0.48+0.34) -6.0% 
git reset --hard (full-v4)     1.00(0.51+0.38)   0.95(0.51+0.34) -5.0% 
git reset --hard (sparse-v3)   1.68(1.17+0.39)   0.46(0.05+0.29) -72.6%
git reset --hard (sparse-v4)   1.70(1.18+0.40)   0.46(0.06+0.29) -72.9%

Test                               base              [7/8]
---------------------------------------------------------------------------
git reset (full-v3)                0.77(0.27+0.37)   0.72(0.26+0.32) -6.5%
git reset (full-v4)                0.75(0.27+0.34)   0.73(0.26+0.32) -2.7%
git reset (sparse-v3)              1.44(0.96+0.36)   0.43(0.04+0.96) -70.1%
git reset (sparse-v4)              1.46(0.97+0.36)   0.43(0.05+0.79) -70.5%
git reset -- missing (full-v3)     0.72(0.26+0.32)   0.69(0.26+0.30) -4.2%
git reset -- missing (full-v4)     0.74(0.28+0.33)   0.71(0.27+0.32) -4.1% 
git reset -- missing (sparse-v3)   1.45(0.97+0.35)   0.81(0.42+0.90) -44.1%
git reset -- missing (sparse-v4)   1.41(0.94+0.34)   0.79(0.42+0.76) -44.0%

Test                               base              [8/8]            
---------------------------------------------------------------------------
git reset -- missing (full-v3)     0.72(0.26+0.32)   0.73(0.26+0.33) +1.4% 
git reset -- missing (full-v4)     0.74(0.28+0.33)   0.74(0.27+0.32) +0.0% 
git reset -- missing (sparse-v3)   1.45(0.97+0.35)   0.43(0.05+0.80) -70.3%
git reset -- missing (sparse-v4)   1.41(0.94+0.34)   0.44(0.05+0.76) -68.8%



Changes since V1
================

 * Add --force-full-index option to update-index. The option is used
   circumvent changing command_requires_full_index from its default value -
   right now this is effectively a no-op, but will change once update-index
   is integrated with sparse index. By using this option in the t1092
   expand/collapse test, the command used to test will not need to be
   updated with subsequent sparse index integrations.
 * Update implementation of mixed reset for entries outside sparse checkout
   definition. The condition in which a file should be checked out before
   index reset is simplified to "if it has skip-worktree enabled and a reset
   would change the file, check it out".
   * After checking the behavior of update_index_from_diff with renames,
     found that the diff used by reset does not produce diff queue entries
     with different pathnames for one and two. Because of this, and that
     nothing in the implementation seems to rely on identical path names, no
     BUG check is added.
 * Correct a bug in the sparse index is not expanded tests in t1092 where
   failure of a git reset --mixed test was not being reported. Test now
   verifies an appropriate scenario with corrected failure-checking.


Changes since V2
================

 * Replace patch adding checkouts for git reset --mixed with sparse checkout
   with preserving the skip-worktree flag (including a new test for git
   reset --mixed and update to t1092 - checkout and reset (mixed))
 * Move rename of is_missing into its own patch
 * Further extend t1092 tests and remove unnecessary commands/tests where
   possible
 * Refine logic determining which pathspecs require ensure_full_index in git
   reset --mixed, add related ensure_not_expanded tests
 * Add index_search_mode enum to index_name_stage_pos
 * Clean up variable usage & remove unnecessary subtree_path in
   prime_cache_tree_rec
 * Update cover letter performance data
 * More thoroughly explain changes in each commit message


Changes since V3
================

 * Replace git update-index --force-full-index with git reset update-folder1
   -- folder1/a, remove introduction of new --force-full-index option
   entirely, and add comment clarifying the intent of sparse-index is
   expanded and converted back test
 * Fix authorship on reset: preserve skip-worktree bit in mixed reset
   (current patch fully replaces original patch, but metadata of the
   original wasn't properly replaced)


Changes since V4
================

 * Update t1092 test 'checkout and reset (mixed)' to explicitly verify
   differences between sparse and full checkouts


Changes since V5
================

 * Update t1092 test 'reset with wildcard pathspec' with more cases and
   better checks
 * Add "special case" wildcard pathspec check when determining whether to
   expand the index (avoids double-loop over pathspecs & index entries)

Thanks! -Victoria

[1] microsoft@6b8a074 [2]
https://lore.kernel.org/git/8b9fe3f8-f0e3-4567-b20b-17c92bd1a5c5@github.com/
[3] If a test and/or commit is not mentioned, there is no significant change
to performance [4] Pathspec "does-not-exist" is changed to "missing" to save
space in performance report

Victoria Dye (8):
  reset: rename is_missing to !is_in_reset_tree
  reset: preserve skip-worktree bit in mixed reset
  sparse-index: update command for expand/collapse test
  reset: expand test coverage for sparse checkouts
  reset: integrate with sparse index
  reset: make sparse-aware (except --mixed)
  reset: make --mixed sparse-aware
  unpack-trees: improve performance of next_cache_entry

 builtin/reset.c                          | 113 ++++++++++++++++-
 cache-tree.c                             |  46 ++++++-
 cache.h                                  |  10 ++
 read-cache.c                             |  27 ++--
 t/perf/p2000-sparse-operations.sh        |   3 +
 t/t1092-sparse-checkout-compatibility.sh | 154 ++++++++++++++++++++---
 t/t7102-reset.sh                         |  17 +++
 unpack-trees.c                           |  23 +++-
 8 files changed, 356 insertions(+), 37 deletions(-)


base-commit: cefe983a320c03d7843ac78e73bd513a27806845
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1048%2Fvdye%2Fvdye%2Fsparse-index-part1-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1048/vdye/vdye/sparse-index-part1-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1048

Range-diff vs v5:

 1:  ad7013a31aa = 1:  ad7013a31aa reset: rename is_missing to !is_in_reset_tree
 2:  b221b00b7e0 = 2:  b221b00b7e0 reset: preserve skip-worktree bit in mixed reset
 3:  1bb2ca92c60 = 3:  1bb2ca92c60 sparse-index: update command for expand/collapse test
 4:  cc76c694647 ! 4:  741a2c9ffaa reset: expand test coverage for sparse checkouts
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'checkout and rese
      +test_expect_success 'reset with wildcard pathspec' '
      +	init_repos &&
      +
     -+	test_all_match git checkout -b reset-test update-deep &&
     -+	test_all_match git reset base -- \*/a &&
     -+	test_all_match git status --porcelain=v2 &&
     -+	test_all_match git rev-parse HEAD:folder1/a &&
     ++	test_all_match git reset update-deep -- deep\* &&
     ++	test_all_match git ls-files -s -- deep &&
      +
     -+	test_all_match git reset base -- folder\* &&
     -+	test_all_match git status --porcelain=v2 &&
     -+	test_all_match git rev-parse HEAD:folder2
     ++	test_all_match git reset deepest -- deep\*\*\* &&
     ++	test_all_match git ls-files -s -- deep &&
     ++
     ++	# The following `git reset`s result in updating the index on files with
     ++	# `skip-worktree` enabled. To avoid failing due to discrepencies in reported
     ++	# "modified" files, `test_sparse_match` reset is performed separately from
     ++	# "full-checkout" reset, then the index contents of all repos are verified.
     ++
     ++	test_sparse_match git reset update-folder1 -- \*/a &&
     ++	git -C full-checkout reset update-folder1 -- \*/a &&
     ++	test_all_match git ls-files -s -- deep/a folder1/a &&
     ++
     ++	test_sparse_match git reset update-folder2 -- folder\* &&
     ++	git -C full-checkout reset update-folder2 -- folder\* &&
     ++	test_all_match git ls-files -s -- folder10 folder1 folder2 &&
     ++
     ++	test_sparse_match git reset base -- folder1/\* &&
     ++	git -C full-checkout reset base -- folder1/\* &&
     ++	test_all_match git ls-files -s -- folder1
      +'
      +
       test_expect_success 'merge, cherry-pick, and rebase' '
 5:  217ae445418 = 5:  65b0eafd27c reset: integrate with sparse index
 6:  a3e2fd59867 = 6:  908c84005b9 reset: make sparse-aware (except --mixed)
 7:  a9135a5ed64 ! 7:  822d7344587 reset: make --mixed sparse-aware
     @@ Commit message
      
          Remove the `ensure_full_index` guard on `read_from_tree` and update `git
          reset --mixed` to ensure it can use sparse directory index entries wherever
     -    possible. Sparse directory entries are reset use `diff_tree_oid`, which
     +    possible. Sparse directory entries are reset using `diff_tree_oid`, which
          requires `change` and `add_remove` functions to process the internal
          contents of the sparse directory. The `recursive` diff option handles cases
          in which `reset --mixed` must diff/merge files that are nested multiple
     @@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
      +		 * (since we can reset whole sparse directories without expanding them).
      +		 */
      +		if (item.nowildcard_len < item.len) {
     ++			/*
     ++			 * Special case: if the pattern is a path inside the cone
     ++			 * followed by only wildcards, the pattern cannot match
     ++			 * partial sparse directories, so we don't expand the index.
     ++			 */
     ++			if (path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
     ++			    strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len)
     ++				continue;
     ++
      +			for (pos = 0; pos < active_nr; pos++) {
      +				struct cache_entry *ce = active_cache[pos];
      +
 8:  f91d1dcf024 = 8:  ddd97fb2837 unpack-trees: improve performance of next_cache_entry

-- 
gitgitgadget
