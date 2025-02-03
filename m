Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0940205AC3
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590699; cv=none; b=TOLioTk47LuPYB+tG9TxWTomTicqRsRLSdwlOpID9OzU+XKZigWLKTbPa8wB7BDEgnmvllZYY5Ypcj8SeVa9Lixc6oVmhmyZEmrTFW+G18fQel9lNlBcBW1+kcSUf6Hxr7nNFpWFaQXVM28RkVDmoYu/68wZK5SIHC7/Ag2HWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590699; c=relaxed/simple;
	bh=ryfaPYW4PCAG7vBGaEGgFi/CIS6UZuxMdFrTq0G0dwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MJhgEqluUEIGxArDjB7TUH1QRn9o68DKhGhw0MWSoho8Y7G543G3C/6Y8MGHvwTON6HFI8YdP1yTxFTJhJhYf+oE9tgANhnrE0mpWg69tcfMSrTfXdGyfmjEJRYwJ2po9SrfRB+p4Kj3g+CDu6/WL61RfrDkRYHyH/je1ghR/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vf60ZVoo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HyM8xFZN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vf60ZVoo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HyM8xFZN"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 08B14138016D;
	Mon,  3 Feb 2025 08:51:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 03 Feb 2025 08:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738590696; x=1738677096; bh=2vRmA0D6Q6
	p2c/oK8p9UtCyWoXxZ4ZBVHF5fgQFfuhk=; b=vf60ZVooBDz/lWKq9F4gG8Sr7s
	xF55q1ZKQIudjKznWPBW39qeHRoSw3YDdrKtJ8vppkqrHnX7tuRPOtKx+6KcusiN
	L/6DrBhdUqPsK7nvnsXfHH8fHUq8icfJ+0Lg62zfRGwekeO/YNNU32vaSxgYAR9V
	iujowEUe5SZXAJHn5olCJ4N8s8IAEN0CKYKJ5Zrdq/BoQVtKPf5Hn4Ur3ph+j9Ca
	8AAkcfmf8rEyUh6QzzVqJi+xm5/4E0h5nyjwEjMBWI1Xga/KZ2pWh8gCV6Bf+cf7
	G2FZzcIjLQxSe0OPIBlwZN+p24tP7DlPv0u76kyRHVVe3cAz1z9qLSCpGVJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738590696; x=1738677096; bh=2vRmA0D6Q6p2c/oK8p9UtCyWoXxZ4ZBVHF5
	fgQFfuhk=; b=HyM8xFZNrXRQ67WxqEE1aRxiVyyjMmLGhaEbRtDPX1/3aCIFzYo
	zshbK8NtG7nARRB+pbOeCjnu5S+oVAXnP08hxkvf/R0keqJ9m8jdkC8oE3ULJaxx
	Qw5Tp46ViolHg9Qn44X+E9efJUGmXjYtHI8Op8k42wlIFrL8EGevLHKYtOTUL4RH
	9arCmVPkFPAeH+hoSKfwuEZ/dJvgh4vU2NKDFUXUo3jyyQ+LpaKD730l6t/0r3f8
	WYglpJz2L/TWR4rLC69LgMCfa3XouYHEb9vWRjFnsWj+LS4oypw9Ktt9GRPzmigD
	O06JKA/3Sm83JtPxXdFFo+hvSIAi3pnhb0Q==
X-ME-Sender: <xms:58mgZ5fwy7ltRrbkeABSpNqtF7ziZeD_DucFvL6cNdDfpRVOejd6hg>
    <xme:58mgZ3M2J1v9yHC8a3pm0AC0GAqDGPPaPuIjU37KPEswBKcZmyYP48qesWBTfxJnS
    QweqxXPR0WUnmrzzw>
X-ME-Received: <xmr:58mgZyjZAe7Y5tGRAHyANB4HVoWFNbFd1Q_T3EOgVS5-TptA8XiauzsQsAx4lXz2wQtE8T1OuojlSbKERmh4AHmmifr8PSVCWSxW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffgffkfggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepte
    eijefgieduheffhfetgeeggedtvdefieeiuddvudetkeetgeefteejjefghfejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:58mgZy_SpiVVsqvwB6in3oz9UawNpkoZbEi-QmbuwJGCulwE2wRdxg>
    <xmx:58mgZ1t8daqjG9--qC0tl4WNbpW5HLxsaMFFAAGUiHjFJEMdEslpCQ>
    <xmx:58mgZxFRijD_3Hn7EKdMvGx-y5Mmt79HYvysmuCUugqVIt7KdeRkgQ>
    <xmx:58mgZ8NbA9wrVu5ELnu6326mDfCCxfV5cOYnNf9IiAGRRtIGw2eH5w>
    <xmx:6MmgZ9JnS1a1Yp13A3Pmj1mwvWU_hRRD9X5zZvyHMZRq5xgw7XgeuDYW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 08:51:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
In-Reply-To: <xmqqseov3oic.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	02 Feb 2025 15:39:23 -0800")
References: <xmqqbjvyv510.fsf@gitster.g>
	<20250123003613.GA3900660@coredump.intra.peff.net>
	<xmqq5xm6uwip.fsf@gitster.g>
	<20250131233452.GB3544301@coredump.intra.peff.net>
	<xmqq1pwi5yt9.fsf@gitster.g>
	<20250201022946.GA4088801@coredump.intra.peff.net>
	<xmqqseov3oic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 03 Feb 2025 05:51:33 -0800
Message-ID: <xmqqo6zjyw4a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> But I have a feeling it is just putting the same on
>> both of us as we see the same CI failures and poke at them
>> independently.
>
> Certainly true.
>
>> I dunno. I'll try it for a while and see how it goes.

After seeing a few of your messages that begin with "Coverity
complains ...", I appreciate them a lot.  Earlier I was naively
hoping that triage-and-hand-off-to-original-author would be much
less work but no, we very much need to somehow find a way to push
the triaging part to individual topic authors or this thing will not
scale.

Perhaps I can control the rate of topics that trickle into 'jch'
from 'seen' to keep them a bit more manageable somehow?  

If an iffy topic that begins its life in 'seen' gets rerolled number
of times while there, but after the final reroll before getting
merged to 'jch' (because it was marked as "Will merge to 'next'?" or
better in the What's cooking draft), it never gets rerolled until it
hits 'next', then your workload would not change compared to the
days back when you built yours on 'next'.

Of course, the question then becomes "who will vet these topics so
that they do not need a big reroll before it hits 'jch'?", and we
are back to square one?

So, I dunno.

Thanks.
