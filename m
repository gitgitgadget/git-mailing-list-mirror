Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236F1FE45B
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318495; cv=none; b=KtH+AcoLxkSKh6LuedgUkgs/UUfq7T+v1gUG1z1L88yOKGVcVjlMMRdvFyNh+mOZv4nP3t5kA8vRBMGn7UKoHY0CMDUga+9Vit1ShtctYCSS8a+76XLqh9AsdLsGg5wuQgZY7pmzaNLrJTTKPDKAB4UPqxgsdsu3M7tTJL3budw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318495; c=relaxed/simple;
	bh=i8n1qNOgwbVQKgqeq52ow/sns1W0QTbL72tXJ2c93PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJJiIetrpiCPzzE8ZlM9l5N8V+pD7ANmU56TpAi77J34xPqZ7aZfduLVkvYwEio4CnzrLU/5LrSCrBpW0ccZHQj9lAMTXyXBtNwGjtzG7p6QsJRVqGvo9KmafmyoZ5f98VX3R54MR7OHCra+8ubgMb+VPOiIJbHdA0cU9OhNNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZGf8KtXc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZGf8KtXc"
Received: (qmail 18570 invoked by uid 109); 22 Apr 2025 10:41:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=i8n1qNOgwbVQKgqeq52ow/sns1W0QTbL72tXJ2c93PQ=; b=ZGf8KtXcWCvr7nPO+Et2jo4HfJB9uoDknT5JTtVub+EXnncKY5rF8C/THVQl7id8QvFuWcDCQQ8vq0rdan1jNrH5e9nfpXIsiHkA+yFFSSVy11NnOY3PAg8KRNb+Vv1S/qZdiUwI4xVgyYC6RYJ2ou8IXrpH4JPSBjdnHUEuxWfeEUqa+3cXvBNGUhRlR/dlWWgIe19Jj6hAvFU6RO5efF6lYU+f/XvNvbAcC4b6c2G5lXfc82lcAJZ2o4ktLbZrG6mKrB31SZ3Daidl9WhLB21wUM1BJoWOrB6EQIQdsIyDSA2EfOEiwRI6T9ipZqfZ65adYfNEa0ji+MQ40RpoBQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Apr 2025 10:41:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32728 invoked by uid 111); 22 Apr 2025 10:41:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Apr 2025 06:41:25 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Apr 2025 06:41:25 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] perf: do allow `GIT_PERF_*` to be overridden again
Message-ID: <20250422104125.GA1460472@coredump.intra.peff.net>
References: <pull.1900.git.1743764167548.gitgitgadget@gmail.com>
 <20250419035407.GA93039@coredump.intra.peff.net>
 <xmqqfri28rlp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfri28rlp.fsf@gitster.g>

On Sun, Apr 20, 2025 at 02:12:34PM -0700, Junio C Hamano wrote:

> > So I think we either need to rewrite the "run" script's fallback code,
> > or teach the GIT-BUILD-OPTIONS writer to avoid mentioning unset
> > variables (which is the real source of the problem in 4638e8806e3a).
> 
> ... this was raised.  And then I completely forgot about the topic,
> as nothing happened since then.
> 
> > ...yes, this is definitely the tip of the iceberg. I don't mind doing
> > this patch as an incremental step forward (and because it is an
> > improvement in behavior even if 4638e8806e3a were reverted). But the
> > issue is far from solved overall.
> 
> I do not mind it as an incremental band-aid.

Looks like this is in 'jch' now, but there's a mis-merge in e8cf2b99cd
(Merge branch 'ps/meson-build-perf-bench' into jch, 2025-04-21).

The original patch in this thread did something like:

  git_perf_settings=$(...pull GIT_PERF_* from env...)
   . ../test-lib.sh
  eval "$git_perf_settings"

That is, we stash away the environment, then load test-lib.sh, which
overwrites the environment, and then we restore (some of) the original
values.

In that merge, the test-lib.sh inclusion is moved (and in fact is now
accompanied by an explicit inclusion of GIT-BUILD-OPTIONS), and we now
have:

   . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
   . "$GIT_SOURCE_DIR"/t/test-lib.sh
   git_perf_settings=$(...)
   eval "$git_perf_settings"

Which of course does nothing. We need to set $git_perf_settings before
those other source lines (and the eval must remain after them).

-Peff
