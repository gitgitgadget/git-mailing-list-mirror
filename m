Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3E3CA491
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983497; cv=none; b=HGOq8kydVPpLhcM854PNI4n1jPL3020+7ySa8sf0Ys6i0nWWLvZRZ8QQqK8GC5L/gmSYOyLaKfdRAY+WdPzR0ObVkL9bhwaHhL2T8Nyn5fojBa6Vv7MnD9SyYSudol6XTU4IG5lSh74FCGQ/i0miX2scwbOQ9Yum6J0Jg8eUAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983497; c=relaxed/simple;
	bh=44RGxnmCaPRxRGHoAgScvYxXY/qPkLIaQVKOWYuoXXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0XpJjAnyolXBIzEiffSRTFD1+LxuzkLe4O7Nuc162QA2zGDMe6V5MU0ZPfBN34i3MFedQ4+SMdh9U8L/OvKivODJecWHzBPEqraiPDKLhq82fB8huBwPMmhoRUlkt+FgZLhuTDgghBvRJkmhI1KpdmUI0H/R2DrzLeYflVYnQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OsooEJ/r; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OsooEJ/r"
Received: (qmail 28845 invoked by uid 106); 9 Sep 2026 19:51:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=44RGxnmCaPRxRGHoAgScvYxXY/qPkLIaQVKOWYuoXXg=; b=OsooEJ/rrizlgUH/M2GqAgE2fs1fLIo/QTuYnz9a9NMxjAS8IW+4yWdxVygGmHljYFFqj8iqSy+0fYZ13KbOWxAq0URWm9lK3c1Zyo7MkjYsPvHtd98hDFX0hQlbLKdMUIPr7phGF2qs0Qd6+XRDHU9CXDAjCGbnRj5gcYHz5im9UxKf2JxvY1r5fTRw+Qvs39BtVF994hkg6XalfLg0CXbhFxXZkhlsNNZvAZd0HDKaC05c/VQ8rTWhs3DrGocNCR0wTiZzwybK5IIgtBCn1w3qbltt2dasNLOIZC6vp8FcTCY2hKkOAfrsFZoL/tCso8fvL7sAVq64VMrA23TiNw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Sep 2026 19:51:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 146433 invoked by uid 111); 9 Sep 2026 19:51:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Sep 2026 15:51:33 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 9 Sep 2026 15:51:32 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>, ben.knoble@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH] advice: use global config for default branch name
Message-ID: <20260909195132.GA182066@coredump.intra.peff.net>
References: <xmqqik4fyaav.fsf@gitster.g>
 <20260908213840.37833-1-ub4nal@mail.ru>
 <xmqqik4fwoz5.fsf@gitster.g>
 <20260909155440.GA94069@coredump.intra.peff.net>
 <xmqqv78eqmw8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv78eqmw8.fsf@gitster.g>

On Wed, Sep 09, 2026 at 11:51:03AM -0700, Junio C Hamano wrote:

> > will. So there are many missed opportunities for offering the turn-off
> > instructions. Nobody seems to have complained, which makes me wonder if
> > the turn-off instructions would be annoyingly chatty if we printed them
> > all the time. Most of those calls predate the addition if the turn-off
> > instructions and advise_if_enabled(), which was added in 2020. I wonder
> > how people would feel if we converted them all and started printing the
> > turn-off instructions everywhere.
> 
> Depends on how we do so, I guess.  Do you mean we should rewrite
> advise() call above to advice_if_enabled(), even though the check
> for ADVICE_FOO token appear redundant?

I mean we could mechanically rewrite:

  if (advice_enabled(ADVICE_FOO))
	advise(...);

to:

  advise_if_enabled(ADVICE_FOO, ...);

So the check wouldn't be redundant, but rather folded into the helper
function. The code becomes shorter, and the user-visible behavior
changes to produce the extra "turn-off" message.

> > Anyway, UI philosophizing aside, another obvious pattern for advise()
> > is:
> >
> >   if (advice_is_enabled(ADVICE_FOO)) {
> > 	/* do lots of work */
> > 	advise("try %s", results_of_work);
> >   }
> 
> Yes, checking with is-enabled primarily for the purpose of skipping
> "do lots of work" is a very typical use.  I do not know why you
> assume ...
> 
> >
> > which _wouldn't_ want to convert to advise_if_enabled().
> 
> ... this "try X" is something the users would not want to learn how
> to disable, but assuming it is not, the existing code above as-is
> should be what we want.

I meant only that they would not want the same mechanical conversion
above, because that would lose the ability to avoid the extra work.

> > I guess the caller could just do:
> >
> >   advise_if_enabled(ADVICE_FOO, ...);
> >
> > inside the block. We know that it's enabled, but it's not like the check
> > is expensive.
> 
> Yes, I think we already have some callers that do so, in a pattern
> where they want to skip the "do lots of work" part.  Or at least I
> think I suggested the pattern in the past for somebody who wanted to
> do that.

I think we do the same thing with trace_want() in a few spots.

-Peff
