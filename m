Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732128A40F
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754481655; cv=none; b=gN+LQd5cTvPBzhFM7cy3255EBaZi3gfpLFeBnyPHBtaEAZBdmqVCDZjgtFj/hVmtycQJo0cazmksQVl96LYEDxcbbZcbxXm9/oe/skdxMBOIp1ZEMuPX4bVyOSnNalxZsHOvoT9y4jlaEG9Fw5Hjy+c1sHMlRMpLxLbrmP59oRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754481655; c=relaxed/simple;
	bh=PXcEOrZpUUdCmgwHZsh3QkJNxP1xGPkh/I5TgAREvnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFFkiy07/+5a3fH0QyNqPO0f1eeIsFn0Jt6Q4rR64Iwk5mto00hZH2OBJgyXZ1i2vGArVyuPybhgJu5zRifMU+g7HTczOd4q/kc1UeRaE9wPoUwYnyYc2xdTBbqSbxZ0TAL0lS+j4uimHMLGzUdNMBlQnn2vJZZNM5c1zGwed5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IIdqGuiH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aKB555J7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IIdqGuiH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aKB555J7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2301714000E4;
	Wed,  6 Aug 2025 08:00:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 06 Aug 2025 08:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754481652;
	 x=1754568052; bh=TihVhYmo9qie2jrDOeEIE2W+G/n9rH9lRMK6Fx1Lx+w=; b=
	IIdqGuiHxuyDmNt2zTSFHVEhWqIEUOMJy/KbUoE2DXpArXrf8xy5GzQVUtuim1Wq
	/t4rD4iEqL4HoRtLggJl3RBKKbeykF1ma/vPlMMkWec6nz8OOpA65QNVlcSrIhHF
	GCrA1mksp7nUO4uaTLHBW25bwUT5rAL0ivPwBTbbNN11YaAAgF6WNccakAhU8roh
	XcBDnkLdB+niGDBiLDGu70q1HzhBsTXOn1jQZYxOv+eJ2SzEjIOY3vmmURB5PAla
	6ed04sAmMjWh4dQAESc4TU/Sk1EhtXj4l0jdGEfm0DS9oevmwGnwyzB9yarv1zwW
	chNEvbrMn0TqXQjuyr2S4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754481652; x=
	1754568052; bh=TihVhYmo9qie2jrDOeEIE2W+G/n9rH9lRMK6Fx1Lx+w=; b=a
	KB555J72KcrxLRjA5O9kfgAndaYsbnXMq2YTOFxZMbw0Q7s8viqS5OEKmbAe32Z8
	ALq1abH0B3iTn/bmVojigZfUWRGby/gBRPBTMDSEEJuWNSA8r7ctlTzRSasy+/Fs
	UGDAKVFFSAOJOqqxuM1s660PolKZZP2G4wAIIsaZJmR16kQpaaGNdPl+N17lSbz6
	xwYWlT1rdyRInnBWzjrKWyvF1VcSEf9IeeOFUlDsKXJAxSyvHT1VUC61SoYBWYfb
	cs5pSYePElyOW8Hoeb/7N1wseXTkS8WhZdn5NNxNwbKWyWUxXWeUI6kE67oOaBz7
	YSozULVho4wNxsOWj6Vgw==
X-ME-Sender: <xms:80OTaGOTxDj0NIMudd3MpFh7e1wYYJ4LrG8x3I8JZy1Gooy9WBzjcg>
    <xme:80OTaAdGdCROyhPlnxEF7p3c1X_GhbLsxSMoj1tj3JjYaDMraM38t28AqRxGnTQM9
    foglU18oo8nw7oDDw>
X-ME-Received: <xmr:80OTaDtFgSJjnRS9y7iqgA-GOC5EFgKkYtv1lkD9Mje3s2htrzgrVlhgzRs3C8_8lCGuvjufe3QdujOwp80gKxGm8TPcSYOd0EJ6n648ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:80OTaBk5twYA0BDF23mHpUKf1gMRrWF3zdxl7z_jayOD9ULOTk9rCw>
    <xmx:80OTaFwfWM6IN9eV8JLV7A4EHgTQQjDctSOTu8pqCh9NBD-KrZb-3g>
    <xmx:80OTaDNKuw7s6NqdBONdPVOrn4L0Bt2dzKAHUmjMbIw1tLXBVjQcZA>
    <xmx:80OTaBqr3SLWI1Gu3KKwW49o9E8W-Hcdcws3gAsqwdMJqUYUYcrcqQ>
    <xmx:9EOTaGt9WFn50HlREw6ESIqYyilSHkz3CZjeHu6_gTUfjMNAORoZu1K->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 08:00:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b861592 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 12:00:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 14:00:15 +0200
Subject: [PATCH v2 10/10] commit-graph: stop passing in redundant
 repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-b4-pks-commit-graph-wo-the-repository-v2-10-911bae638e61@pks.im>
References: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
In-Reply-To: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
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
index 680b03a83a..1b80993b2d 100644
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
index 35143c356c..e2e70ea4f6 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -250,9 +250,8 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
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
@@ -260,7 +259,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 
 	graph_size = xsize_t(st->st_size);
 
-	if (graph_size < graph_min_size(r->hash_algo)) {
+	if (graph_size < graph_min_size(source->odb->repo->hash_algo)) {
 		close(fd);
 		error(_("commit-graph file is too small"));
 		return NULL;
@@ -268,7 +267,7 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	ret = parse_commit_graph(r, graph_map, graph_size);
+	ret = parse_commit_graph(source->odb->repo, graph_map, graph_size);
 	if (ret)
 		ret->odb_source = source;
 	else
@@ -488,11 +487,9 @@ struct commit_graph *parse_commit_graph(struct repository *r,
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
@@ -501,19 +498,17 @@ static struct commit_graph *load_commit_graph_one(struct repository *r,
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
@@ -640,7 +635,7 @@ int open_commit_graph_chain(const char *chain_file,
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
+struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 						   int fd, struct stat *st,
 						   int *incomplete_chain)
 {
@@ -651,10 +646,10 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	FILE *fp = xfdopen(fd, "r");
 	size_t count;
 
-	count = st->st_size / (r->hash_algo->hexsz + 1);
+	count = st->st_size / (odb->repo->hash_algo->hexsz + 1);
 	CALLOC_ARRAY(oids, count);
 
-	odb_prepare_alternates(r->objects);
+	odb_prepare_alternates(odb);
 
 	for (size_t i = 0; i < count; i++) {
 		struct odb_source *source;
@@ -662,7 +657,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 		if (strbuf_getline_lf(&line, fp) == EOF)
 			break;
 
-		if (get_oid_hex_algop(line.buf, &oids[i], r->hash_algo)) {
+		if (get_oid_hex_algop(line.buf, &oids[i], odb->repo->hash_algo)) {
 			warning(_("invalid commit-graph chain: line '%s' not a hash"),
 				line.buf);
 			valid = 0;
@@ -670,9 +665,9 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 		}
 
 		valid = 0;
-		for (source = r->objects->sources; source; source = source->next) {
+		for (source = odb->sources; source; source = source->next) {
 			char *graph_name = get_split_graph_filename(source, line.buf);
-			struct commit_graph *g = load_commit_graph_one(r, graph_name, source);
+			struct commit_graph *g = load_commit_graph_one(source, graph_name);
 
 			free(graph_name);
 
@@ -705,45 +700,33 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
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
@@ -784,10 +767,12 @@ static int prepare_commit_graph(struct repository *r)
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
 
@@ -872,8 +857,7 @@ static void load_oid_from_graph(struct commit_graph *g,
 		g->hash_algo);
 }
 
-static struct commit_list **insert_parent_or_die(struct repository *r,
-						 struct commit_graph *g,
+static struct commit_list **insert_parent_or_die(struct commit_graph *g,
 						 uint32_t pos,
 						 struct commit_list **pptr)
 {
@@ -884,7 +868,7 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 		die("invalid parent position %"PRIu32, pos);
 
 	load_oid_from_graph(g, pos, &oid);
-	c = lookup_commit(r, &oid);
+	c = lookup_commit(g->odb_source->odb->repo, &oid);
 	if (!c)
 		die(_("could not find commit %s"), oid_to_hex(&oid));
 	commit_graph_data_at(c)->graph_pos = pos;
@@ -940,8 +924,7 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
 	c->maybe_tree = t;
 }
 
-static int fill_commit_in_graph(struct repository *r,
-				struct commit *item,
+static int fill_commit_in_graph(struct commit *item,
 				struct commit_graph *g, uint32_t pos)
 {
 	uint32_t edge_value;
@@ -967,13 +950,13 @@ static int fill_commit_in_graph(struct repository *r,
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
 
@@ -988,7 +971,7 @@ static int fill_commit_in_graph(struct repository *r,
 		}
 		edge_value = get_be32(g->chunk_extra_edges +
 				      sizeof(uint32_t) * parent_data_pos);
-		pptr = insert_parent_or_die(r, g,
+		pptr = insert_parent_or_die(g,
 					    edge_value & GRAPH_EDGE_LAST_MASK,
 					    pptr);
 		parent_data_pos++;
@@ -1054,14 +1037,13 @@ struct commit *lookup_commit_in_graph(struct repository *repo, const struct obje
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
@@ -1070,7 +1052,7 @@ static int parse_commit_in_graph_one(struct repository *r,
 		return 1;
 
 	if (find_commit_pos_in_graph(item, g, &pos))
-		return fill_commit_in_graph(r, item, g, pos);
+		return fill_commit_in_graph(item, g, pos);
 
 	return 0;
 }
@@ -1087,7 +1069,7 @@ int parse_commit_in_graph(struct repository *r, struct commit *item)
 
 	if (!prepare_commit_graph(r))
 		return 0;
-	return parse_commit_in_graph_one(r, r->objects->commit_graph, item);
+	return parse_commit_in_graph_one(r->objects->commit_graph, item);
 }
 
 void load_commit_graph_info(struct repository *r, struct commit *item)
@@ -1097,8 +1079,7 @@ void load_commit_graph_info(struct repository *r, struct commit *item)
 		fill_commit_graph_info(item, r->objects->commit_graph, pos);
 }
 
-static struct tree *load_tree_for_commit(struct repository *r,
-					 struct commit_graph *g,
+static struct tree *load_tree_for_commit(struct commit_graph *g,
 					 struct commit *c)
 {
 	struct object_id oid;
@@ -1113,13 +1094,12 @@ static struct tree *load_tree_for_commit(struct repository *r,
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
@@ -1127,12 +1107,12 @@ static struct tree *get_commit_tree_in_graph_one(struct repository *r,
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
@@ -2738,11 +2718,11 @@ static int commit_graph_checksum_valid(struct commit_graph *g)
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
@@ -2776,7 +2756,7 @@ static int verify_one_commit_graph(struct repository *r,
 		}
 
 		graph_commit = lookup_commit(r, &cur_oid);
-		if (!parse_commit_in_graph_one(r, g, graph_commit))
+		if (!parse_commit_in_graph_one(g, graph_commit))
 			graph_report(_("failed to parse commit %s from commit-graph"),
 				     oid_to_hex(&cur_oid));
 	}
@@ -2812,7 +2792,7 @@ static int verify_one_commit_graph(struct repository *r,
 			continue;
 		}
 
-		if (!oideq(&get_commit_tree_in_graph_one(r, g, graph_commit)->object.oid,
+		if (!oideq(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
 			   get_commit_tree_oid(odb_commit)))
 			graph_report(_("root tree OID for commit %s in commit-graph is %s != %s"),
 				     oid_to_hex(&cur_oid),
@@ -2830,7 +2810,7 @@ static int verify_one_commit_graph(struct repository *r,
 			}
 
 			/* parse parent in case it is in a base graph */
-			parse_commit_in_graph_one(r, g, graph_parents->item);
+			parse_commit_in_graph_one(g, graph_parents->item);
 
 			if (!oideq(&graph_parents->item->object.oid, &odb_parents->item->object.oid))
 				graph_report(_("commit-graph parent for %s is %s != %s"),
@@ -2890,7 +2870,7 @@ static int verify_one_commit_graph(struct repository *r,
 	return verify_commit_graph_error;
 }
 
-int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
+int verify_commit_graph(struct commit_graph *g, int flags)
 {
 	struct progress *progress = NULL;
 	int local_error = 0;
@@ -2906,13 +2886,13 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
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
index a2471e9bdc..ad0bce5ed1 100644
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
2.51.0.rc0.215.g125493bb4a.dirty

