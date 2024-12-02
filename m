Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBCE1F9EAA
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126065; cv=none; b=Zu2Nx+G/Lnt+E2krXFeDXCnDLBqfkW00ruSH2P5LkAHpZyt+1dlDR+v7ImDpUAJ3pUT9PVrvyOXSr8HBuiVUzZxTS5RzW7stOCSDRlKuHUEEW4FONaY6LwJzy4+ajJ83E6mUcDUJw7uc9FTZMAMq3nzsh67o6yAG7BoXEyUk1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126065; c=relaxed/simple;
	bh=GDxK/qS80PUHYm4tcbJdShuJBfg4oPqUzRf6Ecw62dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/lhiMioaCMr2LUTmj4zIXy4XhVro8lSSgyUmxUovDi469NylCMMj6mefP8y3+g6id04YxxQ4oXiGtMvyDra9IBxjUb2uJpHIWGTfnGndqxjMGePB6tm0yrWzLq1z4QiHW7UXXRn6kfDO129Ev3zU/wE8FuezomIQNLlT7ExHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qvtSu2/+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=En1anzI3; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qvtSu2/+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="En1anzI3"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45C97114015A;
	Mon,  2 Dec 2024 02:54:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 02 Dec 2024 02:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733126061; x=1733212461; bh=/L9oEtyIx0
	0QRy3ZPfQpCMqLcynj2mmx2RULBYw/Ua4=; b=qvtSu2/+whY5BoQjSJBEkf34B5
	0bc13mxJmHHO0koToW8ynqGTjQx2PnyWYqC/43JoRnxKWuDg3rw6lg3dpwO0RSWZ
	lpxWfqnL0ZZOgfx0CkZDT5SmzHpbMr3Ult0ok9y2Rqgrkorg2zeXTUoaLO5Vc07H
	/i6h+fPd2+t762P1DMRPFM0RkYY5OroTu82K5r9wl/boFZJ1Lg4wOhzhMR2Uz7b4
	VLEj5hKIoFRQmDL41wtVVDxCAfRzH3B3ySbVr968eH6QvXC46cXRP54DpGPJJvT/
	2A1eveZ1kxvvJVVylNuoDe/MDjd8rPbnSXHXoH5ESZ/59JQlRVdHiafH6FLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733126061; x=1733212461; bh=/L9oEtyIx00QRy3ZPfQpCMqLcynj2mmx2RU
	LBYw/Ua4=; b=En1anzI3wXUFRQtfPoS1Gl7MCCAypkIkpJoTluPuRKjp0y2uMDH
	NDOxWkR4iIlg1EoM50LtK4BA4JHohvahXM45MM5shv6wJpPF5PbIXI5m9l0Tt/9w
	/RT75kIYKH7pEj7LwSnH8WOwAmHMyIoAdvDcx3ICNH+uLBHhgHSSJFCa4ll76VrT
	MY+d7nQm+mcBOk3fi5zrhU8jyLMYBtYB6ftO8O2uZD7kENms3zW3T2uB5uBXO9Ok
	2ios6eS1gICAYpq/vB9xzVy4tAt1i7+BIsy58Z6ORvnqAkdvNCp3ZHVyGubMav3y
	pANP/Xrqk882+Vehw++g5EmmVBN21Krr6cA==
X-ME-Sender: <xms:rWdNZ0xnzEgVrQQ0PFRd8F-Ee9ZpvCrijhtxVRxEiUe73o57MbP1aA>
    <xme:rWdNZ4Rf3A0cgOydQk7ViUKPCb2lBvdxYKNAQnN7PzQ-bAErjh8NvYjlLKgFrJLVw
    NN2Z3AsDtCbKq9RwA>
X-ME-Received: <xmr:rWdNZ2WbtWEFNZZOui3oWSU49RRxIcza_9_PkPWQNnT664XRMEHwZkxxf6JnMPmutsNg7ROZcvoQrX5gsOhohc4NWWIhzna6vqfpDoV2GtJylZEmXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:rWdNZyhU79_YxBT2csbetO_Mz3BrXkG68edK1k3_2wqjpS2qsGJ-Xw>
    <xmx:rWdNZ2CJpt-XfZb4t9sJfnxSHQKOe3LtQcNdZKKs2SnWb8MYLHxAng>
    <xmx:rWdNZzJauz7iTxlNlaeTSkxbwTGnPn_4AWuYuE2p_9Fk_DbMv2mexg>
    <xmx:rWdNZ9Dkg_1oTjIE0Sk7X07oiJIHb9fL-63DdlWLliQJKsc9PWQsBA>
    <xmx:rWdNZ5NidXvU1hHxURLfR3KLYIDmBeoezphqwlpPqxtBRVlonW6JMwXH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 02:54:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b522c063 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 07:53:05 +0000 (UTC)
Date: Mon, 2 Dec 2024 08:54:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/10] global: trivial conversions to fix
 `-Wsign-compare` warnings
Message-ID: <Z01nnsh9vKJi-NJP@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <20241129-pks-sign-compare-v1-8-fc406b984bc9@pks.im>
 <20241201220712.GE145938@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201220712.GE145938@coredump.intra.peff.net>

On Sun, Dec 01, 2024 at 05:07:12PM -0500, Jeff King wrote:
> On Fri, Nov 29, 2024 at 02:13:29PM +0100, Patrick Steinhardt wrote:
> 
> > We have a bunch of loops all over the place which iterate through a
> > signed integer with an unsigned index, which generates warnings. Address
> 
> I had trouble parsing this first sentence. Did you mean "max" or "bound"
> instead of "index"? I'd have also thought that "with" is the iteration
> variable, not the boundary. So:
> 
>   ...which iterate up to an unsigned boundary using a signed index (and
>   thus comparing the signed and unsigned values in the loop condition).
> 
> or something?

That reads much better, thanks.

> > @@ -195,9 +192,7 @@ int git_default_advice_config(const char *var, const char *value)
> >  
> >  void list_config_advices(struct string_list *list, const char *prefix)
> >  {
> > -	int i;
> > -
> > -	for (i = 0; i < ARRAY_SIZE(advice_setting); i++)
> > +	for (size_t i = 0; i < ARRAY_SIZE(advice_setting); i++)
> >  		list_config_item(list, prefix, advice_setting[i].key);
> >  }
> >  
> 
> I didn't exhaustively stare at each one, but skimmed through and they
> all look like obvious improvements, like this.
> 
> I do note that you tend to move the declaration of the variable to scope
> it to the loop. I think that's OK (and in general is a good practice),
> but two thoughts:
> 
>   1. Are we all-in on C99 loop scoping like this? I wasn't sure if we
>      were still in the weather-balloon period (but I admit I have not
>      paid close attention, so this is really just double-checking).

Yeah, this should be safe nowadays:

    $ git grep 'for (int ' | wc -l
    36
    $ git grep 'for (unsigned ' | wc -l
    1
    $ git grep 'for (size_t ' | wc -l
    105

>   2. The compiler should mostly catch any cases where this is not
>      correct to do (because any references to the variable outside the
>      loop would now be errors). The exception is if "i" here were
>      shadowing another variable. That seems pretty unlikely, though.

I've been on the lookout for such patterns and didn't spot any.

Patrick
