Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5850171658
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734852296; cv=none; b=oO2o0foK+ocPxcnlqzkasba2T6S6YJIvhlopKGvFBzwQkw4qCF60hvvGEl7g1jDCkIrQg8qMYy8hz6c43XiflfBCpiC03CqwdU5YzZMvQ5Zkm4HvtsVrDWch4l7ozxDfS8s29cyJbURoLJgXjRLtZFNmEMFLH90CIIqBzzMV6eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734852296; c=relaxed/simple;
	bh=jUN4j4x4e8Vy3aqnelpWQvOGVcV/vJpZOw9tIZzNMY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gjd9FTFKyrl+CvfW97yGX6k2dZCCmaJ8AYXwbw/vnDPqaePizujt54BqwfzrwthU7g2GDD+Vl6yVA/ylU4nDa+zyhAIF8MWcCvMe5SkQ7EY/Wrr/ra1zq4b9Tu5NpmHw62Ou0T8nyYth/086d7uhHVFiry0vdDw4crIqA1nMoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iiYguMqH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZSgiPWu; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iiYguMqH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZSgiPWu"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89F1D2540189;
	Sun, 22 Dec 2024 02:24:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 22 Dec 2024 02:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734852293;
	 x=1734938693; bh=DxeckagWI7MDIzubYk7GkEXi4fHJZ692S6m5GYLFQfs=; b=
	iiYguMqHlwg/yma2D4swoH4FgEs7vHPeBA/KRlzYW+wKIltEKSgNQ32aDpiFGd+1
	jIkVlzjGbOVGDiby2C08EboCsEjCnL7827XGZgZLkkiXluD4Jw4aTCnP0go0RUdm
	GZxk4IUDne88o7pzyHMetYystIUnQlzA7/iWbJUEpKvV2wON0VJFm0sOQRuvUrLr
	GjssQeUyHk6tiNcA0TrCBWpq6ZBXuXP7f+y3VDO1AAZmisWG20hfXBpU3vyfkJ8v
	q9sWdHQKwzJOt0urIJZPBBW6vSGwmWA5oo5lClsajb/PCSaMhkVKIUaHn+U+qVY7
	aTb4RyS6vnUgi4GOSI2rrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734852293; x=
	1734938693; bh=DxeckagWI7MDIzubYk7GkEXi4fHJZ692S6m5GYLFQfs=; b=B
	ZSgiPWu7GXgJo3e4IEGabnsnrhGnoopDybhr20NqR3Jm/jrp9aQ5IRKjI80o7+y8
	sZWmv0Ajp4O0+hCfWiqDch+z6cLG5nVqbe7UpxohgC8EYe23AeN5bRGpSkbJ/yXw
	kijjc0Svue3rxvDclD6WQ1z586sMVbIsUIeEM9bbSIrt+W9i5XEbXh3bHNtxRj8y
	9KhMIgydwRulmkOWqVNqhp3E40YHAsEd2K4t8Sc+vOqB3w/JhLOO1hbTtQIUHN6P
	430FuNKM/BzeeJi+TdTE9ArmZaLhUEjbGvo5GZxIuUhMA5u1cELKKGeR/8ttymzF
	PfRbOygtbybrQ0/J0jDVw==
X-ME-Sender: <xms:xb5nZzsWenT04P1MmHbi70rvTM4dtAXKlERJU7l42oDIkKodu2eX3g>
    <xme:xb5nZ0eVTjjVzQKRjeDcqTM4LjIawCtuu9V0nOqlmBfkmVi3KHqLfAzNeGtyw0pDz
    f8_tq4nTi2R0P_nsw>
X-ME-Received: <xmr:xb5nZ2yxZ7qWxjNVY-H04DJcxm7s93C2xspIzndBQIVkfHA6-mTFk2hn_72pQod0z8s-pOp_2D784N9vehs1pr_7DbNY_iHSmAevNIEa6lqqJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtjedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehrrghnuggrlhhlrdgsvggtkhgvrhes
    nhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xb5nZyP_AAQfA-CZidCNHoHeH7iq7IGWMUsA33HpIm0xwEOdtGdOng>
    <xmx:xb5nZz_YLWTJTRb8s7fXlyNiH46tPTRvquLJHT1p06KTg3em8zJx9A>
    <xmx:xb5nZyVJyFRmKLiwrbHm1QsrqHfhmpGwTRgwRnAq8bCc64JvSm7X3w>
    <xmx:xb5nZ0f0twG1XFcUHVFsEtD65FV3fRNBB4SpT2dFscs_1irEdjEMOg>
    <xmx:xb5nZ_YkozUpyfgGun_ag5GTJggVsJO5oqFeWktph-WfGf5vqGNiSyUD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 02:24:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 553e6da4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 22 Dec 2024 07:22:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 22 Dec 2024 08:24:30 +0100
Subject: [PATCH v2 3/4] reftable/stack: fix zero-sized allocation when
 there are no readers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-3-19550090d15a@pks.im>
References: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-0-19550090d15a@pks.im>
In-Reply-To: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-0-19550090d15a@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

Similar as the preceding commit, we may try to do a zero-sized
allocation when reloading a reftable stack that ain't got any tables.
It is implementation-defined whether malloc(3p) returns a NULL pointer
in that case or a zero-sized object. In case it does return a NULL
pointer though it causes us to think we have run into an out-of-memory
situation, and thus we return an error.

Fix this by only allocating arrays when they have at least one entry.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 6ca21965d8e1135d986043113d465abd14cd532c..634f0c54251b3581ca73250aca9f653f4645a569 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -270,9 +270,9 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 				      int reuse_open)
 {
 	size_t cur_len = !st->merged ? 0 : st->merged->readers_len;
-	struct reftable_reader **cur;
+	struct reftable_reader **cur = NULL;
 	struct reftable_reader **reused = NULL;
-	struct reftable_reader **new_readers;
+	struct reftable_reader **new_readers = NULL;
 	size_t reused_len = 0, reused_alloc = 0, names_len;
 	size_t new_readers_len = 0;
 	struct reftable_merged_table *new_merged = NULL;
@@ -280,18 +280,22 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	int err = 0;
 	size_t i;
 
-	cur = stack_copy_readers(st, cur_len);
-	if (!cur) {
-		err = REFTABLE_OUT_OF_MEMORY_ERROR;
-		goto done;
+	if (cur_len) {
+		cur = stack_copy_readers(st, cur_len);
+		if (!cur) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto done;
+		}
 	}
 
 	names_len = names_length(names);
 
-	new_readers = reftable_calloc(names_len, sizeof(*new_readers));
-	if (!new_readers) {
-		err = REFTABLE_OUT_OF_MEMORY_ERROR;
-		goto done;
+	if (names_len) {
+		new_readers = reftable_calloc(names_len, sizeof(*new_readers));
+		if (!new_readers) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto done;
+		}
 	}
 
 	while (*names) {

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

