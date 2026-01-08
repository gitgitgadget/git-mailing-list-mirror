Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41322641D8
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767852813; cv=none; b=cBNZBhy9IUewP+Az+XDJ5ayU43CJEf7lYIKwUFO587iu8D4mApvqqEBKp3tQyU5vf2bgjcox0QKY+pVrA750hTZh/7BsglbbHVChD6XqBcIQnYgFAoVY2tbmvU+uHtSoPGqTI2ry5Y6z0QD4vZSiEmIEWpYJ0VCXAS+Hao4YLhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767852813; c=relaxed/simple;
	bh=XRi9P6+1tm77z5wNQo5atBopkKtjKOxenI2V9xSLxVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxrElyBoP7vg6Pa+5RjGbLKn+82QW8tm2Z1ZUk3UeXBdM0ZAKWT33a9OAaaPCmLZO/QtRmtfDTjRv9wdoB8ixM/z4r6j7Snix+yiOjgZa1wD5b0SDwWvXYdATSA2kO7G+jpw88h1SHitGMnM8DT2mKRifu1CoHIozv8oWQopbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cps4S8Hw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hnDtBaeU; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cps4S8Hw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hnDtBaeU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E65FC7A00B1;
	Thu,  8 Jan 2026 01:13:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 08 Jan 2026 01:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767852809; x=1767939209; bh=7EsD4uWEXP
	pLU4etdWo9xiy8+vABgPqx1BZWU9A8A80=; b=cps4S8HwI9tbF3BlC1XotNxWkr
	wo5Yy/4Pn0VL/eH6r1I71iFEd7O/linkx6zAYaEmS/CshonU8f99uieBa3969uV7
	8C/pNUSm5pMSynOhsU1tBFnF0861XeYFBNw+tPPIJoEe08UGCbEAz6n8Su37UGD/
	v3+SbjI5fiflKuUrvM4aDdiCHkvMOq0IR8DWcq47yHhf50ESZ+iNNk2eoswxHcWs
	gl18YyT03jXa1jhTlNpnrecCMbpnFQN0JHmsmZz63LhI2SJpHmwGucRERp5M1yYf
	aS2gAUJzyJD/CIlHXvZrirX2Pa4MigbFi1Q8uB8w0rD8R+sRo2Kk8s8DzVdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767852809; x=1767939209; bh=7EsD4uWEXPpLU4etdWo9xiy8+vABgPqx1BZ
	WU9A8A80=; b=hnDtBaeUCPsSK2yEEVYq6dkhUDbgpuNc9tDowE7WA9+9lOLWMHj
	cTN0vgkbj7t9Ca5NH+LlngZ1VDdCW51Fk3pOOeVI9QMlxTgATrv9gPKLMQV0btWY
	VmzEQ0o8hVMB4GDInG6TJDS5taPbYesXH3w1cERGTbzMl3FQbGt7Ifj8kL7xnfoQ
	7tYYGNm1RHcbNiF1GlFdnAf9pOMer4KOwGsX+I5QDTNSkAPBeMjVwdc4ZNgXsvcD
	TgptVp43NyWEGaKqb9wG01tzvroR9/Tqu28Hs/rQX2U86+v3tf8Y8VQJbzng0Pht
	XNCBEhdgOfBOLkA88jjKJNqcXv83XBW8g7A==
X-ME-Sender: <xms:CUtfaVoo1h2h5gOyNNoY2zlaGhJv1U-J6AbkektNJY86XsUxQEBYdg>
    <xme:CUtfadqp-zNBxOucMPBgbvrqBt1TvjM-j2Fz3YuHh0kbkt-6GDagL9O7v8FaNnGqI
    qH-aiUkNJOCoGC8Ii4slDNQ0Eu6V19nwXc4XWnpLcL6c0pxKb1YEw>
X-ME-Received: <xmr:CUtfaf0jAhLXdQbziEBvkFwvKNYoxhsU29mhkqQ8hdkdwtdqODPeJ5KtEgajHlk2ZuguYi_8jnHXvF-ZQxKarDFffWsUmpMO91qTNB_I_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgtrghssh
    gvihhkihhoshhhihhrohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:CUtfacDpVFKVMeL56_elGz9Py4KUsIffTMJmMsIbuB3bS_8FSNmkyA>
    <xmx:CUtfaXeE8D4KY-YrJg7tXw7DSKtpEeNpv6UZdS-NF_9rM8kaB5Lplg>
    <xmx:CUtfaRg8t9Bjn4pGXXdMkogFVV2VIpO9i2Vh48BeJHYtaDmQwdhlvQ>
    <xmx:CUtfafrYto99PT-zFLhSNVaNEbAuLKNSXkjxWSbtDGjedvTKpbFTKw>
    <xmx:CUtfafaY_pO3FRDXUDBCP3i9haGYolxlULs1GqbE4scef-Ygc1_SbCAO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 01:13:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 65b133b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Jan 2026 06:13:27 +0000 (UTC)
Date: Thu, 8 Jan 2026 07:13:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] repo: add a default output format to enum
 output_format
Message-ID: <aV9LBNtCaMMTlc8l@pks.im>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20251209194616.61620-1-lucasseikioshiro@gmail.com>
 <20251209194616.61620-2-lucasseikioshiro@gmail.com>
 <aVvIQYdsrB8vAJ_R@pks.im>
 <6D2CDFA6-FB52-4BFD-B800-B01B5E484038@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D2CDFA6-FB52-4BFD-B800-B01B5E484038@gmail.com>

On Wed, Jan 07, 2026 at 06:28:59PM -0300, Lucas Seiki Oshiro wrote:
> 
> > This is missing a test.
> 
> Indeed, I'll add a test for `--format=default`.
> 
> > It would for example be nice to verify that
> > "--format=nul --format=default" does the expected thing.
> 
> Would it be necessary? We already have a test asserting that the
> last "--format" wins:
> 
> test_expect_success 'git repo info uses the last requested format' '
> 	echo "layout.bare=false" >expected &&
> 	git repo info --format=nul -z --format=keyvalue layout.bare >actual &&
> 	test_cmp expected actual
> '

Yup, but we don't have any test that verifies we do the right thing when
the user asks for the default format. So it's mostly an additional check
that the default format can be requested as expected, which would in the
normal case be a no-op as, well, it's the default. So if you specify a
different format before we verify that it can reset to the default.

Patrick
