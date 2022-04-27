Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850BDC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 18:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbiD0STj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiD0STg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 14:19:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730F42AC68
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s21so3619004wrb.8
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vC7Q/4i4e6G9nL1vAoqj3NpAg7XNJBGKgcOlUHLq+3M=;
        b=A4zJFoDeD33tx7MtpGTjdzcnwcT6wm5g/HY9fpJkj47km1Rib37vsGxYV70qzI04dA
         XP+OT/zMbks15pFFgxGM216LAizrSs56ywM13jTfIgibtvSA99e09Axox5mp1Pn/IrSu
         IFQxA+kbaMza9dNjHNLGwA2uDd3pJGDyL4H5swtYI3a0vSKps25jvU7OizACmm2uVRz6
         vTcWXgbPqCa9qgto+Pfe/n9qtnG3/kXVhg7TD+kiF2CcqZDb+B88gs///dOvObnrE3f5
         SE62G8/r4XfrDSp4qf58sLvk7cbGnhIzZcgN9SJWdolWEScEAMLR2qGQfe8uDFr1jq2j
         wNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vC7Q/4i4e6G9nL1vAoqj3NpAg7XNJBGKgcOlUHLq+3M=;
        b=niChft3wMhjUcAOyvBttQjwSTaSYW6bXgqmSbxJ1QnyX6+G+GGr/ZfczxqVcZuWlQ1
         PE0Yn6v9pXHbobUmfnPMRvKLgK2hs4D6jWNv7lSJ/8UCxheAVoVhJmDe+eBZk8/2/elP
         tBRSzmHLGa+i4ru0XAHJb9Fs7JyCRtXgFV4P6VxceEGg/eh8opu5B5OxEvRiJHdW59RX
         aacv17iW7iggd0NcEDruR6aiaL7fCGKXuPEuNNu4j3BDRjqH97QGqWDA7un2aJRjJCFg
         L2HVCVsZk7nUwQNe+QcUx850ux2D69r28oiR/EQ1ssoDNwqXwrnJAFvDLAooga8dqG+2
         oLMA==
X-Gm-Message-State: AOAM532JLbF8FY3zniBDu2NCWk+OT5TTgdbuLaZuxbHWbWZxMPw386pI
        uqDwoL/vnxK1v179gGQgGgPKSNyhTV4=
X-Google-Smtp-Source: ABdhPJz5xv8o9dLpX+V3+yAgeOiSB8LvP3jGDjljC3fjGX/OifNU4eY+cohfiEfnxtIUcvNg6+hL7A==
X-Received: by 2002:a05:6000:18cb:b0:207:8c65:3fd4 with SMTP id w11-20020a05600018cb00b002078c653fd4mr23527703wrq.131.1651083380519;
        Wed, 27 Apr 2022 11:16:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d51cd000000b0020af0706b9csm1723369wrv.53.2022.04.27.11.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:16:19 -0700 (PDT)
Message-Id: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 18:16:11 +0000
Subject: [PATCH v2 0/7] Sparse index: integrate with 'git stash'
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
checkouts [1/7]. Next, sparse index is trivially enabled [2/7].
Functionally, sparse index-enabled sparse-checkouts remain compatible with
non-sparse index sparse-checkouts, but there are still some cases where the
index (or a temporary index) is expanded unnecessarily. These cases are
fixed in three parts:

 * First, 'git stash -u' is made sparse index-compatible by ensuring the
   "temporary" index holding the stashed, untracked files is created as a
   sparse index whenever possible (per repo settings &
   'is_sparse_index_allowed()'). Patch [3/7] exposes
   'is_sparse_index_allowed()' to files outside of 'sparse-index.c', then
   patch [4/7] uses that function to mark the temporary index sparse when
   appropriate.
 * Next, 'git stash (apply|pop)' are made sparse index-compatible by
   changing their internal "merge" function (executed via
   'merge_recursive_generic()') from 'merge_recursive()' to
   'merge_ort_recursive()'. This requires first allowing
   'merge_recursive_generic()' to accept a merge function as an input
   (rather than hardcoding use of 'merge_recursive()') in patch [5/7], then
   changing the call in 'stash.c' to specify 'merge_ort_recursive()' in
   patch [6/7]. See note [4] for possible alternate implementations.
 * Finally, while patches 5 & 6 avoid index expansion for most cases of 'git
   stash (apply|pop)', applying a stash that includes untracked files still
   expands the index. This is a result of an internal 'read-tree' execution
   (specifically in its 'unpack_trees' call) creating a result index that is
   never sparse in-core, thus forcing the index to be unnecessarily
   collapsed and re-expanded in 'do_write_locked_index()'. In patch [7/7],
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
[4] I went with changing 'stash' to always use 'merge-ort' in
'merge_recursive_generic()' as a sort of "middle ground" between "replace
'merge_recursive()' with 'merge_ort_recursive()' in all of its hardcoded
internal usage" and "only use 'merge-ort' if using a sparse index in 'git
stash', otherwise 'merge-recursive'". The former would extend the use of
'merge-ort' to 'git am' and 'git merge-recursive', whereas the latter is a
more cautious/narrowly-focused option. If anyone has any other thoughts, I'm
interested in hearing them.

Thanks!

-Victoria

Victoria Dye (7):
  stash: expand sparse-checkout compatibility testing
  stash: integrate with sparse index
  sparse-index: expose 'is_sparse_index_allowed()'
  read-cache: set sparsity when index is new
  merge-recursive: add merge function arg to 'merge_recursive_generic'
  stash: merge applied stash with merge-ort
  unpack-trees: preserve index sparsity

 builtin/am.c                             |  2 +-
 builtin/merge-recursive.c                |  2 +-
 builtin/stash.c                          |  6 +-
 merge-ort.c                              |  3 +-
 merge-recursive.c                        |  4 +-
 merge-recursive.h                        |  9 ++-
 read-cache.c                             | 18 +++++-
 sparse-index.c                           |  2 +-
 sparse-index.h                           |  1 +
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 78 +++++++++++++++++++++++-
 unpack-trees.c                           |  6 ++
 12 files changed, 123 insertions(+), 10 deletions(-)


base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1171%2Fvdye%2Fsparse%2Fstash-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1171/vdye/sparse/stash-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1171

Range-diff vs v1:

 1:  994864852a0 ! 1:  8ea986cb249 stash: expand sparse-checkout compatibility testing
     @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all () {
       test_perf_on_all git commit -a -m A
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
     -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'clean' '
     - 	test_sparse_match test_path_is_dir folder1
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'cherry-pick with conflicts' '
     + 	test_all_match test_must_fail git cherry-pick to-cherry-pick
       '
       
      +test_expect_success 'stash' '
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'clean' '
      +	test_all_match git status --porcelain=v2
      +'
      +
     - test_expect_success 'submodule handling' '
     + test_expect_success 'checkout-index inside sparse definition' '
       	init_repos &&
       
 2:  f6cf05a5bee ! 2:  b3e3f0298fb stash: integrate with sparse index
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'index.sparse disa
       ensure_not_expanded () {
       	rm -f trace2.txt &&
      -	echo >>sparse-index/untracked.txt &&
     -+	if test -z $WITHOUT_UNTRACKED_TXT
     ++	if test -z "$WITHOUT_UNTRACKED_TXT"
      +	then
      +		echo >>sparse-index/untracked.txt
      +	fi &&
       
       	if test "$1" = "!"
       	then
     -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded' '
     - 	echo >>sparse-index/untracked.txt &&
     - 	ensure_not_expanded add . &&
     - 
     --	ensure_not_expanded checkout-index -f a &&
     --	ensure_not_expanded checkout-index -f --all &&
     --	for ref in update-deep update-folder1 update-folder2 update-deep
     --	do
     --		echo >>sparse-index/README.md &&
     --		ensure_not_expanded reset --hard $ref || return 1
     --	done &&
     --
     - 	ensure_not_expanded reset --mixed base &&
     - 	ensure_not_expanded reset --hard update-deep &&
     - 	ensure_not_expanded reset --keep base &&
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
       	)
       '
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +	oid=$(git -C sparse-index stash create) &&
      +	ensure_not_expanded stash store -m "test" $oid &&
      +	ensure_not_expanded reset --hard &&
     -+	! ensure_not_expanded stash pop &&
     -+
     -+	ensure_not_expanded checkout-index -f a &&
     -+	ensure_not_expanded checkout-index -f --all &&
     -+	for ref in update-deep update-folder1 update-folder2 update-deep
     -+	do
     -+		echo >>sparse-index/README.md &&
     -+		ensure_not_expanded reset --hard $ref || return 1
     -+	done
     ++	! ensure_not_expanded stash pop
      +'
      +
       test_expect_success 'sparse index is not expanded: diff' '
 3:  27d9920366f = 3:  73f04e95400 sparse-index: expose 'is_sparse_index_allowed()'
 4:  64edbed0f95 = 4:  42550f39a75 read-cache: set sparsity when index is new
 5:  80c25c75874 = 5:  4537d473b93 merge-recursive: add merge function arg to 'merge_recursive_generic'
 6:  76f2a9e8722 ! 6:  22fee0732ad stash: merge applied stash with merge-ort
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
       	oid=$(git -C sparse-index stash create) &&
       	ensure_not_expanded stash store -m "test" $oid &&
       	ensure_not_expanded reset --hard &&
     --	! ensure_not_expanded stash pop &&
     -+	ensure_not_expanded stash pop &&
     +-	! ensure_not_expanded stash pop
     ++	ensure_not_expanded stash pop
     + '
       
     - 	ensure_not_expanded checkout-index -f a &&
     - 	ensure_not_expanded checkout-index -f --all &&
     + test_expect_success 'sparse index is not expanded: diff' '
 7:  1daecbe45c1 = 7:  3179018a8cb unpack-trees: preserve index sparsity

-- 
gitgitgadget
