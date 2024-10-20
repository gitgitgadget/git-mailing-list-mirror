Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D62192D87
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431821; cv=none; b=ScJxEK4Nqd9W4bBhEGinmDu/pt31XQuLmvNUOTnXKqlqsEbLaKhTCXcFb66HqWVntdYXbIWP9Lxmj0AzSLzNvKKs36wuLEi3O4pdK+JP8AJnVjdYgPwrWEmsEwkZ2wSIKzhBGkKfiUzQ70uhB1/DrAoS3IaCr7C0Gh7kd25FXUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431821; c=relaxed/simple;
	bh=DhMtzSLbO6KQGxfjDhkLvwejR8ALzzAtYNlSP5BIt78=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=seldk+J9gIlJGzcOa9l+raaKapIq4EcsfGTGlM949Yyct5OhjxMoKY7IL+vNERfTtziMJd8qOBCL7KLFIadM8JtMe3Uaau2MyersOGeqIldEURz9iTan5o4tP8gGYR4fLsWL4SrYxX+ZaFsij6VqseiL7ERixjZaQrxOtnejWHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7puUl3D; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7puUl3D"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a998a5ca499so456121466b.0
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431817; x=1730036617; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQmhKbdfkRQZrIpJL7j3+j8/w3CoauY10DEagaqdgY4=;
        b=B7puUl3DX22PXMb7ymOGqhuL470niGM4oFRlqp73HNzuMYlDI3tlgZWUbVLll+NqlS
         RYNp/mhImm7TboE1E5vbyRtC9h3l0TL3uOmoDH5G60Du//4IZd/0HPpokPvI5GCiO/rJ
         eJyBY5RA1Z7vKH895NgM/4vGT5CHKljePEzdXOHTKXQzjg2MfQd/rFr4VPTK6TgN22P8
         wtVZXnWoBYmH7C4eek4f8Er4jI+N8iT8RK30BN4eV4npGBaU5Hn9bXw0Cyxqn3RNqNa0
         rsI7ELBhugS00ceWpqw4mglfPqTmZMog72arEP/aDk6fbH1/UV7XW6ZM8adqMEEa/rxJ
         aFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431817; x=1730036617;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQmhKbdfkRQZrIpJL7j3+j8/w3CoauY10DEagaqdgY4=;
        b=sVhz3skTzbPVEXpzv1e5NDbthOxh35N0gLvNahIOfE01Yy4V/n6JzNfL0WEzgGYDtq
         NOHNu96tvO/QyW8vwk31p0afZH3xidCXKT82XfVD0tDMgfoBWN/DxdCEfzAWhsIpe9bd
         x3G6djVTgLsNgTNTXzazZsu1/Wjd8zYrMSaYnq3FJohy7gIxeeMLXnTCOpDAByOACzf3
         mIG8KV3OANNtx+SwBrn4XM3O5XU61Ogpnu44HVma8tloGNzm3hOTqjLBFYcBSC3XNn78
         EK31yoBWXvxAyq2XI5xn4Bh6gxKsF7a1hkmG8h2FyJggDZW6KUg0/VqydzDWY98v9OXb
         DADA==
X-Gm-Message-State: AOJu0YxXgt7XYgQzpbQ1dbcYvq6bwnD5c1mo3HcIqbnBnS8fr4J9Yw3V
	4VutL19nezjgdjJSOfLrJZLIol8BQe2TO3vNDBsyCxgIQXeB7gniZ0+LiQ==
X-Google-Smtp-Source: AGHT+IEHKwhRYwAwz5Tlk4LLBdcM9+/28LqM6JBzu1e4FiN7RGvoYUp8H3mjvL+X9/8EYl7/TGsHhQ==
X-Received: by 2002:a17:907:9345:b0:a99:46dd:f397 with SMTP id a640c23a62f3a-a9a69caa3f8mr763703966b.64.1729431816592;
        Sun, 20 Oct 2024 06:43:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d893csm93991366b.16.2024.10.20.06.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:35 -0700 (PDT)
Message-Id: <14375d19392c406d903f6cb26be5a39c4c2ff1e9.1729431810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:16 +0000
Subject: [PATCH v2 03/17] path-walk: allow consumer to specify object types
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

We add the ability to filter the object types in the path-walk API so
the callback function is called fewer times.

This adds the ability to ask for the commits in a list, as well. Future
changes will add the ability to visit annotated tags.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.txt |  9 +++
 path-walk.c                               | 39 ++++++++++--
 path-walk.h                               | 13 +++-
 t/helper/test-path-walk.c                 | 17 +++++-
 t/t6601-path-walk.sh                      | 72 +++++++++++++++++++++++
 5 files changed, 141 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index e588897ab8d..b7ae476ea0a 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -48,6 +48,15 @@ If you want the path-walk API to emit `UNINTERESTING` objects based on the
 commit walk's boundary, be sure to set `revs.boundary` so the boundary
 commits are emitted.
 
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
index 66840187e28..22e1aa13f31 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -84,6 +84,10 @@ static int add_children(struct path_walk_context *ctx,
 		if (S_ISGITLINK(entry.mode))
 			continue;
 
+		/* If the caller doesn't want blobs, then don't bother. */
+		if (!ctx->info->blobs && type == OBJ_BLOB)
+			continue;
+
 		if (type == OBJ_TREE) {
 			struct tree *child = lookup_tree(ctx->repo, &entry.oid);
 			o = child ? &child->object : NULL;
@@ -140,9 +144,11 @@ static int walk_path(struct path_walk_context *ctx,
 
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
@@ -184,6 +190,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 	size_t commits_nr = 0, paths_nr = 0;
 	struct commit *c;
 	struct type_and_oid_list *root_tree_list;
+	struct type_and_oid_list *commit_list;
 	struct path_walk_context ctx = {
 		.repo = info->revs->repo,
 		.revs = info->revs,
@@ -194,19 +201,32 @@ int walk_objects_by_path(struct path_walk_info *info)
 
 	trace2_region_enter("path-walk", "commit-walk", info->revs->repo);
 
+	CALLOC_ARRAY(commit_list, 1);
+	commit_list->type = OBJ_COMMIT;
+
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
 	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
-
 	if (prepare_revision_walk(info->revs))
 		die(_("failed to setup revision walk"));
 
 	while ((c = get_revision(info->revs))) {
-		struct object_id *oid = get_commit_tree_oid(c);
-		struct tree *t = lookup_tree(info->revs->repo, oid);
+		struct object_id *oid;
+		struct tree *t;
 		commits_nr++;
 
+		if (info->commits)
+			oid_array_append(&commit_list->oids,
+					 &c->object.oid);
+
+		/* If we only care about commits, then skip trees. */
+		if (!info->trees && !info->blobs)
+			continue;
+
+		oid = get_commit_tree_oid(c);
+		t = lookup_tree(info->revs->repo, oid);
+
 		if (t) {
 			if (t->object.flags & SEEN)
 				continue;
@@ -220,6 +240,13 @@ int walk_objects_by_path(struct path_walk_info *info)
 	trace2_data_intmax("path-walk", ctx.repo, "commits", commits_nr);
 	trace2_region_leave("path-walk", "commit-walk", info->revs->repo);
 
+	/* Track all commits. */
+	if (info->commits)
+		ret = info->path_fn("", &commit_list->oids, OBJ_COMMIT,
+				    info->path_fn_data);
+	oid_array_clear(&commit_list->oids);
+	free(commit_list);
+
 	string_list_append(&ctx.path_stack, root_path);
 
 	trace2_region_enter("path-walk", "path-walk", info->revs->repo);
diff --git a/path-walk.h b/path-walk.h
index c9e94a98bc8..6ef372d8942 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -30,9 +30,20 @@ struct path_walk_info {
 	 */
 	path_fn path_fn;
 	void *path_fn_data;
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
index ca18b61c3f1..e4788664f93 100755
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
@@ -60,6 +65,10 @@ test_expect_success 'topic only' '
 	test-tool path-walk -- topic >out &&
 
 	cat >expect <<-EOF &&
+	COMMIT::$(git rev-parse topic)
+	COMMIT::$(git rev-parse base~1)
+	COMMIT::$(git rev-parse base~2)
+	commits:3
 	TREE::$(git rev-parse topic^{tree})
 	TREE::$(git rev-parse base~1^{tree})
 	TREE::$(git rev-parse base~2^{tree})
@@ -86,6 +95,8 @@ test_expect_success 'topic, not base' '
 	test-tool path-walk -- topic --not base >out &&
 
 	cat >expect <<-EOF &&
+	COMMIT::$(git rev-parse topic)
+	commits:1
 	TREE::$(git rev-parse topic^{tree})
 	TREE:left/:$(git rev-parse topic:left)
 	TREE:right/:$(git rev-parse topic:right)
@@ -103,10 +114,71 @@ test_expect_success 'topic, not base' '
 	test_cmp expect.sorted out.sorted
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
+	sort expect >expect.sorted &&
+	sort out >out.sorted &&
+
+	test_cmp expect.sorted out.sorted
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
+	sort expect >expect.sorted &&
+	sort out >out.sorted &&
+
+	test_cmp expect.sorted out.sorted
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
+	sort expect >expect.sorted &&
+	sort out >out.sorted &&
+
+	test_cmp expect.sorted out.sorted
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

