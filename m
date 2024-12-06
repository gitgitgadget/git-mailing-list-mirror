Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE68D1FD7B6
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514370; cv=none; b=WwfhrHXT+23BIm5IGI1nCgF2tC+auu/p6OiHWEsVY+uqvkNF+Qo+xThbsGrK8gmoAaWTjzEQkxViDlm+OZ3879i99qfnj7VDfQqqHe9C4GORGyKyudQBIXha1qKhfPHArjU8QPm2ee1olSUUwWxDWCxev+AorDm4SNN6nUBOxfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514370; c=relaxed/simple;
	bh=1AlD6g17219ChcBCBFSeC9cW5PTD5Zc8ybI7/gQOx2E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UMqa2LBuzw+J7teq+BO5X8pMT7GXJfjzWvDgoZ7DVXcgwP9mi4cOWOZZJWDA0BONaEAHDyK74gya1wTsl3+9xgj3tZ7dG4Yfei7WkYrLPm5JSZ5ffOCMiCIT6w1zbUqmAdr+PYA9xvnY89EEHKbjZKgSl2pTTk2Y17TiS54iAyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHsVxSuM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHsVxSuM"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso156809f8f.2
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 11:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733514366; x=1734119166; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq31VILplSBa8TQb0dXBFrXXA0MkVreZP9g6yVe58aw=;
        b=jHsVxSuMIotDhJTQPC6TdSsNN4RR7kjDGdo1Nygo9wJm39/zrw2DwIzVCAMTGxxikO
         Stg3ek0tLhzhp/pOaoZbbd846kagcz9hEYBS1iUmNiwmZtNGJDg7OnrnvvsUkOVv0gy8
         hfFr8rvvT/8ld83wKx7VsbJ2Xj+elB81fjHRuMRWQxSXTm1CHhefFMwjuPqouPbXKS+I
         SnrWIljSjyz6MckFqAMGzDV5d3OAJzOe405gKPa+SD3j7C7HveTjATkbO5poliN4mIMC
         kSK514MOHMdIVw0CX+lUX+tn3PnCgCcK+02cLu4+97PrI5CYB4h5atOJMeL0DnujO1Ce
         3ooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514366; x=1734119166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tq31VILplSBa8TQb0dXBFrXXA0MkVreZP9g6yVe58aw=;
        b=wJBElZwMlrriZptC5o7b5AFXC+4OXEA8LlbA4vM83qSXEXmDQY9LvmGf64HWvIWDcB
         DP45jY2OtL2toikEUtur3t5VzG7kSuDltOKuUsJyujFEB3XRhvjKqc9K74Lntth3Mbp0
         tG3F2S/evYSQW6HkFXm5eUnT0bpVSJDyCyTZQsc5IaNlfzufiFNkNZg7weL+nHwFU+tZ
         1rNkyhdB46BJAdX5CrOd1G8RHuJoZH3ND/WxZuqia2EkPajP6YFjb+gm44HRg2LI1XrI
         uzo8N4rSFLAIBW/rQYYjst1a14ZY8p6lIKHTvhibmRN4cvKwzewzeV8SkMeheuqQ+6Fn
         teew==
X-Gm-Message-State: AOJu0Yy8QvdX7xC/ijozsH0BcLpn5fAO1bRE/IS+Z89ZUp+HfxFzTsVj
	AD8aVqVb+h+EoYpx9eaass+nmYO8hUKZuNwm86uqZdK7P1IxigRXLzX4bg==
X-Gm-Gg: ASbGnct18fapybqAjWlJfnbw/RAP6yBDUz6TNYKYSlzN+BSFFRCXmEyI/hznd6OEfQu
	+RSgZu+8G0Md0p4zPOHvnoGvIzbO7uywSMY+Y1XTVdi2Zu1t2WRmcgvtCP1y3Wx3GyJ+lz15ftj
	Y+tr55KALiL6um9RX5NqGPWYBX7RV8ktGG1ik2dP2GIyXzgfTjalSGMezm0o1qfJMa/XKeznpIp
	t6KMOuWl7KRLMafsp2foWtYhUX0YqTqE+o1MDToP+hv19c2H9g=
X-Google-Smtp-Source: AGHT+IGXZvOmJZOvvnM/ZXblMKO859kaLR9MLnWe1L6/inTL68a3DfCE9GlrU7NK467zVTrVJK5txQ==
X-Received: by 2002:a5d:6484:0:b0:385:e394:37ed with SMTP id ffacd0b85a97d-3862b355c89mr3466180f8f.18.1733514365491;
        Fri, 06 Dec 2024 11:46:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d43b8557sm74023435e9.1.2024.12.06.11.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:46:05 -0800 (PST)
Message-Id: <a41f53f7ced7a403547ce1c239c5fbb5382cfb0f.1733514359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
	<pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 19:45:56 +0000
Subject: [PATCH v3 5/7] path-walk: visit tags and cached objects
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
    karthik nayak <karthik.188@gmail.com>,
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
 path-walk.c                               | 174 +++++++++++++++++++-
 path-walk.h                               |   2 +
 t/helper/test-path-walk.c                 |  15 +-
 t/t6601-path-walk.sh                      | 186 +++++++++++++++++++---
 5 files changed, 353 insertions(+), 26 deletions(-)

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
index 2ca08402367..a1f539dcd46 100644
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
@@ -158,12 +161,16 @@ static int walk_path(struct path_walk_context *ctx,
 
 	list = strmap_get(&ctx->paths_to_lists, path);
 
+	if (!list)
+		BUG("provided path '%s' that had no associated list", path);
+
 	if (!list->oids.nr)
 		return 0;
 
 	/* Evaluate function pointer on this data, if requested. */
 	if ((list->type == OBJ_TREE && ctx->info->trees) ||
-	    (list->type == OBJ_BLOB && ctx->info->blobs))
+	    (list->type == OBJ_BLOB && ctx->info->blobs) ||
+	    (list->type == OBJ_TAG && ctx->info->tags))
 		ret = ctx->info->path_fn(path, &list->oids, list->type,
 					ctx->info->path_fn_data);
 
@@ -194,6 +201,134 @@ static void clear_strmap(struct strmap *map)
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
@@ -202,7 +337,6 @@ static void clear_strmap(struct strmap *map)
  */
 int walk_objects_by_path(struct path_walk_info *info)
 {
-	const char *root_path = "";
 	int ret = 0;
 	size_t commits_nr = 0, paths_nr = 0;
 	struct commit *c;
@@ -222,15 +356,31 @@ int walk_objects_by_path(struct path_walk_info *info)
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
@@ -278,6 +428,26 @@ int walk_objects_by_path(struct path_walk_info *info)
 
 		free(path);
 	}
+
+	/* Are there paths remaining? Likely they are from indexed objects. */
+	if (!strmap_empty(&ctx.paths_to_lists)) {
+		struct hashmap_iter iter;
+		struct strmap_entry *entry;
+
+		strmap_for_each_entry(&ctx.paths_to_lists, &iter, entry)
+			push_to_stack(&ctx, entry->key);
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
index a57a05a6391..56289859e69 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -23,6 +23,7 @@ struct path_walk_test_data {
 	uintmax_t commit_nr;
 	uintmax_t tree_nr;
 	uintmax_t blob_nr;
+	uintmax_t tag_nr;
 };
 
 static int emit_block(const char *path, struct oid_array *oids,
@@ -37,11 +38,18 @@ static int emit_block(const char *path, struct oid_array *oids,
 		tdata->blob_nr += oids->nr;
 	else if (type == OBJ_COMMIT)
 		tdata->commit_nr += oids->nr;
+	else if (type == OBJ_TAG)
+		tdata->tag_nr += oids->nr;
 	else
 		BUG("we do not understand this type");
 
 	typestr = type_name(type);
 
+	/* This should never be output during tests. */
+	if (!oids->nr)
+		printf("%"PRIuMAX":%s:%s:EMPTY\n",
+		       tdata->batch_nr, typestr, path);
+
 	for (size_t i = 0; i < oids->nr; i++)
 		printf("%"PRIuMAX":%s:%s:%s\n",
 		       tdata->batch_nr, typestr, path,
@@ -62,6 +70,8 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle inclusion of blob objects")),
 		OPT_BOOL(0, "commits", &info.commits,
 			 N_("toggle inclusion of commit objects")),
+		OPT_BOOL(0, "tags", &info.tags,
+			 N_("toggle inclusion of tag objects")),
 		OPT_BOOL(0, "trees", &info.trees,
 			 N_("toggle inclusion of tree objects")),
 		OPT_END(),
@@ -87,8 +97,9 @@ int cmd__path_walk(int argc, const char **argv)
 
 	printf("commits:%" PRIuMAX "\n"
 	       "trees:%" PRIuMAX "\n"
-	       "blobs:%" PRIuMAX "\n",
-	       data.commit_nr, data.tree_nr, data.blob_nr);
+	       "blobs:%" PRIuMAX "\n"
+	       "tags:%" PRIuMAX "\n",
+	       data.commit_nr, data.tree_nr, data.blob_nr, data.tag_nr);
 
 	release_revisions(&revs);
 	return res;
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 4a4939a1b02..1f3d2e0cb76 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -9,29 +9,142 @@ test_description='direct path-walk API tests'
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
 	test-tool path-walk -- --all >out &&
 
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tag:/tags:$(git rev-parse refs/tags/first)
+	1:tag:/tags:$(git rev-parse refs/tags/second.1)
+	1:tag:/tags:$(git rev-parse refs/tags/second.2)
+	1:tag:/tags:$(git rev-parse refs/tags/third)
+	1:tag:/tags:$(git rev-parse refs/tags/fourth)
+	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
+	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	3:tree::$(git rev-parse topic^{tree})
+	3:tree::$(git rev-parse base^{tree})
+	3:tree::$(git rev-parse base~1^{tree})
+	3:tree::$(git rev-parse base~2^{tree})
+	3:tree::$(git rev-parse refs/tags/tree-tag^{})
+	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
+	4:blob:a:$(git rev-parse base~2:a)
+	5:tree:right/:$(git rev-parse topic:right)
+	5:tree:right/:$(git rev-parse base~1:right)
+	5:tree:right/:$(git rev-parse base~2:right)
+	6:blob:right/d:$(git rev-parse base~1:right/d)
+	7:blob:right/c:$(git rev-parse base~2:right/c)
+	7:blob:right/c:$(git rev-parse topic:right/c)
+	8:tree:left/:$(git rev-parse base:left)
+	8:tree:left/:$(git rev-parse base~2:left)
+	9:blob:left/b:$(git rev-parse base~2:left/b)
+	9:blob:left/b:$(git rev-parse base:left/b)
+	10:tree:a/:$(git rev-parse base:a)
+	11:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
+	12:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	13:blob:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
+	blobs:10
+	commits:4
+	tags:7
+	trees:13
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
+	0:blob:a:$(git rev-parse HEAD:a)
+	1:blob:left/b:$(git rev-parse HEAD:left/b)
+	2:blob:left/c:$(git rev-parse :left/c)
+	3:blob:right/c:$(git rev-parse HEAD:right/c)
+	4:blob:right/d:$(git rev-parse HEAD:right/d)
+	5:tree:right/:$(git rev-parse topic:right)
+	blobs:5
+	commits:0
+	tags:0
+	trees:1
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
 	cat >expect <<-EOF &&
 	0:commit::$(git rev-parse topic)
 	0:commit::$(git rev-parse base)
@@ -41,20 +154,23 @@ test_expect_success 'all' '
 	1:tree::$(git rev-parse base^{tree})
 	1:tree::$(git rev-parse base~1^{tree})
 	1:tree::$(git rev-parse base~2^{tree})
-	2:tree:right/:$(git rev-parse topic:right)
-	2:tree:right/:$(git rev-parse base~1:right)
-	2:tree:right/:$(git rev-parse base~2:right)
-	3:blob:right/d:$(git rev-parse base~1:right/d)
-	4:blob:right/c:$(git rev-parse base~2:right/c)
-	4:blob:right/c:$(git rev-parse topic:right/c)
-	5:tree:left/:$(git rev-parse base:left)
-	5:tree:left/:$(git rev-parse base~2:left)
-	6:blob:left/b:$(git rev-parse base~2:left/b)
-	6:blob:left/b:$(git rev-parse base:left/b)
-	7:blob:a:$(git rev-parse base~2:a)
-	blobs:6
+	2:blob:a:$(git rev-parse base~2:a)
+	3:tree:right/:$(git rev-parse topic:right)
+	3:tree:right/:$(git rev-parse base~1:right)
+	3:tree:right/:$(git rev-parse base~2:right)
+	4:blob:right/d:$(git rev-parse base~1:right/d)
+	4:blob:right/d:$(git rev-parse :right/d)
+	5:blob:right/c:$(git rev-parse base~2:right/c)
+	5:blob:right/c:$(git rev-parse topic:right/c)
+	6:tree:left/:$(git rev-parse base:left)
+	6:tree:left/:$(git rev-parse base~2:left)
+	7:blob:left/b:$(git rev-parse base:left/b)
+	7:blob:left/b:$(git rev-parse base~2:left/b)
+	8:tree:a/:$(git rev-parse refs/tags/third:a)
+	blobs:7
 	commits:4
-	trees:9
+	tags:0
+	trees:10
 	EOF
 
 	test_cmp_sorted expect out
@@ -81,6 +197,7 @@ test_expect_success 'topic only' '
 	7:blob:a:$(git rev-parse base~2:a)
 	blobs:5
 	commits:3
+	tags:0
 	trees:7
 	EOF
 
@@ -101,6 +218,7 @@ test_expect_success 'topic, not base' '
 	7:blob:a:$(git rev-parse topic:a)
 	blobs:4
 	commits:1
+	tags:0
 	trees:3
 	EOF
 
@@ -112,13 +230,14 @@ test_expect_success 'topic, not base, only blobs' '
 		-- topic --not base >out &&
 
 	cat >expect <<-EOF &&
-	commits:0
-	trees:0
 	0:blob:right/d:$(git rev-parse topic:right/d)
 	1:blob:right/c:$(git rev-parse topic:right/c)
 	2:blob:left/b:$(git rev-parse topic:left/b)
 	3:blob:a:$(git rev-parse topic:a)
 	blobs:4
+	commits:0
+	tags:0
+	trees:0
 	EOF
 
 	test_cmp_sorted expect out
@@ -133,8 +252,9 @@ test_expect_success 'topic, not base, only commits' '
 	cat >expect <<-EOF &&
 	0:commit::$(git rev-parse topic)
 	commits:1
-	trees:0
 	blobs:0
+	tags:0
+	trees:0
 	EOF
 
 	test_cmp_sorted expect out
@@ -145,12 +265,13 @@ test_expect_success 'topic, not base, only trees' '
 		-- topic --not base >out &&
 
 	cat >expect <<-EOF &&
-	commits:0
 	0:tree::$(git rev-parse topic^{tree})
 	1:tree:right/:$(git rev-parse topic:right)
 	2:tree:left/:$(git rev-parse topic:left)
-	trees:3
+	commits:0
 	blobs:0
+	tags:0
+	trees:3
 	EOF
 
 	test_cmp_sorted expect out
@@ -174,10 +295,33 @@ test_expect_success 'topic, not base, boundary' '
 	7:blob:a:$(git rev-parse base~1:a)
 	blobs:5
 	commits:2
+	tags:0
 	trees:5
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

