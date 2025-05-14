Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7531F4621
	for <git@vger.kernel.org>; Wed, 14 May 2025 05:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199556; cv=none; b=OhRyyUfHx2ThufQbddkFzxgALmJhr6B3fyCpqpdWhPQIkZr9l7NzDM2lRnZKHl71fwFxRNVKLkeYFh+d7EffEOZQPMXVsepQhu5HBGdNukIACjcEUxRvJNpyHuEF23ocD6w9Ky7fG9Ddzg3jXHkXarzT2r0aj0H4jCtRJV9zNi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199556; c=relaxed/simple;
	bh=fyfOQOs906ibQWT6eQWfVUnlyC/gRjn3TN/BjjTETeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gt1wRhKIQ6CisCWRr87WxWkZX0sj/G9ZMUJOv1lsVFGjCXCbQEtUpvkS0C3fakiIh9m17Y/hLaW9cmMkL8WI6jgoieJuWYTgXh9oeM7cjkfDx2IDWMSKrbq4XtX42C0J6W8niILRIBiwSprO9l7u/glsRMSeAtsxu2d8T6bqTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AO7qw8H3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GxZFpO/h; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AO7qw8H3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GxZFpO/h"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CBB781380209;
	Wed, 14 May 2025 01:12:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 01:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747199553;
	 x=1747285953; bh=9lHzw4y78ewUqmmpkpgpeGD+ZRCvtoMCWDNxccTE8Es=; b=
	AO7qw8H3jhkAHduqePt7WZk2GAQ/dZJb+LUdqqE+rwQjooTGHDuufGbo7okjmymj
	g7eZIxh08UM0iWFAlJytIqqleBGDnQ2xLpeBMF8Ax2VphhaCwJtUHtEETqqABp+L
	YGxDoLiv6DSAx5ugVngRVDQRqFeBotx4gYUe0xWlbI0HBhYTo/P4C4H2bPZ3Ew31
	qoNGK/OQ/PPIcquSOMN0LACJ3FPb9H/mAPcbE0YzllNJjYNspU5rdhUoda6IuNRO
	xY5bKHwsCBR4mrCAGFWiwXm3wsTecUsj0/kWhsCwnyRHzouRoiwhGVvXFvoT0IkO
	8DjGJRmIZV4KI8MxjRyfNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747199553; x=
	1747285953; bh=9lHzw4y78ewUqmmpkpgpeGD+ZRCvtoMCWDNxccTE8Es=; b=G
	xZFpO/h3KkHFAauLon8v8NwzKJV9Ql1jkk7h84AfKRC/rsguDD1t5svCa9KPxf3X
	ogzYy65uidxBCK4kYvqS6dR8E5DVUUwEqPY67fUtRunHAZaNlkb/0XLwEpqlOE5A
	ylB2qgnZGjHo+UYqXENi8aZj2K1PxEwa+gpzXFO2UG0pcuZcYMPnN0isx+1AecOK
	wen/jvnly2wFj9m4DRDaynk71hBCQw8SAVKHjrMa6vl/pu0GnZ4XjsMP9kNFxkKo
	KsQqiMXZgM41uJip24MwUObHWyDcSS6HlHvh92HZg2tkJ9hvSeiYUmMyo0EQRiXb
	lpYKKgHT6DbaOH1DQ9Ehw==
X-ME-Sender: <xms:QSYkaPnbmEojT7HUnQq_mcWWr_aBwfEmO2Jnq4-0f61vlJW1xoZCeQ>
    <xme:QSYkaC17ORiXc81JnYstnFxzxfi-og8Rok6Hy6Ah27MS2AgBAz6fDe-8XtVf92VQH
    Q6Nk40I8DZa3pAfPA>
X-ME-Received: <xmr:QSYkaFo4AIAawa_uTZCd5oM0fEGPFKwL5FgariqcPkNqPMCbEdoDrQKChlD0pi5op3tJwnPRWQDOBE7w4PTrmAi8MtybNatPc7_w_lMFews>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtg
    homh
X-ME-Proxy: <xmx:QSYkaHlGlPY4mQPolBW5NBFz4atnnv7w5FnQV5NQk0rXGWZgmQbKJA>
    <xmx:QSYkaN17QlbICKh3DkzSPAocmOB20pH9NrLdtLvM0keZtTBO_U8zqQ>
    <xmx:QSYkaGvnOcyDIYkbQn19kbi-534HwZ8JZCeHhl1jw9vHW8qUIObSmg>
    <xmx:QSYkaBU8040PInjSSlmQbkmQF7DguWvqRrkC-cn4BdkPvl5JeJ0xZQ>
    <xmx:QSYkaIb2ogLAL51ow5raMKZKHj69_F_kNhcXjZkNG7PmuL4DBuDNUFc6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 01:12:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0be11325 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 05:12:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 May 2025 07:12:27 +0200
Subject: [PATCH v3 04/17] odb: introduce parent pointers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-pks-object-store-wo-the-repository-v3-4-47df1d4ead22@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

In subsequent commits we'll get rid of our use of `the_repository` in
"odb.c" in favor of explicitly passing in a `struct object_database` or
a `struct odb_alternate`. In some cases though we'll need access to the
repository, for example to read a config value from it, but we don't
have a way to access the repository owning a specific object database.

Introduce parent pointers for `struct object_database` to its owning
repository as well as for `struct odb_alternate` to its owning object
database, which will allow us to adapt those use cases.

Note that this change requires us to pass through the object database to
`link_alt_odb_entry()` so that we can set up the parent pointers for any
alternate there. The callchain is adapted to pass through the object
database accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 45 ++++++++++++++++++++++++++-------------------
 odb.h        |  8 +++++++-
 repository.c |  3 ++-
 3 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/odb.c b/odb.c
index 81281db7e0a..2b36735087e 100644
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
 	struct odb_alternate *alternate;
 	struct strbuf pathbuf = STRBUF_INIT;
@@ -167,22 +171,23 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos))
+	if (!alt_odb_usable(odb, &pathbuf, normalized_objdir, &pos))
 		goto error;
 
 	CALLOC_ARRAY(alternate, 1);
+	alternate->odb = odb;
 	/* pathbuf.buf is already in r->objects->alternate_by_path */
 	alternate->path = strbuf_detach(&pathbuf, NULL);
 
 	/* add the alternate entry */
-	*r->objects->alternates_tail = alternate;
-	r->objects->alternates_tail = &(alternate->next);
+	*odb->alternates_tail = alternate;
+	odb->alternates_tail = &(alternate->next);
 	alternate->next = NULL;
-	assert(r->objects->alternate_by_path);
-	kh_value(r->objects->alternate_by_path, pos) = alternate;
+	assert(odb->alternate_by_path);
+	kh_value(odb->alternate_by_path, pos) = alternate;
 
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
 
-	strbuf_realpath(&objdirbuf, r->objects->alternates->path, 1);
+	strbuf_realpath(&objdirbuf, odb->alternates->path, 1);
 
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
 
@@ -336,6 +341,7 @@ struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destro
 	 * alternate
 	 */
 	alternate = xcalloc(1, sizeof(*alternate));
+	alternate->odb = the_repository->objects;
 	alternate->path = xstrdup(dir);
 
 	/*
@@ -580,9 +586,9 @@ void prepare_alt_odb(struct repository *r)
 	if (r->objects->loaded_alternates)
 		return;
 
-	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(r->objects, r->objects->alternate_db, PATH_SEP, NULL, 0);
 
-	read_info_alternates(r, r->objects->alternates->path, 0);
+	read_info_alternates(r->objects, r->objects->alternates->path, 0);
 	r->objects->loaded_alternates = 1;
 }
 
@@ -959,11 +965,12 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect)
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
index 070dd28e394..1d1ab8e8bf2 100644
--- a/odb.h
+++ b/odb.h
@@ -21,6 +21,9 @@ struct repository;
 struct odb_alternate {
 	struct odb_alternate *next;
 
+	/* Object database that owns this alternate. */
+	struct object_database *odb;
+
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
 	 * sacrificing accuracy due to races for speed. That includes
@@ -98,6 +101,9 @@ struct cached_object_entry;
  * configured via alternates.
  */
 struct object_database {
+	/* Repository that owns this database. */
+	struct repository *repo;
+
 	/*
 	 * Set of all object directories; the main directory is first (and
 	 * cannot be NULL after initialization). Subsequent directories are
@@ -179,7 +185,7 @@ struct object_database {
 	unsigned packed_git_initialized : 1;
 };
 
-struct object_database *odb_new(void);
+struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
 /*
diff --git a/repository.c b/repository.c
index dbc7fa8685f..36c508f7cb2 100644
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
 
 	if (!repo->objects->alternates) {
 		CALLOC_ARRAY(repo->objects->alternates, 1);
+		repo->objects->alternates->odb = repo->objects;
 		repo->objects->alternates_tail = &repo->objects->alternates->next;
 	}
 	expand_base_dir(&repo->objects->alternates->path, o->object_dir,

-- 
2.49.0.1141.g47af616452.dirty

