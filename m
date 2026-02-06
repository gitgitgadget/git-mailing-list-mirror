Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC2D30E852
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393929; cv=none; b=KRErzwooyRDcNJ6tUUwAVkgG/t4Ph0rKvnVqbBnNC5mVW1vbT+L2GQfI5O/h95GeS2pNE9pyVG0jrdUeVlYftCM+u/o/i5sy4rwi+vxQkF6YTF50v/Z4qtoNgLv5ZeAlY/01D0I8DDdcY7lWnuzjUDpV54nh0MSVIIugaN3F/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393929; c=relaxed/simple;
	bh=V/5CvgHIUr6dp0e8XDOAD17B7FWqfp3L8RN13U3N3lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFun+w6gpQRzLzbbCPLTaFVuw7U4FPwsz727wvHGt4+Fe8QzUUrNO3FwTlPKlWDLIPu8PdWMF/GW+2QC4ElnvPklcM3w7555aHlE4V7NGHhMT4FPX2Aa2tHe5KQ2loTGqfjgPpEFgnti5Qkbjk5OpHnBNDJlAZuUaXbrsfXlRp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EaSf4+b4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UB/WKwIf; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EaSf4+b4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UB/WKwIf"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id E010A1D00128;
	Fri,  6 Feb 2026 11:05:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 06 Feb 2026 11:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770393928; x=1770480328; bh=YguYmCn3tx
	yUAfy/8AtVXyliYBhUCnC3UFslpvOGEQU=; b=EaSf4+b4etdm0ffKSwuBVunl1I
	DJqjSdNOK+ukMN0CMyatCflELPBDTmg+/6+9qAeAOfTJbUVmtoI5nKLnhrTk1Yl7
	VNnLyKO+CBW06KQllL4NuBqaDE02XaqWwXDcdsjOgVGmaaaz4nFfvoFwWeyXrfZz
	5aEeuOjf+bbZglfHr278x2PuFnWBLpSRPXnZDJVpI0jvKgszFWwvA4buKQXUJ1mo
	IBHlHPtJqTWiZq0MFonndtDVZ+Ihya477IRhXj2bNn+85A1CU2bG12Irf6Nv6TSg
	XXfYIkRscs19YhfhcdjSqiBQTXiqst/klJ+1+vv5VKQZY9a+mLKQoZokyCSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770393928; x=1770480328; bh=YguYmCn3txyUAfy/8AtVXyliYBhUCnC3UFs
	lpvOGEQU=; b=UB/WKwIfB4OJNb3VHzvN8YQe6iUXpDMHlorv/drPlEiLQruLy9r
	MnNGjeO5kkaEoYb3P5VUgorxAU/CsRefIust0MDEzCnbY5HUm91X61V5hjnrU/Fm
	vHDjLmUbBVSceBniqNYQEvfm9St9eeUYqTGfoZ4fKCqxLMDRWobUm/yUZ06Fe2KH
	58g4zc3o+pcxoW8OaDK0iDCQJ7NYfWkiDDROufnd3+8njNmxTakUjz3VLIOr+yxm
	aBaUTHkzXWRcRh/EYA+oeLo8P/2IsHahe9Eik5PwVBC1KgTk6vj7JjC9zQlIdpCa
	eHRqeykv+0DCTHJRwJJ5S5HufG7zsXwCFXA==
X-ME-Sender: <xms:SBGGaYJR4vc-diVwQKRadaKPpxHDO_QXi-1S-KDQpgQDXRgx_v1WIQ>
    <xme:SBGGafJAniOlQDTMvILofAcYYiaiMLw-_BGF7tM2wxY2LVWGDANOQVT2poFaHqRxj
    l_nBTINOc3BxNZOPu_t-QFKQoUqb0kZcSvMzB4PaC05C6OvRZjx>
X-ME-Received: <xmr:SBGGadsgvYE2U-L9PVm_rUMJpEUa74DcNKJao5S-rUSxq4XCVGL1C4MBqJ7Gu6elv1Wa0aQM4lbFPIG0m3zfmRp9nHIs6yzOVPFpXcyoPKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    hihqshhimhhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:SBGGaUTNDzaMz6CknM3GemiKFCwFpE7X3IS_I4QMbNIL93ChmoMZEw>
    <xmx:SBGGabOzFhfAebWh8jnAQ-Bj_VSOe9Wdxtce8_NR1kHF9bjc8nHA5w>
    <xmx:SBGGaRajt2vIFtmymathT84Ev_ulbImqQc03yltfm5zEMyNuuXTLTQ>
    <xmx:SBGGadxH6c0YexGnHY9uttt4-CxjD3iRtSjKLfrNzlQT749vqaWVJw>
    <xmx:SBGGaQ64Zs3BXzgLEik4-7KDlgdPuDOq-bKAIffDtplgCrzuOim13PQo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 11:05:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9991cd09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 16:05:27 +0000 (UTC)
Date: Fri, 6 Feb 2026 17:05:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Simon Cheng <cyqsimon@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 2/2] checkout: tell "parse_remote_branch" which
 command is calling it
Message-ID: <aYYRRBdCrbWmy1Gj@pks.im>
References: <20260127192936.904719-1-gitster@pobox.com>
 <20260129190616.645471-1-gitster@pobox.com>
 <20260129190616.645471-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129190616.645471-3-gitster@pobox.com>

On Thu, Jan 29, 2026 at 11:06:16AM -0800, Junio C Hamano wrote:
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 4f189fde48..17f31c30b2 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1299,14 +1300,30 @@ static char *parse_remote_branch(const char *arg,
>  
>  	if (!remote && num_matches > 1) {
>  	    if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
> +		    const char *cmdname;
> +
> +		    switch (which_command) {
> +		    case CHECKOUT_CHECKOUT:
> +			    cmdname = "checkout";
> +			    break;
> +		    case CHECKOUT_SWITCH:
> +			    cmdname = "switch";
> +			    break;
> +		    default:
> +			    BUG("command <%d> should not reach parse_remote_branch",
> +				which_command);
> +			    break;
> +		    }

`parse_remote_branch()` is only called by `parse_branchname_arg()`,
which in turn is only called if `opts->accept_ref` is truish. And as
that value only gets set to 1 in git-checkout(1) and git-switch(1) we
know that we indeed don't have to care about git-restore(1).

>  		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
>  			     "you can do so by fully qualifying the name with the --track option:\n"
>  			     "\n"
> -			     "    git checkout --track origin/<name>\n"
> +			     "    git %s --track origin/<name>\n"
>  			     "\n"
>  			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
>  			     "one remote, e.g. the 'origin' remote, consider setting\n"
> -			     "checkout.defaultRemote=origin in your config."));
> +			     "checkout.defaultRemote=origin in your config."),
> +			   cmdname);
>  	    }
>  
>  	    die(_("'%s' matched multiple (%d) remote tracking branches"),

Yup, makes sense.

Overall this patch series looks good to me. There's been the one
micronit in the preceding commit, but I really don't think it warrants
a new version.

Thanks!

Patrick
