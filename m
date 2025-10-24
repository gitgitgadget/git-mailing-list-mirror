Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CBD3093C0
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297096; cv=none; b=FF+zm7oAo/TqN95BkAV6Blm7v2XF6KOA3ah+Mq53ufBs1ePzooCVFKEeRIusiQA+42OoMGbxhRMdwBAjGPp8r6zsrSZIucO0Zuuhw3waKcfn1iL2FOEjDV3dwjHcDVLA66cW3jmoOeRhso4Omuv1Izl9l9eJ/wb/dnap8GOHszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297096; c=relaxed/simple;
	bh=4iyYkJwngWZi6uwwSL2hSXqntUviW3usTF2RI98iHn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmdyn6BSoCXBqVC7qjf7YRxdmol66tx2+kzTU3xR8RDgzWTvbOvVh2ozWglX0ylysvxaXTY4cOPInfFLQY+kpQl5gA88Q1p7T1mHicIhI5wZexqoJoEtJBlQ+8PqDhTaryb9dIBme2KFILMA7+KiYEuaLv6xLSv8fNfcZQ7d1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZEGtOsjR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NRjwtq6a; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZEGtOsjR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NRjwtq6a"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D321EC02A7;
	Fri, 24 Oct 2025 05:11:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 24 Oct 2025 05:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761297093; x=1761383493; bh=skYVwJMkvr
	QfC+7HgmHbWCeit/Xv+r2UvJmrO8pmGTg=; b=ZEGtOsjRKNe4TpeBof1avRYs/A
	A4Wjtncw8K3+L/cElJsfRt8rIjsyTQQPZhaxhc+4g4Z+EaQyrvXy2MksqFikPUeW
	mExqFtRLoIEcQWrU8GCQo+XiOqrLiXhLGp9SnNW9OlY2v3PLlAemCS+A1kHE4jBX
	1wyfldN0XP22pDX98Jh9gLu/wGw7VQhdO+vtPIEo5Mextvw6AN7Pe9XVUnDUrDfe
	wh/dR/PR9GHVm8NnNXruSzxRfQonEdWJ9FVX4JwPAl8iOS6nVjhyQEIHOfTWxHj1
	/uMzBGNEwrJCWEQ3WEMlpOfFdG1JvqJqqXW3LWI78cc3a7tqUKbfCDubWgxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761297093; x=1761383493; bh=skYVwJMkvrQfC+7HgmHbWCeit/Xv+r2UvJm
	rO8pmGTg=; b=NRjwtq6aT4IvpscN+Mplfr0WA9AsC7KdHoe0EYMVwo152ngbAo8
	sNUnksXOwD5zZqOBNmktBRJ1IiCvFvAs20irC5VO9S80eRrJSWxlhjdPdkfB2oYn
	qgB7TZeqiESMdcrFoHUVAcKbHHkMaJpvV7g0oEXI+N+7DBp9I2Nl7g4zjEmChVNF
	fzfn78tk6ejGB6fckssRv/UjaSv81ADk3AYSixSPBYZWAR3zIYChmbZdNGGC9XsA
	gV7fjySVasIvcXuDXxHKkjcd2ClAnEIZ6RN2ewzKFh/KxKwXg4lfny67tN1Z5kqY
	ge5HOoahWZd+Mxa6LOf79lRczGZw3iL+p7w==
X-ME-Sender: <xms:xUL7aDsVTAYLCY_7l4-CgsbUljUIYTPCznBD3vF21uVn35T4eNBU1Q>
    <xme:xUL7aLfMCil6GZ0hvpZYDqyRNEWUmmDLvQy9QntHyEsi2WCppfD8vmo3EVYokjsGQ
    zqilig0HALKUrQWUUL9R140jSh7nRVNofn9VgxAp0x24P2fcaYa-A>
X-ME-Received: <xmr:xUL7aLyhIwb1HkWpFAVWKJpKVh3DAmbXkL5NyFb9LtfSR6xlbAoFzhLVP9WOsLVgpJj4Ie8cmqSj82_F94OhqSN1IGqjrqfm-YoUNuFODw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhdvtddtleekudduudefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuddtleeige
    dvuddvheejsehqqhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:xUL7aBHT6pqAYQ82wdeOq15Bfg-unGtlso2oXHE8A8JfTtJkJhztCQ>
    <xmx:xUL7aPxZiu6xPZEFMGvkabPZwTJk_5E3QhsxFY-xqJC8ase9077Pdw>
    <xmx:xUL7aCsGp6i_3ku_Sl5VfErSmRaX_3jPrNN7q0UHieSRL3AW0PyPRw>
    <xmx:xUL7aM1VN2BNk6PhJytIxlxQ8oU_SyE6aDkotC5KIiShc7EEhlEoZA>
    <xmx:xUL7aBj_I1Gpjp1NxIJsHppZZ2oEks62NRHtrJv4kznJQurinnbX58La>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 05:11:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19b2740f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 09:11:30 +0000 (UTC)
Date: Fri, 24 Oct 2025 11:11:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: RuanXinyu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, RuanXinyu <1096421257@qq.com>,
	RuanXinyu <r200981113@gmail.com>
Subject: Re: [PATCH] refs: add missing remove_on_disk implementation for
 debug backend
Message-ID: <aPtCvwvNUtFXqrpv@pks.im>
References: <pull.2082.git.git.1761295094982.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2082.git.git.1761295094982.gitgitgadget@gmail.com>

On Fri, Oct 24, 2025 at 08:38:14AM +0000, RuanXinyu via GitGitGadget wrote:
> From: RuanXinyu <r200981113@gmail.com>
> 
> The debug ref backend (refs_be_debug) was missing the remove_on_disk
> function pointer, which caused a segmentation fault when running
> 'GIT_TRACE_REFS=1 git refs migrate --ref-format=reftable' commands.

Heh, funny, just as I said nobody uses this infra you show up :) Good
way to prove me wrong, thanks!

> Signed-off-by: Xinyu Ruan <r200981113@gmail.com>

Tiny nit: typically, the author and DCO should match. But the autor is
"RuanXinyu" whereas the DCO says "Xinyu Ruan". I don't really think that
this is something that warrants a new version, but I wanted to point
this out anyway so that you can fix this going forward.

> diff --git a/refs/debug.c b/refs/debug.c
> index da300efaf3..dd49080836 100644
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -48,6 +48,14 @@ static int debug_create_on_disk(struct ref_store *refs, int flags, struct strbuf
>  	return res;
>  }
>  
> +static int debug_remove_on_disk(struct ref_store *refs, struct strbuf *err)
> +{
> +	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
> +	int res = drefs->refs->be->remove_on_disk(drefs->refs, err);
> +	trace_printf_key(&trace_refs, "remove_on_disk: %d\n", res);
> +	return res;
> +}
> +
>  static int debug_transaction_prepare(struct ref_store *refs,
>  				     struct ref_transaction *transaction,
>  				     struct strbuf *err)
> @@ -432,6 +440,7 @@ struct ref_storage_be refs_be_debug = {
>  	.init = NULL,
>  	.release = debug_release,
>  	.create_on_disk = debug_create_on_disk,
> +	.remove_on_disk = debug_remove_on_disk,
>  
>  	/*
>  	 * None of these should be NULL. If the "files" backend (in

Yup, the implementation looks obviously correct to me. Thanks for fixing
this bug!

Patrick
