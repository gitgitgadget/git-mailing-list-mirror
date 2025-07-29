Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E0125D535
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774013; cv=none; b=YY63/TQUz8hk/xcxssFhy+NKX8KpHgn/6JHl7vKATLolBDbjj0+++FbUpDOWtcLgimXQ33PXvqDqYFZPPfSudLhYXoFaVBkPZyWuVT4prOpMGfNNmJ8EPK5tZo21nbIOShm8tOJhCkgub77KjkZMuxxO3DJb59qgYERjfDCY8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774013; c=relaxed/simple;
	bh=Wxje4bKr2v6Degn0TP/EAE09piHFjdZNksLMHyjvwn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af+th2TdGhlT3tipFhz9xvh7cbEHy5J6S77QwsKgBY24Tu1fuHHzkrdOwNV0rJv10zDqKBVBT8rZXDkgyBOF9aDY7v1ZwDXNM7lQnJohccqK//RmslYNz+T/UzokVm4Smgpmn8U2chvvUj1p4BP56Y+xv7IjnaDFu/5Zo/UJlVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WQ6qonM+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WQ6qonM+"
Received: (qmail 2287 invoked by uid 109); 29 Jul 2025 07:26:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Wxje4bKr2v6Degn0TP/EAE09piHFjdZNksLMHyjvwn0=; b=WQ6qonM+m6alg3SuOE1pJcurB/AxCulIrGaS3vj3TFj9tvyQrpUS+hcfMFj1tGd0jAYu7cXnw2OhBeQ1zpvz2AjxZQGUDoHdH7Pgl6tCk8QijWPSq4KgAs0jJT0oVwdpDbKn7vVfYhCRMH/Z3iaLgrTeB70ggFD4qa0Q/Awd3897GzO/b2zMCCSjpTtso3XdXZVxTFymZM5+Vv1GZ+Teqkn3hhfCRd4qdT2o0kOpa3zi2YG3SG8AQYj1a45bDUkwOl8r6k23cCJxF8/+XwTtZ7Rg9XZBbZoRoR+FvLzuBWqD+CwFpu3O51VmmxyYDF9cy4yrPyQN++62sLXGP1kQuw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Jul 2025 07:26:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30609 invoked by uid 111); 29 Jul 2025 07:26:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jul 2025 03:26:55 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Jul 2025 03:26:50 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>, git@vger.kernel.org,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH] git: show alias info only with lone -h
Message-ID: <20250729072650.GD1426859@coredump.intra.peff.net>
References: <1c3a0463-36ee-4a2d-92e0-fac9c0bf77da@arm.com>
 <a35dc2bf-015c-472d-9528-6763f7aac180@web.de>
 <xmqqqzy33k1j.fsf@gitster.g>
 <20250726081254.GA3042329@coredump.intra.peff.net>
 <xmqqfregzb0r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfregzb0r.fsf@gitster.g>

On Mon, Jul 28, 2025 at 06:43:16AM -0700, Junio C Hamano wrote:

> > I guess one way to deal with it would be if the user runs "foo -h", and
> > alias.foo is "bar --other arguments", then we run just "bar -h",
> > dropping the extra arguments provided by the alias.
> 
> It is much simpler and saner to just stop after giving the alias
> expansion, isn't it?  Nobody can get hurt if we did so; doing
> anything else would be driving us into further corner cases that
> would either confuse or harm the users.

Yeah, my suggestion was assuming that it is very valuable for "git foo
-h" to not only print out the alias but to automatically print git-bar's
help output. I don't know if people would miss it or not.

But...

> > I'd also be happy if on top we did:
> >
> >   1. When alias.foo="bar --options", turn "git foo -h" into "git bar
> >      -h", dropping "--options".
> 
> This smells like piling more voodoo magic on top, which I am not
> enthused.
> 
> >   2. When alias.foo="!bar", report only the alias and do not run "bar"
> >      at all. The collateral damage here would be:
> >
> >         !git bar $(some_shell_magic_we_need)
> >
> >      but IMHO that is not all that bad. If we report the alias content,
> >      the user can probably figure out which "git help" to run next.
> 
> This I very much like, and further, I would prefer to do this for
> all aliases.

...yeah, after having slept on it, I am tempted to say that it is not
that valuable. And the best thing is to just stop running the
sub-command automatically entirely, whether shell-based or not.

-Peff
