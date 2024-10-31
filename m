Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B34F145B1D
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356034; cv=none; b=ZEbppHJVgT9hOOEYtHJEOs+QIFT5V3slbtl5+FCRq3RAA4FkSVtP5P1pkueYPfwjcwY1VPWcScQPrLy9GgPg5TbcixNqm2u4JZyYT6pewuXNPlGbNg5TYoEp9w8GcPMjmK0yg8/yJYkYY7v/XlWrD3Bu7k+srjyxtPUEQprn9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356034; c=relaxed/simple;
	bh=j23nr8wd2PgdlXO6XEaqSQICl9VbdOq99jUVWODwuX0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wf3UFzbHmYv8a4Od+1d4kMhEPRhT6KXm0MsihalPu1qCU+qfSrT+ybVbMadTQqZC6UCdcN4cZxsiS8gTjHExnUAywLhEXae68flGPgxwI4c66J8Fyfa8dX7rJef1Feph5U90Mql8exbJZy/t/slpYK56coRvT6d0kenjSFDipeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwncJOwv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwncJOwv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4319399a411so4980045e9.2
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730356029; x=1730960829; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RQbQrqkG8nliIeb2KQdzc5+KDOjtwG1EGxG4tenulA=;
        b=HwncJOwvkAjxtSyVRVHcSPJCBINOyQ7QfhBsByKTGQmtLD0fZtGkUT2bq+l8qMVMEt
         DKKGmEEAULahCCon3in2XBZarHLSeNPl4WnL+KsWAgFMXB02Qnjkr0hIaU9fmaxpSfq7
         bESwzN0oYSXoghrWKE1MqTt1f/QzqgNtwajIb/RqQwWrF3UADVofvwoNubrGFTQMzt4S
         Ki9XHIDfcXC/tcd9GCPdYeIzAtKbJxZml5MunkQz6AJhsO0H/Z3K6KLxTB2+yPIsiv+H
         uKyLwP95B4Ry9Xgr0u81GfI8mXdxxq7EdHQjH7D8vMHn12hOWre2UkJ3t6AprLiFu0jM
         Fv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730356029; x=1730960829;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RQbQrqkG8nliIeb2KQdzc5+KDOjtwG1EGxG4tenulA=;
        b=L3/MHioxKN8ADJmTayz0ZI79pNVa2pe/CCS+9zyt+kVLaRHGKJBOQnttIJ77QB855y
         JTC8H9igikSbzogKTdBQ6zLf++m52F3CaEFO/tzAYnNMouTZPQfoooX5NjiplURY96Em
         QuT+ZEORcUTjcVT9aLNeUXCFqS6XvNAR1tQUdIL4tzonrpZcNaOP0NfxqQhGZRIqpAdH
         NpkHgbVZ/wROffdpz/cWGSFO5EoUw2o72RrTYmP/SpzF51VXfz3Xe6bSxaUTCnzoJKsu
         5d3drFHy7ZwAT3gAluUhjD4QHyZJHby0A7egHuvO11ogIq1DIe9FVpnnVObenD0TlWTa
         GtDg==
X-Gm-Message-State: AOJu0Yzr1BjY4Riug+kCAu6UJqypqZWweJdqw9enVz8Mvdq1yRfjOj54
	cv1+WfB/WZov6Zu3X9bwzIv0dbJkFqOt6E7SBu7NzXy8F70yshKF3UxoQA==
X-Google-Smtp-Source: AGHT+IHgeCrbxV6ynqyeW40JPj+09F+QK90Oihd5mdrEX86yifzlY/rhGemiWFIpyYcLJWm4NEmR9w==
X-Received: by 2002:a05:600c:a085:b0:431:7ca6:57b1 with SMTP id 5b1f17b1804b1-4319ad2d1b4mr163882945e9.32.1730356029134;
        Wed, 30 Oct 2024 23:27:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d69845csm12452615e9.47.2024.10.30.23.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:27:08 -0700 (PDT)
Message-Id: <f4bf8be30b53730cd08f3e1bd85be85947f7ff8b.1730356023.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 31 Oct 2024 06:27:01 +0000
Subject: [PATCH 4/6] path-walk: allow consumer to specify object types
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
 Documentation/technical/api-path-walk.txt |  9 ++++
 path-walk.c                               | 33 ++++++++++--
 path-walk.h                               | 14 ++++-
 t/helper/test-path-walk.c                 | 17 +++++-
 t/t6601-path-walk.sh                      | 63 +++++++++++++++++++++++
 5 files changed, 129 insertions(+), 7 deletions(-)

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
index 9dc56aff88c..14ad322bdd2 100644
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
@@ -154,9 +158,11 @@ static int walk_path(struct path_walk_context *ctx,
 
 	list = strmap_get(&ctx->paths_to_lists, path);
 
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
@@ -198,6 +204,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 	size_t commits_nr = 0, paths_nr = 0;
 	struct commit *c;
 	struct type_and_oid_list *root_tree_list;
+	struct type_and_oid_list *commit_list;
 	struct path_walk_context ctx = {
 		.repo = info->revs->repo,
 		.revs = info->revs,
@@ -209,6 +216,9 @@ int walk_objects_by_path(struct path_walk_info *info)
 
 	trace2_region_enter("path-walk", "commit-walk", info->revs->repo);
 
+	CALLOC_ARRAY(commit_list, 1);
+	commit_list->type = OBJ_COMMIT;
+
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
@@ -219,10 +229,18 @@ int walk_objects_by_path(struct path_walk_info *info)
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
 
@@ -240,6 +258,13 @@ int walk_objects_by_path(struct path_walk_info *info)
 	trace2_data_intmax("path-walk", ctx.repo, "commits", commits_nr);
 	trace2_region_leave("path-walk", "commit-walk", info->revs->repo);
 
+	/* Track all commits. */
+	if (info->commits)
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
index 3c48f017fa0..37c5e3e31e8 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -18,6 +18,7 @@ static const char * const path_walk_usage[] = {
 };
 
 struct path_walk_test_data {
+	uintmax_t commit_nr;
 	uintmax_t tree_nr;
 	uintmax_t blob_nr;
 };
@@ -29,6 +30,11 @@ static int emit_block(const char *path, struct oid_array *oids,
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
@@ -56,6 +62,12 @@ int cmd__path_walk(int argc, const char **argv)
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
 
@@ -78,9 +90,10 @@ int cmd__path_walk(int argc, const char **argv)
 
 	res = walk_objects_by_path(&info);
 
-	printf("trees:%" PRIuMAX "\n"
+	printf("commits:%" PRIuMAX "\n"
+	       "trees:%" PRIuMAX "\n"
 	       "blobs:%" PRIuMAX "\n",
-	       data.tree_nr, data.blob_nr);
+	       data.commit_nr, data.tree_nr, data.blob_nr);
 
 	return res;
 }
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 1f277b88291..4b16a0a3c80 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -31,6 +31,11 @@ test_expect_success 'all' '
 	test-tool path-walk -- --all >out &&
 
 	cat >expect <<-EOF &&
+	COMMIT::$(git rev-parse topic)
+	COMMIT::$(git rev-parse base)
+	COMMIT::$(git rev-parse base~1)
+	COMMIT::$(git rev-parse base~2)
+	commits:4
 	TREE::$(git rev-parse topic^{tree})
 	TREE::$(git rev-parse base^{tree})
 	TREE::$(git rev-parse base~1^{tree})
@@ -57,6 +62,10 @@ test_expect_success 'topic only' '
 	test-tool path-walk -- topic >out &&
 
 	cat >expect <<-EOF &&
+	COMMIT::$(git rev-parse topic)
+	COMMIT::$(git rev-parse base~1)
+	COMMIT::$(git rev-parse base~2)
+	commits:3
 	TREE::$(git rev-parse topic^{tree})
 	TREE::$(git rev-parse base~1^{tree})
 	TREE::$(git rev-parse base~2^{tree})
@@ -80,6 +89,8 @@ test_expect_success 'topic, not base' '
 	test-tool path-walk -- topic --not base >out &&
 
 	cat >expect <<-EOF &&
+	COMMIT::$(git rev-parse topic)
+	commits:1
 	TREE::$(git rev-parse topic^{tree})
 	TREE:left/:$(git rev-parse topic:left)
 	TREE:right/:$(git rev-parse topic:right)
@@ -94,10 +105,62 @@ test_expect_success 'topic, not base' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'topic, not base, only blobs' '
+	test-tool path-walk --no-trees --no-commits \
+		-- topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	commits:0
+	trees:0
+	BLOB:a:$(git rev-parse topic:a)
+	BLOB:left/b:$(git rev-parse topic:left/b)
+	BLOB:right/c:$(git rev-parse topic:right/c)
+	BLOB:right/d:$(git rev-parse topic:right/d)
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
+	COMMIT::$(git rev-parse topic)
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
+	TREE::$(git rev-parse topic^{tree})
+	TREE:left/:$(git rev-parse topic:left)
+	TREE:right/:$(git rev-parse topic:right)
+	trees:3
+	blobs:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_expect_success 'topic, not base, boundary' '
 	test-tool path-walk -- --boundary topic --not base >out &&
 
 	cat >expect <<-EOF &&
+	COMMIT::$(git rev-parse topic)
+	COMMIT::$(git rev-parse base~1)
+	commits:2
 	TREE::$(git rev-parse topic^{tree})
 	TREE::$(git rev-parse base~1^{tree})
 	TREE:left/:$(git rev-parse base~1:left)
-- 
gitgitgadget

