Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7813385B6
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710880; cv=none; b=BSkrbAYPk3AFXzjqxH5pYjY1Lrohsd1/aEOoyJb98IhUcvZsTD5BFlT0aYTm+mrk0FnOLJ3U4nOKfyH1nADFANJU5uMcQNZEQP6gA6gbYflfY7Ftbh9AZxhjAxIwMFesAxJWJhmWwhulbxYgKFxR0NoCg9SyIU+1x/5FeTV1BJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710880; c=relaxed/simple;
	bh=xnEgHOeNbhtMvw4wCPJpQdNvkImvJ6FtdvW34aV5Lk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kBK/SY4qI6mmma1miCmc5lGQqwlRQLAKLvtcYa7lO152cFbfsGUfSP1XZiOopXh5hYq8c4DF07+1VU7WFYqvmyk/Fl5tr3fCwzHQbzENfOviwakd3790pD/zqu/D8e5uaZD9kbtd9fpwGoUeF2WbRWspegTlqol0c/51t/9InfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QafW2cp/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hMJk0VwR; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QafW2cp/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hMJk0VwR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E3B87A003C;
	Fri, 21 Nov 2025 02:41:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 21 Nov 2025 02:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710876;
	 x=1763797276; bh=T4h6D3k7f/Hy2vFep+4vESfpi9O00BTRF9T81Fp53U8=; b=
	QafW2cp/zQl3jhdp+CfJlAjxeJ3C2pug8qNqWWeb39DsG3huPub9INqy4UOz8P0w
	MDHJ+4hSqjJWQISArv+U2MId5Go+jpLfdH1oGDG8FIKRpBG/sDA72xmW8RtxITLu
	qBwIWJOfyGgR4HGMyNs0dgazxlw/nog9YvEcfy/HWOOovzRJSKHWlqzLYlD5DFgo
	9+SreH4etL+BSwa/WtKHdw7eLgy6oxSb6NKjaZlN3YHvNBy0B5giGdoC+pQFvtee
	bi/bZEWqPOcX9biK05ZDZ5f6ivf+fMEuGaKR1lNWqPbHCjvktDA2yca21ZGspXgx
	vyYRlNE0QHsLhp6Wsaq8hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710876; x=
	1763797276; bh=T4h6D3k7f/Hy2vFep+4vESfpi9O00BTRF9T81Fp53U8=; b=h
	MJk0VwRQxeGnSxY0t2vMI4hmSKW02oa7HcC+yPHxTsKsHUi9xHAp7Yy73P280jDK
	LXxE7lZHPBi4tmAS79DzsCX3ag/h1qSYm5Z8vT1iD2OEb7gf26JYQJz28BBNvO//
	1B4MhjMdMWa0oJARzOishQ5GhAp9tBHgIsLkq+ZatTPJ30VrAg84JrxtVeYxiDT2
	1JDwsl4hWx+ASKZKvkREOaYDL9Sq+t0iVuB88kC+ikmq9Ia+dBmsZurxiGCfSyeU
	+yM6xG9tqWMdJVWwhWRRIf2bfx58OdEKTBXg6d0a0WC3f3AWsezVSUihDBUpruUp
	ykn7owMXjCRtT9wbUGsww==
X-ME-Sender: <xms:mxcgaSThhJpihEQ4FBZDJpQz81qDBX_KAQd5doNJyYuCgDVuBJzsJQ>
    <xme:mxcgafMr3KMFD9DoCsttWkUxG6yyktL_Uz40B7oHKq1dvNZM9DNbHhCvptOAzpBRT
    tdm1tRcho8acu_RtocVuEMu86Qi07rtzElSJJ6a-LzPbdWTzjjD>
X-ME-Received: <xmr:mxcgadMQvQZ0bceIdPlMmyld_lw6vzm5_3Iv0-_AYDpVSZg3cWcta1-xeYlTuCgrm_TsxD7nXwwQVmhoPi5a7_ZbBsN7r6OwRCFKnYxwoE9y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mxcgaXs_7CCuua0Mqsa3neFCbQGP6bH0io96CdZe7ziqabxQH_T1WQ>
    <xmx:mxcgafUEZd-lfdowq6VzatabJvoB9cVSKNF5Pf_L7CDFed2JMy8baA>
    <xmx:mxcgaXu75PJY4t9dmBZ5LCoinismCZueQPy67MMZSo8PlgDCXiZIsA>
    <xmx:mxcgaTVfC9ll5s-oezwpNCN5DHhgGN_wbUkF1qnPxgKMJJ19MLKYRQ>
    <xmx:nBcgaWpL4pAu5Qo22KWZmz9hYOh2l6YjRq2zpVsw0wJ0g1wtfxleEJ8A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4b111d03 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:40:49 +0100
Subject: [PATCH v2 04/19] streaming: explicitly pass packfile info when
 streaming a packed object
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-4-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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

