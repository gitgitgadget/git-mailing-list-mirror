Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918A241673
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754481639; cv=none; b=b7RJTq4WhD8h6CnwoyYzkZPIUHZmg1mfzwKbAhN6pECxSMj3/g7NjzzVh+vXZeOF0ttksyq50itjpIFbq7b9/fO11FSzXINGQH7U2wUDeg2BgxSNGOR+Ljc+oBfgoW/iz7P0wA0slA+BP24C5TOZAbDD7gsisaWhhU1sq9TdcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754481639; c=relaxed/simple;
	bh=3V0QO5R16h2NPpJJ7JUL4xuuBsmnRdrMKas8zUUsHWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i9F1gF+zhn1z/OWy6i6GTXOxQeODmAwbJ27aEDAtUIAy/ITvNQQwVbfBrwykWGDH6YOplmvfoZMTCpIBSrMUnd9VH2YKrokPJzDf01/fbADNO4ekT2peNB9aU3aGS+zs8Z0F9iv7msuzp5uANfwVxNQifdyTahNilXV/9+HdsIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GFjnS+wb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dWoS/Yvh; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GFjnS+wb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dWoS/Yvh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C6A0C14000C9;
	Wed,  6 Aug 2025 08:00:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 06 Aug 2025 08:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754481635;
	 x=1754568035; bh=dmTK6Z8/50IEpsXHZxxqW5ZggF856pbNyuyAQ72i6ZE=; b=
	GFjnS+wbsn/yuzDGtfF01H+CxN7vV0aIqt5EE4behNCymgdBR8d1g3LsxwtjR54l
	OtQxgCjvGklb/MNaiSaVP4E+mhyxmQVaUYkz4qyrRfniLzi8NQxp5raEjafDbg9V
	mPlF8sovXOz9Ok4mLE72UDxbTFpzWa/XS3/38IVTQYzk2tlWVjBvfOOckCxX+1Q9
	gzzXux+YwnDSI792e+O3tslH/w7fgfGCcwDgcCbGy6CMUCmqg0Qy91IdMUd6VzPS
	4n32TH4JSvNv/Pam/aExds5OoVyAj9Kq5b1yGoZ7WCmwBVk7MgBMqwjgnco/NRNG
	N5rzyHwNuXP3YVYwK/l4eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754481635; x=
	1754568035; bh=dmTK6Z8/50IEpsXHZxxqW5ZggF856pbNyuyAQ72i6ZE=; b=d
	WoS/YvhxJevpk/0iKfEieMog/Vm9Z9lU8RkRISiMhcQOs2tnAQixozk1ypXwb19z
	k1UDjLGFkrJ3xgK5UUoDktN34EJHpvhMrXlfVGwylUzTSZDV9ZvVPROdaw5d251r
	A13d0kP6w1boh94gHjCspes7r/qFKJFDUgy77v4ocqoMuHY2zuPwG9zIBOX+UCl4
	Yg9ZVI6W1mrFB7hGOHxV06x7LIB2ScB3CgrT8jeDCxsiKIEHshagmE1OI8Lm4bhG
	Rk+Vr9xJfJSX6GLXYaLWSo2Rlq7s12Oi8yrsbM4vKOFX8bROVnc6x1LxBvBPJ41W
	HXHnKn2kDtaKjbEQF1Zow==
X-ME-Sender: <xms:40OTaF2UET48x8cgKTmdLQluTvVpuc1UIZaFxpNY64nwA97aEeECkQ>
    <xme:40OTaHlMlkeyyVsMytaBdCCIYiUqEiWOJRtn2MGGRcCZw10B1sRTdlrU8PlK3dP-L
    eGeyIBVodBDAe8Qhw>
X-ME-Received: <xmr:40OTaMVv4HYXSgl7uEqoHDqZS91ynIDMwhhFAoVTV1B2qx8wC2vEN-aeLkJLwQiSbKeMwYc4aq_ISlqclN-MaL7ZwrTQ4s632CCbf98iHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgr
    ghgvnhesghhmgidruggvpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:40OTaNtRrFaXdFO8LXPd8omPlfCT2XbM5uqe05khztyKGvZhrX6nBw>
    <xmx:40OTaPb1yRwi8KOdjF7bQd8aeV4raoXMR65JOWe-5uadmnD6Xcj7pw>
    <xmx:40OTaMUF-h2wtTk2fFHfrBUJSfdDmMwjcaT3TtHcRkSBrgqEUD1rPg>
    <xmx:40OTaES0sIOGg4QVEcDMy7LFdvKwVP9aBZmU34MFqPZvuTeEvPP-hw>
    <xmx:40OTaKgYBGiE2OGIi_1xLKC0K5nMPfoh9yXzdO-7BzrIbaMCWCTleT4D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 08:00:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f3f7f28e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 12:00:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 14:00:10 +0200
Subject: [PATCH v2 05/10] commit-graph: stop using `the_hash_algo` via
 macros
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-b4-pks-commit-graph-wo-the-repository-v2-5-911bae638e61@pks.im>
References: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
In-Reply-To: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
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
index 6d5b5444e7..c4a0b12b6c 100644
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

