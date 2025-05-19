Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627171E3DF9
	for <git@vger.kernel.org>; Mon, 19 May 2025 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678487; cv=none; b=X0vCBrfpih5U8E9YrugIyI1JOjXOyyb9Hdl4BQtX+pH/Rxl4XtJZUcDTCOPOkiO0YBLmGpcPBx6E9OJN+mfSASbHjxmqp0ma3viI9O3mK7fWbI0MgF30sOv42wBIXnberJrM+Wytqh74DEEqpuRhOMpMMgBFYh05YUNthupic6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678487; c=relaxed/simple;
	bh=Hno4ssZPVBTG+aDDfavkpNF7YsjHyEXUhlLvqyvjAxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ExhwTUPvuHPja/0omWi3iI+Z7c0dNbnn8S2lkBT+RS89DUKjc2ePHfBe/4Wpr0jmsANjKYNk9v9wLPEPJhv9CV7sXtYJfFCWnuxhGe7jtmNdFT5SMYNrtqWEMFTVnVLsQGXNZ6JLqJfFyoI6pfo08LXZfRKvQmhemqvSnEUeu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ft7x1fFz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YVFUV5EC; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ft7x1fFz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YVFUV5EC"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33EC41140106;
	Mon, 19 May 2025 14:14:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 19 May 2025 14:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747678484; x=1747764884; bh=TUOB+DG47s
	AmodK9Zve7xfkopRe4isjscoWoUw+y4EE=; b=ft7x1fFz07g5dVVZaQUrhxiYCO
	5Bxgd+JwLcnapxLghq7wAF1pHEJflblGIDG7sOJSJ8gBZBrBK7DKFXgVirbDJPLi
	tmZFHGT0gzQS1vq8fxS3EWQTT5TcCMexT2quXl+do605e2JlgWJX+q82vO+jrH8w
	z0QVO2SOkzvf6oQTQE8Iivw/rIwSZtDDulh/lDVny08PhVYDJldMKcOAZgVLdhQ/
	3UxijZOrbkGSrSrh6QogTG+DNuM0J3j8eqDoh8xV1CE0a0WUm7cb7pFuwNBoNU/V
	xJbn4sAGwgzboTJMvB1ynP2gi0pofzb6sivfO6T8q4Hii+gFl42HNBVDNwWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747678484; x=1747764884; bh=TUOB+DG47sAmodK9Zve7xfkopRe4isjscoW
	oUw+y4EE=; b=YVFUV5EC1OWmK+afR8km107XKXUY4x4uq597MsoeliQ3rigzEk6
	E19LUFykxQHX/4CPPa+p6rtnqYkn7sDX1xYquoicJQMP4KQd9De0M5GYo3SQ+HJ9
	79TC8CUeIBTsfnctW11beHNGGMKzdZrC33BOj03Cg0XzQSuKiFoe99bp8tDy9NI9
	1y5M4MNcI8JLhUAoykuD2+p8GRNp1vFonmgOMjanmpHQq7+QDVmYl6yJuDsHh5BK
	6Ihk94TbdUtdkr9g20RFRqIaTR4hGdjoyailji8z1y1/h8nhxghR6yhbSVS2jQxm
	4PR5rtgqzgif23iUdoQZmh/3tC4Q+KrupuQ==
X-ME-Sender: <xms:E3UraODXrVbxJIHyOmkvSdgLnupnRIZMcm5HnaPyVj09tce96_29Fg>
    <xme:E3UraIhGbqJ8xWma0JPUFtJg8Zz2Q7U8aoIZFCJaix9vrYR3gVTBRa81OZ2vicMrm
    3NUJVKap8wgzT4BGQ>
X-ME-Received: <xmr:E3UraBmQEikb0jqgws19D7u7xtrLKyVXWn_dHmNE9BdikYbgKJW2b3STmEBJqbUavbYq5OOZe8TquQXBZoohj3E4X4Nz6mCKl-dso3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:E3UraMw8TfSDB2lm0HCl6Y6c_gYUCNxwZb2KzZfg8RRWmwEcsCulOw>
    <xmx:E3UraDTv1ZldHjdxiE8WC0rOgx5gR4cTWsZmIEGIpYi_i2PMQuO0iQ>
    <xmx:E3UraHYt1tGkohITXgrjBUha0zB9VP8B9t65PtLdPD3sXP3BGZB0AA>
    <xmx:E3UraMTwbnTLl4B3EVb_hrnOW_CVA5hesom0_zE0UK9AOY8fPZBTCg>
    <xmx:FHUraMvvotCHupKAX7QAdWwiXuv13G2iz3qW14UNk6VB0zUyMhsjqpUM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 14:14:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  peff@peff.net
Subject: Re: [PATCH v3 0/4] fetch/receive: use batched reference updates
In-Reply-To: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
	(Karthik Nayak's message of "Mon, 19 May 2025 11:58:05 +0200")
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
	<20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
Date: Mon, 19 May 2025 11:14:42 -0700
Message-ID: <xmqqy0usmprh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The git-fetch(1) and git-receive-pack(1) commands update references as
> part of the flow. Each reference update is treated as a single entity
> and a transaction is created for each update.
>
> This can be really slow, specifically in reference backends where there
> are optimizations which ensure a single transaction with 'N' reference
> update perform much faster than 'N' individual transactions. Also having
> 'N' individual transactions has buildup and teardown costs. These costs
> add up in repositories with a large number of references.
>
> Also specifically in the reftable backend, 'N' individual transactions
> would also trigger auto-compaction for every transaction.
>
> The reasoning for using individual transactions is because we want to
> allow partial updates of references in these commands. Using a single
> transaction would be an all-or-nothing scenario.
>
> Recently we introduced an in-between solution called batched reference
> updates in 23fc8e4f61 (refs: implement batch reference update support,
> 2025-04-08). This allows us to batch a set of reference updates, where
> individual updates can pass/fail without affecting the batch.
>
> This patch series, modifies both 'git-fetch(1)' and
> 'git-receive-pack(1)' to use this mechanism. With this, we see a
> significant performance boost:
>
> +---------------------+---------------+------------------+
> |                     | files backend | reftable backend |
> +---------------------+---------------+------------------+
> | git-fetch(1)        | 1.25x         | 22x              |
> | git-receive-pack(1) | 1.21x         | 18x              |
> +---------------------+---------------+------------------+

Very nice.

> The first and third patch handle the changes for 'git-fetch(1)' and
> 'git-receive-pack(1)' respectively. The second patch fixes a small
> memory leak I encountered while working on this series.
>
> This is based on top of master: 7a1d2bd0a5 (Merge branch 'master' of
> https://github.com/j6t/gitk, 2025-05-09). There were no conflicts
> observed with next or seen.
>
> Junio, since the release window for 2.50 is closing in. I would prefer
> we mark this for 2.51, so perhaps when/if we merge it to 'next', we let
> it bake there till the next release window opens. While all the tests
> pass, any bugs here would be high impact and it would be nice to catch
> it before it hits a release.

I've read the difference since the last iteration, "git diff @{1}",
and everything looked sensible.

Not an issue with this series at all, but one thing I wondered is if
it makes sense to change the type of strmap_get/strmap_put to deal
with "const void *".  That way, it would not be necessary to cast
away the constness like so:

>     -+	strmap_put(failed_refs, refname, ref_transaction_error_msg(err));
>     ++	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));

without harming the other side, namely

>     @@ builtin/receive-pack.c: static void BUG_if_skipped_connectivity_check(struct com
>      +		if (reported_error)
>      +			cmd->error_string = reported_error;
>      +		else if (strmap_contains(&failed_refs, cmd->ref_name))
>     -+			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
>     ++			cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);

this piece of code.

It may not make sense, and even if it did, of course, it is totally
outside of this series.

Thanks.
