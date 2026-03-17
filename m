Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717AF3F6600
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773089; cv=none; b=jkRwBmMEzLCqNRWmOeAva3dwc6/5a8g63YTYon08RjitBO4l3xjGtz+gqYRyVGZQ1D3HUbcEMgfSqK9rqhOyiRXdLtoobzVSw3VJJLcscZ32UycTa/FB/fHtPpnsCeXfbYUqrTElYCA4HoBHaPtND3un/yaWFMCGBUWGm1Kc7hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773089; c=relaxed/simple;
	bh=tYWwToL+WtaPKa8wpaG5RSf7uKc3lB46d/h9R1MXmEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrviwxN+hrdu2yvIqGcp537fY1gl9nLFNxRLr+4wP/fia0nw2x2YEXtUAm8m+jsA3BNFm1UufR1pP9Z4Di6uArIGLyUCghNQn2q5S31DVfDzjMmSI3aga+4T83yEmNJRcdtvH4YfMFG5KwoJV8VDk54gbxQEhwdaM3shIbjOZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ctLUO8WK; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ctLUO8WK"
Received: (qmail 32036 invoked by uid 106); 17 Mar 2026 18:44:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tYWwToL+WtaPKa8wpaG5RSf7uKc3lB46d/h9R1MXmEo=; b=ctLUO8WKihJqswI4tIyiq4rA0N/HeblLbpPBm8gztrD9l2lQkMYE3ygku+QYFSPUFxlSEDYDUYwBqZPrMj+GxPWyBjuvBgH2f904MYQ2whdDhKKH/XklSjaNqbclagMCliuTnoLN2ugdCFb0ILhBIPnE0KYIVGTfxFJWwpPNTJYKQ/ZyibU1FQ9HdcChThejFLKoFx4cCJbN+9smCNiV2rSZTdGjKUKp7GyFWogvOkFdYrMi3FCLyoYmKRQMvOYL3iWWgrjEaoxEx8AS1V3mACza14vtG1hcgRDLQfYPR+PXs2989e74X08yISllp9eSmQW2NUWVz8hkMx8KtLI9zw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Mar 2026 18:44:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 48968 invoked by uid 111); 17 Mar 2026 18:44:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Mar 2026 14:44:41 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 17 Mar 2026 14:44:41 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH] rev-parse: have --parseopt callers exit 0 on --help
Message-ID: <20260317184441.GA574291@coredump.intra.peff.net>
References: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>
 <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <xmqqcy13mgdk.fsf@gitster.g>
 <ablCBkmOdoourCnO@fruit.crustytoothpaste.net>
 <20260317145543.GA1828@coredump.intra.peff.net>
 <xmqqv7eul71y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7eul71y.fsf@gitster.g>

On Tue, Mar 17, 2026 at 10:06:17AM -0700, Junio C Hamano wrote:

> > But this
> > is not just a bug fix for --parseopt, but a change in overall intent. It
> > might be worth digging in the commit history or list archive to see if
> > there's any discussion on why we are using 129 in the first place.
> 
> And if it turns out that old discussion was convincing enough, I'd
> prefer to see us moving to --help/-h exiting with 0 eventually.  I
> do not mind doing so at the Git 3.0 boundary, if an excuse to make
> a big change is needed ;-)

I could not find anything convincing. :)

We should also apply our little grey cells and see if we can think of
any reason somebody would be unhappy with a change of exit code now. The
most I could come up with is a script like:

  #!/bin/sh
  git rev-list "$@" >tmp &&
  do_something <tmp

where you might imagine it is run as "foo.sh --objects HEAD" or
something. Right now, running:

  foo.sh -h

will bail when rev-list returns 129, but in the proposed world it would
keep going and run do_something. And you can further imagine a world
where the script then quietly produces the wrong answer, because
do_something thinks the rev-list output was empty (or actually it is
worse; it gets the help output here).

I think this is mostly a case of "if it hurts, don't do it". The "-h" is
not doing anything useful (the user does not even see the help text!),
and if the script wants to support a usage message, it should parse the
"-h" out separately.

Could somebody maliciously convince you to pass "-h" to such a script?
Maybe, but not only are we getting into a series of increasingly
unlikely events, but I think that means you probably have worse
option-injection risks.

So unless somebody can come up with a more compelling example, I don't
really see much backwards-compatibility risk. But maybe I just lack
imagination. ;)

-Peff
