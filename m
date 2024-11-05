Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518ED4D9FE
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776612; cv=none; b=Kq+0+kZ3R3Ko5GQBwyblYO7XuzxnNsNh3W8jwDkDTYOzFl0eAzNy6enFxgmjhSA771WaNqA243TPuAJWq0g4vtp5XVJjZbLHS9V9pWmOoXfM/aZ3l0RC7+W0cN3cHbhnxZvUTTPIbEquZkCE9Tc5gnOZ8m3pVw53AThFxTcaO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776612; c=relaxed/simple;
	bh=4I5+i1w2mCzdCTkLFK0fdvS3uBkYZppCWSGEKE46UuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Epwc3EpQzAVEJEygbCrpi1w2zAQNppcXJ2D+Xv6w5ZaK7Kvyh98Y04QAVf+EAjVfbojU6iOOHgMTYTDE8pFMjmzCyVOZ/amWrbxRMd5z0CyRPYN++8ZR+5I86dexG3MCiBLENyAPY23I8Q/seSSKX/Kjf5dYUhehdOCObaiX/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dOerUfwC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gD2LxSya; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dOerUfwC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gD2LxSya"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 567C0138022C;
	Mon,  4 Nov 2024 22:16:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 04 Nov 2024 22:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730776609; x=1730863009; bh=xeUhitXri9
	1PgyAZ1Z9fGITRAXlzG6jT+D0HMt7JFXU=; b=dOerUfwCojQ6C0y0v1JoDb3GMo
	AgjLbXLXaJeSpgmGVcpUOBVaAe2fA5fHfl2t8jk3YmiXzuYdMbxnt1oiXBynJXCw
	J9r2TLZDi+wpULvQWXCZDeM5rClSICu+VAysnOSfRPdcdDtFkYPU8Ilw43ojYOqO
	yPlMls/mvjZaP8Y8LWh9RnAuKrJPXsVr6tjTxwVM5rdP6Oss9I8TL6rmiaDU5ksj
	aPoZYxmoktLEu/yoBbv+I/ROsY5ixFm1GDJ3PYsMvFWTzOaof8Ku7naGbTfaeoNh
	+oGsj1kDuLjTIG5/w+rdihIb5u6jjXLI7Q0PqxLImXCVgmvZYagUtHtN0yXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730776609; x=1730863009; bh=xeUhitXri91PgyAZ1Z9fGITRAXlzG6jT+D0
	HMt7JFXU=; b=gD2LxSyaGDkc7I+VuSXJLXtVcNHvX36ImjrCmLsMOImcEegBJJy
	HAXaAjbg24AXPWNJjEcWUpaiACNE5B8D6CK1K5g5BMRuOpb/7fhHpdW2sNsuXwYr
	HiNlzrQBEJOL0SRPcDcsufrcAbrTeCyBaHG0MYOhwJBNzItTZiuQ76eYTUW0xKMC
	MYLzfPKLP42NPfrSIRxL1OMXfq6/OK2pk2tiINkmaB2GdAKZV3fd5ryQgRF8iGw1
	w5xR1AVOjhtTV04+4lfn4oTXY+utXY64vARrraqu4sDJBZKZ/7Zvpc/cG9obmdg3
	0r+KPlJW8pIX/JVdh3RBGlng3Y4sPdftp0w==
X-ME-Sender: <xms:IY4pZ2q8HDrwHZLLK8KkkhEB77NvnY4EueVn2jVgdQc4SDjJ-x7cLg>
    <xme:IY4pZ0qRMXWfUcgcd6z_873FEjjbZy_kEIXmhYKHkIr_CW2SvdiQZetPjErgdpbII
    GETZIJ38F7hC6LxhA>
X-ME-Received: <xmr:IY4pZ7OwO4KbOSZXBEQjeaLVEJAYw0TFmM8wk9OoYFlYdgSaDb79xODL8CuJtESXnf9ircylDj7_zLegBc2jN_3DpZ9udhjMp9s9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgheekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:IY4pZ156EngW7q4MFSCIecUADTDhoePvfT3iIML-gmEet6q3G6-4hw>
    <xmx:IY4pZ15Sukg-GfSIp1UQ81avzzzYE28-4t1qab-zVSZRZu9tNokG_g>
    <xmx:IY4pZ1gi5FCwMlB7rpQI0QAFsrmUrMa12UEdlJvm5xyYatGOxnjaeQ>
    <xmx:IY4pZ_5Au9M88kVcvAihRcZLrw2ryArPb32ZjCiNxL7VcDuPexJurw>
    <xmx:IY4pZ_l6HaOiwmAuzh7M_3fAJqeXEHEDyBKnnZ9sVgI4hYkD9mWdqTKd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 22:16:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/8] reftable/merged: drain priority queue on reseek
In-Reply-To: <45f397b563fe88524a2063bde8cad31ab9a2ccbb.1730732881.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 4 Nov 2024 16:11:53 +0100")
References: <cover.1730732881.git.ps@pks.im>
	<45f397b563fe88524a2063bde8cad31ab9a2ccbb.1730732881.git.ps@pks.im>
Date: Mon, 04 Nov 2024 19:16:47 -0800
Message-ID: <xmqqv7x2tlnk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
> index 4c25ee5334..99ca33f973 100644
> --- a/t/unit-tests/t-reftable-merged.c
> +++ b/t/unit-tests/t-reftable-merged.c
> @@ -273,6 +273,78 @@ static void t_merged_seek_multiple_times(void)
>  	reftable_free(sources);
>  }
>  
> +static void t_merged_seek_multiple_times_without_draining(void)
> +{
> ...
> +	err = reftable_ref_record_equal(&rec, &r2[0], GIT_SHA1_RAWSZ);
> +	check(err == 1);
> +
> +	err = reftable_iterator_seek_ref(&it, "a");
> +	check(!err);
> +	err = reftable_iterator_next_ref(&it, &rec);
> +	check(!err);
> +	err = reftable_ref_record_equal(&rec, &r1[0], GIT_SHA1_RAWSZ);

Did you mean REFTABLE_HASH_SIZE_SHA1 instead?

diff --git i/t/unit-tests/t-reftable-merged.c w/t/unit-tests/t-reftable-merged.c
index 620803e0ed..a12bd0e1a3 100644
--- i/t/unit-tests/t-reftable-merged.c
+++ w/t/unit-tests/t-reftable-merged.c
@@ -326,14 +326,14 @@ static void t_merged_seek_multiple_times_without_draining(void)
 	check(!err);
 	err = reftable_iterator_next_ref(&it, &rec);
 	check(!err);
-	err = reftable_ref_record_equal(&rec, &r2[0], GIT_SHA1_RAWSZ);
+	err = reftable_ref_record_equal(&rec, &r2[0], REFTABLE_HASH_SIZE_SHA1);
 	check(err == 1);
 
 	err = reftable_iterator_seek_ref(&it, "a");
 	check(!err);
 	err = reftable_iterator_next_ref(&it, &rec);
 	check(!err);
-	err = reftable_ref_record_equal(&rec, &r1[0], GIT_SHA1_RAWSZ);
+	err = reftable_ref_record_equal(&rec, &r1[0], REFTABLE_HASH_SIZE_SHA1);
 	check(err == 1);
 
 	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
