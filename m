Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B925D1A83FB
	for <git@vger.kernel.org>; Fri,  2 May 2025 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746220055; cv=none; b=twafkoGoUBYWm7zFLHf3QfIefRdNnKjuN1xPCgOuyJILCFmNBxC3pGiivFvZ2g1ON7VeDyyCO/NNdzFnzg41YBPxFWZVNLVUHGfTdMpME9zTOwpBXNww/SplGfPvJq9M7IR0DbwloU4mIyt0jeI++XJ5fHMMmKEYgZBT83NWjjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746220055; c=relaxed/simple;
	bh=jht1EsUeO07rjzS/ytI4s7dd8NfEIWhFf0EsW4xichU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=chRfhyHuDhtHXyrTJfvHY/sInVSWL7mPA0xhdi7ekGv61cklHjKrS+xA6KHpaZCo0trLECXbRwxLg2kCgVHz8AiIKQ4KT5gOeR26kx/TpizS3JdJA2lOLd5dasXCChhQ1zUv4DSFanm37YDgvqCUO/w2kO7OC5IN9C5Qlkwva7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=blsa7e9/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o3V4WKOr; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="blsa7e9/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o3V4WKOr"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C8061380775;
	Fri,  2 May 2025 17:07:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 02 May 2025 17:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746220050; x=1746306450; bh=EU8nGo9k2F
	rTyr4SdUnpGKN5PzKp2Fd0S3TDBIGwCbs=; b=blsa7e9/8qOWV6LQboiYKHA4/z
	W849ixVxyeNKCfLsooVIWtIah8nTTmqh0Y2ahEGmLoD3v6uV9YRHD8rfjaErgp08
	VWhLRylWS/R6K2/dzxnPYrx3JDZJqOneFXWSkbReyK1atBeLMAwOf2oVZ56RZEko
	lc01b7KkZ5J+XNeuGQSZCjCRVv9ayeAddQJ80cPWFMUv9kN0udsg9LZGtvh1+Jmf
	66aQ8HWxahBZs1GelOVe3qN1HnFDFsuVRmWOGcVKoOqf83mpVT0OsmrrA+YYRtOJ
	uiln5XX7gquR0DD68UJh8xm9Mz3aBcI8pCziOC8sRlzC/hOaKE94e45RB/mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746220050; x=1746306450; bh=EU8nGo9k2FrTyr4SdUnpGKN5PzKp2Fd0S3T
	DBIGwCbs=; b=o3V4WKOrPFrMxpAy0VioCP+HrKtUTNMiO+W0xqn/JwDpVOJMyqo
	dauh4NgUMk/htC2qVErxJ5uqjobwqikjLCHd2h0WhmIO0XJpO5EQnfHo393fc1da
	4BJEVhpZo4zuph0cQhCHvSQ6Fbc864Oco3tCa6GBei3bF98MaQNXkWa2zFF7Hdjd
	tpMUFBOYbfrfDg1NgWyLhkfLkHSLe982jqjp7/rRUC/YM1hhi0gyrc9ObgoiWjA7
	ggQrlBkx+YR9vmkdhxSbkZZtxenHcCN9iE0tMmsVRRX1v1cqg9zu+pXZIkkwyiF4
	UPhJO6CDNRyoIezUcqADSA8Xl+aASxRezcA==
X-ME-Sender: <xms:EjQVaADOtVyfg8My5P7ynqdda5StLejytCOUtuhBbwSHml8ggdh7fA>
    <xme:EjQVaCjScgAJcytBPGKwdpD-KKZF2GO_pFjOVk08JdOpPdMlyYHWE8q5aC5tUy9oc
    h1dVFHRG3tXw2udgQ>
X-ME-Received: <xmr:EjQVaDnD871-1HV3KHSkn5C1T04TFB5b2jeLrkJ4oAJLeSXGPqC_uYnH7ooBZv6jgQnk8lVdvPVFVHR2WSsd23F5QOYoHsXY1RVN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:EjQVaGzBno1ZtBnov8WHF41Lr5HHNcLP4J1bR9OviIBu4D_oAIKr1g>
    <xmx:EjQVaFQnMyIqTFIDc3yEf-_R2nevqoSnznl4U0OJDQ2OhFLUG_ydxw>
    <xmx:EjQVaBbTcx9pqDQ49tUy-3qyZAPidRPU4WTUMo_MyKa5E23Z12eyFg>
    <xmx:EjQVaOQ13JLLO2ses2ii7FKys8g8SYLsnN5gZpjo0hUwKzNFVX9Wrg>
    <xmx:EjQVaDcFFUtfrjeWDTqC5a7ArBInIDkAXfLvlpKuYk2wMebrNddPG9tR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 17:07:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v3 0/7] builtin/maintenance: implement missing tasks
 compared to git-gc(1)
In-Reply-To: <d5307e82-8e45-4a2a-a8cc-03f84c2d5670@gmail.com> (Derrick
	Stolee's message of "Fri, 2 May 2025 10:57:33 -0400")
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
	<20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
	<d5307e82-8e45-4a2a-a8cc-03f84c2d5670@gmail.com>
Date: Fri, 02 May 2025 14:07:28 -0700
Message-ID: <xmqqo6wau3fz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 5/2/2025 4:43 AM, Patrick Steinhardt wrote:
>
>> Changes in v3:
>>   - Simplify the heuristic for "rerere-gc" so that we only count the
>>     number of directory entries in ".git/rr-cache", without considering
>>     staleness.
>
> The range-diff was harder to read than just re-reviewing patch 7, but I
> think this v3 is ready to go.

I still do not think "configurable 'rerere gc' basing the decision
on the number of existing rerere entries" adds negative value to the
system.  If there is truly more than N active rerere entries
currently in your repository with your workflow, such a
configuration essentially decides to run 'rerere gc' every time (and
without pruning enough entries to make the next 'rerere gc'
unnecessary), and never otherwise.  It is not like pruning unneeded
loose object files and packing the rest into a packfile, where
running it once (even if it resulted in miniscule packfile due to
misidentification) would remove all the loose object files, which
makes 'repack' unneeded for some time until we accumulate more of
them.  After 'rerere gc', you still will have rerere entries kept.

Until we can implement a meaningful automation (which may require
changing the way rerere entries are stored on disk to help us
cheaply tell if there truly are excessive number of no longer
relevant rerere entries; code that we can readily borrow from
"rerere gc" is enough, as I said), I do not think we should add
extra code to make such a useless decision.  Instead, I would prefer
to see a single "do we or do we not run `rerere gc`?" Boolean, until
that happens.

Other than that, I think the series is a good addition to the
system.  Giving finer grained control is great, and 'git maintenance'
is a much better framework than 'git gc' to do so.

Thanks, all.


