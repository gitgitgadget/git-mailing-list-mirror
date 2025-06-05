Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BC179A3
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749137348; cv=none; b=Kf3OZFXiuRC2dYlvTuUHoqMqhz8BObzRKTZQO1znfTSZlo9RAX7wATDeM+goeJ32Yh4oIVgA40lEF/HyUUrvO0tyT6k4UnpNg/5UbqYU2DpFe1xaRIcmXQ4X8Mpvlnl2JchD/0J8px37V3V5BkwBJ6VE9RLUY3QdNR3d/P0Nj7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749137348; c=relaxed/simple;
	bh=NvjXwYMTrEcIZIjyn02VLQIgyuHHxlvYFVdPVEMiAV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fVb1GSQioPtPaAgoWm9LQ8wGdKfz01kUF+ksv4nEKbtjPua2R3e87nwHKkc2GtANno2s/ucgj936Ap0Gyxx1VpfqmL68AtBKXLDkgIxRSXoErgUr4wqLneYmjE9OrxF8hjzoG5dNv9qS1iP407GwvaIGBE0+2MTy0u59Gk5Z9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DinO/ZIk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h/ZhnEem; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DinO/ZIk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h/ZhnEem"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7ADE92540110;
	Thu,  5 Jun 2025 11:29:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 05 Jun 2025 11:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749137344; x=1749223744; bh=s5zdti1Rt5
	9/TeBNY3wjzHZ68abVsfRHCUhW1LJ87BE=; b=DinO/ZIksrwNEIukI7vvIBdxA1
	N9+vYAU+t1qzxROQC9GxeUENwfjtwDStJi93R7w0JG3kxEqphyWtN9xg8wDZ/c0n
	rDyp4pSlseGNrEAwq5yyA078kli7HDMi1KJMOfSDYQLip77GSmm1OV4x/hDtUph3
	QLT1/95Y6DVLAt1HUysTS+sMCPo5bkZmF/jEqr0nnct08Xb0LtxHdvmGbiGzyhB5
	gM7QAmzJA/um6EXfM583hMQ00VMHIuGohZs58VlMV3izutgFnOc7M4HfvagOOlQu
	huwJN2oJc3fANoECgz/Am2p8iAPfZL1f9cN1jn9w9dXRIRe9acEsEAzq9uHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749137344; x=1749223744; bh=s5zdti1Rt59/TeBNY3wjzHZ68abVsfRHCUh
	W1LJ87BE=; b=h/ZhnEemeZpDSMxlDjkSiFKCrz1SHNz/QpZgIH+BR9HIGTAhthX
	ARtbzbq4CBHWCgEB63ZbgDcwvSM4XNp9jk5WHzOYakF2egq1PclKb/hh1LEOXZ8Y
	xPiVIoI1mmj21XMAcIugBfLQyyvX9Y4kb27bd7/8zWwWIeAW4nl9WtQpRs7TSqe0
	kI6jQzS2MIZEtgMqYnAiI9HR3lSC7cp8R4B3156k6pkMw1Cb5M40gA6+HYvq2nnO
	xI2kcJ9XWrZXglOmF5+Jd1cOkHXd6D/u6chwbYiQMHfYu5hfZ6QpIf2E05bugMD3
	XbRq3NkHXv2+0ZIyWJjcAESUq06KD9hKMLg==
X-ME-Sender: <xms:v7dBaG5jUThrfBRHpFMG6ucOhYoVQVv6MOYcy_FRDaO9RkYlGNaJ4w>
    <xme:v7dBaP5FWm_VniKMgR9yiyeUtj-dFugCniH-0hOukbXXPMVjIYKOfTgfcN1kanMCn
    qfzG7yMQeFFACqPDQ>
X-ME-Received: <xmr:v7dBaFdZ2kUHcv6H6lMlUyXutvzhVHz0Iz7UfJmdZyUPiPKsf92RZJlihYTZpSoKSRgQoRjnzqNssp407lNTsltv0STCixfaNdzj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjh
    hurdgvughurdgtnhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:v7dBaDKgU_2poiGeYpmIWY9vUyL9QPbb7KUXUFtaR2GuXEj006UdpA>
    <xmx:v7dBaKLl40TvYLA4aUL3N6FsZkxxWltvWL5INgm6p_3-PUQzLeg8dw>
    <xmx:v7dBaEzulsNjqJgs-S-wxU7DNqa-BPoWZNP0rWP5mSizHds1ZZjh8w>
    <xmx:v7dBaOJPCeotL4M9EBepIROfhhtdIvPL5pmaouC61-VnYxfQ1Q--nw>
    <xmx:wLdBaKdbztsHczXlRkXDyM_bKR_ibhGHdoEQaIJ-FKLUlcFPf7zLWKPU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 11:29:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Taylor Blau <me@ttaylorr.com>,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v5] pack-bitmap: remove checks before bitmap_free
In-Reply-To: <pull.1977.v5.git.git.1749104667618.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Thu, 05 Jun 2025 06:24:27
	+0000")
References: <pull.1977.v4.git.git.1748931650166.gitgitgadget@gmail.com>
	<pull.1977.v5.git.git.1749104667618.gitgitgadget@gmail.com>
Date: Thu, 05 Jun 2025 08:29:01 -0700
Message-ID: <xmqqldq69phe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>
> In pack-bitmap.c:find_boundary_objects(), the roots_bitmap is only freed
> if cascade_pseudo_merges_1() fails. Since cascade_pseudo_merges_1() only
> use roots_bitmap as a mutable reference but not takes roots_bitmap's
> ownership. Once cascade_pseudo_merges_1 succeed(), roots_bitmap leaks.

"Once cascade_pseudo_merges_1() succeeds", perhaps?

> And this leak currently lacks a dedicated test to detect it.
>
> To fix this leak, remove if cascade_pseudo_merges_1() succeed check and
> always calling bitmap_free(roots_bitmap);
>
> To trigger this leak, we need roots_bitmap contains at least one pseudo
> merge.

"contains" -> "that contains"?

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index ac6d62b980c..8727f316de9 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1363,8 +1363,8 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
>  			bitmap_set(roots_bitmap, pos);
>  		}
>  
> -		if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
> -			bitmap_free(roots_bitmap);
> +		cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap);
> +		bitmap_free(roots_bitmap);

This makes it as if the original _wanted_ to leak it when the call
failed.  Readers may wonder how we got into this state in the first
place.  Was it a simple thinko when 11d45a6e (pack-bitmap.c: use
pseudo-merges during traversal, 2024-05-23) was written, I have to
wonder.

> diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
> index 56674db562f..ba5ae6a00c9 100755
> --- a/t/t5333-pseudo-merge-bitmaps.sh
> +++ b/t/t5333-pseudo-merge-bitmaps.sh
> @@ -445,4 +445,21 @@ test_expect_success 'pseudo-merge closure' '
>  	)
>  '
>  
> +test_expect_success 'use pseudo-merge in boundary traversal' '
> +	git init pseudo-merge-boundary-traversal &&
> +	(
> +		cd pseudo-merge-boundary-traversal &&
> +
> +		git config bitmapPseudoMerge.test.pattern refs/ &&
> +		git config pack.useBitmapBoundaryTraversal true &&

Yup, this is a temporary repository for only this test, so using
"git config" there makes it the simplest and the easiest to
understand.

> +		test_commit A &&
> +		git repack -adb &&
> +		test_commit B &&
> +
> +		nr=$(git rev-list --count --use-bitmap-index HEAD~1..HEAD) &&
> +		test 1 -eq "$nr"
> +	)
> +'
> +
>  test_done
>
> base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
