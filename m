Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B435CBA1
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762899804; cv=none; b=id3KK4lvcvsuTf8Drs6+GJG6nOr8SjM20L2zhNoK1sKBCXGBTAU0kYvAzKyDpa/5aeHZufz3kON5TsnSv1BW8Dbs96ZqTkrro4yz1wWQrXjhhEf1+7+Bj5EwD5DFI1mkkrcq/TiYcMCpiuflL0k+xwqcZZK+L4sjNa1aTd12/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762899804; c=relaxed/simple;
	bh=yp55CMPVeen2Y+VdorymhjRECaZi7OEEPj7Mqcq11YE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kG2efjEAx7x9ns/3NDiIvoWW1yDFuRHO1tgovTAORXwHE6Yb9oZ3kNFCmoKCtElEhUX8uI7YMbLDnxS12dnnlt2ShNAG9Yg+B1cJwsxlOBXuwKVSsL7t9OIB7GslRpXQB1VxIdA/6rXjReKQEqR2iTF7K1zy8zSQ09zGPtUy5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l4+R0PrL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zDcMeReB; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l4+R0PrL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zDcMeReB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0BE6A1D0016F;
	Tue, 11 Nov 2025 17:23:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 17:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762899800; x=1762986200; bh=tuAVVtkTsy
	xhicqpXTqSlollp4/z/mFttgaN9+bRDUc=; b=l4+R0PrLlkZQSuns2uEod9Fd3b
	MvDNvRkaBnAJ3SpyMKSz/BEvq18zFwGdfj+wqL/m6YXM/vyacmQy8GobLjDJ4Ti5
	a/5I6FNkHDFWKWlzuKLRfwdOA+UEMWkXziaM/dezcfrhCcijuGSW5VmQZADVM28Y
	7RaYO7uN78zLwC3fUYsYQA4XYOahH1PkJ3xVBW+B+Zi3FldrwLSNNHG6swRa3V/J
	c6AG42iuzFBIRMExPCvGN/Rxk2ZpVwJwinF8plqd+qnQzbDz3E7Dh8CImx4toiZi
	Y1fpyqBCswyKeqnBb2gKjAYOQvg8qGpH/whBz5XBohSSY0RzzMZukM4uSZYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762899800; x=1762986200; bh=tuAVVtkTsyxhicqpXTqSlollp4/z/mFttga
	N9+bRDUc=; b=zDcMeReBhpcA7Y2+uA9Nz+Q2sJz4gXoGwR48I4ObiMSDDGNVRvu
	CiQ6AjskrRWqxvQn+HBP217UKq20p6ziIsUl3OqUfPm0B4pDBcAzs7prv+ObsmgV
	iBFMaxWT1SqZTMuqyQdxY8X4y3eOZyG59Lm4oAvvHbULKFo3ft2nXSupRVubUtP6
	xLbNhapwqGqWZB3HP4htPbQOizkZDieqGOam1oRLMdQs9c6twleVGgY4IJ/lJmdA
	m+2q9flroQSIiWUD9x5Duz3DoLUBIHE1mALiUo/GoZoeR3Hmj+Sm1MBYbIEtr5sY
	K4f14/e2JMAv0PSamfQZrX5R6NLxe13XBTA==
X-ME-Sender: <xms:WLcTaYiMuK3-vOOInIm2jD6prdG8H5YaG8T5hrN4vumD01QFQTMgeg>
    <xme:WLcTad_DwtYD2Eo94bAFc6U9XGBhJOTf0NBWnXapx2zB3AZNfTMHvB0-SlX4Sf0k5
    oUZDnWzPtjoY3vf6lEUluxm_aYn_H8JTGTPcEsVBSo78HU6kTp4Tg>
X-ME-Received: <xmr:WLcTabvdZNXJC30HGWLKr-LVZBTJDZhxUVbXlLbrLjvn3C5bw8GerOlya-PRsqmnCJOFJI5kg_TZP2tVgcARDPSj6Xb7emYSo97f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WLcTaRr5yjVwuuBa4lGz19ytOQefIEikskXcGQEjm65_U-1Gl7jEdA>
    <xmx:WLcTafpp6VNaFXJOb7zxTexGYa5z3V5N6tGzzdHaiiu2kgRfuSx_9g>
    <xmx:WLcTaQYM1HChBPoiypa11WVS4Wn-nlqzQhfgvbmsrF1m10lqaOAlSw>
    <xmx:WLcTad9iUgkFxtJcbDx_LDSrwMiUBnUyEiVKYUVurMxCkEbRGjgAkw>
    <xmx:WLcTaYQiB0UTOBmSEvWQRUGJ4CIkHG2fMW-2Pfs8RzixrSd9XeJbPcoZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 17:23:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 02/10] xdiff: use ptrdiff_t for dstart/dend
In-Reply-To: <52e3f589b1ce25085921453eea14b9c9d7c8f362.1762890152.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Tue, 11 Nov 2025
	19:42:24 +0000")
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<52e3f589b1ce25085921453eea14b9c9d7c8f362.1762890152.git.gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 14:23:19 -0800
Message-ID: <xmqqms4sus2w.fsf@gitster.g>
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
> ptrdiff_t is appropriate for dstart and dend because they both describe
> positive or negative offsets relative to a pointer.

Makes sense.

> A future patch will move these fields to a different struct. Moving
> them to the end of xdfile_t now, means the field order of xdfile_t will
> be disturbed less.

If these members will be gone from this struct, it wouldn't make any
difference in the end.  I am not sure what you mean by "disturbed
less".  Right now there is a gap between changed and nrec members,
and at some later point, these two members may be adjacent with each
other.  I do not think it would make that much difference if they
become adjacent after this step [02/10], after step [10/10], or in a
separate series (xdiff-cleanup-3?).

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xtypes.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index f145abba3e..7c8c057bca 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -47,10 +47,10 @@ typedef struct s_xrecord {
>  typedef struct s_xdfile {
>  	xrecord_t *recs;
>  	long nrec;
> -	long dstart, dend;
>  	bool *changed;
>  	long *rindex;
>  	long nreff;
> +	ptrdiff_t dstart, dend;
>  } xdfile_t;
>  
>  typedef struct s_xdfenv {
