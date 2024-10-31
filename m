Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C42146D78
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356036; cv=none; b=EzKeONK+wyRIgmcbkd22AOdPDw7cgnaQCST+coEjRHXRddyfi87jNuaxKGhG6bPbshTeACu44jV3Mq9oVhOaGkLD2cVGe4C2C6nFKGyj1LIsoxrAC8qCQyoTb1DLOU2L8potGaNIQJazWDOOS7oB9+lyseA+2LNRYbtlVL5/Y4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356036; c=relaxed/simple;
	bh=Eol5JxchFVl2C9I4alKM+7njyNCg2Mnz0ZYRkQn7dgM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DqwU5jy9plDdSoCbYYva9si0paEFEUGnJfebjiidpaCG/aeP0lg53Pl7ZC+dv6Wk5xpok+M0mGiFnVoucRUpfjmnMsHjZVMkB0ZAzg3PAL/mEWwHFuEdTfCofncyjG2h2s82vSbBBaDRPEC6NQYp9nmr3vb/qbR4FAiayE5Ql7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mk2jocUu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mk2jocUu"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431616c23b5so3190615e9.0
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 23:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730356031; x=1730960831; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJHWTGXNPog2oegEtBI+ShNIY7EpoiTQCs8mJVjh3a0=;
        b=mk2jocUu+Gk/Gza2pdaIm37ZKzQ9sWqLmmwVp2Jph/3QYsZ1TjQ4epysCKnkodY/VS
         bgHJVUSsvVRT2tQBcrJcIFX7Mz4i3WaPoBV4zz2V9nig609ziPrXEJzJF+hd38nP5A49
         br2pUFcTfbkZXgidF+eFypiAhluybdcQIAAqv2+IqU8U78Mu1I6kde6I+uex7O7PX2UI
         HOB1DmEBsCV2l8O6HTvEBhMDhG371CJg/tM9PCldvQRBdAkBPCbersDr5z1LDb3d+++A
         +5zXxEk0QTUHt249eUvn+TExG5OgT22Wf+5N1sz/p7cAJRRXbObXnNJlgitWubU9i648
         JfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730356031; x=1730960831;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJHWTGXNPog2oegEtBI+ShNIY7EpoiTQCs8mJVjh3a0=;
        b=uu9n5lqml9OP3BNlDOPdgbVSRAqiKFhASXIlsZz/hQTa3/ZIAh8WkfQYNu0F9V8Nd0
         WZx3LcztcDg7TlvknbO36Qja7Z2xVvmd/uaxyixi432rikD57MOiUqI5RB0awb/zgqzq
         DaOqiXX+MTVt13y7LDe4lTCxqwRvwFbYxBkOv9RoCzmqLPH8dWndB/cARDUEiKHMEdYm
         i27BNgjfLSOn2oeM1Czb3Jwbkk3iYAY7Avypf/zjq8oHyY5H0egLg2eqgzzLgDH2lkNJ
         iM7XHHKpApsPDNV08N4N3vax2UQ82T1LaR0WRNJW3oN/OABoH5LDfO7WEHoOF/V/zIgf
         Njqw==
X-Gm-Message-State: AOJu0YwlN+4Ofzxtec1G49HqCJg6nrI+Awl1u/IPkdGJ0LhUujHMiU5r
	GMCd6ZCyAOSMVX/hC1ZyWk/JJP9wCFtmHpbAjY2UV5Dye5iPe0M1vxQcBg==
X-Google-Smtp-Source: AGHT+IHV0wzw8jbNMV8s0Y4jpLt1PrK60TNGFjLK9SXQFhl+yNNzsP8qj3mIb0lTujl6JxSv1WET5g==
X-Received: by 2002:a05:600c:4ec7:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-4327dbd0d69mr8525395e9.16.1730356030701;
        Wed, 30 Oct 2024 23:27:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947c03sm42942635e9.28.2024.10.30.23.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:27:09 -0700 (PDT)
Message-Id: <3dc27658526784edf46f67661d1161a8eea3ea0a.1730356023.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 31 Oct 2024 06:27:02 +0000
Subject: [PATCH 5/6] path-walk: visit tags and cached objects
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The rev_info that is specified for a path-walk traversal may specify
visiting tag refs (both lightweight and annotated) and also may specify
indexed objects (blobs and trees). Update the path-walk API to walk
these objects as well.

When walking tags, we need to peel the annotated objects until reaching
a non-tag object. If we reach a commit, then we can add it to the
pending objects to make sure we visit in the commit walk portion. If we
reach a tree, then we will assume that it is a root tree. If we reach a
blob, then we have no good path name and so add it to a new list of
"tagged blobs".

When the rev_info includes the "--indexed-objects" flag, then the
pending set includes blobs and trees found in the cache entries and
cache-tree. The cache entries are usually blobs, though they could be
trees in the case of a sparse index. The cache-tree stores
previously-hashed tree objects but these are cleared out when staging
objects below those paths. We add tests that demonstrate this.

The indexed objects come with a non-NULL 'path' value in the pending
item. This allows us to prepopulate the 'path_to_lists' strmap with
lists for these paths.

The tricky thing about this walk is that we will want to combine the
indexed objects walk with the commit walk, especially in the future case
of walking objects during a command like 'git repack'.

Whenever possible, we want the objects from the index to be grouped with
similar objects in history. We don't want to miss any paths that appear
only in the index and not in the commit history.

Thus, we need to be careful to let the path stack be populated initially
with only the root tree path (and possibly tags and tagged blobs) and go
through the normal depth-first search. Afterwards, if there are other
paths that are remaining in the paths_to_lists strmap, we should then
iterate through the stack and visit those objects recursively.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.txt |   2 +-
 path-walk.c                               | 175 +++++++++++++++++++++-
 path-walk.h                               |   2 +
 t/helper/test-path-walk.c                 |  13 +-
 t/t6601-path-walk.sh                      | 154 ++++++++++++++++++-
 5 files changed, 336 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index dce553b6114..6022c381b7c 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -39,7 +39,7 @@ It is also important that you do not specify the `--objects` flag for the
 the objects will be walked in a separate way based on those starting
 commits.
 
-`commits`, `blobs`, `trees`::
+`commits`, `blobs`, `trees`, `tags`::
 	By default, these members are enabled and signal that the path-walk
 	API should call the `path_fn` on objects of these types. Specialized
 	applications could disable some options to make it simpler to walk
diff --git a/path-walk.c b/path-walk.c
index 14ad322bdd2..eca0e5f3d5b 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -13,10 +13,13 @@
 #include "revision.h"
 #include "string-list.h"
 #include "strmap.h"
+#include "tag.h"
 #include "trace2.h"
 #include "tree.h"
 #include "tree-walk.h"
 
+static const char *root_path = "";
+
 struct type_and_oid_list
 {
 	enum object_type type;
@@ -158,9 +161,13 @@ static int walk_path(struct path_walk_context *ctx,
 
 	list = strmap_get(&ctx->paths_to_lists, path);
 
+	if (!list)
+		BUG("provided path '%s' that had no associated list", path);
+
 	/* Evaluate function pointer on this data, if requested. */
 	if ((list->type == OBJ_TREE && ctx->info->trees) ||
-	    (list->type == OBJ_BLOB && ctx->info->blobs))
+	    (list->type == OBJ_BLOB && ctx->info->blobs) ||
+	    (list->type == OBJ_TAG && ctx->info->tags))
 		ret = ctx->info->path_fn(path, &list->oids, list->type,
 					ctx->info->path_fn_data);
 
@@ -191,6 +198,134 @@ static void clear_strmap(struct strmap *map)
 	strmap_init(map);
 }
 
+static void setup_pending_objects(struct path_walk_info *info,
+				  struct path_walk_context *ctx)
+{
+	struct type_and_oid_list *tags = NULL;
+	struct type_and_oid_list *tagged_blobs = NULL;
+	struct type_and_oid_list *root_tree_list = NULL;
+
+	if (info->tags)
+		CALLOC_ARRAY(tags, 1);
+	if (info->blobs)
+		CALLOC_ARRAY(tagged_blobs, 1);
+	if (info->trees)
+		root_tree_list = strmap_get(&ctx->paths_to_lists, root_path);
+
+	/*
+	 * Pending objects include:
+	 * * Commits at branch tips.
+	 * * Annotated tags at tag tips.
+	 * * Any kind of object at lightweight tag tips.
+	 * * Trees and blobs in the index (with an associated path).
+	 */
+	for (size_t i = 0; i < info->revs->pending.nr; i++) {
+		struct object_array_entry *pending = info->revs->pending.objects + i;
+		struct object *obj = pending->item;
+
+		/* Commits will be picked up by revision walk. */
+		if (obj->type == OBJ_COMMIT)
+			continue;
+
+		/* Navigate annotated tag object chains. */
+		while (obj->type == OBJ_TAG) {
+			struct tag *tag = lookup_tag(info->revs->repo, &obj->oid);
+			if (!tag)
+				break;
+			if (tag->object.flags & SEEN)
+				break;
+			tag->object.flags |= SEEN;
+
+			if (tags)
+				oid_array_append(&tags->oids, &obj->oid);
+			obj = tag->tagged;
+		}
+
+		if (obj->type == OBJ_TAG)
+			continue;
+
+		/* We are now at a non-tag object. */
+		if (obj->flags & SEEN)
+			continue;
+		obj->flags |= SEEN;
+
+		switch (obj->type) {
+		case OBJ_TREE:
+			if (!info->trees)
+				continue;
+			if (pending->path) {
+				struct type_and_oid_list *list;
+				char *path = *pending->path ? xstrfmt("%s/", pending->path)
+							    : xstrdup("");
+				if (!(list = strmap_get(&ctx->paths_to_lists, path))) {
+					CALLOC_ARRAY(list, 1);
+					list->type = OBJ_TREE;
+					strmap_put(&ctx->paths_to_lists, path, list);
+				}
+				oid_array_append(&list->oids, &obj->oid);
+				free(path);
+			} else {
+				/* assume a root tree, such as a lightweight tag. */
+				oid_array_append(&root_tree_list->oids, &obj->oid);
+			}
+			break;
+
+		case OBJ_BLOB:
+			if (!info->blobs)
+				continue;
+			if (pending->path) {
+				struct type_and_oid_list *list;
+				char *path = pending->path;
+				if (!(list = strmap_get(&ctx->paths_to_lists, path))) {
+					CALLOC_ARRAY(list, 1);
+					list->type = OBJ_BLOB;
+					strmap_put(&ctx->paths_to_lists, path, list);
+				}
+				oid_array_append(&list->oids, &obj->oid);
+			} else {
+				/* assume a root tree, such as a lightweight tag. */
+				oid_array_append(&tagged_blobs->oids, &obj->oid);
+			}
+			break;
+
+		case OBJ_COMMIT:
+			/* Make sure it is in the object walk */
+			if (obj != pending->item)
+				add_pending_object(info->revs, obj, "");
+			break;
+
+		default:
+			BUG("should not see any other type here");
+		}
+	}
+
+	/*
+	 * Add tag objects and tagged blobs if they exist.
+	 */
+	if (tagged_blobs) {
+		if (tagged_blobs->oids.nr) {
+			const char *tagged_blob_path = "/tagged-blobs";
+			tagged_blobs->type = OBJ_BLOB;
+			push_to_stack(ctx, tagged_blob_path);
+			strmap_put(&ctx->paths_to_lists, tagged_blob_path, tagged_blobs);
+		} else {
+			oid_array_clear(&tagged_blobs->oids);
+			free(tagged_blobs);
+		}
+	}
+	if (tags) {
+		if (tags->oids.nr) {
+			const char *tag_path = "/tags";
+			tags->type = OBJ_TAG;
+			push_to_stack(ctx, tag_path);
+			strmap_put(&ctx->paths_to_lists, tag_path, tags);
+		} else {
+			oid_array_clear(&tags->oids);
+			free(tags);
+		}
+	}
+}
+
 /**
  * Given the configuration of 'info', walk the commits based on 'info->revs' and
  * call 'info->path_fn' on each discovered path.
@@ -199,7 +334,6 @@ static void clear_strmap(struct strmap *map)
  */
 int walk_objects_by_path(struct path_walk_info *info)
 {
-	const char *root_path = "";
 	int ret = 0;
 	size_t commits_nr = 0, paths_nr = 0;
 	struct commit *c;
@@ -219,15 +353,31 @@ int walk_objects_by_path(struct path_walk_info *info)
 	CALLOC_ARRAY(commit_list, 1);
 	commit_list->type = OBJ_COMMIT;
 
+	if (info->tags)
+		info->revs->tag_objects = 1;
+
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
 	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
 	push_to_stack(&ctx, root_path);
 
+	/*
+	 * Set these values before preparing the walk to catch
+	 * lightweight tags pointing to non-commits and indexed objects.
+	 */
+	info->revs->blob_objects = info->blobs;
+	info->revs->tree_objects = info->trees;
+
 	if (prepare_revision_walk(info->revs))
 		die(_("failed to setup revision walk"));
 
+	info->revs->blob_objects = info->revs->tree_objects = 0;
+
+	trace2_region_enter("path-walk", "pending-walk", info->revs->repo);
+	setup_pending_objects(info, &ctx);
+	trace2_region_leave("path-walk", "pending-walk", info->revs->repo);
+
 	while ((c = get_revision(info->revs))) {
 		struct object_id *oid;
 		struct tree *t;
@@ -275,6 +425,27 @@ int walk_objects_by_path(struct path_walk_info *info)
 
 		free(path);
 	}
+
+	/* Are there paths remaining? Likely they are from indexed objects. */
+	if (!strmap_empty(&ctx.paths_to_lists)) {
+		struct hashmap_iter iter;
+		struct strmap_entry *entry;
+
+		strmap_for_each_entry(&ctx.paths_to_lists, &iter, entry) {
+			push_to_stack(&ctx, entry->key);
+		}
+
+		while (!ret && ctx.path_stack.nr) {
+			char *path = ctx.path_stack.items[ctx.path_stack.nr - 1].string;
+			ctx.path_stack.nr--;
+			paths_nr++;
+
+			ret = walk_path(&ctx, path);
+
+			free(path);
+		}
+	}
+
 	trace2_data_intmax("path-walk", ctx.repo, "paths", paths_nr);
 	trace2_region_leave("path-walk", "path-walk", info->revs->repo);
 
diff --git a/path-walk.h b/path-walk.h
index 2d2afc29b47..ca839f873e4 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -38,12 +38,14 @@ struct path_walk_info {
 	int commits;
 	int trees;
 	int blobs;
+	int tags;
 };
 
 #define PATH_WALK_INFO_INIT {   \
 	.blobs = 1,		\
 	.trees = 1,		\
 	.commits = 1,		\
+	.tags = 1,		\
 }
 
 /**
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index 37c5e3e31e8..c6c60d68749 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -21,6 +21,7 @@ struct path_walk_test_data {
 	uintmax_t commit_nr;
 	uintmax_t tree_nr;
 	uintmax_t blob_nr;
+	uintmax_t tag_nr;
 };
 
 static int emit_block(const char *path, struct oid_array *oids,
@@ -45,6 +46,11 @@ static int emit_block(const char *path, struct oid_array *oids,
 		tdata->blob_nr += oids->nr;
 		break;
 
+	case OBJ_TAG:
+		typestr = "TAG";
+		tdata->tag_nr += oids->nr;
+		break;
+
 	default:
 		BUG("we do not understand this type");
 	}
@@ -66,6 +72,8 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle inclusion of blob objects")),
 		OPT_BOOL(0, "commits", &info.commits,
 			 N_("toggle inclusion of commit objects")),
+		OPT_BOOL(0, "tags", &info.tags,
+			 N_("toggle inclusion of tag objects")),
 		OPT_BOOL(0, "trees", &info.trees,
 			 N_("toggle inclusion of tree objects")),
 		OPT_END(),
@@ -92,8 +100,9 @@ int cmd__path_walk(int argc, const char **argv)
 
 	printf("commits:%" PRIuMAX "\n"
 	       "trees:%" PRIuMAX "\n"
-	       "blobs:%" PRIuMAX "\n",
-	       data.commit_nr, data.tree_nr, data.blob_nr);
+	       "blobs:%" PRIuMAX "\n"
+	       "tags:%" PRIuMAX "\n",
+	       data.commit_nr, data.tree_nr, data.blob_nr, data.tag_nr);
 
 	return res;
 }
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 4b16a0a3c80..5ed6c79fbd1 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -7,24 +7,55 @@ test_description='direct path-walk API tests'
 test_expect_success 'setup test repository' '
 	git checkout -b base &&
 
+	# Make some objects that will only be reachable
+	# via non-commit tags.
+	mkdir child &&
+	echo file >child/file &&
+	git add child &&
+	git commit -m "will abandon" &&
+	git tag -a -m "tree" tree-tag HEAD^{tree} &&
+	echo file2 >file2 &&
+	git add file2 &&
+	git commit --amend -m "will abandon" &&
+	git tag tree-tag2 HEAD^{tree} &&
+
+	echo blob >file &&
+	blob_oid=$(git hash-object -t blob -w --stdin <file) &&
+	git tag -a -m "blob" blob-tag "$blob_oid" &&
+	echo blob2 >file2 &&
+	blob2_oid=$(git hash-object -t blob -w --stdin <file2) &&
+	git tag blob-tag2 "$blob2_oid" &&
+
+	rm -fr child file file2 &&
+
 	mkdir left &&
 	mkdir right &&
 	echo a >a &&
 	echo b >left/b &&
 	echo c >right/c &&
 	git add . &&
-	git commit -m "first" &&
+	git commit --amend -m "first" &&
+	git tag -m "first" first HEAD &&
 
 	echo d >right/d &&
 	git add right &&
 	git commit -m "second" &&
+	git tag -a -m "second (under)" second.1 HEAD &&
+	git tag -a -m "second (top)" second.2 second.1 &&
 
+	# Set up file/dir collision in history.
+	rm a &&
+	mkdir a &&
+	echo a >a/a &&
 	echo bb >left/b &&
-	git commit -a -m "third" &&
+	git add a left &&
+	git commit -m "third" &&
+	git tag -a -m "third" third &&
 
 	git checkout -b topic HEAD~1 &&
 	echo cc >right/c &&
-	git commit -a -m "topic"
+	git commit -a -m "topic" &&
+	git tag -a -m "fourth" fourth
 '
 
 test_expect_success 'all' '
@@ -40,19 +71,104 @@ test_expect_success 'all' '
 	TREE::$(git rev-parse base^{tree})
 	TREE::$(git rev-parse base~1^{tree})
 	TREE::$(git rev-parse base~2^{tree})
+	TREE::$(git rev-parse refs/tags/tree-tag^{})
+	TREE::$(git rev-parse refs/tags/tree-tag2^{})
+	TREE:a/:$(git rev-parse base:a)
 	TREE:left/:$(git rev-parse base:left)
 	TREE:left/:$(git rev-parse base~2:left)
 	TREE:right/:$(git rev-parse topic:right)
 	TREE:right/:$(git rev-parse base~1:right)
 	TREE:right/:$(git rev-parse base~2:right)
-	trees:9
+	TREE:child/:$(git rev-parse refs/tags/tree-tag^{}:child)
+	trees:13
 	BLOB:a:$(git rev-parse base~2:a)
+	BLOB:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
 	BLOB:left/b:$(git rev-parse base~2:left/b)
 	BLOB:left/b:$(git rev-parse base:left/b)
 	BLOB:right/c:$(git rev-parse base~2:right/c)
 	BLOB:right/c:$(git rev-parse topic:right/c)
 	BLOB:right/d:$(git rev-parse base~1:right/d)
-	blobs:6
+	BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	BLOB:child/file:$(git rev-parse refs/tags/tree-tag^{}:child/file)
+	blobs:10
+	TAG:/tags:$(git rev-parse refs/tags/first)
+	TAG:/tags:$(git rev-parse refs/tags/second.1)
+	TAG:/tags:$(git rev-parse refs/tags/second.2)
+	TAG:/tags:$(git rev-parse refs/tags/third)
+	TAG:/tags:$(git rev-parse refs/tags/fourth)
+	TAG:/tags:$(git rev-parse refs/tags/tree-tag)
+	TAG:/tags:$(git rev-parse refs/tags/blob-tag)
+	tags:7
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'indexed objects' '
+	test_when_finished git reset --hard &&
+
+	# stage change into index, adding a blob but
+	# also invalidating the cache-tree for the root
+	# and the "left" directory.
+	echo bogus >left/c &&
+	git add left &&
+
+	test-tool path-walk -- --indexed-objects >out &&
+
+	cat >expect <<-EOF &&
+	commits:0
+	TREE:right/:$(git rev-parse topic:right)
+	trees:1
+	BLOB:a:$(git rev-parse HEAD:a)
+	BLOB:left/b:$(git rev-parse HEAD:left/b)
+	BLOB:left/c:$(git rev-parse :left/c)
+	BLOB:right/c:$(git rev-parse HEAD:right/c)
+	BLOB:right/d:$(git rev-parse HEAD:right/d)
+	blobs:5
+	tags:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'branches and indexed objects mix well' '
+	test_when_finished git reset --hard &&
+
+	# stage change into index, adding a blob but
+	# also invalidating the cache-tree for the root
+	# and the "right" directory.
+	echo fake >right/d &&
+	git add right &&
+
+	test-tool path-walk -- --indexed-objects --branches >out &&
+
+	cat >expect <<-EOF &&
+	COMMIT::$(git rev-parse topic)
+	COMMIT::$(git rev-parse base)
+	COMMIT::$(git rev-parse base~1)
+	COMMIT::$(git rev-parse base~2)
+	commits:4
+	TREE::$(git rev-parse topic^{tree})
+	TREE::$(git rev-parse base^{tree})
+	TREE::$(git rev-parse base~1^{tree})
+	TREE::$(git rev-parse base~2^{tree})
+	TREE:a/:$(git rev-parse base:a)
+	TREE:left/:$(git rev-parse base:left)
+	TREE:left/:$(git rev-parse base~2:left)
+	TREE:right/:$(git rev-parse topic:right)
+	TREE:right/:$(git rev-parse base~1:right)
+	TREE:right/:$(git rev-parse base~2:right)
+	trees:10
+	BLOB:a:$(git rev-parse base~2:a)
+	BLOB:left/b:$(git rev-parse base:left/b)
+	BLOB:left/b:$(git rev-parse base~2:left/b)
+	BLOB:right/c:$(git rev-parse base~2:right/c)
+	BLOB:right/c:$(git rev-parse topic:right/c)
+	BLOB:right/d:$(git rev-parse base~1:right/d)
+	BLOB:right/d:$(git rev-parse :right/d)
+	blobs:7
+	tags:0
 	EOF
 
 	test_cmp_sorted expect out
@@ -80,6 +196,7 @@ test_expect_success 'topic only' '
 	BLOB:right/c:$(git rev-parse topic:right/c)
 	BLOB:right/d:$(git rev-parse base~1:right/d)
 	blobs:5
+	tags:0
 	EOF
 
 	test_cmp_sorted expect out
@@ -100,6 +217,7 @@ test_expect_success 'topic, not base' '
 	BLOB:right/c:$(git rev-parse topic:right/c)
 	BLOB:right/d:$(git rev-parse topic:right/d)
 	blobs:4
+	tags:0
 	EOF
 
 	test_cmp_sorted expect out
@@ -117,6 +235,7 @@ test_expect_success 'topic, not base, only blobs' '
 	BLOB:right/c:$(git rev-parse topic:right/c)
 	BLOB:right/d:$(git rev-parse topic:right/d)
 	blobs:4
+	tags:0
 	EOF
 
 	test_cmp_sorted expect out
@@ -133,6 +252,7 @@ test_expect_success 'topic, not base, only commits' '
 	commits:1
 	trees:0
 	blobs:0
+	tags:0
 	EOF
 
 	test_cmp_sorted expect out
@@ -149,6 +269,7 @@ test_expect_success 'topic, not base, only trees' '
 	TREE:right/:$(git rev-parse topic:right)
 	trees:3
 	blobs:0
+	tags:0
 	EOF
 
 	test_cmp_sorted expect out
@@ -173,9 +294,32 @@ test_expect_success 'topic, not base, boundary' '
 	BLOB:right/c:$(git rev-parse topic:right/c)
 	BLOB:right/d:$(git rev-parse base~1:right/d)
 	blobs:5
+	tags:0
 	EOF
 
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'trees are reported exactly once' '
+	test_when_finished "rm -rf unique-trees" &&
+	test_create_repo unique-trees &&
+	(
+		cd unique-trees &&
+		mkdir initial &&
+		test_commit initial/file &&
+
+		git switch -c move-to-top &&
+		git mv initial/file.t ./ &&
+		test_tick &&
+		git commit -m moved &&
+
+		git update-ref refs/heads/other HEAD
+	) &&
+
+	test-tool -C unique-trees path-walk -- --all >out &&
+	tree=$(git -C unique-trees rev-parse HEAD:) &&
+	grep "$tree" out >out-filtered &&
+	test_line_count = 1 out-filtered
+'
+
 test_done
-- 
gitgitgadget

