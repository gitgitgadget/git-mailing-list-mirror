Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A238207A30
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632426; cv=none; b=gxAVtHMMI1Bg7gNZJXIQ3I56420l0lYTvIbdb9PYnMWEYJq8b0LeAakDYY8Q3i2IMNbFUOHpXZ9RGXS8K2gAcKFDaVub1oNk0k59KMIISGt40kwTnZ+tPR3gg5HTwvBD866waboNzHR+M46IaUrRjYxXgjKxs2eNxExa7VMeJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632426; c=relaxed/simple;
	bh=qPHbKu4gWGNOKLjB1Ld3xW6l3uHkaNv+fzrZx072U18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcVefv+C22Dk0sSax3tZvxBfSuaXFZvx4wYzPIRIHb99YtJ8ATxg+OuucuM/AL+QvQeVvQoOURWBYg0I1Y7nNVzVNaC6KTT1MJYcCflfOiaF4m+RZBJkg0DOvG9sLSGBt+bQv2zYrjxwyWajY7xtlQ+RHd9nAAZAqfreCQFLVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Q5D9DPcm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Q5D9DPcm"
Received: (qmail 5113 invoked by uid 109); 11 Oct 2024 07:40:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qPHbKu4gWGNOKLjB1Ld3xW6l3uHkaNv+fzrZx072U18=; b=Q5D9DPcm3/8E9z/Hz6NjAv11FiRAPNOXuW+tHkfJyxstL40DWglTSAIM35qSmd6NPX/QY+P/ZKmqE2IZ7FPHSEA1fs4JXNHTFIrUQurHlP3tYDgQGHbqRQaRRUjnI4b1JSYpSqEZGpKWoZo9eZktaMRs8kgcAEavqG/jnmksPQQBsQa5E+tXUqRPCaJjuZF4Kv3H2L/f32NM+iKUADLnPbPulnIcrECJJKjyasF2V7IVhb/ug9RSKLaSakFx+KlMyfcPF5olxf/R/vvoa2aIRh3sBq1OvCvSLk5Uf/wFd0hhVsTWjSXXD+QSKvyMZwcPlQfyljZzqGK1/alhvKZMBA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Oct 2024 07:40:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17391 invoked by uid 111); 11 Oct 2024 07:40:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2024 03:40:22 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Oct 2024 03:40:22 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
Message-ID: <20241011074022.GC18010@coredump.intra.peff.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010235621.738239-1-sandals@crustytoothpaste.net>

On Thu, Oct 10, 2024 at 11:56:08PM +0000, brian m. carlson wrote:

> This series updates our requirements for libcurl to 7.61.0 (the version
> in RHEL 8) and for Perl to 5.26.0 (the version in 15.6).  I considered
> the mainstream LTS versions of RHEL, Debian, Ubuntu, and SLES, but
> omitted consideration of paid support extended LTS, since we cannot
> expect Git developers to have to pay a large corporation lots of money
> just to test functionality.  This is in conformance with our policy,
> which states that versions must be "in line with the version used by
> other long-term-support distributions", which does not include extended
> LTS distributions.
> 
> The libcurl dependency changes come in incremental patches so that if we
> have people on unsupported systems, they can simply revert the patches
> that they'd like to omit.  It also makes the changes easier to review
> than one giant commit.

The libcurl changes all looked OK to me. I was a little surprised that
we could move to 7.61.0, which is only 6 years old, since many long-term
releases target 10 years. I guess the ones you looked at have had point
releases with updated libcurl?

I don't have a strong opinion on the extended LTS issue. Like you, I
don't really care about dealing with paid support. OTOH, I think in many
cases there was little to no maintenance burden for these older
versions, since we'd already done the work to #ifdef them. But I guess
since you broke up the patches, they can always choose to revert or
include what they want.

> The Perl changes are a huge upgrade.  5.8.1, our former supported
> version, was from 2003.  5.26 has substantially improved Unicode support
> (including Unicode strings), s///r (to allow returning a modified value
> instead of modifying it in place), postderef syntax (which also provides
> better interpolation for complex expressions), and subroutine signatures
> (although these are experimental until 5.36).  These allow us much more
> readable, modern Perl.

I'm OK with a move to perl 5.26. It does feel a little weird to be
mass-updating the "require" lines in stuff in contrib/ (specifically I
noticed diff-highlight, since I maintain it). But 5.008 is so absurdly
old that I find it hard to believe anybody would ever notice the
difference.

-Peff
