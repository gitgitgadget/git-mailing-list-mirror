Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ADF4D9FE
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 03:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730777005; cv=none; b=W6RyVYEYXF6pB+132NkLRGGWlvqxWBFgPE2qrnaBwBxBs/3l42Mi0Mu6DJz1QTq7Dz46Tl+tiHH4+PjKHaHZi/UzYgL86EbndEWjSptF2fv4sVkpz1Njz7InmE80VP4wDAws6p3cHqssA95iMDxLH5y+oZCrfz0e5YvLhPBB9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730777005; c=relaxed/simple;
	bh=xvQzZG2oERzCA3tV+22Ipo50Gm7uYMr4q7sxpacqRn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VXO+67ULUkC71uaGQJWOmVXJJAdN++NnYejfV36fmW3HhpEGYHbs0iF+TMudIj2U2joeHggqp7JNyOyVNIxdJEEeSyYHT+FYq/v8kvObjH/uuXDsJGmRWXQQpMOjakFTPRU/uQCbAkmYJErI/T+Z1OpVa8xB9Ty1Ya1DQBiLO60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=moZ/Psnm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ENgfsrqf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="moZ/Psnm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENgfsrqf"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF0B5114017B;
	Mon,  4 Nov 2024 22:23:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 04 Nov 2024 22:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730777002; x=1730863402; bh=F0sfTwLiWx
	5chwOAz8njGS8CZ3TZmD9aZthegiGsC08=; b=moZ/Psnm654YVCZeOznaAxynR7
	BzSZapD9UvlJlfc9v7frT2NbgHIxtWeCQB4c9UED1GTZN3ztUnhluKFx36rMK5md
	y49OjiB4ib/Ac4HeP2hLfl3I+retAaCCLgDe/pwP3fT8Qlm/dgiM4JAa0Xv4X4pc
	NiM686YEHNFcYby6EBtbwbY60yA81FvWk7OkC1mLl+9qX60FOGwZ1IaViaoXE/tM
	9LqkpOEFSpUFJE+ooP8lmwZRwIPR3LugGlGaDt5r0hVvK7BF+ikhXh6aUQe8Svi9
	Xyj+X9XK/4pX5EGKVn9tcei4zU4lrwSZyfXiC0u2U5/9apUXr3XJoOKuTMTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730777002; x=1730863402; bh=F0sfTwLiWx5chwOAz8njGS8CZ3TZmD9aZth
	egiGsC08=; b=ENgfsrqfJooo5UwEE4R9mNIYJuHWfBuVix/88ptQjTME+bErrJR
	rwXhXLEaQ2gtPDgZzkujr8TvnUlxTY+aLo122RcMofJy6EuBPcg7DrWWcdId06oP
	4BIQB0+bYKNJ7I1LhnLNG4TeC18Fxv3jqqoGayHYj9yiacutdF32HK8zqNOayHHw
	kmYZKPS76Lep6mbZkdt2fy/JlI6P9nwXor3BdLSwHIjbAcUstUuwtAEJ6U5jwKVY
	SbV31uVvipEEB3zkMrWvhj/xvEKyT+XrslZUAl0aGP6yvgJMjK3ShOpK8RNcb+dY
	tSoe0W9ORBcpEDnPwyD+GOb1zqkQZwBnkfg==
X-ME-Sender: <xms:qo8pZ_AunY0BbGt84VjJV0GFMWgEVPqIBrvnDJEV1gRUPRSmOIVijg>
    <xme:qo8pZ1i4TjGDtoskQDqi2quwQI35pHBiSGZfkoDYPzqBSeBmvgfDubcB1QQuFLf-_
    dfn6X2WFaS2uaL0Xg>
X-ME-Received: <xmr:qo8pZ6nlo_Cs0KMN33MH8eRJ6KdHV7ChOP25padG-vtrqnydkipaIL8ZHRABXsE-32w9uG_wB2jV2jASn9mAop0gH_vUOV7T1nZC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepjefhieevkedvleelheejfeegkeevhfevudel
    vefggffhieeljeehjeevveeiheetnecuffhomhgrihhnpehtqdhrvghfthgrsghlvgdqmh
    gvrhhgvggurdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qo8pZxwLzkBhPiFhyPrw2w41A3izAZWaeEttlOQraeAXgmMdQkaxBw>
    <xmx:qo8pZ0SnyXe3T6vtQEYuCwXQPMyy0Piiw5aJw5FqKMlSaisRGqIo0g>
    <xmx:qo8pZ0bsudiF47UdREAkrU-efRu8YC4pPgBr7-7pfLwUUmV76ZGkAA>
    <xmx:qo8pZ1QPlkj7Q6_sB14abJA58Tii4ew3T2VJtTVGfmGEL9pDrKdcrg>
    <xmx:qo8pZ6dUfe-y_7ucdAQBnu8oaOjl_dqN_7CUANfkM8EBV7xn5RlCdpmz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 22:23:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/8] reftable/merged: drain priority queue on reseek
In-Reply-To: <xmqqv7x2tlnk.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	04 Nov 2024 19:16:47 -0800")
References: <cover.1730732881.git.ps@pks.im>
	<45f397b563fe88524a2063bde8cad31ab9a2ccbb.1730732881.git.ps@pks.im>
	<xmqqv7x2tlnk.fsf@gitster.g>
Date: Mon, 04 Nov 2024 19:23:21 -0800
Message-ID: <xmqqr07qtlcm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Did you mean REFTABLE_HASH_SIZE_SHA1 instead?

Ah, that transition hasn't happened yet on 'master'.  I'll carry the
semantic conflict resoluion in merge-fix hierarchy then.

> diff --git i/t/unit-tests/t-reftable-merged.c w/t/unit-tests/t-reftable-merged.c
> index 620803e0ed..a12bd0e1a3 100644
> --- i/t/unit-tests/t-reftable-merged.c
> +++ w/t/unit-tests/t-reftable-merged.c
> @@ -326,14 +326,14 @@ static void t_merged_seek_multiple_times_without_draining(void)
>  	check(!err);
>  	err = reftable_iterator_next_ref(&it, &rec);
>  	check(!err);
> -	err = reftable_ref_record_equal(&rec, &r2[0], GIT_SHA1_RAWSZ);
> +	err = reftable_ref_record_equal(&rec, &r2[0], REFTABLE_HASH_SIZE_SHA1);
>  	check(err == 1);
>  
>  	err = reftable_iterator_seek_ref(&it, "a");
>  	check(!err);
>  	err = reftable_iterator_next_ref(&it, &rec);
>  	check(!err);
> -	err = reftable_ref_record_equal(&rec, &r1[0], GIT_SHA1_RAWSZ);
> +	err = reftable_ref_record_equal(&rec, &r1[0], REFTABLE_HASH_SIZE_SHA1);
>  	check(err == 1);
>  
>  	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)

