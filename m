Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E51246762
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924412; cv=none; b=g0LCf87r9+Q5J4APePnhaK2UDlQGNV/c4385QZeSemBvO1AUe+oPuFKwjOi6nQjHIL1I+q0C04cvuWfR96Nx2sKKLhCM/f2OJX/4hpl2/jTMgqQTWMgamM9XcL+fraQG7DHqlpFtoChJsaTv83DYOV21SKoxYTHcfjcR0psG9Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924412; c=relaxed/simple;
	bh=UrnEQuA7TEqZ7olly83AAez8xtZEEgaXfsaa5OysXw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnUM80PBF7MRM0+V0li/+l05y1yWUV+Fq1eokFTfrSzBbRkpgK2uUx+OEq3CRqo7oRNoZN1BuzppgEgOzeF4R3DnITP0PkQKReOxYkQOtRC5sIDS/e7TMMchQISBQ4DjvryHsRFYS3/XoRItdELy8ugxrNfAk54QoCesI4eIGM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m1rG0ial; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qPbHGhcI; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m1rG0ial";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qPbHGhcI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1539A1D0009A;
	Sun, 23 Nov 2025 14:00:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 23 Nov 2025 14:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924409;
	 x=1764010809; bh=dvH6NPEUqYVqow80iHBl8NsLwgNTgeeJnDLnburz/aM=; b=
	m1rG0ial3cqq7y32TyS8Uq26JhbKHS8hWgqyr092lDUHJpSJFut2dnIrhas0GwVl
	vG5wzVGqW5OahLwIKrIP28P/H+32X+Uxl5mfISXvvVBh0uF8Z0p7wyWSaSRZVRLM
	L1umgMnQtOhOjphP+4S60oao53vm5kYyn9ff+itBV7a4rhtZMXVcaSP/TX7xThgM
	AoG3cM0eLNhmO9PAOGqlF2U3stbnHDTazdomkEDgaUsDR1q6Ra00ZQlYpMcpohBf
	s3cF80fIdyGUZtEO9wo7pgbWCFj8NqVIdSpER5C5PvKvqySrC/nH3QCC/EvTdfuB
	pFxuP8OVq+0NLZQ3SIzdsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924409; x=
	1764010809; bh=dvH6NPEUqYVqow80iHBl8NsLwgNTgeeJnDLnburz/aM=; b=q
	PbHGhcIiHpmz7bYBS+iWl8erjnLn8tlT4et2hxbQ7ggU0jXVVs9HEJGPPboyb374
	REYj6LFi8CAQqlW+qaZQLyyLL0BvYeAtmi9jpSK9fZ5RPtj/Qa5PGVEddv2rXVx1
	67DVDcP0EsIBhg0P70qMcdqkxnffXbtzunSZQQZcQdbuQYM3FR8tEWS8bbIrLxy9
	wDXZp1SKsOSFUG7gwArJjLNupjI0yAw871TWDRPvCzOfcZH05Iuz25ffw1a+Bb9h
	fvxJOMU+S8F1tBnznaFWdqFd3B8aO9BQDyjMtX4m0briQ1DbiRjxPiE17nL/rDJr
	LN1afc2SDy4CVKAvgeMXA==
X-ME-Sender: <xms:uVkjaf7W9NcecOK7t5Ztxny301TZzjEnqC2iUmlyA--ac1c4tdQfTQ>
    <xme:uVkjab5-vsXIFF7tJnnQN13lcNYG8K-kJw1UTxX_JfdttYB2YvDEwLzk5HcsXt7b2
    AIl1IJ3uKaVo-5F9C3iVgrKeQNxWMPm6fYeyJvLspcUMwj-dER_HA>
X-ME-Received: <xmr:uVkjabe4DGF4lYyUBe5-mdS7-NIhBtlM5ewF2rXS_b8zB6M-icmtAnOavConFv0B3GNdQAM8nGBifo2xctmSA1bbH1rLLcZyjG_B3dOAw0cyrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:uVkjafAdM5RMtPSE0j6oID_1ReTdbqRz1orNeFza42g8zaQT72mRxw>
    <xmx:uVkjae-UKm0p73z-ndLcLhs9zxARYvJ-U_5TmUJzvoWDjTI6YwKqAQ>
    <xmx:uVkjaaJx2plMf0gEjJiEtK0j9AhT40IxYU64ldrG4NnLSt3ZK_0sYg>
    <xmx:uVkjaXgBXYkeHxqXOEp6eVdsDjMT68jo836iiUF8Nbh7FnqeiAIcBw>
    <xmx:uVkjaa9JcoxHABH9Td2cmd9qfSoLfZCPuynH9LMst2dhDJABOFOWdtgy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 14:00:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eb0d8aa9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 19:00:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:32 +0100
Subject: [PATCH v3 07/19] streaming: create structure for loose object
 streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-7-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

As explained in a preceding commit, we want to get rid of the union of
stream-type specific data in `struct odb_read_stream`. Create a new
structure for loose object streams to move towards this design.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 85 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/streaming.c b/streaming.c
index 35307d7229..ac7b3026f5 100644
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

