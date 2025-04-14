Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B6C259C83
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617306; cv=none; b=mcZcWmqxZy27EbMYWciOW7RgIiB3G1R/GjixwwQD8HpvZyFxABuIjRw0gI5XilVEEK1tY9GvDXPOs2vM4u053ctnJBYnD6WXdMk626l7x/IEu8qV/HQVNvCoZb8nuRcnKpEnevHXLMcxGdsi2O2eBO4cDubow3BlEFTZhoTcWZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617306; c=relaxed/simple;
	bh=Rfc81hCBYWBU7k0FO4U6c3q+GMInqYALjhhCT0kl1M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlFA3o0wcQMIL0cXjfRSe0jbx8QY7TZtlmPMM5/7xUwXqM8rLAE6KI1+G0NekrhqvCnN1JkyP1mgtNZdMQO93FgkXbh21yagLMGP7fwYXGhiF8EOjq8yMKxSBPrF25xFQ8Sw/LXu7veBq/8rHQZbwVu/nJHK9VjX4NhSHXps88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=azoLjOse; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cLEuf9oQ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="azoLjOse";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cLEuf9oQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 00D8F254018A;
	Mon, 14 Apr 2025 03:55:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 14 Apr 2025 03:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744617303; x=1744703703; bh=vwkFwToYgv
	8zqa6NFAf6E5n0uJFEdFaIllx4Df6Y9wM=; b=azoLjOsey2SS/8GPC2JhHcTiue
	sZKCT9MeEDz3DKMhQY1xk4br/keIicDizGwy72HrdnsU6+vmLd5Lcr2oWIdtw20/
	kM+kUO3my+iFizpXlrZRK8R32I2W/452jvbzgYVjiebIDJynnQN+t7gI6ysN6ioy
	UbiINOUUrxohog1XxwxBMzuHf5Q2tAQSXTw1ZEn99uxYumZAagltImLEKNB4YV8k
	QNqflGJI0Va1Ek0woSZAiHKLJorEviZyKn7szy8XH7lDRiedn7GUhIN+F+C+df3N
	22ZwHI9njXJP35ml/LdjY/TiXDuDogl7O+HYnNLaJovTYNkBBaZQ1B5Y3C1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744617303; x=1744703703; bh=vwkFwToYgv8zqa6NFAf6E5n0uJFEdFaIllx
	4Df6Y9wM=; b=cLEuf9oQ4hFWw24hsCOcyo7cwnyswYtG/KJjZPUsAPRckFGrD+4
	CMwQ6054lbcKX5ZVSdByXeBNIXT6rTvC15edLDUV0Q5kv7bmT22Efn7DMd7nrYQd
	7gh56yIifd7jxr574jrkotPlKCxnyZRgO5PH4uUJxZYrK11UqflnZCQ8KnNtpQ1B
	BEIUt07tFcE9IVlgwe4NU1fSHEjApOlutX/aZj7ReRUw4jDA8KOQcejfo1EV0aYg
	AV97qiyKqJorOJsoQZK91Pzwq/mqmSL7kh+fEe23S+8MgPp+RFDtIPrK1QHSBjtV
	HwJFNXzrIMvsyq/gP1k7P5KmBMq79nJpcng==
X-ME-Sender: <xms:V7_8ZwXNM9vC1x0RJCRrLJRbnznEfuowaCkH2vinUo85rpugKK_Hkg>
    <xme:V7_8Z0nl0n3HD9INhXDf4xDcSX51bn_U3lAeeGmi3IGhdGHoPqP1hZAIQqaQV4PXC
    BPZot1OzBCCL4uKFA>
X-ME-Received: <xmr:V7_8Z0aOd7GV-pGr-0an0om9NFPANa94CCKtI9VmozNVEguJ0_CpnOMfqF7DrdwBzAKKfpS-wAm1Xe3mNCd8fFvu9U4QCVeUbZ7NtRy5uP9h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddttddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtseguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrg
    ihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:V7_8Z_XjJRvtUkkWtEC47Zos_eg-IYJEBFLoRvcK8VZJQvBYL0N-Mw>
    <xmx:V7_8Z6nxD3J_Xqo8XtltICSwcy-lODos8OjjZE-DjNyWH2Been_gjQ>
    <xmx:V7_8Z0dXmropv_BRI4Qv165a4r0onRgPMdRJSRzZuyt_SLwFyeZT6Q>
    <xmx:V7_8Z8GEMphMkCU_R5UA0e9OIT1ReLHXz6wAbXisrcUHCAol22pWPg>
    <xmx:V7_8Z492ciWHO8kqvepnApyEpkBUj2A8oY-eqhSu-EPwwMGAVZDmtxHo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 03:55:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12249cb9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Apr 2025 07:55:02 +0000 (UTC)
Date: Mon, 14 Apr 2025 09:55:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH v2 07/13] config.mak.uname: only set NO_REGEX on cygwin
 for v1.7
Message-ID: <Z_y_VeJzT82by8wg@pks.im>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <324bb213426ffc9c1f9cd155de309bd0b63cdbc4.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <324bb213426ffc9c1f9cd155de309bd0b63cdbc4.1743859985.git.ramsay@ramsayjones.plus.com>

On Sun, Apr 06, 2025 at 08:38:33PM +0100, Ramsay Jones wrote:
> Commit 92f63d2b05 ("Cygwin 1.7 needs compat/regex", 2013-07-19) set
> the NO_REGEX build variable because the platform regex library failed
> some of the tests (t4018 and t4034), which passed just fine with the
> compat library.
> 
> After some time (maybe a year or two), the platform library had been
> updated (with an import from FreeBSD, I believe) and now passed the full
> test-suite. This would be about the time of the v1.7 -> v2.0 transition
> in 2015. I had a patch ready to send, but just didn't get around to
> submitting it to the list. At some point in the interim, the official
> cygwin git package used the autoconf build system, which sets the
> NO_REGEX variable to use the platform regex library functions. The new
> meson build system does likewise.
> 
> The cygwin platform regex library, in addition to now passing the tests
> which formerly failed, now passes an 'test_expect_failure' test in the
> t7815-grep-binary test file. In particular, test #12 'git grep .fi a'
> which determines that the regex pattern '.' matches a NUL character.
> The commit f96e56733a ("grep: use REG_STARTEND for all matching if
> available", 2010-05-22) added the test in question, but it does not
> give any indication as to why the test was framed as an expected fail,
> rather than a 'positive' test that the 'git grep' command fails to
> match a NUL. Note that the previous test #11 was also originally
> marked in that commit as a 'test_expect_failure', but was flipped to
> an 'success' test in commit 7e36de5859 ("t/t7008-grep-binary.sh: un-TODO
> a test that needs REG_STARTEND", 2010-08-17).
> 
> In order to produce the same NO_REGEX configuration from autoconf, meson
> and make, modify config.mak.uname to only set NO_REGEX for cygwin v1.7.
> In addition, skip test t7815.12 on cygwin, by adding the !CYGWIN pre-
> requisite to the test header, which (among other things) removes an
> '...; please update test(s)' comment.

Out of curiosity, because I really don't know any better: why do we have
to even care about such oldish Cygwin installations from more than 10
years ago? Wouldn't people generally update Cygwin every once in a while
to have recent packages? Or is there a good reason why we should
continue to support it?

Patrick
