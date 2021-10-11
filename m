Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34FFC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0964D60F21
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbhJKUcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbhJKUc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:32:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0158BC061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t2so59908770wrb.8
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3eu00jf4e+X22klEq0CYPgJ/CXgNIwvgJzeD6NoWL6E=;
        b=Gqrcy6rRgqmg4PVg5f74/OBvuAcq3quTWiRXLY6sXds7/CGQMU3vShCgjdFK+UXq3j
         WkataTCKISzK5TahAe62Hh6e/FyyqEKWekHLgVD5gegPWpXeO/XhX+3hPhZg1Q2IfN1D
         aTc1wXRvMRi3+DzMkpR2PQeV92cdKkUMI9SzzM6CGBomJdtnQfdITu9NeKDC+LMOSCgR
         4gF8O10yCdt1y8HQkTKhctribioVBY27vI6AXOUDkvA1FPL+jTiW4KIk2jkDOh1Fp9Kc
         Q7f4tPawne8IDKVyagIahRR9jrHkoktIthuyL3f3GPTsy+3t3eSekQGNNYkxhFMKcGLg
         QqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3eu00jf4e+X22klEq0CYPgJ/CXgNIwvgJzeD6NoWL6E=;
        b=U4hGO0xF5nDHz+EpgFixtyxtIDkeEv16MCLbkSCIBlwXrbm39x+OhQ5TzxPXa8O+lN
         eE36DIm/NaoZ7DkcbLITdDnuCy+jhJ+yslo+Pk7WnDJMX/kJeffyIkA4o6tI+JUo26rm
         QITLY2m+YX4dgQp06SbKlNJosiEd112V79xO+Zl3Gg7jHLPZ+gY0a1IJAr19Plqj8WyI
         m+4SMGv+OxX+m2dAqdp1ad1MZWEIPl/SvVfwYLUnLUoq+EVvrZyY1SWG89v0/WMH24B5
         X+7d49eJRJwZODSgmUDIP3YUP/BKLN8lF5ECofRrAUJ0NstY8w9dvFpm1OQxmXZKuQTC
         VTyw==
X-Gm-Message-State: AOAM531/qFPOFqxPZ+nhpybqhznde0WjweCXtwhv85+0HFKQscTgO9a4
        dcFOPUsROrBYP3s//cKrv1Im5ITMbPA=
X-Google-Smtp-Source: ABdhPJwRmLeVrxsuAXNHsW89AaWvOYR0fKc1+hd6h8KR41aC8do8iahnrbq1TEMtaOJRT+4wG4pqpw==
X-Received: by 2002:a1c:9ac4:: with SMTP id c187mr1285918wme.18.1633984227621;
        Mon, 11 Oct 2021 13:30:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c14sm8677935wrd.50.2021.10.11.13.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 13:30:27 -0700 (PDT)
Message-Id: <b0d437207e774d297848ba90e1726cae6614b255.1633984222.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
References: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Oct 2021 20:30:20 +0000
Subject: [PATCH v4 6/8] reset: make sparse-aware (except --mixed)
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
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Remove `ensure_full_index` guard on `prime_cache_tree` and update
`prime_cache_tree_rec` to correctly reconstruct sparse directory entries in
the cache tree. While processing a tree's entries, `prime_cache_tree_rec`
must determine whether a directory entry is sparse or not by searching for
it in the index (*without* expanding the index). If a matching sparse
directory index entry is found, no subtrees are added to the cache tree
entry and the entry count is set to 1 (representing the sparse directory
itself). Otherwise, the tree is assumed to not be sparse and its subtrees
are recursively added to the cache tree.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 cache-tree.c                             | 47 ++++++++++++++++++++++--
 cache.h                                  | 10 +++++
 read-cache.c                             | 27 ++++++++++----
 t/t1092-sparse-checkout-compatibility.sh | 15 +++++++-
 4 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 9be19c85b66..2866101052c 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -740,15 +740,26 @@ out:
 	return ret;
 }
 
+static void prime_cache_tree_sparse_dir(struct cache_tree *it,
+					struct tree *tree)
+{
+
+	oidcpy(&it->oid, &tree->object.oid);
+	it->entry_count = 1;
+}
+
 static void prime_cache_tree_rec(struct repository *r,
 				 struct cache_tree *it,
-				 struct tree *tree)
+				 struct tree *tree,
+				 struct strbuf *tree_path)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
 	int cnt;
+	int base_path_len = tree_path->len;
 
 	oidcpy(&it->oid, &tree->object.oid);
+
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	cnt = 0;
 	while (tree_entry(&desc, &entry)) {
@@ -757,14 +768,40 @@ static void prime_cache_tree_rec(struct repository *r,
 		else {
 			struct cache_tree_sub *sub;
 			struct tree *subtree = lookup_tree(r, &entry.oid);
+
 			if (!subtree->object.parsed)
 				parse_tree(subtree);
 			sub = cache_tree_sub(it, entry.path);
 			sub->cache_tree = cache_tree();
-			prime_cache_tree_rec(r, sub->cache_tree, subtree);
+
+			/*
+			 * Recursively-constructed subtree path is only needed when working
+			 * in a sparse index (where it's used to determine whether the
+			 * subtree is a sparse directory in the index).
+			 */
+			if (r->index->sparse_index) {
+				strbuf_setlen(tree_path, base_path_len);
+				strbuf_grow(tree_path, base_path_len + entry.pathlen + 1);
+				strbuf_add(tree_path, entry.path, entry.pathlen);
+				strbuf_addch(tree_path, '/');
+			}
+
+			/*
+			 * If a sparse index is in use, the directory being processed may be
+			 * sparse. To confirm that, we can check whether an entry with that
+			 * exact name exists in the index. If it does, the created subtree
+			 * should be sparse. Otherwise, cache tree expansion should continue
+			 * as normal.
+			 */
+			if (r->index->sparse_index &&
+			    index_entry_exists(r->index, tree_path->buf, tree_path->len))
+				prime_cache_tree_sparse_dir(sub->cache_tree, subtree);
+			else
+				prime_cache_tree_rec(r, sub->cache_tree, subtree, tree_path);
 			cnt += sub->cache_tree->entry_count;
 		}
 	}
+
 	it->entry_count = cnt;
 }
 
@@ -772,12 +809,14 @@ void prime_cache_tree(struct repository *r,
 		      struct index_state *istate,
 		      struct tree *tree)
 {
+	struct strbuf tree_path = STRBUF_INIT;
+
 	trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);
 	cache_tree_free(&istate->cache_tree);
 	istate->cache_tree = cache_tree();
 
-	ensure_full_index(istate);
-	prime_cache_tree_rec(r, istate->cache_tree, tree);
+	prime_cache_tree_rec(r, istate->cache_tree, tree, &tree_path);
+	strbuf_release(&tree_path);
 	istate->cache_changed |= CACHE_TREE_CHANGED;
 	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
 }
diff --git a/cache.h b/cache.h
index f6295f3b048..1d3e4665562 100644
--- a/cache.h
+++ b/cache.h
@@ -816,6 +816,16 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
  */
 int index_name_pos(struct index_state *, const char *name, int namelen);
 
+/*
+ * Determines whether an entry with the given name exists within the
+ * given index. The return value is 1 if an exact match is found, otherwise
+ * it is 0. Note that, unlike index_name_pos, this function does not expand
+ * the index if it is sparse. If an item exists within the full index but it
+ * is contained within a sparse directory (and not in the sparse index), 0 is
+ * returned.
+ */
+int index_entry_exists(struct index_state *, const char *name, int namelen);
+
 /*
  * Some functions return the negative complement of an insert position when a
  * precise match was not found but a position was found where the entry would
diff --git a/read-cache.c b/read-cache.c
index f5d4385c408..c079ece981a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -68,6 +68,11 @@
  */
 #define CACHE_ENTRY_PATH_LENGTH 80
 
+enum index_search_mode {
+	NO_EXPAND_SPARSE = 0,
+	EXPAND_SPARSE = 1
+};
+
 static inline struct cache_entry *mem_pool__ce_alloc(struct mem_pool *mem_pool, size_t len)
 {
 	struct cache_entry *ce;
@@ -551,7 +556,10 @@ int cache_name_stage_compare(const char *name1, int len1, int stage1, const char
 	return 0;
 }
 
-static int index_name_stage_pos(struct index_state *istate, const char *name, int namelen, int stage)
+static int index_name_stage_pos(struct index_state *istate,
+				const char *name, int namelen,
+				int stage,
+				enum index_search_mode search_mode)
 {
 	int first, last;
 
@@ -570,7 +578,7 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
 		first = next+1;
 	}
 
-	if (istate->sparse_index &&
+	if (search_mode == EXPAND_SPARSE && istate->sparse_index &&
 	    first > 0) {
 		/* Note: first <= istate->cache_nr */
 		struct cache_entry *ce = istate->cache[first - 1];
@@ -586,7 +594,7 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
 		    ce_namelen(ce) < namelen &&
 		    !strncmp(name, ce->name, ce_namelen(ce))) {
 			ensure_full_index(istate);
-			return index_name_stage_pos(istate, name, namelen, stage);
+			return index_name_stage_pos(istate, name, namelen, stage, search_mode);
 		}
 	}
 
@@ -595,7 +603,12 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
 
 int index_name_pos(struct index_state *istate, const char *name, int namelen)
 {
-	return index_name_stage_pos(istate, name, namelen, 0);
+	return index_name_stage_pos(istate, name, namelen, 0, EXPAND_SPARSE);
+}
+
+int index_entry_exists(struct index_state *istate, const char *name, int namelen)
+{
+	return index_name_stage_pos(istate, name, namelen, 0, NO_EXPAND_SPARSE) >= 0;
 }
 
 int remove_index_entry_at(struct index_state *istate, int pos)
@@ -1222,7 +1235,7 @@ static int has_dir_name(struct index_state *istate,
 			 */
 		}
 
-		pos = index_name_stage_pos(istate, name, len, stage);
+		pos = index_name_stage_pos(istate, name, len, stage, EXPAND_SPARSE);
 		if (pos >= 0) {
 			/*
 			 * Found one, but not so fast.  This could
@@ -1322,7 +1335,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
 		pos = index_pos_to_insert_pos(istate->cache_nr);
 	else
-		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
+		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), EXPAND_SPARSE);
 
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
@@ -1357,7 +1370,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 		if (!ok_to_replace)
 			return error(_("'%s' appears as both a file and as a directory"),
 				     ce->name);
-		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
+		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), EXPAND_SPARSE);
 		pos = -pos-1;
 	}
 	return pos + 1;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 535686a2954..78476de18ea 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -760,9 +760,9 @@ test_expect_success 'sparse-index is not expanded' '
 	ensure_not_expanded checkout - &&
 	ensure_not_expanded switch rename-out-to-out &&
 	ensure_not_expanded switch - &&
-	git -C sparse-index reset --hard &&
+	ensure_not_expanded reset --hard &&
 	ensure_not_expanded checkout rename-out-to-out -- deep/deeper1 &&
-	git -C sparse-index reset --hard &&
+	ensure_not_expanded reset --hard &&
 	ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1 &&
 
 	echo >>sparse-index/README.md &&
@@ -772,6 +772,17 @@ test_expect_success 'sparse-index is not expanded' '
 	echo >>sparse-index/untracked.txt &&
 	ensure_not_expanded add . &&
 
+	for ref in update-deep update-folder1 update-folder2 update-deep
+	do
+		echo >>sparse-index/README.md &&
+		ensure_not_expanded reset --hard $ref || return 1
+	done &&
+
+	ensure_not_expanded reset --hard update-deep &&
+	ensure_not_expanded reset --keep base &&
+	ensure_not_expanded reset --merge update-deep &&
+	ensure_not_expanded reset --hard &&
+
 	ensure_not_expanded checkout -f update-deep &&
 	test_config -C sparse-index pull.twohead ort &&
 	(
-- 
gitgitgadget

