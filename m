Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE83497B87
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275426; cv=none; b=OGlNJDUjeBn+ybNCvd3UGMC1ENWaDO72iFAot2B8efKvX/2Ai9xG4jUejtEsOURvQA3Fq8KAgY/4wv7P+6A/R2q0h0NwaHZ2GIcfPfuPrh3Yq/pbvzH+Kb8J6dmiU/5FvIofmnULe/155F0xw9s3b3sHWFx/62vLJBdMkypJQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275426; c=relaxed/simple;
	bh=tu0nOUA3qRIKpedrxj9UjLHN0xjnJ3YVh5zrhkz/L8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqXr0bCG+tE//+nwcZVJRk0lS5Z7Qh8S+YKTKlfpQbDDMdbUdXbPdeLrLzB0/cyRzliIDO6MgOwhskLwWoIC1XOuw/2Vpog5r6xAsPb61r2s3GoSis+edooUCDcuoCgvH/k9PYlR1C2BhHz7bZ1aAwr4WpircZxxKmJwrTJNlcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Nz0I6eQM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Nz0I6eQM"
Received: (qmail 48638 invoked by uid 106); 24 Sep 2026 18:43:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tu0nOUA3qRIKpedrxj9UjLHN0xjnJ3YVh5zrhkz/L8E=; b=Nz0I6eQMJ7SmoKpKJVG5Q4WZHfXJPCOHbjDWhyp3lRloFYnNYlGo7BPIYo/T53PfnlnayrD7fMKc7nFZKHbhRCgHENZED3Ltl7gikeniz0sd18FfRGAOQQiCBaEvTP5e3kAO8pfVQubG6ZpP1hCo3fN/8jFZ+8X7aU0Y5Wmbs7frXuf5PHj1JhomyA3mKfZgNNcKmVeSHrKF1PhH0UrXazdfvghqgKr1Gub+caCmIP/dTzrDmmpmqKlsvZmQurFQtn32FuxFCQ9YeDSD+EqTTiLcmJNtmvG/mNVHX6Yq/XL7NOqo8fOPT5rniLD1fsZupI0kKXnblptRI1hKZQckhA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2026 18:43:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 195217 invoked by uid 111); 24 Sep 2026 18:43:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2026 14:43:32 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 24 Sep 2026 14:43:31 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
	git@vger.kernel.org, r.norouzi@proton.me
Subject: Re: [PATCH v2] reflog: fix default expiry periods
Message-ID: <20260924184331.GB747880@coredump.intra.peff.net>
References: <20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
 <20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
 <xmqqpky3ahvo.fsf@gitster.g>
 <arUvtE67n5_MFM4C@pks.im>
 <20260924154659.GA736248@coredump.intra.peff.net>
 <xmqqecei35n2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqecei35n2.fsf@gitster.g>

On Thu, Sep 24, 2026 at 10:45:21AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Sep 24, 2026 at 04:12:04PM +0200, Patrick Steinhardt wrote:
> >
> >> > >  #define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
> >> > > -	.default_expire_total = now - 30 * 24 * 3600, \
> >> > > -	.default_expire_unreachable = now - 90 * 24 * 3600, \
> >> > > +	.default_expire_total = now - 90 * 24 * 3600, \
> >> > > +	.default_expire_unreachable = now - 30 * 24 * 3600, \
> >> > >  }
> >> > 
> >> > and the fix is very straight-forward.
> >> 
> >> Is this something that we want to fast-track for Git 2.56?
> >
> > The breakage was in v2.50.0, so it is not a new regression. OTOH it
> > seems quite obvious and low-risk. I'd be OK either way.
> 
> Yeah, I didn't know the breakage was that old.  Perhaps not many
> people are paying attention to reflog expiration?

Quite probably. The default expiration dates are somewhat arbitrary, and
the reflogs themselves are somewhat ephemeral. Probably people would
notice most on stashes, but those are also somewhat ephemeral.

-Peff
