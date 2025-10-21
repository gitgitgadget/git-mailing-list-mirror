Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7C280CFB
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032468; cv=none; b=b9nODWRVrvlkFr+3bizASlmSZTLozIgKuYyIyLUTl/LPGe/50JL6cIUsvZhClNK3UoJxWZZP8k6ehpZ4M+OoNGvMt0EDtUdikHLnR9ogsmpvSyL0lYN1vkF+XqaZR9pmiUQlhckwc0KIQSR5eqKZhBCBowCuGnX5poelNb4F4OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032468; c=relaxed/simple;
	bh=tKRhtw5nPR1spt+ltg+D5/oyPwv3dY6q02SCDsHukbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqE0Ncw3Cc/Z4HkkuUi2qYTwnAqszw2kzbuHwoTeFYKn/8EdZaA1Z33n8F6cldg6+qPPZwV8A8P9reMa75dofxLMwIKuUZlIWNPP38ZODcEFzCrQ29PfpEFqwItu8oNy2BujqqcgYZSlMNJ/c7s9NlJ45DeW+I82s15ORCAmye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VlTNZfNt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WeLjkWJp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VlTNZfNt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WeLjkWJp"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F08AD14000EE;
	Tue, 21 Oct 2025 03:41:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 21 Oct 2025 03:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761032461; x=1761118861; bh=mozN2rHp2Q
	3MKcJhxeWlVTyVzDVeu2P1INIpSGrbuAE=; b=VlTNZfNtWOm1TOUknN1BYheHYl
	cq469EwojssAjCtNAJVZStF44yNHjTNFxcV2D4vQll0cTaln0inpAUKkiQRTDy9o
	gTxozQbe9wZcCZLlOb2ieY+BXVNF91KlAK/IApXx2x9g8W6ZRnfnLhwm6yZPhk6D
	D1+uahbqlPy9yaZeQ/7KXEBeGTvNnwLhpjt1dQT8RwxsCRIkfPdojx/H3XS/C0XP
	F83P1p2c6po/44F5qlAFdG5C9VRo2ktkT3Re6g6NqCubQRbY/NtB6tz3z4z0Rloj
	DKaUzZzhjIyOU4cDdFK3o0HgdTjnfp+OIO16qGfhZIKQQosU8GcFL5zzMDjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761032461; x=1761118861; bh=mozN2rHp2Q3MKcJhxeWlVTyVzDVeu2P1INI
	pSGrbuAE=; b=WeLjkWJpaBJpgGfYivVTbjARb2UdA6OqkR4gFILJy2Xogzh/SJs
	gdsGoY7JJEo63bNVdrxiZetpb//eRhTgZQ/5fYrvs4Xr9ZSpBp+PFNUzVziQ8hjv
	AXlkWTWqwpXlPvsE6mzr3bBfjzBdOR2BYSQDV/CIqPKOodepQ0GWhNr0lBprmnkS
	wrxSQ3/58sHkIl1h19DhbmA5+sNgzoXO8sy1GtUmOQpgRYQjluauS+g7hdIqnepN
	v0f1ZgK3D/d530VW7BHKPsm1loXea7tyrur/0R0O8QniPw6RXTyPa/+yc+qCWfnG
	0/GYIGIhua1k37Ef/mouyPjcCyCRwvHcEnA==
X-ME-Sender: <xms:DTn3aKn92lEIgrp4x_blI-gNEBQR2cI_dfMe_EBwuSdyOJbWo4prfw>
    <xme:DTn3aEa3ozKh0gPq2IpEUvfd16Q-apk-ui_80wtDrhDo2IqyFGfH4yRD011s6pvD_
    uwv8QRfhySPT3VX2AWHiqCYlvV1PIQIAZmwPQhEX-guH-zExqs2qQ>
X-ME-Received: <xmr:DTn3aMTBA9ZOGA1fJdxem1aiX9nVmJ5VYCOz5ApGIyLP3FuCLRw3cNwuI0IWNf-ivAJoWBqrekzYkexmrYh-iqMklbNb2SQ5Ug9LKxSWgYXY-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprggurh
    hirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheprghvrghr
    rggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:DTn3aOtN7CWMC9IOSHfpYJNAr0rl5BICyCE4kJHw_s8GISAUmw8lPQ>
    <xmx:DTn3aOF-wpNRsvB_udjBJybVHV6_gUHh7AvAINbbUk9-pi48CABhwg>
    <xmx:DTn3aPzh2844-x2K3DKHKddPYPTCxNVjq7Q199lTXG9fuYce7re7eA>
    <xmx:DTn3aI2c_kW3w4HdBYc9oNlwWbPrtepMatVoPZYANM2yGz4L1nXlXg>
    <xmx:DTn3aB5sU4TmF56mxcOI6EQrYzHLSP3okWegO1a0zbGQXWJVjM_jzoCv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 03:41:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 168bbba4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 07:40:59 +0000 (UTC)
Date: Tue, 21 Oct 2025 09:40:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 01/10] run-command: add stdin callback for
 parallelization
Message-ID: <aPc5CDkkG5Odnd_g@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-2-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017141544.1538542-2-adrian.ratiu@collabora.com>

On Fri, Oct 17, 2025 at 05:15:35PM +0300, Adrian Ratiu wrote:
> diff --git a/run-command.c b/run-command.c
> index ed9575bd6a..5bc6db5bb1 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1652,6 +1652,44 @@ static int pp_start_one(struct parallel_processes *pp,
>  	return 0;
>  }
>  
> +static void pp_buffer_stdin(struct parallel_processes *pp,
> +			    const struct run_process_parallel_opts *opts)
> +{
> +	/* Buffer stdin for each pipe. */
> +	for (ssize_t i = 0; i < opts->processes; i++) {

This should use `size_t` to match the type of `opts->processes`.

> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 3719f23cc2..dfdb03b3ab 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -54,15 +61,48 @@ static int no_job(struct child_process *cp UNUSED,
>  static int task_finished(int result UNUSED,
>  			 struct strbuf *err,
>  			 void *pp_cb UNUSED,
> -			 void *pp_task_cb UNUSED)
> +			 void *pp_task_cb)
>  {
>  	if (err)
>  		strbuf_addstr(err, "asking for a quick stop\n");
>  	else
>  		fprintf(stderr, "asking for a quick stop\n");
> +	if (pp_task_cb)
> +		FREE_AND_NULL(pp_task_cb);

Tiny nit: the conditional here is not needed.

>  	return 1;
>  }
>  
> +static int task_finished_quiet(int result UNUSED,
> +			       struct strbuf *err UNUSED,
> +			       void *pp_cb UNUSED,
> +			       void *pp_task_cb)
> +{
> +	if (pp_task_cb)
> +		FREE_AND_NULL(pp_task_cb);

Same over here.

Patrick
