Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB943383C64
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381966; cv=none; b=h1tYg7P2xd8arKHm90uDQrMOzPU/fIG1Znq6Jd0WYNiTJCXTsokk3fdM93pXCHEO+MY+5TQCxaPhK9rOAzAOn+p2/FB5XFye5SYodHLx77gRqu+EnzmT5l4x5cCB6hUrMtVqQz+UGra43up5ujEm5nKXAENpWz2nAu+cgSQGxEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381966; c=relaxed/simple;
	bh=MkH/NSEbMIRf5XxZI6etaSfMZ9kPTMl1eD6EnHLgxtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeleXGy0XjlPjmuBs3pCCPHfx2vely/y6Vgoi4a+JjVqVZa1cxu7gqRBDk8VjHnNX/U3uCC5CeSG8h5KCaZFoDOC7iYEpSNKVatQZz1f4csvQVHcKrsB89/PGhn2JCu6dooYEZ4hYsUpLpVo2FcZR5nQAx8ifco8Rz/T25Kmf5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iKA5Gk3L; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iKA5Gk3L"
Received: (qmail 375115 invoked by uid 106); 16 Apr 2026 23:26:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MkH/NSEbMIRf5XxZI6etaSfMZ9kPTMl1eD6EnHLgxtI=; b=iKA5Gk3LiJyil7R+cyJb5yLrJOLPiZnsdwSAySpIhfyXD4BDc6e/g6ztsutWou8GfoARBUL90PrweKc7oSXGHOEgETkOpVMd7SgyD1CrXBfPVVqctpUCMj9uSEbqKTy09wLymteYmqSFDk7mpId8FpL/VeJ1XeIhIwPP7chFnv4zmB/Q/jTFR6nn6/5rC6EiF0vbZvgx7mYeU3NjcYcXSdGAB44a3RWCG3R/rQcrVUI0T/FDT1ZWDY5CSHFxrX3ucs2OkKr2Jur0wvKx5nMZ1M9IQbMIPP4jQsQA+B/W4eZEqYn71vmYlKo5Z8YGwfNEZhN/gSj6bo/eT5znDjNB+w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Apr 2026 23:26:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 625402 invoked by uid 111); 16 Apr 2026 23:26:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2026 19:26:02 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Apr 2026 19:26:01 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] MIDX: revert the default version to v1
Message-ID: <20260416232601.GA1904594@coredump.intra.peff.net>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
 <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
 <20260416053435.GA646718@coredump.intra.peff.net>
 <xmqqldem22uw.fsf@gitster.g>
 <xmqq8qam217m.fsf_-_@gitster.g>
 <20260416200659.GB1887222@coredump.intra.peff.net>
 <xmqq5x5qzktp.fsf@gitster.g>
 <20260416232455.GB1904316@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260416232455.GB1904316@coredump.intra.peff.net>

On Thu, Apr 16, 2026 at 07:24:55PM -0400, Jeff King wrote:

> > Just a sytle thing but I'd prefer to see this written like this:
> > 
> > +	ctx.version = ((opts->flags & MIDX_WRITE_COMPACT)
> > +		       ? MIDX_VERSION_V2
> > +		       : MIDX_VERSION_V1);
> > 
> > because you do not have to worry about the precedence between & and
> > ?: with an extra (parentheses), and a ternary split into multiple
> > lines is easier to spot if you write it at the beginning of the
> > line, with ?  and : aligned.
> 
> OK. I like the "?" at the end of the first line, since it makes it clear
> from just that line that it is a conditional and not a direct
> assignment. But I don't overly care, and if you want to mark it up as
> you apply (if it is not already too late), I am fine with that.

Ah, I just fetched next and saw that you did so already. Good. :)

-Peff
