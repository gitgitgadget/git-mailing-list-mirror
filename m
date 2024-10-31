Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35BD1474BF
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356036; cv=none; b=UWONSyDMzyQogWIy9iGZjhf64jwrRXZvEyDrxEaopoSuQyGL5fciEfyYfVlB5ETOjHpkNzysCbp1EJUk2Htl9ae++Bh1kYkaP2fGub3lY2KucAsfegiOTjevL8g5y0yjBpwnEFFZ8erkWMQbQBi9+eYZ5Em9pFhdJHrYBhi3oBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356036; c=relaxed/simple;
	bh=G2QpZZTHAr6sWqMaRLACpSSeZjJdMzibY3FpF0lYmr0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LKZEGYuq3x4V4rLGMALB5eD5sMyJpWmbbKN/8UnTUindAewotV3ugYXZDCKSu0A7f4Dg9l5zr+SnVHro7MFLetGwqTgIw1+FFmz8wr5YQEelF69YkEfjSg2bFbVsi/W8WYjhBfbVefwuWPGQ+NXV/CLhjs6HmVft8n9SEmCjSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqiYSWyp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqiYSWyp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43158625112so4647945e9.3
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 23:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730356032; x=1730960832; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvMdu6UnVHlDvqMYzqd3RYebVHHIzqrP4+x3NYdYYVQ=;
        b=EqiYSWypW1MZcNl45sNXBprrzAGD5YItEjNyfV+lEfVM0rGN4Afxq/WQcp2ARn9KZf
         kvKq4XKJMse7OPl5OqfNXw8GPcgu53aImZXkSZ49a49n9nbybci6klWz1+z2LOK2U1LA
         oadFB6KYICvhwk+IQdGxMtP6b/vx+B3zJ/4x5YG3nglt5W+HdRS2MV0jOXjj+ATGoW2D
         qu5NMIb/l1FM6817MhkPKz4hZ5L26urp4HYgtPm71DC4o+gcgSlIkC1ULQ+3drZVqNib
         ljvGEpYP4Un4jRkeKohi8PW0zUcBbweHF+ZilGYInVctGWDpF3O8G1L2zLkH9nuzHBFd
         yc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730356032; x=1730960832;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvMdu6UnVHlDvqMYzqd3RYebVHHIzqrP4+x3NYdYYVQ=;
        b=pvUe5dxBLjlsVz7fxDVurbLskWEtlzQ3KZP25nfwYcUk2SgcHtuKoXu7ch5w//4yFK
         0pCL/y3E073SZ8dqacK7Ss5PBlme2ho2mcUr0Ls1F4nTfbN7CsUNg3TIXqJqLKJzt2vX
         PSkeMQisRHGnZaNQRHqWg3ejkkLRx0G1n3C4WCbv+Rxb48ES1a5xEAwEqydC32oC3uaJ
         qnKSXQfpl1YC9rBUVgEUCH43gXxcPAZUpXuwaPI2Jg+PKvk3q+hu1/o6f4LAely7sRoh
         7JL7DyywHH5qwaBWU2CcnNOQcAA3U2IAPd/bUFwcE+xwEVo4EftgPY1KE/C9FRlPzSTh
         43PA==
X-Gm-Message-State: AOJu0YxWpHogAUPv9JPkvG4RRV5Xxevcloy8Q02JWITCJ14wdjUI/3wG
	/9PZsSzYLMVleWTS5yPJrqdyO3o5h17neaz8ZHqdiFur1R+Z6yLyT1oKbg==
X-Google-Smtp-Source: AGHT+IHyRpmqDbU3yESYVikG6j0BANlUsseei/0SqsmnB6Iwjw6QKww4klbaCFfI6wYdHkZelL6yhQ==
X-Received: by 2002:a05:600c:1c88:b0:431:5f3b:6ae4 with SMTP id 5b1f17b1804b1-4319acac1camr186397765e9.17.1730356031463;
        Wed, 30 Oct 2024 23:27:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c1esm1047351f8f.12.2024.10.30.23.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:27:11 -0700 (PDT)
Message-Id: <0bb607e1fd31ad2c6c358a444bd4740c10e15d61.1730356023.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 31 Oct 2024 06:27:03 +0000
Subject: [PATCH 6/6] path-walk: mark trees and blobs as UNINTERESTING
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

When the input rev_info has UNINTERESTING starting points, we want to be
sure that the UNINTERESTING flag is passed appropriately through the
objects. To match how this is done in places such as 'git pack-objects', we
use the mark_edges_uninteresting() method.

This method has an option for using the "sparse" walk, which is similar in
spirit to the path-walk API's walk. To be sure to keep it independent, add a
new 'prune_all_uninteresting' option to the path_walk_info struct.

To check how the UNINTERSTING flag is spread through our objects, extend the
'test-tool path-walk' command to output whether or not an object has that
flag. This changes our tests significantly, including the removal of some
objects that were previously visited due to the incomplete implementation.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.txt |  8 +++
 path-walk.c                               | 73 +++++++++++++++++++++
 path-walk.h                               |  8 +++
 t/helper/test-path-walk.c                 | 10 ++-
 t/t6601-path-walk.sh                      | 79 +++++++++++++++++------
 5 files changed, 157 insertions(+), 21 deletions(-)

diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index 6022c381b7c..7075d0d5ab5 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -48,6 +48,14 @@ commits.
 While it is possible to walk only commits in this way, consumers would be
 better off using the revision walk API instead.
 
+`prune_all_uninteresting`::
+	By default, all reachable paths are emitted by the path-walk API.
+	This option allows consumers to declare that they are not
+	interested in paths where all included objects are marked with the
+	`UNINTERESTING` flag. This requires using the `boundary` option in
+	the revision walk so that the walk emits commits marked with the
+	`UNINTERESTING` flag.
+
 Examples
 --------
 
diff --git a/path-walk.c b/path-walk.c
index eca0e5f3d5b..6f658c28307 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -8,6 +8,7 @@
 #include "dir.h"
 #include "hashmap.h"
 #include "hex.h"
+#include "list-objects.h"
 #include "object.h"
 #include "oid-array.h"
 #include "revision.h"
@@ -24,6 +25,7 @@ struct type_and_oid_list
 {
 	enum object_type type;
 	struct oid_array oids;
+	int maybe_interesting;
 };
 
 #define TYPE_AND_OID_LIST_INIT { \
@@ -140,6 +142,9 @@ static int add_children(struct path_walk_context *ctx,
 		if (o->flags & SEEN)
 			continue;
 		o->flags |= SEEN;
+
+		if (!(o->flags & UNINTERESTING))
+			list->maybe_interesting = 1;
 		oid_array_append(&list->oids, &entry.oid);
 	}
 
@@ -164,6 +169,43 @@ static int walk_path(struct path_walk_context *ctx,
 	if (!list)
 		BUG("provided path '%s' that had no associated list", path);
 
+	if (ctx->info->prune_all_uninteresting) {
+		/*
+		 * This is true if all objects were UNINTERESTING
+		 * when added to the list.
+		 */
+		if (!list->maybe_interesting)
+			return 0;
+
+		/*
+		 * But it's still possible that the objects were set
+		 * as UNINTERESTING after being added. Do a quick check.
+		 */
+		list->maybe_interesting = 0;
+		for (size_t i = 0;
+		     !list->maybe_interesting && i < list->oids.nr;
+		     i++) {
+			if (list->type == OBJ_TREE) {
+				struct tree *t = lookup_tree(ctx->repo,
+							     &list->oids.oid[i]);
+				if (t && !(t->object.flags & UNINTERESTING))
+					list->maybe_interesting = 1;
+			} else if (list->type == OBJ_BLOB) {
+				struct blob *b = lookup_blob(ctx->repo,
+							     &list->oids.oid[i]);
+				if (b && !(b->object.flags & UNINTERESTING))
+					list->maybe_interesting = 1;
+			} else {
+				/* Tags are always interesting if visited. */
+				list->maybe_interesting = 1;
+			}
+		}
+
+		/* We have confirmed that all objects are UNINTERESTING. */
+		if (!list->maybe_interesting)
+			return 0;
+	}
+
 	/* Evaluate function pointer on this data, if requested. */
 	if ((list->type == OBJ_TREE && ctx->info->trees) ||
 	    (list->type == OBJ_BLOB && ctx->info->blobs) ||
@@ -198,6 +240,26 @@ static void clear_strmap(struct strmap *map)
 	strmap_init(map);
 }
 
+static struct repository *edge_repo;
+static struct type_and_oid_list *edge_tree_list;
+
+static void show_edge(struct commit *commit)
+{
+	struct tree *t = repo_get_commit_tree(edge_repo, commit);
+
+	if (!t)
+		return;
+
+	if (commit->object.flags & UNINTERESTING)
+		t->object.flags |= UNINTERESTING;
+
+	if (t->object.flags & SEEN)
+		return;
+	t->object.flags |= SEEN;
+
+	oid_array_append(&edge_tree_list->oids, &t->object.oid);
+}
+
 static void setup_pending_objects(struct path_walk_info *info,
 				  struct path_walk_context *ctx)
 {
@@ -306,6 +368,7 @@ static void setup_pending_objects(struct path_walk_info *info,
 		if (tagged_blobs->oids.nr) {
 			const char *tagged_blob_path = "/tagged-blobs";
 			tagged_blobs->type = OBJ_BLOB;
+			tagged_blobs->maybe_interesting = 1;
 			push_to_stack(ctx, tagged_blob_path);
 			strmap_put(&ctx->paths_to_lists, tagged_blob_path, tagged_blobs);
 		} else {
@@ -317,6 +380,7 @@ static void setup_pending_objects(struct path_walk_info *info,
 		if (tags->oids.nr) {
 			const char *tag_path = "/tags";
 			tags->type = OBJ_TAG;
+			tags->maybe_interesting = 1;
 			push_to_stack(ctx, tag_path);
 			strmap_put(&ctx->paths_to_lists, tag_path, tags);
 		} else {
@@ -359,6 +423,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
+	root_tree_list->maybe_interesting = 1;
 	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
 	push_to_stack(&ctx, root_path);
 
@@ -372,6 +437,14 @@ int walk_objects_by_path(struct path_walk_info *info)
 	if (prepare_revision_walk(info->revs))
 		die(_("failed to setup revision walk"));
 
+	/* Walk trees to mark them as UNINTERESTING. */
+	edge_repo = info->revs->repo;
+	edge_tree_list = root_tree_list;
+	mark_edges_uninteresting(info->revs, show_edge,
+				 info->prune_all_uninteresting);
+	edge_repo = NULL;
+	edge_tree_list = NULL;
+
 	info->revs->blob_objects = info->revs->tree_objects = 0;
 
 	trace2_region_enter("path-walk", "pending-walk", info->revs->repo);
diff --git a/path-walk.h b/path-walk.h
index ca839f873e4..de0db007dc9 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -39,6 +39,14 @@ struct path_walk_info {
 	int trees;
 	int blobs;
 	int tags;
+
+	/**
+	 * When 'prune_all_uninteresting' is set and a path has all objects
+	 * marked as UNINTERESTING, then the path-walk will not visit those
+	 * objects. It will not call path_fn on those objects and will not
+	 * walk the children of such trees.
+	 */
+	int prune_all_uninteresting;
 };
 
 #define PATH_WALK_INFO_INIT {   \
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index c6c60d68749..06b103d8760 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -55,8 +55,12 @@ static int emit_block(const char *path, struct oid_array *oids,
 		BUG("we do not understand this type");
 	}
 
-	for (size_t i = 0; i < oids->nr; i++)
-		printf("%s:%s:%s\n", typestr, path, oid_to_hex(&oids->oid[i]));
+	for (size_t i = 0; i < oids->nr; i++) {
+		struct object *o = lookup_unknown_object(the_repository,
+							 &oids->oid[i]);
+		printf("%s:%s:%s%s\n", typestr, path, oid_to_hex(&oids->oid[i]),
+		       o->flags & UNINTERESTING ? ":UNINTERESTING" : "");
+	}
 
 	return 0;
 }
@@ -76,6 +80,8 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle inclusion of tag objects")),
 		OPT_BOOL(0, "trees", &info.trees,
 			 N_("toggle inclusion of tree objects")),
+		OPT_BOOL(0, "prune", &info.prune_all_uninteresting,
+			 N_("toggle pruning of uninteresting paths")),
 		OPT_END(),
 	};
 
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 5ed6c79fbd1..a561c21d484 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -209,13 +209,13 @@ test_expect_success 'topic, not base' '
 	COMMIT::$(git rev-parse topic)
 	commits:1
 	TREE::$(git rev-parse topic^{tree})
-	TREE:left/:$(git rev-parse topic:left)
+	TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
 	TREE:right/:$(git rev-parse topic:right)
 	trees:3
-	BLOB:a:$(git rev-parse topic:a)
-	BLOB:left/b:$(git rev-parse topic:left/b)
+	BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
+	BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
 	BLOB:right/c:$(git rev-parse topic:right/c)
-	BLOB:right/d:$(git rev-parse topic:right/d)
+	BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
 	blobs:4
 	tags:0
 	EOF
@@ -223,6 +223,29 @@ test_expect_success 'topic, not base' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'fourth, blob-tag2, not base' '
+	test-tool path-walk -- fourth blob-tag2 --not base >out &&
+
+	cat >expect <<-EOF &&
+	COMMIT::$(git rev-parse topic)
+	commits:1
+	TREE::$(git rev-parse topic^{tree})
+	TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
+	TREE:right/:$(git rev-parse topic:right)
+	trees:3
+	BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
+	BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
+	BLOB:right/c:$(git rev-parse topic:right/c)
+	BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
+	BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	blobs:5
+	TAG:/tags:$(git rev-parse fourth)
+	tags:1
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_expect_success 'topic, not base, only blobs' '
 	test-tool path-walk --no-trees --no-commits \
 		-- topic --not base >out &&
@@ -230,10 +253,10 @@ test_expect_success 'topic, not base, only blobs' '
 	cat >expect <<-EOF &&
 	commits:0
 	trees:0
-	BLOB:a:$(git rev-parse topic:a)
-	BLOB:left/b:$(git rev-parse topic:left/b)
+	BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
+	BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
 	BLOB:right/c:$(git rev-parse topic:right/c)
-	BLOB:right/d:$(git rev-parse topic:right/d)
+	BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
 	blobs:4
 	tags:0
 	EOF
@@ -265,7 +288,7 @@ test_expect_success 'topic, not base, only trees' '
 	cat >expect <<-EOF &&
 	commits:0
 	TREE::$(git rev-parse topic^{tree})
-	TREE:left/:$(git rev-parse topic:left)
+	TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
 	TREE:right/:$(git rev-parse topic:right)
 	trees:3
 	blobs:0
@@ -280,19 +303,19 @@ test_expect_success 'topic, not base, boundary' '
 
 	cat >expect <<-EOF &&
 	COMMIT::$(git rev-parse topic)
-	COMMIT::$(git rev-parse base~1)
+	COMMIT::$(git rev-parse base~1):UNINTERESTING
 	commits:2
 	TREE::$(git rev-parse topic^{tree})
-	TREE::$(git rev-parse base~1^{tree})
-	TREE:left/:$(git rev-parse base~1:left)
+	TREE::$(git rev-parse base~1^{tree}):UNINTERESTING
+	TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
 	TREE:right/:$(git rev-parse topic:right)
-	TREE:right/:$(git rev-parse base~1:right)
+	TREE:right/:$(git rev-parse base~1:right):UNINTERESTING
 	trees:5
-	BLOB:a:$(git rev-parse base~1:a)
-	BLOB:left/b:$(git rev-parse base~1:left/b)
-	BLOB:right/c:$(git rev-parse base~1:right/c)
+	BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
+	BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
+	BLOB:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
 	BLOB:right/c:$(git rev-parse topic:right/c)
-	BLOB:right/d:$(git rev-parse base~1:right/d)
+	BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
 	blobs:5
 	tags:0
 	EOF
@@ -300,6 +323,27 @@ test_expect_success 'topic, not base, boundary' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'topic, not base, boundary with pruning' '
+	test-tool path-walk --prune -- --boundary topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	COMMIT::$(git rev-parse topic)
+	COMMIT::$(git rev-parse base~1):UNINTERESTING
+	commits:2
+	TREE::$(git rev-parse topic^{tree})
+	TREE::$(git rev-parse base~1^{tree}):UNINTERESTING
+	TREE:right/:$(git rev-parse topic:right)
+	TREE:right/:$(git rev-parse base~1:right):UNINTERESTING
+	trees:4
+	BLOB:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
+	BLOB:right/c:$(git rev-parse topic:right/c)
+	blobs:2
+	tags:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_expect_success 'trees are reported exactly once' '
 	test_when_finished "rm -rf unique-trees" &&
 	test_create_repo unique-trees &&
@@ -307,15 +351,12 @@ test_expect_success 'trees are reported exactly once' '
 		cd unique-trees &&
 		mkdir initial &&
 		test_commit initial/file &&
-
 		git switch -c move-to-top &&
 		git mv initial/file.t ./ &&
 		test_tick &&
 		git commit -m moved &&
-
 		git update-ref refs/heads/other HEAD
 	) &&
-
 	test-tool -C unique-trees path-walk -- --all >out &&
 	tree=$(git -C unique-trees rev-parse HEAD:) &&
 	grep "$tree" out >out-filtered &&
-- 
gitgitgadget
