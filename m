Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F323EFD1A
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159085; cv=none; b=GMki4ZdfXUKqTP4Gs8y+jXPK6HhSgxI70gKdM8tWpj9nGa8LIkG401OXs6bnuyBXIq5CwTyI9DM+VWKm3wdIeRMuNJwnLE8xBz1nxPu4SCIxosen9zs2kousWymH4x7LtmRvceZ1aISBj0HMCIEVVdlXKPoggGjrPzTMFW2OeXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159085; c=relaxed/simple;
	bh=FqwHxa6X4A52nphmgSCwKn9jxAMZzi5tOIDGhL7ftjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gu20S8sR+kiT9j00tRH6QiUKvfeaiiPwsbHrx0ulupsaYF0tB7gnHfoOw6rk9CSgUlsIImkVUfsoNx4zsWGw08YA1Pn0XC9ga2VIyu7fwG+2PvebnmG/V2rllB4YQII54+OpIUBNu8wxxNWT+0IPqqXbiPj1rtGJK7hd+4YA55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hufyphZH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8OdQ2SO; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hufyphZH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8OdQ2SO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 948C9EC0141;
	Thu,  2 Apr 2026 15:44:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 02 Apr 2026 15:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775159082; x=1775245482; bh=bYdpsD/waJ
	ls46x8qWklRgO/vst3ppWOQ/WxsUcd43k=; b=hufyphZHDO3qTDxR8ZfeZja8k/
	pO1yf527GUUshY+KUo4rLadv2+byyJPA5/jdNOSV54UlYAvo405hMHpJ5LOr05St
	75IMk6U//ORMiFzn6rSgap1vS5iibwoltDIKFx1gmqG26e/MALPFQWnQGN+ORd0i
	7j1JLeBJQPShhGciD3P2ZurEoruKuQnFeGFOks8wFfUqZ5LrfQJ8ohBdk6EtTWSh
	TkS+bbdap9IpqkB9pK/W7w/Bf1rKQOm4QEkv8mX60MDR8gSi6/V8a7nvnzeCe8oi
	Y/XFMxORSps7L4HPGp+04BJRbPqCTQX+xDzi4FP8m0NlfhTjndQ45O+EIKaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775159082; x=1775245482; bh=bYdpsD/waJls46x8qWklRgO/vst3ppWOQ/W
	xsUcd43k=; b=L8OdQ2SO56xPpjI0FG4VlwPDIBI1OJ490RN5jgX03dKOJU92Ynt
	k2MGF1acF6VSYvkiX5bE703oaZ6IrI2ln5Ygz6Do+y3auy5b8BE/MCKez2pUm/A+
	gmhYI8NUlQm936rec3oQT+I0+cs72FLkUiNdxuAQsamkinOoS+8dO86YChVd/Vg2
	2kF9nSVI0AYyKybKSgfTk79rPJo9t9G4A1zAa/l5i8gmFWaDYD4lzq9rYsV2D0Xm
	2ATaoD989sKA8ZwHs0RkejSBvs04dOBTmXClvFNBAE8Ose9MpnY6dlTiidJQtvOF
	jq5kYiJFLNPWKloFegIAmIJopRFbl4woXiQ==
X-ME-Sender: <xms:KsfOabSZF_XVPqfFYI0uYGvoNgN8RHjejKrfoPc8s_ETVX3QnoMWSg>
    <xme:KsfOaTzqQrwMgM6pYGpLIvQq6xxBHJ5LfmotXvcorOjNmeQK6XTqYibC87RoqKGTk
    UkIZ_xtC5tKqL48j_A-UWSMq8hyBWvBGOqm2fLgJsxOPV2FnUvQmw>
X-ME-Received: <xmr:KsfOaV2xKayoBnlczprSjCuUPr_epww7t_Y514wfpEm1gtrmVE3bzpm_APLQq7i0fMcjriWUleQq7E8B9HpZ4m3Ti-MCqHUGUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiledtucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:KsfOaZ4g9sMQ1_9TvSPnumCLthLv2amaMUcpc0zMgic_I2ZQZbmIZQ>
    <xmx:KsfOaQUNA1SvqbvfwJN1e-4m4XOjaVezuZhWRqEnc-qldv0RTsChvQ>
    <xmx:KsfOaQBXMSjSPXhUjqXvhEuKKp4KovGjTHwAaRMl5kFF1mBWihlMTA>
    <xmx:KsfOaX4eFy3Fdeo77fv8VwmMtCjTv07LEJgPdHh2L1Kc0yVxX2D4xw>
    <xmx:KsfOadVN2BOVHfjXY8l9mrct-aS-2QG-E05p1y2GwmF6h8R7FvWDNDOx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 15:44:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 4/4] xdiff: reduce the size of array
In-Reply-To: <a3438dc09335ce46c0141c80d18d71cefcb96a4f.1775141855.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 2 Apr 2026 15:57:44 +0100")
References: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
	<a3438dc09335ce46c0141c80d18d71cefcb96a4f.1775141855.git.phillip.wood@dunelm.org.uk>
Date: Thu, 02 Apr 2026 12:44:40 -0700
Message-ID: <xmqqldf5p2on.fsf@gitster.g>
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
> When the myers algorithm is selected the input files are pre-processed
> to remove any common prefix and suffix and any lines that appear
> in only one file. This requires a map to be created between the
> lines that are processed by the myers algorithm and the lines in
> the original file. That map does not include the common lines at the
> beginning and end of the files but the array is allocated to be the
> size of the whole file. Move the allocation into xdl_cleanup_records()
> where the map is populated and we know how big it needs to be.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  xdiff/xprepare.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index cf4ac34f047..c5a3c9cde76 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -171,12 +171,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>  	if (!XDL_CALLOC_ARRAY(xdf->changed, xdf->nrec + 2))
>  		goto abort;
>  
> -	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
> -	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
> -		if (!XDL_ALLOC_ARRAY(xdf->reference_index, xdf->nrec + 1))
> -			goto abort;
> -	}
> -
>  	xdf->changed += 1;
>  	xdf->nreff = 0;
>  	xdf->dstart = 0;
> @@ -283,7 +277,10 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  	 * changed[i] should remain false, or become true.
>  	 */
>  	if (!XDL_CALLOC_ARRAY(action1, len1) ||
> -	    !XDL_CALLOC_ARRAY(action2, len2)) {
> +	    !XDL_CALLOC_ARRAY(action2, len2) ||
> +	    !XDL_ALLOC_ARRAY(xdf1->reference_index, len1) ||
> +	    !XDL_ALLOC_ARRAY(xdf2->reference_index, len2))
> +	{
>  		ret = -1;
>  		goto cleanup;
>  	}

OK.  In xdl_cleanup_records(), accesses toxdf{1,2}->reference_index[] 
already runs from index 0 (i.e., array element at [0] corresponds to
the xdf1->dstart) even without the previous three patches.  So we
were only wasting the elements near the end in these two arrays.
And the loop that uses the array runs only for len1 times, and the
array may acquire at most one new element per iteration, so len1 is
the reasonable allocation size for xdf1->reference_index[].

Looking good.
