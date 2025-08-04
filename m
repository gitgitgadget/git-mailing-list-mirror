Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339882417C6
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295467; cv=none; b=nybFKzB0NgjOkkeEUFLYQq1/EhvKN1aYy5+IcjPPTkrqkiOVUhORPICtGopNmsppD1MktZJA/iic1wbWQA63a1jtXFIhxcJpWsg8H6GrwbLz04QXiwS2CsXcd4qH9XPCRHuXxr0sR+MciaEe/IT8ifgi6OpSXjO2+qgogLOJq8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295467; c=relaxed/simple;
	bh=NcO7uG1AFfcQjBGdwb5W7AyJeopMn4JvsNBi1Hx+Z1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QFm+Z33QTrJTyl+tymkD1mT5QQeQfYNgJiRz9loQfRAsDuF3iR4zZe/7W+2gU8+zAKoXHTqjIJne4AnKVDlTuj+0blId/rTSr3OylsudLkgEui3JezXmRtSMGSsnB46r5t//EoR3OIrVQI8PmqqNMMXddHo0eMmLOAmml+e6t4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fEsdJFUa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YPz5XpvN; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fEsdJFUa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YPz5XpvN"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B0487A00BA
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 04:17:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 04 Aug 2025 04:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754295463;
	 x=1754381863; bh=+4yDrSFwzsn5HsefOzyDEoeN38IrZVkwdYZdR85zhKQ=; b=
	fEsdJFUaMsqdZxjbUDPvVgZGXJdMiCfXNJo8q7D2kLLnB4ko3c84mE4SNc3pxgAI
	qbMygwnFtz6bBDsS6HxHtlJYTfsY8TWcE5XH7/d8C8VPPC42php1zcguhTfFguuW
	G0/7sMx/1QQQZATdD0J1XjOvPvd+kI2HmMs/yULyb/6S+RVwavYa64n90h0xHnzC
	BckBX90I3t3bWYBISG/8kyB0J6gmxOgGLah+U3mvR48Ogouws3bt8jeM/6bvJxTh
	cJkxyoGDgNL/dUvLAwyxFVnelY8nocr/4zz3QFhHKxOfFuoolezfi8soozlVPa2N
	F8SoZxgxcvnXbO5k0L1NxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754295463; x=
	1754381863; bh=+4yDrSFwzsn5HsefOzyDEoeN38IrZVkwdYZdR85zhKQ=; b=Y
	Pz5XpvN1cPpEO2CHSErTZd5KJX3Ebm20fD+CVuNFU0bUgnurltUrYfnRrSJn8lz2
	bOZAqFKuYuQuXO+e8sf+7Dwm0S2gjSA0TE8YgcRtc192njbMByQSqtXG33UzYHWa
	v3wW0R1vw9fPq3TTA5mTWyaMhi29DtHJCp/66EaWwNVsexTK5QZ/uTO7X1tbGYuT
	XILHWIIE78Ntl/62HhXrkWYE7iV0hcbRRxRCJCm8pTNYcNCZ2U08ZmFkI/G2P6q1
	QSmkIbZTgRr70U17GVaCL843PwDix6/C4LgOMp1cThAbWd8WPFJXHBPqlNoylNY8
	wQEp+J05h1b+lU2YiY1Ug==
X-ME-Sender: <xms:p2yQaBRUoERXZNYLUximUylhDlgWM2f3B_12dSiOOVav85rHmQ_XDQ>
    <xme:p2yQaMwvYJqu94oaBFOxYI4LsbbtUqxgx3ATCZiB8SKAjmZcVAtV6sj_gorF08qR3
    -06WdDELX-ekyOaAQ>
X-ME-Received: <xmr:p2yQaAMja4ZfA9G3hM_AxRuu_YPMsFi4NEqSpsI8xUm26GKqLNzqPx1WzEvT4b2_Kvzgp0E3QoWHLa9IoxRqnu1fekpp2MSopn0J-HqRsYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:p2yQaLOP-_7l9Gz2kHuZHZgW461E4N9h1iXNAmHkxXjTWqU4bxdIBg>
    <xmx:p2yQaCTu5Qifb470RHU6kwNXKqY3J8kfqe8ywOQQKHI5lljali0OgA>
    <xmx:p2yQaNDGCS4oFf9uJ4INYl0mcUPiqkYuQN75htwhfXmIsqV9VoWCPA>
    <xmx:p2yQaBgmHONDCFxXvxfdrF_VwyyZzrS0MwAh49Rxmck2Y79o_jGZiw>
    <xmx:p2yQaGIHRsRr9NZlf_kLl_oSl9SSqBBl0nMCn6_oFJSR-FSNBXrYdJE8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Aug 2025 04:17:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dae5fd21 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Aug 2025 08:17:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 10:17:23 +0200
Subject: [PATCH 7/9] commit-graph: stop using `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-b4-pks-commit-graph-wo-the-repository-v1-7-850d626eb2e8@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_hash_algo` as it implicitly relies on `the_repository`.
Instead, we either use the hash algo provided via the context or, if
there is no such hash algo, we use `the_repository` explicitly. Such
uses will be removed in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c       |  3 ++-
 commit-graph.c               | 40 +++++++++++++++++++++-------------------
 commit-graph.h               |  4 +++-
 oss-fuzz/fuzz-commit-graph.c |  4 +++-
 4 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 145802afb79..680b03a83a8 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -108,7 +108,8 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 		opened = OPENED_GRAPH;
 	else if (errno != ENOENT)
 		die_errno(_("Could not open commit-graph '%s'"), graph_name);
-	else if (open_commit_graph_chain(chain_name, &fd, &st))
+	else if (open_commit_graph_chain(chain_name, &fd, &st,
+					 the_repository->hash_algo))
 		opened = OPENED_CHAIN;
 	else if (errno != ENOENT)
 		die_errno(_("could not open commit-graph chain '%s'"), chain_name);
diff --git a/commit-graph.c b/commit-graph.c
index 9c2278dd7a1..b3feb6dfd77 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -263,7 +263,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 
 	graph_size = xsize_t(st->st_size);
 
-	if (graph_size < graph_min_size(the_hash_algo)) {
+	if (graph_size < graph_min_size(r->hash_algo)) {
 		close(fd);
 		error(_("commit-graph file is too small"));
 		return NULL;
@@ -271,7 +271,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 	prepare_repo_settings(r);
-	ret = parse_commit_graph(&r->settings, graph_map, graph_size);
+	ret = parse_commit_graph(&r->settings, r->hash_algo, graph_map, graph_size);
 
 	if (ret)
 		ret->odb_source = source;
@@ -319,7 +319,7 @@ static int graph_read_commit_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
 	struct commit_graph *g = data;
-	if (chunk_size / graph_data_width(the_hash_algo) != g->num_commits)
+	if (chunk_size / graph_data_width(g->hash_algo) != g->num_commits)
 		return error(_("commit-graph commit data chunk is wrong size"));
 	g->chunk_commit_data = chunk_start;
 	return 0;
@@ -373,6 +373,7 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 }
 
 struct commit_graph *parse_commit_graph(struct repo_settings *s,
+					const struct git_hash_algo *hash_algo,
 					void *graph_map, size_t graph_size)
 {
 	const unsigned char *data;
@@ -384,7 +385,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	if (!graph_map)
 		return NULL;
 
-	if (graph_size < graph_min_size(the_hash_algo))
+	if (graph_size < graph_min_size(hash_algo))
 		return NULL;
 
 	data = (const unsigned char *)graph_map;
@@ -404,22 +405,22 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	hash_version = *(unsigned char*)(data + 5);
-	if (hash_version != oid_version(the_hash_algo)) {
+	if (hash_version != oid_version(hash_algo)) {
 		error(_("commit-graph hash version %X does not match version %X"),
-		      hash_version, oid_version(the_hash_algo));
+		      hash_version, oid_version(hash_algo));
 		return NULL;
 	}
 
 	graph = alloc_commit_graph();
 
-	graph->hash_algo = the_hash_algo;
+	graph->hash_algo = hash_algo;
 	graph->num_chunks = *(unsigned char*)(data + 6);
 	graph->data = graph_map;
 	graph->data_len = graph_size;
 
 	if (graph_size < GRAPH_HEADER_SIZE +
 			 (graph->num_chunks + 1) * CHUNK_TOC_ENTRY_SIZE +
-			 GRAPH_FANOUT_SIZE + the_hash_algo->rawsz) {
+			 GRAPH_FANOUT_SIZE + hash_algo->rawsz) {
 		error(_("commit-graph file is too small to hold %u chunks"),
 		      graph->num_chunks);
 		free(graph);
@@ -618,7 +619,8 @@ static int add_graph_to_chain(struct commit_graph *g,
 }
 
 int open_commit_graph_chain(const char *chain_file,
-			    int *fd, struct stat *st)
+			    int *fd, struct stat *st,
+			    const struct git_hash_algo *hash_algo)
 {
 	*fd = git_open(chain_file);
 	if (*fd < 0)
@@ -627,7 +629,7 @@ int open_commit_graph_chain(const char *chain_file,
 		close(*fd);
 		return 0;
 	}
-	if (st->st_size < (ssize_t) the_hash_algo->hexsz) {
+	if (st->st_size < (ssize_t) hash_algo->hexsz) {
 		close(*fd);
 		if (!st->st_size) {
 			/* treat empty files the same as missing */
@@ -652,7 +654,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	FILE *fp = xfdopen(fd, "r");
 	size_t count;
 
-	count = st->st_size / (the_hash_algo->hexsz + 1);
+	count = st->st_size / (r->hash_algo->hexsz + 1);
 	CALLOC_ARRAY(oids, count);
 
 	odb_prepare_alternates(r->objects);
@@ -714,7 +716,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	int fd;
 	struct commit_graph *g = NULL;
 
-	if (open_commit_graph_chain(chain_file, &fd, &st)) {
+	if (open_commit_graph_chain(chain_file, &fd, &st, r->hash_algo)) {
 		int incomplete;
 		/* ownership of fd is taken over by load function */
 		g = load_commit_graph_chain_fd_st(r, fd, &st, &incomplete);
@@ -906,7 +908,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 		die(_("invalid commit position. commit-graph is likely corrupt"));
 
 	lex_index = pos - g->num_commits_in_base;
-	commit_data = g->chunk_commit_data + st_mult(graph_data_width(the_hash_algo), lex_index);
+	commit_data = g->chunk_commit_data + st_mult(graph_data_width(g->hash_algo), lex_index);
 
 	graph_data = commit_graph_data_at(item);
 	graph_data->graph_pos = pos;
@@ -1110,7 +1112,7 @@ static struct tree *load_tree_for_commit(struct repository *r,
 		g = g->base_graph;
 
 	commit_data = g->chunk_commit_data +
-			st_mult(graph_data_width(the_hash_algo),
+			st_mult(graph_data_width(g->hash_algo),
 				graph_pos - g->num_commits_in_base);
 
 	oidread(&oid, commit_data, the_repository->hash_algo);
@@ -1220,7 +1222,7 @@ static int write_graph_chunk_oids(struct hashfile *f,
 
 	for (count = 0; count < ctx->commits.nr; count++, list++) {
 		display_progress(ctx->progress, ++ctx->progress_cnt);
-		hashwrite(f, (*list)->object.oid.hash, the_hash_algo->rawsz);
+		hashwrite(f, (*list)->object.oid.hash, f->algop->rawsz);
 	}
 
 	return 0;
@@ -1251,7 +1253,7 @@ static int write_graph_chunk_data(struct hashfile *f,
 			die(_("unable to parse commit %s"),
 				oid_to_hex(&(*list)->object.oid));
 		tree = get_commit_tree_oid(*list);
-		hashwrite(f, tree->hash, the_hash_algo->rawsz);
+		hashwrite(f, tree->hash, ctx->r->hash_algo->rawsz);
 
 		parent = (*list)->parents;
 
@@ -2033,7 +2035,7 @@ static size_t write_graph_chunk_base_1(struct hashfile *f,
 		return 0;
 
 	num = write_graph_chunk_base_1(f, g->base_graph);
-	hashwrite(f, g->oid.hash, the_hash_algo->rawsz);
+	hashwrite(f, g->oid.hash, g->hash_algo->rawsz);
 	return num + 1;
 }
 
@@ -2057,7 +2059,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct hashfile *f;
 	struct tempfile *graph_layer; /* when ctx->split is non-zero */
 	struct lock_file lk = LOCK_INIT;
-	const unsigned hashsz = the_hash_algo->rawsz;
+	const unsigned hashsz = ctx->r->hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	struct chunkfile *cf;
 	unsigned char file_hash[GIT_MAX_RAWSZ];
@@ -2145,7 +2147,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
 	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, oid_version(the_hash_algo));
+	hashwrite_u8(f, oid_version(ctx->r->hash_algo));
 	hashwrite_u8(f, get_num_chunks(cf));
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
 
diff --git a/commit-graph.h b/commit-graph.h
index f20d28ff3a0..f26881849d6 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -32,7 +32,8 @@ struct string_list;
 char *get_commit_graph_filename(struct odb_source *source);
 char *get_commit_graph_chain_filename(struct odb_source *source);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
-int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st);
+int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st,
+			    const struct git_hash_algo *hash_algo);
 
 /*
  * Given a commit struct, try to fill the commit struct info, including:
@@ -129,6 +130,7 @@ struct repo_settings;
  * prior to calling parse_commit_graph().
  */
 struct commit_graph *parse_commit_graph(struct repo_settings *s,
+					const struct git_hash_algo *hash_algo,
 					void *graph_map, size_t graph_size);
 
 /*
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index fbb77fec197..879072f9d3c 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -5,6 +5,7 @@
 #include "repository.h"
 
 struct commit_graph *parse_commit_graph(struct repo_settings *s,
+					const struct git_hash_algo *hash_algo,
 					void *graph_map, size_t graph_size);
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
@@ -24,7 +25,8 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
 	the_repository->settings.commit_graph_generation_version = 2;
 	the_repository->settings.commit_graph_changed_paths_version = 1;
-	g = parse_commit_graph(&the_repository->settings, (void *)data, size);
+	g = parse_commit_graph(&the_repository->settings, the_repository->hash_algo,
+			       (void *)data, size);
 	repo_clear(the_repository);
 	free_commit_graph(g);
 

-- 
2.50.1.723.g3e08bea96f.dirty

