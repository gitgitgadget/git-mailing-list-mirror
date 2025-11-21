Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C7B338F56
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710901; cv=none; b=ddB2A0leXrE+tu3v5ScLp8j8M8vsR0wzGzYQRPWtLAXE/ucBj1MSLydoo179PFAwnLeu93gPRgxzvVQz33C4qAC/Zo/uIBHpSXNBuM7SjdzXniBBWswqC19PEFAExD66oeeTbL+MxHrGreR+WpeLnnzB2gyBGeNahVlh922crz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710901; c=relaxed/simple;
	bh=fo5kvEffQTQKwZMAN6nOtt+g3xqnbz4dYcaEZkuODEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLoRPFytHQS0UNNUyrHmEUJL35w70JOzadI+9u+VjUtSWly8TNYX/IqVTvXbHmvXvJ2ZUYiGX59/iWqpsq4IJwbtMjtgpzlvfH0kt/qby7C3LOyqkY17P1/Lvuu9cIKMKyWrjJWTzWhs7ud30S3D9uKd904Fgq9sv2mCc9tJLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OJKJyn0N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v0SCFeJD; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OJKJyn0N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v0SCFeJD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3EFBB1D00176;
	Fri, 21 Nov 2025 02:41:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 21 Nov 2025 02:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710899;
	 x=1763797299; bh=nUTaUuZL+UUmJpluVGsZJ7/KfkBFxu9Lewq4Na9gW7Y=; b=
	OJKJyn0N8WleLhuiYr5nbdhS5tQjNz+jK//hil9H4AvjwV4iXyyPYKNzCb/dA/pT
	wXXXdC9foT8GXhLyfZRvqkRzGBMTphqAUn2hd11Pxh/CeNxC5LyOyjjlvOjlYh0C
	wmDqo/FvILDTGoyjO+2zhItmuL44PafbOffiIcaanywBWOxLon91tZqv5jbO7z6r
	qTByOliR90z7v82rP/30rmhwtU+WNLvOFnS4sRtLrdkVVARPDZR7Cyhg0IhdsRju
	McPgM4/YfFLRa94UvnGPfpItbjeocFLoQQHbuOCFvFldtz2auWyp63jVXNizdzD/
	vSGnYwguLAUroF7Z9eepIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710899; x=
	1763797299; bh=nUTaUuZL+UUmJpluVGsZJ7/KfkBFxu9Lewq4Na9gW7Y=; b=v
	0SCFeJDA/nERIiglXxJP3dX5icuItZXetrNw+evcMpAno/RVdK6ykXH+9ALyVrPy
	4hUq/lLp89GWWqHlxxhCrZwkdipIuOdd89/J38FBh27CXzIiFXR+Vl4f1YyLaBvg
	egkak5KP8TtSmpwfw6sBabmvv3YZqBYCkHKVyGR3rguC853ie0CXtkLWFjA5Pqso
	rT2L3HHFNKufsVLARxmoW3tu6gz3Fqo2zvh0HI2/d4KY/WXlEf7Xu0K5R8s/P9ct
	2IlGL8zrPWarJIHT4T+xwThvk1lESCzmMrr7kCfnJZmZTBZu682Vtir92kR6ZDOY
	XjOUvKNXfOaK7FDXC2IwQ==
X-ME-Sender: <xms:shcgaSthe14eXp8w38YNleHlHKk0HSzOzLByTqSywMRBBByis8vhIw>
    <xme:shcgae74SqPEDZ_18Zhul18YokC7x9MBFSRQHJNopr_1pQwccY6KIvTzIf_8RF_qZ
    8lHStpjrH38wtvWqC6-iTewBsJuZfRxK2OmH7LRTbWmMuprLqv22w>
X-ME-Received: <xmr:shcgabLZd_YbzDu7yerBIuQT3GXgS_Zo5DcMS9j2sQxMP7GYPXRurkYyPyoMHZf9PjOVbeGvXwmgZ4Uokbs0Nry1m87_6eQJsZKYU8IHmYIl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:shcgaW4ggJPKorzcqvAZLs7i2f0QNdqk59VAROxs2U7Je-aTltHeUw>
    <xmx:shcgaWweep4prnp9HbWzprGTEfB-qLnXrNe6NeB-TTCzwHXREOR5dg>
    <xmx:shcgaSZ9de_2BWCHnQW7ywiwA_RWudVhg7cfcoerKO-iBZIhQpY7Mw>
    <xmx:shcgaQR3UUTlJMCFf1iOPC_vvvsm6H_WMrscWDMyopTjvFYjnruU6A>
    <xmx:sxcgaRUwDMMnKazpWN74CroSbQv9BoXzxZ-S_YBcZixUs5Joz6c-X8tW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id effbc645 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:40:55 +0100
Subject: [PATCH v2 10/19] streaming: move zlib stream into backends
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-10-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

While all backend-specific data is now contained in a backend-specific
structure, we still share the zlib stream across the loose and packed
objects.

Refactor the code and move it into the specific structures so that we
fully detangle the different backends from one another.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 104 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/streaming.c b/streaming.c
index 45463b5c55..93fe72182a 100644
--- a/streaming.c
+++ b/streaming.c
@@ -25,23 +25,8 @@ struct odb_read_stream {
 
 	enum object_type type;
 	unsigned long size; /* inflated size of full object */
-	git_zstream z;
-	enum { z_unused, z_used, z_done, z_error } z_state;
 };
 
-/*****************************************************************
- *
- * Common helpers
- *
- *****************************************************************/
-
-static void close_deflated_stream(struct odb_read_stream *st)
-{
-	if (st->z_state == z_used)
-		git_inflate_end(&st->z);
-}
-
-
 /*****************************************************************
  *
  * Filtered stream
@@ -150,6 +135,12 @@ static struct odb_read_stream *attach_stream_filter(struct odb_read_stream *st,
 
 struct odb_loose_read_stream {
 	struct odb_read_stream base;
+	git_zstream z;
+	enum {
+		ODB_LOOSE_READ_STREAM_INUSE,
+		ODB_LOOSE_READ_STREAM_DONE,
+		ODB_LOOSE_READ_STREAM_ERROR,
+	} z_state;
 	void *mapped;
 	unsigned long mapsize;
 	char hdr[32];
@@ -162,10 +153,10 @@ static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t
 	struct odb_loose_read_stream *st = (struct odb_loose_read_stream *)_st;
 	size_t total_read = 0;
 
-	switch (st->base.z_state) {
-	case z_done:
+	switch (st->z_state) {
+	case ODB_LOOSE_READ_STREAM_DONE:
 		return 0;
-	case z_error:
+	case ODB_LOOSE_READ_STREAM_ERROR:
 		return -1;
 	default:
 		break;
@@ -183,20 +174,20 @@ static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t
 	while (total_read < sz) {
 		int status;
 
-		st->base.z.next_out = (unsigned char *)buf + total_read;
-		st->base.z.avail_out = sz - total_read;
-		status = git_inflate(&st->base.z, Z_FINISH);
+		st->z.next_out = (unsigned char *)buf + total_read;
+		st->z.avail_out = sz - total_read;
+		status = git_inflate(&st->z, Z_FINISH);
 
-		total_read = st->base.z.next_out - (unsigned char *)buf;
+		total_read = st->z.next_out - (unsigned char *)buf;
 
 		if (status == Z_STREAM_END) {
-			git_inflate_end(&st->base.z);
-			st->base.z_state = z_done;
+			git_inflate_end(&st->z);
+			st->z_state = ODB_LOOSE_READ_STREAM_DONE;
 			break;
 		}
 		if (status != Z_OK && (status != Z_BUF_ERROR || total_read < sz)) {
-			git_inflate_end(&st->base.z);
-			st->base.z_state = z_error;
+			git_inflate_end(&st->z);
+			st->z_state = ODB_LOOSE_READ_STREAM_ERROR;
 			return -1;
 		}
 	}
@@ -206,7 +197,8 @@ static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t
 static int close_istream_loose(struct odb_read_stream *_st)
 {
 	struct odb_loose_read_stream *st = (struct odb_loose_read_stream *)_st;
-	close_deflated_stream(&st->base);
+	if (st->z_state == ODB_LOOSE_READ_STREAM_INUSE)
+		git_inflate_end(&st->z);
 	munmap(st->mapped, st->mapsize);
 	return 0;
 }
@@ -238,7 +230,7 @@ static int open_istream_loose(struct odb_read_stream **out,
 	 */
 	CALLOC_ARRAY(st, 1);
 
-	switch (unpack_loose_header(&st->base.z, mapped, mapsize, st->hdr,
+	switch (unpack_loose_header(&st->z, mapped, mapsize, st->hdr,
 				    sizeof(st->hdr))) {
 	case ULHR_OK:
 		break;
@@ -256,8 +248,8 @@ static int open_istream_loose(struct odb_read_stream **out,
 	st->mapped = mapped;
 	st->mapsize = mapsize;
 	st->hdr_used = strlen(st->hdr) + 1;
-	st->hdr_avail = st->base.z.total_out;
-	st->base.z_state = z_used;
+	st->hdr_avail = st->z.total_out;
+	st->z_state = ODB_LOOSE_READ_STREAM_INUSE;
 	st->base.close = close_istream_loose;
 	st->base.read = read_istream_loose;
 
@@ -265,7 +257,7 @@ static int open_istream_loose(struct odb_read_stream **out,
 
 	return 0;
 error:
-	git_inflate_end(&st->base.z);
+	git_inflate_end(&st->z);
 	munmap(st->mapped, st->mapsize);
 	free(st);
 	return -1;
@@ -281,6 +273,13 @@ static int open_istream_loose(struct odb_read_stream **out,
 struct odb_packed_read_stream {
 	struct odb_read_stream base;
 	struct packed_git *pack;
+	git_zstream z;
+	enum {
+		ODB_PACKED_READ_STREAM_UNINITIALIZED,
+		ODB_PACKED_READ_STREAM_INUSE,
+		ODB_PACKED_READ_STREAM_DONE,
+		ODB_PACKED_READ_STREAM_ERROR,
+	} z_state;
 	off_t pos;
 };
 
@@ -290,17 +289,17 @@ static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *bu
 	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
 	size_t total_read = 0;
 
-	switch (st->base.z_state) {
-	case z_unused:
-		memset(&st->base.z, 0, sizeof(st->base.z));
-		git_inflate_init(&st->base.z);
-		st->base.z_state = z_used;
+	switch (st->z_state) {
+	case ODB_PACKED_READ_STREAM_UNINITIALIZED:
+		memset(&st->z, 0, sizeof(st->z));
+		git_inflate_init(&st->z);
+		st->z_state = ODB_PACKED_READ_STREAM_INUSE;
 		break;
-	case z_done:
+	case ODB_PACKED_READ_STREAM_DONE:
 		return 0;
-	case z_error:
+	case ODB_PACKED_READ_STREAM_ERROR:
 		return -1;
-	case z_used:
+	case ODB_PACKED_READ_STREAM_INUSE:
 		break;
 	}
 
@@ -310,20 +309,20 @@ static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *bu
 		unsigned char *mapped;
 
 		mapped = use_pack(st->pack, &window,
-				  st->pos, &st->base.z.avail_in);
+				  st->pos, &st->z.avail_in);
 
-		st->base.z.next_out = (unsigned char *)buf + total_read;
-		st->base.z.avail_out = sz - total_read;
-		st->base.z.next_in = mapped;
-		status = git_inflate(&st->base.z, Z_FINISH);
+		st->z.next_out = (unsigned char *)buf + total_read;
+		st->z.avail_out = sz - total_read;
+		st->z.next_in = mapped;
+		status = git_inflate(&st->z, Z_FINISH);
 
-		st->pos += st->base.z.next_in - mapped;
-		total_read = st->base.z.next_out - (unsigned char *)buf;
+		st->pos += st->z.next_in - mapped;
+		total_read = st->z.next_out - (unsigned char *)buf;
 		unuse_pack(&window);
 
 		if (status == Z_STREAM_END) {
-			git_inflate_end(&st->base.z);
-			st->base.z_state = z_done;
+			git_inflate_end(&st->z);
+			st->z_state = ODB_PACKED_READ_STREAM_DONE;
 			break;
 		}
 
@@ -336,8 +335,8 @@ static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *bu
 		 * or truncated), then use_pack() catches that and will die().
 		 */
 		if (status != Z_OK && status != Z_BUF_ERROR) {
-			git_inflate_end(&st->base.z);
-			st->base.z_state = z_error;
+			git_inflate_end(&st->z);
+			st->z_state = ODB_PACKED_READ_STREAM_ERROR;
 			return -1;
 		}
 	}
@@ -347,7 +346,8 @@ static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *bu
 static int close_istream_pack_non_delta(struct odb_read_stream *_st)
 {
 	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
-	close_deflated_stream(&st->base);
+	if (st->z_state == ODB_PACKED_READ_STREAM_INUSE)
+		git_inflate_end(&st->z);
 	return 0;
 }
 
@@ -384,7 +384,7 @@ static int open_istream_pack_non_delta(struct odb_read_stream **out,
 	stream->base.read = read_istream_pack_non_delta;
 	stream->base.type = in_pack_type;
 	stream->base.size = size;
-	stream->base.z_state = z_unused;
+	stream->z_state = ODB_PACKED_READ_STREAM_UNINITIALIZED;
 	stream->pack = pack;
 	stream->pos = offset;
 

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

