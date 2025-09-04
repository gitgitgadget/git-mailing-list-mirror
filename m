Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168B2FF179
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990223; cv=none; b=SAoOv1Zmc5gtTSxoa/3Q+MGIbQgrt4EVDmwlxRNW/zXk4xfOwn2yaui2uvoo6d7Bjpmlg22N0mo+681XSCrhGhll79sguAwE//VoeTKkod7ZFRrahfvAf/pZdgGcq8DLirIC/iDWK0pIc7YV7Rw0Fn8Ala2wvQyBxWpU9CX6gxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990223; c=relaxed/simple;
	bh=HNJzwLg7EojPToA0x5z10jWsB7qqzkOlV0acUHzVdPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPM+VuK5ehSw0UL+gbW8wxpz2u/MebN3lqsrhboY70GwZdBrSwf8BKr4XYDyABqrYygsBk6QFY7gR9p94Zjn9tiJzH6DBgG0FpFcEybXHBR8UYCmwAhS//1CU5hujYr20s2NMh7Ud14Wke6xjW6UoWIcGT7O+oezJXtngwzCx2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mDODWnTL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oPwxI5BZ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mDODWnTL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oPwxI5BZ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B75401D002AA
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 08:50:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 04 Sep 2025 08:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756990220;
	 x=1757076620; bh=2cTTpoAyfv5Io/cnHYAEzYfdA4S9vvlZOj4ag54Cd/8=; b=
	mDODWnTLA682paHDn4UDwC4TFzsPSueu3pCftY0oR436DY61mp6F/c+wFHBN/1g6
	hQEetU7rPqgCymbnT1859VqlyVyvDYdl/naRMvYD6V+/fW/BednD/0Mm2ruV5ssn
	dgMuxI2O/2d0ocSagp208lxnawcv62D71mInsQ8qIAy4HVdOsJyca9bC4Ia5Upm0
	faLie1BPFs0yWyTL87sDzpwtHgWEyGj5Ih3HUibvgPF0GYIw8RvuyYWpChaQnfrS
	NBrVOADWp9nsYQGMsU3yw/hcrVNlwvNGwZ8aYUt5ryVYSH8s+RCWlPUKmGYkCHh+
	rGIPhjloTUW2YEadyLY5rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756990220; x=
	1757076620; bh=2cTTpoAyfv5Io/cnHYAEzYfdA4S9vvlZOj4ag54Cd/8=; b=o
	PwxI5BZIUhbNujjfXTNsHys6kI+vOuU8DtT3CBeIWR/2nj1j7MIEz43zfhMnVjEW
	B4vzT5VvFid6/uERhLwdHgg91r+cweKoSy6LLZW+NK5o4q+8lfI/Vi5LqYjyIyon
	nOLaVOP6oM7OrHnlBWYdAihT//20KvYL4X8kZfx7TyeOl9IipACd+kgrFnR+Pj3G
	w0lWYjdItUZ1ooGcpijNxiY0+tjjaKURzhBgCr9qMVZoMzKZkAak0iQc/O/UIVwy
	BWwuRunDCeSrEbMR6wreREMtdP8H66do4NgLKSv0oMJQ8pAZWKr+5ZX4Kvwas0Ct
	l/2RxR5559+ObMUXPJGoQ==
X-ME-Sender: <xms:DIu5aHFYhsMqSu5RZuZGyqOISuK7jlscBtCSQSASnK-q7TwH53H4KA>
    <xme:DIu5aGWZ9_Vu-JC_PpkFzXDw4h2gAidUwFJT7gFg7ZyMrmAyfCCTqvH6e0n-JkI55
    DSIVGRnwhcNerNtUQ>
X-ME-Received: <xmr:DIu5aCiPzpVeJvhL-yB8kSSISwaD99U9l0ZMKr23N4OpZCvPXSJprmxCS_qd1K8nb9PFMNJ4iY_6-LaE3hnzZdmy-XYs5cIvJvM5o8E0gNZTqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:DIu5aHTZlacUb03VZ_7tdi6PpF0XxPR_aPgBceDnTkotHhSbNkQ6gA>
    <xmx:DIu5aFG7xsyf5nV4shXF8kDoIynohX8u_QMwCXsrHN9oODVJ8Zx4Bw>
    <xmx:DIu5aPmQk7idcHk23VDvGEZ4P2zSMEfuRkd4WbR-ixm2r3qryw44vA>
    <xmx:DIu5aI0PNJcQfRabGYfeeQ98WprgCBSJh3cqFXj0QNr4jZJ7fktN8Q>
    <xmx:DIu5aGNDepP58WRpMsI0UvNHh0RAQHeAe_XZefDDXWINlRwzoEUjI__->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Sep 2025 08:50:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0274e40d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Sep 2025 12:50:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 14:50:00 +0200
Subject: [PATCH 6/6] odb: move commit-graph into the object sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-commit-graph-via-source-v1-6-d932c2481e1a@pks.im>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
In-Reply-To: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Commit graphs are inherently tied to one specific object source.
Furthermore, with the upcoming pluggable object sources, it is not even
guaranteed that an object source may even have a commit graph as these
are specific to the actual on-disk data format.

Prepare for this future by moving the commit-graph pointer from `struct
object_database` to `struct odb_source`. Eventually, this will allow us
to make commit graphs an implementation detail of an object source's
backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 65 +++++++++++++++++++++++++++++++++++++++++-----------------
 commit-graph.h |  2 +-
 odb.c          |  9 ++++----
 odb.h          |  6 +++---
 packfile.c     |  3 +--
 5 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0e25b14076..9929c1ed87 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -721,11 +721,15 @@ static struct commit_graph *load_commit_graph_chain(struct odb_source *source)
 
 struct commit_graph *read_commit_graph_one(struct odb_source *source)
 {
-	struct commit_graph *g = load_commit_graph_v1(source);
+	struct commit_graph *g;
+
+	if (source->commit_graph_attempted)
+		return NULL;
+	source->commit_graph_attempted = true;
 
+	g = load_commit_graph_v1(source);
 	if (!g)
 		g = load_commit_graph_chain(source);
-
 	return g;
 }
 
@@ -737,6 +741,7 @@ struct commit_graph *read_commit_graph_one(struct odb_source *source)
  */
 static struct commit_graph *prepare_commit_graph(struct repository *r)
 {
+	bool all_attempted = true;
 	struct odb_source *source;
 
 	/*
@@ -749,9 +754,19 @@ static struct commit_graph *prepare_commit_graph(struct repository *r)
 	if (!r->gitdir || r->commit_graph_disabled)
 		return NULL;
 
-	if (r->objects->commit_graph_attempted)
-		return r->objects->commit_graph;
-	r->objects->commit_graph_attempted = 1;
+	odb_prepare_alternates(r->objects);
+	for (source = r->objects->sources; source; source = source->next) {
+		all_attempted &= source->commit_graph_attempted;
+		if (source->commit_graph)
+			return source->commit_graph;
+	}
+
+	/*
+	 * There is no point in re-trying to load commit graphs if we already
+	 * tried loading all of them beforehand.
+	 */
+	if (all_attempted)
+		return NULL;
 
 	prepare_repo_settings(r);
 
@@ -768,14 +783,16 @@ static struct commit_graph *prepare_commit_graph(struct repository *r)
 	if (!commit_graph_compatible(r))
 		return NULL;
 
-	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
-		r->objects->commit_graph = read_commit_graph_one(source);
-		if (r->objects->commit_graph)
-			break;
+		if (source->commit_graph_attempted)
+			continue;
+
+		source->commit_graph = read_commit_graph_one(source);
+		if (source->commit_graph)
+			return source->commit_graph;
 	}
 
-	return r->objects->commit_graph;
+	return NULL;
 }
 
 int generation_numbers_enabled(struct repository *r)
@@ -806,7 +823,7 @@ int corrected_commit_dates_enabled(struct repository *r)
 
 struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
 {
-	struct commit_graph *g = r->objects->commit_graph;
+	struct commit_graph *g = prepare_commit_graph(r);
 	while (g) {
 		if (g->bloom_filter_settings)
 			return g->bloom_filter_settings;
@@ -815,15 +832,16 @@ struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
 	return NULL;
 }
 
-void close_commit_graph(struct object_database *o)
+void close_commit_graph(struct odb_source *source)
 {
-	if (!o->commit_graph)
+	if (!source->commit_graph)
 		return;
 
 	clear_commit_graph_data_slab(&commit_graph_data_slab);
 	deinit_bloom_filters();
-	free_commit_graph(o->commit_graph);
-	o->commit_graph = NULL;
+	free_commit_graph(source->commit_graph);
+	source->commit_graph = NULL;
+	source->commit_graph_attempted = 0;
 }
 
 static int bsearch_graph(struct commit_graph *g, const struct object_id *oid, uint32_t *pos)
@@ -1119,7 +1137,15 @@ static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
 
 struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit *c)
 {
-	return get_commit_tree_in_graph_one(r->objects->commit_graph, c);
+	struct odb_source *source;
+
+	for (source = r->objects->sources; source; source = source->next) {
+		if (!source->commit_graph)
+			continue;
+		return get_commit_tree_in_graph_one(source->commit_graph, c);
+	}
+
+	return NULL;
 }
 
 struct packed_commit_list {
@@ -2165,7 +2191,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2] = new_base_hash;
 	}
 
-	close_commit_graph(ctx->r->objects);
+	for (struct odb_source *s = ctx->r->objects->sources; s; s = s->next)
+		close_commit_graph(s);
 	finalize_hashfile(f, file_hash, FSYNC_COMPONENT_COMMIT_GRAPH,
 			  CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	free_chunkfile(cf);
@@ -2667,8 +2694,8 @@ int write_commit_graph(struct odb_source *source,
 	oid_array_clear(&ctx.oids);
 	clear_topo_level_slab(&topo_levels);
 
-	if (ctx.r->objects->commit_graph) {
-		struct commit_graph *g = ctx.r->objects->commit_graph;
+	if (source->commit_graph) {
+		struct commit_graph *g = source->commit_graph;
 
 		while (g) {
 			g->topo_levels = NULL;
diff --git a/commit-graph.h b/commit-graph.h
index f6a5433641..33cb6a7577 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -185,7 +185,7 @@ int write_commit_graph(struct odb_source *source,
 
 int verify_commit_graph(struct commit_graph *g, int flags);
 
-void close_commit_graph(struct object_database *);
+void close_commit_graph(struct odb_source *);
 void free_commit_graph(struct commit_graph *);
 
 /*
diff --git a/odb.c b/odb.c
index 2a92a018c4..fdcc6849a8 100644
--- a/odb.c
+++ b/odb.c
@@ -363,6 +363,11 @@ static void free_object_directory(struct odb_source *source)
 	free(source->path);
 	odb_clear_loose_cache(source);
 	loose_object_map_clear(&source->loose_map);
+
+	free_commit_graph(source->commit_graph);
+	source->commit_graph = NULL;
+	source->commit_graph_attempted = 0;
+
 	free(source);
 }
 
@@ -1023,10 +1028,6 @@ void odb_clear(struct object_database *o)
 	oidmap_clear(&o->replace_map, 1);
 	pthread_mutex_destroy(&o->replace_mutex);
 
-	free_commit_graph(o->commit_graph);
-	o->commit_graph = NULL;
-	o->commit_graph_attempted = 0;
-
 	free_object_directories(o);
 	o->sources_tail = NULL;
 	o->loaded_alternates = 0;
diff --git a/odb.h b/odb.h
index 3dfc66d75a..a4835db685 100644
--- a/odb.h
+++ b/odb.h
@@ -63,6 +63,9 @@ struct odb_source {
 	 */
 	struct multi_pack_index *midx;
 
+	struct commit_graph *commit_graph;
+	bool commit_graph_attempted; /* if loading has been attempted */
+
 	/*
 	 * This is a temporary object store created by the tmp_objdir
 	 * facility. Disable ref updates since the objects in the store
@@ -120,9 +123,6 @@ struct object_database {
 	unsigned replace_map_initialized : 1;
 	pthread_mutex_t replace_mutex; /* protect object replace functions */
 
-	struct commit_graph *commit_graph;
-	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
-
 	/*
 	 * private data
 	 *
diff --git a/packfile.c b/packfile.c
index 5d73932f50..5d3a25816f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -374,9 +374,8 @@ void close_object_store(struct object_database *o)
 		if (source->midx)
 			close_midx(source->midx);
 		source->midx = NULL;
+		close_commit_graph(source);
 	}
-
-	close_commit_graph(o);
 }
 
 void unlink_pack_path(const char *pack_name, int force_delete)

-- 
2.51.0.417.g1ba7204a04.dirty

