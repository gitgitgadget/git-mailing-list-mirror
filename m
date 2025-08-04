Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1194262FE5
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314564; cv=none; b=rEQ9Ilrt8T0mXQ02kgtltlvoSUH5OFx3J1MHOeqzbX4901FHaLJUoSeJcAAINWfWQTDTFv9nCSKQm4lhHMaC8eT2pUm6lDZJpkMSbhQskVcZN1CBvp0q6tNaRPjLrcOMi+O20MazsLcBliO3HftMA19Hc1guQI33qBS82MzDYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314564; c=relaxed/simple;
	bh=VLtqUvahwyQ+WDrgB0y+n+aIVZGTl5gY763OkjNzTUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+pWbW5ssz+wIjiBrjj+evPc2j5ELka7AgOSMEryW5Et6N4YQ+KCZ0de/zWl96n1s4BMhICHl1S/Ps/6SJbcJFT83CaWLPKFXIFd8mSfuyF+CLY8fd4STMRJkO3UHtccVR63k3KVhqxysghzMXwXmeCDVxHF96lOaNZzUMaALLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TzJpU9gE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hldEtsEI; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TzJpU9gE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hldEtsEI"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6B117A01CF;
	Mon,  4 Aug 2025 09:36:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 04 Aug 2025 09:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754314560; x=1754400960; bh=DlmsJ1bJdS
	veG8mqpkh9ZQ6kau6shVzmi8wW6w9QBuM=; b=TzJpU9gE8T9oxdFe1IyubUULpU
	I+WhB0GAPPgEb3+pt7GcrUNnuhzcTpBKLPv2XWFwBE9+LwIYPmKYh5z4qQvqvxa7
	bVRt+jpxuwpP7Guj2Qif4CPkSiOj/cPikyMPu7JuAyxrMu0fTwikknkbPd9dyrOG
	IZ1W+AzDpLsNLgi7ynw/4aKJhkW+PWXsyh9APH+JpnpYdN0sQSGGZul0gwDd1/k+
	idloojGUesWv++TLBhGgma3o78LA5NaCWDtpcZD1Qac/DrKcdiLZpMVjd8syuvlV
	lx3BPqHs/AL7eC3PQ1TGGeophZOWkKsDLhV43JeTdXLl7PrSUcq2cy5TbNLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754314560; x=1754400960; bh=DlmsJ1bJdSveG8mqpkh9ZQ6kau6shVzmi8w
	W6w9QBuM=; b=hldEtsEI9DrIxiXWNT9kRD8EUmnkHELpykNcF7YAcZ6YphKzJUg
	UvuzPjVp/MLfUm2HPgfYSzmshLQJ/0r+dvFLW11ycDcVwHt3xDMUixeFQ72xtUTp
	npwU6bb72/aF039/Kfw28PKK938LeQa23JULpWaQBpf7z5b/1U0qNyuG4xOQmdmA
	yy8MiDhQ6G35v+dYfyEhvP77OChIZkQQ1fDUSNd86WramEALcyU5EwQjehzZRPTA
	QTivSHjTSivQid79D0XKBuKO6RXmnQm9AElaAM2rhFK1F6rB8Ml/DI6bNorjVhqA
	Y5SOOrZa4orOq63+FIMBJysGrzpI0pFNgVg==
X-ME-Sender: <xms:QLeQaHhaUinrzMzCS1GPPqgIslbWCnLffvgEQ8ioqQgX_DJlAxT5lA>
    <xme:QLeQaENLQUAHJG_dkJMBrqJa-bQUYZDg_VGsRWUCjCQIxlLxkPQA5q3uYWxKeH6B2
    w5dXxIKgRyO8nWq3A>
X-ME-Received: <xmr:QLeQaI6GCamkXSBHW8mQ0Pf0XYXiZudrJ0iKZgEjWWE6IVcffmiTnoFzykiNvXV9G7HM0GruELl-a8IIP3bb5KsyfrVl8e4vm35YNgu_aCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:QLeQaC1coKB1dODDkiIsy3A-5RBbf7QRfdefJjes9yKd9qGZinCa1Q>
    <xmx:QLeQaJaYKxTuPBGd5F49GPGVxli4yfX7DcbgtE7VjD7m12JGkNBipQ>
    <xmx:QLeQaKBug1trr22boJGc3w8tJqpkvO8D_Q5xWUvQMh8fXllgZUWewg>
    <xmx:QLeQaL_Rq3kO5RsPU1Xm_5oeILtLaj9FRpcQ0hxFpXL-zfObDMkL1A>
    <xmx:QLeQaK8kum6mnKY4-pJkM0h_RwD0Kz4OOOgDzQI9xMwSKBUy48CAtY7L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 09:35:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd538166 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 13:35:58 +0000 (UTC)
Date: Mon, 4 Aug 2025 15:35:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] revert: initialize const value
Message-ID: <aJC3OiJoqJRnR_My@pks.im>
References: <20250804130011.GA93475@coredump.intra.peff.net>
 <20250804130141.GA95101@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804130141.GA95101@coredump.intra.peff.net>

On Mon, Aug 04, 2025 at 09:01:41AM -0400, Jeff King wrote:
> On Mon, Aug 04, 2025 at 09:00:12AM -0400, Jeff King wrote:
> 
> > There are a few possible options:
> > 
> >   1. Instead of a variable, we could just construct an artificial
> >      sentinel address like "1", "-1", etc. I think these technically
> >      fall afoul of the C standard (even if we do not access them, even
> >      constructing invalid pointers is not always allowed). But it's also
> >      something we do elsewhere, and even happens in some standard
> >      interfaces (e.g., mmap()'s MMAP_FAILED value). It does involve some
> >      annoying casts, though.
> > 
> >   2. We can mark it as static. That gives it a definite value, but
> >      perhaps makes people wonder if the static-ness is important, when
> >      it's not.
> > 
> >   3. We can just give it a value to shut the compiler up, even though
> >      nobody cares about that value.
> > 
> > I went with (3) here as the smallest and most obvious change.
> > 
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > I dunno, maybe the comment just makes things more mysterious and
> > doing the casts would make it more clear what is going on.
> 
> Hmm, I guess one other option I did not consider: we could just drop the
> "const". The pointers to it are "const char *", but it is fine for them
> to point to a non-const variable. Maybe that is less mysterious.

Initializing the value feels like a pragmatic choice to me. There is no
downside, and anyone who might be puzzled by the comment is likely to
git-blame(1) to your commit anyway. So I think the current version is
good enough.

Thanks!

Patrick
