Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288842DFA58
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741129; cv=none; b=eh8tHgnpnZ887kIvztS1l/Dd26sfH6pFwXjft8A84755nNDMPhOHWuPtVEKcyT3TYSIrfn64d90H9bmG+b44NC7mrchz/SpDsxKPhPhG1+IRfYcb1j9mihEtzdYw6dww/UY6q2vg/5R/bkGgh4FrongY9MRJDMA7PxaYxK21UpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741129; c=relaxed/simple;
	bh=gWijlPznJYlKzhVh0duu7WV1FbjvFAhkuYlLqRUPTX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UipMZOuw+7liwmNw7OnQfTyAAyE2e7bwNWKfBT/ow53uIrQRHOD8KhVnISEcfvIvFFjgjSOK+Ga+6JOc93UpIQ6R3idIOyeple4swgEWqPuzVx6AMxdEZcvKqpfbPv+JiDft7IkcUGOcG8Vaqf/UvoL7IkHkHncV6LmWP62qgAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HKfqnUo0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bQMG6thh; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HKfqnUo0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bQMG6thh"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 337F025400E7;
	Tue, 15 Apr 2025 14:18:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 15 Apr 2025 14:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744741125; x=1744827525; bh=RO4El6ImZ2
	FSF/gxUozhCpRqYE1qjCousacc12Txn0E=; b=HKfqnUo0fapC56f8G2048la4eT
	1q1VK2CnqcJIh6dSH1z6xC8K2UnVdD8VhkzcV9+pl4AIfxBwGRL5s5FF2w2NuMlL
	OHB17bsgUXXxz0s87lxzsNl3EF3CBGYJdZXrhe9hRyUzAfILh/7NFOYlsVrtHQdo
	hORtrvv6KRsT9FXoV1CI5748DSSKiqc5B2SQX1gvUOf7/QfAGLPg1FbDEsBvELBS
	q3+kXqJM3rl3y4lN1+XYpZDXxOMceoBmUY4TMyxrT5w4MRo4QY9amrUF1opH5Pve
	1oLMDu4FPq0ZNkKBLM7r7JdAR4ICDHb4r8xrcxcCRsbazU/m+mFwef53UGtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744741125; x=1744827525; bh=RO4El6ImZ2FSF/gxUozhCpRqYE1qjCousac
	c12Txn0E=; b=bQMG6thhFrteNMMTMcOwARjSzPdxCXHLVu9UhE1LTf2AqsIoYZq
	IVkSkXPuC/zKyU5VpmBSq8qx+TZmVH/mJoMvcMNf62flJLwQZmo6hItCLCRI9UOS
	7t+O719UZGd5UQv81h3O4Ep4lByR1pGscMA5i3VY1emp0G3qXsnB1DAMn62k3Kik
	Re3vrEg+kXoeXusCSatTszSMBgnyi07i59Bxsm0NqB/vc/Eeu7c2n8l3LJi3xgis
	Lv6QgcYHbmVyf+64vE83gGgRPz0iZ9OVZH61uy5CmwXziHi+6jALiJo6rFHVTmWf
	uRYE4mSFQU8ntNESwidonME2jjshMuy+hVw==
X-ME-Sender: <xms:BKP-ZwZ7nIjsUEcQ9OjA5Ojpt6f2VhXbiwxAOtMH_H4HrRYBQtdksw>
    <xme:BKP-Z7bhpaY0KmvQ2itNwaEE0OZAr1W_V9YzfaIEjPyTXhOyg56gNu2DSorLZqI-v
    v7Jzk-ywA-mADDB7w>
X-ME-Received: <xmr:BKP-Z6_2ktx27MKELZbNQmdXJsvB_ZORBxKd6cutB2TFkRxOpIGGKb52g-wml34yF2iS1UFZpcJu7L80It5uOWhfr-NXNb9OKmvr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepveellefhgfdugfetgfeuteegvdffvefg
    veetgfetheegkefhfeeuveeigffhgeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    dpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtoh
    epfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BKP-Z6qua2SRU8Jce-a9fVlZOgszlwc_vGCYFm0Tj1XKo-cPde9Wmw>
    <xmx:BKP-Z7rewS1D0qfprGt3dxf6b8lRb4y6OrUZwOhuEirPHdJxWne04Q>
    <xmx:BKP-Z4SNBcqV6YBHM-tTxhUFSMJHP_PHjRy31UNH3gQTWtdoCkOm-w>
    <xmx:BKP-Z7pqz2GK05VMqu9EtJycuKVx_EeYD4cbkvQGsn5TNpxE3Dvn1w>
    <xmx:BaP-Z67ke4UDhu2GVbSzBEY4qJXpPY8yVvuR36WhrUo7IC2i0rqsBSD5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 14:18:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] meson: wire up support for benchmarks
In-Reply-To: <xmqqplhdo5ji.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	15 Apr 2025 07:36:33 -0700")
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
	<20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
	<xmqqplhdo5ji.fsf@gitster.g>
Date: Tue, 15 Apr 2025 11:18:42 -0700
Message-ID: <xmqq34e9mgot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> this small patch series implements support for running our benchmarks in
>> "t/perf" via Meson. The series does not aim to replace "t/perf/run",
>> which is more fully-featured and allows running benchmarks against
>> multiple different trees. Instead, this series only allows running the
>> benchmarks against the current tree. Users are thus expected to continue
>> using "t/perf/run" for more advanced usecases.
>>
>> Changes in v2:
>>   - Adapt "aggregate.perl" to use a "/usr/bin/env perl" shebang.
>>   - Link to v1: https://lore.kernel.org/r/20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im
>>
>> Thanks!
>
>
> The previous iteration of this series has been kept out of 'seen'
> for some time and I didn't recall why I did so.  With this iteration
> merged, all GitHub Actions CI tasks with "meson" in the name are
> failing, so does "documentation" jobs (which recently acquired
> "let's make sure meson-based build does the docs fine" substep).
>
> Can you help seeing where the merge went wrong (yes, I am suspecting
> that there is some stupid merge mistake there)?


Just a few test CI runs.

    https://github.com/git/git/actions/runs/14457387669

is with this topic mergecd in (with alleged mismerge).

This one

    https://github.com/git/git/actions/runs/14406901394

is from last week without the earlier iteration of this topic, which
fails a few meson jobs.

linux-meson job that fails with

meson.build:689:19: ERROR: Command `/usr/bin/git -C /__w/git/git ls-files --deduplicate '*.h' ':!contrib' ':!compat/inet_ntop.c' ':!compat/inet_pton.c' ':!compat/nedmalloc' ':!compat/obstack.*' ':!compat/poll' ':!compat/regex' ':!sha1collisiondetection' ':!sha1dc' ':!t/unit-tests/clar' ':!t/unit-tests/clar' ':!t/t[0-9][0-9][0-9][0-9]*'` failed with status 128.

and

win+Meson test(3) that dies inside Python asyncio both look
problematic.

Thanks.
