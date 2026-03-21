Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865653C07A
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774117625; cv=none; b=CuWKKWM5HN12vgpn52IZF/iGMmvguRy+BnQzLjmH6IWWHH18OLHEf3fEK69tdwa6y6oNpY264HnmheKx7x8S8BK0ZS5uL2aiSFeNwq4xPq2XoBhyxkUr7gs+mV1Vr2Ft523qIdjxS0rKjODvU5/1fSdCE4JQylZRbklpTIwZEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774117625; c=relaxed/simple;
	bh=Zl1pgBaDwQJj3VKDXSV5XtW6hD28gCvLyt7pOvCChM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VAsCdalRrpdzbjURx5h7kBiCoeVvQeEuEvAofVH1Netg+M+HD91mXgcKvNl7pSkQZPEW3d21AjjaSp9WM5Y6ZtK8voy7kaLmFCIBzz8k7qxeZhBUoqS5YPwnNt5tNDzdKN9H38h4ZBWsRij1FxJSU7TTXv4GYSgYCsE/d3Hd/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UwDyFB7J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SaNXkfHj; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UwDyFB7J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SaNXkfHj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 606291D00035;
	Sat, 21 Mar 2026 14:27:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 21 Mar 2026 14:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774117622;
	 x=1774204022; bh=j+ibsF7PHfh9i5LG8RboyCDJa4x7cYDfYe7bca4P0Dw=; b=
	UwDyFB7JxYLOWr9Ag1XMjtQuU4HMTD+jgvvCvsQnqxz/IgUC0zXGGZ6f5EXz8KFk
	bmxh3r9kHzewPXMmdRRX3bHIJCLYhQzBCynBRkFLgupeQuNl7bNMc0jvuGlw8sVT
	Rg/8nfzSX1Tmnv5o/cL+MccJtZ6X01PKS662nmEp7ldOKL44qWqrSR6p4EXXGz2k
	WVdr4fIfmyq6mDfx7CPh34iVSp1aw8ZLLQ8EDtf6F0FhPvAzKVRL5Xq/aDwMyJ5M
	Bps0qRvAEy65GRAbJq/2yFkGzoZjkCif9dWY32IOxnhpdkMVDbV0P+T7LunbE/5H
	fiuLdRMoBJJ2aum4lkE2Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774117622; x=
	1774204022; bh=j+ibsF7PHfh9i5LG8RboyCDJa4x7cYDfYe7bca4P0Dw=; b=S
	aNXkfHjp/qGtFYPtGgqm5MJxkRDZxHRvhgqlgYYIE5PjOGGogCFKcE51KESMd2ie
	10JIc58+wlyHL2CuzeEvucR0JnRmcLzi9RjupvLIDuUN/r9wzizHpBwsQtTaLHCK
	R7xQbz32pq5H/FtZUcsrpFEVyYCioVyanwvV77vi7ibccmUYc6qf8wjRKXhKOLrX
	TXJGxH9d0dxc4++GsVPq6SLYLEJa4syuxr/QPKehUBChLz8wV6RmHOHSaoT8yXaD
	hEBi+Ajg+sulRlYMCP73BReq8iLThiLju2bsw/YNiFFF2NReS0hi+q0JiJsnKhhZ
	OPQPR1Jp132Dvc1BfAHkg==
X-ME-Sender: <xms:9eK-aT2SFmx8ZQLU6XS3VCGdRMnsl34CWktwvpPhN7PO4UX-v5I-pA>
    <xme:9eK-aVxTrPr02TLSbDXmj1Z31gwMr0fgOQ2sOvZ5hhytlN2pq2wy_tWJz7679-ODi
    12Ev_OT6JwX4xb8fTZmRkS3laOn8fmAKy0WuG4J_4SHJYZ945ZT3A>
X-ME-Received: <xmr:9eK-aduA13ecnmErLownfx9PMiI8xvBkO-TKqM73KqUaMscHzXsjOeeh_NDwU5lyeDBhAj-jIrlfIhlKE3Wog1Ha3qZOsCU5Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudefheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhrghgrughssehgmh
    grihhlrdgtohhmpdhrtghpthhtohepohhrghgrugdrshhhrghnvghhsegruhguihhotgho
    uggvshdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9eK-afwOWDzh-ideBEJv5r2bv9cOaxYiYquWew6b6zVY21d0tkdP2Q>
    <xmx:9eK-aYCYuo2VrOao4bkPOmpBr2IvEzXkT-NGG2C5lomULTT9zjQfpA>
    <xmx:9eK-aVcNpiKq9octskdhi4f1Ciy0hI9EdvaTHGtaVx_UU4uJ1Gk7Lg>
    <xmx:9eK-aalO7LwUSvaKM4yaCknp6uGliBKRc-6U31NHWz3Zj_9lpHy_0Q>
    <xmx:9uK-aYqqIFSYD_sD9ndSU5kYRIm-kwyZd4S50kne0bLWCwsW8wVSHluB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 14:27:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
  Orgad Shaneh <orgads@gmail.com>,
  Orgad Shaneh <orgad.shaneh@audiocodes.com>
Subject: Re: [PATCH 2/2] fetch: clobber existing tags with --prune-tags
In-Reply-To: <b444fa7af9f39960652209143c9845a47efd58e1.1771187016.git.gitgitgadget@gmail.com>
	(Orgad Shaneh via GitGitGadget's message of "Sun, 15 Feb 2026 20:23:36
	+0000")
References: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
	<b444fa7af9f39960652209143c9845a47efd58e1.1771187016.git.gitgitgadget@gmail.com>
Date: Sat, 21 Mar 2026 11:26:59 -0700
Message-ID: <xmqq1phdavik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Orgad Shaneh <orgad.shaneh@audiocodes.com>
>
> This was documented but not implemented.

And instead what did the command do / how did the command behave?

It also is curious when it was "broken".  It could be that it was
broken from day one when 97716d21 (fetch: add a --prune-tags option
and fetch.pruneTags config, 2018-02-09) was written, c1a7902f (Merge
branch 'ab/fetch-prune', 2018-03-06) merged it, and Git 2.17 was
shipped with it, but knowing Ævar (by the way where is he these
days???), I somehow doubt it.

And unless it was broken from day one, we must find out if the
change in behaviour was deliberate, in which case it would be the
doucmentation and not the implementation that needs fixing.

> In the flag description:
> prune local tags no longer on remote *and clobber changed tags*
>
> In the documentation:
> ... to prune local tags that don't exist on the remote, *and
> force-update those tags that differ*.
> ...
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 31df7faf56..4d29043baf 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1092,7 +1092,7 @@ test_force_fetch_tag () {
>  	tag_type_description=$1
>  	tag_args=$2
>  
> -	test_expect_success "fetch will not clobber an existing $tag_type_description without --force" "
> +	test_expect_success "fetch will not clobber an existing $tag_type_description without --force or --prune-tags" "
>  		mk_test testrepo heads/main &&
>  		mk_child testrepo child1 &&
>  		mk_child testrepo child2 &&
> @@ -1108,7 +1108,13 @@ test_force_fetch_tag () {
>  			git -C ../child1 fetch origin '+refs/tags/*:refs/tags/*' &&
>  			git tag $tag_args testTag HEAD^ &&
>  			test_must_fail git -C ../child1 fetch origin tag testTag &&
> -			git -C ../child1 fetch --force origin tag testTag
> +			git -C ../child1 fetch --force origin tag testTag &&
> +			git tag $tag_args testTag HEAD &&
> +			test_must_fail git -C ../child1 fetch origin tag testTag &&
> +			git -C ../child1 fetch --prune-tags origin tag testTag &&
> +			git tag $tag_args testTag HEAD^ &&
> +			test_must_fail git -C ../child1 fetch origin tag testTag &&
> +			git -C ../child1 -c fetch.prunetags=true fetch origin tag testTag
>  		)
>  	"
>  }

None of the steps we see in the added test do not seem to check that
--prune-tags does clobber existing tag that no longer exists on the
other side.  It only checks the "git fetch" command exits with
status 0, but does not see if the tag actually went away after the
operation is done.

