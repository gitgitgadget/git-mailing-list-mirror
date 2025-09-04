Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922492FE05D
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990214; cv=none; b=eKraYM5R7CbwTW0OnOw5cE/QRINeo+s0MYstXthHbqd0ePORO3cdyxAeXrTOmmIva+lBmDWh/R5wB/6fvEBF/mbzOz/owjz4aTM7HM2Wp7xbehjXrXJfODvL+TfDAJPYF1MLJsP2Ymu9RI7duxFreMQjcJKt0y6fxUD0LzytIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990214; c=relaxed/simple;
	bh=oNzRa0hK8oRu935J1QKmRCCGED1scEsRpWSxhcDlT6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gzd98aK41UDVAivYcbq0nxusgcVNKQQ4f1Z75o2TpUJd7ma80zC6uGac8opQ9xxM+ltj3CQK3lPmyF3vuQ6Lbnufeuav1PmRkDm4woCjFp1uy/4wy+G8ZdaomfdjS2Hk1nLxB7AuOdeH90uuq8UUkab9K8q75kcCfd80ycfm86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fW+wclvp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SWoZ4Qao; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fW+wclvp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SWoZ4Qao"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A2AE61D0029B
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 08:50:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 04 Sep 2025 08:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756990211;
	 x=1757076611; bh=TM+uBor9XahKlwj5jiFBepE2999C0frMNyqWLAJR/q4=; b=
	fW+wclvpQ9kXn07Z/52de1Odv/rcgMPR2hvQAdbSz8LXphTAdzZv3UO/ztv4stjX
	gv5TL+nmGLKIIkLUzh0OBCOimWJsfrbs8UURIHbPsdGgUsVcqen4HTdotx8sZEKy
	SSev1sFNPVlPTH8e1sjsPld/cuaFsr3Aq8Q2JWp9dZNOc0ll6NuB5XPAyQV8Lpl/
	+ZNed3GfHQf8a9N6FqpD7adgKqwZDM3wcSGiaR1s9Ofxdu2T0hKyQ6XL2rmRdXQB
	AKoClccf+fR0W7YUodvi8JczDfUY+kDU507nc2NYAgx8lqi/OfW5ovpQeG/B5jrV
	BKChHZjwZtgJR0QSmvUwFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756990211; x=
	1757076611; bh=TM+uBor9XahKlwj5jiFBepE2999C0frMNyqWLAJR/q4=; b=S
	WoZ4Qao9NMaHArGwBlV+9kaKLecBgpwmB08X7YKaTVmu6+mtk8EJqhNFiBRO/CoR
	XWNmHUG8Xtbd18KB3Niphz6jfEIkez7oDZQOS+NJWMU5ms0Q9gwXVaVpanRI3Tvl
	+Zqe2evRTc/PJy21VQzxeA+Uw7SrcoPnxeLD1JJqPKWJD7u0xl2q6cmoazwWnXoh
	eTspEKmaS2DoVj8/hZRV0CVifWfd4jQZL/f7nNfUK37YBOcdQUfJF++FVo3WFBQ1
	SrWJrheXX/lKqVA7LeV/VUm+zrStJWEZhMXQZKNf3h/rzhQHZFqZlYbJvDu2D7qp
	J+0HqAHaJ6se4p6cLMxyg==
X-ME-Sender: <xms:A4u5aC5C2MYlnl7b-j2sSGCSLHGqR7qdVk9q1oiN3hq_rY4DlHKjsA>
    <xme:A4u5aN7sE1jLM4brh6wn3R_k81J44XpUR3heAyXnHVZMVjp_VYkR0PHrOTAGBi8xr
    XxPhJiK2i3TRml79A>
X-ME-Received: <xmr:A4u5aK3PaLASWxJvLb8uVB1lW9AyMrZftVGreVbqk2ZwTySmV1uPKy_6Y97gNlGBapt-YLTiBaR-ajjFC9_VwccUNWcC2iWioYWAkZ8csODX6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:A4u5aBXQ1mEV-IKwWEV8sbrDYje_kBW6DeG47EheFfxqAarVDNnOxw>
    <xmx:A4u5aN5jcHKuQJRVr4TgyrC2OFIVcSX2-5PWysaM9UGjLzPkLxUgHg>
    <xmx:A4u5aAIDO1e75Iamw6FU0-V4D1Qe68wloojB-6U52Te9cicTXbpYPQ>
    <xmx:A4u5aGKzP4M6-JRTrIs297UJppolqe-na9GGhYRedHc0Tfd3ZGCMhw>
    <xmx:A4u5aEQk2oAJs50acmUFW-_Ssx964YJe0mTnbYHn2W0DidcyOAte_FxL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Sep 2025 08:50:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 219e952e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Sep 2025 12:50:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 14:49:57 +0200
Subject: [PATCH 3/6] commit-graph: return the prepared commit graph from
 `prepare_commit_graph()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-commit-graph-via-source-v1-3-d932c2481e1a@pks.im>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
In-Reply-To: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When making use of commit graphs, one needs to first prepare them by
calling `prepare_commit_graph()`. Once that function was called and the
commit graph was prepared successfully, the caller is now expected to
access the graph directly via `struct object_database::commit_graph`.

In a subsequent change, we're going to move the commit graph pointer
from `struct object_database` into `struct odb_source`. With this
change, semantics will change so that we use the commit graph of the
first source that has one. Consequently, all callers that currently
deference the `commit_graph` pointer would now have to loop around the
list of sources to find the commit graph.

This would become quite unwieldy. So instead of shifting the burden onto
such callers, adapt `prepare_commit_graph()` to return the prepared
commit graph, if any. Like this, callers are expected to call that
function and then use the returned commit graph.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 82 +++++++++++++++++++++++-----------------------------------
 1 file changed, 32 insertions(+), 50 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3cd9e73e2a..62260a2026 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -735,7 +735,7 @@ struct commit_graph *read_commit_graph_one(struct odb_source *source)
  * On the first invocation, this function attempts to load the commit
  * graph if the repository is configured to have one.
  */
-static int prepare_commit_graph(struct repository *r)
+static struct commit_graph *prepare_commit_graph(struct repository *r)
 {
 	struct odb_source *source;
 
@@ -747,10 +747,10 @@ static int prepare_commit_graph(struct repository *r)
 	 * we want to disable even an already-loaded graph file.
 	 */
 	if (!r->gitdir || r->commit_graph_disabled)
-		return 0;
+		return NULL;
 
 	if (r->objects->commit_graph_attempted)
-		return !!r->objects->commit_graph;
+		return r->objects->commit_graph;
 	r->objects->commit_graph_attempted = 1;
 
 	prepare_repo_settings(r);
@@ -763,10 +763,10 @@ static int prepare_commit_graph(struct repository *r)
 		 * so that commit graph loading is not attempted again for this
 		 * repository.)
 		 */
-		return 0;
+		return NULL;
 
 	if (!commit_graph_compatible(r))
-		return 0;
+		return NULL;
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
@@ -775,20 +775,17 @@ static int prepare_commit_graph(struct repository *r)
 			break;
 	}
 
-	return !!r->objects->commit_graph;
+	return r->objects->commit_graph;
 }
 
 int generation_numbers_enabled(struct repository *r)
 {
 	uint32_t first_generation;
 	struct commit_graph *g;
-	if (!prepare_commit_graph(r))
-	       return 0;
 
-	g = r->objects->commit_graph;
-
-	if (!g->num_commits)
-		return 0;
+	g = prepare_commit_graph(r);
+	if (!g || !g->num_commits)
+	       return 0;
 
 	first_generation = get_be32(g->chunk_commit_data +
 				    g->hash_algo->rawsz + 8) >> 2;
@@ -799,12 +796,9 @@ int generation_numbers_enabled(struct repository *r)
 int corrected_commit_dates_enabled(struct repository *r)
 {
 	struct commit_graph *g;
-	if (!prepare_commit_graph(r))
-		return 0;
 
-	g = r->objects->commit_graph;
-
-	if (!g->num_commits)
+	g = prepare_commit_graph(r);
+	if (!g || !g->num_commits)
 		return 0;
 
 	return g->read_generation_data;
@@ -1012,23 +1006,26 @@ static int find_commit_pos_in_graph(struct commit *item, struct commit_graph *g,
 int repo_find_commit_pos_in_graph(struct repository *r, struct commit *c,
 				  uint32_t *pos)
 {
-	if (!prepare_commit_graph(r))
+	struct commit_graph *g = prepare_commit_graph(r);
+	if (!g)
 		return 0;
-	return find_commit_pos_in_graph(c, r->objects->commit_graph, pos);
+	return find_commit_pos_in_graph(c, g, pos);
 }
 
 struct commit *lookup_commit_in_graph(struct repository *repo, const struct object_id *id)
 {
 	static int commit_graph_paranoia = -1;
+	struct commit_graph *g;
 	struct commit *commit;
 	uint32_t pos;
 
 	if (commit_graph_paranoia == -1)
 		commit_graph_paranoia = git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 0);
 
-	if (!prepare_commit_graph(repo))
+	g = prepare_commit_graph(repo);
+	if (!g)
 		return NULL;
-	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
+	if (!search_commit_pos_in_graph(id, g, &pos))
 		return NULL;
 	if (commit_graph_paranoia && !odb_has_object(repo->objects, id, 0))
 		return NULL;
@@ -1039,7 +1036,7 @@ struct commit *lookup_commit_in_graph(struct repository *repo, const struct obje
 	if (commit->object.parsed)
 		return commit;
 
-	if (!fill_commit_in_graph(commit, repo->objects->commit_graph, pos))
+	if (!fill_commit_in_graph(commit, g, pos))
 		return NULL;
 
 	return commit;
@@ -1062,6 +1059,7 @@ static int parse_commit_in_graph_one(struct commit_graph *g,
 int parse_commit_in_graph(struct repository *r, struct commit *item)
 {
 	static int checked_env = 0;
+	struct commit_graph *g;
 
 	if (!checked_env &&
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE, 0))
@@ -1069,9 +1067,10 @@ int parse_commit_in_graph(struct repository *r, struct commit *item)
 		    GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE);
 	checked_env = 1;
 
-	if (!prepare_commit_graph(r))
+	g = prepare_commit_graph(r);
+	if (!g)
 		return 0;
-	return parse_commit_in_graph_one(r->objects->commit_graph, item);
+	return parse_commit_in_graph_one(g, item);
 }
 
 void load_commit_graph_info(struct repository *r, struct commit *item)
@@ -2519,6 +2518,7 @@ int write_commit_graph(struct odb_source *source,
 	int replace = 0;
 	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 	struct topo_level_slab topo_levels;
+	struct commit_graph *g;
 
 	prepare_repo_settings(r);
 	if (!r->settings.core_commit_graph) {
@@ -2547,23 +2547,13 @@ int write_commit_graph(struct odb_source *source,
 	init_topo_level_slab(&topo_levels);
 	ctx.topo_levels = &topo_levels;
 
-	prepare_commit_graph(ctx.r);
-	if (ctx.r->objects->commit_graph) {
-		struct commit_graph *g = ctx.r->objects->commit_graph;
-
-		while (g) {
-			g->topo_levels = &topo_levels;
-			g = g->base_graph;
-		}
-	}
+	g = prepare_commit_graph(ctx.r);
+	for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
+		g->topo_levels = &topo_levels;
 
 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
 		ctx.changed_paths = 1;
 	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
-		struct commit_graph *g;
-
-		g = ctx.r->objects->commit_graph;
-
 		/* We have changed-paths already. Keep them in the next graph */
 		if (g && g->bloom_filter_settings) {
 			ctx.changed_paths = 1;
@@ -2580,22 +2570,15 @@ int write_commit_graph(struct odb_source *source,
 	bloom_settings.hash_version = bloom_settings.hash_version == 2 ? 2 : 1;
 
 	if (ctx.split) {
-		struct commit_graph *g = ctx.r->objects->commit_graph;
-
-		while (g) {
+		for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
 			ctx.num_commit_graphs_before++;
-			g = g->base_graph;
-		}
 
 		if (ctx.num_commit_graphs_before) {
 			ALLOC_ARRAY(ctx.commit_graph_filenames_before, ctx.num_commit_graphs_before);
 			i = ctx.num_commit_graphs_before;
-			g = ctx.r->objects->commit_graph;
 
-			while (g) {
-				ctx.commit_graph_filenames_before[--i] = xstrdup(g->filename);
-				g = g->base_graph;
-			}
+			for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
+				ctx.commit_graph_filenames_before[--i] = xstrdup(chain->filename);
 		}
 
 		if (ctx.opts)
@@ -2604,8 +2587,7 @@ int write_commit_graph(struct odb_source *source,
 
 	ctx.approx_nr_objects = repo_approximate_object_count(r);
 
-	if (ctx.append && ctx.r->objects->commit_graph) {
-		struct commit_graph *g = ctx.r->objects->commit_graph;
+	if (ctx.append && g) {
 		for (i = 0; i < g->num_commits; i++) {
 			struct object_id oid;
 			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_algo->rawsz, i),
@@ -2651,7 +2633,7 @@ int write_commit_graph(struct odb_source *source,
 	} else
 		ctx.num_commit_graphs_after = 1;
 
-	ctx.trust_generation_numbers = validate_mixed_generation_chain(ctx.r->objects->commit_graph);
+	ctx.trust_generation_numbers = validate_mixed_generation_chain(g);
 
 	compute_topological_levels(&ctx);
 	if (ctx.write_generation_data)

-- 
2.51.0.417.g1ba7204a04.dirty

