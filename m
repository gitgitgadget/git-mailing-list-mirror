Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612E2E7BDA
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553879; cv=none; b=q7M5vsB8mTv6eiotiCDX+ukVY2rfSGOcSOSoCHL+a1hwQN8XWN6eoRGaF85ud7m5W/cdHt+15xD23P0eONxy/IH5LJLviVpvbd0LyEOCtW6h3tHklUFuH28pVos+628rK57Ofu+ubTGry9SVUGIBtrPe7aUiy69Syd3hD+SNVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553879; c=relaxed/simple;
	bh=BUQEldietD2qF2OHXLoLT0H2+lK0dKIZn2ftRoxFwdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZ3BrToJTG+3wyP8oc0jlsUQVoNQ69rn9EWJ2f2Ctbp21yNNb2CiXCb9/qb5Utj+Wnqaa0Ah/qfAF1e3nIb/onbV1UXGV94o41D0iCPjdwVanFOJhNuZq81Ws9kHTiF2ZDagwL4aIKDVkuUSdJ+udZJq8id6WAvpUm8Rp/vyIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UfddIGZJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ou6/cr+6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UfddIGZJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ou6/cr+6"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30BA914000BB;
	Mon, 27 Oct 2025 04:31:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 27 Oct 2025 04:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761553876;
	 x=1761640276; bh=YNoqqQCjPopIFWZCw3RxFWk2BDgsKYH8IGxV+sfm298=; b=
	UfddIGZJAW9wgUrn65UbWixyvuP1fdEwTQVpFGUXNIvcn1EqOCeBGQWvKp8r8jPc
	zqzl8n2AoaZDfcSNK99FVlcu0WuI+HRcEY9wDnXA1YldfVZG7abZo2QrUon1PK8F
	Zxag+jh02FP/WRZHyBBYBFtVKmLgeNGJD3Flok4+9JULvBWBSIlOq5qmYysp2Io6
	UwgLQp//mubdTLp3hvWG3HxOWhUqWV4pHPbOxDiAQUtfISs+6vtXuYxEkPqErkEh
	4XQ0PA/DfO27oc2CSyJDprJkHZKp1RDveUrR2/mN9yYWI2EoTtq4BJRX3fn/kTFk
	sqRlB1brj7yAD4GdAwjK1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761553876; x=
	1761640276; bh=YNoqqQCjPopIFWZCw3RxFWk2BDgsKYH8IGxV+sfm298=; b=O
	u6/cr+6vQCAPRuo+qCy+ceuKUANpKOP/saePFMccExTaC/BerEaXpJHHeIaGvsRx
	FA2wR5nqUyrrfPkIIdBb0a4pVWrpn+bFa+2MveS/+tXuv3yyF2q296Gpf5jDCUNc
	pp8LlIqDFDEFXBCNWwFUAgDf+WaD0qZoIbAsa1eM6pclVGz/bOMK7/YBOFmh9nPc
	Ida9s9vG547gecuxEqqVKLnx4nlOjqoSfs3iyPwm9B/HA6wM4juHE7N8jEX9RLb5
	3Z4SRoIdbDNngzd7VWYt6pddIWszBIlcKvGqoEQ7Zce7cXUlzwJGndebjd38W4WK
	EGRROXXjcdcm6ZaybiYMw==
X-ME-Sender: <xms:0y3_aFF83fRpgQ3uE6sERIbnjj2mW7N3Q3YO4rMOxg3Cd9WnscR3wg>
    <xme:0y3_aF1HvbsWwfUa-eJS_UgNc8fdmog1l6ihCicDipJSsAfdqbf8iixhaXXkay_CD
    qVa238YA6QhuW4pdePNXpI5kG6_zw3hvh1i4BVZYSA_5Dc4-MVJnv4>
X-ME-Received: <xmr:0y3_aNkaEvPok45OJ5SHEOQLjnSMtklApTJfiQfUnTNS1GXsum7KvOOD7c7G03VTTgOtVSgCz6_EmQ7jxvZqBPex4CiIxVjRXW9Nrt3Ung>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0y3_aF8h9uU_DF1aSoMJSejZqk1LovCs3OXn2pTYs8xehQrEe6rkwg>
    <xmx:0y3_aCrpVzWWe7wEWiaDkz0l2Dz8SLWVbJgVo51vwBUhEXJyr-Bbmg>
    <xmx:0y3_aOlK22bVHm2TeCh52tpxz_pck7JsHe_oxNY1YCeTHPYhU1sq3A>
    <xmx:0y3_aJh86eSC0Ui1R2PSzbR0tlg-HgJ-r1MW8dEzbKe0a7-YOpC4vA>
    <xmx:1C3_aL7Cli1mfzKrs41n19WEjrcghQAtT44KFFKGtf7K6FMabeRr3odV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 04:31:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e00eb88c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 08:31:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 09:30:56 +0100
Subject: [PATCH v4 06/10] builtin/maintenance: improve readability of
 strategies
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-pks-maintenance-geometric-strategy-v4-6-18049e4a0adf@pks.im>
References: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
In-Reply-To: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Our maintenance strategies are essentially a large array of structures,
where each of the tasks can be enabled and scheduled individually. With
the current layout though all the configuration sits on the same nesting
layer, which makes it a bit hard to discern which initialized fields
belong to what task.

Improve readability of the individual tasks by using nested designated
initializers instead.

Suggested-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 726d944d3bd..0ba6e59de14 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1835,23 +1835,37 @@ struct maintenance_strategy {
 };
 
 static const struct maintenance_strategy none_strategy = { 0 };
+
 static const struct maintenance_strategy default_strategy = {
 	.tasks = {
-		[TASK_GC].enabled = 1,
+		[TASK_GC] = {
+			.enabled = 1,
+		},
 	},
 };
+
 static const struct maintenance_strategy incremental_strategy = {
 	.tasks = {
-		[TASK_COMMIT_GRAPH].enabled = 1,
-		[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY,
-		[TASK_PREFETCH].enabled = 1,
-		[TASK_PREFETCH].schedule = SCHEDULE_HOURLY,
-		[TASK_INCREMENTAL_REPACK].enabled = 1,
-		[TASK_INCREMENTAL_REPACK].schedule = SCHEDULE_DAILY,
-		[TASK_LOOSE_OBJECTS].enabled = 1,
-		[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY,
-		[TASK_PACK_REFS].enabled = 1,
-		[TASK_PACK_REFS].schedule = SCHEDULE_WEEKLY,
+		[TASK_COMMIT_GRAPH] = {
+			.enabled = 1,
+			.schedule = SCHEDULE_HOURLY,
+		},
+		[TASK_PREFETCH] = {
+			.enabled = 1,
+			.schedule = SCHEDULE_HOURLY,
+		},
+		[TASK_INCREMENTAL_REPACK] = {
+			.enabled = 1,
+			.schedule = SCHEDULE_DAILY,
+		},
+		[TASK_LOOSE_OBJECTS] = {
+			.enabled = 1,
+			.schedule = SCHEDULE_DAILY,
+		},
+		[TASK_PACK_REFS] = {
+			.enabled = 1,
+			.schedule = SCHEDULE_WEEKLY,
+		},
 	},
 };
 

-- 
2.51.1.930.gacf6e81ea2.dirty

