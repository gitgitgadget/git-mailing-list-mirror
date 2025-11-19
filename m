Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8FF2EFD81
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538476; cv=none; b=mRl2l6TLLwEdfA+vDshKDnX/6AFTeYTD9B58q1c5SV5kpweMHaE9ezXUk+TFvCDvWqYZ/MND66pkqFywhBMMVehbUgi9wbpb0H3gKnM0y0WnGnYMUJiOLWeAP+Cu7XqDyXQjfOn5XqxOY5J+qOMC5VbveH4CQZc3952zvTEcTTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538476; c=relaxed/simple;
	bh=YPkLxZ+8O+END01oPPA2DHg6/CoSu4IJE186WKE9izo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JjqdPWDT7tPldglbfibatigz6bmWXB5GKFwIvTWsXEqYGlMSq7jQCL9AGSRBBD3ZOZzzaTQqrcCG+eqBcEsSYMKK3A0Je8XL01b3kOMxgwdqnO+moWIwE+fx/YN9l+zpXnNn7M+XEpZxtVEeSNJtTtt/lZ5v4i+1qNwwJcWX+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hTRg25hS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qe0+7fx6; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hTRg25hS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qe0+7fx6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4325A14001FA
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 19 Nov 2025 02:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538474;
	 x=1763624874; bh=AmlHAboTHaQQIrN/1xPj+zRy6W7ESqYLWEqFC3uOd0I=; b=
	hTRg25hSERyGf31vzkjgbcPQYovptl/34NiFAl1tx5ulpHqpUVuMHHcPlPmCOS0B
	CX8Kzb/F8HQ9xmjdYCNfmh0yy8SufS+IKDQCSiHdFTDpk48rp6BzNi16gERdLgaW
	EBI8tRYu2sPOkOSWA6vTW68PAmkBxFipV3FmSjCWwSX/icxGC+qNL1Z5KWBAteGs
	ijuPBkVeHDM6TVxb7zVrDn/bXl1o81aTdXb37aUTVcbu4Yer61VwTM9wvwb5HqmV
	E+TckCC5O3pKNXDnFri/ERAo5txAnXLrwUyRP3dKWQJ/+hGR+pY1MX3IJOJ2Da8Q
	xmnVkJl/Y4KnVb7l4xMOEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538474; x=
	1763624874; bh=AmlHAboTHaQQIrN/1xPj+zRy6W7ESqYLWEqFC3uOd0I=; b=Q
	e0+7fx6h5vIjv1MNQLiIc/pHrlrDGUTReoDBoHlVW6ysKyf1PKKk2USvWQYb3zx7
	OKlFpbgLmW6VQxYsqtp4hLRda1+KtUKcXOwlwiofAGUXdwBr3onRrROSXcr3T1HI
	kjOB5KrvoXEKDnnt0/j46KQh5S/AEvoZ8DlE2ETkj1ARH4Xig80LcIs+3HppbCoo
	+/b8VZTmoxYgM+yZ+MzLFE4A7uyMjbAC97r12kV4NwWFMKoc798OQxW5eSQTMQ70
	Db3+HszCEBhRBXj/8ld7WZzpABKWoeIERHfGV3aQJTt7XVFGAkX4y4oz4xsSpRvF
	GwkA9LNv30fdUgKOSJsPg==
X-ME-Sender: <xms:KnYdaTXcwrdPWvAElHsSycv4bbie8zbdS-VGeDRbnx-n6BH429urPw>
    <xme:KnYdaSh1S-33SiDnbqsAb2AJxLDR5p4ch6jr5bAdbtaprWTLBWkGpL7joDHOrmmmh
    HQpgAJifSYk15gP3lSW3EI39ZUvWDl3r8cBgVl9nxdR1CxWZ3Mnzw>
X-ME-Received: <xmr:KnYdaVA9ZQFuBD0XCpkq-yQ_lBVDFXV4ITAeCtThVXlM9PK6Lw14O7BexUjdj1HFneBECLyvRf2xxTimGAuLKZg6eYHAr_0gNVpvLneMAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:KnYdaTd8ZtsypWG3mKPVRwnnB-R9-bCADoiFUONWSh0Llj-6OyM0MA>
    <xmx:KnYdaddCFVTsf_keEcFFtY6l5GOnQy4AZkFCw1HJ1zyjxOZpnTybYg>
    <xmx:KnYdaXiM-biVRILymJCtGcA82zERHO4NP1m2yfJewYEDEPUtBn8oHw>
    <xmx:KnYdaZSoE5QOcHHLx0OrD0WxKi4yzSfvLNP84v1eX2w0I8WCeD-jmQ>
    <xmx:KnYdaWlH3szIIBRBHc8DdD8syCuA6EMK_3mLuUr0vElloLLD3nQ4gpxT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7171eb90 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:47:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:08 +0100
Subject: [PATCH 08/18] streaming: create structure for packed object
 streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-8-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

As explained in a preceding commit, we want to get rid of the union of
stream-type specific data in `struct odb_read_stream`. Create a new
structure for packed object streams to move towards this design.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 75 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/streaming.c b/streaming.c
index 190628c767..435ead1066 100644
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

