Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B1A28EA69
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761420; cv=none; b=aRKI8pyaieD+KgRbtD5RoyaabwWn5haBzCWJZ4lSGgyoPZu6eVZG8zW8YXgfOnQM0mllH6bfCQqhFa9OuFtJqGM0qBnQCRHDdu2urIEivEhgTlXWuBR6UCY+tJpFm2eWuRy31J1EWRMc6Y7Cm/RPw2JSvm0eXzuOipTEXa97zCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761420; c=relaxed/simple;
	bh=tK+g7GALwDJaDJF1sIe1oF4BkLkGdCa1nyil9yLrZHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6oIpXYh8TjVy9iMmS5mRrSwEAJVU6mcAJZEWuwDsPKeRb7qXuZpoYI+dKEu5AioTq4pxQV8jlz0m5Wv7JfTgsJxYliQTvHXLS4PsKJl55jsQV+Mbu/TsOOC0C12M4mNsZ1iqsodR4DPbVz7HAw2mDAVX/zS3n+scWIE9Hm8254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YsSzCN6K; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YsSzCN6K"
Received: (qmail 17842 invoked by uid 109); 24 Jun 2025 10:36:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tK+g7GALwDJaDJF1sIe1oF4BkLkGdCa1nyil9yLrZHw=; b=YsSzCN6KNaD5Nyf3H/4T/KrBZ04bj7AXIdmh2mPZpg9OYznYNIlOJU1q8LA7PySBhcpFQlyX4teduSLN3LLOk1koglECyb6KT0LHrlOCtNMR7ZXruuVSOohI6bsONZnsJGXvmww0EOGIkZpSrqJNL+F5vq93p2uPQuUoQSuzp7bILEFPzlgDp7UplsJ3a9+bh6M4ZvqWnn7Bqak7Jmxv/mdedGh9qsAwZ6AyDuo7zrTKFKh2+bWx/XSkhj5G4O10P30VGD4NsKiFwMg4b+7tkk0QGjkCJyWOLKUgxOjU/LfWTJkFbdemF8AmkWAZUvKRJTdH/Mh9Z4Aoms0Nkdo/2w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Jun 2025 10:36:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29572 invoked by uid 111); 24 Jun 2025 10:36:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Jun 2025 06:36:57 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Jun 2025 06:36:52 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] test-lib: teach test_seq the -f option
Message-ID: <20250624103652.GD636332@coredump.intra.peff.net>
References: <20250623105516.GA654296@coredump.intra.peff.net>
 <20250623105625.GB654412@coredump.intra.peff.net>
 <CAPig+cQNWVd7M5pe0te9os3NRrjfBSSaUZjUXKX8RUdTk50SFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQNWVd7M5pe0te9os3NRrjfBSSaUZjUXKX8RUdTk50SFw@mail.gmail.com>

On Tue, Jun 24, 2025 at 02:22:21AM -0400, Eric Sunshine wrote:

> > diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jgit-compatibility.sh
> > @@ -112,14 +112,11 @@ test_expect_success 'JGit can read multi-level index' '
> > -               awk "
> > -                   BEGIN {
> > -                       print \"start\";
> > -                       for (i = 0; i < 10000; i++)
> > -                           printf \"create refs/heads/branch-%d HEAD\n\", i;
> > -                       print \"commit\";
> > -                   }
> > -               " >input &&
> > +               {
> > +                       echo start &&
> > +                       test_seq -f "create refs/heads/branch-%d HEAD" 10000 &&
> > +                       echo commit
> > +               } >input &&
> 
> I had suggested[1] an effectively equivalent change to Patrick for a
> couple tests in the nearby t0610, but he rejected[2] the idea due to
> the pure-shell version being significantly slower than the `awk`
> version.
> 
> Pondering his response today, I wondered if it would make sense to
> replace our pure-shell `test_seq` with an implementation via `awk`,
> however, if most of our sequence vend only a small set of numbers,
> then the startup cost of `awk` would probably swamp any savings,
> especially on Windows where process startup is extremely slow. Taking
> that into account, I further wondered if we could see an overall win
> by taking a hybrid approach in which we employ the pure-shell version
> if vending a small set of numbers, but fall over to an `awk` version
> if vending a lot of numbers, especially as in the test above or the
> tests in t0610. Anyhow, food for thought, or not, if you're not hungry
> for thought food.

Ah, interesting. I didn't time it at all, as my general intuition for
shell performance is that counting process spawns overrides everything
else (though admittedly it is usually O(n) processes vs O(1), and here
we are going from one extra process to zero).

I did a few timings, and it looks like the shell wins at 10,000 on my
system, but awk wins at 50,000 (though there is a lot of run-to-run
noise; I think awk might even win at 10,000 on a loaded system, as this
is such a light load that CPU frequency throttling comes into play).

I assumed that the culprit was a lack of buffering, but I don't think
so. awk seems to issue 10,000 write() calls. I guess it is just internal
shell overhead in issuing commands. Where is a JIT byte-code shell
interpreter when we need one? ;)


My inclination is not to worry about it too much. At 10,000 I think we
are talking about a few milliseconds. There's so much more low-hanging
fruit if somebody wants to optimize the test suite. IMHO readability is
more important here (and if we really want to optimize, doing it inside
test_seq would be better).

-Peff
