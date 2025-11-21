Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4EB335BC6
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710891; cv=none; b=i2bcJyFWB6Er67Ep/XmQJfKlak1ApJeqTyNKxbr8tu+f6/BhymhEU2jkEfgEB5qjCUes0YRAVLZIRiXqXk1jcREL5daT3/drS2GZwzoP10uaMuCYxxJEdyNCCyP3BhLorlVDaelAPQiL+S0fe/hFD/YFX4gOii2vPfn+qfyaK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710891; c=relaxed/simple;
	bh=v+llUDU3/3pyVfQyIbOXCIiISxGRvv2rKlMvq7h+kXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=idwk5aV4DlJlTYeWMyiFxf83qBJbElyTg5KR5Ru+iicD8IPePvkYnJt8sFS2DwNn8tilKXnxAnOJRbNjkwvvbMqypi36yn2dY854oQvGjO4NjkNCYYEKs0faMJRJ2T/DO4Sp9vEfEonoZKsEikXETpG0vzugjAOQOpwyhNjgGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mzuT8FCg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l/AkRqfE; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mzuT8FCg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l/AkRqfE"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 4FF751D0016C;
	Fri, 21 Nov 2025 02:41:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 21 Nov 2025 02:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710888;
	 x=1763797288; bh=MaBggAwMVmJ42GtAdweVlnYGPv6DHpX973UNpdqz/80=; b=
	mzuT8FCgXnr6CFBUJKBTN5Me1LJ9ufwBSumdcxbuJoKk82lWGcHgiSOqWqQsLrxg
	zaOLZ20bZkq20ZUefcheyS2g8fvr1128lA+3L6yBVSERnPdWIn3uMfpEpLZTQXcA
	wiTU7XyRJeqcyobP+F//S2ZlGROqGchfxRxbF2iyba3Hp7/7IoeWuOOEu5/BjDI0
	F24K/Hvouzb1yvp7iw9mu10QvhiyhyDtWcREXfnmcAD98QNP8CZw4wsr+smrtTKp
	i6d8BEGGix72rDk0GrnV8PN3ryXfsf8K9D+2PfrdYvbqdre8+8n/yxLfBlOm1X3D
	LjvCoPLKy+UkOW6DogM9kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710888; x=
	1763797288; bh=MaBggAwMVmJ42GtAdweVlnYGPv6DHpX973UNpdqz/80=; b=l
	/AkRqfEArKRiwrKmHapK+AGC2fDWAPT7qoJQX6bs3oKYOGrYPrvpoUpODbDTYh5V
	UjuRvaa8sau3Tutzq1tjwaTPa9UrJ42L4S7XWjb3o3KQB1+w6RkG5K1ibzSr3w5o
	iuqyghpcGkUvmL4xV5RCicMN2msvm3/D4QwfuSZ7P5jAY3uiZe6NETEZ11syjfP3
	Q9YoHXelN30s0NVijZknFHZNBVd1Ur5moT6rsZ2gf2HgE45lhqcwsPE358Cy4lSr
	rLa4+L9dwmrlDuLkv1PxnSEXhEtxbcUxcY8UDqeGgfZnqhVoaOxukBxzg028317D
	kNv3yIB8/syg9DL9SdRVw==
X-ME-Sender: <xms:pxcgad0zJZyu6ZCKhAml2o0Zerw82QZMGoC_BVz4Jbk97I09cx8GFA>
    <xme:pxcgabia_Q-8k6t-yhP0AMLz4hVAUuR0NrB9syy9_83JhaxNSEFQmaKrE12gWr1PL
    aStZa-D3XqKpY9ZUMZxiaet461-gXZnpUNdQ58yzLZcnNwCqex75g>
X-ME-Received: <xmr:pxcgabQ4Gg4zk60nrJlziBYqKrKDPv73VpOr4eeN6C7ZxI8y2njL7AhtwNFMYb-mK0nsrVNwbaKQChoQxsG-BEO8hxC18iZ268FxdM_f8Dzy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:pxcgaUhg1tZykmRlkm7CL1mjVc9V4xIPTAuK6ahoVCwOnqMAzf-wPA>
    <xmx:pxcgaT4qibAJAPb-Hz64ohWtxEywGO7WUbM5NAJRi0b3ahGq4hdPVg>
    <xmx:pxcgaZAxFCaCdp6ekErdN51YCqX7nwpuQ3hKMWGu3IwEFvSIbzVGUg>
    <xmx:pxcgaSaEs1kzgIliVVsEcdN5afgfnvLp6cfGyJlo7weuEwt3gvTDUw>
    <xmx:qBcgaX9e1tW3ezQixwWA5M16l7gi1stf2vo_FaRhc-N55zI9LCfGZHWh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 248d262d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:40:52 +0100
Subject: [PATCH v2 07/19] streaming: create structure for loose object
 streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-7-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

As explained in a preceding commit, we want to get rid of the union of
stream-type specific data in `struct odb_read_stream`. Create a new
structure for loose object streams to move towards this design.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 85 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/streaming.c b/streaming.c
index 3af2f0c776..193405d11e 100644
--- a/streaming.c
+++ b/streaming.c
@@ -39,14 +39,6 @@ struct odb_read_stream {
 	enum { z_unused, z_used, z_done, z_error } z_state;
 
 	union {
-		struct {
-			void *mapped;
-			unsigned long mapsize;
-			char hdr[32];
-			int hdr_avail;
-			int hdr_used;
-		} loose;
-
 		struct {
 			struct packed_git *pack;
 			off_t pos;
@@ -165,11 +157,21 @@ static struct odb_read_stream *attach_stream_filter(struct odb_read_stream *st,
  *
  *****************************************************************/
 
-static ssize_t read_istream_loose(struct odb_read_stream *st, char *buf, size_t sz)
+struct odb_loose_read_stream {
+	struct odb_read_stream base;
+	void *mapped;
+	unsigned long mapsize;
+	char hdr[32];
+	int hdr_avail;
+	int hdr_used;
+};
+
+static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t sz)
 {
+	struct odb_loose_read_stream *st = (struct odb_loose_read_stream *)_st;
 	size_t total_read = 0;
 
-	switch (st->z_state) {
+	switch (st->base.z_state) {
 	case z_done:
 		return 0;
 	case z_error:
@@ -178,42 +180,43 @@ static ssize_t read_istream_loose(struct odb_read_stream *st, char *buf, size_t
 		break;
 	}
 
-	if (st->u.loose.hdr_used < st->u.loose.hdr_avail) {
-		size_t to_copy = st->u.loose.hdr_avail - st->u.loose.hdr_used;
+	if (st->hdr_used < st->hdr_avail) {
+		size_t to_copy = st->hdr_avail - st->hdr_used;
 		if (sz < to_copy)
 			to_copy = sz;
-		memcpy(buf, st->u.loose.hdr + st->u.loose.hdr_used, to_copy);
-		st->u.loose.hdr_used += to_copy;
+		memcpy(buf, st->hdr + st->hdr_used, to_copy);
+		st->hdr_used += to_copy;
 		total_read += to_copy;
 	}
 
 	while (total_read < sz) {
 		int status;
 
-		st->z.next_out = (unsigned char *)buf + total_read;
-		st->z.avail_out = sz - total_read;
-		status = git_inflate(&st->z, Z_FINISH);
+		st->base.z.next_out = (unsigned char *)buf + total_read;
+		st->base.z.avail_out = sz - total_read;
+		status = git_inflate(&st->base.z, Z_FINISH);
 
-		total_read = st->z.next_out - (unsigned char *)buf;
+		total_read = st->base.z.next_out - (unsigned char *)buf;
 
 		if (status == Z_STREAM_END) {
-			git_inflate_end(&st->z);
-			st->z_state = z_done;
+			git_inflate_end(&st->base.z);
+			st->base.z_state = z_done;
 			break;
 		}
 		if (status != Z_OK && (status != Z_BUF_ERROR || total_read < sz)) {
-			git_inflate_end(&st->z);
-			st->z_state = z_error;
+			git_inflate_end(&st->base.z);
+			st->base.z_state = z_error;
 			return -1;
 		}
 	}
 	return total_read;
 }
 
-static int close_istream_loose(struct odb_read_stream *st)
+static int close_istream_loose(struct odb_read_stream *_st)
 {
-	close_deflated_stream(st);
-	munmap(st->u.loose.mapped, st->u.loose.mapsize);
+	struct odb_loose_read_stream *st = (struct odb_loose_read_stream *)_st;
+	close_deflated_stream(&st->base);
+	munmap(st->mapped, st->mapsize);
 	return 0;
 }
 
@@ -222,7 +225,7 @@ static int open_istream_loose(struct odb_read_stream **out,
 			      const struct object_id *oid)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
-	struct odb_read_stream *st;
+	struct odb_loose_read_stream *st;
 	struct odb_source *source;
 	unsigned long mapsize;
 	void *mapped;
@@ -244,8 +247,8 @@ static int open_istream_loose(struct odb_read_stream **out,
 	 */
 	CALLOC_ARRAY(st, 1);
 
-	switch (unpack_loose_header(&st->z, mapped, mapsize, st->u.loose.hdr,
-				    sizeof(st->u.loose.hdr))) {
+	switch (unpack_loose_header(&st->base.z, mapped, mapsize, st->hdr,
+				    sizeof(st->hdr))) {
 	case ULHR_OK:
 		break;
 	case ULHR_BAD:
@@ -253,26 +256,26 @@ static int open_istream_loose(struct odb_read_stream **out,
 		goto error;
 	}
 
-	oi.sizep = &st->size;
-	oi.typep = &st->type;
+	oi.sizep = &st->base.size;
+	oi.typep = &st->base.type;
 
-	if (parse_loose_header(st->u.loose.hdr, &oi) < 0 || st->type < 0)
+	if (parse_loose_header(st->hdr, &oi) < 0 || st->base.type < 0)
 		goto error;
 
-	st->u.loose.mapped = mapped;
-	st->u.loose.mapsize = mapsize;
-	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
-	st->u.loose.hdr_avail = st->z.total_out;
-	st->z_state = z_used;
-	st->close = close_istream_loose;
-	st->read = read_istream_loose;
+	st->mapped = mapped;
+	st->mapsize = mapsize;
+	st->hdr_used = strlen(st->hdr) + 1;
+	st->hdr_avail = st->base.z.total_out;
+	st->base.z_state = z_used;
+	st->base.close = close_istream_loose;
+	st->base.read = read_istream_loose;
 
-	*out = st;
+	*out = &st->base;
 
 	return 0;
 error:
-	git_inflate_end(&st->z);
-	munmap(st->u.loose.mapped, st->u.loose.mapsize);
+	git_inflate_end(&st->base.z);
+	munmap(st->mapped, st->mapsize);
 	free(st);
 	return -1;
 }

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

