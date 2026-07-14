Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4643A329C7B
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007368; cv=none; b=VgNPkvTnnJZqn1KgmMluzbXADN8IUy5LvTL67/odXs7BI6P6f+JzMLUQ1hy4wXtujPRZ6mGTj3HNPio9rRPvDXAiK0779Hsc9N/G3O8C/mlltpjqZ8lDdbu/feNplBHPKKVxQEMdwJBZ8hbw0pKpG64plLVougnl6jLtZZ0XZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007368; c=relaxed/simple;
	bh=XfFN1NYBW3cf4068viioA+tLKc9WEt7FqLJpB2Fl/4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpWqJ/OwedsPNlfA/lLwEM6aDsfcxgGrTkU4DZhoJXndxUQGfuOQQujAob/IptWWqoMD8wUix2f+G4vPvJ7g49QE6eHHxxpzFeV2Hk3+76KaILCQ595PhyukG+IRWRNsyMwPpiCIA5l5kQXcfiNSd67Wkagw+3XRnceOtmPnfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oFa4ZtsP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S2AuINVi; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oFa4ZtsP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S2AuINVi"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5134D7A00EC;
	Tue, 14 Jul 2026 01:36:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 14 Jul 2026 01:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784007365; x=1784093765; bh=6m4GCFw817
	O0LYgMrh0M4JcV88Fe3s8D3LLLwzxVoF4=; b=oFa4ZtsPRTF9FxwLeH4gHfikNq
	2fot8cbBIZSJs2k1brpUpZZV1zF+homg8xZ3B+dYeUuWcbfSGQd5EkppkVkw3kpr
	0xOq30ECzLf+3G7GqWha5Rj+jhTNIUpnb3UWADTKwr+YNdRc/frR7RMptaZdpxBP
	rQsMHBseBMwQxxpRUiSZwUNRXIOGznTdKwGzotQc/QibhzcCtdPcoUWRYMxVcz2e
	xblmyBVpNTna65M8ks0vaqLhmUsadschOcVFcAm+X/jGjUBQTcfJp3EXGaoudyNW
	KXQ30ZWkK6fy0VzkoG+FnB22KxV0XoMgRpFiXGCIvw/CxmGZZ2gCCd0ZWxog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784007365; x=1784093765; bh=6m4GCFw817O0LYgMrh0M4JcV88Fe3s8D3LL
	LwzxVoF4=; b=S2AuINVimX1o6ytx6ZwxfhgpYVG3TKAd/bI2e0Ml9dAK/9pj/Ce
	95rXzQBRSWNH3SOerJmFbIACLmCjlFrHD72eexxZIek8qFGuhP35RRO8q7b+gSuz
	2aDXAlD+p8Ib5Tk3BVLnGaieUQXQaGmGEjseG7XUrr/XL/GswHymh1Ikj5lrCaFs
	wS1tGcnSK6mwdym+BatcdpQf239H53iCU9XmTp7wkFvIK1vJXeHaQsGenmLbCpaO
	F4Daj4co9axC5JmIvD0udgy/augeqGVnWLu9TF2gFullQYDAda3HP0YHCdM8OL43
	XQbHC5VUOJSr4NZJZBwkkYO45ZyMcWeOgsQ==
X-ME-Sender: <xms:xMpVaiQbBC-K4oMLDE4_T3CZCbXpIByCyj668pFHwqMQ93-6roa-8w>
    <xme:xMpVauymgFWkvN8mGN8Uk34iuD7848Q3C1JR4mAV-UiRm85hUu_01aPBSDbUM9o_4
    CTWmx9rl_P13NZ4EzJQOPEgtvBnkgZwpMfKaS_LW-ph-CTKY6lLuA>
X-ME-Received: <xmr:xMpVak0oOfXE5fI240X3Lrezsi42cC6UnUPBb8xS6lseFIT8yjTkZUFiedy_8K6Qqi56kXqePR_NB5cHI9JW8y3qU1di_Lm9LNRbOYKSRw>
X-ME-Proxy-Cause: dmFkZTGEJ1/ngIffSYMvIdj2AQoX+rw+liJBviAIz+kkkS2YPfbp//479VZMXmP6N3h95N
    CnZ1TllbkMHfnnqEHIDuhnB5gMiZicqyrs6idK9l4lPyK0eHFlYJVLg22jl5jqvHpaT6Gg
    Au9UYW0nsPYkhw1CZQL/eWL2oUldy9llJdlKGRty7Ufp+p4g6+pGYBGllLj0MP1R072MeW
    vQKGW9s5twHTQLVa+fiHZq27HSXfOUbpCrYT2Hd8iS5Zpj1/RDGqQejOFoktl9BoDMdY88
    BkcOCu7caiyYAWZ49KQbz9PnVvb40abu78MfIzaCy47Sm51soExrhLYo99UgIxqTmtsIV5
    FLPdFRfq47oZ4HfCvEUDy4NckbKGVORFHObgvrbFwLATFDWJvqxc+Ye4H+e4NyZVWl1pgm
    ib5cRMCcxyDmtUHawXqxSbMJ/j8EaKnsOUo+XkVs3R/4oyL/h+qrF9fenQUGr21jomPM/Z
    M+tm30+/l2JFgEmbGD54K+I50XnjuODAxOOeJFWGDMOHkgaHg3taj3af3XLxy8uWpY1ReK
    AbiQAj6SmPFVsfop7yjCEVdOwkCs3P370VTd8m3ouoTPydyYT7LKeMrtmJOa8McGDj/i1J
    x3U/ZPwwCgFQsydKzS44q6ksOpkYOLvW/qo3aVQApTKxHZYNPBuZCkfRkVQg
X-ME-Proxy: <xmx:xMpVas5kp4likOTg1GR7VxIt55EuxzOr7SD-JN-k_77wDDM2iEOgAA>
    <xmx:xMpVanU1AEAqrsJ0mYlU090gu1yTTJ-7IsqTd2UIyT_N6qkaBmFimw>
    <xmx:xMpVarAukHwuBwLv5dX7ENWqoU00VooGKC7cJTBa40VhzGZkG4cbKg>
    <xmx:xMpVam4UgcWBvRLIeNc0J2eDYhjUWujDlMiy_X-rSdlSN9tapMXdwQ>
    <xmx:xcpVavVUS6Qp7qbusYN4GJy_TL7xV6ojnwBKTKiAWSFc9qO51I3rsplx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 01:36:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc0f3fd7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jul 2026 05:36:01 +0000 (UTC)
Date: Tue, 14 Jul 2026 07:35:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] odb/source-packed: improve lookup when
 enumerating objects
Message-ID: <alXKvlzBASmRDtQr@pks.im>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-1-3710a9cc165a@pks.im>
 <alFxRvkfNgJRCQTB@com-79390>
 <alS1440iifvTvGKP@pks.im>
 <alWx1wj1bc48g11X@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alWx1wj1bc48g11X@com-79390>

On Mon, Jul 13, 2026 at 08:49:43PM -0700, Taylor Blau wrote:
> On Mon, Jul 13, 2026 at 11:54:43AM +0200, Patrick Steinhardt wrote:
> > On Fri, Jul 10, 2026 at 03:25:10PM -0700, Taylor Blau wrote:
> > > On Fri, Jul 10, 2026 at 10:48:53AM +0200, Patrick Steinhardt wrote:
> > > > Fix the issue by using `packed_object_info()` directly.
> > >
> > > What you wrote here makes sense to me insofar as I understand the
> > > pluggable ODB code.
> > >
> > > However, I am confused by the way this function is written in general.
> > > We use `bsearch_one_midx()` to locate the first possible MIDX position
> > > in which an object matching the given prefix may exist, which is
> > > sensible. However, we go from that position up to "num", where "num" is
> > > the total number of objects in the MIDX!
> > >
> > > Functionally this is not incorrect as we will happily discard objects
> > > that do not match the prefix. But it causes us to waste CPU cycles
> > > repeatedly calling `match_hash()` (at least for the first byte of the
> > > prefix) for objects that we know will match.
> >
> > That's not quite true though, as we abort iteration as soon as
> > `match_hash()` tells us that the prefix doesn't match anymore.
> 
> Right, we neither iterate through more objects than necessary once we
> know that `match_hash()` will stop returning true, nor do we emit
> objects that don't actually match the prefix.
> 
> What I was trying to say above is that in the special case where our
> prefix is a single byte long, we don't have to call `match_hash()` at
> *all*, since we can enumerate just the portion of the fanout for that
> specific byte, and we know that all such entries will match.

Oh, now that's what you're getting at. I don't think that this case ever
happens at all right now. I think the shortest prefix that we're ever
using should be at least 2 bytes, as we don't treat anything shorter
than 4 hex characters as an abbreviated object ID.

Thanks for clarifying!

Patrick
