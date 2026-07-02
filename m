Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24148125D
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986949; cv=none; b=Jm6ENPR+D2FhkYULJ9HXWRdrYd/oLfX4pBiscaUz/ZWnWTQKfZMLJV0kWXwb2hrjJ1m+9nw0L2dpxDkUDnqKNbrvPfqqF8PwvbyyfMZgb4j6nARfDbhb7Ro9Ppx7Hxq5a3gL81a1H8sWlVx/WJyZ1OStErvAR0NADCRBrxJdAp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986949; c=relaxed/simple;
	bh=FG0HrqojVSydpWzsqNmBT9z+WozET3Wffgn9gqrUFMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiX5zZ+RGr4uMTZGVmucDbfY42jTkfJcERatYVLS8lWL1eevoRDMLj7Rr8nOsSA/KY6/QEfbXLOmZlygWSgblI0XtGUGQODMwUWVuom/4AwSAV+7P4mx9Vhz0K12/wc5ZQ3Y686dmISjKUuyhw5IjKrvRj98UitQQvdW/Cwapqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z3crFU8T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OVLYxnbt; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z3crFU8T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OVLYxnbt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F72A1400100;
	Thu,  2 Jul 2026 06:09:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 02 Jul 2026 06:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1782986946; x=1783073346; bh=dUYKKzkIBl
	/plKIItrR/9B5qIyA5+FmZBvLyXJ3c2Ms=; b=Z3crFU8TJzKj6ZB5vRknysYjUG
	NfrVpKanTGCJOH0LUGgYAU1Hnd7Pe9MVMkj1LncGGVF8Wu7PUlnVZ4ZYEMz+2UII
	vphlieRBhRWtNl/K7uJ/dmMnp5JHy/EodReBHZie6VEZpNfPGH8kY2WqzQwjrxRN
	JPPlFZRXP5KqYpqZbd3ZcrojeRu27xTYF+5pHWGpRrbjS9zYp+dlrSO+4oXd30c8
	JrkI//CXQULQlfZrOUCbVqcCNXYxJiqKJuDodFFNE0NqI6ey8nOqfW8uXJdaBsFF
	MwyxcAk5EcIgXT24bB/rAL75570MwrmgSKtVE9yyLpspOVcJ0m8q1A1awgoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1782986946; x=1783073346; bh=dUYKKzkIBl/plKIItrR/9B5qIyA5+FmZBvL
	yXJ3c2Ms=; b=OVLYxnbtrRus57OkK18LO0FzQic4WlGvknDqQdHHJvOSBXH/9P/
	KZcnBYBN918IrP6wCWe2bXv+KaWjXeFmenAiNB4EjXw9+6a920X0z1ti8bAs86kU
	al1frRzpRGUp7ajWlY4zJg9muDZdstuR6NI+Xb2mvfmhFRAVfP8YWBKzfGI1uiYv
	mQKRV2kfjwGpKMK4FzqtI3cHniPp6Lg9b6DkibVzW6pUiQdc8ctN2C0cvA3X1l5w
	g53uCCg3KDU9Mq1stAeBK0CocMzzbeQirAPTppGyVRtCHFYH7CzSzWVGlmvt9EYQ
	cOrd89RH16ee6ZmdzkRipGWKnHbc7AzhN2g==
X-ME-Sender: <xms:wjhGava3UW0zm-LoYfDdCTgRrNZSD4xLs-SlRWz5Y8U9alGdWoF0nA>
    <xme:wjhGal1PrJNzF4GN3BrspBDygFH3jU8nf0898Wbdzj8DGpTXn1Xjyr4SaHTixnl0f
    x4vyAFOPc2JevN5Go-_yye0J4En7huqwRan-unBgN1QBWcJTe4Udg>
X-ME-Received: <xmr:wjhGavVg5bPi9ltB8rxwn2SufZo-Yg1YoI3SiDGRCPM_bxim1285Lqr0NsyCbHdnQsVcA_3MALzQGlOaZ9SbvZDbiPMSvSFmRZyhPE1CNi5JFA>
X-ME-Proxy-Cause: dmFkZTF0fMKTis+r4wAZiZSLHc0i1KsMmKyfrn/q5DqkfjMuLFCuY1mjIr+3yQF+oUNI78
    YEzbX7jAUl18b9GFnvC0AvCkuPsfDT3h82qxtexuhFJSfqQp4IkqgmH0P1RMLGEyCsN/D6
    d8ysbFYJY2yKwekQQstA/310MoBMLW38bCJZgCb2L40D023daybNS8aLmaO++k0EGGtNah
    9n8kdlyn0qr2JhKy99sESMFaoIfYzNf1g1jI0gAVW5acONxX3PrUeRqumeFxxQbu6QM1U1
    3oDFEdiloJnnJOfoTOH42XEUmNopXHh0ubBA6rUWTMpb3L1RvGsl4TdR8Og88SR9MQ4VD/
    gBEqI273Ih9NKUZ8ihi4IA6q44gbZyHpUGoEEVQcqKWVyuUYqT++9ybEF+K6RSZ/SPH9Qp
    pG2AwAlICmBFBxxfgE+EE1101l0w/PBn1bWULt/8406uDLRcpxdC2HsKOWZoW9xnz39aP3
    MnIVMhxQHp/c8bvohbX7afogFAvqVN23eRYg/uqAJ2u8aTCyQNmR18AsDk+FztfNCisWk1
    H35m9QSCFxpY3L6gSVWSAOFGbPZGnXWR7qW4P8OGbBIQ8bmCLAKYPxfB4fZCZTI5d8TdR1
    JZBDCmTXQBEsR1qMxoE2lf0guphMTmSh9Y9CK9kslzBmAA09eM18ge5T+06Q
X-ME-Proxy: <xmx:wjhGavXpbG5C6S3Qq3FUikUj5wp97AnSTR6gpqtUL7tTaA-D3ss9zg>
    <xmx:wjhGauc2z2wgDUqpcgssDxTEwTkIgRnr0tRlNmWVVlU3ivJwugFJ4Q>
    <xmx:wjhGaoVrE3nWZUCYj5E_I4z_34wVWVn54zwzrXSH-CtI1XmEm6SzXw>
    <xmx:wjhGandPTeIsw_tQ_AhXX_0a84hXfu_nZgarmlpiuG9R7KGjf7c5Pw>
    <xmx:wjhGaugeMNEREvFFqnWVyIgzUrL5RdrDJInY9J0lg-_V6sqRDPbjLtKu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 06:09:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed5d0c47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 10:09:02 +0000 (UTC)
Date: Thu, 2 Jul 2026 12:08:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: fix leak of rev_info in prepare_bases()
Message-ID: <akY4u02vdBkVqs7m@pks.im>
References: <20260630063944.GA3733670@coredump.intra.peff.net>
 <20260630064301.GB3733961@coredump.intra.peff.net>
 <akOZy-BygZS8fqPM@pks.im>
 <20260701081358.GB813310@coredump.intra.peff.net>
 <akTS_rPV7JaGHKRq@pks.im>
 <20260701084733.GA814472@coredump.intra.peff.net>
 <akTXYoY7mSQUM33P@pks.im>
 <20260702085821.GC481298@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702085821.GC481298@coredump.intra.peff.net>

On Thu, Jul 02, 2026 at 04:58:21AM -0400, Jeff King wrote:
> On Wed, Jul 01, 2026 at 11:01:22AM +0200, Patrick Steinhardt wrote:
> 
> > > > linux-reftable or linux-reftable-leaks? I think it would certainly make
> > > > sense to drop one of these and merge it into linux-TEST-vars. The
> > > > linux-reftable job doesn't provide any benefit over its -leak variant,
> > > > so that would be the candidate I'd personally merge.
> > > 
> > > Both. Fold linux-reftable into linux-TEST-vars, and then drop
> > > linux-reftable-leaks in favor of a new linux-TEST-vars-leaks.
> > 
> > Hm, okay. I guess that should be fine. Do we also want to do a similar
> > thing for macOS and create a macos-TEST-vars job that exercises all of
> > this?
> 
> It could be helpful if we expect the interaction of macOS and those
> test-vars to be interesting, but I'm a bit skeptical. Most of them are
> about feature selection. So I'm doubtful it would turn up anything
> useful. But who knows.
> 
> Likewise I find the dual clang/gcc jobs to be overkill. Compiling with
> both is useful, as they have different warnings. But have we ever seen a
> case where running the tests showed a different result with different
> compilers?

Not that I'd know of. As you say, I think it makes sense to use
different compilers in general. But I don't really think we need to have
this as a full "compiler x tests" matrix.

> I dunno. I guess there is an argument for CI-maximalism; as long as the
> jobs run in parallel and they're "just" CPU-minutes. But those minutes
> eventually have a cost, and I'm not sure I've gotten useful data from
> most of the jobs (i.e., failures that didn't also just happen somewhere
> else).

I'm certainly on board with reducing the test matrix a bit. I'm sure
that we can have a cleverer selection of jobs where we both have the
same test coverage as we have right now while running less jobs overall.

> Anyway, that is all a big tangent/rant. Mostly I think it would be fine
> to cannibalize linux-reftable into linux-TEST-vars if we want to get
> more coverage without increasing the CI cost.

You got to start somewhere :)

> Note that I did find some leaks that would only be hit running
> linux-sha256 with a non-standard backend like OPENSSL_SHA256=1.  But
> that is getting super specific now (even if we ran linux-sha256 with
> leak detection, would we want to do it with openssl and not the default
> backend)?
> 
> > Also, while at it... I really think that job name is just plain awful.
> > While at it, we might rename it to something more sensible like
> > "linux-changed-defaults".
> 
> Yes please. Every time I see the all-caps TEST in the middle I think I'm
> having a stroke.

Heh :P

> change-defaults is OK but not super descriptive. I might call it
> linux-exotic-flags or something. That's not descriptive either, but is a
> little more fun.

I certainly like it more than my suggestion.

Thanks!

Patrick
