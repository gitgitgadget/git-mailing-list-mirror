Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9E9C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbiEWNs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbiEWNsy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:48:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700E6562FB
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t13so2291605wrg.9
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LJwl1gkb+QqojdaEVsUpq11adP/9JZcpHnmOGg3Glv8=;
        b=Oy9ZyW9Xrgs9ZkHYrEqBM2q1uKnIEEfFOVz/b50cwjk8J8jrQ4UB96RrfNtspOU9J6
         cUw8GTvKkK+tyrybciXUDPtue7A5my2rp6woa4HeUJfCoSNqllIZN63+r8wsglokyw3V
         UaVWXqqOO2eRW9B++kuBQFqfa1dE1LdlZE4zIEQD7Ip0G1t6gr7oCKr4LpTXPVBIAXr8
         fJVEQVmhbCUKkCfqesuSTUkB+YL0YkWPM7eQoGr7BDWPY2TPomuTfKrIaXBr1T+Igkkj
         uGMytYS2dwptj8ukT/U6QyVHEEC1wq599ea3yrJmB7Td08G+JjzUBvKpJgWNYnIjzz+r
         2rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LJwl1gkb+QqojdaEVsUpq11adP/9JZcpHnmOGg3Glv8=;
        b=tn7oMS8VOhgwPm79Fy+dumhEQnt7aAwI/A7QiWM59eiRcZ0CgMbSb3Mvbx0c0LvbuN
         Ks7P9YSis3U6ysNPusf05HkyCjb8zfAwJCu4xl62NCcjavRPPBQNhri65DH4yiPbpDQs
         Y3eZLpQEvedWaCArBe9C4Z60cXIBe9QMGQKCrEpJCOweklIsustXgT9wRVcoIFAvnNsO
         7GXKt10WLWsNS+2TCt6Oe7urzovoKxk3jq1stVXqrQnO52uDl7vAoPu3crwRU+mmsTgO
         aVdcGA9p7MvU1s2/pI4HLD+dfD5JYFi2yWNJTNtB8n/zmzXDbyC6SqphklmHFKD0g/EE
         F1Zg==
X-Gm-Message-State: AOAM532MAn+/UqMAeOii3/eduvg6EFYb0h0v18KpV6gS0e+ujlhUuJJl
        IM5Gx9eYM0WQ7uSzWi3WTPjhZDlToGE=
X-Google-Smtp-Source: ABdhPJwb4PAZq57cfxlX2b96K7uQMJp+oyIy8gjSGqQOOA4N8V1SPkord2zlWu3PLiAkfig6T304uw==
X-Received: by 2002:a5d:5641:0:b0:20d:c15:1b33 with SMTP id j1-20020a5d5641000000b0020d0c151b33mr18560799wrw.66.1653313728224;
        Mon, 23 May 2022 06:48:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4-20020adfc6c4000000b0020d03b5c33dsm10195384wrh.46.2022.05.23.06.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:48:47 -0700 (PDT)
Message-Id: <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
References: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 13:48:36 +0000
Subject: [PATCH v3 00/10] Sparse index: integrate with sparse-checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on ds/sparse-colon-path.

This series integrates the 'git sparse-checkout' builtin with the sparse
index. This is the last integration that we fast-tracked into the
microsoft/git fork. After this, we have no work in flight that would
conflict with a Google Summer of Code project in this area.

The tricky part about the sparse-checkout builtin is that we actually do
need to expand the index when growing the sparse-checkout boundary. The
trick is to expand it only as far as we need it, and then ensure that we
collapse any removed directories before the command completes.

To do this, we introduce a concept of a "partially expanded" index. In fact,
we break the boolean sparse_index member into an enum with three states:

 * INDEX_EXPANDED (0): No sparse directories exist.

 * INDEX_COLLAPSED: Sparse directories may exist. Files outside the
   sparse-checkout cone are reduced to sparse directory entries whenever
   possible.

 * INDEX_PARTIALLY_SPARSE: Sparse directories may exist. Some file entries
   outside the sparse-checkout cone may exist. Running convert_to_sparse()
   may further reduce those files to sparse directory entries.

Most of the patches in this series focus on introducing this enum and
carefully converting previous uses of the boolean to use the enum. Some
additional work is required to refactor ensure_full_index() into a new
expand_index() method, as they are doing essentially the same thing, but
with different scopes.

The result is improved performance on the sparse-checkout builtin as
demonstrated in a new p2000-sparse-operations.sh performance test:


Test HEAD~1 HEAD
================

2000.24: git sparse-checkout ... (sparse-v3) 2.14(1.55+0.58) 1.57(1.03+0.53)
-26.6% 2000.25: git sparse-checkout ... (sparse-v4) 2.20(1.62+0.57)
1.58(0.98+0.59) -28.2%

The improvement here is less dramatic because the operation is dominated by
writing and deleting a lot of files in the worktree. A repeated no-op
operation such as git sparse-checkout set $SPARSE_CONE would show a greater
improvement, but is less interesting since it could gain that improvement
without satisfying the "hard" parts of this builtin.

I specifically chose how to update the tests in t1092 and p2000 to avoid
conflicts with Victoria's 'git stash' work.


Updates in v3
=============

 * expand_to_pattern_list() is renamed to expand_index().

 * The enum values are renamed to be less ambiguous.

 * Use a local variable to store the trace2 region label.

 * A tail-recursive method is converted to an iterative one.

 * Comments are added.

 * WRITE_MISSING_TREE_OK flags are removed as unnecessary.


Updates in v2
=============

 * Typo fixes.
 * Two patches are added to the start to (a) refactor existing sparse index
   content tests, and (b) add new sparse index content tests with additional
   scenarios.
 * Use NOT_MATCHED directly instead of implicitly allowing UNDECIDED when
   matching in cone mode.

Thanks, -Stolee

Derrick Stolee (10):
  t1092: refactor 'sparse-index contents' test
  t1092: stress test 'git sparse-checkout set'
  sparse-index: create expand_index()
  sparse-index: introduce partially-sparse indexes
  cache-tree: implement cache_tree_find_path()
  sparse-checkout: --no-sparse-index needs a full index
  sparse-index: partially expand directories
  sparse-index: complete partial expansion
  p2000: add test for 'git sparse-checkout [add|set]'
  sparse-checkout: integrate with sparse index

 builtin/sparse-checkout.c                |   8 +-
 cache-tree.c                             |  27 +++++
 cache-tree.h                             |   2 +
 cache.h                                  |  33 ++++--
 read-cache.c                             |   6 +-
 sparse-index.c                           | 132 ++++++++++++++++++++---
 sparse-index.h                           |  13 +++
 t/perf/p2000-sparse-operations.sh        |   1 +
 t/t1092-sparse-checkout-compatibility.sh |  95 ++++++++++++----
 unpack-trees.c                           |   4 +
 10 files changed, 275 insertions(+), 46 deletions(-)


base-commit: 124b05b23005437fa5fb91863bde2a8f5840e164
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1208%2Fderrickstolee%2Fsparse-index%2Fsparse-checkout-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1208/derrickstolee/sparse-index/sparse-checkout-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1208

Range-diff vs v2:

  1:  f2960747ed8 =  1:  f2960747ed8 t1092: refactor 'sparse-index contents' test
  2:  5030eeecf4f =  2:  5030eeecf4f t1092: stress test 'git sparse-checkout set'
  3:  d15338573e5 !  3:  44b0549a288 sparse-index: create expand_to_pattern_list()
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    sparse-index: create expand_to_pattern_list()
     +    sparse-index: create expand_index()
      
          This is the first change in a series to allow modifying the
          sparse-checkout pattern set without expanding a sparse index to a full
     @@ Commit message
      
          We already have logic in ensure_full_index() that expands the index
          entries, so we will use that as our base. Create a new method,
     -    expand_to_pattern_list(), which takes a pattern list, but for now mostly
     -    ignores it. The current implementation is only correct when the pattern
     -    list is NULL as that does the same as ensure_full_index(). In fact,
     -    ensure_full_index() is converted to a shim over
     -    expand_to_pattern_list().
     +    expand_index(), which takes a pattern list, but for now mostly ignores
     +    it. The current implementation is only correct when the pattern list is
     +    NULL as that does the same as ensure_full_index(). In fact,
     +    ensure_full_index() is converted to a shim over expand_index().
      
     -    A future update will actually implement expand_to_pattern_list() to its
     -    full capabilities. For now, it is created and documented.
     +    A future update will actually implement expand_index() to its full
     +    capabilities. For now, it is created and documented.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ sparse-index.c: static int add_path_to_index(const struct object_id *oid,
       }
       
      -void ensure_full_index(struct index_state *istate)
     -+void expand_to_pattern_list(struct index_state *istate,
     -+			    struct pattern_list *pl)
     ++void expand_index(struct index_state *istate, struct pattern_list *pl)
       {
       	int i;
       	struct index_state *full;
       	struct strbuf base = STRBUF_INIT;
     ++	const char *tr_region;
       
      +	/*
      +	 * If the index is already full, then keep it full. We will convert
     @@ sparse-index.c: static int add_path_to_index(const struct object_id *oid,
      +	 * This is used by test cases, but also helps to differentiate the
      +	 * two cases.
      +	 */
     -+	trace2_region_enter("index",
     -+			    pl ? "expand_to_pattern_list" : "ensure_full_index",
     -+			    istate->repo);
     ++	tr_region = pl ? "expand_index" : "ensure_full_index";
     ++	trace2_region_enter("index", tr_region, istate->repo);
       
       	/* initialize basics of new index */
       	full = xcalloc(1, sizeof(struct index_state));
     @@ sparse-index.c: void ensure_full_index(struct index_state *istate)
       	cache_tree_update(istate, 0);
       
      -	trace2_region_leave("index", "ensure_full_index", istate->repo);
     -+	trace2_region_leave("index",
     -+			    pl ? "expand_to_pattern_list" : "ensure_full_index",
     -+			    istate->repo);
     ++	trace2_region_leave("index", tr_region, istate->repo);
      +}
      +
      +void ensure_full_index(struct index_state *istate)
      +{
     -+	expand_to_pattern_list(istate, NULL);
     ++	expand_index(istate, NULL);
       }
       
       void ensure_correct_sparsity(struct index_state *istate)
     @@ sparse-index.h: void expand_to_path(struct index_state *istate,
      + * If the pattern list is NULL or does not use cone mode patterns, then the
      + * index is expanded to a full index.
      + */
     -+void expand_to_pattern_list(struct index_state *istate,
     -+			      struct pattern_list *pl);
     ++void expand_index(struct index_state *istate, struct pattern_list *pl);
      +
       #endif
  4:  269c206c331 !  4:  8a459d6c67d sparse-index: introduce partially-sparse indexes
     @@ Commit message
          For now, convert the single-bit member 'sparse_index' in 'struct
          index_state' to be a an 'enum sparse_index_mode' with three modes:
      
     -    * COMPLETELY_FULL (0): No sparse directories exist.
     +    * INDEX_EXPANDED (0): No sparse directories exist. This is always the
     +      case for repositories that do not use cone-mode sparse-checkout.
      
     -    * COMPLETELY_SPARSE (1): Sparse directories may exist. Files outside the
     +    * INDEX_COLLAPSED: Sparse directories may exist. Files outside the
            sparse-checkout cone are reduced to sparse directory entries whenever
            possible.
      
     -    * PARTIALLY_SPARSE (2): Sparse directories may exist. Some file entries
     -      outside the sparse-checkout cone may exist. Running
     +    * INDEX_PARTIALLY_SPARSE: Sparse directories may exist. Some file
     +      entries outside the sparse-checkout cone may exist. Running
            convert_to_sparse() may further reduce those files to sparse directory
            entries.
      
          The main reason to store this extra information is to allow
          convert_to_sparse() to short-circuit when the index is already in
     -    COMPLETELY_SPARSE mode but to actually do the necessary work when in
     -    PARTIALLY_SPARSE mode.
     +    INDEX_EXPANDED mode but to actually do the necessary work when in
     +    INDEX_PARTIALLY_SPARSE mode.
      
     -    The PARTIALLY_SPARSE mode will be used in an upcoming change.
     +    The INDEX_PARTIALLY_SPARSE mode will be used in an upcoming change.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ builtin/sparse-checkout.c: static void clean_tracked_sparse_directories(struct r
       	 * conflicted entries or submodules.
       	 */
      -	if (!r->index->sparse_index) {
     -+	if (r->index->sparse_index == COMPLETELY_FULL) {
     ++	if (r->index->sparse_index == INDEX_EXPANDED) {
       		/*
       		 * If something, such as a merge conflict or other concern,
       		 * prevents us from converting to a sparse index, then do
     @@ cache.h: struct untracked_cache;
       
      +enum sparse_index_mode {
      +	/*
     -+	 * COMPLETELY_FULL: there are no sparse directories
     -+	 * in the index at all.
     ++	 * There are no sparse directories in the index at all.
     ++	 *
     ++	 * Repositories that don't use cone-mode sparse-checkout will
     ++	 * always have their indexes in this mode.
      +	 */
     -+	COMPLETELY_FULL = 0,
     ++	INDEX_EXPANDED = 0,
      +
      +	/*
     -+	 * COLLAPSED: the index has already been collapsed to sparse
     -+	 * directories whereever possible.
     ++	 * The index has already been collapsed to sparse directories
     ++	 * whereever possible.
      +	 */
     -+	COLLAPSED = 1,
     ++	INDEX_COLLAPSED,
      +
      +	/*
     -+	 * PARTIALLY_SPARSE: the sparse directories that exist are
     -+	 * outside the sparse-checkout boundary, but it is possible
     -+	 * that some file entries could collapse to sparse directory
     -+	 * entries.
     ++	 * The sparse directories that exist are outside the
     ++	 * sparse-checkout boundary, but it is possible that some file
     ++	 * entries could collapse to sparse directory entries.
      +	 */
     -+	PARTIALLY_SPARSE = 2,
     ++	INDEX_PARTIALLY_SPARSE,
      +};
      +
       struct index_state {
     @@ read-cache.c: static const char *alternate_index_output;
       {
       	if (S_ISSPARSEDIR(ce->ce_mode))
      -		istate->sparse_index = 1;
     -+		istate->sparse_index = COLLAPSED;
     ++		istate->sparse_index = INDEX_COLLAPSED;
       
       	istate->cache[nr] = ce;
       	add_name_hash(istate, ce);
     @@ read-cache.c: static int read_index_extension(struct index_state *istate,
       	case CACHE_EXT_SPARSE_DIRECTORIES:
       		/* no content, only an indicator */
      -		istate->sparse_index = 1;
     -+		istate->sparse_index = COLLAPSED;
     ++		istate->sparse_index = INDEX_COLLAPSED;
       		break;
       	default:
       		if (*ext < 'A' || 'Z' < *ext)
     @@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struc
       {
       	int ret;
      -	int was_full = !istate->sparse_index;
     -+	int was_full = istate->sparse_index == COMPLETELY_FULL;
     ++	int was_full = istate->sparse_index == INDEX_EXPANDED;
       
       	ret = convert_to_sparse(istate, 0);
       
     @@ sparse-index.c: int convert_to_sparse(struct index_state *istate, int flags)
       	 * cannot be converted to sparse, do not convert.
       	 */
      -	if (istate->sparse_index || !istate->cache_nr ||
     -+	if (istate->sparse_index == COLLAPSED || !istate->cache_nr ||
     ++	if (istate->sparse_index == INDEX_COLLAPSED || !istate->cache_nr ||
       	    !is_sparse_index_allowed(istate, flags))
       		return 0;
       
     @@ sparse-index.c: int convert_to_sparse(struct index_state *istate, int flags)
       	FREE_AND_NULL(istate->fsmonitor_last_update);
       
      -	istate->sparse_index = 1;
     -+	istate->sparse_index = COLLAPSED;
     ++	istate->sparse_index = INDEX_COLLAPSED;
       	trace2_region_leave("index", "convert_to_sparse", istate->repo);
       	return 0;
       }
     -@@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
     +@@ sparse-index.c: void expand_index(struct index_state *istate, struct pattern_list *pl)
       	 * If the index is already full, then keep it full. We will convert
       	 * it to a sparse index on write, if possible.
       	 */
      -	if (!istate || !istate->sparse_index)
     -+	if (!istate || istate->sparse_index == COMPLETELY_FULL)
     ++	if (!istate || istate->sparse_index == INDEX_EXPANDED)
       		return;
       
       	/*
  5:  c977001c033 !  5:  9103584ed75 cache-tree: implement cache_tree_find_path()
     @@ Commit message
          path exists.
      
          The implementation is adapted from do_invalidate_path() which does a
     -    similar search but also modifies the nodes it finds along the way.
     +    similar search but also modifies the nodes it finds along the way. The
     +    method could be implemented simply using tail-recursion, but this while
     +    loop does the same thing.
      
          This new method is not currently used, but will be in an upcoming
          change.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## cache-tree.c ##
     @@ cache-tree.c: struct cache_tree_sub *cache_tree_sub(struct cache_tree *it, const
      +{
      +	const char *slash;
      +	int namelen;
     -+	struct cache_tree_sub *down;
     ++	struct cache_tree_sub it_sub = {
     ++		.cache_tree = it,
     ++	};
     ++	struct cache_tree_sub *down = &it_sub;
      +
     -+	if (!it)
     -+		return NULL;
     -+	slash = strchrnul(path, '/');
     -+	namelen = slash - path;
     -+	it->entry_count = -1;
     -+	if (!*slash) {
     -+		int pos;
     -+		pos = cache_tree_subtree_pos(it, path, namelen);
     -+		if (0 <= pos)
     -+			return it->down[pos]->cache_tree;
     -+		return NULL;
     ++	while (down) {
     ++		slash = strchrnul(path, '/');
     ++		namelen = slash - path;
     ++		down->cache_tree->entry_count = -1;
     ++		if (!*slash) {
     ++			int pos;
     ++			pos = cache_tree_subtree_pos(down->cache_tree, path, namelen);
     ++			if (0 <= pos)
     ++				return down->cache_tree->down[pos]->cache_tree;
     ++			return NULL;
     ++		}
     ++		down = find_subtree(it, path, namelen, 0);
     ++		path = slash + 1;
      +	}
     -+	down = find_subtree(it, path, namelen, 0);
     -+	if (down)
     -+		return cache_tree_find_path(down->cache_tree, slash + 1);
     ++
      +	return NULL;
      +}
      +
  6:  e42463de0d2 =  6:  75ecb579a9f sparse-checkout: --no-sparse-index needs a full index
  7:  346c56bf256 !  7:  310e59d9f0e sparse-index: partially expand directories
     @@ sparse-index.c: static int add_path_to_index(const struct object_id *oid,
      -	strbuf_addstr(base, path);
      +		/*
      +		 * Have we expanded to a point outside of the sparse-checkout?
     ++		 *
     ++		 * Artificially pad the path name with a slash "/" to
     ++		 * indicate it as a directory, and add an arbitrary file
     ++		 * name ("-") so we can consider base->buf as a file name
     ++		 * to match against the cone-mode patterns.
     ++		 *
     ++		 * If we compared just "path", then we would expand more
     ++		 * than we should. Since every file at root is always
     ++		 * included, we would expand every directory at root at
     ++		 * least one level deep instead of using sparse directory
     ++		 * entries.
      +		 */
      +		strbuf_addstr(base, path);
      +		strbuf_add(base, "/-", 2);
     @@ sparse-index.c: static int add_path_to_index(const struct object_id *oid,
       
       	strbuf_setlen(base, len);
       	return 0;
     -@@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
     - 	int i;
     +@@ sparse-index.c: void expand_index(struct index_state *istate, struct pattern_list *pl)
       	struct index_state *full;
       	struct strbuf base = STRBUF_INIT;
     + 	const char *tr_region;
      +	struct modify_index_context ctx;
       
       	/*
       	 * If the index is already full, then keep it full. We will convert
     -@@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
     +@@ sparse-index.c: void expand_index(struct index_state *istate, struct pattern_list *pl)
       	full->cache_nr = 0;
       	ALLOC_ARRAY(full->cache, full->cache_alloc);
       
     @@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
       	for (i = 0; i < istate->cache_nr; i++) {
       		struct cache_entry *ce = istate->cache[i];
       		struct tree *tree;
     -@@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
     +@@ sparse-index.c: void expand_index(struct index_state *istate, struct pattern_list *pl)
       		strbuf_add(&base, ce->name, strlen(ce->name));
       
       		read_tree_at(istate->repo, tree, &base, &ps,
  8:  ed640e3645b !  8:  b3cbfd3f136 sparse-index: complete partial expansion
     @@ Commit message
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## sparse-index.c ##
     -@@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
     +@@ sparse-index.c: void expand_index(struct index_state *istate, struct pattern_list *pl)
       	 * continue. A NULL pattern set indicates a full expansion to a
       	 * full index.
       	 */
     @@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
      +		 * need to expand to a full index since we cannot satisfy
      +		 * the current request as a sparse index.
      +		 */
     -+		if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
     ++		if (cache_tree_update(istate, 0))
      +			pl = NULL;
      +	}
       
       	if (!istate->repo)
       		istate->repo = the_repository;
     -@@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
     +@@ sparse-index.c: void expand_index(struct index_state *istate, struct pattern_list *pl)
       	full = xcalloc(1, sizeof(struct index_state));
       	memcpy(full, istate, sizeof(struct index_state));
       
     @@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
      +	 * are only modifying the list of sparse directories. This hinges
      +	 * on whether we have a non-NULL pattern list.
      +	 */
     -+	full->sparse_index = pl ? PARTIALLY_SPARSE : COMPLETELY_FULL;
     ++	full->sparse_index = pl ? INDEX_PARTIALLY_SPARSE : INDEX_EXPANDED;
      +
       	/* then change the necessary things */
      -	full->sparse_index = 0;
       	full->cache_alloc = (3 * istate->cache_alloc) / 2;
       	full->cache_nr = 0;
       	ALLOC_ARRAY(full->cache, full->cache_alloc);
     -@@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
     +@@ sparse-index.c: void expand_index(struct index_state *istate, struct pattern_list *pl)
       		struct cache_entry *ce = istate->cache[i];
       		struct tree *tree;
       		struct pathspec ps;
     @@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
       		if (!(ce->ce_flags & CE_SKIP_WORKTREE))
       			warning(_("index entry is a directory, but not sparse (%08x)"),
       				ce->ce_flags);
     -@@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
     +@@ sparse-index.c: void expand_index(struct index_state *istate, struct pattern_list *pl)
       	/* Copy back into original index. */
       	memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
       	memcpy(&istate->dir_hash, &full->dir_hash, sizeof(full->dir_hash));
      -	istate->sparse_index = 0;
     -+	istate->sparse_index = pl ? PARTIALLY_SPARSE : COMPLETELY_FULL;
     ++	istate->sparse_index = pl ? INDEX_PARTIALLY_SPARSE : INDEX_EXPANDED;
       	free(istate->cache);
       	istate->cache = full->cache;
       	istate->cache_nr = full->cache_nr;
     -@@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
     - 
     - 	/* Clear and recompute the cache-tree */
     - 	cache_tree_free(&istate->cache_tree);
     --	cache_tree_update(istate, 0);
     -+	cache_tree_update(istate, WRITE_TREE_MISSING_OK);
     - 
     - 	trace2_region_leave("index",
     - 			    pl ? "expand_to_pattern_list" : "ensure_full_index",
  9:  089ab086f58 =  9:  aa3bdcf705c p2000: add test for 'git sparse-checkout [add|set]'
 10:  ad9ed6973d5 ! 10:  11728619120 sparse-checkout: integrate with sparse index
     @@ unpack-trees.c: enum update_sparsity_result update_sparsity(struct unpack_trees_
       	}
       
      +	/* Expand sparse directories as needed */
     -+	expand_to_pattern_list(o->src_index, o->pl);
     ++	expand_index(o->src_index, o->pl);
      +
       	/* Set NEW_SKIP_WORKTREE on existing entries. */
       	mark_all_ce_unused(o->src_index);

-- 
gitgitgadget
