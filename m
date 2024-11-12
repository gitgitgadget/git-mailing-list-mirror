Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB2212D16
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408500; cv=none; b=Ilh0ImJfECwyHZhOK3J3Pd39iBPm87PlGT/PwP0UjKRX7+suaKBAqkHUbtJYWTZsW7kBSJ7Cn2Sa2qrOxxO4af2HOFoaliE0UROkbMzpPFck6nV6KoxYPXBBEuL+TTSJdMLO+Z1UfsESXLNVgQKL0bejY0xibhdbLeAdpSkIFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408500; c=relaxed/simple;
	bh=Bc7yVlDV/KKHWANF6C4ti4sUJ4jlobpD+m9ryMMvjnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZwAF/7YXAiELGi4Yf0Nv46gCYoev0bxSVPokLAK90vEUlkTLSBCrW0Ihz8CTFB/kF5LuU9hzve1sc5ulGFRx6Dg3Gh6xdLJm4FXsd6J16FaJWUovfhuUF2xKgmINFXR1jO+WcGs7vcV+8IZHy0kpR7saEJGKKmxwZinHJbfAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EacFW6N9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lTG0YPy4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EacFW6N9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lTG0YPy4"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 47EDF2540195;
	Tue, 12 Nov 2024 05:48:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 12 Nov 2024 05:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731408497; x=1731494897; bh=3nxU5vx6CE
	NV1bW1HXmJ7OMBYatFOXr4IHyJfkzpbIM=; b=EacFW6N9hAqcQWMGFqxlQ9AAaI
	nG9L3oLSVMsCl0jH3JL60Ok0dsCSnkal+pllhsU+GKMa0m0EQtrvuTndGTBZp9xm
	rCr3gclpBYa23xxsQgzdNpaL5riH9kWv7k/ClijnTq0yN7zCP8SMdshBa42te2N9
	N40ynnZ6Df6HgUERHDQk9XbeKsMjJ6kg5YxzSjflRyTfYLSOmES+0nqV6KJtEaVH
	A9IoJFpwovyknzWZJOXJOgd/J0iI5HSRZQGMczePingPNl0M9T5xdkqMqm+LDX1F
	rw9Wl5qNcPWdGNt2rIir2PE7tOXRUtizS+rpJxrsJDL75RS3qj1rpLjASGPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731408497; x=1731494897; bh=3nxU5vx6CENV1bW1HXmJ7OMBYatFOXr4IHy
	JfkzpbIM=; b=lTG0YPy4eJ7i2Zvu2408lLgrY4P+1K6HcgLEMVKzOt+M1Zi7NQY
	VSGmDzVpGxGrZBeGnSJ+6BxJifU0v+Gln6Xm6zSBsUqKWscFKBOCqbP+H6u2kLPE
	5BDIgDPlGb9KXNVv979WGli4qTMSPzZ5Hl8WMU/B9PZhAcSvN/J5zwWSH9Skph0C
	zMpS83mKqLuE8pg6Urm7sUoEc1LI8Hhax2p6bOxG3r9m66QyO28bzkd1t+oNyTAD
	Yi43OEQIOwGJxEYEd74Uo1t+NKB3Vo8+Tplbbj+mbpWMkpspUh4aV0TaLu8Gv9tv
	KTLmAhrf8uz2t+CR8uWvdE0wXw81Aw1doJQ==
X-ME-Sender: <xms:cDIzZ6-T9sgeueD9TMnhhXC6ggEEXAECqGZomQIXTEsH5C__p4xRGw>
    <xme:cDIzZ6s39khKpjP2bpFY5FMjuJSrBShjnJ1cORDgfQQkXpk-KrcYEwk1iVAwWRWy9
    HIQIJMzKgCIUF27qQ>
X-ME-Received: <xmr:cDIzZwCu3dmQemJS7Aqr3ZRnmcyDWq6eOpsBoJMwAzVrBByQMFUiGi_-y3Z6O7uqDhu86IOwrSYOLLgjtszKqDrdoGi5CSqxSMV0CIqa2PqZwq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhs
    rgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesgh
    gvnhhtohhordhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:cDIzZyeCmprTAJtRPJDDuFo7IdKgVa2HbwXPmsrmsdYt9JNIDFgrpA>
    <xmx:cDIzZ_M48K4j4r3kCrIzsVHIDR2LSBWsAD4r9CtGXUrGnOIXh8u7Gw>
    <xmx:cDIzZ8ktXQp7xp2uuyEBd-72wMToVsthnfPy-iv27-DsiDgeJ6kncg>
    <xmx:cDIzZxumuBb7wEIcoaAmXrK4D-XUm-3hidCSjINEXstqhvzB2tWAZw>
    <xmx:cTIzZ4gWVBwiI9Sb_RlXnI0a3aTtxnIGeMQmYEgUibAWVlDaWKYrLXoZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 05:48:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c58cc7a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 10:47:37 +0000 (UTC)
Date: Tue, 12 Nov 2024 11:48:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Eli Schwartz <eschwartz@gentoo.org>,
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <ZzMyZLhL-GKFP76c@pks.im>
References: <ZyjlvNJ4peffmGZ1@nand.local>
 <ZzHeLlYu8Gwk1FPj@pks.im>
 <20241111210629.GB5019@coredump.intra.peff.net>
 <bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>
 <20241111221320.GF5019@coredump.intra.peff.net>
 <f3b00260-ec3d-4607-aaf7-9cfd9898434f@gentoo.org>
 <20241112022104.GA77521@coredump.intra.peff.net>
 <941bae7b-83be-43f8-aaa3-43b4d9501690@gentoo.org>
 <20241112045224.GA98197@coredump.intra.peff.net>
 <xmqqwmh96nw2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmh96nw2.fsf@gitster.g>

On Tue, Nov 12, 2024 at 02:07:25PM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > [1] I think my gut feeling is that these are questions that Patrick
> >     should be answering if he wants to sell the project on moving away
> >     from make. I know we can't expect to be spoon-fed all parts of a
> >     transition, but I am starting from the point of view of: I am
> >     perfectly happy with make, why do you want me to switch?
> 
> Yeah, that is a very fair thing to say.
> 
> Even if you personally (or I for that matter) were not 100% happy
> with make, it is important for somebody who has sufficiently gained
> respect in the project to play devil's advocate to say it, and I am
> glad you did. 

Yup, I agree with you a 100%.

I was first focussing on getting everything set up and then get some
early signals as to whether this is a direction that we can go into in
the first place, and because of that I didn't yet provide any docs. But
based on your feedback I guess I should focus on exactly that as my next
step. So I'll include docs in the next reroll that demonstrate everyday
workflows in Git and how to do these with Meson.

Thanks!

Patrick
