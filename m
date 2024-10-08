Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0C11DF98F
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396733; cv=none; b=kryfJbZVa2VyluwQlpS7zj5kn2rHNOHaz3Kk7w52pfWQb4CSL21lV5S29nWy8ualKzroS4uM43aKom4uIGwaHgpOd1HIPFNrNg9HXvMB9LAXOW9GWy3UdyDRdOTQywNuP9PvBU/QUU4vPO05+tbIFSx+dt949LTDaK1EZU8A2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396733; c=relaxed/simple;
	bh=DhMtzSLbO6KQGxfjDhkLvwejR8ALzzAtYNlSP5BIt78=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IOtVAX11GtmUDYEIk/cngvLxXnme848wyxpS9N4JC64K90l7hqZxHsWk9f9dpj0MQJbJ0m2qdcvKpWQgAY+14iI5U5DofsjmAVmkqX/Y2v8lrf9UnKao9NZUuycI3Reyjs4Sl6n4fAGtK3Bcq0aiNU/ZjMnQ1AZV50tRBXF8P5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK+HzVHY; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK+HzVHY"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2facaa16826so48791371fa.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396729; x=1729001529; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQmhKbdfkRQZrIpJL7j3+j8/w3CoauY10DEagaqdgY4=;
        b=mK+HzVHYxih/w7TMGb/+i3bm/6ICi6huqOEjGOwQEJdjjVYJ4oXLHVUCrRIK/jR8JQ
         t42eO/MPepGqghcEnqMjA8mZ/7whPcC634qfh2RGbv9s5YXPrftWo7fOK2IL0O7A15vT
         DkPXFtKD6tu9jOzv3uvhIGh503MqFpKKpHzpnyPVdXrY6hW5okPpO+upTh8iueMzeDZy
         YAJ+ibQvcRJZkr0IvuqOnIEyNEKVzoaTFUkF2jpesugnaUzirJtC2iGP0Yoxul7AI12A
         VYXzTJwnAN13/RNLpnEJUD44kS1gxO7ZHI96d1B1OltmkEt1qcmuxCvhOohnqnxGgh58
         C8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396729; x=1729001529;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQmhKbdfkRQZrIpJL7j3+j8/w3CoauY10DEagaqdgY4=;
        b=sHlNn8CRS03Tx7wU42TYNsGujiF5foTvcaPibvhgwbU0tyc+oTx0N8wAS0F5NFFLTc
         /ASc7jiKfrsx3osaiUT8zw6jvPYi5JoaRWQpxc3mibYmHSex9zYQ72qqpjI+mW84e44u
         PUYubWvRDRXuDLf2zvTK+H3KjtnY+w95bhkX2yAFuuySlyaPvyX5izUskQmFCMPier6S
         8amtHh5cYXdF/MuWiOgjyEfhTrwwJArKn6WCLcykXc5dAAu79pjnNtUwrTiP40kiE3Z2
         RCIwMHQ2xSe7dX+S12eipqMM4WXcqRlCiSym3iQSmVgn7IAKJxkrKLSoWbIEEV6rW9yz
         U9qw==
X-Gm-Message-State: AOJu0YyVGJjtbFXoRh0+WwcgC2cWDsaKGKE1oFQF4OieUgXNjpiihkhq
	E1o0VD7YSY9nStGOSX6ODWEVK9qwwlfS64Ay4T5FwD1cffOwNOzBFa0IRg==
X-Google-Smtp-Source: AGHT+IE5qpJ3O13B7Dj3nRowIfd325QcUwnOhSV1k2Uh+t0mvyQtiCzr6tQgbkXx3VEPA65ma+wwjA==
X-Received: by 2002:a2e:be9d:0:b0:2f7:ad6b:a31e with SMTP id 38308e7fff4ca-2faf3d75b0dmr63879161fa.31.1728396728469;
        Tue, 08 Oct 2024 07:12:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05a7e87sm4322495a12.24.2024.10.08.07.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:07 -0700 (PDT)
Message-Id: <14375d19392c406d903f6cb26be5a39c4c2ff1e9.1728396724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:11:49 +0000
Subject: [PATCH 03/17] path-walk: allow consumer to specify object types
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

