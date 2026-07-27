Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D792771E
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785131147; cv=none; b=NjC1H5dJZrh5c3g5iQaojK1g+fp6r1chljbjepHRq8ybIbVRPkV4MkqkBj9MrimjivV/1ANCZkM+1tRoI4dhPAxzZnMSo/1fGraCrOkkjA4AtsGRDYpRcdUeSpZeOjDzcwKE1q0GqlNj4sAXylYLtIkKbWPuRXQl22KwdY5igBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785131147; c=relaxed/simple;
	bh=VIl5tmmErlJIYe/mqBGbWiSnVJlzvMDh/nyiOMOkVlw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f3obVolpUTbipB6zvasID6sEIdWNheBWHbmhz+05Kx6+nOoyDWLKKhnpheiqwBUsJheLFwnaUz68GnNkbfrO7Iew4auPV292a+eZIW6PDr7LLumTHAEq8nPbuYA1KSdDt5yKOpcjvYAhSdOUXHXHAeERQ9ZJC5TxwgVg9SRdmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lBe4AcPL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KtCQ/kiE; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lBe4AcPL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KtCQ/kiE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 63ADC7A030A;
	Mon, 27 Jul 2026 01:45:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jul 2026 01:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785131144; x=1785217544; bh=39GebDNQ9V
	D6WzLmW2UIcJiHYMH22VTSJD8dHdRbFho=; b=lBe4AcPLEPEKKNEnihCLbpLDJj
	UBtTXfqIUpAZkxkrGRrzrDws2MglcBlUsir+nahwq+30soRBaRfbJ3PPob/P3Xll
	PGpIw8nSWe7/P26IJ2iqRBRzjEw6AXrCe+5Nd3IOs8TninM+mvuN6w0EsNFnkg1C
	0dJbZ6UwVipKLb773ed9DLApTicbiNO6RlzvAW30g13mkPzdn2n9DqVxx+QHA8L3
	pKxGcp4PguI/rpEPvK/whv6jwKqB3hhEss0Sx/H8K7B+luk+IweVced0kq/bwxxo
	UTaXRlUWGsi3e8f68ommjBlWK4w+s2fHIQGD2NLvBt0854VznUGEfL+6fFWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785131144; x=1785217544; bh=39GebDNQ9VD6WzLmW2UIcJiHYMH22VTSJD8
	dHdRbFho=; b=KtCQ/kiEqZWcN/74yYje1DVDEUZ8W6iNW07ff7Q8IRVirxnj4wG
	5ve+HuCWIR54Qs11rRjaMumza2FyUxJCevPGgm0BjwDNrV73zPURRt9GRrK9prEU
	Dx8k956W000t2TYfZTKkvNUK1G565Ny0NcMAcFAXQiQixJ7fWTUqg1KS9DAvBDMk
	t9oHNm7SuXA/aPJcnQ4XKwTb5FzmMdzT5z+aT69Hw14cXWYfyhlva1m7gZOfjVy6
	TOY4RsrY1R6WKaY5hF/Za7gv+9JRaQeM54hv+U8KmeK0EGeWldD8TgIuBDJuQn/P
	gtiQUd3W5c21f5HAe5ouDxkqiSHKC0xvnFA==
X-ME-Sender: <xms:h_BmajcmFZXRZ7nH_85YRLHNIVP7LWLuyqGCcUrr4URJnMwXPg_vqw>
    <xme:h_Bmanc1g8kxfw494JF0SIwiFU-8fNscAKo3Oxqy4lIYA5L6--Oaw5O9KjxY_R04H
    xCHEcnHbDX3-jg6wDTfnEzOmT_tKi6734PL2mHoGsqA5o2Xh-piJUs>
X-ME-Received: <xmr:h_Bmal3x6CFHO5GMsR312l4hxKWVIqLrUoOPAyFndXabZWMQBgql-rpNQIIcRQ37jhtY-zfvvsea-ZCMvJwXxJFNq-XDOS-Wug>
X-ME-Proxy-Cause: dmFkZTE7JAbQrYxDHG6/23RuPZo/keSNS7t51qVO+DKdRwInKs/ztLaQJEIcdklDqf36Yu
    8LWwQpnNZFi9S6xo2rQRS/n4+XS9XpbjRqOltJjGFQAJVgwfN8Xc0rdaXaG4k5up3Sgh7d
    ERlvSv6yuGwzMektjmHNah4RJhi0Su6KALiPsrYG9On/DNV2dYiyw+WZe4OVqjFa/5M42x
    P5GF38xNwPIZTM6OrAupbLnvODwvMFfELDH4wmyDa+VJzqHQVuTr5nsReRDT20UvAo9Tly
    t0j7/6bOknMz4wlnJlrmCZCJ9H0pVVHzWxonQxLIJ+k4oPvD8/3bojVtGVD0pKhe/QQlj7
    ZmLgfGYDfnUhiMeGXRjyJLBl+pIv74qVK9mJp8hp0kLfGdxB4D6dl4Zd4X7lMfHY+6vubD
    OpXYJISZozjSnMlQBzWr2ILfAKCzJtlo6+95fowI2vkpbgeGxfWrFVOCh7B15pFhF87dTD
    lXvcyld2B0nFhSf+F5mOJTXdgcQ/QhyyyliTDcE8CywU5YJ/mtW5fBaAz1civI09mfWm4J
    Sy4glAaX0yhrapEDQEFFj7vrrInh8oeg5ZLf/WU1MjkQMZHhd3HH2tMMUFuLIJyox3dZmo
    pOzKv+EAAFVLbZDcHFa9tOetXa8vJgzjh5lXfqIl1YX8TF5KsKE+Q3J7bswA
X-ME-Proxy: <xmx:h_Bman8lqdd1XGOha7GxpmQ5QYvwuZXalRhwr_W5QJN_89t7EMBb_w>
    <xmx:h_Bmai4slE3B78UH9cpDXleVuEA-IQ5_TAjeDX4oFp7seEQ5HLdYzw>
    <xmx:h_BmanuOYYMs5BVeJ5PMZQj8cZcsog76s8ir_ND3S08oP9aOmpz3LQ>
    <xmx:h_Bmas1lQWJvqPz6zn0yLzKCmTckbXRbLY_4SqmcSApGwUB0M4ajyw>
    <xmx:iPBmaoZiJ5g0ZTJTXNR3_h6-T-13vX_WTRnLUrRSP24MvjYFiPACFAf4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 01:45:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: erik88 <erik88@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Patrick Steinhardt
 <ps@pks.im>,  Emin =?utf-8?Q?=C3=96zata?= via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Greg Hewgill <greg@hewgill.com>,  Micheil Smith
 <micheil@brandedcode.com>,  Michael Haggerty <mhagger@alum.mit.edu>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,  Emin
 =?utf-8?Q?=C3=96zata?= <eminozata@proton.me>
Subject: Re: [PATCH] stash: add 'rename' subcommand
In-Reply-To: <amXJcVadL8btF_gh@vader> (erik's message of "Sun, 26 Jul 2026
	11:00:42 +0200")
References: <pull.2180.git.1784190706028.gitgitgadget@gmail.com>
	<alitkCsplW_DIaRw@pks.im> <xmqqh5lyhlp6.fsf@gitster.g>
	<allISNh-b6Sc6y5-@fruit.crustytoothpaste.net>
	<xmqqpl0mbetb.fsf@gitster.g> <amXJcVadL8btF_gh@vader>
Date: Sun, 26 Jul 2026 22:45:41 -0700
Message-ID: <xmqqtsplouii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

erik88 <erik88@gmail.com> writes:

> On 26/07/16 06:11PM, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>> > I have a large number of stashes in my git.git repository (211 at
>> > present) and it may be that I, in a mad rush to solve some problem or
>> > another, went with the default message.  I do this kind of thing with
>> > repositories at work all the time.  But it's inconvenient to have to
>> > search through `git stash list -p` to see which change it was and which
>> > stash I need to pop to resume my work, so I can see the utility of this
>> > approach.
>
> Same. I always accumulate 100+ stashes. I never bother with a message
> when I stash. 90-95% of the stashes are useless cruft but there's always
> an experiment, a script file of some sort, which turns out to be useful.

OK, so editing the log message for each stash entry is already a use
case.  In that case, I no longer object to the feature in principle.
At least, I cannot think of a way for it to encourage any bad
workflows.

The next step is for someone to review the implementation.  I have
not read the implementation at all, and it will be quite a while
until I get to it (if I ever do).

>> Hmph, are you saying that you are going to wade through 211
>> stash entries one by one and reword them?
>
> Not me but my AI agent ;-)

I have no sympathy for you, then.  Your AI agent should be able to
unstash and restash 211 entries one by one and reword them just fine
;-).
