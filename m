Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5618038380
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706593444; cv=none; b=oRkKUfpiUeb25iT904G/Z/vz6JqzGlgGfJmwljyqPSIs7LVrAnQDjdZU/Uuj2KRDXrUVeNejpFu0z793PZb+5bn55lCEaAchuCVjK0Bs7FNQGiF6xtYp8uAas9gSS0M4qtbQEYEzMEJoRgUfQIEtTb2Lqgro0o3AJWC1TYw1wAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706593444; c=relaxed/simple;
	bh=H2k7/rSxaYJrqoGMJTfMfY3Ge9k3cxAs/G4wNTy3I8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgycG1X5ioSMHC9bly/vsMzA0KM6b7YcGgKrBilZOWEIKIbTFUJy10mt8S0o4IUPz64MZEYKQetBNzFo0GaOR8xn7O5uq82iFSUN2t9aKHapSqDGF0mAlBAZwAqiJ81sq/xhAqH8hFJ5vjfyeIRdNOSaHK5qFvQyEZOXg6qBXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8717 invoked by uid 109); 30 Jan 2024 05:44:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jan 2024 05:44:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29179 invoked by uid 111); 30 Jan 2024 05:44:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jan 2024 00:44:04 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jan 2024 00:44:01 -0500
From: Jeff King <peff@peff.net>
To: Sergey Organov <sorganov@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
	git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
Message-ID: <20240130054401.GA166761@coredump.intra.peff.net>
References: <87il3h72ym.fsf@osv.gnss.ru>
 <xmqq1qa5xq4n.fsf@gitster.g>
 <87ede56tva.fsf@osv.gnss.ru>
 <87a5ot6tos.fsf@osv.gnss.ru>
 <xmqqzfwspmh0.fsf@gitster.g>
 <87ede4fg8s.fsf@osv.gnss.ru>
 <xmqqzfwrjdul.fsf@gitster.g>
 <87jzns7a8a.fsf@osv.gnss.ru>
 <20240129182006.GC3765717@coredump.intra.peff.net>
 <87v87bx12j.fsf@osv.gnss.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v87bx12j.fsf@osv.gnss.ru>

On Tue, Jan 30, 2024 at 12:49:08AM +0300, Sergey Organov wrote:

> > Please don't. I set it to "false", because I find the default behavior a
> > pointless roadblock if you are already aware that "git clean" can be
> > destructive. Surely I can't be the only one.
> 
> Well, provided there is at least one person who finds it useful to set
> it to 'false', I withdraw my suggestion.
> 
> That said, did you consider to:
> 
>   $ git config --global alias.cl 'clean -f'
> 
> instead of
> 
>   $ git config --global clean.requireForce false
> 
> I wonder?

Not really, as when I originally set the config in 2007, it was just
undoing the then-recent change to default clean.requireForce to true. I
already had muscle memory using "git clean" as it had worked
historically from 2005-2007.

I know that isn't necessarily relevant for new users today, but my point
is mostly that we have clean.requireForce already and people would
probably be annoyed if we took it away. :)

-Peff
