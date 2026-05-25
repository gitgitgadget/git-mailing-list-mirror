Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B13D1AAC
	for <git@vger.kernel.org>; Mon, 25 May 2026 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694034; cv=none; b=H1mo21J/965S/DROBJNXDw4odP6waHOFZWAaFfqwrQ/7hlZWus7pBAEU0cI+EKYWUAuMjytLCCHeXDaVMoMv+jnS9cnns83Mey0jsXBUWXdmlfHaRFrocjix4anzvpTUkCLDc07ZiDBMrWLgGRfOIdu5FXFjqQkwB0+p8Gevrn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694034; c=relaxed/simple;
	bh=aT8iBoG338ZgBNJq6UTQd8hruoNAffNGOFTPC3bp4nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLFSc2an7aGCzg5dtRgoWB33TwCxJKbRfRW5sTCPVt6uatz7uE4oohjwiSR4MRvrBSJkr74ufpXf5JxEXb1GtpF8KDWkD6Fd8HO9vBZGjke9ZEcJdY1XcdrezYqrqcxzmC9HrmbkG9H16Ah7K0LQOrmzfn0Uru+JgyPkB7g+hAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OtVfmntH; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OtVfmntH"
Received: (qmail 10155 invoked by uid 106); 25 May 2026 07:27:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aT8iBoG338ZgBNJq6UTQd8hruoNAffNGOFTPC3bp4nw=; b=OtVfmntHZ6NtBXBTN/BPh0+PMRuu8+IAgleEZGiLVjnYrS/0M3KGx+v9hRh1lfaDE6HYg0HbQdMGryfChh8yrPj40b7c5+xO/tQH4/wzjYz4PkOXpVYGtg2SDLea4IafU0FLUcdWRc2K8tTEu5fIwd0+Qz9n9rhucK9qBgL+1MyXCc+tEGWTda95opkwvYy+5bgKKCMlZpojPWjukEWRAm/s/s2fFbEOrVAZF+6mxc9MRrr9JAaN+8KRBBySxWCJMgUwNGz/ytMfb+vYt+WB5vqVYykByKzwRKGUIIHo0WPJ1QtonC3nzJT/h4LMmddQR7ep6DY+X0QsPtJ73vGI6Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 May 2026 07:27:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13873 invoked by uid 111); 25 May 2026 07:27:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 May 2026 03:27:16 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 May 2026 03:27:11 -0400
From: Jeff King <peff@peff.net>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: amoghdambal1@gmail.com, git@vger.kernel.org
Subject: Re: Expected test suite behavior
Message-ID: <20260525072711.GE2737798@coredump.intra.peff.net>
References: <CAC2QwmKgQW2c6_OhepsB1hzXYHxpX0X4eyQS0dPcxRZLOnCdig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC2QwmKgQW2c6_OhepsB1hzXYHxpX0X4eyQS0dPcxRZLOnCdig@mail.gmail.com>

On Sun, May 24, 2026 at 11:20:54PM -0700, Michael Montalbo wrote:

> Amogh Dambal <amoghdambal1@gmail.com> writes:
> > Hey folks,
> >
> > I wanted to get started hacking on/poking around the Git source, but I'm
> > seeing some behavior with the tests that I can't quite figure out.
> > [...]
> > Is there a README/documentation I've missed reading that can help
> > explain the behavior I'm seeing?
> 
> Hello. If you run `make test GIT_TEST_OPTS=--verbose` or uncomment
> L16 of t/Makefile is there more information describing the issue?

You can't use --verbose when running under the "prove" TAP harness
(which the OP seems to be doing). You can use --verbose-log instead, and
then output is in t/test-results/t1234-whatever.out.

However, when debugging tests I find it easier to focus on a single
failing test by running it individually, like:

  cd t
  ./t1234-whatever.sh -v -i -x

That will stop at the first failure (-i), showing the output of all
commands (-v), and additionally enabling shell tracing (-x) so you can
see which command in the test failed.

-Peff
