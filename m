Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB91F279333
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754481641; cv=none; b=TUAMchNu4p8opzVudJRybD72ey6MmaKpOAP39pXVbspB2iZdFz+GUjqv+LqyF0ZTTbmPPo/GxtpZuJEbntMKERmXXJjqICNvFQXDl4iepu7MwL4POKOJuUEY1YGRCsn9cC12UTQ+iBehHNn/OWnhu9Lemttepyivt7lCR9wGNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754481641; c=relaxed/simple;
	bh=8sCrAdWqOUGzps0Uh2ZLhyMfRCfg6+7zFHQMoq0sAV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HPZFb02Hd1xVLrq9o1G5+Ax0sdeYYG1Wxj4+1pXf8nuu64hOX7TAm1LDoHUfgrsiVbw9UXX8Q9aI0cb6dPnvzyZxd6VCn/j5bYFiuc7WAMjxLV8S+rZZ0OUFfax87wOBNzHBQyqVVyuFYTgUA/2yWqaofmISqyFdJ3C3XrigFjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IkWK2j9Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=de3ob7pp; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IkWK2j9Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="de3ob7pp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 00E3014000CB;
	Wed,  6 Aug 2025 08:00:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 06 Aug 2025 08:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754481638;
	 x=1754568038; bh=7RsPJPtYeerLcSWONr5s+Bv8SdP2m9ZEomEcOIFCQFE=; b=
	IkWK2j9QRRSgsWe8inby6FsCEnzrBQUzktoepRtaLWavg2qRYSE1AJu2ZTD9I8BS
	9Uy5WLOQMlTHT9MKEaQ5joCWNyQd5DrHR4EdxwAtJ346S/plvd012p4Na1RyrsBR
	DDd/wuviXHPEKLQJ/knzP9WlI8lDZ1KLtFrLTu+LLu8jjq6u2zEtXLw/17V9qD7e
	jQpt/eLu5la5KR5+Fhz1Ag80GCg8Ck+whwsBlveUUdN2E0aAJWl7sz8iABsadOwK
	9AcG8IK+VI2NcoHCm8ubqFyMoI9V3ILzI9G8D0lAgg/Ktu2mNLTFM8ipkUXSK3vU
	Up3MPOwRrn6dko/ULA2QOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754481638; x=
	1754568038; bh=7RsPJPtYeerLcSWONr5s+Bv8SdP2m9ZEomEcOIFCQFE=; b=d
	e3ob7pp3MdHw/LsmmYHBJVUuW+sFXAzJ/vGMy43gZ64MAkocUpfgeBnVojG3J27r
	wmLfUIGi5Ejp4+cCh1isbPq04s7t4G8qKjKIfOjJaNYZwWqnQ47dWs2jHHLzuhjm
	DLxt06rGuALSx1xfP8U4j+vkoS52caOjip4a/LaPhIVVILUuzUcvD1ybo45owoHK
	IW7MwZnTwUlWixkJG/IdqimmtgKG66hRMpnAfCvE2oDCk7g1gtVZ34FwOrZ1L+9Q
	rq8Bw2GCED2uisdy5Qsfq3jJzpIkmk1ikFekJ11TM7v8Sn59jWlhAXT1aHPMe218
	+H64s/fzVhoPM/U7KeEaQ==
X-ME-Sender: <xms:5kOTaDZEU6XHiRgcUvbzGlxsNxNHJKysmSAMFkQFdvYSrOp_QxNQ6A>
    <xme:5kOTaN4hl4zDe7kEhV6yenp_SncJO8uy76BTKUhHLbDTQjiesMnaoHXIafaf2WrKL
    Mc46SpLgH-OzDM8_A>
X-ME-Received: <xmr:5kOTaMYJEOcqCi91x6IyfL9uxu8p_8WoqoQr_QMtJ_8F614kkSqC1WMg0I4M6kUBxY_J1f0dEGXtOxuYiLXEN7Epjt34XFwVHNnHQtGS_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsfigrlh
    gurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprh
    gtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:5kOTaEjKObbHyOufZ0viDz9vt4KZvessyqSYgvfXjZ2MBdSERY8tmA>
    <xmx:5kOTaF8qtHCVlzeVOM0pWKACtK2Gqubnz-wRSlvLYGls5E11xxuSxQ>
    <xmx:5kOTaHqslKK0tohGiRQccx8ApVSqFPqAjGqsANOFTQXlewe3mhfNiw>
    <xmx:5kOTaFVNLJDRejgsM3qS5u-zWiqVYhtXDmkXNab-Fqs14LxEYbELjQ>
    <xmx:5kOTaLX7QsgQa7BqUZeGwGcQOLKjiIGFmFgK2cxim5IYEgqIDHkDjdNj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 08:00:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6816e6d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 12:00:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 14:00:11 +0200
Subject: [PATCH v2 06/10] commit-graph: store the hash algorithm instead of
 its length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-b4-pks-commit-graph-wo-the-repository-v2-6-911bae638e61@pks.im>
References: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
In-Reply-To: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
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
index c4a0b12b6c..590a6972d2 100644
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
2.51.0.rc0.215.g125493bb4a.dirty

