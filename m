Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5552C324C
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095022; cv=none; b=l9pBjaCNz7n3iyYV2erDg0jFbfwssN/QyZLC/T9YbJnrQexLYHlLOR8Fx01fYrSNtGI7QFuQz/VStf84/WASklTgKKOaEVQycvHG3qcfaX9rOTnTLBu8eeyRQxhSQr8goUDbsYd2FPKanCg7w1Xcvx+qD1GCLBFqRBf+HBXJNYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095022; c=relaxed/simple;
	bh=NgWHlUY8GOfP+WDkbX3xKU7yJOqM6dWRNqrWAQ7wwB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NW2U0Gmi8GTYlmyWulEcN0YHgy7yiKrxrpydDEbWU4UjNhB4y/OnPV+CoEd6qPDfRsfL8uOTjhYxf1s+eV75kF/2kBVWXxxG2WYkKhy0knc9DAraM4hgvv39ziHbTAbLFrMxVVgkwQ5KPqsPMBM9tJZWAmpPuJ3i3OClC6AU+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TZyqc5sA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MMShTRCr; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TZyqc5sA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MMShTRCr"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9152F7A0089;
	Wed, 13 Aug 2025 10:23:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 13 Aug 2025 10:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755095017;
	 x=1755181417; bh=zlfvDxbyVNMSn6SRK9esKm8lOfoEgR40JXGhFlzVbQA=; b=
	TZyqc5sAII8Yt0qbdzCLOsQLYoWRmfhWwmEmg3W86034gbPHose7PPGM61GTIHuc
	sFpXro2THwVXq9nUn7oD0sMbdShFXEtjLkp5B7eRzXipqak37bkY2fn3/cT5S2B9
	pgxcC6ohPb3ZMInWIoHv8U9X47exh7SBMfEE5XdwlGq9yn97+4Y82wzDnC7a7+C/
	X6ycEp92FCGgXS88qW/hjXzaQ+Jihc2RL+hYbY3zV1A/SuU0xZJjl7YL43W3dnXW
	HVn0+oBKmgI8pwK0jV7iiWMiSGy8HUruyQhWdC6ilfPX89H3c4zImQklB2LXBegI
	j73PoHK0LXqJiZ4d+xSc9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755095017; x=
	1755181417; bh=zlfvDxbyVNMSn6SRK9esKm8lOfoEgR40JXGhFlzVbQA=; b=M
	MShTRCrb8gh65gOM6HoHHTucBxrG3wVtMULM+WNZCG3cOOAM7dd9licfeCm+R1r8
	5uQM5gx7i31nopXoQSm6Bvqz0SPNofJM5eut487YxaEdOaWFX4r9q78HGZcc4sEg
	wqrDg8VtHY7ZWWJlZs/96597gRhTzy9fnn+52bqzCSWhjEvb8ke6IA1em6waQwml
	9iRdYODQLT4JPrwqMDOJMOAuk7ABXXL2JhaHXr+2cO5XVzAotnaQ51gC8Ht85DT1
	XN6oMSTlG/t21RlVlzeebl/hiQpMFCaavG2Kv0/xdHXFCOlZhL9dlAE0KKGwL8N7
	XjMlCSEXltGOdhLY502FQ==
X-ME-Sender: <xms:6Z-caEJKZNwL0fPxDNPvvhsyxpR4wFVqS6v54MKMvKFeNHEfnkXMIA>
    <xme:6Z-caMlEBuuRe44oQH4TfylXr4JvDUhT3AkBTxj217g9E3WWo_tF_4PfmZgZka4yJ
    GHgTXhQt0vJ-v2JHw>
X-ME-Received: <xmr:6Z-caFJPsU46cuUJrFcaZSqib22R_4soYv4F7vhRebJ7aCkvKKFKFa2WCMs9mIyc9xjn5BuvoWCTbNNcZ0sfcNkJINwyFWvljzRj--M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptggrrh
    gvnhgrshesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6Z-caB5B0HDUz6EUWEEl-lYTelcVy07-rj0YgYn8PKLh8ITOVAPhgg>
    <xmx:6Z-caJ3MBL5gtybQhmSO617Vr4EZ1TYlKmiSTgpxFIu0BSSdjXwiTA>
    <xmx:6Z-caHejpAzCwu8LAubzFgQ65Xffbt5WiFR5OKOm-MBYwkudyiRtYg>
    <xmx:6Z-caPeHeC8P5ODU-ljKlhMtoDundtbdG8gfWjFGxkHIK8Eyg4Jl4w>
    <xmx:6Z-caEoqQb9DYwumHXW5DDvzKBO2hLIgi-Gfi8HnAHq6g4TVJNo1GuQA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 10:23:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Carlo Arenas <carenas@gmail.com>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 0/8] reftable: a couple of improvements for libgit2
In-Reply-To: <aJwsq-dLyQ9I7fDo@pks.im> (Patrick Steinhardt's message of "Wed,
	13 Aug 2025 08:11:55 +0200")
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
	<20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
	<CAPUEsph_rWfbxobf0fWuGcWF=XNa4911FAXvB7agbfyUiZDr6Q@mail.gmail.com>
	<aJwsq-dLyQ9I7fDo@pks.im>
Date: Wed, 13 Aug 2025 07:23:35 -0700
Message-ID: <xmqqldnnpafs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Aug 12, 2025 at 12:00:53PM -0700, Carlo Arenas wrote:
>> On Tue, Aug 12, 2025 at 2:54 AM Patrick Steinhardt <ps@pks.im> wrote:
>> 
>> > Range-diff versus v2:
>> >
>> > 1:  ce08ba1217 = 1:  1613715dc9 reftable/writer: fix type used for number of records
>> > 2:  80a87ff19a = 2:  4a082b71fb reftable/writer: drop Git-specific `QSORT()` macro
>> > 3:  e230c97347 < -:  ---------- reftable/stack: fix compiler warning due to missing braces
>> > 4:  dd413b76a2 ! 3:  3977a1f497 reftable/stack: reorder code to avoid forward declarations
>> >     @@ reftable/stack.c: int reftable_stack_reload(struct reftable_stack *st)
>> >         struct reftable_stack *stack;
>> >      @@ reftable/stack.c: struct reftable_addition {
>> >
>> >     - #define REFTABLE_ADDITION_INIT {{0}}
>> >     + #define REFTABLE_ADDITION_INIT {0}
>> 
>> This define shouldn't be needed anymore AFAIK
>
> It doesn't exist anymore after this patch series, as it gets removed in
> the fourth patch. The above change in the range-diff is merely a result
> of me swapping the order of patch 3 and 4.

Interesting.

What is being shown here is that the reordering patch in the
previous round had {{0}} here (due to the old "fix compiler" step
making that change) while the new iteration has {0} instead.  These
are both context lines that we are seeing here.  As the "fix
compiler warning" step finds no counterpart, old #3 is not shown
above this part, and new #4 that removes this #define does not
appear in the output, either.

A diff-of-diff is a bit confusing to read when something like this
happens.
