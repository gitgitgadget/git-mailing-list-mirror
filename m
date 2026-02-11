Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8673338F45
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770812032; cv=none; b=TbsRXh2lcajGJEPGAOX7nciEQUf2ZSjTXLbe58hvA104dCtSFdSws9waATCEU1odKHAIbk3pWW+peLz1rNtP5teDWqeIofatGUDyNfEbjlKy5cIFmo78974DLmjj4EBYyDsTLDm1gnfEv/tnfDTPSq7jgTyLar1XjPHOfSISQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770812032; c=relaxed/simple;
	bh=EbFpQ2XXAjLq3YxPA2lGvcfZEXtcHg3L9H18Dcm59Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/yk/QwxMmtquDruNMnde46etUsoBjSCvYmrSrMYwAewdeZwv9+LvAqwxGYYCTYEbzaJ0DHoRTevUf1+jcXUHqEUAiu2PbFpm+QU9hLHTExYK4TFiS+m0loeS0lyJhQTHigYgL+PbQIOGm2zcICpo9qoKv6LoennsUUXP2r9mGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gXPMHiMm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oeq+RQ+s; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gXPMHiMm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oeq+RQ+s"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A8D07A0045;
	Wed, 11 Feb 2026 07:13:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Feb 2026 07:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770812029; x=1770898429; bh=ZNLM4R+n6f
	PiUqHf+ww0bMzuECREo/EFeA9Zf4/ijZg=; b=gXPMHiMmGyfMoUBxASYOb0mEHQ
	eZdoMPn00FxfAgSl0Kgr09ASmmsUk8lqojmrKoPP0FriRW7Kw28e8Rd2hsfROb93
	a/FVB0aHVT2OIvsdpnHBGOf+MgqBKm17GXRakwkzBECV4VrjK0f0x+yJJMXOdg8I
	fNo4vSP2Tpx75QbbyUSrtT7NxtKnECVFRtHuDXok0/Fjk8H6GIpoeV48YqtS9Duy
	L+4tfYubzjwGkFM6/hu5IiMymoPRk5UOfH8TagtiAWWzCkp6GCg9YSKSlkHZdtKY
	vtKvVeKira2RGKByeiTjwnd2MITV52ImkhUBbaYWZdNOKW90X8LBj1O2tDlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770812029; x=1770898429; bh=ZNLM4R+n6fPiUqHf+ww0bMzuECREo/EFeA9
	Zf4/ijZg=; b=oeq+RQ+sHWXSl1OPM3z0mKtUDb3ttLBlqcIMgQyx7AhZ6XMa0+S
	pMv7Qk3qYRMoUgjhkcmWvb+pcMNEvImt7mbzHCL7gKb5OCup9XC5bQKr06Jd7iOj
	Ib12dhWuu1c63Y9HkIIcx+bZoe5+02s/TF1oQLwJ70WX32sKuKoZ60NbNocbabaZ
	6IcV259nysAVINORrC4xYbQLTxX8PzKp8BxwnNrxFMkc9x1ZKLNJKfTXglpw4U0/
	SY2N73+GBbLN6Ao7MxTlYDrdSkJfFJaajZnZUz2Rc7cym1Ch1/tmQGYke/6TQiVO
	7johrG36pqGtpQUgU9AvkGFME+pMl3WLvxA==
X-ME-Sender: <xms:fXKMaeXb2ZHYVfrjTKX9D_KriQSCTyJTBsqs7u9LKc3SlzcSBgQS2A>
    <xme:fXKMaZpZ17C0lkbcbQyifhk9au38iS4qnxS7byCX0QurLY6v5Yv754U5ozUfgVYvI
    bsPwAQ4T8RbUOuvCPncn0yQh_IN3DlyI9bCnuhT16wgH927Mkf2x0U>
X-ME-Received: <xmr:fXKMaYlAtn-eLWG3mO7yhFBLYNynUiM1R52OjeYYAvqkDMmwkUDjZpMlaei1LB0jv__3HisTh8-OUo0dm5DQiMwpWU_A-3tPamUqiq9q2ei->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:fXKMaR2uyd-iPXuq1RPQK0zramm2X4cyCqsHcCri6MjXLkyM1igvuw>
    <xmx:fXKMadS-R0xoxY_YKTCfas9caq1d1gVR5Yc7Lv8uQnne1Sjl1uV8gg>
    <xmx:fXKMaSy2JpRVE3IrYGHef-CnIh3xmXNx_r3Uo1jcSi_41jk3cmzVtw>
    <xmx:fXKMaVBpenecyj4UZ1UD7wLEqeJfxFqX0664qF-xwqvRIkOvDIq0JQ>
    <xmx:fXKMaZtlZRnVUczYR9_lED7NGYL4p-NRqFDLVrnIXJ5VbVOvHLSOYDHb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 07:13:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d3e455bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 12:13:47 +0000 (UTC)
Date: Wed, 11 Feb 2026 13:13:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/5] config: make 'git config list --type=<X>' work
Message-ID: <aYxyeAQ_-9KXxI-L@pks.im>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <e27d52c4a5970f774e324b0a9c0badb0532bf3d4.1770698579.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e27d52c4a5970f774e324b0a9c0badb0532bf3d4.1770698579.git.gitgitgadget@gmail.com>

On Tue, Feb 10, 2026 at 04:42:59AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> Previously, the --type=<X> argument to 'git config list' was ignored and
> did nothing. Now, we add the use of format_config() to the
> show_all_config() function so each key-value pair is attempted to be
> parsed.
> 
> If there is an error in parsing, then the row is not output.

I was a bit surprised at first, but now that I think about it a bit more
I think this is sensible behaviour. If I ask for `git config list
--type=int`, then I don't want to see any non-int configuration. I
wouldn't even expect a warning, as the option essentially works like a
filter.

> This is a change in behavior! We are starting to respect an option that
> was previously ignored, leading to potential user confusion. This is
> probably still a good option, since the --type argument did not change
> behavior at all previously, so users can get the behavior they expect by
> removing the --type argument or adding the --no-type argument.

Yeah, I fully agree that this is a sensible change in behaviour. It is
obviously broken right now, so I would claim that this is simply a bug
fix.

> diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
> index ac3b536a15..5300dd4c51 100644
> --- a/Documentation/git-config.adoc
> +++ b/Documentation/git-config.adoc

The synopsis of `git config list` should also be amended.

> diff --git a/builtin/config.c b/builtin/config.c
> index e69b26af6a..c83514b4ff 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -363,21 +363,12 @@ static int show_all_config(const char *key_, const char *value_,
>  {
>  	const struct config_display_options *opts = cb;
>  	const struct key_value_info *kvi = ctx->kvi;
> +	struct strbuf formatted = STRBUF_INIT;
>  
> -	if (opts->show_origin || opts->show_scope) {
> -		struct strbuf buf = STRBUF_INIT;
> -		if (opts->show_scope)
> -			show_config_scope(opts, kvi, &buf);
> -		if (opts->show_origin)
> -			show_config_origin(opts, kvi, &buf);
> -		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
> -		fwrite(buf.buf, 1, buf.len, stdout);
> -		strbuf_release(&buf);
> -	}
> -	if (!opts->omit_values && value_)
> -		printf("%s%c%s%c", key_, opts->delim, value_, opts->term);
> -	else
> -		printf("%s%c", key_, opts->term);
> +	if (format_config(opts, &formatted, key_, value_, kvi, 0) >= 0)
> +		fwrite(formatted.buf, 1, formatted.len, stdout);
> +
> +	strbuf_release(&formatted);
>  	return 0;
>  }
>  

I wonder whether there is a good argument to be made here that we should
keep the old logic in case no "--type=" parameter was given. In that
case, for example the following output would remain the same:

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 9850fcd5b5..b5ce900126 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -2459,9 +2459,10 @@ done
>  
>  cat >.git/config <<-\EOF &&
>  [section]
> -foo = true
> +foo = True
>  number = 10
>  big = 1M
> +path = ~/dir
>  EOF
>  
>  test_expect_success 'identical modern --type specifiers are allowed' '

I'm not really sure whether we want that though. I actually like that
this also leads to some code duplication, so maybe this is fine?

Patrick
