Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0082C15B0
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155760; cv=none; b=S1Z1w44aHtZnw842DM5Lw8XvvWhXMzTEJ1mnjc7hyY/6z+qNwO4MylXLXv6JICXoJnt8ImZzmsAwyDRr65CSfkXDiH2H5PZylgrgR92zAzmZigNTdJ0X41BzFA6BnS7pAfA0nNxwCEM0FK8Yza0O2rA9p4k+o5aTendvsFQAwhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155760; c=relaxed/simple;
	bh=VMkFLJIcxmgFgZNsIEmn0WnfR5PwfG6IIcZgZc5M3DY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kx6r7Z24f13PNSaW2zN4N+bTXftA5b3h7e8Xq6Gy6gaaq7XZBu46qgEHpa7y39Snx2EVs8l0E+E2BJhB6lZUZFrZo1s7K2AAxuowdMvMGZVuJOH938T8Zfs/Q6yYGNA3A/nioCtSCUdmdKn1NWm9RIhoUHbuI3xApUns2buQToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CehQBSf0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nS07depz; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CehQBSf0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nS07depz"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 08F0A1D00112;
	Mon,  3 Nov 2025 02:42:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 02:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155757;
	 x=1762242157; bh=QPMh2driatK4olSfGLUdLP/QtGSxUjKoork2CD+UIhA=; b=
	CehQBSf0vGO08j5NOSeWYAGWjnS8bNIxULB0uiav3r8/55imvwhfmbjw6KQV0Zjg
	9cjtrco66kHCorSWWQ8Wcwx0MsNYPT0jJx5DSse8VkVeQzui2nhqoZDx1AXgDdX5
	uYEhl+yyd0IJ7cRDzRyenqfjU2OWPhJc7kTjgyecteRM21HfBkIhfbYH+8tjjNxV
	XWyrEWwnSOsUxihQWJu+N6jTHx/aY0uO35Iiz2qM3I94tMvtU3XGRVVbJPy3d4kH
	JifVbl6xyz1aTnJFW5Z77Qka6Ciea2CMr30CLr3IBOoDaR/wd13eoj24AC8QMY+3
	nTcFVUk0E+sk4ijEwOVClw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155757; x=
	1762242157; bh=QPMh2driatK4olSfGLUdLP/QtGSxUjKoork2CD+UIhA=; b=n
	S07depzG3vlToBCfP2qurM20cLNyGKWB6MABN5tBIeLlXRmin/waj1Q0yYCV/Yng
	xUQ205qXEuNjAbOtN12DeC8rN5F40giiOCPZ+SUaUbPQtfC+6VaAyr+gzSwocMcc
	uQNy1uez0KY4vFZjThRAsrOE8cuWnK/X4dEFFVU6/DtlC+Cdv+8eVobWkrwjGJ7r
	80wNigK+1BajvbG4ahBEimcquhVplF3z9/EzqyqP+D3lPfG5ge6fWYbwOSv+KD4R
	XUcIWXQbCnMw7eyqleOttoTPUgG5Aspl1vtwrb2sU0BuGLmU5uLtVASUYYbfXFmE
	OY8QkYZH7E5X5R7lmmsCg==
X-ME-Sender: <xms:7VwIaX40EYzg2M8Bk-eH1-gHnzDaYZkTkIGFDvYze_CX1prs3nal6w>
    <xme:7VwIaUWFdnJXX1OrJROaG9r_Uf-TWFSNu45fhwyiTGdiodRStp6KK6krRzvf1LM7_
    8m74d0TxogJ9QmahOau-s-naMrXKPK1Nu2aBFQUeTL08qN_Rti0>
X-ME-Received: <xmr:7VwIab3ETB53v8ZhpfqzDoqFlrP3QYRFJYImAi-B0hENrbZ5Op_Q909rjTeyYIh5kIWFkBbkGl3GlTRYpo48BruMguHxugbwryx59IQCuJ9l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:7VwIaR0WeAxqzMInbO1UfctyMBuJ83NumD7t0o9xv9-bVb1G95YOwQ>
    <xmx:7VwIae_zHCYRLajTl3coNK1MHoJVrjQZ7pGAz1eZysF0CeN0hUYDew>
    <xmx:7VwIae0XYmq1dfVtZ_vyguammtoN7k-T1M0UsLYTKOneM8DoxIDPDw>
    <xmx:7VwIab8nkm_TE_mMggqT-rbf5paNQtyHCcXRI91g-WlpyR9MEdDCcQ>
    <xmx:7VwIacWXoE1ro22zTMm5qoj-LKQ_qq3pXUzuO6SpfneYw9WgxGDVPomJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ee478ff7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Nov 2025 08:42:04 +0100
Subject: [PATCH v3 09/13] object-file: read objects via the loose object
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-9-6a61ea977393@pks.im>
References: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When reading an object via `loose_object_info()` or `map_loose_object()`
we hand in the whole repository. We then iterate through each of the
object sources to figure out whether that source has the object in
question.

This logic is reversing responsibility though: a specific backend should
only care about one specific source, where the object sources themselves
are then managed by the object database.

Refactor the code accordingly by passing an object source to both of
these functions instead. The different sources are then handled by
either `do_oid_object_info_extended()`, which sits on the object
database level, and by `open_istream_loose()`. The latter function
arguably is still at the wrong level, but this will be cleaned up at a
later point in time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 68 ++++++++++++++++++++++-------------------------------------
 object-file.h | 15 +++++++------
 odb.c         |  9 ++++++--
 streaming.c   | 11 +++++++++-
 4 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/object-file.c b/object-file.c
index ccc67713fad..6d6e9a5a2ad 100644
--- a/object-file.c
+++ b/object-file.c
@@ -167,25 +167,22 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 }
 
 /*
- * Find "oid" as a loose object in the local repository or in an alternate.
+ * Find "oid" as a loose object in given source.
  * Returns 0 on success, negative on failure.
  *
  * The "path" out-parameter will give the path of the object we found (if any).
  * Note that it may point to static storage and is only valid until another
  * call to stat_loose_object().
  */
-static int stat_loose_object(struct repository *r, const struct object_id *oid,
+static int stat_loose_object(struct odb_source_loose *loose,
+			     const struct object_id *oid,
 			     struct stat *st, const char **path)
 {
-	struct odb_source *source;
 	static struct strbuf buf = STRBUF_INIT;
 
-	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources; source; source = source->next) {
-		*path = odb_loose_path(source, &buf, oid);
-		if (!lstat(*path, st))
-			return 0;
-	}
+	*path = odb_loose_path(loose->source, &buf, oid);
+	if (!lstat(*path, st))
+		return 0;
 
 	return -1;
 }
@@ -194,39 +191,24 @@ static int stat_loose_object(struct repository *r, const struct object_id *oid,
  * Like stat_loose_object(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-static int open_loose_object(struct repository *r,
+static int open_loose_object(struct odb_source_loose *loose,
 			     const struct object_id *oid, const char **path)
 {
-	int fd;
-	struct odb_source *source;
-	int most_interesting_errno = ENOENT;
 	static struct strbuf buf = STRBUF_INIT;
+	int fd;
 
-	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources; source; source = source->next) {
-		*path = odb_loose_path(source, &buf, oid);
-		fd = git_open(*path);
-		if (fd >= 0)
-			return fd;
+	*path = odb_loose_path(loose->source, &buf, oid);
+	fd = git_open(*path);
+	if (fd >= 0)
+		return fd;
 
-		if (most_interesting_errno == ENOENT)
-			most_interesting_errno = errno;
-	}
-	errno = most_interesting_errno;
 	return -1;
 }
 
-static int quick_has_loose(struct repository *r,
+static int quick_has_loose(struct odb_source_loose *loose,
 			   const struct object_id *oid)
 {
-	struct odb_source *source;
-
-	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources; source; source = source->next) {
-		if (oidtree_contains(odb_source_loose_cache(source, oid), oid))
-			return 1;
-	}
-	return 0;
+	return !!oidtree_contains(odb_source_loose_cache(loose->source, oid), oid);
 }
 
 /*
@@ -252,12 +234,12 @@ static void *map_fd(int fd, const char *path, unsigned long *size)
 	return map;
 }
 
-void *map_loose_object(struct repository *r,
-		       const struct object_id *oid,
-		       unsigned long *size)
+void *odb_source_loose_map_object(struct odb_source *source,
+				  const struct object_id *oid,
+				  unsigned long *size)
 {
 	const char *p;
-	int fd = open_loose_object(r, oid, &p);
+	int fd = open_loose_object(source->loose, oid, &p);
 
 	if (fd < 0)
 		return NULL;
@@ -407,9 +389,9 @@ int parse_loose_header(const char *hdr, struct object_info *oi)
 	return 0;
 }
 
-int loose_object_info(struct repository *r,
-		      const struct object_id *oid,
-		      struct object_info *oi, int flags)
+int odb_source_loose_read_object_info(struct odb_source *source,
+				      const struct object_id *oid,
+				      struct object_info *oi, int flags)
 {
 	int status = 0;
 	int fd;
@@ -422,7 +404,7 @@ int loose_object_info(struct repository *r,
 	enum object_type type_scratch;
 
 	if (oi->delta_base_oid)
-		oidclr(oi->delta_base_oid, r->hash_algo);
+		oidclr(oi->delta_base_oid, source->odb->repo->hash_algo);
 
 	/*
 	 * If we don't care about type or size, then we don't
@@ -435,15 +417,15 @@ int loose_object_info(struct repository *r,
 	if (!oi->typep && !oi->sizep && !oi->contentp) {
 		struct stat st;
 		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
-			return quick_has_loose(r, oid) ? 0 : -1;
-		if (stat_loose_object(r, oid, &st, &path) < 0)
+			return quick_has_loose(source->loose, oid) ? 0 : -1;
+		if (stat_loose_object(source->loose, oid, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
 		return 0;
 	}
 
-	fd = open_loose_object(r, oid, &path);
+	fd = open_loose_object(source->loose, oid, &path);
 	if (fd < 0) {
 		if (errno != ENOENT)
 			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
diff --git a/object-file.h b/object-file.h
index f8a96a45f57..ca13d3d64e7 100644
--- a/object-file.h
+++ b/object-file.h
@@ -43,6 +43,14 @@ void odb_source_loose_free(struct odb_source_loose *loose);
 /* Reprepare the loose source by emptying the loose object cache. */
 void odb_source_loose_reprepare(struct odb_source *source);
 
+int odb_source_loose_read_object_info(struct odb_source *source,
+				      const struct object_id *oid,
+				      struct object_info *oi, int flags);
+
+void *odb_source_loose_map_object(struct odb_source *source,
+				  const struct object_id *oid,
+				  unsigned long *size);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -66,9 +74,6 @@ const char *odb_loose_path(struct odb_source *source,
 int has_loose_object(struct odb_source *source,
 		     const struct object_id *oid);
 
-void *map_loose_object(struct repository *r, const struct object_id *oid,
-		       unsigned long *size);
-
 /*
  * Iterate over the files in the loose-object parts of the object
  * directory "path", triggering the following callbacks:
@@ -196,10 +201,6 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
  */
 int stream_object_signature(struct repository *r, const struct object_id *oid);
 
-int loose_object_info(struct repository *r,
-		      const struct object_id *oid,
-		      struct object_info *oi, int flags);
-
 enum finalize_object_file_flags {
 	FOF_SKIP_COLLISION_CHECK = 1,
 };
diff --git a/odb.c b/odb.c
index d1df9609e21..4c0b4fdcd54 100644
--- a/odb.c
+++ b/odb.c
@@ -697,13 +697,18 @@ static int do_oid_object_info_extended(struct object_database *odb,
 		return 0;
 	}
 
+	odb_prepare_alternates(odb);
+
 	while (1) {
+		struct odb_source *source;
+
 		if (find_pack_entry(odb->repo, real, &e))
 			break;
 
 		/* Most likely it's a loose object. */
-		if (!loose_object_info(odb->repo, real, oi, flags))
-			return 0;
+		for (source = odb->sources; source; source = source->next)
+			if (!odb_source_loose_read_object_info(source, real, oi, flags))
+				return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
 		if (!(flags & OBJECT_INFO_QUICK)) {
diff --git a/streaming.c b/streaming.c
index 4b13827668e..00ad649ae39 100644
--- a/streaming.c
+++ b/streaming.c
@@ -230,12 +230,21 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 			      enum object_type *type)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
+	struct odb_source *source;
+
 	oi.sizep = &st->size;
 	oi.typep = type;
 
-	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
+	odb_prepare_alternates(r->objects);
+	for (source = r->objects->sources; source; source = source->next) {
+		st->u.loose.mapped = odb_source_loose_map_object(source, oid,
+								 &st->u.loose.mapsize);
+		if (st->u.loose.mapped)
+			break;
+	}
 	if (!st->u.loose.mapped)
 		return -1;
+
 	switch (unpack_loose_header(&st->z, st->u.loose.mapped,
 				    st->u.loose.mapsize, st->u.loose.hdr,
 				    sizeof(st->u.loose.hdr))) {

-- 
2.51.2.1041.gc1ab5b90ca.dirty

