Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48916137C32
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549616; cv=none; b=WSxueRJdJKpHZn8aSakGwGYpjMpzU0wywQ+mLbaIUQFgQae+nQbX+ocusYcnF3kWepH5nDwGB2jvN6SPNOxVIW1NuDwUTbnwDCjOwvluEvSvzmhDPVf//dpS82YSzKKdez4kht9PLSpdxxg4Z1tbZKjqSWXXR40Pvn27lUTVXD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549616; c=relaxed/simple;
	bh=+qi/Ep6br/GzN5zGQvC4RLznyOcIOHesOPPOjduzzAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAl25IyaMT/H4I8uvGhVl8RpxP8mCDww4h4NavQ+CFVQ1PFokd2KPshpEltErJXHM3Uo5nEidS/+JXQejAfxobxZbPx7Cyx/8XyKGVhK972RRojj3052N8Vlsmm7gWRWTmUolZCqB++p1PcYrWO0NmYJ6bwsWkMujZ/u1TiSy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16603 invoked by uid 109); 19 Apr 2024 18:00:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Apr 2024 18:00:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26597 invoked by uid 111); 19 Apr 2024 18:00:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Apr 2024 14:00:14 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Apr 2024 14:00:12 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH] format-patch: allow --rfc to optionally take a value,
 like --rfc=WIP
Message-ID: <20240419180012.GA523357@coredump.intra.peff.net>
References: <xmqqzftqnuxq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzftqnuxq.fsf@gitster.g>

On Thu, Apr 18, 2024 at 03:54:25PM -0700, Junio C Hamano wrote:

> ---rfc::
> -	Prepends "RFC" to the subject prefix (producing "RFC PATCH" by
> -	default). RFC means "Request For Comments"; use this when sending
> -	an experimental patch for discussion rather than application.
> +--rfc[=<rfc>]::
> +	Prepends the string _<rfc>_ (defaults to "RFC") to
> +	the subject prefix.  As the subject prefix defaults to
> +	"PATCH", you'll get "RFC PATCH" by default.
> ++
> +RFC means "Request For Comments"; use this when sending
> +an experimental patch for discussion rather than application.
> +"--rfc=WIP" may also be a useful way to indicate that a patch
> +is not complete yet.

It's probably worth spelling out WIP here, too, like:

  ...is not complete yet ("WIP" stands for "Work In Progress").

These are necessarily going to be project-specific phrases, and readers
of the manpage may not be familiar with our conventions.

-Peff
