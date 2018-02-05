Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35CCC1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeBFAMh (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:12:37 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38785 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752023AbeBFAMf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:12:35 -0500
Received: by mail-pg0-f65.google.com with SMTP id l18so147517pgc.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RskVwooViWwW6WwtmgxjRFssC2QOJcqErvaZQF6yN5Y=;
        b=OWTvAyzFA3nw7xG1aXxdQ8VOJI7izXMehapWuU6Q69HsaVSVeZluebicWzg2VXzndh
         MGl9gMCtypSjuPRG2OVZ8tb1KTdBf5BMxYRiPij087WD2BzdfZWQKp+qJFypYR+5ZHil
         z3k+byj/R+zAC7uDCbS7ZsfHvy0/HdU1aXl4i9PmeKHQu5jtQgxvLEXKcsPnp8NgXNXO
         TsLoPgFsCbOpw/uK5yCbX04Qo3Bm+vOIcnPXK2gpWALmFKXEyBp/ZlqFeT2kbKRXGDKh
         fT7Vc3hDMI4MlNkqNyc7SMCJLJRgRaq1OIZmx0bT0yriYZEfJHwQ5eylre/0+2++NHFY
         JK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RskVwooViWwW6WwtmgxjRFssC2QOJcqErvaZQF6yN5Y=;
        b=l+urEhxp4seSWrBTyXMNEfU4m7ExSDAUGy6EquiDQfnfKbzN3RMr9ELFcjtXoxteFz
         /H92kfuJNuykn+LnJe+UYY8hKKLj+PL19EazHOjQryOFJRpP8GQZKJS2XK0cNMNyrvse
         NKk6FydRRbxCFVr2MFtZfkJTNOSHAiX26q8r5MfIMoGh1v9XyY4uwNwScgu2QcEqsBCy
         tkkJzfpBkcrr9qsNZZXr9vU9d4VvOa8gjwJxZaZWYL/yQNODVRtWEuPRtYP6euWhDUs3
         XAQcJDzcaWHLiKBEyGfJ5zTqsnC892vaO47diGHh/UURNCB2mp53Wf0esAPZl/Gre8C1
         YK7A==
X-Gm-Message-State: APf1xPD2NNSRY8c2nobJxjPEb+4lcfNpFFAPnaao0dr7lr5miiQW1AYe
        4dftfl1+FTatcvWaGys5V3OsxlBflik=
X-Google-Smtp-Source: AH8x227LnDv98NmVrP0bEesb0E/NoNE+x6/gPgDxHY4QgkXq8BoYtx90Ajq2MpfGKaZOD0+kD1LaDQ==
X-Received: by 10.98.247.25 with SMTP id h25mr524334pfi.162.1517875954231;
        Mon, 05 Feb 2018 16:12:34 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l64sm19514140pfi.46.2018.02.05.16.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:12:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 085/194] tree: add repository argument to lookup_tree
Date:   Mon,  5 Feb 2018 15:55:46 -0800
Message-Id: <20180205235735.216710-65-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of lookup_tree
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Add the cocci patch that converted the callers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/am.c                           | 6 ++++--
 builtin/diff-tree.c                    | 2 +-
 builtin/diff.c                         | 3 ++-
 builtin/reflog.c                       | 2 +-
 cache-tree.c                           | 3 ++-
 commit.c                               | 2 +-
 contrib/coccinelle/object_parser.cocci | 8 ++++++++
 fsck.c                                 | 2 +-
 http-push.c                            | 3 ++-
 list-objects.c                         | 2 +-
 merge-recursive.c                      | 6 +++---
 object.c                               | 2 +-
 reachable.c                            | 2 +-
 revision.c                             | 4 ++--
 sequencer.c                            | 2 +-
 tag.c                                  | 2 +-
 tree.c                                 | 4 ++--
 tree.h                                 | 3 ++-
 walker.c                               | 3 ++-
 19 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index acfe9d3c8c..32002a8661 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -32,6 +32,7 @@
 #include "apply.h"
 #include "string-list.h"
 #include "packfile.h"
+#include "repository.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -1398,9 +1399,10 @@ static void write_index_patch(const struct am_state *state)
 	FILE *fp;
 
 	if (!get_oid_tree("HEAD", &head))
-		tree = lookup_tree(&head);
+		tree = lookup_tree(the_repository, &head);
 	else
-		tree = lookup_tree(the_hash_algo->empty_tree);
+		tree = lookup_tree(the_repository,
+				   the_repository->hash_algo->empty_tree);
 
 	fp = xfopen(am_path(state, "patch"), "w");
 	init_revisions(&rev_info, NULL);
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 1f78308e33..ab491efa9e 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -46,7 +46,7 @@ static int stdin_diff_trees(struct tree *tree1, const char *p)
 	struct tree *tree2;
 	if (!isspace(*p++) || parse_oid_hex(p, &oid, &p) || *p)
 		return error("Need exactly two trees, separated by a space");
-	tree2 = lookup_tree(&oid);
+	tree2 = lookup_tree(the_repository, &oid);
 	if (!tree2 || parse_tree(tree2))
 		return -1;
 	printf("%s %s\n", oid_to_hex(&tree1->object.oid),
diff --git a/builtin/diff.c b/builtin/diff.c
index ed6092ef1a..0b7d0d612d 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -379,7 +379,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				add_head_to_pending(&rev);
 				if (!rev.pending.nr) {
 					struct tree *tree;
-					tree = lookup_tree(the_hash_algo->empty_tree);
+					tree = lookup_tree(the_repository,
+							   the_repository->hash_algo->empty_tree);
 					add_pending_object(&rev, &tree->object, "HEAD");
 				}
 				break;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 18145d5494..335525bb15 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -65,7 +65,7 @@ static int tree_is_complete(const struct object_id *oid)
 	int complete;
 	struct tree *tree;
 
-	tree = lookup_tree(oid);
+	tree = lookup_tree(the_repository, oid);
 	if (!tree)
 		return 0;
 	if (tree->object.flags & SEEN)
diff --git a/cache-tree.c b/cache-tree.c
index 2a98b15b92..75ff93abc7 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -671,7 +671,8 @@ static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 			cnt++;
 		else {
 			struct cache_tree_sub *sub;
-			struct tree *subtree = lookup_tree(entry.oid);
+			struct tree *subtree = lookup_tree(the_repository,
+							   entry.oid);
 			if (!subtree->object.parsed)
 				parse_tree(subtree);
 			sub = cache_tree_sub(it, entry.path);
diff --git a/commit.c b/commit.c
index 68967e6c59..253a906124 100644
--- a/commit.c
+++ b/commit.c
@@ -339,7 +339,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	item->tree = lookup_tree(&parent);
+	item->tree = lookup_tree(the_repository, &parent);
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index 3bc38d2faa..e5ce73fe13 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -5,6 +5,14 @@ expression E;
 +the_repository,
  E)
 
+@@
+expression E;
+@@
+ lookup_tree(
++the_repository,
+ E)
+
+
 @@
 expression E;
 @@
diff --git a/fsck.c b/fsck.c
index 6d04981735..54943b7dee 100644
--- a/fsck.c
+++ b/fsck.c
@@ -360,7 +360,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			continue;
 
 		if (S_ISDIR(entry.mode)) {
-			obj = (struct object *)lookup_tree(entry.oid);
+			obj = (struct object *)lookup_tree(the_repository, entry.oid);
 			if (name && obj)
 				put_object_name(options, obj, "%s%s/", name,
 					entry.path);
diff --git a/http-push.c b/http-push.c
index 6c60b12ad1..83117770a3 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1307,7 +1307,8 @@ static struct object_list **process_tree(struct tree *tree,
 	while (tree_entry(&desc, &entry))
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			p = process_tree(lookup_tree(entry.oid), p);
+			p = process_tree(lookup_tree(the_repository, entry.oid),
+					 p);
 			break;
 		case OBJ_BLOB:
 			p = process_blob(lookup_blob(the_repository, entry.oid),
diff --git a/list-objects.c b/list-objects.c
index c11dc1281b..0db8fc15c2 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -130,7 +130,7 @@ static void process_tree(struct rev_info *revs,
 
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
-				     lookup_tree(entry.oid),
+				     lookup_tree(the_repository, entry.oid),
 				     show, base, entry.path,
 				     cb_data, filter_fn, filter_data);
 		else if (S_ISGITLINK(entry.mode))
diff --git a/merge-recursive.c b/merge-recursive.c
index e2c434c305..181ab36c36 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -95,7 +95,7 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 	}
 	if (!oidcmp(&two->object.oid, &shifted))
 		return two;
-	return lookup_tree(&shifted);
+	return lookup_tree(the_repository, &shifted);
 }
 
 static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
@@ -332,7 +332,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		return NULL;
 	}
 
-	result = lookup_tree(&active_cache_tree->oid);
+	result = lookup_tree(the_repository, &active_cache_tree->oid);
 
 	return result;
 }
@@ -2091,7 +2091,7 @@ int merge_recursive(struct merge_options *o,
 		/* if there is no common ancestor, use an empty tree */
 		struct tree *tree;
 
-		tree = lookup_tree(the_hash_algo->empty_tree);
+		tree = lookup_tree(the_repository, the_repository->hash_algo->empty_tree);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
diff --git a/object.c b/object.c
index e0dac087c8..5ddbe91a38 100644
--- a/object.c
+++ b/object.c
@@ -197,7 +197,7 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
 			obj = &blob->object;
 		}
 	} else if (type == OBJ_TREE) {
-		struct tree *tree = lookup_tree(oid);
+		struct tree *tree = lookup_tree(the_repository, oid);
 		if (tree) {
 			obj = &tree->object;
 			if (!tree->buffer)
diff --git a/reachable.c b/reachable.c
index 943e4518c2..44a9328c0e 100644
--- a/reachable.c
+++ b/reachable.c
@@ -89,7 +89,7 @@ static void add_recent_object(const struct object_id *oid,
 		obj = parse_object_or_die(oid, NULL);
 		break;
 	case OBJ_TREE:
-		obj = (struct object *)lookup_tree(oid);
+		obj = (struct object *)lookup_tree(the_repository, oid);
 		break;
 	case OBJ_BLOB:
 		obj = (struct object *)lookup_blob(the_repository, oid);
diff --git a/revision.c b/revision.c
index a7b57e3452..629af0dca5 100644
--- a/revision.c
+++ b/revision.c
@@ -64,7 +64,7 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			mark_tree_uninteresting(lookup_tree(entry.oid));
+			mark_tree_uninteresting(lookup_tree(the_repository, entry.oid));
 			break;
 		case OBJ_BLOB:
 			mark_blob_uninteresting(lookup_blob(the_repository, entry.oid));
@@ -1295,7 +1295,7 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 	int i;
 
 	if (it->entry_count >= 0) {
-		struct tree *tree = lookup_tree(&it->oid);
+		struct tree *tree = lookup_tree(the_repository, &it->oid);
 		add_pending_object_with_path(revs, &tree->object, "",
 					     040000, path->buf);
 	}
diff --git a/sequencer.c b/sequencer.c
index 311f00acda..6533b97138 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -349,7 +349,7 @@ static int read_oneliner(struct strbuf *buf,
 
 static struct tree *empty_tree(void)
 {
-	return lookup_tree(the_hash_algo->empty_tree);
+	return lookup_tree(the_repository, the_repository->hash_algo->empty_tree);
 }
 
 static int error_dirty_index(struct replay_opts *opts)
diff --git a/tag.c b/tag.c
index 4cf449303b..ba1df1c695 100644
--- a/tag.c
+++ b/tag.c
@@ -148,7 +148,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	if (!strcmp(type, blob_type)) {
 		item->tagged = (struct object *)lookup_blob(the_repository, &oid);
 	} else if (!strcmp(type, tree_type)) {
-		item->tagged = (struct object *)lookup_tree(&oid);
+		item->tagged = (struct object *)lookup_tree(the_repository, &oid);
 	} else if (!strcmp(type, commit_type)) {
 		item->tagged = (struct object *)lookup_commit(&oid);
 	} else if (!strcmp(type, tag_type)) {
diff --git a/tree.c b/tree.c
index 8f0ee6c8c0..b0d8610c41 100644
--- a/tree.c
+++ b/tree.c
@@ -119,7 +119,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 		len = tree_entry_len(&entry);
 		strbuf_add(base, entry.path, len);
 		strbuf_addch(base, '/');
-		retval = read_tree_1(lookup_tree(&oid),
+		retval = read_tree_1(lookup_tree(the_repository, &oid),
 				     base, stage, pathspec,
 				     fn, context);
 		strbuf_setlen(base, oldlen);
@@ -194,7 +194,7 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match,
 	return 0;
 }
 
-struct tree *lookup_tree(const struct object_id *oid)
+struct tree *lookup_tree_the_repository(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
diff --git a/tree.h b/tree.h
index 744e6dc2ac..8195db473f 100644
--- a/tree.h
+++ b/tree.h
@@ -12,7 +12,8 @@ struct tree {
 	unsigned long size;
 };
 
-struct tree *lookup_tree(const struct object_id *oid);
+#define lookup_tree(r, oid) lookup_tree_##r(oid)
+struct tree *lookup_tree_the_repository(const struct object_id *oid);
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
 
diff --git a/walker.c b/walker.c
index f5a221d48e..5cfd2316a8 100644
--- a/walker.c
+++ b/walker.c
@@ -49,7 +49,8 @@ static int process_tree(struct walker *walker, struct tree *tree)
 		if (S_ISGITLINK(entry.mode))
 			continue;
 		if (S_ISDIR(entry.mode)) {
-			struct tree *tree = lookup_tree(entry.oid);
+			struct tree *tree = lookup_tree(the_repository,
+							entry.oid);
 			if (tree)
 				obj = &tree->object;
 		}
-- 
2.15.1.433.g936d1b9894.dirty

