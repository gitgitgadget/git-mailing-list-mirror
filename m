Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A61474DA
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860044; cv=none; b=qDluZh0tFpyS77pJ4rclCxom9PWmazhQDYvYwv40EhO5POvuiMo/nEXAwbQWY/4PDHNy87lYs+3cGkhppTEhu7f/KoRu+TuprVhLz5UWW0VDOvNPMvgwPQIobwyp6+07NzBIsJStZ2sCcMjTYe/TKWt0Wpx0JPHGA+1t40jrI4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860044; c=relaxed/simple;
	bh=X33LTtQKTv/962ZoAOQJsHJIC78XOcYRjWr5xaO0lYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rGRfztdFO4MeFglmy/SYAlbfgogKDD26kWPrO2zDqlYS5jYlLpxOD0GkJOjwD1q499Gr+DGC2WH/rab2CfttsYN8HN1H9CIPy6OXEk4Sjj/m2muekpcdUZw7VwKqulM0HgPvGMrVbmGW+IfAVU5KgZ7Lh7hBNT0nsi65m6rTtBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dPpvsLlS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pti50qY9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dPpvsLlS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pti50qY9"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC6CA254012F;
	Mon,  2 Jun 2025 06:27:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 06:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748860040;
	 x=1748946440; bh=NdemH7tUXE0RPb5n7+CziUeGyUFsR9njEkdt4ZFNtNc=; b=
	dPpvsLlSdE1I/t8305yrhjVSD/ShpfQigrINFcBQZsyB1wa1/lvf8luvb/jwFPdk
	XhFwpAKH5Xcku7kZXwgAaXyzz9YIsjYSnViOIuMDkMjvUIg+iexQ38u5CXDKc8pZ
	XvD/Ro+WgtQURxPpIEh6vc3biK8jNkQhL2hkPw+m9rGDDKTKwVNHAbpxihuJPRMQ
	FL1SumUbLAMD9NsyPcuEQScoOc5psJ78M1+LmmbfYwNTL+jiey8u/wo9c9Yo/mqp
	MwnIB8fYccCCY2kp1yNBAfBMpqcFuyKiIhLNNnnJXImKl6yIDZOYYxJp8O5+w1UQ
	rpHtYLrXIJRHsgUvcDRFQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748860040; x=
	1748946440; bh=NdemH7tUXE0RPb5n7+CziUeGyUFsR9njEkdt4ZFNtNc=; b=p
	ti50qY9q7xtxfWBuvfTrmC6U7T1HcrgMEUp0E56ylkztafScEkua5XDHv0kZ+P3B
	xuy98ZBsFJZ2pWqsDCxpPW0l5vU5YIdqc0Pwm3rBekNL+WDj3rtoIs92i5IXaogG
	3SauALpHx2O+P9kf4jSyu70t2sFsosz4zcdk8UwpXin7roqixemFf1V1f3YumPG2
	JkcSLv6tX3rgxKGV9exIJlgQiH4OxqdXKhX/DRRFkUEdGpbQ8ojwsbyf5VWxey+w
	7ZxgVz9cS9HCDSKFP1YxQwx1OCdhpzc5Wqz06v3zKbGW7QWgmyxcF0ayp4D4U9il
	bmJGkFTBPb72DF4SBh+jQ==
X-ME-Sender: <xms:iHw9aO9OYCVOk3nWy5vpovJFr-5VoT2_0G9Lp-qLBxtlD3-VH5JSeQ>
    <xme:iHw9aOtxNr8W7VgaOLdUxCEYj0XU0WNTbYcCv8eM86IqSojdifE90vuULG-l_lCuN
    ArWgiO47s2e2t9Yow>
X-ME-Received: <xmr:iHw9aED7ixpmrfSc0yr0lYO1r4f7CW17gyubkTW5YuLNpnRKq-nGUOdz7wL5JqbDfcdCRt7CmYWOJ8G18ngFXnmexPULnf4CC8WxvefHw4bj6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeegfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:iHw9aGfmOHVkRzhtHwbeJTnRB_fMv3Yb4da0_DemYYtvCpGzOB8WmA>
    <xmx:iHw9aDNocv2lMsXGdVblA0bhcGCetizp-0cgKMw4eNNYLKAJe9_2tA>
    <xmx:iHw9aAnMPn3N-Zr3yD_R_zXNrp8rCElb3kX6tqkoH9DRY7MO6DGNOw>
    <xmx:iHw9aFuH9hdzCDd3bwJWJptmPzfPu4hAVSmqlHVhYyzY4JSvqY_kwg>
    <xmx:iHw9aAH1h5WytFtdQCSREN5woFisvb3nyhpja6hnRwpaj1PPsaqRsawN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 06:27:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a39b51c6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 10:27:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 12:27:02 +0200
Subject: [PATCH v4 01/17] object-store: rename `raw_object_store` to
 `object_database`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-object-store-wo-the-repository-v4-1-e986804a7c62@pks.im>
References: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
In-Reply-To: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
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
index ad3943b6906..905fcbdf0e8 100644
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
index 58cde0313a5..f4e8f99d90f 100644
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
@@ -950,9 +950,9 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect)
 		    type_name(expect));
 }
 
-struct raw_object_store *raw_object_store_new(void)
+struct object_database *odb_new(void)
 {
-	struct raw_object_store *o = xmalloc(sizeof(*o));
+	struct object_database *o = xmalloc(sizeof(*o));
 
 	memset(o, 0, sizeof(*o));
 	INIT_LIST_HEAD(&o->packed_git_mru);
@@ -961,7 +961,7 @@ struct raw_object_store *raw_object_store_new(void)
 	return o;
 }
 
-static void free_object_directories(struct raw_object_store *o)
+static void free_object_directories(struct object_database *o)
 {
 	while (o->odb) {
 		struct object_directory *next;
@@ -974,7 +974,7 @@ static void free_object_directories(struct raw_object_store *o)
 	o->odb_by_path = NULL;
 }
 
-void raw_object_store_clear(struct raw_object_store *o)
+void odb_clear(struct object_database *o)
 {
 	FREE_AND_NULL(o->alternate_db);
 
diff --git a/object-store.h b/object-store.h
index c5890085352..a3be27d1171 100644
--- a/object-store.h
+++ b/object-store.h
@@ -87,7 +87,12 @@ struct packed_git;
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
@@ -169,8 +174,8 @@ struct raw_object_store {
 	unsigned packed_git_initialized : 1;
 };
 
-struct raw_object_store *raw_object_store_new(void);
-void raw_object_store_clear(struct raw_object_store *o);
+struct object_database *odb_new(void);
+void odb_clear(struct object_database *o);
 
 /*
  * Create a temporary file rooted in the object database directory, or
diff --git a/packfile.c b/packfile.c
index 70c7208f027..c735b4d0135 100644
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
2.50.0.rc0.629.g846fc57c9e.dirty

