Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074DE422533
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828352; cv=none; b=hiwsgJ1aieQvt8ZZv8BH0nzNyh6JOVEvz2ZpgORJ+0hG0Bo/ZDRAcyqjnTzY3CVefykuuQal0NwwjkxkHGwGjkq9HnI3mUQmYzri2iQozj++Bzwq+RUVEQJfC1DplHN8oJ28ciMK7+3EwLdzsX5AlpV6kNhuNKwWU/Ejy41yA2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828352; c=relaxed/simple;
	bh=17JgYgQQEu6gNGIED0wLiWLM4o9vKnQazkpXy9dHUzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVgWvWKsJmN3UOHhlKmR9Uo1PS6vSz7UPF7aM/ZIt+Dx3HUtEwQEhKKLSkS6Iec2I1aJ8HBPv88eLgLcvLyyp+c1gYe4SBgiiv4D6eSxBEDM8f6JN1UJo9JkuhoT3lqvJx4Ac06D6BbaSscRI4kuHrAnjD1QwlXVNzg9VRyycAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OtVj13ky; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M4WQtnr/; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OtVj13ky";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M4WQtnr/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id F04D21D00187
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 03:25:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 03:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785828349;
	 x=1785914749; bh=wQW+EMWkMFuZjgB6g87cP3DWaMlru9J7rGjT20Lvb+Q=; b=
	OtVj13kyTF4hDEi5yCQRiBi4rgEpi8aNrXhOrXRCOV2f2JbqcUWZoO8iJvw+cSrf
	BDLLx8szNkavY1kOAKIgDYJg1iizk4Y3G+yJ4CF9R6T6N1oIR1Y5Y8ebQxdy0dv2
	21m2tqA359ppRkpGRfQDnDo+x9RL9Dbl15HW4Zk8KBnOVjcmRQ6klcyme5/mqnfe
	QHr+X5jOJ0+KSllAD+rNvbkt8cl8yErSBypYkFvBcIM53IB+o0MNeCyUORYTlwrs
	b/ofo2wSue6r5NsPBcqP3eQUOAfKstZHRZIe3y1buloXcXiJuRKwqElsLu9DVyRJ
	E+3ZVrC5nhkYjoYswxMykg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785828349; x=
	1785914749; bh=wQW+EMWkMFuZjgB6g87cP3DWaMlru9J7rGjT20Lvb+Q=; b=M
	4WQtnr/+nmSPiktWCNEQPSJv9sLw7kFuwoLSk18aaGvT+B38ZD/iZNayUpMqNMcE
	1G56Na9pswInFytlzLcsUYMVqFoAvfC6gfoYhz7i+7v7QogDvhEAUATUGgITM8Tw
	gOfCGzNJh4yRp55DrRp/OTfrHc95Y5rp3or4XNT3Lx3WTB0r7a0s80X+iIw+XukA
	Rvl4HYCPPYCekQrduhT16aYcYwIUDatJLLItBZ2358pckEeYo6ISUECpyEGrvaxw
	jWpdOPUtaV+hyidMBYtCeWEjtmV5WwsW71bxxytIcm+0fIoR/TKQDxhWwIpOY9mP
	4P9AsVKpioYTUzy8yUWsQ==
X-ME-Sender: <xms:_ZNxag4ClEfObA6I5IZmEceWAHTtEX755JbRcMzKjGMg88edqCs0Ug>
    <xme:_ZNxao2IZSMazLht83GIQVeKIGYzHXNeWM8Vdm4ji9g56__l8m64nZKld_-3hWDkY
    vhHtMhATDuuQhNpTjrjFPlRwdKfmuX0dlUfh35COMtuClz810PZrw>
X-ME-Received: <xmr:_ZNxalE9CO_2KEF3wgNZvXuWobF4GyVhrY_05XVt8Wttov7JQoRbMOGdvdG_08DEZebHr6OYwcc7ZV_IkLEqQ1GwQUF25pDlJCbif7dT>
X-ME-Proxy-Cause: dmFkZTGJA/hd69o6AiEEnltmxxNPL/iz2JXYj1ZUCV9O8/iM3GIVZKb1NAe3PBzTWzWtB+
    O4CAqSBZES2dh/iHdrp95HkrzL3i2X/F9QiW1doHWb6x6GaLIXzJBuTNRp2y4lqMTv2GPB
    strxDCbZ/EYeXFpjwhGxsag30tHIR0f3Iac3xcq5uCaTWL6TQOZY6GBfzmgt06EFd2/PEV
    tiG3bIE1zpEvoMZ2EaS4OunWnPZ2CH/1Nsq1PgNvH5S47PGjbE4jcG6Ukz0+bMhrbt9Hsg
    HQqHiZld24lnD8uXrgPpPeulB5cTahmBAqH+Z2fisxWNmmWeJQiJh/a7h3YqjBCF/CcKt1
    gv2VAXap4vNT4OuaOzwTflG/HQ1RQi2GJti4JiJJtuAvNi+Q8wR2Zvo5OAJk3KoMtq6wPT
    MHSUPfa8Gr79Oydhy+9VsvvyYvprv9Ja69nnvuH3eH/SEY4xB/15EGfVrPL/FwJf5Z7CYJ
    7gKVPCKj/PpCUK8Cj4UiZO05YZKSdzY0hLpd+jevmGJajL7EDJgdfIAwgW7d8kOqfiL3wc
    FF5TRjlqZuhO/bN9re7lET8/Ks7oJGjSdOYNH+9r3wfZemdpMQAZ/RFWElupy5he2pawUW
    tMkv8TDvJntST23z40RDRu00rOK9HitozJ+6o2GVTaSyBHjFwNPk9vj3zM7g
X-ME-Proxy: <xmx:_ZNxaqRiulpidhJKKYkpMuQBzW_c73PiMXGcQxdptkHMpP1A0yNfwg>
    <xmx:_ZNxakBNUN6gbWqVFE0jr5tqCRzsSHrAs8_hhZORu-NDooFBcHnpXQ>
    <xmx:_ZNxai1RQ0ajojoEfVN02N3gnLdQr5UfaXzFDbauQCYsXLinN5YBLA>
    <xmx:_ZNxaqUHE1DvoFPn0veaSToWJRLhYds0RZRd-dlewz2pkYpr1jk4TQ>
    <xmx:_ZNxahajXBJi37OjAgpJHRPPK56hoMiX5SC1FrhJNhYRCQzphzgYBTQB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 4 Aug 2026 03:25:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 783ac8e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 4 Aug 2026 07:25:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 04 Aug 2026 09:25:30 +0200
Subject: [PATCH 2/7] odb/streaming: drop `is_finished` field
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-pks-odb-stream-unification-v1-2-86d70e82345e@pks.im>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
In-Reply-To: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
To: git@vger.kernel.org
Cc: 
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

