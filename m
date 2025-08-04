Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA8242909
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295460; cv=none; b=namp/NvgRitBEm442csgQjJaQAvAeXz7TuHE4xDaxeOe5Vj9qHeH7EMQBY1A+Dn4+/XU+9GSUYZt+c9OwXblw0Yc6dVBryKkc6VLmaFLnSYg2IOx1AHkl+Z5+z4FmCvWbeFLUy6oM645nlSelEBwH+E8qKBBv/UWlBbButukqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295460; c=relaxed/simple;
	bh=TyjIsUkrlSf1JraJVv+KSXwKJ0G60Teo/M+z75BNUzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tmxhM7mUDZ5UsAGE2GMJJqEwjsgl6cmkkyKVHAbQyjfeLD+PFF8D7z45Tg42kk4TVPpr26A/wXswLlnK2YxILOONkro26koIW7ybKUZD3pW+P1h0IIQW7usHUHIvS4VY27Y3pSFWWfRyAZbOyTbfYbundWrAX5oVBNHJTa22iRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AUr3Q2zg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VDI96V7g; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AUr3Q2zg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VDI96V7g"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90E407A00CE
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 04:17:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 04 Aug 2025 04:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754295457;
	 x=1754381857; bh=YqbJ+pVo0/QE6twSRKke8expntchIPYZXrm4r/UQEP4=; b=
	AUr3Q2zgEClHvw0lnkb1nd98zSg/tgqhVTLjYtl8G5bDY1YtUIaNYLriTpjKy13a
	8oyo/X91oeYxYuJoX+Epnnjh/0nDhwugJuOEwmKB/dX0LIDlMLp26Q4zpBTMvfA9
	U93++xSPmbsWZQp12pxqmZeuAD66hQx8u3N/lB+6FaAJNoCUr9Y36zVXLXqj1bJW
	CiGA2UMmUjbaiUy99g70NvI7r71Wr8YqfwPNxCrtV/CNjAKfx4/CgCaZbkeC2IHQ
	u28239+NlWUuSqd53eiddyTtTmuKYGMx+HMIjKoSsJw7VwO+dqmHHm/XtXdJ3+dj
	OaD7LxhgaBRRD/dI/fbKqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754295457; x=
	1754381857; bh=YqbJ+pVo0/QE6twSRKke8expntchIPYZXrm4r/UQEP4=; b=V
	DI96V7gAe5+9tlRYlK6E0pcMTefIFT3Q7ygGh627Q1atkxqSQ+86kB2SfBG2WSZU
	7913EowjwieaFwjkT0HkiU9N/KlYTaWNG9+rXZCtnKZ4RDM+B574AUjrdt/bY1Wg
	Z3KEgC9+F/Np2mk3KMMfsPqYzod1dzXW3qXJdJ7jdx+w1nBqCezw7iBiwCfmCPJJ
	oOmr2sc0g6RMSDmu0P9mHfEQ9rtj3u/5LOb0J4tGApHQ+Eqc+P/5AElj6jWZVSU4
	GqyouYVswwGpfB1Jb3YZQto6owTk8iDtMa41eVVHhUrJxK/r9KKUz5kXfq07PCCD
	InoggAVqp7PJ/bkyceI5A==
X-ME-Sender: <xms:oWyQaM2wHQxPHQ0NLt0eazAqu499Nq0F1FgntsDtKd8T7WES1qWQ9Q>
    <xme:oWyQaJHgmhTntIm3c8FENNzAJl0VIV9tSrqkugdXEaJr2KYhPQqWUM0nzljSgC8h5
    TD4xScfYpZ3NPt4DA>
X-ME-Received: <xmr:oWyQaORk1ReuMmHKk3BiJrHEhKrGZRFqyNFnP8WxVC8tZ3qW13PsUFsAHHjtRG9w7sUDnWtXedGK4juy-L2AHDjv0P0wGjBIlL_p6vVQaeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:oWyQaIDC1Tmo25tpXZbQ3wVfkjiDVcNzh0m6eOs1Yq-Db3ZoQJWcBw>
    <xmx:oWyQaG29bbz9XxTHMbyWxFo01Dxb5m59jOpSVSDEYILXgbZJiUSiiA>
    <xmx:oWyQaOWeZAh47RyMEy6VPhrCc6QVEOPSXBCKOpmcr1jJQzwevaOoaA>
    <xmx:oWyQaAkFSeNyglgbnGFcsKNpgDGWY3B5ew2G5OWJzpEmrn3aPDlE5g>
    <xmx:oWyQaG-H9k59VV1EUOakRXUuQMZNd1jDrYco9hjwVeO2FT5pNG8G1_9t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Aug 2025 04:17:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78664a4d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Aug 2025 08:17:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 10:17:21 +0200
Subject: [PATCH 5/9] commit-graph: stop using `the_hash_algo` via macros
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-b4-pks-commit-graph-wo-the-repository-v1-5-850d626eb2e8@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 443177ffd3..3c40f4a470 100644
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
2.50.1.723.g3e08bea96f.dirty

