Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3D1553A2
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935348; cv=none; b=Lhnu0T1a9hjUz1yrMwWh7/Qzsn3NWITOjYvtkKLQKguKqU4s+KaGFPEHnfH5Y18uhh4c1BUoIJdiHffAn52FmKZNtSLHhUX29+RMSzfb2k7NYgOpeZ+nk0VgGPUZHoPNvROCuBFafjMRj65YbW2egKGlbPSlSIuZy3qgYDY0Ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935348; c=relaxed/simple;
	bh=QRJsSZc60IEV4ZDpcbs9kydefRBOi/HwlQC97Qvrkxs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QZWOE+VbkioJD7R8za2N2XMSOWOt+SAt/pf+24XsiuNnWtIROxWRkfDgAjBlGdzl+lNR4ZhzaXnivf67fYt9jJgE44Efsv2sykEFcsukrAovmgIMeBYr7qttSoYP3DhgzQGw4I5Lj/t6f1zP8BlQHLO3471FWLeqfRhngSK6SR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpOm1nzo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpOm1nzo"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c263118780so285892a12.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935344; x=1726540144; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbVTtYaEPCjJM/2vZZq/HednK1w+JHK8tzmD/VLle5o=;
        b=YpOm1nzoYqtyQV2oXbQ3hKyYDlCrsOuXRuQzQTIOZxe7rJ9+8a3haM+ViHBm+604A6
         +N44eKE7MNHoJenAFRH4LV/jJHR3ekpoMcK5RpYIbKFqz6iDppcKAz53pLjla/L+EHUL
         HysNpTiNjXGYD625NkCEggV8Hgzk6/gsPNLBScaIjAIxZK6URH8UZTRQN2Cq+B42nK1b
         q/WtS/8LoYvbWwrLG4uLSLjWhZjaQYAMkVq9fG4vMwOBgUzLLm0ONfEK2YyeiVdYzeKH
         V3xK8p8wjZM5chL06lM3rmf0rtqX76J/JftKOZEBYIjpktrYZQWWb2FUsJ88ZhRA6pKh
         s6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935344; x=1726540144;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbVTtYaEPCjJM/2vZZq/HednK1w+JHK8tzmD/VLle5o=;
        b=t0TOzeMGhjBVdT8Dv5FCmufQ6fNm2qLojZ57772m/Qkz2MuqEfp3X9XGftHefeJyAP
         5011mB1MFEvOhN5WH5X8R2cJ1GMuOppMjxb0Ra6Ihhf3CNS/VpxyxLyNAU5vyuBOz3cv
         oE4b88CRYgVgYBj4tWBkS5M4GYJr1E/8Ijyy10A9mMX9CW1gIl9eTgySImUvjAhIUuHC
         9d7brHB8AJ2uEHgvCPbHHDDkRsxwQkyUwTlafts8cy1OdmrQnRLCGxIMe9MqzB6ju+J0
         or6c3lzVZ4B1IxRt9Go1xnvWNNlqmgypmshFaaHtvFtXsmdCw+QgJcCmKbXeWLBr0x5p
         /pEQ==
X-Gm-Message-State: AOJu0YwzOUgwlSLmMdchA/Mf1eNj2PqRvpU6Hn7hB6F0DYl//VdRB5Cf
	nJ59XpsoPHC29JxNVLZIC5zHGv2O4ZcgBzOCPLkMKC+SeGPYu1ROtlJ9Ig==
X-Google-Smtp-Source: AGHT+IH6iJc6IJM2REftbErvoUcKKbD/+lQHT0iUush/Izw9TQEYGD3eHAbl1W9Nl9S0kY0oOdPIyg==
X-Received: by 2002:a17:907:3181:b0:a86:aa57:57b8 with SMTP id a640c23a62f3a-a8a888d0570mr1090913866b.63.1725935343807;
        Mon, 09 Sep 2024 19:29:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced17asm420038366b.170.2024.09.09.19.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:03 -0700 (PDT)
Message-Id: <2829fe3875438f3a9907f36d825d6c24952abded.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:32 +0000
Subject: [PATCH 07/30] path-walk: allow consumer to specify object types
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

This adds the ability to ask for the commits as a single list. This will
also reduce the calls in 'git backfill' to be a BUG() statement if called
with anything other than blobs.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/backfill.c |  2 +-
 path-walk.c        | 40 ++++++++++++++++++++++++++++++++++------
 path-walk.h        | 12 +++++++++++-
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 82a18e58a41..2a1b043f188 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -61,7 +61,7 @@ static int fill_missing_blobs(const char *path,
 	struct backfill_context *ctx = data;
 
 	if (type != OBJ_BLOB)
-		return 0;
+		BUG("fill_missing_blobs only takes blob objects");
 
 	for (size_t i = 0; i < list->nr; i++) {
 		off_t size = 0;
diff --git a/path-walk.c b/path-walk.c
index dc2390dd9ea..d70e6840fb5 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -83,6 +83,10 @@ static int add_children(struct path_walk_context *ctx,
 		if (S_ISGITLINK(entry.mode))
 			continue;
 
+		/* If the caller doesn't want blobs, then don't bother. */
+		if (!ctx->info->blobs && type == OBJ_BLOB)
+			continue;
+
 		if (type == OBJ_TREE) {
 			struct tree *child = lookup_tree(ctx->repo, &entry.oid);
 			o = child ? &child->object : NULL;
@@ -156,9 +160,11 @@ static int walk_path(struct path_walk_context *ctx,
 
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
@@ -200,6 +206,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 	size_t commits_nr = 0, paths_nr = 0;
 	struct commit *c;
 	struct type_and_oid_list *root_tree_list;
+	struct type_and_oid_list *commit_list;
 	struct path_walk_context ctx = {
 		.repo = info->revs->repo,
 		.revs = info->revs,
@@ -210,28 +217,49 @@ int walk_objects_by_path(struct path_walk_info *info)
 
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
 		if (t)
 			oid_array_append(&root_tree_list->oids, oid);
 		else
 			warning("could not find tree %s", oid_to_hex(oid));
+
 	}
 
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
index bc1ebba5081..49b982dade6 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -32,6 +32,14 @@ struct path_walk_info {
 	path_fn path_fn;
 	void *path_fn_data;
 
+	/**
+	 * Initialize which object types the path_fn should be called on. This
+	 * could also limit the walk to skip blobs if not set.
+	 */
+	int commits;
+	int trees;
+	int blobs;
+
 	/**
 	 * Specify a sparse-checkout definition to match our paths to. Do not
 	 * walk outside of this sparse definition. If the patterns are in
@@ -43,7 +51,9 @@ struct path_walk_info {
 	struct pattern_list *pl;
 };
 
-#define PATH_WALK_INFO_INIT { 0 }
+#define PATH_WALK_INFO_INIT {   \
+	.blobs = 1,		\
+}
 
 /**
  * Given the configuration of 'info', walk the commits based on 'info->revs' and
-- 
gitgitgadget

