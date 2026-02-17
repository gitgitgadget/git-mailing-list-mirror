Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE22D7397
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319107; cv=none; b=TNyiTPbLzqLQKt8/TE84JmFXDoIdr/lqkckGlv0hCwfDzKvAr/VhCvPcOM+9IYvYUfNgllEMcc4SxMdMzYAEsryLx5t4HAPt53vOHCu3fxzaiO+XfFT4mj6p+h2yCyakQEJ9fAVeq46yymb+RxCPM99yFmxpV9iuK6KMzQZrHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319107; c=relaxed/simple;
	bh=Vwe0/Dwvnei4B6Gw9EudUIQFtFs9J/gE973gH1mWZWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ph49PAsGCkfmtW9/tjv5EDmsorfb+o/KEnRLo2Xm9yPned/IaHxmHoqv1/4yT7cjx0IRSZ4+1ytQSS2XUL774PaIr5SOTTLx2jeUxYNHSy62ClATQf9GuiT9x3eO6P3UiKIKSNm4rHOg2XIXYF13xH6p8L9OGnPeTG8U8N0EQ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=borTD/Vu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZrbrDnQ9; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="borTD/Vu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZrbrDnQ9"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id BBA361D00124;
	Tue, 17 Feb 2026 04:05:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 17 Feb 2026 04:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771319105; x=1771405505; bh=LKGHA631zR
	PAFS8EC4EAH3tDSEWNQld9FA4GIECs2YE=; b=borTD/Vutfz4sQCeV530aFHUB1
	vWeTCmJQ/P0oPZoWIedrbMzgs4sd/3qUcRCYmnOS6ex/zcTiwfc7/PNR8hKyug9v
	0ZKg66+9uJ74uH0lbCbR6YSfh16f1xzlutQcTqVNw5ZGuG9F45LOJbWbn/pZgkMj
	VJkSgjaM/Ib4nrP7RJsDw3cot9rU7tOTYSc5DyZJAK0rL40cMul842r1b/LxS/df
	AbEJj/WxwcUbqfQejx7tT1phk01tsxZvtaSG7xyek8D63kLz5K/zl5Ing0Iy5f+u
	gE6M+7nQ+WvOgVNU6vxsYUPeosSk6/K8TxPtN/K475BcoChwG7oa32EeaglQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771319105; x=1771405505; bh=LKGHA631zRPAFS8EC4EAH3tDSEWNQld9FA4
	GIECs2YE=; b=ZrbrDnQ9g639YSoKPvgU1+201RxlAZgD2I9AkPLhlGrZlu27h60
	lxEEw7g0KfGEvccuFmnRS6ed4cMxUDBlEb0hSrYvYqxg1AKX2iw/pP+XfcCSoe1M
	F3+QrhDOMD4vHAvNx/X5zsczYAdiIvHMFIr99dvLLlBignWJxJ/YUyIMY7ilOyL0
	KU72N/Vaby5+gAIymd3xVr6RtDU75tpAO8R8+ne9qGgIddHe7fyFjWNTDB9BA3Lh
	BPUBvHDHUvV8U8e8BDb4GVotmKvVSv8lKoToGG3oUp9DNYt1nDXfnRHagxk6Srok
	/ZQ86vA9ktgGGuwnTalk7w1kgoGjV9gA0Kg==
X-ME-Sender: <xms:QS-UaXo2_Quxzh2gyCdMK0GfO6aaIXFBu3tHmeU6byfqDDlU8wnkrg>
    <xme:QS-UaQvJoiy2ts4uRt3NNVOH2F9vTWJt352D_2JvpadJmEhYTOhnid0pLYyr1mwTD
    qmu2dvcLFStH_uRIRaiyqySzkDEVD0yIY4lf2T2_wOzHvn5EECtyRM>
X-ME-Received: <xmr:QS-UaaY5oLVe6YmzYLxWyQGrqVQkFUkpEf55YycZNfCw80HZ62FZ_qIN4mJGfLlvTQGbyjreZE-czxfJfD9h5kPosmRm-5otXMY4uzcSsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:QS-UaXbN9NZK-kEmqDRezLFjWDJ3nuNa7_XQ3iiLeZIqD72kTUEU6Q>
    <xmx:QS-UabkN2lsqde4n3l4orSvZoy6V2omftJY0n-5oFY-S1Gxp3T5CUA>
    <xmx:QS-Uaa0LcPkIWJ_oPSjUy7WtiIJpzVRAFK1ulOsCl9TOFUtVk7gFQg>
    <xmx:QS-UaT23cSs3WMm0ifAhKgz40AdzqwCZgyGcyhockGwOvrP2XTtGBg>
    <xmx:QS-UaVAZF4EIR-Os0XivGehvWrv46mdJWozbqFadOKnacg5ALPQqChx9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 04:05:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 80821318 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 09:05:01 +0000 (UTC)
Date: Tue, 17 Feb 2026 10:04:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 02/13] config: add 'gently' parameter to
 format_config()
Message-ID: <aZQvOrNOjqiJSRC5@pks.im>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
 <93c94a1b257d26a23942e902630c220e4a4f8eaf.1771026918.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93c94a1b257d26a23942e902630c220e4a4f8eaf.1771026918.git.gitgitgadget@gmail.com>

On Fri, Feb 13, 2026 at 11:55:07PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/builtin/config.c b/builtin/config.c
> index 237f7a934d..b4c4228311 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -242,10 +242,14 @@ struct strbuf_list {
>   * append it into strbuf `buf`.  Returns a negative value on failure,
>   * 0 on success, 1 on a missing optional value (i.e., telling the
>   * caller to pretend that <key_,value_> did not exist).
> + *
> + * Note: 'gently' is currently ignored, but will be implemented in
> + * a future change.
>   */
>  static int format_config(const struct config_display_options *opts,
>  			 struct strbuf *buf, const char *key_,
> -			 const char *value_, const struct key_value_info *kvi)
> +			 const char *value_, const struct key_value_info *kvi,
> +			 int gently UNUSED)

I'd propose to either make this a bool, or turn it into an enum flag so
that it becomes easier to see at the callsite what the magic "true" or
"1" means:

    enum format_config_flags {
        /*
         * Do not die in case the value cannot be parsed properly, but
         * return an error instead.
         */
        FORMAT_CONFIG_GENTLY = (1 << 0),
    };

    format_config(opts, buf, key, value, kv, FORMAT_CONFIG_GENTLY);

I personally prefer this option over using a bool, even though it's a
bit more verbose.

Patrick
