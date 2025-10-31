Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40782EC0AD
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891197; cv=none; b=upVnz/6wn3E4mePTYNoWSifLFiaX1Mui2QryBxKzdolijea9UHGGdKgsUdTWlp52AqS2i7Gj0xX0n8Mwmh1as4d07otujHNaKCC4e2CbnGbv1qk9Mwj5eN92StWDi6VKPNk1khbMw8YZeyRSW2o9ZD63/Z+gajtR+0yZgdCYPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891197; c=relaxed/simple;
	bh=938ZXwyHIEXmhj1gp5vjLsMQ0rxuky2cs2pn2EnfST8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O8kL8NHFMOvb8FGlZ1ywcG5luNWQv/X1Xr6TKZDM45v/LnzehQFWOWUl2NCHcpzc3P0jBt0yQRAST+/qQsc8gfHF1DBM3DPHB5WkMIdE27X09RCpMCHiY6UJPfkHa8ZmharVT+01wT9WpwEM04CuHzTSppxn93Cgx8BA3V1XlcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F7Qel6Rz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kHApsAkN; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F7Qel6Rz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kHApsAkN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B42A6EC0084;
	Fri, 31 Oct 2025 02:13:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 31 Oct 2025 02:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891194;
	 x=1761977594; bh=s4+gxvqx0hUPHL+Vw/uRabg/5AMkUrBsJ7pJqUvemIM=; b=
	F7Qel6RzWdZRjHdBRp/zQUbt6mZZjoz88Dg83Gtvvnm0dyR1UScGoM2bZi68VPDm
	OIbTvp0ABdyn61XQ4pV4sToYNelgjAxzLSws7uYb505535kEGhtaNLfPYi8q+cDd
	ht6bLkZWqZusgi97PPgFGM+im5Ln1UYl+IbviJO1WG7gmGzaDWQiiU4MyzkzOwfG
	vGAAP7ftbTv3h8xVH+rgYmg9zXY9d6NcZ3RjqCxUCAkSOr8AXA1Ev6vCXdiEmLkL
	qK+aVW4CylO+DNLoDGGpqcThtc+gNhQXb/9vVyO/osMDGXo/1ucC69TspndS1rU8
	smh1c5mTi8zjGFzjADgJyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891194; x=
	1761977594; bh=s4+gxvqx0hUPHL+Vw/uRabg/5AMkUrBsJ7pJqUvemIM=; b=k
	HApsAkNHeu2C9jZG+BZbFFtyoXnEvr7OqqIDYzOIYTD/d2pm5WRsEHq7r0BWxmHD
	NzjvoAPs5aAJZW7+EVowPR61NIunlQ9aWK3mMUQTBVy5p7SJ4srq4IGIFE+YiBqW
	so8njOFwuooPGd5rTiKxN0EKCS5sFyjz3Ojnv+ZM1EaqkcN9NQ8ODhSYYMBRJfEp
	QTe43JA758uIGmAWfN7zGyX1+IHzwcse8tFpSDyKMHIZqxrxBVlrdBn6aK4yelfh
	5eqkNf6dWpN/mM/ijXMLwYKcppx56tUsOIy5rnlNHjvIm3COlYL1oSXJnx+Wz/5L
	QuRDLd8FWMB5cLfCX2eLQ==
X-ME-Sender: <xms:elMEaZzncCL_URPgZGE45Io9slryq2sFhB86AQqkc_BO-LAhmlYfxA>
    <xme:elMEaQu9ypeFzm32UyfZ8kbDZNndt3HqEXwQSaUs582VSMILuCfQ_29tYEHX72Yrm
    EpA-zrHXwYFIJ6zo_SX1XnBzbhW6ZKhtTqeAEeE_874G0iNaTHVqQ>
X-ME-Received: <xmr:elMEaQtozMvdDghgts9dMH5ctitzFkDjj9nA0ZMpxmg4UiG7Sojc3KSXmxDMJTnh1sdWzXvtm7mcxLie4Alm0S1Zi4WVZdiDxkO0gbDQirLJqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:elMEaVOycMhCf045AXXwEtMDj24H5MDar_5-yb5nHyQmGPsBEk9O1Q>
    <xmx:elMEae36F2EZyO2lXpQzuB2R78TLbsQOSQcImw6bRfbnM0oKLHl_1Q>
    <xmx:elMEaRNGtMVxkqyV7Oeb1KBsXa58Y1I1fnJS0csrbEJDSO5vYxeHOA>
    <xmx:elMEae3xDablr39uRBl3o8zKNkWCaNGN2w9jq4XMCWLYWqOhToN1ng>
    <xmx:elMEaQsD-PESuB2MCVhV41b22MJ3Eq9ggg34nBRAC20TXRiXgNfGk9lL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:13:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea3747e3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:13:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Oct 2025 07:12:45 +0100
Subject: [PATCH v2 09/13] object-file: read objects via the loose object
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-9-920f721aef71@pks.im>
References: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
In-Reply-To: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
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
index e8877876d77..64a3d45376a 100644
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
+static int stat_loose_object(struct odb_loose_source *loose,
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
+static int open_loose_object(struct odb_loose_source *loose,
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
+static int quick_has_loose(struct odb_loose_source *loose,
 			   const struct object_id *oid)
 {
-	struct odb_source *source;
-
-	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources; source; source = source->next) {
-		if (oidtree_contains(odb_loose_source_cache(source, oid), oid))
-			return 1;
-	}
-	return 0;
+	return !!oidtree_contains(odb_loose_source_cache(loose->source, oid), oid);
 }
 
 /*
@@ -252,12 +234,12 @@ static void *map_fd(int fd, const char *path, unsigned long *size)
 	return map;
 }
 
-void *map_loose_object(struct repository *r,
-		       const struct object_id *oid,
-		       unsigned long *size)
+void *odb_loose_source_map_object(struct odb_source *source,
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
+int odb_loose_source_read_object_info(struct odb_source *source,
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
index 74bae27612f..58ec22d187e 100644
--- a/object-file.h
+++ b/object-file.h
@@ -43,6 +43,14 @@ void odb_loose_source_free(struct odb_loose_source *loose);
 /* Reprepare the loose source by emptying the loose object cache. */
 void odb_loose_source_reprepare(struct odb_source *source);
 
+int odb_loose_source_read_object_info(struct odb_source *source,
+				      const struct object_id *oid,
+				      struct object_info *oi, int flags);
+
+void *odb_loose_source_map_object(struct odb_source *source,
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
index 96059456f20..5dc1e2c7eb0 100644
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
+			if (!odb_loose_source_read_object_info(source, real, oi, flags))
+				return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
 		if (!(flags & OBJECT_INFO_QUICK)) {
diff --git a/streaming.c b/streaming.c
index 4b13827668e..8e554abd084 100644
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
+		st->u.loose.mapped = odb_loose_source_map_object(source, oid,
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

