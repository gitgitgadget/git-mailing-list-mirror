Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E32D97BE
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884221; cv=none; b=pvgUmAmEhUEI5lc/7Ab96bT7MJpIJE7M43UdOMQsnYarFcNcMoruVwSHl3a+LquOmWCVSgJsoz/bOAnJuuYnRL3Eo+QL7rB5108OLOYwWU8SsKJxtRBWoht8NaSRkRYgCZxzVNLb4xRZHY8QK3hviEqkfMsgdLGlM7gt1vfrs20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884221; c=relaxed/simple;
	bh=nOh7rPVMx6YOC/MVW7WFNU0UwyE2mkAsUmuLFhiYero=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SS6rPC3fOgJ/5pWRe5Y1UBycgxCzlwxcJOC3n5UcDvqTuGE2KtdF21nVf99mNxRi8H+FjsEbmeAaX0cuX2LiH/ba9ntaOS5ZkxigKkEUeH7caCnx5gJvdwQWnI8JMvFT9bMfapThVKWdi0cqrCjevxUcs3kAoSjg5Ex5GJ44h5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LxH+RrAo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mO0yXNYl; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LxH+RrAo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mO0yXNYl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95F7E1400388;
	Wed,  3 Sep 2025 03:23:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 03 Sep 2025 03:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756884218; x=1756970618; bh=adzeYNWK0i
	ghP2RuvYNZzFmk0rAzqrES2tSH0MGhD5s=; b=LxH+RrAoTfZibvAzBegD43Q2W0
	VycL65SJlsyGI9XL7vQZgxMyAOzwL7ZGWOKjQT9djmXFCLTQTazTyhKfhR689Clb
	wtVfHdGD9/qsw7BjS1BoYf/tRhCfhEodCTM0ASVJPG3cebF9xxqnX4eHq5zFPPUz
	q5nexTM1GTdBVTv1zvR+/C7v5BRk9NA79cRKBtHRGynvKRjf2eKZcSq5JMnUUTVU
	NH1EEjHkW5iDnulC4JYgnlmYKuev9czxYemlajREhmmzPGkjguPeUWxZAL7LgYfv
	zLbSY8w8jfUggMTKeHA+frVfFbVgF6wxw8BWhcv9rSuvbDIik2sLF0koicZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756884218; x=1756970618; bh=adzeYNWK0ighP2RuvYNZzFmk0rAzqrES2tS
	H0MGhD5s=; b=mO0yXNYlsHaqCJcupY79+WbAppeQm2z4XGAsHvJbsGwOHlTT7gs
	d1lZLOtoBSEz+DHo0dFHhQVg8Q/y9Af6A+MNkAAgFYUlh0wPrqv2MWQ9BvttIF4D
	lJgsxofVumohEh09EybWZzljiCn9QEOJ6h4IHSLYqUzex3Zet4nK1YKwNJ/Foxbe
	1pXksScv22NWIQ8WMme2vgg1MgLiA/wI2BVs07Nnk3S+k/OfJ+BIN0uQnIamom76
	btSZCTwDdbTKgmsPznQNxbHdg2Wz9PV7zICJH+zOeN2JWDzxFRbvO5IjzjbPDtJj
	ZMmaI1Aal4I/8sde3aoYjWlDs2+ZCfQ7TJw==
X-ME-Sender: <xms:-uy3aNZdPsEXqO1zpa5CO4ZXfz_qlGG70ygQ7OG3YVSw1z0PajUUoA>
    <xme:-uy3aLSzhc9-bSu4uxzRmG7gqZo41rlZE5_Wb0zRSc4x41C9rtZDfTVtQ7F26qXwE
    8z2WsYxdmBl3O8K6A>
X-ME-Received: <xmr:-uy3aM684kelzj9w3Yp48Fm0e73NcRlhtez5LMBZCjrTsvRc-QGhrFAfr5VgY5GKZG1LOsnZ70GdoGfMhOxnvdAwxRE_6E40Tf37oYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ihhsrggrtghoshgtrghrsehlihhvvgdrtghomhdrrghupdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:-uy3aIyB5nAnLsTPR4uGBqaA8MEIXAmwBQ08pWBooF2JU5vHYlFFpg>
    <xmx:-uy3aDSxx2KBP3oIyet1iSNd2RuqhYT15fUC7G_GXGKkDACrFT_1Og>
    <xmx:-uy3aPU4FVrUC0z4VmOp9RNDbKY4eZlqKueWHQAYfhHUdcUvU_if9w>
    <xmx:-uy3aFZsMT3yr9ZRl_tFSF7hhvRWv4Zs0Vfxe_rmxgWhhA_4RuxFvA>
    <xmx:-uy3aLucJDDtbxsxwEUKwv4eClVx77YRBAREzHDkjdoo1VViEF9xP7vf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 03:23:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id edf1a495 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 07:23:36 +0000 (UTC)
Date: Wed, 3 Sep 2025 09:23:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Isaac Oscar Gariano <isaacoscar@live.com.au>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] add-interactive: manually fall back color config to
 color.ui
Message-ID: <aLfs9ZbAxHnsqluw@pks.im>
References: <20250821070740.GA3356411@coredump.intra.peff.net>
 <20250821072224.GC1839835@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821072224.GC1839835@coredump.intra.peff.net>

On Thu, Aug 21, 2025 at 03:22:24AM -0400, Jeff King wrote:
> Color options like color.interactive and color.diff should fall back to
> the value of color.ui if they aren't set. In add-interactive, we check
> the specific options (e.g., color.diff) via repo_config_get_value(),
> which does not depend on the main command having loaded any color config
> via the git_config() callback mechanism.
> 
> But then we call want_color() on the result; if our specific config is
> unset then that function uses the value of git_use_color_default. That
> variable is typically set from color.ui by the git_color_config()
> callback, which is called by the main command in its own git_config()
> callback function.
> 
> This works fine for "add -p", whose add_config() callback calls into
> git_color_config(). But it doesn't work for other commands like
> "checkout -p", which is otherwise unaware of color at all. People tend
> not to notice because the default is "auto", and that's what they'd set
> color.ui to as well. But something like:
> 
>   git -c color.ui=false checkout -p
> 
> should disable color, and it doesn't.
> 
> This regression goes back to 0527ccb1b5 (add -i: default to the built-in
> implementation, 2021-11-30). In the perl version we got the color config
> from "git config --get-colorbool", which did the full lookup for us.
> 
> The obvious fix is for git-checkout to add a call to git_color_config()
> to its own config callback. But we'd have to do so for every command
> with this problem, which is error-prone. Let's see if we can fix it more
> centrally.
> 
> It is tempting to teach want_color() to look up the value of
> repo_config_get_value("color.ui") itself. But I think that would have
> disastrous consequences. Plumbing commands, especially older ones, avoid
> porcelain config like color. by simply not parsing it in their config

Is the "color." intended to refer to config keys starting with that
string? If so it would help to quote it and maybe say "color.*".

> diff --git a/add-interactive.c b/add-interactive.c
> index 95ab251963..db7e6a81a8 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -45,6 +45,15 @@ static int check_color_config(struct repository *r, const char *var)
>  		ret = -1;
>  	else
>  		ret = git_config_colorbool(var, value);
> +
> +	/*
> +	 * Do not rely on want_color() to fall back to color.ui for us. It uses
> +	 * the value parsed by git_color_config(), which may not have been
> +	 * called by the main command.
> +	 */
> +	if (ret < 0 && !repo_config_get_value(r, "color.ui", &value))
> +		ret = git_config_colorbool("color.ui", value);

With the previous comments where I say that we should use
`GIT_COLOR_UNKNOWN` we should probably convert the `ret < 0` to `ret ==
GIT_COLOR_UNKNOWN`, as well.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 3f9cb9453f..0024991257 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -1335,6 +1341,15 @@ do
>  		test_must_fail git $cmd --inter-hunk-context 2 2>actual &&
>  		test_grep -E ".--inter-hunk-context. requires .(--interactive/)?--patch." actual
>  	'
> +
> +	test_expect_success "$cmd falls back to color.ui" '
> +		git reset --hard patch-base &&
> +		echo working-tree >file &&
> +		test_write_lines y |
> +		force_color git -c color.ui=false $cmd -p >output.raw 2>&1 &&
> +		test_decode_color <output.raw >output &&
> +		test_cmp output.raw output
> +	'

Nice and straight-forward.

Patrick
