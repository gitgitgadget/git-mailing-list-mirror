Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038CD3E4C7A
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103387; cv=none; b=RCv2THsGx+8OLtlO3mrIhC6wW+RS7kvk3w4Gr0rgMpXsW2HXWnrOlTe/JnigtYjcnalpw2TwQEiWKgLVS9UB+XyczTmQBPTH3GYy27dBDIQ/0ivU8glxpTldHSHjpJAcudhDVBdLeIljqR6Wwt5WhA1K4NubarJJfPm7hNJJWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103387; c=relaxed/simple;
	bh=zZKfAeZdvawpvVdPSQj4hCGiBcvU+O51LzFUFGITTew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaZkYdooPGRx04RWHQ1H13DJ2r/go8BCz+hoNBD4vxqNBKVpPdMekuzExcFzQTYzZRrT7lrpJJUnqsrsGd7hYrV2lF2kvjXZWQd8DHO9qz4GM9JxD2WFa0ZtE+T9c52M6eLXnnGnGxe7JLy3gqt9dutTBggZYzFUXyCXX8h5jBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aaKRk3a/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rKw1GYh8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aaKRk3a/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rKw1GYh8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DE20140014F;
	Fri, 11 Sep 2026 01:09:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 01:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789103382; x=1789189782; bh=0BxkzDdScf
	JDe8sZOfgLkTRKAbuZfxFcokMsRU2jc1k=; b=aaKRk3a/G8f2Kmd8mYrgOL/GTl
	nCSGW1S1EHV4SktSs2Fc79+wZ2jLWA5faYTIJhZ/85YV5xsbotZ8meeKhDTnxRdD
	HQv/aTDxfxPVyjkBYJIwJNuEvNCsaT6W1B0Rakuc5iz2IWkmNQc5hejbpaYGcuw4
	ZUJoULnTD4WRQ2Su7tc4cV8iRk2o0t+5jd16LxYIH7QUMuYdnecMfaKZonSw13yl
	/Pyx/bNSALCjile/GQ5Id9UR3Om70TkTEwJ8Ivzg9s+/wmRm+E4vTK04VMro68UP
	yvUNQi3GdPRYSZfk/ygwFmzPnL7fEknEqE+9cj/KmjbMCvMFXaVx77VOvygQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789103382; x=1789189782; bh=0BxkzDdScfJDe8sZOfgLkTRKAbuZfxFcokM
	sRU2jc1k=; b=rKw1GYh8LW+hWeJ1pZzPAymtvUo8pAffyjzvpsPvPYiSSvtwm0e
	7iAofE8dmsR3ViTqTZfS3AI3Bxq1ABLnr0DakyjjuY6LeABFYGPZ/rtbFuG2cKpV
	xNeTxT7N8YqeW4P2F8GocNTEz6gKmAfJKFAO1qyh0jzTOJ7/2pAfFRdpujnjO8XG
	wiiFCSRCDxIPqiIbQ5rO2hGVv7qIxLkdelRkCLx6iPh4xpGFftiFuweCcjkMeCO8
	WX8ZWtZhQ6Ll3ummzWRl7nPE7KoKWtw4O2jF8zm6UyA0dGodFdEqowpUvsSTQeez
	zbQ6XetCkwtVBqIyArozY+nwP1/X9oRLBOA==
X-ME-Sender: <xms:Fo2javVR6dc3nTUUL-0UIm3csLqBZPLbdE-kneM9WAexs1wfi8YLRw>
    <xme:Fo2javD6p0MslgC4i-vZjwWdFSPhyVPYKQ7NqEjKDtjuyv6flwj8Vw0mNa2RuEmoZ
    9RSpbpVYc3EC1SNknJGZRP12UI7y4fpRznl67qthc-nEM4swxoFSQ>
X-ME-Received: <xmr:Fo2jaoyAt2O9oOgvHdivOjobvzEQ8uOUyMcOinwYCIueehvSBSd7MBaUvRum1mLAcBYHwQ>
X-ME-Proxy-Cause: dmFkZTGdWL/qErXI4Nuxe5aNcJ8ts/3CyBIf0PxGnFuM6qkRk/uPlpA+E3ZIjFZyDJtXzh
    sMWxSVwF1bhqIaFuf4SyJ5Pzh40bxekYPem8+Bj/wMVdJQhMvGbH5UrnOtJ/KGspb4GGas
    x7ssOodz0drRjO0cmp1jbTWBKpew2Iw9KWEnlnGgxRqALYvb5GwAb8TE7Est9wETxsoqb+
    oKuCKVqclCKyfFFQmO4khiXeq6yXk19L5mJtTk85Lbm0XIKmOGCW2IoECZapbaw8kdXepJ
    J9yP+dx0TqUetgxain6sypuQWMT5z0GF+Vz1O/8w15TL9Sug7Zn1V9DqJ2nrRH0wyEYRfF
    nSw6rtALrLL+nQOHpYiFGEVxsq4Agji22VhYae1rMVfSpVLpbu9bNM4VUhFcOetKVFUfSj
    zCOPKzlfN4VJ9/KRUDTBGQEI/qM16ZQgTl1vkNq/2jr8pNE/0mIb9NEWKi5XnwcBtWCEgA
    LO/5ebyZIJKGf/hEaFg4V7wtmzXYInAngbzaf+w8Frfet2qhMX4ZhNoh4V8hOuw+716BmI
    I6NXMjNdytavEPOsolNfCFCPagUpiQCR+bkzm3MyZfHB9hGRuzfJJUoH8XL+Fy/99yluJT
    6J67Yrl70hKKHaGV6AxP7QevYk25opHGcBHwn2tCWN0H/NQHaYUuRUT/iznA
X-ME-Proxy: <xmx:Fo2jakAHeiQ5xO0_iQHjCSKpM2YizSlovXwADEKMpEfSkKc8vGmEtA>
    <xmx:Fo2jatYR2sMF8xdIYQ4RVUvH5HqBecozCQhF_SZxq8xDeBdrTQKUsw>
    <xmx:Fo2jakhduV-LWRQclV0nQfZrBmTf6HErt248-E23QMiI9yEEcb-EIQ>
    <xmx:Fo2jan5x7icYYYU72fvG2C4kyOWGjvj8craz0Eckv1-tOOp9yPPR8Q>
    <xmx:Fo2jaomhL7tom61MhoG3NRF9y-zWROrGc2BfuY3xvFN-wkaX5yDPB77J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:09:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6ce31b65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:09:38 +0000 (UTC)
Date: Fri, 11 Sep 2026 07:09:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] ci: bump debian-11 job to debian-12
Message-ID: <aqOND8cPTRtV1Io8@pks.im>
References: <20260905135822.GA3914811@coredump.intra.peff.net>
 <ap5Ttt-2NmM5dRZl@pks.im>
 <20260911021933.GA948291@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911021933.GA948291@coredump.intra.peff.net>

On Thu, Sep 10, 2026 at 10:19:33PM -0400, Jeff King wrote:
> On Mon, Sep 07, 2026 at 08:03:34AM +0200, Patrick Steinhardt wrote:
> 
> > > +      # Supported until 2028-06-30.
> > > +      - jobname: debian-12
> > > +        image: debian:12
> > >    artifacts:
> > >      paths:
> > >        - t/failed-test-artifacts
> > 
> > The changes look good, but I wonder whether we want to swap to the
> > "oldstable" tag instead. That points to debian-12, too, and might result
> > in less churn going forward.
> 
> I was all ready to agree and propose a patch, but I think it might be
> more complicated. The "old" flags flip when a new stable version is
> released, but what we really care about is things leaving LTS. And the
> two are not really aligned.
> 
> So if we wanted the oldest supported Debian release, that would have
> been "oldoldstable" (debian-11) until August 31st of this year. But
> after that, we want "oldstable" (debian-12), which is now the oldest
> thing under LTS. And that will be true until probably next summer, when
> debian-14 is released, at which point we'd want to stay on it by
> switching to "oldoldstable" again for another year.
> 
> The offset comes from the fact that Debian releases approximately every
> 2 years, but with a 5-year LTS, and they never align.
> 
> If we track oldstable, then every other year we're not using the oldest
> supported release (because the prior release is still in LTS). Or we
> track oldoldstable, which means every other year we're using a release
> that's no longer supported. Or we flip-flop between them once a year,
> when oldoldstable goes out of support.
> 
> Which makes me inclined to just keep the current scheme: use the numeric
> codes and just bump them every 2 years or so when they go out of
> support. And we can even put it off until the out-of-support release
> starts causing problems like it did here.

Sounds good, let's stick with the current patch then. Thanks!

Patrick
