Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1970E13FEE
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 03:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566371; cv=none; b=rFVqD7I1xg4ywL4j8OGsvw+QlrwllNzMxDmHPM+oPS87LdxwKdOITYuNNiTnV7S3j7isx++Hu7TOONi8XrQDeF+nbPR5kUT5dNztUpOAdJSFrNNcvGobrGcxXfv6nHNsab/e/po5nzULPsr9XZBOmqDf63ThGfOnzOM8DK9SXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566371; c=relaxed/simple;
	bh=VRlHAa9ZtA4UnsV3VOQXnsOoZkc3RNNBxjfVN0b5o4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEF7xVGPjJs/+HluRrdpOJp/jpMJeCOwWfqwUrLWXT66ZIqzJrWmrN5XPC4bIGxUhjGJpJ56GPbHpAS3NSkkDLSHbzzHj1SFv+od1hntLbAYi3Wy0c5Qw4d9cb9rJyBx9fAymKz7wftYrKFJxz8hCiQYG/nc4P/7FTtKhcJqRJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Q6iSNEVp; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Q6iSNEVp"
Received: (qmail 63706 invoked by uid 106); 28 Sep 2026 03:32:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VRlHAa9ZtA4UnsV3VOQXnsOoZkc3RNNBxjfVN0b5o4k=; b=Q6iSNEVpkU+8R/jVEfpH39BCcLjjWAovQbT+LOxMZmD7EIzvyHfztlLa59uYPriYxDvZg23az9oTKsxRcNuiyLGC0gVMFG2yXXO6RtGnVNmPP6yHD0cSdgrg05gzJIlCEH4K4FwdLAkPtdesPviO2twC6Q8jgXsL/1s3oiHSImWcYLs6G7+oZhXDSWBhta6+tOL2uOtWw53ph8Fp0rmvix4vX6TNcqB3H+f42hgTmIKDknVGqv5AaPVaByatPQ77yvzEstpQQ/304oHGHO/NJEPe3crAmAG5n9EHXgs3jzSi/G01D53nYXTwq3k8TgGmdpOe7kbFd+TUppFRreOo+g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Sep 2026 03:32:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 237819 invoked by uid 111); 28 Sep 2026 03:32:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2026 23:32:48 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 27 Sep 2026 23:32:47 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>,
	Harald Nordgren <haraldnordgren@gmail.com>, ps@pks.im,
	git@vger.kernel.org, sandals@crustytoothpaste.net,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Changing default config values (was Re: What will come after Git
 2.56?)
Message-ID: <20260928033247.GB493672@coredump.intra.peff.net>
References: <ap50kgyenpRrsqln@pks.im>
 <20260924183523.53201-1-haraldnordgren@gmail.com>
 <xmqqpky21mh6.fsf@gitster.g>
 <7ccc822a-6bd0-44e2-8d6b-ca525d729207@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ccc822a-6bd0-44e2-8d6b-ca525d729207@gmail.com>

On Sun, Sep 27, 2026 at 02:48:31PM +0100, Phillip Wood wrote:

> One way we could change the default values of a set of config variables is
> to have a config variable, say "core.defaults", that determines the default
> values of the config variables we'd like to change. That would allow us to
> have a set of "modern defaults" that can evolve over time and can be easily
> enabled or disabled (a bit like "feature.experimental"). We may want to
> extend the concept slightly so that different values for "core.defaults"
> tune the defaults for different workflows; for example having a setting that
> implies "push.default=current" and "status.compareBranches=@{upstream}
> @{push}" for triangular workflows. If we take the approach suggested above,
> the modern defaults could be enabled by default and it would be easy for
> users to opt-out by setting a single config variable.

I dunno. There can be some convenience in setting foo.bar that covers a
bunch of other related config options. And I'd have no objection to
feature.triangular or something that changes the fallback defaults for a
few relevant options (which could of course still be individually
overridden).

But I'm not sure what core.defaults is buying us. If I understand,
you're thinking that setting core.defaults to "modern" would give new
values for a bunch of defaults. But why wouldn't we just switch the
defaults? I can think of two reasons:

  1. It might break scripts or other automated flows. But then, so would
     config.defaults=modern (or using the individual config options
     themselves).

  2. It might anger old-timers who like the current defaults. But why
     not just switch the defaults, and let the old-timers use the
     existing config to escape-hatch back? If there's not consensus over
     the defaults, _somebody_ is going to be annoyed by whatever we
     pick.

     It's probably reasonable to pick the one that annoys the fewest
     people, though I think we instead tend to go with status quo
     inertia. Which, to be fair, is not entirely unreasonable simply
     because we don't actually _know_ what will annoy the fewest people.
     So changing nothing is often a safe guess.

-Peff
