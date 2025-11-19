Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7351C2EA480
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538474; cv=none; b=YAKsfNmFHYrpDSEmP67ABApNQeYDDJ8PVRNjoBRdB3mP2AYEiEnXMfKsK+oyYLwGPdxYl9/EML0wckZy0N5xbAOAnrnmAzwg4XjpMdtnULH/XR5HAeBtWYruzRdvx5zDq5KyunMIOYObEUje8vk7BGLvTVCl1YaK2uqYPArrkRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538474; c=relaxed/simple;
	bh=bnMBxBxac2spkuNjqxWShhb2Kc4t2jNcuP+sLGk5tKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ER3M1U3UHpGQI+hrRgrQY8GIozjr0vhmpWqT6n89S6UUEaP1n1TAowl/AKiz6AhxyyyBHzsNzV+yDado56BPErPPQja6fkYXP0N9yce4cWCdIiDQfNaoBuMA44u/UQ1P1MXt0lSHz7IoSkeYsYrdj+CVA/nEVFwm/fmYa5yMIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SDmJflAM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PZJbrgJB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SDmJflAM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PZJbrgJB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 913F51400202
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 19 Nov 2025 02:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538470;
	 x=1763624870; bh=YANvimV5XgV06CSBLQ4zMJ4sDzvOiKDiygLLyi3/kWI=; b=
	SDmJflAMhnoX8h5tbRgCRjbKtV9CAWQHUwtuxLEVodKcyns22jxjdwv1HiWlbCAu
	keBQJmb80Nao6mFZyEd2DuEHiMyP+LIVIAR3um062XMXRciz8xKytQQXvDceC28D
	FPAC5pLl5aRGx/x0OzRlHiQedOUVrBiRlrCCsJgPMNY9UH6REntWIGLL8TZFXnTZ
	YfL9TI+OfvlvEj4MnkVwAR3BVukBG91gS/j8hMhZ0+282wdbat5AsmTROCF9JD1p
	6KByMuOpu56ZX1+XdOdn0DDBq8LAb2nkYIulpipqzuNo8YfkxyH3/DWjZDqI82lR
	sYTTjHgklhyPO1myOk9eiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538470; x=
	1763624870; bh=YANvimV5XgV06CSBLQ4zMJ4sDzvOiKDiygLLyi3/kWI=; b=P
	ZJbrgJBpXIb6sxuoQlNHAq7S5zCcVwoh5DK3dmVSpxID+nTSyD19AD+uns9DD2PX
	3KbdprrKeqKiJsCc96dMNoE4QximWlD0nFGexG5KW214dScdUQXXxT/+WWWzsZDf
	FMbqzP5GYeecs7ke+YhBZv8f9DRbL6pdrr2I8TDaO8HyfyplDKmCvZf0FcQkYqU3
	ldnrjPVmToHCcCYe+zZVbyxx1Hy7yZDM6Mu2IeppY+dhX9y7mJB3Vh0I02367S8r
	09jhEenLqN4s0e4eOy69pgx4khpyXXvs8ApCJC1TQiAM6wgatoTMu2vmY45f7znB
	iTSRzXbuEoH0fXZu5VPAw==
X-ME-Sender: <xms:JnYdaU4ea50W8bImm3aSm9gl7OGQ89ObX9OTy0OagxkW9Ea88IxKkQ>
    <xme:JnYdac0PXn4XLUcSRhBU3-8CQJRP0c95cTUJkuYoa3PZ-ZkCfmJIWcTGDIQBUaPIX
    MOaOYS_oImXE6Gk_2V58bd8f0psDs9ZWt_DBmCoTaLx7_H3zSKPJQ>
X-ME-Received: <xmr:JnYdaZFTXSNcYnZDx3HI8_TudsnjUrG90-kbwbiC9Xs8OM5TuwLTzPFOL2YtPqggCYW1MJiqgCojkENwztna-KH_WGOtOFcBiqM3RVwBqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:JnYdaeRb8hf-0ukd4HGfY7m77eyrH99WBz2VnxkMoprwfueXIF-ycg>
    <xmx:JnYdaYDtFAC19cgjmmBFGZcXaKQla3yXQZREotFXvOn6JawgVgh8Nw>
    <xmx:JnYdaW0M9YmfqnB-9CSUAPSP7h49kUEuLCkKYQTyx_emzoY11QD6zA>
    <xmx:JnYdaeVB---O5GAPda_lF40DCUdAftvMVCPGW7tRBbCKk64xCNNQkA>
    <xmx:JnYdaVZshX41hWIrhy3F4t9otKG8X4xNFTndIal6CLTK-HZbUbN74a6m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f4db5d36 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:47:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:07 +0100
Subject: [PATCH 07/18] streaming: create structure for loose object streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-7-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

As explained in a preceding commit, we want to get rid of the union of
stream-type specific data in `struct odb_read_stream`. Create a new
structure for loose object streams to move towards this design.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 85 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/streaming.c b/streaming.c
index 9018b10b23..190628c767 100644
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

