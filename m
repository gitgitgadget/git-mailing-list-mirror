Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE36D20E31F
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 04:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729226223; cv=none; b=t5VxDbOAzMRD5VCxin1Ff01hwPd3hUoUGT62umGrxtrcn3dJ9cKsvwl0ncRPOo+ncASIyA3lmaJUBMItIFKpaaoalfpUCLsTSma8RheZy+c9kKOcGm2j/4fdmv4PzhjzCb60eXXcDaEPOKTkyL3SdHp5lyYGwTJPlYtRsvPRGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729226223; c=relaxed/simple;
	bh=+lzfL99HQO5j49kQsRmjKokoJWEuNSnL0QMxGq2/ePw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgIEyBykKPFwaAuUplLp1VWXF2k0LdYNeRh5C80Bs80wlfQRBXrGEZq01DIcLMaktAM9PR5iRRCCjtuTzInDyWc6AbYEUZHVNurjdVt5gqKCOnG69eTh7THKz0ZWHq8dG4WCXIqshEVrfQ5TFpeemkid6Kx7pM0jMTOzwCTbHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GutjIDPE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/aUSqx7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GutjIDPE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/aUSqx7"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F411E11400BE;
	Fri, 18 Oct 2024 00:36:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 18 Oct 2024 00:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729226219; x=1729312619; bh=kix6SUCxBI
	UcBfFRA4kvILQnvC+6tGQAcnhyo6t+QX4=; b=GutjIDPEGMvqBkHd8PmthGUygm
	6ebGTkt+viUfxqv6rtJOBRH3dBk8YUX0G08aKlm6KIhdnJxNt6SvD8+SD2UXaSyr
	mrsd2bteD8GWh6ZrTNNG4xGArmAGybEr/Ve4xc0ywTGtcC7C0r+GviPNeuvljDFh
	ozqTsUNwq1Wb2lgBuxq+rXy4uG3ic1rVpEgoMiC+RF8lz33+gul0tT4XcaBkH4NN
	VRHwtVOkNK2Cs5Bd7vsX/oaTUcHXNfcweyF7acaaTzgZ2RaB8axGgNGFmEeKD5KZ
	gou8N4+Yw8AIj8GJ87bbBwoA/namCKOFwWxTRwSaLXvyZd3vx2XBrIw7btpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729226219; x=1729312619; bh=kix6SUCxBIUcBfFRA4kvILQnvC+6
	tGQAcnhyo6t+QX4=; b=J/aUSqx7e1aydYlLfaHTrDuhzGDMxYBxEa5bNFKaAwKZ
	WoK0MxLghcXpaY5c7w9dDLUE7yaMbXsWeLg3fgjy1kSNKY9bv8wXB1J9WKRiK29L
	SW8Tq4sqj4OpAS5vLnkK/3JvCJgbGYV1uCpVIavZ8scbRngbRQQHFhTY8tS19oNF
	sL34TIkBQMNpHT3pXzO9Jj6wF7KXXE5hLbu6RtlHpCC3m2gyRuxNNcMxOz/pH6TX
	DVWAqW921B3DwQxH+LhlioNIf4uFgIGa4R7hkkuMwogJuPuzz8r9kgcuAhWlWsty
	oBdyFHyMZGoXfgy611OYX/KCDvpit/zTG1INMu1CgA==
X-ME-Sender: <xms:6-URZ2jKG3xVyQNyewqrCmh2CCdWwMd7CB1Fv9iqZ-WiYczaDdkmjw>
    <xme:6-URZ3C6hN_ckn6Hq06pdi5XbNi5Tg8RMPrfhVgVq-BsiT1V5B2XR7FPTa-7Vhb7m
    EWfz8JJAeBSUj7i8Q>
X-ME-Received: <xmr:6-URZ-FZpGHmTDnKvahAXDmcmKNNS-Llc7c5C6JGAJgy5ffMqTUdaER44qlp9YFnSwFwd43q4ltWBd2POOk9taqJ245hPyfGdXdFBXRn0frd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrg
    hmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoheprggu
    rghmseguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6-URZ_TWCXrGv3O0My8mIwAcYi6Hu8MwbEwNO1cimTQfpv1JHn_MeQ>
    <xmx:6-URZzyCg8ryAFPSmzX_PpH6mHG52qsqPKSa6vcA5_NKlEL71Tw_1A>
    <xmx:6-URZ973Nvk1l4m5k9MqARvouokKoSz0H__Raiitb653Jg2Ux6pblA>
    <xmx:6-URZwyPXvaGdJ9aYz_CE3s9Fnsx5UVEvnjXx3ZrGAsvw3j7kQXLww>
    <xmx:6-URZ-rVf7lyGr0EVj3haTYxmKUiWsTxDX2-mx1Wx7aBSCB9MX7AMY0R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 00:36:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a0376583 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 04:35:37 +0000 (UTC)
Date: Fri, 18 Oct 2024 06:36:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] builtin/credential-cache--daemon: fix error when
 "exit"ing on Cygwin
Message-ID: <ZxHl5-32sClL6H3Y@pks.im>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <20241016145539.GA703747@coredump.intra.peff.net>
 <20241016150922.GA1848210@coredump.intra.peff.net>
 <ZxAiAUdtddwk5RS7@nand.local>
 <20241017023319.GA1858436@coredump.intra.peff.net>
 <ZxDOydD7kpSGchiQ@pks.im>
 <395cd934-f6a4-4f08-8bbc-f5a068ebfa39@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <395cd934-f6a4-4f08-8bbc-f5a068ebfa39@ramsayjones.plus.com>

On Thu, Oct 17, 2024 at 11:58:33PM +0100, Ramsay Jones wrote:
> 
> 
> On 17/10/2024 09:46, Patrick Steinhardt wrote:
> > On Wed, Oct 16, 2024 at 10:33:19PM -0400, Jeff King wrote:
> >> On Wed, Oct 16, 2024 at 04:28:49PM -0400, Taylor Blau wrote:
> >>
> >>>> This all seemed eerily familiar. Try this thread:
> >>>>
> >>>>   https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/
> >>>>
> >>>> It looks like the conclusion was that we should adjust errno handling on
> >>>> the client side, but nobody ever followed up with an actual patch.
> >>>
> >>> Thanks for digging. It would be great if you both and Ramsay could unify
> >>> on an agreeable path forward here.
> >>
> >> I think the patch Ramsay posted elsewhere is the right way forward.
> >> Hopefully he can fill out a commit message with the summary and then we
> >> can proceed.
> >>
> >> (I'm happy to help with explaining the credential-cache side, but I
> >> would just be hand-waving on the cygwin parts).
> > 
> > Sounds great to me -- in that case, let's just drop my patch. I was
> > basically just trying to get somebody to have a look at the issue, and
> > it very much seems like I succeeded :)
> > 
> > Ramsay, do you want to polish your patch with a commit message or shall
> > I pick it up and iterate on it?
> 
> I can't get to it before the weekend, at the earliest, sorry! :(
> 
> If you fancy picking it up, please be my guest! :)

I've sent v2 using that hack now, noting your original authorship. I
want to finally get on top of all of those platform-specific failures :)

Thanks!

Patrick
