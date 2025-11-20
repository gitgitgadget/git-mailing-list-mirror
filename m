Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C229E10B
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649596; cv=none; b=Vso9EvP+wC8PJneYAor6Y+LvJ5+GUQySBaTn8BaYqvuXAJWI1CJ90nhG+l3MJ+oQjzUdI8WY11qGrBGz4Tkui86o7SLn+cl84udQPdQFTA2lAO8B7Bx469h5ANQ5jXyhZotmJYXfYv5CoC5kYUIaHSNLNlasQl6dTdCgOkzOG3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649596; c=relaxed/simple;
	bh=V6pfIa7fDlcsIO5ep8UdFKUrNY9MSfG8aTXEo6jJ3hA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YedqSUQVZ8/rQ3zNreSwLAd2hibTV5eJkAXLNy03IUwpeqAGzMIiBjNIGFhBqKIXXRvjrV72YD/pV6DdKcXwk3j1ck4SWpbbSV1Mtlnz/1tenRoew7TLTlUEzOMBCtANQ0AfQLrSALmacfqE8sQ7oTI2m0rjsroiCbXrPGnuoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EfR4Zggi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vmTvKciK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EfR4Zggi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vmTvKciK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B5C03EC037B;
	Thu, 20 Nov 2025 09:39:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 20 Nov 2025 09:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763649592; x=1763735992; bh=IFVmwnD7Xi
	KIrmZXlUaQw4EmDpzPWDVEJTyhEV95S5A=; b=EfR4Zggi+IeczJUoZDvO2SSTxO
	SY8Vo8+4ETnOQ6J+zQobxuKYjIe1BF+Yp6IfvZtZnMHVtQM4n07+qTABpvhlbg9P
	zcNKnBif3jIh6cZFtw+yLpbNj1i856qjoytO6mbrmQ7OAIe/Juqtj3haqOeUouv2
	IlYZIAqfrCIFGQxtvqTLi0ytoAqAU28E1xmmo2+/X3B3DaowZHAYbh0jee8Beq3M
	HWCMeop+1JGQVTGEfR5NumFcuAp9Uyua05AhYdpmQDdG3fp07Ua2aB0Q6yDzGZ2G
	DibOBenQzVSf/IRcBHtDJ2d9SlE1nWRmMRg0KWCpEm+7xpa7LyKbrAetw5Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763649592; x=1763735992; bh=IFVmwnD7XiKIrmZXlUaQw4EmDpzPWDVEJTy
	hEV95S5A=; b=vmTvKciKMTbxXPzUNEETL4rJsNqW5dDKVJ5xe6hTcuZ57HSi20O
	Fu9Iu1IOSH4m4d+Qnc6LXwcTBjFPYMFLdehJJKq52P/CV9Pj3AYDVptBbpiea++f
	FIMYzFPIcZyMeZQUDrGSFiammr5I+fY4m3Cc1U6IT7EEMcnbAHl6tLtxVaeJQ2jp
	2E7e1AmPHvPsPfSFAVTrwvyJ7SmOVFs/3y9c0vdNcZ0QfWwCpCXreZXpXfBsUk35
	o1RoF/bIrkPjRpAEzge4vQxNuIltj7pajwJw/33x+TkpPjJX9qggUAvN8lANX/xZ
	YX164RwGV/qvhqM3lJI5R4oY24FEZBymhng==
X-ME-Sender: <xms:OCgfaV_SbY3qVWT7q6mIjgQJDwinKqcgbR_kXZclwW8pmLchKwvwtA>
    <xme:OCgfaQuthpc9PJxVi6-qG75mcxKq-ALVCBqpkAEaun5g8gg0J8ZDwXfPmWodF4JLy
    4kpHGkkQrX7O4PGIlJT_TzHz0_wO-Yt2WUj1Zr0baNcr8IGO_PjMg>
X-ME-Received: <xmr:OCgfaYCd3QGs-HYz1joCKQw1KLf57uBRnvOgVe8wfBE_Af8D4IGsCRqCPUx1OHjO01Vqs6FRnnHqzTtVbkPsrxJDjPw6xsuerQLN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OCgfaYUd_fH9VxWXT0SB7-Z0LbKHqXUfvq1cHBB94qaqXJnOCi6GsA>
    <xmx:OCgfaWBFKKtBKKAB5hl0gvUs-CpsIONXpUKwDYiySNQq4EJqmkHo0Q>
    <xmx:OCgfab8XkJGCA1eT7SVaoJqX3mYa78lOKINzCk0yc0PRR1hQcr9mwg>
    <xmx:OCgfadHJrn1oHwisvm8aOrqsvitRzxIYjDtgMvoRTx7NY6tIsPeOww>
    <xmx:OCgfad8AxoDokRmKX6qvk22NZYAWEBgIxokaKjToOVaecSvOyhdxTKup>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 09:39:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH] wrapper: simplify xmkstemp()
In-Reply-To: <20251120082328.GD1283645@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 20 Nov 2025 03:23:28 -0500")
References: <058c5722-30f5-4bc5-90f5-24e4c6f3ff8f@web.de>
	<xmqqbjl0iax6.fsf@gitster.g>
	<20251118094621.GB530545@coredump.intra.peff.net>
	<3b1cb53a-6427-4626-a768-1961e25514f8@web.de>
	<xmqqqztvc51s.fsf@gitster.g>
	<20251120082328.GD1283645@coredump.intra.peff.net>
Date: Thu, 20 Nov 2025 06:39:50 -0800
Message-ID: <xmqqbjkwahu1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> > +#define mkstemp(template) git_mkstemp_mode((template), 0600)
>
> So this patch implements what I was thinking, though I probably would
> have made it more explicit: add mkstemp() to the banned list (not
> because it's evil but because it's unportable) and force callers to use
> git_mkstemp_mode() explicitly.

Because only a very small number (one?)  of callers call mkstemp()
in the current code, the above is probably a good thing to do.

