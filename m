Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB858003D
	for <git@vger.kernel.org>; Sat,  9 May 2026 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778349204; cv=none; b=COiE5xuYl84MsDOgm0u+5NAI+lWz1RgOd4RwV6600IlAZU9u3DEVZaF6sW4lxXmzk4HcOc0QEhqvEIR8hyEICdEfrbisa+tki0o2t7BDY+/fteNt7z5J74MI/swI6QhzpStMYWrc74VdOlD2aVkIOpJTuL0+SbvPP/LkztbN5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778349204; c=relaxed/simple;
	bh=0E7kZ1z5s47Np/0H2sc4znHU5j3AKmD2KRCCmNyJZjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCkBc1IgSAHREtFKOYx4ItKMKGUF8Vs4Wql/hk94SPFe/J9wkcK+Xeev3uXRSg3VA+zrLPPfp2ue9ZYEh15WamUlbCeI+Y8BJ2ZoieHw1ztFWWacQ1C/3r20aWyrTjh+diuUCuCwQAsCl3h3aNXRFdvbFYmRi0bOCX8RWH5Yv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Gm9LnaNh; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Gm9LnaNh"
Received: (qmail 1882 invoked by uid 106); 9 May 2026 17:53:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0E7kZ1z5s47Np/0H2sc4znHU5j3AKmD2KRCCmNyJZjg=; b=Gm9LnaNh0H67PCmcCnhw2bKDHgjmFzGs+e4KBTz9k/2a44A4zBiySiC9WC+ACiz/k5Z2rZGP5/mPAIpFgPdZkYfJLDi93u93QaTK/VLGk921KFOWoaYYtrT875IidRFJShnxWgNSYeI7Ppa4TafsqKRRNe+8Ait+oFk10iJ6TWhFuKYf1DJqLhXdaxVFzPEHuYjSpwBUYB1WwEj3Q9A4NuXj+0HO46JhV3AgPne+AcR+LlcFeX1xrSkASkSrp8lN0Eca0rIUdbokJOII0Ub8jrKZaV/hAXOpO6YKmTuSArRW79Nr28mw4tYeUpMBTJ4ANHvOUkXe4loGaeDTwL5mbw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 09 May 2026 17:53:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3552 invoked by uid 111); 9 May 2026 17:53:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 09 May 2026 13:53:22 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 9 May 2026 13:53:21 -0400
From: Jeff King <peff@peff.net>
To: Mikael Magnusson <mikachu@gmail.com>
Cc: jean-christophe manciot <actionmystique@gmail.com>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
Message-ID: <20260509175321.GA2336838@coredump.intra.peff.net>
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
 <20260508180341.GB737125@coredump.intra.peff.net>
 <CAHYJk3R-TyYv1MizKmHhhADrQd+VnQjxSikpcaPLB=VfHrAwpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHYJk3R-TyYv1MizKmHhhADrQd+VnQjxSikpcaPLB=VfHrAwpg@mail.gmail.com>

On Sat, May 09, 2026 at 05:13:17PM +0200, Mikael Magnusson wrote:

> This sounds pretty horrific, this maintenance thing is enabled by
> default and there's nothing but pure chance that stops it from
> corrupting the repo if I happen to run git repack manually at the same
> time? It's hard to believe something this disruptive is even enabled
> by default, I don't expect jobs to kick off at random hours using up
> resources when I'm not working on git. (I'm assuming I'm several
> months late to protest this being enabled by default, but still). I
> would strongly suggest anything like this is *never* enabled by
> default, it is extremely surprising to find out about. Hopefully I
> misunderstood the part about this being enabled by default, and you
> still need to say "git maintenance register", right? (although the
> manpage erroneously(?) claims this will only enable tasks that are
> safe, which you seem to have disproven?).

This is not the time-based maintenance runs, but rather an "auto" mode
that is triggered by commands like commit when the repo state looks like
it is in need. That mode has existed for many years, but used to be "git
gc --auto". And now it is "git maintenance run --auto" with a new name
and new code (and, it turns out, some new bugs).

The locking issue seems to be specific to --detach mode, so I don't
think affects time-based runs, only the auto mode (though if you
register for time-based maintenance and then manually run git-repack
outside of "git maintenance run", I suspect you are subject to an
unlikely race there).

I think this did get much worse in v2.54. I left more details elsewhere
in the thread.

-Peff
