Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6B27A473
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529766; cv=none; b=JWwyCN/q2Ltu3DW4RBXRze9hUkrwkfo9B8UIcohLMShZZHGkb4uIGX4upqGzXGh/dHYOQXqZWXt704D0qlHuUiCyiltrPfCUejW/D+tEofClbDrc/4tV42r0d2+AC0PiwMPFIS6Sa0W4N4eNOicsG4MkpIkmI1VXNxP55G3VPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529766; c=relaxed/simple;
	bh=gmyCZB3zWTM8k4RWGkuItSQPpuSBdMWL/FP8ElRLgc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tOLNQigfyhgW8p4WjAGuUYcD7ktoUbAZpZjB7AFiVI9Q533u3G71tfzsDC8SuBtufPqHgdQmrR8Jhh/WibR/Uebn7jEK+5DH9FroSrKsNsTFvHh01ybV2vjSe1jrqKC52vvV/PtqBmAip1hJxmVDQGC26xaPoOUUREw9aYEOqtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XznuVzQL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oOSWiV+O; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XznuVzQL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oOSWiV+O"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFEA711401DD
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:09:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 07:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529763;
	 x=1746616163; bh=MKwBj141fzhap76j86nuA/tufGqGPZNLpHprMcup89M=; b=
	XznuVzQLdlgL/OrrNMvmkD1BLRx+a21JtpVf4WnvvmWnZa55eFtRtqgFVKKziLca
	S9JGFhcr7PAsAXDgMbVlBTFySOuqNw1p7UJsVdHkArt/ey8dMS+5AB3XbEBmjpu3
	eit5YqUIxpqQglFvzfb8lUNriLQv5yG1yqq+QFjuy15pUsV1/AfEy6qJp8YOgscf
	8ecQePG/l4dPh2r+psRvs4xgfxT8hPxEhchx7rmOoDVZwPB4ACAAUwRVZQQeGSXf
	vBTwqeqtY8avr4e0d8g9PMwE0YfR0UFnxq7iL5FSZYk2nUsP9iRjzzCR4mZEkLYM
	Ylu6JJAw730lRBIrHHoWew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529763; x=
	1746616163; bh=MKwBj141fzhap76j86nuA/tufGqGPZNLpHprMcup89M=; b=o
	OSWiV+OXYBsmo1opZhYcfLzLdr5yYpjvAij7EkCRmL+b/+P23m3mhWe1Ae5c/IOU
	xO9u/su2h7ewb7qgWp69BigSQhzYIUbsQaZuCidNaUq42aw2o6Pj2nazCF7+rHn+
	Xrbx5YmnybjfM1ZBiHq1NK+UoUQXpIAfxH+lY5Bq6l8xiFU4sZK+LW+GHEXlunP0
	FEujsOnH7/KDbQmsRaNrnKu5fatxcScASkcfh93g8q7nmWH1ICHPOTE5zxTixYcS
	4/uxiE+FhG7TROaEcLtBvpnudaO54A7PLrblVMHixeNg+Ea/YqsDQ5qCUycyBqQ4
	77GSUwWtnWC0egGaTaGBQ==
X-ME-Sender: <xms:4-0ZaLxA37Qr4wwFBuztFn40IfRBKHZfW_dbHMRvLkbEn3PqEa_hDQ>
    <xme:4-0ZaDSUfZTq2JeXJUG61krpoSnK_ECpN2KCveYVWTYa1v82KKU43w3Gve9EoegqI
    EmXVQ6C1Fz0IdhRUw>
X-ME-Received: <xmr:4-0ZaFUq77v6BLW7uMn7a7izTuRC2L0tN_SjpW2eBZgRNk3VKsXW7tNEia8Ijw3tcPwHk_R77k85F_uZb-uD5GoY9AaALCAr1idS6mZX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4-0ZaFjQHOaey0jZnCTzRFQFJaHwRGDExuJ_BYo7pF84yutccesqAw>
    <xmx:4-0ZaNCJ13pVnXZFeEdsda2Q-FPVjXbfH-2tGeZyaD_SCKUm5FhQ5g>
    <xmx:4-0ZaOIpPeCGeFLnMVkLo2DAk1IwUXb-D5oA8K3PHHZZASJ_NmB6Dw>
    <xmx:4-0ZaMByoXivjwyXWSZlhDWxiy0Y2DzROBzCrFRFx1AcZb46FhiOOg>
    <xmx:4-0ZaBu35ivwRuQeQAd9XHvR6kYVezgcv0ZJlJDa2XMnxrSLC9MO1rOH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 07:09:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f24fcf9a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 11:09:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 13:09:18 +0200
Subject: [PATCH 05/17] odb: get rid of `the_repository` in `find_odb()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-object-store-wo-the-repository-v1-5-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Get rid of our dependency on `the_repository` in `find_odb()` by passing
in the object database in which we want to search for the backend and
adjusting all callers.

Rename the function to `odb_find_backend()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 18 +++++++++---------
 midx-write.c           |  2 +-
 odb.c                  | 14 +++++++-------
 odb.h                  |  7 ++++++-
 4 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 0a184d39720..28550d3bcc9 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -66,7 +66,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 			struct repository *repo UNUSED)
 {
 	struct commit_graph *graph = NULL;
-	struct odb_backend *odb = NULL;
+	struct odb_backend *backend = NULL;
 	char *graph_name;
 	char *chain_name;
 	enum { OPENED_NONE, OPENED_GRAPH, OPENED_CHAIN } opened = OPENED_NONE;
@@ -101,9 +101,9 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
-	odb = find_odb(the_repository, opts.obj_dir);
-	graph_name = get_commit_graph_filename(odb);
-	chain_name = get_commit_graph_chain_filename(odb);
+	backend = odb_find_backend(the_repository->objects, opts.obj_dir);
+	graph_name = get_commit_graph_filename(backend);
+	chain_name = get_commit_graph_chain_filename(backend);
 	if (open_commit_graph(graph_name, &fd, &st))
 		opened = OPENED_GRAPH;
 	else if (errno != ENOENT)
@@ -120,7 +120,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 	if (opened == OPENED_NONE)
 		return 0;
 	else if (opened == OPENED_GRAPH)
-		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, odb);
+		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, backend);
 	else
 		graph = load_commit_graph_chain_fd_st(the_repository, fd, &st,
 						      &incomplete_chain);
@@ -221,7 +221,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 	struct oidset commits = OIDSET_INIT;
-	struct odb_backend *odb = NULL;
+	struct odb_backend *backend = NULL;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
 	struct progress *progress = NULL;
@@ -289,10 +289,10 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	odb = find_odb(the_repository, opts.obj_dir);
+	backend = odb_find_backend(the_repository->objects, opts.obj_dir);
 
 	if (opts.reachable) {
-		if (write_commit_graph_reachable(odb, flags, &write_opts))
+		if (write_commit_graph_reachable(backend, flags, &write_opts))
 			result = 1;
 		goto cleanup;
 	}
@@ -318,7 +318,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 		stop_progress(&progress);
 	}
 
-	if (write_commit_graph(odb,
+	if (write_commit_graph(backend,
 			       opts.stdin_packs ? &pack_indexes : NULL,
 			       opts.stdin_commits ? &commits : NULL,
 			       flags,
diff --git a/midx-write.c b/midx-write.c
index dd3b3070e55..e8371a84a14 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -922,7 +922,7 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 	struct strbuf cur_path_real = STRBUF_INIT;
 
 	/* Ensure the given object_dir is local, or a known alternate. */
-	find_odb(r, obj_dir_real);
+	odb_find_backend(r->objects, obj_dir_real);
 
 	for (cur = get_multi_pack_index(r); cur; cur = cur->next) {
 		strbuf_realpath(&cur_path_real, cur->object_dir, 1);
diff --git a/odb.c b/odb.c
index 67207ce636d..6359c541d78 100644
--- a/odb.c
+++ b/odb.c
@@ -448,15 +448,15 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 	return ref_git;
 }
 
-struct odb_backend *find_odb(struct repository *r, const char *obj_dir)
+struct odb_backend *odb_find_backend(struct object_database *odb, const char *obj_dir)
 {
-	struct odb_backend *odb;
+	struct odb_backend *backend;
 	char *obj_dir_real = real_pathdup(obj_dir, 1);
 	struct strbuf odb_path_real = STRBUF_INIT;
 
-	prepare_alt_odb(r);
-	for (odb = r->objects->backends; odb; odb = odb->next) {
-		strbuf_realpath(&odb_path_real, odb->path, 1);
+	prepare_alt_odb(odb->repo);
+	for (backend = odb->backends; backend; backend = backend->next) {
+		strbuf_realpath(&odb_path_real, backend->path, 1);
 		if (!strcmp(obj_dir_real, odb_path_real.buf))
 			break;
 	}
@@ -464,9 +464,9 @@ struct odb_backend *find_odb(struct repository *r, const char *obj_dir)
 	free(obj_dir_real);
 	strbuf_release(&odb_path_real);
 
-	if (!odb)
+	if (!backend)
 		die(_("could not find object directory matching %s"), obj_dir);
-	return odb;
+	return backend;
 }
 
 static void fill_alternate_refs_command(struct child_process *cmd,
diff --git a/odb.h b/odb.h
index 1617a9bac2c..a8c0f788969 100644
--- a/odb.h
+++ b/odb.h
@@ -56,7 +56,6 @@ struct odb_backend {
 void prepare_alt_odb(struct repository *r);
 int has_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
-struct odb_backend *find_odb(struct repository *r, const char *obj_dir);
 typedef int alt_odb_fn(struct odb_backend *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
 typedef void alternate_ref_fn(const struct object_id *oid, void *);
@@ -183,6 +182,12 @@ struct object_database {
 struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
+/*
+ * Find backend by its object directory path. Dies in case the object directory
+ * couldn't be found.
+ */
+struct odb_backend *odb_find_backend(struct object_database *odb, const char *obj_dir);
+
 /*
  * Create a temporary file rooted in the object database directory, or
  * die on failure. The filename is taken from "pattern", which should have the

-- 
2.49.0.1045.g170613ef41.dirty

