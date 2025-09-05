Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831D19539F
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077923; cv=none; b=MUkJf0QwvtOWk0cEScbW2RCkTPfjAP7gWZeRH0/ghDjlisCeIOE5879+Tsi+hHopfKQXGDZC0d7+3Gjbpshq21/CSJij4Gp6LGx6JbTmIOd811L9IUHUyFjDDDyclc6sjZumgk6BehhSsa6gBcyCAWNJ8IDBOpMdIz0H+ZGTpuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077923; c=relaxed/simple;
	bh=vn/Sk6RV8gofyAhMKE6flBUtupGzrYcZXuJfhbSSPjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRXP/A5KsVOabWavHbaugBgb1B/weAHwUZW3Z0YBAxZu/YCFLv6w7+pbDbPKs9jcYR1N+4fzphS30PvySR9Hx02rMssmqs0gVjhKIb9PK1zsfFra4BAfflkM58E/wqEwmI+6Os3Xc7ySeDqDEJG7FWnv+VLTJEP69rxAW1p2fJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ysw8FJjx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ysw8FJjx"
Received: (qmail 217339 invoked by uid 109); 5 Sep 2025 13:11:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vn/Sk6RV8gofyAhMKE6flBUtupGzrYcZXuJfhbSSPjw=; b=Ysw8FJjxEbeJLcVk1gYlrZFoIFOa0rQ5x0GtsK3mpIRm4W4lwz2ZtakP7FMA6baFABGVdG0sa9nWILPv3wvW7qM5/0mtG/cAnU3++3C30K13uWcMSdNxAkJgh6vBYaW23xMiCz+1F4zUY65LaoPvLk+DYku96GOkr/Jk0AZ7CEyXbwTa2nhPD/Q0im3kJF+btmN75SYrtfBHHRb40zJ0bF4NSN95HWzHOu5KkFh3OgnSPIHiCcTnOdy2ts90ZGovSqXe0QBs6Q0agW2fk4Zm6tmtcHmSTsYpKiCnsjlhWvNlCVKR/Yee/Ye55z0XDgnKFEr5UzfaZLcaboH1B9NCzQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Sep 2025 13:11:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 374566 invoked by uid 111); 5 Sep 2025 13:11:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Sep 2025 09:11:59 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Sep 2025 09:11:58 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] usage: help the user help themselves
Message-ID: <20250905131158.GA596956@coredump.intra.peff.net>
References: <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
 <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
 <CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
 <xmqq349czcl8.fsf@gitster.g>
 <CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
 <CAPig+cSL=-gD5+WomF7-hYjVJ_PH0m+0i8g3F=E_U3k=QNHr8Q@mail.gmail.com>
 <15bb8d07-675b-4ccd-8345-ab5861319faf@app.fastmail.com>
 <CAPig+cQdwr-a_B++=2+q4mV8oZ7VLTYEQ9wnVP84jFYkTHFtHw@mail.gmail.com>
 <20250903214415.GA1915988@coredump.intra.peff.net>
 <CAPig+cTN9vwoquOKCRz9TXRLtwHaxF-mL6xbbXxUmoHxZkW5rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTN9vwoquOKCRz9TXRLtwHaxF-mL6xbbXxUmoHxZkW5rA@mail.gmail.com>

On Wed, Sep 03, 2025 at 06:11:30PM -0400, Eric Sunshine wrote:

> > > I didn't spell it out above, but what I had in mind was something very
> > > simple... not at all ong and detailed; for instance:
> > >
> > >    For interactive use, define a Git alias `git whatchanged`
> > >    which runs `git log --raw --no-merges`.
> >
> > I think that is good advice, but... it won't do anything until we
> > actually drop the whatchanged command, since until then we'll refuse to
> > override the command (even the crippled --i-still-use-this one).
> >
> > We'd need something like the patch here:
> >
> >   https://lore.kernel.org/git/20250830022718.GB567900@coredump.intra.peff.net/
> 
> Indeed. I saw your patch in the other thread and had it in mind when
> composing my earlier email, even though I didn't specifically mention
> it (though I probably should have) since I was more focused on raising
> the point that -- given the recent spate of muscle-memory /
> mnemonic-value argument emails -- the existing hints in Kristoffer's
> patch series may be insufficient to quell future emails.

Heh, I should have figured. I didn't see any response in that thread, so
this was my attempt to pawn it off on folks who are more interested in
the topic (and working on the advice half). ;)

-Peff
