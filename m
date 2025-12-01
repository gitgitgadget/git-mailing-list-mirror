Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE83002AA
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582443; cv=none; b=fGXBj1aOZL1vK5TGG2anoEGOfIoFk7FIZwoet+Ti7nQfR57PUzztY2x0dlSeSxnsDZeyISOawv+QRXo9MeSnhSBstrGljGnYnhEhXK5Z5/7UBwrs/J0O1f3/UcL05p/ueu1ihAPz0npunAgN/f+6T1zolNyI/Fq/r4Cvd0P9+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582443; c=relaxed/simple;
	bh=QBBaV4t+27VBAd6fAsJYYxFn4XWuvaz55Wk218V/shQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fvlxo+E6/s3lIlQuuU9qDgyieOcND0L1KMm3o6C8qXup64qD3qN1BSFj5qQyBeX3EiJTQWoVTWS6V9lStS2wSm1xpDbuA2HEJWi6gXTcDSP0cy1Sr7ksZ97PJAYWn2OcGwj4rveBPNo9mNza1poY0aOQY7y5n920Ayj61Kkv8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OmyCrt39; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c6WZyQMl; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OmyCrt39";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c6WZyQMl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C92EC14001BB;
	Mon,  1 Dec 2025 04:47:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Dec 2025 04:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764582440; x=1764668840; bh=fvmenQuUfB
	U/EvuwwZpt0PaASNcUPkjXPJZWNlGsdHs=; b=OmyCrt39cyg1Pn36bwA/AeB/Ls
	9NEIULTS9ThrUBELtb45jxIFCnYIjRFaUGnmF3jumhkX2/yDNB3hKNl4szGpp/w9
	Xx9a5KUrc9jCBaAQ23bfSSyaTljkX7fSrThVkuLlK1m4aA/YRe48uMGsV1C1YaRk
	nVCBLkl3fYLKqlVxzO/DJ9RHaBbRS1e7R3NpjSksoEedP5UEgmLJZRNRM0SqPa6P
	sVpI/E4YHaWO8SyfE2qCXtY/URwu2vGl4Zx5qXlKjLQ0KhbM9e6L64NU0qehQNkA
	zsNNM490KM5dRoabVYGYldot6/pDbeR1b4Ji6XdDbbI+sw18QN86ekc4DbWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764582440; x=1764668840; bh=fvmenQuUfBU/EvuwwZpt0PaASNcUPkjXPJZ
	WNlGsdHs=; b=c6WZyQMlaSOGU/pYPoTShuVgt6X2i9kv2vD26N3eFYmSfrp+Yt7
	UHnBupDpiljrNDhU/pyqbZ5Xo2E9qTFwTqVYqPQhZ0rupDZjdhIsysDa4dZnVBLC
	Jj3gFwNBR7/S3y3aow49Di4WTHYngvx90A6ucuZETH+tMWO0vyjpcRQJ9TVRbAoW
	l9ZKfnrTGe3+ucepUz3jtF2LlsxlDiVgZ8BLoxvtvbA19V8lofkkpPsetCoZ+jg0
	hYLIGfVUTCIhlRpO7bso4W1y7rmIA5BXQ4V+ovCktgk7y8E4dK/pax5wdZ7I/0kX
	ZPTOsEm9GSGBRL1lsaM6dEw9UZVTT742mIg==
X-ME-Sender: <xms:KGQtaSDAUOpz1kt1Muo_edMcEN7t-_WapK_B--CtR-s-olJhdQrtqw>
    <xme:KGQtaT-FUODbCveHc-xmAwUu5T4gNilbId8YGd_19d8zaWBDPNWKyi5XtXFFpHacb
    qy4GPUDuGke5xWxamcI2MGrSJEMLSlMANOjer5law73cJ98iwtRJA>
X-ME-Received: <xmr:KGQtaS9ekYbdBMzTXo1ZzF1lbweFIe4XXpVBZJ1iCOfuSufflSXD2WuZYGKIhLdOzCrFRy9wVnztgTPhHMuyDyZ5lrZzURimuqEH47z8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:KGQtaafXoWStQCi6YwjEHJtG7bbtJga08TYnVlEGl2nprGJEz-buRQ>
    <xmx:KGQtabFX_kqAiIEie0XgbvfHcYZnxo3o5-lDv8yNwmGT2vjX7B7zrA>
    <xmx:KGQtaYfd0dBqxvRYRHLhthTFnWts9AYuDdknvsyvsC7aaYp1C6Y1XA>
    <xmx:KGQtaVGmqS59u4Pe_vkB3DLW3kgoGfym_VnZlMDE_YlZQcYtKz9JbA>
    <xmx:KGQtaQfncrre_OnK25CGDNzQd-uknpLLv-wT75Pf7rERwbv1gYRSS4rG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 04:47:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d6c1df2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 09:47:18 +0000 (UTC)
Date: Mon, 1 Dec 2025 10:47:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 07/10] t1006: accommodate for symlink support in MSYS2
Message-ID: <aS1kI0AR8TLVkm07@pks.im>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
 <8a7c68b629f64a3fd8c08f54b5e8693f6568885c.1764440906.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a7c68b629f64a3fd8c08f54b5e8693f6568885c.1764440906.git.gitgitgadget@gmail.com>

On Sat, Nov 29, 2025 at 06:28:23PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 1f61b666a7..0eee3bb878 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -1048,18 +1048,28 @@ test_expect_success 'git cat-file --batch-check --follow-symlinks works for out-
>  	echo .. >>expect &&
>  	echo HEAD:dir/subdir/out-of-repo-link-dir | git cat-file --batch-check --follow-symlinks >actual &&
>  	test_cmp expect actual &&
> -	echo symlink 3 >expect &&
> -	echo ../ >>expect &&
> +	if test_have_prereq MINGW,SYMLINKS
> +	then
> +		test_write_lines "symlink 2" ..
> +	else
> +		test_write_lines "symlink 3" ../
> +	fi >expect &&
>  	echo HEAD:dir/subdir/out-of-repo-link-dir-trailing | git cat-file --batch-check --follow-symlinks >actual &&
>  	test_cmp expect actual
>  '

Okay.

>  test_expect_success 'git cat-file --batch-check --follow-symlinks works for symlinks with internal ..' '
> -	echo HEAD: | git cat-file --batch-check >expect &&
> -	echo HEAD:up-down | git cat-file --batch-check --follow-symlinks >actual &&
> -	test_cmp expect actual &&
> -	echo HEAD:up-down-trailing | git cat-file --batch-check --follow-symlinks >actual &&
> -	test_cmp expect actual &&
> +	if test_have_prereq !MINGW
> +	then
> +		# The `up-down` and `up-down-trailing` symlinks are normalized
> +		# in MSYS in `winsymlinks` mode and are therefore in a
> +		# different shape than Git expects them.
> +		echo HEAD: | git cat-file --batch-check >expect &&
> +		echo HEAD:up-down | git cat-file --batch-check --follow-symlinks >actual &&
> +		test_cmp expect actual &&
> +		echo HEAD:up-down-trailing | git cat-file --batch-check --follow-symlinks >actual &&
> +		test_cmp expect actual
> +	fi &&
>  	echo HEAD:up-down-file | git cat-file --batch-check --follow-symlinks >actual &&
>  	test_cmp found actual &&
>  	echo symlink 7 >expect &&

I'm not quite sure I follow, so my questions may be dumb. Does this mean
that git-cat-file(1) fails to follow the symlink in this case, and
consequently we cannot execute it at all? If so, is this a bug that
we'll eventually have to fix?

If this is something we can fix it could be sensible to have an `else`
branch that documents the failure case. In that case, we would then
notice that the test fails once we fix the underlying issue.

Patrick
