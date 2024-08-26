Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64A14534A
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665870; cv=none; b=oBTCJgZuJiNpb4DWTEfRRM0DrfYbw+af5h7tquogenMZHwbqnFQF6QWhKrrt16OPdKdZTTuoD4W7jyMfS8197O0kcxhz1RpXBo2H1Y/nnCzWKtr7JhJyc2ykFLSq85Lu22qtehOpVJUquWdz+KQoQDtITMURdGwj6ui8iYESB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665870; c=relaxed/simple;
	bh=lwBX4dVwOznj6kOS2OhhcTUQs7/I2WBTxYRXBl49pJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yyswhju2k9SoB/LEZeVFNTciiGmVC3mqsYKtwii7VRFI4J6NYatTPYx2YrMGrGxN3WeOqs8dVf93RAXSg7HvJi14TOZh2/Co/7q+Nv/5mQMlkmJWt66BDsmyxVOIlrRa46BUmh4Wi8+FxoGRmp5G+2DcsCV0EOAOvSgXuJ0dn+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VBtIXB/q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o7L7FKss; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VBtIXB/q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o7L7FKss"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1007F1151AF5;
	Mon, 26 Aug 2024 05:51:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Aug 2024 05:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724665867; x=1724752267; bh=dod9Z+Wmim
	/lqNKtKbo2ZeSho5VlgbgYO3E56t/lPKY=; b=VBtIXB/qir0SKDKVM/Z1nyATso
	brRaZt6NYYYY0APXnx6D1Ju/MS19lzQ6dLvOhbV8yjckX28ER3IPKw9j1Pkir+QD
	/uby5seFd0zuJeLDuq1HveEMHrl98m1/7+c7cItHodefEX1l2WGMhX1AoQhytiz9
	BjjwcAF6HOdXu0DuIU0JFgZg+y1VDfkd41HTlx3ehqpf80d7rx/DQIvIzis/2ZQT
	c8pW+8uWZyEII/IDSD+nhuhJVwIg57l0ZopFj3bi4J4T5Pp2mNfrCBzWD9TOxMby
	cyyooV1LGa15uQzC+Dw5gT0Z24dLGz0tH4iq25CoqwpsNAaMLet0L/aLSYuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724665867; x=1724752267; bh=dod9Z+Wmim/lqNKtKbo2ZeSho5Vl
	gbgYO3E56t/lPKY=; b=o7L7FKsstDgqeN9mfxQt7fBrJgYEPTqrHU6w28+2NEMq
	fUbwcCETkqJsCuAVqVCulIcZVAmeoW/MiFg90kpCg7Xg6W+cKfPdGaSdzJGbd3/1
	2hYqusgp++rzd6o9pbLl36e6M6HTYFlBb3krllR3jNdmg7sAlL0r09OmVCwRoMfy
	+51M7Ubye4S3X0Rmer1ag9fY0ArXUvNt95/MzmUkKIyjxcjr6K1cR4HPA+lommCP
	90Ak8JOLBIfpCAGcV/d5iUqp8VuFxJdkR68hA9kvhlXfbMIoHezx7zkN0AVYF7vg
	VG7GKbUAEu3TxR+ulVruTLXv04W4qOLGl7LDmQYOOA==
X-ME-Sender: <xms:ClDMZlS3LbN0MVdlTCiNdAvQes-fQlXiC3oxhZJn3AugMgxlBE6yYA>
    <xme:ClDMZuyikn6aj66FDDnic8odNd-ks-2Yx730z5hgpHUTCi9QcU4qbtaaE96Pxad2D
    wKSdekFO8f7r3u0Fw>
X-ME-Received: <xmr:ClDMZq2-v3NtbE0SrqB0_vBNzpkLLouRsAnewJXm-SOHcwfBv422itThqjmx7SqXf_dq8gFMLKjSO1g2roLqG0um8wRBBpE29kguc91HKi8a9Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ClDMZtAJU6CibwGAW-F4CTQlyXyLu_YIV4X-rBHSXMq7wmtyySoltA>
    <xmx:ClDMZujRL4Yk4-2K2fmvlGHrE3VEdBFKimRhLMK9Mu3JziKK3GQxxA>
    <xmx:ClDMZhpsuUt6SbKir6XkPP3Qynx9JcJj8_yV_OZebniC9U-QoY_WuA>
    <xmx:ClDMZpj0p3sJPLcDv2VQB_HbJmbsF9USXumtb2pHSNl105y0vue4zw>
    <xmx:C1DMZhs03CoScK0a7eTx5hiF4jLKeSuR3-y_GQ_0bNxF4BCT1IgFNlx_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 05:51:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a8e817f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 09:51:01 +0000 (UTC)
Date: Mon, 26 Aug 2024 11:51:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bundle-uri: plug leak in unbundle_from_file()
Message-ID: <ZsxQBEpfChQozhF7@tanuki>
References: <20240826083052.1542228-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826083052.1542228-1-toon@iotcl.com>

On Mon, Aug 26, 2024 at 10:30:52AM +0200, Toon Claes wrote:
> When the function returns early, the variable bundle_ref is not released
> through strbuf_release().
> 
> Fix this leak. And while at it, remove assignments in the conditions of
> the "if" statements as suggested in the CodingGuidelines.
> 
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  bundle-uri.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 1e0ee156ba..eb49cba182 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -367,17 +367,21 @@ static int unbundle_from_file(struct repository *r, const char *file)
>  	struct strbuf bundle_ref = STRBUF_INIT;
>  	size_t bundle_prefix_len;
> 
> -	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
> -		return 1;
> +	bundle_fd = read_bundle_header(file, &header);
> +	if (bundle_fd < 0) {
> +		result = 1;
> +		goto cleanup;
> +	}
> 
>  	/*
>  	 * Skip the reachability walk here, since we will be adding
>  	 * a reachable ref pointing to the new tips, which will reach
>  	 * the prerequisite commits.
>  	 */
> -	if ((result = unbundle(r, &header, bundle_fd, NULL,
> -			       VERIFY_BUNDLE_QUIET | (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0))))
> -		return 1;
> +	result = unbundle(r, &header, bundle_fd, NULL,
> +			  VERIFY_BUNDLE_QUIET | (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0));
> +	if (result)
> +		goto cleanup;

This changes the returned error code from `1` to whatever `unbundle()`
returns. Is this intentional? If so, the commit message should explain
why this change is safe.

Other than that this looks good to me, and the fix does not conflict
with any of my leak-plugging series.

Thanks!

Patrick
