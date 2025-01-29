Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91A32F29
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738130600; cv=none; b=rNUvO+iBWpwmvCkv9r6TrhPeoAbQI9pCb75wCPTh3xBQCUJwu7I9C3c5qWgFWsro4SeOEro/l0CdHzqXIvcxuIRtc0JVwA/XakwE6zPAc7kY5HxtQ0ylncsoGZjadWtSdkz2ob9AfgrNfbT6IVV5yOyfA7FKVnQ1ftv7G3qD5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738130600; c=relaxed/simple;
	bh=eZIBGO/jZqWkNCJmpjY0Goe+rmiKNUZIAGDuFPVmCDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8X3T8KBKBcza7IvykRpzHdfL+nErwH3Pk6S6gfEref8/3C4GkVyaQfaNLw/giJZc6iepOPqxdr0eqMUbhTjavdfiFG0yDKUq9ki+C7+MF0RYdl/rXwcOhGifJrBZ207ccqqt79DT0Cg16MUgHQpakf1MhG7H8N04YqB21H2C7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WiGdZLt8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WiGdZLt8"
Received: (qmail 19679 invoked by uid 109); 29 Jan 2025 06:03:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eZIBGO/jZqWkNCJmpjY0Goe+rmiKNUZIAGDuFPVmCDk=; b=WiGdZLt8Xwc6O45KIGqB7+oZT2P8MJ455i4VJfr8d/xrg3CAPtN2NBWEq7WOFMFcABAQUskWhxCBUWaSdje7Wd7fNJco7HbECHqfPvbDbcSf9SmJfnULJ2J0vQB2pTsbcJLiSpuir1BL1McQfgCf2/vHFncUDkXKOqT/MoJfzPT8KxqxtroBWVlR+URDUnvXTZELE3G8YhyuKS8ykKLO1PFUiauSJNnI8g7mAEdIrutzP1jTG32Dzs99nz8UY0hVK2aUCcUE9Ve7w2NlFUt6AtX24rMWmuK2wimZvVAF0roGreVVej25oMvSvSKzZ+wnuDndLtOTS9Ef/gWZaaBzUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jan 2025 06:03:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26376 invoked by uid 111); 29 Jan 2025 06:03:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jan 2025 01:03:15 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 29 Jan 2025 01:03:11 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #07; Fri, 24)
Message-ID: <20250129060311.GA1712361@coredump.intra.peff.net>
References: <xmqqwmekvubv.fsf@gitster.g>
 <20250128164606.GA1688180@coredump.intra.peff.net>
 <xmqq8qquom4t.fsf@gitster.g>
 <xmqq4j1iokvv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4j1iokvv.fsf@gitster.g>

On Tue, Jan 28, 2025 at 10:26:12AM -0800, Junio C Hamano wrote:

> >> It has to be fixed in an evil merge of the two (or brian's rebased on
> >> Adam's, which has since graduated to master).
> >
> > Thanks; I had this one on my radar and I thought there was a
> > merge-fix I made somewhere, but it is likely to have been lost
> > during shuffling the order of merges.  Will take a look again.
> >
> > Thanks.
> 
> Here is what I'd directly apply to 'next'.  The merge-fix mechanism
> knows about the same change, so when I merge the bc/doc-adoc-not-txt
> topic down to 'master', the same tweak will be made as an evil
> merge.

Yeah, that looks perfect, thanks.

-Peff
