Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CCE2AD37
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777244497; cv=none; b=sBIDteCXvOUwDwcg2RstdbPVpwx5f3DJHhSF8H9QBEtcJ+y7meEFFe9jT7Hj3hInrVGY+2iTbUaTZZpq1WRNRav8GE440FLzjs7vv9yMYGkM/kQRymSF7/P0a7EBum0O/U6P0lVZs2R0Vh7yheVhJyj8reTW/WKjKi4em5LGIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777244497; c=relaxed/simple;
	bh=H5nZCizAevwdvRD4nOlMnuwVYsuQ+zEJJdvOhPZN+II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg79jQAgSYaVap8rZ+HlgGJjPV+bYqKDzLZ53qJLSlithOpIE55hrD90T6cbPQ6oX55453CSkqALFqjGEfQr0mvhLCgnOkFFPq9NvKDXzLXeh9vjhiDmBnR2Yan4J8GCpVR5qBXxfsElEeaZY7u8MZm8wXCIHAgxGNsxNPNNtYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=c2DNUSPs; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="c2DNUSPs"
Received: (qmail 467297 invoked by uid 106); 26 Apr 2026 23:01:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=H5nZCizAevwdvRD4nOlMnuwVYsuQ+zEJJdvOhPZN+II=; b=c2DNUSPsahNS6JUBgDsiomTuyx+efJVvxkUxYvSOhV2FAoXNTDk/+LIW0ZIkKggoIIvVanMDHHpodhmuKMUPujyau7xvzwn/zj2fyvzOWdqBCgWwodNQXW4SyPyOD3c6Yk6tKPSCfkzL+WD/usUQYtme1wGFqGxTD/8jG5I561HusSyenvzgah1nHYV3r9jFslZ70XD3ixPxjzRZXQ85/tJgRyBkFbpAPCPvXRX0f2pIdUQKa5WjJzuO0jZ+P9THeSu4MxtC7gmVylzfGNrdBteUtApbB+RDPhVT7zCNVewOqO1D4qrgbvVkD80aDC9kr+W/yZ/w2NpOewxO8we+PQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Apr 2026 23:01:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1061688 invoked by uid 111); 26 Apr 2026 23:01:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Apr 2026 19:01:26 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Apr 2026 19:01:25 -0400
From: Jeff King <peff@peff.net>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, rsch@web.de,
	michael.grossfeld@amd.com
Subject: Re: [PATCH] alias: restore support for simple dotted aliases
Message-ID: <20260426230125.GA218434@coredump.intra.peff.net>
References: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
 <20260424151053.917066-1-jonatan@jontes.page>
 <xmqqpl3ovuvq.fsf@gitster.g>
 <40408c99-7e2a-4cf6-b9b2-6d0e0da3b2c5@jontes.page>
 <20260425232916.GA29816@coredump.intra.peff.net>
 <4a130a23-fa32-460b-a338-409d85d18166@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a130a23-fa32-460b-a338-409d85d18166@jontes.page>

On Sun, Apr 26, 2026 at 09:21:52PM +0200, Jonatan Holmgren wrote:

> I see the appeal of the overlapping-namespace approach for maximum compat.
> 
> My hesitation is that it introduces a config model where a single key
> (`alias.foo.bar`) no longer has a clear interpretation, but instead is
> implicitly treated as both a historical alias and structured data. That
> feels harder to reason about and document.
> 
> For the regression, I would lean toward a narrower compatibility rule:
> restore dotted aliases except where they collide with explicitly
> recognized structured keys (currently `command`). That keeps behavior
> predictable while still fixing the breakage.

Yeah, I agree with you here (and the rest of this email). My earlier
message was mostly about laying out the possible alternatives.

> One question: do we consider the historical dotted aliases something we
> want to preserve indefinitely, or just something to transition away from?
> My assumption has been that they were an accidental side-effect of the
> config parsing rather than a designed feature, but I agree they are now
> part of existing workflows and need to be handled carefully.

I think it would be OK to consider them a historical curiosity that may
eventually be removed, but without an active deprecation timeline. If
you do not need to work with older versions of Git it is already a good
idea to move to the new syntax because it prevents your alias being
caught up if further keys are added. It might be reasonable for the
documentation to note that (and of course also mention the downside,
which is that older versions of Git will not respect your alias).

We could eventually drop support, but I think it would have to be
either:

  1. In some distant version such that "pre-2.54" is considered ancient.

  2. At some version boundary where we declare a number of breaking
     changes. Git 3.0 is probably going to such a version, but I don't
     know if we have a concrete timeline (or how long we'd want a
     change to be in the "breaking changes" list in the build-up to that
     version).

There's a related question, too, about whether "alias.foo" (without
extra dots) could/should be dropped eventually. I don't see a particular
reason to do so, as the cost to carrying support is quite minimal.

-Peff
