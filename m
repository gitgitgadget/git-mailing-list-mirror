Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A5355F58
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630051; cv=none; b=kC2piu1L1ctJNh5m0k7+Itz/DI/599HAkcTt3rpyxHS08+fk2yVRMFkpnIYZjrA/nIu1fUO/QyrDfNYDjwVA9Lw/mH3mtbQ7uRMRcrgJM8sam8neujA+6Wz36QSSPsjcnEWo/6uFEcku1MWo1GV6R/bSByITonF04Gpz0l9XhA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630051; c=relaxed/simple;
	bh=FMJJvX66ORrSH/enfzzqeNv8FTojR1hhm/2Vh1i4fdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f4Hx9M8j2vsJYOdPSjQE0drpi6mOfnhzER6KsA6DLpXuHQY7hB0e6WiMWDFpOX70U+1ZfTXWWNqcqWGI13rtsQGVno+bfBv3P7zskRLagSgXTDyTmciEBiHA3YDi15zJYqvMwA9Ptk/+74GvZQkutFNgoX9WcraJ+qKFOLB4cJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IzYQNp23; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=asFJGuG1; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IzYQNp23";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="asFJGuG1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0ECE91400223;
	Fri, 27 Mar 2026 12:47:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 27 Mar 2026 12:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774630049; x=1774716449; bh=DLa9msu/xc
	0iSi92V3ZMpFO2fhsPdByHR3VK54q9Ri8=; b=IzYQNp23kxf/BWxMiR5WWaOZiu
	ro2WmobjC2PhqHqSqLrJX/1tpOBjwYsTho4KL4FfbiArhd17oQYshGkFMeh2vSxu
	JfGiWGUMrqOL6oIitbI3KO/qV9wLD5Xuy5W4UoFFl1LStZsFIl9x9rX0QV/oCK+B
	aqpNSChczNQfpYs8efKZvDfCdu7mINIjyPQZa1jxlO2AE3A/Fv1pH3E5eZhsPwWH
	ttHEx2HstE0SOV2r0JWWOk+IShUBnHDGkgua2qFFBqN5G7p8e+oqI9Y0vclWLZpo
	188zfilltEhkmPwK5L29ZtTa7Shr3ukrLAGWsfND1mTF+aelMO/YQu1Yco7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774630049; x=1774716449; bh=DLa9msu/xc0iSi92V3ZMpFO2fhsPdByHR3V
	K54q9Ri8=; b=asFJGuG1JqBzBbpKgwlVGbjxXl53VXrcXLLoG+hzSuoHIuOCvxh
	gmjHUagURU0Dq64Iivmh/i3UFmFFZ6/PhronzbrNG8Uu5M+kqTTN1hHBLd8GDJOB
	wweR/NChIAUReQB+HjnrZTbvykTv7jmmMX7CLAU5NBb8W2ZBt5nRAPGrqePdXR5d
	TDqAl2ta8Vycy0uydfbKwB66W2Vhxfu6JOt64Ah5OD02kqmsvxT+LvqY6MewjHB0
	auKnv2MZonRitIoYyH0zIxCoxFQdsm0VfQB1SwPWrIstt4vKDV/Usowo8eqWLx6Y
	Wp6ZRpbPKSnaDbLsa/nwucfYY9oFf4iyyfA==
X-ME-Sender: <xms:n7TGafdZTxaO_u1sRvTF_hJhAXdnDTtT0D-CCPEjQzecrwcK56rANw>
    <xme:n7TGacovI57qcwa8DJK-FftM5jjbi4xUMBJi8rAHWYPXY8oDWRI1XC01GzRhpkeI5
    ZdMMDNb4YsKxX3cAK3ViUq3t-CCEs-RHC2bq9tjFrNZZlA3taYrfw>
X-ME-Received: <xmr:n7TGaV7doGA0RoqsplGeFQLCBK9iBTnK8LNALdOzp5yFhlEySF9pIDKps4OrbR6FY2KUOVZznS1HFuT_Y85pOi7gF579Z9u-vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:n7TGaao40yplwO5LR8oc5SBYGWDJGq8iTDbCD2DWK4aHiFJPg3jVyw>
    <xmx:n7TGafhX8RNFBX2e2JMJJ6aag7jinFfO1GDu9EVhfOAAkHJ9AaxjFg>
    <xmx:n7TGacLF_IU_eKdHdsSL57lQKGiByBEqOHNfIqQVDqfgpXhklL3GeA>
    <xmx:n7TGaXCJ9x7HHf0AnwhDFJ58JyOE9pZlI1ezr4h3IPyECeeJplgiBg>
    <xmx:obTGaegYahE3l3JSQ-MB66B1MC_nM2TOCjeQMwLpC7FOWvVg4NmcAnZ3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 12:47:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/8] improve "git format-patch --commit-list-format"
In-Reply-To: <acaq3Rg63ZjEV8rH@exploit> (Mirko Faina's message of "Fri, 27 Mar
	2026 17:18:10 +0100")
References: <cover.1773959395.git.mroik@delayed.space>
	<cover.1774284699.git.mroik@delayed.space>
	<xmqqqzpa489h.fsf@gitster.g>
	<ad6a32f9-1b48-4bb5-97c5-96d1dfea3074@gmail.com>
	<xmqqpl4qr1he.fsf@gitster.g> <acXYSm1JoX6YRuoL@exploit>
	<xmqqldfdmf6r.fsf@gitster.g> <acaq3Rg63ZjEV8rH@exploit>
Date: Fri, 27 Mar 2026 09:47:26 -0700
Message-ID: <xmqqbjg9kyn5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Fri, Mar 27, 2026 at 09:04:44AM -0700, Junio C Hamano wrote:
>> When the payload _can_ be specified to wrap (i.e., end-user
>> configurable output format), the wrapping should not be forced by
>> the mechanism.  A project that is not ours may want to keep a single
>> long line for their commit list entries.
>> 
>> I do not mind if the default "modern" were defined to include %w()
>> to force wrapping to those who follow the default, of course.  But
>> do not unconditionally wrap what the end-user formatted to their
>> liking.
>
> I see, since there's not much to edit, I'll send the changes regarding
> the docs and the wrapping in a single series (I saw that you already
> made mf/format-patch-commit-list-format-doc but I hope it is not a
> problem), instead of submitting a new one.

I do not quite know what you are planning to do with the above four
lines, but you do not have to answer me here, as we'll know soon
enough once you post them.  I'll just have to remember *not* to merge
the new -doc topic to 'next' until that happens ;-).
