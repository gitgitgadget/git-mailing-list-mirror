Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4B6408018
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339710; cv=none; b=r1Wvswa5nOve2kljq87Wtyz/N3iE+Jc3cZb3V/6TAv/XZl4wKkVFI3j3Rff09GV8wQVWUiTp4Ke4xw7P6DYUDp0HxQmrSBSP+WNccZBqhpOM6b4orkEKTdfCPudC/cI8vyHI528GrMlTYGuLlGJArbZJsmWCXpeU8q2n304tnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339710; c=relaxed/simple;
	bh=fJTs4M8DVfzvZBHtOCuzxiH3PSD+u0NFQcMnMwPfVGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVYKhRqRDU3rRWUtg/OzGJBTheRuzFm+aFgEd5julfI2FzFgaf6CHdSHh450ifDcqYGIksOOR7DUdf6jhyhMsYSc6muXQrF8KtNQEgoInzN0SXRWpZjCgPxjsoqUVIe9X3K4ts16I9Pftg94AtQQHt7tiKdDf9wk/ILAjqwNgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=g2VGQwj7; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="g2VGQwj7"
Received: (qmail 10374 invoked by uid 106); 2 Sep 2026 09:01:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fJTs4M8DVfzvZBHtOCuzxiH3PSD+u0NFQcMnMwPfVGw=; b=g2VGQwj7ZxReNK8wjgs6qgaEd070/7HGcELrMPUrykETPKcBI1rSUL+puMWBGNvE2hYI9F9zcsN3oLEbYQHCbY0XwQ5vZo8l7VxUZDytkJw60vKKjREonTiQB9UBmIF/yStcLJupCCTH0HXz3gRci9PLG4UyRvO+Soa+edvhmPf4x8Sw3WCKIoahl9i3OBHYSx2nXNVKIodPw91jqKX+vs9VMZ0epEhr7bttpAWIaYcsCdT5DuKxKgQ61uvQC1uBEycLLJGr5ySY6Pqq5mJ3z4Y9adSVfd2oOSxa2kAXe6YjXUa5BUfYAH35vfzcdIcgssl/cv5PH2Gf1+fCkSx5qQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2026 09:01:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 48379 invoked by uid 111); 2 Sep 2026 09:01:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Sep 2026 05:01:46 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Sep 2026 05:01:46 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci: use system asciidoctor
Message-ID: <20260902090146.GA1791728@coredump.intra.peff.net>
References: <20260902071113.GA70165@coredump.intra.peff.net>
 <20260902071613.GB641414@coredump.intra.peff.net>
 <apfWhYF6nmcFGKE3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apfWhYF6nmcFGKE3@pks.im>

On Wed, Sep 02, 2026 at 09:55:49AM +0200, Patrick Steinhardt wrote:

> One thing that we might have to worry about is compatibility with _old_
> versions of asciidoctor. Now that we're using a more modern version of
> it we might start relying on features that weren't available in older
> versions, and we wouldn't notice anymore. So we kind of have the reverse
> problem now.

Right, this is the "we could in theory check both" path I mentioned
earlier.

v1.5.8 is sufficiently old that I don't think we need to care anymore.
We can still take bug reports if somebody happens to use it and finds a
problem. Checking other older versions isn't likely to be that
interesting (the next version after 1.5.8 is 2.0.0, which had a higher
than usual chance of breaking things).

> >  Documentation)
> > -	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make ruby
> > +	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make ruby \
> > +		asciidoctor
> >  
> > -	sudo gem install --version 1.5.8 asciidoctor
> >  	sudo gem install concurrent-ruby
> 
> Huh. I was wondering whether we can now stop installing Ruby altogether,
> but we still install the "concurrent-ruby" Gem. But what even is that,
> and what do we use it for?
> 
> It's originally been introduced via 974cdca345 (doc: introduce a
> synopsis typesetting, 2024-09-24), but unfortunately the commit message
> does not document why we have to install that Gem now. I couldn't find
> any reasoning in the mailing list thread, either.

Er, yeah, see my cover letter. :)

-Peff
