Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780A61A0BDC
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731181284; cv=none; b=WlOedsM2rlrWYjIe6Q1bqyklOaZso8jBVKdCbHckOwIOltX76td9d0mk5gZsol8D8jcowjBD36SExU2opmOd3tN61ZispwKdQdM2ie37qrKkt6eVJQ+GDNIgX/0nB0nO79HPV7yl8yw5ObJsxfHUivSRN5v/syeGOywoL+pSr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731181284; c=relaxed/simple;
	bh=ePLR5Ql+fYCXNWN3Ui+KDe2rO7S3LgcBN+vPVkv2p8g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qr1k40l6qfuWZQ/xgkDAgFR0+JrtJFQbJMihUHr6Lp/+ExtqfUE0KZ540KrQE3PxMhPGBsufZ069LMgvtuiBwY2IGvTkPl+wu/XCcgHAzRkLBpEMks6pxpgDDTiifsFtVGt7OlKc+9ENkaG2/6ImUCdPmvzspNpE34cHxIyjxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5JmnLHs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5JmnLHs"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43158625112so28840705e9.3
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 11:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731181279; x=1731786079; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1eJy5XoD6urwVb6CkLe+hSb4FCriQNWyOJPq1Y2PE4=;
        b=P5JmnLHsZX9OzZcVDcYLTMKTbNXt/Sbp//SMSajM+lkJRetU5SDdwg4Snaki+KQ983
         4VH/6/E7kShYNeTPsSl5FEx2doN13A9BJ+aiEtdOG2c/pYdEnI6DlSPQ7HAm67xOJZBk
         zPYLznT6IIwMyhy6fT5+Xo6tg9s8csh66aO8aEpTQB8TTLlVDgRNOkH9GNX8rHvVfxzy
         toTpaFqJ5oTFNt0eb9nz/qmGMIskEGa8Nc4JrZLNmrUCGwtTlRi0AzAKjAwnaBlUMLeG
         Pk3QH//fWcHi4sWzzW+50ic/wT/sxZU8MvMaN3/4RsAvWuoAuM9uhJE8LT0P1VwFqWxt
         gb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731181279; x=1731786079;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1eJy5XoD6urwVb6CkLe+hSb4FCriQNWyOJPq1Y2PE4=;
        b=qKryq82tcvELcZMALmeuDtHeGQ2cG60IFOHXI1YRNAdYYaBXtYw4pBbpWuhUonyOVT
         HctJVfU9wqSqxFHtBxUKZMV4u5iEkJ+XXbRJLzduCqOG6pr3x+EawIvZ+AjzcT3e3B13
         w+whVXcaoneOrFP8CuNNjdBEIM3CHXm/fC6ChRzffIccYF3keTN08EYUt8MY76hnIb+j
         Bw4F+Ib/fNmGwh4sGCm95GiFkH1kLMR5VFKiJFAQG0kKvOhav7YQIZ24Z0p8WkBxJvf8
         aqOISvkSCoq7gVSQz7LyQBqRjTn1nFpr/6vH/ltNT8DM7YGapvZABFPB5784xO4hR4ss
         UvWg==
X-Gm-Message-State: AOJu0YxasdKzX8qMVYUsKaEfDgDmnwYepL/fVhPna8s05VfdvEDTyJqm
	M2QZLyp1qFOucaZZiKFLk3E0JpZHgHIGFutCzx3bk544jXigmf4M7tqung==
X-Google-Smtp-Source: AGHT+IFVIBQgm8efb3GAGbBfeoF491JUPvzhSUHH9Jk8Wfp+lrO3tc8QJiUfX+X/0g9ARFse3lUAQg==
X-Received: by 2002:a05:600c:3ba6:b0:431:542d:2592 with SMTP id 5b1f17b1804b1-432b751d866mr59838385e9.27.1731181279223;
        Sat, 09 Nov 2024 11:41:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05673d0sm115080735e9.25.2024.11.09.11.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 11:41:18 -0800 (PST)
Message-Id: <83b746f569df932452d8d102dc29dda0859c4ed2.1731181273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
	<pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Nov 2024 19:41:10 +0000
Subject: [PATCH v2 4/6] path-walk: allow consumer to specify object types
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
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

We add the ability to filter the object types in the path-walk API so
the callback function is called fewer times.

This adds the ability to ask for the commits in a list, as well. We
re-use the empty string for this set of objects because these are passed
directly to the callback function instead of being part of the
'path_stack'.

Future changes will add the ability to visit annotated tags.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.txt |   9 ++
 path-walk.c                               |  33 ++++-
 path-walk.h                               |  14 +-
 t/helper/test-path-walk.c                 |  18 ++-
 t/t6601-path-walk.sh                      | 149 +++++++++++++++-------
 5 files changed, 173 insertions(+), 50 deletions(-)

diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index 662162ec70b..dce553b6114 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -39,6 +39,15 @@ It is also important that you do not specify the `--objects` flag for the
 the objects will be walked in a separate way based on those starting
 commits.
 
+`commits`, `blobs`, `trees`::
+	By default, these members are enabled and signal that the path-walk
+	API should call the `path_fn` on objects of these types. Specialized
+	applications could disable some options to make it simpler to walk
+	the objects or to have fewer calls to `path_fn`.
++
+While it is possible to walk only commits in this way, consumers would be
+better off using the revision walk API instead.
+
 Examples
 --------
 
diff --git a/path-walk.c b/path-walk.c
index 24cf04c1e7d..2ca08402367 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -98,6 +98,10 @@ static int add_children(struct path_walk_context *ctx,
 		if (S_ISGITLINK(entry.mode))
 			continue;
 
+		/* If the caller doesn't want blobs, then don't bother. */
+		if (!ctx->info->blobs && type == OBJ_BLOB)
+			continue;
+
 		if (type == OBJ_TREE) {
 			struct tree *child = lookup_tree(ctx->repo, &entry.oid);
 			o = child ? &child->object : NULL;
@@ -157,9 +161,11 @@ static int walk_path(struct path_walk_context *ctx,
 	if (!list->oids.nr)
 		return 0;
 
-	/* Evaluate function pointer on this data. */
-	ret = ctx->info->path_fn(path, &list->oids, list->type,
-				 ctx->info->path_fn_data);
+	/* Evaluate function pointer on this data, if requested. */
+	if ((list->type == OBJ_TREE && ctx->info->trees) ||
+	    (list->type == OBJ_BLOB && ctx->info->blobs))
+		ret = ctx->info->path_fn(path, &list->oids, list->type,
+					ctx->info->path_fn_data);
 
 	/* Expand data for children. */
 	if (list->type == OBJ_TREE) {
@@ -201,6 +207,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 	size_t commits_nr = 0, paths_nr = 0;
 	struct commit *c;
 	struct type_and_oid_list *root_tree_list;
+	struct type_and_oid_list *commit_list;
 	struct path_walk_context ctx = {
 		.repo = info->revs->repo,
 		.revs = info->revs,
@@ -212,6 +219,9 @@ int walk_objects_by_path(struct path_walk_info *info)
 
 	trace2_region_enter("path-walk", "commit-walk", info->revs->repo);
 
+	CALLOC_ARRAY(commit_list, 1);
+	commit_list->type = OBJ_COMMIT;
+
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
@@ -222,10 +232,18 @@ int walk_objects_by_path(struct path_walk_info *info)
 		die(_("failed to setup revision walk"));
 
 	while ((c = get_revision(info->revs))) {
-		struct object_id *oid = get_commit_tree_oid(c);
+		struct object_id *oid;
 		struct tree *t;
 		commits_nr++;
 
+		if (info->commits)
+			oid_array_append(&commit_list->oids,
+					 &c->object.oid);
+
+		/* If we only care about commits, then skip trees. */
+		if (!info->trees && !info->blobs)
+			continue;
+
 		oid = get_commit_tree_oid(c);
 		t = lookup_tree(info->revs->repo, oid);
 
@@ -243,6 +261,13 @@ int walk_objects_by_path(struct path_walk_info *info)
 	trace2_data_intmax("path-walk", ctx.repo, "commits", commits_nr);
 	trace2_region_leave("path-walk", "commit-walk", info->revs->repo);
 
+	/* Track all commits. */
+	if (info->commits && commit_list->oids.nr)
+		ret = info->path_fn("", &commit_list->oids, OBJ_COMMIT,
+				    info->path_fn_data);
+	oid_array_clear(&commit_list->oids);
+	free(commit_list);
+
 	trace2_region_enter("path-walk", "path-walk", info->revs->repo);
 	while (!ret && ctx.path_stack.nr) {
 		char *path = ctx.path_stack.items[ctx.path_stack.nr - 1].string;
diff --git a/path-walk.h b/path-walk.h
index c9e94a98bc8..2d2afc29b47 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -30,9 +30,21 @@ struct path_walk_info {
 	 */
 	path_fn path_fn;
 	void *path_fn_data;
+
+	/**
+	 * Initialize which object types the path_fn should be called on. This
+	 * could also limit the walk to skip blobs if not set.
+	 */
+	int commits;
+	int trees;
+	int blobs;
 };
 
-#define PATH_WALK_INFO_INIT { 0 }
+#define PATH_WALK_INFO_INIT {   \
+	.blobs = 1,		\
+	.trees = 1,		\
+	.commits = 1,		\
+}
 
 /**
  * Given the configuration of 'info', walk the commits based on 'info->revs' and
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index aa468871079..2b7e6e98d18 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -19,6 +19,8 @@ static const char * const path_walk_usage[] = {
 
 struct path_walk_test_data {
 	uintmax_t batch_nr;
+
+	uintmax_t commit_nr;
 	uintmax_t tree_nr;
 	uintmax_t blob_nr;
 };
@@ -30,6 +32,11 @@ static int emit_block(const char *path, struct oid_array *oids,
 	const char *typestr;
 
 	switch (type) {
+	case OBJ_COMMIT:
+		typestr = "COMMIT";
+		tdata->commit_nr += oids->nr;
+		break;
+
 	case OBJ_TREE:
 		typestr = "TREE";
 		tdata->tree_nr += oids->nr;
@@ -60,6 +67,12 @@ int cmd__path_walk(int argc, const char **argv)
 	struct path_walk_info info = PATH_WALK_INFO_INIT;
 	struct path_walk_test_data data = { 0 };
 	struct option options[] = {
+		OPT_BOOL(0, "blobs", &info.blobs,
+			 N_("toggle inclusion of blob objects")),
+		OPT_BOOL(0, "commits", &info.commits,
+			 N_("toggle inclusion of commit objects")),
+		OPT_BOOL(0, "trees", &info.trees,
+			 N_("toggle inclusion of tree objects")),
 		OPT_END(),
 	};
 
@@ -81,9 +94,10 @@ int cmd__path_walk(int argc, const char **argv)
 
 	res = walk_objects_by_path(&info);
 
-	printf("trees:%" PRIuMAX "\n"
+	printf("commits:%" PRIuMAX "\n"
+	       "trees:%" PRIuMAX "\n"
 	       "blobs:%" PRIuMAX "\n",
-	       data.tree_nr, data.blob_nr);
+	       data.commit_nr, data.tree_nr, data.blob_nr);
 
 	release_revisions(&revs);
 	return res;
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index a3da55933f4..dcd3c03a2e8 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -33,22 +33,27 @@ test_expect_success 'all' '
 	test-tool path-walk -- --all >out &&
 
 	cat >expect <<-EOF &&
-	0:TREE::$(git rev-parse topic^{tree})
-	0:TREE::$(git rev-parse base^{tree})
-	0:TREE::$(git rev-parse base~1^{tree})
-	0:TREE::$(git rev-parse base~2^{tree})
-	1:TREE:right/:$(git rev-parse topic:right)
-	1:TREE:right/:$(git rev-parse base~1:right)
-	1:TREE:right/:$(git rev-parse base~2:right)
-	2:BLOB:right/d:$(git rev-parse base~1:right/d)
-	3:BLOB:right/c:$(git rev-parse base~2:right/c)
-	3:BLOB:right/c:$(git rev-parse topic:right/c)
-	4:TREE:left/:$(git rev-parse base:left)
-	4:TREE:left/:$(git rev-parse base~2:left)
-	5:BLOB:left/b:$(git rev-parse base~2:left/b)
-	5:BLOB:left/b:$(git rev-parse base:left/b)
-	6:BLOB:a:$(git rev-parse base~2:a)
+	0:COMMIT::$(git rev-parse topic)
+	0:COMMIT::$(git rev-parse base)
+	0:COMMIT::$(git rev-parse base~1)
+	0:COMMIT::$(git rev-parse base~2)
+	1:TREE::$(git rev-parse topic^{tree})
+	1:TREE::$(git rev-parse base^{tree})
+	1:TREE::$(git rev-parse base~1^{tree})
+	1:TREE::$(git rev-parse base~2^{tree})
+	2:TREE:right/:$(git rev-parse topic:right)
+	2:TREE:right/:$(git rev-parse base~1:right)
+	2:TREE:right/:$(git rev-parse base~2:right)
+	3:BLOB:right/d:$(git rev-parse base~1:right/d)
+	4:BLOB:right/c:$(git rev-parse base~2:right/c)
+	4:BLOB:right/c:$(git rev-parse topic:right/c)
+	5:TREE:left/:$(git rev-parse base:left)
+	5:TREE:left/:$(git rev-parse base~2:left)
+	6:BLOB:left/b:$(git rev-parse base~2:left/b)
+	6:BLOB:left/b:$(git rev-parse base:left/b)
+	7:BLOB:a:$(git rev-parse base~2:a)
 	blobs:6
+	commits:4
 	trees:9
 	EOF
 
@@ -59,19 +64,23 @@ test_expect_success 'topic only' '
 	test-tool path-walk -- topic >out &&
 
 	cat >expect <<-EOF &&
-	0:TREE::$(git rev-parse topic^{tree})
-	0:TREE::$(git rev-parse base~1^{tree})
-	0:TREE::$(git rev-parse base~2^{tree})
-	1:TREE:right/:$(git rev-parse topic:right)
-	1:TREE:right/:$(git rev-parse base~1:right)
-	1:TREE:right/:$(git rev-parse base~2:right)
-	2:BLOB:right/d:$(git rev-parse base~1:right/d)
-	3:BLOB:right/c:$(git rev-parse base~2:right/c)
-	3:BLOB:right/c:$(git rev-parse topic:right/c)
-	4:TREE:left/:$(git rev-parse base~2:left)
-	5:BLOB:left/b:$(git rev-parse base~2:left/b)
-	6:BLOB:a:$(git rev-parse base~2:a)
+	0:COMMIT::$(git rev-parse topic)
+	0:COMMIT::$(git rev-parse base~1)
+	0:COMMIT::$(git rev-parse base~2)
+	1:TREE::$(git rev-parse topic^{tree})
+	1:TREE::$(git rev-parse base~1^{tree})
+	1:TREE::$(git rev-parse base~2^{tree})
+	2:TREE:right/:$(git rev-parse topic:right)
+	2:TREE:right/:$(git rev-parse base~1:right)
+	2:TREE:right/:$(git rev-parse base~2:right)
+	3:BLOB:right/d:$(git rev-parse base~1:right/d)
+	4:BLOB:right/c:$(git rev-parse base~2:right/c)
+	4:BLOB:right/c:$(git rev-parse topic:right/c)
+	5:TREE:left/:$(git rev-parse base~2:left)
+	6:BLOB:left/b:$(git rev-parse base~2:left/b)
+	7:BLOB:a:$(git rev-parse base~2:a)
 	blobs:5
+	commits:3
 	trees:7
 	EOF
 
@@ -82,15 +91,66 @@ test_expect_success 'topic, not base' '
 	test-tool path-walk -- topic --not base >out &&
 
 	cat >expect <<-EOF &&
+	0:COMMIT::$(git rev-parse topic)
+	1:TREE::$(git rev-parse topic^{tree})
+	2:TREE:right/:$(git rev-parse topic:right)
+	3:BLOB:right/d:$(git rev-parse topic:right/d)
+	4:BLOB:right/c:$(git rev-parse topic:right/c)
+	5:TREE:left/:$(git rev-parse topic:left)
+	6:BLOB:left/b:$(git rev-parse topic:left/b)
+	7:BLOB:a:$(git rev-parse topic:a)
+	blobs:4
+	commits:1
+	trees:3
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'topic, not base, only blobs' '
+	test-tool path-walk --no-trees --no-commits \
+		-- topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	commits:0
+	trees:0
+	0:BLOB:right/d:$(git rev-parse topic:right/d)
+	1:BLOB:right/c:$(git rev-parse topic:right/c)
+	2:BLOB:left/b:$(git rev-parse topic:left/b)
+	3:BLOB:a:$(git rev-parse topic:a)
+	blobs:4
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+# No, this doesn't make a lot of sense for the path-walk API,
+# but it is possible to do.
+test_expect_success 'topic, not base, only commits' '
+	test-tool path-walk --no-blobs --no-trees \
+		-- topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	0:COMMIT::$(git rev-parse topic)
+	commits:1
+	trees:0
+	blobs:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'topic, not base, only trees' '
+	test-tool path-walk --no-blobs --no-commits \
+		-- topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	commits:0
 	0:TREE::$(git rev-parse topic^{tree})
 	1:TREE:right/:$(git rev-parse topic:right)
-	2:BLOB:right/d:$(git rev-parse topic:right/d)
-	3:BLOB:right/c:$(git rev-parse topic:right/c)
-	4:TREE:left/:$(git rev-parse topic:left)
-	5:BLOB:left/b:$(git rev-parse topic:left/b)
-	6:BLOB:a:$(git rev-parse topic:a)
-	blobs:4
+	2:TREE:left/:$(git rev-parse topic:left)
 	trees:3
+	blobs:0
 	EOF
 
 	test_cmp_sorted expect out
@@ -100,17 +160,20 @@ test_expect_success 'topic, not base, boundary' '
 	test-tool path-walk -- --boundary topic --not base >out &&
 
 	cat >expect <<-EOF &&
-	0:TREE::$(git rev-parse topic^{tree})
-	0:TREE::$(git rev-parse base~1^{tree})
-	1:TREE:right/:$(git rev-parse topic:right)
-	1:TREE:right/:$(git rev-parse base~1:right)
-	2:BLOB:right/d:$(git rev-parse base~1:right/d)
-	3:BLOB:right/c:$(git rev-parse base~1:right/c)
-	3:BLOB:right/c:$(git rev-parse topic:right/c)
-	4:TREE:left/:$(git rev-parse base~1:left)
-	5:BLOB:left/b:$(git rev-parse base~1:left/b)
-	6:BLOB:a:$(git rev-parse base~1:a)
+	0:COMMIT::$(git rev-parse topic)
+	0:COMMIT::$(git rev-parse base~1)
+	1:TREE::$(git rev-parse topic^{tree})
+	1:TREE::$(git rev-parse base~1^{tree})
+	2:TREE:right/:$(git rev-parse topic:right)
+	2:TREE:right/:$(git rev-parse base~1:right)
+	3:BLOB:right/d:$(git rev-parse base~1:right/d)
+	4:BLOB:right/c:$(git rev-parse base~1:right/c)
+	4:BLOB:right/c:$(git rev-parse topic:right/c)
+	5:TREE:left/:$(git rev-parse base~1:left)
+	6:BLOB:left/b:$(git rev-parse base~1:left/b)
+	7:BLOB:a:$(git rev-parse base~1:a)
 	blobs:5
+	commits:2
 	trees:5
 	EOF
 
-- 
gitgitgadget

