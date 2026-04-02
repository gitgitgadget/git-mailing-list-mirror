Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714ED309F19
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157876; cv=none; b=ddYxNNEpDFnhwiVm5JoDyj5z7Z5J/nfQtgy3V8UByT+sTrMJeWm3yworgzuGDaRsPAwvOczsSEpvk9BogS99ia1/apQbdj5Q1kgOlA5WZWYCyA4XhDpxEfcDd5YTs42KeH7ohFy515zA4QrweyXWloaacP1RbXL0wd+7kMkaxC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157876; c=relaxed/simple;
	bh=fqYH0NgJMSLeS1a6FlJGNpfA0g7fiO2xOxQpT/1UB8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U+Wdp+jr3jmyAJjYEtidgXf2l8CJ6B80MxCktegM5WPHUaM2KX8iuWpU/qrXHWZmq0+kbDaDhDcBLUn2fSXczyOQuMrWwdsIT4CJd1DE5SMYJUoIjku8o2TsQNSaReKrQ79gVbBZumtDqe2i1hAhbpJmqLeARqj50XEOcz16CKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JXjgDRxg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tRgpRemz; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JXjgDRxg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tRgpRemz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B45F21400250;
	Thu,  2 Apr 2026 15:24:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 02 Apr 2026 15:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775157874; x=1775244274; bh=l5RPNhEum5
	K7eO9pnMW78yM9YAP/3dDWBfSmefVeSHg=; b=JXjgDRxgv3/fHa4BE5i/i9E9NC
	tA1W8FcvIisbHgXjpktBdkerXKspe4V++JylRWBx8Pk2ll5Cc7jTMmpq482pupHN
	gZZIHeM4q9arUMQE5bNBzpwygtBlmCnrPPqVtzqGaBs50kaWm1VDny2EoEw9tCbO
	xw+RaqEnjr5Y74MfaL93bLGsQ1LZ6MSn7Sjl6kmmUvp3taL1zD/SCRwdOZhkJK9G
	v3dw3ytx45ODDqC5wXjog7g08gbGcYKU4+ft5yuGU87cPgEnK2T4WSlosvSorxu7
	qfNCw68nFYGzWChfvMOG2a8BPe3R2kbOa4ckpswWkDvVH8Lrm1iU+Br/KCSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775157874; x=1775244274; bh=l5RPNhEum5K7eO9pnMW78yM9YAP/3dDWBfS
	mefVeSHg=; b=tRgpRemzpZqove9EDTKdgYj1rQbUFY4zCI9LAkix7eTqAoCJlEL
	TLDcJhhrw2tLozLKh9ZhY5wReDvWYtVEX8DPiN7emX6pAqP0dabAXpDQ9vyq7ski
	XPMdXSRLIpb3W13P5w8I5IV0g4BImFohanqNev8UxSu8syvRmObFKOYRUlT2M6dB
	sVhxfBpQ4+wRmDEAYJfq4M4vPBk+QjAnRR7tpL+bZWCQOKkaIHxonxAfmOIGKjZX
	HyiOq85ZV7GG2NkZiOE9HG20N31JA0MrTdMqyShsovPaEPxPqAEJEuXqCL6VxzNJ
	neDbaSLvomHwyffIL54jjjwyuW/ZU/dwrDg==
X-ME-Sender: <xms:csLOaWfXo_k7S8JLLrkM4FxPWvfrxSHFfZ_jH1i2KlEE71WnCUnarg>
    <xme:csLOaXMBbMY26Pgxkk3zaUgipMHIvn8LvE12VE3Kt8DX1y1rDc_lGBovj8nI1SvQN
    8lX2d72RG0iZKOjJW5ABwQhL66zrYATw0RX6uBxBI_bLfqqyaettg>
X-ME-Received: <xmr:csLOacj9NwPQHZc5DhF8mqk6Qm9A1MCbf62OPJY_7D57nUdT-bBRF1ZQbGdCO7YOW9J0xuXouV6l5CSCub5BUZWqM7DQaM5Ldg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeikeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:csLOaS3MWOqgDUcY2U8tCojOCuVp3B3TArhk36SR8tAIjtTKsidnvw>
    <xmx:csLOaeiS_Hs5wjM71bAHc8W40M-2vWV1lX8czRWCB3xiKrZtQplogA>
    <xmx:csLOaadK_aKMFfbGl2VJCsBYo-5U_h5z1RputttCmPp9BSmmUyaK0g>
    <xmx:csLOaZnmySIssnr7dJrYqztpVqheRZlJ_iMMLi351mO8kYN7BJB6Cw>
    <xmx:csLOaQAuz2nCNG8EGqH_lauqefeVFORxK95RDFQTGOrS83foRBDwoOOT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 15:24:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 3/4] xprepare: simplify error handling
In-Reply-To: <cdcad99edc403a9e0d1d21592fa295477282421c.1775141855.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 2 Apr 2026 15:57:43 +0100")
References: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
	<cdcad99edc403a9e0d1d21592fa295477282421c.1775141855.git.phillip.wood@dunelm.org.uk>
Date: Thu, 02 Apr 2026 12:24:33 -0700
Message-ID: <xmqqpl4hp3m6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If either of the two allocations fail we want to take the same action
> so use a single if statement. This saves a few lines and makes it
> easier for the next commit to add a couple more allocations.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  xdiff/xprepare.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index f8e6a6d74d5..cf4ac34f047 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -282,11 +282,8 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  	 * Create temporary arrays that will help us decide if
>  	 * changed[i] should remain false, or become true.
>  	 */
> -	if (!XDL_CALLOC_ARRAY(action1, len1)) {
> -		ret = -1;
> -		goto cleanup;
> -	}
> -	if (!XDL_CALLOC_ARRAY(action2, len2)) {
> +	if (!XDL_CALLOC_ARRAY(action1, len1) ||
> +	    !XDL_CALLOC_ARRAY(action2, len2)) {
>  		ret = -1;
>  		goto cleanup;
>  	}

If the original were "after successfully allocating action1[], if
allocation of action2[] fails, then release action1[] before
returning -1", written in place, it would have been a different
story, but the "cleanup:" label is left to free each and every
resources the code obtains in this function, so this consolidation
does make sense.

