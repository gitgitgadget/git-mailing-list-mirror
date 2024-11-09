Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1D31A0BFA
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731181285; cv=none; b=e0vsHvq5DusTmVDfpbeCCRLMSVYxWyM8VCZtCqkmQNpPwCoE9dgiqzxoTdSn/ASEiIGaCgNmnNBZPi+WRpcPIKf8gOKuex8orR0nHlnykTs/qw13aq+sX6H1quPYIL2hK5gKMAGvMqzwY0hajP18DX1YYS023fVpEM4kkov+yYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731181285; c=relaxed/simple;
	bh=cBo6LQnLjMBu6wYkUXSZ7v7LeeOQQCAfgHPaWMvQjpE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G7+/tca301/SvTwpUKhh5mDJoSTJaIXkk0NB8KFXJanE7U3Mam679eERpVOg3WGxaOYFLKaBwH8iTgRu9gyKIrQ2OQBuMVFfg+BHvloPx/TWXMA0lkq/XLon7EsvRkxqoPJ1wEbjxyNTvdwP275OlxH1qwSOJxOmN8GMDIUM5fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpC2LbNT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpC2LbNT"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315abed18aso28105865e9.2
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 11:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731181280; x=1731786080; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAOYMZE/i6Tnnwnx6VOYfCVwAyAEBg28V79fWYt3h+Q=;
        b=VpC2LbNTKkD20gk+TRuFcOi7jyuTQsvcGhrBHmdDEprzMX+YA4RWrjA2XoKWEHymgE
         dpTPTClYhjjgASDiL8EAPbdGlMaS1Ed1D2WrTPPYg4pHp++UMEcKRti2EPl8n3nEFwlh
         P5NpBUdXoJuFQZBKsV+LX+TMrGAE57dvzA/gvFTEeyyMMd7twoKFGlq0uOTLap4InwS+
         qq9aIZdt79tDOYft0Cpax5BGQxC15J6SPqkvoQrTFYuQsuSaSugD6D/Y2Z2M1wKUhcTL
         7VaWspuFfNrQ2g5F6QHWh6zPiSIED4nhPlVxeOiZIL1Z0sYSyowFCSPU+j0oDFBeeg+6
         fB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731181280; x=1731786080;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAOYMZE/i6Tnnwnx6VOYfCVwAyAEBg28V79fWYt3h+Q=;
        b=XaG78b0uojF9cvPOj3JbAevCNOycoqtCxNTEGgvAfXVwwNGaXGnke4g8v3sjIo8RFO
         jutPIXv+4tNYUDSFJZtQobbqbGLRiSZCG9PutPHM+ihMFVdBM6k4r2YZddF298IEe/tv
         F4i1NDvN9f83s515TQ03XFfpfK7CD+R1MtAeoDJfbco/gO7VDCxEudDlQcMY+2XK9QXd
         7CP30FyTd/tOR9mcDGuOz7cNwALXI2yUpH3cIOAdgl/r96tqPtr+HCJMxgsFZf/v5V3L
         5j4FAbo4sEjeaXThy0+B3pIUF2UQyLkZFceTGZI29nxQ5eVLZP0uWOdSl7FX1b6bY9TR
         KkFw==
X-Gm-Message-State: AOJu0YywTOtXr5+8LarZi6+Bqla8scW415LHl00OirIvy45sr/7M1H3X
	FzdZdGJ2s9RTL5tUFbyYQP9MGwrshdsnG1c9iyG+BJemPwlhOJl3OEnotw==
X-Google-Smtp-Source: AGHT+IHSaflgwNQT6t0ONKzNEM2+GvPBfwVPR3FtIeSQmk5CI6BCXXggSwgSVG3lNI6EeOvJT+F5JA==
X-Received: by 2002:a05:600c:3b9d:b0:431:612f:189b with SMTP id 5b1f17b1804b1-432b7505ae9mr65057435e9.12.1731181280147;
        Sat, 09 Nov 2024 11:41:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea7c3sm8690512f8f.80.2024.11.09.11.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 11:41:19 -0800 (PST)
Message-Id: <97765aa04c2fe4a254a93814a6e0de14fa4f9149.1731181273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
	<pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Nov 2024 19:41:11 +0000
Subject: [PATCH v2 5/6] path-walk: visit tags and cached objects
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
 t/helper/test-path-walk.c                 |  18 ++-
 t/t6601-path-walk.sh                      | 186 +++++++++++++++++++---
 5 files changed, 356 insertions(+), 26 deletions(-)

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
index 2b7e6e98d18..265bd0b443b 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -23,6 +23,7 @@ struct path_walk_test_data {
 	uintmax_t commit_nr;
 	uintmax_t tree_nr;
 	uintmax_t blob_nr;
+	uintmax_t tag_nr;
 };
 
 static int emit_block(const char *path, struct oid_array *oids,
@@ -47,10 +48,20 @@ static int emit_block(const char *path, struct oid_array *oids,
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
 
+	/* This should never be output during tests. */
+	if (!oids->nr)
+		printf("%"PRIuMAX":%s:%s:EMPTY\n",
+		       tdata->batch_nr, typestr, path);
+
 	for (size_t i = 0; i < oids->nr; i++)
 		printf("%"PRIuMAX":%s:%s:%s\n",
 		       tdata->batch_nr, typestr, path,
@@ -71,6 +82,8 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle inclusion of blob objects")),
 		OPT_BOOL(0, "commits", &info.commits,
 			 N_("toggle inclusion of commit objects")),
+		OPT_BOOL(0, "tags", &info.tags,
+			 N_("toggle inclusion of tag objects")),
 		OPT_BOOL(0, "trees", &info.trees,
 			 N_("toggle inclusion of tree objects")),
 		OPT_END(),
@@ -96,8 +109,9 @@ int cmd__path_walk(int argc, const char **argv)
 
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
index dcd3c03a2e8..bf43ab0e22a 100755
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
+	0:COMMIT::$(git rev-parse topic)
+	0:COMMIT::$(git rev-parse base)
+	0:COMMIT::$(git rev-parse base~1)
+	0:COMMIT::$(git rev-parse base~2)
+	1:TAG:/tags:$(git rev-parse refs/tags/first)
+	1:TAG:/tags:$(git rev-parse refs/tags/second.1)
+	1:TAG:/tags:$(git rev-parse refs/tags/second.2)
+	1:TAG:/tags:$(git rev-parse refs/tags/third)
+	1:TAG:/tags:$(git rev-parse refs/tags/fourth)
+	1:TAG:/tags:$(git rev-parse refs/tags/tree-tag)
+	1:TAG:/tags:$(git rev-parse refs/tags/blob-tag)
+	2:BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	2:BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	3:TREE::$(git rev-parse topic^{tree})
+	3:TREE::$(git rev-parse base^{tree})
+	3:TREE::$(git rev-parse base~1^{tree})
+	3:TREE::$(git rev-parse base~2^{tree})
+	3:TREE::$(git rev-parse refs/tags/tree-tag^{})
+	3:TREE::$(git rev-parse refs/tags/tree-tag2^{})
+	4:BLOB:a:$(git rev-parse base~2:a)
+	5:TREE:right/:$(git rev-parse topic:right)
+	5:TREE:right/:$(git rev-parse base~1:right)
+	5:TREE:right/:$(git rev-parse base~2:right)
+	6:BLOB:right/d:$(git rev-parse base~1:right/d)
+	7:BLOB:right/c:$(git rev-parse base~2:right/c)
+	7:BLOB:right/c:$(git rev-parse topic:right/c)
+	8:TREE:left/:$(git rev-parse base:left)
+	8:TREE:left/:$(git rev-parse base~2:left)
+	9:BLOB:left/b:$(git rev-parse base~2:left/b)
+	9:BLOB:left/b:$(git rev-parse base:left/b)
+	10:TREE:a/:$(git rev-parse base:a)
+	11:BLOB:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
+	12:TREE:child/:$(git rev-parse refs/tags/tree-tag:child)
+	13:BLOB:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
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
+	0:BLOB:a:$(git rev-parse HEAD:a)
+	1:BLOB:left/b:$(git rev-parse HEAD:left/b)
+	2:BLOB:left/c:$(git rev-parse :left/c)
+	3:BLOB:right/c:$(git rev-parse HEAD:right/c)
+	4:BLOB:right/d:$(git rev-parse HEAD:right/d)
+	5:TREE:right/:$(git rev-parse topic:right)
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
 	0:COMMIT::$(git rev-parse topic)
 	0:COMMIT::$(git rev-parse base)
@@ -41,20 +154,23 @@ test_expect_success 'all' '
 	1:TREE::$(git rev-parse base^{tree})
 	1:TREE::$(git rev-parse base~1^{tree})
 	1:TREE::$(git rev-parse base~2^{tree})
-	2:TREE:right/:$(git rev-parse topic:right)
-	2:TREE:right/:$(git rev-parse base~1:right)
-	2:TREE:right/:$(git rev-parse base~2:right)
-	3:BLOB:right/d:$(git rev-parse base~1:right/d)
-	4:BLOB:right/c:$(git rev-parse base~2:right/c)
-	4:BLOB:right/c:$(git rev-parse topic:right/c)
-	5:TREE:left/:$(git rev-parse base:left)
-	5:TREE:left/:$(git rev-parse base~2:left)
-	6:BLOB:left/b:$(git rev-parse base~2:left/b)
-	6:BLOB:left/b:$(git rev-parse base:left/b)
-	7:BLOB:a:$(git rev-parse base~2:a)
-	blobs:6
+	2:BLOB:a:$(git rev-parse base~2:a)
+	3:TREE:right/:$(git rev-parse topic:right)
+	3:TREE:right/:$(git rev-parse base~1:right)
+	3:TREE:right/:$(git rev-parse base~2:right)
+	4:BLOB:right/d:$(git rev-parse base~1:right/d)
+	4:BLOB:right/d:$(git rev-parse :right/d)
+	5:BLOB:right/c:$(git rev-parse base~2:right/c)
+	5:BLOB:right/c:$(git rev-parse topic:right/c)
+	6:TREE:left/:$(git rev-parse base:left)
+	6:TREE:left/:$(git rev-parse base~2:left)
+	7:BLOB:left/b:$(git rev-parse base:left/b)
+	7:BLOB:left/b:$(git rev-parse base~2:left/b)
+	8:TREE:a/:$(git rev-parse refs/tags/third:a)
+	blobs:7
 	commits:4
-	trees:9
+	tags:0
+	trees:10
 	EOF
 
 	test_cmp_sorted expect out
@@ -81,6 +197,7 @@ test_expect_success 'topic only' '
 	7:BLOB:a:$(git rev-parse base~2:a)
 	blobs:5
 	commits:3
+	tags:0
 	trees:7
 	EOF
 
@@ -101,6 +218,7 @@ test_expect_success 'topic, not base' '
 	7:BLOB:a:$(git rev-parse topic:a)
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
 	0:BLOB:right/d:$(git rev-parse topic:right/d)
 	1:BLOB:right/c:$(git rev-parse topic:right/c)
 	2:BLOB:left/b:$(git rev-parse topic:left/b)
 	3:BLOB:a:$(git rev-parse topic:a)
 	blobs:4
+	commits:0
+	tags:0
+	trees:0
 	EOF
 
 	test_cmp_sorted expect out
@@ -133,8 +252,9 @@ test_expect_success 'topic, not base, only commits' '
 	cat >expect <<-EOF &&
 	0:COMMIT::$(git rev-parse topic)
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
 	0:TREE::$(git rev-parse topic^{tree})
 	1:TREE:right/:$(git rev-parse topic:right)
 	2:TREE:left/:$(git rev-parse topic:left)
-	trees:3
+	commits:0
 	blobs:0
+	tags:0
+	trees:3
 	EOF
 
 	test_cmp_sorted expect out
@@ -174,10 +295,33 @@ test_expect_success 'topic, not base, boundary' '
 	7:BLOB:a:$(git rev-parse base~1:a)
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

