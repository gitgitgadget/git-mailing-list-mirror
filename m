Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1731F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeICWb7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46597 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbeICWb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so1048451ljj.13
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=orBY/dPbhZMkpPxDDmE1x8L76X39WD4UcjmFJqw1Vhw=;
        b=fRunh0iA2uyhDlOIKFtwMtMIt0j1LjPQhuFi5g2p9c303ujJiKJU+leAMlKyUaULSG
         houxaaLwVrvhzm0tL46OY+c5x5Lmu2BZ/tsZKZfgserKbVljCywIp94E4iFmXtmQPdSb
         Yw5xSdM6bA1uIvnW4p2GIspy6lyLnDOEFtbKudPyW7xpLmNfCzFMnxp+nP8+bTgRHf/2
         acHD6X6PR+krUF/prqQZTHmD3PAtIy4ibHY2BQJPy3PxDLgLU+ctY3LuDYg1Y04Dbj5r
         m4OCC+3LXR/0MPoKozKQirItI/Iw/uBOFQ2w0hGSilQfuwaRF8HdUzalfMRKgbq260p6
         hXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=orBY/dPbhZMkpPxDDmE1x8L76X39WD4UcjmFJqw1Vhw=;
        b=JopF6lgFYm9qQK+UJyA8lbZ9ReGc0BzxFDrY/ixYSzkj3xHkgt0ZOYsmgqx8acmXVg
         OSn93L+ymWjVZjvN/n4cXSblrhIy7RBH8pDNFeqtefYQI4BAybghrquOPnZT7vBuwNYE
         QhUwqLe1AM4+YhbPL8WJx10MIWaIAUn/qxH/i9EV5/LG8jG9vkLgjh4f8bPI1nqjm6jM
         RbjkovavL0shoMbQvPHtPM0jJWqPGaziDQnPz/sQFPqHEkIaGfvjunped+8nNdgPISCC
         PEeTLGm0DF74wYMwcb4YcxrZnCglKnJkSI3z01MztUBqtoluxRL69JdQOps3macUkjJ9
         z5mg==
X-Gm-Message-State: APzg51B9TrodF99NHa13SJdBsnvkOu1H/3vvrRLmmgDfzyfSFfYFKfDQ
        ufiKgCaHny3AyGZbbwehq7A=
X-Google-Smtp-Source: ANB0Vda60+KIbX1ySgBIOb955VxWbNwlW4GnxMb/OVbWVzkfqUpmso7Rv1AIpFQ43zNqRAy6kFhwXQ==
X-Received: by 2002:a2e:4557:: with SMTP id s84-v6mr17844719lja.47.1535998237592;
        Mon, 03 Sep 2018 11:10:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 23/24] revision.c: reduce implicit dependency the_repository
Date:   Mon,  3 Sep 2018 20:09:31 +0200
Message-Id: <20180903180932.32260-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 list-objects.c |  8 +++++---
 revision.c     | 44 +++++++++++++++++++++++---------------------
 revision.h     |  2 +-
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index c99c47ac18..0c2989d5ca 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -196,7 +196,7 @@ static void mark_edge_parents_uninteresting(struct commit *commit,
 		struct commit *parent = parents->item;
 		if (!(parent->object.flags & UNINTERESTING))
 			continue;
-		mark_tree_uninteresting(get_commit_tree(parent));
+		mark_tree_uninteresting(revs->repo, get_commit_tree(parent));
 		if (revs->edge_hint && !(parent->object.flags & SHOWN)) {
 			parent->object.flags |= SHOWN;
 			show_edge(parent);
@@ -213,7 +213,8 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
 		struct commit *commit = list->item;
 
 		if (commit->object.flags & UNINTERESTING) {
-			mark_tree_uninteresting(get_commit_tree(commit));
+			mark_tree_uninteresting(revs->repo,
+						get_commit_tree(commit));
 			if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
 				commit->object.flags |= SHOWN;
 				show_edge(commit);
@@ -228,7 +229,8 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
 			struct commit *commit = (struct commit *)obj;
 			if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
 				continue;
-			mark_tree_uninteresting(get_commit_tree(commit));
+			mark_tree_uninteresting(revs->repo,
+						get_commit_tree(commit));
 			if (!(obj->flags & SHOWN)) {
 				obj->flags |= SHOWN;
 				show_edge(commit);
diff --git a/revision.c b/revision.c
index 20c8fd4d1b..a89d6e9689 100644
--- a/revision.c
+++ b/revision.c
@@ -51,7 +51,8 @@ static void mark_blob_uninteresting(struct blob *blob)
 	blob->object.flags |= UNINTERESTING;
 }
 
-static void mark_tree_contents_uninteresting(struct tree *tree)
+static void mark_tree_contents_uninteresting(struct repository *r,
+					     struct tree *tree)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -63,10 +64,10 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			mark_tree_uninteresting(lookup_tree(the_repository, entry.oid));
+			mark_tree_uninteresting(r, lookup_tree(r, entry.oid));
 			break;
 		case OBJ_BLOB:
-			mark_blob_uninteresting(lookup_blob(the_repository, entry.oid));
+			mark_blob_uninteresting(lookup_blob(r, entry.oid));
 			break;
 		default:
 			/* Subproject commit - not in this repository */
@@ -81,7 +82,7 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 	free_tree_buffer(tree);
 }
 
-void mark_tree_uninteresting(struct tree *tree)
+void mark_tree_uninteresting(struct repository *r, struct tree *tree)
 {
 	struct object *obj;
 
@@ -92,7 +93,7 @@ void mark_tree_uninteresting(struct tree *tree)
 	if (obj->flags & UNINTERESTING)
 		return;
 	obj->flags |= UNINTERESTING;
-	mark_tree_contents_uninteresting(tree);
+	mark_tree_contents_uninteresting(r, tree);
 }
 
 struct commit_stack {
@@ -198,7 +199,7 @@ void add_head_to_pending(struct rev_info *revs)
 	struct object *obj;
 	if (get_oid("HEAD", &oid))
 		return;
-	obj = parse_object(the_repository, &oid);
+	obj = parse_object(revs->repo, &oid);
 	if (!obj)
 		return;
 	add_pending_object(revs, obj, "HEAD");
@@ -210,7 +211,7 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 {
 	struct object *object;
 
-	object = parse_object(the_repository, oid);
+	object = parse_object(revs->repo, oid);
 	if (!object) {
 		if (revs->ignore_missing)
 			return object;
@@ -247,7 +248,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 			add_pending_object(revs, object, tag->tag);
 		if (!tag->tagged)
 			die("bad tag");
-		object = parse_object(the_repository, &tag->tagged->oid);
+		object = parse_object(revs->repo, &tag->tagged->oid);
 		if (!object) {
 			if (revs->ignore_missing_links || (flags & UNINTERESTING))
 				return NULL;
@@ -297,7 +298,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 		if (!revs->tree_objects)
 			return NULL;
 		if (flags & UNINTERESTING) {
-			mark_tree_contents_uninteresting(tree);
+			mark_tree_contents_uninteresting(revs->repo, tree);
 			return NULL;
 		}
 		add_pending_object_with_path(revs, object, name, mode, path);
@@ -1253,7 +1254,7 @@ static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	if (!is_null_oid(oid)) {
-		struct object *o = parse_object(the_repository, oid);
+		struct object *o = parse_object(cb->all_revs->repo, oid);
 		if (o) {
 			o->flags |= cb->all_flags;
 			/* ??? CMDLINEFLAGS ??? */
@@ -1312,7 +1313,7 @@ void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 
 	cb.all_revs = revs;
 	cb.all_flags = flags;
-	cb.refs = get_main_ref_store(the_repository);
+	cb.refs = get_main_ref_store(revs->repo);
 	for_each_reflog(handle_one_reflog, &cb);
 
 	if (!revs->single_worktree)
@@ -1326,7 +1327,7 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 	int i;
 
 	if (it->entry_count >= 0) {
-		struct tree *tree = lookup_tree(the_repository, &it->oid);
+		struct tree *tree = lookup_tree(revs->repo, &it->oid);
 		add_pending_object_with_path(revs, &tree->object, "",
 					     040000, path->buf);
 	}
@@ -1352,7 +1353,7 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 		if (S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		blob = lookup_blob(the_repository, &ce->oid);
+		blob = lookup_blob(revs->repo, &ce->oid);
 		if (!blob)
 			die("unable to add index blob to traversal");
 		add_pending_object_with_path(revs, &blob->object, "",
@@ -1585,8 +1586,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 		*dotdot = '\0';
 	}
 
-	a_obj = parse_object(the_repository, &a_oid);
-	b_obj = parse_object(the_repository, &b_oid);
+	a_obj = parse_object(revs->repo, &a_oid);
+	b_obj = parse_object(revs->repo, &b_oid);
 	if (!a_obj || !b_obj)
 		return dotdot_missing(arg, dotdot, revs, symmetric);
 
@@ -1599,8 +1600,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 		struct commit *a, *b;
 		struct commit_list *exclude;
 
-		a = lookup_commit_reference(the_repository, &a_obj->oid);
-		b = lookup_commit_reference(the_repository, &b_obj->oid);
+		a = lookup_commit_reference(revs->repo, &a_obj->oid);
+		b = lookup_commit_reference(revs->repo, &b_obj->oid);
 		if (!a || !b)
 			return dotdot_missing(arg, dotdot, revs, symmetric);
 
@@ -2208,7 +2209,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 			BUG("--single-worktree cannot be used together with submodule");
 		refs = get_submodule_ref_store(submodule);
 	} else
-		refs = get_main_ref_store(the_repository);
+		refs = get_main_ref_store(revs->repo);
 
 	/*
 	 * NOTE!
@@ -2889,9 +2890,10 @@ void reset_revision_walk(void)
 static int mark_uninteresting(const struct object_id *oid,
 			      struct packed_git *pack,
 			      uint32_t pos,
-			      void *unused)
+			      void *cb)
 {
-	struct object *o = parse_object(the_repository, oid);
+	struct rev_info *revs = cb;
+	struct object *o = parse_object(revs->repo, oid);
 	o->flags |= UNINTERESTING | SEEN;
 	return 0;
 }
@@ -2924,7 +2926,7 @@ int prepare_revision_walk(struct rev_info *revs)
 		revs->treesame.name = "treesame";
 
 	if (revs->exclude_promisor_objects) {
-		for_each_packed_object(mark_uninteresting, NULL,
+		for_each_packed_object(mark_uninteresting, revs,
 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
 
diff --git a/revision.h b/revision.h
index a47064cd37..f819ea4151 100644
--- a/revision.h
+++ b/revision.h
@@ -277,7 +277,7 @@ void put_revision_mark(const struct rev_info *revs,
 		       const struct commit *commit);
 
 void mark_parents_uninteresting(struct commit *commit);
-void mark_tree_uninteresting(struct tree *tree);
+void mark_tree_uninteresting(struct repository *r, struct tree *tree);
 
 void show_object_with_name(FILE *, struct object *, const char *);
 
-- 
2.19.0.rc0.337.ge906d732e7

