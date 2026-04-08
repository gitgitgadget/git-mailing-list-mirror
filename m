Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905923D2FE1
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667219; cv=none; b=FM3qsYRtrJNeC4VLZhxTUj1VNlwXbRs/hmCEL2UCsk9irEpLV5CwSKQFSyLaHmma6+mRVw45E1alDEapAta/hn8LE8DSIkDPY8t9asv6Q4bH+oz4Yj7NDG94GfvoGoLikIXEmYRfO2oRvNo3tYS+u0ORLMDaZCXAyZp2vsKX8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667219; c=relaxed/simple;
	bh=b1UvkByVXhHUqvWaNiVry+6v5pS9IzDaxb4qzDqV04U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TG+7eAMrP6WcA/de6mJNnRyJaTtC95O/M0GJETlnTcNtZGMUlYehsZAIlF2ioKG7HwS4ZuNDJG5EE/OHy1eBAqArmxN7gYdZfRvl/sheyWGeDgqxuhc2/NkEr6YSqxiwc/5zRMv12NiIjryUPtdRW6Wx9nnyLN1IkRqdrBqrEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LVVn8Tdr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bgPgew3f; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LVVn8Tdr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bgPgew3f"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD9D61400076;
	Wed,  8 Apr 2026 12:53:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 08 Apr 2026 12:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775667216; x=1775753616; bh=vem77ZVoY0
	VDIQ3V5Dd62IExMDpQTxC2p4hNKlW5nAM=; b=LVVn8TdrTel6wCA8P2B71VPxKX
	owjFoNcCk0PVykl0dt6BZkpyVVcylkmP/mtpXLCK9RRlIPwJGAP2v+rRsnYEg/KG
	Henz6g4rn32MA41sid6m8rdvhp7u0yJc7AF+gPwLqyYhOEu6mytXHoHpq2XAuJvS
	lK86Ak/KUD3Y7ZYk07Qv5e/z/xjCMNfAMFkewFhIQJ89xd6YjpBG9rthlRbSxQnj
	G8GU8EynMAZdTd6dsFPfdA4iPsJfNbOo4qxWqU+eqm71X5Sx2xtp06+JzWMd5kzS
	FifQi1y52djjzx2L3HfTrRxp6caP0xH6M/A2m/7ui8qAs92plYucBS1W4SPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775667216; x=1775753616; bh=vem77ZVoY0VDIQ3V5Dd62IExMDpQTxC2p4h
	NKlW5nAM=; b=bgPgew3f8TQ8oOufYvoGjTsyME/YE9HajwWEldyQz/aNXCXtM/R
	4tXOaADT/Ey7e1clwhyGYbHmmr4Wj9V13z8jR9vd9t7rjwt0rttiUcfjOVt5Za65
	TzWakF9K0Poyb24SbIOzTuC3fjQTZVFmUgdxHboLh6o2EuVORsQnorTdpBsDg9rx
	x+Aw9XvhWPdMD5pUdnUDX8qzE8S9VYzfwt1TR5sgV5PfWzclsuoFbBPWC/kFBcBM
	T0pYxkteF1iagBKQWySe65Ifetlp1dzunyAhi2gAmGQW1+d/cs3TzufdTIy576Ah
	gWDR9pyaYR8x7YcTxwTeOl8Mo3bttdsyHDg==
X-ME-Sender: <xms:EIjWaZ4Eg0VRkqFbAyflafdCTbasnepc_OWVwxyrIJTEhvWmGDhMkw>
    <xme:EIjWadzRw69ZiYqx0AnRbPWeXfGWxmN9L_aevEls6SmC5piZ2LOViE6DL0FcGHYOs
    2pBzra7cq0C1lhL_6iAQccUL5UdG7KEq6t3Y0bimTorG6ttq3RvrQ>
X-ME-Received: <xmr:EIjWaYyVzqYnbKZykM5w4s1TepGcUTVXxqpm1nYGvSPIYkJZOcyQoyTEJiq9vAuijy7Uw4XosVvhbWURPDZzsY8uGr_6jSjLpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrg
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprhhs
    sggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:EIjWadyeAmvnso48F8XslCXZQjOvrVW8P3pG4yvISMY1yBIcgDlPNQ>
    <xmx:EIjWaaYIvVrvrJ-OUe3R5ZG-ZU0txnKw0LMFClVG83xt-fMMpEP_fw>
    <xmx:EIjWaWUsRmm2WIiE8X10McazAWO3ZZGP1laACdQRaKwZNk5M5FlD6w>
    <xmx:EIjWaQjtGLg9MIhhT7x83YAOrH8l-f9W0kulfVmSQHGK1agY8e_b-g>
    <xmx:EIjWadtq2CJvtR7JftcR2lG-G5z8ftWql1yxrARn6XS0l_EB80lsqCin>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 12:53:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Jeff King <peff@peff.net>,  rsbecker@nexbridge.com,  git@vger.kernel.org
Subject: Re: Help needed on 2.54.0-rc0 t5301.13 looping.
In-Reply-To: <871pgp3byq.fsf@collabora.com> (Adrian Ratiu's message of "Wed,
	08 Apr 2026 14:53:17 +0300")
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>
	<20260408052031.GB1324339@coredump.intra.peff.net>
	<20260408054347.GA2284358@coredump.intra.peff.net>
	<871pgp3byq.fsf@collabora.com>
Date: Wed, 08 Apr 2026 09:53:34 -0700
Message-ID: <xmqqcy091jht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Thanks Peff for the in-depth analysis, fix and test.
> It is very much appreciated. I missed this case.
>
> I agree with your assesement: this must be fixed regardless if it also
> fixes Randall's case or not (might be a separate root cause).
>
> I would proceed like this (obviously crediting you for the fix & test):
>
> If it fixes Randall's case:
>    send a standalone bug-fix patch, then integrate the test into the
>    parallel series.
> else
>    integrate both the fix and the test into the parallel series.
>
> @Randall please let us know if the fix proposed by Peff in the other
> response works for you.

It sounds sensible, but a standalone fix early before 2.54 final, as
the problem and the fix shown by Peff here looked correct, without
waiting for NonStop may be simpler to work with.  Then, rebuild
parallel series on top of the 'master' that has the fix applied,
perhaps?

Thanks.
