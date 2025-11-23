Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5099F24A066
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924422; cv=none; b=AVPlaYvnnITbps5ZytOwXadxDBidrKCxhgUYbXW+3t8Gi5uLGDrULhCs7UELJbMh7agkkKmB1KYYdMD5JFR7CvnB51HBHLvp5iZMkeNDkgFz6L19XWg3BN4xdDrXa6z1kNI6PQIiHWiJ4VvYL3jGua/tfP3cBFuVpCQ6eA8iidY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924422; c=relaxed/simple;
	bh=8myHI4Vl1w7VqSHP7Cw7sSvquORalI9JfDh3/BIG02g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=daqwkAzwBAHaTGVfEksaoPqOvvePDwzCpq3EPTi2QGvd7w8ZNG/rWFTF9JItAz0LlodKECUsWDqK8V+GvKa0v2umSSKYkaVObHbLg2NGwzcXI6jNG9hN73UYgaOEfgOakkIN2giqzrWwTKrZoaHuq5buUTcXG1bp85VCO75d06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FIT8aDPl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gm7xQOOb; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FIT8aDPl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gm7xQOOb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 87C487A0091;
	Sun, 23 Nov 2025 14:00:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 23 Nov 2025 14:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924419;
	 x=1764010819; bh=IxFLwvYU7dKbI3x5bgLL7KC2dIbn9/2Mwt4Vz1gbnYI=; b=
	FIT8aDPlnKtibwYP/hpiiC7VPw+KPk3brM/5GwVC0EyzvAMb6z+m/Vv4DnTNqlpI
	N8f8fwvJ3YS6sPiJr3wSoVTCWz34NpjLh4Por2GX4Ior9oxJfm/o6OaxOzn9/gmq
	AfbAT9UKkEj8986/QP8Cipykf4ISPHR2gTWFYJ+UyuLVHNEWJSCoZ9Iil7lUeHPj
	EmqO++Q5aCdGoaKVG6RY2pfCzdD6soVmWyT8LmGKqBtxyD6IqHOSXSGR3/NkgeYM
	ceJhXXZ4Oh2k2t7wQd8LvecMKf7gEW6QYG/Xh0azaMljedqlbw35hemdWTytBXXW
	YEB65akdXuFZo1oYmSVNdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924419; x=
	1764010819; bh=IxFLwvYU7dKbI3x5bgLL7KC2dIbn9/2Mwt4Vz1gbnYI=; b=G
	m7xQOObLPMblgVjF5nzOiLMIigXxuvC+z44N49XkDVNVA/vJkVKz1XgitZ8pw9R/
	W1CgQKXoyMP9ybuX5kfUAOcqLq8CWQFWq2xSFsuixtShpWpIAWecuqnOXejlECKZ
	dyIRfFiTP565t0jKVLT4qEwC5zbqS7imGkej/6eWff/mAtPoW0aFP+7dPvQr5uPd
	rA030Z7oIodqRR0+ruVBAGWkjTSKzSe8aYqySVttcCL9/AH5pIvT4zLDNBoX2P7/
	p0HEWnJkUTK3rObPH6TApKUEVuNIrFci8ZdXEO72zKymO4Spa4tqV/xhEnYDKMny
	e9BkvCxnxkMv8wgSTxmuA==
X-ME-Sender: <xms:w1kjacd1c1JmrjRv3tymV4ztH1-HzhtKkwORWlCd4LrdsRJgrj4AbQ>
    <xme:w1kjaVOwnF_KpxOn-fdClRQdhGPljdWkr6Vu49OzZNQkeA768IXCxfKPV33kBAXJ0
    uRtKwJ9_EuMgoszrgS9eHY4huZb8GC1_S5u_nBt-9C-N1kNCCX4sA>
X-ME-Received: <xmr:w1kjaSizj3DmB2FgcEd6fjrWl052EPk5br7gNyf7eA3iBspIN-XzdePfWQH0n-Ym4TEuE9ozweS_9voYQJOZp-rkNBVu9Xfm_ve8xajo-UeAIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:w1kjaQ1GJboveRR7Wne47p-XbAUI5Op00CbxdiRfUlA-8jYLkEOl7g>
    <xmx:w1kjaUi3C0b6aJElniKboW16bvJxw7knebc0S8ggyg-TBYf-VFJQUA>
    <xmx:w1kjaYcHng6_C63S7oxcv0gnSkZ95x10rGs3SGu-OssLHoElfIiEaw>
    <xmx:w1kjafmRa74TkgSRFKSJGoDLwhhfyq54iQpnDHIdwQWpPmv53oeM4A>
    <xmx:w1kjaWBbezzJhoYpjcQ4oxsm8c5hoM0bDS2Nzv_rEj-94TavkvEGaoL4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 14:00:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 260ab69c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 19:00:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:35 +0100
Subject: [PATCH v3 10/19] streaming: move zlib stream into backends
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-10-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index 199cca5abb..46fddaf2ca 100644
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

