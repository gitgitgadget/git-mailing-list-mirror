Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383722C3259
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772577; cv=none; b=TawZf+fizGVTEhEGneexjXScWy665tMQdo6v2O+WxGmcoAkL2WTwEq2uXlSuthVox5u/c/Tq8H5719cW6ekT+4LeE1YM0WswKuv/+RTwV+Zj382BRxg7BtxjGDg2zByQohXsbzUvONMZ2rbLdHMRApHD6fic9V4dWlFdqPPg4jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772577; c=relaxed/simple;
	bh=BzeuajIZBmIHvC+D+uxwrWbvIuVkUdXA9fnD0RfuGfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmRnq+2UpnNIfGhLipMyhw+6/BLC3MYl5Xkg6YW8ib+pgbvK+/wNe7+GlVNOBcl0O6ELorJqk0P5FFzDrO/jzkdsK5Vf+ZxFNiJdK5uSfW55riOJpaTVOm1WMfTDxDjLRj9pEZhRBnmI8Ph89+EvSBckh96MHe5Iuu1raAoaVpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m0+czwot; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Awj3vAAR; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m0+czwot";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Awj3vAAR"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E9987A00AF;
	Tue, 24 Jun 2025 09:42:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Jun 2025 09:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750772573; x=1750858973; bh=68OSyGTLoS
	Zdy0Tp/oSatHHnplZbxK/tSooLmKaaho4=; b=m0+czwotT3MPdH7noRF7mLNyGY
	BNb6/5WL1Q1O5QbjRp5tnxxD0eEnme3gvPc4c4rN6jQaaF1suZ3wwmoBg/36C9tA
	7rauFj5ZaV79nN6CrTvoSOA6zxTWqg/EXVKTdafP97KlTE1EaJkiLhL6C7TnpDTH
	UvOezY85YOhhWkfxouSP99COpYsiKOdkFnuhZwDkKntEvQ7Wo68FbL/UlWHyCvVe
	5akWsvVsXLn8sxKB32zd6H6LQw6dWGBmcAJwN6OcV9UQZBcKlslNQJOqdvN7fcs+
	CY1Jl9dzZbgdwPWtpsyu5AdYPbnf7ewQbXKjSEcDcca9iA7Kj+6/I48RfGoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750772573; x=1750858973; bh=68OSyGTLoSZdy0Tp/oSatHHnplZbxK/tSoo
	LmKaaho4=; b=Awj3vAAREVeyRId2h4YS25sZVH1JFmveOnpD/z1P2Hn3lrpcxD7
	DrQH3ubGuTLhkYH2NS3xyLH3OH/DkcEP8Ss7qCtaFNVrECn/NeL4rA4HY1sliSHw
	9VYsj7sHER+FB/SPRRB7tD9pUzKbADtpUBFHHCtEHaWAKbm3GNH7enTi/Q3Az4aF
	jlyZx2E6j7ed4wGGWL32PfGXpKrN45dFyOFhnwH+Fd0YHCWzD5XEOztKBxQAzhyz
	OSlpInkWFIhBhqZpTlI/FaYLGhHyny1H702Afxw5svcf4LKOSPj4hO7Ryh05lVZ1
	i8ghCB8Frv/NrhXa08AqB5NVOQa34mM7zow==
X-ME-Sender: <xms:XataaEBVXK3ut8zpMLrAPBtyvfQ2f8RahKgFmekCxkjOWtmkSYHnMg>
    <xme:XataaGjo3SMEsud_Fu0pPaj4zxaRwq7ICsZCrMYlhxPoakaUJfjya1wdUIC9se8k0
    289OAyjJIMXlHgh4g>
X-ME-Received: <xmr:XataaHm8iQuH7ixRNXAGmMA6ljW0PuunSG0JGtsgCPugy1Eyo1jURUGuMRQXH0h5F54Mbp0T32NMMW448WYxTAro7iWCAEd-c0NWfkXTqbM1u6m9hgiR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvohguugcukghu
    lhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    fgveefveeihfehhefhgeethfdvffehfeehueelheeiffeuvddvuefhveffiefgueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XataaKxhaZtUKjXz5YPL2ZTeUteDqUj56iTHrodGZKepA7bEO1ZwPA>
    <xmx:XataaJTickgNjuUmoJPV5MBhANgGS5zhdUEQWTZb1_-DKWBn8g9KoQ>
    <xmx:XataaFYN0skN_uDxfHi0q1D7IS2wXD9ulalSHjb_q8GmEhquWPVwiw>
    <xmx:XataaCSDUPi16l98Kyq8jHAYUIexGFCRVB3jzXBRG8JAH1u3hQ_Gcw>
    <xmx:XataaOKt6h-LqsOYsEIsXhJfCXPmYWl9hsUC9IG1zfRWJyhUcxjbRqHu>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 09:42:53 -0400 (EDT)
Date: Tue, 24 Jun 2025 09:42:52 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] test-lib: teach test_seq the -f option
Message-ID: <aFqrXMHStEJXx8e5@teonanacatl.net>
References: <20250623105516.GA654296@coredump.intra.peff.net>
 <20250623105625.GB654412@coredump.intra.peff.net>
 <aFmOazVXXGpt8bLB@teonanacatl.net>
 <20250624101651.GC636332@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624101651.GC636332@coredump.intra.peff.net>

Jeff King wrote:
> On Mon, Jun 23, 2025 at 01:27:07PM -0400, Todd Zullinger wrote:
>> I don't know whether it's worth the extra code or not.  I
>> just wondered about how it would fail in the face of a minor
>> typo.  It certainly should cause any test to fail if it were
>> to output 1 instead of the intended format string, so it's
>> arguably fine as-is.
> 
> Hmm, maybe. I notice that "seq" itself does this (though it did surprise
> me). I think there it is actually doing the "%" interpolation itself (to
> avoid memory errors by feeding arbitrary strings to printf functions),
> so it's easy to do.
> 
> In our case, we can rely on the shell printf to do something sensible if
> fed garbage. And because we're not parsing ourselves, a pattern like you
> have above isn't totally accurate (e.g., consider what it would with
> "%%d"). But it probably would be enough to catch typos.

Parsing it fully felt like overkill, and a good bit more
code to do it well.  So that was me being lazy.  :)

> It would also disallow:
> 
>   test_seq -f "same line" 50
> 
> to produce repeated lines, though I don't know how valuable that would
> be. So I dunno.

I can see someone using it that way, like a cheap version of
the yes command.

> If people are going to use "-f%d", I think we'd be better off making it
> work than trying to complain about it. But I was hoping we could just
> keep things simple and stupid, given the limited audience.
> 
> So my inclination is to leave the sharp edges and see if anybody gets
> cut, but it's possible that I'm just being lazy.

Sounds good to me.  As you say, it's not going to be exposed
to "normal" users.

The worst thing it can do is allow a test to pass which
shouldn't -- and that's by far the least likely way for the
(not very) sharp edges to cut us.

-- 
Todd
