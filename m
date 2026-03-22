Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881D373BF6
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774202706; cv=none; b=vFwM4Gy6OkpohkXCZiJ+jYPVA04BnXa+hWXFqdHGIf8muZQHpwlA8fqb3BwZl5TKvJRAdDKlwsjoWKn2r/ZYcP/SZbUQiOXvHUx/AFXlZMkQNZaDBuYYYhta4+FKNl/VBrTW6JNpiVwGOIIMlWASaGTAfBkjz9glTJknI3eTa+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774202706; c=relaxed/simple;
	bh=oGNnRmxaupHd6qeAQyrz8e+zx+fFdjCmLlYQA/XXpjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FeMmVqcD4rssPdrYShkosG+HabERZdIOhAbpEQ27w91xp4SaEHJX6MsPkEHXMEvN/z8kJEalV+4uRtHbgLM6uoKdO8OdiYYD46Ug/z7HkjRS/f9M1Pxa1mG+23cD4wO0DWXlOz0Rv/CfZtbLlX1EvFwZy/ZMZcUtVPAkotPABvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M7+d7MXc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tQTna9Ff; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M7+d7MXc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tQTna9Ff"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 930D1140018E;
	Sun, 22 Mar 2026 14:05:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 22 Mar 2026 14:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774202703;
	 x=1774289103; bh=Fr/5yGiUT0AvAH3Prd0/JY+BTvvNVMz7H9OSiEO04yE=; b=
	M7+d7MXciu0r0q7gVOIMQVlsGL+/wzMHXuSvZwQuqmpt6+W85ckENE3en+/rCs+q
	+3TR2wE+naDTrpqyBPYgKt1d0bMmJhcgK5J1jTG8QPEgg84Si5NnwBjSblIQLrtc
	IKLPyQQZeWJFIftVBtIyBVaehqFcMlSgaagUYAqhNc6ZrqRg9rqGuYhU6973+yMr
	/k8tXtEKCmPc7wkxOYx6ihpna+91sp1xuy6WaE8F4q67NBd6Q93DE4XwnRFVOXe7
	eaEFLxRM4z+vmLVJyPFjHCxYfbGt1Uv34FY6hC5Rt5eygPBnwM/yrLH+1Nr5JEGd
	X/lDG7wVaRlDfG8v54KC/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774202703; x=
	1774289103; bh=Fr/5yGiUT0AvAH3Prd0/JY+BTvvNVMz7H9OSiEO04yE=; b=t
	QTna9FfYy2X6bvPL2OYDCDZWYKpMZxv4e3gn5/5rAQ8LbyJvqHju2u+gopqnqXQP
	YSUZ1o6PiEQwNbxhS0mGXz/T/rYj415cGDRvwIMJV8ExVEfCeS7E4DCoNWpH5eSO
	01ii0BAsRCXFqLWKwOI9xtMWFdkMKd8MzCwb+bZbMvg2C7dlHGTcq8jd8GqxGMuc
	xfO7Zdp/aI81lpYT7luLggdzOlJkS4+GYaBrEdDQor/JAikq8jz3n21rt3wDrk0f
	RlPoIjZQ5MnGHiZo90sivGR1HahYDs9cm5kk16hJQGiUcazDH7xrpltVYX/M4JTa
	ZL5ar/0RLOPrj6eVzxqLg==
X-ME-Sender: <xms:Ty_AaZduWiiWyFAG_OuQRefUW7RM6Uymy48QhJ5ovq4HiZ_m5nc7uQ>
    <xme:Ty_Aaeq34gS7wNHSFgmozunCmh9aDjv7tbiTA57GTwx8JQkReLCMhrzDykKxNy36M
    7BJiPMwXzt3Bo8SNqbggTyvoStP-le68O1wTui8-ft-RDRoNh7akQ>
X-ME-Received: <xmr:Ty_Aaf6S-nEedYnMGTg3NOkHzaSPLQxcQSd7Ui724wOWPVJ_pPWs2eR1N7PSncco72FgtKQM8wAh1eG6_SOqMJLtQKuX5X3SAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeigeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnhepuedttdeigeeugedvfeehhffggf
    ejteekgfffteeuffdvleetffeikeeuffeiffdvnecuffhomhgrihhnpegrrhhgshdrnhhr
    pdgrrhhgshdrvhhinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ty_AacpNs1YKlVlMH6vIfOxT0niUPAR7x6nePMyojfgWt_6uAUNwIQ>
    <xmx:Ty_AaZgW1U5MJseudxdTIyq5hBLo-9P5QBGnv9BgsRQLQBZQT4TUrQ>
    <xmx:Ty_AaeKvuLG0HIzAGJFzT_BHe2GFsWg_NhAAX6mzP-FX5Rd_fPUK-g>
    <xmx:Ty_AaRD50icRSpVnTIsa05XGP9wooMitnljX_Mjh6qYEYZoyVIDDHA>
    <xmx:Ty_AaaRmSKe7m7i9GPR5eKXJrRN10jFR5QAIWJL6nMl1W4DYvfdxM1eT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Mar 2026 14:05:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] use strvec_pushv() to add another strvec
In-Reply-To: <084f3b43-91ac-4553-8305-03944e97eaa6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 20 Mar 2026 01:46:26 +0100")
References: <ad46f86f-2ac0-4802-8e63-d854d594932d@web.de>
	<084f3b43-91ac-4553-8305-03944e97eaa6@web.de>
Date: Sun, 22 Mar 2026 11:05:01 -0700
Message-ID: <xmqqeclb91v6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Add and apply a semantic patch that simplifies the code by letting
> strvec_pushv() append the items of a second strvec instead of pushing
> them one by one.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Changes since v1:
> - Semantic patch.
> - New conversion in builtin/rebase.c.

Thanks.  The fixup does not apply to plain vanilla v2.53 but that is
OK, as a code-cleanup patch like this is not maint material.

> diff --git a/contrib/coccinelle/strvec.cocci b/contrib/coccinelle/strvec.cocci
> new file mode 100644
> index 0000000000..64edb09f1c
> --- /dev/null
> +++ b/contrib/coccinelle/strvec.cocci
> @@ -0,0 +1,46 @@
> +@@
> +type T;
> +identifier i;
> +expression dst;
> +struct strvec *src_ptr;
> +struct strvec src_arr;
> +@@
> +(
> +- for (T i = 0; i < src_ptr->nr; i++) { strvec_push(dst, src_ptr->v[i]); }
> ++ strvec_pushv(dst, src_ptr->v);
> +|
> +- for (T i = 0; i < src_arr.nr; i++) { strvec_push(dst, src_arr.v[i]); }
> ++ strvec_pushv(dst, src_arr.v);
> +)
> +
> +@ separate_loop_index @
> +type T;
> +identifier i;
> +expression dst;
> +struct strvec *src_ptr;
> +struct strvec src_arr;
> +@@
> +  T i;
> +  ...
> +(
> +- for (i = 0; i < src_ptr->nr; i++) { strvec_push(dst, src_ptr->v[i]); }
> ++ strvec_pushv(dst, src_ptr->v);
> +|
> +- for (i = 0; i < src_arr.nr; i++) { strvec_push(dst, src_arr.v[i]); }
> ++ strvec_pushv(dst, src_arr.v);
> +)

It is a bit unfortunate that we need to write these four cases separately.

> +@ unused_loop_index extends separate_loop_index @
> +@@
> +  {
> +  ...
> +- T i;
> +  ... when != i
> +  }

I do not grok this one (not an objection, but a statement of fact
that I have to look up what "when !=" is doing there and I haven't).

> +@ depends on unused_loop_index @
> +@@
> +  if (...)
> +- {
> +  strvec_pushv(...);
> +- }

This is a bit questionable, in that we would probably want to remove
excess {} around any simple single-statement block, and not limited
to a call to strvec_pushv().

I think it leads to a philosophical question: should Coccinelle
rules used in the context of this project aim to produce the ideal
result that does not require any human clean-up, or is it OK to make
humans notice there is a questionable construction without updating
it to the final ideal form?  I've been assuming the latter somehow
but I do not recall we had a discussion or decision on this point.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 6ecd468ef7..a32224ed02 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1024,12 +1024,8 @@ static int get_pack(struct fetch_pack_args *args,
>  				     fsck_msg_types.buf);
>  	}
>  
> -	if (index_pack_args) {
> -		int i;
> -
> -		for (i = 0; i < cmd.args.nr; i++)
> -			strvec_push(index_pack_args, cmd.args.v[i]);
> -	}
> +	if (index_pack_args)
> +		strvec_pushv(index_pack_args, cmd.args.v);

This does lead to a great result, and I presume that this is the
doing of the last two rules?
