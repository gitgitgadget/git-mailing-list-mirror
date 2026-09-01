Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8985047B42F
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259284; cv=none; b=MDC0not6wQ4dlYm2pcHcGnmeCDg29y/uxfYeYqQO7WN3bq+Bc3eeK+eiAJA+YbxBSSDhhfkeoYtd0DS1KtoeFUSn2ljV73zpqhCyVnE6Ety/v1syTGf4AkWAQ2lbqq+f9mgrEfmGwOzRNBfoMpgGOkSTn5kCx86NrDb1psBAMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259284; c=relaxed/simple;
	bh=MuO5+Xax9v3lWiuiyKmxmRwhS/8uPx+iRrPaiqUp/Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nl5KA0YvuMxIj8w00hnyVIMTESL53TIPwvTV6KAFYzb8WcRgPB+EDeZ2ZXq2m4H6AboZK5cQwwxrbblmBhu6G3yxmWFmiTbNqAmHID6fm3uh0EkHht6JzixtGCZKR8CuLlAlCdpoUqhyHQRCMQUs5uJ+xHCtwqwUOEe5N8tz8A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U/lhi5ye; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wy6T5Kkh; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U/lhi5ye";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wy6T5Kkh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E262EC022E;
	Tue,  1 Sep 2026 06:41:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 01 Sep 2026 06:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788259281; x=1788345681; bh=oVtSJ5KgOO
	31UByoQIqS/juBAjJ9o6YwihsD+W9aN/M=; b=U/lhi5ye6aIHaMrrxSxGmVOFb0
	iPmVLoXkC0MZrMx5z6iHNdffWYJaZ72uW/R3SHxcBHr0cOIxdya7SDWCHLCOmywK
	GVCM37ql+rYVd9/+ms27oIFx6wRsNtHUmZQMPu7KtbE668+84X2m1g16H2TLRlTV
	nISnZFfZ2Ka8BOcN8MoZcxShkPwgOQWXmJyz8xhO+aqVLu/HN6fzPY7jk3lkQWHl
	pNpCI844QjGIsUksQF5XC5zqo6ebiANxMHZjLpGCNUyIiPwSvMLzWUknd3R8zkVM
	XB3UPHU5+cd76WFlkLptnanHCER/CsnXaYZxGQy/Xp5WFN5Ph3/fgQs55oVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788259281; x=1788345681; bh=oVtSJ5KgOO31UByoQIqS/juBAjJ9o6Ywihs
	D+W9aN/M=; b=Wy6T5KkhhfzMox9oR7kTNCB8qwq/2nzpLyTp1/YkL0iHXWClcra
	dmXVXx4mV03R2d5TXX6St/otUTjqzJHAvEAGSZTqMjtdMmDO4ew0LqdY8+lJjfnA
	AAWax/emTHj0YzNvjXbqXmM6wixQ34WnBPf9iseKp/hhITMnbBRM72XES9F/pD2Z
	aZBsGuGEO/wGghjIDDXJPmA+/OvmXqZ5o7853AMZISjtWYS+TwdnOZ4jA+E6Wp5o
	vrketXBSKjMIVqxzQHNs8obcjLrK7zz9HHsshCJOax1y8wqq0Ac0K1kxi7JkI9B+
	yn94273k1mNJQR5COwDSwG90hBuXmF1tTNQ==
X-ME-Sender: <xms:0auWajxAz7wJS8RCpXozgxQD0BIum56kBOMD7fTk5uSFW-FKLVgB0Q>
    <xme:0auWahTh169dawowQPxk-spUvk8jMXYnuFTfv6AJq0hwF2bQxEHlWCmsw5wsNkQz5
    sEU0X4Fs5jx5gw0CpWFzoZ9EXfCXPWKaALumnX9fguRsA8HIA3VHQ>
X-ME-Received: <xmr:0auWaq_D291SsMow1wS8EPg5_taJdrEj82Uh73B57b4XhYJGYtBV9w>
X-ME-Proxy-Cause: dmFkZTEqrbCXXnw3hQP61GxCB2Rwq2KiCaLxp2s1NJpX7fsyOdBEh7aoNHnrBXRujrfJ7g
    8Sbvd+IeTESWzkyxNoNSJOgfrc9iFd3HZ9OXMbF2fx3he4WJ77tn03+vMQUJPdwb8e1CFN
    pWUU0YK8ZTdXAckC5iCoaXwD7jxFe6jVfv+bOdAjDByC73sspMj66ceys2lQFAEaY2O2sF
    mQPzpuH9E4YV5FJloYIARq1oMR+/C1SNdSU4RM9UZM7TwVj+rDCGY4AgcCdn5uW/Y3xUec
    DvKpIGsDDJ5FWFrGxiwAgUPDb03Cb9VgLEJFpUANEC+Y4GhWGis1hGL/2uYRsBro1YOSTm
    laBw9xsd/biId1K6A/JQZy5BfFKkvZM2P4lXA/w9Q4SAMOUjISvinEc7ZR0Csl/U761LYy
    sdUaJlTVhcFEaeAe1PaYod7i82gP3R6XNDQ6FQG8TWvw+yjxLmvGnhM7GGfh6fB3DY8iuH
    MVc88AEZilocsRjq1qNVplvqULrwjvUBfVYwu9yWlNU4A0oIAkSqty4c7IIyKesgPlATy0
    LIpNfe3b65vwavWgZzk75gz/brkq5HIdssugr8kNoZfC3oKgjcFY960RAcBkq9HOPVSJww
    B/e0oAuE1EzaXF/L2/j0MHcwWcECaECOJOMmxxW7Y+1XECmQp1mkMtcFhxEA
X-ME-Proxy: <xmx:0auWaorUjzeo6L_AW6elcn0kESGcqodOhZ30PhYQXITeprrcxcSFmg>
    <xmx:0auWann4L2Y6Wc-9F0uwO2_-s3o-BNl6e1_ybPD7l7CGv5y1WAzHeg>
    <xmx:0auWavJszTYs-CrNoQSmkz2bPcguRadUU9eoeRsYd0lc1ZRhD-MBXA>
    <xmx:0auWasyBBQzTDPWSC4OHXCJPniVYYFgZ1O150kgybWrKufcalVElGA>
    <xmx:0auWagS7d8hQUihB273lJHhlcu3Wxy_UNA7doz-0ctfWtTAOoQzsHY6I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 06:41:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id baad186e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Sep 2026 10:41:27 +0000 (UTC)
Date: Tue, 1 Sep 2026 12:41:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: fix missing Ruby dependency in "documentation" job
Message-ID: <aparyEbGiiFZpiCZ@pks.im>
References: <20260901-b4-pks-ci-fix-documentation-job-v1-1-a8257ee2a9a4@pks.im>
 <20260901084737.GA2973751@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901084737.GA2973751@coredump.intra.peff.net>

On Tue, Sep 01, 2026 at 04:47:37AM -0400, Jeff King wrote:
> On Tue, Sep 01, 2026 at 10:16:11AM +0200, Patrick Steinhardt wrote:
> 
> > Our "documentation" job has recently stopped working with the following
> > error:
> > 
> >   + sudo gem install --version 1.5.8 asciidoctor
> >   + gem install --version 1.5.8 asciidoctor
> >   ./ci/install-dependencies.sh: 23: gem: not found
> 
> Not directly related to your patch but... asciidoctor 1.5.8, really?
> That version is 8 years old. Looks like we set that version in
> 615a6c37e1 (ci: stick with Asciidoctor v1.5.8 for now, 2019-03-29)
> due to some issues with the then-new-ish v2.0.0.
> 
> But these days I'd guess everybody is using v2.0.x (which seems to work
> fine) for local builds. We probably ought to do the same in CI. If we
> have to catch issues in one, I'd rather it be the one people are likely
> to actually use.

> It's possible that we could benefit from building with both in order to
> support the older version. But given its age I doubt it's worth it. We
> can still take bug fixes if somebody finds a problem, but we don't
> necessarily need to spend cycles building every commit with 1.5.8.

I was wondering about whether I should bump its version while at it. In
fact, we could just install it from the Ubuntu sources nowadays, too. I
ultimately decided to not do that though and just fix the failing CI
pipeline for now, but I agree that it's something we might want to
follow up on.

Patrick
