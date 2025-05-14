Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B191F4634
	for <git@vger.kernel.org>; Wed, 14 May 2025 05:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199554; cv=none; b=AlzsU4QxAtJXxpwRTC64iudgK3Ayvc+WeMGERQwZXQGNSQKX9bVY4CQ3qadk0xD/ahrkngzbEnhAc8wIKniU76rWBVTgfyHbMyYFmoJLv7EhJxFLwftxm5jU66gG+0v4q60pasdYPKDye5l28+Reh6ulzqBUAiT4ky8rWKEsMPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199554; c=relaxed/simple;
	bh=yDAahoGWmj7ilySV6TYtLjqdQ8DmoddhBmP+M+KUTZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HG5bNMgMaIqiCkShjW1wT+vFaef6ZOHyB0NZ+Vu9Ca+qP/Zg676n/tXFPtFCRVoG/QChQ9Dy/2aIcNvD+wXXPopPqA7h/+wV7tfKPS6HahxrfqA8k7nyTOaW1M/JrKjzlNTcpTHEyqUBI9ISpP8ng8K5yMf1dDJw2f1s2NlKOFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ao3IxH/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cRRaTJip; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ao3IxH/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cRRaTJip"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E5801140088;
	Wed, 14 May 2025 01:12:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 May 2025 01:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747199551;
	 x=1747285951; bh=MzW57MuKuOZ7REadrj162lEEG7quHFhAevvHDyeuMVc=; b=
	Ao3IxH/uPHVCycpHBv5A4ayvxWlIgca6EPYf4puvQ4MSvSlJmWYN8qu+grOIPr9P
	BOeBm8xhbZGs9IExH7Ao0spPsut1E7iLFVrVmKi+xL+D5XsfhhBXWJeLeWymJ2sI
	m58oiGbDmeg59KiTkcsno7vn1jj9VJatieCsfcKaz6qphi0LPiLW1rXWJ0gx4QXx
	njKTXa1S5Pw9aHeMhP8MpU1Tgfn+qS6hN8c8cVbF5uINEajHE4xjx+rKkZ0S1srv
	3tPV7GKDwv46vk+kkMYMxPcpqHvxektxGe5B7DGka7+cm6MOhJuSouZIOKtlh2Du
	/9u3OgBr30YIp33WjP2LwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747199551; x=
	1747285951; bh=MzW57MuKuOZ7REadrj162lEEG7quHFhAevvHDyeuMVc=; b=c
	RRaTJip/l8X77UOejlPSnCQahjyZhG5Msj8Q3L55g1gere++QTdmn3EARDF+xV6x
	KhQ8QQp+lMjOfc0r9ZhrJp+tP25yanG79xYjuPJC9WpnH7AICsVGgWDOm5ogY3tN
	pYS8L3OPV973QPDFn13cPaL3mmJZbVBdDYqPwAXzdBuGVP3TEiBIdQGojisrjh3C
	ao9ZjLXkBPrd1TgMz2IIVmKDDrVUTzfLZ3g7ywozFXyt9Ya9pPm17wmdKO8hcjAq
	m7fGaONvMnnZH+d/F9bSZwKZpbLYcSO+sodsA8UAAIpU33f7pjqv83eVkwMm+9mD
	XJ2LoLJXcdqfFkPHGxuaw==
X-ME-Sender: <xms:PyYkaMGNB9Yb5cfAjryFnTZeo1AM5KfP4V5UGp3Kzpsoq9sMF1LwzA>
    <xme:PyYkaFXddD7p_LmXPBab7rZErInguccIzwF_09xqmur0thDHnMAoARAyuswBbHOe1
    SvaVT3gUWkCP6_Urg>
X-ME-Received: <xmr:PyYkaGLzWE50yqaHQIYdJd38xvVTXUDXfu3pnpkxwdYnjhJ_A1_dkK7nj-P5RkFDpaRvfhKjXv_ct7ZONK_5466rkkZSHcjobj94eBs6mNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtg
    homh
X-ME-Proxy: <xmx:PyYkaOEYxeVUDnYRdFtDzRhtnDn9aRsZvV3p_-kT30WLKqULLMgzQA>
    <xmx:PyYkaCWC9TJldMJVqGnRVs29epWGzF_j37VEUVLTWqnZpYQAFKJTPw>
    <xmx:PyYkaBNEeNYYGHq8GmyLAm1tNoowjHdzDPXPLYI4NRB5v6x6S0HhAQ>
    <xmx:PyYkaJ2ffwyP-zdlsjC7BBD884l4U4qqjB5sbX4vhpNJWdOIn1H0SA>
    <xmx:PyYkaA499wrq810oHgkDNFp-OxzoWhxpoWfg0fvzQ4jmvsD7F2y41l4V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 01:12:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id da53a28e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 05:12:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 May 2025 07:12:24 +0200
Subject: [PATCH v3 01/17] object-store: rename `raw_object_store` to
 `object_database`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-pks-object-store-wo-the-repository-v3-1-47df1d4ead22@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The `raw_object_store` structure is the central entry point for reading
and writing objects in a repository. The main purpose of this structure
is to manage object directories and provide an interface to access and
write objects in those object directories.

Right now, many of the functions associated with the raw object store
implicitly rely on `the_repository` to get access to its `objects`
pointer, which is the `raw_object_store`. As we want to generally get
rid of using `the_repository` across our codebase we will have to
convert this implicit dependency on this global variable into an
explicit parameter.

This conversion can be done by simply passing in an explicit pointer to
a repository and then using its `->objects` pointer. But there is a
second effort underway, which is to make the object subsystem more
selfcontained so that we can eventually have pluggable object backends.
As such, passing in a repository wouldn't make a ton of sense, and the
goal is to convert the object store interfaces such that we always pass
in a reference to the `raw_object_store` instead.

This will expose the `raw_object_store` type to a lot more callers
though, which surfaces that this type is named somewhat awkwardly. The
"raw_" prefix makes readers wonder whether there is a non-raw variant of
the object store, but there isn't. Furthermore, we nowadays want to name
functions in a way that they can be clearly attributed to a specific
subsystem, but calling them e.g. `raw_object_store_has_object()` is just
too unwieldy, even when dropping the "raw_" prefix.

Instead, rename the structure to `object_database`. This term is already
used a lot throughout our codebase, and it cannot easily be mistaken for
"object directories", either. Furthermore, its acronym ODB is already
well-known and works well as part of a function's name, like for example
`odb_has_object()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c |  2 +-
 commit-graph.h |  4 ++--
 object-store.c | 12 ++++++------
 object-store.h | 11 ++++++++---
 packfile.c     |  2 +-
 packfile.h     |  4 ++--
 repository.c   |  4 ++--
 repository.h   |  4 ++--
 8 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6394752b0b0..1b66486b9c9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -829,7 +829,7 @@ struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
 	return NULL;
 }
 
-void close_commit_graph(struct raw_object_store *o)
+void close_commit_graph(struct object_database *o)
 {
 	if (!o->commit_graph)
 		return;
diff --git a/commit-graph.h b/commit-graph.h
index 13f662827d4..20d38c100ce 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -26,7 +26,7 @@ void git_test_write_commit_graph_or_die(void);
 struct commit;
 struct bloom_filter_settings;
 struct repository;
-struct raw_object_store;
+struct object_database;
 struct string_list;
 
 char *get_commit_graph_filename(struct object_directory *odb);
@@ -186,7 +186,7 @@ int write_commit_graph(struct object_directory *odb,
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags);
 
-void close_commit_graph(struct raw_object_store *);
+void close_commit_graph(struct object_database *);
 void free_commit_graph(struct commit_graph *);
 
 /*
diff --git a/object-store.c b/object-store.c
index 2f51d0e3b03..1effcb12273 100644
--- a/object-store.c
+++ b/object-store.c
@@ -44,7 +44,7 @@ struct cached_object_entry {
 	} value;
 };
 
-static const struct cached_object *find_cached_object(struct raw_object_store *object_store,
+static const struct cached_object *find_cached_object(struct object_database *object_store,
 						      const struct object_id *oid)
 {
 	static const struct cached_object empty_tree = {
@@ -86,7 +86,7 @@ int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct raw_object_store *o,
+static int alt_odb_usable(struct object_database *o,
 			  struct strbuf *path,
 			  const char *normalized_objdir, khiter_t *pos)
 {
@@ -959,9 +959,9 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect)
 		    type_name(expect));
 }
 
-struct raw_object_store *raw_object_store_new(void)
+struct object_database *odb_new(void)
 {
-	struct raw_object_store *o = xmalloc(sizeof(*o));
+	struct object_database *o = xmalloc(sizeof(*o));
 
 	memset(o, 0, sizeof(*o));
 	INIT_LIST_HEAD(&o->packed_git_mru);
@@ -970,7 +970,7 @@ struct raw_object_store *raw_object_store_new(void)
 	return o;
 }
 
-static void free_object_directories(struct raw_object_store *o)
+static void free_object_directories(struct object_database *o)
 {
 	while (o->odb) {
 		struct object_directory *next;
@@ -983,7 +983,7 @@ static void free_object_directories(struct raw_object_store *o)
 	o->odb_by_path = NULL;
 }
 
-void raw_object_store_clear(struct raw_object_store *o)
+void odb_clear(struct object_database *o)
 {
 	FREE_AND_NULL(o->alternate_db);
 
diff --git a/object-store.h b/object-store.h
index c2fe5a19605..34b8efbbb83 100644
--- a/object-store.h
+++ b/object-store.h
@@ -86,7 +86,12 @@ struct packed_git;
 struct multi_pack_index;
 struct cached_object_entry;
 
-struct raw_object_store {
+/*
+ * The object database encapsulates access to objects in a repository. It
+ * manages one or more backends that store the actual objects which are
+ * configured via alternates.
+ */
+struct object_database {
 	/*
 	 * Set of all object directories; the main directory is first (and
 	 * cannot be NULL after initialization). Subsequent directories are
@@ -168,8 +173,8 @@ struct raw_object_store {
 	unsigned packed_git_initialized : 1;
 };
 
-struct raw_object_store *raw_object_store_new(void);
-void raw_object_store_clear(struct raw_object_store *o);
+struct object_database *odb_new(void);
+void odb_clear(struct object_database *o);
 
 /*
  * Create a temporary file rooted in the object database directory, or
diff --git a/packfile.c b/packfile.c
index d91016f1c7f..8f51665266d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -359,7 +359,7 @@ void close_pack(struct packed_git *p)
 	oidset_clear(&p->bad_objects);
 }
 
-void close_object_store(struct raw_object_store *o)
+void close_object_store(struct object_database *o)
 {
 	struct packed_git *p;
 
diff --git a/packfile.h b/packfile.h
index 3a3c77cf05a..826eb7f475f 100644
--- a/packfile.h
+++ b/packfile.h
@@ -183,12 +183,12 @@ int close_pack_fd(struct packed_git *p);
 
 uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 
-struct raw_object_store;
+struct object_database;
 
 unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 void close_pack_windows(struct packed_git *);
 void close_pack(struct packed_git *);
-void close_object_store(struct raw_object_store *o);
+void close_object_store(struct object_database *o);
 void unuse_pack(struct pack_window **);
 void clear_delta_base_cache(void);
 struct packed_git *add_packed_git(struct repository *r, const char *path,
diff --git a/repository.c b/repository.c
index 9b3d6665fc6..07757e6e0c9 100644
--- a/repository.c
+++ b/repository.c
@@ -52,7 +52,7 @@ static void set_default_hash_algo(struct repository *repo)
 
 void initialize_repository(struct repository *repo)
 {
-	repo->objects = raw_object_store_new();
+	repo->objects = odb_new();
 	repo->remote_state = remote_state_new();
 	repo->parsed_objects = parsed_object_pool_new(repo);
 	ALLOC_ARRAY(repo->index, 1);
@@ -374,7 +374,7 @@ void repo_clear(struct repository *repo)
 	FREE_AND_NULL(repo->worktree);
 	FREE_AND_NULL(repo->submodule_prefix);
 
-	raw_object_store_clear(repo->objects);
+	odb_clear(repo->objects);
 	FREE_AND_NULL(repo->objects);
 
 	parsed_object_pool_clear(repo->parsed_objects);
diff --git a/repository.h b/repository.h
index c4c92b2ab9c..3a5ef9c781e 100644
--- a/repository.h
+++ b/repository.h
@@ -9,7 +9,7 @@ struct git_hash_algo;
 struct index_state;
 struct lock_file;
 struct pathspec;
-struct raw_object_store;
+struct object_database;
 struct submodule_cache;
 struct promisor_remote_config;
 struct remote_state;
@@ -47,7 +47,7 @@ struct repository {
 	/*
 	 * Holds any information related to accessing the raw object content.
 	 */
-	struct raw_object_store *objects;
+	struct object_database *objects;
 
 	/*
 	 * All objects in this repository that have been parsed. This structure

-- 
2.49.0.1141.g47af616452.dirty

