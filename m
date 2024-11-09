Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E413BC12
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731178825; cv=none; b=R5hCic0RFDcC1wIouaXS/as6TnM2FDO5li1X5ZKcybWgzuMoYa+qvzWfVVEF342Qzoc/OxGKbEd9Y/Ka3QdRB45BAN2CRC4MnUpV25h+soovc6gXLHZ08zzRYcpT4/pC6NzDlLO/qAnws46eDtserJUCfuSUoFGEAW89jisEcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731178825; c=relaxed/simple;
	bh=f8GoVa+muOTEo9EbrmuAu0DvORHujnmkwZKTK4V36Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9WWyMCrVso66RkWN7UVjIRCA9g8bORa913HgJd3vFx61zkBXhRakt/Yt/hB7RsltWaflQJtR78enjr2N/UDS925fnYImofpjWlijlqdmkLZ/K7odkCyC9O0g0fbGWg9PW0Dbyc8p96yfAOMEbZ9urf+fPFY8iPYHT1Oadvs/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dI2e7FoV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dI2e7FoV"
Received: (qmail 23420 invoked by uid 109); 9 Nov 2024 19:00:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=f8GoVa+muOTEo9EbrmuAu0DvORHujnmkwZKTK4V36Q0=; b=dI2e7FoV6yxpHmWBgwpPkpVjaDWKSjr3u0WmhDI2eyuPSXe4X2pzOzIlesiiIAm4CmVg8ym3mTDrRtJHbr4iMEW2f0MwGwK0mBOCWtwPYEDLE/io/tp04016kOPszIh/ywFbMlR4mN8X8DFnd6+KoEogV3H43jcwP3zG06EaAlfulb/UxbvgS4iVVyjOcepHzjHpX9nnk93GrBj9P2Qu1DNP9IAyW7mydutS9xuYhnjvbu1D6UC3ioQzvzp3ewFf3kAmHOKKEd1pNtIeNxrXQl/5lhvt4gK+CIva08cq0HxzrXh1fDEFr3HUwO5h+xAeVaE3Cv3sIteY8xIFDFEfkw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 09 Nov 2024 19:00:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12350 invoked by uid 111); 9 Nov 2024 19:00:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 09 Nov 2024 14:00:13 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 9 Nov 2024 14:00:12 -0500
From: Jeff King <peff@peff.net>
To: Todd Zullinger <tmz@pobox.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC]: Test Were failing on Fedora Linux.
Message-ID: <20241109190012.GA588841@coredump.intra.peff.net>
References: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
 <CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com>
 <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
 <CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
 <87msi85vc9.fsf@igel.home>
 <CAPSxiM_h2yEZcUPP33q8HHdn6kqq7SbvzNq8eEFda81ZgY6R2w@mail.gmail.com>
 <Zy-IYwjb_RO5NW-s@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zy-IYwjb_RO5NW-s@teonanacatl.net>

On Sat, Nov 09, 2024 at 11:05:55AM -0500, Todd Zullinger wrote:

> The 64-bit libc_malloc_debug.so.0 is in /lib64 and was moved
> to the glibc-utils package in Fedora 40, with 2c1b0f0 (Move
> memory tracing libraries to glibc-utils, 2024-05-15)¹.  The
> commit message notes:
> 
>     On x86_64, glibc-utils will now only contain the 64-bit
>     version of these libraries but still need the 32-bit
>     version (in order to support tracing i686 applications).
>     Therefore, on i686 the libraries remain in the main
>     glibc package.
> 
> If you're interested in installing the various dependencies
> needed to run the test suite on Fedora, take a look at the
> Fedora git package spec file².

Hmm. I wonder if our test scripts could be a little more forgiving here.

The glibc malloc debugging stuff has always been turned on by default
since a731fa916e (Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the
test suite for detecting heap corruption, 2012-09-14). Back then the
setup just involved setting some environment variables. If we were on a
system where it didn't exist, it was no big deal. We'd just run without
it.

That changed in 131b94a10a (test-lib.sh: Use GLIBC_TUNABLES instead of
MALLOC_CHECK_ on glibc >= 2.34, 2022-03-04). Now that glibc split this
out into libc_malloc_debug.so, we have to add it to LD_PRELOAD. We only
do that when we detect glibc, but it sounds like it's possible to have
glibc but not the malloc debug library. In which case we'll produce
errors (at the very least it seems like ld.so will complain to stderr,
which perhaps is the source of the test failures here).

Can we do a better job of detecting that the library is available?

I don't offhand know of a good portable way to ask the system about
available libraries. But I guess just doing something like:

  err=$(LD_PRELOAD=libc_malloc.so.0 git version 2>&1 >/dev/null)
  if test -z "$err"
  then
	...seemed to work...
  fi

would do it? I dunno. Maybe this is not a common enough thing to worry
about. It just seems bad for us to make life harder for people running
the tests for an optional thing.

  Side note: The glibc malloc stuff seems a bit more redundant these
  days, since we run with ASan in CI (which I'd expect to catch a
  superset of what the malloc debugging would). There is some value in
  catching things sooner, though (I don't usually do an ASan run on my
  workstation, and of course some people may not use CI at all).

-Peff
