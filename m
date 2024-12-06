Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA1201023
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514370; cv=none; b=rfflaPcSBaeD1XEH+dBa10TJ4Aa0DsWT2rgBJFQDpxwkTmwPxZ/FXivObG0FALc8y4bDDWG2vvCu9pFK7E96IE7fBPIW75u/y1FoMZ9B0lxeJoIgUtZzR1lHownEhKBrk9ZIyIyFsm45MzxRXa+BLodYge4tIc4i2IjK2zpJwh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514370; c=relaxed/simple;
	bh=+VnwthW9ctL/hfvs3viMpFjeoLFDpbA91ba1Qc1rz2g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UwsrmbjB7P9lJB002KgrKnnBK5+gHvbvbeYHilPf7LeFSq8ocplvlsL+3x2LXjuwoMXfG6g8Yio0K/jxFzwAKdLOJ7K2L6ZWBuu1CAIOp7VxQY/00V6wS0Fb8EFPW9ZxbEw07sGg2xV5p5d2anN3rsSioaL9IQwjR751mAtYu20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD+O2BWt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD+O2BWt"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a742481aso23029975e9.3
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 11:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733514367; x=1734119167; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEbmlcnP7MWTTmM1ZpgBOiqSdszMBUQRr5qML4XzYKw=;
        b=WD+O2BWtRBcsRXuw/X4fMHmS3ajs8ZB8F79A2eRVOYgsYLrrBFojh5d5oD1UQ3WnJB
         lVlfeoUzvX5eh+QZDJxVlyvTQO0MRjwwGVUUYNkzWNAJ43sXSSfjr3UWaMSMUcA1kyB5
         7RrhcsgnonfkT6gSwOYQlROsRHrD9r4B1tsRACNPWihoYfqG75+icTc98E3nTVkdQ/lj
         no4s2FUPSCf4EfhYkYp38QcUlwflyb3tuxFYUySekxz9ADPp2SFCUFrnUZrbuLPyvWt/
         s/mGzzNPYKvvRPUUppm2vB0IUlNwVHaf4kf9nOrSWatIsFYIZgKqwSo8vnMjrln/nQJq
         Y15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514367; x=1734119167;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEbmlcnP7MWTTmM1ZpgBOiqSdszMBUQRr5qML4XzYKw=;
        b=J+SgOUYeg0KaR+TFrJlhJUCfY11/ha4SbaIs5ApoiXfrVjszpI2Lz9uw2dt0mBeQJ8
         q23rIeOM750sdLi0SLSlwNGMF5+YHHWydaBqU5ipZtYvwzbs+gzMJsVrXKjV7xBqQ7NQ
         RHAmSuKvIWKuS1Y8+oSwTlgiCVzZuDiC5XCT/JwdG0y8ykOA4lVYONgB+nlul7nUkDVG
         HIeFY8tI2qfn9MyZqb2tMwnZjagt8eZe97TaseTPrrtVCOURBhCKnT6YzdEZj+jBqJ1F
         3UcNQJG9LVrr99eQes/pVP16QFy6cOW4Pq+G7Ij5gkLfkxXHiWqS22UDcSXSJ+JG4d23
         pp8g==
X-Gm-Message-State: AOJu0YwArR8Ah+VrWkjicCLFa41wajq+Z9zHPoYUIFd3IRN+5cS9msGO
	cGoOu4/WFKX+7xL2yrkKtDYtLIoDy3TupwBu/j0DrcK5a6IA2l208QKcCg==
X-Gm-Gg: ASbGncs4yVU4elVWB6tH1wbFGhgUMeCAysdWy9StFuEFQ2ZJHz565Tk1cwLJwHI4F2n
	2vwkiTc1ujnOq1iT3qIosW87R2lvuMqrrmH3h40b3ND6XEQyssEGm0MOQgkGDBN9czRqfe88Pvk
	Vey0MUMFU4UBigWJWqHtTVtslsW9B1CpXXm3lr0yO+NhwtvJs8MljnMdtLb3Q39OBRGuFshSfBf
	LD1w83CKJ36CmZNH9RyeaEwTdalUdH08Q1Ck1Wb7o85m/pUnvM=
X-Google-Smtp-Source: AGHT+IH/yPqU0zk247qhOq8SJ9n0F39HG+U8p2peyp17G+KzOpCw0/1x+bQrGGhgv/XtM6dkpgl/QQ==
X-Received: by 2002:a05:600c:548b:b0:434:a71f:f804 with SMTP id 5b1f17b1804b1-434ddeae72fmr40882175e9.3.1733514366425;
        Fri, 06 Dec 2024 11:46:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cf99sm5383539f8f.43.2024.12.06.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:46:05 -0800 (PST)
Message-Id: <0f1e6c51b2c2371fdb19dba6af9d0a0e353f0871.1733514359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
	<pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 19:45:57 +0000
Subject: [PATCH v3 6/7] path-walk: mark trees and blobs as UNINTERESTING
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
index 56289859e69..7f2d409c5bc 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -50,10 +50,14 @@ static int emit_block(const char *path, struct oid_array *oids,
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
@@ -74,6 +78,8 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle inclusion of tag objects")),
 		OPT_BOOL(0, "trees", &info.trees,
 			 N_("toggle inclusion of tree objects")),
+		OPT_BOOL(0, "prune", &info.prune_all_uninteresting,
+			 N_("toggle pruning of uninteresting paths")),
 		OPT_END(),
 	};
 
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 1f3d2e0cb76..a317cdf289e 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -211,11 +211,11 @@ test_expect_success 'topic, not base' '
 	0:commit::$(git rev-parse topic)
 	1:tree::$(git rev-parse topic^{tree})
 	2:tree:right/:$(git rev-parse topic:right)
-	3:blob:right/d:$(git rev-parse topic:right/d)
+	3:blob:right/d:$(git rev-parse topic:right/d):UNINTERESTING
 	4:blob:right/c:$(git rev-parse topic:right/c)
-	5:tree:left/:$(git rev-parse topic:left)
-	6:blob:left/b:$(git rev-parse topic:left/b)
-	7:blob:a:$(git rev-parse topic:a)
+	5:tree:left/:$(git rev-parse topic:left):UNINTERESTING
+	6:blob:left/b:$(git rev-parse topic:left/b):UNINTERESTING
+	7:blob:a:$(git rev-parse topic:a):UNINTERESTING
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
+	0:commit::$(git rev-parse topic)
+	1:tag:/tags:$(git rev-parse fourth)
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	3:tree::$(git rev-parse topic^{tree})
+	4:tree:right/:$(git rev-parse topic:right)
+	5:blob:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
+	6:blob:right/c:$(git rev-parse topic:right/c)
+	7:tree:left/:$(git rev-parse base~1:left):UNINTERESTING
+	8:blob:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
+	9:blob:a:$(git rev-parse base~1:a):UNINTERESTING
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
-	0:blob:right/d:$(git rev-parse topic:right/d)
+	0:blob:right/d:$(git rev-parse topic:right/d):UNINTERESTING
 	1:blob:right/c:$(git rev-parse topic:right/c)
-	2:blob:left/b:$(git rev-parse topic:left/b)
-	3:blob:a:$(git rev-parse topic:a)
+	2:blob:left/b:$(git rev-parse topic:left/b):UNINTERESTING
+	3:blob:a:$(git rev-parse topic:a):UNINTERESTING
 	blobs:4
 	commits:0
 	tags:0
@@ -267,7 +290,7 @@ test_expect_success 'topic, not base, only trees' '
 	cat >expect <<-EOF &&
 	0:tree::$(git rev-parse topic^{tree})
 	1:tree:right/:$(git rev-parse topic:right)
-	2:tree:left/:$(git rev-parse topic:left)
+	2:tree:left/:$(git rev-parse topic:left):UNINTERESTING
 	commits:0
 	blobs:0
 	tags:0
@@ -282,17 +305,17 @@ test_expect_success 'topic, not base, boundary' '
 
 	cat >expect <<-EOF &&
 	0:commit::$(git rev-parse topic)
-	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~1):UNINTERESTING
 	1:tree::$(git rev-parse topic^{tree})
-	1:tree::$(git rev-parse base~1^{tree})
+	1:tree::$(git rev-parse base~1^{tree}):UNINTERESTING
 	2:tree:right/:$(git rev-parse topic:right)
-	2:tree:right/:$(git rev-parse base~1:right)
-	3:blob:right/d:$(git rev-parse base~1:right/d)
-	4:blob:right/c:$(git rev-parse base~1:right/c)
+	2:tree:right/:$(git rev-parse base~1:right):UNINTERESTING
+	3:blob:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
+	4:blob:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
 	4:blob:right/c:$(git rev-parse topic:right/c)
-	5:tree:left/:$(git rev-parse base~1:left)
-	6:blob:left/b:$(git rev-parse base~1:left/b)
-	7:blob:a:$(git rev-parse base~1:a)
+	5:tree:left/:$(git rev-parse base~1:left):UNINTERESTING
+	6:blob:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
+	7:blob:a:$(git rev-parse base~1:a):UNINTERESTING
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
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base~1):UNINTERESTING
+	1:tree::$(git rev-parse topic^{tree})
+	1:tree::$(git rev-parse base~1^{tree}):UNINTERESTING
+	2:tree:right/:$(git rev-parse topic:right)
+	2:tree:right/:$(git rev-parse base~1:right):UNINTERESTING
+	3:blob:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
+	3:blob:right/c:$(git rev-parse topic:right/c)
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

