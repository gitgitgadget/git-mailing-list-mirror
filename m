Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079CC2D77F5
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771023900; cv=none; b=JMmC/FpJ+L7ugfqsmEI7Uz37XebB+MSNM3AgxazqobxuYpcR+VJ0688JeGw3F/drDBrTnAfyss8z9HDfMQVcXwdOFHFpspbJIR8QLVic82WTnLRBrtmMyDiDLQQw9dchuvIzczB6BVFmSWRPvVHj22XhwpTpZVBteoJ/Xax/xmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771023900; c=relaxed/simple;
	bh=xR+hl94P/oVecVH8cqRUoUfcVnOfTBHq+c3mvmziHBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QeSTgG2VBro09oGjCOG1spTNN2IoWW1cqvcMkIEYmX2Nq2s/D6ebkLZ0pJbcWXuZcpZlKf0AV2yg2AHOuPJ6QTq/14sKRBII6Wvux5GgHzY/8DPu1rmobbZ0T9+poUkqOxmTsLeGWj5EkuoSqqowdGVXdJQswbv7OckXomHhuhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HW0APuIR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZdEVkB7U; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HW0APuIR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZdEVkB7U"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C36A1D0009F;
	Fri, 13 Feb 2026 18:04:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 13 Feb 2026 18:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771023897; x=1771110297; bh=/Kp/pAcILL
	eYY+uMgHxT0DnP6DuNBw7ygILwFTXLrGU=; b=HW0APuIRJVuqZYSswfAr5l/tmp
	r0TXr88FbNpDvDKcAoCml8fR3ItO9ibLAIMdfp45hc/5mAiNCRHTqEX9jOvKZEt5
	lrB6KQOp7pz9/ms8x/oZKKDFRhVg9s1qWBYfeJvARriuluVTnE4ZFiq7H9HvI9pr
	0XXLm/A5SzdunDZVRixycntXq/xFDWxq02+EmdCs7XVJVdG+J2Vdc+PA0G/rkLUa
	znMSGg1GH0zpkLpAKn41uJkxX9Cz7y32RLc7odISk+cwJ2FcQQbp8Rs9Dxl7EVuy
	UWYvs8KFwKCj9V5zth9llVuuMYcvN5HfI5/KNK63Dred7y3kFrBaHPW5whWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771023897; x=1771110297; bh=/Kp/pAcILLeYY+uMgHxT0DnP6DuNBw7ygIL
	wFTXLrGU=; b=ZdEVkB7UgAph5T8sL6QBIOrGXJh/Ai187Pv4GvOI0APZWiE1e/e
	UM9r8FH6Udd76JJu7XKHRMBR4PIYMGBhe+9t93rr2CC6nOxGKuJPrBpC53OTUzsf
	YpGLzyHrpA4mLrhiNE1FEzeF4UVUbMn0xZhlIemg54b/CAB2ui1ecmjuS071wwKl
	gc+3DfMWs7HWW7yPKywBoBL3DdxDE2q07GPV2fn5aSbMYiU+OYhTObzYuswrB45o
	B2jOslULPMMXSoD/8Rl4Y5KMQXIX4XRZa0HmShT6QHiEDS6iOTxRwiN9nm2JmCbD
	es/Zqux+gTHwsTDelVoMiUQUo2drNnYWYDw==
X-ME-Sender: <xms:Ga6PaQnEvJaEIX_auY2vAapkLw0UlYRygSI4if2K9osDg9lALjm7fw>
    <xme:Ga6Pabr4_AkkOH-nHTHkibvn_ln9VO8sHIUZ5uaoArMTGCCVzkd-h5kjGtf0bYDcn
    au3YTZVPqAtSlSIdbBC_SKtsOol5H5sI3N1LXaI9mNdppBALOqGFg>
X-ME-Received: <xmr:Ga6PaaA89udL05CPqM9ZeDleG2jmwqz4tdO7G1N0NE__5OQXxMcwZH4iNbQxiHMRJo_bdlMsxIT9kBDVAHrUxKQc4kjDLn0K6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdelhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Ga6PaWHNfdQYpj2iU7QuVLIW-m7fN_LRsKTM4kp-O_QajIIfosVd2A>
    <xmx:Ga6Pac0uDDpzEfAe4MqToHw2QvlxBq5vogHxbsAqHs9EL5KXuIL7fg>
    <xmx:Ga6PafPsNr8FyI1ILgM08hG5uqCHUC6Q4k5TDpKMw2dKMRhl-R8Aqw>
    <xmx:Ga6PaUZD4rYFX95O8twvw8ng_uW41Pm9Lvp6OYzCJsI80deRXAIjng>
    <xmx:Ga6PaT9ehIswQ_hC8zsMfeBdGj4rkU8aWPYg9-XIOoGrqZA-kbK0GTRj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 18:04:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>,  Lucas Seiki Oshiro
 <lucasseikioshiro@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v4 1/4] interactive -p: add new `--auto-advance` flag
In-Reply-To: <497ca5b43c84dc4d146a18899461cd02564c0268.1771015581.git.abrahamadekunle50@gmail.com>
	(Abraham Samuel Adekunle's message of "Fri, 13 Feb 2026 23:09:45
	+0100")
References: <cover.1771015581.git.abrahamadekunle50@gmail.com>
	<497ca5b43c84dc4d146a18899461cd02564c0268.1771015581.git.abrahamadekunle50@gmail.com>
Date: Fri, 13 Feb 2026 15:04:55 -0800
Message-ID: <xmqq4inkjld4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> When using the interactive add, reset, stash or checkout machinery,
> we do not have the option of reworking with a file when selecting
> hunks, because the session automatically advances to the next file
> or ends if we have just one file.
>
> Introduce the flag `--auto-advance` which auto advances by default,
> when interactively selecting patches with the '--patch' option.
> However, the `--no-auto-advance` option does not auto advance, thereby
> allowing users the option to rework with files.
>
> Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> ---
>  add-interactive.c     | 4 ++++
>  add-interactive.h     | 5 +++--
>  builtin/add.c         | 4 ++++
>  builtin/checkout.c    | 7 +++++++
>  builtin/reset.c       | 4 ++++
>  builtin/stash.c       | 8 ++++++++
>  t/t9902-completion.sh | 1 +
>  7 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/add-interactive.c b/add-interactive.c
> index 95ec5a89f8..c3a36cd11f 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -64,6 +64,7 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
>  	s->r = r;
>  	s->context = -1;
>  	s->interhunkcontext = -1;
> +	s->auto_advance = 1;
>  
>  	s->use_color_interactive = check_color_config(r, "color.interactive");
>  
> @@ -124,6 +125,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
>  			die(_("%s cannot be negative"), "--inter-hunk-context");
>  		s->interhunkcontext = add_p_opt->interhunkcontext;
>  	}
> +	if (!add_p_opt->auto_advance)
> +		s->auto_advance = 0;
>  }

I am confused.  Why do we need above two hunks in this function?
Wouldn't it suffice to do

	s->auto_advance = add_p_opt->auto_advance;

in the first hunk, instead of assigning 1 to it?

>  struct add_i_state {
>  	struct repository *r;
> @@ -28,7 +29,7 @@ struct add_i_state {
>  
>  	int use_single_key;
>  	char *interactive_diff_filter, *interactive_diff_algorithm;
> -	int context, interhunkcontext;
> +	int context, interhunkcontext, auto_advance;

Please don't do this.

The original is already bad to have two members on the same line,
but is tolerated as they represent somewhat related concepts.  The
auto_advance member has nothing to do with these two.


