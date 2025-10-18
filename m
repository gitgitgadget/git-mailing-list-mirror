Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F95944F
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781373; cv=none; b=Z5yV5mSxJpyl0EMbsdHUww5aJFImk+jOc1ijeX0T02LJFEkEDWhmZNkWFXoBdtFj+5Ug6hZfAd0B/SGweK1II4NEkkcdwst6GjknAPVDEk9raVljWVbj1vt1P3QVs3S33QulTuMh8IJ8Uhx8NJUTuB5ml4+BDs22E3WXHzM9+4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781373; c=relaxed/simple;
	bh=5JfJ41CGwdfSf+t7RNdGBRv9WARQsslULU1aHWNM/cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyBx1GnDd3bNmB9C/iDrYbP4rSv3ZuZ7ShChC4Q5Zawl+nZbqUaOIjPSrQCuloH9xS5XCyZl+IUm3TrhxmrgKsRs+MG1EMD2FIBNY9ijEFCj835WPjV1z9f6+6hgL/aS/m2lJUClLIkZVcRj2/ZklfslMCUp4OlIgddmipvWmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=h0z333sX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="h0z333sX"
Received: (qmail 261282 invoked by uid 109); 18 Oct 2025 09:56:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5JfJ41CGwdfSf+t7RNdGBRv9WARQsslULU1aHWNM/cM=; b=h0z333sXnWrQQTckdpzV7/ZP0eK2HGOgi1FGS04Ddna5VcLcKfidO4lffIeNjT6D+yUeUQhF7AHsb+noLD3wzrGshDIjG/C1w/fnEAD76HQfstdzBu+u7xM+oUxx7NY6mxFKIDN6s1BZT1sGFvL2ZJYFYQRbbLIVD4+QfpaM1atFqW0iwGrnF7UKy+fNQAKkJEFPZp1z5Xjcj94y0Vqo1NAy/jIcuUdX9nhpJ0ugEyef6phNJD3zHRGyj6ZaaFrRksJrydr9udrZZXTrAT3sbVhM/AN1TXxsPL6TYQPKyX0WKUJcQTXZ32kVGFDIHQIij84N0z3D+pKTuewwi0xuyQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Oct 2025 09:56:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 409878 invoked by uid 111); 18 Oct 2025 09:56:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Oct 2025 05:56:07 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Oct 2025 05:56:06 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Lauri Tirkkonen <lauri@hacktheplanet.fi>,
	Collin Funk <collin.funk1@gmail.com>,
	Xi Ruoyao <xry111@xry111.site>, git@vger.kernel.org
Subject: Re: t7528-signed-commit-ssh.sh fails due to ssh-agent fails to start
 with ENAMETOOLONG
Message-ID: <20251018095606.GF1060824@coredump.intra.peff.net>
References: <4e2952e512afc780b621d2c153b3e6e4eb7ed89a.camel@xry111.site>
 <87o6q6nux7.fsf@gmail.com>
 <20251017070912.GA4068463@coredump.intra.peff.net>
 <aPIR8fB4w5Jkeiq2@mail.hacktheplanet.fi>
 <20251017105400.GB1015973@coredump.intra.peff.net>
 <aPKZeqTK-tIcrfFB@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPKZeqTK-tIcrfFB@fruit.crustytoothpaste.net>

On Fri, Oct 17, 2025 at 07:31:06PM +0000, brian m. carlson wrote:

> I had not had time to properly analyze it in order to say something more
> thoughtful than "this is broken", but I can confirm it breaks for me on
> Debian unstable:
> 
>   ERROR: ld.so: object 'libc_malloc_debug.so.0' from LD_PRELOAD cannot be preloaded (cannot open shared object file): ignored.
>   ./t7528-signed-commit-ssh.sh: 1: eval: directory.t7528-signed-commit-ssh/.ssh/agent/s.5w4CQ2109U.agent.5l0ixCaX1S: not found
>   Agent pid 1429798
>   Could not add identity "/home/bmc/checkouts/git/t/trash directory.t7528-signed-commit-ssh/gpghome/ed25519_ssh_signing_key": agent refused operation
> 
> Note that OpenSSH in my case is broken because of the space in the
> home directory.  I've reported that to Debian and we'll see if it gets
> fixed.  (I did mention it breaks the Git testsuite in the hopes that
> improves the likelihood of getting it fixed.)

Thanks, I saw your report and had nothing to add. I agree it would be
nice if ssh-agent shell-quoted the output. I don't think there should be
portability issues.

> > Yeah. We could either do something like "ssh-agent -T || ssh-agent", or
> > we could go with "ssh-agent -a" (which has been around since 2002, but
> > does raise the potential relative-path issue).
> 
> I think like `ssh-agent -T || ssh-agent` would be better because we know
> $HOME can be very long in our case, whereas $TMPDIR should not be
> excessive (since presumably it worked before and other services, such as
> tmux, place their sockets there).

Yeah, I think "-T" would work fine. I just find it a bit hacky to assume
that a failure of "ssh-agent -T" is because of the "-T" option. We also
could do better at detecting errors in general. If you did not have
ssh-agent at all, then:

  eval $(ssh-agent) &&

will not fail the &&-chain since its exit code is eaten in the $()
substitution, and we eval an empty string. So arguably we should pull
this into a prereq or something that makes sure we can actually run
ssh-agent in the first place.

-Peff
