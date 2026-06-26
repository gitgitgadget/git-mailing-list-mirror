Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456E1714AA
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451021; cv=none; b=vEkv6nmQN2Z/rZipWuFq5n51GL7S9bBa49CF3sgeW7Wg8FbffACA+u+ZU/FuLHE+jZJRL5Ws+6P4O0BIu4K7UpSzyPadmxxUC/oCJKWwSCadBz3gZ1uosvXdVCE3ZxFz0UTExcHz8KVzX0yeTEzBOaVJS3vGxYzsyxhhGKK6X0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451021; c=relaxed/simple;
	bh=chTs++0f7FMNnk3ZNLRbxEgKnElNI21ZpOeX1X45wyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdIEgEEFx29h2vlSP+Gai/mHl5RCgNAx+RKxRjEIubRmHy7Pf30X3a1qPcXCdCj1peoqHwSN0YlpOZJjnaVWJmvQ94RamtUB78D1nmxytb2iuKw1FZYtIomsrHHXcfVyucK7eAo/JB/sB/2pXAyVldExCXUXR+hCiJgg681MQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OwmpqcMi; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OwmpqcMi"
Received: (qmail 37342 invoked by uid 106); 26 Jun 2026 05:16:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=chTs++0f7FMNnk3ZNLRbxEgKnElNI21ZpOeX1X45wyk=; b=OwmpqcMigqZFgl8mfUajDr8F8v8ENdwqtxS4qSuy9JmcdVSB8ixhTnWGruU7MBEeSUSUqZ2FwzgCSAQXsF39qX2ETxNPonV/Doqdq7i1NdQiQy0ebvIei6oGkmrqANX4M3Ny+eX0Gn8WM847E7VwZAl2cni2GtCriB6dO1rJunmy6RY+3H02fKTCDV8mxBh/NJrU+m73TsyIPn4o16ddx8wmn31vK5jPYEQdULEuCDOuGd4Px0lUpdX8k4xuaTtceP6VlLFJX4NDVJT/Z0cJPVhP6qS/elrlcetz3XyopLFu8TCDphDG7wt2zKyAHXPwYhkovv5vfeenNhoHqpw8Vg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Jun 2026 05:16:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 78100 invoked by uid 111); 26 Jun 2026 05:16:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jun 2026 01:16:58 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 26 Jun 2026 01:16:57 -0400
From: Jeff King <peff@peff.net>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
Message-ID: <20260626051657.GB3138423@coredump.intra.peff.net>
References: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
 <20260621213407.GC2297179@coredump.intra.peff.net>
 <aji9MOE-NTHKXYqn@pks.im>
 <ajkEzhdqzmAePk_P@pks.im>
 <ajkGkB2ckf3p43QR@pks.im>
 <ajkOoRhqaAcy6gBg@pks.im>
 <CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>

On Thu, Jun 25, 2026 at 08:27:35PM -0700, Michael Montalbo wrote:

> I think that is the trigger for issues we've been seeing. I spent
> some time investigating the Apache side over the last week and maybe
> found a mod_http2 bug, which I filed upstream with a potential fix:
> 
>   bug:  https://bz.apache.org/bugzilla/show_bug.cgi?id=70131
>   fix:  https://github.com/mmontalbo/httpd/pull/2

Thanks both of you for digging into this. I'm not familiar enough with
Apache's code to pass confident judgement, but your findings certainly
convinced me that this is just an apache bug.

> Given there could be a potential reliability issue with an upstream
> dependency like Apache, I was considering what mitigation strategies
> might help:
> [...]

Depending on how widespread the Apache bug is, another option might just
be: do nothing and wait for it to get fixed.

Trying to make the wedged state fail fast and loudly is mostly just
punting on the problem. We'd still see spurious failures. We've so far
resisted the urge to do any automatic flaky-test retries, preferring
instead to just try to root out the flakes. I'm a little hesitant to
start now, because I think our strategy has mostly been good so far, and
I've seen some horrible counter-examples where flakes and retries become
a routine drag on development (and I'm afraid that accommodating flakes
might make them more common).

>   - Make slow tests faster by optimizing the test itself and/or
>     the test runner configuration (e.g., job number matching
>     cores) so wedges become less likely.

It sounds like the bad state is triggered when Apache hits a timeout,
and we hit that timeout because the system is slow or busy. We could try
to make things less slow, but would it work equally well to increase
that timeout?

-Peff
