Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28417346AC4
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149339; cv=none; b=ovQdXOzwRmUQgWvJZxKf2hKpg+mEUGaVwRUU1OuPHFMfKBuf32lWbdoL3zqbZksWXVfyAKcUbwJFSl8tGENU/nubOCDSL6hQ0zWhNh0PDaoDLK43z/+HEFx9JNywu9JhOpcoNA4vPVHUp+z1zLaUoyGm+XyZxP0ZiTfzm/Omv2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149339; c=relaxed/simple;
	bh=Y1/cnnsrk2fcJRHHyeqknBK+olProgl0Cn8ja5dN1H4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BQ3YUIFUVNHwpTVxJiJ/44SQ26WG2NQHmKGmgNN7V2iaqfsbGMf80lLcbVpW09A7Z47owpXVTT0s10Wq2QXJ5USdQaaAk3u6mhfgD2vip/yiw1p/Z/Yk/MUvrIw+RMx1qbwsKjSjCDafFq8WOnks6Zx9/tvEchBt9VHzNxygymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bn3jeFNE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KBRJ78dY; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bn3jeFNE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KBRJ78dY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 695341D0005E;
	Thu,  2 Apr 2026 13:02:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 02 Apr 2026 13:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775149332; x=1775235732; bh=Y1/cnnsrk2
	fcJRHHyeqknBK+olProgl0Cn8ja5dN1H4=; b=bn3jeFNEdGmeXhJ748Qyup6XsX
	Grex3gfVTuWGAX9LBPmnU8sldubvg7ccak5hKM2JSK5kFlLAJZ99BkEkIRPlUlhG
	c94Erifa/ZPt4Kw31A4BDgYde4XvOhm3agEjaSj9HLZodR8CPOpKgrQvDz8DU5AA
	WGEzq3Nva9J8uRsPgz4036xxWzqqLw4/oTObUA7TPuSEriGVYPRrT7sLwhovozfZ
	8QIZJkp6mvOGxx6EP4pfJOZ5uQNFAv9S9Xj1CwtV7VQ+mz0VvSybUddrkj8MlEQV
	eOm4fqw0sMWIMWWXzbLeJ5vwTlFAovZYmlhfOFgSMc6tIe4F0ULfUEJPHE2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775149332; x=1775235732; bh=Y1/cnnsrk2fcJRHHyeqknBK+olProgl0Cn8
	ja5dN1H4=; b=KBRJ78dYGmxA/6jXsHh+XTUv11O6ONwXvONKLDKS02do/q7T1ae
	WUcfsyQKZPkZJy5DTBnbKbWrEsRPFyl5hgbTK5bmBjtVihcuBsGwEJBNAYD9bmOO
	Wl4JPDdSAzgsY1sMu069GI1hX2kc2UlcT46J3mg9UYk5DTVRwvFz3j+Ox/xRlOJU
	p5MsWXl/xlYBCrJPlAPsDk4X7y+3KcqR86CciImKz91T4rGnuUr2Eop4ciVtlF7M
	cilHyImgRMDOsmh7DhYNVaRoX5gbe1z2thXRwhFbwOtaflJqrOihUj1jR6o/WSxW
	xNhPDVe4RckkWu3B4tgvluZkrUjeNglmfVA==
X-ME-Sender: <xms:E6HOaWNVYnqfad2gHL6Kmv5qTTVJijibi3pVVbZzAWUQ3Q1EiO9WVg>
    <xme:E6HOaYqOSv05PUy_JmaB8W79n0-dRV2NNKBkH_aNSzC67asZf1z_5cLdbk4sqNXa3
    jbNAXyIoFm4AV3o3zC_uI9yWro3vJ5Liy-6gNtm8FZnjTgUsswY9Q>
X-ME-Received: <xmr:E6HOaXEHyjD3SQL8URTuLJKcE0pqydfwRbLpd2sMzTiGV6NoF41B4HI6cHYPwkZHvvNTh0mH0AqWofPeei7IiWrjk_NxSEDm6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:E6HOadogzgasNZjsdmPiS37GFE-2Iui-0AZwzpBI8YSOsJoW7UjOBw>
    <xmx:E6HOaQaotdIV2ZRFsnFYM1Vb2vfYSgqjV0V0T42MMnYKReFT4mQY4w>
    <xmx:E6HOaWUNBpVnMs76KvP70qv9-33K7Rjsd-X6Dx4NzNKxBFDzFXbGxQ>
    <xmx:E6HOaZ_owOBrZ_pRimUtpRcE3z9_vj3-9v7gzHRKkyqKt7KdVJ-edw>
    <xmx:FKHOaXTxTc9R6vGU2cGrV70wdq0Y9crVS0VJ0fFUKH2D3NgfWFOaWac5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 13:02:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Elijah Newren <newren@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2] replay: support replaying down from root commit
In-Reply-To: <87zf3ld90k.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
	(Toon Claes's message of "Thu, 02 Apr 2026 11:08:43 +0200")
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
	<20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>
	<xmqqtsu5xaw0.fsf@gitster.g>
	<CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
	<87a4vv2ada.fsf@iotcl.com> <xmqqfr5lkyq8.fsf@gitster.g>
	<CAP8UFD3P2Gs0J1FNyKW2URwSEW4ZaTrVO7cM1V8sG+zzXctbhg@mail.gmail.com>
	<xmqq4ilw2cnw.fsf@gitster.g>
	<87zf3ld90k.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Date: Thu, 02 Apr 2026 10:02:10 -0700
Message-ID: <xmqqv7e9qorx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> Even though I am on the fence about the need for this specific note
>> in the documentation, ...
> ...
> But to summarize: I'm not sure a documentation change is needed, but if
> you insist, I'm attaching a fixup patch (it's based on
> sa/replay-revert). I'm leaving it to Christian an Junio to decide
> whether it should be included. I'm happy to take it to a separate series
> if you consider that a better idea.

As I already said, I am not enthusiastic about the "how about adding
something like this" Christian gave us and I think we can do without
it, so I'll leave it up to Christian ;-)

Thanks, all.
