Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27E71799F
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500367; cv=none; b=gZjhnwPkoVF3Tu1GgGk7mdItlF6HbvOzkmXS7oFP+7A4YtkowaJo2inpQe8dMtlyJnxDntiEPvrCgxXIq9cbGuHecxoV9ylvzbUvePY6sDjZN0FOWJ9Zjzqh75R6kQnDNrz7r9742ucdCiV6rfvPwEIy4noOG0Org6K6G7I33xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500367; c=relaxed/simple;
	bh=ONGpUEaiwAE6WerPGnEADcVK/x8Ds5xIoCLp0BdjZr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvBE+ncu6fEDOCxFNeZwWpe9s7FI+HkHZIrQWi7eWxvkRpE1UZNSavUZYyeHBKHuf07rxbF0BFOEF9SCRbHZK62VCsfLXpf1ogYzaDTdUXbWle2hEWcDNEUo4BO6bXN9FVEUw3rDhHrGccc8uHeB3krBe5y3GSKeOAInqYTQFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YRz3aX0T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h3NnpnF5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YRz3aX0T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h3NnpnF5"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F22F7114021F;
	Mon, 21 Oct 2024 04:46:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 04:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729500362; x=1729586762; bh=yWN30T4DcF
	hiPAPlgwOlgOgVHJ4Z1y1EAd13S3FkNbI=; b=YRz3aX0Th1QsuGskOmgg0uyI7i
	wgzYVQFf+FZ1Eoy+B3TBVuvXZFKY2na/c+IrfuwIqSBMnD2yRObR6rYvuJPZ0ynj
	wTZAy9pS7ognLdoudVMwjpZPRYGQfzCoeS5PorYzEfV4HI2Sno93UmvXol2Ia2XN
	YC+2OF225blFt5wuhiLqceyx7czZRkBSBHQ+cmFh3iXpu0CzUQX/4dUBqAsoR0Un
	dor7P4pauRPkKdhnYYLP4gweEbC+a1GdfzayErwX278PMt0ph2MfFetyFVCNrd6W
	tWB71u0dC0bh2Wk5ZLmmY7nKX8lBvW2fSai/X1pbCmZ93G6YYXA0plfULKqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729500362; x=1729586762; bh=yWN30T4DcFhiPAPlgwOlgOgVHJ4Z
	1y1EAd13S3FkNbI=; b=h3NnpnF5a9biOdgEr8UXpJfP0eOSKjFSl8zzfHEa3zAK
	YxrAsjQquIe8uLcXg825g+ElqO5LEELApTQLE77P84LbVBa4caZKWhcwfxIvQGnO
	YJQGXuABW7k0Auif59Y9nZ8JADLtVd9WJsYMJqfgVQFVUaj/1i6qS+DrnXqjcZNX
	bHovHGgYcjzki4+aJ4ih0yv10r5DH9no00SbiFOq8NCbSm3ybHHh7PHU91D65cxi
	x2MQq9A5FfCeI8LW5WaM/cquUqk5MnRNiFou0U9nJyCnAUnYnVdFT+ErvUZasQ1c
	Z3CHNlR3NVzXr4587YMVwWmMI0RaldaS3C9pGHrkKw==
X-ME-Sender: <xms:yhQWZ6nQeo81c09zziSQfrO3JfVgigS6L6u1eE_UnhWj3hLu_1qMBQ>
    <xme:yhQWZx3KhKAxt0pOxeImvt2p0JnLlslos7YtlMSjWgxEc6a4jdAXGpxi2lb8IGSf_
    TdJGFkNDTykxSzXpQ>
X-ME-Received: <xmr:yhQWZ4p0PBZr63ZFOJHNyNlkoQHdfe9pkn6Y-GZcu7R7PlpdaTvGx_I1EVThDjoJiJC4Spq7mHqEjgdblHWDhyRgjQewmr2M4DoYPQaQtU5W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homh
X-ME-Proxy: <xmx:yhQWZ-kGjShGqHmqHLcaISB92iJf3hSmc88RLTR7z1FaHJbr6bmC6w>
    <xmx:yhQWZ40LUaHQR0lQhl_LloxNQ4qib0LV30JFTyN71ACM5AoaDVY-bA>
    <xmx:yhQWZ1s1xex8FT1PFTtbcqdlyqEM4HhE63N4cGh7gjQ9jrmOrqhF4A>
    <xmx:yhQWZ0ULaYpPQLzh51YdUQLcYaQgzFgf4CZ23yeEJsfyFiFWyBeZPg>
    <xmx:yhQWZ2AdyxwKs5XMkHTwV6SVxS6Bw3x8XtABN9ZSwYC0v5bzlgm73dub>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 04:46:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c09c0d7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 08:44:34 +0000 (UTC)
Date: Mon, 21 Oct 2024 10:45:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/21] Memory leak fixes (pt.9)
Message-ID: <ZxYUxBQCUk4RIHNd@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <ZxLTfBEIEpvgM376@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxLTfBEIEpvgM376@nand.local>

On Fri, Oct 18, 2024 at 05:30:36PM -0400, Taylor Blau wrote:
> On Fri, Oct 11, 2024 at 07:32:04AM +0200, Patrick Steinhardt wrote:
> > Hi,
> >
> > here's another round of memory leak fixes. With this series we're down
> > to 10 test suites which are failing with the leak sanitizer. There are
> > two patch series in flight [1][2] that fix three more test suites, so in
> > total we're down to 7 test suites that we'll still have to fix up. So:
> > we're almost done!
> 
> I was just looking through Toon's responses lower down in the thread,
> and realized that I never picked this one up.
> 
> I think that makes sense... since this came on 11 October, which is when
> Junio signed off for vacation. I think that we each assumed that the
> other would (or had) pick it up.
> 
> In any case, this is now in my tree as 'ps/leakfixes-part-9'. Sorry for
> the wait.

No worries, I'm happy that you keep things moving in the first place.
Thanks!

Patrick
