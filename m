Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CF82FDC3E
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990218; cv=none; b=MgQ05m/vhEszpq2qlthNy+eoFX3FhNl/DLitFkusxBwLiSgvWBs4ZYmV0jq11pm7afCdZfkO5IJIN/cDlR4ic1zAGGdL7RS0XGHc2xF+31hDT8mrHdrKfa2mCpz/ZWp+Pln+/OP/l0exd6qUGcD4CJ3ibZHvZYkXtNvZEimhXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990218; c=relaxed/simple;
	bh=7S28JjqOt1Rqmv++2AOMWtZyglWT1NES1vSF7HP1twU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQQIa0CyM1V27JTpesjlPiP0ss7YD4xmICpw5QewtHndluU2Y6TijORI5fTVE/2gDC2E3yg6MresaD7Rby7PvX4ekr2qeDEU2eBqpUwOgLPrO9PhoPF4ULEjXTeZ6Tj6WttdkH0/ayAVmc1Tb4nkAWYFYOgGy3PUV9gZtz1zpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nfP9pHvc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z6J8i3Ie; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nfP9pHvc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z6J8i3Ie"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A1A537A03B4
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 08:50:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 04 Sep 2025 08:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756990214;
	 x=1757076614; bh=2ooXQt9eG8JgBGmF4TWsfq04ONtfNxRamjI9ug57QlI=; b=
	nfP9pHvc1Q9aT0aAzyIgEidfxV/HmA245EsZWJBCtHv2k1HmbJih/ZMK6/Gnax4o
	BxB3cpUf46mUMPfwJKsm1lommaIxJ+pxkgZRPfsmkMKh7Pcucx9iU/8T6w/XEwu8
	wbJ+ty4oRpj/Ri5QQ+uLxMwErIQLWylyftTbd1HmBitmUJTuAe3DkRxtCgJeLQMJ
	MXvrhmPlWpzS/NF++L5Y4gRNld92jPfqvTIf1+MP+zCnoWlRL1uox0lLnL280bP8
	044BfOCVsL+uuidbFfWxVvxNJvOrA4sxCDHwP6qnvikB8wFDSMi/vjY1iRGnNZ6r
	aUF65Gi05YOcbQdik4CIwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756990214; x=
	1757076614; bh=2ooXQt9eG8JgBGmF4TWsfq04ONtfNxRamjI9ug57QlI=; b=Z
	6J8i3IemVRG+HsmfR3MafZ5aGQ9iIrDkD8W4zZhSpKcV81rRP2vkYwzKLFA/1isb
	WMJfCr7yuH5y07UAJDEdhbiyPu1/p7D3QBEuEuoX+fz0OhjdtAFgr+iLVHIPm2Dd
	q+18Vfka10Ex+Y42IaYpvwE1Hc0RRKM63daKGbZhMZmRh0ZyT1mKxtjNT2+eOTfb
	wnkjYl3eouTjhYARI7vQ4ET8WwsgXnV5zGrJuB5ikkh5MlgX5fEJW50E0lx4JVmT
	ExfaSRPORqU6ee8Qd7WlHLVf02T7CHX4Ab/uNXPMT+GtK64m+62w6ZXfRkjE2AFY
	4kH3S78jN8siWxxiV3M4w==
X-ME-Sender: <xms:Bou5aJvWxjlXDwhd8qQIYx7MXu-3A-ljYDnTC503XN_l38kZ_VBqxQ>
    <xme:Bou5aEcNf_uBjlzglHcydF8OezfGj_n-hQW8OWAQ77apSrrUSiUH18vFRZJcpspZX
    olbapgHA0EL83AvLw>
X-ME-Received: <xmr:Bou5aGLy73KjC24hnApF2hfkzsRemwNB3WkGWRHGB3wHx3AnlHUQ1-iQJI_S2TD5_Cfbpj6bRLC1NvRNmZbK43BOkWfwfbdk1UJzhkFGOHwqUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:Bou5aCY1a5NNvWXYjFuPHFHaNelsQdlC_TAG3iTxFM2yjNtv-2di0A>
    <xmx:Bou5aBuyGMtnNJJG6wKn19SHVsPuSpEZ44v05PPk5Xqbd7hYg3OIYA>
    <xmx:Bou5aPsga1P1ayg6t84w0dbL9nzQ2RpDXeYjlNBBa_LtGkYpvRQcSQ>
    <xmx:Bou5aGcsNq6qhLKPKIXY1eDM_45kQ8pdmZaHYQb6a-aGBh73bScCew>
    <xmx:Bou5aJXvBWzZ8_7g4-6LiOha8Eg3vycTBIjzmdK06Tj07Hhqbrr1AlAS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Sep 2025 08:50:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 39235984 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Sep 2025 12:50:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 14:49:58 +0200
Subject: [PATCH 4/6] commit-graph: return commit graph from
 `repo_find_commit_pos_in_graph()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-commit-graph-via-source-v1-4-d932c2481e1a@pks.im>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
In-Reply-To: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The function `repo_find_commit_pos_in_graph()` takes a commit as input
and tries to figure out whether the given repository has a commit graph
that contains that specific commit. If so, it returns the corresponding
position of that commit inside the graph.

Right now though we only return the position, but not the actual graph
that the commit has been found in. This is sensible as repositories
always have the graph in `struct repository::objects::commit_graph`.
Consequently, the caller always knows where to find it.

But in a subsequent change we're going to move the graph into the object
sources. This would require callers of the function to loop through all
sources to find the relevant commit graph.

Refactor the code so that we instead return the commit-graph that the
commit has been found with.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bloom.c        |  8 +++++---
 commit-graph.c | 18 ++++++++++++------
 commit-graph.h | 12 ++++++------
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/bloom.c b/bloom.c
index b86015f6d1..2d7b951e5b 100644
--- a/bloom.c
+++ b/bloom.c
@@ -452,10 +452,12 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	filter = bloom_filter_slab_at(&bloom_filters, c);
 
 	if (!filter->data) {
+		struct commit_graph *g;
 		uint32_t graph_pos;
-		if (repo_find_commit_pos_in_graph(r, c, &graph_pos))
-			load_bloom_filter_from_graph(r->objects->commit_graph,
-						     filter, graph_pos);
+
+		g = repo_find_commit_pos_in_graph(r, c, &graph_pos);
+		if (g)
+			load_bloom_filter_from_graph(g, filter, graph_pos);
 	}
 
 	if (filter->data && filter->len) {
diff --git a/commit-graph.c b/commit-graph.c
index 62260a2026..16dfe58229 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1003,13 +1003,16 @@ static int find_commit_pos_in_graph(struct commit *item, struct commit_graph *g,
 	}
 }
 
-int repo_find_commit_pos_in_graph(struct repository *r, struct commit *c,
-				  uint32_t *pos)
+struct commit_graph *repo_find_commit_pos_in_graph(struct repository *r,
+						   struct commit *c,
+						   uint32_t *pos)
 {
 	struct commit_graph *g = prepare_commit_graph(r);
 	if (!g)
-		return 0;
-	return find_commit_pos_in_graph(c, g, pos);
+		return NULL;
+	if (!find_commit_pos_in_graph(c, g, pos))
+		return NULL;
+	return g;
 }
 
 struct commit *lookup_commit_in_graph(struct repository *repo, const struct object_id *id)
@@ -1075,9 +1078,12 @@ int parse_commit_in_graph(struct repository *r, struct commit *item)
 
 void load_commit_graph_info(struct repository *r, struct commit *item)
 {
+	struct commit_graph *g;
 	uint32_t pos;
-	if (repo_find_commit_pos_in_graph(r, item, &pos))
-		fill_commit_graph_info(item, r->objects->commit_graph, pos);
+
+	g = repo_find_commit_pos_in_graph(r, item, &pos);
+	if (g)
+		fill_commit_graph_info(item, g, pos);
 }
 
 static struct tree *load_tree_for_commit(struct commit_graph *g,
diff --git a/commit-graph.h b/commit-graph.h
index 4899b54ef8..f6a5433641 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -48,10 +48,9 @@ int open_commit_graph_chain(const char *chain_file, int *fd, struct stat *st,
 int parse_commit_in_graph(struct repository *r, struct commit *item);
 
 /*
- * Fills `*pos` with the graph position of `c`, and returns 1 if `c` is
- * found in the commit-graph belonging to `r`, or 0 otherwise.
- * Initializes the commit-graph belonging to `r` if it hasn't been
- * already.
+ * Fills `*pos` with the graph position of `c`, and returns the graph `c` is
+ * found in, or NULL otherwise. Initializes the commit-graphs belonging to
+ * `r` if it hasn't been already.
  *
  * Note: this is a low-level helper that does not alter any slab data
  * associated with `c`. Useful in circumstances where the slab data is
@@ -59,8 +58,9 @@ int parse_commit_in_graph(struct repository *r, struct commit *item);
  *
  * In most cases, callers should use `parse_commit_in_graph()` instead.
  */
-int repo_find_commit_pos_in_graph(struct repository *r, struct commit *c,
-				  uint32_t *pos);
+struct commit_graph *repo_find_commit_pos_in_graph(struct repository *r,
+						   struct commit *c,
+						   uint32_t *pos);
 
 /*
  * Look up the given commit ID in the commit-graph. This will only return a

-- 
2.51.0.417.g1ba7204a04.dirty

