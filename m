Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1011C2C9
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890442; cv=none; b=B7Ch+GXsCKPNt+hpz9pD3HuKF12BGKHnHeXJSH0SSPSHHSNxeiZFjMSxeXW9X4i8QjjGFJOs7AG6705qcggcwRmHt2qoNNB4r2cDutvbYL7r97fzQacS6X76mviIf+6DV6oKAw8p/8wFZZcPomJcatMzK3J/0fvOYqgMQvegSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890442; c=relaxed/simple;
	bh=Ow8YLIWun4LH0qMn8JHvPV9HCzAjU9047pt2ehly4XM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KBum0JCCVdNfI7WNIA1ZPIqmXoCTrun9IekMeRQM9dsP4irJkbwYL9VKMsNWLHaGZKV4e0X6nL2fhFZTfaNAId1vzit1fv9R6LwPH9lnPR4lI3ygAf63UUKyvuVjF0/4ivzzWJjpSSbClXnGOWlU+youiRIiGoevBTmslkwySmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cRol5H9y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F43yculv; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cRol5H9y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F43yculv"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC3C21401D9B;
	Wed, 30 Jul 2025 11:47:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 30 Jul 2025 11:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753890438;
	 x=1753976838; bh=iSN3K6t2d8jW/uFiLiE8J3o0z0vksI11LMX3alaJ6zA=; b=
	cRol5H9yoFISAETySmDz2O3ERWnNJ7PTFDZEc/svqoGR0p1jb1vHrrxFYvNM41/q
	0Oo/0G0eBAJQoNtnA2UUG+VvFz6s0k0P+uJf1a8ulBVtGtNW7EW8Z9orP9AtFQUR
	vqejldnEM9lTBOrMDOowqFKG2+6eLE6L6O7twf4R5RDiuAShpFJ4yHubx0IlKzbv
	68R1rYivBdvRtuNLczQru7QvCxKctZBKkzBJPMqVB7JFGBGx3f4hVHgbPwji3Mxx
	yFqE/zIjgv2I9wK10r/l7Ai7Ftjcu+Wb12KBDUzPYcwJRqo5fSAltjzttzCNQgBx
	yaXgOspVoyhZ239dpKiHVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753890438; x=
	1753976838; bh=iSN3K6t2d8jW/uFiLiE8J3o0z0vksI11LMX3alaJ6zA=; b=F
	43yculvvM/9uxfDjX+g2H7VM3alWiz0866tNhp0752v/jx5RNvkBfb8DeNIfHbgu
	scumKEKBqUIkPqztGakuYKKTihkEWeQIyKNu0eC0NN3HGy0rQamR/sqxGRgfGcV2
	Sey1W2QThTSzb8K0Kw0gF60MyNZltvQv70NlxoYwOLMEC709v+9SoFujiPscHdSB
	J2arXv7TGDDG3O0z7FoDDa295hFXWTRXABucWIytDbTXYNTcWUvF95UJmAhNcjhO
	v362pjo2+y0OaaN/J7XQEXdUll9EQAiUIjYnzjphYwiKkJ82JpnhsYzvM0TelJWu
	5NPVj2EKskdk7uCRRBfxg==
X-ME-Sender: <xms:hj6KaCelNfWsUqa78cPNfkdxravmd0S545NRRZLt8wM_0Iz7e0Is0Q>
    <xme:hj6KaEq27_RLd-194ISO356a4lG6PfZAL2FvX8Y2JzfQE0Wp90Z20VPGQImiyAYjz
    n69LXDYutRf7Bhb5A>
X-ME-Received: <xmr:hj6KaD-J_MMHNQpk1QkDlr5jl83ZYW028iMmv3A04Zc3tS09rKD9weug06N_MbX9oec5gl7ZGw1NFgUAFFNEnsE9djLvL--inYKSyC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopedukedvfedtvddvvd
    efjeelseduieefrdgtohhmpdhrtghpthhtoheptghhvghnjhhirghnhhhusehkhihlihhn
    ohhsrdgtnhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hj6KaAfZXuRYAOOUx4yF8dElW5uJoT0AhV8Fjp8f9jue5zBloHrEig>
    <xmx:hj6KaNLQAicj0uQTdeBN-LI7BsiywcPAiyASMFUMkE7Pn9vJpi7G7g>
    <xmx:hj6KaAgMcM-HVEGdNxGkeiZqzx3LPi35y6jEJATjE6_l736YPrtCMQ>
    <xmx:hj6KaLRTsgN4j4oatYeVS6xCaqkVHfJIHdliXDmsdD4C4kv3pJ4Yiw>
    <xmx:hj6KaIJWqLNCa7q_HM_G9CMrrkVSQiMdNUg60wmzIdEme8APrXo9RHZy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 11:47:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=E9=99=88=E5=BB=BA=E8=99=8E_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, Justin Tobler
 <jltobler@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6ZmI5bu66JmO?= <18230222379@163.com>,
  =?utf-8?B?6ZmI5bu66JmO?=
 <chenjianhu@kylinos.cn>
Subject: Re: [PATCH] modify the =?utf-8?Q?=E2=80=9Cfoo=22?= file path to
 "$PWD/bad-clone/sub/foo".
In-Reply-To: <pull.2022.git.git.1753860300588.gitgitgadget@gmail.com>
 (=?utf-8?B?IumZiOW7uuiZjg==?=
	via GitGitGadget"'s message of "Wed, 30 Jul 2025 07:25:00 +0000")
References: <pull.2022.git.git.1753860300588.gitgitgadget@gmail.com>
Date: Wed, 30 Jul 2025 08:47:16 -0700
Message-ID: <xmqq5xf9n0jf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"陈建虎 via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?=E9=99=88=E5=BB=BA=E8=99=8E?= <chenjianhu@kylinos.cn>
>
> In the t7450-bad-git-dotfiles.sh, when post-checkout
> is executed, the actual path where the foo file
> is created should be "$PWD/bad-clone/sub/foo".

"is created" is a bit iffy thing to say, as the test actually
expects the path _not_ to exist.

Also, pay special attention to what you say on your Subject: line.

    Can I tell what area the change touches by only looking at the
    Subject: line, especially when it is mixed with dozens of other
    patch e-mails?

is the question any author of a patch e-mail should be asking.

    $ git log --no-merges --format=%s -100 | sort

may give us some inspirations.  For this one, perhaps I would have
written

    Subject: t7450: inspect the correct path a broken code would write to

    Prior to 05e9cd64 (config: quote values containing CR character,
    2025-05-19), a repository can trick "clone --recurse-submodules"
    into running a post-checkout hook shipped with the project.  The
    test was written to make sure the trick would no longer run the
    hook with the fix in the commit.

    However, the test did not check for the path the hook would
    create; correct the path to the expected one if the bug were
    still with us.

or something like that.

Justin, who wrote the test originally, Cc'ed for comments.

Thanks.

> diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
> index 14b5743b962..f512eed278c 100755
> --- a/t/t7450-bad-git-dotfiles.sh
> +++ b/t/t7450-bad-git-dotfiles.sh
> @@ -401,7 +401,7 @@ test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into d
>  	git -C repo commit -m submodule &&
>  
>  	git -c protocol.file.allow=always clone --recurse-submodules repo bad-clone &&
> -	! test -f "$PWD/foo" &&
> +	! test -f "$PWD/bad-clone/sub/foo" &&
>  	test -f $(printf "bad-clone/sub\r/post-checkout")
>  '
