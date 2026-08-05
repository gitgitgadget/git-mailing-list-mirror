Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95036826E
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915906; cv=none; b=Tll1RIR2qYLbiqEzYyzBMUFbWNbEkry0aRdPKgtOP5cxmgXCKv7O2VXH/3krVEwmf7dc8wqXEnJDmNBVfVOXR3xWV1JKTohSWcSU5Piv/lkUpy/EpD6x57hcdUW3ie7DV7e4lT5QqVaqygEjc8TsJIuEwNQ+f/E/Aq6TgXf48GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915906; c=relaxed/simple;
	bh=7K92NYRU+K2AcU0iA+XDiGMCdjBUZC583QadWAhcy6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k5EZOLaRUa4pE+MwOnWTfK/T2OqIPXAvu8mN6oiX/MSAUnrDRCFirDQOaTm9K5NsufSUccueTmmWV33CNhCxYMgDrcjgnqtQlDSmPVblyx00Mgf9FzZx1YD5CetBLKkSGdNrDdiInrVa+svNMPHkVGvZAf3Pf8I8BedigdsgVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BEcYpboQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bQ3AC9SH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BEcYpboQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bQ3AC9SH"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 182AE14000ED;
	Wed,  5 Aug 2026 03:45:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 05 Aug 2026 03:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785915904;
	 x=1786002304; bh=j/n74/ado5S4YvMhRy0KYzx5t6yCnkSusSvRmgywwTw=; b=
	BEcYpboQ63N9pvTc7T04wNuhQkr6mKYqBGwP0TQTBIlzLVIdX+uC1ekO3TFXFx30
	28dXXeTLzKnF5gcMJerj54MNGnb9vhcwRsy4UNjpx4vqXH7OnU0k+JxSr2shvYL0
	hNCqPrbU15gcRoHhXl/ZPEYg8XL8ZedCZY63L5Ub200RUxOTMXnoGDdGFoadaphu
	+ENczpam6coeSp7j3+ZXRQ4q4UWShnBpXBLfN/bS1REom7b4VZpQL9AcNrVz5g1l
	RorLTYK4K8K8QWwbdOcAgawyuNXi0bOtGmzbQi7nb4BsRBHyzww0oCHyOFOQqxTN
	fhtpz09U7uCI39HrJ0+JPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785915904; x=
	1786002304; bh=j/n74/ado5S4YvMhRy0KYzx5t6yCnkSusSvRmgywwTw=; b=b
	Q3AC9SHLZfl5eb68FqalfyjFmcZh9jFPFifnyUWjOArJRPxY9LbRNZTqMKJJhOur
	XmBndCOGGnRXXda4kubSjkjC6knVNChTgBNX7lF35X9dsbHDF5ArbxBbTZpFm4LK
	EgH8R2YpaxUIIgUrL0ztaqYbpCCBmyTaTfVSXfkuO6XJoDs9U0N31l7Y35sgxDu2
	kfeSiw+0rgxlUjxENmfQ4Zt0nMs0AtCjs5b9iVBDFuyW1llj59fS6PfiEpmKu340
	p+F6/+R3/1qanyMHbeuq0O7+sjNdhrtOFK9eY3jNvA9WpPP8CktUgSFNTZd8sXNi
	k6gyaBDEt6g2CVh+D+nRQ==
X-ME-Sender: <xms:AOpyajcCJOldLnD4AcyecrTdxLdCj5PYRmzp9CTRd-bzD1EPWSL4Fw>
    <xme:AOpyagpT2Ax-6SdR7eSlEjc7vZF-tGw33eB3eg65Wzp5Kyzqm4NknzmMjgPclNwP9
    S0n6aApebFDggBHL63tb3NC5i1TYMrITVumJMWoNBv37aFzw8Ec-cY>
X-ME-Received: <xmr:AOpyap5fbEBrKy8v8SweO7FiwGhuuyCV9BjYH1AD3me5lc47nQigp9JnSzxbJcDB3w3u4mCe1xBuKyrSPmkCy5XocD18okxT4Kbmi9oBAg>
X-ME-Proxy-Cause: dmFkZTEcLJn9n5hBgoBcU0GbAx0M7GV7DF7/UmcIBGprRonrJMVjpy1E6xkHIgmNwgNS5F
    2WCCCLtAy7vUY+R6LfaE9a6DDHCr6plIi/saORD+1pAMBom8AFBtPAYTRlaYEMRX9epKuj
    LeQFSUTOdVcIHAF5smNWnURC888YjoXR87dKjtISuASchJOo2XDY8sq/p4ueXvMC+CsxHV
    G+OeyNwZPvxkPMzlFH0mgt9YjOisAbQsMnxM4VRk1rw2d9k8Ibog5kUMsUmQG2V/i+gqMW
    NF7w30VPjs5/NzagY70D9L3n2jtf7XXHXPMgNjxwsn7Up4XcK8coEbEf9cJiXLRsJCrSEC
    bERIZwrl32PdmvaoM9QdYGYooaiMj+90j+ANnAUTtUj/WbrWAjZUKxNNp6RacTwT0fGlDj
    dg68q+fMpj8wNrkA5EQHR7iUz2F44jS4MzBn7ecy+YKTWrNVSdJb/jCf6+g8T5cMaNrbSs
    zmKnUv3xKKtUnfhbOM5UNibvdSGCtSf2alGQ5cPM3skbu5mPMQiY3Sw11ET7kV/y0gtFm9
    3LRbH3+I+XZ50KDdIwhI26/0yCrUWeSk5fZgJrB2UktKXIp+fBA2QrGdhm5aPve/8/GcEr
    Cr33Hfjivf0WbewuIk4PslABmhzf2xPVPPtlEGffvXGWN0VUGKarroTShMRQ
X-ME-Proxy: <xmx:AOpyauotf94wDLye0dnu6Pi1uOV03hb30iFqbVFDray8Phq1c_wtPA>
    <xmx:AOpyajhEgKl_RIjx1Dg-Cqjhu7ygB6dAoiGYS-D_IHquNUMZBb4w2A>
    <xmx:AOpyagLdGOe_R9D3tZqbcByc022CChQNHhda_i-Y-3KDatcrYsjx-w>
    <xmx:AOpyarDv0KP2j3pKn_0l0AI2Nhtk1M2QJAiV7hhyra2HD6bOxryz_Q>
    <xmx:AOpyasptPjQ2myGD9arNVOrulCYkNK37DgyUvZyZa7WRsoFHIg9wyF2E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 03:45:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d163c4e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 07:45:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 05 Aug 2026 09:44:47 +0200
Subject: [PATCH v2 3/8] odb/streaming: support streaming arbitrary object
 types
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pks-odb-stream-unification-v2-3-b8c369564641@pks.im>
References: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
In-Reply-To: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The object database supports the ability to write object streams into
it. This functionality is used when we encounter a blob that is larger
than "core.bigFileThreshold" so that we don't have to soak large files
into memory.

As we only ever write large files, the infrastructure doesn't support
specifying any other object type than "blob". This limitation is quite
artificial though: there is no reason why we shouldn't support writing
arbitrary large objects with a stream. While it's very unlikely that we
encounter a huge object other than a blob, users are known to be
creative and sometimes like to inflict pain on themselves by creating
commits or trees that are huge.

Extend the infrastructure to support streaming arbitrary object types.
For now we don't use this functionality anywhere, but it brings us a bit
closer to unify `struct odb_read_stream` and `struct odb_write_stream`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/unpack-objects.c      |  1 +
 object-file.c                 | 31 +++++++++++++++----------------
 odb/source-inmemory.c         |  5 +++--
 odb/source-loose.c            |  2 +-
 odb/streaming.c               |  3 ++-
 odb/streaming.h               |  3 ++-
 odb/transaction.h             |  2 +-
 t/unit-tests/u-odb-inmemory.c |  7 +++++--
 8 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index b7c486ea94..7439ec53be 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -393,6 +393,7 @@ static void stream_blob(unsigned long size, unsigned nr)
 		.read = feed_input_zstream,
 		.data = &data,
 		.size = size,
+		.type = OBJ_BLOB,
 	};
 	struct obj_info *info = &obj_list[nr];
 
diff --git a/object-file.c b/object-file.c
index 317c09dff8..699a6a008c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -702,9 +702,9 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
 		die_errno("unable to write pack header");
 }
 
-static int hash_blob_stream(struct odb_write_stream *stream,
-			    const struct git_hash_algo *hash_algo,
-			    struct object_id *result_oid)
+static int hash_stream(struct odb_write_stream *stream,
+		       const struct git_hash_algo *hash_algo,
+		       struct object_id *result_oid)
 {
 	unsigned char buf[16384];
 	struct git_hash_ctx ctx;
@@ -712,7 +712,7 @@ static int hash_blob_stream(struct odb_write_stream *stream,
 	size_t bytes_hashed = 0;
 
 	header_len = format_object_header((char *)buf, sizeof(buf),
-					  OBJ_BLOB, stream->size);
+					  stream->type, stream->size);
 	git_hash_init(&ctx, hash_algo);
 	git_hash_update(&ctx, buf, header_len);
 
@@ -740,9 +740,9 @@ static int hash_blob_stream(struct odb_write_stream *stream,
  * Read the contents from the stream provided, streaming it to the
  * packfile in state while updating the hash in ctx.
  */
-static void stream_blob_to_pack(struct transaction_packfile *state,
-				struct git_hash_ctx *ctx,
-				struct odb_write_stream *stream)
+static void stream_to_pack(struct transaction_packfile *state,
+			   struct git_hash_ctx *ctx,
+			   struct odb_write_stream *stream)
 {
 	git_zstream s;
 	unsigned char ibuf[16384];
@@ -755,7 +755,7 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 
 	git_deflate_init(&s, cfg->pack_compression_level);
 
-	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, stream->size);
+	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), stream->type, stream->size);
 	s.next_out = obuf + hdrlen;
 	s.avail_out = sizeof(obuf) - hdrlen;
 
@@ -764,7 +764,7 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 			ssize_t rsize = odb_write_stream_read(stream, ibuf,
 							      sizeof(ibuf));
 			if (rsize < 0)
-				die("failed to read blob data");
+				die("failed to read object data");
 			if (!rsize)
 				is_finished = true;
 
@@ -797,7 +797,7 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 	}
 
 	if (bytes_read != stream->size)
-		die("read %" PRIuMAX " bytes of blob data, but expected %" PRIuMAX " bytes",
+		die("read %" PRIuMAX " bytes of object data, but expected %" PRIuMAX " bytes",
 		    (uintmax_t)bytes_read, (uintmax_t)stream->size);
 
 	git_deflate_end(&s);
@@ -868,7 +868,7 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
  * result, which we need to know beforehand when writing a git object.
  * Since the primary motivation for trying to stream from the working
  * tree file and to avoid mmaping it in core is to deal with large
- * binary blobs, they generally do not want to get any conversion, and
+ * objects, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
 static int odb_transaction_files_write_object_stream(struct odb_transaction *base,
@@ -886,7 +886,7 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 	struct pack_idx_entry *idx;
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
-					  OBJ_BLOB, stream->size);
+					  stream->type, stream->size);
 	git_hash_init(&ctx, transaction->base.source->odb->repo->hash_algo);
 	git_hash_update(&ctx, obuf, header_len);
 
@@ -911,7 +911,7 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 	hashfile_checkpoint(state->f, &checkpoint);
 	idx->offset = state->offset;
 	crc32_begin(state->f);
-	stream_blob_to_pack(state, &ctx, stream);
+	stream_to_pack(state, &ctx, stream);
 	git_hash_final_oid(result_oid, &ctx);
 
 	idx->crc32 = crc32_end(state->f);
@@ -953,7 +953,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 				 type, path, flags);
 	} else {
 		struct odb_write_stream stream;
-		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size));
+		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size), OBJ_BLOB);
 
 		if (flags & INDEX_WRITE_OBJECT) {
 			struct object_database *odb = the_repository->objects;
@@ -968,8 +968,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 			if (!inflight)
 				odb_transaction_commit(transaction);
 		} else {
-			ret = hash_blob_stream(&stream,
-					       the_repository->hash_algo, oid);
+			ret = hash_stream(&stream, the_repository->hash_algo, oid);
 		}
 
 		odb_write_stream_release(&stream);
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 01bb81c63c..139618024a 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -290,10 +290,11 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
 		goto out;
 	}
 
-	hash_object_file(source->odb->repo->hash_algo, data, total_read, OBJ_BLOB, oid);
+	hash_object_file(source->odb->repo->hash_algo, data, total_read,
+			 stream->type, oid);
 
 	ret = odb_source_inmemory_write_object(source, data, stream->size,
-					       OBJ_BLOB, oid, NULL, NULL, 0);
+					       stream->type, oid, NULL, NULL, 0);
 	if (ret < 0)
 		goto out;
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 361b4e2a2a..5681a38f03 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -868,7 +868,7 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 
 	/* Since oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", loose->base.path);
-	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, in_stream->size);
+	hdrlen = format_object_header(hdr, sizeof(hdr), in_stream->type, in_stream->size);
 
 	/*
 	 * Common steps for write_loose_object and stream_loose_object to
diff --git a/odb/streaming.c b/odb/streaming.c
index 912e75e682..0918cad426 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -324,7 +324,7 @@ static ssize_t read_object_fd(struct odb_write_stream *stream,
 }
 
 void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
-			      size_t size)
+			      size_t size, enum object_type type)
 {
 	struct read_object_fd_data *data;
 
@@ -335,4 +335,5 @@ void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
 	stream->data = data;
 	stream->read = read_object_fd;
 	stream->size = size;
+	stream->type = type;
 }
diff --git a/odb/streaming.h b/odb/streaming.h
index 5e8e6e532e..3c8ed55129 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -56,6 +56,7 @@ struct odb_write_stream {
 	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t);
 	void *data;
 	size_t size;
+	enum object_type type;
 };
 
 /*
@@ -92,6 +93,6 @@ int odb_stream_blob_to_fd(struct object_database *odb,
  * Sets up an ODB write stream that reads from an fd.
  */
 void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
-			      size_t size);
+			      size_t size, enum object_type type);
 
 #endif /* STREAMING_H */
diff --git a/odb/transaction.h b/odb/transaction.h
index ffb279314c..1eb74664c6 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -24,7 +24,7 @@ struct odb_transaction {
 
 	/*
 	 * This callback is expected to write the given object stream into
-	 * the ODB transaction. Note that for now, only blobs support streaming.
+	 * the ODB transaction.
 	 *
 	 * The resulting object ID shall be written into the out pointer. The
 	 * callback is expected to return 0 on success, a negative error code
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 4437140ed0..1ab07af6d6 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -297,8 +297,11 @@ void test_odb_inmemory__write_object_stream(void)
 	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
 	const char data[] = "foobar";
 	struct membuf_write_stream stream = {
-		.base.read = membuf_write_stream_read,
-		.base.size = strlen(data),
+		.base = {
+			.read = membuf_write_stream_read,
+			.size = strlen(data),
+			.type = OBJ_BLOB,
+		},
 		.buf = data,
 	};
 	struct object_id written_oid;

-- 
2.55.0.679.g6767b8d81c.dirty

