Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B247C21A437
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711687; cv=none; b=aC2pH3yjzpiWmrH6P7MPDHunSQlkG92xlamMvUjGHmX76bhm0jtxqPNO1APCtoPErfYyKSq+lB1TrJ6xcKuHVn/YQUYroTId4qEQdF88akOhX6ULMtYxNdnSey4/OR86Hlx/nGRHMKO9QXYHSOWrllmHf4GDq36VqSVuAYnZxbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711687; c=relaxed/simple;
	bh=TX2eg2bC6r2fyjjLFZ1R/cCQCY7L57g7zo4gRUrs84w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R5k5Sd3+ogE6mCi1c7bcbeGfOotjf2ScAx22QcODRPsSnY2gBSgaCzJMXMI3ujJeHZY+Fm0PQr8p+S1xHkZrz+7W6J31Yfa9MN8iBaV7o2qFwtnF88eHPWkX8lPBWvRvFeZ6kElwWpnrYKxIqYYfQO/uWCfzQBT4wqU98cRUkZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H79uTpS1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H79uTpS1"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862d161947so1093062f8f.3
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734711684; x=1735316484; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=te9A5Z4cilQv6ticNcx81z2SLbSgkLxZ+XAWRjW0RDU=;
        b=H79uTpS1XYbhLznx2i5abIrRronk4RiN3mu3JKzZwBnyMOpYEmw9S9CUU6iwNrNan7
         Jp8HCuxzgz+QIlDf7FOjGI5ngvlWL6RcAn/6kAikxL8IQE6TVzd9jboLuWkJJq5RT1k3
         kjlmvSnqpFdw0OeIahhQk6yan2tb1TZv+OipDgwbELIYEHcFL+DpYzWoy/ZrQSzXVudJ
         2jPVekNYQhP1Uqkjevhsg+HoI2T2cW3aiN94HMaYr5K6ntrp1LN3cswXsz/9hTGYjgvs
         zurD1+oWVfCQwlyGLPt2USbRRW2DBWs4N+3OUslSKjxavM1g3WI7XnY6JHBbmDupukqT
         pk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734711684; x=1735316484;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te9A5Z4cilQv6ticNcx81z2SLbSgkLxZ+XAWRjW0RDU=;
        b=d7Bjnwcscyh30GXJD4Z1LTSM6/ETZXhcB36QZEpHowCnLBLsp0jBM50+3I8i96Rq+9
         NtLO/R2kI5rv9F0kkwIP+zItWgx3wQX/f0SMbFPohbfdKfAoR30NlMmajOZWeFMWqa3N
         Cc+dJOyMaYAC5GjrjfwPsDhJsBmT6TvVf3WZCHlugczd/fiy+C62mj28SLecwtyWr2E8
         hI7Gb2q2flMcTm7NFI6x5w1ALJMKU6wJOuvyzVrEUrRe2UtraZu75bX+VaIKP40pn5ar
         oNqOtM8n/LFum2SR1ze8LnV/c+7KOsdLz2ZB8uBMJV6QbkQcrmOb7Y5mjRoKbOm8tp7s
         oU9Q==
X-Gm-Message-State: AOJu0YzSChrW2tUOY60SDl8dBEhGu0iPfI4toyqd3UO0jhAZAIY37yPM
	YLEBGhB5Ng+JgOfoxyWFMgRZXdtA347vyXS9/rlj+6O/rXEWDrshJ7W21w==
X-Gm-Gg: ASbGncssj6EjIycTToS3VF38DZC9f31BWrA2r7UWJzprJYIcYl3l57JAK6mEJLnuQNo
	Na9mnYYJEi0oRpchofhsno8tg3pmOtm07QY2mzK1xAxnNFyFbwOFTb8opAq27wRYOD9Xol5nUfl
	bG+SfJg0GCOaqEhx0q9ijT4p6aIxFPF44RVdxLD59uHenvBxiQmvHL781fTWNFUcG4SJ4W7nVlR
	Q2Ge99C76xTDoninBWqFO0ZFeLvIT37TDhyB1FVjETxJDSXzdeR5DFm6g==
X-Google-Smtp-Source: AGHT+IEYvp9kZZObb1dxU7VXsMTt7wJNGe0v93/odgA/BxQEWqCKLFskPFaa2gCCTqpbO5ZDB0Z18Q==
X-Received: by 2002:a05:6000:18a5:b0:382:5aae:87c7 with SMTP id ffacd0b85a97d-38a221f9d65mr3466231f8f.31.1734711683242;
        Fri, 20 Dec 2024 08:21:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219611sm50250265e9.23.2024.12.20.08.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:21:22 -0800 (PST)
Message-Id: <db5c86112300130d9f1a62f67800fc5bc824b268.1734711676.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>
References: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
	<pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 16:21:12 +0000
Subject: [PATCH v4 4/7] path-walk: allow consumer to specify object types
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
 t/helper/test-path-walk.c                 |  15 ++-
 t/t6601-path-walk.sh                      | 149 +++++++++++++++-------
 5 files changed, 170 insertions(+), 50 deletions(-)

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
index 021840ab41b..05ca7b2442a 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -98,6 +98,10 @@ static int add_tree_entries(struct path_walk_context *ctx,
 		if (S_ISGITLINK(entry.mode))
 			continue;
 
+		/* If the caller doesn't want blobs, then don't bother. */
+		if (!ctx->info->blobs && type == OBJ_BLOB)
+			continue;
+
 		if (type == OBJ_TREE) {
 			struct tree *child = lookup_tree(ctx->repo, &entry.oid);
 			o = child ? &child->object : NULL;
@@ -159,9 +163,11 @@ static int walk_path(struct path_walk_context *ctx,
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
@@ -203,6 +209,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 	size_t commits_nr = 0, paths_nr = 0;
 	struct commit *c;
 	struct type_and_oid_list *root_tree_list;
+	struct type_and_oid_list *commit_list;
 	struct path_walk_context ctx = {
 		.repo = info->revs->repo,
 		.revs = info->revs,
@@ -214,6 +221,9 @@ int walk_objects_by_path(struct path_walk_info *info)
 
 	trace2_region_enter("path-walk", "commit-walk", info->revs->repo);
 
+	CALLOC_ARRAY(commit_list, 1);
+	commit_list->type = OBJ_COMMIT;
+
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
@@ -224,10 +234,18 @@ int walk_objects_by_path(struct path_walk_info *info)
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
 
@@ -245,6 +263,13 @@ int walk_objects_by_path(struct path_walk_info *info)
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
index 7cb3538cd8f..2cafc71e153 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -31,9 +31,21 @@ struct path_walk_info {
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
 
 void path_walk_info_init(struct path_walk_info *info);
 void path_walk_info_clear(struct path_walk_info *info);
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index def7c81ac4f..a57a05a6391 100644
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
@@ -33,6 +35,8 @@ static int emit_block(const char *path, struct oid_array *oids,
 		tdata->tree_nr += oids->nr;
 	else if (type == OBJ_BLOB)
 		tdata->blob_nr += oids->nr;
+	else if (type == OBJ_COMMIT)
+		tdata->commit_nr += oids->nr;
 	else
 		BUG("we do not understand this type");
 
@@ -54,6 +58,12 @@ int cmd__path_walk(int argc, const char **argv)
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
 
@@ -75,9 +85,10 @@ int cmd__path_walk(int argc, const char **argv)
 
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
index 4e052c09309..4a4939a1b02 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -33,22 +33,27 @@ test_expect_success 'all' '
 	test-tool path-walk -- --all >out &&
 
 	cat >expect <<-EOF &&
-	0:tree::$(git rev-parse topic^{tree})
-	0:tree::$(git rev-parse base^{tree})
-	0:tree::$(git rev-parse base~1^{tree})
-	0:tree::$(git rev-parse base~2^{tree})
-	1:tree:right/:$(git rev-parse topic:right)
-	1:tree:right/:$(git rev-parse base~1:right)
-	1:tree:right/:$(git rev-parse base~2:right)
-	2:blob:right/d:$(git rev-parse base~1:right/d)
-	3:blob:right/c:$(git rev-parse base~2:right/c)
-	3:blob:right/c:$(git rev-parse topic:right/c)
-	4:tree:left/:$(git rev-parse base:left)
-	4:tree:left/:$(git rev-parse base~2:left)
-	5:blob:left/b:$(git rev-parse base~2:left/b)
-	5:blob:left/b:$(git rev-parse base:left/b)
-	6:blob:a:$(git rev-parse base~2:a)
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tree::$(git rev-parse topic^{tree})
+	1:tree::$(git rev-parse base^{tree})
+	1:tree::$(git rev-parse base~1^{tree})
+	1:tree::$(git rev-parse base~2^{tree})
+	2:tree:right/:$(git rev-parse topic:right)
+	2:tree:right/:$(git rev-parse base~1:right)
+	2:tree:right/:$(git rev-parse base~2:right)
+	3:blob:right/d:$(git rev-parse base~1:right/d)
+	4:blob:right/c:$(git rev-parse base~2:right/c)
+	4:blob:right/c:$(git rev-parse topic:right/c)
+	5:tree:left/:$(git rev-parse base:left)
+	5:tree:left/:$(git rev-parse base~2:left)
+	6:blob:left/b:$(git rev-parse base~2:left/b)
+	6:blob:left/b:$(git rev-parse base:left/b)
+	7:blob:a:$(git rev-parse base~2:a)
 	blobs:6
+	commits:4
 	trees:9
 	EOF
 
@@ -59,19 +64,23 @@ test_expect_success 'topic only' '
 	test-tool path-walk -- topic >out &&
 
 	cat >expect <<-EOF &&
-	0:tree::$(git rev-parse topic^{tree})
-	0:tree::$(git rev-parse base~1^{tree})
-	0:tree::$(git rev-parse base~2^{tree})
-	1:tree:right/:$(git rev-parse topic:right)
-	1:tree:right/:$(git rev-parse base~1:right)
-	1:tree:right/:$(git rev-parse base~2:right)
-	2:blob:right/d:$(git rev-parse base~1:right/d)
-	3:blob:right/c:$(git rev-parse base~2:right/c)
-	3:blob:right/c:$(git rev-parse topic:right/c)
-	4:tree:left/:$(git rev-parse base~2:left)
-	5:blob:left/b:$(git rev-parse base~2:left/b)
-	6:blob:a:$(git rev-parse base~2:a)
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tree::$(git rev-parse topic^{tree})
+	1:tree::$(git rev-parse base~1^{tree})
+	1:tree::$(git rev-parse base~2^{tree})
+	2:tree:right/:$(git rev-parse topic:right)
+	2:tree:right/:$(git rev-parse base~1:right)
+	2:tree:right/:$(git rev-parse base~2:right)
+	3:blob:right/d:$(git rev-parse base~1:right/d)
+	4:blob:right/c:$(git rev-parse base~2:right/c)
+	4:blob:right/c:$(git rev-parse topic:right/c)
+	5:tree:left/:$(git rev-parse base~2:left)
+	6:blob:left/b:$(git rev-parse base~2:left/b)
+	7:blob:a:$(git rev-parse base~2:a)
 	blobs:5
+	commits:3
 	trees:7
 	EOF
 
@@ -82,15 +91,66 @@ test_expect_success 'topic, not base' '
 	test-tool path-walk -- topic --not base >out &&
 
 	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	1:tree::$(git rev-parse topic^{tree})
+	2:tree:right/:$(git rev-parse topic:right)
+	3:blob:right/d:$(git rev-parse topic:right/d)
+	4:blob:right/c:$(git rev-parse topic:right/c)
+	5:tree:left/:$(git rev-parse topic:left)
+	6:blob:left/b:$(git rev-parse topic:left/b)
+	7:blob:a:$(git rev-parse topic:a)
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
+	0:blob:right/d:$(git rev-parse topic:right/d)
+	1:blob:right/c:$(git rev-parse topic:right/c)
+	2:blob:left/b:$(git rev-parse topic:left/b)
+	3:blob:a:$(git rev-parse topic:a)
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
+	0:commit::$(git rev-parse topic)
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
 	0:tree::$(git rev-parse topic^{tree})
 	1:tree:right/:$(git rev-parse topic:right)
-	2:blob:right/d:$(git rev-parse topic:right/d)
-	3:blob:right/c:$(git rev-parse topic:right/c)
-	4:tree:left/:$(git rev-parse topic:left)
-	5:blob:left/b:$(git rev-parse topic:left/b)
-	6:blob:a:$(git rev-parse topic:a)
-	blobs:4
+	2:tree:left/:$(git rev-parse topic:left)
 	trees:3
+	blobs:0
 	EOF
 
 	test_cmp_sorted expect out
@@ -100,17 +160,20 @@ test_expect_success 'topic, not base, boundary' '
 	test-tool path-walk -- --boundary topic --not base >out &&
 
 	cat >expect <<-EOF &&
-	0:tree::$(git rev-parse topic^{tree})
-	0:tree::$(git rev-parse base~1^{tree})
-	1:tree:right/:$(git rev-parse topic:right)
-	1:tree:right/:$(git rev-parse base~1:right)
-	2:blob:right/d:$(git rev-parse base~1:right/d)
-	3:blob:right/c:$(git rev-parse base~1:right/c)
-	3:blob:right/c:$(git rev-parse topic:right/c)
-	4:tree:left/:$(git rev-parse base~1:left)
-	5:blob:left/b:$(git rev-parse base~1:left/b)
-	6:blob:a:$(git rev-parse base~1:a)
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base~1)
+	1:tree::$(git rev-parse topic^{tree})
+	1:tree::$(git rev-parse base~1^{tree})
+	2:tree:right/:$(git rev-parse topic:right)
+	2:tree:right/:$(git rev-parse base~1:right)
+	3:blob:right/d:$(git rev-parse base~1:right/d)
+	4:blob:right/c:$(git rev-parse base~1:right/c)
+	4:blob:right/c:$(git rev-parse topic:right/c)
+	5:tree:left/:$(git rev-parse base~1:left)
+	6:blob:left/b:$(git rev-parse base~1:left/b)
+	7:blob:a:$(git rev-parse base~1:a)
 	blobs:5
+	commits:2
 	trees:5
 	EOF
 
-- 
gitgitgadget

