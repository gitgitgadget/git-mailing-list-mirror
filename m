Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B6218EB1
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755237001; cv=none; b=FrDP0TYGqZxRi1XFbi3CCK7zutPyseztCN508o3AjZ6fifL+pnWQRd92ACHAPD64TmGw2kYi5mUvvQQjyI8YZ9lp92nQdhLNSvaW4ypHfpT0DO1V63Hu50hREkBZ4CI7FcMtnW4vSLnrqu1G/omgMj5gP7rlbsF5aT30bZ6p2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755237001; c=relaxed/simple;
	bh=UAkSE206XrKT2Hr1CSJB7u2eQy76jdGdmnXocl8PS6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8tUmJYvixVKtMWmdMipmD7ciRboDtcrMhsyRBlLEN3DBTkXoWOt+hHzKHGDWzaFAcUPJj9gmmXu7txv4Q4sGf2DbLU1lNns6C+WgxcFIkTe+a+G8qO18EcUcMHKvFC+fu8ArXietltDKckfp19JXaH+OZtkL7f28n77GCiRY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kvj1SUFU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f+SzE5EF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kvj1SUFU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f+SzE5EF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B551E1400048;
	Fri, 15 Aug 2025 01:49:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 15 Aug 2025 01:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755236998;
	 x=1755323398; bh=WaVTJD26MNCzRI5j8GTwVMKNYhM1SfiX/swICcdqKY0=; b=
	kvj1SUFUlkaCLn6bGTirwATkaIpXY6aauR85u3ftJT6pWF9VXdq4hVF0BODuNWCM
	3xw3sPOIrAj3Ruvb/mvbOBWa3eOXm4qIee3rypqDAP0ho17J7pQiCpxiWM7LPQ9m
	N56JMLvH6mj2xotrwalgvLDM3IeqBFNGsJMR1aa2PdRgdwzSQUaY+RVQZcYyGY+q
	PjTT9M2aq3/fcvj8eYXNfMppxAqnq586iuw+gv8ikzbsOP74do+9851aUEN/UknO
	oRykfvXwqNh+OpIaM6YjgR9r7XcBcAxQ2PF/Hkx3DF8i66Z7W/gcH6RfynhwWD/Q
	RJpIQxI2D8eT/J1jbO8/fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755236998; x=
	1755323398; bh=WaVTJD26MNCzRI5j8GTwVMKNYhM1SfiX/swICcdqKY0=; b=f
	+SzE5EFJAmqtR76MfmOpQZUn78Ql5O4UCcpatSNoL8Unl0pMMhraYRaw5YFfXWrs
	6Y42aTJfPYZFGKecNp26rm6YnvxepgWuuNt3f06bUuX7ya2eN8DmvUi4I1OhOJbf
	e05kwWlhbBKD5tA1k/7sTuruhEvkFUu3leJTa/8Q/dziNpQcoQ44iPTMkIbidPR3
	hJaZZhCTus9EqJgVy/z7viBlbSoTkQ45NS6FM2r5GDHITBn382kGQ+vHYlS5NeaE
	xsjPgTffBjr4Je5r7xEpGRbGmSjZBnQGbsej2VzYYHsEU0gvC/3lC295Vx+guNyY
	KrOXn41+wodwE7afv5UOw==
X-ME-Sender: <xms:hsqeaJxGTDdYtkxC0kZ2oJuC7fRcp1odd3amMGqCiv0jKzULC8kQiA>
    <xme:hsqeaEzLzBUtIJJOzXs18R5OMQSKb9Wyi3sEH5tvvhI_EFHJJxnvPaZJ6aij9V43a
    Wwk8rnuLll5p8UBZA>
X-ME-Received: <xmr:hsqeaJwBih4dkCJWPL1SgX-QS-rK-BAyV5Jj0HQozQgw1AVKz3l9q4so_mLSXJBT3Tdri6IjAtGTRRHajANHkopizxu5MQ0avV9XVuLiwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsfi
    grlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvg
X-ME-Proxy: <xmx:hsqeaGaUGvdMPH5osmDvhGBpgB3FssxCgLDSPFxtcYONW4uXLG3hdw>
    <xmx:hsqeaCUtqV2hSEYtnBcqWgdciqeULTrZ0-KYKaQlJOJle1Bq7rSxQw>
    <xmx:hsqeaMi-7On_jp71-lKEkKPWZeQrwMeWkHf8f_BGDUPmcqr-iPDELQ>
    <xmx:hsqeaIssBpXrh4Z8pIezQnc871IHLYfB6wme5Mq11ZlyYeyBD3MasA>
    <xmx:hsqeaFQ9xnPIR3CuV9rnws6ZoqnDY7QkVc7f3yy5XESfw7dGQ9YKOnol>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 01:49:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0dd0995b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 15 Aug 2025 05:49:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Aug 2025 07:49:48 +0200
Subject: [PATCH v4 2/6] commit-graph: store the hash algorithm instead of
 its length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-b4-pks-commit-graph-wo-the-repository-v4-2-b6b651178cce@pks.im>
References: <20250815-b4-pks-commit-graph-wo-the-repository-v4-0-b6b651178cce@pks.im>
In-Reply-To: <20250815-b4-pks-commit-graph-wo-the-repository-v4-0-b6b651178cce@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The commit-graph stores the length of the hash algorithm it uses. In
subsequent commits we'll need to pass the whole hash algorithm around
though, which we currently don't have access to.

Refactor the code so that we store the hash algorithm instead of only
its size.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 36 ++++++++++++++++++------------------
 commit-graph.h |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index ecd50ea3ff..5053d12534 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -311,7 +311,7 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 {
 	struct commit_graph *g = data;
 	g->chunk_oid_lookup = chunk_start;
-	if (chunk_size / g->hash_len != g->num_commits)
+	if (chunk_size / g->hash_algo->rawsz != g->num_commits)
 		return error(_("commit-graph OID lookup chunk is the wrong size"));
 	return 0;
 }
@@ -413,7 +413,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 
 	graph = alloc_commit_graph();
 
-	graph->hash_len = the_hash_algo->rawsz;
+	graph->hash_algo = the_hash_algo;
 	graph->num_chunks = *(unsigned char*)(data + 6);
 	graph->data = graph_map;
 	graph->data_len = graph_size;
@@ -478,7 +478,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 		FREE_AND_NULL(graph->bloom_filter_settings);
 	}
 
-	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_len,
+	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_algo->rawsz,
 		the_repository->hash_algo);
 
 	free_chunkfile(cf);
@@ -584,7 +584,7 @@ static int add_graph_to_chain(struct commit_graph *g,
 		return 0;
 	}
 
-	if (g->chunk_base_graphs_size / g->hash_len < n) {
+	if (g->chunk_base_graphs_size / g->hash_algo->rawsz < n) {
 		warning(_("commit-graph base graphs chunk is too small"));
 		return 0;
 	}
@@ -594,7 +594,7 @@ static int add_graph_to_chain(struct commit_graph *g,
 
 		if (!cur_g ||
 		    !oideq(&oids[n], &cur_g->oid) ||
-		    !hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_len, n),
+		    !hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_algo->rawsz, n),
 			    the_repository->hash_algo)) {
 			warning(_("commit-graph chain does not match"));
 			return 0;
@@ -805,7 +805,7 @@ int generation_numbers_enabled(struct repository *r)
 		return 0;
 
 	first_generation = get_be32(g->chunk_commit_data +
-				    g->hash_len + 8) >> 2;
+				    g->hash_algo->rawsz + 8) >> 2;
 
 	return !!first_generation;
 }
@@ -849,7 +849,7 @@ void close_commit_graph(struct object_database *o)
 static int bsearch_graph(struct commit_graph *g, const struct object_id *oid, uint32_t *pos)
 {
 	return bsearch_hash(oid->hash, g->chunk_oid_fanout,
-			    g->chunk_oid_lookup, g->hash_len, pos);
+			    g->chunk_oid_lookup, g->hash_algo->rawsz, pos);
 }
 
 static void load_oid_from_graph(struct commit_graph *g,
@@ -869,7 +869,7 @@ static void load_oid_from_graph(struct commit_graph *g,
 
 	lex_index = pos - g->num_commits_in_base;
 
-	oidread(oid, g->chunk_oid_lookup + st_mult(g->hash_len, lex_index),
+	oidread(oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, lex_index),
 		the_repository->hash_algo);
 }
 
@@ -911,8 +911,8 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	graph_data = commit_graph_data_at(item);
 	graph_data->graph_pos = pos;
 
-	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
-	date_low = get_be32(commit_data + g->hash_len + 12);
+	date_high = get_be32(commit_data + g->hash_algo->rawsz + 8) & 0x3;
+	date_low = get_be32(commit_data + g->hash_algo->rawsz + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
 	if (g->read_generation_data) {
@@ -930,10 +930,10 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 		} else
 			graph_data->generation = item->date + offset;
 	} else
-		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+		graph_data->generation = get_be32(commit_data + g->hash_algo->rawsz + 8) >> 2;
 
 	if (g->topo_levels)
-		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
+		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_algo->rawsz + 8) >> 2;
 }
 
 static inline void set_commit_tree(struct commit *c, struct tree *t)
@@ -957,7 +957,7 @@ static int fill_commit_in_graph(struct repository *r,
 	fill_commit_graph_info(item, g, pos);
 
 	lex_index = pos - g->num_commits_in_base;
-	commit_data = g->chunk_commit_data + st_mult(g->hash_len + 16, lex_index);
+	commit_data = g->chunk_commit_data + st_mult(g->hash_algo->rawsz + 16, lex_index);
 
 	item->object.parsed = 1;
 
@@ -965,12 +965,12 @@ static int fill_commit_in_graph(struct repository *r,
 
 	pptr = &item->parents;
 
-	edge_value = get_be32(commit_data + g->hash_len);
+	edge_value = get_be32(commit_data + g->hash_algo->rawsz);
 	if (edge_value == GRAPH_PARENT_NONE)
 		return 1;
 	pptr = insert_parent_or_die(r, g, edge_value, pptr);
 
-	edge_value = get_be32(commit_data + g->hash_len + 4);
+	edge_value = get_be32(commit_data + g->hash_algo->rawsz + 4);
 	if (edge_value == GRAPH_PARENT_NONE)
 		return 1;
 	if (!(edge_value & GRAPH_EXTRA_EDGES_NEEDED)) {
@@ -2623,7 +2623,7 @@ int write_commit_graph(struct odb_source *source,
 		struct commit_graph *g = ctx.r->objects->commit_graph;
 		for (i = 0; i < g->num_commits; i++) {
 			struct object_id oid;
-			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
+			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
 				the_repository->hash_algo);
 			oid_array_append(&ctx.oids, &oid);
 		}
@@ -2754,7 +2754,7 @@ static int verify_one_commit_graph(struct repository *r,
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit;
 
-		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
+		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
 			the_repository->hash_algo);
 
 		if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
@@ -2799,7 +2799,7 @@ static int verify_one_commit_graph(struct repository *r,
 		timestamp_t generation;
 
 		display_progress(progress, ++(*seen));
-		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
+		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
 			the_repository->hash_algo);
 
 		graph_commit = lookup_commit(r, &cur_oid);
diff --git a/commit-graph.h b/commit-graph.h
index 78ab7b875b..7dc1f2b22b 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -84,7 +84,7 @@ struct commit_graph {
 	const unsigned char *data;
 	size_t data_len;
 
-	unsigned char hash_len;
+	const struct git_hash_algo *hash_algo;
 	unsigned char num_chunks;
 	uint32_t num_commits;
 	struct object_id oid;

-- 
2.51.0.rc1.215.g0f929dcec7.dirty

