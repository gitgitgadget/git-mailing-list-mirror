Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A59D3009C8
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764201316; cv=none; b=WSEwKXTJdr/tmWVW66j4j8ePrHFtcIk33hEqx1X48DMvTG9akDyGyHk7fHp2cx7L36+7Ws9jkYPR3AlhI+gm4aDPFQwqEWmTLc4tnfkY/WyjZ4L1YKq+GuDLk7cdGFZFh7evDIl+8FDGrP3etOCi5cT37nTjhNhohWsSsGo+bOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764201316; c=relaxed/simple;
	bh=51tzXzI3+ItatD8SF7MXdrSM/i2x4Htl1JJoafiPyyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LLcWdnFifF0myJQI5DBjPZP3pHqAyC77x6BzncI5MaFtvDSGXESWUPWEnZRibE2UoZj3OtWHwDGtc09NW9n516xdCGGYNaeIBxm/FFZwvQ4YF5FKFbC7xgmdBX3aIrKiE1Xe5rj1cdsajIc2PmRqwInhZKKbFaaY9wQu9/8hKCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nn7q2rC7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nc7WEDYG; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nn7q2rC7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nc7WEDYG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id F18501D0014B;
	Wed, 26 Nov 2025 18:55:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 26 Nov 2025 18:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764201312; x=1764287712; bh=qUEttidRUd
	iarGebddr6VF5z3yWY9MSYbbk4qJALR4o=; b=Nn7q2rC7Hs7qjVXOVeI4grdRfz
	Bk5Ru1O+5kh/O8Ui8KEQysDl3UKPtWHQZSahfg8aL6baOUt2o6zL2Hk10ZwuaPdH
	LKnVmxj/H/tYvJca7PLzyL+IVXwWMaWDvGKL1AEB1Hfr6neiQi2qmVjNNN4s3lmr
	cpaYbKB4vg8XoaJJNG3zcr4k3YTutnFxx/0LsQnfMTfRuckyNSKdww69VUIKjdv8
	R0YeUX3gH8CCFjCJCy8bOvR02p0CQYhf8fQkND3N4QvhPlHvHMGsrzqayle3jTdE
	0ACxYanTr7GmMfgM4esbkc/mUFIBVTDpNzqp63JeYsHbVP4A0WesIooEVVbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764201312; x=1764287712; bh=qUEttidRUdiarGebddr6VF5z3yWY9MSYbbk
	4qJALR4o=; b=Nc7WEDYGNLLhnIbXjo9ykwv0lPwU7M5rgL2m8FYsW3NBpE7VJ2l
	Ur4CEda/cOZ9dHQq9rVUheyuNsisq4jT/2nC8i7hOl9xkC4SfTNOkurCWbekYwVn
	nS+AHbEDy26qyzsb9lqE2xzmGB4N4C5cTsq6VW6j9GBGaQGE1oEUt0Qqp7vjPMOZ
	SY70mArhU7/yzxWXgAzXdyBrZI7mtE9dwc3GtsdGoolSoXkHik2k3AvMxtHnVWgh
	0EViZ6SkaxZfPHB7I3u0qknPzeSD0ZtdstydYC9uyC1+KLL7rdu0YIstwo6TcEwC
	/eyAWMKBN1f35AYVf6TydEiVBd0DzzcNMGA==
X-ME-Sender: <xms:YJMnaTLAcYSNjdNghgkiYnP4NrXnmTtwfK_MJMTnaj_SpPm47FABYA>
    <xme:YJMnaZbFASDys517YPy2IlPwNnNUTgJVc6B_GIfvzku-ifAi_jbGrMBjcyEummI2-
    hHtbfoeVsOfjoGbI6RsYb7J9WrrDg9nB5a8fg6i1bvDPdYK1P3hNUo>
X-ME-Received: <xmr:YJMnad_A0V1p2_gQEmYsdxYzU0QROpgpzCCzhds8YyNXbEyrM3NBjMxKqxWbrcJcDg6UHCh6c0kOCyfvvvu-QY6amj_iFSrYplSR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtoheprghtthhhvgifhhhughhhvghsleefgeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YJMnaSbn2iPHEzu_nwHiyt2kmLMcFod7rcSG-HnhjciW_yvB43XBPQ>
    <xmx:YJMnaZNjnUJgTT0gfVw3JddXyrjdHJGBNOAGQg2Bpyt5oklHOpHOUQ>
    <xmx:YJMnaWDXSlyDS1SKu1hiFAvPeTbsH77LYZT0X87q3lZ6LauSl7Q1vw>
    <xmx:YJMnaYJPuMmsuF3SG8l1aD6V6uz98oLfEvR87FaQbvIcNdeJgzSu5g>
    <xmx:YJMnaVDCrPBO2mvXPsTdzB3hq_Cbe3D9a7e-HebBd9My3DIj5vCbaemO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 18:55:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  atthewhughes934@gmail.com,
  johannes.schindelin@gmx.de,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/5] scalar: annotate config file with "set by scalar"
In-Reply-To: <a4ad8f80d062cd9fc62db69c21625eb286f4ebb8.1764195516.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 26 Nov 2025
	22:18:32 +0000")
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
	<a4ad8f80d062cd9fc62db69c21625eb286f4ebb8.1764195516.git.gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 15:55:10 -0800
Message-ID: <xmqqqztkl57l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Add "# set by scalar" to the end of each config option to assist users
> in identifying why these config options were set in their repo.

The implementation is quite straight-forward, inlining expansion of
repo_config_set_gently() in the places that we want to add comment to.

If we had (a lot) more than two callsites, I would have suggested to
add a simple helper function, something like

    static int scalar_config_set(struct repository *r, const char *key, const char *value)
    {
	char *file = repo_git_path(r, "config");
        int res = repo_config_set_multivar_in_file_gently(r, file,
		key, value, NULL, " # set by scalar", 0);
	free(file);
	return res;
    }

and then the updates to the callers would have been absolute minimum.

Well, even with only two callsites, perhaps such a refactoring may
still have value in reducing the risk of typo in the comment.

> diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
> index bd6f0c40d2..43c210a23d 100755
> --- a/t/t9210-scalar.sh
> +++ b/t/t9210-scalar.sh
> @@ -210,6 +210,9 @@ test_expect_success 'scalar reconfigure' '
>  	GIT_TRACE2_EVENT="$(pwd)/reconfigure" scalar reconfigure -a &&
>  	test_path_is_file one/src/cron.txt &&
>  	test true = "$(git -C one/src config core.preloadIndex)" &&
> +	test_grep "preloadIndex = true # set by scalar" one/src/.git/config &&
> +	test_grep "excludeDecoration = refs/prefetch/\* # set by scalar" one/src/.git/config &&
> +
>  	test_subcommand git maintenance start <reconfigure &&
>  	test_subcommand ! git maintenance unregister --force <reconfigure &&

Looks good.
