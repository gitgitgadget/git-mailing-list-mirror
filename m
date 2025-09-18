Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615152857DE
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177118; cv=none; b=R7hOmhe4JscfM2ePkV3ddGNfQTjqz1E+EYncpBdSE81Hs4sHIXvDOW6FgXggaWsQuCwk3wQifiP2z1sGmEfvINgJlZHceH1Q2f6JsDap9medb2OObL7nXkS0cBUlp36Aw8/cyXQrCtg3EWPchEHWylpgHNlKyqv+B5/G7jtgSxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177118; c=relaxed/simple;
	bh=7sPny6+Qn09ChSRTPq+635jUQn1YNosHCaTZUlN76OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ8H6L+qMEXX8RTe+SEr9KW7V9078h+Nadn8sWFo+vGc7T6+DVrKwwmsCCXGue21Y780bjBJZ9SQA5vd3LjFynpar330DJkXaZk4D4sVzwkhZ1VpfvP+6hw/beeFWTA7pK9sE1z8GwOWL9R2pY5kg4RLB+F/Qq2gbAg3y1DX4hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=d4PzX4Li; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="d4PzX4Li"
Received: (qmail 115999 invoked by uid 109); 18 Sep 2025 06:31:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7sPny6+Qn09ChSRTPq+635jUQn1YNosHCaTZUlN76OE=; b=d4PzX4LiCNu2LIBnqVPvJQ/j2K1E+2MkXpeLN/R9tNC5t0THk7i0FbBHcVxUqORH1pBDtX68MuwZiSejBGdc9JK9RnGQzEuSvNMuWLzwdaF/Ep8yOUsT9QdBVUpO1D+An4Gatv2VsKKy8ZIKRALdVfkvU5BjFnUwbW8rRQSTPB3vL8EZC604ho0YFr9DFgK2Bs/IVVMeB/gnH65Wg1PLdF5mF8AjIhswoYmGjgRT0Xmm/F7iSYC5EFY/yPIYt+J+aJEHFTvmRFIXhkhFsBFZ77hMNFdmcpzEGcW2gDzlZvXYVftw4n6LeHQ6hVnQUDuWJdSGu925tvi1chArBi282Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Sep 2025 06:31:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 187823 invoked by uid 111); 18 Sep 2025 06:31:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Sep 2025 02:31:52 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 18 Sep 2025 02:31:52 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [Change] Git build issue on NonStop
Message-ID: <20250918063152.GA1168297@coredump.intra.peff.net>
References: <01c101dc2842$38903640$a9b0a2c0$@nexbridge.com>
 <20250918022912.GA1135133@coredump.intra.peff.net>
 <01c601dc284b$24496400$6cdc2c00$@nexbridge.com>
 <aMuankGhjxXNKErO@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMuankGhjxXNKErO@pks.im>

On Thu, Sep 18, 2025 at 07:37:34AM +0200, Patrick Steinhardt wrote:

> > >diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c index
> > >80c5359425..f408af850f 100644
> > >--- a/t/unit-tests/clar/clar.c
> > >+++ b/t/unit-tests/clar/clar.c
> > >@@ -875,8 +875,8 @@ void clar__assert_equal(
> > > 		void *p1 = va_arg(args, void *), *p2 = va_arg(args, void *);
> > > 		is_equal = (p1 == p2);
> > > 		if (!is_equal)
> > >-			p_snprintf(buf, sizeof(buf), "0x%"PRIxPTR" !=
> > >0x%"PRIxPTR,
> > >-				   (uintptr_t)p1, (uintptr_t)p2);
> > >+			p_snprintf(buf, sizeof(buf), "0x%"PRIuMAX" !=
> > >0x%"PRIuMAX,
> > >+				   (uintmax_t)p1, (uintmax_t)p2);
> > > 	}
> > > 	else {
> > > 		int i1 = va_arg(args, int), i2 = va_arg(args, int);
> > >
> > >would be sufficient.
> > 
> > Yes, it would work. uintmax_t is part of the standard set while uintptr_t is
> > considered an extension. Not my decision on this grouping. I'm setting
> > the -D in CFLAGS to see if that works, I would be fine going that way, 
> > although better would be adding it into config.uname.mak in the NONSTOP
> > section.
> 
> That should work alright, yeah. Peff, do you want to create a PR in
> https://github.com/clar-test/clar to fix this? Otherwise I can handle
> this.

I'd be happy if you take it from here. Note in what I posted above it
should probably be PRIxMAX to show hex (not "u").

-Peff
