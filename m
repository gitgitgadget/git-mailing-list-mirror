Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE62B3E8695
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368975; cv=none; b=QVq8v40WLFglEXs/0TqrICdhoHiuk7LsiKxz+F3Rmd0Yl4n/JfSzN61elzu5+j/68OeNMPX6NhQfkxFH0Mj0fox9/D/9fV63tcxE529AMVvj2w5HWekDR8O2HfwOOGaf7vN8fSW6IZTt7glnYA5ge+dEuq3VPWCvdrQlzPpNIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368975; c=relaxed/simple;
	bh=Re6oFsJaV6tLN1TZ+vDUguP+1it5p2BaegqlPzClngA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn3UWelHgMU5c5Cf95syi0LAJD8amQF2JDTs5gopST1Ol48WbmDXExVBeMB8/2dgjix1qESzJslOL2lqwv8TpMGKZKQEIO2uX7DJsxvtUqKIP3Fs2lLdFlCuobcckiu6cK/7rQqh2sQhg8H5rP8Cp4qbKPdBHkF3mc7qeLrXTIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=htjgUs9a; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="htjgUs9a"
Received: (qmail 373746 invoked by uid 106); 16 Apr 2026 19:49:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Re6oFsJaV6tLN1TZ+vDUguP+1it5p2BaegqlPzClngA=; b=htjgUs9a4Hlz+InsnziCujGQT0/POl8HpxSKfObgBBVZCTU4z6eXWBvx90FGU4nsJXlLPyaG6U6/kNgdagyfQtPvZ1IrmOBLJ648IATjY4kEvQqOEKThGmpigAWcnunoUAj+8mrmxTAOyKXpvRD0WqdEtCotUMX06/fgZhznfY+Il9lf9XELEwmstGKajv/oug2D9PZy/DuPC9K1Isb1w3KawVRyhWYVyPtxgWXRGxTK7fqYx0MuWzhIc+QBkTSZYEqdWk9sbH211sbh8QDE9S2+IjP4UwHO6e90QvSwuLZ6yDU1I0nSSZUSZzypdcsvdG7wNA2KYTZfbjqHh1TX/A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Apr 2026 19:49:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 622114 invoked by uid 111); 16 Apr 2026 19:49:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2026 15:49:22 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Apr 2026 15:49:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
Message-ID: <20260416194922.GA1887222@coredump.intra.peff.net>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
 <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
 <20260416053435.GA646718@coredump.intra.peff.net>
 <xmqqldem22uw.fsf@gitster.g>
 <xmqqh5pa22h0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5pa22h0.fsf@gitster.g>

On Thu, Apr 16, 2026 at 11:18:35AM -0700, Junio C Hamano wrote:

> As to the other change, rebased to our current codebase, we could
> sell it as "futureproofing" for similar breakages we make next, but
> that means we are promising ourselves that we will forever keep the
> MIDX purely optional feature.  I do not think we want to decide that
> we are comfortable with that position during -rc period, so I am not
> sure.  These error() messages should be reworded to make it clear
> that we are _ignoring_ the corrupt multi-pack-prefix file(s) as a
> result, and then further weakened into warning(), I think, if we
> were to go in that direction.

Yeah, I agree that re-wording would be a good idea here. I think this
can happen post-release. We'd like for this to have happened long ago,
but it didn't. Doing it in 2.54 versus 2.55 does not really matter, as:

  1. We still have to worry about 2.53 and earlier anyway, so one
     version is not much in the grand scheme of things.

  2. For midx v2, 2.54 knows how to read it anyway, so is not affected
     by the problem. ;)

-Peff
