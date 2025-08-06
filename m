Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0623372C
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754481624; cv=none; b=vCbB5cJ14iJ0C9qK8tYQkC595Wp0jIxeWeoAFISKA6o0aJNTYGpX1bT8oSLJVM9UsIQZgWAQqWRMi2SmBVkU/qU4Gn7mDUlLPSYkixLEBObxJ+0ZJxlB+FidnZvlc4cBrCaD1rEjJsXM1FVKDfousckgit28Ryl+JOB3dc72Glk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754481624; c=relaxed/simple;
	bh=kbAD0FCTV3mW4LHQL8OC4pwYLaBTDVahzMbZ/aw6es4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=NIEe6B7x6xhmw0HX3Pbhs3pWYCk3jbL2hhSH2Kj5axBy2StUqqwM070AiOmocgawvdl+mRP+irZQutzOzWDTHbznkbWiBmXA7eZp51ESK5k7S4FKOxUOkcHNIw3/Iroek10s6WJK7PvhiMz4g4ATGwQAglnNUjAo6PfP5yH40xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QqZuXYb2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eurHhcPQ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QqZuXYb2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eurHhcPQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 615B914000CB;
	Wed,  6 Aug 2025 08:00:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 06 Aug 2025 08:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754481620;
	 x=1754568020; bh=ZgPXqD5KRRicmxAWhMkjhgshIgnbODmhujVgh3UByS8=; b=
	QqZuXYb2dKHTfBwoKqAOLlA+AnkusO3zvOGsTS388iBb8jf0CefgTTJ+2wiqitT7
	vesemZRTrv1Gz0rUjsY5AYmzRD908Q41K8bZk+VHexqNT3z81mZskBiJ/gq4bSmd
	xQS9wTUEVSv2a0J3D5dkeJ/AMsDRrMwehwtU5ZpM10v91Afxv8GV5hOmwa0IpLFq
	Yij+KgBNdT4tAKZDkdySqKf+M+6odVQXp2olOnMsT/xZZlwRf/FDsNuWdajYY28Q
	N45zpmIxVclqNuG7STfZvt+nQWmV9xmQaILPu4yySRzeL20rrkQtliPpZ9HtNL1m
	uUSylexv5NnpEnhyLexlcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754481620; x=
	1754568020; bh=ZgPXqD5KRRicmxAWhMkjhgshIgnbODmhujVgh3UByS8=; b=e
	urHhcPQxKU3I3aCfih7Mu4VZUz1N21s9iH/iQlADtji+X9XyWtI46VIo81Mxu0s8
	oaK189+tXTEi6MldavUYc0yu4XwQbPLiiRt2xpPYybFh91E4qKpTIxHQQM79hwi1
	6jjxIwVTxl2mTOEjlIQdchDZygZfq1/IPWMYYltPcMz150b89tX3fbqFimXM0mNQ
	C64tzFVIfMndaK8SOhS/Civ3dDNPMDbcAXFfnY2qXk7q7Eb77wZ3S0ZArHE4pxCV
	QDU6PLF39INhvTjLyCNFSJS3C8cdgK+r6RkMU5M/gHnSodcDuy6cj0m27KoRsdXt
	cVMRXu3De1pNOtABsEYHg==
X-ME-Sender: <xms:1EOTaMXdaiwiD7HRjnYs0JGAhcAGECQFXMMupGkOsBJaGFdUhXKl_w>
    <xme:1EOTaMH9bdeJ224XpreKRQS1tOWGr1lZhqVrXnm2ZI05QluZCeGIOGBHkfFUte-rj
    MzB_HcKQUBmAwEfPg>
X-ME-Received: <xmr:1EOTaG2bXV1TE_6A9BaNpVekGX10kHHGofZn0quEba7ussnlPvxy4P1X7mSHTz_YRkrPTr1TlpCcF_6I-vaF2C8XTQyy22lAk1mi2Kuxww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhes
    ghhmgidruggv
X-ME-Proxy: <xmx:1EOTaGPYEN5XP6ZhJRxBkwrSWTmA8ib3HwQu6gTvu1pCmr7fKSMZbQ>
    <xmx:1EOTaN5t1QitTIV6RMOIZ3vq0dh_ZfDuAOcInfyNKe99qOpUNtlyuA>
    <xmx:1EOTaI2DdqZeAqlLWq9dnMZreDj3wT-uKe1xPnKWd2CG7w0i9Mgggw>
    <xmx:1EOTaGzyE95lOsc8kEjTGj3j12XMlnjF0KN_uDakg6nb45jWZGxRyg>
    <xmx:1EOTaDB4Va_towUmFMPWAPEIr_GEU3CioDsX57cu8dbG5RNp5_eShJhI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 08:00:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc7c92ea (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 12:00:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/10] commit-graph: remove reliance on global state
Date: Wed, 06 Aug 2025 14:00:05 +0200
Message-Id: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMZDk2gC/42NTQ6CMBCFr0Jm7Zi28tO48h6GBZSRTgy0aRvUE
 O5uwQu4/F7ee98KkQJThGuxQqCFI7s5gzoVYGw3j4Q8ZAYlVCUa2WBfon9GNG6aOOEYOm/x5TB
 ZwkDeRU4ufFAORpnO9EbTBfKXD/Tg9+G5t5ktx713aBe5pz+DFuWfhkWiQF2JoVY19Yr0LY/OP
 EG7bdsXHkQKJNcAAAA=
X-Change-ID: 20250717-b4-pks-commit-graph-wo-the-repository-1dc2cacbc8e3
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series is another step on our long road towards not having
global state. In addition to that, as commit-graphs are part of the
object database layer, this is also another step towards pluggable
object databases.

Changes in v2:
  - Use `unsigned` instead of `size_t` to count number of Bloom filters.
  - Use `uint32_t` instead of `size_t` for number of commit graphs,
    as this type is also used to iterate through this count already.
  - Refactor `parse_commit_graph()` to take a repository instead of both
    repo settings and a hash algo.
  - Link to v1: https://lore.kernel.org/r/20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (10):
      trace2: introduce function to trace unsigned integers
      commit-graph: stop using signed integers to count Bloom filters
      commit-graph: fix type for some write options
      commit-graph: fix sign comparison warnings
      commit-graph: stop using `the_hash_algo` via macros
      commit-graph: store the hash algorithm instead of its length
      commit-graph: refactor `parse_commit_graph()` to take a repository
      commit-graph: stop using `the_hash_algo`
      commit-graph: stop using `the_repository`
      commit-graph: stop passing in redundant repository

 builtin/commit-graph.c       |  13 +-
 builtin/commit.c             |   2 +-
 builtin/merge.c              |   2 +-
 commit-graph.c               | 371 +++++++++++++++++++++----------------------
 commit-graph.h               |  25 ++-
 oss-fuzz/fuzz-commit-graph.c |   6 +-
 t/helper/test-read-graph.c   |   2 +-
 trace2.c                     |  14 ++
 trace2.h                     |   9 ++
 9 files changed, 227 insertions(+), 217 deletions(-)

Range-diff versus v1:

 1:  cb92085a3b =  1:  a25e9cdbcc trace2: introduce function to trace unsigned integers
 2:  25520448c6 !  2:  e03ca21ec2 commit-graph: stop using signed integers to count bloom filters
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    commit-graph: stop using signed integers to count bloom filters
    +    commit-graph: stop using signed integers to count Bloom filters
     
         When writing a new commit graph we have a couple of counters that
    -    provide statistics around what kind of bloom filters we have or have not
    +    provide statistics around what kind of Bloom filters we have or have not
         written. These counters naturally count from zero and are only ever
         incremented, but they use a signed integer as type regardless.
     
    -    Refactor those fields to be of type `size_t` instead.
    +    Refactor those fields to be unsigned instead. Using an unsigned type
    +    makes it explicit to the reader that they never have to worry about
    +    negative values and thus makes the code easier to understand.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ commit-graph.c: struct write_commit_graph_context {
     -	int count_bloom_filter_trunc_empty;
     -	int count_bloom_filter_trunc_large;
     -	int count_bloom_filter_upgraded;
    -+	size_t count_bloom_filter_computed;
    -+	size_t count_bloom_filter_not_computed;
    -+	size_t count_bloom_filter_trunc_empty;
    -+	size_t count_bloom_filter_trunc_large;
    -+	size_t count_bloom_filter_upgraded;
    ++	unsigned count_bloom_filter_computed;
    ++	unsigned count_bloom_filter_not_computed;
    ++	unsigned count_bloom_filter_trunc_empty;
    ++	unsigned count_bloom_filter_trunc_large;
    ++	unsigned count_bloom_filter_upgraded;
      };
      
      static int write_graph_chunk_fanout(struct hashfile *f,
 3:  12e150a326 =  3:  d569434715 commit-graph: fix type for some write options
 4:  0bdaff4e76 !  4:  3f820e3347 commit-graph: fix sign comparison warnings
    @@ Commit message
             quantity, we still return a signed integer that we then later
             compare with unsigned values.
     
    -      - The bloom settings hash version is being assigned `-1` even though
    +      - The Bloom settings hash version is being assigned `-1` even though
             it's an unsigned value. This is used to indicate an unspecified
             value and relies on 1's complement.
     
    @@ commit-graph.c: struct write_commit_graph_context {
      	char *base_graph_name;
     -	int num_commit_graphs_before;
     -	int num_commit_graphs_after;
    -+	size_t num_commit_graphs_before;
    -+	size_t num_commit_graphs_after;
    ++	uint32_t num_commit_graphs_before;
    ++	uint32_t num_commit_graphs_after;
      	char **commit_graph_filenames_before;
      	char **commit_graph_filenames_after;
      	char **commit_graph_hash_after;
 5:  6e5d4da7f1 =  5:  c3be366e36 commit-graph: stop using `the_hash_algo` via macros
 6:  8e8bf531d1 =  6:  2476994769 commit-graph: store the hash algorithm instead of its length
 -:  ---------- >  7:  b582b49437 commit-graph: refactor `parse_commit_graph()` to take a repository
 7:  20bce2f981 !  8:  0d0bd20ceb commit-graph: stop using `the_hash_algo`
    @@ commit-graph.c: struct commit_graph *load_commit_graph_one_fd_st(struct reposito
      		close(fd);
      		error(_("commit-graph file is too small"));
      		return NULL;
    -@@ commit-graph.c: struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
    - 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
    - 	close(fd);
    - 	prepare_repo_settings(r);
    --	ret = parse_commit_graph(&r->settings, graph_map, graph_size);
    -+	ret = parse_commit_graph(&r->settings, r->hash_algo, graph_map, graph_size);
    - 
    - 	if (ret)
    - 		ret->odb_source = source;
     @@ commit-graph.c: static int graph_read_commit_data(const unsigned char *chunk_start,
      				  size_t chunk_size, void *data)
      {
    @@ commit-graph.c: static int graph_read_commit_data(const unsigned char *chunk_sta
      		return error(_("commit-graph commit data chunk is wrong size"));
      	g->chunk_commit_data = chunk_start;
      	return 0;
    -@@ commit-graph.c: static int graph_read_bloom_data(const unsigned char *chunk_start,
    - }
    - 
    - struct commit_graph *parse_commit_graph(struct repo_settings *s,
    -+					const struct git_hash_algo *hash_algo,
    - 					void *graph_map, size_t graph_size)
    - {
    - 	const unsigned char *data;
    -@@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
    - 	if (!graph_map)
    - 		return NULL;
    - 
    --	if (graph_size < graph_min_size(the_hash_algo))
    -+	if (graph_size < graph_min_size(hash_algo))
    - 		return NULL;
    - 
    - 	data = (const unsigned char *)graph_map;
    -@@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
    - 	}
    - 
    - 	hash_version = *(unsigned char*)(data + 5);
    --	if (hash_version != oid_version(the_hash_algo)) {
    -+	if (hash_version != oid_version(hash_algo)) {
    - 		error(_("commit-graph hash version %X does not match version %X"),
    --		      hash_version, oid_version(the_hash_algo));
    -+		      hash_version, oid_version(hash_algo));
    - 		return NULL;
    - 	}
    - 
    - 	graph = alloc_commit_graph();
    - 
    --	graph->hash_algo = the_hash_algo;
    -+	graph->hash_algo = hash_algo;
    - 	graph->num_chunks = *(unsigned char*)(data + 6);
    - 	graph->data = graph_map;
    - 	graph->data_len = graph_size;
    - 
    - 	if (graph_size < GRAPH_HEADER_SIZE +
    - 			 (graph->num_chunks + 1) * CHUNK_TOC_ENTRY_SIZE +
    --			 GRAPH_FANOUT_SIZE + the_hash_algo->rawsz) {
    -+			 GRAPH_FANOUT_SIZE + hash_algo->rawsz) {
    - 		error(_("commit-graph file is too small to hold %u chunks"),
    - 		      graph->num_chunks);
    - 		free(graph);
     @@ commit-graph.c: static int add_graph_to_chain(struct commit_graph *g,
      }
      
    @@ commit-graph.h: struct string_list;
      
      /*
       * Given a commit struct, try to fill the commit struct info, including:
    -@@ commit-graph.h: struct repo_settings;
    -  * prior to calling parse_commit_graph().
    -  */
    - struct commit_graph *parse_commit_graph(struct repo_settings *s,
    -+					const struct git_hash_algo *hash_algo,
    - 					void *graph_map, size_t graph_size);
    - 
    - /*
    -
    - ## oss-fuzz/fuzz-commit-graph.c ##
    -@@
    - #include "repository.h"
    - 
    - struct commit_graph *parse_commit_graph(struct repo_settings *s,
    -+					const struct git_hash_algo *hash_algo,
    - 					void *graph_map, size_t graph_size);
    - 
    - int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
    -@@ oss-fuzz/fuzz-commit-graph.c: int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
    - 	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
    - 	the_repository->settings.commit_graph_generation_version = 2;
    - 	the_repository->settings.commit_graph_changed_paths_version = 1;
    --	g = parse_commit_graph(&the_repository->settings, (void *)data, size);
    -+	g = parse_commit_graph(&the_repository->settings, the_repository->hash_algo,
    -+			       (void *)data, size);
    - 	repo_clear(the_repository);
    - 	free_commit_graph(g);
    - 
 8:  424567998e !  9:  a86c1ab958 commit-graph: stop using `the_repository`
    @@ commit-graph.c: void git_test_write_commit_graph_or_die(void)
      		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
      }
      
    -@@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
    - 	}
    - 
    - 	oidread(&graph->oid, graph->data + graph->data_len - graph->hash_algo->rawsz,
    --		the_repository->hash_algo);
    -+		hash_algo);
    - 
    - 	free_chunkfile(cf);
    - 	return graph;
     @@ commit-graph.c: static int add_graph_to_chain(struct commit_graph *g,
      		if (!cur_g ||
      		    !oideq(&oids[n], &cur_g->oid) ||
 9:  cff4bc0329 ! 10:  70a7f6fecf commit-graph: stop passing in redundant repository
    @@ commit-graph.c: struct commit_graph *load_commit_graph_one_fd_st(struct reposito
      		close(fd);
      		error(_("commit-graph file is too small"));
      		return NULL;
    - 	}
    +@@ commit-graph.c: struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
      	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
      	close(fd);
    --	prepare_repo_settings(r);
    --	ret = parse_commit_graph(&r->settings, r->hash_algo, graph_map, graph_size);
    -+	prepare_repo_settings(source->odb->repo);
    -+	ret = parse_commit_graph(&source->odb->repo->settings, source->odb->repo->hash_algo,
    -+				 graph_map, graph_size);
      
    +-	ret = parse_commit_graph(r, graph_map, graph_size);
    ++	ret = parse_commit_graph(source->odb->repo, graph_map, graph_size);
      	if (ret)
      		ret->odb_source = source;
    -@@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
    + 	else
    +@@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
      	return NULL;
      }
      

---
base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
change-id: 20250717-b4-pks-commit-graph-wo-the-repository-1dc2cacbc8e3

