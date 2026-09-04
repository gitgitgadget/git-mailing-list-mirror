Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF03655DA
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538642; cv=none; b=czd6s1ylNpnryrb+tZ2LFkS9JbMNw2+k5Ji/cIuZJXgXqxJFLjS7OukLecc/2gBC+HH6exZ/4cBoicsYaBwDQ3ddEwM3jw1Ay/ut2ex0j6F1K9k2NEMAQeMDyiJIin01Fa+mjBqUR4r7w/uZgq7Keq9Xo9yE/8EyJvaApFDjs1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538642; c=relaxed/simple;
	bh=O/EDiKsSPkxG3NE1vBSFxgFQ9LE6/dB5i64WaPnf3pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NpPQF8vRRLPrLH4+Rq3suPoDERDhpT36GJakk8yoT23JlftsxK5khrIuY/Vg7ln8tmcG5o9vSludQ/4srapwGxnXjrQg6wGOCtEP9SqGT9ZbIDypY/w+QTgEycVpkJZwXRKqIMBTbq8YIBLEfJYoHDiUsgAJq3WgaogULD19fq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KKQzf+TZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g0yKzeye; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KKQzf+TZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g0yKzeye"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C131140009C;
	Fri,  4 Sep 2026 12:17:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 12:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788538640; x=1788625040; bh=7IJoe7jQU0
	W7/ZE1/kx2jD2OQOnIBedYy9wHOLdYoeQ=; b=KKQzf+TZ+AlnoFJGBW6XPLl+d2
	83mA5UYaR3x9uhpyBVyPbG5kL9wur+bY488fqm//bBBQnD5zzfQCwOelPWMeFjSj
	ZGilw48VD3G8c/FqPB4rUB+bg+pl1NNy5dct1y/fBJMilq1/R8oKx/GVVxiINNQ4
	BrRzNr0EKVUIJTEBU8uPowxzxwejYK7MmN0BCumNfWnuglQZ7hkWQkw++ZrCXYJ7
	nwgMAxFmR7tjsbrXus6DMxSErGMc90FvRbMSEyytBFnpnydgQfWcca4BFGb8JsGe
	V2YhxZBmXztYD3eDKJ3X2xBp+LuK6mogJfHqSwVsO5SGdMSc4X+CFfqT44zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788538640; x=1788625040; bh=7IJoe7jQU0W7/ZE1/kx2jD2OQOnIBedYy9w
	HOLdYoeQ=; b=g0yKzeyeClE1Usxbty4/9UrcZXhwAacFxAifbxvQc33wCA6oRWD
	yCPWUXUvc8sqO///rUvDlyO9VA87Yjnx1pZV0ooDIlBs4tMf0Tmya10fUXYR80uK
	3DXaKVrvgp9MuPGyNoyhskB5ruNA1t0PbLsZ51VGhLiPr11myXkYAp6CazNyTqsb
	7S0ZffmDzOKvh2fFdtd5Su/OpzIKd1I9hSIyHvQYc+v9anM/b05vAYOpIyEZGewK
	/A6bov5eHQXxwQgNPfCrBvMTLrJG1yiw36lq0gAyMqKQLgI+T2L//BQTnGJ+56N6
	BdMST4nVI9kHqDmbxB8e41678U1gFj9cmFg==
X-ME-Sender: <xms:EO-aahDRUkjRnElpWh7aWnkikH2AMGFr009QYyCwrjtTdUsKvow9iA>
    <xme:EO-aamgkBjEenCpTTNl-dQrvuTY3V5-ZDzSsHfROYE5xWj0D-RxfjICEOVXEHqkMf
    -HKcQinb-bgEis2b2szjX3feh4jDaa3PAFLaYmbxqTyMcTlvQ2iEuE>
X-ME-Received: <xmr:EO-aahn-HJJtDELcZs5I3Dxl4MytXI6i6lzN0XiobsXZn04JcG5GwRxiKnS0P0MmM72Gpgvei4f0U2JlILlOtZQkSBCjRNTWAQ>
X-ME-Proxy-Cause: dmFkZTEVybm1gBvexIhIfZA6Qw8rGY0TNYtxJdbwofoDHLBGyLUwSnaRLZnrJruY45yTMv
    l/bS4E+J9RlXTPqkDXPjMLKyN2aV80c9u+b2heApROivVO3sBSozyNff5byKMfGDgtRTQN
    goc9mJXVLVEd1Bw4cSePp8VkmbB0mN6tEUe2dp2m2sf1ApZ0c1i//Nkn4U7wOXUKWxSz7X
    BoIr/AFOgLTcuhPqo65W0KqosXNzb/ydo3PbfxdNhekzHcolYOQgD7Mr9eSLxk1YVNdXsK
    OZzzs0rOo0MCH6zNezhN4hhgC0XZ7MVnksVvuL5+9zHO8OBe6HonqHt31YvD1RiBh5MHdC
    NDd3CfN9p4bus38JgFCv2ahdz+hxv1eme2zQVdsQvZ6vA/Lkl7WKPDwcIFVphk/25ymcoM
    QZjiAGB7CR2iAWUfMy1jFIKl0aVVeOxi9PFAli5uQHcJ8RKYFKpSuvqct+cmSwKBSMqItL
    tbpmNGfdi9m3O7gOxvlQSa3erikcquigVJ/yVkJ7j0prydRIoI05rD0NXbu4Ra6TofvRRC
    6jPcv+d+eZy2HYtHgNb5IeyHBIf/vEj1p4a1zHUMotxylcnRq+PzouVS4SIspXS36qHpkU
    V9NYTZ1ka6fOnSGn/B1OQOA16vomsSNLSEOcSbPfFpOSQgHvCyML/PJAeU/A
X-ME-Proxy: <xmx:EO-aaqq0zghCiKw-4cw-6LPKfE7G-9OFYtgar726S2GIXC-Co1ZXgw>
    <xmx:EO-aaiHeTBzYPDrmJlvmwACF2aiQRbUrQFPpCKfoCwLUhrl1qSobkw>
    <xmx:EO-aauyHTs99QBcEVJXccOhRLse6b3OG0gE7-6B49-h_lsuvdrusuw>
    <xmx:EO-aavr6CFBflr7ZxgJ5GG7le6rg-NRMPTYFmbRV5xmB550RfJqSAA>
    <xmx:EO-aapFd6HNAUyJfTwim7cEOFbu28AG53fQb8YaSgbHzYiLbNB-TvZKi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 12:17:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Aleksei Sviridkin <f@lex.la>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a
 conflicting --no-commit
In-Reply-To: <apqSXT4lT7v0ILjp@pks.im> (Patrick Steinhardt's message of "Fri,
	4 Sep 2026 11:41:49 +0200")
References: <20260903125524.67889-1-f@lex.la> <xmqq7bl29g2p.fsf@gitster.g>
	<20260903214553.53942-1-f@lex.la> <apqSXT4lT7v0ILjp@pks.im>
Date: Fri, 04 Sep 2026 09:17:18 -0700
Message-ID: <xmqqh5k556up.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The question is whether it really makes sense to have tests for every
> single edge case. In a perfect world we of course would, but in the real
> world there are a) gazillions of different combinations and b) every
> test brings its own overhead as it increases both wall time and
> maintenance costs.

Very true.  There needs a very good justification to add overhead to
protect what has been working fine for a long time ;-).

