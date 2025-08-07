Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF6F255F53
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553914; cv=none; b=SiP8Vx8vHGigVfWT0Jm3J+ca/EwnMoQmlMPcUIZwpUUwvxLNtmMipVuVZT1IhFrwFKONcmxQgUitcl1tQpwFgrDjZhxHOuoUqBI7OLit0/KTiwYJX87e/K2H4Y2Ae77F5Y9iyebv5NYqyZ3XPb1H+SRKgA4vWx/RBoO0I8NDpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553914; c=relaxed/simple;
	bh=dxZFpGScxylRAwYmlSQHDHl6MAmhCjSz28tfh9KPLPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VSUrw/QlKKEOuELrcW4DqbgtANFpeKRrwPtNzlh0GwL0L0pAtrP4Iimv3bX4Nr9+jdWjVwVm+SyrIax9G3fzI7ENcPngwh6O53zi47ztIfd4AAredfHOT33aQp8SyLsONP0MhMixOMJfd2YOdiK8412UEWy9AMmG7VVJhMEPEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EaHLhSPx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nP7fvz1E; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EaHLhSPx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nP7fvz1E"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 566C214000BA;
	Thu,  7 Aug 2025 04:05:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 07 Aug 2025 04:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754553912;
	 x=1754640312; bh=tUj9CZam8KuFlOercbeJpTu5t03ar4MyzAKk2e0pzb4=; b=
	EaHLhSPxywmZZe3Pgz2bz3R4yUd3KgcXL41ihrT3/xVB+BQAJyrcQSpFpLE8G+/0
	jF4rn9pvxdj4O/7Bycafl/LRXo0vSFH+vpLvAIjgNF5VaARVLG82tk+gZupP0LSb
	xsrBOGg+Q0f8GPZaXqe3Ng2dE0gmP0ogRp44p+TRXM6K/MTRwWyvqmLreliOZ74Y
	wfCPMqbnYk9TUFCnAD0IKt4qKJKhgOr8dihumW6JkkacIfeUBynccYb1PcnJJDiE
	EuP2Ga+kWglQtczrM1Mvf2KX2bkNgzTjRBRaucO4lMgozGOXebs2ABsXiGFIE2UQ
	t/9cOGOsfi1p4ip+aTh9dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754553912; x=
	1754640312; bh=tUj9CZam8KuFlOercbeJpTu5t03ar4MyzAKk2e0pzb4=; b=n
	P7fvz1EyllBxtONUaY0p5vE3W8/A+w2pobCX/XYFF1YyRtbuJljnq4rB5PQjcsvS
	JnExeL2quJqPahIEPxIdcHNqIaMqKkfwAUwrYBLz6X+axLIvejEDZyOYGCsGHKjb
	re9ZlDZxuwUfe4cOl7swl8EyRl619lmehlVzuB2mnm1lu/Qnl71iQDw2x5fTSG9q
	B3oOhsZSzFNDsUeL2/HU/X1tXEOLPO09kN7+Edoz+wgGy/H8rmyAhTbh/dWeVz9T
	2G0MMhZydaAUrhCxN/nGsLIO5sN9ayXaSygMAaOsLwyvcfstBfD1Lch8dhiEY59V
	o7lU2uk8UHtmRnLuhIOwQ==
X-ME-Sender: <xms:OF6UaMglEb9WkpD-vulkE4MJTsxah8F-xdFZ_DcIK5yNMEiCvUhEXg>
    <xme:OF6UaAhZsaltssO46Zsxl0j9gjUxjk2HcVVmGEJ6kL1bNIkRj7fvzRNWj0W6rnq92
    5JT7cw2NKjxjMjmyw>
X-ME-Received: <xmr:OF6UaKhCgR9eHeOiErEJi5dW-piTBa3_7m4n5S_b-6jgzRZ0EOQ_Uzgfka3CW8Fpo6xc6x0lbjwKWeHqTUufbLX71Wby66a6q9Yf-ATrYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprh
    gtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OF6UaIIO4uOdCsX4bvotq3eqLmPUsTKMcXrdsA64h4Gw-D5NGsHfag>
    <xmx:OF6UaBFTHUD4lHKDlmh42x9eiQE7e8YiyxfmMiiYUIwE7K28kR1Srg>
    <xmx:OF6UaETsAk0bhqxR99VJgBI8aI9D8jkH-67XrPHWJJ5u_gRl3AK-uQ>
    <xmx:OF6UaFfypCjh4Srr_oJUEMKl4XG02ItZsdNGy0XbvF_SnnY-DjRWAQ>
    <xmx:OF6UaC_hvSIOo7OtGi4fsosGQ2p5kKD6jljqlnIZd-L9KR22CjOyIlxk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:05:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aee264ab (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:05:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:04:49 +0200
Subject: [PATCH v3 07/10] commit-graph: refactor `parse_commit_graph()` to
 take a repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-commit-graph-wo-the-repository-v3-7-82edef830a1e@pks.im>
References: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
In-Reply-To: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Refactor `parse_commit_graph()` so that it takes a repository instead of
taking repository settings. On the one hand this allows us to get rid of
instances where we access `the_hash_algo` by using the repository's hash
algorithm instead. On the other hand it also allows us to move the call
of `prepare_repo_settings()` into the function itself.

Note that there's one small catch, as the commit-graph fuzzer calls this
function directly without having a fully functional repository at hand.
And while the fuzzer already initializes `the_repository` with relevant
info, the call to `prepare_repo_settings()` would fail because we don't
have a fully-initialized repository.

Work around the issue by also settings `settings.initialized` to pretend
that we've already read the settings.

While at it, remove the redundant `parse_commit_graph()` declaration in
the fuzzer. It was added together with aa658574bf (commit-graph, fuzz:
add fuzzer for commit-graph, 2019-01-15), but as we also declared the
same function in "commit-graph.h" it wasn't ever needed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c               | 23 ++++++++++++-----------
 commit-graph.h               |  2 +-
 oss-fuzz/fuzz-commit-graph.c |  6 ++----
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 430eab0b869..77b785a5e05 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -270,9 +270,8 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	prepare_repo_settings(r);
-	ret = parse_commit_graph(&r->settings, graph_map, graph_size);
 
+	ret = parse_commit_graph(r, graph_map, graph_size);
 	if (ret)
 		ret->odb_source = source;
 	else
@@ -372,7 +371,7 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 	return 0;
 }
 
-struct commit_graph *parse_commit_graph(struct repo_settings *s,
+struct commit_graph *parse_commit_graph(struct repository *r,
 					void *graph_map, size_t graph_size)
 {
 	const unsigned char *data;
@@ -384,7 +383,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	if (!graph_map)
 		return NULL;
 
-	if (graph_size < graph_min_size(the_hash_algo))
+	if (graph_size < graph_min_size(r->hash_algo))
 		return NULL;
 
 	data = (const unsigned char *)graph_map;
@@ -404,22 +403,22 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	hash_version = *(unsigned char*)(data + 5);
-	if (hash_version != oid_version(the_hash_algo)) {
+	if (hash_version != oid_version(r->hash_algo)) {
 		error(_("commit-graph hash version %X does not match version %X"),
-		      hash_version, oid_version(the_hash_algo));
+		      hash_version, oid_version(r->hash_algo));
 		return NULL;
 	}
 
 	graph = alloc_commit_graph();
 
-	graph->hash_algo = the_hash_algo;
+	graph->hash_algo = r->hash_algo;
 	graph->num_chunks = *(unsigned char*)(data + 6);
 	graph->data = graph_map;
 	graph->data_len = graph_size;
 
 	if (graph_size < GRAPH_HEADER_SIZE +
 			 (graph->num_chunks + 1) * CHUNK_TOC_ENTRY_SIZE +
-			 GRAPH_FANOUT_SIZE + the_hash_algo->rawsz) {
+			 GRAPH_FANOUT_SIZE + r->hash_algo->rawsz) {
 		error(_("commit-graph file is too small to hold %u chunks"),
 		      graph->num_chunks);
 		free(graph);
@@ -450,7 +449,9 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs,
 		   &graph->chunk_base_graphs_size);
 
-	if (s->commit_graph_generation_version >= 2) {
+	prepare_repo_settings(r);
+
+	if (r->settings.commit_graph_generation_version >= 2) {
 		read_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
 			   graph_read_generation_data, graph);
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
@@ -461,7 +462,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 			graph->read_generation_data = 1;
 	}
 
-	if (s->commit_graph_changed_paths_version) {
+	if (r->settings.commit_graph_changed_paths_version) {
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   graph_read_bloom_index, graph);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
@@ -478,7 +479,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_algo->rawsz,
-		the_repository->hash_algo);
+		r->hash_algo);
 
 	free_chunkfile(cf);
 	return graph;
diff --git a/commit-graph.h b/commit-graph.h
index 2228c714cb1..4879643db0f 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -128,7 +128,7 @@ struct repo_settings;
  * Callers should initialize the repo_settings with prepare_repo_settings()
  * prior to calling parse_commit_graph().
  */
-struct commit_graph *parse_commit_graph(struct repo_settings *s,
+struct commit_graph *parse_commit_graph(struct repository *r,
 					void *graph_map, size_t graph_size);
 
 /*
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index fbb77fec197..fb8b8787a46 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -4,9 +4,6 @@
 #include "commit-graph.h"
 #include "repository.h"
 
-struct commit_graph *parse_commit_graph(struct repo_settings *s,
-					void *graph_map, size_t graph_size);
-
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
@@ -22,9 +19,10 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 	 * possible.
 	 */
 	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+	the_repository->settings.initialized = 1;
 	the_repository->settings.commit_graph_generation_version = 2;
 	the_repository->settings.commit_graph_changed_paths_version = 1;
-	g = parse_commit_graph(&the_repository->settings, (void *)data, size);
+	g = parse_commit_graph(the_repository, (void *)data, size);
 	repo_clear(the_repository);
 	free_commit_graph(g);
 

-- 
2.51.0.rc0.215.g125493bb4a.dirty

