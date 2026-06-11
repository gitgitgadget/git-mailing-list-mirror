Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7113B2AA
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196396; cv=none; b=cJF74Koy6eVoH0uEErfZUFGgs8mn40g14L98hS9mz8d3j4lR053CBpnAsXlCxcRzpcJyhs/oUmZpUzJOypTYNhnyNR3+RWyMlmlHTrCUB9sgXDQCKudinZ/gVVi3vIP+EA5xnuRplcOLrxc1VM1o+pp4hvvxAmaKP5LjxwSjlbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196396; c=relaxed/simple;
	bh=4LhrRR1+vYlaFUvvjmDHmgWrSY9TUHQ7qx6BGl7N/bs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B+07I6Nx8Zr3vJZj27AzgN4gNh99tLvXudz/9Y4ccFmKXmSqSqDYvi6g3fUdDVBQK3kASBtAjoB+TEqJnv1JIe1+ZeSUGbB6T8jreQhCMaXowx0CB7zKYevTzd7ge9iTFXlr2bQCpJiV3qgPwQ7zONzFuMGCNQX25Q6r3v2ftzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ps7z6BYf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TACammOZ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ps7z6BYf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TACammOZ"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5299F1400106;
	Thu, 11 Jun 2026 12:46:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 11 Jun 2026 12:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781196394; x=1781282794; bh=A+aMGPcLhv
	KUqQO29BqwLuD5vPr83pSsa6+NCS5OUC8=; b=Ps7z6BYfZmF24NV4Nwsyf9kA9u
	eEg8+rOP+PCu9iTgspytjW4BvhuA2Z6onOVjY4j8U/fcXgS8kzTC/AuukgEnEmFo
	Tl+1Pj9h03RsJTYQKfeWZ+SnRMHEnKRjcfom6l0GLATQ4MaeYfv0V7ckMasn7fRc
	lotD/FYyEvmm3QOBRcykI9oCmMxgGeXFmApFBZIpF4JaU4wm9rdAUAsAqS77sH2v
	/VJaEHE9cuncRFrVH52PZFaLFUL0vp6znUlibLzcTIVFh2r4A/UpJ3VdPKGErrCx
	CipNIg9XBP4eKUzzZCnZA2HTB2maCPt+usDKz8J4eaICbr4B0cwobUyJHGLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781196394; x=1781282794; bh=A+aMGPcLhvKUqQO29BqwLuD5vPr83pSsa6+
	NCS5OUC8=; b=TACammOZtNOCavn2sIIgL6EvOh1/4fo4waUAnxbfZTvVDqAKv+G
	GHo31E548Z5P8N8Y4S9ryFUFzjmVPceisxS/eQa5UMEhaSlR/1dWa5JlXNSsF01m
	t37/Re8huJmZkXFkWNnWYuStEhpnQdY/SAIUVF4BqablNHItB5nfE1fuKO3fbpAW
	Ox9kgEerUO29qJmIL8Dm8sG2womyeYhjktdremo2qITHzH0Khc7JLW5ovgXwOF8O
	i/rkd4d37PEIM1uRyuz7TMM7NSZa7SDEyP6gSdN3SvpQfrQ8XDc4zZhOXnhFcX1p
	IsUGADp2xSsBUN5pwRN/xWDqGjLe0yU2XsA==
X-ME-Sender: <xms:auYqauzNREaq1tXKKNH__MHaTtvyJSHBLExH7b6MGLg81S5J6pB1Pg>
    <xme:auYqahR2DJ1dTUut7TbSSeF2SPkcDzuwX41Wj_9s0MLiG8FyDoJgRKC0KobkDCBmb
    1nCyRi75FbtXQSaH8bMDFEo6SUQ2oG6NYwEhsNgf_lN6ejbTo0-ug>
X-ME-Received: <xmr:auYqalVMvrDqn8mJk-rCTgI-El0BKuDm2UwbNIo_VymglC1NvaDtdPG-qP192c2TRM8L5DvPip40aU_jkglz2pOCiAhsRLZ3dHOS>
X-ME-Proxy-Cause: dmFkZTFByD1VLIfY7mov0wN3C95Lha05UdiZskl+DVzy4qzyHxb+8xQe82SU2qF8r1zShR
    fgaFn5RS9HvmLSt1l1w74Ku48keHEPxN/MyYIKYo+wVEqsBnoqibie9cwfua+b3V/aI/1v
    StmJzDI4mOvosOuF8lynIGmO3cgwG8h5jKDqnqktQxkIpf2cdQrPaBrsANUh7RpXdgjW07
    XIwesw3O8XU/e8UQR91I63bv0kjKXv2uyL4z1iLT1JIdyqKaTslYTPi8D9mDL4B27Y7Gzj
    nRD1ji2aP3XyhQsm+yyXX+ftChS3l08omyk1BI0ZZcAykFni+Dd53aa+iBeWOTNsQpW5S0
    Puz0fmy9Nhik9TBpF+8nu82xaawBT9nMoeZVbCIfFOYyiRskhN4WaXRraPKXwfD/REQrof
    8XbH+2pxN1qjjTxUAwqmSw5ouTDylAnwLfrGWd/H9TFyF0ss6hq2HUXnnaElxUvbmOc1ty
    mBjiDED3ZfBpFAmog+glbyaMob4hAqtHJgZ4WEGJheXgsyBP1GKuo/rXKjFBGJMIsPTL1j
    D/E9kdL0Ndv2l9i2JVBIdeTViFKH325Ad9sFDtxGY4Wp6celPbz/yz7HRdI+8EL7SpBfgo
    M+eKm8Tk3VzqG5Rf/BIMuLMm4qhNFxTWhsqL4rGn4hOqMxdW1JgjMnZUDhwg
X-ME-Proxy: <xmx:auYqajbsFie0sC9rF92JxYIHk3EBfxJJtNWQsTdBD8M1WQyO3SMHPg>
    <xmx:auYqar1MBICGgYE2-QcYgFF2KwqRuUdP8EVQOPM1QFT-4XlvnVYJ9w>
    <xmx:auYqaljImFFIi1NQgcrSBB1zE8gEdnZV31ZHCfu6ZCYzuX-F7ltonA>
    <xmx:auYqavZwF4veh--BRv6qq-YUbiOgp66PudLrk0vbfxjH2ShdzC4Y7g>
    <xmx:auYqaj-PaUiL2JfXbA_hhnMc6UZGG6oZXYZRDnxzo2Vr9SvnJLR2mVAr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 12:46:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 3/6] SubmittingPatches: discourage common Linux trailers
In-Reply-To: <discourage_Linux.8f6@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 11 Jun 2026
	00:22:46 +0200")
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
	<discourage_Linux.8f6@msgid.xyz>
Date: Thu, 11 Jun 2026 09:46:32 -0700
Message-ID: <xmqqwlw5nhxz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> This project does regularly mention what commits a patch/commit fixes,
> but that is done inline in the commit message proper (c.f. the trailer
> block of the message).

"cf."?

> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ [2]

;-)

> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/SubmittingPatches | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 51c308a89a8..5dc32128883 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -479,6 +479,10 @@ to be accepted since these are the most common ones. But another kind of
>  trailer might be relevant, for example to link to an issue tracker
>  belonging to a downstream project that is affected by a bug in Git.
>  
> +Other projects might regularly refer to other kinds of data, like
> +`Fixes:` and `Link:` in the Linux Kernel project, but these ones in
> +particular are not used in this project.
> +
>  Only capitalize the very first letter of the trailer, i.e. favor
>  "Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
