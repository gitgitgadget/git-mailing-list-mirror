Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540713B6BE5
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867084; cv=none; b=WOtuH6LMfPyBJAWeIKpy6owab6Nwi4/50K0Ww09K8mSAx09drlF73UYnlpuNnO6ZJIjB87XKklcXY8yYI9QR9QU04Uagc4GuOuU5+p3Bkp3UzGa1xXAwFUdLaQ+51EtNz4D2eWzrDQd/+tUaGJ2HwKChSs12iU3UjG+Lqau2brQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867084; c=relaxed/simple;
	bh=osq7YVu7PAGlt+Bm9XAgUyECe0AaJUG58nnd9nAb99I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mG6KJ3uev7P2mQlLJBI/4WGWEihf7xBCPb8Elo+Ub3AkxCBxQI9XXSRG0q0HlE27tGKkJuS2l4xNEkAd138Kg678B8N4ObXZiEs3w4+wHHAF7tDs5/0baSFZV/++dkGAYWm/r8Y9xnWhfWp5sEiS0+FSOTQAgt8LG7Dx9BF5fPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dz022Ba+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O1/9W4Tj; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dz022Ba+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O1/9W4Tj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 13B861D002A5;
	Mon, 30 Mar 2026 06:38:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 06:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774867079; x=1774953479; bh=bBEVf1yuWJ
	fbkxZ+wkw74XKv40kprWZEqHIqig4VowE=; b=dz022Ba+jkW766ClYslJV0zGC0
	xNJr21t7kjp1SfGOalBk5pXw2vK0hhVAO1kUKBi51JsFYhsJNVYOmL25XTlceYTD
	Q9za1K5GQA7e9aXsE6w8eu3AqYc1f1gJiBxJxKX3thQkU+Ym6iF9Cp2wrM7sQkwl
	PPGAYZiJNFm3SC43FL9w6ExPTg/uX3d3yowoFPVgeFhT1MMmeGzqnOIga9TVliRO
	Ixw3CuvAq7NdYVfC8c+/cLvDAOmEWRoV7XnBF1/m/IIljen22/whlBBSiDNEblGT
	IMDRS3A2NPDtHAmSIlYbcsSi88bWXWmAHnvcWVT9Mgl4PvfkSR82pHxxP7Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774867079; x=1774953479; bh=bBEVf1yuWJfbkxZ+wkw74XKv40kprWZEqHI
	qig4VowE=; b=O1/9W4TjXD4n70ri9Mzhl7+2H/ngNKsun8pcJuB7uzY79nhLwQB
	8vaWP+DcIfQtX3wJijR7Hy2RkB8CyQyPLKhRRQkddC9h4/HRN1OV2OV8YyU90Q73
	QtQpyTDJ8MnMa9G0eGKRp6uuiLUBdKpx8znSmWdJ5d0iY53xKyUmgMG9vKOGXfDA
	xDXh1d/rYOW2hScagAL71Jb9BIFd+XAR3xmPE27BuNK0K+NCVbXTTMBLzzauF+02
	Qt2UthAS3h6psNmeuzbQm6KTh382mac3AtKA9byxo/16TNjSp8NpHH3pVkX2wU5O
	ngYlIJxMMufKMRqD7xMzSQx33SEdkfjcspg==
X-ME-Sender: <xms:h1LKaW7ZAVYOVxb8owqAOrL_8YiedznUyGDq131Xnvep09SvKq6CnQ>
    <xme:h1LKaTmp-xRtns1ioGj-bNwTJVPP1WrK7id218Gm49rZNDILcsXgoPgiDr0oNs-Ct
    figismHFlYwKWz2u0NFLb0NdXC-cd9C6131bOMWeZ5SbbD_1gtw0A>
X-ME-Received: <xmr:h1LKafSdf8DX-qIfL2WpMT4EcXlrdrhfxD80R3e2Zj5xgVTChgScYJuanTqMB4y0a3a9ert8zsXrYMLVJZEgQK6de0L_7is3jYuuNjKihurxQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdr
    tghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:h1LKaaHoHLfGlIn7YCEp777wS-C-iFdGxC1nBegvS7OXTo5XFAUtNg>
    <xmx:h1LKacGBMWnURzffHrLuIvG0AHPMUjc-6RzEiZAkZBVkVV-Hgl7dVg>
    <xmx:h1LKaQTEw88G0efeiX30e9j3K7Eqt_4HB8fRDuyWSesTWsH0ydcT5g>
    <xmx:h1LKaVKELpIOOa_EyFyQO6wdO4zLrB4CS-TRC5SttB73xkWrZg55SA>
    <xmx:h1LKaf9ZP06iBuUx2wBGL2Me09DWOVX7ZIIOcGgAjn_eXVWLgCNRaVBJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 06:37:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc59d9cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Mar 2026 10:37:56 +0000 (UTC)
Date: Mon, 30 Mar 2026 12:37:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, christian.couder@gmail.com,
	gitster@pobox.com, toon@iotcl.com
Subject: Re: [PATCH v2 1/1] cat-file: add mailmap subcommand to
 --batch-command
Message-ID: <acpSgZ8RgBIE-h1Q@pks.im>
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-2-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329082808.12609-2-siddharthasthana31@gmail.com>

On Sun, Mar 29, 2026 at 01:58:08PM +0530, Siddharth Asthana wrote:
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b6f12f41d6..a53926d2bb 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -692,6 +693,24 @@ static void parse_cmd_info(struct batch_options *opt,
>  	batch_one_object(line, output, opt, data);
>  }
>  
> +static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
> +			      const char *line,
> +			      struct strbuf *output UNUSED,
> +			      struct expand_data *data UNUSED)
> +{
> +	if (!strcmp(line, "yes")) {
> +		if (!mailmap_loaded) {
> +			read_mailmap(the_repository, &mailmap);
> +			mailmap_loaded = 1;
> +		}
> +		use_mailmap = 1;
> +	} else if (!strcmp(line, "no")) {
> +		use_mailmap = 0;
> +	} else {
> +		die(_("mailmap: unknown argument '%s', expected 'yes' or 'no'"), line);
> +	}
> +}

Not commenting on the overall chanegchange, but I guess we should use
`git_parse_maybe_bool()` here?

Patrick
