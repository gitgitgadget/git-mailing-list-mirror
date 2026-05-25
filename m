Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137419D8A8
	for <git@vger.kernel.org>; Mon, 25 May 2026 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779678100; cv=none; b=GYjPsGBXlk3KT+ZL2qyO+0/cI49Z6iwfp3fsDvD3XvYjs1Mzor+yINa/ovLxjG4IHy0ZwPeVzAfeFKFmWf49xJ+/ajEfk6Vo1acbE9yhwauyYjborCJq7kN+JlDA/02w/xdczGyZe5Sn5IHsMs52Jj2UmQsDOS0PadikoZ1oH3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779678100; c=relaxed/simple;
	bh=jTxGjQ1CGfeJl4cfxkytnlpTJtqZjR3oV7kek0VfbGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mx2m38Lu4i1qSuzcumInJ1Mh652cEqauCnvVfUSykVEwaLReFz5+hlwWu8rz4PRWYX/0pGNfzHFpbzJvjefshhIZ6u2zSvV1egqfcp2CVAJjTSXRHRUzFvAbbENAhYE7odFAG5U8Tp5b2GoZNSKlbpARcoWiLvpJ9ti5tw563tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IJa54oTP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lbGESG8K; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IJa54oTP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lbGESG8K"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B8A0F14001B3;
	Sun, 24 May 2026 23:01:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sun, 24 May 2026 23:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779678098;
	 x=1779764498; bh=yzyF+kn/XCOHBAbiwronSQCnuautQhQIZe4b5ol7jKA=; b=
	IJa54oTPwcz2k+HjIKzYn7fssakD/XjAAhJOrrQnVL6o4T4+qwiEDKKDC/f1JMqy
	epns+CE3DNfZo+LX68mwXbno7yy9eoVjaqG/RR6o81xN4nqOQG4ViZWvozYHSEXI
	f5NQg9NTh2sV3aoaNMkrqydOoTlNEbDocQqbW0gRQbCFX6SoAqqKfTGUtToAKqSZ
	buSZ3htoeUK33IoAzU5T27DRD9eccerquOflnJdygK7zS7ozI30EjHK7JLyQSOuM
	iV7YPWPL4DwQ9k1vstvvExghRSAjN6pIswJFdoY5K5YYNFtR8kATti1IzZfFN27k
	y1+KL0IAIS7vPjOdebNnvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779678098; x=
	1779764498; bh=yzyF+kn/XCOHBAbiwronSQCnuautQhQIZe4b5ol7jKA=; b=l
	bGESG8Kh8M/1NXQrb0u5vS14vR69JWJ4C5BbAzQ/YR4tqiM6w/aPoyzbP78xjXYT
	MsCRO6p0uceYNscvIrikQG4vrUnQjRw7E0MwBAW8A6zI8NmCaZfqqTJanAcrpkWv
	EDGlmzEU8aEvdhWTJauD5sbwktFmH+VAaR7ZNw9QOkYC4TjudgglpHGx5u9NEV+i
	b8FKrj2WhheTaalTylc+xTc4+u9s2ZhqDRuB7+8gkZhY5V3BRifZUScjeOhu/Pp0
	BESY+5QEcvcRshq+nwNOcDCWnUB0r7pVO2+oBZ0vr0Bfo9u0y6L8gJaa7NQLsLSN
	/YZnphdpVA7E7JUPfkAOQ==
X-ME-Sender: <xms:krsTavctzvrWIAK4lMAkcmgsE8aIqx5YV3tYCWnNZsjkVD9ogjWT4g>
    <xme:krsTal7qeCeD48rjuSBy-zGT_590k4CiNjQ5klEP_LQRJBwfuue1k4k1g2Qp-RMJC
    Y6S2n9sNGPOXuq7jGWMlkMCjYW8RQYAMRqoKGtwHgqw2Btoin7mjg>
X-ME-Received: <xmr:krsTamsSaUu8mYVB_pDoUiNZtDLc9JARiA42aWNFX7l1ZKPjif8ScIGar6s7lMjUoht2IG57Kr1N-YesJ32QlkN_DP5XE2roYshY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtveeileekveevgffhueehudetjeeiiedtleffhfeufeettdelkeejhfek
    vdefkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    gvsegslhgrtghkqdguvghskhdrtghnpdhrtghpthhtohepuggvvhhnuhhllhdomhgvrdgs
    lhgrtghkqdguvghskhdrtghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhu
    khdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:krsTalhZOpnWGF7UnI5rjN_KOQFOG9Rbm6lDupOib5NVrHgaIiuPPg>
    <xmx:krsTahp2F8vLIPs7L6dqOYekxH1GILZDX5skPwuITB5f6LVZulBT2w>
    <xmx:krsTaiugeYdGp0PJdTL-eTkGQM5xsEyQ6NxNzrTUUNUE5F7bf2jwHg>
    <xmx:krsTakaS4HkX9LBYe1p803JSXipQPEifsghW5KLjzwuoor9hKxbrXw>
    <xmx:krsTakhYNyD_esdEBLADhEKW4gxZJvVuwDgLRUPEIEbKd51qFxh2_rJF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 23:01:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chen Linxuan <me@black-desk.cn>
Cc: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 0/2] includeIf: add "worktree" condition for matching
 working tree path
In-Reply-To: <CAC1kPDNKfm9Q=FWJkvpUSBmpmxL+RaOCifST8p=ViDwqVceNsg@mail.gmail.com>
	(Chen Linxuan's message of "Mon, 25 May 2026 10:36:12 +0800")
References: <20260513-includeif-worktree-v4-0-f8e6212d1fba@black-desk.cn>
	<xmqqbje4grra.fsf@gitster.g>
	<CAC1kPDNKfm9Q=FWJkvpUSBmpmxL+RaOCifST8p=ViDwqVceNsg@mail.gmail.com>
Date: Mon, 25 May 2026 12:01:36 +0900
Message-ID: <xmqqwlwsfazz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Chen Linxuan <me@black-desk.cn> writes:

> On Mon, May 25, 2026 at 10:14 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
>> writes:
>>
>> > The `includeIf` mechanism already supports matching on the `.git`
>> > directory path (`gitdir`) and the currently checked out branch
>> > (`onbranch`).  But in multi-worktree setups the `.git` directory of a
>> > linked worktree points into the main repository's `.git/worktrees/`
>> > area, which makes `gitdir` patterns cumbersome when one wants to
>> > include config based on the working tree's checkout path instead.
>> >
>> > Introduce two new condition keywords:
>> >
>> >   - `worktree:<pattern>` matches the realpath of the current worktree's
>> >     working directory against a glob pattern.
>> >   - `worktree/i:<pattern>` is the case-insensitive variant.
>> >
>> > Supported pattern features: glob wildcards, `**/` and `/**`, `~`
>> > expansion, `./` relative paths, and trailing-`/` prefix matching.
>> > The condition never matches in a bare repository.
>> >
>> > Signed-off-by: Chen Linxuan <me@black-desk.cn>
>> > ---
>>
>> The test in this series fails in GitHub CI for Windows, it seems.
>>
>> https://github.com/git/git/actions/runs/26377220573/job/77639885088
>
> It seems that "includeIf.worktree:/.path" not working on windows.
>
> Will be updated in V5

The topic has long been merged to 'next', but I've reverted the
topic out of 'next', so I can take a new iteration.

Thanks.
