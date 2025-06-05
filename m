Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDC1F4295
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106025; cv=none; b=nlH+vTwokY8dH2Z4RezdgnJQ9MzpRA5hzKjqZ04loTom+7gKleLN4+ajd6+mMoAVrmgZonP4hCfhMQq1CJUPYxJEnZIyZeUBl2sFXZ3ElF2aG3jRqm5LkQsuPK/9L/YSMqkKgUUs69vF2gaVmfklE6GYP9/vD5EcJEqFN7ahCG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106025; c=relaxed/simple;
	bh=n5djHIkuApLZOUYsTHub548hJj1nLVuCpjSM/ZgN1Gk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EB1cYj3GaLkdbmNVHZAMLJrd2FV1atHWWgtSFrn1yT135APT8h942MQBngXinJguKy4ZoSVOfB9tsEWviDFogdzDX0OdxNvt+1zkpeUVpB5prHceXbuu39VaIxJCpzi+yUTNRWTjsNgiFgeZNaiVgUetDpFhMX/yp4hO9UUtTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ls8w15HB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YaldakTx; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ls8w15HB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YaldakTx"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 10BC111400B7;
	Thu,  5 Jun 2025 02:47:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Jun 2025 02:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749106021;
	 x=1749192421; bh=ToKI6jUnraI98Xawle8XtzJtp0UTmo5/oQfOX0oljn4=; b=
	ls8w15HBuCLT0jnx+GYL3QzV4NPblVMpDNFs0CJ5FCJ8dxcCICAsqHmTGv7s+Gr+
	dSZVn9704/N7J+7H+V8rvd39cJ4MtyfHwJNfnBbdTAw6Jw1ezwiuW2tQ7NntNzhf
	ve9UCHlKNFUYCAiSSCd3R56MGicNIoHm/iWb24K03s4NL7haOF6nHJcXSfaarPCC
	oiLGUEHSBeOi8kuL8MSJ71qysZWPC5k22FQDJ3sSJqTeujhuU7xeg9R62WoG+4DS
	YowmSOnqvlQGY3yYTguHjr41r11C9EWWnf80OkaMngn4asyqtQWUN70O/HS+0RkQ
	oJVe9AO1Q7o1N4DA1rlUog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749106021; x=
	1749192421; bh=ToKI6jUnraI98Xawle8XtzJtp0UTmo5/oQfOX0oljn4=; b=Y
	aldakTxU0lT4ARKrs2ZymJD/zTcq+z4o7o9nwAGhOgWQIl7pO30jAqLuoA//jqOs
	1TO1L+SHyP8Kvc9ONvmE7VfHbm/8RG/QyzfwWSG5iD+PSgEh8JDd/91voe0xH83+
	j3DetKAFqteztKhSKOELeO5ByRBFeToheyWaxFFZacvOi/+XLZYrKor7wdHQPFKk
	sFXJG4N3ucqqfNLoG2YFqRPfGlcggG1W4QRbTA0+aqu4ZVs8/GDtYqLfAwrO2vF/
	S8wCYOW8uzNZz47l5sDnFDRyTR2PFg//FrB70QClB4hCye/oyfx9ZuVQGrhaiCf7
	BTlYNABj3wfMrYVj7iC4g==
X-ME-Sender: <xms:ZT1BaM2gBp5LbOEFJyGy3Tvpkx5U6pMv_SfTEz1OttXRzwnS5wEvYQ>
    <xme:ZT1BaHHBPIgpV_oknEpGp3uWmfnfPmHrqxLlyrLmpFd5TTAf4YMetLmhSmRSw_R0p
    _wt2KnEyaCvoZz1QQ>
X-ME-Received: <xmr:ZT1BaE47NuHQnuiNV2QJCQqxp-AOMXh2xy-MFMx8RkehRsrUHS7UPi2Q4U7xfNEjSA3PAx9RWQTxx4a6QBxKdKJF2phYsVXI51FBZGIJ-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsthho
    lhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ZT1BaF3AKjKWZQMOLrzdihLgRp72PFdRr1YruyztTQuEKvIawx0Tbg>
    <xmx:ZT1BaPE5B_1MdOyUH1YZHNYEsSh6E4hqIYLQYKk1VNu--m-8DH6Y6Q>
    <xmx:ZT1BaO_NNCMu7IXWHvZiIN3ORGAvPupMaPmaZJwxUtKMlhZywZ-P1Q>
    <xmx:ZT1BaEn6cfsEpd_c1rEYZduamXfL6hFPFX-GLCTyTrnKUm0zE7Chxw>
    <xmx:ZT1BaJdECy3nV3L17kuinW1QZ_ZD-S4VIqptOPQf4e04zd3KYBltNg5J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 02:47:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 974929a3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 06:46:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Jun 2025 08:46:51 +0200
Subject: [PATCH v5 01/17] object-store: rename `raw_object_store` to
 `object_database`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-pks-object-store-wo-the-repository-v5-1-779d1c28774b@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
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
2.50.0.rc1.591.g9c95f17f64.dirty

