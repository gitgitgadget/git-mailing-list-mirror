Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943DE2417FB
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924416; cv=none; b=h03a/7D9haaMwkRnSxiqVUt5gBQhE/NQGRiYJF1uqGjZJ7ArnaBikVvF07HCdi5UcOCrTb3ylkfNXA/G8DRmJg5fWRw7v1luOTZLiJlKCxZrKehDhacg8cxRvGVz5eXLHmQldYQlht8LjpenZElkzgeWlN2o/e5pwGpHrc0CTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924416; c=relaxed/simple;
	bh=dOvsrdFzPRG2ABD1HwMw8+kqmSu4f57U3hon0sglCdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQHiKuKf6urHX2HWO7+HBLN27WFyr/rcjYfsIoY764ZT2mHycIXUCzAlJzBehoNSLbrLVeij9BINwVzRTWUni+2UVlrMbfT7I0g+SSO4XCfvNmrh4mdqYVR5VUQvUPcaFu/yXmQRshdClXEYCntmDhFoaAlMaMVNA4ER3WEGWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kcNu2LAv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qSh3pivc; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kcNu2LAv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qSh3pivc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D74B1D0009A;
	Sun, 23 Nov 2025 14:00:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 23 Nov 2025 14:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924412;
	 x=1764010812; bh=vclkXhH71ZuRfXvUzJGrKcD+Qvu9WTIHdrHNT5CccL8=; b=
	kcNu2LAvrdPhDYD0Ax43iSxlhXYo/WdBxYs1GKbL2F7mBffmYWXUzaxnNl/0GlK6
	9zm811pgWTiGLUe+CyJEUqSND7hXehUfdRoedrHtcRsA/UPW6AhNm9iV5WtV0IVS
	8oQFMp+wSHxqoAxftZTabnzHvJYypKA5M8uZeCWqZQppAr3zttCT5AnOkxRiDAXr
	+aN5kPUPMckwaKO2NtIfz9d6kged3pGqRoMO9+LYt6QH38SIg3gL9QX2W8UWpmMP
	jO5SW24aBEHkPBrFeE/fycvOE9QqSJEv/BuZEZ/W+Dl60QhwIV6S6lJT7EmL5CV4
	vYCd48+k4VAy9v4DmiWu0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924412; x=
	1764010812; bh=vclkXhH71ZuRfXvUzJGrKcD+Qvu9WTIHdrHNT5CccL8=; b=q
	Sh3pivcXQmO0mAo485XVYspQpqc5LaecbeL+3qIgpKs+xFv0wbrmcM6cD3zP9yjj
	98RDGic60rBpSp1mE4TEFMloKKu+3lyHqZ4j5NO+qxoss0ifYnpNzIHsR84BXAI3
	IF/78xedp71rZOpSCJE3r3QCIdrgkZGt9Tx3BmOU6UEP2mo98PxleNnWEXXRJij+
	D38GCAjsqIqq6y4pxI9SIhOGt+OY9lyM6+dGQJYwCA1SsyVJ405zrrgvw9M2g/Ve
	qMiZaveg/LBrTLFt5kuXCQzz5AxYjglkLh0kcySZlAFXPo90JXb4+FCcd/QprMnw
	K0Fz0+AH8tfk9EgDka7QQ==
X-ME-Sender: <xms:vFkjaUMO7JdazjIpBNgVbR7f4ucBWZXtq3h1gxzr9mdouU7YuktG5g>
    <xme:vFkjaR8FRWdvOEdPpGQPPQzRF1nF4MAfk5t8Dk0b7TGMl6lo-qbrJCvz6hW-TiIZw
    5wEo2myyxHUPEyeGkl2pS-y4q7E5_J6E2PuKXUccQO0uCA311LC4jc>
X-ME-Received: <xmr:vFkjaQQWewOcORP2jpbP38hIaucyFGTEzCNOniBs4RFJUXHKnolGjAuAfLbQFalrqrll73xaLx8sohIKD5VKi2ypk9o23l3mfpUyfijn073Hqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vFkjabkFAK7IQBeMtAkX8WVpmdIFjs7PVmoFVKwLUiAw6ltFg0STsw>
    <xmx:vFkjaYTb83wmtOdT5HQ6sH-sqqEwV9m4TiH0wK0Wlrr5RbH964k2yQ>
    <xmx:vFkjaRNdU2_9qEeYdYQCPZ-BMN4rjFLAvD95eSZUE1i4KGfBnaoXBA>
    <xmx:vFkjaZXGjBu4yWXM0Og67ZAGFDexXCWbrow-rZvlrQPCdgek3vueQw>
    <xmx:vFkjaTxpEP4896qQpntSRmd0tDCtpNNtj22eKNK9FH8fCahgu031FSMe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 14:00:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6dc08d76 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 19:00:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:33 +0100
Subject: [PATCH v3 08/19] streaming: create structure for packed object
 streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-8-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

As explained in a preceding commit, we want to get rid of the union of
stream-type specific data in `struct odb_read_stream`. Create a new
structure for packed object streams to move towards this design.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 75 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/streaming.c b/streaming.c
index ac7b3026f5..788f04e83e 100644
--- a/streaming.c
+++ b/streaming.c
@@ -39,11 +39,6 @@ struct odb_read_stream {
 	enum { z_unused, z_used, z_done, z_error } z_state;
 
 	union {
-		struct {
-			struct packed_git *pack;
-			off_t pos;
-		} in_pack;
-
 		struct filtered_istream filtered;
 	} u;
 };
@@ -287,16 +282,23 @@ static int open_istream_loose(struct odb_read_stream **out,
  *
  *****************************************************************/
 
-static ssize_t read_istream_pack_non_delta(struct odb_read_stream *st, char *buf,
+struct odb_packed_read_stream {
+	struct odb_read_stream base;
+	struct packed_git *pack;
+	off_t pos;
+};
+
+static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *buf,
 					   size_t sz)
 {
+	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
 	size_t total_read = 0;
 
-	switch (st->z_state) {
+	switch (st->base.z_state) {
 	case z_unused:
-		memset(&st->z, 0, sizeof(st->z));
-		git_inflate_init(&st->z);
-		st->z_state = z_used;
+		memset(&st->base.z, 0, sizeof(st->base.z));
+		git_inflate_init(&st->base.z);
+		st->base.z_state = z_used;
 		break;
 	case z_done:
 		return 0;
@@ -311,21 +313,21 @@ static ssize_t read_istream_pack_non_delta(struct odb_read_stream *st, char *buf
 		struct pack_window *window = NULL;
 		unsigned char *mapped;
 
-		mapped = use_pack(st->u.in_pack.pack, &window,
-				  st->u.in_pack.pos, &st->z.avail_in);
+		mapped = use_pack(st->pack, &window,
+				  st->pos, &st->base.z.avail_in);
 
-		st->z.next_out = (unsigned char *)buf + total_read;
-		st->z.avail_out = sz - total_read;
-		st->z.next_in = mapped;
-		status = git_inflate(&st->z, Z_FINISH);
+		st->base.z.next_out = (unsigned char *)buf + total_read;
+		st->base.z.avail_out = sz - total_read;
+		st->base.z.next_in = mapped;
+		status = git_inflate(&st->base.z, Z_FINISH);
 
-		st->u.in_pack.pos += st->z.next_in - mapped;
-		total_read = st->z.next_out - (unsigned char *)buf;
+		st->pos += st->base.z.next_in - mapped;
+		total_read = st->base.z.next_out - (unsigned char *)buf;
 		unuse_pack(&window);
 
 		if (status == Z_STREAM_END) {
-			git_inflate_end(&st->z);
-			st->z_state = z_done;
+			git_inflate_end(&st->base.z);
+			st->base.z_state = z_done;
 			break;
 		}
 
@@ -338,17 +340,18 @@ static ssize_t read_istream_pack_non_delta(struct odb_read_stream *st, char *buf
 		 * or truncated), then use_pack() catches that and will die().
 		 */
 		if (status != Z_OK && status != Z_BUF_ERROR) {
-			git_inflate_end(&st->z);
-			st->z_state = z_error;
+			git_inflate_end(&st->base.z);
+			st->base.z_state = z_error;
 			return -1;
 		}
 	}
 	return total_read;
 }
 
-static int close_istream_pack_non_delta(struct odb_read_stream *st)
+static int close_istream_pack_non_delta(struct odb_read_stream *_st)
 {
-	close_deflated_stream(st);
+	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
+	close_deflated_stream(&st->base);
 	return 0;
 }
 
@@ -358,19 +361,17 @@ static int open_istream_pack_non_delta(struct odb_read_stream **out,
 				       struct packed_git *pack,
 				       off_t offset)
 {
-	struct odb_read_stream stream = {
-		.close = close_istream_pack_non_delta,
-		.read = read_istream_pack_non_delta,
-	};
+	struct odb_packed_read_stream *stream;
 	struct pack_window *window;
 	enum object_type in_pack_type;
+	size_t size;
 
 	window = NULL;
 
 	in_pack_type = unpack_object_header(pack,
 					    &window,
 					    &offset,
-					    &stream.size);
+					    &size);
 	unuse_pack(&window);
 	switch (in_pack_type) {
 	default:
@@ -381,13 +382,17 @@ static int open_istream_pack_non_delta(struct odb_read_stream **out,
 	case OBJ_TAG:
 		break;
 	}
-	stream.type = in_pack_type;
-	stream.z_state = z_unused;
-	stream.u.in_pack.pack = pack;
-	stream.u.in_pack.pos = offset;
 
-	CALLOC_ARRAY(*out, 1);
-	**out = stream;
+	CALLOC_ARRAY(stream, 1);
+	stream->base.close = close_istream_pack_non_delta;
+	stream->base.read = read_istream_pack_non_delta;
+	stream->base.type = in_pack_type;
+	stream->base.size = size;
+	stream->base.z_state = z_unused;
+	stream->pack = pack;
+	stream->pos = offset;
+
+	*out = &stream->base;
 
 	return 0;
 }

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

