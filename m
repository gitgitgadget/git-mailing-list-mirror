Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94F348479
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583866; cv=none; b=ufzmcHNTe7vX20z6/UULLz78VjtGrUH7jh+b1em9Jtmfql3THcA3FJH4y+T6INcTCgKY2KnDGYT/y5CvE3JvSpOFJ3FcUyAtYEuOnjGkBQmHjME0Bz6JBxcbi/VaHdsr+wi5ydOUqo5yNjhsORLWRKMm/zWDVRUbYPnwfwD5zk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583866; c=relaxed/simple;
	bh=AY3QPy5XOVHnLFzUJpDFRAb9BrReVRVLDAc1imTKhz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XEO0lHb8msCpxk42iIMjQIL6PyfTwO6iLnP+6ytWkx7CAtD5C3ZiTuDqcZx0hjUgTq0MeeU8VOHNSO9CKvkGLBSIAdOmQyDyTELqFvF2+T9HY5qDbeuZco/M3n8Fy7uabDETxx+AjuUGsNP67eIKUYAzKgi13In0nMEnILFKl6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mxhg8hfZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dOopfqq8; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mxhg8hfZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dOopfqq8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F0D51D00152;
	Fri, 16 Jan 2026 12:17:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 16 Jan 2026 12:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768583864; x=1768670264; bh=EuKYRuypsD
	1CBDw3h+iWGl91TZPlPSLCt9OciK4t11k=; b=Mxhg8hfZv1Pb7jgI8NZ6u2fOrK
	wRTCTs7K2rdjMVa9+woAdhgCNp7Gn24/wuUlon7AZZ0lE3GA3tyCp9KNzVyawkPE
	3voTwxUW8TV+WTbJzxGxd0jegYZjZu5KwkDNlIgNpOru7rOS6YMPHwlrIqVkSzo+
	VL4YbySn9+Cv3S9g1hNLij81wyBLRfhscPBYLqK6KOx/gAcn288iQHsaseOQ78PG
	M3YDqjlRoeub3Fc6pf3TnuHWsUx4Dst9v0q4klYBVKS9nJ3NAQ8FxJQCdBbPNg+j
	lAiGLIsYVa7lvxywyXQPrL1H1NzNPdXcR2pvvVzeqjJS5dD/nhUy+tlBFotw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768583864; x=1768670264; bh=EuKYRuypsD1CBDw3h+iWGl91TZPlPSLCt9O
	ciK4t11k=; b=dOopfqq8hNU8pqys96DTqJJGqcKFezgrBnsle2/x1feD1RHFwQT
	nFkL29inHlpQDmg4eQfliOTDLo5pVCu/6rIGpdiXnowffUJ8+NbpwdYPin02HKOa
	uM/mKYtgeziyJvoOa2CGHQ2rvrLmFlaMN3AkQAvWDNGg6kWGLRD7ZNFgSri00Zq1
	Dz9lr6vp/WMXJuNg7Ze+N/gd6G8iXcNrlDpoYv7zY04qxCl7Ie5K05J3QCNmRZnW
	xxZdNP1GccHtP/cVWEDlNCFT5Fk5+TEPQyniAWsP9YOL4DCKU8fR7uVvEJp0zg2s
	ua+fRYJDtOXjaA/ZEA7zVj8uXnWECKnS6fQ==
X-ME-Sender: <xms:uHJqaSxONifqVKXLLxum7ncSOFlkBG4HgSF-3phARCHGrvqQqFfvlw>
    <xme:uHJqaQjVuLOjwXdjWAozZhD-m2-pb44blijw2Bp4siR7cnsE7-tyehiKO70Vc6vp3
    UmN4Ds3bZ9l_VPIKXHqLykRLLKyO8-yQlAljOB3Cgy0CHh-R4KVqj8>
X-ME-Received: <xmr:uHJqaWnAu9PrYK7Yxl8MLHFrphYv6AnLOamLY4E-BywadWvbWQkqkRaYd5wIcFjy2Y49DqHrl_ISZsYzrRye8Rmbg6T8n3e71B1gKEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhishhh
    hhhhrggrrggrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdrug
    gvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uHJqaeiwStMVxI2MFUMzg-5IcaplYQS_Bxz8R-HaOu5yg1LWWZoaAQ>
    <xmx:uHJqaS2XUp_Awj3IZOZFxf8MDhTQ7oUGbYRUFPklsvXH4MvJszty4A>
    <xmx:uHJqafIrxr_hHAv8tz1BJ9squ8Ishtk3JPP-lueSBTv3JTmwKVWt4A>
    <xmx:uHJqaax9zoWpGj6GZ39kMnm2AuSQhuLSxCF7aZEdstBvetv2kb4l5A>
    <xmx:uHJqaZ2kH7-bxPtNfBRvCokLi_rK7IFJIoGIY00uD6pbWJC4GB6SX0eu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 12:17:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org,
  stolee@gmail.com,
  newren@gmail.com,  peff@peff.net
Subject: Re: [PATCH v3] sparse-checkout: optimize string_list construction
In-Reply-To: <CAPvEtrdQ7LB4p0_yCg+ef6fsWSHwxA8C1uX0SJbfnV3vfQHD_g@mail.gmail.com>
	(Amisha Chhajed's message of "Fri, 16 Jan 2026 14:00:31 +0530")
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
	<20260115130935.93526-1-amishhhaaaa@gmail.com>
	<CAPvEtreX9sGHUn7+Y0kLo_VnK7Y=OYLq-kz-+np3bu1QtoEpnA@mail.gmail.com>
	<fc14e0e5-93bc-4805-a20d-d2aa4eb87ddb@web.de>
	<CAPvEtrdQ7LB4p0_yCg+ef6fsWSHwxA8C1uX0SJbfnV3vfQHD_g@mail.gmail.com>
Date: Fri, 16 Jan 2026 09:17:42 -0800
Message-ID: <xmqqy0lx8ojt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> It was assumed to be safe under the notion that our entries are not
> duplicate but as already pointed out, our entries are not unique so we
> need one of those two ways either insert or remove_duplicates, this
> can be a trivial question but i wonder how are the tests passing by
> removing these lines, i was actually researching about it.

... suspense.  And the result of the research was???

If the answer was simply "we lack test coverage", it may make sense
to add a test taken from Peff's earlier response to increase test
coverage, perhaps?

Thanks.
