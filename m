Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A77E22256E
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604498; cv=none; b=c/SRp3svic7e6rtBpxoFVku/PLhTWE/9VXYbRwXo1jhdDSRqZgDYYL/l3WRBzxubnHFZL86pAaUnqSyiRATV490AquCjH9DVNpw4cHK1SbpPCuOZB2+/UKDSni+mfXDQvOT1tGH0Eq1e6we/ReyXWgwygWle/U4u377ymGVtxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604498; c=relaxed/simple;
	bh=fJMVEYxmrVdYXwgZfCC9xiVIu7tjIOLSLzAcFOYdbpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzYZROP3Oub22PoQnzs+40sPLRH2HTK7O6tm72eSOt6xfsRKwA52sfFXIER8wMT3rnddPxdutve3sJuURu8DKcO+XkHmEzrTOOQMNsqsEfWaJZDgZopWXpP6pHdJZNzB6QDGFjVXWk+m5HqevBq2XzPYcLddhRuEVddgvA8Yfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BmDt9WLF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GYfY7s/5; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BmDt9WLF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GYfY7s/5"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69DCF254010F;
	Wed,  7 May 2025 03:54:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 03:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746604495; x=1746690895; bh=LknSz6ebVq
	ITaQ9yeTfTFZ5tv+CyMbiDbQDx5sd7yW8=; b=BmDt9WLFh4OjeOfcq/bptHodUu
	crd/mcgrGP+YZeLu2wFBuvPDvmtxXZML3fEtj1OjtH6DZvcIJ92kcjn+43R/eTPu
	ledXwSfiIzc69HI9i7KQqqjotSqODjFrGcv7JMM/Ot8c85br547gsZjaZfUyhUra
	9ojoS7cWDWfQwbF+EwXkFTMvPEhMo1hW7f8HsPahus/0N0u899BmJnBLFAS2soeS
	k4llJcPkYzdzEIHEt37l3X/itpXiVN8ZAf3m/Jw8us4rO/YfCD8fL5SJYCFaRaBG
	TMtrNTVomWlyDdTskVEmnhbob4v3F2Ou8ya2VtdhmdcSMZn5JW3oj13NR2XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746604495; x=1746690895; bh=LknSz6ebVqITaQ9yeTfTFZ5tv+CyMbiDbQD
	x5sd7yW8=; b=GYfY7s/5GXOSfYKgVC2yrHVu6s9Ze10lGECRivfr/5d2GeIedR9
	jsuCAV6dtXEjsOqLsnt+wXBvNOVZgs++ZWLQD2B7RDzJoYxntm8Vim7ekOz1k/oV
	mMX1WnYcA2FC1/fi4BDbrVsDg5NFD5KXpTdql3tPaMEGackaZnbF8k+bFPEkjmm/
	XJnoGtzqNYuorK8nKY39/Dbul1AdnZfj+vATorMTvuDeoLmfTlh7Db6ilseuSR+c
	GoXSgye72kCp7dpTYj4HVnHv7V7DRdP/ykDzptcHO2WAq3RsHbiydx0WtdWIT3mY
	s+gt+s4Od+fwCboDc1dalzfsJVFQXnyjsyg==
X-ME-Sender: <xms:zxEbaO1oDvGnRpJgIgZYgirvHR2BBbWGmyDhUQZTSS2qJcf0g5Hxqw>
    <xme:zxEbaBG32R2FvnQ1O5dLDc0EMW10P3B6n4oLTA6EJjh4twtTz2cYOSw6SGLCcHtbG
    ZNDcbym4Djv9QTxzw>
X-ME-Received: <xmr:zxEbaG6QOMmySdltLt92EEA_OZP-oiiLj3ajTYTFSy-HFVYb_M9blIFgoEnOf4EeifEBMUUIJpGRRo5VrwkDuE4VTxw2wYID6cdGUc0Hml280Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeifeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudel
    ueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrd
    hnjhhurdgvughurdgtnhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:zxEbaP2-I02Tg1W7ydcZUuRptvlQe2rrEP9mb7q3LC5KwY2YTBHEzw>
    <xmx:zxEbaBFkT6mF9EyJeB6tw7oOE4bZlTOKSLTSp09Mz3eyVdcS2vdkpg>
    <xmx:zxEbaI99R-kWKnGW87rHZzonK3feR1zAFV5gpLhXQmLcnwg8gAcMDQ>
    <xmx:zxEbaGmBsMIXAXzPmRrY9GN_Yz44oMvtYD93wfbO9hj_0IhRM4sJYA>
    <xmx:zxEbaAxCmSQir2MPBqCiNwJR8_Ida9PkE8Xj5FREnjmQ5XXVxRCj_JjM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:54:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e15c2cc4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:54:50 +0000 (UTC)
Date: Wed, 7 May 2025 09:54:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH 2/3] fix: replace bug where int was incorrectly used as
 bool
Message-ID: <aBsRzPvrMrDtEVli@pks.im>
References: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
 <7a5e2f295296265379551584a271a409a0ce3153.1746585203.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a5e2f295296265379551584a271a409a0ce3153.1746585203.git.gitgitgadget@gmail.com>

On Wed, May 07, 2025 at 02:33:22AM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>

The same is true here -- this needs to have a proper commit subject and
message.

> diff --git a/parse-options.c b/parse-options.c
> index 4279dfe4d313..12721b83000a 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -638,7 +638,9 @@ static int has_subcommands(const struct option *options)
>  	return 0;
>  }
>  
> -static void set_strdup_fn(struct parse_opt_ctx_t *ctx, const struct option *options) {
> +static void set_strdup_fn(struct parse_opt_ctx_t *ctx,
> +			  const struct option *options)
> +{
>  	for (; options->type != OPTION_END; options++)
>  		;
>  	if (options->value && options->strdup_fn) {

Please refrain from doing code style cleanups of code you have just
introduced in the preceding commit.

Patrick
