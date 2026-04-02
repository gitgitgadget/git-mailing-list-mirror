Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF7365A1B
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113708; cv=none; b=H+XW1zM3y7Iyi60oxbZ5jY3iuZhResfS37lSCxkEXITJZsQZV1Md9AcBTWn9Jw9WFXL4VYf42oe1077xJj7Q3NTSx3ndIR8kkgwnhhrmlWRe7Tbzz8o/QC35VgvZRTLk5IkTVHfCIhWrdgIwl71MHPMjFQqjXqGqiNAwLftK4lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113708; c=relaxed/simple;
	bh=V2aBFYKYWFaiX+t81RtJlJID0AkTPrTU44B9odY/P5o=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhboeTUBP4+o2Imiw5RX+enHQbHQ1JC86HN4pv2DBQzO6udhzbqMVh3W5OeSZOsPT/URfCSQCMI5zgmFrL/KqQWW0qEsXRNsbY30rEsC3fToA1u6oJpIZdpRCdYteHQ9JjeOzwQh2Fk+xK3LnPvbxlJAOPncf+aRbOpXlqC7dX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h9a/AhOT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rfv0KKgj; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h9a/AhOT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rfv0KKgj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D7EB57A0351
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 03:08:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 02 Apr 2026 03:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775113706; x=1775200106; bh=7LyaDEun/q
	jMtDklsog49zSn7VS2tWJiLH5fdERkkDQ=; b=h9a/AhOT9dENx9UlQS2HlYO3M/
	pIznUDAWLEuF9D32PM3sIiWKZXoDTcI9X+4p7BpKj9QsjIgaju3eWTML+gH5cXUg
	xHgdLjcc24QRiyaXv07bJNJbUlzuJWHquV9Wi5Sd7QYukTgUScRS5Le4C0i+UFgv
	t11Lu1FPxgmEAfhOlVJAjcCDmWew9jmoySoeM7UjvEz+udnpWp7fKdxcy0/VX9vS
	Mf4236h9rZxdAFisd651PGiIDm/a6ED6C6yp6uCKT1I17bSjVz7wTpX6P50lDRFt
	XpdD5xiNimaK8zmqg5kA82fGPvA5JphTqPwVxV0FO6//jbJTq1arr38PdLGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775113706; x=1775200106; bh=7LyaDEun/qjMtDklsog49zSn7VS2tWJiLH5
	fdERkkDQ=; b=rfv0KKgj1gPnt5ZzVj1zW0URF6TqPNxuHmf6Km1JJYJD6gWQbIR
	dHbBRuUXfcX/fkvgwQZFsjI0D7Peux8lB1wW3/LhRKj+ECwx7hyUfM/pJBLfbh0/
	AAe1iQBkX7eAOuY2cc6NyyRxiUdG+NPkUn0jfnTCcSLRedG+ZB3q9eRxkHkzMzBC
	89/9U7Lmh8Q3fAoJ+tPwc1R6tcZ4KJs6Mc0gE9UdHaoRUoMmCidj9YSEQ5ovTjdE
	ULtoedpxi1dJjJIN08H0lhEgzeLZVkW+ZPUXa8Oq8Y26W2j8i1pzTf34ENJSzPuk
	QV/AMQ6IhpaltnOd4bPvoevYPHLD4kgQ5bA==
X-ME-Sender: <xms:6hXOaZ6Nde7vCJnJkQV8DG_yRmWsTCDHBQA-3hPm7zqXx8Kny4eblA>
    <xme:6hXOad1UkV0EeStyucLIDgNRt1HqShZd_sptkHiSV1Epq53RaX-bQS-qncCsGbJHV
    c8pGu8iZfB-syw_Fhzs4NZbVhDknrHs3pVseaWk8mXRavDgerf8yQ>
X-ME-Received: <xmr:6hXOaWEb_sbRGhjIMz3tpzNZUD03xR2smucZw2wuhepkqGdQ0DqHf6gYTLBlbRky34GJ8GczNY0Q778SIgWsh2yftZ_BQjMBc0Oxl8euYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvd
    enucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhi
    mheqnecuggftrfgrthhtvghrnhepvdekueeiiefhleevfeevvedvhfffveegjedvtdeuge
    eiteefhefglefhkeduhfeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6hXOaXRPrMrmEs2m7DGQTQeg4xRdi9xnwxUPJ60odNLcxB_8EkqHpQ>
    <xmx:6hXOadAB1ZJ5MbYLoeZZ64dDTktr-rjbqblWsqLFqL88t_-QqKKwGA>
    <xmx:6hXOaX2SvbFp3xkwr4zwC1W_1OYKEavh-0KcCJArKxHyvswfDZf5Rg>
    <xmx:6hXOabW2jn_wNQhRyJ2_VFqM36NwAhAWUgNCVvY1hLFwkWcKbh6w6w>
    <xmx:6hXOaeZj47D_UgT_NpD69xilNKNez_QABHFsOPQLKrmbgzq7WYWq_Lta>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 2 Apr 2026 03:08:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a2e67f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 2 Apr 2026 07:08:24 +0000 (UTC)
Date: Thu, 2 Apr 2026 09:08:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH] hash: introduce support for the MD5 hash algorithm
Message-ID: <ac4V5UaLs9hJemxt@pks.im>
References: <20260401-pks-object-format-md5-v1-1-1b8f0be23713@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-pks-object-format-md5-v1-1-1b8f0be23713@pks.im>

On Wed, Apr 01, 2026 at 12:42:28PM +0200, Patrick Steinhardt wrote:
> We are currently in the process of migrating to SHA256 as the
> alternative to SHA1. But we believe that proposal is misguided.
> 
> When Linus first announced Git in April 2005, he was explicit about the
> role of SHA1 in the design: the hash is used for content integrity, not
> for cryptographic security [1]. Given this foundational principle, the
> collision resistance of the underlying hash algorithm is essentially
> irrelevant. What matters is that identical content always produces the
> same name, and that any corruption of stored data is detectable.
> 
> While SHA256 technically provides stronger collision resistance than
> SHA1, it does so at the cost of 64-byte object names instead of 40, a
> 60% increase in verbosity for no practical benefit.
> 
> As an alternative, MD5 satisfies the requirements of collision
> resistance and deterministic checksums perfectly well. At a length of 32
> hex characters they are shorter than SHA1, roll off the tongue more
> easily, and have been a beloved companion to the software engineer for
> decades. Furthermore, it remains in active use throughout the ecosystem,
> in checksums on download pages, filesystem integrity tools, and
> countless systems out there, which overall proves the point that they
> aren't inherently broken.
> 
> Quoting Linus in [1]:
> 
>   In other words, I think we could have used md5's as the hash, if we
>   just make sure we have good practices. And it wouldn't have been
>   "insecure".
> 
> Let's do so and wire up MD5 as a new alternatitve hash algorithm next to
> SHA1 and SHA256. Repositories can easily be initialized with MD5 by
> saying `git init --object-format=md5`, and tests can be executed with
> the new hash by setting the `GIT_TEST_DEFAULT_HASH_ALGO=md5` environment
> variable.
> 
> [1]: https://lore.kernel.org/git/Pine.LNX.4.58.0504160913180.7211@ppc970.osdl.org/

This was obviously a joke, but one thing I would like to point out is
that this patch actually works. There's 15 test suites that are failing,
but everything else passes. Which is quite amazing, and it shows that we
have come a long way with making our code base more agile when it comes
to the hash function. I guess a lot of the praise goes to brian here.

So while this here was a joke, it was also me experimenting with how
hard it is to actually add another hash function. We've discussed in the
past whether it might make sense to have a third hash that is focussed
on speed. Of course, it would still require collision resistance, but it
might actually be in the picture to compromise on the cryptographic
nature for internal projects.

Anyway, that's a bigger discussion to be had at a future point in time.

Thanks!

Patrick
