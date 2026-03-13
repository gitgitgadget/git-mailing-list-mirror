Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22553D5661
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433774; cv=none; b=T+Q+cylA9Gw2AIf9HWqKjphJ0Q5Joycw3tTlrTTdj689uwxfk9hgCZKgGLnXRXskewX73LY/NvB0PVI5Ehn4Lv7sB/sJbS1gEhCsW+1BudaCkFAMyOtVTE2YNj7jWiJlmFAl9Sw/2zXR3yN9tWADU7A9xlYYPMjiyO8Jujic9s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433774; c=relaxed/simple;
	bh=QQBAdw6OwJ+mnwm6s/vuEbgFrB3j+7D37WUYG5XCb0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ke/MqmZZO75ZcEwgKm/yY6sxbsOp27e6V+YDuUDbMVJJjRbwi0q+TNU9lPqXN7kGhXgNzXSWlWiPmvKWKxydbA1ColJyBFn1xHW3layJhZLxC5gpLFVZPvMm/UPhRXk4jK5h+tSAky8ZAEBAQVPE+5vP7VHaW6QNO1mV7KwJ0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Df2fXM25; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jp9UhnwM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Df2fXM25";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jp9UhnwM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F2D867A012C;
	Fri, 13 Mar 2026 16:29:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 13 Mar 2026 16:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773433771; x=1773520171; bh=QQBAdw6OwJ
	+mnwm6s/vuEbgFrB3j+7D37WUYG5XCb0g=; b=Df2fXM25tvJA0PMnGAkZf/dkRd
	jk5v9pUuuIuNI3HPhr7EE8CHB30OIg7BplGKPeCARbhN8j8CGSHpMNFdz4Lm804I
	2iqFiElPRO1goKiDDzJFjRZ96qQ9+91V8Y2D2G94ZjEqSGSOqtQnCOcCJLC5VLg9
	R2rNfCDMyO9rKxEv7sXyUOKyG+Nh8kta1gZD0LUU6Rs1SbU6dz1pza2N5Te8HrwJ
	XYeEnzEOj/sAvybAXJVoAf8+NriigkOHnjAzQ+IWzx9ivPhPSubyeBH320JzQLE1
	hNvOisuWWdpIoUA8xUoAjbNoGsN3Z/SXljQzZ/oh7WOipPtT6pOrDuHrEMZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773433771; x=1773520171; bh=QQBAdw6OwJ+mnwm6s/vuEbgFrB3j+7D37WU
	YG5XCb0g=; b=jp9UhnwMi8dBYCFxpj2jE2zuZ6O9T+PnYPmzBEvyoEc3tc4hS7y
	GUMejofcCQN9s7QcN2Crqyl1uynKeDaRzQ6OlrhkTRUtECMXCuX3sTlNWLl0vTxs
	k+xOS7QTZhQL76j1EebAkuhwq7pbRkPReGfdIEgYpIxyLiHPjU06YozAA+qz1/cH
	2W6rSBWJBvKcZVuiKDVDMUnhaSzPB1t6uJT0aBWgQ58cUf+8Xqf+Iu4CLRMx4p8Q
	Z1Dm0/VC//o8sdn41MdM4aOjRxqGm/tOeKkZu0hn2YNB1XUgxHapWUlKTjIU4Qq2
	1oL+IrjXXiShfEoec7Qb7GiLB49iucbVClg==
X-ME-Sender: <xms:q3O0aasCWVjzLDODLwoxu3FnBhAffor44Z_fxX6FqZoVqNvR1mn6WQ>
    <xme:q3O0aW68wQeut5yuB3WczNL7k3lc-Bd2zsaQuU4erE8WHv5Uv_7o8dPn4NP0Kxymf
    -feNJcXXyGInDheNVDP5cnnURShEWdxvUUx09ZjvWtXxasOF9aPEA>
X-ME-Received: <xmr:q3O0aTIXrqrok7N7cc3rzgP83OXNGUIf0yBvkOKMSLDChphGPNVbBvXIXbtS49oKiOXasyP76w62kVm3bYwjDITNdlsQd7Uyuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhhohhmrghsrdgsrhgruhhnsehvihhrthhuvghllh
    dqiihuhhgruhhsvgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:q3O0ae5P2bvDrWa2KeqR_SCxeUyeIrJvlBfGRZwug9YFvqkbUHSi6w>
    <xmx:q3O0aexXILeZqAqtoa8JW2ZcbBSlZo7KLcyojPlrFWOcgIdNQ0ZA8g>
    <xmx:q3O0aab45MfYVxHPgcRWCshODnFuolAdLh8GFc9Tag2C51-1n--Asg>
    <xmx:q3O0aYQMvm5ckpMUGueByWFoa6bEng7FFX_iUE3BMd-wMNaOm7dEDg>
    <xmx:q3O0abmvTG98VRqvrIPrwQjNAlfoYPfq6q2nGSgoNh1dTFg5iJ_CV64D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 16:29:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc: GIT Mailing-list <git@vger.kernel.org>
Subject: Re: describe with --git-dir and --dirty outside of the repo always
 says dirty
In-Reply-To: <99f2ba7e-cc5f-4ef5-9b09-85896563346f@virtuell-zuhause.de>
	(Thomas Braun's message of "Fri, 13 Mar 2026 20:02:58 +0100")
References: <99f2ba7e-cc5f-4ef5-9b09-85896563346f@virtuell-zuhause.de>
Date: Fri, 13 Mar 2026 13:29:29 -0700
Message-ID: <xmqq8qbv4gnq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> When I do
>
> git describe --dirty
>
> in clean repo of git.git I get
>
> v2.53.0-522-g67006b9db8
>
> but when I do it from outside of the repo
>
> cd ..
> git --git-dir=git/.git describe --dirty

"--git-dir" tells git "I am at the root of the working tree, but the
git directory that you usually find at ".git" (or a parent directory
of where we are) is not where you expect but somewhere else, so I am
telling you where it is with this argument.

So if you are not at the root of the working tree for that working
tree, "git --git-dir=git/.git diff" would report that you have a ton
of changes to working tree files, and "describe" would report that
your working tree is dirty.

In other words, working as intended.

You can tell where the working tree is (instead of telling the
command that you are at the root of the working tree, when you are
not), with the "--work-tree" option.

$ git --git-dir=git/.git --work-tree=git describe --dirty

> Where should I start digging for a fix?

Between the keyboard and the chair ;-)?

Perhaps documentation for "--git-dir", GIT_DIR, "--work-tree", and
GIT_WORK_TREE should be studied, and if you find that they are
lacking, that is something we can fix.

Thanks.
