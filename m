Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609943218CF
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538462; cv=none; b=udhVqw2gHuRZUhkEcJ7CFl8icf90wHCSjUc4/lXcwtYQo9NH5NzCIdbie2J9xoRWHmgr0qGxNfyesNPyB2/I/lFIesbmEhV7sbVckV6BlAOdksoNByynF/XH+PeHZArMNyLaDJSP3mGx80+besh6Jhrmx6NfsMPq014p0UAUoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538462; c=relaxed/simple;
	bh=xnEgHOeNbhtMvw4wCPJpQdNvkImvJ6FtdvW34aV5Lk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFCktDFD1Bp/1tG9bcJa1/qRXiYZq8rNRMLRYkXvuRM0i2TL6Haa9wxRM9aYrp/y14b59ie7HfnAzRRsgvcwp0fCHprpuWR7RHXY/PICrFsNAb/tDy6dv9O0PLbt9+sQUAVZDeP0RBZirImvSVEvv7AnEjZ0cGj0n2L7EXXMIAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o2oAc5zH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o9j9cx07; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o2oAc5zH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o9j9cx07"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F71EEC01CC
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 19 Nov 2025 02:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538459;
	 x=1763624859; bh=T4h6D3k7f/Hy2vFep+4vESfpi9O00BTRF9T81Fp53U8=; b=
	o2oAc5zHzwqu4k7pLjSSUMjZ1kR0B1+BPRRy/I5ctJgm9QLok1CFp35MUtKAm2WM
	Hyi3bVmefD3PINZhthO7asrI1d9C1UgTHg6VIjcj7F3y0/4tmzf2g1u2YjSl1lPn
	z2WXPlXBlVa5L1D5B3PaSrFgE8j7bGod+BSjEQhmRmrSsuN9WnKae7C1swaS3qE+
	Jjf4flcZLNC50VELzAXPR5p3W8rolIEuXGEer7lNdBJGqTGfLQ3SFtrLUxcUDSKZ
	vKpYnstW5ZG1mv5x2BxUEurNAO92TI2SnC0tdjmz1vYNDbDcYCdM0UPB3PlPuIMB
	ze1Qr2HTVhkWf6DV6TAiwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538459; x=
	1763624859; bh=T4h6D3k7f/Hy2vFep+4vESfpi9O00BTRF9T81Fp53U8=; b=o
	9j9cx07IEL6FYL4EeSW1A8uej2jkZQQOaRYy3unlUyDyfh/5RuNu2m83ZcQtFUsW
	0WTpXHIO/OV1wDE3V2yurBvMGS3CeR53ixGcaOPcLcSKFVDaMC1d+X5kphG5WEGy
	ceoavj4xnrL+B0WNwzQFHv+5YVRpOO8B7w/ubAfxeLbJxM8z87POc+58Hf44qPpE
	GXMDtq6GmLWB1v5QLpK5AuDEtfAuCLf3zc87vslXCCxTBDHLnxslfsml3dURXPZZ
	f+uby1Av7o/YyNeVog35hQq3Lhr/4Doj0+q9fFXsUG27o5m+6lDuk1ts99p/4geZ
	ZEKJK+N6BToe2EVV6tbNQ==
X-ME-Sender: <xms:G3YdaUN9Yjax0Pp4iXjDzYMvL9pecSg8qrAGdij2zpcmtT8ekA2VlQ>
    <xme:G3YdaR6c3d5zVvq-kXnQBwgNS2HoTvJvcPjpdwnQO7Y1cyLSDoa3Z0LWZn9fn4xFI
    z_aRlDOR9URCWqclrJ7_Z3dTUTkK1WTPn4U5hOzNwqR87QtZ-gmvA>
X-ME-Received: <xmr:G3YdaQ7YaGrgFsOs313uvIgUA5Pqehg2ohw647lnPb86Jx6OmWykhF1ZTxAh45O9DnvgSNrvDZm5cthKNMbOdCK_QYwrTp-PDwS-pplqjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleff
    vdevleenucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:G3YdaR0THjofdWciqCP2BgBEBATQEObqpHUWCkjke5njErBqdYEdjw>
    <xmx:G3YdacUm2ynYeWJxiEtduv0ItEwMvwB6DTT8YKDCe7uEcA_uFSclRg>
    <xmx:G3Ydac5sawwe3sM_3dME2_7ID7Ckv6eIsijHNq8nC7nT1k3mdedN9A>
    <xmx:G3YdaTJxZc6r3aMfyb7x6hu1YD8aCtihU-Nb6XmB5JU4zpl0pXDpIA>
    <xmx:G3Ydac9j4eheo4_etW61xWja4YtauncV3wespXfboGYyT7CkXI914eUf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3eea8341 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:47:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:04 +0100
Subject: [PATCH 04/18] streaming: explicitly pass packfile info when
 streaming a packed object
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-4-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When streaming a packed object we first populate the stream with
information about the pack that contains the object before calling
`open_istream_pack_non_delta()`. This is done because we have already
looked up both the pack and the object's offset, so it would be a waste
of time to look up this information again.

But the way this is done makes for a somewhat awkward calling interface,
as the caller now needs to be aware of how exactly the function itself
behaves.

Refactor the code so that we instead explicitly pass the packfile info
into `open_istream_pack_non_delta()`. This makes the calling convention
explicit, but more importantly this allows us to refactor the function
so that it becomes its responsibility to allocate the stream itself in a
subsequent patch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/streaming.c b/streaming.c
index 9596a94c58..d7db446d25 100644
--- a/streaming.c
+++ b/streaming.c
@@ -340,16 +340,18 @@ static int close_istream_pack_non_delta(struct odb_read_stream *st)
 
 static int open_istream_pack_non_delta(struct odb_read_stream *st,
 				       struct repository *r UNUSED,
-				       const struct object_id *oid UNUSED)
+				       const struct object_id *oid UNUSED,
+				       struct packed_git *pack,
+				       off_t offset)
 {
 	struct pack_window *window;
 	enum object_type in_pack_type;
 
 	window = NULL;
 
-	in_pack_type = unpack_object_header(st->u.in_pack.pack,
+	in_pack_type = unpack_object_header(pack,
 					    &window,
-					    &st->u.in_pack.pos,
+					    &offset,
 					    &st->size);
 	unuse_pack(&window);
 	switch (in_pack_type) {
@@ -365,6 +367,8 @@ static int open_istream_pack_non_delta(struct odb_read_stream *st,
 	st->z_state = z_unused;
 	st->close = close_istream_pack_non_delta;
 	st->read = read_istream_pack_non_delta;
+	st->u.in_pack.pack = pack;
+	st->u.in_pack.pos = offset;
 
 	return 0;
 }
@@ -436,14 +440,10 @@ static int istream_source(struct odb_read_stream *st,
 		return 0;
 	case OI_PACKED:
 		if (oi.u.packed.is_delta ||
-		    repo_settings_get_big_file_threshold(the_repository) >= size)
+		    repo_settings_get_big_file_threshold(the_repository) >= size ||
+		    open_istream_pack_non_delta(st, r, oid, oi.u.packed.pack,
+						oi.u.packed.offset) < 0)
 			break;
-
-		st->u.in_pack.pack = oi.u.packed.pack;
-		st->u.in_pack.pos = oi.u.packed.offset;
-		if (open_istream_pack_non_delta(st, r, oid) < 0)
-			break;
-
 		return 0;
 	default:
 		break;

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

