Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148823C8AA
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967093; cv=none; b=IOX6s5sApau+od3XDuMJAyPN7lX31DoSLpwmTHCCShduxk2S0QufuvHp3teaZefjn0Ho0yCRgtby3oFWjYYrlHsxZTlqAj8gg6Mw6WV/4bYr1g6bwKtY/Hs/kBThxnLDOifxy2pIwAx09Ce2/hfnLPZW9YZeVozZEJLuAYlnKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967093; c=relaxed/simple;
	bh=Bh9vwedD9WWwmCCn45DtZ9+TUHFPyhOBpQyAZquslIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YUJp1s7in3wbGYnjEra8gRX3JIZ8tAGU7T5/33gF60ALrnESfoc8rD3HBprM+up3x9CFicN7JLIun2xUS/YNtmXV7X3//AliTjmaz6c2AN9QIUorwEDuZMeqr9LTgzlCgSSgPMrLdTbTQXGbyXqla2FWj8uP5HjPwdx3iwq8pUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0fS1VqZN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dE17Ey+/; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0fS1VqZN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dE17Ey+/"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A7E0114012E;
	Tue,  3 Jun 2025 12:11:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 03 Jun 2025 12:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748967089; x=1749053489; bh=iPRB7Dj6T9
	KR7NUUBtTI7RuI2cVOkgVx3Sj2c5X74W4=; b=0fS1VqZNZsZfkfFgE4kN0fYzlv
	xtF3rZ1iltI9tTtWBhXaxPxm9ZYt5Zalx6RZu58MKl2dyK2cS4cShIIg3dOGwvi1
	aAEPd7Ilwjo5WizkhV14TW8/AKoE2/+LO+yG0goCwUdw+WewkVy9WvSnvIFzWvlr
	57+grMpqNToT/lDh/pE1IuDWhTSBUcxWDcX43dpJYyWMBqIqqaxaTrygRZ7RRCLe
	opshUCAHJqcCNAwZmP9V00/ngTsuxNx9aENTNzLSz09mQVr2qILEmrXFmseyE8oB
	WReApTxGHAHOgcpb0d2vKq85AB8vqDJz+J5mBSCqh1XKf4PKMGhiXzgp4lag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748967089; x=1749053489; bh=iPRB7Dj6T9KR7NUUBtTI7RuI2cVOkgVx3Sj
	2c5X74W4=; b=dE17Ey+/btSn1pocEHrEnlIVa162m2TX2MfShKZ0Pmt2/8+SRI/
	Nd6Gm+OWXzBSYgNdUd0Ec+XKfv/oD1tVO37AXsHJYV0AZqShf+ECNnRsHuwxHFhz
	50lk5MU68K9PjTV9C3JghKUqx8KC/lN/0tdp58qZ9M6+3XLDebrFXlrvvFarxuwL
	uEb8GqwoN9RUVNJvwMazLGwqkeCzPuqYDnHcxeQWpt5gGZXq47ueEFd1znwCgknh
	JIRIZoHYVpqXY19eEE8lMgmdKgIyg1udzDrIUPdEpxA+CUTpsEyBppxWCC7Pkfgu
	jnJWzluxs3trHH+JnCNNTlLrgQh/9+3PzHw==
X-ME-Sender: <xms:sB4_aJA5zE11hpvGHBvw3pRFRgfPS-IRBYLdc_O8_r_ZGj255remVA>
    <xme:sB4_aHj-YdQ2cgPB5FUHzczGApjBuHs7L1iJE3gr6QujncBD7H8FZGXYaeD3TnNoE
    SVIsTVPXJObAYrfdA>
X-ME-Received: <xmr:sB4_aEmBWRbyMCR98YwUf0STids-DM21_k3zKJjJCfbITjrqYO5G4t7evoBSB_tlocKc24YG9eDxovcyGgvUrEk5xmhPnfFyIgRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmh
    hsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtseguihhnfihoohguihgvrdhorhhgpd
    hrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sB4_aDwOc7DKvdJ1ye5mWowsBLSGLj2pJ3LYMvW4NTipdgZFCt9dCQ>
    <xmx:sB4_aOS7WuPOTienpKpzOe_TjfFvNrXcEKQh3R4rInwSMHOUZi2TsA>
    <xmx:sB4_aGZ0h8EKegf7cGIORJshWH2th1FeCqEtw4UuL6rbhhx41W5c7A>
    <xmx:sB4_aPTE5U0SHVxJuo_vi1HEdX5R8kCKaHxYcdxrVIlRVczjQG4X7Q>
    <xmx:sR4_aJOk0jVQnXikSJNjDi583WsxXBY_3e6Iys783lkYVr0tjMCMkqw6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 12:11:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Adam Dinwoodie
 <git@dinwoodie.org>,  jayatheerthkulkarni2005@gmail.com
Subject: Re: v2.25.0-rc0 test failure on cygwin
In-Reply-To: <771677b1-2ce5-40ce-a704-752ff57ba0d3@ramsayjones.plus.com>
	(Ramsay Jones's message of "Mon, 2 Jun 2025 23:33:18 +0100")
References: <771677b1-2ce5-40ce-a704-752ff57ba0d3@ramsayjones.plus.com>
Date: Tue, 03 Jun 2025 09:11:26 -0700
Message-ID: <xmqq5xhcpzyp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> I noticed on Friday, while testing the v2.25.0-rc0 build, that test t6137
> failed on cygwin:
>
>   $ tail test-out-2-50-rc0 
>   Test Summary Report
>   -------------------
>   t6137-pathspec-wildcards-literal.sh              (Wstat: 256 (exited 1) Tests: 25 Failed: 11)
>     Failed tests:  2, 7, 9, 11, 14-15, 17, 19, 21, 23, 25
>     Non-zero exit status: 1
>   Files=1023, Tests=30946, 21783 wallclock secs (19.08 usr 42.17 sys + 4031.65 cusr 12965.78 csys = 17058.68 CPU)
>   Result: FAIL
>   make[1]: *** [Makefile:78: prove] Error 1
>   make[1]: Leaving directory '/home/ramsay/git/t'
>   make: *** [Makefile:3286: test] Error 2
>   $ 
>
> A quick squint at the failing tests made it clear that the failure was
> caused by the cygwin build treating a quoted glob character sequence
> (e.g. '\*') as a directory separator char followed by a glob character.

Should we revert ec727e18 (dir.c: literal match with wildcard in
pathspec should still glob, 2025-05-03) before deciding to how to
proceed, as we will be deep in prerelease freeze?

It's not a "fix" for something that is gravely wrong but a glitch
people have lived with almost forever, so it can be reattempted in
the next cycle without hurting much.

Thanks.


