Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D0241696
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295462; cv=none; b=D//mbPzyhSJ6/gEFzrhdxtnCx2Kd1kUQKC+Tr31emGoP71Q0FFmeqjMbRwoxlUcltkft9JIRw+XMfGV3Brj0Avm7nxxBfyayZBdU06CuGZ3UJ+BPiYqpNzzEKQDxRcYQQVx+dHRslMT7B1arB+Ac7ewA/KPlpFqbjefw2H9Ta0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295462; c=relaxed/simple;
	bh=Zn6ob+ZLxNvDKQFKzK02K0mWWUEHqKx5uY0fra1b+Zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZvtRjM2g125PfKA8Hg5Tq6PrteL4hD12ffnpUYua4iFl+Mw7dPgFl0mlvuVBtgvKVUvL6I+ChRRjq69L2rklIlgHo3RLBcr1UdjOTG38D3qphqu0bZJodRXN9RXqZboF7Fe+wZSvwDvGpRgWxtvBLjxV3GRRdfq0s0ZnRtEzyak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PPEMdIPc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B35LJa8A; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PPEMdIPc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B35LJa8A"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 803237A00C1
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 04:17:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 04 Aug 2025 04:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754295460;
	 x=1754381860; bh=LIRuewgd/VyW/IbXdVkLMciOtZ4utn9ilxLOQdpzkW8=; b=
	PPEMdIPcOuiZi7WjysHA3ekLPe5Bn93ThZb0ATgbZptvYTE1jf2aM19h7VCwGVeQ
	D71yfv5TkYg7CRQy3IKYlnKADRp8e0upDySJfMGkh4JvK9F1keZTlqb+yOiHlvFI
	CmDA5COVDUW+1LCXKnG5NyOZr+zpDrB3c6bX8DvQrjLqYZv+JcLT3RuhzYGpXs1E
	6VSbtfNGRhhl6dYhU0AlV/wVVeko3yIKLQaiSUHFB8t+Z7N4IToTpUhFKf8gWDb9
	gGzQBeZDQCVg03oDAs+s6d02C+kIx37ec+uUxt9y0QSsbSOn7FGlhPPE17V50fq3
	bZcnctbCmscY+CfqN4ExwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754295460; x=
	1754381860; bh=LIRuewgd/VyW/IbXdVkLMciOtZ4utn9ilxLOQdpzkW8=; b=B
	35LJa8AkHc1eiUSgGv+Zqjir5jCgKdtImxiC6LNdWiyWlRxMVjzW8RpQlWeDwMji
	M7PouEIwhI36sRBrko2XESWUXYDbLC3tR9Wtl7W8ifHZjL/kHfMNAXR8NgJyRX30
	lvbpnt6zTrvkWzPhVi2prSuYeAfupHj1hUqSZG7VAOUtwX9DkvTR1xolVERFU6ol
	B/X/XtIewNFDJFH/VVKy1pTf5Dbh+9g5IIQr1uobEY3uKH5ZWLzXGF3A+/0kJqCs
	/vuIhrVE3JZXyvpU10H0ePVQMOV/3V9EZrWQpE1V+0PX8zLGKLIZTSvQy19fuoXa
	6oJKL3QJB3g1XQAKDgqXQ==
X-ME-Sender: <xms:pGyQaPf0_kMLcpbwc2Povtp7DDkyUtqQi55ECsIjPq3Z6ieOVd9Z7Q>
    <xme:pGyQaHOieoWvooLzuSh7GpGdYOfLJ9_C6WpnpjiqwoBSSN0wfOr1QgCP90D-WE18d
    ZeQmAPBOz8k7MDtcA>
X-ME-Received: <xmr:pGyQaB7-o-dmmFcim8jHEc_MKhAoYGzJY4AMf8D8XohqtHuwbedylR_eMU6Et-4hLTLQSQ4WxF5GcRjem5ANTM00jREkWjoe2HLXVruryNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:pGyQaDIc79-cEpN0MvjXfdAwZJoytLkPBhKMsnDm7QIr4JlVqGHMKA>
    <xmx:pGyQaDfa5kcJpwvYER2wmzBYHZTY_OUvsfzhssnk5ntHnfSX25s81g>
    <xmx:pGyQaOdcC_GN5cxjaaiq6ib2u-5GBHxXaIUW7JsLHnVY1iOZeRk_xA>
    <xmx:pGyQaOO31abIRtcwkesMrg1BHCAvbVyTxZvXUBwiRB4eQprKrHyVqA>
    <xmx:pGyQaKGxwRKwGk1tXG-x20F2P-8S2DqBqsnzX9JgGK-pIq0Lqr0JUxKt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Aug 2025 04:17:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1ea67c2b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Aug 2025 08:17:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 10:17:22 +0200
Subject: [PATCH 6/9] commit-graph: store the hash algorithm instead of its
 length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-b4-pks-commit-graph-wo-the-repository-v1-6-850d626eb2e8@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 3c40f4a470..9c2278dd7a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -310,7 +310,7 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 {
 	struct commit_graph *g = data;
 	g->chunk_oid_lookup = chunk_start;
-	if (chunk_size / g->hash_len != g->num_commits)
+	if (chunk_size / g->hash_algo->rawsz != g->num_commits)
 		return error(_("commit-graph OID lookup chunk is the wrong size"));
 	return 0;
 }
@@ -412,7 +412,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 
 	graph = alloc_commit_graph();
 
-	graph->hash_len = the_hash_algo->rawsz;
+	graph->hash_algo = the_hash_algo;
 	graph->num_chunks = *(unsigned char*)(data + 6);
 	graph->data = graph_map;
 	graph->data_len = graph_size;
@@ -477,7 +477,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 		FREE_AND_NULL(graph->bloom_filter_settings);
 	}
 
-	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_len,
+	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_algo->rawsz,
 		the_repository->hash_algo);
 
 	free_chunkfile(cf);
@@ -583,7 +583,7 @@ static int add_graph_to_chain(struct commit_graph *g,
 		return 0;
 	}
 
-	if (g->chunk_base_graphs_size / g->hash_len < n) {
+	if (g->chunk_base_graphs_size / g->hash_algo->rawsz < n) {
 		warning(_("commit-graph base graphs chunk is too small"));
 		return 0;
 	}
@@ -593,7 +593,7 @@ static int add_graph_to_chain(struct commit_graph *g,
 
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
@@ -2622,7 +2622,7 @@ int write_commit_graph(struct odb_source *source,
 		struct commit_graph *g = ctx.r->objects->commit_graph;
 		for (i = 0; i < g->num_commits; i++) {
 			struct object_id oid;
-			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
+			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
 				the_repository->hash_algo);
 			oid_array_append(&ctx.oids, &oid);
 		}
@@ -2753,7 +2753,7 @@ static int verify_one_commit_graph(struct repository *r,
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit;
 
-		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
+		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
 			the_repository->hash_algo);
 
 		if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
@@ -2798,7 +2798,7 @@ static int verify_one_commit_graph(struct repository *r,
 		timestamp_t generation;
 
 		display_progress(progress, ++(*seen));
-		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
+		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
 			the_repository->hash_algo);
 
 		graph_commit = lookup_commit(r, &cur_oid);
diff --git a/commit-graph.h b/commit-graph.h
index b71cb55697..f20d28ff3a 100644
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
2.50.1.723.g3e08bea96f.dirty

