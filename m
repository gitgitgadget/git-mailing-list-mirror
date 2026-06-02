Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C712E7F39
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381405; cv=none; b=AGnw0mdhncN9Q4P3crYdnumlW+sl3rhDzcltq2jaoAiiVtH/x5E/HrnhBMUOD3iOVZiQw2/E6RjNNtaRdnNCpqRKWD+QClh0dWN5TshEWachGQSmlfSS6SxzHP38WJm/EZx9nb7zw4dfE+eyWbWD4Prb0xdzW7ZZcJteAyTGoWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381405; c=relaxed/simple;
	bh=UYuUtbwzfnarX6DO15p8D8PTyaf7rrBuc/sIJ4azot8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmfAQwrvrewlj4nn9kZgnYPzrVfAHjizekRGJwNSovLeOI/aAzynPN+mz+7Qh8ETvvq7TabHXzbOlveNvtdYUL5LoXjsd32LZ6jMBg2nSThaYVZPUXkV5OzJvacngN/sC/0TAdyn/eblV64og4ZNoKmrXQJcCk8X6pjAlFwWX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BV7nTYlV; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BV7nTYlV"
Received: (qmail 30464 invoked by uid 106); 2 Jun 2026 06:23:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UYuUtbwzfnarX6DO15p8D8PTyaf7rrBuc/sIJ4azot8=; b=BV7nTYlVjB/yy7AxhozFRcPG2jsQ15FEDpJp+xH3WCo2uImiAyt6aZ1xKaUPrC5sNajyeHE4UTkL2nTNE5iAkeLanqSnAwdQSPcS8y7dchOflllDLt5iK94e58LkZKbQckg3uPiyRZb05xRivn1tHUanoMxXksrIm2EtYfHhzfpXpsD0jqQtAm88aPT0xEVvGV6TODaZ1N6+xf73KEwibp3Dc2IJ9j1DJmos2SnXdGkbSxf+7XheIhRzkq8YCsmmbJ16bSwNLbC7XPmaKyE87k4+uSkpg1A06zuJ9hB3BKdrjdAgag6jVrDqgh1Nf1+/202uyi1uVG9CltVwZpxeHA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jun 2026 06:23:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 75782 invoked by uid 111); 2 Jun 2026 06:23:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Jun 2026 02:23:27 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Jun 2026 02:23:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: kristofferhaugsbakk@fastmail.com,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] commit: remove deprecated functions
Message-ID: <20260602062322.GB695568@coredump.intra.peff.net>
References: <CV_commit.h_remove_deprecated.714@msgid.xyz>
 <V2_CV_commit.h_remove_deprecated.732@msgid.xyz>
 <20260529083716.GE1106035@coredump.intra.peff.net>
 <xmqqa4te91g7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa4te91g7.fsf@gitster.g>

On Mon, Jun 01, 2026 at 04:14:48PM +0900, Junio C Hamano wrote:

> > This looks obviously correct to me, but the whole topic made me wonder:
> > was it worth retaining the old names and deprecating them, versus just
> > removing them back then?
> >
> > Topics in flight would have needed an update then, but they did
> > eventually anyway. So it feels like the total amount of work done is
> > larger, compared to just fixing them as the topics were merged. Either
> > way the compiler tells us, and the adjustments themselves are small.
> 
> Your alternative approach will depend on the integrator doing all
> the fixups at the merge time.
> 
> The amount of effort required by the entire community as a whole may
> have been larger, but the way the rename was carried out did spread
> them thinner.

True, though my thinking was two-fold:

  - Topics in flight that you _haven't_ picked up yet are not your
    problem. They become the problem of their authors, as long as they
    build on top of the change in question (either originally, or via
    rebase).

  - It's also work to pick up the new topic. So there's some tradeoff
    for the maintainer in how many fixups (and how much effort for each
    one) versus the work to juggle a new topic.

> Admittedly, with help from rerere and merge-fix mechanism, such a
> "fixup at the merge time" typically needs to be done only once per
> the other conflicting topic in flight, but still, when constructing
> a workflow, I try to avoid having to depend on the single bottleneck
> for a task that does not need to be performed by the single
> bottleneck, especially when the single bottleneck has other tasks
> that can only be done by the single bottleneck.

Yeah, I think that is a good philosophy in general. I just wondered
whether the tradeoff was right here (but I'm happy to defer to you for
the final call on that).

-Peff
