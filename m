Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60023373D
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582372; cv=none; b=j1VByWFha3WmN0a9HUCYuNhUU4x1qYb6IyZbLo0MMp7BhDdxJm2FkpmTnOUl5YMsx0swREDkdWGVb7SZPNkz15IrqEfxK8zgVur1TbHIKbeJimKgtOU/ULiIUsT74xtrB1fVuG4qvqagcQLMah+23ZKLXopOyCxFT0NWvlRA8F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582372; c=relaxed/simple;
	bh=hXkSs287XgYbJEvkJ//9FyERx2p1efpjFbEbYZYIBJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBTU63kE1uqwdhgmU7rVXTXk/AShaN4Uf2vMzN/lz8Fu1Y8qyl2tNs/KktS+ojf2RWclL0FrrCqZPlibJzLb4VRMCwICoIFW8Kl7Et4+iuEcRnXRYdaL39stYk3xuJN3M1rbwPE+TyXtXjTaceDeNK+3WDBc8Wdig5LFmMSda2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s0f/Mo33; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TJ3BjFvn; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s0f/Mo33";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TJ3BjFvn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 186DE1D00101;
	Fri, 20 Feb 2026 05:12:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 05:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771582369; x=1771668769; bh=yD3s80Iq+w
	LFs4DEpxlVYGM8YfTmslieXpNUEGn0LGQ=; b=s0f/Mo33sse54ZcZJL1pT+JO/9
	6hHwD2q5Gdm+A3HKTjGtykg3wd1m1V+WQcs1UFyvtsWIAVw1MEW0zWL3/YdP7pPn
	vfaxWmedWYe7k11qMDmB7uxkEK00DXEL41Ip/5HkQp/p1DNxsnhMPeoOsZ4UwShA
	TrSrDa0088soN6UyAWlL+sSE/vO9rCHG8QMRBsQpIN5lLIa0CJ1OyL46FF5h4ax7
	UcyUhPQqQoDVJO58kafUZPU1+NZN+jwmL2gLvjZc2C5RjXaMRvxI99+AwqKmTFGp
	WZXYq8nWRb1EoF3wdW3eVyB8N3FvaDXSSZTmiX0ESAdERs3dxoF+xQcsEGTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771582369; x=1771668769; bh=yD3s80Iq+wLFs4DEpxlVYGM8YfTmslieXpN
	UEGn0LGQ=; b=TJ3BjFvnSybNflv34YNOon/u2wJTkN95fxpKBl1YioRJFmrcpiN
	mlReVY8PPC3euoUkCu6hnLVCuuibIYjGIdt4WBAGmnkESNZ0YaA4K+elz4ZRFXIO
	3fsNOrticqkO1D6rcJ7hZ6nyOJIaAqu5swDVk47nM4vxDDtja6/v3EC/wlPDWZGH
	vba7Di2PzSyJZXS06VCyCFiR0QOiFZwx+nMWa72tJUzdt6DYXLpu4Uyk4ArxlbsF
	n3IH8TkfTczy0STmRCAr4J807mxA2PhlFbk0/HN9LfItXCdtLU0RNEXqgsjnBH4R
	rjcMvF98pym3LHqpLQMxrAoa79F8yqrBabQ==
X-ME-Sender: <xms:oTOYaUw09BI9W9lUbBVOzjnwyU-E09LMvHZPV_v02eDXC-yvZOywTQ>
    <xme:oTOYafJyM7JfcoY3k922P62mRnI-QITsBLsIAskeOC-RBP9XWFLtqnPiAyB2UkkUr
    EPCHeaIBOe3frau4J9Zwcfn1yWkQjZ0YSJDU4NDE3vRgeURyq-uBDY>
X-ME-Received: <xmr:oTOYaervV48d78pPkK2K_gDQpCKqNbUBjLTvJo1qIHFQBCSFzQqD7IQO16bseFBpRMFnq8m8nyE5ZPOPOpKo_sMieKoJOVESnrMxmyKZ0ZrP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrvhhilhgrrdhjnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    eplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:oTOYaeKMVqdW2wQp4Q0QNTwA8sB6Wjk8_rqtsF8Gjxkzm8SCWn0aog>
    <xmx:oTOYaTTF2hPcUgwBD8h8SmjQowwMVucQOZZvc9jmas0XWm7LsvOkwQ>
    <xmx:oTOYadsIP-kG330QWGfs8TZ8DQYIMPGGVZhPKLNhN6e7FV4ciNpsdg>
    <xmx:oTOYaUbP6FstY9ajuOBGX_FCO78LNU2TCFThoiJ16B7VkDkZHz8FZQ>
    <xmx:oTOYaZYdL10WQspuDYmUZlwJRHvVnxHuaBrbjfLYw9nMkcN0YNMge9jT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 05:12:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b573f1c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 10:12:45 +0000 (UTC)
Date: Fri, 20 Feb 2026 11:12:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	avila.jn@gmail.com
Subject: Re: [PATCH 6/8] t1901: use tr in git repo structure output instead
 of expected value
Message-ID: <aZgzmlVfuXgI2UJ9@pks.im>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
 <20260218211845.96009-7-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218211845.96009-7-lucasseikioshiro@gmail.com>

On Wed, Feb 18, 2026 at 06:08:42PM -0300, Lucas Seiki Oshiro wrote:
> The test 'keyvalue and nul format', as it description says, test both
> keyvalue and nul format. These formats are similar, differing only in
> their field separator (= in the former, LF in the latter) and their
> record separator (LF in the former, NUL in the latter). This way, both
> formats can be tested using the same expected output and only replacing
> the separators in one of the output formats.

Hm, okay. I have to admit I don't quite understand what we gain here. We
have to use tr(1) regardless of how we do it, and I cannot see that
either of these alternatives is clearly superior compared to the other.

> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index a6f2591d9a..4de795181f 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -145,18 +145,18 @@ test_expect_success SHA1 'lines and nul format' '
>  		test_cmp expect out &&
>  		test_line_count = 0 err &&
>  
> -		# Replace key and value delimiters for nul format.
> -		tr "\n=" "\0\n" <expect >expect_nul &&
>  		git repo structure --format=nul >out 2>err &&
> +		tr "\012" "=" <out | tr "\000" "\012" >actual &&

We can combine the two calls to tr(1) to a single one.

> -		test_cmp expect_nul out &&
> +		test_cmp expect actual &&
>  		test_line_count = 0 err &&
>  
>  		# "-z", as a synonym to "--format=nul", participates in the
>  		# usual "last one wins" rule.
>  		git repo structure --format=table -z >out 2>err &&
> +		tr "\012" "=" <out | tr "\000" "\012" >actual &&

Same here.

Patrick
