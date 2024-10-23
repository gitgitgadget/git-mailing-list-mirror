Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0697515746E
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720590; cv=none; b=h51CvWHOxx153gztQ6yL43Fc8ungbXHaKXkJAcdluSe9KWilGXjYVdYk98ufYZsjATS1h4140w4rAYqg8vXThCdfUYIS9NisjIFE+WhKt4opQWG4LmJLp3tV13+2P3AauY9+YzVFpmKKz+TdSNHDIy8kiFINlnGQAfJtvhpsGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720590; c=relaxed/simple;
	bh=ycCYjhUglwCOziKLK+2OlL9FB6xhxuNsKQpEQEE9PQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrzX4+XcxefdYWSD/9TgKzkg07UH2qWln9UXj1ttghr3YlUVJHJG+tjadeb+tNk9ZVAVRjBqJWrZ+Zhci0hubVrEiwPEFMdhqbEc2LncWqdAafKdB8laOA8L1FcGRJOoikW8tfWyBrxsDe7miqZQR76y0HbDD85BO0XyETBmkSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=L2X7+OYy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="L2X7+OYy"
Received: (qmail 16313 invoked by uid 109); 23 Oct 2024 21:56:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ycCYjhUglwCOziKLK+2OlL9FB6xhxuNsKQpEQEE9PQQ=; b=L2X7+OYymnWmYiSo7D7tS+2sfNWIfuNiISiQTBVn3+UlxHsjUIP3Nch3d7VofFelOMsvB6zmKE0HS4I2W+6Q9cRIQxQ4BTNIu/lHwEHlh4doHsbrjd5fNQoBLrgsnLaIH+LwQsaNbON1oRxgaaFEq9H2mGlDa+BSKDN2KkJ8mJpHdnd3yij2fux4euHwd6CAPecYHpj/ZYt8Gijdoc1A02Mc/nV00AmzsCLTv9jnaVzpcj7fxpXDSSB1YvXMnQIOpVzk+kA8gClef48KhDtmmBxpk44w8UkxPwpNRwaxfcH7soElleoHEXCAoJD4KP7GM8r38xC5Ya4BB0wC1wVBFA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Oct 2024 21:56:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28520 invoked by uid 111); 23 Oct 2024 21:56:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Oct 2024 17:56:18 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Oct 2024 17:56:18 -0400
From: Jeff King <peff@peff.net>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [RFC PATCH] object-name: add @{upstreamhead} shorthand
Message-ID: <20241023215618.GA821188@coredump.intra.peff.net>
References: <20241020202507.2596990-1-bence@ferdinandy.com>
 <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
 <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com>
 <20241021191441.GD1219228@coredump.intra.peff.net>
 <D51R90BTHJMY.1C1XY5P4CHTWG@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D51R90BTHJMY.1C1XY5P4CHTWG@ferdinandy.com>

On Mon, Oct 21, 2024 at 10:09:38PM +0200, Bence Ferdinandy wrote:

> > And possibly we could make it easier to just grab the remote name with a
> > single command.
> 
> As I was running this patch through my head yesterday I sort of distilled my
> argument in favour to "writing remote agnostic scripts are unnecessarily
> complicated", but I do agree, that if there were a git command that could
> return the remote for a branch without any extra scripting hacks would easily
> get you the same result, and may even be useful elsewhere.
> 
> I'm not sure where this would be the best. Maybe: 
> 	git branch --show-current-remote
> ?

I've been giving some thought to this.

You could argue it's about querying remotes, so "git remote". Although
we don't really want to know anything about the remote except its name,
so it's a little weird.

Or as you note, we're querying info about a branch. So "git branch"
makes sense.  But "--show-current-remote" feels kind of narrow there.
Shouldn't we be able to ask about the configured remote for any branch?

In which case it is really just a single "git config" lookup away:

  git config branch.$branch.remote

You have to look up the current branch, of course. You can do that with
symbolic-ref like:

  git config "branch.$(git symbolic-ref --short HEAD).remote"

You might get an error from symbolic-ref if we're on a detached HEAD, of
course.  You can either ignore that (in which case the lookup of
"branch..remote" would show nothing), or a script can actually
distinguish the two cases ("not on a branch" versus "there is no
configured remote").

There's also another wrinkle we hadn't discussed: we have the concept of
both an upstream remote for fetching and a push remote. And this would
naturally extend there (you'd ask for .pushremote instead).

And finally, there's yet another way to access this information. ;) The
for-each-ref formatter (which is also used for "branch --format") knows
how to show remote names (and much more). So:

  git branch --list --format='%(upstream:remotename)' $branch

also gets you what you want. I don't think there's a good way to ask
that command to show just the branch pointed to by HEAD, though. We
recently added --include-root-refs to for-each-ref, but that's not quite
what you want (you want just HEAD, and you really want to dereference it
to show details of the branch it points to).

So I think rather than "branch --show-current-remote", we'd want
some option to make "branch --list" show only the currently checked out
branch, and then you could apply --format to it to get whatever
information you wanted. Something like:

  git branch --list --is-head --format='%(upstream:remotename)'

-Peff
