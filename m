Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D388256C61
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553918; cv=none; b=hwqU966fpt+QkNUABF6ig+STzIIYygSSVHZT9mVxk/yuSc4ety4G2B3ax6W/GNWq/Ili1vwcgiuUbQ7Fd1CAV+H36jT8aR4EJ29/JW99J7ZwpJliQ2K1q90WcmxlqQvrwceejCcx/soCsogJgEL9nY49EsIOzyg5u6Dhp5T4QYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553918; c=relaxed/simple;
	bh=UEn5JR99BfKUSV926qM6wYfU/qn/vudf0Pxp3rjtUmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L73Hyp+gFzTLW6aze4ZlQIh1kP6qU9lwtNvViww5p3xiLXmL19I2CJp8Xa2WaN5ERBXT1grCkhzvIdXaye/3iN2ma+TiEszZ0DdyQ7pFM4TtMqcpsKHrdfwkgbtW74h5GkmFSsaG1rdYbogwK4I6rTSag9YnICCsG/Q+VB4JEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YAi5KyOL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NKVMqU7h; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YAi5KyOL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NKVMqU7h"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 99D0BEC00AB;
	Thu,  7 Aug 2025 04:05:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 07 Aug 2025 04:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754553915;
	 x=1754640315; bh=+SWKJHrJK5+Ra+kWTozCvxR74PIXkG47uouL6XIjEyY=; b=
	YAi5KyOLXStlPG0iljed6rghn3WB2SyJqPiqfD4mU8R9IWp/Z5EeHLuWoYuXyKn1
	SkxkQlKpzJWLLPavnD0wjKsIVc14PyFFBf3RMEhW9mXyTZFckyN4zJ5SnYL/f6GN
	5zftPurmAWJ09eKZnGn46xUYTtifz8hw51mHSdPZWdM/Dc4tjWRUknQplipcCDoz
	YG7fpnJce4Cze2uGX4vXzSNK7xIAfbH2reeTs2Mt73ApN46J8gyGcgUBkLKhYnnC
	s21o1wXIpIMK7NVwK4gU33FQnDj5aNugFt4Owc8dpKKf2Cw7vJQu8x1n8lRoWJVd
	JDxj8fp/s28bQFX/dmMzmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754553915; x=
	1754640315; bh=+SWKJHrJK5+Ra+kWTozCvxR74PIXkG47uouL6XIjEyY=; b=N
	KVMqU7h7+Hwj1MlmrCh5CR/lnIM+RZrV8xsVN/SYPq3pHCyh24nQu+lIvrcm6XHx
	xixkLwAzMzt2B4hcG3s5CiCygv1/uT7nm2Mf28RB25iks5v+bHYZIrHg75h2/nxF
	4FVhohrH2fDhRMIwEfDClG4ENNxyxAH/9SL32LDOwe7SizoY5hJ5mhgcc0A2L5Nb
	Z2EXEZzCoFpoISU5AvN+WomXHSmC0aTfN2PSFj0ugR0elKpNCGDXX7rpDgYlq7yE
	65dwdaM3b/QZt7KBEGSLT/m8kkQX/gNYQ+WZY6aXNzFzZ0ZyqsudmttBk7OQ3NK9
	AULn31J073P80VuOkgyLQ==
X-ME-Sender: <xms:O16UaKNruy4mLokPdr4xCyDbbBrpuVot1xnnF8AWnmR1pRIXsuXh1A>
    <xme:O16UaKdwZmKWBKhZuexhK2YkonF7xp0318qeDtNNbq-UGAKH89F_DcU476E3TS6Zw
    jXpcxqjCul2yEIo0w>
X-ME-Received: <xmr:O16UaBW-3c_UAlnX96pxJbAz-P4QGePqLejOwDasIHThFvsNqYoijnuvx7C0JVML8Nn66K5Sb4t9q0Z5iQHVXOmPXYoYU4O1xr6gDaP6YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprh
    gtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:O16UaKgmiS9lxNWIx_WtdA7FShYx_iKyyoyPUcqzM9de5pJRPaWGbw>
    <xmx:O16UaI-tOR8JiH42zZYuZj1FNrtD4o07mAbm8zd2UswUQjqG358x3g>
    <xmx:O16UaEahwhZBl1RiHrDsoEcc4A62juYAYRX7kK3ge6JUPaKDd6l1ew>
    <xmx:O16UaH3pDjccbiQvaBVVVGqathQLTsZbzehB6NP5mSmulF-w2sYYPQ>
    <xmx:O16UaDf6uZ7bQyl9D786BNLTOI44zwwLfFBZQnpXxnJ0JMmntEa0HWdz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:05:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb7922e9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:05:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:04:50 +0200
Subject: [PATCH v3 08/10] commit-graph: stop using `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-commit-graph-wo-the-repository-v3-8-82edef830a1e@pks.im>
References: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
In-Reply-To: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Stop using `the_hash_algo` as it implicitly relies on `the_repository`.
Instead, we either use the hash algo provided via the context or, if
there is no such hash algo, we use `the_repository` explicitly. Such
uses will be removed in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c |  3 ++-
 commit-graph.c         | 27 ++++++++++++++-------------
 commit-graph.h         |  3 ++-
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 145802afb7..680b03a83a 100644
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
index 77b785a5e0..594eca4110 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -263,7 +263,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 
 	graph_size = xsize_t(st->st_size);
 
-	if (graph_size < graph_min_size(the_hash_algo)) {
+	if (graph_size < graph_min_size(r->hash_algo)) {
 		close(fd);
 		error(_("commit-graph file is too small"));
 		return NULL;
@@ -318,7 +318,7 @@ static int graph_read_commit_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
 	struct commit_graph *g = data;
-	if (chunk_size / graph_data_width(the_hash_algo) != g->num_commits)
+	if (chunk_size / graph_data_width(g->hash_algo) != g->num_commits)
 		return error(_("commit-graph commit data chunk is wrong size"));
 	g->chunk_commit_data = chunk_start;
 	return 0;
@@ -619,7 +619,8 @@ static int add_graph_to_chain(struct commit_graph *g,
 }
 
 int open_commit_graph_chain(const char *chain_file,
-			    int *fd, struct stat *st)
+			    int *fd, struct stat *st,
+			    const struct git_hash_algo *hash_algo)
 {
 	*fd = git_open(chain_file);
 	if (*fd < 0)
@@ -628,7 +629,7 @@ int open_commit_graph_chain(const char *chain_file,
 		close(*fd);
 		return 0;
 	}
-	if (st->st_size < (ssize_t) the_hash_algo->hexsz) {
+	if (st->st_size < (ssize_t) hash_algo->hexsz) {
 		close(*fd);
 		if (!st->st_size) {
 			/* treat empty files the same as missing */
@@ -653,7 +654,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	FILE *fp = xfdopen(fd, "r");
 	size_t count;
 
-	count = st->st_size / (the_hash_algo->hexsz + 1);
+	count = st->st_size / (r->hash_algo->hexsz + 1);
 	CALLOC_ARRAY(oids, count);
 
 	odb_prepare_alternates(r->objects);
@@ -715,7 +716,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	int fd;
 	struct commit_graph *g = NULL;
 
-	if (open_commit_graph_chain(chain_file, &fd, &st)) {
+	if (open_commit_graph_chain(chain_file, &fd, &st, r->hash_algo)) {
 		int incomplete;
 		/* ownership of fd is taken over by load function */
 		g = load_commit_graph_chain_fd_st(r, fd, &st, &incomplete);
@@ -907,7 +908,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 		die(_("invalid commit position. commit-graph is likely corrupt"));
 
 	lex_index = pos - g->num_commits_in_base;
-	commit_data = g->chunk_commit_data + st_mult(graph_data_width(the_hash_algo), lex_index);
+	commit_data = g->chunk_commit_data + st_mult(graph_data_width(g->hash_algo), lex_index);
 
 	graph_data = commit_graph_data_at(item);
 	graph_data->graph_pos = pos;
@@ -1111,7 +1112,7 @@ static struct tree *load_tree_for_commit(struct repository *r,
 		g = g->base_graph;
 
 	commit_data = g->chunk_commit_data +
-			st_mult(graph_data_width(the_hash_algo),
+			st_mult(graph_data_width(g->hash_algo),
 				graph_pos - g->num_commits_in_base);
 
 	oidread(&oid, commit_data, the_repository->hash_algo);
@@ -1221,7 +1222,7 @@ static int write_graph_chunk_oids(struct hashfile *f,
 
 	for (count = 0; count < ctx->commits.nr; count++, list++) {
 		display_progress(ctx->progress, ++ctx->progress_cnt);
-		hashwrite(f, (*list)->object.oid.hash, the_hash_algo->rawsz);
+		hashwrite(f, (*list)->object.oid.hash, f->algop->rawsz);
 	}
 
 	return 0;
@@ -1252,7 +1253,7 @@ static int write_graph_chunk_data(struct hashfile *f,
 			die(_("unable to parse commit %s"),
 				oid_to_hex(&(*list)->object.oid));
 		tree = get_commit_tree_oid(*list);
-		hashwrite(f, tree->hash, the_hash_algo->rawsz);
+		hashwrite(f, tree->hash, ctx->r->hash_algo->rawsz);
 
 		parent = (*list)->parents;
 
@@ -2034,7 +2035,7 @@ static size_t write_graph_chunk_base_1(struct hashfile *f,
 		return 0;
 
 	num = write_graph_chunk_base_1(f, g->base_graph);
-	hashwrite(f, g->oid.hash, the_hash_algo->rawsz);
+	hashwrite(f, g->oid.hash, g->hash_algo->rawsz);
 	return num + 1;
 }
 
@@ -2058,7 +2059,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct hashfile *f;
 	struct tempfile *graph_layer; /* when ctx->split is non-zero */
 	struct lock_file lk = LOCK_INIT;
-	const unsigned hashsz = the_hash_algo->rawsz;
+	const unsigned hashsz = ctx->r->hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	struct chunkfile *cf;
 	unsigned char file_hash[GIT_MAX_RAWSZ];
@@ -2146,7 +2147,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
 	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, oid_version(the_hash_algo));
+	hashwrite_u8(f, oid_version(ctx->r->hash_algo));
 	hashwrite_u8(f, get_num_chunks(cf));
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
 
diff --git a/commit-graph.h b/commit-graph.h
index 4879643db0..5f417f7666 100644
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

-- 
2.51.0.rc0.215.g125493bb4a.dirty

