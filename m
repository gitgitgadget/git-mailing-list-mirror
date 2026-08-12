Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92097483816
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559060; cv=none; b=XWyUsLqUX30nG/hiqTIGfBqIW9ID0RZOUfl/nTMEBttvbkMiVWAjmqztYxu3ZZr2lFeBVDNi/kFz5xfR009VZDj6RTD4TbMyyFeaiaAqI3ew6YdTcFjCd8Uv962GU1LFDvfxkFs+KDaMO3HE9lXJocgLcArJn2s8ntDEPjVZ0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559060; c=relaxed/simple;
	bh=DnynYurJ0Dy0e0dNXIift1UXQtOZm3r4TSkW/bFovj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J/+y/Ym86vCJmbwpaGz99piL0GtSRYuoOb7KxT7lGXUTSx14SqGunj/U3CLoEs2hc6syG+0BL9KQuAiPF2Y2Pb3G72Uy0KMi+KReopH2UzZfVsqJf9xbfutMQHLojrU+6FIa7GNTInUkbIUgYmX02vacUUK1f8QbFXuEb9dHj4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MwVl2I54; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WggN3E7Q; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MwVl2I54";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WggN3E7Q"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D81A7A01A4;
	Wed, 12 Aug 2026 14:24:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 12 Aug 2026 14:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786559056; x=1786645456; bh=4pxhMikaox
	rkmVunvHUWLvigN3w5mI0ahyIhm8bNW6A=; b=MwVl2I54++uDzNXvT8eV6dqAJQ
	g/oj6inCUTkbdhUdCf9Dm0rWyJcbFrdkto3WvWXe95qHn33gFfHNGHKpMGJcqdSc
	wpDIj45GnGYesPXfRLzcUjCeOJ1Rn/xZso8DPdwlFd3TF2iw1jW7mBIBAPY6ayB8
	dG8G5FLyjm5qKqGlUlMvpLBuPu5I5z6byGxLPExuXUzoeoDr82hWQRM0RaJNQsXd
	RqqXfRmwGyPPcaBDv5l0u5WgseR4F9mptSqJIDWVwcXT9bFMZezBIkf4rMszmNi8
	AvuoFmyxRG3zIE1eJvLRwN8++EYZIIbolWmmwwTUwXUQSFbpp3I0CyuU6Eyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786559056; x=1786645456; bh=4pxhMikaoxrkmVunvHUWLvigN3w5mI0ahyI
	hm8bNW6A=; b=WggN3E7QdybdT8r30sW1tgbje9eargjtvCXHtnOfwyKS1o0jorP
	g4Z3raPrru7a+Y9RRyE1plsg+B3tdyTL4UfLVOnRvTDuQN3Nz3x3KR+Q+1c26XeG
	b9o+QaZIEQtF/Np6W0QFPgsT0q2GVv7VgEVzhnW5+lnz5oRf/dIwlAqHHOrfIn9O
	9gfQl5S8m1mwUyHUnIIbW0G0OQi5XpwP1rtasWOs4CrH4s4zWA1GM+b1r2t/E9o5
	2Y5UTTw5sWZ0C5zvA8QUMEpd1fAByA9LqZPfyOfyoq5VKeN4zzxMsMlcYK20jEkN
	wkXCs0M9J6lMnVuJh1QYsjinSgotal4Opfg==
X-ME-Sender: <xms:ULp8as23a3J19respQN48EgmmhL6OxMZlZQ6Cg-YOZbBVOaXExpKtQ>
    <xme:ULp8at9WKNGcDMzPrh902v7a6wqNCfSIvHHZO9NkhxijnUK0LUN6Tu22sti1Gyuqw
    LQS83bxXczsiFkMUMDfznyLwAtv3v90EpwQ5ydAklluuAB7DCmOzwQ>
X-ME-Received: <xmr:ULp8atPp32ZVtqmMvKECQP34bloM2gdS8Ap2G4kvLJAeE3yxBknFKAJUsIlb4dejqPYNZg5_o4eLhoTuKxxmcDLQnY5OMtfhfA>
X-ME-Proxy-Cause: dmFkZTFu0/LV7tdU5BOMerEcELEsyxkXnDeGFhRhklhNweIKJX8wq5+sFUMFbkJmZw5vBM
    UUv+31ZXcAhe71HvVZcHvvDatkli6cdeVE/MBdIlLbYeCCuGorTZb/C2Bwm3i1pKY1Mt8X
    9mW+Av8DMnrUlEwYV8VUYNOiAA3Xw7yT88l1ZvGVeS7iHPlaUxNSQugS9tbvhl8BgFFxGX
    L7wU9gK5GO/qkNkw5VvcHyUCqnpiKEs1XMsonnC1FL7idNMPt8ebI1wr7O3ZyVZ0lIXOmW
    i1HlL4VO+nsiPvzOBAMnpgDurUkoSTD1LaG32HA7zPVxY8MAAUrXemNsLP4+dDcS1IPEhy
    n3ZpP3b8xMpYnlpsRfd9CkoB7BKoQ2XFfOYwi+8WpyoYl0EtTwGEwi6rrsafDpleXkScLo
    G91Tfg/eqfspGBhl6pEngcFFtqP3xAYvSbIU5UpYa50/kj9Lm5dNzMcStYQBjf7pg8dk/S
    8FPEttClC2oyQFIU3q2NZyUwz7m5z8kn4Gy6SipzjsW00ZAoIFZ9BGJXc6MwnRthwgphbC
    3z0bppQg9H2CxvmMW/tiA4gpEKb9hdstZR1ccJhbKaReMC2OafBH062bqzaRKeIVuNwY7E
    W45qiqoB7Q9+cekYfB4HONOeH4/UrEFGX3L44DXq7w86epks7b2O88KLlNmg
X-ME-Proxy: <xmx:ULp8ahdLjwcACBFrOLsmjhIUwz7ML6LEamyjbR8talTOGqS0EpKbaw>
    <xmx:ULp8asVfw1XLA9TdxB069PZGxjAYJX1B5k49Y0XHqcuvRJAS8gG16Q>
    <xmx:ULp8apge0y_nzebg4AqAtG51Cf1dHJtIbq3G_t1PhP03Dkp1549jow>
    <xmx:ULp8ar_euWRlAVFZKYkpZXGsBO-7zH1v9QA6A2A-7ncd4pHgrOVxBw>
    <xmx:ULp8aodNCoGFusVW5YSkKjZEGWy1_OrhwEZmqdZvRybX5k9XXotTZ1Q3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 14:24:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Elijah Newren <newren@gmail.com>,  Kristofer Karlsson via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v8 00/10] commit-reach: terminate merge-base walk when
 one side is exhausted
In-Reply-To: <CAL71e4NMdOeL0Mwngpw9qn=sSctFEVMPiYEiWQ=LT+Ct-mP02Q@mail.gmail.com>
	(Kristofer Karlsson's message of "Wed, 12 Aug 2026 09:04:26 +0200")
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
	<CABPp-BENLi7kBBu9QsN87aQY5C0kamzsKpXZTKYcHZk+WX11ng@mail.gmail.com>
	<CAL71e4NMdOeL0Mwngpw9qn=sSctFEVMPiYEiWQ=LT+Ct-mP02Q@mail.gmail.com>
Date: Wed, 12 Aug 2026 11:24:15 -0700
Message-ID: <xmqqwltvw628.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> ... and here I just restored your tests to their original glory,
> despite making the patch series as a whole feel a bit inconsistent.
>
> Overall though, I wonder if it would be useful to codify a
> preference for double or single spacing after periods, even if
> that (obviously) does not imply we should reformat the entire
> code-base directly.

This is a thing that is best left for "match the surrounding area"
rule.  As you mentioned earlier, it is not something we want to go
back and churn every line to make it consistent.

>> Okay, my last two range-diff comments were just jokes, but more
>> serious now: I think you did a nice job on the re-splitting.  Thanks
>> for doing that!
>
> Thank you, writing documentation feels harder (for me)
> than coding, but I'm somewhat happy with the end state now :)

Good.  We can declare victory and mark the topic for 'next' now?

Thanks, both of you.
