Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2928B27AC4C
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421719; cv=none; b=DxUNXR5XB6uxRnjIpIMp56dTWMfM2nwU8Wv4p90LKwKGKi/m0O2B04+56lXNtYL4O4NqeJ1vkytMi5NXhE+MfR4xydaeU4AWPEClWcNDk4nEB+IUsX8ewJ81IgJPe4XoPmm+Y0RHr2GpN7/efDeSas1yo5Qp0SExYohkPAT2lRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421719; c=relaxed/simple;
	bh=Bls6HyJSbTbN3QWRUsgEoT6THQ5Clwr62X5VP2hHWWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EoStRakMHhR9SSKSuF8aTjes//08le0U/v7t6qmBTFfINcmd7pYeLbA7rts8YuoOEAox2NQBLC3AJ9fm0Z90t9mhHsGo3UIvI2qeY6YyfH+vbue8x7IbBqAISwnCu1LnrGivhxJhKt50YG36N8MbwHJkma4HGmXyazJTY52YZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WOb6ehZe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nzsSgKz4; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WOb6ehZe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nzsSgKz4"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0110925400E7;
	Fri, 16 May 2025 14:55:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 16 May 2025 14:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747421715; x=1747508115; bh=9TGFHxvU5j
	UtkEeTt/KmpdcjeHgOBHbk/TPC7Hzgafo=; b=WOb6ehZeieJ9S622PIEARHmAz8
	LQpJ9e2aRDDKVYgwy8qDP+0uuqYUEAFk0GIMQwcUoJgciR429MsHrVdLcB8EAY3A
	gfE+QYdscRz8a59y2YZb0pEzZDRX1RLdSr+UGFUT7QqlKKKAbnWJDmi8x7evzmU/
	ZsngXnCA6i4nKJaZIF3su9oFNcaiUt9ly4QhBcVPZ5NnU+TSeIhkIkA1axBVURf9
	EPNrnG8no5NTK3/AyWI++EyG2Bb8voY/QII69FjxszV1ykTjjcMq+o/zSc8uiMEQ
	ldUVsXzDUtXX5sSaHKPWlbxJg0TLplTfKXCoCTR1URdK220DZr2i/GRgV0eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747421715; x=1747508115; bh=9TGFHxvU5jUtkEeTt/KmpdcjeHgOBHbk/TP
	C7Hzgafo=; b=nzsSgKz4be+MVo2zjfjvcQGfr4NO9/aoSJq51dANzR1gHwVK3Kq
	mrickUIyMR3bjMvjzqTsFw7MhniWuHbH0gX71qNXHTUqOlaxg6r+9dIQWF2dECrl
	rgRqO7SdGSWgKhOzqAUUvITc0iLSFnFNhSD53qz2ICT1kiUmmmmouIMdXYr8KAtq
	DXrBBDvW4PjoHasPJJvI5PKyfEeZsryBZT8dFEuEHIkDMUCoaOq0J4NLiIxcFZND
	ukMLdHxC2RcRUYEA1CDtuYEXvhhfTHbey62wvtAr1kXbesQgh5sC3bAIJx47YGYt
	lnEdPoBHC3sSsuRaEOzPg6VYkWUPUTVvFsQ==
X-ME-Sender: <xms:E4onaAKD8A-Chu4zxInfaPnxAMtbfL7KjwAeGgwAFH8e2cwRxf5hKQ>
    <xme:E4onaAKw6agMxC1COxFr10M-NCRYn21AnA99COErFDiZ8JSCt5dDjfESJCQu8haos
    LhJpgHhKEdc7mWWYg>
X-ME-Received: <xmr:E4onaAsV2tQWSTcQS9qGYDNb_L7Cixd4itf7pXiUFCgLF_mUeF--BNxbx-raIoFKCPANP5-hp-Uf5XxmncmGnpC5ovtOBeSySl2T2zI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:E4onaNZDysTuKtivqg9xIVIC5zquHluynB00q9TyjrqbT7y8ZQxIdw>
    <xmx:E4onaHbqnNwbEBOwpCxKXc-R5QCOrzYzzTvtogXG9lKjjc-sPaAN6Q>
    <xmx:E4onaJB0JOMd9NvAYDXRSLKENWB3rYzCvoKptAHKPnpfCtwgz0k9_A>
    <xmx:E4onaNaSnD4EGE-vGEGdytUjqcifv7CLanyciSFWOmQD35BV8qxrlg>
    <xmx:E4onaLkEb2fFjpar89MAp6LE45i4RaXUGRrEUFYEOT6tVoMwLd0cstqd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 14:55:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Derrick
 Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/4] Integrate the sparse index with 'git apply' and
 interactive add, checkout, and reset
In-Reply-To: <CABPp-BFmgAsps=Y+YE=dTUxnGSKj+49jNxODdQDOnvuF7XzKZA@mail.gmail.com>
	(Elijah Newren's message of "Fri, 16 May 2025 08:32:11 -0700")
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
	<pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>
	<CABPp-BFmgAsps=Y+YE=dTUxnGSKj+49jNxODdQDOnvuF7XzKZA@mail.gmail.com>
Date: Fri, 16 May 2025 11:55:13 -0700
Message-ID: <xmqq34d4v10u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> However, I think Junio already merged your v1 to next
> (https://lore.kernel.org/git/CABPp-BEukTWwsuC7MMR8D5_UAhyw-LgT=DsPKAWeR_ZmVVhjzQ@mail.gmail.com/).
> So he'll either have to revert your v1 in next and apply the new
> series on top, or you'll need to re-roll as fixes on top of your v1.

Yup, the earlier one will be reverted when I queue this round.

Thanks, both, for being careful.



>
>>  2:  63caae87634 ! 2:  0a2752721d0 git add: make -p/-i aware of sparse index
>>      @@ Commit message
>>
>>           It turns out that control flows out of cmd_add() in the interactive
>>           cases before the lines that confirm that the builtin is integrated with
>>      -    the sparse index. We need to move that earlier to ensure it prevents a
>>      -    full index expansion on read.
>>      +    the sparse index.
>>
>>      -    Add more test cases that confirm that these interactive add options work
>>      -    with the sparse index. One interesting aspect here is that the '-i'
>>      -    option avoids expanding the sparse index when a sparse directory exists
>>      -    on disk while the '-p' option does hit the ensure_full_index() method.
>>      -    This leaves some room for improvement, but this case should be atypical
>>      -    as users should remain within their sparse-checkout.
>>      +    Moving that integration point earlier in cmd_add() allows 'git add -p'
>>      +    and 'git add -p' to operate without expanding a sparse index to a full
>>      +    one.
>
> Was the second 'git add -p' meant to be 'git add -i'?

Good eyes.

>
>>  -:  ----------- > 3:  d1482a29d8f reset: integrate sparse index with --patch
>
> Other than the one comment above, your changes from the range-diff
> look good to me for patches 1 & 2, and the new 4.  I haven't looked at
> this new patch 3 yet but wanted to comment on the merged-to-next
> issue.
