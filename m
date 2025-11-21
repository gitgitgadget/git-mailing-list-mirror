Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11013385BE
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710920; cv=none; b=P7BuiabxlLHuy03ez5lWfCxuiOeAYHZqyFzVjy140i0Coivxrp09ubWlXGEsmUE1TRV20mhYviXUoUHAgADU/6u0gftwozKHYubeEk56hkv7a5lqzIOWwUjCniZtRNcGFMqBm2O0CFHYWUF6zTL0/yxvY/c0BTRcfc1eUNK4JF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710920; c=relaxed/simple;
	bh=3QdvO2UyKoJT7xM0GN4yt2v4CYCiB2tQnEqygHLP7Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3aF75ritZHo2LWnz60ryc5MxOvLwODMcnl+cfsgWI8epUkrAPp/71hs/tuSUS6arLu0aLYKc9ydCyMa+fb2taEP5WrRZzzxdfqnwPLMOjFl80u0Twxti8ckNG8uQLEETPi5oSYq3v2PKAQ1A+0GWp/WeB2V7RetQsth3kpx+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H9q6E73r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DRoBLxgm; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H9q6E73r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DRoBLxgm"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 1FE631D0015F;
	Fri, 21 Nov 2025 02:41:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 21 Nov 2025 02:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710917;
	 x=1763797317; bh=2DzCRtj3TdHudv73zc8hWqFDu2BEi97/uwBWzzzI7oY=; b=
	H9q6E73r0cIddzU4eOdAtgojfA1LbVnGj9MU5D4zZrlVXtHaDislYSbI3EDqGzzm
	rYOgOQ2nNY+1xxSGKfXu/MqOvrMnU9x7cE7WLNH9G8rnIOXmgDycQPl3wXr77kib
	u3W+po6GsEj9RJt7IBKjJdHdiIZmgLtJ447c1FZhpiTYyxOdYXbKjToPkmY1XPBj
	vOmCNYeOXzSWH3qkEWPyHhxlYjREuGmyRq83FPASCsVXcG83ZXIGq2x3I/aINyT6
	n7Dl1VvqRd4CJl5T3fhTldI8CaQl6GJv4VHYnosaylAw4jMkDfftXW1VTAQqMl17
	d9vnCWrrWS2+tg/VVtS51g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710917; x=
	1763797317; bh=2DzCRtj3TdHudv73zc8hWqFDu2BEi97/uwBWzzzI7oY=; b=D
	RoBLxgm5N20gQ2zfB79/He/80IgcC4TtkJ7u+uyQcc7s8oG8LdqPNV4vy/qHrxek
	8wD2xnNdR4EnFwxS1RdO2PI/3zTec+Cm13E3TOxEoVsCqhzO9Yy5C/RMWS5cyB1p
	BpMw8HOse7LGF9rTJ79/TaekWRdBMlJoLC9QSMPyS479K9UUudoOQI1hKqir1hqh
	Fcam4EwoXE0K8MLd3gx2G02YPfmt27IAJ55VcJXWv/lTS2R3+QKqv8Ds1slvEwh7
	wx8Fwwkz/5DoMZbqVNfsiohPmSblTg6x8Htois+lXBKvTEZmWO+f9RhMZFfqYaQS
	rKMQiRF1V1GOlsVfn8OrA==
X-ME-Sender: <xms:xRcgaSeI2q2nhfE57Ejhq5LsmgOrb1noVwO4moMtzK93zxrpU5-vig>
    <xme:xRcgaTr6JGS72Fb9oinrL1xfKNDUSZ-hZgZeeZ1EjXf1HONGIHa2oBYV0TgVqey3y
    LIoEaRUUZ-Sq2J2M5wDRJht6fHtRTAhtVJicDiw7p9lN2aVYrafsg>
X-ME-Received: <xmr:xRcgaQ6vhAqT8hMwobUINqGmuz7ADLqOg-AfvsiRWI-yVYfDUWALIlbkSWAAjgN56zz1jepx1W8Ndb0-AQMF3HV43lR77dti8x4aSG28oXvt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:xRcgaZqgdx3-PbabbBD_nIZ7jW031oDtAa2gM0TmCXJvyfpHGlrWkA>
    <xmx:xRcgaSg5kwqv8C91ITvqYuLWuOlqe--0y-KoCKubKMvt38MTeWQB1A>
    <xmx:xRcgaTLHejFgQqZTZHooNcaPOkB4HyrawuWMpKKBy8VTJL9UyqgvpQ>
    <xmx:xRcgaSDGKMwHbCx2iJiiDHzyuTLRkmWRz7LP9KhUxBy6C4eU8P0GpQ>
    <xmx:xRcgaSFmWDJcnuR0B1s0HeybOpRXoBXh_eGBqZ6dr7FFT6epUW_y0-rd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b9f6939c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:41:00 +0100
Subject: [PATCH v2 15/19] streaming: move logic to read loose objects
 streams into backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-15-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Move the logic to read loose object streams into the respective
subsystem. This allows us to make a couple of function declarations
private.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 167 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 object-file.h |  42 ++-------------
 streaming.c   | 133 +---------------------------------------------
 3 files changed, 164 insertions(+), 178 deletions(-)

diff --git a/object-file.c b/object-file.c
index b62b21a452..8c67847fea 100644
--- a/object-file.c
+++ b/object-file.c
@@ -234,9 +234,9 @@ static void *map_fd(int fd, const char *path, unsigned long *size)
 	return map;
 }
 
-void *odb_source_loose_map_object(struct odb_source *source,
-				  const struct object_id *oid,
-				  unsigned long *size)
+static void *odb_source_loose_map_object(struct odb_source *source,
+					 const struct object_id *oid,
+					 unsigned long *size)
 {
 	const char *p;
 	int fd = open_loose_object(source->loose, oid, &p);
@@ -246,11 +246,29 @@ void *odb_source_loose_map_object(struct odb_source *source,
 	return map_fd(fd, p, size);
 }
 
-enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
-						    unsigned char *map,
-						    unsigned long mapsize,
-						    void *buffer,
-						    unsigned long bufsiz)
+enum unpack_loose_header_result {
+	ULHR_OK,
+	ULHR_BAD,
+	ULHR_TOO_LONG,
+};
+
+/**
+ * unpack_loose_header() initializes the data stream needed to unpack
+ * a loose object header.
+ *
+ * Returns:
+ *
+ * - ULHR_OK on success
+ * - ULHR_BAD on error
+ * - ULHR_TOO_LONG if the header was too long
+ *
+ * It will only parse up to MAX_HEADER_LEN bytes.
+ */
+static enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
+							   unsigned char *map,
+							   unsigned long mapsize,
+							   void *buffer,
+							   unsigned long bufsiz)
 {
 	int status;
 
@@ -329,11 +347,18 @@ static void *unpack_loose_rest(git_zstream *stream,
 }
 
 /*
+ * parse_loose_header() parses the starting "<type> <len>\0" of an
+ * object. If it doesn't follow that format -1 is returned. To check
+ * the validity of the <type> populate the "typep" in the "struct
+ * object_info". It will be OBJ_BAD if the object type is unknown. The
+ * parsed <len> can be retrieved via "oi->sizep", and from there
+ * passed to unpack_loose_rest().
+ *
  * We used to just use "sscanf()", but that's actually way
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-int parse_loose_header(const char *hdr, struct object_info *oi)
+static int parse_loose_header(const char *hdr, struct object_info *oi)
 {
 	const char *type_buf = hdr;
 	size_t size;
@@ -1976,3 +2001,127 @@ void odb_source_loose_free(struct odb_source_loose *loose)
 	loose_object_map_clear(&loose->map);
 	free(loose);
 }
+
+struct odb_loose_read_stream {
+	struct odb_read_stream base;
+	git_zstream z;
+	enum {
+		ODB_LOOSE_READ_STREAM_INUSE,
+		ODB_LOOSE_READ_STREAM_DONE,
+		ODB_LOOSE_READ_STREAM_ERROR,
+	} z_state;
+	void *mapped;
+	unsigned long mapsize;
+	char hdr[32];
+	int hdr_avail;
+	int hdr_used;
+};
+
+static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t sz)
+{
+	struct odb_loose_read_stream *st = (struct odb_loose_read_stream *)_st;
+	size_t total_read = 0;
+
+	switch (st->z_state) {
+	case ODB_LOOSE_READ_STREAM_DONE:
+		return 0;
+	case ODB_LOOSE_READ_STREAM_ERROR:
+		return -1;
+	default:
+		break;
+	}
+
+	if (st->hdr_used < st->hdr_avail) {
+		size_t to_copy = st->hdr_avail - st->hdr_used;
+		if (sz < to_copy)
+			to_copy = sz;
+		memcpy(buf, st->hdr + st->hdr_used, to_copy);
+		st->hdr_used += to_copy;
+		total_read += to_copy;
+	}
+
+	while (total_read < sz) {
+		int status;
+
+		st->z.next_out = (unsigned char *)buf + total_read;
+		st->z.avail_out = sz - total_read;
+		status = git_inflate(&st->z, Z_FINISH);
+
+		total_read = st->z.next_out - (unsigned char *)buf;
+
+		if (status == Z_STREAM_END) {
+			git_inflate_end(&st->z);
+			st->z_state = ODB_LOOSE_READ_STREAM_DONE;
+			break;
+		}
+		if (status != Z_OK && (status != Z_BUF_ERROR || total_read < sz)) {
+			git_inflate_end(&st->z);
+			st->z_state = ODB_LOOSE_READ_STREAM_ERROR;
+			return -1;
+		}
+	}
+	return total_read;
+}
+
+static int close_istream_loose(struct odb_read_stream *_st)
+{
+	struct odb_loose_read_stream *st = (struct odb_loose_read_stream *)_st;
+	if (st->z_state == ODB_LOOSE_READ_STREAM_INUSE)
+		git_inflate_end(&st->z);
+	munmap(st->mapped, st->mapsize);
+	return 0;
+}
+
+int odb_source_loose_read_object_stream(struct odb_read_stream **out,
+					struct odb_source *source,
+					const struct object_id *oid)
+{
+	struct object_info oi = OBJECT_INFO_INIT;
+	struct odb_loose_read_stream *st;
+	unsigned long mapsize;
+	void *mapped;
+
+	mapped = odb_source_loose_map_object(source, oid, &mapsize);
+	if (!mapped)
+		return -1;
+
+	/*
+	 * Note: we must allocate this structure early even though we may still
+	 * fail. This is because we need to initialize the zlib stream, and it
+	 * is not possible to copy the stream around after the fact because it
+	 * has self-referencing pointers.
+	 */
+	CALLOC_ARRAY(st, 1);
+
+	switch (unpack_loose_header(&st->z, mapped, mapsize, st->hdr,
+				    sizeof(st->hdr))) {
+	case ULHR_OK:
+		break;
+	case ULHR_BAD:
+	case ULHR_TOO_LONG:
+		goto error;
+	}
+
+	oi.sizep = &st->base.size;
+	oi.typep = &st->base.type;
+
+	if (parse_loose_header(st->hdr, &oi) < 0 || st->base.type < 0)
+		goto error;
+
+	st->mapped = mapped;
+	st->mapsize = mapsize;
+	st->hdr_used = strlen(st->hdr) + 1;
+	st->hdr_avail = st->z.total_out;
+	st->z_state = ODB_LOOSE_READ_STREAM_INUSE;
+	st->base.close = close_istream_loose;
+	st->base.read = read_istream_loose;
+
+	*out = &st->base;
+
+	return 0;
+error:
+	git_inflate_end(&st->z);
+	munmap(st->mapped, st->mapsize);
+	free(st);
+	return -1;
+}
diff --git a/object-file.h b/object-file.h
index eeffa67bbd..1229d5f675 100644
--- a/object-file.h
+++ b/object-file.h
@@ -16,6 +16,8 @@ enum {
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
+struct object_info;
+struct odb_read_stream;
 struct odb_source;
 
 struct odb_source_loose {
@@ -47,9 +49,9 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
 				      struct object_info *oi, int flags);
 
-void *odb_source_loose_map_object(struct odb_source *source,
-				  const struct object_id *oid,
-				  unsigned long *size);
+int odb_source_loose_read_object_stream(struct odb_read_stream **out,
+					struct odb_source *source,
+					const struct object_id *oid);
 
 /*
  * Return true iff an object database source has a loose object
@@ -143,40 +145,6 @@ int for_each_loose_object(struct object_database *odb,
 int format_object_header(char *str, size_t size, enum object_type type,
 			 size_t objsize);
 
-/**
- * unpack_loose_header() initializes the data stream needed to unpack
- * a loose object header.
- *
- * Returns:
- *
- * - ULHR_OK on success
- * - ULHR_BAD on error
- * - ULHR_TOO_LONG if the header was too long
- *
- * It will only parse up to MAX_HEADER_LEN bytes.
- */
-enum unpack_loose_header_result {
-	ULHR_OK,
-	ULHR_BAD,
-	ULHR_TOO_LONG,
-};
-enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
-						    unsigned char *map,
-						    unsigned long mapsize,
-						    void *buffer,
-						    unsigned long bufsiz);
-
-/**
- * parse_loose_header() parses the starting "<type> <len>\0" of an
- * object. If it doesn't follow that format -1 is returned. To check
- * the validity of the <type> populate the "typep" in the "struct
- * object_info". It will be OBJ_BAD if the object type is unknown. The
- * parsed <len> can be retrieved via "oi->sizep", and from there
- * passed to unpack_loose_rest().
- */
-struct object_info;
-int parse_loose_header(const char *hdr, struct object_info *oi);
-
 int force_object_loose(struct odb_source *source,
 		       const struct object_id *oid, time_t mtime);
 
diff --git a/streaming.c b/streaming.c
index 586c20eac6..cc67d56cd4 100644
--- a/streaming.c
+++ b/streaming.c
@@ -114,137 +114,6 @@ static struct odb_read_stream *attach_stream_filter(struct odb_read_stream *st,
 	return &fs->base;
 }
 
-/*****************************************************************
- *
- * Loose object stream
- *
- *****************************************************************/
-
-struct odb_loose_read_stream {
-	struct odb_read_stream base;
-	git_zstream z;
-	enum {
-		ODB_LOOSE_READ_STREAM_INUSE,
-		ODB_LOOSE_READ_STREAM_DONE,
-		ODB_LOOSE_READ_STREAM_ERROR,
-	} z_state;
-	void *mapped;
-	unsigned long mapsize;
-	char hdr[32];
-	int hdr_avail;
-	int hdr_used;
-};
-
-static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t sz)
-{
-	struct odb_loose_read_stream *st = (struct odb_loose_read_stream *)_st;
-	size_t total_read = 0;
-
-	switch (st->z_state) {
-	case ODB_LOOSE_READ_STREAM_DONE:
-		return 0;
-	case ODB_LOOSE_READ_STREAM_ERROR:
-		return -1;
-	default:
-		break;
-	}
-
-	if (st->hdr_used < st->hdr_avail) {
-		size_t to_copy = st->hdr_avail - st->hdr_used;
-		if (sz < to_copy)
-			to_copy = sz;
-		memcpy(buf, st->hdr + st->hdr_used, to_copy);
-		st->hdr_used += to_copy;
-		total_read += to_copy;
-	}
-
-	while (total_read < sz) {
-		int status;
-
-		st->z.next_out = (unsigned char *)buf + total_read;
-		st->z.avail_out = sz - total_read;
-		status = git_inflate(&st->z, Z_FINISH);
-
-		total_read = st->z.next_out - (unsigned char *)buf;
-
-		if (status == Z_STREAM_END) {
-			git_inflate_end(&st->z);
-			st->z_state = ODB_LOOSE_READ_STREAM_DONE;
-			break;
-		}
-		if (status != Z_OK && (status != Z_BUF_ERROR || total_read < sz)) {
-			git_inflate_end(&st->z);
-			st->z_state = ODB_LOOSE_READ_STREAM_ERROR;
-			return -1;
-		}
-	}
-	return total_read;
-}
-
-static int close_istream_loose(struct odb_read_stream *_st)
-{
-	struct odb_loose_read_stream *st = (struct odb_loose_read_stream *)_st;
-	if (st->z_state == ODB_LOOSE_READ_STREAM_INUSE)
-		git_inflate_end(&st->z);
-	munmap(st->mapped, st->mapsize);
-	return 0;
-}
-
-static int open_istream_loose(struct odb_read_stream **out,
-			      struct odb_source *source,
-			      const struct object_id *oid)
-{
-	struct object_info oi = OBJECT_INFO_INIT;
-	struct odb_loose_read_stream *st;
-	unsigned long mapsize;
-	void *mapped;
-
-	mapped = odb_source_loose_map_object(source, oid, &mapsize);
-	if (!mapped)
-		return -1;
-
-	/*
-	 * Note: we must allocate this structure early even though we may still
-	 * fail. This is because we need to initialize the zlib stream, and it
-	 * is not possible to copy the stream around after the fact because it
-	 * has self-referencing pointers.
-	 */
-	CALLOC_ARRAY(st, 1);
-
-	switch (unpack_loose_header(&st->z, mapped, mapsize, st->hdr,
-				    sizeof(st->hdr))) {
-	case ULHR_OK:
-		break;
-	case ULHR_BAD:
-	case ULHR_TOO_LONG:
-		goto error;
-	}
-
-	oi.sizep = &st->base.size;
-	oi.typep = &st->base.type;
-
-	if (parse_loose_header(st->hdr, &oi) < 0 || st->base.type < 0)
-		goto error;
-
-	st->mapped = mapped;
-	st->mapsize = mapsize;
-	st->hdr_used = strlen(st->hdr) + 1;
-	st->hdr_avail = st->z.total_out;
-	st->z_state = ODB_LOOSE_READ_STREAM_INUSE;
-	st->base.close = close_istream_loose;
-	st->base.read = read_istream_loose;
-
-	*out = &st->base;
-
-	return 0;
-error:
-	git_inflate_end(&st->z);
-	munmap(st->mapped, st->mapsize);
-	free(st);
-	return -1;
-}
-
-
 /*****************************************************************
  *
  * Non-delta packed object stream
@@ -455,7 +324,7 @@ static int istream_source(struct odb_read_stream **out,
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next)
-		if (!open_istream_loose(out, source, oid))
+		if (!odb_source_loose_read_object_stream(out, source, oid))
 			return 0;
 
 	return open_istream_incore(out, r, oid);

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

