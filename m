Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49305C43217
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 353B36138F
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhJENW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 09:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbhJENWx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 09:22:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67D9C061766
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 06:21:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so3041972wmq.1
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E8peHUGeSN0CW7vLeX8jUKgpN5LLCbqWtr/BN26N/aU=;
        b=bWFiZLWCk8KlM9TxPoMxsGpeTpCICKBUflc9B3/kWOgKiFvEuhgsG1iD8ez+7stGTu
         SRhgJXIR+SRd2Dr0ZU976DfKhGmw3LxJlP3wgOSvmIVWxpfftvF5Ses/9zjztMLNLGG9
         kdeWlD9ENdJpWlgXJ0ldN5+IxUNUWsNm0stjYO/AUvMyUsMR59QJQK2fkYTe/R+uaQ20
         dEz1fPQ3BhPtF4Dov2G04Hz7CPEZN3jH+o5gJ0SM5ia1DRxpwKCSV71mnHXMYSMcD05i
         CN6M+165ZxJkLPPF0DNqwAl0iNkP+LI9SVyHL8jgDIk1kjd3wc8azIu/+FqKS3jly+af
         +GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E8peHUGeSN0CW7vLeX8jUKgpN5LLCbqWtr/BN26N/aU=;
        b=y69MLpYk0Xa7OCjxiR2RrDCmVOZRKUOpKELqwSREry4OFHiRbrKEmwt/2wYfo64CQr
         UW8Y601zB09x6RxynC4bXj2DmBUpEpSGqN7k+RuKfckoJ9thXd2RQzpgwgSFtGdJB41D
         yxOApD2Auc+W0BgoAH4hwduS1om6+YJ3GLiPnVDkP8Jpx146cyPuZXU45kxhi3XGdBC2
         K5eDIEzmoYptNrCxgOSmZmPWrg4y0u+oFch8+ojkm3GsU1e/3qnGfWrPttr94J9yocjC
         YYbfmOdt6bf2n/Tld51dk9nnXIL+F9ALU2Rv6b5BEJmYDTF5YNmNjxHuqHXynmJkuBKl
         Vlsg==
X-Gm-Message-State: AOAM531qUPEHknqwXzC8iq64pDwFZqDFAYeIV5+CM3OYqQg76Jl0eHYN
        fs2n9/OCD1b//Lt6C7pcCk0RsJI7wfI=
X-Google-Smtp-Source: ABdhPJzi8UKM3X9AFYaqX7wHlYY5XGDFsN704kl7rbWwMYa4v9P3MPGU0fTHOVgaKponvfggmQ37tg==
X-Received: by 2002:a1c:a941:: with SMTP id s62mr3396791wme.55.1633440061335;
        Tue, 05 Oct 2021 06:21:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm5166217wrm.54.2021.10.05.06.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:21:01 -0700 (PDT)
Message-Id: <78cd85d8dcc790251ce8235e649902cf6adf091a.1633440057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Oct 2021 13:20:55 +0000
Subject: [PATCH v2 5/7] reset: make sparse-aware (except --mixed)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
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
index f0723a6ac97..e301ef5633a 100755
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

