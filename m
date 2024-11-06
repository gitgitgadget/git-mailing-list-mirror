Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6630820969F
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919069; cv=none; b=ERy5O8gPoGu+lF8p+z+W+qTO569YYPh6XjDU+XZp0Z0+oMeCmNgz/QJlifsRraWrxEc7rwcsAMPvXzAc6JMxFOYWF0V6HUCCtW62ciyvPtXA4B758ODPZclkKpU5CHfvDZTxkO4w/MLQWoc3CG/V3nTywPff3Jb1bYQlRc+81eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919069; c=relaxed/simple;
	bh=HP2Ai7YKlAOwKnbxksjSZI9DzEUL0/oYOrkoAxr32ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idc+gF8qCrskRhrQIrAR2ik60QTD4fYUbDcHsAVHcTFfikM/b8p2ctIZmEjQSmIoHqFfbBW42qgA9qnuw0BaLmmxYQIzg2jaHdK3LKmRwYw0rPoCrUoG1mtnfZxJWQDvuREoWUmACiC+GLLIpBlt5IpAVAqbqQPg7ZJrT7jxSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ys+JqJQF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ys+JqJQF"
Received: (qmail 14093 invoked by uid 109); 6 Nov 2024 18:51:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HP2Ai7YKlAOwKnbxksjSZI9DzEUL0/oYOrkoAxr32ek=; b=Ys+JqJQF4FeXQXPSRscxvNfP7CW3raGheksX4vURuv4ZIpvIGqZA/RE8w4mieuPUVuVyvGGUjP/MO0hMVPP6QtdEKLZrVzim6BILWW/Ie7q9PnD2X/W5jq1KnTdYVWYXuyOQjAaoXAGpee0Qz0aKJFuWMmMl8NWXYhKa6dJtrVmjvsMBkC+2m8FBE6n1tdcTyEPjsy4WVf1rqi3AE9Aq0KEWtMTt1UlUWxOxVQ4YKeXmbhhT1aBHy5pU91fZPVu3t1f35nwRfh8uSQ6LkJWilWy6vaJvTK9fJ8QmGIa1K4B7PPEoyvkvPTBO8QyodN7EVz2hbBxmf8LLahpWqkSfkQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Nov 2024 18:51:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7086 invoked by uid 111); 6 Nov 2024 18:51:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2024 13:51:03 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Nov 2024 13:51:02 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: values containing ')' are broken in ref formats
Message-ID: <20241106185102.GA880133@coredump.intra.peff.net>
References: <20241105190235.13502-1-five231003@gmail.com>
 <xmqqikt1qhwt.fsf@gitster.g>
 <20241106022552.GA816908@coredump.intra.peff.net>
 <xmqq8qtxqcye.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qtxqcye.fsf@gitster.g>

On Tue, Nov 05, 2024 at 07:05:13PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I am tempted to say the solution is to expand that "equals" value, and
> > possibly add some less-arcane version of the character (maybe "%)"?).
> > But it be a break in backwards compatibility if somebody is trying to
> > match literal %-chars in their "if" block.
> 
> If they were trying to write a literal %, wouldn't they be writing
> %% already, not because % followed by a byte without any special
> meaning happens to be passed intact by the implementation, but
> because that is _the_ right thing to do, when % is used as an
> introducer for escape sequences?  So I do agree it would be a change
> that breaks backward compatibility but I do not think we want to
> stay bug to bug compatible with the current behaviour here.

I think "because that is the right thing to do" is what is in question.
It is not like we happen to allow "%", but you should be writing "%%" in
an if:equals value already. They mean two different things, and anybody
who is doing:

  %(if:equals=%%foo)

to match the literal "%%foo" will be broken if we change that. They are
not doing anything wrong; that is the only way to make it work now.

I wouldn't go so far as to call the current behavior a bug. It's
just...not very flexible. I also think it is unlikely that anybody would
care in practice (though I find matching refs with ")" in them already a
bit far-fetched).

If we wanted to be extra careful, we could introduce a variant of
"equals" that indicates that it will be expanded before comparison.  Or
even an extra tag, like:

  %(if:expand:equals=%%foo)

> I am not sure with the wisdom of %) though.  Wouldn't "%(foo %)" look
> as if %( opens and %) closes a group in our language?

Yeah, I agree it is ugly and possibly confusing. Normally I'd suggest
"\" for escaping, but it isn't otherwise syntactically important within
these formats (I don't think, anyway). The magic character is "%" so
that is what we have to work with.

-Peff
