Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA823E7BA9
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 02:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093177; cv=none; b=d35X/SOBL9jRZmBQ2HR9gwYIp8pjG6rXpV2my+bSEjMyR4R+OvQ/GiaWaYyFg5amqTXJyEwYUbfJbeqmZ+EYqjPJQrFfI5DdtPzyBWH3wwkMPtaJSGabkmGQ888px/HoZ+9nAthP2X6Gb4N8PUxjOt40NLz1TRIIcsIcr1uDGfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093177; c=relaxed/simple;
	bh=0izFT1QqXESsUDmutgofmC9ls98Bm+jpWzVlM65R31M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW8di+I4XWtR+fFSSkyTpf3OwRvmJGh7fpUM4aRXwk60JND57wx5BwEEupAPjgLkd1suLANuteN6ZSySd+77OBuK5g0J24O65aN2aIhTqfFZ+iM32PJ02xsdlThzmDty0CMysJYrEcR/ofN8LzQ01FkCOXQRxLhaTuBlxq2oIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KkvNf2f+; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KkvNf2f+"
Received: (qmail 33440 invoked by uid 106); 11 Sep 2026 02:19:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0izFT1QqXESsUDmutgofmC9ls98Bm+jpWzVlM65R31M=; b=KkvNf2f+q/x0HWUFRztpQ/A7eX8P9I5VJmuVgGlugtdIcTXOLn8C1s0o+GE2uCU997ulm3H1RAWpGLQ9HRtrBV+7THUST6I9eRJsm/JK6m+RLLso1C1EvNeL/VMHyGHNzFtyxnIQiCTZciM341PstpICg+66eivxCjk1Lh0A+6K6ohsT5FDQ7gUZ/SOGMizozl3dauwJWkM41RK/xYsFFhnZ63CD/6o/EVqxzMQEJJq3r86ieNqFGgtUI8gLUB3wL+4r1OyBGHh6WuPGMQYeLkE/ckVxcRNW24UtY5nGFjSGuDkOQNJUrQT9pgLORXwxXz1miyuMz2ZmvKnLbC5GnQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2026 02:19:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 165438 invoked by uid 111); 11 Sep 2026 02:19:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2026 22:19:33 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 10 Sep 2026 22:19:33 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] ci: bump debian-11 job to debian-12
Message-ID: <20260911021933.GA948291@coredump.intra.peff.net>
References: <20260905135822.GA3914811@coredump.intra.peff.net>
 <ap5Ttt-2NmM5dRZl@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ap5Ttt-2NmM5dRZl@pks.im>

On Mon, Sep 07, 2026 at 08:03:34AM +0200, Patrick Steinhardt wrote:

> > +      # Supported until 2028-06-30.
> > +      - jobname: debian-12
> > +        image: debian:12
> >    artifacts:
> >      paths:
> >        - t/failed-test-artifacts
> 
> The changes look good, but I wonder whether we want to swap to the
> "oldstable" tag instead. That points to debian-12, too, and might result
> in less churn going forward.

I was all ready to agree and propose a patch, but I think it might be
more complicated. The "old" flags flip when a new stable version is
released, but what we really care about is things leaving LTS. And the
two are not really aligned.

So if we wanted the oldest supported Debian release, that would have
been "oldoldstable" (debian-11) until August 31st of this year. But
after that, we want "oldstable" (debian-12), which is now the oldest
thing under LTS. And that will be true until probably next summer, when
debian-14 is released, at which point we'd want to stay on it by
switching to "oldoldstable" again for another year.

The offset comes from the fact that Debian releases approximately every
2 years, but with a 5-year LTS, and they never align.

If we track oldstable, then every other year we're not using the oldest
supported release (because the prior release is still in LTS). Or we
track oldoldstable, which means every other year we're using a release
that's no longer supported. Or we flip-flop between them once a year,
when oldoldstable goes out of support.

Which makes me inclined to just keep the current scheme: use the numeric
codes and just bump them every 2 years or so when they go out of
support. And we can even put it off until the out-of-support release
starts causing problems like it did here.

-Peff
