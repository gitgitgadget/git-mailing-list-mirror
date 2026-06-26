Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A3283FDC
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782517397; cv=none; b=Jzu6RyxglUUGDibdLbmENxlsm1FrKNXBU9TCzbhhzUvS8MybEf07Lc3a594zP0Wn2wHLPg/zdBzmvNBZrkwSdPK8iyPKEt+aTcGfVruZIYxY/YmZ7lvzP0xz1+4ZPs6k7ifjiW9Fe27MmZocP2OTMt8BlEE62Rz8cZ5zSz6NK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782517397; c=relaxed/simple;
	bh=3zWp1qaR3bcoeNkGt7htpq1dZdyqT+hW6jmEGUXg0LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxssxeZ0cHpz1T0CsCq3o1SXAfbUAR1WcbFUcwRObeN7wJVxvQX7GNfsNTWaLIKNdTPgg9KPxFqMf6oOvb5/a9vjF+kplRJKtAuNDbzZkaY9v0gqXcg4L55sMP3CVW19867wKvteoT9FhkiJ3zf5rxc+05O4HCmdSQHfnx17AJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SlaZ+Zw8; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SlaZ+Zw8"
Received: (qmail 43642 invoked by uid 106); 26 Jun 2026 23:43:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3zWp1qaR3bcoeNkGt7htpq1dZdyqT+hW6jmEGUXg0LM=; b=SlaZ+Zw8LZ1bkK+reX2Shqq0MF4MJg4kRWpoaSONJMoEaEHe3OgKPJc42eSZDf9h3M18h/P9UdgB7zJeL7aRNqwln3bUm0LZZETdOHwmN+li8vsLO2O6HGjXVNMJ6sbR0myfAwx18snqXtEp2TmzmmqGRR1GHTf8ebVe58jisvNEFIMTPcmLI8/n9qPtXk3yMLR+7XO+VmE3fkWIra3vFOAmNGDv4d5XYHqm0Tfwi/d4833zRbfgmp7uVTqnkDMmSHPz1+sjEtY0xn4vmw6Q+pgnHgZwd5DJoV2P853ndrrQ0Yyur+lf9KAF8EYdc/wrssFWhlshClXvDCtrVpjG4g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Jun 2026 23:43:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 89777 invoked by uid 111); 26 Jun 2026 23:43:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jun 2026 19:43:13 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 26 Jun 2026 19:43:12 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
Message-ID: <20260626234312.GA3156205@coredump.intra.peff.net>
References: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
 <20260621213407.GC2297179@coredump.intra.peff.net>
 <aji9MOE-NTHKXYqn@pks.im>
 <ajkEzhdqzmAePk_P@pks.im>
 <ajkGkB2ckf3p43QR@pks.im>
 <ajkOoRhqaAcy6gBg@pks.im>
 <CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>
 <20260626051657.GB3138423@coredump.intra.peff.net>
 <aj5ZaZK7xylfs4Xw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aj5ZaZK7xylfs4Xw@pks.im>

On Fri, Jun 26, 2026 at 12:50:17PM +0200, Patrick Steinhardt wrote:

> > Thanks both of you for digging into this. I'm not familiar enough with
> > Apache's code to pass confident judgement, but your findings certainly
> > convinced me that this is just an apache bug.
> 
> The bug manifests both with HTTP/1.1 and HTTP/2 though, so this wouldn't
> fully fix the flakes we see, right?

If I understand the situation correctly, there are really two problems.

First, the EXPENSIVE tests in t5551 sometimes trigger a timeout with
Apache's stock settings. This presumably became a problem recently due
to 7a094d68a2 (ci: run expensive tests on push builds to integration
branches, 2026-05-08). The same problem exists in t5559, which just
wraps t5551 but tells us to use http2.

This timeout will cause test failures in t5551, because we aren't able
to complete a request we expected to. Obviously bad and annoying.

The second problem is that when Apache hits the timeout in HTTP/2 mode,
it hangs forever. And then the CI job hangs for 6 hours until it's
killed, which is an even more annoying failure.

So the root cause is the same (a timeout), but the effect depends on
HTTP/1.1 vs HTTP/2. I was able to reproduce both cases on my local
Debian unstable system by dropping the timeout as you suggested. Running
t5551 with GIT_TEST_LONG yields a failure, whereas running t5559 yields
a hang.

We can mitigate both cases by bumping the timeout value, since it's
addressing the root cause.

There's an open question of whether this is just papering over a problem
that real users might experience, and whether Git should be doing more
to keep the connection alive. I think it's probably OK to ignore this in
practice. This is an intentionally large request being served by a very
underpowered platform. The default apache timeout is 60s. If a
real-world server is seeing ls-refs requests take that long then they
probably need to reconsider some other decisions, from ref packing to
better hardware to dropping some users. ;) I don't think trying to
insert keepalives at the Git layer here is worth the trouble.

To give a sense of the time options, here are a few timings from my
local machine, timing "git upload-pack . </dev/null >/dev/null" in
t5551's big repo.git (that's a v0 advertisement, but it should be
roughly the same work as the v2 ls-refs).

  cold-cache, refs not packed:
  real	0m9.973s
  user	0m0.354s
  sys	0m1.364s

  warm cache, refs not packed:
  real	0m0.410s
  user	0m0.153s
  sys	0m0.257s

  cold-cache, refs packed:
  real	0m0.149s
  user	0m0.086s
  sys	0m0.035s

  warm cache, refs packed:
  real	0m0.069s
  user	0m0.054s
  sys	0m0.016s

So 10s is pretty abysmal (and on an SSD, no less). I would expect the
cache to be warm (we just wrote these refs!) but I could also believe
that CI systems are under heavy I/O and memory pressure, so we sometimes
end up crossing the 60s mark.

So bumping Apache's timeout to 600s or something would probably be a
fine mitigation. That's still not _solving_ the problem, but presumably
an order of magnitude is enough for it to never come up in practice.

Michael suggested packing the refs as a mitigation. I was lukewarm on
that in my previous email, because it wasn't clear to me how close we
were on the timeout budget, and if it would just make the race less
frequent (rather than never happen). But seeing those cold-cache numbers
makes me think it might be worth doing just on principle to make the
tests more efficient, and any timeout mitigation is a bonus.

Of course the pack-refs process (and the initial ref writes) will still
have to touch all of those loose files, so those will still be slow. But
they're not on a timeout, and I suspect we read the result many more
times than we write/pack (the test failures we are seeing are not in the
expensive tests, but just "normal" tests that are stuck with the
gigantic ref state).

-Peff
