Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5157637107F
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 23:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382078; cv=none; b=m0MdZ9SyCPejzLkMMAhAg2RgbQTPZ7qjj0j2WSTiiVzStFdAEGClcDNtZEEP29Marx1X9gU33uv/cS/L+dQM9l5ReVsjMYkrPdklYOfkKhKS556VclTLc+HVtYHd0FGLobTLJ3+cre/NBOQzbRujEj55Aipn6aDEpwhxYk6DLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382078; c=relaxed/simple;
	bh=99rkTGWxAZcEtC3Z418MZXgY/utPwBTrCOb40cChipQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlXd3N6IP6oYubYQHXimhwjUeHV1ZkBAwhT8r/mUHbaq+BKGJ4IY4sL1wmeTa7GP5iZ0mxmsACieA+B1NLuXHUCc6HHTH4lWICSoj38zqTVHlDMzqDphPw2Y78dR1vYybB6ZPd7ZKnBIQZlPAB8H8UnYUsF0ths25Edtwz+xzlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ULxwva8q; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ULxwva8q"
Received: (qmail 375133 invoked by uid 106); 16 Apr 2026 23:27:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=99rkTGWxAZcEtC3Z418MZXgY/utPwBTrCOb40cChipQ=; b=ULxwva8qZynqnBlv9DTk3wawvDidajQ2XUcZGxPkSF3WuPi0mZNjo/KfW00M6zH9oZ68Efv1nEW9PgPCKI/txRv4Cz0S1ovx9UQKW3hMTOwNuPvvPXgLLCNxKHAjEI9zwv9DwbbM8ImQEr4ggA77rr12Wx+uGiHqN/qoUW9NpP13gUm/WEoJ5KbEV57TZCzdf2pwlUYS5Pc4GzqqxyC2KPNbqKWDeULI+iS76aV3bcHQwE/Bm42zo/wcaQW/dCMgSrGC4gKywIDCEOsp3cWUMY5UpyAkFGoQhTrYKXg3bsrxUmtui3rjHpUA+knpGs9z4GOYhruPQ1lNOs05QnFCWA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Apr 2026 23:27:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 625478 invoked by uid 111); 16 Apr 2026 23:27:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2026 19:27:56 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Apr 2026 19:27:55 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] MIDX: revert the default version to v1
Message-ID: <20260416232755.GC1904316@coredump.intra.peff.net>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
 <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
 <20260416053435.GA646718@coredump.intra.peff.net>
 <xmqqldem22uw.fsf@gitster.g>
 <xmqq8qam217m.fsf_-_@gitster.g>
 <20260416200659.GB1887222@coredump.intra.peff.net>
 <aeFQvu4iqJAQMjCy@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeFQvu4iqJAQMjCy@nand.local>

On Thu, Apr 16, 2026 at 05:12:30PM -0400, Taylor Blau wrote:

> > As a result, writing a midx with Git 2.54-rc2 puts the repository into a
> > state that is unusable with Git 2.53. And this midx write may happen
> > behind the scenes as part of normal operations, like fetch.
> 
> I'm not sure if it's worth mentioning, but I think that it's reasonable
> to say "Git 2.53 and earlier", with the implied lower bound being which
> version first introduced the MIDX. I think it's equally fine as-is,
> though.

Yeah, that is a little more clear. Looks like it's been pushed out to
next already, though.

> > I have a feeling there are probably some gaps in v2 testing in t5319,
> > since we are no longer using v2 for the bulk of the tests. IMHO that is
> > OK to sort out post-release.
> 
> Perhaps, although you could make the opposite argument for v1 MIDXs
> when we previously switched the default to write v2 MIDXs. The format
> differs only in the version field, and the ordering constraints on the
> packs within the MIDX. That area and the compatibility issues here are
> the "interesting" parts to test IMHO.

I think that t5319 specifically writes a few midxs with v1 to test the
ordering constraints. Probably there should now be some v2 specific
tests in the same way. I was hoping you could pick up the pieces there,
post-2.54.

-Peff
