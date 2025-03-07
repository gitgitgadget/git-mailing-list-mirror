Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D491E1DE1
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741340159; cv=none; b=EAjF2RbMoe8/1NmjpMVvvYilvWmybHYAwU3vnO47Vq2fvTCqKbM/6BD/p+FHbtewVIHDR+GsEJx5Ur4om/U98jzYNWefW8B14QbE8tCONziypQ5LI9dh2MNiT18GGXvt9OUlFWjzNXeNaaKrVt7RtFh4e9L5JgKMa1551RsylXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741340159; c=relaxed/simple;
	bh=qBKxXFWS8mQu0R2tuAu80THb6M3QImkSoIqoBRm4kKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXBWHewEvNsR0SM8/LIt9j3R06dxoImhT4S6bZLZnxW2D5dpBsPw2OhpOsS3YqBhz5dNTyfZPfdjhpbuZeLVr8R3zFzGT9FORphots0J14xgCyy4fC3xLydL6Hy99er8cfWUdNI2KchETPc7d+xHPPRhw2NztZ10XlapwVjE8MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vkc5vwUb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oGaIV9fa; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vkc5vwUb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oGaIV9fa"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 25DD0114018A;
	Fri,  7 Mar 2025 04:35:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 07 Mar 2025 04:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741340157;
	 x=1741426557; bh=qzC4tLgaeyuE2gY1QgKIjGAIrpbpuaN1TCJFgM6HGHo=; b=
	Vkc5vwUb6Bu4WpInMbp0oQBrgSXCSbQgVZO+j0URq7AOI5xcZXRoYTQFMn4hkb7k
	chj8D+l7Nj2+i8L3i2L55MzuauiFPGhg/lCOX5DEi2fvR0TyvRcXR4v9/b/XNbLh
	uXFYfO48SJaqRANHmG9Wkmx0IqwAInIIpeo/6qGEueT52m6BUg90n2I/p0Y3u6CV
	W9Ug39hbWaqBf4tLjOptV4foS8BTWTI+wB0k5LmwMIwP4sKlWcLecYE3mXJyWQ6L
	HuHZvyvvit+a5uhx4XfHpWxR6JSPsnz10nPSy8i3jsmR0i0B5DmIYHj9sc1PuQ9L
	42ZrxbgEqhrsg3Ql2KTFUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741340157; x=
	1741426557; bh=qzC4tLgaeyuE2gY1QgKIjGAIrpbpuaN1TCJFgM6HGHo=; b=o
	GaIV9famKmNBCCKzhVbeTgpUorLzgSvlegG1TG5fC4UkoyEJmx/R90kC7GSa9Hkm
	ctjILpIwVhqJDm2JxvqdQLvo+8STYIIMazVckYUkfwLxfqbV9zj3LnuRqdzpJm2x
	j9L68oWFTnS8qLGe2i0mjjP+UzbzXMphIexWjSFyRLOoU3OoAvztHLfBpveyOCCr
	lz09KbqBksTNMEtFvJ11YsY5oqx442evuhWtPEQm6jkIfcNeqkGbwXOYMQUwvTE+
	7atZA9HHFIRqUKW0g986KHdMiWrLj4770KgKL60vPY6WjqoM8KTT7d5IOg5Ni2EE
	t3zvUNtvs6v3XAmV58tBA==
X-ME-Sender: <xms:_L3KZ6TEnypYJ0nB-jDJHlDIAxufb9BaD38yoZvD5RE0nbgxfyvMRQ>
    <xme:_L3KZ_wt2HeeIqmwDPZnL2ujBPUcNK9HJBIzR7kZL1VNYGZPvfsH6uHc2sJQ69lVU
    KMgiX2uovaNYmue-g>
X-ME-Received: <xmr:_L3KZ31UDCRY45g_1f98GWwinqPXauAiGpD8h2310mj1K6y_tOqzE55n0HmkssIh9wBNsxhDHAwXMSBGoKPI4dX60cle9GBbMWeQQbkJMlk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhurhgrkhekkedtieesghhmrghilhdrtghomhdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:_L3KZ2CzR_vc1k1yKoOlmGjFrWUpDl0xpnpnRpbIT6Ed0znFcEaKKg>
    <xmx:_L3KZzhkc0GEo9bI5KCajWiqKcraChQkndm41-01xrNDW8AlPI9NmA>
    <xmx:_L3KZyqYsv6HCqt0jYT9lU8ulhg5ZQU5gxrx5HGTWi7igwRzFWwYUQ>
    <xmx:_L3KZ2gXFgyR1xirLn3N7hGn5kds7kHc8ynXGVGtDONHl2_iKPN0Ww>
    <xmx:_b3KZ-Wa11cLT9FuHVT066BwD1PpL7tdRh2JDAGlLKp81tcabymTGqeL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 04:35:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b2cedf1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 09:35:53 +0000 (UTC)
Date: Fri, 7 Mar 2025 10:35:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	SURA <surak8806@gmail.com>
Subject: Re: [PATCH v2 2/2] refs.c: stop matching non-directory prefixes in
 exclude patterns
Message-ID: <Z8q99U9u6HQvHXFT@pks.im>
References: <cover.1741223981.git.me@ttaylorr.com>
 <cover.1741275245.git.me@ttaylorr.com>
 <67c8c5f797833a9a35f4805059d7e759020f54bd.1741275245.git.me@ttaylorr.com>
 <xmqqjz92hxxi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqjz92hxxi.fsf@gitster.g>

On Thu, Mar 06, 2025 at 09:27:21AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
> > So there is a subtle bug with '--exclude' which is that in the
> > packed-refs backend we will consider "refs/heads/bar" to be a pattern
> > match against "refs/heads/ba" when we shouldn't. Likewise, the reftable
> > backend (which in this case is bug-compatible with the packed backend)
> > exhibits the same broken behavior.
> > ...
> > There is some minor test fallout in the "overlapping excluded regions"
> > test, which happens to use 'refs/ba' as an exclude pattern, and expects
> > references under the "refs/heads/bar/*" and "refs/heads/baz/*"
> > hierarchies to be excluded from the results.
> >
> > ... test (since the range is no longer
> > overlapping under the stricter interpretation of --exclude patterns
> > presented here).
> 
> The code change, reasoning, and the tests look all good.  It just
> leaves a bit awkward aftertaste.
> 
> In general, I think our "we have a tree-like structure with patterns
> to match paths" code paths, like pathspec matching, are structured
> in such a way that the low level is expected to merely cull
> candidates early as a performance optimization measure (in other
> words, they are allowed false positives and say something matches
> when they do not, but not allowed false negatives) and leave the
> upper level to further reject the ones that do not match the
> pattern.  If packed-refs backend was too loose in its matching and
> erroneously considered that refs/heads/bar matched refs/heads/ba
> pattern, I would naïvely expect that the upper layer would catch and
> reject that refs/heads/bar as not matching.

I think you've swapped things around a bit by accident. The problem is
that the patterns were being matched too loosely by the underlying
backends, which had the consequence that the backends marked too many
refs as excluded. As a result, those reference won't ever be yielded to
the upper layer at all. So the upper layer doesn't even have a chance to
correct such a mistake at all: it cannot correct what it doesn't know.

There isn't really a way to implement such a safety net, either (or at
least I cannot think of any): the whole point of making backends handle
the exclude patterns is that they can skip whole regions entirely and
not even try to read them.

> Apparently that was not happening and that is why we need this fix?
> 
> Is the excluded region optimization expected to be powerful enough
> to cover all our needs so that we do not need to post-process what
> it passes?

No, it's not. But we can only correct false negatives, not false
positives:

  - A false negative is a ref that matches an exclude pattern but that
    we yield regardless from the backend, and those do get handled by
    the upper layer.

  - A false positive is a ref that does not match an exclude pattern but
    is still treated as matching by the backend. We thus don't yield
    them, and thus the upper layer cannot rectify the bug.

The fix at hand fixes false positives.

What makes me feel a bit uneasy is that for the "files" backend the
optimization depends on the packed state, which is quite awkward overall
as our tests may not uncover issues only because we didn't pack refs. I
don't really see a way to address this potential test gap generically
though.

The "reftable" backend doesn't have the same issue as it does not have
the same split between packed and loose refs, so the optimization always
kicks in.

Patrick
