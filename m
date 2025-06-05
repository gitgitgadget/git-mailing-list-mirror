Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C471FC0E3
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106027; cv=none; b=JXQHDHoSa8Pitx4IbSMj6vbjVNj0k7tnJqntpkEqbkDY1r1M8PPytezPNZEca2CWNF3Z686puEpYsYm6IOKQ6nrPnLcU6PuHoG2vxSjt1hQYcrWuzG6bkhiGl/k1YfCYaCrhUj2QaN/4QxZCr5yokXxAF7CjqYoH/zoGe6l6BCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106027; c=relaxed/simple;
	bh=zNhLMmfmF+trqiiP8E3LhtO++tCnh7Av33FDa5LpMLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=caFX0hDnsiBa5ImeY3vGM3Z38sLsPHSVdNy+qF6HHJ1WYCGuk7jjQXnEXBnv/GjMOeg5SajyjQFFb477dImvx866sC6Ij4HVrbqM8zI3Be5TXA4lV9MR6CV/fBFI4QHwg5nzJ4Y2WsU8RUEWsuTAIEEeb3JgLp4g7Yp6visxIx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=amCw6cK3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFOZxtPp; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="amCw6cK3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFOZxtPp"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F220D25400E8;
	Thu,  5 Jun 2025 02:47:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 05 Jun 2025 02:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749106023;
	 x=1749192423; bh=dyL+fVE9LYsOcfTP66Ot7Ivf0tXLSsaorl2aNXNlY8Q=; b=
	amCw6cK3OPtQuy/DZeg1KNZdqqNePr0pdXKbdNrFYaUalwAuXOXAYiiLX84PySmA
	YnsxzTyVltVz560F6GpSj3ySCOL8dqWQgsy912R4cMiyqKVkhOdNkJNq4FV6umdm
	yMlxvQnn/5CWBt6xxrGe0usC32vVXbw7BMd7t/+lVhTctyXJ9BS4mc07B6fOHgU4
	uX395mKYyNjaF3MsV3l6ah9emTKabvusOVkwmaMoMd+JAuKNS37sHkSca09xsVwP
	MMQcxWLVkbNEOwhRGzQF/zqFqhjPQI0g5q8594TNzBWxsxtKgJoSBgNHaJOqgNM+
	HzgcOgEKkLQxGK686lgv1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749106023; x=
	1749192423; bh=dyL+fVE9LYsOcfTP66Ot7Ivf0tXLSsaorl2aNXNlY8Q=; b=Q
	FOZxtPpXyNJLKTuEpiigR8TGF0lic7KrhujUHWdbvL4HgH6GxJwbJdo08L810Qug
	IHLFD2wiVnFt34D78n2UAQHCcc5Q2jMusN+SqjcigZPLNLfP+VaU6WTt3OrZW8Tb
	NLVmStAO3YBsQ+cc6H8oE+eOJ8UbNAUgHh9cCCYwNzBeVZbjNXjx3ePPWSkBs5w1
	qFvEgQHeGLCfoAyL7HPb2TSOylMQeoMsJ1JU9IDR3LngmgO1/j41+OOHBjh2BvdO
	h/NQ2IydelL7zv10SBOB2EQDvpQeRVr9vwQafIJ64AsB5CNL4zkle1IMja/xWy3f
	AnEv6g3CP9/hc1zfxaNVQ==
X-ME-Sender: <xms:Zz1BaMHGrQBaSS3hx9FsQqRgAJJbR_ydaOw50UnUm8rfwQ0zSWMBzg>
    <xme:Zz1BaFUicUpYDRfTPiCdSzXz2441lJosSZnZ18WVChFl2C2RWH_PxxVz6zNCrsgmH
    Q74uUGKhany4rmlOA>
X-ME-Received: <xmr:Zz1BaGJUwKrydjkK6P3Zmap8KMcTU9cL58pXHjGCJ2k2-fDYr7F1bkJA1wA77ZS4TBIdz5j7jtVEdNu3nLaZ21bEZELDtk6EicNgQ_YGWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:Zz1BaOFl74quOTNBrwMMhns12_Bil3DKeNxSkiiG7R28RwmvbbsDsw>
    <xmx:Zz1BaCVLJoOmAyNT9iJiK3flxf5H0UlG5gjwGl1e2hgQ7qrcb_C1fQ>
    <xmx:Zz1BaBPZ0xsKRJ0ZmTyEQ3zuAJPJElejuxdATvgYFEBgZBbcUlEWIw>
    <xmx:Zz1BaJ0QXDhff52l0bm1h46Hu8uuQiQ1n1hAmVPdAQabO9jOII_nlA>
    <xmx:Zz1BaNsv5b_mLqG087zHePcla7b6jAO_5RH795hi_eIRyWIwzw8vVidX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 02:47:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2848da61 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 06:47:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Jun 2025 08:46:54 +0200
Subject: [PATCH v5 04/17] odb: introduce parent pointers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-pks-object-store-wo-the-repository-v5-4-779d1c28774b@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

In subsequent commits we'll get rid of our use of `the_repository` in
"odb.c" in favor of explicitly passing in a `struct object_database` or
a `struct odb_source`. In some cases though we'll need access to the
repository, for example to read a config value from it, but we don't
have a way to access the repository owning a specific object database.

Introduce parent pointers for `struct object_database` to its owning
repository as well as for `struct odb_source` to its owning object
database, which will allow us to adapt those use cases.

Note that this change requires us to pass through the object database to
`link_alt_odb_entry()` so that we can set up the parent pointers for any
source there. The callchain is adapted to pass through the object
database accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 47 +++++++++++++++++++++++++++--------------------
 odb.h        |  8 +++++++-
 repository.c |  3 ++-
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/odb.c b/odb.c
index d1025ac182d..afb16f4c693 100644
--- a/odb.c
+++ b/odb.c
@@ -135,11 +135,15 @@ static int alt_odb_usable(struct object_database *o,
  * of the object ID, an extra slash for the first level indirection, and
  * the terminating NUL.
  */
-static void read_info_alternates(struct repository *r,
+static void read_info_alternates(struct object_database *odb,
 				 const char *relative_base,
 				 int depth);
-static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
-	const char *relative_base, int depth, const char *normalized_objdir)
+
+static int link_alt_odb_entry(struct object_database *odb,
+			      const struct strbuf *entry,
+			      const char *relative_base,
+			      int depth,
+			      const char *normalized_objdir)
 {
 	struct odb_source *alternate;
 	struct strbuf pathbuf = STRBUF_INIT;
@@ -167,22 +171,23 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos))
+	if (!alt_odb_usable(odb, &pathbuf, normalized_objdir, &pos))
 		goto error;
 
 	CALLOC_ARRAY(alternate, 1);
-	/* pathbuf.buf is already in r->objects->source_by_path */
+	alternate->odb = odb;
+	/* pathbuf.buf is already in r->objects->alternate_by_path */
 	alternate->path = strbuf_detach(&pathbuf, NULL);
 
 	/* add the alternate entry */
-	*r->objects->sources_tail = alternate;
-	r->objects->sources_tail = &(alternate->next);
+	*odb->sources_tail = alternate;
+	odb->sources_tail = &(alternate->next);
 	alternate->next = NULL;
-	assert(r->objects->source_by_path);
-	kh_value(r->objects->source_by_path, pos) = alternate;
+	assert(odb->source_by_path);
+	kh_value(odb->source_by_path, pos) = alternate;
 
 	/* recursively add alternates */
-	read_info_alternates(r, alternate->path, depth + 1);
+	read_info_alternates(odb, alternate->path, depth + 1);
 	ret = 0;
  error:
 	strbuf_release(&tmp);
@@ -219,7 +224,7 @@ static const char *parse_alt_odb_entry(const char *string,
 	return end;
 }
 
-static void link_alt_odb_entries(struct repository *r, const char *alt,
+static void link_alt_odb_entries(struct object_database *odb, const char *alt,
 				 int sep, const char *relative_base, int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
@@ -234,20 +239,20 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		return;
 	}
 
-	strbuf_realpath(&objdirbuf, r->objects->sources->path, 1);
+	strbuf_realpath(&objdirbuf, odb->sources->path, 1);
 
 	while (*alt) {
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(r, &entry,
+		link_alt_odb_entry(odb, &entry,
 				   relative_base, depth, objdirbuf.buf);
 	}
 	strbuf_release(&entry);
 	strbuf_release(&objdirbuf);
 }
 
-static void read_info_alternates(struct repository *r,
+static void read_info_alternates(struct object_database *odb,
 				 const char *relative_base,
 				 int depth)
 {
@@ -261,7 +266,7 @@ static void read_info_alternates(struct repository *r,
 		return;
 	}
 
-	link_alt_odb_entries(r, buf.buf, '\n', relative_base, depth);
+	link_alt_odb_entries(odb, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
@@ -303,7 +308,7 @@ void add_to_alternates_file(const char *reference)
 		if (commit_lock_file(&lock))
 			die_errno(_("unable to move new alternates file into place"));
 		if (the_repository->objects->loaded_alternates)
-			link_alt_odb_entries(the_repository, reference,
+			link_alt_odb_entries(the_repository->objects, reference,
 					     '\n', NULL, 0);
 	}
 	free(alts);
@@ -317,7 +322,7 @@ void add_to_alternates_memory(const char *reference)
 	 */
 	prepare_alt_odb(the_repository);
 
-	link_alt_odb_entries(the_repository, reference,
+	link_alt_odb_entries(the_repository->objects, reference,
 			     '\n', NULL, 0);
 }
 
@@ -336,6 +341,7 @@ struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy)
 	 * alternate
 	 */
 	source = xcalloc(1, sizeof(*source));
+	source->odb = the_repository->objects;
 	source->path = xstrdup(dir);
 
 	/*
@@ -580,9 +586,9 @@ void prepare_alt_odb(struct repository *r)
 	if (r->objects->loaded_alternates)
 		return;
 
-	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(r->objects, r->objects->alternate_db, PATH_SEP, NULL, 0);
 
-	read_info_alternates(r, r->objects->sources->path, 0);
+	read_info_alternates(r->objects, r->objects->sources->path, 0);
 	r->objects->loaded_alternates = 1;
 }
 
@@ -950,11 +956,12 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect)
 		    type_name(expect));
 }
 
-struct object_database *odb_new(void)
+struct object_database *odb_new(struct repository *repo)
 {
 	struct object_database *o = xmalloc(sizeof(*o));
 
 	memset(o, 0, sizeof(*o));
+	o->repo = repo;
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
 	pthread_mutex_init(&o->replace_mutex, NULL);
diff --git a/odb.h b/odb.h
index 6f56b168e46..c3851e29668 100644
--- a/odb.h
+++ b/odb.h
@@ -28,6 +28,9 @@ struct repository;
 struct odb_source {
 	struct odb_source *next;
 
+	/* Object database that owns this object source. */
+	struct object_database *odb;
+
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
 	 * sacrificing accuracy due to races for speed. That includes
@@ -105,6 +108,9 @@ struct cached_object_entry;
  * configured via alternates.
  */
 struct object_database {
+	/* Repository that owns this database. */
+	struct repository *repo;
+
 	/*
 	 * Set of all object directories; the main directory is first (and
 	 * cannot be NULL after initialization). Subsequent directories are
@@ -186,7 +192,7 @@ struct object_database {
 	unsigned packed_git_initialized : 1;
 };
 
-struct object_database *odb_new(void);
+struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
 /*
diff --git a/repository.c b/repository.c
index 13426db0f2b..c606e1153c8 100644
--- a/repository.c
+++ b/repository.c
@@ -52,7 +52,7 @@ static void set_default_hash_algo(struct repository *repo)
 
 void initialize_repository(struct repository *repo)
 {
-	repo->objects = odb_new();
+	repo->objects = odb_new(repo);
 	repo->remote_state = remote_state_new();
 	repo->parsed_objects = parsed_object_pool_new(repo);
 	ALLOC_ARRAY(repo->index, 1);
@@ -167,6 +167,7 @@ void repo_set_gitdir(struct repository *repo,
 
 	if (!repo->objects->sources) {
 		CALLOC_ARRAY(repo->objects->sources, 1);
+		repo->objects->sources->odb = repo->objects;
 		repo->objects->sources_tail = &repo->objects->sources->next;
 	}
 	expand_base_dir(&repo->objects->sources->path, o->object_dir,

-- 
2.50.0.rc1.591.g9c95f17f64.dirty

