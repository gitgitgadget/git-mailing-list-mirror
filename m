Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF922FF22
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854578; cv=none; b=SvRa1vAvpJoMmHRcsfHIXrP4nY3guHyYbqIDX6wjRp8yPXnYmAmPHiLoliwiUxodtejXBE5Uds+4GjCMZ0bYMBXsCkXUcKbu1m7MF7dd99LIdllf+rT4usXeCuw7ztP1UZ7a8oxvWTRMKD9+FC4pc3D30z/bZvo7/l/njmBSC4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854578; c=relaxed/simple;
	bh=X9FBeFlOB4Vr3vuNhkeTtYF6EHfcoYhjrv64rGZVsMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0NWi1wR93J9AaTL2FAYd+1WzspFjep3Sa7y0nnN6C4yxLOnmkwZ89lxBJsT08f/8zGKeC5KQyRyJ/9q+YLR3CQul+4KEN8dnKJ61JlwRe222GrWrFREorFtylWGAhlUIqPE4/T2Hcr6hVHHQVPrhjS/3QOMlYCbFDQv/QvN1oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ONMNMbTu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ONMNMbTu"
Received: (qmail 54886 invoked by uid 109); 23 Feb 2026 13:49:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=X9FBeFlOB4Vr3vuNhkeTtYF6EHfcoYhjrv64rGZVsMs=; b=ONMNMbTuQIKYPQC8reQN3gq82HAUU9l/wRWcDICSbvOIDjRCLPohZqqD2qMf6psf5jpmfH3PB8gVhtu2lzbw5oxnz8XvezQl6W4N/BGO9kG0xqlPBhh3XPJwvXGv3o7Dd9x+jMb3oh2yrKWCcSGGLqKaqqdTpteDgkOXJ0EZp+5HpR40zZfNMF1qeEsTwNPuGLIv2+7T6+SdqfQ7jpe4d5P6dHVSaGVs3ed8/ed0HjPqEg52T2XsXjlmlJggjZ2MXjPDhr8ujdQFWLu3QU3pubpi4H+oRkFlC89yWljjvXr1J+v8B0Wzpr20EykGZuyVouvoNbt6zEPeteN71vqbHQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 13:49:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 105979 invoked by uid 111); 23 Feb 2026 13:49:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 08:49:36 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 08:49:35 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 11/18] git-compat-util.h: introduce `u32_add()`
Message-ID: <20260223134935.GA271392@coredump.intra.peff.net>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <c0c1769464b1c8065c2cea59dfd85a1d37de9dd1.1768420450.git.me@ttaylorr.com>
 <xmqqpl7beugj.fsf@gitster.g>
 <aWgSzI30k0BZfZ4Q@nand.local>
 <aWgwn2rk/qw+fRoA@nand.local>
 <aXCTkVpjJkTabx_0@pks.im>
 <aXFni2tE7vn1dKFp@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXFni2tE7vn1dKFp@nand.local>

On Wed, Jan 21, 2026 at 06:55:55PM -0500, Taylor Blau wrote:

> I had considered this approach when writing, but ultimately decided
> against it, since it felt a little clunky to have to pass a pointer in
> to do a simple arithmetic operation. But I think your point about
> ensuring that we actually do:
> 
>     if (unsigned_mult_overflows(a, b))
>       die(...);
>     result = a * b;
> 
> and not "result = a * c" or some other expression which is not "a * b"
> is a good one.

It is clunky, but it's how the compiler intrinsics work (if we ever
chose to use them).

> I dunno. The spots in this patch are the only uses of u64_mult() and
> u64_add(), so I'm hesitant to keep a helper function around just for
> that sole use-case. I wonder if we should do what you suggest here for
> the much more frequently used st_add() / st_mult() / st_sub() functions?

I am to blame for the crappy interface of the st_add() etc functions. It
did make conversion _much_ easier, because you can do stuff like:

  -foo = malloc(nr * size);
  +foo = malloc(st_mult(nr, size));

as opposed to:

  size_t total;
  ...
  st_mult(&total, nr, size));
  foo = malloc(total);

My rationale was that size_t computations like this are OK to die() with
very little useful error reporting up the chain because:

  1. The result is generally just passed along to malloc() anyway, where
     we likewise find it OK to die() without much info. So you can
     imagine a world where we just do 128-bit size computations and then
     let malloc() fail, and it would look the same. ;)

  2. They don't happen in practice unless there is a bug or a malicious
     input. Which is mostly true for 64-bit systems. Maybe less so for
     32-bit ones, where you might conceivably wish to have 4 billion of
     something.

I don't think any of that holds true for u32 values like counts of
objects. It's conceivable that you might want to try to write a midx for
two packs with 2.1 billion objects each (though from my experience, such
a repo would be unusable).

Anyway. My point is mostly that I think we can design u32_add() to be
what we want and not worry too much about going back to fix st_add(),
etc.

-Peff
