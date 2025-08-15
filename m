Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DBA220F2F
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 05:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755237014; cv=none; b=c5zYWaxry+abjQfzztqwAWPsT9LimQ7nWNmBHsD6Kd8akUQb631GkRSzf4HojaL+2tZaLyjgCftQDBvgCuDAs3bNTmbm3Xl0h9Bv9P4H3QEm1T86RyomjVAIduJrP/FWbd2ht2RoxM8szvAFprf7SPdFuupZ9incF1i7SV70evw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755237014; c=relaxed/simple;
	bh=UpPivi2DbU9qKx9Zfm+ZvYtaV1MC2MXtNhVP8tYZ3Zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lr8UlDiv0qQONzP/opKnc3bosnR5YuTgVunEVBsVginuvxBeCmWvOXCozR9AbSqI0P0kvXO0RcH+qVnnoe/CK2/KkHIpGmqWayPcEOUS4PlwmDPni7NIB+74Va6fWItOai8lKw5ZBC32TyGzyycOG1Yeo0nvIeNoI888Grl8/3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LyTkDKt4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GrPmJaPP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LyTkDKt4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GrPmJaPP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B9F214000DA;
	Fri, 15 Aug 2025 01:50:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 15 Aug 2025 01:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755237011;
	 x=1755323411; bh=ZnirKI/ZRP5LA4nW1l0JSMmOwktbEF89sbduoHQtfZg=; b=
	LyTkDKt4JAd12O96I2iu/LACxDqm+IRe9AgMtzE+e5dGLs8hkm/gc3L/3xTke9Oj
	fEgGD9plXptPedH/dwPIzyW1xOLVC+tgO9V6mfY8vHAqYqk6frM0c2ZbhsB5GBrk
	KEggUcHntssKNFvYMMRcKxGJmI4k4EE+/3eNaJv7eZ29ucu+YRmTYSkzWxVYyd3A
	Lp0OKmV5zr6n6xpYjpWdDfplzi39CzpbfgkqbpZ/aOvBZAD8s+mrmKPm4XmjkI8r
	hRxsL2KHCp7bVDaLxnw2rVn3nFULSn4KqiiyQ/3n+GKYrMe5hO/wAx1R/MBJdbDb
	JEa2kJrIL1vqVe3zV7n+Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755237011; x=
	1755323411; bh=ZnirKI/ZRP5LA4nW1l0JSMmOwktbEF89sbduoHQtfZg=; b=G
	rPmJaPPKpoT7GPx1q9IEOPqLyx1BNYglGHlsTflecH8ifSj0EolvxbXnAkIuoJW+
	IhEp/hlwQLpK78mQaKrc8Z6O9O3rURakvSNl7hiKyj5fypM0Ox8YUm1xh9SWFa1L
	slQhI4XrJvV9GGiCfXx399Kpe1A90vlu2Mg0UmCU1zlJAyhOPHL5h9xkd/NtSb1k
	eUDMPbZLuQnS1iIO7mhr9FOUMjHe/TaArmB3aoK5uv5ZW48jF7dd51qxZ8xj1W7b
	pAYQu7kxBehLTW74VywlLrJUWEVy50lf0CgHdoF5GlATgdDWgY/1NWOPBWiVL8Kg
	4O95ww0ifB79j/bMPHBAg==
X-ME-Sender: <xms:k8qeaEyqCfo8TiJKOcxz8zzF2BIywQ4MnC5SZIrcZqQZvZ1D_4eltA>
    <xme:k8qeaDxdQK5ROx3b7jLhU2GhRZw81Hx-0qTMmTFxXo01AmwiK5z6-GqJ21TXvsGEs
    _yO64hO_t8WI5Iokw>
X-ME-Received: <xmr:k8qeaMzEHIYVxH-DhH8GCXncWdS8l1-qMNKhD9ehJwD1JbSrTD28BnM7OK1oLXquZ7sKwbh7GA6k0r2oeipW2lFvfVkMrMK7e4ePlr82sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprh
    gtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:k8qeaNbPNHw8kZWeWoB2ukQq81hgW5hKoR1pmBjdi0QsAL6s9SoNYw>
    <xmx:k8qeaNUbe4byL1RQS82RfcCpUeEEkfu9sIXhI5vuThFw40-2T-7kvw>
    <xmx:k8qeaLh_AZL0skbSMl89C_IV7wyuaI_I-97pI8f8OCDRkScPfG3ndQ>
    <xmx:k8qeaLvyc8hC8eM8VJRpD0Xt700OZBhi6qKXDVlV0_-pEGtN9YjKKg>
    <xmx:k8qeaAPh73X4ZkbgVfmuuH2WXRS50YFDGOQLjTQKRAkgY6kTldgA7Ggf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 01:50:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd3103cf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 15 Aug 2025 05:50:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Aug 2025 07:49:52 +0200
Subject: [PATCH v4 6/6] commit-graph: stop passing in redundant repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-b4-pks-commit-graph-wo-the-repository-v4-6-b6b651178cce@pks.im>
References: <20250815-b4-pks-commit-graph-wo-the-repository-v4-0-b6b651178cce@pks.im>
In-Reply-To: <20250815-b4-pks-commit-graph-wo-the-repository-v4-0-b6b651178cce@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Many of the commit-graph related functions take in both a repository and
the object database source (directly or via `struct commit_graph`) for
which we are supposed to load such a commit-graph. In the best case this
information is simply redundant as the source already contains a
reference to its owning object database, which in turn has a reference
to its repository. In the worst case this information could even
mismatch when passing in a source that doesn't belong to the same
repository.

Refactor the code so that we only pass in the object database source in
those cases.

There is one exception though, namely `load_commit_graph_chain_fd_st()`,
which is responsible for loading a commit-graph chain. It is expected
that parts of the commit-graph chain aren't located in the same object
source as the chain file itself, but in a different one. Consequently,
this function doesn't work on the source level but on the database level
instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c     |   6 +--
 commit-graph.c             | 120 +++++++++++++++++++--------------------------
 commit-graph.h             |  12 ++---
 t/helper/test-read-graph.c |   2 +-
 4 files changed, 59 insertions(+), 81 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index fa6dd34d8d..dbeaeeaed3 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -121,15 +121,15 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 	if (opened == OPENED_NONE)
 		return 0;
 	else if (opened == OPENED_GRAPH)
-		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, source);
+		graph = load_commit_graph_one_fd_st(source, fd, &st);
 	else
-		graph = load_commit_graph_chain_fd_st(the_repository, fd, &st,
+		graph = load_commit_graph_chain_fd_st(the_repository->objects, fd, &st,
 						      &incomplete_chain);
 
 	if (!graph)
 		return 1;
 
-	ret = verify_commit_graph(the_repository, graph, flags);
+	ret = verify_commit_graph(graph, flags);
 	free_commit_graph(graph);
 
 	if (incomplete_chain) {
diff --git a/commit-graph.c b/commit-graph.c
index 180b826239..5aaaa9715a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -252,9 +252,8 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
-						 int fd, struct stat *st,
-						 struct odb_source *source)
+struct commit_graph *load_commit_graph_one_fd_st(struct odb_source *source,
+						 int fd, struct stat *st)
 {
 	void *graph_map;
 	size_t graph_size;
@@ -262,7 +261,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 
 	graph_size = xsize_t(st->st_size);
 
-	if (graph_size < graph_min_size(r->hash_algo)) {
+	if (graph_size < graph_min_size(source->odb->repo->hash_algo)) {
 		close(fd);
 		error(_("commit-graph file is too small"));
 		return NULL;
@@ -270,7 +269,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	ret = parse_commit_graph(r, graph_map, graph_size);
+	ret = parse_commit_graph(source->odb->repo, graph_map, graph_size);
 	if (ret)
 		ret->odb_source = source;
 	else
@@ -490,11 +489,9 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 	return NULL;
 }
 
-static struct commit_graph *load_commit_graph_one(struct repository *r,
-						  const char *graph_file,
-						  struct odb_source *source)
+static struct commit_graph *load_commit_graph_one(struct odb_source *source,
+						  const char *graph_file)
 {
-
 	struct stat st;
 	int fd;
 	struct commit_graph *g;
@@ -503,19 +500,17 @@ static struct commit_graph *load_commit_graph_one(struct repository *r,
 	if (!open_ok)
 		return NULL;
 
-	g = load_commit_graph_one_fd_st(r, fd, &st, source);
-
+	g = load_commit_graph_one_fd_st(source, fd, &st);
 	if (g)
 		g->filename = xstrdup(graph_file);
 
 	return g;
 }
 
-static struct commit_graph *load_commit_graph_v1(struct repository *r,
-						 struct odb_source *source)
+static struct commit_graph *load_commit_graph_v1(struct odb_source *source)
 {
 	char *graph_name = get_commit_graph_filename(source);
-	struct commit_graph *g = load_commit_graph_one(r, graph_name, source);
+	struct commit_graph *g = load_commit_graph_one(source, graph_name);
 	free(graph_name);
 
 	return g;
@@ -642,7 +637,7 @@ int open_commit_graph_chain(const char *chain_file,
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
+struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 						   int fd, struct stat *st,
 						   int *incomplete_chain)
 {
@@ -652,10 +647,10 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	int i = 0, valid = 1, count;
 	FILE *fp = xfdopen(fd, "r");
 
-	count = st->st_size / (r->hash_algo->hexsz + 1);
+	count = st->st_size / (odb->repo->hash_algo->hexsz + 1);
 	CALLOC_ARRAY(oids, count);
 
-	odb_prepare_alternates(r->objects);
+	odb_prepare_alternates(odb);
 
 	for (i = 0; i < count; i++) {
 		struct odb_source *source;
@@ -663,7 +658,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 		if (strbuf_getline_lf(&line, fp) == EOF)
 			break;
 
-		if (get_oid_hex_algop(line.buf, &oids[i], r->hash_algo)) {
+		if (get_oid_hex_algop(line.buf, &oids[i], odb->repo->hash_algo)) {
 			warning(_("invalid commit-graph chain: line '%s' not a hash"),
 				line.buf);
 			valid = 0;
@@ -671,9 +666,9 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 		}
 
 		valid = 0;
-		for (source = r->objects->sources; source; source = source->next) {
+		for (source = odb->sources; source; source = source->next) {
 			char *graph_name = get_split_graph_filename(source, line.buf);
-			struct commit_graph *g = load_commit_graph_one(r, graph_name, source);
+			struct commit_graph *g = load_commit_graph_one(source, graph_name);
 
 			free(graph_name);
 
@@ -706,45 +701,33 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	return graph_chain;
 }
 
-static struct commit_graph *load_commit_graph_chain(struct repository *r,
-						    struct odb_source *source)
+static struct commit_graph *load_commit_graph_chain(struct odb_source *source)
 {
 	char *chain_file = get_commit_graph_chain_filename(source);
 	struct stat st;
 	int fd;
 	struct commit_graph *g = NULL;
 
-	if (open_commit_graph_chain(chain_file, &fd, &st, r->hash_algo)) {
+	if (open_commit_graph_chain(chain_file, &fd, &st, source->odb->repo->hash_algo)) {
 		int incomplete;
 		/* ownership of fd is taken over by load function */
-		g = load_commit_graph_chain_fd_st(r, fd, &st, &incomplete);
+		g = load_commit_graph_chain_fd_st(source->odb, fd, &st, &incomplete);
 	}
 
 	free(chain_file);
 	return g;
 }
 
-struct commit_graph *read_commit_graph_one(struct repository *r,
-					   struct odb_source *source)
+struct commit_graph *read_commit_graph_one(struct odb_source *source)
 {
-	struct commit_graph *g = load_commit_graph_v1(r, source);
+	struct commit_graph *g = load_commit_graph_v1(source);
 
 	if (!g)
-		g = load_commit_graph_chain(r, source);
+		g = load_commit_graph_chain(source);
 
 	return g;
 }
 
-static void prepare_commit_graph_one(struct repository *r,
-				     struct odb_source *source)
-{
-
-	if (r->objects->commit_graph)
-		return;
-
-	r->objects->commit_graph = read_commit_graph_one(r, source);
-}
-
 /*
  * Return 1 if commit_graph is non-NULL, and 0 otherwise.
  *
@@ -785,10 +768,12 @@ static int prepare_commit_graph(struct repository *r)
 		return 0;
 
 	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources;
-	     !r->objects->commit_graph && source;
-	     source = source->next)
-		prepare_commit_graph_one(r, source);
+	for (source = r->objects->sources; source; source = source->next) {
+		r->objects->commit_graph = read_commit_graph_one(source);
+		if (r->objects->commit_graph)
+			break;
+	}
+
 	return !!r->objects->commit_graph;
 }
 
@@ -873,8 +858,7 @@ static void load_oid_from_graph(struct commit_graph *g,
 		g->hash_algo);
 }
 
-static struct commit_list **insert_parent_or_die(struct repository *r,
-						 struct commit_graph *g,
+static struct commit_list **insert_parent_or_die(struct commit_graph *g,
 						 uint32_t pos,
 						 struct commit_list **pptr)
 {
@@ -885,7 +869,7 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 		die("invalid parent position %"PRIu32, pos);
 
 	load_oid_from_graph(g, pos, &oid);
-	c = lookup_commit(r, &oid);
+	c = lookup_commit(g->odb_source->odb->repo, &oid);
 	if (!c)
 		die(_("could not find commit %s"), oid_to_hex(&oid));
 	commit_graph_data_at(c)->graph_pos = pos;
@@ -941,8 +925,7 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
 	c->maybe_tree = t;
 }
 
-static int fill_commit_in_graph(struct repository *r,
-				struct commit *item,
+static int fill_commit_in_graph(struct commit *item,
 				struct commit_graph *g, uint32_t pos)
 {
 	uint32_t edge_value;
@@ -968,13 +951,13 @@ static int fill_commit_in_graph(struct repository *r,
 	edge_value = get_be32(commit_data + g->hash_algo->rawsz);
 	if (edge_value == GRAPH_PARENT_NONE)
 		return 1;
-	pptr = insert_parent_or_die(r, g, edge_value, pptr);
+	pptr = insert_parent_or_die(g, edge_value, pptr);
 
 	edge_value = get_be32(commit_data + g->hash_algo->rawsz + 4);
 	if (edge_value == GRAPH_PARENT_NONE)
 		return 1;
 	if (!(edge_value & GRAPH_EXTRA_EDGES_NEEDED)) {
-		pptr = insert_parent_or_die(r, g, edge_value, pptr);
+		pptr = insert_parent_or_die(g, edge_value, pptr);
 		return 1;
 	}
 
@@ -989,7 +972,7 @@ static int fill_commit_in_graph(struct repository *r,
 		}
 		edge_value = get_be32(g->chunk_extra_edges +
 				      sizeof(uint32_t) * parent_data_pos);
-		pptr = insert_parent_or_die(r, g,
+		pptr = insert_parent_or_die(g,
 					    edge_value & GRAPH_EDGE_LAST_MASK,
 					    pptr);
 		parent_data_pos++;
@@ -1055,14 +1038,13 @@ struct commit *lookup_commit_in_graph(struct repository *repo, const struct obje
 	if (commit->object.parsed)
 		return commit;
 
-	if (!fill_commit_in_graph(repo, commit, repo->objects->commit_graph, pos))
+	if (!fill_commit_in_graph(commit, repo->objects->commit_graph, pos))
 		return NULL;
 
 	return commit;
 }
 
-static int parse_commit_in_graph_one(struct repository *r,
-				     struct commit_graph *g,
+static int parse_commit_in_graph_one(struct commit_graph *g,
 				     struct commit *item)
 {
 	uint32_t pos;
@@ -1071,7 +1053,7 @@ static int parse_commit_in_graph_one(struct repository *r,
 		return 1;
 
 	if (find_commit_pos_in_graph(item, g, &pos))
-		return fill_commit_in_graph(r, item, g, pos);
+		return fill_commit_in_graph(item, g, pos);
 
 	return 0;
 }
@@ -1088,7 +1070,7 @@ int parse_commit_in_graph(struct repository *r, struct commit *item)
 
 	if (!prepare_commit_graph(r))
 		return 0;
-	return parse_commit_in_graph_one(r, r->objects->commit_graph, item);
+	return parse_commit_in_graph_one(r->objects->commit_graph, item);
 }
 
 void load_commit_graph_info(struct repository *r, struct commit *item)
@@ -1098,8 +1080,7 @@ void load_commit_graph_info(struct repository *r, struct commit *item)
 		fill_commit_graph_info(item, r->objects->commit_graph, pos);
 }
 
-static struct tree *load_tree_for_commit(struct repository *r,
-					 struct commit_graph *g,
+static struct tree *load_tree_for_commit(struct commit_graph *g,
 					 struct commit *c)
 {
 	struct object_id oid;
@@ -1114,13 +1095,12 @@ static struct tree *load_tree_for_commit(struct repository *r,
 				graph_pos - g->num_commits_in_base);
 
 	oidread(&oid, commit_data, g->hash_algo);
-	set_commit_tree(c, lookup_tree(r, &oid));
+	set_commit_tree(c, lookup_tree(g->odb_source->odb->repo, &oid));
 
 	return c->maybe_tree;
 }
 
-static struct tree *get_commit_tree_in_graph_one(struct repository *r,
-						 struct commit_graph *g,
+static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
 						 const struct commit *c)
 {
 	if (c->maybe_tree)
@@ -1128,12 +1108,12 @@ static struct tree *get_commit_tree_in_graph_one(struct repository *r,
 	if (commit_graph_position(c) == COMMIT_NOT_FROM_GRAPH)
 		BUG("get_commit_tree_in_graph_one called from non-commit-graph commit");
 
-	return load_tree_for_commit(r, g, (struct commit *)c);
+	return load_tree_for_commit(g, (struct commit *)c);
 }
 
 struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit *c)
 {
-	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
+	return get_commit_tree_in_graph_one(r->objects->commit_graph, c);
 }
 
 struct packed_commit_list {
@@ -2740,11 +2720,11 @@ static int commit_graph_checksum_valid(struct commit_graph *g)
 				       g->data, g->data_len);
 }
 
-static int verify_one_commit_graph(struct repository *r,
-				   struct commit_graph *g,
+static int verify_one_commit_graph(struct commit_graph *g,
 				   struct progress *progress,
 				   uint64_t *seen)
 {
+	struct repository *r = g->odb_source->odb->repo;
 	uint32_t i, cur_fanout_pos = 0;
 	struct object_id prev_oid, cur_oid;
 	struct commit *seen_gen_zero = NULL;
@@ -2778,7 +2758,7 @@ static int verify_one_commit_graph(struct repository *r,
 		}
 
 		graph_commit = lookup_commit(r, &cur_oid);
-		if (!parse_commit_in_graph_one(r, g, graph_commit))
+		if (!parse_commit_in_graph_one(g, graph_commit))
 			graph_report(_("failed to parse commit %s from commit-graph"),
 				     oid_to_hex(&cur_oid));
 	}
@@ -2814,7 +2794,7 @@ static int verify_one_commit_graph(struct repository *r,
 			continue;
 		}
 
-		if (!oideq(&get_commit_tree_in_graph_one(r, g, graph_commit)->object.oid,
+		if (!oideq(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
 			   get_commit_tree_oid(odb_commit)))
 			graph_report(_("root tree OID for commit %s in commit-graph is %s != %s"),
 				     oid_to_hex(&cur_oid),
@@ -2832,7 +2812,7 @@ static int verify_one_commit_graph(struct repository *r,
 			}
 
 			/* parse parent in case it is in a base graph */
-			parse_commit_in_graph_one(r, g, graph_parents->item);
+			parse_commit_in_graph_one(g, graph_parents->item);
 
 			if (!oideq(&graph_parents->item->object.oid, &odb_parents->item->object.oid))
 				graph_report(_("commit-graph parent for %s is %s != %s"),
@@ -2892,7 +2872,7 @@ static int verify_one_commit_graph(struct repository *r,
 	return verify_commit_graph_error;
 }
 
-int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
+int verify_commit_graph(struct commit_graph *g, int flags)
 {
 	struct progress *progress = NULL;
 	int local_error = 0;
@@ -2908,13 +2888,13 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		if (!(flags & COMMIT_GRAPH_VERIFY_SHALLOW))
 			total += g->num_commits_in_base;
 
-		progress = start_progress(r,
+		progress = start_progress(g->odb_source->odb->repo,
 					  _("Verifying commits in commit graph"),
 					  total);
 	}
 
 	for (; g; g = g->base_graph) {
-		local_error |= verify_one_commit_graph(r, g, progress, &seen);
+		local_error |= verify_one_commit_graph(g, progress, &seen);
 		if (flags & COMMIT_GRAPH_VERIFY_SHALLOW)
 			break;
 	}
diff --git a/commit-graph.h b/commit-graph.h
index 0a67ac9280..4899b54ef8 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -114,14 +114,12 @@ struct commit_graph {
 	struct bloom_filter_settings *bloom_filter_settings;
 };
 
-struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
-						 int fd, struct stat *st,
-						 struct odb_source *source);
-struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
+struct commit_graph *load_commit_graph_one_fd_st(struct odb_source *source,
+						 int fd, struct stat *st);
+struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 						   int fd, struct stat *st,
 						   int *incomplete_chain);
-struct commit_graph *read_commit_graph_one(struct repository *r,
-					   struct odb_source *source);
+struct commit_graph *read_commit_graph_one(struct odb_source *source);
 
 struct repo_settings;
 
@@ -185,7 +183,7 @@ int write_commit_graph(struct odb_source *source,
 
 #define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)
 
-int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags);
+int verify_commit_graph(struct commit_graph *g, int flags);
 
 void close_commit_graph(struct object_database *);
 void free_commit_graph(struct commit_graph *);
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index ef5339bbee..6a5f64e473 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -81,7 +81,7 @@ int cmd__read_graph(int argc, const char **argv)
 
 	prepare_repo_settings(the_repository);
 
-	graph = read_commit_graph_one(the_repository, source);
+	graph = read_commit_graph_one(source);
 	if (!graph) {
 		ret = 1;
 		goto done;

-- 
2.51.0.rc1.215.g0f929dcec7.dirty

