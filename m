Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F1633B955
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710935; cv=none; b=B4fetzjKDGb7MKRf3wQzZwBcaTXBIR2Wzc1dVtzUMnf5LpFosl0crKgyKy2qgAdD4w/fxiZodmCAvq6ndJqteoMTgVEKN74yzO9jvH5kKIz+dLWG/3RQLBo24Hx47XLszwRni1t/67Em1AiPkIw+vkjti2MpcFBQGq2H3fQiVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710935; c=relaxed/simple;
	bh=nafyUQmESKloY2pAUIRmc3WTOur6AE9d07y331ET7c0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/bmTYx19S19KkXDfsxrf5JxDkH4dN4swHjDGrVaJrMmI5rDXagxa8dR2JSD1fjx7CitSWgjqUpM+SQ7NDX5Lcmxz4y4TgaiOfEAzl1K5rmh/+9+pYWn6w1l1gaq+N3YphjF17f70RH7UG75uIiezeo8kNz2uL/+EBEwwVN/FYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lDuTODMz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IHgJFtUG; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lDuTODMz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IHgJFtUG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 609667A01A0;
	Fri, 21 Nov 2025 02:42:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 21 Nov 2025 02:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710933;
	 x=1763797333; bh=jUmOQonCCQKmlxhgTFtMn1PZegLmlXozTc1n9tfx6+A=; b=
	lDuTODMzSV5NpS+8Q9AleH5+u3TuLdtFfbayB25riE97d8+lNm0HKWT79sSCTcQA
	d/HSGwsFheB1E/10/M5uJvq4RkerzbGhjnXnoqAhWsp4tUD2+gvi2v6KL1Hq3QpM
	uExlS2A1vbaF4QUigtFN3tlZfy1pNrj+otFtbQJYXngjWWW1qYguKWrKRuTUD3jy
	0pDUu/f2mxFtSjkwFg73o2OkIm3NhQIE+6VBtt/il7qB30qK6uGoZjycAjeNANIP
	PAG2NaO51aKYdOxjEVxg2IeRh77BNwDSvi5yOk/kHCxN9ZL1nzm+603i1s7EIfXk
	JXRefIu2IxOP/6yRsHZNfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710933; x=
	1763797333; bh=jUmOQonCCQKmlxhgTFtMn1PZegLmlXozTc1n9tfx6+A=; b=I
	HgJFtUGcrbJzeKbBIc3XZr7n9qrDoFHJn2DuZTGNgd2dZsKpyHjAGm6zFa6YFSoA
	oiYeFi34KN2vmVuKTIPalcDhcUfAX6TslaQU5rZhDkO7gBT+0RwYgMaf7oXp/BMl
	0M2e2OcApMsg4J2zPOhTC0YvwPrFIGsw4nhvZGEm6WuAJlERPAHaQKYeEq+pjZBL
	BTislCsRw2w6boxxhmlIPjp+6wlj1sgNOGy7CLoq57npayVXEw+6/Vn/CnCv8hui
	6M22MuVvJND4V/H5K8nD1tksYv9QSlhFv3wEVxf2kjzVOjQ5rkpBKm1dY+H8bYd7
	0QWuw2sHY1u3mWuNycJ/g==
X-ME-Sender: <xms:1RcgaWezuyvWGxyk_R-pPvya0G2Sug1JWZEsP3JppbOIE7nSfu8j5w>
    <xme:1RcgaXrk36g1xWj-VgmStg-QOZzI3m3Y0WAHCrpwG_Q5BIWrIJoMr4OE6-ZWpevwk
    qzUyeYtx_DOmgJf53WO1GvJbadn81tVHyew166XsrtTF308xvBgwg>
X-ME-Received: <xmr:1RcgaU7sj68m2dVt29GvSrfNux7t0bxp3P2py1HFmJ7Gr6mc-VkT4mdAcm_k2fE04ARZcf1z7U9_0P7lpGY3t7Md-pEhjW0f2emhk7sTmTx0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:1Rcgado0SHNGgAmd1zb09Zm2fkQT_3_IVxkEn480t_izy-d4T8nR7g>
    <xmx:1RcgaWjYkyRCgqDbgjO-ft63VtrXE8HTPvWvn1vaeb93G-BI9egd5Q>
    <xmx:1RcgaXIV0iGnSsoYctT-s37WU4OTTQQ0UWuh9_2EBc9nNPGxxWZ6CQ>
    <xmx:1RcgaWCXojQMu5XgVUY7OoSRtdBEtpCK7eTUgzbiQu-8xvfBfHQF0A>
    <xmx:1RcgaWH0R3Vw3-s_y1XGY4Quv9vo8KBXLXlrnCS-ZUY31OElB7d-aLLr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:42:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7da04d0a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:42:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:41:04 +0100
Subject: [PATCH v2 19/19] streaming: drop redundant type and size pointers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-19-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

In the preceding commits we have turned `struct odb_read_stream` into a
publicly visible structure. Furthermore, this structure now contains the
type and size of the object that we are about to stream. Consequently,
the out-pointers that we used before to propagate the type and size of
the streamed object are now somewhat redundant with the data contained
in the structure itself.

Drop these out-pointers and adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive-tar.c          |  4 +---
 archive-zip.c          |  5 ++---
 builtin/index-pack.c   |  7 ++-----
 builtin/pack-objects.c |  6 ++++--
 object-file.c          |  6 ++----
 odb/streaming.c        | 10 ++--------
 odb/streaming.h        |  7 ++-----
 7 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 74499c311f..e34e3daec9 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -130,12 +130,10 @@ static void write_trailer(void)
 static int stream_blocked(struct repository *r, const struct object_id *oid)
 {
 	struct odb_read_stream *st;
-	enum object_type type;
-	unsigned long sz;
 	char buf[BLOCKSIZE];
 	ssize_t readlen;
 
-	st = odb_read_object_stream(r->objects, oid, &type, &sz, NULL);
+	st = odb_read_object_stream(r->objects, oid, NULL);
 	if (!st)
 		return error(_("cannot stream blob %s"), oid_to_hex(oid));
 	for (;;) {
diff --git a/archive-zip.c b/archive-zip.c
index 2b645f28ef..f8d1e80671 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -347,12 +347,11 @@ static int write_zip_entry(struct archiver_args *args,
 			method = ZIP_METHOD_DEFLATE;
 
 		if (!buffer) {
-			enum object_type type;
-			stream = odb_read_object_stream(args->repo->objects, oid,
-							&type, &size, NULL);
+			stream = odb_read_object_stream(args->repo->objects, oid, NULL);
 			if (!stream)
 				return error(_("cannot stream blob %s"),
 					     oid_to_hex(oid));
+			size = stream->size;
 			flags |= ZIP_STREAM;
 			out = NULL;
 		} else {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6403edd3a6..eb0c34b4c8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -798,8 +798,6 @@ static int compare_objects(const unsigned char *buf, unsigned long size,
 static int check_collison(struct object_entry *entry)
 {
 	struct compare_data data;
-	enum object_type type;
-	unsigned long size;
 
 	if (entry->size <= repo_settings_get_big_file_threshold(the_repository) ||
 	    entry->type != OBJ_BLOB)
@@ -807,11 +805,10 @@ static int check_collison(struct object_entry *entry)
 
 	memset(&data, 0, sizeof(data));
 	data.entry = entry;
-	data.st = odb_read_object_stream(the_repository->objects, &entry->idx.oid,
-					 &type, &size, NULL);
+	data.st = odb_read_object_stream(the_repository->objects, &entry->idx.oid, NULL);
 	if (!data.st)
 		return -1;
-	if (size != entry->size || type != entry->type)
+	if (data.st->size != entry->size || data.st->type != entry->type)
 		die(_("SHA1 COLLISION FOUND WITH %s !"),
 		    oid_to_hex(&entry->idx.oid));
 	unpack_data(entry, compare_objects, &data);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f6c01bc4e0..2044378521 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -521,9 +521,11 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		    oe_size_greater_than(&to_pack, entry,
 					 repo_settings_get_big_file_threshold(the_repository)) &&
 		    (st = odb_read_object_stream(the_repository->objects, &entry->idx.oid,
-						 &type, &size, NULL)) != NULL)
+						 NULL)) != NULL) {
 			buf = NULL;
-		else {
+			type = st->type;
+			size = st->size;
+		} else {
 			buf = odb_read_object(the_repository->objects,
 					      &entry->idx.oid, &type,
 					      &size);
diff --git a/object-file.c b/object-file.c
index 4b46cf5b71..89ebe08b66 100644
--- a/object-file.c
+++ b/object-file.c
@@ -132,19 +132,17 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 int stream_object_signature(struct repository *r, const struct object_id *oid)
 {
 	struct object_id real_oid;
-	unsigned long size;
-	enum object_type obj_type;
 	struct odb_read_stream *st;
 	struct git_hash_ctx c;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
-	st = odb_read_object_stream(r->objects, oid, &obj_type, &size, NULL);
+	st = odb_read_object_stream(r->objects, oid, NULL);
 	if (!st)
 		return -1;
 
 	/* Generate the header */
-	hdrlen = format_object_header(hdr, sizeof(hdr), obj_type, size);
+	hdrlen = format_object_header(hdr, sizeof(hdr), st->type, st->size);
 
 	/* Sha1.. */
 	r->hash_algo->init_fn(&c);
diff --git a/odb/streaming.c b/odb/streaming.c
index a7ee50dc34..efd8f1f473 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -214,8 +214,6 @@ ssize_t odb_read_stream_read(struct odb_read_stream *st, void *buf, size_t sz)
 
 struct odb_read_stream *odb_read_object_stream(struct object_database *odb,
 					       const struct object_id *oid,
-					       enum object_type *type,
-					       unsigned long *size,
 					       struct stream_filter *filter)
 {
 	struct odb_read_stream *st;
@@ -236,8 +234,6 @@ struct odb_read_stream *odb_read_object_stream(struct object_database *odb,
 		st = nst;
 	}
 
-	*size = st->size;
-	*type = st->type;
 	return st;
 }
 
@@ -248,18 +244,16 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 			  int can_seek)
 {
 	struct odb_read_stream *st;
-	enum object_type type;
-	unsigned long sz;
 	ssize_t kept = 0;
 	int result = -1;
 
-	st = odb_read_object_stream(odb, oid, &type, &sz, filter);
+	st = odb_read_object_stream(odb, oid, filter);
 	if (!st) {
 		if (filter)
 			free_stream_filter(filter);
 		return result;
 	}
-	if (type != OBJ_BLOB)
+	if (st->type != OBJ_BLOB)
 		goto close_and_exit;
 	for (;;) {
 		char buf[1024 * 16];
diff --git a/odb/streaming.h b/odb/streaming.h
index 2dce2e359f..8220e8de3c 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -25,16 +25,13 @@ struct odb_read_stream {
 };
 
 /*
- * Create a new object stream for the given object database. Populates the type
- * and size pointers with the object's info. An optional filter can be used to
- * transform the object's content.
+ * Create a new object stream for the given object database. An optional filter
+ * can be used to transform the object's content.
  *
  * Returns the stream on success, a `NULL` pointer otherwise.
  */
 struct odb_read_stream *odb_read_object_stream(struct object_database *odb,
 					       const struct object_id *oid,
-					       enum object_type *type,
-					       unsigned long *size,
 					       struct stream_filter *filter);
 
 /*

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

