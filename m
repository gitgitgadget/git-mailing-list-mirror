Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF84F39DBDB
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381803; cv=none; b=bfFoUQmeL/pgaHnn1fbrtRlnn+9cE+K3MgwMKb37JUjV8PnSwsIzmzLslTk56LdYuMhoPll2K7ej8wjYEHIw4PYKz+DGMLc0jMZJfj8fGpEGzTR2R4HQdNpitp1bLGq0nme+6lVf7vL2wPGgjHf9LIpcwY6C39EBowVB+K4IlXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381803; c=relaxed/simple;
	bh=76ttSOSlTV00vvCqwAZJJDVPLHkUFqHNYX9Z2ZC2Gik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLAK+eS9b1MuvwZyE/f2peB+3dMRXIKbHDzbt8Ls26bHSDWuUSgSTifTYM1cJx4/YqMfdv7L4vzkQ53LRf6wUfne0XGQTSAS6aUk7QmE9gAHgsNPWW6LG4RLnk30wWdJT+/JLXsInGAoBpim9yAVHjrXWt9JoUpfyiSp7sJ9Or4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BGF2fsL6; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BGF2fsL6"
Received: (qmail 375078 invoked by uid 106); 16 Apr 2026 23:23:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=76ttSOSlTV00vvCqwAZJJDVPLHkUFqHNYX9Z2ZC2Gik=; b=BGF2fsL6FANkNiZrPc1VevCZ4mjXNla+Wt2AHN4fPeYR+bBFvTrANo9fR4+9tCqMsjK80p/EzYe7nMdwC9/mlgYQ2WyUfnddTMy4OgNBNRkbo1QWIgjnfCbGGkFnKnp25cRkvjDsviat8x9NPe4P70SKLb5jK8C+4cpi9eKy+dwf77PpoCXk63FJIlWOyhqecAZSKr4AZUME31xpMOOmyL12YvcU70wnXrI8lcfX0uCREFOVWM882bsXwhTdvxoplvOa/eVyGr6EAMCyGkZCoWYPBZZv8kuFAydi+oQkk6dc1JfNocIDK3vYTFsf/ebgujklKRbiHzOXpegfQeJnMg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Apr 2026 23:23:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 625346 invoked by uid 111); 16 Apr 2026 23:23:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2026 19:23:20 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Apr 2026 19:23:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
Message-ID: <20260416232319.GA1904316@coredump.intra.peff.net>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
 <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
 <20260416053435.GA646718@coredump.intra.peff.net>
 <xmqqldem22uw.fsf@gitster.g>
 <xmqqh5pa22h0.fsf@gitster.g>
 <20260416194922.GA1887222@coredump.intra.peff.net>
 <xmqqqzoezmt9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqqzoezmt9.fsf@gitster.g>

On Thu, Apr 16, 2026 at 01:12:50PM -0700, Junio C Hamano wrote:

> Looking at the later part of load_multi_pack_index_one() function,
> it is full of die() calls, not prepared to degrade gracefully at
> all.

OK, I confess I did not look past the two goto calls below the lines I
touched, since I didn't think we'd be applying it immediately anyway.

> The reason why I do not think reword is worth doing is that as far
> as this function (i.e., "Here is an MIDX file---please read it and
> give me struct multi_pack_index back") is concerned, these error
> returns are giving diagnosis on the nature of errors.  Sometimes we
> cannot learn the length of the file, sometimes we find that the file
> is unreasonably short, sometimes it is not sorted properly, etc.
> None of the existing "error + cleanup" says "we are continuing
> anyway" and that is good.  The decision to keep going without using
> midx file (or not) belongs to the caller, so if we wanted to say
> that, we should say so in the caller, not here.

Yep, I agree with all of that.

-Peff
