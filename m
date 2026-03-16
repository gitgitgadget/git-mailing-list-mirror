Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21A139D
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647263; cv=none; b=YVYs6W5QRwnCW/Jbb4xYMarS1Q1pnUWAbgWpWMB2/DRbVmTMj6OVtd6hQ4V4SANQzXQyYA7FMwjgrcjdBhuG3qOXBP9cbyBVQgLiEpkNY9HBLT1lwLubeTT8mi1RhpjfP47AZ0cG2LvoeZoFi197jXSHShQnW7ef+hwIejS7iVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647263; c=relaxed/simple;
	bh=EGTWHxeZzuuJm1+bJE5JuBsxiiqL8xD/WmXK4z9BtuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs1l+VgWdYab5k4BIE6UQNMyYcADcyP2sljZhxjjggSGBEdjkbcympKx6h38z4FLkGwqGDraSuLs9UuA9H+cGIxg/Q7BAr5WJ9QdDU0GIGxHw3b992r7fKj9u/nPz/PElaU8gaNgdRcljWpUOlKmfrF/FpFWiFFDo3yHL0HeXY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Oke3C0Sy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=25Wg76fO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oke3C0Sy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="25Wg76fO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26D8B1400164;
	Mon, 16 Mar 2026 03:47:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 16 Mar 2026 03:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773647261; x=1773733661; bh=PXzexQcntJ
	Bn3YUMM1XvDBM6+V0A7UnoRoj09CUPuIQ=; b=Oke3C0SysU2wHkqR8BuQEsJhiv
	qY3KvA32R/7kcKK3Y2M6Y3wQwxnKD+Beplig6r++E8ddeYQmnYx456mDiEK/0der
	WlA8sm8/tMTHzKl2KcNIVka7oJ6AmTLv9YxE1YYso0nHx9U1z8hhGPOUcRVUmmiH
	jUEdBcOZ5JbxCv0wePPDBwSUnSzuQ1bdvowPHm5Rs+XUlqsOqE1mSMbrOzuxW+5R
	i+agAqb9I+hDBircAsbaJrccXbOi9CxOTTa7av3MlxweTBQtgGHE4XqmDWHiL5Ke
	jB6SV++zVT3dMSc7SRbCC7kR9BwB68mLJhntGveo1JacWRsOjYKREoIu6+yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773647261; x=1773733661; bh=PXzexQcntJBn3YUMM1XvDBM6+V0A7UnoRoj
	09CUPuIQ=; b=25Wg76fOmvoLw3SKi8P0dFDscalWTuiv8bCDUQxLXdDc4fGZ2Qy
	HbtvAY/RwaktpssN8XVkvNNpkIHm7AGz2rYrdKZLYP8gFr6NOC0EzMk0YKnux3n2
	ik+YPNJhq2jsalxRIacUl2Gu+/VHUhrB5gdDEcCx9em5+tpIGUa3qoQS41JfKD/d
	T+aSOaGfhDfBZJ8Pdtu9CfS5S/IuvlGBxCvDJLaqNbTtA8cRbL7mWPz4AsBD3/Dz
	SL3p7Ato6/LMFmnu4dI/ngiTPRci1FnvL9JfzF2t9sVISx/VCCQhzaO1FR+oYDbE
	+bYMCa1QI6JYqantJULDo6vrWB+bKUccEog==
X-ME-Sender: <xms:nLW3aeLXPK5bkJutJQ5SAfD1CuQorjV3N_7MK6qbfeMqgtx_B14rrA>
    <xme:nLW3aYvX6AwHvCwDwZw1QBppfPYQu2zGw7KGAfy_dlvBPLs94-Iwwcw6bWdzwLDZf
    -XDLr7t5I58F8PvmZaB90OxyGrBDtjcOFNKIVjeSeHLx-mNviw9eg>
X-ME-Received: <xmr:nLW3aSV9DHb-G1YpV9RHOtffzOAZy0qr5Nbq5zbU6_ESOwnRkGZQP6fBXU0cg52Bbik-FAAPt-sNEYMgSsGeyrGyRbMaOs5vdX8X8zX601s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgrnhessghr
    rghithhhfigrihhtvgdruggvvhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:nLW3aTg8af3Ay1Czw70egVTJWReX0kDBBWelrXXJAAalVI81FCptYQ>
    <xmx:nLW3aaojCQeZgwPRSwoRxmkKco0z3wOp6lLM2-960O6_GtSw7TG2ag>
    <xmx:nLW3aZGhSJM3q1qSL6p9x0q35sYzwSX5kfSoxg35nPB7iMihsY0dEg>
    <xmx:nLW3af4MyG8PKphZhMcRE3QvQRhK7XPjnPTu0RBTpES5j4fQghSYXw>
    <xmx:nbW3aaKNiDiIACUDQkjftRk8Phm0L06AMqmSE3iYYl6ah3lug7fauucE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 03:47:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c80d7947 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 07:47:37 +0000 (UTC)
Date: Mon, 16 Mar 2026 08:47:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Alan Braithwaite via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	jonathantanmy@google.com, me@ttaylorr.com, gitster@pobox.com,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Alan Braithwaite <alan@braithwaite.dev>
Subject: Re: [PATCH v6] clone: add clone.<url>.defaultObjectFilter config
Message-ID: <abe1l8ONmFIhzaxi@pks.im>
References: <pull.2058.v5.git.1772847236966.gitgitgadget@gmail.com>
 <pull.2058.v6.git.1773553022381.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2058.v6.git.1773553022381.gitgitgadget@gmail.com>

On Sun, Mar 15, 2026 at 05:37:02AM +0000, Alan Braithwaite via GitGitGadget wrote:
>  1:  fa1ea69bdb ! 1:  480453b2e7 clone: add clone.<url>.defaultObjectFilter config
>      @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
>       +test_expect_success 'setup for clone.defaultObjectFilter tests' '
>       +	git init default-filter-src &&
>       +	echo "small" >default-filter-src/small.txt &&
>      -+	dd if=/dev/zero of=default-filter-src/large.bin bs=1024 count=100 2>/dev/null &&
>       +	git -C default-filter-src add . &&
>       +	git -C default-filter-src commit -m "initial" &&
>       +

As Junio already pointed out, this change here is a bit puzzling. Not
that I think it's a problem, but one wonders why this existed in the
first place if it seemed to not be necessary.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 45d8fa0eed..18316a7da9 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -757,6 +758,51 @@ static int git_clone_config(const char *k, const char *v,
>  	return git_default_config(k, v, ctx, cb);
>  }
>  
> +static int clone_filter_collect(const char *var, const char *value,
> +				const struct config_context *ctx UNUSED,
> +				void *cb)
> +{
> +	char **filter_spec_p = cb;
> +
> +	if (!strcmp(var, "clone.defaultobjectfilter")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		free(*filter_spec_p);
> +		*filter_spec_p = xstrdup(value);
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Look up clone.defaultObjectFilter or clone.<url>.defaultObjectFilter
> + * using the urlmatch infrastructure.  A URL-qualified entry that matches
> + * the clone URL takes precedence over the bare form, following the same
> + * rules as http.<url>.* configuration variables.
> + */
> +static char *get_default_object_filter(const char *url)
> +{
> +	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
> +	char *filter_spec = NULL;
> +	char *normalized_url;
> +
> +	config.section = "clone";
> +	config.key = "defaultobjectfilter";
> +	config.collect_fn = clone_filter_collect;
> +	config.cb = &filter_spec;
> +
> +	normalized_url = url_normalize(url, &config.url);
> +	if (!normalized_url) {
> +		urlmatch_config_release(&config);
> +		return NULL;
> +	}

We haven't allocated anything, right? So in theory, we should be able to
return early without calling `urlmatch_config_release()`. This could be
stressed further by moving the error path earlier, so that it's the
first thing we do in the function.

Patrick
