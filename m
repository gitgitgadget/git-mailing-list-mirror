Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641039099B
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160981; cv=none; b=EgPXjLJy6HrH9csIzd7Vn+H3lNN6kNLTUGVQ7h0zW3tNaVcJQZB04Y70bHgd5u/d4pJpTTO7kgggDMbrnyiwJRUOpQzPqacUXhkcgdsoG9LznWMrAZOaSLn4h30RtJQtk/5lIMOCrIKzaJz62kXYLthaIaDSONTAVU0lIxsv9MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160981; c=relaxed/simple;
	bh=MSAefF3Bv1xEuGwsNCh6yp97UxjMYs5saoJzzgyFpvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaIS43jpt1gkw/Xgzjwyf5Gu/rBQZOITktCvNamxl1y/ENF5AoeMA6Aq1Xp2C2YJzUGrNkb4MTaBumJVXPh2K/mbyDMKHrPG/J0sTRnSmBqu/ZvFhWj7FjqTwkol3a7Kvc+xkQq1P9+C1KG2DeKUFpqzFIR6Jp7qSK3nHGpccv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LYOrincF; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LYOrincF"
Received: (qmail 106327 invoked by uid 106); 11 Jun 2026 06:56:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=MSAefF3Bv1xEuGwsNCh6yp97UxjMYs5saoJzzgyFpvI=; b=LYOrincFXBY8YQzZPPY31GjUitFWdbKXkvKWAeeCvTdHOKnqdmyeQznq4MDs6ado9J1zC+pKxijRWTRMYyFv0pNYGufxdcGBifemBsH3IqDqEgyqsW79Gm7bfEnLBen9AL7bze83eR8J3X20dHk/bklwydr0682Q7W77cKszwQGOyCltFTvTJYshw6S9z4RJlA7lpOiaqSs7UDgTu0ERud2b9T+zkxcQ8EBr2blupH99ZPN3mctLw2rDtMRvHFOGbifeGRCysjN3ZJ+7BuEhMekJqPrNx//aa2WZ4/oxhlxMD/xqpvdwWn8sJl2Vsanzog57kWhw5E16cgbaX/pq4w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 06:56:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 314170 invoked by uid 111); 11 Jun 2026 06:56:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 02:56:21 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 02:56:16 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: trailers: --only-trailers normalizes URLs to trailers
Message-ID: <20260611065616.GE2191159@coredump.intra.peff.net>
References: <ae4a32e7-bacb-4c88-b2a0-5aeaff60b904@app.fastmail.com>
 <20260609004340.GF358144@coredump.intra.peff.net>
 <d8f7f827-27da-41fc-af8d-72d383b24fff@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8f7f827-27da-41fc-af8d-72d383b24fff@app.fastmail.com>

On Wed, Jun 10, 2026 at 04:21:29PM +0200, Kristoffer Haugsbakk wrote:

> > Yeah, though if you'll allow me to nitpick your subject a moment: I
> > don't think --only-trailers is really the culprit here. It demonstrates
> > the problem because it normalizes the "trailer" it found. But the loose
> > trailer matching is the more fundamental issue. For example:
> >
> >[snip]
> 
> Yeah, this is more precise. I focused a ton on the normalized output
> because that’s what makes it obvious. But the fundamental problem is
> interpreting URLs like trailers.

That makes sense. As the author of --only-trailers I immediately
wondered if I had introduced a bug in it, so I was partially motivated
by exonerating myself. ;) I agree that using it is the simplest way to
demonstrate the problem.

> > Agreed, though I think a rule like: ":// (with no whitespace)" is not a
> > valid separator. Something like this:
> 
> Yes, matching on `://` strictly is a better proposal. No need to care
> about `http`, `https`, `file`, etc. And both of these would *still* have
> to be true for this change to be a false negative w.r.t. the user’s
> intentions:
> 
> • They really input a trailer that looks like a URL, but it’s not meant
>   to be a URL
> • They really wanted the value to start with `//`
> 
> And again I don’t think that is likely to ever happen (with a knock
> on wood).

I didn't spend much effort on the patch I showed beyond running it once.
It would probably need tests and a doc update. I wasn't planning to run
with it, but if you feel like doing so, please feel free to use it as
you like.

-Peff
