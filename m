Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3CC1E9B14
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389853; cv=none; b=Fq+kdJp0hjxDoHv8ndXVTUgrxzGsAYaRjz4IhPabGD0SqIzyqI3sBViT9xA/KsAfHfauAJg7+yh3DP9I0jWV/qy5Zz4cGVXH3Pa4TuwhHuBJCwmlIVxkzYRGnI7HaUzbJXaAysr5R/rDtuKzS3qyeFJmZqI0+6MUF1k7PQ1fWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389853; c=relaxed/simple;
	bh=yu3OJLwsFWZRZdFNmbWSBDgGoNf7atK+Yz954hbU/LM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQbFMy3VVh+Xg+7CV9TwNfaAFWTXS1gw6yZUN42NewPskTxPoFtJslKbKEfITqew518qXSBVFuV7VIDyWLjZJzgK5oNNZlUAGiIpM/Bfwp5U24TnDrj7lDGC9usqB6iqXVio9PrrSWsGhE33qaqdXIcY+3RYZMpPnNeunc2fRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RXKRcuxP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GslScuK2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RXKRcuxP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GslScuK2"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5995413808D3;
	Mon, 20 Jan 2025 11:17:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 20 Jan 2025 11:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737389851;
	 x=1737476251; bh=WaoR+k+6DjARBBtjMn9106/s4+VHDkUvuAKjlisjXJY=; b=
	RXKRcuxPo5M5wKSU0LSkD57O24FvHwaV78zQaQa4N60HWwyPCjXHCyAqtcmwxYyK
	Uxdcqc/AAeDb9TmCzAJKbsXjNQbEOsfsCE6aGQA9pMPKYjNAdgO0whvIwEGLSUU4
	LX25RvTWJZx2ki5u6a+uiSbbXVIVLvAdjdBhSgMndEG3L3+jfaL90li0vOuHvv0I
	+Ig9TVBWkGdr8Jy2/nJoE2i7vKCdtm6dMkyJt/k6BHedZ1a29Y6gtcw/ZL/rYCIb
	Svje8Udd26A+/EUAkqq5lWBBQiQDDWYn54KQsWKt6neXU+IHJFqO5QEBgSvj4nb2
	q0JEoHVNzuU7hoQByRIK0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737389851; x=
	1737476251; bh=WaoR+k+6DjARBBtjMn9106/s4+VHDkUvuAKjlisjXJY=; b=G
	slScuK2Egobd89gvBFgqpv7S0bmQ8tBqM4AG6t83+fbO0DG4ixZJZOJPNIH7weHW
	kyN+hCjgrktoetju19T8ylRTUEnIYKqzRzOwoTqmdx5FbomyOaFXdx4Zuzr+haXa
	IvlQ23Qycm2NEzqG5jbmahKokJHfy8fOEwGzH2XhzvP1xGKBwCzflyMio6ZzVl30
	zkl3slhuehSp7aFWcTGx35/5DJkEkQ2huq0dAjdQOcFTnPHBHBQeQjvRpqSCFevO
	Oj3aKSJPAi09OBloc+R6DIsF5e97xRK4SOdskAHO5u1XOgL5ETYu7bNGanluHuEs
	iwKxpjd5NktDxCBV38Pog==
X-ME-Sender: <xms:G3eOZ-hP5RAmzB6YICmnDlMX2NfEYTEjcey6nTy0-3q5zmEFFQxBiQ>
    <xme:G3eOZ_CRQ1kPmPt708VDQkc9RXA7SBWUDqH7cYT8d7oBszG2AwFebdeTT3b_MiJN-
    TpTjfV7xspFLvDQag>
X-ME-Received: <xmr:G3eOZ2Ebg1ce9GGA5EDTAqltrT0m3EhH-AHDrXrCb5EUr7yU5tp0xzU1j0bB0iqp350eLaw36LgbNy6U1rNiLIhn0vjj6L4Z8R1CjY9Ye8RPpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:G3eOZ3Q6u61RyRWuquqiA4pDlaMSq3vbb5jdkoXmkCvbEkBT5O-uSQ>
    <xmx:G3eOZ7zfb-YCqmjTp3OEbuhIe0HlA511zesllcUezkHrv5zIcT_RPQ>
    <xmx:G3eOZ17H22p903nLDfsObKHcD0rJdLpsD36PoL3HSvpRF623l8-xsQ>
    <xmx:G3eOZ4zo97URfqOLEnGL8HexozW6k2CJg4e21lyMA_WN5bQWVQZKqg>
    <xmx:G3eOZ2-oWAf1by6mfW3ipROvSJUWbQm6LYCyeeSBv9TJRMmLBPuavrzs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 11:17:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1743aadd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 16:17:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 17:17:25 +0100
Subject: [PATCH v2 07/10] reftable/block: adjust type of the restart length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-b4-pks-reftable-sign-compare-v2-7-b4566d02e4a5@pks.im>
References: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
In-Reply-To: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The restart length is tracked as a positive integer even though it
cannot ever be negative. Furthermore, it is effectively capped via the
MAX_RESTARTS variable.

Adjust the type of the variable to be `uint32_t`. While this type is
excessive given that MAX_RESTARTS fits into an `uint16_t`, other places
already use 32 bit integers for restarts, so this type is being more
consistent.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c           | 12 +++++-------
 reftable/reftable-writer.h |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 1275085257..8ac865ce78 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -40,16 +40,15 @@ size_t footer_size(int version)
 static int block_writer_register_restart(struct block_writer *w, int n,
 					 int is_restart, struct reftable_buf *key)
 {
-	int rlen, err;
+	uint32_t rlen;
+	int err;
 
 	rlen = w->restart_len;
-	if (rlen >= MAX_RESTARTS) {
+	if (rlen >= MAX_RESTARTS)
 		is_restart = 0;
-	}
 
-	if (is_restart) {
+	if (is_restart)
 		rlen++;
-	}
 	if (2 + 3 * rlen + n > w->block_size - w->next)
 		return -1;
 	if (is_restart) {
@@ -148,8 +147,7 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 
 int block_writer_finish(struct block_writer *w)
 {
-	int i;
-	for (i = 0; i < w->restart_len; i++) {
+	for (uint32_t i = 0; i < w->restart_len; i++) {
 		put_be24(w->block + w->next, w->restarts[i]);
 		w->next += 3;
 	}
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 5f9afa620b..bfef3b1721 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -84,7 +84,7 @@ struct reftable_block_stats {
 	/* total number of entries written */
 	int entries;
 	/* total number of key restarts */
-	int restarts;
+	uint32_t restarts;
 	/* total number of blocks */
 	int blocks;
 	/* total number of index blocks */

-- 
2.48.0.257.gd3603152ad.dirty

