Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8A028B51F
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754481647; cv=none; b=ENJ/OEQdRbuNOU1mNm8N3Ok3HV8h2xxKtI+NJUp/WPcplcyJH/rgiKbPRaa8QXTyKsc60R7IflIpueo9YFQfcJ0tJB9e83ua+PoyTknTjjgLCWiT4sYmgmrE22IJkPsqYUdJkmM03/H4ktFEVH1Br/JMlCw2haOTsrniNuSrmJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754481647; c=relaxed/simple;
	bh=XB958yAJBbt/PGPnr8K2KYR3qsY+sNYEXWf0nmtS4YM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MA/hxyQOh3e4Zl/IjrDc+fm6cr1LcHkNHv3PsArJ4v828VQ+b+kLBmHbFgs2xpwtDv+lfYWAWARCM8zymbFNtGVkow4xN77wNOugnA1OKo607SQVSTSEJHd1vOERCsBmFLX6w1oysG25oUOxrdpcPGwQ3taXsNnR62mjxFpP4wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eFNNmbaE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WimLndUS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eFNNmbaE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WimLndUS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 79091EC01C9;
	Wed,  6 Aug 2025 08:00:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 06 Aug 2025 08:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754481645;
	 x=1754568045; bh=qfq/QxDRc5N1T851KDkFH2eSUoFBScKz6FbusQeUumE=; b=
	eFNNmbaE8YdvAfJGde0ctn7FGq9MkUZGFfBpTI4rF8FyoMr7/P/GMJEFqqOYvd2L
	W7LQGVdH4FxscxbH0fvGJROUR+bwu9J/yybshUbXGYRruFWrrxNtXOjjjd19sY3Q
	aXaj5BWTxJlnB+qBjxMW3zPYX65s/6TWZKvwXgr8YdbQQthdyjp6o8DY7v3pLtuZ
	lHY0gbQMqmK45/1aINMm5M/SVXDVkmlL6SVmFL88Gm0VIbsLNuV6btg/PG6qJGjC
	HBbVk9LQ5S0nBV2/XYfCP83PfQOwyzlT2nYhf9OoSvxbiqS/cd2MLZm8Sn39VEu0
	XvDiqHfqbxwmWy5lByWgKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754481645; x=
	1754568045; bh=qfq/QxDRc5N1T851KDkFH2eSUoFBScKz6FbusQeUumE=; b=W
	imLndUS2R/7RemUYJ68/CO9dd9CIDh8N2pdAc379CI0aA89RJBrr7oRLAo0cKc8N
	4NDy5WmD/b0MCWAxm8wOWTJHs6wew2xSa5mDXukJIfqDcxx+IDE+D8IQcVpk25L3
	BrGM3OoCEJB4nRJO/O/lyqnD5ck3yh7EDghINKOBXEmwFemxxMFAXtE6b7lcvVK+
	KJhTpv5r5zqQC8Y/fF7L7v6JFJVb5PquIA5QGBayPrL+2O3qGl0LOVziZ1Ui19fD
	AM3BaLzfQDHgzzAYQt3rBP5VwmC0+HkwPMnNjh7u+XVHdhduRw/cTGDuxUAhOY6S
	B4ymkwYppTHdT5kGDK7wQ==
X-ME-Sender: <xms:7UOTaBVJHGLAwNjhsMukOelozGDsqaRHJoknOqI-O-10A71-7FCr1g>
    <xme:7UOTaNGOImjF26SXu746RM3nY1bh9w9OdX5hjugXp9S7LPlq6XigfZ7ik4qH5LZ5F
    p5fbbivu62z1QvZBA>
X-ME-Received: <xmr:7UOTaD2_U8_ewj3i4dH1HDh3E92qRHMnDJh8Qz3EFv6Z4FCGMfMLrluZNGl2VdD1kc1Nqk4PKrBMm0lnKqTWnosWJYSKYzgXIWeYTDer2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7UOTaPP3yuuvWAzr5_5UYkIEC9nrCfL-n2yQsjDDIvarhZ5rwMbsYA>
    <xmx:7UOTaC4-MBJWCYjjETfOhvZ74v7TR4K7v4_sFa9X2oeLnEZ36RYSrw>
    <xmx:7UOTaJ0VCaNIiPI8i_Fu6_ic493RYYWHYuiHut-AyuCbVXwncRPQfA>
    <xmx:7UOTaDyDdp69wFS19DCxFwbHaryAe97ASjlyO4c5mwR8tZ_bPiSiiw>
    <xmx:7UOTaMAZVlxAlhURw4kIQ2F9yLCvxbpWxDN53oqLdkjvGNjy8-4GFdLR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 08:00:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 77fe746e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 12:00:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 14:00:13 +0200
Subject: [PATCH v2 08/10] commit-graph: stop using `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-b4-pks-commit-graph-wo-the-repository-v2-8-911bae638e61@pks.im>
References: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
In-Reply-To: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
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
index 50391cc0f3..d351ea5806 100644
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
index 5a5c876af0..6de624785c 100644
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

