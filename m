Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A237FF60
	for <git@vger.kernel.org>; Mon, 11 May 2026 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530252; cv=none; b=bld39YJwRZ+QbXqVYLcDlouEXVxVqSToRyFT2Sn93WyFSXwGGv4cXh3EkgGP9Rqc8kIXuEIvAtcVFkLk9nRfLKGvW/hrJxmFp6SOlGbvXJEf4LA5Z7za1rMBniIQxjCY8aInB3JTL69budY7kYPIxqhdU/wNKXDmLai4Lp97nPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530252; c=relaxed/simple;
	bh=FLDFdvUKFSMf3xLn8IrO9C8jTDgOAa5V4h9sl7WI4vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5TpQA9K+57/T4kKZtm1vQJsHAF6zSE3YdpqRMWaA/jz2rNfzpaLuwi4BmCwUvcHRz04GSgJFgF2J8FGZsxpXvcs86aAiPlgNyET0EPwKlmGMpWuoIOrBPgF30+8+qmJuVc4rboLvfBySSNxeon+ee2XNU2Fj1SKyjtr98YMcCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gnWkzzwk; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gnWkzzwk"
Received: (qmail 19352 invoked by uid 106); 11 May 2026 20:10:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FLDFdvUKFSMf3xLn8IrO9C8jTDgOAa5V4h9sl7WI4vg=; b=gnWkzzwk01+lo48hwrR5BTBIbmEeEfXJO6cspg2r6AxHXlaZ59J6H8KmYkXsBJKKlrv4HfsZ1qzKhAA+HabJvpB8W7Ib5bUGV7aRby76zMvFUTRvguxpS3V31kCb8V0cAnen6M8Y3GAJSk1GHthr1wExLp26DMqor/Jxlc0l0FeBn4qWD0WPNsrs/Ho7k3D4RqAt+9o4cH1b9jKXEbD2Ik6Aaa7tqMmKCGmK5W6NqkpwSEebM4eMqn8kNZK1Hkh1Duz8ur+ZOcL6XNImyaOpHZENmgdOeOKk8lRjfldwpGLHd+brGqzyjl9fQBApJe52n1q3gm3gOPl73cb4V90Lzw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 May 2026 20:10:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34310 invoked by uid 111); 11 May 2026 20:10:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 May 2026 16:10:49 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 11 May 2026 16:10:49 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,
	jean-christophe manciot <actionmystique@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
Message-ID: <20260511201049.GB22912@coredump.intra.peff.net>
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
 <20260508180341.GB737125@coredump.intra.peff.net>
 <20260509175249.GA2336928@coredump.intra.peff.net>
 <af+snTGFeoUUyfPU@nand.local>
 <9ddfd37d-7d71-4359-b9be-d993fbfd138c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ddfd37d-7d71-4359-b9be-d993fbfd138c@gmail.com>

On Sun, May 10, 2026 at 12:08:14PM -0400, Derrick Stolee wrote:

> > So in that sense I would prefer to "fix forward" here rather than to
> > mask over the bug. But even the relatively short diff above is not so
> > straightforward to reason through, review, or test, so I'm open to other
> > ideas on how to proceed here.
> 
> I initially worried about cross-platform support, thinking that we
> needed to pass file descriptors / handles and Windows always has
> issues with file handles. But we aren't actually keeping a handle
> open but instead a record that we created the lock and should delete
> it when everything resolves.

The daemonize() function is a noop on Windows anyway, because we don't
have fork(). It's controlled by the NO_POSIX_GOODIES knob.

> For me to be convinced that this forward fix is the right direction,
> I'd need to see a test that proves the detached process will clean up
> the locks on a normal process end and an early exit.

I think it's hard to trigger an early exit, since the only thing we do
while holding the lock is run the maintenance tasks, and those are
almost entirely just using run-command to run subprocesses. So I don't
see a single path that can lead to a die().

Which leaves signals. It is easy-ish to test manually with a
long-running maintenance (say, the "gc" task on linux.git), verifying
that maintenance.lock is there, killing the detached git-maintenance
process with SIGTERM, and then confirming that the lock was cleaned up.

It looks like Taylor found a way to make an arbitrarily slow task using
the prefetch process. So I think his test could be modified to issue a
kill at the right moment and verify cleanup (rather than waiting for a
normal exit, which calls rollback_lock_file() and never checks the owner
field at all).

-Peff
