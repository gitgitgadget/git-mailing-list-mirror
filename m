Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ABC285CB2
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366254; cv=none; b=IflDimw1k4cScGHvmBrJ+d0PEpQKCa8bHX4xzeKyiq67TRly2uHDLRH+mtUVE/6PX3c7wjF0JdJJMm0F2qWO/IGsY7JcDkPosqgQIAXsu85F01xpnaAukP1Di3nmVZ6bne4pvtnmgHH7UfFFhmQW8ncwHBTzDc1VQqhf2l/Ms2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366254; c=relaxed/simple;
	bh=iHq96/xDofT7t+4+Q22p+iBqbPWgdKnDBI5bffZPc50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b5bvPh00OjVEZVMkuwluLfHwFNdCGHmNemJBovX+JJN7ijpPbpLpcSZJ3Z+AVSktBj1A54v5dZ/bsQPnX6DYgER5pxrfN3AAmD3xUXPcMBl4wb589ibVl8Qq13nrZ5Xck5S7rWxK2AheJrtKDrVZh4QRN7LOf6hN8FWapvlNVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SFrzCbNp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k2WhuOc9; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SFrzCbNp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k2WhuOc9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F41A37A01A5;
	Wed,  5 Nov 2025 13:10:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 05 Nov 2025 13:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762366249; x=1762452649; bh=39wsYDiwIQ
	kBt3nx4IoQZdUJ8hnxDTo32fW+MCOZOB8=; b=SFrzCbNpU93MdjzQr4L0Od+bby
	PTqEb0ZrAKwkiFkwazdBTtXOuQihFr7WVabrL86tTVz3LNHdeJoR3HKX9WNcD2j3
	igEl6pIm/3L4yv8RTwBi1RQuRgI/v4rjXnH4awJHP1Ax6Ryy1P8tlXYpDx/dLg4S
	hhnnangMuc9s9rfoBvcDB/wl6IE3yPc2SbgF7z72CMGCVhAiufyfeVocJnOUe01W
	SdKWoSwLmYcGsG26tFBByyqde2oWXNG+jyZp2WvFwYzq+OW2jrzANMGbrJ2jweiq
	qINEwkpwhMpqc89bHlpdax5WrgHUq+HlhuDguIwJwiaTTtGst2ZJKiSWmFDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762366249; x=1762452649; bh=39wsYDiwIQkBt3nx4IoQZdUJ8hnxDTo32fW
	+MCOZOB8=; b=k2WhuOc9Xd8YLol1BMKWTG8ZFTzMQjwH6WenHAVQv4fF5okakE+
	7+7jG+Hd4IH/m4vRinHHkoK6INY5/4RJIXrABHiBV0FINw/eVjYdHyyNcodUYFmI
	6F0oo/lkh783FXSVApAofGIMAEv2cTljt+hK+ul/M4FlGBlTxaWgSYx7phCQp9Nd
	Qv6axIH/TIHuo/SiI8NXPSFI3Nha8thfOcXdHUfl8tuPmd2Wb+22qTHTCSjh3vLd
	SMk+o7VHmJDFm5uFOuWKGCwVNpvsyhdZwS07z9W9S2CYKn7+6QPcYEv6MOa8GeRt
	+/7JKX+pPS7/Qm4nte5xpo9BUqaeTnofB0Q==
X-ME-Sender: <xms:KZMLaWNFpnimEBYXbXWE2lGmqjw0WJu3iw6t-sAzt556m8OHvPa6XQ>
    <xme:KZMLab1jk60SmZ-GOer3g5nMDyzXKLdozgr_5awr4Tq6wJVSFJj4zr3Q25qhiqgRI
    kyYhEoTNrcYanzSVPc_eA5Ce6zwD7dl5MA9BRUjYFqtx6x0e8GR0Ys>
X-ME-Received: <xmr:KZMLaVnYq8734J9QShR-bzM4n_teM8WlFbOgkqjuZXJbmw62jckAQzYtCTc9z6rbYyhh1LuPNYj-pFY78Sby43f96OPIh67kSO2v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KZMLaSU-OIkArI4ZgIK2LzY_7suFIkvHTMfQGCBbRihm89RgtzwV6g>
    <xmx:KZMLabtw-Yn6PC0Ft_BcLKiFJCDNs8uVjZXMcP0QIl6QLwssIXZJ1A>
    <xmx:KZMLaVZb3fR9mCq7y2fO8rIruvOBgyK2ksmd5tprput5iZkO18Y91w>
    <xmx:KZMLaaVv0D9johzt3v-QSnO4b5uf7RsPopcM_3Cvf3VkW-02qHU09A>
    <xmx:KZMLaZngfqZ4MZz0JCIkQPytFMGclXhZKIzIfNv1ksQZYkeBusF1k0nu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 13:10:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com
Subject: Re: [PATCH v2 2/5] reftable/stack: add function to check if
 optimization is required
In-Reply-To: <CAOLa=ZRD_zNCnGf3ibU=X04vC8WjxzRVAyg+OwPr1Hf12kSGgA@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 5 Nov 2025 09:11:53 -0500")
References: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
	<20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-2-303462a9e4ed@gmail.com>
	<xmqqcy5xpmrw.fsf@gitster.g>
	<CAOLa=ZRD_zNCnGf3ibU=X04vC8WjxzRVAyg+OwPr1Hf12kSGgA@mail.gmail.com>
Date: Wed, 05 Nov 2025 10:10:47 -0800
Message-ID: <xmqqms50l594.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> The reftable backend performs auto-compaction as part of its regular
>>> flow, which is required to keep the number of tables part of a stack at
>>> bay. This allows it to stay optimized.
>>
>> Sounds very sensible.
>>
>>> Compaction can also be triggered voluntarily by the user via the 'git
>>> pack-refs' or the 'git refs optimize' command. However, currently there
>>> is no way for the user to check if optimization is required without
>>> actually performing it.
>>
>> Sounds very sensible goal.
>>
>> But where is the existing logic to decide when it needs to
>> auto-compact, performed as part of its regular flow?
>>
>> After reading "the reftable machinery already decides when it needs
>> to compact and does so" plus "but the logic to decide is not made
>> available to users", I would have expected for this patch to extract
>> such an existing logic or otherwise make it available to new callers
>> so that things like "gc --auto" can call it, but the diffstat shows
>> mostly additions, which does not give readers any confidence in the
>> new function that answers "do we need compaction?".  It would give
>> _an_ answer, but there is no clue if the answer it gives is the same
>> answer as the existing logic that decides when to compact as part of
>> the regular operation.
>>
>> I am puzzled.
>>
>>> +int reftable_stack_compaction_required(struct reftable_stack *st,
>>> +				       bool use_heuristics,
>>> +				       bool *required)
>>> +{
>>> +	struct segment seg;
>>> +	int err = 0;
>>> +
>>> +	if (st->merged->tables_len < 2) {
>>> +		*required = false;
>>> +		return 0;
>>> +	}
>>> +
>>> +	if (!use_heuristics) {
>>> +		*required = true;
>>> +		return 0;
>>> +	}
>>> +
>>> +	err = stack_segments_for_compaction(st, &seg);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	*required = segment_size(&seg) > 0;
>>> +	return 0;
>>> +}
>>
>> Specifically, where is the above logic come from?  Is it duplicating
>> an existing logic but that code is hard to separate out into this
>> helper?
>>
>
> Good question.
>
> Most of this logic is already part of 'reftable_stack_auto_compact()'.
> We also have another similar function 'reftable_stack_compact_all()'.
> The former is used for compaction based on heuristics and the latter is
> for compacting all tables into one. In the refs subsystem usage of
> heuristics is denoted by the usage of the 'REFS_OPTIMIZE_AUTO' flag.
>
> The function we're introducing allows users to explicitly mention if
> they want to use heuristics or not. This allows us to differentiate
> between the two modes. The result of which is that this uses intertwined
> logic of the two existing functions. Hence we can't extract any code out.
>
> I'll add this information in the commit message.

You mean you already have two duplicate implementations whose
definition of "when should we compact?" can drift apart over time
(worse, they may already be subtly different), and you are adding
yet another one?

Instead of describing such an insanity in the commit message, can we
refactor to have a single central logic that is used from three
places?

Thanks.
