Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DAA13D503
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159421; cv=none; b=amqIbTIMVUq+4f0aUvWZtQI2sK3qIA9tDdqeVab8vZpWSdPQS+bA3pfFe6LQfJTGgkb+2XebqpBoxjTVqACv6mxljmuszvstpPIAd8Tj84EQMdA/qntsRa9QxshqHbuTc2ynhzrI2Qn1oPXsHnWjWVJE10AYQPXsQvuw42iPSu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159421; c=relaxed/simple;
	bh=X7coHRKj7x01rl5lNJW+jn+/ALtXwIa4WOsmySI4v/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=il1YGnz3eYHJehDmw8Qp/uxQywfp4JKsAcN4dGiyO8dH3FDOeSyungkiXsYpByPt0iP/oIbvgE/izLtIZ8g/xsawrCJTkoHzXfx3YKg0EU2L7WQv4Q34feUHIbWK8bPIjHOa5+x05dZbyOzz6cmujMaUi0O5+Y+t7/Zfolmf//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aith2sky; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AinLeH5Y; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aith2sky";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AinLeH5Y"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E63A611401DB;
	Wed, 29 Jan 2025 09:03:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 29 Jan 2025 09:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738159417; x=1738245817; bh=xHsN8oggAb
	KRCc2KDYLtlL4fXN43JpkJQSwuQ7D1BQ0=; b=aith2sky/2Srv25jnPMHjH4tWg
	cMpTQHCFu3e62A+1tNZPGHMpUSCTZwtSK8qv2NENZ2P0nAi+znc+hvNMT+jrrwxe
	IoqTV3rFK7j+tKs1ahqyQEe4LP2ZuTc29sCcHKJ6cEur5HMODrX3GeWCK5t+FefZ
	xOuf6pbV7uJ6MGqo8FFgQBJanI6fyOeOj7EFfx2cjzyZrdU/Kdbdgyc6IDlsMsQy
	UOq13PAd4g9Vs+jHOWqtz4pUm3rgDSBfk85M5QEb0u2Q/4NEOD5kW2+G1NfhXXvp
	FwrUaxDX0yIJahnHVAPa4fQWB4dkY2S6knp5Lc8Y2DGkrWynTdTYhzLNQ1Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738159417; x=1738245817; bh=xHsN8oggAbKRCc2KDYLtlL4fXN43JpkJQSw
	uQ7D1BQ0=; b=AinLeH5YFkDD9YDEAmGdGNt0lRBfe/pH3TVMaUmRBYGzst5fKAa
	7kzayndZwTlDtBU3aXS7vZp+4J4CMnQB0FjoRjLYJFp5u3YWalvwon3bZEXsEL0b
	gjkpAb1Xj5xwVRl16j0zo0FrTBVtD7PbLbQlVt1c8r5Qq8210pcz9NHMcfImGzB1
	QiO2NNtQvDhGLsf8aeoYxQg3CI+XSrRpabG6cO+wxxqARMccTXkiwc2uKj6J2zlw
	MrF5XBQhZq5hVJBkp7YDUa9g8FCrWSeYIZa7T6NTOT2mnQJR7oLdbVXYCkmWyNYD
	XJThQNuy+4Q4wfWWKVIMPBE6iB4sJLsFU8g==
X-ME-Sender: <xms:OTWaZ1TvKNzgRnJLcIvpIWpaMsJzl4KBpq90PjQ5TqILior7-lLRXw>
    <xme:OTWaZ-x62UV7nmW3Cq25irg_lAVAyand8V92BGyIzJrri4J62EXutL1Taqmpc14o-
    51qcZlLWf6wNDhSAA>
X-ME-Received: <xmr:OTWaZ622-RJsacoEkVjykJxs2njCM81duvM1FENxbAdYBCZY1nbh5F5Tddha1fASUeSsbxKkl3yev8JJRCwtGowUZzgdwfWJRS3F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OTWaZ9Ch0SAJ_hxI4u4ssJPYdg0w0PgF3SMtqZvkv7mPlg8xMznWLg>
    <xmx:OTWaZ-iJphi4C6AFFnX2UjNSYEf_LznvyShdmCDTId2PQ5NPtGCxcg>
    <xmx:OTWaZxrElfGBOpWCzX79RzlR68lHe5jRp3wYREiMbUr-rLS30YdhCg>
    <xmx:OTWaZ5hsiTG2kHd5IjaZVU-OaFe3W1WrXtz-WDMgr4WCntb994yyew>
    <xmx:OTWaZ_vShIzq_t3AcQVCUX8NIoAy0w8Um16XyOcSzVitBv9UdJG_4-j1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 09:03:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #08; Tue, 28)
In-Reply-To: <Z5nfcAUZPNdDSI0l@pks.im> (Patrick Steinhardt's message of "Wed,
	29 Jan 2025 08:57:36 +0100")
References: <xmqqlduulbgn.fsf@gitster.g> <Z5nfcAUZPNdDSI0l@pks.im>
Date: Wed, 29 Jan 2025 06:03:36 -0800
Message-ID: <xmqqr04lk98n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jan 28, 2025 at 04:18:00PM -0800, Junio C Hamano wrote:
>> * ps/ci-misc-updates (2025-01-10) 10 commits
>>  - ci: remove stale code for Azure Pipelines
>>  - ci: use latest Ubuntu release
>>  - ci: stop special-casing for Ubuntu 16.04
>>  - gitlab-ci: add linux32 job testing against i386
>>  - gitlab-ci: remove the "linux-old" job
>>  - github: simplify computation of the job's distro
>>  - github: convert all Linux jobs to be containerized
>>  - github: adapt containerized jobs to be rootless
>>  - t7422: fix flaky test caused by buffered stdout
>>  - t0060: fix EBUSY in MinGW when setting up runtime prefix
>> 
>>  CI updates (containerization, dropping stale ones, etc.).
>> 
>>  Will merge to 'master'.
>>  source: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
>
> I'm a bit confused about the state of this topic. You say it will be
> merged to 'master', but as far as I can see it's not even part of 'next'
> yet.

I am utterly confused---I'll figure out what happened here.

Thanks.
