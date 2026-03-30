Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7018FDDE
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911757; cv=none; b=Sv1E2McgA/hw5u1bEZ0tFMG5TPn+3fGXwKwdgGLKTWQ3juY0D/4bIi33dTfY1DjzgSH/Ue5zi6GG2IJNSgmi3iu2cbOqvytydLnkuezb1Z+HoMwi9mjUPUjSROHJTW5WUUwDUrlTdpoZ6L1EDEsp9YgJR/ZUU48vR47yyG0P5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911757; c=relaxed/simple;
	bh=ArIao1oq//wxuiKxVxw1+yUIAeGVdra4xUN9wkiwR2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jTnTR9Ls+rkIunwPWJFfhcdgHmQ7B4+pIeil/JcoNPlAIzVM3Y7K/unpZGEjbQFvg3de0u8hTIoAMVVvCGjmJuesWRZXB+KfVH4fVuN2EIypJsI+wBMIh3iepzt3e/C8qruOKhfWc5LqsSOJigCO0JEREphMgByRisEyfHk1nW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dxxbeVCh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s3uKf2Be; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dxxbeVCh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s3uKf2Be"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 4F06DEC01F7;
	Mon, 30 Mar 2026 19:02:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 30 Mar 2026 19:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774911755; x=1774998155; bh=pKoR1nwyzS
	B2hTaa907TsQ87rtdG567R7cP/2ad6HFc=; b=dxxbeVChS9PMhveha2GD7MApIM
	x5PGLJTdjvipWgP/PblIWDvseBp/CrBp6u/UDwlb4dvfWOAKN0Du8/uwwsrMjIAo
	2P6tgK+TqTxqI9mb44crFBNESri2D/r/rpqrvxYWFYkjD/lIMZx+Xrvd2gqtQIAO
	X8/SiQy3JlL42FH6LCz8Z4CRkv+HHnwjtlaWS1h1sPyE1dKEp9eYnopKiMjzwWym
	m/Tfcb8rlv2BInu+JvHjNFDGA7AieqZw/ndtYY6cgYE9kTjBxyl1DUH/7M+sGFUO
	cO3Hv/TVTPVSkiwbyeipE4DjwWaUSyzb0ASCAIKGDsyjxso59oxT+Lu+4AVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774911755; x=1774998155; bh=pKoR1nwyzSB2hTaa907TsQ87rtdG567R7cP
	/2ad6HFc=; b=s3uKf2Beng8G/AmSHIxOEqSC/8/65kNhOka9DYDFGSlg4GBfHV4
	Ml21cHnMOwe+aYZZdPiKKYtUmMPYLZuuwqMCaasBWKtLk8Fjg7ubMQokLjRDVvVK
	0f9WDc3nsKTSTQbAISk9Zt6x63yP/2DTJgbb7TyasFweZGVPczQXapImELj7QspC
	TBUW9kxNHfliybz/jwo8mda8W8X6mwFDQanoBC4xwSZkBS7OSInackX80k6yv0V0
	jANs6FgmPBTtzECPQ6SZfMhj8fq/cnTy7BibmUtNNf2txYbL4efoE7LU4AJl0gNq
	BL6LDBrlddvOpe7XBV2XqwC8+hDzpIjQ0RQ==
X-ME-Sender: <xms:CwHLaf9GS7NiBmRbRrgHuWuzoU2fTMjnlpwlKb8LKlas0LfF2So0OA>
    <xme:CwHLaYkpCBWvalH_G4H0XBzFslNt1LmoX39EUe3GerqZvK5MOBrNqtl7aLXGtqCHM
    9EUzaep2Qq1tGDqyLqA5rtB0QYpNuFBrnq1YY_zEUVtoo2IKnzkRQ>
X-ME-Received: <xmr:CwHLacx6o2-NRnEBGXXTXAL2h6wOeRDoWyRNXzHTUkB6ijRkaHZ3fY06IY2Yy_eamtg3WwDwxOOfVJ5Hq4yT2GGX-XeYnx0sqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peihtghhihhnrdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:CwHLaa7AfgZjMX072THUg5S0u6rw2ElpwNjZ8Pez9N05SMbyKCcasg>
    <xmx:CwHLaUUUHjuhswJRfr6nDko6kzS0IYN43-7R2oGO-vlmG_Q2W7KdSw>
    <xmx:CwHLaaKbp4CV_jJRj1NLqd6ughbz7EghPOJFwhFrv7b9dQyiTLIUMw>
    <xmx:CwHLaeu2VMrcpIbnOad8KdU80pSLFSuspGPdwX4nSLPQPJG8_qARyQ>
    <xmx:CwHLaYCLqecgSfrPp8Th1EkbkBTTlVs8lWgaIp-xo7F5oGpX9_94_D22>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 19:02:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Jeff King
 <peff@peff.net>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH v4 5/6] xdiff/xdl_cleanup_records: make setting action
 easier to follow
In-Reply-To: <0cf1412d01cc4895aa945b6f3ead3b2d79716523.1774890003.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Mon, 30 Mar 2026
	17:00:02 +0000")
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
	<0cf1412d01cc4895aa945b6f3ead3b2d79716523.1774890003.git.gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 16:02:33 -0700
Message-ID: <xmqqy0j86hva.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> Rewrite nested ternaries with a clear if/else ladder for
> action1/action2 to improve readability while preserving
> behavior.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xprepare.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Oh, I love this kind of rewrite that makes it more trivial to follwo
what the code is doing.  Looking good.

> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index bd8baf214d..471d9567c9 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -303,14 +303,24 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
>  		rcrec = cf->rcrecs[mph1];
>  		nm = rcrec ? rcrec->len2 : 0;
> -		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
> +		if (nm == 0)
> +			action1[i] = DISCARD;
> +		else if (nm < mlim1)
> +			action1[i] = KEEP;
> +		else /* nm >= mlim1 */
> +			action1[i] = INVESTIGATE;
>  	}
>  
>  	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
>  		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
>  		rcrec = cf->rcrecs[mph2];
>  		nm = rcrec ? rcrec->len1 : 0;
> -		action2[i] = (nm == 0) ? DISCARD: nm >= mlim2 ? INVESTIGATE: KEEP;
> +		if (nm == 0)
> +			action2[i] = DISCARD;
> +		else if (nm < mlim2)
> +			action2[i] = KEEP;
> +		else /* nm >= mlim2 */
> +			action2[i] = INVESTIGATE;
>  	}
>  
>  	/*
