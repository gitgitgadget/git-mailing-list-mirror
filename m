Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF72499F12
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594096; cv=none; b=gSQpABWF76v7wW7dvPQdjU0Eu4KUc9h8+LPPcdgaWlWX+F17xm4woFcMSlCUnS8//LKZuWoRnbuFb1quB12nRdpqOup/vQDQynaeZg3LiEZDwG2GoST01uNblYr6eRgq65Cz6J3jXtZnmW+WazB0IZbgP8eIwf6tKK+D/JsAgpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594096; c=relaxed/simple;
	bh=rLi4B6HanuXIatt1pAOTXNQBMhrJ3gOpxDGXb92Hg1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5P28eT07mgwMd0FTAD0ejelRBU2xXVa5DKI23oX6PZXYtwPdqV/8AQ74B5CMinEvtUtzfWIHcGNd/QEI4ZRiImO2VpDOjatkvvA7q/UXqYzH21MINh3wPHV3Au+Mq6lMKkbth1KU0qtqrme1UV5z9WlHhGmfDJ2crv1EX9uKUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VkcMBwYT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iGU3Kwmr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VkcMBwYT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iGU3Kwmr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A2E91400105;
	Mon, 28 Sep 2026 07:14:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 07:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790594093;
	 x=1790680493; bh=U8J5B8eyjsFIg4EoKhDQWzVakgaxW081kyC3UjnuOyg=; b=
	VkcMBwYTRY5Aaff3lputcbE4YLoCe0fpG7XtpdDKpA6iLt/o5TAzr0wRalyTThgj
	eXGZaaKem4YVQHXkus2sJuLMbKYFOzSnXYn4uSNPwFHjgk471NP/jvWRbEXG5mHt
	e7XAwiG+wzRDnA0HqlBxA9WMFxAYjhOMKyZhWzx+OGxh1DgMHt41CErYhc17cyWR
	i6FAQ7UK7pnI653O2OlsvPIhyQZof5iCLI4ZbUeMLQrYdZNYO3E75VnLTOeg1Ns5
	V7byyRE0CPYAymdNDN8b3vXvQy22bCbIczEtsWOuh10lndiHuY2gmQ+R3//Q+lza
	ytE6YTmlxXU2JBaZpZ3//Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790594093; x=
	1790680493; bh=U8J5B8eyjsFIg4EoKhDQWzVakgaxW081kyC3UjnuOyg=; b=i
	GU3Kwmrfd5YcoKiTI8ENonjozZRS+5JmUVhuoO5s+o1DzJkMM3xYzG46eMd50pW7
	s4JwVufmKTNmXdb76nQBT56+i/btbX3NYY1jqSXSHBYHKnaEAq/bGWScq3hS/4i5
	SA65mFZkc3fTJqCFTYm9oVDXWVUbXV/Y6stagaBPZqy2VrJqqXMGlCIyJ2/LYim1
	yveHdYCbPPtmH7hfi3vwx+AR+CqwG8tH6jzkVlqGsYR+PQJzYMhtOJg9i/mwHsyO
	R0QcltWMFyOZE1iyp141xA0S8aE2AqA97bxI1i9qCRDkFqYSMHG0J1Nwa9VBaSXU
	Y5dWM1dIRr8OqjiY8ew4A==
X-ME-Sender: <xms:LUy6au1jfThz7FGQYvyGym55zsC4c33osbHj4ZsxAjgJ0CeVlZXIHQ>
    <xme:LUy6aoE61bx8hzuEJ_f0UWQCpLa-rtKBkYkVybrP4v_0x8MWFnC4PvvoeM2oXmOef
    JH6VxbJjIqOGZw0BgvvT6i7vvgBjVyH2ksHpNmZtK7o3YqT6Y--4As>
X-ME-Received: <xmr:LUy6ar7cLzT3bIdPAF0yRb0tNtZppT0DC3vxfadF8yazkyLUqBWiDg>
X-ME-Proxy-Cause: dmFkZTFXWEC5PtFw08vxeyJjVjBqWlcqlqnAyAJrU9clNx/8YvKTEquAD1nyMctuH58aR+
    ojY5vUoGr7Q4K7thxtnnKfCWxgdtvOtpR64jlFRnUFXLodY4SPL9FRo0VyTxa5xegeIL/v
    EBUj07rRZcxjpXH7RGt6GZwfZFZEpJImcs54xmA8xiXCG3n/CiBFBanoLW+LLwJCSaaY+A
    UlkZ3VU+oZwzdaAXsIYNiD+dvl4V1CUsvgxLzMgX0LFEZYs76ijCd3l7ewluYNOF0AyQCI
    mG2UuWgEUfK4A0ICEKNZxhMqwBMHnDDLzL4zyZodV5Q20aWNswQMS3nBG1h9oXXwThjPU5
    aVDzOaw4USJ2LsC6+hhkJTR0azy8Q6H0umK0P+cpA7SL7dwre3kaBTD6Sx5OlxLWYkaMsn
    JCg1y6t2/AXyfintPb14TKi7k/jabROH7YXLDmnSd/rRzBDmjHR0fILnBsUEnOARq5BvU6
    Dxy0peID3RNeF6bf13DIOF7wLtPN8jRaDenK8+Z4RppTlgksYK0Y1o5xisUf87LdoLYzFt
    qSr9BvGCHDBWH+Ryr+mynQa2GBdzNWEbtsTYHOHMXRm0MQLuQb3qCfW97ivWAbzOkvif9S
    YCoMIZ9cOFoexLVnLfpqoas+W0xJBxvSG4wv2GxCYBHPlc5hEF0Ybaobqsmg
X-ME-Proxy: <xmx:LUy6auu--1R3TwWZA8u6BMaE_rk8f4d41Vx9aQs501k2SAYSc96qWQ>
    <xmx:LUy6as6hnNQFWMFrkMqnc3xx0kbVOzEa0sAk7rt7N53Z2KRgS1D-Pw>
    <xmx:LUy6apVGjlz_k3OXqOBj9E5FEo1u3fmT3D3GPpjhvCOERqwoCwUXEw>
    <xmx:LUy6au_-RAuoEaIaEnqOAWsS-7skgDybjIFos6aHqsulBM3j8P_y5A>
    <xmx:LUy6aj1nPuS_NRmbdTFLIeVp3jmcVcCaabkweXxKZq5yJwYGpeyAkgK1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 07:14:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ebe383d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 11:14:50 +0000 (UTC)
Date: Mon, 28 Sep 2026 13:14:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] ci: align job counts across CI providers
Message-ID: <arpMJ4EBomeSF6LS@pks.im>
References: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
 <20260925-ci-large-test-resources-v2-2-f632cf319756@gmail.com>
 <aroK7KcRabARSqd8@pks.im>
 <CAJ-ks9mWU2cFWLfioSSM_6Ct1ydtxn3i4Dh-L537M5EDiMW3vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mWU2cFWLfioSSM_6Ct1ydtxn3i4Dh-L537M5EDiMW3vQ@mail.gmail.com>

On Mon, Sep 28, 2026 at 06:16:33AM -0400, Tamir Duberstein wrote:
> On Mon, Sep 28, 2026 at 2:36 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Fri, Sep 25, 2026 at 12:35:39PM -0400, Tamir Duberstein wrote:
> > > GitHub Actions sets JOBS to ten regardless of runner size, while
> > > GitLab CI uses the detected CPU count. Use the CPU count for Make and
> > > prove on both providers, selecting JOBS after the operating system
> > > is identified.
> >
> > Again, it should be noted here what the effect of this is. In other
> > words, does GitHub slow down as a result? You already showed numbers
> > during the discussion on v1 of this series, and these numbers should
> > probably be included in this message, too.
> 
> Agreed, but in this case there was no reliable performance change
> across 10 runs; I could include that.

I think it should be included, as it's the one thing that people will be
wondering about when they see this change.

Patrick
