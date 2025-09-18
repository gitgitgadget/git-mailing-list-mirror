Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964DB2749EA
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758173864; cv=none; b=q9COG24uKS++E2X+JkO/7p6dX1c67GsQk4kljJessye6IYhlejW8WMD4ONN5YVEX0XHakTRvI6yB+3pa/bbcd0ckKI7YHrMTjHZc0SOXkJfczqr7OxFnvZxKj9NWD1GfeAId6F94b9Q/Q0VVyh2eNoxCo83RhHYfq9OsoUK2IYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758173864; c=relaxed/simple;
	bh=4hK8+GuMgcIVj0kxektmO+qk135+y9uy49wK8/Jw64Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+aDtZDqVH7ADx/ss7KRBoeWGSYVHEwad1W6YRUapdeLgA3pNcUmY2mcAnJgFTFEMXlboXrKQIY22U9g1mFR6rKc4vpK/bjT7ezaJ4x5gkDyxtw8UNe2JzZz5S1IQSZSgolALJEg2viC5ZpsrZ62orGlC2STINYv+5FhSQOjR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kcbxaVB4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dlra+flm; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kcbxaVB4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dlra+flm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9882A1400246;
	Thu, 18 Sep 2025 01:37:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Sep 2025 01:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758173860; x=1758260260; bh=tFApiTKPWv
	HU6Yj2/EI7P1LplBjSLvAkMlDpXE/ZHmE=; b=kcbxaVB4xGrtMmw8sX7/Hcj0/K
	boFNYF0oLaqg3ykOOgEASPMsqzelccxynhD3GYFHnQlsTDSpWawcuIYZMC4NaHJQ
	MI7ymTu3GEK/q5JABr09K21idAt+n+A7Wgywdb5CaBviyF6SY84CnIDpoLl1vleh
	mYwbg3/8UcH/BO20F/msqimGHHCgR1ouuBxDg/s17Rd88S9cTsl/MB9eBUzPO3g0
	1/ShwWnLhSMMaq9ZegSdjckv5tmbcKylcyTIUIJm5zjFs9pewIkSlNzax8x+aoA/
	XRHh6jPnr3tRn4DRp+JDUkOMygalmq5/fzOGmPzKHgMYXtIRHeZtW70S9vUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758173860; x=1758260260; bh=tFApiTKPWvHU6Yj2/EI7P1LplBjSLvAkMlD
	pXE/ZHmE=; b=Dlra+flmXHhO28GdkakBs9DwxJH+BOBQI58LbgGTopakZuQV5+M
	wY98nA7PVB6XU/oNmNkjFzHB6po68nom/nEnYhpCoWuqCENCPu9S/Sk3NGM7BnK6
	60p4eiSva3Y1KEj8uaLOWPTfnbYeBnDwXgT9dAeXWxmvdSsCKDDU+MrYRygjkii4
	dfqRdfMPD2H2zGlqMOaKPuWmzOzyPGXlOb5OOj6devT72mK1KgKHTphFzW/siFK8
	xgQqwxY95xBN1krsbyqCOthfRugAj4IhMfuJ71z3cDRaRPlz15UO7UqLB6z78VXS
	FZ2HVjU7qlQi8kgbxxoRv+YnFEiYzbfl/7g==
X-ME-Sender: <xms:pJrLaEaz1hq9zydQXHswEi2LYt7Ei4xtiVruJ6AbJnvCcPq9CeI3nQ>
    <xme:pJrLaCpBgX-ClxOkOCGInE7OtIMhDLj3HWU_GRHzQQfFjbMtHfqJm2oLT0j_BgTKf
    dfbZqaaLuZuKphUUQ>
X-ME-Received: <xmr:pJrLaIb-FtIIejKPYHLNee0GU8YRPeCn0wmw3yQXJEdIi7agYKza1NtCRJVI3_jTfgWqp4KZSNKuGFTNZ5WcAYv3-vaKNlPbsveU7KAbqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeefhfefleekueetudffkeelffdtueffuefhie
    dufeettdeugfevkeffkedvtdefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtgho
    mh
X-ME-Proxy: <xmx:pJrLaKQ-YF5eLujWAn5DUJLPNp8ZazKz_afDi9jcGFyM8hoRWEMuLQ>
    <xmx:pJrLaP6EA6n1e1VoYCeGK1Y20DnW0tIcSBx9HWD71LfgPgUmymLBEA>
    <xmx:pJrLaPzd9muepS5Y3XJNokhKL121VWa-nv4e0360bgBeFtAD-2el4Q>
    <xmx:pJrLaOSsC1NwWOmh_HzOH2oceGyc8f6kbKG19Rl6LcW9VFcSa4KGkg>
    <xmx:pJrLaLfZShnuTkuEo_OAGA3mAfQvL_6MgtzzPEzBMC8tcYao4DC9cema>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 01:37:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20d0bb40 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 18 Sep 2025 05:37:37 +0000 (UTC)
Date: Thu, 18 Sep 2025 07:37:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Jeff King' <peff@peff.net>, git@vger.kernel.org
Subject: Re: [Change] Git build issue on NonStop
Message-ID: <aMuankGhjxXNKErO@pks.im>
References: <01c101dc2842$38903640$a9b0a2c0$@nexbridge.com>
 <20250918022912.GA1135133@coredump.intra.peff.net>
 <01c601dc284b$24496400$6cdc2c00$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c601dc284b$24496400$6cdc2c00$@nexbridge.com>

On Wed, Sep 17, 2025 at 11:20:05PM -0400, rsbecker@nexbridge.com wrote:
> On September 17, 2025 10:29 PM, Jeff King wrote:
> >On Wed, Sep 17, 2025 at 10:16:13PM -0400, rsbecker@nexbridge.com wrote:
> >
> >> Just a quick FYI. The addition of uintptr_t in clar tests has broken
> >> my CI build on NonStop x86. I will be fixing this locally. It may take
> >> a patch series unless a quick workaround is possible, which I am
> >> hoping.
> >>
> >> For those on the list from my platform who are monitoring, this looks
> >> like -D__NSK_OPTIONAL_TYPES__ is now required for the build. I am
> >> unsure what else may be needed.
> >
> >We use uintptr_t in lots of places in the regular code. I guess this bit in
> >compat/posix.h is what makes it work:
> >
> >  #ifdef NO_INTPTR_T
> >  /*
> >   * On I16LP32, ILP32 and LP64 "long" is the safe bet, however
> >   * on LLP86, IL33LLP64 and P64 it needs to be "long long",
> >   * while on IP16 and IP16L32 it is "int" (resp. "short")
> >   * Size needs to match (or exceed) 'sizeof(void *)'.
> >   * We can't take "long long" here as not everybody has it.
> >   */
> >  typedef long intptr_t;
> >  typedef unsigned long uintptr_t;
> >  #endif
> >
> >But clar has its own compatibility layer. So it would need to do something similar. I
> >see the clar line in question also uses PRIxPTR, which I can imagine might not be
> >available everywhere either. We don't use that ourselves at all.
> >
> >I kind of wonder if just:
> >
> >diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c index
> >80c5359425..f408af850f 100644
> >--- a/t/unit-tests/clar/clar.c
> >+++ b/t/unit-tests/clar/clar.c
> >@@ -875,8 +875,8 @@ void clar__assert_equal(
> > 		void *p1 = va_arg(args, void *), *p2 = va_arg(args, void *);
> > 		is_equal = (p1 == p2);
> > 		if (!is_equal)
> >-			p_snprintf(buf, sizeof(buf), "0x%"PRIxPTR" !=
> >0x%"PRIxPTR,
> >-				   (uintptr_t)p1, (uintptr_t)p2);
> >+			p_snprintf(buf, sizeof(buf), "0x%"PRIuMAX" !=
> >0x%"PRIuMAX,
> >+				   (uintmax_t)p1, (uintmax_t)p2);
> > 	}
> > 	else {
> > 		int i1 = va_arg(args, int), i2 = va_arg(args, int);
> >
> >would be sufficient.
> 
> Yes, it would work. uintmax_t is part of the standard set while uintptr_t is
> considered an extension. Not my decision on this grouping. I'm setting
> the -D in CFLAGS to see if that works, I would be fine going that way, 
> although better would be adding it into config.uname.mak in the NONSTOP
> section.

That should work alright, yeah. Peff, do you want to create a PR in
https://github.com/clar-test/clar to fix this? Otherwise I can handle
this.

Thanks, both!

Patrick
