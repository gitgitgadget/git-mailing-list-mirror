Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6501BF33
	for <git@vger.kernel.org>; Mon, 25 May 2026 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779668415; cv=none; b=GLvYkQiljMovzI2DhYTNGKv4voLecFVvk/gDem4RtCaKCpFtRwBpzxTgn4jY7jonN6CQ4PnOoWRqkBWJZKgDBQpiau26kuTp/IkgKO5iLFnb6tHvidjtwcFshw9mIVx4dM5HLmnfnJtSVK+28lWnEGgmhah8jxoDYOE2o7jEwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779668415; c=relaxed/simple;
	bh=sa9Ty/QxtA6vFv2qCPyay6mmDwkfoTUYnnxLidn4v+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WJ8TfdRf9y2xBK9ofd3xKSttITP9SX5M+NXrSguTTDx9HuR0XHUI7TXrxdLznYYK6G6J3MvEFTec+O280MKUDSHsSzosDZAz7oVdt4JilgBVQkW0IdcFdB0cRoLHYJia5B8KmY8uG7v1s9Ok1pa1pxVT8EVbVjDcQcTkYCCu1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lOTMXzDA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HcPQoqhu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lOTMXzDA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HcPQoqhu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8BAE5EC01F0;
	Sun, 24 May 2026 20:20:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 24 May 2026 20:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779668412; x=1779754812; bh=V4vV16SvEm
	6raV3T0wHOwtY2djV0nFMZ4wEOrwuTw2E=; b=lOTMXzDAri2ag88mom+/F6D0O+
	PonkDkAxTRhkKN4zYZCXq4plIF7tiKcCDZ8RZuJrNTz036WJIYYFSrA29UY7nrpe
	JMEIPArOcQPsFELqM7wtLyuB5HhmNCA5wNJP4lHsHHxcoaoA/8pOSpVmo9qHp5/B
	d0OYUE1voY/xB5mtv+m1nj4MLChbbISm5o3k8/IPWmnrgyOf7PEt/d4fy9ZJVsCh
	6quigSQKioqHlz2wChf+S9dDBgZ7/AxlHA1E/uU7fGyRjBrecaRVOY8FDKcQWXad
	XVWlFNDazUMY1IL9cgO8ai5jxjHhVE2zp6RS+1r6wgiSS59EXQP5IcTg+TQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779668412; x=1779754812; bh=V4vV16SvEm6raV3T0wHOwtY2djV0nFMZ4wE
	OrwuTw2E=; b=HcPQoqhupQbSjDzm/qAs5LOXvfHD2Xd9xE0Qi5vK2FinEEhwC9Q
	suBD/IAEDoGfyO8/BklbdVz24RoCsd4bzi6jxWcC4sDQkipVdhjyRDxJRgQc6meD
	V/vAIDWre+yWHl2iP7X3MICc32Cwx/8XOrM5rydowwq5fdvYBldYBVock8zsXSPF
	VKKhj98o+a2Nu1vQtWev21MOglRqWmncch6sWdZsssriN8HL+1++Qn01WWRKk85q
	i9Xc/qroNUSW3FW6sh/uqkfQyc+A+Q5CzdFVSmdjCBrcgOgMT9W9MU1Cb28/Ghqa
	i2+bjO6CpGhnjzLQ8VfyDEJXc/Uqbd0goIg==
X-ME-Sender: <xms:vJUTanp5CKv6hOtGz9o0wPcT9tr6kVV2U_5f2GRe-m9w_INlhlD_GQ>
    <xme:vJUTaooVZpv6VAhdAWf60sHrxTj7e2ktmY6HHVqefWsCevdu7uNDP8LCYFnJMmb9V
    rOGRHQR716YToVLvUvt7ATpynA4yZH-Clirv1hU6URxPo5pc-CcNA>
X-ME-Received: <xmr:vJUTapM189ZBATKZfpHkg8iagy1nWGfpC4V4tqM5v70ygAzg0lJCTAo2c3dfylr7sxcMa21zuV0hDf2bw3zCJ3IDNoqIr0d54RW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhihesrghl
    hihsshgrrdhishdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vJUTapzvU77ZjzU0OMr6sQrm5hI6CvGPLdug08rodxbaLHFzDp3asA>
    <xmx:vJUTaitjFEy1_VptER4TpB5zDxOKaH4xMS15RttmrdOz-0_6uBaYlA>
    <xmx:vJUTai4pAbodO91T-fhZkC4S5pDA-novP2whf32ktQ0M-muvP3zIKw>
    <xmx:vJUTahTw0J-3q_N5NBlbY92CyR9pzGjV5GQ5qOJnVNX_VaHNVVFbUA>
    <xmx:vJUTaovxJjadGzjIbnrgnfjBj4WTOGOSutq4a1SwxkHjDRM3CmIhgraJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 20:20:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH] receive-pack: fix updateInstead with core.worktree
In-Reply-To: <20260522154418.5883-1-hi@alyssa.is> (Alyssa Ross's message of
	"Fri, 22 May 2026 17:44:18 +0200")
References: <20260522154418.5883-1-hi@alyssa.is>
Date: Mon, 25 May 2026 09:20:10 +0900
Message-ID: <xmqqfr3ggx1h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alyssa Ross <hi@alyssa.is> writes:

> This used to work, but when push_to_checkout() started being called
> before push_to_deploy(), ...

We tend to try describing where things started breaking a bit more
precisely.  The above seems to say that you know that in the past
push_to__checkout() was not called before push_to_deploy(), and it
no longer is the case these days?  Can you spell out in what commit
that change happened (refer to the commit using the "git show -s
--pretty=reference" format)?  I.e.

	... but when X started doing Y at a8cc5943 (hooks: fix an
	obscure TOCTOU "did we just run a hook?" race, 2022-03-07),
	<<this bad thing>> started to happen.

It isn't really we are exercising "checkout" and "deploy" both at
the same time, but an old commit started to always call _checkout
only to see if that actually invokes the hook, and if it didn't,
then call _deploy.  The intent still is to use either one of these,
but as you exactly identified what is wrong in the current code, the
call to _checkout that is only done to probe if it is used at all
started to contaminate the environment with that commit.

So this change ...

> -	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
>  	strvec_pushv(&opt.env, env->v);
> +	strvec_pushf(&opt.env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
>  	strvec_push(&opt.args, hash_to_hex(hash));

... looks like absolutely the right thing to do.  And ...

>  	if (run_hooks_opt(the_repository, push_to_checkout_hook, &opt))
>  		return "push-to-checkout hook declined";
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 117cfa051f..f51fb11a6d 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1791,6 +1791,17 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
>  	)
>  '
>  
> +test_expect_success 'denyCurrentBranch and core.worktree' '
> +	test_when_finished "rm -fr cloned cloned.git" &&
> +	git clone --separate-git-dir cloned.git . cloned &&
> +	git --git-dir cloned.git config receive.denyCurrentBranch updateInstead &&
> +	git --git-dir cloned.git config core.worktree "$PWD/cloned" &&
> +        test_commit raspberry &&
> +	git push cloned.git HEAD:main &&
> +	test_path_exists cloned/raspberry.t &&
> +	test_must_fail git push --delete cloned.git main
> +'

... a test that protects similar breakage in the future is also
excellent.

>  test_expect_success 'denyCurrentBranch and worktrees' '
>  	test_when_finished "rm -fr cloned && git worktree remove --force new-wt" &&
>  	git worktree add new-wt &&
>
> base-commit: aec3f587505a472db67e9462d0702e7d463a449d
