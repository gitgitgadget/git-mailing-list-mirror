Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3492E0B58
	for <git@vger.kernel.org>; Wed, 13 May 2026 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688391; cv=none; b=YwzofJjL27NB/bmuR9lBurI/NPGpVbxKV6Zitxppsfi9eIlVzhW80zw3r/u8qFopk/7oDSA0kHTTyC+bGqMQWS9PB3RgNCWHFiTqJuOtHhb3DKMBNs8lrLRt635DI+MHC+XITZH2Orp59s0TtNxIUsYwCd7LbtqzN2eDmbd5el0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688391; c=relaxed/simple;
	bh=pVAIfloh7hj6Uk1GZcSl1JonIJEFwRkruB61qa0ANNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kBOnuMZFi2VdAxmdER3tqnp2HByFooSJGE8ykNuHUuv8NZugg/a3NZtz7M06JYHCICxr+W4YeybcV5ifywXDfhwaKXWxeOjF+PP/piigx33vZ906+XGp5/zJfqjE1OdXk7oea9HmqWMp5LhG4fawlTiY00AtkkvO5+kRwt8eP/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EdhD5tiV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k89vJSaR; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EdhD5tiV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k89vJSaR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DCC61140016D;
	Wed, 13 May 2026 12:06:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 13 May 2026 12:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778688388; x=1778774788; bh=pVAIfloh7h
	j6Uk1GZcSl1JonIJEFwRkruB61qa0ANNY=; b=EdhD5tiVJ4u6QOioGaDQzEDF4w
	Fd6wRjKNzLLkyo/Sx96Ctc22qjSA9+iYEPBWS207OFFhA1YKeWzIqXFMss+Z77bt
	5oqxVyvKmGd0H60d3s+vjgxvywTJAIOkc3AMfLEXuwK370yK2u5gNN+DpdT8RMw4
	2C0weI7RJEhXxg1b1hIJ3ISNUdNa9Z2b+voZF8ZYd8Fsrzyy+mxX1OswsxCcUEIh
	9bu5HuM/jjo+7xRD3cRt6uZB9WwVhhkKjkAM0ILg41CSi7UyXTTTRNVyjgTEeCfa
	Wx6CrnaPvjQ8pYBmPD7OHYRGOVG35VXf1IYZuZDo7nrb9pdfBVgumVpihRLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778688388; x=1778774788; bh=pVAIfloh7hj6Uk1GZcSl1JonIJEFwRkruB6
	1qa0ANNY=; b=k89vJSaRVZeQl2/+J8yrOIBKIMUDrwpwZL0R+nzse/TZyREP1cn
	YED7SPwAj5nW1/5dbjDqEbI4S3WCPVeVM8rS4dlKjcNIvY4r7gOAUuoYvzU5B4iw
	jfCdSlgWQ9v4H4UrxcrAPg+LK96ozAFNB7cf5Obq7ZJgcZ7J9otDp0ghMt54gs8b
	Q2u0J4smyX6cjC39T6ORtWAP5FPjmsumtxjiBoCRgqlisehAZ4I5vlN/0D2Y6jbr
	tN7/2bpM0fJrNUdgY1WYzkb5a4MdDDaI8jbLq7XFPJoHE7peQMiANhZjG2f3NhbH
	hBhysF6nsHz/oko0bCv5K6KBdqiJS7QIzyg==
X-ME-Sender: <xms:hKEEaic33i-5ny7VL7du0INXM-ma9tifA9gPvpBG0L2Yco-txw8ISw>
    <xme:hKEEajp98GI2uJwOdkWBM9MFujV0eiS4Ho6S0JcvZb-8K0EjUUXJuWc7ep4_WFKMn
    4D8jNZbyYTImXlOPiouz8fkGnVacF6sJ2SX-zr4FU-9_o9U2lYJ8A>
X-ME-Received: <xmr:hKEEag523SIh14oHr92cXmLRtZLOyo4ESPogp1yufzzF1tSXjxyZ12ZT-IsW12ghmHudvu5s6q6VLErjIBv89G065pDQ2bDjZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdehtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpuh
    hshhhkrghrkhhumhgrrhhsihhnghhhudeljedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hKEEappbDrJtJ5t645kgLvyM58z_ptQoVg9jVXMbx7wyhWEvv_7o2w>
    <xmx:hKEEaijYwh7fZOGNflzFwSQYPibl8LTWohhNAy22GVSxqtkHJlaTug>
    <xmx:hKEEajJ6myb3rfP6w_24GlCNNpyMG-I_o85EfXMfdxvuwmcGIWEPRA>
    <xmx:hKEEaiD95o_ZOhKA6TurRP4XcnbtF-qlkgC7cGVPQIL5PJ3zASSHaA>
    <xmx:hKEEavozLyKriVOAotViW546c61K4P5spHMr6UBgNb9HuiwO_1rVoLQf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 12:06:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2026, #03)
In-Reply-To: <CALE2CrT9=5mOauUdzxJAEjeeD77RWGyXjLGGTObsk9R1eOrP0g@mail.gmail.com>
	(Pushkar Singh's message of "Tue, 12 May 2026 19:50:10 +0530")
References: <xmqqik8tm16n.fsf@gitster.g>
	<CALE2CrT9=5mOauUdzxJAEjeeD77RWGyXjLGGTObsk9R1eOrP0g@mail.gmail.com>
Date: Thu, 14 May 2026 01:06:27 +0900
Message-ID: <xmqqmry3i9a4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> I noticed my stash test patch did not appear in the list, so I just
> wanted to gently follow up in case it got missed.
>
> Patch Link: https://lore.kernel.org/git/20260505103332.43702-2-pushkarkumarsingh1970@gmail.com/T/#u

When somebody else discussed on the topic or if I find the topic may
be interesting, I often pick up such patches to keep in 'seen'.

I am not sure if it qualifies as "got missed", but it seems nobody
discussed the topic, and I wasn't sure what the point was myself.
Surely we can pile on tests that demonstrates a command works in a
certain way, but is this particular test demonstrate something we
are likely to break, or something?

