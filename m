Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0463141A4EF
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828359; cv=none; b=BsB5Kvn8MSAbYNpHFfIIBtPRxZoo/C1Kj6i0c8VIFphTxogUOR+8EVMsLcXkHb6h3y1vAUYpSiaDuzUISA8qyibeoBUROqNMxw7DRdAuMtw52nzzjNLd26AXWas5WFacWUnBGBTIQelvFuOlKAVWTMpUgF/C/7xBICC8nPJ5oiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828359; c=relaxed/simple;
	bh=8pMbIjUTg8R2QUfUSt/kioULM2PKavmgNzplea0beQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i6Vv4Lo3MjkL6TF7iT2WwRHB9Xo/okaERpfXHZQl6jy7JUr2w5Y2Iac91ZIHMrk9+QTECIjEYV8EuJZrtuyBf3WSZYe3JZwfcNq16grIMSYaq4xgqcbuTCMnCedNe8N3SpUV8vmjf7H6ybB7ZASKQQUVFiqKBQQuiCZ6qOZfByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M7ArxmX9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QySbK0jz; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M7ArxmX9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QySbK0jz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 868BA7A014B
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 03:25:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 03:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785828356;
	 x=1785914756; bh=yAqZhlb7DlvbLsaa4GIT3/qWLGKuRt6ujqtkIaPj3j4=; b=
	M7ArxmX96eTlHErBcZfR8FAOE3Kcj3wnLYkG0T6/jjWSnLXOHGp4a4uQAlHXEaYt
	4akP0os8dBEczURzg/PEVjJHWI5qGE+2lc1csgL06Pz4819N1BE80+9zCigM7W8C
	Ra0NaC1KgzjumxhpvSLKcl1S+725se5nYI3yHkuUojVh3Gybq2TFykdh7jgZBa+s
	C5QdYhDmdc4wbLIYNTj5aui62e8EAq0FkeF7cPXTNHvjeR8Zugbuz8IoCwMJQK49
	TTo9sIGNp1lgTtEgxto5uwQfcTkWhEcih5BDMprny9BS9LegjIlBo3CTu96a8cbf
	6JdPiFP3joLPQU0W581XiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785828356; x=
	1785914756; bh=yAqZhlb7DlvbLsaa4GIT3/qWLGKuRt6ujqtkIaPj3j4=; b=Q
	ySbK0jzBzpJA1z910P8pdN0rQnJMAHc2/d8XKRnBrk/l+QQoODQXVIz72prol2/t
	QNyof/ArAbND6dCKw7avKdKgoCeBa+VE/Yo+w3AXBl50QXwRTa6MROdT0xVQgLtd
	fqvHaRxvHkwSusz7FEoyIkPiSNA5p8WA2IDGCRPNhoGkx+hqzhXQbdKAzJM8w8u0
	eWBnWHgLZmDUE/Oi6qU4e9lLF6TOy8fP+M0sCb2ifSRoesMVWd5v9N9bTW8DcgQh
	LHB8zpMTlB0atLHv0s6iUhy9heDQKwD5YOB4fp6RSFtgPi5GzWoH4QrnGpYqzcIk
	bNnrkZoibdKJ9ZShlHXsQ==
X-ME-Sender: <xms:BJRxame0hA_x33kgVSwRd5pK7AZy5MyCqJ3RJIHCdP_KHE7bxbKrxw>
    <xme:BJRxanJuKR3GEMETXj-oTSL8RpEgVRzRUTcQLRieLtcXJ_c-zC4IW_8ygstT8Sq1m
    5-1uEEgjYgMrzYG7QG6R_RBxl4SsjaL78scyv654HmYabosqd14XsQ>
X-ME-Received: <xmr:BJRxatLdGM0DDCc4MV8vxVOMKjZrhf4GgPt2lSuO1N4N1diWhivJdoqvli37wC_HRmffeQkR6hrahECZJk2sgTYUvBQs8Mmbh2B4A82J>
X-ME-Proxy-Cause: dmFkZTGaw7KkDjgajDpaxV2Iw8X+9GB+eFUuTHytPlpk9e4DeA/0fhZcyyfCQhNwmklQVQ
    V0lleKWUq93kXUbkfpvvAaxWPVHegpYZFmUESv3Yg0zVt80t33sC3bXTg0imQnqoZCksYu
    ryHqT6JXukAeu3/FAEQgfQ1tWX90p6cJ6AxE7v2fYE0wlKD/+2hT0gPxBYcIMy2vT9FU4r
    YmXNIDVxGtS52A/KchwI/j00nDOcaPI1mKnJl9Gef/0JJz5q3PXkc9lpbofiU/v+aemSgw
    grY96ll1stIVp2o2Ggc5KSfGQu7H/AL20kNlEhEeiOM2DLNJcBD27ECK9hkrmJ52ghtKpn
    XsGym+6TorU/e+DKsLWLPf+v7bP07zDQIhHJZOpehRai+M770/yAG+s9QhbuewNFLwRa4l
    ZoxPUUUgQ1NP5/O+ujl57d1Jmz9lCWmVHXrKfSJCO+6UBe2O6bz7v1vIWBOf1KXcYGdYaB
    fTp+YUQNNvOnJbRZLZXMp0o8Zp4dG8cWZ7o7tLKu+/XD/HrnBaxgooIgSqyV+SbfrRxHHc
    dk8A07ggGx2Mew8y52y6PAgacH4/Ox0kDtBGXxDNfLPyv0rpM5doJRmogUDHgbYCCQK8j8
    NzPBg1jMQ4eJBi+YhAMZ8TtB+L2rbhBjyjQer3yIMn4UG8ftrhcOnk88T+aw
X-ME-Proxy: <xmx:BJRxapGf7qyHEgGTEJmzVZFYS47HCIlgusG3fxddjIrluswestr1vw>
    <xmx:BJRxaiksx32Dh-G5nRuOPPV-zwk5RVOdVXdRb13EFVEHsEuO2BQ3dQ>
    <xmx:BJRxamKQ8YTcg-miiR3QV4Zq8SZuiRIOGTI6H4pM6CT8BpzeDGbgFw>
    <xmx:BJRxajaP6cdk64MSAVSSoq2ILFL3IcnI18F5_ohH4b6sHf04i-5HVg>
    <xmx:BJRxakP1fdW1hUt_o3U7WjbAysjF0mAFLqc0Z8jFGDiwEET8SyWs1JGi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 4 Aug 2026 03:25:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d77f43fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 4 Aug 2026 07:25:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 04 Aug 2026 09:25:32 +0200
Subject: [PATCH 4/7] odb/streaming: rename `struct odb_read_stream`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-pks-odb-stream-unification-v1-4-86d70e82345e@pks.im>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
In-Reply-To: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Rename `struct odb_read_stream` to just `struct odb_stream`. This
prepares for unification of the two different types of streams, as these
provide the same functionality with the preceding refactorings.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive-tar.c                 |  6 +++---
 archive-zip.c                 | 10 ++++-----
 builtin/index-pack.c          |  6 +++---
 builtin/pack-objects.c        | 14 ++++++-------
 object-file.c                 |  4 ++--
 object-file.h                 |  2 +-
 object.c                      |  6 +++---
 odb/source-files.c            |  2 +-
 odb/source-inmemory.c         |  8 ++++----
 odb/source-loose.c            |  8 ++++----
 odb/source-packed.c           |  2 +-
 odb/source.h                  |  6 +++---
 odb/streaming.c               | 48 +++++++++++++++++++++----------------------
 odb/streaming.h               | 24 +++++++++++-----------
 pack-check.c                  |  4 ++--
 packfile.c                    |  8 ++++----
 packfile.h                    |  4 ++--
 t/unit-tests/u-odb-inmemory.c | 12 +++++------
 18 files changed, 87 insertions(+), 87 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 0fc70d13a8..df2d7fb8e9 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -129,7 +129,7 @@ static void write_trailer(void)
  */
 static int stream_blocked(struct repository *r, const struct object_id *oid)
 {
-	struct odb_read_stream *st;
+	struct odb_stream *st;
 	char buf[BLOCKSIZE];
 	ssize_t readlen;
 
@@ -137,12 +137,12 @@ static int stream_blocked(struct repository *r, const struct object_id *oid)
 	if (!st)
 		return error(_("cannot stream blob %s"), oid_to_hex(oid));
 	for (;;) {
-		readlen = odb_read_stream_read(st, buf, sizeof(buf));
+		readlen = odb_stream_read(st, buf, sizeof(buf));
 		if (readlen <= 0)
 			break;
 		do_write_blocked(buf, readlen);
 	}
-	odb_read_stream_close(st);
+	odb_stream_close(st);
 	if (!readlen)
 		finish_record();
 	return readlen;
diff --git a/archive-zip.c b/archive-zip.c
index 97ea8d60d6..8095fd04d5 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -309,7 +309,7 @@ static int write_zip_entry(struct archiver_args *args,
 	enum zip_method method;
 	unsigned char *out;
 	void *deflated = NULL;
-	struct odb_read_stream *stream = NULL;
+	struct odb_stream *stream = NULL;
 	unsigned long flags = 0;
 	int is_binary = -1;
 	const char *path_without_prefix = path + args->baselen;
@@ -428,7 +428,7 @@ static int write_zip_entry(struct archiver_args *args,
 		ssize_t readlen;
 
 		for (;;) {
-			readlen = odb_read_stream_read(stream, buf, sizeof(buf));
+			readlen = odb_stream_read(stream, buf, sizeof(buf));
 			if (readlen <= 0)
 				break;
 			crc = crc32(crc, buf, readlen);
@@ -438,7 +438,7 @@ static int write_zip_entry(struct archiver_args *args,
 							    buf, readlen);
 			write_or_die(1, buf, readlen);
 		}
-		odb_read_stream_close(stream);
+		odb_stream_close(stream);
 		if (readlen)
 			return readlen;
 
@@ -461,7 +461,7 @@ static int write_zip_entry(struct archiver_args *args,
 		zstream.avail_out = sizeof(compressed);
 
 		for (;;) {
-			readlen = odb_read_stream_read(stream, buf, sizeof(buf));
+			readlen = odb_stream_read(stream, buf, sizeof(buf));
 			if (readlen <= 0)
 				break;
 			crc = crc32(crc, buf, readlen);
@@ -485,7 +485,7 @@ static int write_zip_entry(struct archiver_args *args,
 			}
 
 		}
-		odb_read_stream_close(stream);
+		odb_stream_close(stream);
 		if (readlen)
 			return readlen;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bc86925ad0..7226da3e65 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -763,7 +763,7 @@ static void find_ref_delta_children(const struct object_id *oid,
 
 struct compare_data {
 	struct object_entry *entry;
-	struct odb_read_stream *st;
+	struct odb_stream *st;
 	unsigned char *buf;
 	unsigned long buf_size;
 };
@@ -780,7 +780,7 @@ static int compare_objects(const unsigned char *buf, unsigned long size,
 	}
 
 	while (size) {
-		ssize_t len = odb_read_stream_read(data->st, data->buf, size);
+		ssize_t len = odb_stream_read(data->st, data->buf, size);
 		if (len == 0)
 			die(_("SHA1 COLLISION FOUND WITH %s !"),
 			    oid_to_hex(&data->entry->idx.oid));
@@ -813,7 +813,7 @@ static int check_collison(struct object_entry *entry)
 		die(_("SHA1 COLLISION FOUND WITH %s !"),
 		    oid_to_hex(&entry->idx.oid));
 	unpack_data(entry, compare_objects, &data);
-	odb_read_stream_close(data.st);
+	odb_stream_close(data.st);
 	free(data.buf);
 	return 0;
 }
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ec5b6f206..683160c6bb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -411,7 +411,7 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	return stream.total_out;
 }
 
-static unsigned long write_large_blob_data(struct odb_read_stream *st, struct hashfile *f,
+static unsigned long write_large_blob_data(struct odb_stream *st, struct hashfile *f,
 					   const struct object_id *oid)
 {
 	git_zstream stream;
@@ -425,7 +425,7 @@ static unsigned long write_large_blob_data(struct odb_read_stream *st, struct ha
 	for (;;) {
 		ssize_t readlen;
 		int zret = Z_OK;
-		readlen = odb_read_stream_read(st, ibuf, sizeof(ibuf));
+		readlen = odb_stream_read(st, ibuf, sizeof(ibuf));
 		if (readlen == -1)
 			die(_("unable to read %s"), oid_to_hex(oid));
 
@@ -521,7 +521,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	unsigned hdrlen;
 	enum object_type type;
 	void *buf;
-	struct odb_read_stream *st = NULL;
+	struct odb_stream *st = NULL;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
 	if (!usable_delta) {
@@ -589,7 +589,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 			dheader[--pos] = 128 | (--ofs & 127);
 		if (limit && hdrlen + sizeof(dheader) - pos + datalen + hashsz >= limit) {
 			if (st)
-				odb_read_stream_close(st);
+				odb_stream_close(st);
 			free(buf);
 			return 0;
 		}
@@ -603,7 +603,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		 */
 		if (limit && hdrlen + hashsz + datalen + hashsz >= limit) {
 			if (st)
-				odb_read_stream_close(st);
+				odb_stream_close(st);
 			free(buf);
 			return 0;
 		}
@@ -613,7 +613,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	} else {
 		if (limit && hdrlen + datalen + hashsz >= limit) {
 			if (st)
-				odb_read_stream_close(st);
+				odb_stream_close(st);
 			free(buf);
 			return 0;
 		}
@@ -621,7 +621,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	}
 	if (st) {
 		datalen = write_large_blob_data(st, f, &entry->idx.oid);
-		odb_read_stream_close(st);
+		odb_stream_close(st);
 	} else {
 		hashwrite(f, buf, datalen);
 		free(buf);
diff --git a/object-file.c b/object-file.c
index 699a6a008c..5f6d584c35 100644
--- a/object-file.c
+++ b/object-file.c
@@ -122,7 +122,7 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 }
 
 int stream_object_signature(struct repository *r,
-			    struct odb_read_stream *st,
+			    struct odb_stream *st,
 			    const struct object_id *oid)
 {
 	struct object_id real_oid;
@@ -138,7 +138,7 @@ int stream_object_signature(struct repository *r,
 	git_hash_update(&c, hdr, hdrlen);
 	for (;;) {
 		char buf[1024 * 16];
-		ssize_t readlen = odb_read_stream_read(st, buf, sizeof(buf));
+		ssize_t readlen = odb_stream_read(st, buf, sizeof(buf));
 		if (readlen < 0)
 			return -1;
 		if (!readlen)
diff --git a/object-file.h b/object-file.h
index 805f2cfa28..f44758c4f8 100644
--- a/object-file.h
+++ b/object-file.h
@@ -101,7 +101,7 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
  * the streaming interface and rehash it to do the same.
  */
 int stream_object_signature(struct repository *r,
-			    struct odb_read_stream *stream,
+			    struct odb_stream *stream,
 			    const struct object_id *oid);
 
 enum finalize_object_file_flags {
diff --git a/object.c b/object.c
index 23b84aa7e2..37e6efee47 100644
--- a/object.c
+++ b/object.c
@@ -345,7 +345,7 @@ struct object *parse_object_with_flags(struct repository *r,
 	if ((!obj || obj->type == OBJ_NONE || obj->type == OBJ_BLOB) &&
 	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
 		if (!skip_hash) {
-			struct odb_read_stream *stream = odb_read_stream_open(r->objects, oid, NULL);
+			struct odb_stream *stream = odb_read_stream_open(r->objects, oid, NULL);
 
 			if (!stream) {
 				error(_("unable to open object stream for %s"), oid_to_hex(oid));
@@ -354,11 +354,11 @@ struct object *parse_object_with_flags(struct repository *r,
 
 			if (stream_object_signature(r, stream, repl) < 0) {
 				error(_("hash mismatch %s"), oid_to_hex(oid));
-				odb_read_stream_close(stream);
+				odb_stream_close(stream);
 				return NULL;
 			}
 
-			odb_read_stream_close(stream);
+			odb_stream_close(stream);
 		}
 		parse_blob_buffer(lookup_blob(r, oid));
 		return lookup_object(r, oid);
diff --git a/odb/source-files.c b/odb/source-files.c
index f51960bd71..f7b8c76549 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -63,7 +63,7 @@ static int odb_source_files_read_object_info(struct odb_source *source,
 	return -1;
 }
 
-static int odb_source_files_read_object_stream(struct odb_read_stream **out,
+static int odb_source_files_read_object_stream(struct odb_stream **out,
 					       struct odb_source *source,
 					       const struct object_id *oid)
 {
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 4f76db5496..4bee3ae699 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -73,12 +73,12 @@ static int odb_source_inmemory_read_object_info(struct odb_source *source,
 }
 
 struct odb_read_stream_inmemory {
-	struct odb_read_stream base;
+	struct odb_stream base;
 	const unsigned char *buf;
 	size_t offset;
 };
 
-static ssize_t odb_read_stream_inmemory_read(struct odb_read_stream *stream,
+static ssize_t odb_read_stream_inmemory_read(struct odb_stream *stream,
 					     char *buf, size_t buf_len)
 {
 	struct odb_read_stream_inmemory *inmemory =
@@ -94,12 +94,12 @@ static ssize_t odb_read_stream_inmemory_read(struct odb_read_stream *stream,
 	return bytes;
 }
 
-static int odb_read_stream_inmemory_close(struct odb_read_stream *stream UNUSED)
+static int odb_read_stream_inmemory_close(struct odb_stream *stream UNUSED)
 {
 	return 0;
 }
 
-static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
+static int odb_source_inmemory_read_object_stream(struct odb_stream **out,
 						  struct odb_source *source,
 						  const struct object_id *oid)
 {
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 5681a38f03..038defd905 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -278,7 +278,7 @@ static void *odb_source_loose_map_object(struct odb_source_loose *loose,
 }
 
 struct odb_loose_read_stream {
-	struct odb_read_stream base;
+	struct odb_stream base;
 	git_zstream z;
 	enum {
 		ODB_LOOSE_READ_STREAM_INUSE,
@@ -292,7 +292,7 @@ struct odb_loose_read_stream {
 	int hdr_used;
 };
 
-static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t sz)
+static ssize_t read_istream_loose(struct odb_stream *_st, char *buf, size_t sz)
 {
 	struct odb_loose_read_stream *st =
 		container_of(_st, struct odb_loose_read_stream, base);
@@ -339,7 +339,7 @@ static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t
 	return total_read;
 }
 
-static int close_istream_loose(struct odb_read_stream *_st)
+static int close_istream_loose(struct odb_stream *_st)
 {
 	struct odb_loose_read_stream *st =
 		container_of(_st, struct odb_loose_read_stream, base);
@@ -350,7 +350,7 @@ static int close_istream_loose(struct odb_read_stream *_st)
 	return 0;
 }
 
-static int odb_source_loose_read_object_stream(struct odb_read_stream **out,
+static int odb_source_loose_read_object_stream(struct odb_stream **out,
 					       struct odb_source *source,
 					       const struct object_id *oid)
 {
diff --git a/odb/source-packed.c b/odb/source-packed.c
index e6ff74833b..b3186ca593 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -70,7 +70,7 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
 	return 0;
 }
 
-static int odb_source_packed_read_object_stream(struct odb_read_stream **out,
+static int odb_source_packed_read_object_stream(struct odb_stream **out,
 						struct odb_source *source,
 						const struct object_id *oid)
 {
diff --git a/odb/source.h b/odb/source.h
index 0080148ba7..89b0c39682 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -26,7 +26,7 @@ enum odb_source_type {
 };
 
 struct object_id;
-struct odb_read_stream;
+struct odb_stream;
 struct strvec;
 
 /*
@@ -125,7 +125,7 @@ struct odb_source {
 	 * The callback is expected to return a negative error code in case
 	 * creating the object stream has failed, 0 otherwise.
 	 */
-	int (*read_object_stream)(struct odb_read_stream **out,
+	int (*read_object_stream)(struct odb_stream **out,
 				  struct odb_source *source,
 				  const struct object_id *oid);
 
@@ -339,7 +339,7 @@ static inline int odb_source_read_object_info(struct odb_source *source,
  * Create a new read stream for the given object ID. Returns 0 on success, a
  * negative error code otherwise.
  */
-static inline int odb_source_read_object_stream(struct odb_read_stream **out,
+static inline int odb_source_read_object_stream(struct odb_stream **out,
 						struct odb_source *source,
 						const struct object_id *oid)
 {
diff --git a/odb/streaming.c b/odb/streaming.c
index 0918cad426..98e2152e36 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -20,8 +20,8 @@
  *****************************************************************/
 
 struct odb_filtered_read_stream {
-	struct odb_read_stream base;
-	struct odb_read_stream *upstream;
+	struct odb_stream base;
+	struct odb_stream *upstream;
 	struct stream_filter *filter;
 	char ibuf[FILTER_BUFFER];
 	char obuf[FILTER_BUFFER];
@@ -30,14 +30,14 @@ struct odb_filtered_read_stream {
 	int input_finished;
 };
 
-static int close_istream_filtered(struct odb_read_stream *_fs)
+static int close_istream_filtered(struct odb_stream *_fs)
 {
 	struct odb_filtered_read_stream *fs = (struct odb_filtered_read_stream *)_fs;
 	free_stream_filter(fs->filter);
-	return odb_read_stream_close(fs->upstream);
+	return odb_stream_close(fs->upstream);
 }
 
-static ssize_t read_istream_filtered(struct odb_read_stream *_fs, char *buf,
+static ssize_t read_istream_filtered(struct odb_stream *_fs, char *buf,
 				     size_t sz)
 {
 	struct odb_filtered_read_stream *fs = (struct odb_filtered_read_stream *)_fs;
@@ -86,7 +86,7 @@ static ssize_t read_istream_filtered(struct odb_read_stream *_fs, char *buf,
 
 		/* refill the input from the upstream */
 		if (!fs->input_finished) {
-			fs->i_end = odb_read_stream_read(fs->upstream, fs->ibuf, FILTER_BUFFER);
+			fs->i_end = odb_stream_read(fs->upstream, fs->ibuf, FILTER_BUFFER);
 			if (fs->i_end < 0)
 				return -1;
 			if (fs->i_end)
@@ -97,8 +97,8 @@ static ssize_t read_istream_filtered(struct odb_read_stream *_fs, char *buf,
 	return filled;
 }
 
-static struct odb_read_stream *attach_stream_filter(struct odb_read_stream *st,
-						    struct stream_filter *filter)
+static struct odb_stream *attach_stream_filter(struct odb_stream *st,
+					       struct stream_filter *filter)
 {
 	struct odb_filtered_read_stream *fs;
 
@@ -120,19 +120,19 @@ static struct odb_read_stream *attach_stream_filter(struct odb_read_stream *st,
  *****************************************************************/
 
 struct odb_incore_read_stream {
-	struct odb_read_stream base;
+	struct odb_stream base;
 	char *buf; /* from odb_read_object_info_extended() */
 	unsigned long read_ptr;
 };
 
-static int close_istream_incore(struct odb_read_stream *_st)
+static int close_istream_incore(struct odb_stream *_st)
 {
 	struct odb_incore_read_stream *st = (struct odb_incore_read_stream *)_st;
 	free(st->buf);
 	return 0;
 }
 
-static ssize_t read_istream_incore(struct odb_read_stream *_st, char *buf, size_t sz)
+static ssize_t read_istream_incore(struct odb_stream *_st, char *buf, size_t sz)
 {
 	struct odb_incore_read_stream *st = (struct odb_incore_read_stream *)_st;
 	size_t read_size = sz;
@@ -147,7 +147,7 @@ static ssize_t read_istream_incore(struct odb_read_stream *_st, char *buf, size_
 	return read_size;
 }
 
-static int open_istream_incore(struct odb_read_stream **out,
+static int open_istream_incore(struct odb_stream **out,
 			       struct object_database *odb,
 			       const struct object_id *oid)
 {
@@ -178,7 +178,7 @@ static int open_istream_incore(struct odb_read_stream **out,
  * static helpers variables and functions for users of streaming interface
  *****************************************************************************/
 
-static int istream_source(struct odb_read_stream **out,
+static int istream_source(struct odb_stream **out,
 			  struct object_database *odb,
 			  const struct object_id *oid)
 {
@@ -196,23 +196,23 @@ static int istream_source(struct odb_read_stream **out,
  * Users of streaming interface
  ****************************************************************/
 
-int odb_read_stream_close(struct odb_read_stream *st)
+int odb_stream_close(struct odb_stream *st)
 {
 	int r = st->close(st);
 	free(st);
 	return r;
 }
 
-ssize_t odb_read_stream_read(struct odb_read_stream *st, void *buf, size_t sz)
+ssize_t odb_stream_read(struct odb_stream *st, void *buf, size_t sz)
 {
 	return st->read(st, buf, sz);
 }
 
-struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
-					     const struct object_id *oid,
-					     struct stream_filter *filter)
+struct odb_stream *odb_read_stream_open(struct object_database *odb,
+					const struct object_id *oid,
+					struct stream_filter *filter)
 {
-	struct odb_read_stream *st;
+	struct odb_stream *st;
 	const struct object_id *real = lookup_replace_object(odb->repo, oid);
 	int ret = istream_source(&st, odb, real);
 
@@ -221,9 +221,9 @@ struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
 
 	if (filter) {
 		/* Add "&& !is_null_stream_filter(filter)" for performance */
-		struct odb_read_stream *nst = attach_stream_filter(st, filter);
+		struct odb_stream *nst = attach_stream_filter(st, filter);
 		if (!nst) {
-			odb_read_stream_close(st);
+			odb_stream_close(st);
 			return NULL;
 		}
 		st = nst;
@@ -248,7 +248,7 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 			  struct stream_filter *filter,
 			  int can_seek)
 {
-	struct odb_read_stream *st;
+	struct odb_stream *st;
 	ssize_t kept = 0;
 	int result = -1;
 
@@ -263,7 +263,7 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 	for (;;) {
 		char buf[1024 * 16];
 		ssize_t wrote, holeto;
-		ssize_t readlen = odb_read_stream_read(st, buf, sizeof(buf));
+		ssize_t readlen = odb_stream_read(st, buf, sizeof(buf));
 
 		if (readlen < 0)
 			goto close_and_exit;
@@ -294,7 +294,7 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 	result = 0;
 
  close_and_exit:
-	odb_read_stream_close(st);
+	odb_stream_close(st);
 	return result;
 }
 
diff --git a/odb/streaming.h b/odb/streaming.h
index 3c8ed55129..037954c231 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -8,19 +8,19 @@
 #include "odb.h"
 
 struct object_database;
-struct odb_read_stream;
+struct odb_stream;
 struct stream_filter;
 
-typedef int (*odb_read_stream_close_fn)(struct odb_read_stream *);
-typedef ssize_t (*odb_read_stream_read_fn)(struct odb_read_stream *, char *, size_t);
+typedef int (*odb_stream_close_fn)(struct odb_stream *);
+typedef ssize_t (*odb_stream_read_fn)(struct odb_stream *, char *, size_t);
 
 /*
  * A stream that can be used to read an object from the object database without
  * loading all of it into memory.
  */
-struct odb_read_stream {
-	odb_read_stream_close_fn close;
-	odb_read_stream_read_fn read;
+struct odb_stream {
+	odb_stream_close_fn close;
+	odb_stream_read_fn read;
 	enum object_type type;
 	size_t size; /* inflated size of full object */
 };
@@ -31,22 +31,22 @@ struct odb_read_stream {
  *
  * Returns the stream on success, a `NULL` pointer otherwise.
  */
-struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
-					     const struct object_id *oid,
-					     struct stream_filter *filter);
+struct odb_stream *odb_read_stream_open(struct object_database *odb,
+					const struct object_id *oid,
+					struct stream_filter *filter);
 
 /*
- * Close the given read stream and release all resources associated with it.
+ * Close the given object stream and release all resources associated with it.
  * Returns 0 on success, a negative error code otherwise.
  */
-int odb_read_stream_close(struct odb_read_stream *stream);
+int odb_stream_close(struct odb_stream *stream);
 
 /*
  * Read data from the stream into the buffer. Returns 0 on EOF and the number
  * of bytes read on success. Returns a negative error code in case reading from
  * the stream fails.
  */
-ssize_t odb_read_stream_read(struct odb_read_stream *stream, void *buf, size_t len);
+ssize_t odb_stream_read(struct odb_stream *stream, void *buf, size_t len);
 
 /*
  * A stream that provides an object to be written to the object database without
diff --git a/pack-check.c b/pack-check.c
index c3b8db7c5c..1b5e26847d 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -106,7 +106,7 @@ static int verify_packfile(struct repository *r,
 	QSORT(entries, nr_objects, compare_entries);
 
 	for (i = 0; i < nr_objects; i++) {
-		struct odb_read_stream *stream = NULL;
+		struct odb_stream *stream = NULL;
 		void *data;
 		struct object_id oid;
 		enum object_type type;
@@ -171,7 +171,7 @@ static int verify_packfile(struct repository *r,
 			display_progress(progress, base_count + i);
 
 		if (stream)
-			odb_read_stream_close(stream);
+			odb_stream_close(stream);
 		free(data);
 	}
 
diff --git a/packfile.c b/packfile.c
index 0eee45055f..70254573a3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2115,7 +2115,7 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 }
 
 struct odb_packed_read_stream {
-	struct odb_read_stream base;
+	struct odb_stream base;
 	struct packed_git *pack;
 	git_zstream z;
 	enum {
@@ -2127,7 +2127,7 @@ struct odb_packed_read_stream {
 	off_t pos;
 };
 
-static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *buf,
+static ssize_t read_istream_pack_non_delta(struct odb_stream *_st, char *buf,
 					   size_t sz)
 {
 	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
@@ -2187,7 +2187,7 @@ static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *bu
 	return total_read;
 }
 
-static int close_istream_pack_non_delta(struct odb_read_stream *_st)
+static int close_istream_pack_non_delta(struct odb_stream *_st)
 {
 	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
 	if (st->z_state == ODB_PACKED_READ_STREAM_INUSE)
@@ -2195,7 +2195,7 @@ static int close_istream_pack_non_delta(struct odb_read_stream *_st)
 	return 0;
 }
 
-int packfile_read_object_stream(struct odb_read_stream **out,
+int packfile_read_object_stream(struct odb_stream **out,
 				const struct object_id *oid,
 				struct packed_git *pack,
 				off_t offset)
diff --git a/packfile.h b/packfile.h
index e1f77152b5..f913cb3d0c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -12,7 +12,7 @@
 
 /* in odb.h */
 struct object_info;
-struct odb_read_stream;
+struct odb_stream;
 
 struct packed_git {
 	struct pack_window *windows;
@@ -306,7 +306,7 @@ off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
 		     off_t *curpos, enum object_type type,
 		     off_t delta_obj_offset);
 
-int packfile_read_object_stream(struct odb_read_stream **out,
+int packfile_read_object_stream(struct odb_stream **out,
 				const struct object_id *oid,
 				struct packed_git *pack,
 				off_t offset);
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 1ab07af6d6..839a0fd3b7 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -100,7 +100,7 @@ void test_odb_inmemory__read_written_object(void)
 void test_odb_inmemory__read_stream_object(void)
 {
 	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
-	struct odb_read_stream *stream;
+	struct odb_stream *stream;
 	struct object_id written_oid;
 	const char data[] = "foobar";
 	char buf[3] = { 0 };
@@ -112,15 +112,15 @@ void test_odb_inmemory__read_stream_object(void)
 	cl_assert_equal_i(stream->type, OBJ_BLOB);
 	cl_assert_equal_u(stream->size, 6);
 
-	cl_assert_equal_i(odb_read_stream_read(stream, buf, 2), 2);
+	cl_assert_equal_i(odb_stream_read(stream, buf, 2), 2);
 	cl_assert_equal_s(buf, "fo");
-	cl_assert_equal_i(odb_read_stream_read(stream, buf, 2), 2);
+	cl_assert_equal_i(odb_stream_read(stream, buf, 2), 2);
 	cl_assert_equal_s(buf, "ob");
-	cl_assert_equal_i(odb_read_stream_read(stream, buf, 2), 2);
+	cl_assert_equal_i(odb_stream_read(stream, buf, 2), 2);
 	cl_assert_equal_s(buf, "ar");
-	cl_assert_equal_i(odb_read_stream_read(stream, buf, 2), 0);
+	cl_assert_equal_i(odb_stream_read(stream, buf, 2), 0);
 
-	odb_read_stream_close(stream);
+	odb_stream_close(stream);
 	odb_source_free(&source->base);
 }
 

-- 
2.55.0.679.g6767b8d81c.dirty

