Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16A0E1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbeKJPdX (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34973 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbeKJPdX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so3388384ljb.2
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LQ5Nw7bsTCRM8YIiL57S16qk+pC8efXpC9u8QUtnnAg=;
        b=gayA9JA13MmOg3Jjzcx7tKFprXT5jhIdno3yocS5QP0LAncvahNHfhYnGG3bCahCOr
         kwvJN+MLvsmYfABbUBpNEXgXMoMhCYuIKhOn2gMdO8xKWp2tsg61cad0bhs4VATKHADw
         N5izAkZ2GmwAUqsRBMMcGLybhMVMnFpSNk9AwkJJCqK77cEMdkx+/ioFWb9IvgbpZ1Cl
         qkZItDWLG+9RA7DR/Bch+lCs/cd5eOVQDbrbS9vsVxLud6uzLL3juoEo35pEHZeh5aCL
         67MgVb0XMaWerxHN3rrj6w6K0VSMRAZm9kPiYc9K8Du0x9d4hVXwQZQOezFsos7S218k
         PzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQ5Nw7bsTCRM8YIiL57S16qk+pC8efXpC9u8QUtnnAg=;
        b=N+2HeKODlHCx3Pahhu++r9Uuld0PmZtz551y8p27Hqln+jKPF7suALHbZrEnmum2N4
         vX3R48sjN2LNT4AVpaAgeTeQdSUIinjenqWxOj18TQeCyJaxZ61iN/C5H0R8oV4TosMP
         HTR0pexWdiL0mjnHPVSf3p439XSnLomfP4Eo2rDRD2FXgmUgjL4A9d1F7Zf/XFfGK//N
         Yk6rbeu89mWaX+gGo05SN+l6tB51K7ZY0GIZwraFx7crmUdGQuQCQEfcd41HiYrGP+2L
         qmli4bmV4+lkEeCxpsJVO2zTAgpL7lyWeI18vz1DnyF/uqwFXtFSSiGLx4wujioR4miS
         UrTg==
X-Gm-Message-State: AGRZ1gJfwPn2ZI1IWAQ7dA0xr96asmeMEBUZUYgQjGrhgV+OwMcEG35J
        fgt6NrTLJBVuEI0A8eJjqEksiVA3
X-Google-Smtp-Source: AJdET5eFbC/tOCKVw7cw/R6mvGfZ2cO1I5EtsAe7HVWHgCkY8IXYS8iF7/8d24/498msxz4xdGxY4Q==
X-Received: by 2002:a2e:6c04:: with SMTP id h4-v6mr4232808ljc.92.1541828974275;
        Fri, 09 Nov 2018 21:49:34 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:33 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 14/22] cache-tree.c: remove the_repository references
Date:   Sat, 10 Nov 2018 06:49:02 +0100
Message-Id: <20181110054910.10568-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This case is more interesting than other boring "remove the_repo"
commits because while we need access to the object database, we cannot
simply use r->index because unpack-trees.c can operate on a temporary
index, not $GIT_DIR/index. Ideally we should be able to pass an object
database to lookup_tree() but that ship has sailed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/read-tree.c |  4 +++-
 builtin/rebase.c    |  2 +-
 builtin/reset.c     |  2 +-
 cache-tree.c        | 26 +++++++++++++++-----------
 cache-tree.h        |  4 ++--
 read-cache.c        |  2 +-
 sequencer.c         |  2 +-
 unpack-trees.c      |  2 +-
 8 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index fbbc98e516..c05c12d034 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -255,7 +255,9 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	 * what came from the tree.
 	 */
 	if (nr_trees == 1 && !opts.prefix)
-		prime_cache_tree(&the_index, trees[0]);
+		prime_cache_tree(the_repository,
+				 the_repository->index,
+				 trees[0]);
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die("unable to write new index file");
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b9eb958454..d9bedecf86 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -582,7 +582,7 @@ static int reset_head(struct object_id *oid, const char *action,
 	}
 
 	tree = parse_tree_indirect(oid);
-	prime_cache_tree(the_repository->index, tree);
+	prime_cache_tree(the_repository, the_repository->index, tree);
 
 	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0)
 		ret = error(_("could not write index"));
diff --git a/builtin/reset.c b/builtin/reset.c
index 5b4bbb0fb5..161b5e0cae 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -93,7 +93,7 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 
 	if (reset_type == MIXED || reset_type == HARD) {
 		tree = parse_tree_indirect(oid);
-		prime_cache_tree(&the_index, tree);
+		prime_cache_tree(the_repository, the_repository->index, tree);
 	}
 
 	ret = 0;
diff --git a/cache-tree.c b/cache-tree.c
index 9d454d24bc..190c6e5aa6 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -659,7 +659,9 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 	return ret;
 }
 
-static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
+static void prime_cache_tree_rec(struct repository *r,
+				 struct cache_tree *it,
+				 struct tree *tree)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -673,24 +675,25 @@ static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 			cnt++;
 		else {
 			struct cache_tree_sub *sub;
-			struct tree *subtree = lookup_tree(the_repository,
-							   entry.oid);
+			struct tree *subtree = lookup_tree(r, entry.oid);
 			if (!subtree->object.parsed)
 				parse_tree(subtree);
 			sub = cache_tree_sub(it, entry.path);
 			sub->cache_tree = cache_tree();
-			prime_cache_tree_rec(sub->cache_tree, subtree);
+			prime_cache_tree_rec(r, sub->cache_tree, subtree);
 			cnt += sub->cache_tree->entry_count;
 		}
 	}
 	it->entry_count = cnt;
 }
 
-void prime_cache_tree(struct index_state *istate, struct tree *tree)
+void prime_cache_tree(struct repository *r,
+		      struct index_state *istate,
+		      struct tree *tree)
 {
 	cache_tree_free(&istate->cache_tree);
 	istate->cache_tree = cache_tree();
-	prime_cache_tree_rec(istate->cache_tree, tree);
+	prime_cache_tree_rec(r, istate->cache_tree, tree);
 	istate->cache_changed |= CACHE_TREE_CHANGED;
 }
 
@@ -726,7 +729,8 @@ int cache_tree_matches_traversal(struct cache_tree *root,
 	return 0;
 }
 
-static void verify_one(struct index_state *istate,
+static void verify_one(struct repository *r,
+		       struct index_state *istate,
 		       struct cache_tree *it,
 		       struct strbuf *path)
 {
@@ -736,13 +740,13 @@ static void verify_one(struct index_state *istate,
 
 	for (i = 0; i < it->subtree_nr; i++) {
 		strbuf_addf(path, "%s/", it->down[i]->name);
-		verify_one(istate, it->down[i]->cache_tree, path);
+		verify_one(r, istate, it->down[i]->cache_tree, path);
 		strbuf_setlen(path, len);
 	}
 
 	if (it->entry_count < 0 ||
 	    /* no verification on tests (t7003) that replace trees */
-	    lookup_replace_object(the_repository, &it->oid) != &it->oid)
+	    lookup_replace_object(r, &it->oid) != &it->oid)
 		return;
 
 	if (path->len) {
@@ -793,12 +797,12 @@ static void verify_one(struct index_state *istate,
 	strbuf_release(&tree_buf);
 }
 
-void cache_tree_verify(struct index_state *istate)
+void cache_tree_verify(struct repository *r, struct index_state *istate)
 {
 	struct strbuf path = STRBUF_INIT;
 
 	if (!istate->cache_tree)
 		return;
-	verify_one(istate, istate->cache_tree, &path);
+	verify_one(r, istate, istate->cache_tree, &path);
 	strbuf_release(&path);
 }
diff --git a/cache-tree.h b/cache-tree.h
index 0ab6784ffe..326209198b 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -32,7 +32,7 @@ struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
 int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct index_state *, int);
-void cache_tree_verify(struct index_state *);
+void cache_tree_verify(struct repository *, struct index_state *);
 
 /* bitmasks to write_cache_as_tree flags */
 #define WRITE_TREE_MISSING_OK 1
@@ -47,7 +47,7 @@ void cache_tree_verify(struct index_state *);
 #define WRITE_TREE_PREFIX_ERROR (-3)
 
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix);
-void prime_cache_tree(struct index_state *, struct tree *);
+void prime_cache_tree(struct repository *, struct index_state *, struct tree *);
 
 int cache_tree_matches_traversal(struct cache_tree *, struct name_entry *ent, struct traverse_info *info);
 
diff --git a/read-cache.c b/read-cache.c
index f3a848d61c..69944fc933 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3126,7 +3126,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	struct split_index *si = istate->split_index;
 
 	if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
-		cache_tree_verify(istate);
+		cache_tree_verify(the_repository, istate);
 
 	if ((flags & SKIP_IF_UNCHANGED) && !istate->cache_changed) {
 		if (flags & COMMIT_LOCK)
diff --git a/sequencer.c b/sequencer.c
index 111cb747d6..726f727644 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2991,7 +2991,7 @@ static int do_reset(struct repository *r,
 	}
 
 	tree = parse_tree_indirect(&oid);
-	prime_cache_tree(r->index, tree);
+	prime_cache_tree(r, r->index, tree);
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0)
 		ret = error(_("could not write index"));
diff --git a/unpack-trees.c b/unpack-trees.c
index 7570df481b..6d53cbfc86 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1630,7 +1630,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		move_index_extensions(&o->result, o->src_index);
 		if (!ret) {
 			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
-				cache_tree_verify(&o->result);
+				cache_tree_verify(the_repository, &o->result);
 			if (!o->result.cache_tree)
 				o->result.cache_tree = cache_tree();
 			if (!cache_tree_fully_valid(o->result.cache_tree))
-- 
2.19.1.1231.g84aef82467

