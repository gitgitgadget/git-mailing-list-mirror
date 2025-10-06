Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743115278E
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759788494; cv=none; b=B2ZmjjxL5gNyDi9x5wQ9TX/XnnuX5eXH+TsiC7dxWOns6yKGruLZsK4rXuv7HneA64NQwCWr7zdaI/7KhyCDLMfdHXQGeDfVID27COzYviAzBwy9XQbQx4HCJgXnNyGJFYSqPkguSzANoE9+wXO2QAZfVo1m98zCAz73/zT7mos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759788494; c=relaxed/simple;
	bh=vInDFow6AU6kwCNu9WvYapt/ECymMV4+dlBbaQp3dkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FKy5SzziIzypAY2wAOKgCLQPrHgbQ2PU8/EWGYI/QHx5USz0Ug463b6RBoXraPEyZ68JniQaino4v6oi/sdk/Wd5oiJgZnqr34BFp3ddxn/6KEXqz1ijRzrfjfcnqwYyEyQd6MjtZyob53AUDTiaJz8xoaAoKJ2IODJi4X5kHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hA01M4q3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xqM+3ePK; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hA01M4q3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xqM+3ePK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85449140016D;
	Mon,  6 Oct 2025 18:08:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 06 Oct 2025 18:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759788491; x=1759874891; bh=BbjvB4n4Ir
	U/M7A5HYD2w1xPHgYfsbusk4uXEA4eukI=; b=hA01M4q3iTjYMxcE1hw6xIyWib
	5G52POCy3SMk/QJgjJdxFpQdACqfONlFmPgFpDVxtDk2zJvkF0WWR7pwalJsvDd+
	xUmjo7HWgfYpR4I+dkFw23kMXNNhWj6lRM/8vYW0XuEEGo2eYlCJR/Z8LLGjZgJr
	afwULwLi3aBS/CgJZNNU6H7abttCR45JrHhq1RTHt/T5q/W4JeY62eY+D4wIUUac
	pZ7h/Gy+toeQv8NXewVsdbPTElBbCztxvlGDsf78pRXa6sWriQsexAdx0/VIkJe8
	oE3sXHgNtF96/O6d4Qg5e4NoVSafV0KiOmGjd1eTA4arEb2kr67jq7BjiHIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759788491; x=1759874891; bh=BbjvB4n4IrU/M7A5HYD2w1xPHgYfsbusk4u
	XEA4eukI=; b=xqM+3ePKvLuVzbQmnbeKKtua6OKFgn3xmcKdGKOU2HTjreTHfHP
	XC/jAsqfjzvYD/FYlfMV0C9joNXTH9mhU/DW01/8nXJOoBxYMPLuOhVRu/C5Ghrs
	3642z3SlJjFtycnVWAXd8PucfSTnuSAL0AEm0aXpWj2DUr/70aqEhoZlR/KULTKo
	V6qjRXpKFT331MFF8JLLZDVHkRCLiCqcgfelRLQbpcLT5oBROwoBSdC1/DWp7dkJ
	6Tq9NWSd4S78G0DZPI3dlVNx5eiNX6Px+cRkBjfr3XJyds/jebzf2U2T3qJbcb8F
	YUS7GuN9TzaeZntLC4yIFmM8AJm0/UKzhhQ==
X-ME-Sender: <xms:yz3kaN-XxwCMxnRYIZdygbZ6BYLzW0WIMz6Qf2iAXgshM4voh2bxnQ>
    <xme:yz3kaIvEMG7lgk-WXqn6hH6Z-HyG0N_JwfWJX3_GRNXf9qRH5eMqM5MgKXBG4xTjI
    Q_gZVlYEweiF2SyyrPFpN6OUawSmOBEOZiXoK-d-8ceQPQSckcSBg>
X-ME-Received: <xmr:yz3kaACfZuP5usFwyXsVUxyIaQTJwtnfpWeF5kxZ_iBH2EzLqYNt-UhKEGeX7tisnRPEAP8c8mav5IIYsqCbS7LYf_Azb_3N6jZJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yz3kaAXBq3IrV5qnkc_0mkjGn6O4Atcf1JdUC6soAcyQUACpqMbUBQ>
    <xmx:yz3kaODiaBaSUrrsZBQvx5eZxPiqkOt8P58T9Wspc2a0JzLCuDuSuw>
    <xmx:yz3kaD8nlHswR8IPCi9Czsjlw5--ql_MnzmkknV-RePhssO7Rl8uoQ>
    <xmx:yz3kaFFjVhE3_Kt2FsrUlb10_NXhSrX_lBaT2J_UCtY32jgQt8DXMA>
    <xmx:yz3kaA-HrzrOmQzZ_Z-Pw74MsGnC_ldczwLkwIQR237UKQ8-uP9EMqsX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 18:08:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v5 0/7] refs/reftable: add consistency checks
In-Reply-To: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
	(Karthik Nayak's message of "Mon, 06 Oct 2025 16:22:58 +0200")
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
	<20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
Date: Mon, 06 Oct 2025 15:08:09 -0700
Message-ID: <xmqq5xcrof92.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The reference subsystems allows for adding backend specific consistency
> checks. These checks are run as part of 'git refs verify'.
>
> While the files backend has some consistency checks added, the reftable
> backend currently has none. This series first tightens the reftable
> backend to make it a little more strict and then also adds the required
> infrastructure and some simple consistency checks.
>
> Since the reftable backend is treated as a library within the Git
> codebase, we don't want to spillover our internal fsck implementation
> into the library. At the same time, the fsck checks need to access
> internal structures of the reftable library which aren't exposed outside
> the library.
>
> So we solve this by adding a 'reftable/fsck.[ch]' which implements and
> exposes a checker for the reftable library and returns specific errors
> as defined by the library. We then add glue code within
> 'refs/reftable-backend.c' to map these errors to errors which Git's fsck
> implementation would understand. This allows us to separate concerns.
>
> We add the following consistency checks:
>
>   1. Check for validating the reftable table name. This is treated as a
>   warning since the reftable specification only suggests a table name
>   but doesn't enforce it. Also there is a difference in the table name
>   used in Git vs that in jGit.
>
> We tighten the reftable backend by raising a REFTABLE_FORMAT_ERROR error
> when:
>
> 1. The 'tables.list' file doesn't have a trailing newline.
>
> ---
> Changes in v5:
> - Added documentation around the return value of 'parse_names()'.
> - Added a test to validate that 'git refs verify' doesn't barf against
>   a clean working repository with multiple reftable tables.
> - Link to v4: https://lore.kernel.org/all/20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com

Looking good.  Shall we declare victory and mark the topic for
'next' now?

Thanks.  
