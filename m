Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D103546FB
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820743; cv=none; b=YFd4mEwdiqb3phJAbKKduv7cvtymx16tI190Sczr+fVy4GRLx9VSy9Z6XdHCSzZ5bx/2kBvH3EHq08fB17Ebusdlyne82F8Tdcggd+lS31qAHeR1eYzkqhfhVOCfiWAZr9FRrI9jRCaFcwN5z2rAz4Y+CRwOGilIildZ1M1Lwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820743; c=relaxed/simple;
	bh=WskWrEEQRb5ysSnhS7AiW+mp0AcA2OxCZvKGuIWx0zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M30vjc/uSmHHBfKYsidQU44nfPvXQmK5C3MvKmEX3H3zmqZf0/V7yR6y3WTaxATAWLM6rvWjT7opMy0sL3UZVVKhat7ftibb8IRLOA5vnjSOht9HQmbqdJqu4x9WGRKjYkmx0KwXEuXgt2mRMNaRgZAUjnweOWDctslO0DAAYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mZWyO/bi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qxlekSMy; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mZWyO/bi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qxlekSMy"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0ACFFEC01BD;
	Thu, 30 Oct 2025 06:39:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 06:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761820741;
	 x=1761907141; bh=2vX+R2YVw7XumahH65Mw2hd1bAg1wsFK8SDH+/FNnzU=; b=
	mZWyO/bi9WBUdFQs/3ANVzC6ZSJHECCynG6pyioW9v6/jeybcwq62mFt2EUq86Fs
	i3h9xEtXXuh1yq+ZUAG+vue/KvaRUzrpXvtJMLsXUC5GERW/DpFiScOQULAF430S
	MghYQeHlQVsvMFlW0KkRikwFMIkR/4ypTBhZlw/X0gWRdrbActm1pgXRiuoZA15u
	qL9RLy9YRlQ7wNVA1W8e7JulqDZTUmMsAx+OgthSxt4fXwDYWTCEXIdnCz9+9fc9
	kkuIravSJMBk3mgV2rSptxYLvD1N+Tyu7OQDiDhJgXhPpVn+VPYYfDeGuAc6H5AN
	TQWNkx1QbY6lYlRcxJFHKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761820741; x=
	1761907141; bh=2vX+R2YVw7XumahH65Mw2hd1bAg1wsFK8SDH+/FNnzU=; b=q
	xlekSMyJx1oMBv6N0alR1wii402Fcl9B2nyEK+mvV0ZmRlGmLJMuH9rQy9a/fC3e
	yiVeqt3eXwvzE+cTWpxZxsRaCDx9d+2+ltCu2S/D7AbjBh6QSegLF+wj7qpQGaNl
	WyEOFzJMEvdnD+mho0gGYOndBloSEMge7W7wxCmqijKeIYLiEUICv/VjoInnYjlC
	A5gKcv+Dame8R05m+W8WQvoMXmkVyC80937YeQfGNY7/YEHPttsLVuH7rc6UPM3N
	A/Sk8bl0DVEAXmaABZVFn+kyCVB3ni8jeKD78y9NkR4SDiX682kBK48nrdHH+pI/
	NG1IMSYDrjUa7/PTV/HPQ==
X-ME-Sender: <xms:READaTFPQ4wkDCUn36SEUlawS_7HAgGCcUnVAN_RRVxjXtPsfZ6wRg>
    <xme:READaXV-KRQQY6lO-x9K2S5h3qXWg26ohUSmLFpyIWMfIxxI7KCMwABNLXi6znTBf
    ZJVAZnGEshp-FdZGVCRhCcvTWliHBQJxv3ZT3dh-i8Rwp4rVJ0M>
X-ME-Received: <xmr:READaaIDDlW7Rey8yWI_aRMSwiW-ZQH1ZgI8Fld2Dq2KiYTd6YYo_xb7ExvbAG7vYHQhXfvP2zENYq4Ed3MI8M_WkWBO6jmMC5QyBtiEpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:READaf8ls3ydybqYgxqPxyTrtms0znvk9oRPeI4T_-SxYj2Vx28N3w>
    <xmx:READaVJ9v-JGAC385oG3flKVAWMKM0eW1STi8UEs7EpBCpPlet0lyg>
    <xmx:READaclVTogH1004NZMWO5ZcOrJOMboEbqYucMImwyQBHs6FKiQ7qw>
    <xmx:READaRMwpFVhG_vjF9gK_Wwf36cGoXah6h84z5-C1kZioOuBWrM93A>
    <xmx:RUADaVpIG_9oP_oGpP0Zk0pofACQSnN2klf39kGHUHFyNM_WIc-VuImf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 06:38:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 545cc8cb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 10:38:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Oct 2025 11:38:42 +0100
Subject: [PATCH v2 5/8] builtin/pack-objects: simplify logic to find kept
 or nonlocal objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-pks-packfiles-store-drop-list-v2-5-84654f080cc0@pks.im>
References: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
In-Reply-To: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

The function `has_sha1_pack_kept_or_nonlocal()` takes an object ID and
then searches through packed objects to figure out whether the object
exists in a kept or non-local pack. As a performance optimization we
remember the packfile that contains a given object ID so that the next
call to the function first checks that same packfile again.

The way this is written is rather hard to follow though, as the caching
mechanism is intertwined with the loop that iterates through the packs.
Consequently, we need to do some gymnastics to re-start the iteration if
the cached pack does not contain the objects.

Refactor this so that we check the cached packfile at the beginning. We
don't have to re-verify whether the packfile meets the properties as we
have already verified those when storing the pack in `last_found` in the
first place. So all we need to do is to use `find_pack_entry_one()` to
check whether the pack contains the object ID, and to skip the cached
pack in the loop so that we don't search it twice.

Furthermore, stop using the `(void *)1` sentinel value and instead use a
simple `NULL` pointer to indicate that we don't have a last-found pack
yet.

This refactoring significantly simplifies the logic and makes it much
easier to follow.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5348aebbe9f..b83eb8ead14 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4388,27 +4388,27 @@ static void add_unreachable_loose_objects(struct rev_info *revs)
 
 static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
-	static struct packed_git *last_found = (void *)1;
+	static struct packed_git *last_found = NULL;
 	struct packed_git *p;
 
-	p = (last_found != (void *)1) ? last_found :
-					packfile_store_get_packs(packs);
+	if (last_found && find_pack_entry_one(oid, last_found))
+		return 1;
 
-	while (p) {
-		if ((!p->pack_local || p->pack_keep ||
-				p->pack_keep_in_core) &&
-			find_pack_entry_one(oid, p)) {
+	repo_for_each_pack(the_repository, p) {
+		/*
+		 * We have already checked `last_found`, so there is no need to
+		 * re-check here.
+		 */
+		if (p == last_found)
+			continue;
+
+		if ((!p->pack_local || p->pack_keep || p->pack_keep_in_core) &&
+		    find_pack_entry_one(oid, p)) {
 			last_found = p;
 			return 1;
 		}
-		if (p == last_found)
-			p = packfile_store_get_packs(packs);
-		else
-			p = p->next;
-		if (p == last_found)
-			p = p->next;
 	}
+
 	return 0;
 }
 

-- 
2.51.2.997.g839fc31de9.dirty

