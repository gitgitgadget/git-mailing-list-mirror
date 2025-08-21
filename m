Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF342E2F03
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771707; cv=none; b=JUGfEDy0ZUFoDBfzSAXF4LrBiZPO2QSuSiXH4FmotR4TaCorGEDZGYkoJ7aZW/eyQGBmGxo5KNhUr4qNENEv5Nz7/LAU5yNaKs/UgBzxymyOYJSOhmTwYFW6UWXEIkVLIP7FervrGOH+KDvYD1L/1cCpKeL9R9RpOFfBTezwMQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771707; c=relaxed/simple;
	bh=GKGhjij2k7waf0LJ03LJu6CNWKixu7YUmpDp0mvN+Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXp4KLpzmIesZY3XwVSVxtS7tel0P2yCny++b+6EiA4/V94pcRxKMOA59OomAZSMUDY6vywAuRrugf90pD4RoGH6zJVv853NrLlctagYxYXsgAan/V6WnJ+whLKecVTUlhaZrOB1ogYKny46LsXzm3gyPmhWTOrfHVqdyATHqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bWSoFTOJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AJGX9qwe; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bWSoFTOJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJGX9qwe"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B30381400060;
	Thu, 21 Aug 2025 06:21:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 21 Aug 2025 06:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755771704; x=1755858104; bh=lX6Tjhi7Td
	JQDuBFl4CeQ6M8VVQDqXSDVcC2ySE91bA=; b=bWSoFTOJV/DA4VyQdBvCigAA8h
	2UhCPByr0n8O+SWQvbOZi8oszUuiC8mQtP0v8Ov8HMRPY7UDQQBzXn+J7P39B9wf
	nlWItBF3afOKVzcxR2fT8tHhjij2rHz6IcV2nFdaXfYrP6bM/N7obmvX28twg34D
	WMkOM827itydKZLZTbAprotE8RjQD2benE1wdexUvTiAm4R3Zub2MNI2fmlZoUUB
	BQdnaB9+H5vMd9YwP0Q9u2MDGTJ8ZLcAn18k2blXP7J2SWvU+ps+WAkvN0cnyaAr
	4MYSHK24OhgPJnY14FQBuFuOPghGqpRhfYow50/92GaXB+0LSfqchU9GJATg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755771704; x=1755858104; bh=lX6Tjhi7TdJQDuBFl4CeQ6M8VVQDqXSDVcC
	2ySE91bA=; b=AJGX9qweBpF9OtwM9wTW9EqWgjGbowEDD77ETG/briKDQxIxKBg
	nz9dLoFWllKZ4lY3ydWFPBalEjcG5svelv8xXNNk6m3WsSgXpxSn3OKdgJE6zItt
	AhY+AoYKYFi5lNCQk5nvZ5az2WlMFwsMpVobqFcEvZ1FszGxCCefo16tPKCbovep
	CCSjzvce/qfTSai/mx9dRHGVNTFbLsLSx54PvN/LHa6ULsc7+8kJRY22DXsJTqxq
	JYk1vEVIoXlxuHjlknKstkyAxDSmnyEy+I3NPB/MkKYnvJ2OTSW4AAlCOJbv+u4P
	kY1NcwGYkCO2v76I/AGfBUXnqM2cu4+B1nA==
X-ME-Sender: <xms:OPOmaNEmvW54uEyNOUNlTTH5XW0MH0Dn-GWkkcHqG2LMizOXwVwpaw>
    <xme:OPOmaFlVk1KYN9D14o5z6ma-m62FCnK_yGe2Ho60JsZw7bkzM2RPUFeBrnY3nssXZ
    y9KFGWPQ4we3VOUZw>
X-ME-Received: <xmr:OPOmaInQP0wtSQ-QCKFMVAvDj_V43mvnPIDgUk4FGcuj73AkEjWfkp34Z3f3L4Ts3ykRVT5r69g-_QJgE1JL47hoWBxatQwwJz2j9hLMRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvggvthhsoh
    hniheftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:OPOmaOtbNEPr0V8MNogqddfH6YB3RE_KKjKcZ0Ml7ho6QFmOw3kuAw>
    <xmx:OPOmaDnGFTlB1HLaItVGvuC9xc_UCNh5vrzM0lohO00vI5mHFGJ25A>
    <xmx:OPOmaBumu3ZUU8j-DlOVMSfqPxhO-r7YDEQ6pisQ-CtEg-IdfU7C2A>
    <xmx:OPOmaBe8NBPuhBre541D-hJ6U4GelxMKkUudsdqEdxuHlDmkTi6vew>
    <xmx:OPOmaBh9NimbwCzyE2BczxA0ZuwPpv_dyg8nKiI4OWikvsCZzNNhFUUq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 06:21:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b8fce49 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 10:21:43 +0000 (UTC)
Date: Thu, 21 Aug 2025 12:21:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Subject: Re: [GSoC][PATCH 2/2] t: add test for git refs exists subcommand
Message-ID: <aKbzNNcZZ-E0FVeI@pks.im>
References: <20250821085246.929307-1-meetsoni3017@gmail.com>
 <20250821085246.929307-3-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821085246.929307-3-meetsoni3017@gmail.com>

On Thu, Aug 21, 2025 at 02:22:46PM +0530, Meet Soni wrote:
> The new `git refs exists` subcommand must have identical behavior to its
> predecessor, `git show-ref --exists`. To avoid duplicating the entire
> test suite, refactor the existing tests into a shareable helper script.
> 
> Extract the tests for the `--exists` flag from `t1403-show-ref.sh` into
> a new `show-ref-exists-tests.sh` helper. The command under test is
> parameterized using the `$git_show_ref_exists` variable.
> 
> Source new helper to both `t1403-show-ref.sh` and the new test file,

s/new/this/, otherwise this reads grammatically wrong to me.

>  test_done
> diff --git a/t/t1462-refs-exists.sh b/t/t1462-refs-exists.sh
> new file mode 100755
> index 0000000000..c00d76cc9e
> --- /dev/null
> +++ b/t/t1462-refs-exists.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +
> +test_description='refs exists'
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +git_show_ref_exists='git refs exists'
> +
> +test_expect_success setup '
> +	test_commit --annotate A &&
> +	git checkout -b side &&
> +	test_commit --annotate B &&
> +	git checkout main &&
> +	test_commit C &&
> +	git branch B A^0
> +'

It's a bit weird that this setup needs to be replicated. I guess it
comes from the fact that t1403 also has a bunch of other tests for
git-show-ref(1) that are irrelevant to existence checks.

How about we instead split out the existence-checks in t1403 into a
separate test suite first and then pull out the whole logic from it in a
subsequent commit so that we can also share the setup?

Patrick
