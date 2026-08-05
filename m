Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CCC361DC0
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915900; cv=none; b=E02G+jj5S1bgh5iXrk+Q1d4IkYSxZ7Mj+ymTMgb837+c6Kcq0LDSTETazsmHH3rKDYd7BNLKKGdwUcfJCILyBe0BRqXb2FszJVf2H8lwxDZBBLHMKwQAVEzZZd7ATE16U8OCfAca1w8Z2QZa8K5e7jJMJFJuQmbX+17wQVvoOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915900; c=relaxed/simple;
	bh=ie6Radd+Qrn/rzSJz0I+XQbcuA0flVa9LlbC9erWYgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Njt8oZ0mFK6GT4DZevu0x7P09FLvEGxVuRj/rakAdSJI4pmY4ZVAOwylqo3y565D8FaarSVFFTEaOu8ESrZg+DlBi3kWOCnA1AmHZWOVjm/dG4V20chxDWAWluyns71VM/nsLjdG14Wgt8jJ8m+xmZ+3G9gbMyrhnm4l2OSBJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GwOs9U2m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k/wEjPGc; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GwOs9U2m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k/wEjPGc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CFC9EC00E1;
	Wed,  5 Aug 2026 03:44:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 03:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785915897;
	 x=1786002297; bh=srxNmpJtMnNe5IW/PRkqwB8njuSKKW35FHZgyC4R2aI=; b=
	GwOs9U2mxMGky9961gSfDTq9OHnIEfScy23e1yGFCK3b4I9KmoROlEswLOYil9AV
	sQOovPJPFCLZj2S4VAAybUriI3wUpPWPQCMH26uSnNlvC9NZzJHp3sbayocHOANw
	/K1rsLgMRuBe9suz/sIiJ4Fm8g9LnNgklOtJK3fQLsAfZLmVdyyvX9zvSUKwVLm6
	Rhyp4moh8/nAZm6yamXKwNUpHnNj1CUffcQOrmVflBbsu2FMG7CtAOe0dF0XTCkK
	Nb9RYD2ENnmaG32PsLR2rDXKDTxCtp0QKiou/GTIsLWDrwqff4PkRV1PUoRNMSYd
	KkKt4N8Ge6qjl+NDLwI25g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785915897; x=
	1786002297; bh=srxNmpJtMnNe5IW/PRkqwB8njuSKKW35FHZgyC4R2aI=; b=k
	/wEjPGcj96jr+4ouVtkVe4SQCwCf5MboiIs0/ApgWvwV36vcjACbcdZmPIyxkAwB
	IFgKomkDJ8l7uymnyMEfzVedIyYUxVhw/wQaTd81lU6kkWYvS/4AY41CnL2wTLB8
	eF21qMneMYKHWqPH4zGVUW7MmY1K5didGviKBb0lSbq0wSqjoBNqO5OG2pzk/i6S
	R8EXmcofEo23CwHUJb9e+YNXiRnZC2baUii/6PJWp/XDKi2QPGXI9WO/OEm8Tlol
	wgDlNbz1HyCmeNOlBDKQs+q3JAcuspCo2PIbabdjmaMq0mK7+HbAjtcwWZoOMzzo
	hr7n6NhWPnrBzqzq/Ansg==
X-ME-Sender: <xms:-elyal6aiHwLEyx_KcBONbxpwMj69dLXGwp28XvYqdGY5MJsQdz4tQ>
    <xme:-elyaqUlVEW4N31XrwnfyHLF0EvEGGcX9gJDK_By9YDlLvJ1a4M5lJezsBoDS4hj8
    W6sbZnXVd393eYbvNBT_9U0InkcrJdXECBOBeRp6tqLP9LhGEW7Xzw>
X-ME-Received: <xmr:-elyap1NQB0OR_jW6GDOd06tQiHj3WtG3l4m203M8srYg7IcsxSNIIc7v0vpELaE5EANrZ8QoJmRqKNKZPuDpC29IRPQxhCv3uyzFDxKzA>
X-ME-Proxy-Cause: dmFkZTEcLJn9n5hBgoBcU0GbAx0M7GV7DF7/UmcIBGprRonrJMVjpy1E6xkHIgmNwgNS5F
    2WCCCLtAy7vUY+R6LfaE9a6DDHCr6plIi/saORD+1pAMBom8AFBtPAYTRlaYEMRX9epKuj
    LeQFSUTOdVcIHAF5smNWnURC888YjoXR87dKjtISuASchJOo2XDY8sq/p4ueXvMC+CsxHV
    G+OeyNwZPvxkPMzlFH0mgt9YjOisAbQsMnxM4VRk1rw2d9k8Ibog5kUMsUmQG2V/i+gqMW
    NF7w30VPjs5/NzagY70D9L3n2jtf7XXHXPMgNjxwsn7Up4XcK8coEbEf9cJiXLRsJCrSsC
    2mQYW0E+CNoCXqGVCyxwjas9hWygDI1LhqIVVKFMG2RoEm/GYvsm3mCpMpSaiQYLCDQKdk
    QHMmIuPlmW6DNu7QtrBPj8tRl8ZmoTrG84eyAbDfXyNc3DGG9Q5eop8m2aBc69ibTHSGb4
    lPZ3dOLd7M+aOlEoGJ1os5rdX4hb05uuMws6Rbl7ocX+P7h8OYxuInRD8qqbzM99orQDR9
    secMbadN9GtRj0Z8dU1O0MdyfiaTFAB7F9ksep9gI4Lzw8vSHhO4HRPIT4nkxiALuHsxuT
    vEoLF1QNCIGECgjG9zRLMjCWHVGEi6MvJekvx3DFhEW5YjjOcFsfNl8ycRPQ
X-ME-Proxy: <xmx:-elyan2dotWooxnmxM5O42W9YcAxusGatCzPuAgayGnKLOh0tTzwVg>
    <xmx:-elyas_XWA8lRXDhvveQ04uKUMBtaQ3zsNm6lclGI7BPOQcgqXlVGg>
    <xmx:-elyak1eHdrEs--aD6FXe4kx87Hj398Bx9-0L4UXi_ekcSzxEDsmag>
    <xmx:-elyap9eCWTNikYKGfLEyElCgWaLLvwpIVpzo_zlP78Kqz5wDWaGvA>
    <xmx:-elyaiVwRqVfZv6A04HKWidtaLHgBXYu_YfOWTA_g8ewBEka3EIyDnX1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 03:44:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 606a5ae4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 07:44:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 05 Aug 2026 09:44:45 +0200
Subject: [PATCH v2 1/8] odb/streaming: track write stream size in the
 structure
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pks-odb-stream-unification-v2-1-b8c369564641@pks.im>
References: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
In-Reply-To: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When passing around a `struct odb_write_stream` we typically also have
to pass the number of bytes that the stream will yield. This is required
because the object header itself contains that size, and consequently we
cannot write the header without that information.

Move this information into the stream itself so that it becomes self-
describing. In addition to that, this also brings the `struct
odb_write_stream` a bit closer to the `struct odb_read_stream` so that
we can eventually merge both stream types.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/unpack-objects.c      |  3 ++-
 object-file.c                 | 25 +++++++++++--------------
 odb.c                         |  4 ++--
 odb.h                         |  2 +-
 odb/source-files.c            |  3 +--
 odb/source-inmemory.c         | 11 +++++------
 odb/source-loose.c            |  7 +++----
 odb/source-packed.c           |  1 -
 odb/source.h                  |  5 ++---
 odb/streaming.c               |  1 +
 odb/streaming.h               |  1 +
 odb/transaction.c             |  4 ++--
 odb/transaction.h             |  4 ++--
 t/unit-tests/u-odb-inmemory.c | 11 +++++------
 14 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4263edfbec..f3e0b504f4 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -392,13 +392,14 @@ static void stream_blob(unsigned long size, unsigned nr)
 	struct odb_write_stream in_stream = {
 		.read = feed_input_zstream,
 		.data = &data,
+		.size = size,
 	};
 	struct obj_info *info = &obj_list[nr];
 
 	data.zstream = &zstream;
 	git_inflate_init(&zstream);
 
-	if (odb_write_object_stream(the_repository->objects, &in_stream, size, &info->oid))
+	if (odb_write_object_stream(the_repository->objects, &in_stream, &info->oid))
 		die(_("failed to write object in stream"));
 
 	if (data.status != Z_STREAM_END)
diff --git a/object-file.c b/object-file.c
index ec35c318bc..b196abb596 100644
--- a/object-file.c
+++ b/object-file.c
@@ -704,7 +704,7 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
 
 static int hash_blob_stream(struct odb_write_stream *stream,
 			    const struct git_hash_algo *hash_algo,
-			    struct object_id *result_oid, size_t size)
+			    struct object_id *result_oid)
 {
 	unsigned char buf[16384];
 	struct git_hash_ctx ctx;
@@ -712,7 +712,7 @@ static int hash_blob_stream(struct odb_write_stream *stream,
 	size_t bytes_hashed = 0;
 
 	header_len = format_object_header((char *)buf, sizeof(buf),
-					  OBJ_BLOB, size);
+					  OBJ_BLOB, stream->size);
 	git_hash_init(&ctx, hash_algo);
 	git_hash_update(&ctx, buf, header_len);
 
@@ -727,7 +727,7 @@ static int hash_blob_stream(struct odb_write_stream *stream,
 		bytes_hashed += read_result;
 	}
 
-	if (bytes_hashed != size)
+	if (bytes_hashed != stream->size)
 		return -1;
 
 	git_hash_final_oid(result_oid, &ctx);
@@ -740,7 +740,7 @@ static int hash_blob_stream(struct odb_write_stream *stream,
  * packfile in state while updating the hash in ctx.
  */
 static void stream_blob_to_pack(struct transaction_packfile *state,
-				struct git_hash_ctx *ctx, size_t size,
+				struct git_hash_ctx *ctx,
 				struct odb_write_stream *stream)
 {
 	git_zstream s;
@@ -753,7 +753,7 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 
 	git_deflate_init(&s, cfg->pack_compression_level);
 
-	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, size);
+	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, stream->size);
 	s.next_out = obuf + hdrlen;
 	s.avail_out = sizeof(obuf) - hdrlen;
 
@@ -793,9 +793,9 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 		}
 	}
 
-	if (bytes_read != size)
+	if (bytes_read != stream->size)
 		die("read %" PRIuMAX " bytes of blob data, but expected %" PRIuMAX " bytes",
-		    (uintmax_t)bytes_read, (uintmax_t)size);
+		    (uintmax_t)bytes_read, (uintmax_t)stream->size);
 
 	git_deflate_end(&s);
 }
@@ -870,7 +870,6 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
  */
 static int odb_transaction_files_write_object_stream(struct odb_transaction *base,
 						     struct odb_write_stream *stream,
-						     size_t size,
 						     struct object_id *result_oid)
 {
 	struct odb_transaction_files *transaction = container_of(base,
@@ -884,7 +883,7 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 	struct pack_idx_entry *idx;
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
-					  OBJ_BLOB, size);
+					  OBJ_BLOB, stream->size);
 	git_hash_init(&ctx, transaction->base.source->odb->repo->hash_algo);
 	git_hash_update(&ctx, obuf, header_len);
 
@@ -899,7 +898,7 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 	 * to zlib compression and is sufficient for this check.
 	 */
 	if (state->nr_written && pack_size_limit_cfg &&
-	    pack_size_limit_cfg < state->offset + size)
+	    pack_size_limit_cfg < state->offset + stream->size)
 		flush_packfile_transaction(transaction);
 
 	CALLOC_ARRAY(idx, 1);
@@ -909,7 +908,7 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 	hashfile_checkpoint(state->f, &checkpoint);
 	idx->offset = state->offset;
 	crc32_begin(state->f);
-	stream_blob_to_pack(state, &ctx, size, stream);
+	stream_blob_to_pack(state, &ctx, stream);
 	git_hash_final_oid(result_oid, &ctx);
 
 	idx->crc32 = crc32_end(state->f);
@@ -962,14 +961,12 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 				odb_transaction_begin_or_die(odb, &transaction, 0);
 			ret = odb_transaction_write_object_stream(transaction,
 								  &stream,
-								  xsize_t(st->st_size),
 								  oid);
 			if (!inflight)
 				odb_transaction_commit(transaction);
 		} else {
 			ret = hash_blob_stream(&stream,
-					       the_repository->hash_algo, oid,
-					       xsize_t(st->st_size));
+					       the_repository->hash_algo, oid);
 		}
 
 		odb_write_stream_release(&stream);
diff --git a/odb.c b/odb.c
index dabd481f57..585b2b2965 100644
--- a/odb.c
+++ b/odb.c
@@ -1028,10 +1028,10 @@ int odb_write_object_ext(struct object_database *odb,
 }
 
 int odb_write_object_stream(struct object_database *odb,
-			    struct odb_write_stream *stream, size_t len,
+			    struct odb_write_stream *stream,
 			    struct object_id *oid)
 {
-	return odb_source_write_object_stream(odb->sources, stream, len, oid);
+	return odb_source_write_object_stream(odb->sources, stream, oid);
 }
 
 struct object_database *odb_new(struct repository *repo,
diff --git a/odb.h b/odb.h
index cbc2f9ced4..019d3af3e8 100644
--- a/odb.h
+++ b/odb.h
@@ -629,7 +629,7 @@ static inline int odb_write_object(struct object_database *odb,
 struct odb_write_stream;
 
 int odb_write_object_stream(struct object_database *odb,
-			    struct odb_write_stream *stream, size_t len,
+			    struct odb_write_stream *stream,
 			    struct object_id *oid);
 
 void parse_alternates(const char *string,
diff --git a/odb/source-files.c b/odb/source-files.c
index 5e086d266f..f51960bd71 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -175,11 +175,10 @@ static int odb_source_files_write_object(struct odb_source *source,
 
 static int odb_source_files_write_object_stream(struct odb_source *source,
 						struct odb_write_stream *stream,
-						size_t len,
 						struct object_id *oid)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	return odb_source_write_object_stream(&files->loose->base, stream, len, oid);
+	return odb_source_write_object_stream(&files->loose->base, stream, oid);
 }
 
 static int odb_source_files_begin_transaction(struct odb_source *source,
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 3e71611b8e..398131e194 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -257,7 +257,6 @@ static int odb_source_inmemory_write_object(struct odb_source *source,
 
 static int odb_source_inmemory_write_object_stream(struct odb_source *source,
 						   struct odb_write_stream *stream,
-						   size_t len,
 						   struct object_id *oid)
 {
 	char buf[16384];
@@ -265,12 +264,12 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
 	char *data;
 	int ret;
 
-	CALLOC_ARRAY(data, len);
+	CALLOC_ARRAY(data, stream->size);
 	while (!stream->is_finished) {
 		ssize_t bytes_read;
 
 		bytes_read = odb_write_stream_read(stream, buf, sizeof(buf));
-		if (total_read + bytes_read > len) {
+		if (total_read + bytes_read > stream->size) {
 			ret = error("object stream yielded more bytes than expected");
 			goto out;
 		}
@@ -279,15 +278,15 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
 		total_read += bytes_read;
 	}
 
-	if (total_read != len) {
+	if (total_read != stream->size) {
 		ret = error("object stream yielded less bytes than expected");
 		goto out;
 	}
 
 	hash_object_file(source->odb->repo->hash_algo, data, total_read, OBJ_BLOB, oid);
 
-	ret = odb_source_inmemory_write_object(source, data, len, OBJ_BLOB, oid,
-					       NULL, NULL, 0);
+	ret = odb_source_inmemory_write_object(source, data, stream->size,
+					       OBJ_BLOB, oid, NULL, NULL, 0);
 	if (ret < 0)
 		goto out;
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index ef0e919277..77a2adb52a 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -846,7 +846,6 @@ static int odb_source_loose_write_object(struct odb_source *source,
 
 static int odb_source_loose_write_object_stream(struct odb_source *source,
 						struct odb_write_stream *in_stream,
-						size_t len,
 						struct object_id *oid)
 {
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
@@ -868,7 +867,7 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 
 	/* Since oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", loose->base.path);
-	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
+	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, in_stream->size);
 
 	/*
 	 * Common steps for write_loose_object and stream_loose_object to
@@ -916,9 +915,9 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 		 */
 	} while (ret == Z_OK || ret == Z_BUF_ERROR);
 
-	if (stream.total_in != len + hdrlen)
+	if (stream.total_in != in_stream->size + hdrlen)
 		die(_("write stream object %"PRIuMAX" != %"PRIuMAX), (uintmax_t)stream.total_in,
-		    (uintmax_t)len + hdrlen);
+		    (uintmax_t)in_stream->size + hdrlen);
 
 	/*
 	 * Common steps for write_loose_object and stream_loose_object to
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0890704e76..e6ff74833b 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -610,7 +610,6 @@ static int odb_source_packed_write_object(struct odb_source *source UNUSED,
 
 static int odb_source_packed_write_object_stream(struct odb_source *source UNUSED,
 						 struct odb_write_stream *stream UNUSED,
-						 size_t len UNUSED,
 						 struct object_id *oid UNUSED)
 {
 	return error("packed backend cannot write object streams");
diff --git a/odb/source.h b/odb/source.h
index fc04dd5cda..0080148ba7 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -221,7 +221,7 @@ struct odb_source {
 	 * otherwise.
 	 */
 	int (*write_object_stream)(struct odb_source *source,
-				   struct odb_write_stream *stream, size_t len,
+				   struct odb_write_stream *stream,
 				   struct object_id *oid);
 
 	/*
@@ -437,10 +437,9 @@ static inline int odb_source_write_object(struct odb_source *source,
  */
 static inline int odb_source_write_object_stream(struct odb_source *source,
 						 struct odb_write_stream *stream,
-						 size_t len,
 						 struct object_id *oid)
 {
-	return source->write_object_stream(source, stream, len, oid);
+	return source->write_object_stream(source, stream, oid);
 }
 
 /*
diff --git a/odb/streaming.c b/odb/streaming.c
index 20531e864c..38c2f6687c 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -336,5 +336,6 @@ void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
 
 	stream->data = data;
 	stream->read = read_object_fd;
+	stream->size = size;
 	stream->is_finished = 0;
 }
diff --git a/odb/streaming.h b/odb/streaming.h
index c023671780..4d7d31b5aa 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -55,6 +55,7 @@ ssize_t odb_read_stream_read(struct odb_read_stream *stream, void *buf, size_t l
 struct odb_write_stream {
 	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t);
 	void *data;
+	size_t size;
 	int is_finished;
 };
 
diff --git a/odb/transaction.c b/odb/transaction.c
index dab7da6a9a..6aaf133812 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -40,9 +40,9 @@ int odb_transaction_commit(struct odb_transaction *transaction)
 
 int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 					struct odb_write_stream *stream,
-					size_t len, struct object_id *oid)
+					struct object_id *oid)
 {
-	return transaction->write_object_stream(transaction, stream, len, oid);
+	return transaction->write_object_stream(transaction, stream, oid);
 }
 
 int odb_transaction_env(struct odb_transaction *transaction, struct strvec *env)
diff --git a/odb/transaction.h b/odb/transaction.h
index 4cb2eafcbf..ffb279314c 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -31,7 +31,7 @@ struct odb_transaction {
 	 * otherwise.
 	 */
 	int (*write_object_stream)(struct odb_transaction *transaction,
-				   struct odb_write_stream *stream, size_t len,
+				   struct odb_write_stream *stream,
 				   struct object_id *oid);
 
 	/*
@@ -82,7 +82,7 @@ int odb_transaction_commit(struct odb_transaction *transaction);
  */
 int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 					struct odb_write_stream *stream,
-					size_t len, struct object_id *oid);
+					struct object_id *oid);
 
 /*
  * Populates the provided strvec with the environment variables that a child
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index ddf2db5c81..5ccc52dccc 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -269,7 +269,6 @@ struct membuf_write_stream {
 	struct odb_write_stream base;
 	const char *buf;
 	size_t offset;
-	size_t size;
 };
 
 static ssize_t membuf_write_stream_read(struct odb_write_stream *stream,
@@ -280,13 +279,13 @@ static ssize_t membuf_write_stream_read(struct odb_write_stream *stream,
 
 	if (chunk_size > len)
 		chunk_size = len;
-	if (chunk_size > s->size - s->offset)
-		chunk_size = s->size - s->offset;
+	if (chunk_size > s->base.size - s->offset)
+		chunk_size = s->base.size - s->offset;
 
 	memcpy(buf, s->buf + s->offset, chunk_size);
 
 	s->offset += chunk_size;
-	if (s->offset == s->size)
+	if (s->offset == s->base.size)
 		s->base.is_finished = 1;
 
 	return chunk_size;
@@ -298,13 +297,13 @@ void test_odb_inmemory__write_object_stream(void)
 	const char data[] = "foobar";
 	struct membuf_write_stream stream = {
 		.base.read = membuf_write_stream_read,
+		.base.size = strlen(data),
 		.buf = data,
-		.size = strlen(data),
 	};
 	struct object_id written_oid;
 
 	cl_must_pass(odb_source_write_object_stream(&source->base, &stream.base,
-						    strlen(data), &written_oid));
+						    &written_oid));
 	cl_assert_equal_s(oid_to_hex(&written_oid), FOOBAR_OID);
 	cl_assert_object_info(source, &written_oid, OBJ_BLOB, "foobar");
 

-- 
2.55.0.679.g6767b8d81c.dirty

