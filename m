Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DC33263F
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104884; cv=none; b=fXkDiGvNTH1kGoA2SmjtXmaCL/ewUqWOSK7FAs3YokNOJrKH65zLHLFW9mywNp99t2StJ0dKDCZ4E9madZ7bBzrEbAhgHaj0jzr7zyBCPmHk2dKXiXmPZ2Ox+dONKFvl/QRVDMT4JqeAuMzX0LpM7DRgqPfVIOEn7TNPwxXBeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104884; c=relaxed/simple;
	bh=BBpFOqytvQduZ1l5WyoIeIsoJcZ3+y9yBTPVGC/8e8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pbkp92rSz8OHF2gr/H0ceHAUO+GDjpJZej1dznyXB6beGBfQUE5H4PnNBbZ9W2GTVlSeZIms+/eg/MT63zri72ThQ3UsD7oMCbDELh9MvFvN//5gEcsAeEVBuiVidngz17z8NwAywyKsF+7im0N7jWO64iOVd2xVVbw4hxAZ7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NsovwWvR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jgVkemR5; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NsovwWvR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jgVkemR5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C5442EC016D;
	Wed, 10 Jun 2026 11:21:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 10 Jun 2026 11:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781104881; x=1781191281; bh=SrO3yJvdsB
	THxmKtRAMhFDsPDwXwPHoPEwNhCToygOo=; b=NsovwWvRXPe5OItyqKR4RcNGSW
	rAqTdOXiVYM4fE5yGC6bOuWO5IpfsuzjfuIlD2JvVhZ998PBjAlSChLhmg0syuXS
	qhTOuIFzIHMALQMIYGM0YuMAIbChDFD4chaCQwVvmHn13DccT0cGNZiLRmxThPZ1
	tsnTTpm/U7D0JhWujX4uf50YTDQ1T0Dge+vqoSgBAb107TIIInnRFpk43l3cNtly
	hqp+Vr/U+hfxL9/zwC3PPUY8VBAGEujbRyw0IngCfo36zl27/tnY1t70Syy2CdcM
	bXrcbwbnOxKueAHSLuAjUytw3t/LsjkBlaO5R1QyTPjwugI0xrQlcVgHJ9ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781104881; x=1781191281; bh=SrO3yJvdsBTHxmKtRAMhFDsPDwXwPHoPEwN
	hCToygOo=; b=jgVkemR5vmq5wkEyD06IXTe4fQDUvAC5dXE8NOE1t8OALHJVRk5
	/swQTYG28PQT+gITEk1EgSAgFB7irLRWQXJ+4O/VfwDlR2IVqAOMunoB4Z1C0pm/
	KMpmSgCwaYMAaqHLm0YP2PEZhnAjzWY7clQpCiMdsGJQGDm64GHwu3Nj2VSRzQ/Q
	a7Boe4sIOmYAMjJj77QzK0NdO6xpEQ5/520Kn3eb0EwdEW9yOUrm/7Z+DFZIFYEA
	D+gHg9E+SlHzUR441+0pM5KuIR7BCjsyyTaOOc0uHuiIQMHCkXlbesappkO6n5Up
	MAoRlGRQQcC9WJHhHdbH+zGnD4w4UvRCrXQ==
X-ME-Sender: <xms:8YApavaTmcL1MFbGx_flokcsi3MiTtsvdQVdFpum8ZNQNm8cQS9BqQ>
    <xme:8YApahcFkMGsylOWvEX6s-rcqJLR3xXat9t16f0MuQySKeE9oCTEnVHpcJv14aSPr
    HkEFjzSr7U83SHhTJsj41_uamU9BW_KpbTASRtYXJdbo1XMC3XUXQ>
X-ME-Received: <xmr:8YApasmsNs68CVJPgQd-ZdVyqRuV-dMyTYLZfYGse1ZuCupGj08Xt0AD84NrJ9sd_wESgGviaLa8X84otsMBAWpg-q8f-pu58nGn>
X-ME-Proxy-Cause: dmFkZTEa5brE73Su2pMbH8+JaKpNK5HJSCAnPrv1oiGzUogQLsLwk54ksEUxI4FWZrUod8
    IyR6JTZxbEaswFg8b3I9Rp/ra58f9mi7d2unfZuBTnFxeW8fq2WY1RRNo6m8B/aCbClktv
    lUzAej2CH5rLEmXtVbRc5Tzr+dcUB6U/gWxID8krMSmKLNymy5XT2Lz2GLLk0th7GCFwRx
    6TuHNLvIz5PjiXKTTCMkMgKNjTm5uj5pKGcRjGAniBvIB6gk8wsc0WFVXdfH435L0sBbw3
    CE8+MCP7Z19vDojHDNfQ9JvCjKB+Dofu5HpX1Wv6V1L0KsJEX98Xt7w6yeqXv2A8t+4KiV
    mrExjDrv40ni3wNpLbDMePArNbTWHnfs7hZ1ZLgme7Yra9393MMbX9cFoKpGAM9Sfrbc4K
    hnpu5TCkbIufNZvJROiEdXsYwLW2YD7kuskm3XhMsztVOSbvBLYb+rJ/1CF2Ge5gaqcD/Z
    hZdAdu5ctXLFZXEyA3NxwS3LAEH5q5gPlK28JNfOM6v+SY/waHWtAd8R9cse8af1npznka
    ghITllqThGYj9g9Z3WK7j0LWc2+D2fzy97at1i9Iq1uuoWR0MFbMM8ywu0ksQmJZCV0D0b
    EphZiafNoNdrnZkGu4Hcboqsakyih57zbMiILKf5K6zcfcidiMosgIy8cg7Q
X-ME-Proxy: <xmx:8YApah2f0lyJJyDEs7ODZNlHTqGjzg99w9xvez4tQRWhhQCxI7O8Qg>
    <xmx:8YApalc2HinzcqnFPu3mnm2K4XPx4CGRWIQbny3by-b84TDQaCY41A>
    <xmx:8YAparZdVfNk-hHFPE1p6AYk8Hzi5af8KtBA66VcVWi9DjexOK3Wrg>
    <xmx:8YApaqEszQ7BtTcEpQIGG_GV7rwLxA2VeElqQX9FmyC8q2-LuH6M2g>
    <xmx:8YApah5kb701ImnyLw55b2uOiTgwPbdNtZupaHP4y4wRPmLV13fCt9hs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 11:21:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
  phillip.wood@dunelm.org.uk,  git@vger.kernel.org,
  christian.couder@gmail.com,  karthik.188@gmail.com,  jltobler@gmail.com,
  ayu.chandekar@gmail.com,  siddharthasthana31@gmail.com
Subject: Re: [GSoC RFC PATCH 0/1] graph: add indentation for commits
 preceded by a root
In-Reply-To: <CAN5EUNSFBC0+aoW1ceGjEiKWBRjzuzUEUjg8Xys5O9rDsJdkjg@mail.gmail.com>
	(Pablo Sabater's message of "Tue, 19 May 2026 07:59:43 +0200")
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
	<26d887d2-6ec2-4af1-b0bd-8e9b017bb4dd@gmail.com>
	<CAN5EUNQCsKD0CJqDi43i2JVBQQChAZVt_THQ1wGpdeydNHHCFw@mail.gmail.com>
	<2e8b9b1b-6a69-4e94-95ea-7f587435bfce@gmail.com>
	<CA+J6zkTGgeNuH0eusTy+t8LO3bjygSz4svJB=K4R5ASmBdd0uQ@mail.gmail.com>
	<CAN5EUNQoKRqt3FGLmzRGpPU1nO5jCAogP8Wm9gBZXuPbMNbQAw@mail.gmail.com>
	<xmqq8q9gb704.fsf@gitster.g>
	<CAN5EUNSFBC0+aoW1ceGjEiKWBRjzuzUEUjg8Xys5O9rDsJdkjg@mail.gmail.com>
Date: Wed, 10 Jun 2026 08:21:19 -0700
Message-ID: <xmqqcxxyxvyo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

>> > Do we want cascading or just a fixed indentation?
>> >
>> >     * A parentless
>> >     * B parentless
>> >     * C parentless
>> >   * D1 child
>> >   * D parentless
>>
>> I am late to the party, but I cannot get how the latter is viable.
>> If "A" had parent "B" whose parent was "C" that is root, wouldn't we
>> see the same output?  Or are we adding " parentless" at the end of
>> the one-liner log message?
>
> We wouldn't see the same output because A and B wouldn't get padded in
> that case. Vertical adjacency between indented commits doesn't imply
> relation because indentation means that they are "parentless",

Hmph, I guess such "the first column is special in that two commits
on consecutive lines with the asterisk on the same column, if only
that is on the first column, are parent-child, but it does not hold
in all other columns" was beyond my imagination. And that was why I
said I am late to the party.  Do others find such a rule intuitive?
I didn't (and that is what led me to ask the question).

> Anyways, having more than 2 "parentless" commits one after the other
> is strange. Cascading is just having a depth counter and printing the
> padding depth times, so I'll keep it as it is more intuitive.

Is everbody happy with this version, or will we see an updated final
reroll to tie any loose ends?  For example, do we need the above
"vertically adjacent commits are in parent-child relationship only
when they appear on the first column" given as a new instruction in
the documentation to help users read and understand what the graph
output is trying to tell them?

Thanks.
