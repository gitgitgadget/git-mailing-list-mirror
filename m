Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648292FBE12
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319122; cv=none; b=eIRwq/Im2u2OPiIZpqcwW6u4Hj28kWndT2oiRHOy+RlU3JiBNWmplcYugxKMUXnrCbZIp3CvQrH0TaZ04u4+6zNJXUK4W3ZpURwdoErIxramPFkSi6Ue8udxdtNKHpswJWKK5hkGCNzeK4LxPRfal01D9NC/YuxBLdNZXM4wkrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319122; c=relaxed/simple;
	bh=I9MbomeBx6o4FyJFMHWLcbLDhNuBj6T2jqALqLsSc4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0NllD3Qf/AfkiPADtPhW6Nmt0sPbVPe23ptPp/m767y4T33nUVyQhttEFjko+OJ49fuvXjuYv9fsxFS6X6AcvwOrcPk3PkzpvWZCHTJ/3tA7NUhhZRbzGla6+CGdc7/Do/+2qJ+MQj60ezq6w8dnd/ckTnqkg7HIBxMwSvU/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FTzyZRX8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K9WJbnDz; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FTzyZRX8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K9WJbnDz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 733AB7A0544;
	Tue, 17 Feb 2026 04:05:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 17 Feb 2026 04:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771319120; x=1771405520; bh=6R/CAzRJce
	LwQZIH6HtznUbf4Q8pM3CfXkLp7EfwhD4=; b=FTzyZRX8GamM2ntPG1631/NkLS
	bned6dqOIw997laNCg8C6VxWEdAMVxOOghOzqrxYeSAdY8LBED12Qqn/CpKuhlzY
	s7tSCLm8g/pgdACqQ64SNxpv2T9u/XyJn8XYiK9gkEsB5Sd8dvVjui+rswp5nYYT
	dVwcPcXRl1ALLWV9XeoljXRPMkRgLbt2eEmD7y5sRTosc4Z8LEbeCJPfW8TX2Vbx
	NnMhpFR/aLZ8hW9GvF1x+EDem0tsexz5x8ubree2PhwkamfbXmdzagWsPCT17bNL
	+scZCanyQBMgtRcV5iRHlS8xk5q7dmPg4LaoLQUr9lwiP0QmZJ2Ckd+A8Jyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771319120; x=1771405520; bh=6R/CAzRJceLwQZIH6HtznUbf4Q8pM3CfXkL
	p7EfwhD4=; b=K9WJbnDzr2B549qpUqugnYTM4h+GZ/wTVgA0c1HAieVCMo/f0jD
	SayWYkK9FWUKElc5EeYMutjzIhgAPFA+7pOWEGu+dtNswxpKSihmn6IVYhON+w3i
	gIFLZ3yFq/W2kUbUC/KDU+392YcL4KGXn2XELeiWuqDKKR6YNHUYdaDd800oqN1F
	GmgQYkiGTv9+WlxQRGLWFc/8TaZM848JWP48XQAzOQCH0GTlvCTMUBNwXhM480LV
	Ltnet4+3dhW8iVcFhzbTuWGHOQN+eu44HNCM3oZBOPwyOJJzANYAFB7jBpPTGOY5
	59SZxOxOQ9iSXr5ERjF4NFumoxAuDXOKY9A==
X-ME-Sender: <xms:UC-UaXsg2AS_RJkJfGbnx3N9AIM9_3-c9WgwwWaSPqz2FKVXiGsJKQ>
    <xme:UC-UaXhRAWfGpZMDveFpyva2MW7ENNB1pirVjAvYx1ygBeDppCroAU1r-ImGb1ZD8
    az_EH9TKlrF9olF48pfI9UKf2FqZqCHNkj3XnSb0xT6G4dtM9WmKA>
X-ME-Received: <xmr:UC-UaQ8-7shHnwqk3jqHAyCDCxY8jygXmOtTGv0A1vyALotUnN3XK6ASbF3QnmRN83wVSic55A9wOXQfel0XqAbhejhbocnHJrd_6uRu2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UC-UaSsE70X170XdSwPrJrQz9ON1EQ9EN_MpqrD5OZPT-u0owunsRA>
    <xmx:UC-Uacr2Zc4IkpZ2ocQAW3kLTgCJo5LCD_54A6Mc8A-Lh2nLbhhQUw>
    <xmx:UC-UaeqNEwzC8pIlKwh19xS25DtuuEhzGo7NurDQIi2m0P8-MzwSVg>
    <xmx:UC-UaTb5TvjTyhB_tCCbF65BS9Ts0LVHRF81ug6g5-H-jxyK6UMtKQ>
    <xmx:UC-UafEPqNbLahPhO8Y0HLzMRB-Jm3N0I-gXj4rcOgHQ_WxLW3immwTt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 04:05:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 510857fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 09:05:17 +0000 (UTC)
Date: Tue, 17 Feb 2026 10:05:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 09/13] config: format paths gently
Message-ID: <aZQvSvBEebHFf9Bb@pks.im>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
 <d1cfa0c5e1295d7b6655a0962bd47f8e89bc4a04.1771026918.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1cfa0c5e1295d7b6655a0962bd47f8e89bc4a04.1771026918.git.gitgitgadget@gmail.com>

On Fri, Feb 13, 2026 at 11:55:14PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/builtin/config.c b/builtin/config.c
> index 0c539ff98e..4664651dd2 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -314,6 +314,28 @@ static int format_config_bool_or_str(struct strbuf *buf,
>  	return 0;
>  }
>  
> +static int format_config_path(struct strbuf *buf,
> +			      const char *key_,
> +			      const char *value_,
> +			      int gently)
> +{
> +	char *v;
> +	if (gently) {
> +		if (git_parse_maybe_pathname(value_, &v) < 0)
> +			return -1;
> +	} else if (git_config_pathname(&v, key_, value_) < 0) {
> +		return -1;
> +	}
> +
> +	if (v)
> +		strbuf_addstr(buf, v);
> +	else
> +		return 1; /* :(optional)no-such-file */

Okay, this is the first callsite where we return a vaule `> 0`, if I see
correctly. But in `show_all_config()` we check for `res >= 0`, and if so
we would print the configuration regardless.

But `buf` will now be an empty string. So wouldn't this cause us to
print such an empty string, too? I'm not quite sure whether this
behaviour is intentional or not, or whether I'm missing something here.

In any case, I think this should be documented in the commit message.

Patrick
