Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357042741CE
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372559; cv=none; b=LZEFTZWxp00Bk7lzQls6h1Jq1ZOKd4w67ZLo1XpiUCmqFGhjVowl9F2pf2AYGQ5WK/T6UISmy5ttHPwe+aRA0bxi5n1ugDiC0LKT0E7Dd3ErayzPJUDYhhIgzzAOyO5xxQwxQ3PfkMGCoYPggYz0Uz+8rQjEPTS+GLjYAkotEnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372559; c=relaxed/simple;
	bh=l/Xb+U43D4Txv4PPaadbGw/f9FG+00dAIocqH3h3v4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvmiBzvYPhP7Pfda0fxbKC3aQEjKTfJIz8wHOPS4FIMpvVA3jUEbRDHUUbg+JjiH1ixaG4s+XPkkVl93PYlycBD1zJEhVG3JLeqcDyXb5WZmJGRXPxINADheCwgFb543bisvDqY8GDRVnFzO+LZqs0WNWkRG6V/ACbMPUZUoaEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h7IjVGvv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dgVqc1w1; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h7IjVGvv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dgVqc1w1"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3884DEC04E8;
	Tue,  1 Jul 2025 08:22:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 01 Jul 2025 08:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751372555;
	 x=1751458955; bh=KEeiDhxKPXamnrdYmT3By+SoTZj35htd40RzzDTh9NU=; b=
	h7IjVGvvy4e7CHJOcXXx7qsxtoPMReagf7foLWV34BU4bUYqVBUdKYjJKrxd3Vk1
	/r/1gjMZV44iyQhKZ8HRj3uBC1CZlJ9hPVqDwpfsbUXoDJAbJwt3ypDOjpFc0e0O
	0XgJvBjj0tEMls+NOyakhC5f4SBmC0P6XmW7OIK+HwwnWYsQxljAeTpsyzdjlEyt
	hC7ir6wFz+o2cHSeoQjNCJWCUuAg0ShLGpoBrrSlvuFwZPsF2qhOqxUszyDP5w4K
	6kEWzmA09J0En7pJwGitu02dtmfl+p5p6RhWLgx5EQkTfXqk6nCqD6qgX3PgKOch
	Fi5BvbuvoBulwst+TkgL2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751372555; x=
	1751458955; bh=KEeiDhxKPXamnrdYmT3By+SoTZj35htd40RzzDTh9NU=; b=d
	gVqc1w1Q2+YbQ5XgclCnhk+XRVxv9abl9UEwRAam8m5tQRYW/V+WDYnQKXf2GYMF
	FabSkkrqGqf29/ddlrncr16jDcv1GLKe0b42KRlrWOy/NNhmBNHNTw9TRPERKDAS
	vZecSsWeBIecqC40PYuG0H7wkXvwgIxEi0SyUaEgFiZjvQT4vq1JR/WkGdvgfnP5
	IFsDc9N73WVnff6HS3DZ10aKRLjgZBux3KdfhCDigkS7mToeNMSdS4eLosVCRxlg
	rpwXI9D7lFuE5SOVlH9C8bqmQC5aahMK1rv9iDJkYCQadHNiUNcUHO5uF8gm3Ef+
	NE0euTMy0sog448mOsPCg==
X-ME-Sender: <xms:C9NjaAJ27960SoPo8Z_zJKVDmtgKC2pHs07xzPvjGplW3XbZrTJ32g>
    <xme:C9NjaAInyd0N4tFko61b2yCoc5ozyx7_w1iDP4BTFBkpFb641djZ6esupfnBz9CMw
    g4ojdKN07FDgJFELw>
X-ME-Received: <xmr:C9NjaAvA6dCeSJk9rw36KAjuwhwoYulq7_QmL4L4PdPI-XYmS3CODzdJR4kn8r1xbV2nzb8njIZt9D03Ndg71t8B3WAV1v1v-Gaxvntv-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdp
    rhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:C9NjaNYSGM9HEvJNPaWDb3xjQhIi8RgVtcdCbg4cIBc7CtmeDrw2vw>
    <xmx:C9NjaHYNuPtFUll5eHwjC3UxNClZKbaJ0dWsYLi8bSSIP2K3078QPA>
    <xmx:C9NjaJBbJMeR7KTO1fmLE2OFguXTnwE8V7vaAMyyFBem7OZB8CJJrQ>
    <xmx:C9NjaNbtGzDfn4U7FVmXp2Sh81eLkQfs9o0yGcHAVs3eqDdkSIi7Ag>
    <xmx:C9NjaAALlQXBSbEYLdqWzyeqsM9F7EAa1qMfWyQJ5zpKcygGB0nux8Ez>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 08:22:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9bbb344c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 12:22:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Jul 2025 14:22:16 +0200
Subject: [PATCH v6 04/17] odb: introduce parent pointers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-pks-object-store-wo-the-repository-v6-4-dbf3894ab4e2@pks.im>
References: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
In-Reply-To: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
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
 odb.c        | 45 ++++++++++++++++++++++++++-------------------
 odb.h        |  8 +++++++-
 repository.c |  3 ++-
 3 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/odb.c b/odb.c
index d1025ac182d..0464d7f54a2 100644
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
+	alternate->odb = odb;
 	/* pathbuf.buf is already in r->objects->source_by_path */
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
2.50.0.195.g74e6fc65d0.dirty

