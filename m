Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F322D63E8
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723228; cv=none; b=lxlw5m7vwqCi+gp3iNXoReywtFd0G3RrU/nLmIC2hViFa7JjayYXaJZUI6TNl6Hh1WkOE3WUE2lGF3kPMlVvivSFw522B/d8ikrOwc+fVOCeCqJmGkgSMXd9w1fSb0vgai8dTrF+PSu428xCn7F7p+phOslnbQtHfphSsKjeV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723228; c=relaxed/simple;
	bh=/Jo01yl/r2Ql7RRZbhP01+RYwpNWxmxU4VyIPzjDbj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fNuLl1ZVWQ8J1QOGigsus+rMeDutFRe+boMU74BLYbWBEH+1hoYRrkfn/TYaiHSxj6fnX6PXBp31jLmMxxsDBmNAE4k2uxQJnvpRB5YQv+hPiNoMgmRF3kb+1y7E7f/wyRWTAwKGyn5WT/lAMZeuPqzE2XYnnbHJ+Yy3iy6N9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bQnX7ny9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fAv/H71F; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bQnX7ny9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fAv/H71F"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 960801D00096;
	Wed, 20 Aug 2025 16:53:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 20 Aug 2025 16:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755723224; x=1755809624; bh=lBnu63WNut
	2xLHG3zCVSgJ5gQd6cE7qnxU6sQ/gftgA=; b=bQnX7ny97BTfO6QlKNBGRbgPwc
	d5MU0X72ussL5W8vLF1HVfB3LGBZ6DMgv+YfsBJntC/vaRMQRJ/p507f4lsLiJ/P
	L0Kqol8UEn/XTCUaEGrsp2KhIFYtEbsrzG1UTUgagWoZqAlCGM/urCGVgyspFoeR
	gd1znyzNEZoHc1B5Dc4ImNdegOI05rLKBXbsM6FqnMAM8Nv2QZJh6/qjEztpvMn1
	MJizFrbA6zGx3GvyzN2cADV5jJUXiNO1nmhVHe3ZHnvlx+0qdUsO/As0IGkCjGrO
	2AKJotaPqeah3yIAuGt3l4FhMMfTJ/KoIjD+QI2o7pLJ9w7EPebKGALcyKlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755723224; x=1755809624; bh=lBnu63WNut2xLHG3zCVSgJ5gQd6cE7qnxU6
	sQ/gftgA=; b=fAv/H71FR2wHb9Y/qB2yVizs2wrrB99PGcy7APo54GhsIpxhYaB
	hsICuT6C2Rpgb+fofQlBgOJW8OB9hIEeW5lHGlq5IiUEbUFAj6WjklJI2ISb5z4E
	7vpG1T1Hlk/tlcuGpFXVMm07kiTzvItT6gHLs7M4enOqJE66p6hF6XotzpC2AYZX
	RRpDOrVlsZjQzgKUQ8I3OhAB213HAzByPzRhkMPGC485q8NWA5JXlFc2Z8fWYR54
	r52VejEjtE6CIP4Qlrpcmfvo18sM2Noyy+FawldlC1WcLkcDY6+IX5hW2CXphTjP
	5OLysKj4MHdNGpaIxKcNPUfXKHoFFmvWXXA==
X-ME-Sender: <xms:2DWmaBwPmx9RPeqfBH3Vm687rdL1xudPGQ-LWEC1_dwAFwyDiTJrog>
    <xme:2DWmaEif5i7pG9eoCNYsBZHi58_DjfZSSP1uLrOd336cHVi6JGVv4spcjSMB9VgJf
    eNxTJvDpcWdrQ1DEA>
X-ME-Received: <xmr:2DWmaEwFd1o1-T_5zpC6zDnMWpRKWgZdQWL6adG5suQC0Xd4FRl4fxNlHQKqm_YMSOSA9YencAO8HoI7bot2t5sdPd_oHZUezjgpgw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggrnhgrlhhlvghngeeisehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2DWmaPIE4aca6zfjeV-lHBKnnDcqCfBguXpcUMe9EYYfuPBHf70d4A>
    <xmx:2DWmaDQI6hq0paL0FBpOSM1Bunx6qTksOChgQBpQgbVI5TzyHDECvQ>
    <xmx:2DWmaPo_x86T6LRGwnB3MAZhJx8BwgEPJjx5ayHwBMDYw1_9ebVP9Q>
    <xmx:2DWmaAqa9zdjcZ8dTBk-kAyEIP80pbYOOBuiMatHe9J3es6dfo8nmQ>
    <xmx:2DWmaNL9F6pxqxT4N3FRwuZTXtyIzpTIQNoguZQd42X4DJOi_teWBp-9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 16:53:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Dan Allen <danallen46@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: I use whatchanged!
In-Reply-To: <83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com> (Dan Allen's
	message of "Wed, 20 Aug 2025 13:20:58 -0600")
References: <83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com>
Date: Wed, 20 Aug 2025 13:53:42 -0700
Message-ID: <xmqq8qjdaf55.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Allen <danallen46@gmail.com> writes:

> The exact usage in the script is:
>
>     git whatchanged --pretty=%at

And "git log --raw --pretty=%at" does not fit your need?
