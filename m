Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A83254AF
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040948; cv=none; b=n1I90+vzxUkeThQSqlio1qoqXgu84gkC2YNnaAZ9xvSRGOIx4bZbdzNlFl+JIWadI5swt7vCG2AReOuUsprO9fTwT9E0YZxD61AGN7DaHGYWtaIgW9HAz1fMR/a4IxtTi31kH+k4b15jAF4gim2VUSHCYz/zH8/c/mTgqc67Cso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040948; c=relaxed/simple;
	bh=iNFz8XUyJ3OrS59wMxcSF2egjHk+ymnFGmP9a3RLdsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6VUYbhM72DyuqkjOmerdvifFUZy1vkfuGg0t/IEJJkhphCFXxxfZ0SY2nB677cvXn/iCf5Xe28oC8T9+UmdA02XS7+YsWeNueB5wBrmvgnP2uDBSM3CipjL5PaPPN2/cKLg1LWUdtR2gccTW+M6FNXX9MjU9NnyQ2xhTABC1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NxWM0Evj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h0/bFkHk; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NxWM0Evj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h0/bFkHk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 20FF87A019E;
	Thu, 18 Dec 2025 01:55:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 01:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766040944;
	 x=1766127344; bh=Y6/NdNeuE8Yt0snVGB3xwbZPOQ00ikrs/RwpjvdO4QQ=; b=
	NxWM0EvjNeQlH18p0hl1gmqKLgc0lWD7/bPvtczKKeyboqw5b7KQV29Rsgr6yL4Q
	/Mh9iWPCqKoeBrR79QR2rRDkwawwymrKaIlq2tMzjWultvkZwoNKm6Edd1xGFyUR
	ZDZc3ZVfETAywbabUV/9jELzH/ZQEpZJxn+HO8gdhUCus0/RFoWFmIWYmgOM1kPb
	ANwcO/rD0uGoL4fqW6D3qa95ukhIT8gj//yRWm8YfxcTds3J/2ha7fyg9rOuFcn4
	RebkqQQHyeJvVf4PGHpwAs5TvVKBV/NJtescc8T1xdSmSd/93aXXV2+fPmROMh//
	nYlfZnxRCB3KrE0ZVtF/Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766040944; x=
	1766127344; bh=Y6/NdNeuE8Yt0snVGB3xwbZPOQ00ikrs/RwpjvdO4QQ=; b=h
	0/bFkHk1+73+eramP1hS7jwvvMWmpSZGlloifXieWunfIQ9QF4sLbTFjzu8xke0w
	1QSMPrPHKf443iOyD1plIEi8ZGS0fuoKYJKoL7Z4fluASHn4xE5Vb5UIWlQ4Rpnn
	rDHE89ZL1iaP2GPaGXhUBJI0zhv1baIWM80GwAET8CmXjHK5k9IQ/czy25UIqn1Y
	QU6DLMCgTNQxPoJGlr/Zk4iPsG0BUEClVV9x6jnUOehu/Yg5cikmtnuBLPFuPs23
	EFTA1BLRbz+Fudplv9gEXpzwtNwZ9XP6sQOlwMpdifLP9VQLwm6wZa1FN/kjLINw
	ey3/InGnhNKLcBe4yHEHg==
X-ME-Sender: <xms:cKVDaTHAl6g5Gif0awiqKa3Gu-U2VEmLOotIbllxveWvjyn2tABaZA>
    <xme:cKVDaWV6CKPOavfXfW80GY0Ci2QhgpCZ1PfpFPR0VEDTcL6y98TEspJx0eCVEPb28
    0JBIuVrPj3aKhFkd3aIDOxGpiO7Xv3uf44QZ9oPTTk32Gc0Ih98AQ>
X-ME-Received: <xmr:cKVDaSzR96f4lWUChMXUXy6gU7bF62n_pnJH0LxR9FzrBGZ_oHZa5RKcM6u9KaSWqJDk2xcZN6oax5OYcvBcvb7bB6Vsb-EA8RIX31oOfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:cKVDacPg204zidY96z1_Y39AqDVYE5ie1-WgsZVn1432iM_S4XDpkA>
    <xmx:cKVDab5iGFe1E7hheGqPsL6AjqTOMbD9Mo6KHNe0L4X70pASdIDjYA>
    <xmx:cKVDaVOq2GakSMK6T3BhGWBKQMsuXQHDvEF-q4D2QTGpB3TsKxDPFQ>
    <xmx:cKVDaRnKX03x3RaNe6nu9PW692sr9uKMjnGBanwHVC6XUpVqEPVsNw>
    <xmx:cKVDaT2WQ0F-lYy59cx645SfgINGomRp7eWAVL_rJY-S4v-U1XMFTsMW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:55:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 160c9c19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:55:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:55:25 +0100
Subject: [PATCH v2 06/10] packfile: only prepare owning store in
 `packfile_store_get_packs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-pack-store-via-source-v2-6-62849007ce21@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
In-Reply-To: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

When calling `packfile_store_get_packs()` we prepare not only the
provided packfile store, but also all those of all other sources part of
the same object database. This was required when the store was still
sitting on the object database level. But now that it sits on the source
level it's not anymore.

Adapt the code so that we only prepare the MIDX of the provided store.
All callers only work in the context of a single store or call the
function in a loop over all sources, so this change shouldn't have any
practical effects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index a0225cb2cb..c46d53b75d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1092,10 +1092,8 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 {
 	packfile_store_prepare(store);
 
-	for (struct odb_source *source = store->source->odb->sources; source; source = source->next) {
-		struct multi_pack_index *m = source->midx;
-		if (!m)
-			continue;
+	if (store->source->midx) {
+		struct multi_pack_index *m = store->source->midx;
 		for (uint32_t i = 0; i < m->num_packs + m->num_packs_in_base; i++)
 			prepare_midx_pack(m, i);
 	}

-- 
2.52.0.351.gbe84eed79e.dirty

