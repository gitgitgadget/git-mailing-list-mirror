Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7411D95B3
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514369; cv=none; b=gJnP32zbCyuz9e12+oaNVuKQbgUQWtyRkL9c/hEU1WonVM2lU6oVIvbv2rbRRaKstCpebSEaKsyIxfmibo2Soj/PliVr6m8HZ8BfxsSW1l5Ob/shIpX0Mz5C9+yJ+YPqAQPcEjDDuhVlP6clzWmfb9HfPz5Cs/NqKW+J0BHO27A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514369; c=relaxed/simple;
	bh=c69QMRIQgBxeeosu/SUWZ8uwxVfVLwrtR18tIuOqEuI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I9va8/zGCaGfoj1Bo/S+dc89uJ2ZGDujr+E396aDmJTP53VJhPIb1zAkBN3fGmalhHZaLiJ83JFMMAcwX9SLYba2TqLWWrGrdyu4MHcvtd8knNwWQngSPFKSEQ2U7Dcm70mNejVMNDtueBrXe9kq0C4gWJLqmSecvqpZBHr3bAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To9TwVTj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To9TwVTj"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e27c75f4so1903162f8f.2
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 11:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733514365; x=1734119165; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruO3A6BE7P15W+qA4nk9ZOT+xqeQ7hwu/TsiJTH9Mp0=;
        b=To9TwVTjJTflJmnx39VEA3TZ+ohX60oAdTExqp6TkO5R6Hna+Kc+dclrvczA3Ceskd
         anypDpMJhra4F4Q3vUzcrZklvBnqfaPlOrkaNqXEO6VzcUTlKioRQPNWY+6T7SlaLYIJ
         TzyaSIp7mVCV/GvnXSmRusB49aXuSKZClGsBgzKHs/F3IKiUHzKovRdH/cX3o61jtVIx
         SIJ3oZElxG/kjrEENIPFfbejYcITZzKuHPDt3kF2pRPtPgKqcOTj7nQ+yvD1BeBLFCuT
         OKONVOOT2iB8JhsnEIaE1uq64XYtx5Ekz5O8a0BR3//XXaHkgwcG5p7MLGVhhJ3QiYpe
         s0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514365; x=1734119165;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruO3A6BE7P15W+qA4nk9ZOT+xqeQ7hwu/TsiJTH9Mp0=;
        b=J+SmUTlYax/tCT1JA56+IN6GHQCapzlg4t9OvVhk4gJn2knPQwYjYaFVDycYSYqKuv
         DYyrx+L+Z9F7c67XYv+cxDBS2eNjzjHsG+1X/+tp0R9n3X2fiWyPWlv11ff52RUGDun3
         xD2oCKyoJimYdPXB9cMKGKxQ8mlbeYHhR3Vhq/UyLeg2eCGUKNky6HYL/Tj9GwNd/pjd
         T0BNb2x26cglg5D1fKH1bRX3YdiWZRBXL9PjmuppeccMTqInZWFQCNCyjQYhLjDN69AM
         NVVWRqslG/rqmbs7TIA4I4QnHMRbdlesGcAmnqTShGLKwwlmNLPqGWAk4RCXikWTwX8+
         9U9Q==
X-Gm-Message-State: AOJu0YwjY8UJgQggaXp5uUzh7Ob5KcUA8mDCTS29KtBY5ym1VZ9p6m+Z
	OgCpqYU0LF7hQ6/qR0AEdKkwk0kgOir/DqI0JzL47ZmrX33f/kLTud6SKg==
X-Gm-Gg: ASbGnctgxoiKZ7S7y0As2qIZqDFyY/c5JFnC7rzPYBdns18ObbCKEkWrGB9n2sjRlVo
	A91DJxM1R3b00qARztxCf/tiYZB9zt23/dPaVexSgchGLxPtuNSy3qRnjNrI/36ecooyG3O2rZG
	/DsKj2L7IeJyuOs+lGuVWhz5VGwPLwOgA9WCVwQZ2MeGFvRFCYGMQn+5BY/NKy/Ny5VjIvtJUk0
	OyoLsqJpnmQe5TMfwOLV1JzXFn9iH7di3d0QQZ8ej9+hAoCd54=
X-Google-Smtp-Source: AGHT+IHO6dcWx1XgaFLb9iaXd65YI39itKLtB/PGXfX3e+7URyqJecASHyMP7+d1E4MtWHP41aIQrg==
X-Received: by 2002:a05:6000:401e:b0:385:f44a:a3b with SMTP id ffacd0b85a97d-3862b3e6b94mr2847501f8f.41.1733514364562;
        Fri, 06 Dec 2024 11:46:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862f02f5c3sm1512941f8f.65.2024.12.06.11.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:46:04 -0800 (PST)
Message-Id: <42e71e6285f6a6976aee4ce04f1285bcb0305223.1733514359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
	<pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 19:45:55 +0000
Subject: [PATCH v3 4/7] path-walk: allow consumer to specify object types
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

