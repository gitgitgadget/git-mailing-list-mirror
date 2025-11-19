Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA81320A03
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538502; cv=none; b=QjDwdNPwEDAbyPnpPOH8kroaQmyQjHDl+rtT7DxH4jjhQ5Nbw+OXkWeNhSAICBITmAcOOI9hCQAO527Ea/P/nBSJq44yumKs+KrJrfW7hp82rwWXQIBKVlXV1EIe5IWwt6ZJymFqFEPalkuUjTxAu2L5YFohwIrvLsLcEvbiGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538502; c=relaxed/simple;
	bh=oBRd6ZkIOliJM/4mr840LyA+/uPvmiuFeMPOlIAefHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLkDp94yukL0PizbDFg5WmugsrP4qTRJ10nztVioSof9g7LhgoWJgqo82dKvXSivHJybKcOjraKNSXJG3o30x3xuK7bQfDUeCU3gnoVOE17Cue0J9svnZ7M5fyZhjNJZ4pX2jSVwfIPPQvfDIlnZhb48t6gS7cU/R0IhmpHEdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dyLr0zq7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKRlOcKS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dyLr0zq7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKRlOcKS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 28B9EEC00B4
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 02:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538499;
	 x=1763624899; bh=gzQFw/SFoJpUNt/fp9YHiDDePkoWCZo6Ao8Yt7xF9Dw=; b=
	dyLr0zq78gNh/dQyPyexNWAAkrIf+dMVrqceVCyhK2WNuXT6BFCfAvsbzetN5q0M
	BAAijyhuB1oLAfzgUw+qMseEJuhYMd0adbIReY0oCCGVtwEQ5BPnFcCacjzh+R8B
	Bn1WOsKfPptDMi9YXf3suNXVEO8T9rkPNZxs94SCbiVphpgAbthu6QdiSep+QTVZ
	CWdN8DCM+vVZCIXoGkFAJCEwe2BlJv6uHmHul07P6Yr3l/H9JDq0/Ye3ucuK95/H
	zP6FJPdWLI/jiwJpBB62hvqNJG8Ad5Hjvs22KX/vGCBf/tgffolnvyL+k2M2sX/h
	eDg8FruSZd7EpUXOk17hpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538499; x=
	1763624899; bh=gzQFw/SFoJpUNt/fp9YHiDDePkoWCZo6Ao8Yt7xF9Dw=; b=S
	KRlOcKS44eJ9eraumeNaMD3tAGr17wfa2AiP4lS9g0clD6KPAGE2VllKK3BKTb2g
	I7CAVE6juzLRFHi3uJZUzkzDPmB5+TBjPZJ48aul4rfhWiPaYPy2pjYSVv5w/STU
	sK7Lu/FUKx2Y5WHQ4mofwyIqEaig63Amr8VwP8MqWj2F9/tzDcIs4VJxcaqO7CkH
	rFA2aFFu+Z44FKxBm1vopjEG3F1OLoaxqyksGHG0QfyREg12+LGM2KPhfb2XwIkz
	2VyWvmCS/0KsSzqSrLD6QWCm4tafVrrN6xUGP7zXBNk4GKixr77htizZjNVD02gv
	46aWjGK2z0Bzh4QMEPNSg==
X-ME-Sender: <xms:Q3YdaeKl9pDQbvIF09zTy7Uppni3ijpJGyqvt7nho0NduDIR982RXA>
    <xme:Q3YdadHBBeEA11tQSVyWaz3FcpRqFMGMKPs2ZrTc28v2heFIHkIFaA4k2yWEsn7sT
    L7dlWs3a5TKNBxdSTZE59bUcnT6CbpYEs12K7ZkOBu96lhLtEry>
X-ME-Received: <xmr:Q3YdaUW3Y2IrDLA_NGZ9jEhWKfTfy7u1FZqSIsp7M44ky2vgrFDezU-vTNxKtilKR0pVODHnBRDxJYNJNv4Hi7o2w0P-2XV_P8fDdg6WJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Q3YdaYiHLq1Zay6V9UyvrtD3t2kRP317ReyR3T0l6lZh-fUwsGLecg>
    <xmx:Q3YdaVTaGA0Zm6LFFiD5KqmjtCpZ75pozD_85R1WoURMUXQtc7k-ig>
    <xmx:Q3YdabFa18bvaOixuh5xM7w0kJKwQ3Kc5WkeSllCTN84ME1Qc6Fy6g>
    <xmx:Q3YdadmsV01gt29wr7cwyoiKPJbEX0vnQ5PANDseKvkG4WjkDHJ09w>
    <xmx:Q3YdafrIcyHIJl0v1rCI4WBHX8IP1gidknTX5L_lqFpGekby8PrYWG2k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1fe00592 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:48:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:15 +0100
Subject: [PATCH 15/18] streaming: move logic to read loose objects streams
 into backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-15-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 3f94bd2a03..216576857f 100644
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
@@ -454,7 +323,7 @@ static int istream_source(struct odb_read_stream **out,
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next)
-		if (!open_istream_loose(out, source, oid))
+		if (!odb_source_loose_read_object_stream(out, source, oid))
 			return 0;
 
 	return open_istream_incore(out, r, oid);

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

