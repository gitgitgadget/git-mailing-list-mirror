Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FBA18DB16
	for <git@vger.kernel.org>; Thu,  1 May 2025 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746115429; cv=none; b=t7822xuMEJbH7x2u3Leiknvs2RiZkXDN7BG/hjVeMofOQ1FyySsTr6nPfYH/Gb/L3S58Qn1af5Y59LTLbWYWT2OsGh5vywss2K3sObdPUvT9VQimggwXWOb+qfbsoE/wiHeBR+YSSblDmdqUBuCgQRvBb8ChyZWNLKWgcdBYhCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746115429; c=relaxed/simple;
	bh=VfT9bjqcOU4EEE7jaTJLmier/FbRcnSsJBZqteS7nQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVFk/r5gi0ewYrxIPEMyUX1bPN3PM5Vmw4onCoKp7ru3toxmRW7v2Ttduh8ohxAVBA8pzMrUqnYpc5hGBM4pC3+OJ+VSTX5OqldmQaQmEVZfza/Dp5mZiWzhmqmIbmI6WwtePDQaY/OZB1cY0ucMyzzbeiq/EAl4amI8RlJZuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VY2Lk1QD; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VY2Lk1QD"
Received: (qmail 24599 invoked by uid 109); 1 May 2025 16:03:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VfT9bjqcOU4EEE7jaTJLmier/FbRcnSsJBZqteS7nQo=; b=VY2Lk1QDvKZamtG3XpoxVz1goqGNlppzsLdqcEgs6KRfWtLRJsE9KU3E6a9x5QSJwK1Z5xgRilbR3a68Qw7/AjOnzbQS8QYgtcloVGMlUjh9jMsberG8yytuoJQK266aXIPfnMgDBeHxQY52XEgs7cs5zQZYyjBi83hYJkLaC9yMLHjGSX4UlxrJ6EleOpC+lXmfaMRDBmgDc3lPCBf4S4h0INrezPftrNv6BzVlMIsj5TGOpV9QGmsAl1xFjZt4iiSopqhILy+77ZHP7zEkHhTrTKGtnctw23wfIZSP+ZKlVjYgLpswMExgbsRraTutGenbmhYPrMQjwSLLaLgOug==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 May 2025 16:03:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8394 invoked by uid 111); 1 May 2025 16:03:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 May 2025 12:03:45 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 May 2025 12:03:44 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Taylor Blau <me@ttaylorr.com>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Nico Williams <nico@cryptonector.com>,
	Edwin Kempin <ekempin@google.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] p5332: drop "+" from --stdin-packs input
Message-ID: <20250501160344.GA1794891@coredump.intra.peff.net>
References: <292ae7a3-2aad-1f22-2afe-739ec921d6b7@gmail.com>
 <20250422111632.GA1855088@coredump.intra.peff.net>
 <xmqqv7qw42na.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7qw42na.fsf@gitster.g>

On Tue, Apr 22, 2025 at 08:49:45AM -0700, Junio C Hamano wrote:

> > The fix is to remove the extra "+" (which also lets us simplify the sed
> > invocation a bit, as it is now just stripping the leading directories).
> >
> > But that leaves the mystery of why it was ever there in the first place.
> > The answer is that an earlier iteration of the patch series had a
> > concept of "disjoint" packs in the midx. And one of its patches here:
> >
> >   https://lore.kernel.org/git/c52d7e7b27a9add4f58b8334db4fe4498af1c90f.1701198172.git.me@ttaylorr.com/
> >
> > taught read_packs_from_stdin() to treat a leading "+" as marking a
> > disjoint pack. But in the second version of the series, which was
> > ultimately merged, that disjoint concept went away, and the code to
> > parse "+" did likewise. The regular regression tests were adjusted to
> > match, but this case in t/perf was forgotten.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  t/perf/p5332-multi-pack-reuse.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thanks.  I wonder if we had some tools and mechanisms people were
> discussing to track changes on changsets, such a mishap could have
> been caught more easily.  [jc: random folks from that discussion
> CC'ed, just in case they are interested].

IMHO it would probably not help that much, because the error was in the
other direction. I.e., the issue was that something _didn't_ change
between two versions of the series, but should have.

In general I think we'd usually rely on tests or compiler analysis
(e.g., leftover unused variables) to catch this kind of thing. It's just
that hardly anybody actually runs the perf tests. I know there was some
discussion about running them regularly in CI, but I'm skeptical that
the CPU time / utility tradeoff is very good there.

In some sense, this case was the process working as designed. Running
the test _did_ catch the problem, but we didn't notice because nobody
ran it for a while. So in the interim, nobody was hurt. ;) I'm mostly
joking. It is certainly more convenient to catch these things earlier,
but latent buggy code that nobody runs might not be that big a worry.

-Peff
