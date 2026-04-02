Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE42E2665
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162659; cv=none; b=Bkm8OHq8v44PLsWbkbcvgBMnLkJWAQg6BP+TfHxuuXGNlq+NTLkdhH6nYqtdt7sfNlMRzMcWubTpCzYsn+A7AAER+6kxed3FdCiCQ/poFAs3A2GPmfd41ERDf/HAW1enVDEexTonNzaBE5FloYTWxl5JeoivunX90jRP7hb1OkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162659; c=relaxed/simple;
	bh=DGVCBYjRFtgfnY7oz4ook+FRIniKqtDIEiejZEM51yk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=riP2oc/b51Q/SG8vvkXvxMnSgrqhmWs7k4TGE6+bN/JrvFuTlN/p/bi6wVgI1oJZNo8q5kuGuldRkrQnlXChqio7QS9xYCBOF4XTCCk9aLKtDpnY64VnYA72k/QtwdxoQdjc1urNugNfAnWeq9IU163JWD4zJ7MMP6ZQlsLfjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PfaPdNDj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=toaJtW68; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PfaPdNDj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="toaJtW68"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4435E14001CD;
	Thu,  2 Apr 2026 16:44:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 02 Apr 2026 16:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775162657; x=1775249057; bh=MdnN5QDkTk
	rDML6BN2+7dMV8sFZItiBEIZOkJ5Ld8OM=; b=PfaPdNDjRWw5dJ/4mJE4ooo3OV
	bvSGgV5qHm2mLQpZU7Eql84zzaLjKDocEQU+tYthhlVu/EbyUw//QZRR2sELRCzJ
	0WDVmYnb1EHHk/uO/Z2X2q0ROYzEbP7KYlHHTyLDX09cKq2IjfejnhdgpnryYfMF
	pvF33qGA2RbeofnxQokREHHjfQQNW32Chg4soRJB0G2q+XguorHW7N+43hUlKmkT
	XyxQ0/E4BH7eVBzISDKr8jYxU8F6xId+BwFJ7A7Y+eXbq9MgLwuoqAZ58KF5s9PX
	ZkOXjtZjKSHBG15dkLixDH4an27Ak5nxrRChA9H2uqnaQgN/eJO/5B/pq94g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775162657; x=1775249057; bh=MdnN5QDkTkrDML6BN2+7dMV8sFZItiBEIZO
	kJ5Ld8OM=; b=toaJtW68lhPu5dV4ZUw4eDv7+00Ptd62HlFg9QGf5pPRNgRdzRN
	r/n1REASyL8NPnYtRzZSbRZgMwc2+Cz6K/JWyJFqUsJV0mggrppCzZnjgyMsd/Ia
	ehcUt+HzGrfDkmLqcTSVnRQda76CDpKmH0eWCnyuhX6IyWzCX/Ik+csmYCsh832L
	IKCyuktpdVTE8BKgpwe8KA4JgXObuAEj3sYfIk1jEWcflSRlnKy5xM/C88cNTZVx
	gL2cnRQlk6Q33JC78unbucPmI53Ae0TQJKUHwNtlru9AwPEIK5Jqm6+Ve397eoFr
	B6GEjzK2eCHMg0qFNFFDinfmmqCz9vkrdvg==
X-ME-Sender: <xms:IdXOaX--bWILFsnCNtDcqRYcpjmcB3K4G4lNzHl2WoSG7xn16T71pw>
    <xme:IdXOaav2IqQE9uaKN4-xMIL99gbNnhuuG0kqbQxXosPITAUKO516Q90gG0uIRbM2D
    XlMMnd8Z1nQ4UoL4ApGoqTfY4Rg3q0gKSxQc7w4v7nf0dHBxhudTQ>
X-ME-Received: <xmr:IdXOaaC2Dmp6HIO_s2LjudRwNAJWkIzFEa7GUg6OpcHRAaE5CsWOYM6TOgy8wv5dQdjawPp37sjxMpZGCDDl0Wo9XOk3lGc9pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IdXOaSWQ91Q3qg9ISLuEzQnHIR5UGMOmEdPYbP-dwmzV2UTpxWmWcQ>
    <xmx:IdXOaYDTRj77idCHBip2MjUlZr2ysNrouL1Yejd-S0NVgmtLwzOBqQ>
    <xmx:IdXOaV9bw261ZQF0kFEJjEszCGQCg6_yqJVQoMg-dfqqS7XS4CXL-A>
    <xmx:IdXOafFUxNJPdLFRHvtwNIULgmYrqSIrmcEBT5d_1zpH96xcVqL8Kw>
    <xmx:IdXOaXblpwgfDAK8a_mKKpb-Bfbm-vEtHmFhdBZbgEHBaTRWPo7SUZbD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 16:44:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 11/17] t5509: specify bare repository path explicitly
In-Reply-To: <f6fc807af627701bf7f9ea413c7714e9bc01aea4.1775140403.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 02 Apr 2026
	14:33:17 +0000")
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<f6fc807af627701bf7f9ea413c7714e9bc01aea4.1775140403.git.gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 13:44:15 -0700
Message-ID: <xmqq341dozxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  test_expect_success 'hide namespaced refs with transfer.hideRefs' '
>  	GIT_NAMESPACE=namespace \
> -		git -C pushee -c transfer.hideRefs=refs/tags \
> -		ls-remote "ext::git %s ." >actual &&
> +		git --git-dir=pushee -c transfer.hideRefs=refs/tags \
> +		ls-remote "ext::git %s pushee" >actual &&

Hmph.  The command being ls-remote (which does not care what state
your working tree files are), the above may work, but rewriting 
"-C there" with "--git-dir=there" changes the semantics of the
program, no?  A more conservative rewrite that would preserve what
the original wanted to test would be to ...

	(
		cd pushee &&
		git --git-dir=. -c ... ls-remote ...
	)

... do this instead, I think.

>  	printf "$commit1\trefs/heads/main\n" >expected &&
>  	test_cmp expected actual
>  '
> @@ -97,8 +97,8 @@ test_expect_success 'hide namespaced refs with transfer.hideRefs' '
>  test_expect_success 'check that transfer.hideRefs does not match unstripped refs' '
>  	git -C pushee pack-refs --all &&
>  	GIT_NAMESPACE=namespace \
> -		git -C pushee -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
> -		ls-remote "ext::git %s ." >actual &&
> +		git --git-dir=pushee -c transfer.hideRefs=refs/namespaces/namespace/refs/tags \
> +		ls-remote "ext::git %s pushee" >actual &&
>  	printf "$commit1\trefs/heads/main\n" >expected &&
>  	printf "$commit0\trefs/tags/0\n" >>expected &&
>  	printf "$commit1\trefs/tags/1\n" >>expected &&
> @@ -107,8 +107,8 @@ test_expect_success 'check that transfer.hideRefs does not match unstripped refs
>  
>  test_expect_success 'hide full refs with transfer.hideRefs' '
>  	GIT_NAMESPACE=namespace \
> -		git -C pushee -c transfer.hideRefs="^refs/namespaces/namespace/refs/tags" \
> -		ls-remote "ext::git %s ." >actual &&
> +		git --git-dir=pushee -c transfer.hideRefs="^refs/namespaces/namespace/refs/tags" \
> +		ls-remote "ext::git %s pushee" >actual &&
>  	printf "$commit1\trefs/heads/main\n" >expected &&
>  	test_cmp expected actual
>  '
