Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FEE17C7BD
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541507; cv=none; b=X8cVbZfeEBWSn0xiX51DacG6BWPRak0R+ANq9Nzr2ixBoiLHu0e7KTXjj0vUshVdjQAJnnbsjp16EltBdTCAKLcZWv4hNMt8HUKDg4wAJeaDurDSVCnlI6lfmSKgA8vS/Cxd5KK/kNiI/o/74wG0LIymSS++GcIKMVIFIwU95oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541507; c=relaxed/simple;
	bh=9SVDC8Iz2csum7pwWZFfj8C6NkQ3os6GlzSSdJXm39A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvdh1+BT8teH66vbpNrlAf7BuWaAiUHhTnrOy4FaxuY8yy/mrf9kmeloXRSBC0Eqr1BSQcaNqL1xAjBwUooc+R2rCnDdFRQC5a+teQamfkaJaNd1NYX3DfNqztH/dxIf4RSSUkdpRmeKolKQqwZeKC91P61OnhVoqFRlwiByyBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n93gnvEk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XQHbhWHZ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n93gnvEk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XQHbhWHZ"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8D929138FCF1;
	Tue, 13 Aug 2024 05:31:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Aug 2024 05:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541505; x=1723627905; bh=t0cKJCT6Dq
	39QHiGDSWrGUXezekt2PtsslEGLNkj8JA=; b=n93gnvEkyDSGOA5FKF6h0b5eKi
	mhIPsN7Kswmm8kVpDytyhCToBKgYTWQTz4Mb8+VCKbdpohqf9dNv3oRn/YnlYeSc
	Q66GItpLqxnzf9BHRXKIDOL6NxLqsXndF8eEIV2sGVgd8lOxjBk9Q+L9NGkyA4j6
	UF+gREIbos8PtSVIZrHDSlEub4N6B3I/qxt9hiKwsPUz10vnjPaA4ts15Q4n2N7T
	JCqGY4G7BA1ePDtxg5pbMs9HZ36aW6IuAp9m36WOFHAjjrbLuI/1Ccyh48gP/ReM
	my1b12LzChzXVy0+Oy6La+DMg+JTZQYncuZyttY21+oSlgfu/89t7gux5VjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541505; x=1723627905; bh=t0cKJCT6Dq39QHiGDSWrGUXezekt
	2PtsslEGLNkj8JA=; b=XQHbhWHZu/HNuuy7Z3q88PDHZDu1HeuoryUijAznIFzC
	DYzIPc44DrNeR1VAX9fnafY+N17L46CHNZRNoULuRF3T3ORHFnQ35ZOKlvOqnQBc
	bEbIgnn37r1O9OLNFAKNdtTLYcaMf5Nk3ftokYW455wcAXhW5qWizIzku/PwJ411
	VObiyGvz9hchibYzxa09y2PfaQTJVjoHzVZnmAIIPTArh1k9JyMGh8EFvzd9l4ll
	u8yXUJzozyWJYq5xOoOFKSEwoK1SKkXiVHLR9klLfiFNwMeIO163oi694AlTDfsw
	G1AlEXWh5jjWZhAa1mto6MOZju5ciolQXn9HfISQJg==
X-ME-Sender: <xms:ASi7ZjnOA1hUoy1CLdM7wzTeeSxtUrAP7_5LfCrqnCGB6M3txDVBog>
    <xme:ASi7Zm0gaLdPbefF_WzD22iZBoVIcF0RxQoj0Atgff6J69UlQIrtt3trAA9gccenY
    81IZ7nHGOn7PtPxRA>
X-ME-Received: <xmr:ASi7ZpoUVAbNfC-YTed4YNNYHDT2tW7RaOCGbdhoW39H_RRLJZ-EwD-2BnURdyOxq9NAwePOmxeaNsEjnwm1UtSHQ_Q21uZdHDt64ax_HYWTog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgfefueeltdfhfefgteehfffhffegieeukeevteefvefg
    udelgeegueevudfhveeknecuffhomhgrihhnpeguihhffhhophhtrdhnohenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ASi7ZrmNKgszptR-040Y95VCWDC03iQZoZ8Q44lFIkS2wDdufTailw>
    <xmx:ASi7Zh1SQk09zswNkolL1J1JtjiymQF-WzTt4yukWXYYyoI9VdV3cA>
    <xmx:ASi7ZqugpdQTWyjPcKQ1DKIaLoFcZd4twQa8QruOYoMRo6htU1YMeg>
    <xmx:ASi7ZlWcIDMe9OoCwDdKs02f23zNxsDMUrcHLe8GmpQ3S_Z7ENICaA>
    <xmx:ASi7Zroz1d1_LQycRO-O94QA-MXKW5eKvC4SG_boxrYWRVSSWk11s05b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3f03a88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:27 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 12/22] builtin/fast-export: fix leaking diff options
Message-ID: <9591fb7b5e1dac2f989bd10ef2c13a191571a060.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

Before calling `handle_commit()` in a loop, we set `diffopt.no_free`
such that its contents aren't getting freed inside of `handle_commit()`.
We never unset that flag though, which means that it'll ultimately leak
when calling `release_revisions()`.

Fix this by unsetting the flag after the loop.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-export.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 4b6e8c6832..fe92d2436c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1278,9 +1278,11 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	revs.diffopt.format_callback = show_filemodify;
 	revs.diffopt.format_callback_data = &paths_of_changed_objects;
 	revs.diffopt.flags.recursive = 1;
+
 	revs.diffopt.no_free = 1;
 	while ((commit = get_revision(&revs)))
 		handle_commit(commit, &revs, &paths_of_changed_objects);
+	revs.diffopt.no_free = 0;
 
 	handle_tags_and_duplicates(&extra_refs);
 	handle_tags_and_duplicates(&tag_refs);
-- 
2.46.0.46.g406f326d27.dirty

