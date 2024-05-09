Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707028F7A
	for <git@vger.kernel.org>; Thu,  9 May 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274296; cv=none; b=a7tAoZrq0p98iKlIlV0RxSijewFKzxbm3ZThSuye0gutmhLLryR5HVMZWVXlZwsjqUxqwtNtt+Z5d6960J/oCfOYtu2AH3eepFRWsom1KAM5rpWyVeAlMUHFLLEkNi1Itpzck8E74ta7MfSZjcgHFC50UPc5QPZdgPNTr7GDME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274296; c=relaxed/simple;
	bh=Q6BDaL0p5512ijtMvRgdd1yHFIOZaQ+5kqrcIQyy9tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgofvgHtaHig4FvWaPREssIG5x2cAcbFJLtkqIUWmVGCh6zVCyQ7NShlYdHpG4exRfdC6e7P9IK4mWk0+nVtGjeg5vpGV/TE2tr4dGMGKyIl5HFCiypuE2cy+9j0K1I7zyItNBS1+3MauMVBTGl0MU4125tm+g3N+mHDQx+I8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7067 invoked by uid 109); 9 May 2024 17:04:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 May 2024 17:04:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31521 invoked by uid 111); 9 May 2024 17:04:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 May 2024 13:04:54 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 May 2024 13:04:53 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] http: add the ability to log progress
Message-ID: <20240509170453.GE1708095@coredump.intra.peff.net>
References: <20240508124453.600871-1-toon@iotcl.com>
 <20240508124453.600871-3-toon@iotcl.com>
 <20240509163414.GA1708095@coredump.intra.peff.net>
 <xmqqbk5fudw8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbk5fudw8.fsf@gitster.g>

On Thu, May 09, 2024 at 09:51:51AM -0700, Junio C Hamano wrote:

> > It might also be reasonable to just bump to 7.32.0 as our minimum. The
> > last bump was recent via c28ee09503 (INSTALL: bump libcurl version to
> > 7.21.3, 2024-04-02), and the version picked there was arbitrary-ish (it
> > was something we had happened to depend on accidentally). 7.32.0 is
> > itself almost 11 years old now.
> 
> The last bump was 7.19.5 (May 2009, 14.9 years) to 7.21.3 (Dec 2010,
> 13.3 years).  As 10 is a nice round number, we may even be able to
> pick randomly a slightly newer one, say, 7.35.0 (Mar 2014, 10.0
> years).
> 
> It is in a sense an inferiour way to pick the minimum dependency
> than the choice of 7.32.0, which is backed by "we use this and that,
> which appeared in that version", of course.

I am OK with just using round numbers, too.

The biggest thing for a time-oriented scheme is really what made the
cutoff for long-term distro releases.  With a 10-year support term, we
are often looking at 11 or so years to have made it into a release.
OTOH, if somebody using a 10-year-old distro is forced to use a slightly
older version of Git to match, IMHO that is not the end of the world.

Bumping to 7.35.0 would also let us simplify some curl-compat code,
which is always my real goal. ;)

-Peff
