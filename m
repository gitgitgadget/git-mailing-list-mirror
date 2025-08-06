Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CCD246BBB
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754481644; cv=none; b=eHs1RKI+8iH9fe8xJY0yg1WZaeKtZ/J206vi4QD/GtUlZTCLz5gTGoNPrDm56zhFD2vveDTkFTNFzpY8xsolebqOnTzXeNrL2rHNQrhX39Fgzy32zvvd4wq8+gicbm5065Flf/YcZaztJQEmp/CioNmrhiGpwsaV9VnbUBWm15w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754481644; c=relaxed/simple;
	bh=dujGH3Q2taUpjhtV+USy0byqu+w3sagiHEvko1c7lFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KnGLwz1glJ22uo2eHE7/+hkPa2OlRhvQLBeLDa7MElrbopfOFP9QdfDjgqFYvlIZbI0iom30VUvdVLZQr/zIR/sXjUbqcVnLq5aC1IZHm4Z+bJg6hH33iGEfk9S+TFWmecqbimY7Z882UX0mshQKqZ4+wp9A+j6oD4Gm6RzO6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cRmTK+Yj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h3Aj645A; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cRmTK+Yj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h3Aj645A"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3EA5614000CB;
	Wed,  6 Aug 2025 08:00:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 06 Aug 2025 08:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754481642;
	 x=1754568042; bh=2GHpf6DhfTgoYy8CS8mQNy9IBSAF6eBidv+mg0P2bQ4=; b=
	cRmTK+YjPUh3Fg2BAbqUSorCCM3gqAo+eDt5LvaPHCCeuSXDCyxjVAar6N97bnHC
	LyD49+HTLFh/gn4wYHu9MOKFP4bFxzVzZRPnTm65WAg89Ix6VCZMkNzbeB8HZBYU
	IKKANjB7mkzCwXHw9b/yMsG+b5JZUysUJZiykiyD4Z89grHcruj/JWGcDELzWQ46
	KnRwHPxSpA1HJzhIbApZj1wd+U57iaU/a53TCIxUtgwtNlEKxl/RQy+Za7b/QFxk
	FdX10BkJi5Urg7V/FDR4IjnKIPsgHXDwqGzGVAAhiYVCzkvYJZrkoiK6DRhfE2we
	KRtlzNnSfsAt2/vdC6fD9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754481642; x=
	1754568042; bh=2GHpf6DhfTgoYy8CS8mQNy9IBSAF6eBidv+mg0P2bQ4=; b=h
	3Aj645AVN5JzX2SmgNwYJa9H1CjT1yt10O7Ww+CdPDkWIzFy2GPudFDj17kWUOXC
	GsIi4WRWR+7yFosGuIS3RbEgxnrEaX98nYQ/4UaSBOJGN09kzZ/pxFdX9Gk1PzsL
	m640bnZGucTQ0zbGhCKCpKW2a289TOxA72wFNH6QATUWFBrXWj+4qCKApwt2Jlny
	9pxBu3iY978R4dbBG4M+W5yl9afS07DJDfrFfvySZMXrNgH+wOW3Y8G9BESX4eTd
	qYp2kfw5tWsyZ3lTnh/AiNOiDgobAZnAS9MBcQLpuq1U44k6hqUeWLCePYI0uVbs
	uJdcaNmGRe60MlbDh3KmQ==
X-ME-Sender: <xms:6kOTaLvvaY7rmFqVuJeAaYDsnMdWm8QAJCcoKA4LLLnDuqx35VsJqg>
    <xme:6kOTaH-n8502wx82ubk-53m-nRmJkLCfNYhbtwS2lyS9nk4Vt-6HJpvgJc-iGYcLx
    U-BThtNyCKe56LrIg>
X-ME-Received: <xmr:6kOTaFOV7znVKlR99-_FvXvWmDYilFE1HDjOhAUFSAio3PWAP5ImmW4QaawEHJ6v4i47VdSOCbTjZ-oYM6RaBx2cffHlzNdC6NhofqeSVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6kOTaFHjxMIUKge0C9sFKePovrclC7rtlDRX10YEIfeZaqeJtekrsg>
    <xmx:6kOTaDTpt6LcQhato0UC1HQkJcw04WWmtWIOYJysnAiqEo0pOhlg1A>
    <xmx:6kOTaCtL_O0zzWZwNae4mFjH0Jqs1irQmseBTZwVj8KBg-DEFd7O2A>
    <xmx:6kOTaLLkCY0BhHWVL4KaA4dwgTzZQ3mAkxfGWDNNEpP9OpuEc7Nbxw>
    <xmx:6kOTaN5usygELAfW45t69EKC_Th7sVoS_rCdqg1w230kL0IfW92171Ql>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 08:00:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e3202a21 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 12:00:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 14:00:12 +0200
Subject: [PATCH v2 07/10] commit-graph: refactor `parse_commit_graph()` to
 take a repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-b4-pks-commit-graph-wo-the-repository-v2-7-911bae638e61@pks.im>
References: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
In-Reply-To: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
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
index 590a6972d2a..50391cc0f32 100644
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
index f20d28ff3a0..5a5c876af0b 100644
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

