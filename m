Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA001DF271
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052907; cv=none; b=M4Jh41xKHP8sdpmewz/tXxYjA46waGnunRieIZn6i6HU0WnnV6mqiUQVuve/7t6mY0U3/xX8cECjiNpkaY9H6V7Tcinu6thIVQM9Mb7PkXF6iNKKGbGIZNDar7AUHru6vuPtHTrzQo9MfbjEnV2S1Dax9HiOdBf4eolVFplrth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052907; c=relaxed/simple;
	bh=yNiOIXNMH8qUXRFfatF/Hrv0zHHaZv1NHqVuolomlxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pk3i9LyAuePnn7/St+OeaM5+Nn0SfcyAS7Qw+oZ9X/QWRatF2DZloAJMnLCJ+xI4sTgICZfP4TOhoweLcW0F9gWGBFIpFaXcYH2TzvZr2D71yjdVSOq06sn67kLAWhjcHXkja3sZTlWaATSYosYuuqxRJ92noynZO3NFB/2mCuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SjiFl1LH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZaNm3J74; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SjiFl1LH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZaNm3J74"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 19A1F11401CC;
	Tue, 28 Jan 2025 03:28:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 28 Jan 2025 03:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052904;
	 x=1738139304; bh=WuG4AcUl6HDdJnnwSbtTHemegXqNW+IiTeBaIn9TSHA=; b=
	SjiFl1LHawuLu1VYabGcim1TtWFQQ376RPep9TIn3bDWn9b8cwetpYoGpIemWzo3
	EkPo8ai1gaNCZ5EmdtAG9z32qNkNExkszHEwsaJnlQvNe+Bvwl1PB3aWWQQPfOmo
	IYC4WEYQoWeDXVQBKE8HJKTD2FjOhDaCrVu+pHzB6A9ixleTxIefFbtHK40hRx1L
	lTlc2rYkFUPB26+IV5LpS1JrPamJWD+8dA40ukmZs53jAJ4+uTnTvVqDRLP/PRJy
	a4pwHhbgJzO36G1ramqkXsU7D8Z4CxOr97UHmONFCHQDtpalkRjtoqZtof3u7Vka
	rxcXpZG5fGvKHmXhRNK7ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052904; x=
	1738139304; bh=WuG4AcUl6HDdJnnwSbtTHemegXqNW+IiTeBaIn9TSHA=; b=Z
	aNm3J74rCgs/ERzD/PeqMIt+u/MTTzSx7PDRTQhKC3iKVPiWBVTW2ct8PNoJjDXG
	pE/rIWMyyf8+XSjMndIs7roqDwxQQ0rtNgJNdIB8b+TY0QmDQHa03P0yAgkd44bF
	4N/A2WnqOy4IcDYEEqfWi0PR88cdBAg9zImvJgsbj1UFVYlVw3fdWyRa2tBoS4uw
	ugmQFTlBWVlrfMJ65oKkzSmb6DwkuipX1Br7WM/NTTWBzVJs8qpDXdQtQ4yrPoJd
	cdCA1x9VhlfnEkItWB7VTrPosY6hch402Qwxfx9xmBubG5fnsjCRKi3+BgfM+0rq
	7fqJ2JaFxLEStxvceJgHA==
X-ME-Sender: <xms:KJWYZ8nMrL9dcq3w6dkhLa5KAd35rBFBulPsj1IROxV92zFP6VP9OQ>
    <xme:KJWYZ73j0Tv17zCGTZaFeRaF0jSy1r5TCK-YodV9XkiWGkEM_ssbxqLaaGOVaby00
    Bzxo-vKn5rptWChGw>
X-ME-Received: <xmr:KJWYZ6odltoZoCogrAAxMFlHKIixP-brKmQHoYwStIaNYFuYtVsimEThosniOSTApmcFpnP4txfFMtyMcwGBQVgQMj5FwIOG2NdyDzjzgzc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KJWYZ4nJLPomV55XNys3FWKIwyZ2YL3R09Oa5XuaC1a7IHxwvtf5RA>
    <xmx:KJWYZ62pspZSXE4tR7tPD38qegAgWbbbt6CBCTDKTpsA7CxxPQ4jfg>
    <xmx:KJWYZ_tI5qB-IVgItTcBxM_vgAA-rTIfVJ-gjfXc0Hm_i7A8bg1OXg>
    <xmx:KJWYZ2UmoMtWHd4NakcPDvkzFHj4MMkz3SQ-Bgba-3M5RPlT67MKGg>
    <xmx:KJWYZ9Q8CFSz4YxcVsTx8waCDeiW6ahEpqE8L77GPiL7nTGlvyb8Fa_4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aa8381d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:11 +0100
Subject: [PATCH v2 10/20] reftable/reader: stop using `ARRAY_SIZE()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-10-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We have a single user of the `ARRAY_SIZE()` macro in the reftable
reader. Drop its use to reduce our dependence on the Git codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index bf07a0a586..c3a3674665 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -849,7 +849,7 @@ int reftable_reader_print_blocks(const char *tablename)
 	printf("header:\n");
 	printf("  block_size: %d\n", r->block_size);
 
-	for (i = 0; i < ARRAY_SIZE(sections); i++) {
+	for (i = 0; i < sizeof(sections) / sizeof(*sections); i++) {
 		err = table_iter_seek_start(&ti, sections[i].type, 0);
 		if (err < 0)
 			goto done;

-- 
2.48.1.362.g079036d154.dirty

