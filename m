Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5410F182B7
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045119; cv=none; b=Nqd9hPTbmviAMbgzQ+F14poP7s1K74wZxt1CGpIapyDmllwt7n++OxQdNW//AfRgfxSRrH071TaB/u7EiCaw633LxwbiMXHqvMsWjcjpkI+kIekNpcJSpPboVLm9OWXbRW2p6t/W4VjYaB7uvUG8x8hzF8ioBkGI7AX+fvI3H1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045119; c=relaxed/simple;
	bh=2kNvqUFHTBxzws+sYWf9bVsXnDu2/tz0GdA1LICAWek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oul1IlSGffTS2ZYNYDHpK9t2prjh+BGcj1+EaIbgRv9HX4DWfDodElCIsKQcsbZSP5uhmgZYjEViaSKinnRt0UnX7s0/BSb3uLDZ2O3BrMCwfAoISoqo2QoCCp7wA59h7PyV/tmJYSGdCpZJgN5XgdEzDu7KfqmpIuxamqnFQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X+qXTxn2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hBuccg8c; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X+qXTxn2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hBuccg8c"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95F031400233;
	Wed, 25 Feb 2026 13:45:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 25 Feb 2026 13:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772045117;
	 x=1772131517; bh=bp7WmDGDTtus3enH4Lbc1+CsLCx1LZA29Bn0+gWSqBc=; b=
	X+qXTxn2NeR/yoFFio3ZPUNQhfwPOQm7Xocc0iu28a5eLhEJVIk7eI5Kp03zRuqd
	skfyDuA1eHJzhV/hu1lN0NNGQItwSGdfbFBIjyEVtyGYpPT/MfypaIuxFcojY630
	adQSDmRW0wPREYv+hBLH9YBy3jJmkItj75FxSxVVrop9Xp8KLTedEKictk5jHfxv
	QGQV1ljuAQt9atporRD6vdMaKJbZCybpb6qFwiqJ/c69xxxjwzuTXEfIhi+PiZUK
	m46L7F+dYgf2x7MRfQW4OpBIXqj3ONVfwAPggOzwfFEWkdLK9s7TQkNATMF31LeA
	rRq0tzcde1wFQWpNmqfosQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772045117; x=
	1772131517; bh=bp7WmDGDTtus3enH4Lbc1+CsLCx1LZA29Bn0+gWSqBc=; b=h
	Buccg8cB1BFeaCSHs4a/w1A44naPdrVVOCqrCgTFa9zTrAxSdWxAeG6VS9t9paOw
	8iMyL9/6NQzlPfMny5xxwNggsP2BwGEu8eYf+AK9nGRxW/2ylHrs1sNXPJzBuNZP
	3+Ssa9KVzpcPSKR+zc5y7VcW7CZ4bWfedXy2C4xbcgBYGrR4v60cDdhIPoVtG4js
	Fu7L9qbvDbboaDfPhKguqWKSrLJiNtwCFecAZ/UX9evKEs4LaUn+XeqAMoVkbicc
	LBMDLEqFLWEQ3z41/9BAXsiswq2LjlDv7ukSFLs6fKFvAquDHslqRHqqohXQITIG
	/jmgshJe0VKiYXEpgOnog==
X-ME-Sender: <xms:PEOfadEOiWWb4n8-AaK2dNJcUEPAh3Qdp4ws_rNTUbI-hwg8TaiEOw>
    <xme:PEOfaXTK41L5IoqKQbfIiW61VunE-MeKat78s048BU91oA3slLVPNnZpqwtJTRJ4O
    g_xRaXzjxyCGFp6NEHgVr3teIykslC6bvErabOof1w7mF2-vB8w>
X-ME-Received: <xmr:PEOfaTabUa-F1EOP4XvJxmnsw4Dgcql1QFHi9tInba_OQeMs4ieXNQCE9oYkSh1pXEgZjEP_HgxoZwhCP5drwnQ6JltiB6kKBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgrrhgtnhgrrhgtseigihhp
    lhhinhhkrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtghomhdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PEOfaS1Qm_KADWYAJ1uVfD3OBvAB6KHB8Djame-u70Rc1YxPfIWdDA>
    <xmx:PEOfaWqNrI4BqFTMT3HM0gpW7D1fERP5NOYj2rs95KatbY9NcybCbw>
    <xmx:PEOfaRNZCYhHuQHjYYhA7UBuP01vjoWSdQxi97vPR9UH893Bs6W_3Q>
    <xmx:PEOfafo3LF3eY5bN_SnxsexIvkFkCZsZZi0Q-dr2488K9ROhZClZcw>
    <xmx:PUOfaQe_DtiSRevilHo7c8p34pSydggcSztfidKACoLlLrkc5ZYGMElS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 13:45:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Patrick Steinhardt <ps@pks.im>,  Marc Branchaud <marcnarc@xiplink.com>,
  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Evan Martin
 <evan.martin@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v7] build: regenerate config-list.h when Documentation
 changes
In-Reply-To: <4ef96c6bbf698a08df1df87b7cb053b6d0d00822.1771943954.git.ben.knoble+github@gmail.com>
	(D. Ben Knoble's message of "Tue, 24 Feb 2026 09:39:44 -0500")
References: <5dcd4e9308100a25603c50fecb36447c0ee4df62.1771682788.git.ben.knoble+github@gmail.com>
	<4ef96c6bbf698a08df1df87b7cb053b6d0d00822.1771943954.git.ben.knoble+github@gmail.com>
Date: Wed, 25 Feb 2026 10:45:15 -0800
Message-ID: <xmqqv7fkachw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> The Meson-based build doesn't know when to rebuild config-list.h, so the
> header is sometimes stale.
> ...
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>
> Notes (benknoble/commits):
>     Changes from v6 (<5dcd4e9308100a25603c50fecb36447c0ee4df62.1771682788.git.ben.knoble+github@gmail.com>):
>     
>     • Fix Make-based builds when a dependency is removed by generating the
>       expected empty targets. (Thanks to a report from Szeder Gábor.)

OK, now we are pretty much completed and ready to merge it down to
'next'?  Let me mark it as such.

Thanks.
