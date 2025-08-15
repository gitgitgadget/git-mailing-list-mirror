Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701EC1C5499
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236999; cv=none; b=Zgc6wZ21DRqExlWDcDUWfnibyIAxW7LcrPJbhaKoLKfySEjxNDi2mnIwaPz8vep8sms1p+lTBbp3vZjp4zqwEU9Z8kl9zAM1Gm6xMvJQHkVOSNeYYu3Qe0IuxJvHBpqTO81RZn8xu70O5wIL5j1DoWVlVnvgDzF74lCAgF384jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236999; c=relaxed/simple;
	bh=eRczSYUxGyQLSU17eGVEJWXL/Gxk7ltZDoI6Lv2vFTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QAxhHy5PiowH4Q2FErPLBYr1ja8faJOZi6Ejz2koId8v0hvGPHyC3BYToiwwe7yVlUlS/ZaSeK4xa0YkfoyD+exOnqXK5MpR2q7wj18RxN23mSpzd+rD2TFgKuauwE7GYM+2o0Th5mF5w9S57WuSgnxyArrv2QCLoXirhIOg7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RrS1F9gI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BJhbaVA8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RrS1F9gI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BJhbaVA8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 611DD14000DE;
	Fri, 15 Aug 2025 01:49:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 15 Aug 2025 01:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755236996;
	 x=1755323396; bh=bk40cW4RgzfuOSaMiJbsdLkIKoom5qe73tnBhgy+FiE=; b=
	RrS1F9gIFc8990+FNNOEsnr0Hnt90vmFcL95iwr28QlNqfLFaKvSEcKbMhoVxo4Z
	8gQvcqutMeVY0JWVVR1etn/AaxFdwv9vuSUhlCH+x6QmjXY5A3LHGc451Vz5uL1H
	qdX/igpEIHlDvhNK/DAxTJb84I3qhKtKAy0pwreDgaH+vwuCZb6CBxi9yF4TuHQe
	L3PNrcJooVjjywvy1BuMPP6UPvCBWiq4I6hiKpPcNFO7ZTqYNUfEgrOPteomKuje
	Jy0s6ZSP7hwsdEv4WhaWyRrfbQHNTDLhvXgz784wzkO0MbffmeMpYa6TiMqV0PnR
	+hrPli/9NXJtqvJ+r5WwPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755236996; x=
	1755323396; bh=bk40cW4RgzfuOSaMiJbsdLkIKoom5qe73tnBhgy+FiE=; b=B
	JhbaVA8UCxcLxW0+O1cKcXO0aW0rI2qIGbIrIaOwTWOwwsFr6SpUEVepKeVk3KLg
	cMzxpw8JGfX7NravxrhMwFsaVOmNW1qoUXVCtdWNdh2BFXLXosRlwxIMSXc7MA4t
	8AEydCYOB/qiFgkpIVI5RVOQOb/1aASUZyFeQGcL0B6ktQ2fVyTLfNAsxN9o8bOV
	QGA6uwMvZm6zCj8HJIFSfXYJlP3KZxIp7ZTgvFeuu6MrWvFw6LJsdu5D8ywh+P8Q
	XJ+BcUCuCOqJfLpPOpq58BZDbaVuiiBaf49qhjq+VYcBI+JoZqZ0wrK9r1GcQLKU
	Cjfa+hxBA2qihBSm1lfKw==
X-ME-Sender: <xms:hMqeaDOgIWgTo1vAikMlrRuEYvEJ4_soooBrVPI5Vv3CM7aSEf9HMQ>
    <xme:hMqeaJeaVRjz2uYKyxByHmBSDx3FrY76XPgNqOKRDk379L7ejojcOdWssFp2doAPs
    SyDlLwgy_ffDXF4og>
X-ME-Received: <xmr:hMqeaIumK0B95Rmd5ru2u4p4WzBasS0LQQmwDpgyffRSKg9djrapeccwJ6oWUY3jzRhIwo-ctJ1nEtNCBZS9tV8JAHJvp0Z5B_FXH7YzFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepohhsfigrlhgurdgsuh
    guuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hMqeaCmIcNFGSp0kBl8gspOVg0RyA6EdyiytV3BzxzsYARfd2kwyQQ>
    <xmx:hMqeaCwpB1_xiiY_jTJH_5aQkVGXn69cE9X8pwg7PlMSXtRtAPHWdQ>
    <xmx:hMqeaMNX01cx1urUOT6Z5QHjH4GTphVyKPf8JQepP0qEBD7LY4dRKg>
    <xmx:hMqeaGrRCj9Kf-Z4sV_tLcFTcPGF2visg9lgRPLJaT44k0L_ymQtFA>
    <xmx:hMqeaLYGldIz3SHiok2sG8IUhoYr0giZDYapikKDAfGiZMPMCKdxG4RV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 01:49:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8735027f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 15 Aug 2025 05:49:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Aug 2025 07:49:47 +0200
Subject: [PATCH v4 1/6] commit-graph: stop using `the_hash_algo` via macros
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-b4-pks-commit-graph-wo-the-repository-v4-1-b6b651178cce@pks.im>
References: <20250815-b4-pks-commit-graph-wo-the-repository-v4-0-b6b651178cce@pks.im>
In-Reply-To: <20250815-b4-pks-commit-graph-wo-the-repository-v4-0-b6b651178cce@pks.im>
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
index bd7b6f5338..ecd50ea3ff 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -53,8 +53,6 @@ void git_test_write_commit_graph_or_die(void)
 #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
 
-#define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
-
 #define GRAPH_VERSION_1 0x1
 #define GRAPH_VERSION GRAPH_VERSION_1
 
@@ -66,8 +64,6 @@ void git_test_write_commit_graph_or_die(void)
 
 #define GRAPH_HEADER_SIZE 8
 #define GRAPH_FANOUT_SIZE (4 * 256)
-#define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * CHUNK_TOC_ENTRY_SIZE \
-			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
 
 #define CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW (1ULL << 31)
 
@@ -80,6 +76,16 @@ define_commit_slab(topo_level_slab, uint32_t);
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
@@ -258,7 +264,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 
 	graph_size = xsize_t(st->st_size);
 
-	if (graph_size < GRAPH_MIN_SIZE) {
+	if (graph_size < graph_min_size(the_hash_algo)) {
 		close(fd);
 		error(_("commit-graph file is too small"));
 		return NULL;
@@ -314,7 +320,7 @@ static int graph_read_commit_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
 	struct commit_graph *g = data;
-	if (chunk_size / GRAPH_DATA_WIDTH != g->num_commits)
+	if (chunk_size / graph_data_width(the_hash_algo) != g->num_commits)
 		return error(_("commit-graph commit data chunk is wrong size"));
 	g->chunk_commit_data = chunk_start;
 	return 0;
@@ -379,7 +385,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
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
2.51.0.rc1.215.g0f929dcec7.dirty

