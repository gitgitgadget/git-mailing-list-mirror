Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835F27A464
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529766; cv=none; b=gyQCplhZ9PoKQ4A/dNbEI8xLc+QRcLZGAwwT/XXsF27+WdfCBdKPAAooMLDRRhUaFIsZuWzK83cyEZNbebtX1ZRuj9RteoIQiVCQ7vIlyzMvYHkvDpQGdUF2ii9BKKDG1LJjW7KqyZPB2OfoJuXc6dvdBM1m5kXZkzk/1pcKGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529766; c=relaxed/simple;
	bh=fp7kWR3NcYHsiSrZ0iZSWl9dzlU7+WDkfUWW3HwK3Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbjIlN1yju8dPyTfGWYPHuEYBOeT8ek4/Kqu93NHhlphAXPeZH9p08VM59lq4QEOIJK4ZRXthRenZKBEy0ooBmiSgkKXoXUpMaIz1kLu5ToS0Pzf0h7n1UGmAlQ2qkkXcZfn9tS5MaQrSFCH+mRoHuV7+R5I9dJKg1a77BobYU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VcQElCra; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RdvS4Qx7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VcQElCra";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RdvS4Qx7"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 398FE1140290
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:09:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 06 May 2025 07:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529763;
	 x=1746616163; bh=EXI6bBoQslG+ml/3r35D19h1DwO+ZmY47T6EYwoBEMQ=; b=
	VcQElCraWnn4igIJVmOyRLKJKV5MeL3BrwCzyPmOdmgtWaDsKfqlrJwXl4HteC3l
	xt4tR5J67/1nJU2fY/IwEiPXrCaQFgAcwSkZAao6vj1yIqy9AzTWtFoAwAaesQiS
	91cNXOksSw/w1aWvUa82fPfi4NoQhlpy/ukL0ousb2DwPvQbN2BpDVXifqCihtuB
	jR4joqmodkKk0YwgztPnsiRaIcDDbxIjxn1n1pSe0kOGVhKn/lFp0OvlYG54/2y2
	+F21TFiRvqVPYVfPYqlxsI2LekjbYb4RydvnfIYSQJSFQQWcrUyZGlbZdLk1icgd
	txLq0KObBi7IPkCnccWM9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529763; x=
	1746616163; bh=EXI6bBoQslG+ml/3r35D19h1DwO+ZmY47T6EYwoBEMQ=; b=R
	dvS4Qx7h/iwVpe/NgrNYkm6q3p9wixPoqVS3WZ7LmEk0S33v8q8For1CqIQTMZs9
	K6uwUuHhtq9d90r7btGdiFiKghGN096e1y4m6QJtzJXbeud0aeRFITqHcNQKVvWj
	TMyzuUtBk8xLEeuggCVcgquneDWiEG9VN2IS6BNyro4vAcOgPogORbzGFBx9oHxA
	yVBbL6XxwKcr8ctt2KODVhhWaUwHTzotRn97fQNk9j4xonr036DhcTReueP/7GFQ
	ukZrM8XHLdc+evYyj7M4HmSZLooPWyMFilRMDFMbgNkFxKP5M6N3diV49BpL7dGC
	CJobO898Szd6Q1aBOupTw==
X-ME-Sender: <xms:4-0ZaHF3JZ1nPqMv3U0SYJPl0QKAo6TusZyJoheD2h69K7m-NysCaw>
    <xme:4-0ZaEV9ZfQG4MVVrwFnGDNJON8GGbrazJbfP8qghg0Uxc7heHl96xAjT7E9A21Y4
    udAlvvz8SCpxTNm1Q>
X-ME-Received: <xmr:4-0ZaJKsvobGdu6xBkuEVnNjT1F2JrwMiKjwMbnLrPjZVOKkYbi_N4unAO7UJFkWMtUpjoleRiDymChX9QJAIT218KDSCOzKvdDB76hf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4-0ZaFEStqWdeyeT07P0tqvxxPqnz7Md95zO0aPcR7xRmJYFg8zZjQ>
    <xmx:4-0ZaNVW6n__6mzkQvZQ1mZIxIP9MezkMS1Wqnad-0EMTDD3DJo57Q>
    <xmx:4-0ZaAPzDEREfbgmJqYeX1lsYVYGgkzA-a-CRuI3GTHN7Rfwcz3K6Q>
    <xmx:4-0ZaM27Oa_Y9K_FJWKoBqaHWuf9G9XmQx4SQ5Jqb9cjvYYetlzcbw>
    <xmx:4-0ZaFRpKEkdcsvkJQxBQC1RLrwqq5FiL2gj52ZFBwmSiLvh3dKf9Vdy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 07:09:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 303cb68e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 11:09:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 13:09:17 +0200
Subject: [PATCH 04/17] odb: introduce parent pointers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-object-store-wo-the-repository-v1-4-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In subsequent commits we'll get rid of our use of `the_repository` in
"odb.c" in favor of explicitly passing in a `struct object_database` or
a `struct odb_backend`. In some cases though we'll need access to the
repository, for example to read a config value from it, but we don't
have a way to access the repository owning a specific object database.

Introduce parent pointers for `struct object_database` to its owning
repository as well as for `struct odb_backend` to its owning object
database, which will allow us to adapt those use cases.

Note that this change requires us to pass through the object database to
`link_alt_odb_entry()` so that we can set up the parent pointers for any
alternative backends there. The callchain is adapted to pass through the
object database accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 43 +++++++++++++++++++++++++------------------
 odb.h |  6 ++++++
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/odb.c b/odb.c
index 435f532a9c4..67207ce636d 100644
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
 	struct odb_backend *backend;
 	struct strbuf pathbuf = STRBUF_INIT;
@@ -167,22 +171,23 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos))
+	if (!alt_odb_usable(odb, &pathbuf, normalized_objdir, &pos))
 		goto error;
 
 	CALLOC_ARRAY(backend, 1);
+	backend->odb = odb;
 	/* pathbuf.buf is already in r->objects->backend_by_path */
 	backend->path = strbuf_detach(&pathbuf, NULL);
 
 	/* add the alternate entry */
-	*r->objects->backends_tail = backend;
-	r->objects->backends_tail = &(backend->next);
+	*odb->backends_tail = backend;
+	odb->backends_tail = &(backend->next);
 	backend->next = NULL;
-	assert(r->objects->backend_by_path);
-	kh_value(r->objects->backend_by_path, pos) = backend;
+	assert(odb->backend_by_path);
+	kh_value(odb->backend_by_path, pos) = backend;
 
 	/* recursively add alternates */
-	read_info_alternates(r, backend->path, depth + 1);
+	read_info_alternates(odb, backend->path, depth + 1);
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
 
-	strbuf_realpath(&objdirbuf, r->objects->backends->path, 1);
+	strbuf_realpath(&objdirbuf, odb->backends->path, 1);
 
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
 
@@ -336,6 +341,7 @@ struct odb_backend *set_temporary_primary_odb(const char *dir, int will_destroy)
 	 * alternate
 	 */
 	backend = xcalloc(1, sizeof(*backend));
+	backend->odb = the_repository->objects;
 	backend->path = xstrdup(dir);
 
 	/*
@@ -580,9 +586,9 @@ void prepare_alt_odb(struct repository *r)
 	if (r->objects->loaded_alternates)
 		return;
 
-	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(r->objects, r->objects->alternate_db, PATH_SEP, NULL, 0);
 
-	read_info_alternates(r, r->objects->backends->path, 0);
+	read_info_alternates(r->objects, r->objects->backends->path, 0);
 	r->objects->loaded_alternates = 1;
 }
 
@@ -964,6 +970,7 @@ struct object_database *odb_new(struct repository *repo)
 	struct object_database *o = xmalloc(sizeof(*o));
 
 	memset(o, 0, sizeof(*o));
+	o->repo = repo;
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
 	pthread_mutex_init(&o->replace_mutex, NULL);
diff --git a/odb.h b/odb.h
index 5774e1d615b..1617a9bac2c 100644
--- a/odb.h
+++ b/odb.h
@@ -16,6 +16,9 @@ struct repository;
 struct odb_backend {
 	struct odb_backend *next;
 
+	/* Object database that owns this backend. */
+	struct object_database *odb;
+
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
 	 * sacrificing accuracy due to races for speed. That includes
@@ -93,6 +96,9 @@ struct cached_object_entry;
  * configured via alternates.
  */
 struct object_database {
+	/* Repository that owns this database. */
+	struct repository *repo;
+
 	/*
 	 * Set of all object directories; the main directory is first (and
 	 * cannot be NULL after initialization). Subsequent directories are

-- 
2.49.0.1045.g170613ef41.dirty

