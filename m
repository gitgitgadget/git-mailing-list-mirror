Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F2248F4B
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553908; cv=none; b=Z73Hz5mPfi6IBfUMvG/RS3nzgrkb7MlC/O4zBCmpccKOej3rB2jVybXtfelNKk1g4uGjAb2x9i2Kl6NKBsJ4BGsxDsVVF07UTTfow4kTWsHPSP/B03nwj+QV9uJf3bvadafSUpaoLKblhHrataqe2b7PP/i44xBsSWRD124RGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553908; c=relaxed/simple;
	bh=zDoyVBufibFhcGN5ccWg18B8GoExkW9Vjl+htgG2ZDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLuP4KDxY5IcdxSHIhDjGKJUWqLBZI1kYP1twuLMRsaHw1NFPnsZjRv6/DxXXi3WPIUKiiRtEI2PDJGmLiKqpG3lZUIiYje7+NEXbd6c4eDvNq4wqZe2BBgaUp2zqD+JkNSVlNbGlldDBCgiz4me7w7A4cl+0YiSPN1B9MrxWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dg3lNpjR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RTHNL0/1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dg3lNpjR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RTHNL0/1"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE3CB140016F;
	Thu,  7 Aug 2025 04:05:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 07 Aug 2025 04:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754553905;
	 x=1754640305; bh=6Q/4+WsxChTzTwKiovaQ2x7jAA3xJTIDGf6jhDJfryY=; b=
	dg3lNpjRr1C1A0Daw6xHiL/43T+UagWEdnWp5DzlyUt1xDPaAZThkF2dhf3Yq7Jg
	v+okbNOAkqaZlFlKOQqi81eGNVqqfHSnEWvRe+PrkQ/i6otFpzOawZxEHNV8qSzI
	d2dA8SPfLblRJ3fMYI3MveFlBedoznJp+P36ICwV9rZvQe/tvd1gd+sll1UjUWjF
	juCxIyfjvwbUFkwWEiujqnCIif3cytATKHHr84t6WjpuPMeZJ4pqBhGRAwcPm8hc
	eI0OgpWTEBTYpLoXrrpaP70R+fhaQUCEr61nPzW7g2l+Jntd8/vGVJ3dRhplwUBC
	Ul24XV0it/IdiUY6+NqCvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754553905; x=
	1754640305; bh=6Q/4+WsxChTzTwKiovaQ2x7jAA3xJTIDGf6jhDJfryY=; b=R
	THNL0/14QRvUTv7vvoSQ9AsvPcIIAHyKCyw7Jsy6QWZEhclWRcVhX31wIy1SB1Y5
	XhRuFcPZR1D3aM1qS6UOy/PQQPJos+J4crk/ER8Oip7O7ET/giEwU8+jnqcqTzN0
	5V0ltjjUCQ3vsmDKcLwdMj+oR8jTQJsx6pjiy3jdvjVLdbmoAg6qpY7+aGgUfgaJ
	7Yr6Zfsqg8NXraAsBInXpMFTojBwY8oyG9q/Yg2JhqRhdFE9rGZjCS4bT1YZ9X6C
	3OYXkUMfxu/Yotjo0yb4fKGP5dF3mmW1adFtcCrRGUBmd2sobNEphs+RxuJbZJIu
	vtuQWo93adMdXMy2XQUQw==
X-ME-Sender: <xms:MV6UaGX5DKc9EtR4Q8qyhU47MpkQ9ArkNLWHiOrYiE_wwk24eAQmnQ>
    <xme:MV6UaOGAxeoGj4Bi7cAWb-_eBLu3Kxq-GpBP2rT0GLwRRoO2x5ANPFIY8LP5I9U8R
    _cAJX18-mj8nD7RAA>
X-ME-Received: <xmr:MV6UaA0w79qYk6R7KUOM_ERfSQJN0OwLBxmGKiHoMhvhl13Pn2dXGixdHvqhDSe7G-kWbwPmW4wMeOhRCVDv9MKCWh31ZTloDozuZKw8gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepohhsfi
    grlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvg
X-ME-Proxy: <xmx:MV6UaIPgFOQt84xH1ukz96jn4NiKc379SHLIgnTSAtPKP5I4dVuA0w>
    <xmx:MV6UaH6jWXVf76lUHt7UpazGyd0_EgQUVY1Hdzja87-GRfiRdiA3KQ>
    <xmx:MV6UaK0Yb9K3CbR4q92wkLMIEuOkJrNXBkvIiQz9QMNjWDjw9EDfYw>
    <xmx:MV6UaAwxZib3FO37Yjvxu9uZlwd4NPDJN7I1E6Z19inDgckBxknXGQ>
    <xmx:MV6UaFCk2CLBHQvxqP7NVjEH56Vlucwelb5-FV4FNDauDrfHz8Oh0mfl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:05:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 410d9de1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:05:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:04:47 +0200
Subject: [PATCH v3 05/10] commit-graph: stop using `the_hash_algo` via
 macros
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-commit-graph-wo-the-repository-v3-5-82edef830a1e@pks.im>
References: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
In-Reply-To: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We have two macros `GRAPH_DATA_WIDTH` and `GRAPH_MIN_SIZE` that compute
hash-dependent sizes. They do so by using the global `the_hash_algo`
variable though, which we want to get rid of over time.

Convert these macros into functions that accept the hash algorithm as
input parameter. Adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7c0ded4532..e75fb8e6ea 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -52,8 +52,6 @@ void git_test_write_commit_graph_or_die(void)
 #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
 
-#define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
-
 #define GRAPH_VERSION_1 0x1
 #define GRAPH_VERSION GRAPH_VERSION_1
 
@@ -65,8 +63,6 @@ void git_test_write_commit_graph_or_die(void)
 
 #define GRAPH_HEADER_SIZE 8
 #define GRAPH_FANOUT_SIZE (4 * 256)
-#define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * CHUNK_TOC_ENTRY_SIZE \
-			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
 
 #define CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW (1ULL << 31)
 
@@ -79,6 +75,16 @@ define_commit_slab(topo_level_slab, uint32_t);
 define_commit_slab(commit_pos, int);
 static struct commit_pos commit_pos = COMMIT_SLAB_INIT(1, commit_pos);
 
+static size_t graph_data_width(const struct git_hash_algo *algop)
+{
+	return algop->rawsz + 16;
+}
+
+static size_t graph_min_size(const struct git_hash_algo *algop)
+{
+	return GRAPH_HEADER_SIZE + 4 * CHUNK_TOC_ENTRY_SIZE + GRAPH_FANOUT_SIZE + algop->rawsz;
+}
+
 static void set_commit_pos(struct repository *r, const struct object_id *oid)
 {
 	static int32_t max_pos;
@@ -257,7 +263,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 
 	graph_size = xsize_t(st->st_size);
 
-	if (graph_size < GRAPH_MIN_SIZE) {
+	if (graph_size < graph_min_size(the_hash_algo)) {
 		close(fd);
 		error(_("commit-graph file is too small"));
 		return NULL;
@@ -313,7 +319,7 @@ static int graph_read_commit_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
 	struct commit_graph *g = data;
-	if (chunk_size / GRAPH_DATA_WIDTH != g->num_commits)
+	if (chunk_size / graph_data_width(the_hash_algo) != g->num_commits)
 		return error(_("commit-graph commit data chunk is wrong size"));
 	g->chunk_commit_data = chunk_start;
 	return 0;
@@ -378,7 +384,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	if (!graph_map)
 		return NULL;
 
-	if (graph_size < GRAPH_MIN_SIZE)
+	if (graph_size < graph_min_size(the_hash_algo))
 		return NULL;
 
 	data = (const unsigned char *)graph_map;
@@ -900,7 +906,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 		die(_("invalid commit position. commit-graph is likely corrupt"));
 
 	lex_index = pos - g->num_commits_in_base;
-	commit_data = g->chunk_commit_data + st_mult(GRAPH_DATA_WIDTH, lex_index);
+	commit_data = g->chunk_commit_data + st_mult(graph_data_width(the_hash_algo), lex_index);
 
 	graph_data = commit_graph_data_at(item);
 	graph_data->graph_pos = pos;
@@ -1104,7 +1110,8 @@ static struct tree *load_tree_for_commit(struct repository *r,
 		g = g->base_graph;
 
 	commit_data = g->chunk_commit_data +
-			st_mult(GRAPH_DATA_WIDTH, graph_pos - g->num_commits_in_base);
+			st_mult(graph_data_width(the_hash_algo),
+				graph_pos - g->num_commits_in_base);
 
 	oidread(&oid, commit_data, the_repository->hash_algo);
 	set_commit_tree(c, lookup_tree(r, &oid));

-- 
2.51.0.rc0.215.g125493bb4a.dirty

