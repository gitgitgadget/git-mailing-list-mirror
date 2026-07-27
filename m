Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534A36EAB0
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167085; cv=none; b=gcEn/OeooqFOEyvsI5aQVScLfwWI653nX2XaeiWi+/5/zwWY0/DjERBs2Vcg+I4vxDyZjh6kZiiEAcpry6kQpakHG8J27XlmFxcUsCt5ynjrZBDUPnTLrveVbk+Mf+Yu4LFVwJqVZhmjLHgAkMvzf2kT7qXX+lFbL3rbJWDnb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167085; c=relaxed/simple;
	bh=R+oKZ0XMxnqrkutmVHmWUj77K/LgBZdc0x10MVMoW1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DmU1BCHk81JTgeFhlUbhIDMDvVWrH+d3J6flt0949mRfprlyCJovSPgZcDJ/Rc5Wad5eGvK7HwfE3/TcNs83JzQq1HLLQ2BczNt8CPaSidM8Vb5TSF3LM65N2qFTAipTQRUEDzQWwJ4LzXBT8sN0BHBd2GxEmjoAyhQHSnVjGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=x63pD37r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lTaQbEB9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="x63pD37r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lTaQbEB9"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 5808EEC0209;
	Mon, 27 Jul 2026 11:44:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 27 Jul 2026 11:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785167082; x=1785253482; bh=30b40fHLzb
	0/I52zXLY1K+dJJwGSyVc/G/nBImeyQ/8=; b=x63pD37rtHrEErr2ODR3nupBcm
	yyHVE9vvrdKrdTs02Ix0js1sQj0Xl0TPzAznCPyVFy5SLRencYlUjtqlgRfCW2RO
	rYp++BdWHnpnZhzbhduKEwyIOpdYbaOqGFV+cXgJQVXIYlOIgsIRnHyNFF7s7kcC
	zNPKCo80b+sA+fTTsBUIdjJS195t3CXQfQBBenWl5H/RxQbYLmNeD+4K6UW6biJI
	S121XJoWLUcv54KJM00XjSz0Pg4a3ky9UT/RVy09vall2BDNL0B6XGIwUfPscxWr
	S3PNcttUwb+Q3lH8MSk6Y+sG7tZ2VX2u0mLy/GVNXbr/dXKKccvtBCrlQyfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785167082; x=1785253482; bh=30b40fHLzb0/I52zXLY1K+dJJwGSyVc/G/n
	BImeyQ/8=; b=lTaQbEB9Aogy17dSu3G3ckdOPNbN9j28RLaSZchtcufETWNVxWo
	0wPaWYguyElreu96WXLGNM/+2Qh6Pmk9NfZ9Jt+/6jMJoRrivqDG6I2rvQQ1IpTL
	V+ol3gCZ2bSVsySk7qs9qarRk/eNEfeASh6DPWa1KgcbWIC7bnrhENKWCoYKPn3X
	4wQRJQ94cQ8ikSSHAYMZWS6FWr1OqWGYYQOsmGBhhvbh+w5VRk6109/8JEoGFQ2E
	w8K9GUcjSTkX4+UDjMzCY5SIPr+11N+AkS4KiREk6UtkPZjEeNrDS/DlpFwBhOiP
	7owl0yOG7gSfbg7xnUNr49FS7liWTsvvLkA==
X-ME-Sender: <xms:6XxnaqD2GDZXICkCrJVJ7fCxV-EfDyryMWsmfYYe93vdgmXBepJB7Q>
    <xme:6XxnannDKcJ5F2rMfJLRpdZckS0KjLGy_L39vwJh9vFYeF4iXmgb9YJaxuJXSt32s
    gJtWj77TBvV5XXh9GVip4jK5CQP9UhChwbj0ogLX2hhUWgp3XMKTQ>
X-ME-Received: <xmr:6XxnaoPIEK8PtzCWlfm5D_gtHXBucZE99QtN89qJC81IP4B5Ns42PKiuVljTtPZa0Q9hm3sj6ka6Y44hGNPUdjlQK_86tWNKoA>
X-ME-Proxy-Cause: dmFkZTEn4IYyGp7wpz8oTXh6UkHlLpgZqlt+IFvcSFZgAW/Rlw1hwDC41JV4l72dmcIOMx
    q8KW8W10OeiCm6Ezf+Y5rDW6rAV9dtsy/O3xn4yW+48oTzwJQJnjLrIzmJGrOq9qKGx1W1
    6YJnGCxcQSNbyFF78Z7FpL/PNGOVeYCqI/QBSHOwz4ohiMAN+twq0KCkwEms+XNJAI34hT
    pY58DS42LhepNSoSkP5CEsmy5tEJ0oCjttffYqZbVGgDrPkSMjn+KxgP+ezpbfCK0sCiQ1
    xtn48Uh9i56eKHZwdI5MIAHr/KFQgYRQZsMv6B0S3aZTEmduyW+4PemoQzPTp6ncAJ+YRc
    hwyDYWlPjJgelTh2D7nr4ZCsk4qdLD8s+co7hMIbBTkorAb1h8GlBys0XAkdMkIV9WfFO7
    ZA/80uf3okv0Do/1j284my65hc/wfzV/ZvsMzPuukeMIayiCBsKIAK2FejTzLeanN8y3kF
    8ul+MijuwUJ3UAJGKCkvfFnshoMZrBNBn+Jh2m/RAxvWPQs8ipWSn6Wqpytm759rZjOPIh
    rPoVkKdnsMVOABVTfRe6xId3j7yZu4aDKVYXmbdOGfl5hKC3BmkEs4ws9WqsppKANdwH3p
    Ds/+zm+fpbAeiiT6I/T6NEz327zELbMfeCB8pvdJ8VBcZjaBqSZlF93sxkpA
X-ME-Proxy: <xmx:6Xxnak-JEeqSW_PuMK6_v83_jtj2YUJ6PqYBTdWBGlSMlVYM7xoOoQ>
    <xmx:6XxnaqHZaBWJsNthJru8ZWmuejdwNyIM1dbrK_EtAKHHaRiNfJWd7w>
    <xmx:6XxnajhgCVKJ92p2s2bx5jWEIPSicRD5BjskwuSyW-CETo9Nc5FtSw>
    <xmx:6XxnavsJiyfg7Zdiyn7puIIXQ80ANnmaIxzpyEeK_Dy6LACM4FfCsg>
    <xmx:6nxnaoP7HKPycZHBuwtbPXLkjNtfvMETXq3QfoN2Ue1Nxx74wyrgwIc4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 11:44:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>,  Ben Knoble <ben.knoble@gmail.com>,
  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH 0/5] Reintroduce writev(3p)
In-Reply-To: <f8050598-392f-44c9-8d66-0454740a7a12@kdbg.org> (Johannes Sixt's
	message of "Thu, 16 Jul 2026 20:56:06 +0200")
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
	<f8050598-392f-44c9-8d66-0454740a7a12@kdbg.org>
Date: Mon, 27 Jul 2026 08:44:39 -0700
Message-ID: <xmqqo6fso2s8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 16.07.26 um 09:52 schrieb Patrick Steinhardt:
>> this patch series reintroduces the writev(3p) wrapper. This wrapper was
>> originally introduced as part of Git 2.54 [1], but was ejected due to
>> issues on NonStop [2].
>
> Please don't call the function "writev" so that nobody associates it
> with the guarantees that only POSIX provides, but none of the
> emulations. Call it "write_gather", for example.
>
> Also, clearly document that its only purpose is to reduce sequences of
> write() calls to a single function call, but that the additional writev
> guarantees are not needed.

It is philosophically more "pure" to have a two-level abstraction
where write_gather(), which may be inspired by writev(2) but with
specific subset of semantics that the application needs, is used by
the application and have platforms with good enough writev(2) to
implement it in terms of it.  Other platforms may implement it
differently, like a series of write(2) calls, and as long as it
fulfills the need of write_gather(), we are OK.

Doing so would also help in a minuscule way to avoid adding to the
complaints we sometimes hear that our internal implementation
assumes platform support for POSIX API and semantics way too much
even when we do not need to.

So I do not mind going in that direction.  It feels a slightly
roundabout approach, but in the longer run, I think it would place
us in a much better place.

I think Patrick's writev(2) follows the pattern our previous compat/
routines have taken.  We use real writev(2) where it is available,
and in the fake implementations in compat/ we have comments that
essentially say "the real function offers X, Y, and Z, but we only
want X and Z and do not need Y, so this implementation does not
support Y".  It is harder to maintain because the application side
may be tempted over time to start depending on Y.  If some platforms
cannot easily provide an equivalent of the real function, it is
easier for them if the rules explicitly state from the beginning
that we do not require and will never require Y, needing only X and
Z from either the fake or real implementation.

At that point, we are not describing the real function anymore, so
your proposal to give it a specific name is one step away from that,
and that step is in the right direction.

Thanks.

PS.  I was going over the list of "waiting for response" topics, and
this was one of them.  I suspect Patrick and the GitLab team are
still away at an offsite [*], so this is in no way poking him for an
immediate reroll, but rather a note sent while my attention is on
these stalled topics.

https://lore.kernel.org/git/amLgMqkqxR8mKIbT@pks.im/
