Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27481A262A
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731181286; cv=none; b=f+zFWjTbcjwqj9Tf/lk1kbuVibFObZ+nijwjynlFZsJYMyqDKZABQa1T3JFMkKRORU9hN1pO1As+jfgGfqt5h70VZcVGXy/6kV8wvQ0R72/pF9T2Ir4YSBxF7YsFAyJkcvH/7uA3xS0+XtsK/QE9840xrd+r5ysWMbviNHa1H4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731181286; c=relaxed/simple;
	bh=Ie08kIgiQaGBVuzd23wXE3upY+qBECOiNgI8xKAx6Pc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cCIgKop67m/Hf59iZWwtm8nW+v5erwCQHezzsx3SO9NYJyWdpNqB6mFlyp+mItz9z/dy2waHDmv74TlfExZ+5n8RpwGHPOIBnQrBlNlif7P0gxQhptvCqWpBJdKrEe63RuZmo4aKfEbhmDBkwXn1/MZCbERVLClZSpOejjDEkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbFmBk0A; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbFmBk0A"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so39811985e9.2
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 11:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731181282; x=1731786082; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLFT/VSU03/ZBWro0ppu7EqnscWtnVkhTdodi8DvWM8=;
        b=TbFmBk0AsCjAVCKDElVk5jvHSQrg8v7xQCwrzBSBhIgRq5G6gKmzt/77/aGbwFH3D0
         VSFfgDCYbmzIdgcvuPwDdT1mL2QjdFmafnI+YAMl4gdmjFOt6h+oNPGJ5gYEsLDK8u60
         HVwATNfAEl5zCHtfdAVP+YamMDXY1vphOEfS5VsrR4i4aIic9UKv8rDMAkKhylOjb6Ti
         HrNUbDj8lbUXC20cuTBjrx4O/+sHs3nxP1Mqu/EUICvBnGb+kJlqQnCoJZvV5PYmsu6U
         Bn4JcDB//bYO9Dd+WGH5maFzv6+ziwBsmvz+bz5VYCMl/0mRt4hxUu4zTABSPh4jjqXN
         CHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731181282; x=1731786082;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLFT/VSU03/ZBWro0ppu7EqnscWtnVkhTdodi8DvWM8=;
        b=msNmWsAsHWphB5nbRLyNVIwzGoj5O3ZVVtpWxyYu3qQiiNGry3rInO+KsrN0sHhVEr
         x6Mvdpgr9ddyZHLZbL/KMRdjuJfaC3eoUfsf4MAbh6KX2ypEmgZEZH2zKKhhdEy362OS
         Xpq7VHFffkMzSU0um+aRMFW7P2g6CBi2ZL2O+X4dNSZ3kb/SkgPVknc5BT0Jb7Sht+ja
         kmvts0d+Z7Gs3Ny4WeN0U9gs6y0jd1ra1jUmrDYoMnFumJlMI65xTOLXqxk273ulRQgi
         28K7e1vako+L0VaHfkO65Vqo+2Z8HQScXE/YxEk7Pj4n1+dlXS+bSDqoZL6l0FPSlZ7E
         rrRA==
X-Gm-Message-State: AOJu0Yx1OSln2W7J4JmtX5SYQAaFcPhJ4wzij6PY53XzjfagfPRQ79VK
	URURWBaIYf3TyIxza55RzYO/z9rWBwU0xTr/FZ6MRPbuz5AdEF+wuAXgaA==
X-Google-Smtp-Source: AGHT+IH/1ihuADUiZhfIJw2vQnEa62OIhD29OhkOOwLfuxAona6XkjQkcRtJO/d8/cIf+f+EJ03+mA==
X-Received: by 2002:a05:6000:385:b0:37d:4a16:81d7 with SMTP id ffacd0b85a97d-381f1866abfmr7151644f8f.8.1731181281787;
        Sat, 09 Nov 2024 11:41:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97ce1bsm8461567f8f.36.2024.11.09.11.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 11:41:20 -0800 (PST)
Message-Id: <a4aaa3b001b75c19c96130f1c057157a29f9a7f5.1731181273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
	<pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Nov 2024 19:41:12 +0000
Subject: [PATCH v2 6/6] path-walk: mark trees and blobs as UNINTERESTING
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
 t/helper/test-path-walk.c                 | 12 +++-
 t/t6601-path-walk.sh                      | 79 +++++++++++++++++------
 5 files changed, 158 insertions(+), 22 deletions(-)

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
index a1f539dcd46..896ec0c4779 100644
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
 
@@ -167,6 +172,43 @@ static int walk_path(struct path_walk_context *ctx,
 	if (!list->oids.nr)
 		return 0;
 
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
@@ -201,6 +243,26 @@ static void clear_strmap(struct strmap *map)
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
@@ -309,6 +371,7 @@ static void setup_pending_objects(struct path_walk_info *info,
 		if (tagged_blobs->oids.nr) {
 			const char *tagged_blob_path = "/tagged-blobs";
 			tagged_blobs->type = OBJ_BLOB;
+			tagged_blobs->maybe_interesting = 1;
 			push_to_stack(ctx, tagged_blob_path);
 			strmap_put(&ctx->paths_to_lists, tagged_blob_path, tagged_blobs);
 		} else {
@@ -320,6 +383,7 @@ static void setup_pending_objects(struct path_walk_info *info,
 		if (tags->oids.nr) {
 			const char *tag_path = "/tags";
 			tags->type = OBJ_TAG;
+			tags->maybe_interesting = 1;
 			push_to_stack(ctx, tag_path);
 			strmap_put(&ctx->paths_to_lists, tag_path, tags);
 		} else {
@@ -362,6 +426,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
+	root_tree_list->maybe_interesting = 1;
 	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
 	push_to_stack(&ctx, root_path);
 
@@ -375,6 +440,14 @@ int walk_objects_by_path(struct path_walk_info *info)
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
index 265bd0b443b..7e791cfaf97 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -62,10 +62,14 @@ static int emit_block(const char *path, struct oid_array *oids,
 		printf("%"PRIuMAX":%s:%s:EMPTY\n",
 		       tdata->batch_nr, typestr, path);
 
-	for (size_t i = 0; i < oids->nr; i++)
-		printf("%"PRIuMAX":%s:%s:%s\n",
+	for (size_t i = 0; i < oids->nr; i++) {
+		struct object *o = lookup_unknown_object(the_repository,
+							 &oids->oid[i]);
+		printf("%"PRIuMAX":%s:%s:%s%s\n",
 		       tdata->batch_nr, typestr, path,
-		       oid_to_hex(&oids->oid[i]));
+		       oid_to_hex(&oids->oid[i]),
+		       o->flags & UNINTERESTING ? ":UNINTERESTING" : "");
+	}
 
 	tdata->batch_nr++;
 	return 0;
@@ -86,6 +90,8 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle inclusion of tag objects")),
 		OPT_BOOL(0, "trees", &info.trees,
 			 N_("toggle inclusion of tree objects")),
+		OPT_BOOL(0, "prune", &info.prune_all_uninteresting,
+			 N_("toggle pruning of uninteresting paths")),
 		OPT_END(),
 	};
 
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index bf43ab0e22a..d3c0015319a 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -211,11 +211,11 @@ test_expect_success 'topic, not base' '
 	0:COMMIT::$(git rev-parse topic)
 	1:TREE::$(git rev-parse topic^{tree})
 	2:TREE:right/:$(git rev-parse topic:right)
-	3:BLOB:right/d:$(git rev-parse topic:right/d)
+	3:BLOB:right/d:$(git rev-parse topic:right/d):UNINTERESTING
 	4:BLOB:right/c:$(git rev-parse topic:right/c)
-	5:TREE:left/:$(git rev-parse topic:left)
-	6:BLOB:left/b:$(git rev-parse topic:left/b)
-	7:BLOB:a:$(git rev-parse topic:a)
+	5:TREE:left/:$(git rev-parse topic:left):UNINTERESTING
+	6:BLOB:left/b:$(git rev-parse topic:left/b):UNINTERESTING
+	7:BLOB:a:$(git rev-parse topic:a):UNINTERESTING
 	blobs:4
 	commits:1
 	tags:0
@@ -225,15 +225,38 @@ test_expect_success 'topic, not base' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'fourth, blob-tag2, not base' '
+	test-tool path-walk -- fourth blob-tag2 --not base >out &&
+
+	cat >expect <<-EOF &&
+	0:COMMIT::$(git rev-parse topic)
+	1:TAG:/tags:$(git rev-parse fourth)
+	2:BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	3:TREE::$(git rev-parse topic^{tree})
+	4:TREE:right/:$(git rev-parse topic:right)
+	5:BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
+	6:BLOB:right/c:$(git rev-parse topic:right/c)
+	7:TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
+	8:BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
+	9:BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
+	blobs:5
+	commits:1
+	tags:1
+	trees:3
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_expect_success 'topic, not base, only blobs' '
 	test-tool path-walk --no-trees --no-commits \
 		-- topic --not base >out &&
 
 	cat >expect <<-EOF &&
-	0:BLOB:right/d:$(git rev-parse topic:right/d)
+	0:BLOB:right/d:$(git rev-parse topic:right/d):UNINTERESTING
 	1:BLOB:right/c:$(git rev-parse topic:right/c)
-	2:BLOB:left/b:$(git rev-parse topic:left/b)
-	3:BLOB:a:$(git rev-parse topic:a)
+	2:BLOB:left/b:$(git rev-parse topic:left/b):UNINTERESTING
+	3:BLOB:a:$(git rev-parse topic:a):UNINTERESTING
 	blobs:4
 	commits:0
 	tags:0
@@ -267,7 +290,7 @@ test_expect_success 'topic, not base, only trees' '
 	cat >expect <<-EOF &&
 	0:TREE::$(git rev-parse topic^{tree})
 	1:TREE:right/:$(git rev-parse topic:right)
-	2:TREE:left/:$(git rev-parse topic:left)
+	2:TREE:left/:$(git rev-parse topic:left):UNINTERESTING
 	commits:0
 	blobs:0
 	tags:0
@@ -282,17 +305,17 @@ test_expect_success 'topic, not base, boundary' '
 
 	cat >expect <<-EOF &&
 	0:COMMIT::$(git rev-parse topic)
-	0:COMMIT::$(git rev-parse base~1)
+	0:COMMIT::$(git rev-parse base~1):UNINTERESTING
 	1:TREE::$(git rev-parse topic^{tree})
-	1:TREE::$(git rev-parse base~1^{tree})
+	1:TREE::$(git rev-parse base~1^{tree}):UNINTERESTING
 	2:TREE:right/:$(git rev-parse topic:right)
-	2:TREE:right/:$(git rev-parse base~1:right)
-	3:BLOB:right/d:$(git rev-parse base~1:right/d)
-	4:BLOB:right/c:$(git rev-parse base~1:right/c)
+	2:TREE:right/:$(git rev-parse base~1:right):UNINTERESTING
+	3:BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
+	4:BLOB:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
 	4:BLOB:right/c:$(git rev-parse topic:right/c)
-	5:TREE:left/:$(git rev-parse base~1:left)
-	6:BLOB:left/b:$(git rev-parse base~1:left/b)
-	7:BLOB:a:$(git rev-parse base~1:a)
+	5:TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
+	6:BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
+	7:BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
 	blobs:5
 	commits:2
 	tags:0
@@ -302,6 +325,27 @@ test_expect_success 'topic, not base, boundary' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'topic, not base, boundary with pruning' '
+	test-tool path-walk --prune -- --boundary topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	0:COMMIT::$(git rev-parse topic)
+	0:COMMIT::$(git rev-parse base~1):UNINTERESTING
+	1:TREE::$(git rev-parse topic^{tree})
+	1:TREE::$(git rev-parse base~1^{tree}):UNINTERESTING
+	2:TREE:right/:$(git rev-parse topic:right)
+	2:TREE:right/:$(git rev-parse base~1:right):UNINTERESTING
+	3:BLOB:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
+	3:BLOB:right/c:$(git rev-parse topic:right/c)
+	blobs:2
+	commits:2
+	tags:0
+	trees:4
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_expect_success 'trees are reported exactly once' '
 	test_when_finished "rm -rf unique-trees" &&
 	test_create_repo unique-trees &&
@@ -309,15 +353,12 @@ test_expect_success 'trees are reported exactly once' '
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
