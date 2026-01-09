Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B936405A
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976368; cv=none; b=fMwcOb/1J3a5jWe8hgYn8PeaD+1RBaFkB8ZdulmfCZwriI8hgjeMwc0QMbewSjYT56amJlmDNW6sdMmqtRa3kKbkw/1c1c1Hs7Tyi1MJYJY6BihCyyDnIp9ATi86GPiSe8y2VnDMIcuf2UCkXYufFmher6z7fhLq3gLjqYDB8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976368; c=relaxed/simple;
	bh=lPWjB0k3c9g3EhT/XdC39Nik2fuvnx2fLl0nhiJ2KWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCCO7kVXnhzcmGap2ENYqcCOuuSt1xPUe+4qz42G/JYMYzOTCqH96BnCs9S35lncTVoOk/idBafrIukMDRjkV2dDbc5rZ06+xHSMLnHC9r0uacH30PieRN8Qd8I5Il0umzLCNfNTLLJpPOU8j6TC3JB4Is+TjOBePb2/mba3ajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AoePKevI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3Fc6vlM; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AoePKevI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3Fc6vlM"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C1601D00061;
	Fri,  9 Jan 2026 11:32:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 11:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767976365;
	 x=1768062765; bh=BRx6tsB/jlyzk+io0kF1VkHhhDJFmIdYg78vj4mpKqY=; b=
	AoePKevInBPk5sK8p8HjuPdljmqrbEbkSBw7VkyU7jx08/F0a0WKNpJd2dn3kuUs
	HSWy+5AbeFJvOmPb2J01XFXtcllTqPEPlMJ+nD8RyfAGUsfu1pK3pdhX1vtUd8Bq
	sjgSAIYw6cyOR4asGZxq0HQyoZa7sZnEU5mIkXgdB3Sf3WYPjcxWD6uzXpbKVRMC
	vSsfSOXqwAuu47IzW8ai7CzQeojZkueoX2h94jfQPOVRwwCn8dl5IlHLEkB5g4bQ
	DUomM/ByUZNBQsklC/FhzpW4ZBlMSiAENaE/D4vnWf1VPPwM0W+XuaBZajjIEaUx
	nS1wwubElkLQVbiVa6J9Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767976365; x=
	1768062765; bh=BRx6tsB/jlyzk+io0kF1VkHhhDJFmIdYg78vj4mpKqY=; b=A
	3Fc6vlM4wgpEfFYWY7VY2L4rcPF9HHIFjcUFnfAuUU1qIuKXHDsMy0nLZuHouAKV
	brMw2256AE484LhQfXIfDzISnV/5Xe9m1dFbHGXq/3gy7fXW9ULFWGP79YC+9PR6
	8VAH61Wh2Ud9spncZfvP/LSKdxgkFY6X5Rsp+L2so54mGptIk/DNNqt3Mrqkm9Mo
	Q/Cny3WTmHDmQc+3vCeFum80UaA6bFAQHGygqTNr2popAdiZcq0e+BZCk5V224kw
	NVn5uJesfJMrMbzE5JRn367MOKr1sHZROfZco+sSy0BCxwmgDHzq8QsLEd4wi9+Q
	ixc/KGbUQaD5foNdnvqvQ==
X-ME-Sender: <xms:rC1haTEU3WBM00WsG3XjQgtT8CRdT1h7CMGArTmJSoAGuHYUH0D9og>
    <xme:rC1haZoOX90cYdqFVOIXdp4W40FXzKmZAZM2NhA36lEhfJ8kN5xmqX_4DJiB5KMgD
    eHxgERwwonP01mICisNjRUkpDKTNKldmm-S8F9sDjh15LCiBUo3eA>
X-ME-Received: <xmr:rC1hacZiBRHbAJY0I4OR3zQ126feosNyVk1goi07Wq5g36ONmtIFGUlv1nBLG9VIfbpOl0VEC2HZf5vDk0h4ra3vZjy0-XeeQEI88Be-_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    ephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:rC1haSURwWcvXIAWsnc7A8HbipJx_UXEYmzhtSgL4QrfTGYmnNDGlw>
    <xmx:rC1haV8BwJS3ONPwVwn-4cH0jgtueDnfDyshpWXh6H-DfaURkq8ozg>
    <xmx:rC1hab_zXXt7CMrtpT10E7ETp_mreJ85naxbpJi3guqPViWkXSfyGw>
    <xmx:rC1haVQ-VjEynb_Iul51UMyEgt1UlRznNIVxzDArSvGP1zc_cqyPZg>
    <xmx:rS1haYBt0BMnKTIWAeW0PaSX565jyWysLyIfz8walJkqTuct7OmqkEp8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 11:32:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 237ecfcb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 16:32:42 +0000 (UTC)
Date: Fri, 9 Jan 2026 17:32:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood123@gmail.com,
	git@vger.kernel.org, gitgitgadget@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
Message-ID: <aWEtp77UB30SbKle@pks.im>
References: <20260109160037.2067-1-haraldnordgren@gmail.com>
 <848006C9-FD1B-4E73-935F-D4A338AF2EC9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <848006C9-FD1B-4E73-935F-D4A338AF2EC9@gmail.com>

On Fri, Jan 09, 2026 at 11:22:33AM -0500, Ben Knoble wrote:
> 
> > Le 9 janv. 2026 à 11:07, Harald Nordgren <haraldnordgren@gmail.com> a écrit :
> > 
> > ﻿
> >> 
> >> Using an enum for a set of flags is a bit confusing.
> > 
> > The point of the flag and the bitmasking is to selectively turn off the push
> > and pull advice advice from the relevant branch when the push branch
> > comparison is active.
> > 
> > In an earlier implementation the advice logic was moved to the caller
> > instead 'format_branch_comparison', but it's more faithful to the original
> > to have the advice logic inside 'format_branch_comparison'. Maybe I
> > misunderstood your comments around this?
> > 
> > Would happily take a suggestion on a nicer way to handle it.
> 
> I think other uses in Git declare a bunch of integer constants for the
> bitfields, not an enum. Why? Because or-ing flags together creates a
> value not in the enum…

We nowadays typically declare the flags as enum, but when accepting the
bitfield we use `unsigned`.

Patrick
