Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F233C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbiCAU06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiCAU0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:26:24 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC7A8BF6D
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:24:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t11so1311057wrm.5
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 12:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=tQJ34rs4yOw7ts0nT6t9mvrYiIQ3jaDbGQLe8onAIaQ=;
        b=W9qs/TChR7cFV9cvEtyVCSZrU/XPhZt7XN9/4pds6xU8B3qp47cTSRw4PkPoX/hZpg
         3Y0BlJW+Ceb77K5dr1iX3NlQret6IEHVqWcJBkwDFpQtOPbKKucEEMcPLji4Etio+xTJ
         HYAgUku8aAtjnwXQsWByvxKCXdWNLeKgsca18SoHIvHPUhKLbj7nimgjWZXS0KonWcy7
         /haGQJMC7x4+HeCzRBKnJYmuLdnFzDGdrUgM/TzDbC5BJ4lKn+OyOG1sFdQ3JPTdmiXO
         z2CM+QLunxNEbwoFdlog2SL0NXHfnxX+31+UTowWkxBgh7Xq0AFm9+xrcDCY66IPq8b0
         mdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=tQJ34rs4yOw7ts0nT6t9mvrYiIQ3jaDbGQLe8onAIaQ=;
        b=lZILRHHTv9mH/pgiDI9lfGKwudWx29ykVTuJjPvRjJYJlpqMYa0UF0MfIuZ7v+qYx4
         PMl6ouX/CMv3fMOsFzH6S/XfJalN/B0ZqvWHkJsalWLL3kLg1FYMoTVwh1flJfeqLJev
         +q0rEZmBTJxDKinG1sO/vhP6CHbU4mgoTRQLtjKo1QxmBAEKUOSJPh4UWQ8pQW2EIfs4
         9g+dCyU+kvN34unQ+4kiGUeUOddUca7T9AK4fm1/hp+0ejOY2MIo3ney8Pslo8qdUguk
         1NmRWSH3S7ZuVM6eNPzOTfyotSU1ECHmVrUvCgy0hy78Fkw2badHWnxf8wDcvJ3ydWfg
         L2JQ==
X-Gm-Message-State: AOAM533DYxvTG0SVTWhMY1TYU+NHFqeYZ7Gg6HQF3KVYjOVCoDV7y4+K
        Z9S+uC322DFwg6o3qcD/3OwPgb5BSko=
X-Google-Smtp-Source: ABdhPJycTFIDQug70P7eeauApbpnkNTBX3q7EQRB8KH6ndoZbItY2WG3knlRLnSWXCfDm86soMNNbQ==
X-Received: by 2002:a05:6000:1acf:b0:1ea:f20:cbed with SMTP id i15-20020a0560001acf00b001ea0f20cbedmr20211264wry.217.1646166272453;
        Tue, 01 Mar 2022 12:24:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7-20020adff547000000b001e3241df64bsm14457979wrp.112.2022.03.01.12.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 12:24:32 -0800 (PST)
Message-Id: <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 20:24:23 +0000
Subject: [PATCH v3 0/8] Sparse index: integrate with 'read-tree'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like previous integrations [1] [2], this series allows 'git read-tree' to
operate using a sparse index.

The first three patches are bugfixes for issues found while implementing the
'read-tree' integration:

 * The first (patch [1/8]) fixes an edge case in which a repo with no
   in-cone files or directories would have its root collapsed into a sparse
   directory; the fix ensures the root directory is never collapsed into a
   sparse directory.
 * The second (patch [2/8]) corrects the 'git status' reporting of changes
   nested inside the subdirectory of a sparse directory, ensuring that the
   modified file (not the subdirectory) is correctly reported as having
   changes.
 * The third (patch [3/8]) explicitly disallows the somewhat ambiguous case
   of using 'git read-tree --prefix=/' to represent the repo root (it could
   be interpreted as a leading slash - even though it's actually trailing
   slash - which is not allowed for prefixes). Now, an error specifying that
   prefixes cannot begin with '/' guides users more directly to the correct
   syntax. If a user does want to specify the repo root as their prefix,
   that can still be done with 'git read-tree --prefix='

The remainder of the series focuses on utilizing the sparse index in 'git
read-tree'. After some baseline behavior-establishing tests (patch [4/8]),
sparse index usage is trivially enabled (patch [5/8]) for 'read-tree'
except:

 * usage with '--prefix'
 * two- and three-way merge

These cases require additional changes in order to work as expected (i.e.,
outwardly matching non-sparse index sparse-checkout). For the former, the
sparse index can be enabled as long as the index is expanded when the prefix
is a directory outside the sparse cone (patch [6/8]). For the latter, sparse
directories that cannot be trivially merged must have their contents merged
file-by-file, done by recursively traversing the trees represented by the
sparse directories (patches [7/8] & [8/8]).


Changes since V2
================

 * revised/clarified explanation for why the 'recursive' flag is necessary
   in 'git status' internal diff in both the commit message for [2/8] and
   the code comments
 * added patch [3/8] to disallow '/' as a prefix
 * moved the loop over different 'read-tree' scenarios outside the test in
   t1092 test 'read-tree --merge with files outside sparse definition',
   separating the tests into individually-runnable and traceable cases
 * improved test case clarity and variety in 'read-tree --prefix' tests
 * removed redundant arg to 'git reset' in 'sparse index is not expanded:
   read-tree'
 * pointed out pre-existing testing that covers '--prefix' in [6/8] commit
   message
 * moved prefix-dependent index expansion logic into function
   'update_sparsity_for_prefix', improved explanation for function behavior
   in comments
 * pointed out pre-existing testing that covers two- and three-way merge in
   [7/8] & [8/8] commit messages, respectively
 * added test cases for "ensure not expanded" tests of read-tree for both
   two- and three-way merge
 * fixed issue with three-way merge implementation (if the "no merge" cases
   described in 't/t1000-read-tree-m-3way.sh' are reached, sparse
   directories should be recursively merged), testing added in the "ensure
   not expanded" cases


Changes since V1
================

 * switched an empty string check from '!strlen(path)' to the
   slightly-less-expensive '!*path'

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/pull.1109.v2.git.1641924306.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.1048.v6.git.1638201164.gitgitgadget@gmail.com/

Victoria Dye (8):
  sparse-index: prevent repo root from becoming sparse
  status: fix nested sparse directory diff in sparse index
  read-tree: explicitly disallow prefixes with a leading '/'
  read-tree: expand sparse checkout test coverage
  read-tree: integrate with sparse index
  read-tree: narrow scope of index expansion for '--prefix'
  read-tree: make two-way merge sparse-aware
  read-tree: make three-way merge sparse-aware

 builtin/read-tree.c                      |  14 ++-
 dir.c                                    |   7 +-
 t/perf/p2000-sparse-operations.sh        |   1 +
 t/t1003-read-tree-prefix.sh              |  10 ++
 t/t1092-sparse-checkout-compatibility.sh | 133 ++++++++++++++++++++
 unpack-trees.c                           | 147 +++++++++++++++++++++--
 wt-status.c                              |   9 ++
 7 files changed, 308 insertions(+), 13 deletions(-)


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1157%2Fvdye%2Fsparse%2Fread-tree-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1157/vdye/sparse/read-tree-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1157

Range-diff vs v2:

 1:  744668eeece = 1:  744668eeece sparse-index: prevent repo root from becoming sparse
 2:  f0cff03b95d ! 2:  26f4d30bd95 status: fix nested sparse directory diff in sparse index
     @@ Metadata
       ## Commit message ##
          status: fix nested sparse directory diff in sparse index
      
     -    Add the 'recursive' flag to 'wt_status_collect_changes_index(...)'. Without
     -    the 'recursive' flag, 'git status' could report index changes incorrectly
     -    when the following conditions were met:
     +    Enable the 'recursive' diff option for the diff executed as part of 'git
     +    status'. Without the 'recursive' enabled, 'git status' reports index
     +    changes incorrectly when the following conditions were met:
      
          * sparse index is enabled
          * there is a difference between the index and HEAD in a file inside a
            *subdirectory* of a sparse directory
          * the sparse directory index entry is *not* expanded in-core
      
     -    In this scenario, 'git status' would not recurse into the sparse directory's
     -    subdirectories to identify which file contained the difference between the
     -    index and HEAD. Instead, it would report the immediate subdirectory itself
     -    as "modified".
     +    Because it is not recursive by default, the diff in 'git status' reports
     +    changes only at the level of files and directories that are immediate
     +    children of a sparse directory, rather than recursing into directories with
     +    changes to identify the modified file(s). As a result, 'git status' reports
     +    the immediate subdirectory itself as "modified".
      
          Example:
      
     @@ Commit message
            (use "git restore --staged <file>..." to unstage)
                  modified:   sparse/sub
      
     -    The 'recursive' diff option in 'wt_status_collect_changes_index' corrects
     -    this by indicating that 'git status' should recurse into sparse directories
     -    to find modified files. Given the same repository setup as the example
     -    above, the corrected result of `git status` is:
     +    Enabling the 'recursive' diff option in 'wt_status_collect_changes_index'
     +    corrects this issue by allowing the diff to recurse into subdirectories of
     +    sparse directories to find modified files. Given the same repository setup
     +    as the example above, the corrected result of `git status` is:
      
          $ git status
          On branch master
     @@ wt-status.c: static void wt_status_collect_changes_index(struct wt_status *s)
       	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
      +
      +	/*
     -+	 * The `recursive` option must be enabled to show differences in files
     -+	 * *more than* one level deep in a sparse directory index entry (e.g., given
     -+	 * sparse directory 'sparse-dir/', reporting a difference in the file
     -+	 * 'sparse-dir/another-dir/my-file').
     ++	 * The `recursive` option must be enabled to allow the diff to recurse
     ++	 * into subdirectories of sparse directory index entries. If it is not
     ++	 * enabled, a subdirectory containing file(s) with changes is reported
     ++	 * as "modified", rather than the modified files themselves.
      +	 */
      +	rev.diffopt.flags.recursive = 1;
      +
 -:  ----------- > 3:  e48a281a4d3 read-tree: explicitly disallow prefixes with a leading '/'
 3:  ffe0b6aff2b ! 4:  90ebcb7b8ff read-tree: expand sparse checkout test coverage
     @@ Commit message
          emphasis is placed on interactions with files outside the sparse cone, e.g.
          merges with out-of-cone conflicts.
      
     +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## t/perf/p2000-sparse-operations.sh ##
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'update-index --ca
       	test_cmp expect sparse-checkout-out
       '
       
     -+test_expect_success 'read-tree --merge with files outside sparse definition' '
     -+	init_repos &&
     -+
     -+	test_all_match git checkout -b test-branch update-folder1 &&
     -+	for MERGE_TREES in "base HEAD update-folder2" \
     -+			   "update-folder1 update-folder2" \
     -+			   "update-folder2"
     -+	do
     -+		# Clean up and remove on-disk files
     -+		test_all_match git reset --hard HEAD &&
     -+		test_sparse_match git sparse-checkout reapply &&
     ++for MERGE_TREES in "base HEAD update-folder2" \
     ++		   "update-folder1 update-folder2" \
     ++		   "update-folder2"
     ++do
     ++	test_expect_success "'read-tree -mu $MERGE_TREES' with files outside sparse definition" '
     ++		init_repos &&
      +
      +		# Although the index matches, without --no-sparse-checkout, outside-of-
      +		# definition files will not exist on disk for sparse checkouts
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'update-index --ca
      +		test_all_match git read-tree -mu --no-sparse-checkout $MERGE_TREES &&
      +		test_all_match git status --porcelain=v2 &&
      +		test_cmp sparse-checkout/folder2/a sparse-index/folder2/a &&
     -+		test_cmp sparse-checkout/folder2/a full-checkout/folder2/a || return 1
     -+	done
     -+'
     ++		test_cmp sparse-checkout/folder2/a full-checkout/folder2/a
     ++
     ++	'
     ++done
      +
      +test_expect_success 'read-tree --merge with edit/edit conflicts in sparse directories' '
      +	init_repos &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'update-index --ca
      +	test_all_match test_must_fail git read-tree -mu rename-out-to-in update-folder1
      +'
      +
     -+test_expect_success 'read-tree --prefix outside sparse definition' '
     ++test_expect_success 'read-tree --prefix' '
      +	init_repos &&
      +
     -+	# Cannot read-tree --prefix with a single argument when files exist within
     -+	# prefix
     -+	test_all_match test_must_fail git read-tree --prefix=folder1/ -u update-folder1 &&
     ++	# If files differing between the index and target <commit-ish> exist
     ++	# inside the prefix, `read-tree --prefix` should fail
     ++	test_all_match test_must_fail git read-tree --prefix=deep/ deepest &&
     ++	test_all_match test_must_fail git read-tree --prefix=folder1/ update-folder1 &&
      +
     -+	test_all_match git read-tree --prefix=folder2/0 -u rename-base &&
     -+	test_path_is_missing sparse-checkout/folder2 &&
     -+	test_path_is_missing sparse-index/folder2 &&
     ++	# If no differing index entries exist matching the prefix,
     ++	# `read-tree --prefix` updates the index successfully
     ++	test_all_match git rm -rf deep/deeper1/deepest/ &&
     ++	test_all_match git read-tree --prefix=deep/deeper1/deepest -u deepest &&
     ++	test_all_match git status --porcelain=v2 &&
     ++
     ++	test_all_match git rm -rf --sparse folder1/ &&
     ++	test_all_match git read-tree --prefix=folder1/ -u update-folder1 &&
     ++	test_all_match git status --porcelain=v2 &&
      +
     -+	test_all_match git read-tree --reset -u HEAD &&
     -+	test_all_match git read-tree --prefix=folder2/0 -u --no-sparse-checkout rename-base &&
     -+	test_cmp sparse-checkout/folder2/0/a sparse-index/folder2/0/a &&
     -+	test_cmp sparse-checkout/folder2/0/a full-checkout/folder2/0/a
     ++	test_all_match git rm -rf --sparse folder2/0 &&
     ++	test_all_match git read-tree --prefix=folder2/0/ -u rename-out-to-out &&
     ++	test_all_match git status --porcelain=v2
      +'
      +
      +test_expect_success 'read-tree --merge with directory-file conflicts' '
 4:  cb7e0cf419c ! 5:  015618a9f29 read-tree: integrate with sparse index
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
      +	for MERGE_TREES in "update-folder2"
      +	do
      +		ensure_not_expanded read-tree -mu $MERGE_TREES &&
     -+		ensure_not_expanded reset --hard HEAD || return 1
     ++		ensure_not_expanded reset --hard || return 1
      +	done
      +'
      +
 5:  4f05fa70209 ! 6:  1a9365c3bc5 read-tree: narrow scope of index expansion for '--prefix'
     @@ Commit message
          If the prefix is in-cone, its sparse subdirectories (if any) will be
          traversed correctly without index expansion.
      
     +    The behavior of 'git read-tree' with prefixes 1) inside of cone, 2) equal to
     +    a sparse directory, and 3) inside a sparse directory are all tested as part
     +    of the 't/t1092-sparse-checkout-compatibility.sh' test 'read-tree --prefix',
     +    ensuring that the sparse index case works the way it did prior to this
     +    change as well as matching non-sparse index sparse-checkout.
     +
     +    Helped-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## builtin/read-tree.c ##
     @@ t/t1092-sparse-checkout-compatibility.sh
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is not expanded: read-tree' '
       	do
       		ensure_not_expanded read-tree -mu $MERGE_TREES &&
     - 		ensure_not_expanded reset --hard HEAD || return 1
     + 		ensure_not_expanded reset --hard || return 1
      -	done
      +	done &&
      +
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
       test_expect_success 'ls-files' '
      
       ## unpack-trees.c ##
     -@@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
     - 		setup_standard_excludes(o->dir);
     - 	}
     +@@ unpack-trees.c: static void populate_from_existing_patterns(struct unpack_trees_options *o,
     + 		o->pl = pl;
     + }
       
     -+	/*
     -+	 * If the prefix is equal to or contained within a sparse directory, the
     -+	 * index needs to be expanded to traverse with the specified prefix.
     -+	 */
     -+	if (o->prefix && o->src_index->sparse_index) {
     -+		int prefix_len = strlen(o->prefix);
     ++static void update_sparsity_for_prefix(const char *prefix,
     ++				       struct index_state *istate)
     ++{
     ++	int prefix_len = strlen(prefix);
     ++	struct strbuf ce_prefix = STRBUF_INIT;
      +
     -+		while (prefix_len > 0 && o->prefix[prefix_len - 1] == '/')
     -+			prefix_len--;
     ++	if (!istate->sparse_index)
     ++		return;
      +
     -+		if (prefix_len > 0) {
     -+			struct strbuf ce_prefix = STRBUF_INIT;
     -+			strbuf_grow(&ce_prefix, prefix_len + 1);
     -+			strbuf_add(&ce_prefix, o->prefix, prefix_len);
     -+			strbuf_addch(&ce_prefix, '/');
     ++	while (prefix_len > 0 && prefix[prefix_len - 1] == '/')
     ++		prefix_len--;
      +
     -+			/*
     -+			 * If the prefix is not inside the sparse cone, then the
     -+			 * index is explicitly expanded if it is found as a sparse
     -+			 * directory, or implicitly expanded (by 'index_name_pos')
     -+			 * if the path is inside a sparse directory.
     -+			 */
     -+			if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, o->src_index) &&
     -+			    index_name_pos(o->src_index, ce_prefix.buf, ce_prefix.len) >= 0)
     -+				ensure_full_index(o->src_index);
     ++	if (prefix_len <= 0)
     ++		BUG("Invalid prefix passed to update_sparsity_for_prefix");
      +
     -+			strbuf_release(&ce_prefix);
     -+		}
     -+	}
     ++	strbuf_grow(&ce_prefix, prefix_len + 1);
     ++	strbuf_add(&ce_prefix, prefix, prefix_len);
     ++	strbuf_addch(&ce_prefix, '/');
     ++
     ++	/*
     ++	 * If the prefix points to a sparse directory or a path inside a sparse
     ++	 * directory, the index should be expanded. This is accomplished in one
     ++	 * of two ways:
     ++	 * - if the prefix is inside a sparse directory, it will be expanded by
     ++	 *   the 'ensure_full_index(...)' call in 'index_name_pos(...)'.
     ++	 * - if the prefix matches an existing sparse directory entry,
     ++	 *   'index_name_pos(...)' will return its index position, triggering
     ++	 *   the 'ensure_full_index(...)' below.
     ++	 */
     ++	if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, istate) &&
     ++	    index_name_pos(istate, ce_prefix.buf, ce_prefix.len) >= 0)
     ++		ensure_full_index(istate);
     ++
     ++	strbuf_release(&ce_prefix);
     ++}
     + 
     + static int verify_absent(const struct cache_entry *,
     + 			 enum unpack_trees_error_types,
     +@@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
     + 		setup_standard_excludes(o->dir);
     + 	}
     + 
     ++	if (o->prefix)
     ++		update_sparsity_for_prefix(o->prefix, o->src_index);
      +
       	if (!core_apply_sparse_checkout || !o->update)
       		o->skip_sparse_checkout = 1;
 6:  94c2aad2f93 ! 7:  71bec3ddad1 read-tree: make two-way merge sparse-aware
     @@ Commit message
          This process allows sparse directories to be individually merged at the
          necessary depth *without* expanding a full index.
      
     +    The 't/t1092-sparse-checkout-compatibility.sh' test 'read-tree --merge with
     +    edit/edit conflicts in sparse directories' tests two-way merges with 1)
     +    changes inside sparse directories that do not conflict and 2) changes that
     +    do conflict (with the correct file(s) reported in the error message).
     +    Additionally, add two-way merge cases to 'sparse index is not expanded:
     +    read-tree' to confirm that the index is not expanded regardless of whether
     +    edit/edit conflicts are present in a sparse directory.
     +
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## builtin/read-tree.c ##
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
       
       	ensure_not_expanded checkout -b test-branch update-folder1 &&
      -	for MERGE_TREES in "update-folder2"
     -+	for MERGE_TREES in "update-folder2" \
     -+			   "base update-folder2"
     ++	for MERGE_TREES in "base update-folder2" \
     ++			   "base rename-base" \
     ++			   "update-folder2"
       	do
       		ensure_not_expanded read-tree -mu $MERGE_TREES &&
     - 		ensure_not_expanded reset --hard HEAD || return 1
     + 		ensure_not_expanded reset --hard || return 1
      
       ## unpack-trees.c ##
      @@ unpack-trees.c: static int is_sparse_directory_entry(struct cache_entry *ce,
 7:  c4080e99d6e ! 8:  6bc11325dd1 read-tree: make three-way merge sparse-aware
     @@ Commit message
          merge, the contents of each conflicted sparse directory are merged without
          referencing the index, avoiding sparse index expansion.
      
     +    As with two-way merge, the 't/t1092-sparse-checkout-compatibility.sh' test
     +    'read-tree --merge with edit/edit conflicts in sparse directories' confirms
     +    that three-way merges with edit/edit changes (both with and without
     +    conflicts) inside a sparse directory result in the correct index state or
     +    error message. To ensure the index is not unnecessarily expanded, add
     +    three-way merge cases to 'sparse index is not expanded: read-tree'.
     +
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## builtin/read-tree.c ##
     @@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is not expanded: read-tree' '
     + 	init_repos &&
       
       	ensure_not_expanded checkout -b test-branch update-folder1 &&
     - 	for MERGE_TREES in "update-folder2" \
     --			   "base update-folder2"
     +-	for MERGE_TREES in "base update-folder2" \
     ++	for MERGE_TREES in "base HEAD update-folder2" \
     ++			   "base HEAD rename-base" \
      +			   "base update-folder2" \
     -+			   "base HEAD update-folder2"
     + 			   "base rename-base" \
     + 			   "update-folder2"
       	do
     - 		ensure_not_expanded read-tree -mu $MERGE_TREES &&
     - 		ensure_not_expanded reset --hard HEAD || return 1
      
       ## unpack-trees.c ##
      @@ unpack-trees.c: int threeway_merge(const struct cache_entry * const *stages,
     @@ unpack-trees.c: int threeway_merge(const struct cache_entry * const *stages,
       
       	if (head) {
       		/* #5ALT, #15 */
     +@@ unpack-trees.c: int threeway_merge(const struct cache_entry * const *stages,
     + 
     + 	}
     + 
     +-	/* Below are "no merge" cases, which require that the index be
     +-	 * up-to-date to avoid the files getting overwritten with
     +-	 * conflict resolution files.
     +-	 */
     ++	/* Handle "no merge" cases (see t/t1000-read-tree-m-3way.sh) */
     + 	if (index) {
     ++		/*
     ++		 * If we've reached the "no merge" cases and we're merging
     ++		 * a sparse directory, we may have an "edit/edit" conflict that
     ++		 * can be resolved by individually merging directory contents.
     ++		 */
     ++		if (S_ISSPARSEDIR(index->ce_mode))
     ++			return merged_sparse_dir(stages, 4, o);
     ++
     ++		/*
     ++		 * If we're not merging a sparse directory, ensure the index is
     ++		 * up-to-date to avoid files getting overwritten with conflict
     ++		 * resolution files
     ++		 */
     + 		if (verify_uptodate(index, o))
     + 			return -1;
     + 	}

-- 
gitgitgadget
