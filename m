Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213F1487C1
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738366496; cv=none; b=N7RDNqZZZw3Sak138PvZtp304o7RCuUShmX1MJxDNFI66AFNIMb6Fgiba6JvRTeIivxQ1loF+3GP6fxpGns5lycA6yV/9lb6fiUZ5w4Q6unzk7t5KvLV1wsmrcMuNX4VelrE1M4hqfJCKp9isQ2XPb/rZrsKPsKqmfXbxMHW09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738366496; c=relaxed/simple;
	bh=Wl1XR7e9RSp6Qwq2bzBqUmVp63QI8zHxAGR3BuUfQpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9O2TNi6w8FSDfFuwENqm+UTd5krAgoua+pDChuESo2919bZpVZAU6OwyXL/PE0Q5XSHiN0T7K7zlXEEU4ZsQXuDI4Emgs70p5tYpK1Crsx6XrwX31kY24AzkWpNQzBlG0rNpr+yRsf+wzNHfZU+2+um5pLPcedmBqilamoNt4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SA5ow123; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SA5ow123"
Received: (qmail 7621 invoked by uid 109); 31 Jan 2025 23:34:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Wl1XR7e9RSp6Qwq2bzBqUmVp63QI8zHxAGR3BuUfQpw=; b=SA5ow123QFh6LWlTE/ESD3YEoXKkt3mACDbDuxSjC3+u3dRjuikImUWadDbthMVaEeEYsI6jifRmOKQrmHyQqkFvbCOPW9eN3OrgGqYcpZoP1O9gOAH4CY6PBaysduu8eN+gCkj97z4qoGNpqefltOIHep4BXhxMKzCmq5vh1zykAA9br1h2pTqdnCIzYPTizQqeb34yYdwRok2dZndaFQPamRY17w2XqoDP5UC+nv5YI1Pn/piGhmxFTeGjcuBLC17gkHvNVPQVV18e0WFR35OBWSsUO3rDgIGi+EMA3Ibj7JUwultGElvX4kjjA3zarTYSwDmH7eWeOK4VEd2oXw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jan 2025 23:34:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5770 invoked by uid 111); 31 Jan 2025 23:34:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2025 18:34:55 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 31 Jan 2025 18:34:52 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
Message-ID: <20250131233452.GB3544301@coredump.intra.peff.net>
References: <xmqqbjvyv510.fsf@gitster.g>
 <20250123003613.GA3900660@coredump.intra.peff.net>
 <xmqq5xm6uwip.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xm6uwip.fsf@gitster.g>

On Wed, Jan 22, 2025 at 05:52:30PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Since this hit 'next', it made it into my Coverity runs, producing the
> > small fixup below.
> 
> Thanks.  A greedy me wonders if things like this can be caught by
> them a bit earlier before they hit 'next', though ;-)

I've always been a little afraid to touch 'seen' since it does not
necessarily even pass tests, and I don't want to waste too much time
hunting problems in other people's topics. ;)

But I might give it a try. It will require some workflow changes, as I
only run CI on what I integrate for my daily build, which is based on
next. I do not ever look at or push what is in 'seen' at all to my repo.

Hmm. I wonder if I could just build my daily driver off of 'jch', which
is a little less scary than 'seen' (and IIRC is your daily driver?).

> Nice way to use extended context to show why the change makes sense.

I've been tempted to support a:

  Diff-options: -U10

trailer, but that is probably overkill and full of annoying corner
cases.

-Peff
