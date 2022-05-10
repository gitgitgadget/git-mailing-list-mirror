Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E2DC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 23:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbiEJXck (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 19:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiEJXci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 19:32:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF31D5007
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d5so638935wrb.6
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EN8DXWKApD4j4GLaAWswi9Tqjn7QJoRkCN9kTaSuOeA=;
        b=aDfaOiqk4EeYeAKxytvENJ4wIruWT24fr+Rd1clVlAnOzr2RUHe1scCEJpG9Quqncj
         WLEeDc1DfuTQXC5a4Rcn3Fdt5AN/qZtH1jjDAzJvuhABO/lHGJ0jW0DW93Evjhqa4CId
         oW+RVTobF0BQ3mUI8Paw7mKyCtt61UoGRIrh4QQt9ARSlw9V3d5KgtcGhITLENaQCwmF
         Pi0Rs7X3yOiKfshyLN4KkqIMrR0XWUvPxrauM4TEUkDKjBToL6iiFGRINPWm5aLCOCVU
         1WZaD/bfql25JLyR+N8Jvg1FYM7fow1jHVey1LGFr5Rw579ON4VnuxtbmLbdThEKGFpU
         N3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EN8DXWKApD4j4GLaAWswi9Tqjn7QJoRkCN9kTaSuOeA=;
        b=wnouCNFM4EdXZqN2/TQFKDcJv9VZngRXe5M+lWvsDCkySGem5ug274BOrO9mgWeUx4
         r0e9KaL2+XPz6tJ/kEZe321lhSsMAk+var94xwFHG66yDtpYs1lmOr34ZZJDIxVWKxkm
         duKFaGo5SgFNfutY7vW5Yfn4sABC9KYfo1kvBJF2bV30eiSZlcUlRXO9obzSuy4YnuDJ
         Ni9ZrjekLIDfXDw3Gvy1aF14e/WkVttEDfzvUKHROcFy9l5Nd1u25WBZ+SWManYHLN+v
         wd1j81snY5kpPrAhI7YFETLAYTmlPUaVbux+loiJV2uzZy4494HhOcG5CJX4d6pAWv8u
         uXQA==
X-Gm-Message-State: AOAM531HhrlM8w+KE6fDkzzSij01n6y8iJYHsSF6RMRyqZxRIPQjzhtl
        JQ/Iyc0RLxAzlNjMZUPkZQVRMq1fkvA=
X-Google-Smtp-Source: ABdhPJy/7KMTaQslyT/RQwJzYqvHskSKt1p72NGUVQUotCrtXJxDdtYGTXKqFA+cuX+DLbpIHnXoog==
X-Received: by 2002:a5d:4b43:0:b0:20c:ca56:e5fb with SMTP id w3-20020a5d4b43000000b0020cca56e5fbmr9951403wrs.212.1652225554529;
        Tue, 10 May 2022 16:32:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d6542000000b0020c5253d910sm150360wrv.92.2022.05.10.16.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 16:32:33 -0700 (PDT)
Message-Id: <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
References: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 23:32:26 +0000
Subject: [PATCH v3 0/6] Sparse index: integrate with 'git stash'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series, in combination with the sparse index integrations of reset [1],
update-index [2], checkout-index [2], clean [2], and read-tree [3], allows
most subcommands of 'git stash' to use the sparse index end-to-end without
index expansion.

Like the earlier series, this series starts with new tests ensuring
compatibility of the sparse index with non-sparse index full and sparse
checkouts [1/6]. Next, sparse index is trivially enabled [2/6].
Functionally, sparse index-enabled sparse-checkouts remain compatible with
non-sparse index sparse-checkouts, but there are still some cases where the
index (or a temporary index) is expanded unnecessarily. These cases are
fixed in three parts:

 * First, 'git stash -u' is made sparse index-compatible by ensuring the
   "temporary" index holding the stashed, untracked files is created as a
   sparse index whenever possible (per repo settings &
   'is_sparse_index_allowed()'). Patch [3/6] exposes
   'is_sparse_index_allowed()' to files outside of 'sparse-index.c', then
   patch [4/6] uses that function to mark the temporary index sparse when
   appropriate.
 * Next, 'git stash (apply|pop)' are made sparse index-compatible by
   changing their internal merge function from 'merge_recursive_generic()'
   (which constructs "fake" commits from the working tree, stash, and stash
   base) to 'merge_ort_nonrecursive()' (which operates on the trees
   directly) in patch [5/6]. The use of the non-recursive 'merge-ort' helps
   us to avoid sparse index expansion associated with 'merge-recursive', as
   well as avoid the unused/unnecessary complexity of a recursive merge.
 * Finally, while patch 5 skips index expansion for most cases of 'git stash
   (apply|pop)', applying a stash that includes untracked files still
   expands the index. This is a result of an internal 'read-tree' execution
   (specifically in its 'unpack_trees' call) creating a result index that is
   never sparse in-core, thus forcing the index to be unnecessarily
   collapsed and re-expanded in 'do_write_locked_index()'. In patch [6/6],
   'unpack_trees' is updated to set the default sparsity of the resultant
   index to "sparse" if allowed by repo settings and
   'is_sparse_index_allowed()' (similar to the change in patch 4).

Performance results (from the 'p2000' tests):

(git stash &&
 git stash pop)              master            this series
---------------------------------------------------------------------
full-v3                      4.07(2.42+1.34)   3.98(2.42+1.32) -2.2%
full-v4                      4.05(2.46+1.31)   4.00(2.49+1.29) -1.2%
sparse-v3                    7.48(4.81+2.57)   1.53(0.26+1.61) -79.5%
sparse-v4                    7.35(4.74+2.54)   1.59(0.27+1.63) -78.4%

(echo >>new &&
 git stash -u &&
 git stash pop)              master            this series
---------------------------------------------------------------------
full-v3                      4.21(2.62+1.45)   4.11(2.55+1.44) -2.4%
full-v4                      4.11(2.51+1.41)   4.02(2.49+1.41) -2.2%
sparse-v3                    7.35(4.64+2.66)   1.70(0.32+1.64) -76.9%
sparse-v4                    7.74(4.87+2.83)   1.70(0.32+1.66) -78.0%



Changes since V2
================

 * Replaced use of 'merge_recursive_generic' with 'merge_ort_nonrecursive'
   in 'do_apply_stash()'
 * Rebased on top of 'master'


Changes since V1
================

 * Added quotes to the "$WITHOUT_UNTRACKED_TXT" when testing for it in
   'ensure_not_expanded' (in 't/t1092-sparse-checkout-compatibility.sh')
 * Moved the 'stash' test in 't1092' elsewhere in the file, so that it
   doesn't conflict (even trivially) with the also-in-flight 'git show'
   integration
 * Moved the 'ensure_not_expended' tests for 'checkout-index' back to
   original location

[1]
https://lore.kernel.org/git/pull.1048.v6.git.1638201164.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.1109.v2.git.1641924306.gitgitgadget@gmail.com/
[3]
https://lore.kernel.org/git/pull.1157.v3.git.1646166271.gitgitgadget@gmail.com/

Thanks!

-Victoria

Victoria Dye (6):
  stash: expand sparse-checkout compatibility testing
  stash: integrate with sparse index
  sparse-index: expose 'is_sparse_index_allowed()'
  read-cache: set sparsity when index is new
  stash: apply stash using 'merge_ort_nonrecursive()'
  unpack-trees: preserve index sparsity

 builtin/stash.c                          | 33 ++++++++--
 read-cache.c                             | 18 +++++-
 sparse-index.c                           |  2 +-
 sparse-index.h                           |  1 +
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 78 +++++++++++++++++++++++-
 unpack-trees.c                           |  6 ++
 7 files changed, 131 insertions(+), 9 deletions(-)


base-commit: 0f828332d5ac36fc63b7d8202652efa152809856
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1171%2Fvdye%2Fsparse%2Fstash-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1171/vdye/sparse/stash-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1171

Range-diff vs v2:

 1:  8ea986cb249 = 1:  4e0a09f7a3c stash: expand sparse-checkout compatibility testing
 2:  b3e3f0298fb = 2:  7be484a8c0b stash: integrate with sparse index
 3:  73f04e95400 = 3:  6f00fca9267 sparse-index: expose 'is_sparse_index_allowed()'
 4:  42550f39a75 = 4:  bb092c075f4 read-cache: set sparsity when index is new
 5:  4537d473b93 < -:  ----------- merge-recursive: add merge function arg to 'merge_recursive_generic'
 6:  22fee0732ad ! 5:  e733c2fd9f4 stash: merge applied stash with merge-ort
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    stash: merge applied stash with merge-ort
     +    stash: apply stash using 'merge_ort_nonrecursive()'
      
     -    Change the merge function used in 'do_apply_stash()' from 'merge_recursive'
     -    to 'merge_ort_recursive'. In addition to aligning with the default merge
     -    strategy used by 'git merge' (6a5fb96672 (Change default merge backend from
     -    recursive to ort, 2021-08-04)), this allows 'git stash <apply|pop>' to
     -    operate without expanding the index by default. Update tests in 't1092'
     -    verifying index expansion for 'git stash' accordingly.
     +    Update 'stash' to use 'merge_ort_nonrecursive()' to apply a stash to the
     +    current working tree. When 'git stash apply' was converted from its shell
     +    script implementation to a builtin in 8a0fc8d19d (stash: convert apply to
     +    builtin, 2019-02-25), 'merge_recursive_generic()' was used to merge a stash
     +    into the working tree as part of 'git stash (apply|pop)'. However, with the
     +    single merge base used in 'do_apply_stash()', the commit wrapping done by
     +    'merge_recursive_generic()' is not only unnecessary, but misleading (the
     +    *real* merge base is labeled "constructed merge base"). Therefore, a
     +    non-recursive merge of the working tree, stashed tree, and stash base tree
     +    is more appropriate.
     +
     +    There are two options for a non-recursive merge-then-update-worktree
     +    function: 'merge_trees()' and 'merge_ort_nonrecursive()'. Use
     +    'merge_ort_nonrecursive()' to align with the default merge strategy used by
     +    'git merge' (6a5fb96672 (Change default merge backend from recursive to ort,
     +    2021-08-04)) and, because merge-ort does not operate in-place on the index,
     +    avoid unnecessary index expansion. Update tests in 't1092' verifying index
     +    expansion for 'git stash' accordingly.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     @@ builtin/stash.c
       #include "strvec.h"
       #include "run-command.h"
       #include "dir.h"
     +@@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *orig_tree)
     + static int do_apply_stash(const char *prefix, struct stash_info *info,
     + 			  int index, int quiet)
     + {
     +-	int ret;
     ++	int clean, ret;
     + 	int has_index = index;
     + 	struct merge_options o;
     + 	struct object_id c_tree;
     + 	struct object_id index_tree;
     +-	struct commit *result;
     +-	const struct object_id *bases[1];
     ++	struct tree *head, *merge, *merge_base;
     ++	struct lock_file lock = LOCK_INIT;
     + 
     + 	read_cache_preload(NULL);
     + 	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
     +@@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
     + 
     + 	o.branch1 = "Updated upstream";
     + 	o.branch2 = "Stashed changes";
     ++	o.ancestor = "Stash base";
     + 
     + 	if (oideq(&info->b_tree, &c_tree))
     + 		o.branch1 = "Version stash was based on";
      @@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
     - 	bases[0] = &info->b_tree;
     + 	if (o.verbosity >= 3)
     + 		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
     + 
     +-	bases[0] = &info->b_tree;
     ++	head = lookup_tree(o.repo, &c_tree);
     ++	merge = lookup_tree(o.repo, &info->w_tree);
     ++	merge_base = lookup_tree(o.repo, &info->b_tree);
     ++
     ++	repo_hold_locked_index(o.repo, &lock, LOCK_DIE_ON_ERROR);
     ++	clean = merge_ort_nonrecursive(&o, head, merge, merge_base);
     ++
     ++	/*
     ++	 * If 'clean' >= 0, reverse the value for 'ret' so 'ret' is 0 when the
     ++	 * merge was clean, and nonzero if the merge was unclean or encountered
     ++	 * an error.
     ++	 */
     ++	ret = clean >= 0 ? !clean : clean;
     ++
     ++	if (ret < 0)
     ++		rollback_lock_file(&lock);
     ++	else if (write_locked_index(o.repo->index, &lock,
     ++				      COMMIT_LOCK | SKIP_IF_UNCHANGED))
     ++		ret = error(_("could not write index"));
       
     - 	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
     --				      merge_recursive, &result);
     -+				      merge_ort_recursive, &result);
     +-	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
     +-				      &result);
       	if (ret) {
       		rerere(0);
       
 7:  3179018a8cb = 6:  4b4c38fcc03 unpack-trees: preserve index sparsity

-- 
gitgitgadget
