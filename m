Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74649101DE
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759683; cv=none; b=FamTQgMkWaQdHNaLI39IiIB/+HF6uhAPNTYkK8NjRJG81jN90DEs9TM96SwOfWXpyvZt57bs5q0jI2S0JXPItH5y+2ajDYF1aFkLpFA6WcKlj6mTKXpE6Qw99gJ0aK4zTctPZHbmSXAljvkneSvDgtm9R3SLFejL4lAV0ksT5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759683; c=relaxed/simple;
	bh=msIieUR1Fl6YQ697Dt/MSm8jWfHftOXFfpeBzcwsBJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jGSlirb1H6fKh4igpVvZZweIm/i3cnJn9Ltm2YoqgGpLlvajrY/WGjuvn6Ule4rt61dN9zXmX+w1nGWNJB2vb0AsQCTfVr8JdAXJ9MOvYcH2RnpufENkn2lBJ11xxVFpJ6kj253E8WYTolzcFMbM8dTeMUgIZq4lkRGOvnXrj+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qm/VPDC+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YoVOSmI5; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qm/VPDC+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YoVOSmI5"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EC48254028A;
	Thu, 12 Jun 2025 16:21:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 12 Jun 2025 16:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749759680; x=1749846080; bh=gD8U+6dHiX
	zbsvoY39HUYgko4dGDGwtz7SxRfvY0ejk=; b=Qm/VPDC+G7Ibz0lxjFKGLOJOXi
	wsP+8hpBUxNeU5p599b8xu1jXCm4jNiTUxoiE5C3FrYOX5bvYA/NuW++Z79lyL9b
	PQ1S7TLJFkXvD0u8aIIunDC57gWoe9WNnfXJFefuBVwLrg27+qvZqe37QvjiusJD
	1dXOJ18wz1PLe3K14nzEX2ik0p8/KC+F3MYGf95Mn1fO73A3TKoDO0SYCwxT0qCL
	47CLu96DuIk1LfudWt59W4Cw8xLUTIr7QeuRu+Pv8T3LyMR2vcYm6PYuRUEu8+ym
	x3vW5R35RymsqTXDWKwTMFmysyYSMxwx2T567oorAIsLxkVj2sgNHYXLXIKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749759680; x=1749846080; bh=gD8U+6dHiXzbsvoY39HUYgko4dGDGwtz7Sx
	RfvY0ejk=; b=YoVOSmI5o7VWhY7I2koxG556E5AyKYEq/KO3U+EilVkVbdrxOPj
	zHS3rLIp38OmQDCgtDqYK6FOkG/2R36/qTmpgTLl56C6k01d9kg1YzWummH9NjKb
	3jjELZ+lrxamL/A7ykxp7W3oO/fTiGhs8fu35Yc0Oxj8CUDKBlVXkbu3nUJy3alo
	12Sbpn51PYSAo7im31Olukwke/GAPU6TwY5GO6PghlgnQ551+MAwDi7OEb002PFs
	8MFXz680r5MdRyETcBmgPlxfBXzgPIhx49X+lO+ytdIEKiwh69a5dJW66XrLUj8k
	zVdQky1h5glv9C1JZJ7hr2vd6Bpa6qVC21g==
X-ME-Sender: <xms:wDZLaNMxwg50v5v_u8A-h96yAG2aKgVfZpRrt-_bijEMN1w-Jmb9oQ>
    <xme:wDZLaP_k7PH4T2QISHjS-UTmzNL_OSNMkuiwEn76yhOgXb8pwqBig-dL3cavdeUCx
    Z9F2mX2AWxhVGj9zQ>
X-ME-Received: <xmr:wDZLaMTyDgy9hgm8nvI3NzeZeAqY4HRST0D3RRL9biDKTIUlbnzOYMrY_Pi7QTDBQbz-yKz-3NZDTdqFfbMzQTwbcf3ih3sMZ2ST>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduiedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsvggsrghsthhirg
    hnsegsrhgvrghkphhoihhnthdrtggtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wDZLaJvhDJqGeGvkOB73D-G5JlRDyG68a3J7wbVCknkXKcZGDAZ1Ig>
    <xmx:wDZLaFcVVcvzgcBfpPS6MwUxUlS4Zod9SNjgWvTnj6KUdy8Wop-eNg>
    <xmx:wDZLaF3cgKPv_0nh47zxwJM_VEWp7fd8DBMQOViwzRAC216a5QrKHQ>
    <xmx:wDZLaB_zMqJT_yNGOuYBhV2FLixeDuizA3nrr60apRhMcpJHBD3laA>
    <xmx:wDZLaKN7AawuWbK4hhQ9hpj4iwmSmxoPMdGCIIbrKOLdPdSDMbG07Ip6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 16:21:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/6] bswap.h: Rework ntohl handling
In-Reply-To: <20250611221444.1567638-1-sebastian@breakpoint.cc> (Sebastian
	Andrzej Siewior's message of "Thu, 12 Jun 2025 00:14:36 +0200")
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
Date: Thu, 12 Jun 2025 13:21:18 -0700
Message-ID: <xmqqcyb8d83l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <sebastian@breakpoint.cc> writes:

> since the add of bswap32/64() support based on __builtin support, the
> usage of ntohl() macros is broken on big endian machines because the
> macros are always overwritten providing a swap.
>
> The first patch in the series reverts the change and the following
> patches try to improve the situation by allowing to always provide an
> optimized version.

I am inclined to take only this one for the upcoming release, as a
pure regression fix.  It's not like with the change reverted, those
platforms with __builtin_bswap32/64 will stop building correctly.
The worst is that they fall back to the implementation they have
always been using until any and all released versions of Git.

The rest looked promising and with very good materials, but let's
leave them for the cycle after 2.50 ships.

Thanks.
