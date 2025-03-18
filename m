Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056602FB6
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258179; cv=none; b=C1yJ+P430ZZZiXvvfutwGtqeP4xfy94ba5QcrQxkU/CqT4UyAAA/Da85Rh6w9nIsdx+wlbmOQEyjhSvC5AYE7SmcedCM0K5VdcXiy07ZIWobV7cZXhRVU4pquBTEKRDvzfuw2PPoyG6vP6za9dILjUx6qNBBq5nXQ6+MQCh+ToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258179; c=relaxed/simple;
	bh=yttWR5E2eTyf6mzOm8uiKTF0qe6qim+aXHrebcvvvDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vA1a1+6/BykmDPq06NPf1ClPkU3ynjuCcAcCjz97YmJZH3KU8xAkIKcPpRxUQF7fVHb41C+/Bujykvi/r+45zIZ7VNZdz5FJZ1m6c7RpIrb4s8KyRtRL8G+sSA3kQTz2CJ1QsAq/khQRiAHQszE9gfDYlYuTI2UywY1pJd6dFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aWDMrTrK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nCjZMJA1; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aWDMrTrK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nCjZMJA1"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A399613833DC;
	Mon, 17 Mar 2025 20:36:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 17 Mar 2025 20:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742258173; x=1742344573; bh=Q/FicjpKP3
	IUt2lnon40okDrxu+8H3bniGjXDoHBBcg=; b=aWDMrTrK5RLilwoRwkR41EeBwB
	jgNeuWnc+VGy9A9U8aM+sK9y1HlCtNdOp6gSDB6n6NlANLWEQY4IKWTLutMnMpgw
	Mjn+vHVFVbx1wlMIXERUZ64PPeI5jiXxIMQYHqSEn44i0Bg3hHwTYcVoJTGX5rNX
	G+ZwYXM6pG9PgWZsXcAcOTYc6I/swuf/ykSilJSGfDqKel4qXKlb7HfSQx5A7Jyo
	eJ1k/13oJSbw87HOQolZcSAUWXOjW69p2sWuUdcXdQiUgf9lU4Z4BvMqAyngvQDL
	9+izOahNvtJbjafBMYDPvfL0QCZVJKA+akFATohQexKfBIXiIOcZSXt3OVBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742258173; x=1742344573; bh=Q/FicjpKP3IUt2lnon40okDrxu+8H3bniGj
	XDoHBBcg=; b=nCjZMJA1IJ27eGlnzkf2DPZEDmrmxRiSBDdKs3yk4Q64bSAS/C7
	xd9ESZKOGj7etZ9t/nqdbRQRHnwwX8QDl0J3pDcxUGAAwwx8dbbTiz5PAs4KHWJw
	3GFJyP1bOFUXo6JqNo9t4v4TfFBH1iNlQbvflaGtYgpJcUKc1Ss5/l+0yVgullXl
	VINfI7Va37vXHomW9pr4vjSXIwGB2OcErQKTTWKwl8NZ08rKP//LM41VCue7YWsY
	sTSt8YAiAi3sS6t46unpHYzcn35qJBcsOO6+1pnBhVi3ku0DwWmr1JztkPzsa/mg
	SdHd3C+Q1+5rR9EB9S9T/QY3AKv2O2prvKw==
X-ME-Sender: <xms:_b_YZ4_UpbpAI6r8Ca_DuTX8Cu1zSv1j-OI3azQIVsx84qqcm-Xm2A>
    <xme:_b_YZwsXXrN5xj595TjdncTMbrQG6Vq1aICSvd0lR9swUO0cv3DuIir4QHO1xAgn-
    kW1pwlAyvTymgHlQA>
X-ME-Received: <xmr:_b_YZ-AJSKcQWU4CMee2JIx1DLVN1oHH73tJYkLnE-ZszJHRJmc-QA5vHFervPuxseJoHiYBYt5TIQ5LsjWp6ptBzumOOLrx3JOa0W4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efgfdvfedutedukeetteevheeigfdvtdejffdtkeefjeffgefhgffggeegfeefteenucff
    ohhmrghinhepmhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:_b_YZ4fg7pHu3wC3eGiMIXUCprhEGILGY8IVfxL6qORO1AibH6Ueyg>
    <xmx:_b_YZ9OnJgvLJdD8Sb90xWQCkgMOtW6Oi3Y49Ys_AkwEleu2_6_jgw>
    <xmx:_b_YZymjp6u-b_IYF-xcc-lAtdSSB5DUEeMowRpejyNWFpPnia82aA>
    <xmx:_b_YZ_vfYB0GmCXsG28smZ0dlRQiXipwb9UdlknPZe6iP1YyGOGpqg>
    <xmx:_b_YZypT0o0SD-awjzzofRYrdF7rLOqEs0fNi_1mWjVCUtIdyQDSqCcB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 20:36:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] run-command: use errno to check for sigfillset()
 error
In-Reply-To: <xmqqwmcn5k11.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	17 Mar 2025 16:12:26 -0700")
References: <20250307225444.GA42758@coredump.intra.peff.net>
	<20250314210909.3776678-1-gitster@pobox.com>
	<20250314210909.3776678-3-gitster@pobox.com>
	<Z9iUe3Hg30W5LFSZ@nand.local> <xmqqwmcn5k11.fsf@gitster.g>
Date: Mon, 17 Mar 2025 17:36:11 -0700
Message-ID: <xmqqcyef5g5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> On Fri, Mar 14, 2025 at 02:09:08PM -0700, Junio C Hamano wrote:
>>> From: Jeff King <peff@peff.net>
>>>
>>> Since enabling -Wunreachable-code, builds with clang on macOS now fail,
>>> complaining that the die_errno() call in:
>>>
>>>   if (sigfillset(&all))
>>> 	die_errno("sigfillset");
>>
>> Hmm. Would it have made sense to swap the order of this and the first
>> patch so we don't have a DEVELOPER=1 breakage (for macOS with Clang) in
>> history?
>>
>> I think it's too late now since this topic is already on 'next', but it
>> occurred to me idly while reading this patch.
>
> I thought db1d1f5d (config.mak.dev: enable -Wunreachable-code,
> 2025-03-14) aka jk/use-wunreachable-code-for-devs~2 is still out of
> 'next'?

Ah, I did revert an earlier one-commit topic out of 'next'.  Perhaps
I didn't tell What's cooking about it.

