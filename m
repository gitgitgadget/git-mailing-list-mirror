Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E002E92D6
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761984; cv=none; b=iEM3qO8ePuU/8OwG2vEhu1BP2L6+wXfViJxojbMdQzwBZewqqg5Nj9h8SZXr/d4lUuSfnpNJkNJyEtayLHLVwneysVGJi5ONIZzsz07WSmwbKJEOkrhztuayX+29XXQD2GNkHU96k8TyLHR3BaC6DApU3BHNpT4oX3IxaoRmIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761984; c=relaxed/simple;
	bh=qCVSRv9Ely7oi3gv/yhP8eFLeu2nCX63U23RnAbYqCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Da7xSJrxKJsQxQnds6B0ylqwSaBDl61zuv/F1iM8dhLxg+QfsxAaCU612kV0TpgEITXCVhkNdqLGTK0fQspTiUabf68WtohCZbor4NKQxpVg01gUaO6CqgbLQYDBmU+x4zoxx4SGx9nhkmdfF85Pk9x0dHjqiFCSmPmkqOzY01I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GJ95JmEp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GLIkMufB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GJ95JmEp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GLIkMufB"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1871F14000BB;
	Thu, 21 Aug 2025 03:39:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 21 Aug 2025 03:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761982;
	 x=1755848382; bh=QwMpg53zG24FcvQDN45Msw7nELOb2Nl3uYvHBljaWaQ=; b=
	GJ95JmEpOR+beGVrdM9LaF8w+UXAqcnTwtvxFR29Mj8igcRyfm4s1pqb9bMzRskM
	kz/98jnbIu5xjF2kD1xlU9EIJmVA4pNdOjtJrocNlGBNZTptMf0ZSg1edRupd8Kb
	PCyzcqAa+E05dg3czsSU295K3NHQ06zRxx0Gw6kWQlDij4LswwQyLUp9FG8o/G1B
	SSicAtNeErOrcyhEPIE5mUIxwhq9rYwliSl0qWuoPok6CKwOZUyTr4YGBPp3Oe2P
	t/HScSJ0m3eQ6eUNjNsUDtnW8HChKNOllklLdAHRypchLuWS/OCf3tVClrGiecul
	BSnW7cvFfMMM9uKWuitrKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761982; x=
	1755848382; bh=QwMpg53zG24FcvQDN45Msw7nELOb2Nl3uYvHBljaWaQ=; b=G
	LIkMufB+v9F1jTy4NsI83fCkDmS6/7YAW1HV+idDXIGl5PB6z5ZXcIaxwjFxzZnB
	aJ/RKXy0odshMsnktZxg3FuhRqy9L22Yf/Yqe9/9NMTmXbqhMSrFCDKn7DUm151H
	Accs2dRb3t6DAdcnIi4mx2Fpm9sRwLbPeU5lWJauh7IaIglSVIsxzS4ejVG9Ke2M
	+JcWoZfq2HsTRkY89quHU0mmN4NQbStUjf96n/bAIibWJxBQrkpRrFPZ0UL4Vvxt
	aFHqKfnQ/qXBojBLXxuwY1nssg077VOstSPEsy7odb+Zt3bVsUqe5axjWE144tjR
	0GgyC75jQpmHnAQZRjCBQ==
X-ME-Sender: <xms:Pc2maAeZCMiqVmugMLC4jjiF0wGxEKYfeDyKDFqwbG5DW25KQTvpzg>
    <xme:Pc2maFd6Fz44aeVsGLJDaVgHJjvEqJ313eIosBISrBrX23C5zWMnQp0INRe5KQsX2
    7fT9vuOZR0IPpLNfQ>
X-ME-Received: <xmr:Pc2maK_E56qHSF4HGt8JKZAmrPotgtqYlAi8GrsNOOV0UR0l8-YYqkMuE9jIOp_mpa6G_tWqyl8zRidgzaTHDRDMs61HzrefL8kcvc6hkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:Pc2maBl0GX0Vp2RcX9tv26OIGsDfKoLUJgkbIHChZIz4iO9Ts73EXA>
    <xmx:Pc2maM9lwuEJqXnRfvGgJ3YnkVPu7mpf6CE8cg6qW9ONNqvxy5n7Yg>
    <xmx:Pc2maPlc5JHafBhcl0W_vQR6GKM-gcrGIoJlb46-ccpYHSNRYhxwXA>
    <xmx:Pc2maJ0MflBSwP8n-CHaS2nDnsVWM3PsSBusqHlRHXK2JyNd5tpBhA>
    <xmx:Ps2maKGrMf8x7RHYQB6ZuJJ2V0hFDTbX-gZCqC3b_VAbLvXzuytKPtoq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9dcba64e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:09 +0200
Subject: [PATCH v2 11/16] packfile: always add packfiles to MRU when adding
 a pack
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-11-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

When adding a packfile to it store we add it both to the list and map of
packfiles, but we don't append it to the most-recently-used list of
packs. We do know to add the packfile to the MRU list as soon as we
access any of its objects, but in between we're being inconistent. It
doesn't help that there are some subsystems that _do_ add the packfile
to the MRU after having added it, which only adds to the confusion.

Refactor the code so that we unconditionally add packfiles to the MRU
when adding them to a packfile store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     | 4 +---
 packfile.c | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 95e74c79c1..3cfe7884ad 100644
--- a/midx.c
+++ b/midx.c
@@ -476,10 +476,8 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 					struct packed_git, packmap_ent);
 	if (!p) {
 		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
-		if (p) {
+		if (p)
 			packfile_store_add_pack(r->objects->packfiles, p);
-			list_add_tail(&p->mru, &r->objects->packfiles->mru);
-		}
 	}
 
 	strbuf_release(&pack_name);
diff --git a/packfile.c b/packfile.c
index c885046d9f..a79d0fc1fa 100644
--- a/packfile.c
+++ b/packfile.c
@@ -790,6 +790,7 @@ void packfile_store_add_pack(struct packfile_store *store,
 
 	hashmap_entry_init(&pack->packmap_ent, strhash(pack->pack_name));
 	hashmap_add(&store->map, &pack->packmap_ent);
+	list_add_tail(&pack->mru, &store->mru);
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);

-- 
2.51.0.261.g7ce5a0a67e.dirty

