Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6622318
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886852; cv=none; b=WR8x5pDrHZ/acmrEW8x20aUMijsZQgWZsGuscnFvaEx4z3ebbBFSPnBMBxp2rA6Guc0v0v9cnGM9hmQjjxgCgAs6IunFz8Ho7MC6rKw16Q6AnmUzVBVYRiUKl5CyndSu7po+UW1N6g5RpM1cPvlpmlcx05p7Cfd/Cxa0oGSeses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886852; c=relaxed/simple;
	bh=yBAzM1dXckPyJlU8+lcqdGzsPQaHVmhwuRuNeLyzjpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbniPF62TZvgQlit094Ht4mnyLtn4VKpSmDZ5O5P6DAmIk1gRjWRETulFtdI0DDvjZt8ozb9p2et9BGi9sYMCJ8mMvY+dsWgbY+Y8SmrDbiwcFjmRzzuCQpGO2YDmuIYIvKm8NqDh6BjoK8yHzwRR42EHmXeQ+hHx3mI50Mma5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MWKsPxQ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FO7tNeJt; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MWKsPxQ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FO7tNeJt"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC3CD11401A0;
	Mon, 14 Oct 2024 02:20:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 14 Oct 2024 02:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728886848;
	 x=1728973248; bh=uo7vBjuizZfHFdd4NfRTrmhf+ITMHqJNM2K24/L7AOc=; b=
	MWKsPxQ5TBCc33lP0AMKgNOpSMZsFv/zNOtfYegaKRTGl5LDG4nhLX0lTV8eoyNn
	mWt5OHbbqDlbh6g1CxGF8+9P/e9BmFp7SyWRzrKhg7OLgeHQlZfGhxnv80xhsIR2
	jZLZjcThKgUwz1RaA+x73bwY3iDrl1TzQADjRiK3zmG5GU5zKK2du+Q5ny1iE73c
	pRoeDVqMbOlrRTCyEjX53vaRQwFI8qSbufS07A9VTrsJ9pjEljKSNrow2gWscrwg
	4Jv1JgRCvUO8A6jAlZ4Em5Frt8CAPJPlM2JeuFPWRJEzpZVB0wMxRB1WrpGnUur+
	DWvtCwK7tHoz6YIMDs1YxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728886848; x=
	1728973248; bh=uo7vBjuizZfHFdd4NfRTrmhf+ITMHqJNM2K24/L7AOc=; b=F
	O7tNeJt3+We+oMyvsks7k9zreWbzZIpNiT3kPcmSPd7K+15H9xdNjY8yq35f3ykW
	Mgt2g1p5ZmWb3sEWDou8gUcEaWdzRF2HvNOIKwlilLDLVMkN38jDQczwj7Pb2Kta
	CL3/DRsdVO2uGS5O9A6ena0SKIryAFR1tpd2o0/ngK+brw+3ThuqixHfBoaOqpMC
	EoYpzEqATTt22PH7HnezfbIaRiG+xMuEKuPTMkiCC/ISDixW5w4SbDFyzrJ3JVb3
	2WydJa13kKreEc7lTXN9MfiUaGBnziCDeKTFhO/CD7S41ghsPDkFv5R6b/NDsb8m
	/kQj6MDifvFzKMzJ28Vwg==
X-ME-Sender: <xms:QLgMZ1SbREZsTUDf8GpUqTNja0LLU3MJouq6muRSA3gsMX4yjFkvTQ>
    <xme:QLgMZ-y2KeABUwxEsDKpOBikN9lMgbRepfVBxtkGpyMv8sacISB6NXHh0KQWVPcun
    xjd_CmUwothBwzLGA>
X-ME-Received: <xmr:QLgMZ61CCy1fal4XtZp9tqkU7zPjqLDA05cL_KWQyr5jAgbg9dl1bex6Hp58QR2joCmRiB3txYAIqzJqvvrjbUmDckW7i_-v-HoY48bfH_NuUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeggedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfeehffegfeelgfeiudelheeuuefgieefveejjeev
    leehtedvgeejgfekgeeugfdtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    grshgvuggvnhhosehmihhtrdgvughupdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvg
X-ME-Proxy: <xmx:QLgMZ9A9Eg4m3L0WOkcJr52Feov9T-9BTpdoMxc2uby3nZUWxIXzlA>
    <xmx:QLgMZ-j1UPndQgZxXSUdOiytXPi5Lv2XwOfL5ouXhC6FD8dpe4WrVQ>
    <xmx:QLgMZxrALUd0AAYEQ47nPWV7cD69CHNiXW4VBlQfPvE-S0lkKlqAIQ>
    <xmx:QLgMZ5i4p3-_FwcmcZbq-6_rSUhmrv4_dMTv6QWCuV0juamg98JO2Q>
    <xmx:QLgMZ_tOoGa5x8bTlWvC0IcxLQbxa6biqiMkS_nwVyIvHZBbweiKCPK6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 02:20:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bfb3cbcf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 06:19:32 +0000 (UTC)
Date: Mon, 14 Oct 2024 08:20:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git no longer builds on SunOS 5.10, a report
Message-ID: <Zwy4NUHQ3zpzkaXU@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <ZwoxHYD-e4qo7OyW@pks.im>
 <CAOO-Oz0+sOpF6YQHSu0ytCO5TL+Anpr1k_9vQx6hebr624WjMA@mail.gmail.com>
 <ZwwmFtF1Y30y8eoU@pks.im>
 <CAOO-Oz2gN1Y9h-p_AJ=7iKzxOK2ShmgEmWzpFrpwwAD2GH=6TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOO-Oz2gN1Y9h-p_AJ=7iKzxOK2ShmgEmWzpFrpwwAD2GH=6TQ@mail.gmail.com>

On Sun, Oct 13, 2024 at 06:50:09PM -0400, Alejandro R. Sedeño wrote:
> On Sun, Oct 13, 2024 at 3:57 PM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
> > index cef0f023c2..064ca5c2ea 100644
> > --- a/t/unit-tests/clar/clar.c
> > +++ b/t/unit-tests/clar/clar.c
> > @@ -4,6 +4,10 @@
> >   * This file is part of clar, distributed under the ISC license.
> >   * For full terms see the included COPYING file.
> >   */
> > +
> > +#define _DARWIN_C_SOURCE
> > +#define _POSIX_C_SOURCE=200809L
> 
> token "=" is not valid in preprocessor expressions.

Yeah, typoed this one.

> 2008 postdates my available compiler by many years, so trying to define this
> is not going to get you everything you might expect here.
> 
> Fixing the #define to use a space and not = results in
> 
> /usr/include/sys/feature_tests.h:332:2: #error "Compiler or options
> invalid for pre-UNIX 03 X/Open applications and pre-2001 POSIX
> applications"
> 
> The relevant bits of the header:
> 
> #if defined(_STDC_C99) && (defined(__XOPEN_OR_POSIX) && !defined(_XPG6))
> #error "Compiler or options invalid for pre-UNIX 03 X/Open applications \
>         and pre-2001 POSIX applications"
> #elif !defined(_STDC_C99) && \
>         (defined(__XOPEN_OR_POSIX) && defined(_XPG6))
> #error "Compiler or options invalid; UNIX 03 and POSIX.1-2001 applications \
>         require the use of c99"
> #endif
> 
> Removing `#define _POSIX_C_SOURCE 200809L` results in successful compilation.

Ah, I didn't even know that headers would bail out in case they don't
support the standard, but it makes sense in retrospect. My current
version is:

#define _BSD_SOURCE
#define _DEFAULT_SOURCE
#define _DARWIN_C_SOURCE

I hope that should work fine on all platforms. In any case, I have
created [1] upstream now.

[1]: https://github.com/clar-test/clar/pull/107

> > +
> >  #include <assert.h>
> >  #include <setjmp.h>
> >  #include <stdlib.h>
> > @@ -271,9 +275,7 @@ static double clar_time_diff(clar_time *start, clar_time *end)
> >
> >  static void clar_time_now(clar_time *out)
> >  {
> > -       struct timezone tz;
> > -
> > -       gettimeofday(out, &tz);
> > +       gettimeofday(out, NULL);
> >  }
> >
> >  static double clar_time_diff(clar_time *start, clar_time *end)
> > diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sandbox.h
> > index e25057b7c4..b499d2e1e6 100644
> > --- a/t/unit-tests/clar/clar/sandbox.h
> > +++ b/t/unit-tests/clar/clar/sandbox.h
> > @@ -122,7 +122,7 @@ static int build_sandbox_path(void)
> >
> >         if (mkdir(_clar_path, 0700) != 0)
> >                 return -1;
> > -#elif defined(__TANDEM)
> > +#elif defined(__sunos) || defined(__TANDEM)
> 
> I think we want __sun here, not __sunos.

And typoed that one, as well :)

Patrick
