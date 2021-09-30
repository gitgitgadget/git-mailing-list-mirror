Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AC9C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA2761A60
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351973AbhI3Ow6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351915AbhI3Owu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 10:52:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9DEC06176C
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w29so10532472wra.8
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xk1RNAVfiBZq1Y54Z/enWBmL6YQ8PMyjPngQ4ycl5tE=;
        b=YaiuyXRFWyk4miWnH6NP4K4utGQitjpUsri7l2VItAqHuMHhkQYwiSbVIr+fY9LF9/
         w5J1gpxTQ+5F8sWV5lwmkJ08xL8WaD+LegHt5vEvU4doIjGqIW4hGk4O4nq8OtS+DrKc
         PFg4pnz8trfV6sCDGWXT5a2dIt4iBPCIg7aTuR8tMgcJMG5/73xscLwWW6ql6q1o9Vbl
         Ow42CR1wbDyErROjcZ4U3SQNDzKkK9s5tDGWNz9npuA1/ZXUH5A7e7jN0+TzS+aZsftp
         22+s7kLIK2w5QiU8t1IjWxUzNu/0/i3GCjbI/5gxbC17lyLf/pMCKOSMFJNkYH7aLrdK
         zE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xk1RNAVfiBZq1Y54Z/enWBmL6YQ8PMyjPngQ4ycl5tE=;
        b=3z1wsKK4Yj6sNvpW2pkanS8ppF55JNEyWo/DPZjc8yQLmhf26QEy26Qlr+eSd7UP9o
         Kf9lGJpqED9/P2OUWqtkC7pNVc0lx+mDmeRdl7+BxbWnIEerrWBm0z6Cu+EvSsISD28p
         0hTdpeNQ9xWmkyM22RCfypO9uM3MloEJtLHpUUnltCVK5JYNE3e4ZpcuL1pV+n8o/XRM
         qgZap1axcCBZhVsC0A6CwBQ5Mme0tQBqK0xRm6QqtutnQ80iYPrJAieTnDmoj8VdeLlR
         oi/zPDU+mXiRWGRxI0jDlufEiJhZ6cElZ6jlWolmK11g6VM8qQ9QU2T7gyq9JoqJ2eIc
         qQHw==
X-Gm-Message-State: AOAM531jQB3cBHxWJkpCzjklf1nCu+krKNr9rM7S42Yglz05UPSxsj0f
        CZhWP9M8m7KJ0xKdKqL88cJxclHT4Q0=
X-Google-Smtp-Source: ABdhPJx8QYkDg3jNSFRmjnpGFCbk5Oqw3iuTpxakmn2f2F/fukx+I6rIecSYbu9+DW1E+MbWehCmEw==
X-Received: by 2002:adf:e583:: with SMTP id l3mr6766346wrm.390.1633013466000;
        Thu, 30 Sep 2021 07:51:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8sm3309866wru.30.2021.09.30.07.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:51:05 -0700 (PDT)
Message-Id: <e919e6d3270889d14a32ff49c391ec484bab6836.1633013461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Sep 2021 14:50:59 +0000
Subject: [PATCH 5/7] reset: make sparse-aware (except --mixed)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

In order to accurately reconstruct the cache tree in `prime_cache_tree_rec`,
the function must determine whether the currently-processing directory in
the tree is sparse or not. If it is not sparse, the tree is parsed and
subtree recursively constructed. If it is sparse, no subtrees are added to
the tree and the entry count is set to 1 (representing the sparse directory
itself).

Signed-off-by: Victoria Dye <vdye@github.com>
---
 cache-tree.c                             | 44 +++++++++++++++++++++---
 cache.h                                  | 10 ++++++
 read-cache.c                             | 22 ++++++++----
 t/t1092-sparse-checkout-compatibility.sh | 15 ++++++--
 4 files changed, 78 insertions(+), 13 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 9be19c85b66..9021669d682 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -740,15 +740,29 @@ out:
 	return ret;
 }
 
+static void prime_cache_tree_sparse_dir(struct repository *r,
+					struct cache_tree *it,
+					struct tree *tree,
+					struct strbuf *tree_path)
+{
+
+	oidcpy(&it->oid, &tree->object.oid);
+	it->entry_count = 1;
+	return;
+}
+
 static void prime_cache_tree_rec(struct repository *r,
 				 struct cache_tree *it,
-				 struct tree *tree)
+				 struct tree *tree,
+				 struct strbuf *tree_path)
 {
+	struct strbuf subtree_path = STRBUF_INIT;
 	struct tree_desc desc;
 	struct name_entry entry;
 	int cnt;
 
 	oidcpy(&it->oid, &tree->object.oid);
+
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	cnt = 0;
 	while (tree_entry(&desc, &entry)) {
@@ -757,27 +771,49 @@ static void prime_cache_tree_rec(struct repository *r,
 		else {
 			struct cache_tree_sub *sub;
 			struct tree *subtree = lookup_tree(r, &entry.oid);
+
 			if (!subtree->object.parsed)
 				parse_tree(subtree);
 			sub = cache_tree_sub(it, entry.path);
 			sub->cache_tree = cache_tree();
-			prime_cache_tree_rec(r, sub->cache_tree, subtree);
+			strbuf_reset(&subtree_path);
+			strbuf_grow(&subtree_path, tree_path->len + entry.pathlen + 1);
+			strbuf_addbuf(&subtree_path, tree_path);
+			strbuf_add(&subtree_path, entry.path, entry.pathlen);
+			strbuf_addch(&subtree_path, '/');
+
+			/*
+			 * If a sparse index is in use, the directory being processed may be
+			 * sparse. To confirm that, we can check whether an entry with that
+			 * exact name exists in the index. If it does, the created subtree
+			 * should be sparse. Otherwise, cache tree expansion should continue
+			 * as normal.
+			 */
+			if (r->index->sparse_index &&
+			    index_entry_exists(r->index, subtree_path.buf, subtree_path.len))
+				prime_cache_tree_sparse_dir(r, sub->cache_tree, subtree, &subtree_path);
+			else
+				prime_cache_tree_rec(r, sub->cache_tree, subtree, &subtree_path);
 			cnt += sub->cache_tree->entry_count;
 		}
 	}
 	it->entry_count = cnt;
+
+	strbuf_release(&subtree_path);
 }
 
 void prime_cache_tree(struct repository *r,
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
index f5d4385c408..ea1166895f8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -551,7 +551,10 @@ int cache_name_stage_compare(const char *name1, int len1, int stage1, const char
 	return 0;
 }
 
-static int index_name_stage_pos(struct index_state *istate, const char *name, int namelen, int stage)
+static int index_name_stage_pos(struct index_state *istate,
+				const char *name, int namelen,
+				int stage,
+				int search_sparse)
 {
 	int first, last;
 
@@ -570,7 +573,7 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
 		first = next+1;
 	}
 
-	if (istate->sparse_index &&
+	if (search_sparse && istate->sparse_index &&
 	    first > 0) {
 		/* Note: first <= istate->cache_nr */
 		struct cache_entry *ce = istate->cache[first - 1];
@@ -586,7 +589,7 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
 		    ce_namelen(ce) < namelen &&
 		    !strncmp(name, ce->name, ce_namelen(ce))) {
 			ensure_full_index(istate);
-			return index_name_stage_pos(istate, name, namelen, stage);
+			return index_name_stage_pos(istate, name, namelen, stage, search_sparse);
 		}
 	}
 
@@ -595,7 +598,12 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
 
 int index_name_pos(struct index_state *istate, const char *name, int namelen)
 {
-	return index_name_stage_pos(istate, name, namelen, 0);
+	return index_name_stage_pos(istate, name, namelen, 0, 1);
+}
+
+int index_entry_exists(struct index_state *istate, const char *name, int namelen)
+{
+	return index_name_stage_pos(istate, name, namelen, 0, 0) >= 0;
 }
 
 int remove_index_entry_at(struct index_state *istate, int pos)
@@ -1222,7 +1230,7 @@ static int has_dir_name(struct index_state *istate,
 			 */
 		}
 
-		pos = index_name_stage_pos(istate, name, len, stage);
+		pos = index_name_stage_pos(istate, name, len, stage, 1);
 		if (pos >= 0) {
 			/*
 			 * Found one, but not so fast.  This could
@@ -1322,7 +1330,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
 		pos = index_pos_to_insert_pos(istate->cache_nr);
 	else
-		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
+		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), 1);
 
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
@@ -1357,7 +1365,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 		if (!ok_to_replace)
 			return error(_("'%s' appears as both a file and as a directory"),
 				     ce->name);
-		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
+		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), 1);
 		pos = -pos-1;
 	}
 	return pos + 1;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index e36fb18098d..0b6ff0de17d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -786,9 +786,9 @@ test_expect_success 'sparse-index is not expanded' '
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
@@ -798,6 +798,17 @@ test_expect_success 'sparse-index is not expanded' '
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

