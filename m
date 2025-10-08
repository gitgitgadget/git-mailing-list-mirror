Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17E23ABA1
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907689; cv=none; b=h36WJiEDJdNLlGxsenG7AY6kUsbXFU2A7fJMaNgZx8RHMQR0mLsulaBHzoomzwMwW3cL1gTZEjOsLhn47KpbWvzZNKl7n+KlaEUI9IeqmRyeBk6fFx3RSz6XbvlevhCxOQ1kqqldjcWI+M27bBmmqYF6SwxZ4x/f2Z+8ThqntUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907689; c=relaxed/simple;
	bh=S2TC6A8omlq68oyyDj1Jfa3VyuMAILZsa5gMzjIAjpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oiv38ji0z55uwcS0sHkkXUTkH0TAgiaobaRVftLCPB2gqxgSY8jEUAimsSPuMOVnG1dPxdz4KZpqAPjd7th7oWlGWQJcfLU6swL5Nx0fdQf4cDCylDBdGZHpTTnPtvfGDKvCOTLCh4s+7hWiOihWLd+7G/puo0CmVAHuXiUXG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LSpNyvs9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9Gjj0n0; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LSpNyvs9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9Gjj0n0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DD3E51D00050;
	Wed,  8 Oct 2025 03:14:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 08 Oct 2025 03:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759907685; x=1759994085; bh=ow8GOLDJXW
	N5zNIFAzrSxKetgW+c+oicMdyhcjGQ7Hc=; b=LSpNyvs9tPHdUpGLbPTILt/hQ6
	tuQOxjl2T+mMcGzoNeEQlU5Ux+rQSz3tyxGCoiHS58XJFPiBejn0bGAUVmeSxsSk
	Snv1LM12HB+ep+Q5tixxfhUGw5/xZjARsV62dUx8e9SAL41tYyoQDm9jLcqJNHpN
	ejjBsL8WNN93ah3zqMATfSeFdf9d81CAWZHsHW+Gt2GJDxbBGS/v31c9vdWqQITt
	vXT07zmLL2W8ZrgMI7Pke8R98K2hz5y+y3yuIDxxD05we1vh5sIWPg6YGtYkDXYq
	Fe2YSZzL9URITPdLfmdVuOfHSHJ5vWS/nT7Djo72fQ6/TdF6VFCHvGpXspVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759907685; x=1759994085; bh=ow8GOLDJXWN5zNIFAzrSxKetgW+c+oicMdy
	hcjGQ7Hc=; b=g9Gjj0n0U4O5RttLvY0WwQvWq/1pIRtCU4ov5/MXiBI+i9tcXk/
	3mmmGAKWNvqUyAQhHmzZB6Quz0LqChsu3o0fOnUNPbt8UUGpfXeKMtwOa0VeD6dg
	7HBUsRmcsZAxhB6xxDKxA8PaCKeHPMmajIItxkUg77YFiBOeBOkDAxxzEV+50u/e
	0phPXd0kBmhgzbctCC1OUoG6SawJxD6cX1GfKDir7e05wkdz0of9H4xjrhpTKP1T
	Dz5wt4jRpI0uxh7gqT+BhdVOIpgau2tg7TxRQJfpOw4r9nZGtFCOHO4xUqS79TKU
	xM15R0tj0qZQhCcrvgsj04SsMC+wFUNE48Q==
X-ME-Sender: <xms:ZQ_maIyQk-h2tdQblEWsj9Nu7n___H7h7oT0KNJNanXuzpyGwUmMRQ>
    <xme:ZQ_maJMRT9d80scUa7o-v69FBUY4DWlXwCX-kiCrU-zStcAl9iGcQh3hTIafrPnRE
    i0ELDliZBPh3egZbu9yqzCldpuAwOjIWwqH_V-hZJZxXeELnQJTd48>
X-ME-Received: <xmr:ZQ_maF-r4dgC46AJyR4F1cZj9zF_5MkxIT19D7EYc6qQArbl0jgualrF-EWPzcbw7d6aylrDxF6bz7t1UgS8fvkFBFs-VK2uCHDZ5Vez>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegthhhrihhstg
    hoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhs
    tghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:ZQ_maO7f353DgQcoJvxvjZLe86Xf0R_qCuzQVus24oyj9qhUZYuxhw>
    <xmx:ZQ_maD4qog_3kjMZfIkYwVblT4Wpw77p9G82HFoz0dgkZMQZObWhiw>
    <xmx:ZQ_maPoA65EWoeh16u8ZDFdsiKcDo74Pu5gJj8hFtT8_WrUlEhKXcA>
    <xmx:ZQ_maMPmGymEzSobXdt8Y7OZjzAcvMLIezRv_yqYgJCr65-OKrJVGw>
    <xmx:ZQ_maAgJmCkzqfsz0PoznoufB0F0q0kAstl4I94qrkeDSQlLY7x_H-LD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 03:14:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61ed6a4d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 07:14:43 +0000 (UTC)
Date: Wed, 8 Oct 2025 09:14:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/5] fast-import: add '--signed-tags=<mode>' option
Message-ID: <aOYPYEk5sT6b1kuS@pks.im>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-6-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007122958.1089680-6-christian.couder@gmail.com>

On Tue, Oct 07, 2025 at 02:29:58PM +0200, Christian Couder wrote:
> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
> index 85ed7a7270..b74179a6c8 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -66,6 +66,11 @@ fast-import stream! This option is enabled automatically for
>  remote-helpers that use the `import` capability, as they are
>  already trusted to run their own code.
>  
> +--signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
> +	Specify how to handle signed tags.  Behaves in the same way
> +	as the same option in linkgit:git-fast-export[1], except that
> +	default is 'verbatim' (instead of 'abort').
> +

Nit: I would've ordered this after "--signed-commits", mostly so that
these two are ordered alphabetically.

>  --signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
>  	Specify how to handle signed commits.  Behaves in the same way
>  	as the same option in linkgit:git-fast-export[1], except that
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 2010e78475..668c926db5 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2961,6 +2962,43 @@ static void parse_new_commit(const char *arg)
>  	b->last_commit = object_count_by_type[OBJ_COMMIT];
>  }
>  
> +static void handle_tag_signature(struct strbuf *msg, const char *name)
> +{
> +	size_t sig_offset = parse_signed_buffer(msg->buf, msg->len);
> +
> +	/* If there is no signature, there is nothing to do. */
> +	if (sig_offset >= msg->len)
> +		return;
> +
> +	switch (signed_tag_mode) {
> +
> +	/* First, modes that don't change anything */
> +	case SIGN_ABORT:
> +		die("encountered signed tag; use "
> +		    "--signed-tags=<mode> to handle it");

This message needs to be marked for translation.

> +	case SIGN_WARN_VERBATIM:
> +		warning(_("importing a tag signature verbatim for tag '%s'"), name);
> +			/* fallthru */

This comment is misindented.

> +	case SIGN_VERBATIM:
> +		/* Nothing to do, the signature will be put into the imported tag. */
> +		break;
> +
> +	/* Second, modes that remove the signature */
> +	case SIGN_WARN_STRIP:
> +		warning(_("stripping a tag signature for tag '%s'"), name);
> +			/* fallthru */

Same here, the comment is misindented.

> +	case SIGN_STRIP:
> +		/* Truncate the buffer to remove the signature */
> +		strbuf_setlen(msg, sig_offset);
> +		break;

I'm not familiar with the signature format, so it's probably a dumb
question: does the signature always extend until the end of the tag
message? Doesn't the tag message come after it?

Patrick
