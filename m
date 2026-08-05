Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E703E0C44
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915903; cv=none; b=JJHSAy8VNYQinndq7xno8HdSpuk0p2aKVHD6CzYZfA622//4GPUHAEaKeOgRRSj/uCWLTzXLtckeBTg6vZ6sRwQYfoqDP5h87oRgzkxw19wblZjvXXTHkTYSaVZFUQHFGlxpjrvMVvrwYGOlAOsiNNLoJ9wjV7BGWysGDVt17+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915903; c=relaxed/simple;
	bh=17JgYgQQEu6gNGIED0wLiWLM4o9vKnQazkpXy9dHUzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AovyqizaOQdidIVg3kdiB2nSxWL7sFKnpzbF9n0sijZhbk7YzNEBVw/FyNtzB3zzltUkM4Nj8kpd4+UzewNeJHPxAOUrP0GvABaPMXVyU4xXvvj2HR64HSFAOxYe6J32u2LyQje3rpGe9Ozkg6Bz55E5RTLjAn6mQYbej4C1dx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AbFas9nk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fCcaGVT9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AbFas9nk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fCcaGVT9"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id B6F10EC012B;
	Wed,  5 Aug 2026 03:45:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 05 Aug 2026 03:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785915900;
	 x=1786002300; bh=wQW+EMWkMFuZjgB6g87cP3DWaMlru9J7rGjT20Lvb+Q=; b=
	AbFas9nkA3AuxyES26vWH+LqGk29hOEH5TJskvJbWQ+nBbooj6cPQnQ+sdNVooWQ
	qlxKyASlm/DNi8cy46XzEZQPuZjkcxFiQRo0D6DX4U8pWmRF6vinFGZS382m7yf2
	iKBwHEuDIbcSTHvuXL2rD0G5zDEjAOGd0OCPr2A/0+8p/Za04V9RebCIsaxMnEWY
	65mM0hxK8138KvCc00KcGA6vsqfNnXtGT41tQeOcvVAXVVphsVtVf97J/mTX9vhe
	qw013HhQfLc4vNVBi0sw7x5EHk4OH6+F8Q4DhyUg9JR8KhEzkRq2Bwk6gFrsH270
	pMnbdCthFhpK0jEX+VJ9aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785915900; x=
	1786002300; bh=wQW+EMWkMFuZjgB6g87cP3DWaMlru9J7rGjT20Lvb+Q=; b=f
	CcaGVT91ZloCGBYIGXqzedgonZhFa66ZC0R8IsgxPZMIS6pF7sch1H7kCO0aiFGH
	FekN/fMb2YOOMwLWzOjV9JWqlweGUAUdh9Mb8Xi/1GwKJHQ8q+1g/fofD+zVh6Xf
	kUSoHwnA/qh81PnuwHgv7SPxYq2uMwmu7pxJ0XOqVzYXUV9+LAVtjhnEQNb6cL69
	xRw1gvl8rEIMpMFQ690WU96Dylm5o3P3WbFw9sG1TalRiOy7mRnJ3+1KsGi+sa1c
	NYbNqokrqa8LFRVFmHP1qqtzOT3Qtczyh3NYFAx79fajCVcHSzTe3V0hDJk9n13n
	LKFXzJGxQijyB02KyJQRQ==
X-ME-Sender: <xms:_OlyaoGoH6xmG5NpWMSNlCN4_u3e025cJEeGpuqrX9-DaYP5FJTWpQ>
    <xme:_OlyaoycnKG9Te-yaglG8jOCPdaKaEU2m91s2G_kDzTQlJDS0URUoLnrZxJ1lHd-h
    hBsyiKiC8t3G-cvpi-KBA6ddYoS385kefMyMNeokoqtZviAmhfDj9g>
X-ME-Received: <xmr:_Olyavh34nEeSDjeolz8XxTWE8LfBA8C-n3yrzuerMVyMFDAWHiPGwe959CQZ9GMyfkBjpZ91N6SKgawi3t2DybX3RRpGPK7pq5y348GPw>
X-ME-Proxy-Cause: dmFkZTEcLJn9n5hBgoBcU0GbAx0M7GV7DF7/UmcIBGprRonrJMVjpy1E6xkHIgmNwgNS5F
    2WCCCLtAy7vUY+R6LfaE9a6DDHCr6plIi/saORD+1pAMBom8AFBtPAYTRlaYEMRX9epKuj
    LeQFSUTOdVcIHAF5smNWnURC888YjoXR87dKjtISuASchJOo2XDY8sq/p4ueXvMC+CsxHV
    G+OeyNwZPvxkPMzlFH0mgt9YjOisAbQsMnxM4VRk1rw2d9k8Ibog5kUMsUmQG2V/i+gqMW
    NF7w30VPjs5/NzagY70D9L3n2jtf7XXHXPMgNjxwsn7Up4XcK8coEbEf9cJiXLRsJCrSDO
    BIg3+q9k5vQNiOOWOgRv5Z47Q1WWRpm9SYDeH2KvV/s2Nc125JItQbVqBaXY5X8uk3zLHU
    ULqewTd3H3HJVki6UqKvQoxkQwN3+4mAE0K/6WUZLUc7mn1EoZ7wy52XjlnjMBIIDSNr5g
    0NK4ptu8kefTrbyx6WEOLL+n9ICF92GEqv2NjLUHMSiTtb8p0rNstr8daOVBOtaNUJ4Cl2
    TCl/horT6A1ITm85owIw/GFv7g6cMZTo/La4TJJ/W6ewukF/eL0olGow20V/cwR+ruE6h8
    VLrUlbN1YHi2y4oUumdtRMUV1YH2hSUKeO2EwCU8KwtuSk18iswfvquJfNow
X-ME-Proxy: <xmx:_OlyajxooIYM2D7KObQGitWtUlmbihn1IvKFW81ikBsucp76VVXVvQ>
    <xmx:_OlyaiLFo_nGx-n4JeWBvNxRxV63_R7tvr0N-z5q7V6rZh086M5miA>
    <xmx:_OlyaqT8wK9Q-4lVTXgt2UOG6HVPGzlJR4f0wRAqKlxFMSJkzMQqpw>
    <xmx:_OlyaqrzKcWMjIAxKZP8zmz87nw3jQYzQR2s9H9z-g57-o3lun73Dw>
    <xmx:_Olyaszt6s6on8LNmOIBlpe57ywOHILk3fWiV5ycQ24Tep5C_ZcbwDfz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 03:44:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 725f99c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 07:44:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 05 Aug 2026 09:44:46 +0200
Subject: [PATCH v2 2/8] odb/streaming: drop `is_finished` field
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pks-odb-stream-unification-v2-2-b8c369564641@pks.im>
References: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
In-Reply-To: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The `is_finished` field is used to track whether a write stream is done
writing all of its data. Tracking this field as part of the stream
itself shouldn't be required though: callers will already know when the
stream is done when the stream's read function returns zero bytes, same
as when reading from a file descriptor.

There is one exception where it gets a bit more complicated: when
consuming data in "builtin/unpack-objects.c" it may happen that we don't
yield any new bytes after reading from the pipe. This is addressed by
looping until we have produced at least a single byte of output.

Drop the field from `struct odb_write_stream`. Again, same as in the
preceding commit, this brings the structure a bit closer to its sibling
`struct odb_read_stream`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/unpack-objects.c      | 15 ++++++++-------
 object-file.c                 | 13 ++++++++-----
 odb/source-inmemory.c         |  9 ++++++++-
 odb/source-loose.c            | 12 ++++++++----
 odb/streaming.c               |  5 +----
 odb/streaming.h               |  1 -
 t/unit-tests/u-odb-inmemory.c |  5 +++--
 7 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f3e0b504f4..b7c486ea94 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -368,20 +368,20 @@ static ssize_t feed_input_zstream(struct odb_write_stream *in_stream,
 {
 	struct input_zstream_data *data = in_stream->data;
 	git_zstream *zstream = data->zstream;
-	void *in = fill(1);
 
-	if (in_stream->is_finished)
+	if (data->status != Z_OK)
 		return 0;
 
 	zstream->next_out = buf;
 	zstream->avail_out = buf_len;
-	zstream->next_in = in;
-	zstream->avail_in = len;
 
-	data->status = git_inflate(zstream, 0);
+	while (data->status == Z_OK && zstream->avail_out == buf_len) {
+		zstream->next_in = fill(1);
+		zstream->avail_in = len;
+		data->status = git_inflate(zstream, 0);
+		use(len - zstream->avail_in);
+	}
 
-	in_stream->is_finished = data->status != Z_OK;
-	use(len - zstream->avail_in);
 	return buf_len - zstream->avail_out;
 }
 
@@ -397,6 +397,7 @@ static void stream_blob(unsigned long size, unsigned nr)
 	struct obj_info *info = &obj_list[nr];
 
 	data.zstream = &zstream;
+	data.status = Z_OK;
 	git_inflate_init(&zstream);
 
 	if (odb_write_object_stream(the_repository->objects, &in_stream, &info->oid))
diff --git a/object-file.c b/object-file.c
index b196abb596..317c09dff8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -716,12 +716,13 @@ static int hash_blob_stream(struct odb_write_stream *stream,
 	git_hash_init(&ctx, hash_algo);
 	git_hash_update(&ctx, buf, header_len);
 
-	while (!stream->is_finished) {
+	while (1) {
 		ssize_t read_result = odb_write_stream_read(stream, buf,
 							    sizeof(buf));
-
 		if (read_result < 0)
 			return -1;
+		if (!read_result)
+			break;
 
 		git_hash_update(&ctx, buf, read_result);
 		bytes_hashed += read_result;
@@ -749,6 +750,7 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 	unsigned hdrlen;
 	int status = Z_OK;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
+	bool is_finished = false;
 	size_t bytes_read = 0;
 
 	git_deflate_init(&s, cfg->pack_compression_level);
@@ -758,12 +760,13 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 	s.avail_out = sizeof(obuf) - hdrlen;
 
 	while (status != Z_STREAM_END) {
-		if (!stream->is_finished && !s.avail_in) {
+		if (!is_finished && !s.avail_in) {
 			ssize_t rsize = odb_write_stream_read(stream, ibuf,
 							      sizeof(ibuf));
-
 			if (rsize < 0)
 				die("failed to read blob data");
+			if (!rsize)
+				is_finished = true;
 
 			git_hash_update(ctx, ibuf, rsize);
 
@@ -772,7 +775,7 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 			bytes_read += rsize;
 		}
 
-		status = git_deflate(&s, stream->is_finished ? Z_FINISH : 0);
+		status = git_deflate(&s, is_finished ? Z_FINISH : 0);
 
 		if (!s.avail_out || status == Z_STREAM_END) {
 			size_t written = s.next_out - obuf;
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 398131e194..01bb81c63c 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -265,10 +265,17 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
 	int ret;
 
 	CALLOC_ARRAY(data, stream->size);
-	while (!stream->is_finished) {
+	while (1) {
 		ssize_t bytes_read;
 
 		bytes_read = odb_write_stream_read(stream, buf, sizeof(buf));
+		if (bytes_read < 0) {
+			ret = error("failed to read object stream");
+			goto out;
+		}
+		if (!bytes_read)
+			break;
+
 		if (total_read + bytes_read > stream->size) {
 			ret = error("object stream yielded more bytes than expected");
 			goto out;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 77a2adb52a..361b4e2a2a 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -859,6 +859,7 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 	struct strbuf filename = STRBUF_INIT;
 	unsigned char buf[8192];
 	int dirlen;
+	bool is_finished = false;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
@@ -889,7 +890,7 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 	do {
 		unsigned char *in0 = stream.next_in;
 
-		if (!stream.avail_in && !in_stream->is_finished) {
+		if (!stream.avail_in && !is_finished) {
 			ssize_t read_len = odb_write_stream_read(in_stream, buf,
 								 sizeof(buf));
 			if (read_len < 0) {
@@ -898,12 +899,15 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 				goto cleanup;
 			}
 
+			/* All data has been read. */
+			if (!read_len) {
+				is_finished = true;
+				flush = 1;
+			}
+
 			stream.avail_in = read_len;
 			stream.next_in = buf;
 			in0 = buf;
-			/* All data has been read. */
-			if (in_stream->is_finished)
-				flush = 1;
 		}
 		ret = write_loose_object_common(loose, &c, &compat_c, &stream, flush, in0, fd,
 						compressed, sizeof(compressed));
diff --git a/odb/streaming.c b/odb/streaming.c
index 38c2f6687c..912e75e682 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -310,7 +310,7 @@ static ssize_t read_object_fd(struct odb_write_stream *stream,
 	ssize_t read_result;
 	size_t count;
 
-	if (stream->is_finished)
+	if (!data->remaining)
 		return 0;
 
 	count = data->remaining < len ? data->remaining : len;
@@ -319,8 +319,6 @@ static ssize_t read_object_fd(struct odb_write_stream *stream,
 		return -1;
 
 	data->remaining -= count;
-	if (!data->remaining)
-		stream->is_finished = 1;
 
 	return read_result;
 }
@@ -337,5 +335,4 @@ void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
 	stream->data = data;
 	stream->read = read_object_fd;
 	stream->size = size;
-	stream->is_finished = 0;
 }
diff --git a/odb/streaming.h b/odb/streaming.h
index 4d7d31b5aa..5e8e6e532e 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -56,7 +56,6 @@ struct odb_write_stream {
 	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t);
 	void *data;
 	size_t size;
-	int is_finished;
 };
 
 /*
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 5ccc52dccc..4437140ed0 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -277,6 +277,9 @@ static ssize_t membuf_write_stream_read(struct odb_write_stream *stream,
 	struct membuf_write_stream *s = container_of(stream, struct membuf_write_stream, base);
 	size_t chunk_size = 2;
 
+	if (s->offset == s->base.size)
+		return 0;
+
 	if (chunk_size > len)
 		chunk_size = len;
 	if (chunk_size > s->base.size - s->offset)
@@ -285,8 +288,6 @@ static ssize_t membuf_write_stream_read(struct odb_write_stream *stream,
 	memcpy(buf, s->buf + s->offset, chunk_size);
 
 	s->offset += chunk_size;
-	if (s->offset == s->base.size)
-		s->base.is_finished = 1;
 
 	return chunk_size;
 }

-- 
2.55.0.679.g6767b8d81c.dirty

