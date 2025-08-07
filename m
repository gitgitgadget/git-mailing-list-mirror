Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C58E253F07
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553905; cv=none; b=Fwyp5AKdyFNe7apa5blpxXzdrl5R+q6beLOFjH2G8jlGOlQE984DOEJJqPkfQFWUmecja4f46hgB3fi4n3isAO/SrD3ElLAdULInNhmAXgt+lWNedTtbyLzbYi6PF/ckLAXozRV7yIJ/lEjWd1s+aULs6pp4npFApPUL8iWsk7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553905; c=relaxed/simple;
	bh=F255LI3twtDZ1khioYj6AWXiRv0ScAlzNdeyhhoIorc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fKg0+ReJMGwRaR5OUl0SW+0JI6ohZqaJq9XQL6dzmVa+j8r/I+FOLJlIVi2yUbDZc2mvxoF1/ha1OxZfUhgey46dTIfNKKpb7FZBfPsoTjcgI6mA57eH93vjIHtCSYyw0SVXzn9iR0TF9Q/5CmnRnUyvcn7G6daoE3XXKefVHeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GJt4P010; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TVNerzFx; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GJt4P010";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TVNerzFx"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C03CEC0015;
	Thu,  7 Aug 2025 04:05:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 07 Aug 2025 04:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754553902;
	 x=1754640302; bh=95gnkqZtZn+MvvyH348vGk5nqbo/FhlxBJ0XFQrvUMw=; b=
	GJt4P010/tJe/mMojcTJGv/DDwpq5C5swEaRN4fhuOul01tz5SB6xfMLNHhp0QBM
	/cq3iDPWpmrJNdSF1x7h9aF5NDzPWQhIXB8Xm6sK9Nhp444KJQ531bJiRp5zDm9G
	Pr+bu/aXDjHSBxPk4f15K+0Yfpv3jZWWrOuNVYhb6fvNkDM0qLhevcG7K6xhQKN1
	IAPNnUKD0xbnxISW3Xt+IxpTCplZhh4vrQmg1Cl95R8Mc8FQyLWG/K+pd0wmOqqK
	BXgHCnsiLE/wdgoIW6NIcKqFNcPVE1t8UWjenppk9RQFNR/6MAt0nve7m4s/jRVj
	tDjCBIPQjED6IFnlDm3qiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754553902; x=
	1754640302; bh=95gnkqZtZn+MvvyH348vGk5nqbo/FhlxBJ0XFQrvUMw=; b=T
	VNerzFx42EiauF8rziuPttuKiuVYUOc2RLQ1kdQwBiv6Tp8OGaZrPp5n6ZiiIIm9
	n40Y1th/tYyXM7ni2siz5GhzsijU1pzOdaDAcrxpqhj6UmwDN9SQQXaNKiYgkkTR
	NzsVI2l7NGcgXF7YqiZGWfwdP4NQk5gjHKeM37sMjOiOFH+BPR+m3vi9nHHHJSj0
	pQ5YSRjiyWp0NPP4lSZ48qU44u8MJjYl6VDkphXLmjor/qwzqzp3htzcqSfIXRqf
	3DfsNdOXmwbfbGqMz5EzJW4Mq7F7CecX7LycS7jjtEcBNKp2MNyC/4gCNMCPsOwx
	9xfV99HL8bBVUwVx9RkBA==
X-ME-Sender: <xms:Ll6UaPRtyZUURoxGXXLHTU392zUeEvx-gR_n4MXGRLjg_jXQRldWyA>
    <xme:Ll6UaMSbj1cUgaijgP1IqN9pEH59xDl8-2jB1Gbvnd9UgtrPVjCExZFzV8nT70EBJ
    B6gYRq8cVikxcQOHw>
X-ME-Received: <xmr:Ll6UaLSUaGSFVlgHrvvAskwUx9sIC7LGbDx0qS6yRtOfSVIFBA08esxq0Vl__pXGa5qE2tCuUKGI2muqqQLraA7HwcVGrvlSRtkRty5alA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepohhsfi
    grlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvg
X-ME-Proxy: <xmx:Ll6UaJ7FJhkDkfvf6cpYhNrUzTonG6TZa3Q8SRMin4_l-ZwkJfHlvA>
    <xmx:Ll6UaP1xssB0thEdZZMZELeT5UQx0rbrjlN9qjCV15Dw1WIQo5ffIw>
    <xmx:Ll6UaMAe2S_8lBywL7tpEzo5QX4dVD3UcXeL3UPkmNwk41ricnEMmA>
    <xmx:Ll6UaCPZg0F0t6htQrzYDzXwRVmIa-8HViVmUcj1YmjEGG2U6owYLA>
    <xmx:Ll6UaMvXJ9qlHn3okrJAaGYpNTDjUQzT08T1oGmwatgKkoBg_PO6terF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:05:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d2736d6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:05:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:04:46 +0200
Subject: [PATCH v3 04/10] commit-graph: fix sign comparison warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-commit-graph-wo-the-repository-v3-4-82edef830a1e@pks.im>
References: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
In-Reply-To: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
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

  - The Bloom settings hash version is being assigned `-1` even though
    it's an unsigned value. This is used to indicate an unspecified
    value and relies on 1's complement.

Fix all of these cases by either using the proper variable type or by
adding casts as required.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 53bf83f7b5..7c0ded4532 100644
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
+	uint32_t num_commit_graphs_before;
+	uint32_t num_commit_graphs_after;
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
2.51.0.rc0.215.g125493bb4a.dirty

