Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B02241CB6
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295457; cv=none; b=ZS5Gz8kGWXDamdoBHzhLA7mq4dCKPA6jcB2ROrF3EeLpZBlRb2j9o3EXxr0RCrsx7uDOGqqDvWtbKMBfA5R9ZwETlOQ2o8LvCYuo31dvEYdXFA40oUDuqolTsZ2xeNwSXcxPZ3xGC6xFOHs5zituZhkAr1qKl06gsbfb1zNnb+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295457; c=relaxed/simple;
	bh=KUaeGPsYjY0/cisk1Xn4M0gpM+eo6ayunhPapKKeTLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PdjyaCqFg0R6AHmWBmdkVXIlWAYPQGBaUE6RlD/I322nA3wCUuWwyNRqVB0uVtiFAf4xzxUpa4qZaeqB94/qi2+btFt9t9SA4ZhVnk01z5pyI4cwdddLqKK0euyDwvv4L4wyktlbaT6wIVd1mP2GyJoSgVrJDRA+Y7D8ZJu0chw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UByTOx+6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MCl639n/; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UByTOx+6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MCl639n/"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 9BF841D0013C
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 04:17:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 04 Aug 2025 04:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754295454;
	 x=1754381854; bh=G1Q0yyPbeTcDXTUjrNjk93LG5sb9XdUxWzcv88FqY+0=; b=
	UByTOx+6DzfRJ8jMsy7i1wrnQkC+Bkf2CNEvyC8xeXY+YV8nSiLb851b99iI+j0L
	wqzYsVUL4CabRnrBFkEwX7btXjKkCBmHO//iT7enVOHhRfVuAWh5SAZ6w5xzxxVg
	ko2m9BAPGHYWubVPuQPSBx5FZhBhqoev5PUSX3TP2U2H8Cx0qhaBR/ptF5heQ/Vw
	St/R1tbWDa252kFeZHDlXCy+rMhhJg75SCCm9ULZL2N27uWbzcBOPFDGSDriVKAJ
	UqWCVYbtXidC8PctJANm+6E5K9cehBTOQFX37wq1ptq2+e2PUUoCSx42ABAJ8xTM
	DcppfyiocKAlnYX6zTLr2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754295454; x=
	1754381854; bh=G1Q0yyPbeTcDXTUjrNjk93LG5sb9XdUxWzcv88FqY+0=; b=M
	Cl639n/h3QvHqzP3a+pMpi1dmKlGsxyE0y9A1cHXwCqS2p+py5ARmEw3UxP+YIP8
	2vfavmJMVEPnv2yXyQFkAipIihIL3ohG284YGZ++NTIb/gx8wb/K/toK/umXfnRv
	kmwkglIuuZiAKIiJgjWUNgm+5+8hH1KRrxuft7lyEoQNznxk0Zou+Ajn0IsuJ9zx
	hByOK7sUQjuE2WQLP/yysGXwtRGtWHQ8IBPo+tXpPdX2C5JHVm6lFDeUlAKOt4nP
	eyl2LLyfrbmVFR8dqXMgLgoRTaHP13ALAOwcMOdgIBOcATqQmOKCuG7peDNUxLLc
	SnQXP9dA06/9hrJeSSFFA==
X-ME-Sender: <xms:nmyQaFOLKzhE7CNNWnnqLuOrLGyzf4C7U5icxnH16PNiUl7_UFZg4A>
    <xme:nmyQaJ9PXfCrJRNJcYeEzJo9VciQ7GlJmnJXHsMjO60FpJ5_-48nTLsPi4EvmeHks
    BXfMC9gD1cckkoLyA>
X-ME-Received: <xmr:nmyQaNpBTd52eNCjHtwAXfpQkj9p0zm3YbyyYYQOFR2blIVDutsJa0IqOPeL5hCvB2JTEteOde0WRFDVYVokkOVOg9cXIXmZZGFqtRI4gXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:nmyQaD7bK3K8YT2AFi-PIRH-G4r_ylbVnkUUy9saujGXK7FXHW9Kfw>
    <xmx:nmyQaFP6eKYevtkpgB8j7z2NxvBsDyDSoiDc4T1j4Yo_OZqs6_0C3Q>
    <xmx:nmyQaNMw7F_GtLkJroeGrWF2yjs8dT1NcjnuEE6QjTEmcDiyII7VdA>
    <xmx:nmyQaF_7heAbloVyg-2OIIBAjjPMrTpcS11Iq-d1NMtdiD8PPoEt9A>
    <xmx:nmyQaK1LHL9ESCye2fwihIo-xFUOJI3OTCicXotZE4UntIJh5KBXvk6h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Aug 2025 04:17:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74dd17e7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Aug 2025 08:17:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 10:17:20 +0200
Subject: [PATCH 4/9] commit-graph: fix sign comparison warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-b4-pks-commit-graph-wo-the-repository-v1-4-850d626eb2e8@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "commit-graph.c" file has a bunch of sign comparison warnings:

  - There are a bunch of variables that are declared as signed integers
    even though they are used to count entities, like for example
    `num_commit_graphs_before` and `num_commit_graphs_after`.

  - There are several cases where we use signed loop variables to
    iterate through an unsigned entity count.

  - In `write_graph_chunk_base_1()` we count how many chunks we have
    written in total. But while the value represents a positive
    quantity, we still return a signed integer that we then later
    compare with unsigned values.

  - The bloom settings hash version is being assigned `-1` even though
    it's an unsigned value. This is used to indicate an unspecified
    value and relies on 1's complement.

Fix all of these cases by either using the proper variable type or by
adding casts as required.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index ad3f084dd4..443177ffd3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
@@ -569,7 +568,7 @@ static void validate_mixed_bloom_settings(struct commit_graph *g)
 static int add_graph_to_chain(struct commit_graph *g,
 			      struct commit_graph *chain,
 			      struct object_id *oids,
-			      int n)
+			      size_t n)
 {
 	struct commit_graph *cur_g = chain;
 
@@ -622,7 +621,7 @@ int open_commit_graph_chain(const char *chain_file,
 		close(*fd);
 		return 0;
 	}
-	if (st->st_size < the_hash_algo->hexsz) {
+	if (st->st_size < (ssize_t) the_hash_algo->hexsz) {
 		close(*fd);
 		if (!st->st_size) {
 			/* treat empty files the same as missing */
@@ -643,15 +642,16 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	struct commit_graph *graph_chain = NULL;
 	struct strbuf line = STRBUF_INIT;
 	struct object_id *oids;
-	int i = 0, valid = 1, count;
+	int valid = 1;
 	FILE *fp = xfdopen(fd, "r");
+	size_t count;
 
 	count = st->st_size / (the_hash_algo->hexsz + 1);
 	CALLOC_ARRAY(oids, count);
 
 	odb_prepare_alternates(r->objects);
 
-	for (i = 0; i < count; i++) {
+	for (size_t i = 0; i < count; i++) {
 		struct odb_source *source;
 
 		if (strbuf_getline_lf(&line, fp) == EOF)
@@ -1145,12 +1145,12 @@ struct write_commit_graph_context {
 	int num_generation_data_overflows;
 	unsigned long approx_nr_objects;
 	struct progress *progress;
-	int progress_done;
+	uint64_t progress_done;
 	uint64_t progress_cnt;
 
 	char *base_graph_name;
-	int num_commit_graphs_before;
-	int num_commit_graphs_after;
+	size_t num_commit_graphs_before;
+	size_t num_commit_graphs_after;
 	char **commit_graph_filenames_before;
 	char **commit_graph_filenames_after;
 	char **commit_graph_hash_after;
@@ -1181,7 +1181,7 @@ static int write_graph_chunk_fanout(struct hashfile *f,
 				    void *data)
 {
 	struct write_commit_graph_context *ctx = data;
-	int i, count = 0;
+	size_t i, count = 0;
 	struct commit **list = ctx->commits.list;
 
 	/*
@@ -1209,7 +1209,8 @@ static int write_graph_chunk_oids(struct hashfile *f,
 {
 	struct write_commit_graph_context *ctx = data;
 	struct commit **list = ctx->commits.list;
-	int count;
+	size_t count;
+
 	for (count = 0; count < ctx->commits.nr; count++, list++) {
 		display_progress(ctx->progress, ++ctx->progress_cnt);
 		hashwrite(f, (*list)->object.oid.hash, the_hash_algo->rawsz);
@@ -1331,9 +1332,9 @@ static int write_graph_chunk_generation_data(struct hashfile *f,
 					     void *data)
 {
 	struct write_commit_graph_context *ctx = data;
-	int i, num_generation_data_overflows = 0;
+	int num_generation_data_overflows = 0;
 
-	for (i = 0; i < ctx->commits.nr; i++) {
+	for (size_t i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
 		timestamp_t offset;
 		repo_parse_commit(ctx->r, c);
@@ -1355,8 +1356,8 @@ static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
 						      void *data)
 {
 	struct write_commit_graph_context *ctx = data;
-	int i;
-	for (i = 0; i < ctx->commits.nr; i++) {
+
+	for (size_t i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
 		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
 		display_progress(ctx->progress, ++ctx->progress_cnt);
@@ -1526,7 +1527,7 @@ static void add_missing_parents(struct write_commit_graph_context *ctx, struct c
 
 static void close_reachable(struct write_commit_graph_context *ctx)
 {
-	int i;
+	size_t i;
 	struct commit *commit;
 	enum commit_graph_split_flags flags = ctx->opts ?
 		ctx->opts->split_flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
@@ -1620,10 +1621,9 @@ static void compute_reachable_generation_numbers(
 			struct compute_generation_info *info,
 			int generation_version)
 {
-	int i;
 	struct commit_list *list = NULL;
 
-	for (i = 0; i < info->commits->nr; i++) {
+	for (size_t i = 0; i < info->commits->nr; i++) {
 		struct commit *c = info->commits->list[i];
 		timestamp_t gen;
 		repo_parse_commit(info->r, c);
@@ -1714,7 +1714,7 @@ static void set_generation_v2(struct commit *c, timestamp_t t,
 
 static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 {
-	int i;
+	size_t i;
 	struct compute_generation_info info = {
 		.r = ctx->r,
 		.commits = &ctx->commits,
@@ -1793,10 +1793,10 @@ static void trace2_bloom_filter_write_statistics(struct write_commit_graph_conte
 
 static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 {
-	int i;
+	size_t i;
 	struct progress *progress = NULL;
 	struct commit **sorted_commits;
-	int max_new_filters;
+	size_t max_new_filters;
 
 	init_bloom_filters();
 
@@ -1814,7 +1814,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 		QSORT(sorted_commits, ctx->commits.nr, commit_gen_cmp);
 
 	max_new_filters = ctx->opts && ctx->opts->max_new_filters >= 0 ?
-		ctx->opts->max_new_filters : ctx->commits.nr;
+		(size_t) ctx->opts->max_new_filters : ctx->commits.nr;
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		enum bloom_filter_computed computed = 0;
@@ -2017,10 +2017,10 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
-static int write_graph_chunk_base_1(struct hashfile *f,
-				    struct commit_graph *g)
+static size_t write_graph_chunk_base_1(struct hashfile *f,
+				       struct commit_graph *g)
 {
-	int num = 0;
+	size_t num = 0;
 
 	if (!g)
 		return 0;
@@ -2034,7 +2034,7 @@ static int write_graph_chunk_base(struct hashfile *f,
 				    void *data)
 {
 	struct write_commit_graph_context *ctx = data;
-	int num = write_graph_chunk_base_1(f, ctx->new_base_graph);
+	size_t num = write_graph_chunk_base_1(f, ctx->new_base_graph);
 
 	if (num != ctx->num_commit_graphs_after - 1) {
 		error(_("failed to write correct number of base graph ids"));
@@ -2480,7 +2480,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 		if (stat(path.buf, &st) < 0)
 			continue;
 
-		if (st.st_mtime > expire_time)
+		if ((unsigned) st.st_mtime > expire_time)
 			continue;
 		if (path.len < 6 || strcmp(path.buf + path.len - 6, ".graph"))
 			continue;
@@ -2576,7 +2576,7 @@ int write_commit_graph(struct odb_source *source,
 			ctx.changed_paths = 1;
 
 			/* don't propagate the hash_version unless unspecified */
-			if (bloom_settings.hash_version == -1)
+			if (bloom_settings.hash_version == (unsigned) -1)
 				bloom_settings.hash_version = g->bloom_filter_settings->hash_version;
 			bloom_settings.bits_per_entry = g->bloom_filter_settings->bits_per_entry;
 			bloom_settings.num_hashes = g->bloom_filter_settings->num_hashes;

-- 
2.50.1.723.g3e08bea96f.dirty

