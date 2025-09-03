Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141261917FB
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935861; cv=none; b=gaMuHPQoB0nTvfHtHF7N/lmtbG3yKPUx1bRG8WJ2AUrYeHfWw8+dQTLcukiqRFnq8OzR+dmHeStBvpNGpqC33fkhMyrTKs0dd5rf9UO9Ybbc/wQaAmMAWZPPgHFaz4ClogFfR9OTuVYkJzbDjb/y8GSjI3iyGiRV/H/cTcZHQdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935861; c=relaxed/simple;
	bh=6gzV1IGPJTcFnIuOqemY2fVuZV0hm67+I/Wz65a6Deo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvUGEAZ5lvU5SOXG3x2DT4o54CNkyjwGPMujKgj8nDQtbMvZ0N2IxayFuxHwjOa7qVVoOVORe0A7NrY8cJuvD+qtJD3dwmNgT0cYjoUTjld1NbHKQxrp9G1SJ+4ToSZqkMwLRKUBcGbesrtdUtic4GgRGg3Qo7nxsQhTjX/EMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ByAZiFAy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ByAZiFAy"
Received: (qmail 196357 invoked by uid 109); 3 Sep 2025 21:44:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6gzV1IGPJTcFnIuOqemY2fVuZV0hm67+I/Wz65a6Deo=; b=ByAZiFAywv+nW8GZLF+fE01AGG6jJJKqPdImhf5ymCutxB8zWRjfUQLWvs6W/7nYolNcAfCFIjrOzzD0TwKJDHKXbh0U2+FTjmucEIc91gJKJ7U7KGsyQn6ZIRld1BpYt1LXzzdO871w59H6c+ZhgIY2YL3SguKiW7GO5ZMXvXPkEbOChRH3Ivr936gQNH1X/npmmGEAKEiYVwbJkkMi0B7a3V/ILG4mDivBF22JnaCIhu08UZaj8ckImsusuItIpYgxPSVPp7OumIYtGgx3t4Be1mt4c4DcthR0mEXFhtQxApFOOUAuNJQlAPwW0RylbLiq1ApBDH6r45uM2Nd2og==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Sep 2025 21:44:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 348013 invoked by uid 111); 3 Sep 2025 21:44:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Sep 2025 17:44:16 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Sep 2025 17:44:15 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] usage: help the user help themselves
Message-ID: <20250903214415.GA1915988@coredump.intra.peff.net>
References: <cover.1756311355.git.code@khaugsbakk.name>
 <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
 <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
 <CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
 <xmqq349czcl8.fsf@gitster.g>
 <CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
 <CAPig+cSL=-gD5+WomF7-hYjVJ_PH0m+0i8g3F=E_U3k=QNHr8Q@mail.gmail.com>
 <15bb8d07-675b-4ccd-8345-ab5861319faf@app.fastmail.com>
 <CAPig+cQdwr-a_B++=2+q4mV8oZ7VLTYEQ9wnVP84jFYkTHFtHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQdwr-a_B++=2+q4mV8oZ7VLTYEQ9wnVP84jFYkTHFtHw@mail.gmail.com>

On Wed, Sep 03, 2025 at 05:21:47PM -0400, Eric Sunshine wrote:

> > I've seen  "troubleshooting" questions from git users
> > who got one of those long and well-described Hints
> > like e.g. detached head and default git init branch
> > when either the msg already spelled eveything out
> > or the msg was purely informational.
> 
> I didn't spell it out above, but what I had in mind was something very
> simple... not at all ong and detailed; for instance:
> 
>    For interactive use, define a Git alias `git whatchanged`
>    which runs `git log --raw --no-merges`.

I think that is good advice, but... it won't do anything until we
actually drop the whatchanged command, since until then we'll refuse to
override the command (even the crippled --i-still-use-this one).

We'd need something like the patch here:

  https://lore.kernel.org/git/20250830022718.GB567900@coredump.intra.peff.net/

-Peff
