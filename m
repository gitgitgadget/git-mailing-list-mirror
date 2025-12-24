Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B5120FAB2
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536700; cv=none; b=O+qDae9eVA4zz55OhWiNolqQLvie0gZKCnH5z8WjroaJHpM2pBthW9hCSKVMm9mQEcpo3ostjZCBzPMriCZO/B2nGXJJ0oh/WZmwb0CBXsMAvHkbE8ApdXu3QlkND//aMiQo4ceB7YM2CoXvRCcABxkHS1ELqeDpBloZuaWF2m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536700; c=relaxed/simple;
	bh=l06wfWKCLurt41Z0jaBBf7gteRs/Se/+Ifh6hN57XOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RpeyNhquSxQAsnge1ba1c9t9h1wCW4eto2V4uxehasKHr2Ddr6hDE5orRdpuEJB4g0k9Hce9U4DeWshhj8o1pVrTNks+wl1a9el5JbdJuoIJMzkCifDWcW7yzsSZdAQQb8qPYPJcL6YJkEQgZgpPcdP5wBAabD+ZQzHa0NtB6Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h4cqafNq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xIEIk4MV; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h4cqafNq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xIEIk4MV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4F0547A007C;
	Tue, 23 Dec 2025 19:38:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 23 Dec 2025 19:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766536697; x=1766623097; bh=tZc6l2zsa4
	wPrxLjp/WRAkFBr9u6rlE7LdcQFXLraVc=; b=h4cqafNqGy1FJO+gpEDge7bOCd
	e0BmRZGixSiu6emj6w3KxqDZWnPasrrneLCZ7b07u2H1qZM4iPzb6OfduTepC8ZA
	6yWw1lgm0q/F7Pt+NMtoe3Ccpiw2Si4BzGKFyBIjYBLbhGcdaqprWl9fsz6nurcu
	oXBB5R2ycVBKXdnEdSW1MjaYoGl8EqBRxqMSrQF2DzrVBrYEE8ahCOR9Nu0+m+EW
	JvxmQxlitBKD0SF5g8t8RFM2T8ObrPUKucsoVmZAQFlMvCmAHG76K7IMyr/bpH5y
	Jgw1EUKvPkf0NFZl+gdhhuuT8Nc4qSDTX5q1Q0pRRdJWnbQ/MBBx3sb7g+BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766536697; x=1766623097; bh=tZc6l2zsa4wPrxLjp/WRAkFBr9u6rlE7Ldc
	QFXLraVc=; b=xIEIk4MVs08am0wkim2RLOJ6Pqo3oNm2+mU99YE6/AeM+QCmsmR
	62XBuvDNooGnM8ordjN3/uTUcj+uBWnjnmn7a5nhV6PcOS/OCLO6Gc7ktDi7BaOH
	K8OLZjGISaZphmPeHMXf1D29pfgOxN4KfsjZzNeVgcsCQ7H/waUbUXHkNkJMrkZ4
	O+6TTcqnL3/jZwGuw3USA5OyBBUCo8onaw8EN4Htaiw9zBkm1lHWaa2aQ6Otbnr6
	fmTuhYLdai1WkLBcs+r8CEYItGu5MVUbTTY6YMDPUUABLtltUoXSKpCD7OgG2CeM
	yBdSh7XS+SutKLEYZU821He6SAcOmoWCydA==
X-ME-Sender: <xms:-TVLaUDgzWmT4sEBaZTmU6yyoIQbnyh4AZgtshmiCjPAlbvMKgFslA>
    <xme:-TVLadbhTlrzXQwueKohX5cdtekz7amO8X3MSrMvvKAyOEZY7SJXvI33tH_j5E5_M
    8uph-oGmJEKT2yAcZOvpTVxNX0LgLs2LTDdPToonTrvX_kW9g6a>
X-ME-Received: <xmr:-TVLaf7-1roXJ_dntkVzniomvLfousxo_IMC74UDkHY_iJg9a0UQvcwgsGKIvxR6Ue4KbJ4NQSdB11QRaDVutYfkVFFbNP8nDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopeihtghhihhnrdhmrggtvhhimhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrrhgrlh
    gunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:-TVLaWbwa5InQpqnSVNOnKGEF1hf8z1u0vPvUKXrZ6wzXE3qoGSv7g>
    <xmx:-TVLaWi8Dpkh5UEwJKbeufX5iOu4DPwYobIHmy_htMeFxYnfrO5BgQ>
    <xmx:-TVLaf8BaEwt2a6DtOwD8V7Xy8WvhQ4Ou6pY2pC78rMlCtnHd1xrkQ>
    <xmx:-TVLaZo7YUnkTf5nh9HPgE11mjm-ayYp1UJt8Hnq5PvOaG_J8FvluQ>
    <xmx:-TVLaRqOjtUlbizvCO9sy76S8ZvPM2ld-MvGbqJ10qqq6yMSZjWK5CLJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Dec 2025 19:38:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Yee Cheng Chin <ychin.macvim@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] status: show default branch comparison when tracking
 non-default branch
In-Reply-To: <CAHTeOx_kSX7RhVvjjffSK849MMQbjNreqrq=ezHazw0GjMO2Ww@mail.gmail.com>
	(Yee Cheng Chin's message of "Tue, 23 Dec 2025 15:11:34 -0800")
References: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com>
	<CAHTeOx_kSX7RhVvjjffSK849MMQbjNreqrq=ezHazw0GjMO2Ww@mail.gmail.com>
Date: Wed, 24 Dec 2025 09:38:15 +0900
Message-ID: <xmqqy0msogso.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yee Cheng Chin <ychin.macvim@gmail.com> writes:

>> The default branch is determined dynamically by checking:
>> 1. refs/remotes/upstream/HEAD (if upstream remote exists)
>> 2. refs/remotes/origin/HEAD (fallback)
>
> I feel like this is making a lot of assumptions regarding remotes.
> "origin" and "upstream" are not inherently special names for remotes.

Good point.  There is a mechanism to determine where a branch would
be pushed to with "git push", and where the new material to update
the branch would come from with "git pull", and these places need to
be considered when doing comparisons.  This series seems to punt on
determining both repository and branch and instead uses a hardcoded
"upstream" (or "origin") and "HEAD", which is not satisfactory.

> I personally have different Git repositories where they could mean
> slightly different things, and I don't use the "upstream" wording
> myself (I sometimes use "official" for the upstream branch, and/or
> "ychin" for my own fork's remote). Feels like we should not be
> imposing such a hard-coded value when nothing else in Git enforces it.
>
> Also, when there are multiple remotes, it's not always clear which one
> the user actually cares about. It's not always clear if they care
> about the upstream or the downstream remote, of a third one that
> actually matters more.
>
> This would also work poorly with detached branches (e.g. the popular
> 'gh-pages' branches in a lot of repositories), or permanently foked
> branches like fixed versions (e.g. v2.x legacy branch when the
> software main branch moved to v3.0). Seems like for this to work well
> it would need to be configurable per branch. Even on a repository
> level there would likely be lots of edge cases with each branch having
> its unique circumstances.

Yes, unrelated branches like gh-pages gives us a very good example
to think about.

Thanks.
