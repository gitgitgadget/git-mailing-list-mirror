Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282524C676
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771485524; cv=none; b=hR84IoN3MEuRRt9G033ylU/cFICFSgLX0gkWHijj/OimyVFhPWRg+ZYV/vDRmEa+9WKKL01+ePE3/BLngr10ze1cO14w4Vsehvm+cWoqHscq/ahuhMf9Peva2CyIf8eYuXosQkknpmTbbeNsTvQxT+SOTetLMh3z3rqSbwxowPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771485524; c=relaxed/simple;
	bh=56S7IhhQ2cFUewB/l+j/5kL61kc1fxqO4vfmHl1bLSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUoRbnflC5FuylRTwWQJx/gTQHLdoKArXhBdtVsYr7z5abBLcs6bCrxpxcGIlvrOVDc7hPyrQWXV6UiFYmisZ5rH5Zld2NZ7+sMpvJ4YMqChqXvlSSeMcHBED9mSJr+qQyrbHplp5dA2QLRe5TI2E418hHxbXuvKJTQSP0e8DtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S1eJPnmw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IJ9sUdN8; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S1eJPnmw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IJ9sUdN8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54043140012C;
	Thu, 19 Feb 2026 02:18:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Feb 2026 02:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771485521; x=1771571921; bh=Ltyc7Uzmsh
	wNvvcn6DtNcdTiJD2Qig3/zwnOpLkV5Lk=; b=S1eJPnmwghREA0UXk+7RqeHU0x
	xdSmrQkOHlYJ3beCqBZZVOqW/P//BupEVLvbJTxBOEi+b32rPTw0Ab79mBW3BXNR
	0yQmfu9vFwVosKX337m9TH+nFsbY9ic2L0bkJ9YMsh708JLsT5QPoauMJq3la7UZ
	C19aA6t2Wj/auCM1pfLZBxVhxrmXO/Z7x6l9TbMEV+sWuN25RSBfkdD+RO0DO5rc
	tAdC3zR+s18OvAFiXq7t5wAyM1gODFSiD1knr229u8/vrh6wJre40CNzAH+YK7El
	gSoCguumxNQtKSXVS35TOFJqcs40wofmZNSvVzzjLCax5gtpFalYW5gjJpGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771485521; x=1771571921; bh=Ltyc7UzmshwNvvcn6DtNcdTiJD2Qig3/zwn
	OpLkV5Lk=; b=IJ9sUdN8VhOMEcPdOdjS49JzGS/ouf4XPTAzxBuHHlsiYJ+JNCM
	wGuIUTVIkYiO9ZUblrLEz8OKDe1+WRCezPncPgJcMtjajB0WhSvsmIGxb30WL3C9
	iUMdx5e93yobh8w1jsk54GHGBc/Pt7oskP93+H1qhMUf3FFsAJwup7hEELPiG2WA
	e+NvrzEQbEK1DFjUM/93is7xe9UYvOlDlmDiHqFiuzIZAbxCOqXZfd+0oYs5JgbZ
	AhoYLw1rOa3YvfoAoyhU9FJYJeyFTyh5OdjbD/ddI+SKavj5iX+nG9UKeumIHbT+
	h5k5A0b98v3w8VPOJkzfCTD6Kv/KaMz4Zbw==
X-ME-Sender: <xms:UbmWafnNbVEdDTXXbt0scWTWpe6jJhNI6HiUK8i_eLEVUiE7ghQDKA>
    <xme:UbmWaaRgLNSIljeLyIcLkkpYMCUqEUX2yzpUxThBnngVzNphjNBp86IPJPliFy2tL
    YiVsMBTsw29z10x1bS5aRqvguQ-2OVX5KlBxFcy_PGnYNgj2U8i>
X-ME-Received: <xmr:UbmWaTCGZrk0rs7HR5-oB2evFlre_x_nACFXkX2UwDw7E0q18XPT5E9_yqKFKQ4j82nbHivBgZ6FwcKN0rNgRl--L4ZUbMDdd0uEXzwVww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhsmhhilhgvhi
    esghhithhlrggsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:UbmWaRTGQEpwEQadQ_uezSyh7FG16cz3wtAu5QM_znNhw2H0xMXXyQ>
    <xmx:UbmWaRrKWyxxSuFDF-x7q4cwMX_VS6LJcafDRjnVRntwh7YakMgXXA>
    <xmx:UbmWaTzqMUEm4Nxx96fzLGhzrKNnEpBWJhl4GSpMOC-gT5vUah1JrQ>
    <xmx:UbmWaWKt1f-94wn0C96nQpieiiR8ESDzhp4A2rpDV_y1z6hj8CDHtw>
    <xmx:UbmWad_IBrS8cKAvc9exZzLqw8jNzQRZXM1nyjALljWpeLlcucD5IbOG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 02:18:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9c45515a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 07:18:37 +0000 (UTC)
Date: Thu, 19 Feb 2026 08:18:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>
Subject: Re: [PATCH 2/3] commit: make `repo_parse_commit_no_graph()` more
 robust
Message-ID: <aZa5Sxw1-6uZc7C0@pks.im>
References: <20260216-b4-pks-receive-pack-optimize-shallow-v1-0-e98886daff2b@pks.im>
 <20260216-b4-pks-receive-pack-optimize-shallow-v1-2-e98886daff2b@pks.im>
 <aZYJyT3QZ2lJrkL-@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZYJyT3QZ2lJrkL-@denethor>

On Wed, Feb 18, 2026 at 01:23:47PM -0600, Justin Tobler wrote:
> On 26/02/16 04:38PM, Patrick Steinhardt wrote:
> > Make the code more robust by extending `repo_parse_commit_no_graph()` to
> > unparse a commit first in case we detect it's coming from a graph. This
> > ensures that we will re-read the object without it, and thus we will
> > populate `maybe_tree` properly.
> 
> Hmm, I wonder if this is conceptually the correct place to address this
> problem. Naively, I would expect `repo_get_commit_tree()` to always be
> capable of providing the commit tree. I guess the problem though is that
> this would require `repo_get_commit_tree()` to detect this scenario and
> reparse the object itself. Maybe we could at least have
> `repo_get_commit_tree()` BUG() in this scenario though?

I was wondering myself whether we should make `repo_get_commit_tree()`
more robust instead. But I shy away from just calling BUG() because a
bunch of callers are prepared to handle a `NULL` return value, even
though many others aren't.

The alternative would be parse the commit via the ODB in case we see
that the commit is not from a graph. We cannot unparse the object here
though as that would potentially invalidate for example the list of
parents. So we'd have to refactor the code base a bit so that we can
parse the tree object.

But there's also another problem: we cannot expect the commit or tree to
even exist at all due to partial clones, and the question is what we
should do in this case. Should we fetch the missing objects in case
we're asked to get the tree? Maybe, but I guess it depends on the
context of the caller.

Overall this becomes complex pretty fast, unfortunately. I've attached a
naive implementation of the above, but as mentioned it fails in some
tests related to partial clones.

Patrick

--- >8 ---

diff --git a/archive.c b/archive.c
index fcd474c682..974f318f6d 100644
--- a/archive.c
+++ b/archive.c
@@ -49,7 +49,7 @@ void init_archivers(void)
 	init_zip_archiver();
 }
 
-static void format_subst(const struct commit *commit,
+static void format_subst(struct commit *commit,
 			 const char *src, size_t len,
 			 struct strbuf *buf, struct pretty_print_context *ctx)
 {
@@ -90,7 +90,7 @@ static void *object_file_to_archive(const struct archiver_args *args,
 				    unsigned long *sizep)
 {
 	void *buffer;
-	const struct commit *commit = args->convert ? args->commit : NULL;
+	struct commit *commit = args->convert ? args->commit : NULL;
 	struct checkout_metadata meta;
 
 	init_checkout_metadata(&meta, args->refname,
@@ -489,7 +489,7 @@ static void parse_treeish_arg(const char **argv,
 	const struct object_id *commit_oid;
 	time_t archive_time;
 	struct tree *tree;
-	const struct commit *commit;
+	struct commit *commit;
 	struct object_id oid;
 	char *ref = NULL;
 
diff --git a/archive.h b/archive.h
index bbe65ba0f9..0d0f064ffa 100644
--- a/archive.h
+++ b/archive.h
@@ -15,7 +15,7 @@ struct archiver_args {
 	size_t baselen;
 	struct tree *tree;
 	const struct object_id *commit_oid;
-	const struct commit *commit;
+	struct commit *commit;
 	const char *mtime_option;
 	timestamp_t time;
 	struct pathspec pathspec;
diff --git a/commit-graph.c b/commit-graph.c
index 1fcceb3920..45a9b486a7 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2774,7 +2774,7 @@ static int verify_one_commit_graph(struct commit_graph *g,
 
 		graph_commit = lookup_commit(r, &cur_oid);
 		odb_commit = (struct commit *)create_object(r, &cur_oid, alloc_commit_node(r));
-		if (repo_parse_commit_internal(r, odb_commit, 0, 0)) {
+		if (repo_parse_commit_no_graph(r, odb_commit)) {
 			graph_report(_("failed to parse commit %s from object database for commit-graph"),
 				     oid_to_hex(&cur_oid));
 			continue;
diff --git a/commit.c b/commit.c
index b7c4ec2eb5..03a2ddfb78 100644
--- a/commit.c
+++ b/commit.c
@@ -435,24 +435,6 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
 	c->maybe_tree = t;
 }
 
-struct tree *repo_get_commit_tree(struct repository *r,
-				  const struct commit *commit)
-{
-	if (commit->maybe_tree || !commit->object.parsed)
-		return commit->maybe_tree;
-
-	if (commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
-		return get_commit_tree_in_graph(r, commit);
-
-	return NULL;
-}
-
-struct object_id *get_commit_tree_oid(const struct commit *commit)
-{
-	struct tree *tree = repo_get_commit_tree(the_repository, commit);
-	return tree ? &tree->object.oid : NULL;
-}
-
 void release_commit_memory(struct parsed_object_pool *pool, struct commit *c)
 {
 	set_commit_tree(c, NULL);
@@ -483,6 +465,34 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
+static int parse_commit_tree(struct repository *r, struct commit *item,
+			     const char *buffer, unsigned long size,
+			     const char **out)
+{
+	const int tree_entry_len = the_hash_algo->hexsz + 5;
+	const char *tail = buffer + size;
+	struct object_id tree_oid;
+	struct tree *tree;
+
+	if (tail <= buffer + tree_entry_len + 1 || memcmp(buffer, "tree ", 5) ||
+			buffer[tree_entry_len] != '\n')
+		return error("bogus commit object %s", oid_to_hex(&item->object.oid));
+	if (get_oid_hex(buffer + 5, &tree_oid) < 0)
+		return error("bad tree pointer in commit %s",
+			     oid_to_hex(&item->object.oid));
+
+	tree = lookup_tree(r, &tree_oid);
+	if (!tree)
+		return error("bad tree pointer %s in commit %s",
+			     oid_to_hex(&tree_oid),
+			     oid_to_hex(&item->object.oid));
+	set_commit_tree(item, tree);
+
+	if (out)
+		*out = buffer + tree_entry_len + 1;
+	return 0;
+}
+
 int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size, int check_graph)
 {
 	const char *tail = buffer;
@@ -490,9 +500,8 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	struct object_id parent;
 	struct commit_list **pptr;
 	struct commit_graft *graft;
-	const int tree_entry_len = the_hash_algo->hexsz + 5;
 	const int parent_entry_len = the_hash_algo->hexsz + 7;
-	struct tree *tree;
+	int ret;
 
 	if (item->object.parsed)
 		return 0;
@@ -506,19 +515,11 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	item->parents = NULL;
 
 	tail += size;
-	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
-			bufptr[tree_entry_len] != '\n')
-		return error("bogus commit object %s", oid_to_hex(&item->object.oid));
-	if (get_oid_hex(bufptr + 5, &parent) < 0)
-		return error("bad tree pointer in commit %s",
-			     oid_to_hex(&item->object.oid));
-	tree = lookup_tree(r, &parent);
-	if (!tree)
-		return error("bad tree pointer %s in commit %s",
-			     oid_to_hex(&parent),
-			     oid_to_hex(&item->object.oid));
-	set_commit_tree(item, tree);
-	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
+
+	ret = parse_commit_tree(r, item, buffer, size, &bufptr);
+	if (ret < 0)
+		return ret;
+
 	pptr = &item->parents;
 
 	graft = lookup_commit_graft(r, &item->object.oid);
@@ -567,18 +568,16 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	return 0;
 }
 
-int repo_parse_commit_internal(struct repository *r,
-			       struct commit *item,
-			       int quiet_on_missing,
-			       int use_commit_graph)
+static int repo_read_commit_buffer(struct repository *r,
+				   const struct object_id *oid,
+				   void **buffer, unsigned long *size,
+				   int quiet_on_missing)
 {
 	enum object_type type;
-	void *buffer;
-	unsigned long size;
 	struct object_info oi = {
 		.typep = &type,
-		.sizep = &size,
-		.contentp = &buffer,
+		.sizep = size,
+		.contentp = buffer,
 	};
 	/*
 	 * Git does not support partial clones that exclude commits, so set
@@ -586,6 +585,51 @@ int repo_parse_commit_internal(struct repository *r,
 	 */
 	int flags = OBJECT_INFO_LOOKUP_REPLACE | OBJECT_INFO_SKIP_FETCH_OBJECT |
 		OBJECT_INFO_DIE_IF_CORRUPT;
+
+	if (odb_read_object_info_extended(r->objects, oid, &oi, flags) < 0)
+		return quiet_on_missing ? -1 :
+			error("Could not read %s", oid_to_hex(oid));
+	if (type != OBJ_COMMIT) {
+		free(buffer);
+		return error("Object %s not a commit", oid_to_hex(oid));
+	}
+
+	return 0;
+}
+
+struct tree *repo_get_commit_tree(struct repository *r,
+				  struct commit *commit)
+{
+	unsigned long size;
+	void *buffer;
+
+	if (commit->maybe_tree)
+		return commit->maybe_tree;
+
+	if (commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
+		return get_commit_tree_in_graph(r, commit);
+
+	if (repo_read_commit_buffer(r, &commit->object.oid, &buffer, &size, 0) < 0 ||
+	    parse_commit_tree(r, commit, buffer, size, NULL) < 0)
+		die(NULL);
+
+	free(buffer);
+	return commit->maybe_tree;
+}
+
+struct object_id *get_commit_tree_oid(struct commit *commit)
+{
+	struct tree *tree = repo_get_commit_tree(the_repository, commit);
+	return tree ? &tree->object.oid : NULL;
+}
+
+static int repo_parse_commit_internal(struct repository *r,
+				      struct commit *item,
+				      int quiet_on_missing,
+				      int use_commit_graph)
+{
+	unsigned long size;
+	void *buffer;
 	int ret;
 
 	if (!item)
@@ -608,16 +652,10 @@ int repo_parse_commit_internal(struct repository *r,
 		return 0;
 	}
 
-	if (odb_read_object_info_extended(r->objects, &item->object.oid,
-					  &oi, flags) < 0)
-		return quiet_on_missing ? -1 :
-			error("Could not read %s",
-			     oid_to_hex(&item->object.oid));
-	if (type != OBJ_COMMIT) {
-		free(buffer);
-		return error("Object %s not a commit",
-			     oid_to_hex(&item->object.oid));
-	}
+	ret = repo_read_commit_buffer(r, &item->object.oid, &buffer, &size,
+				      quiet_on_missing);
+	if (ret < 0)
+		return ret;
 
 	ret = parse_commit_buffer(r, item, buffer, size, 0);
 	if (save_commit_buffer && !ret &&
@@ -635,6 +673,12 @@ int repo_parse_commit_gently(struct repository *r,
 	return repo_parse_commit_internal(r, item, quiet_on_missing, 1);
 }
 
+int repo_parse_commit_no_graph(struct repository *r,
+			       struct commit *commit)
+{
+	return repo_parse_commit_internal(r, commit, 0, 0);
+}
+
 void parse_commit_or_die(struct commit *item)
 {
 	if (repo_parse_commit(the_repository, item))
diff --git a/commit.h b/commit.h
index 1635de418b..f3c1932e74 100644
--- a/commit.h
+++ b/commit.h
@@ -93,8 +93,6 @@ struct commit *lookup_commit_reference_by_name_gently(const char *name,
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
 int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size, int check_graph);
-int repo_parse_commit_internal(struct repository *r, struct commit *item,
-			       int quiet_on_missing, int use_commit_graph);
 int repo_parse_commit_gently(struct repository *r,
 			     struct commit *item,
 			     int quiet_on_missing);
@@ -103,11 +101,8 @@ static inline int repo_parse_commit(struct repository *r, struct commit *item)
 	return repo_parse_commit_gently(r, item, 0);
 }
 
-static inline int repo_parse_commit_no_graph(struct repository *r,
-					     struct commit *commit)
-{
-	return repo_parse_commit_internal(r, commit, 0, 0);
-}
+int repo_parse_commit_no_graph(struct repository *r,
+			       struct commit *commit);
 
 void parse_commit_or_die(struct commit *item);
 
@@ -153,8 +148,8 @@ void repo_unuse_commit_buffer(struct repository *r,
  */
 void free_commit_buffer(struct parsed_object_pool *pool, struct commit *);
 
-struct tree *repo_get_commit_tree(struct repository *, const struct commit *);
-struct object_id *get_commit_tree_oid(const struct commit *);
+struct tree *repo_get_commit_tree(struct repository *, struct commit *);
+struct object_id *get_commit_tree_oid(struct commit *);
 
 /*
  * Release memory related to a commit, including the parent list and
diff --git a/pretty.c b/pretty.c
index e0646bbc5d..2d8261e772 100644
--- a/pretty.c
+++ b/pretty.c
@@ -889,7 +889,7 @@ enum trunc_type {
 
 struct format_commit_context {
 	struct repository *repository;
-	const struct commit *commit;
+	struct commit *commit;
 	const struct pretty_print_context *pretty_ctx;
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
@@ -1440,7 +1440,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				void *context)
 {
 	struct format_commit_context *c = context;
-	const struct commit *commit = c->commit;
+	struct commit *commit = c->commit;
 	const char *msg = c->message;
 	struct commit_list *p;
 	const char *arg, *eol;
@@ -1984,7 +1984,7 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 }
 
 void repo_format_commit_message(struct repository *r,
-				const struct commit *commit,
+				struct commit *commit,
 				const char *format, struct strbuf *sb,
 				const struct pretty_print_context *pretty_ctx)
 {
@@ -2282,7 +2282,7 @@ void pp_remainder(struct pretty_print_context *pp,
 }
 
 void pretty_print_commit(struct pretty_print_context *pp,
-			 const struct commit *commit,
+			 struct commit *commit,
 			 struct strbuf *sb)
 {
 	unsigned long beginning_of_body;
@@ -2363,7 +2363,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	repo_unuse_commit_buffer(the_repository, commit, reencoded);
 }
 
-void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
+void pp_commit_easy(enum cmit_fmt fmt, struct commit *commit,
 		    struct strbuf *sb)
 {
 	struct pretty_print_context pp = {0};
diff --git a/pretty.h b/pretty.h
index fac699033e..8b5b448988 100644
--- a/pretty.h
+++ b/pretty.h
@@ -82,8 +82,8 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w);
  * Shortcut for invoking pretty_print_commit if we do not have any context.
  * Context would be set empty except "fmt".
  */
-void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
-			struct strbuf *sb);
+void pp_commit_easy(enum cmit_fmt fmt, struct commit *commit,
+		    struct strbuf *sb);
 
 /*
  * Get information about user and date from "line", format it and
@@ -117,9 +117,9 @@ void pp_remainder(struct pretty_print_context *pp, const char **msg_p,
  * Please use this function for custom formats.
  */
 void repo_format_commit_message(struct repository *r,
-			const struct commit *commit,
-			const char *format, struct strbuf *sb,
-			const struct pretty_print_context *context);
+				struct commit *commit,
+				const char *format, struct strbuf *sb,
+				const struct pretty_print_context *context);
 
 /*
  * Parse given arguments from "arg", check it for correctness and
@@ -133,8 +133,8 @@ void get_commit_format(const char *arg, struct rev_info *);
  * Please use this function if you have a context (candidate for "pp").
  */
 void pretty_print_commit(struct pretty_print_context *pp,
-			const struct commit *commit,
-			struct strbuf *sb);
+			 struct commit *commit,
+			 struct strbuf *sb);
 
 /*
  * Change line breaks in "msg" to "line_separator" and put it into "sb".
