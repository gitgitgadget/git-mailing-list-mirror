Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2B19A2B0
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612130; cv=none; b=k7Znl2/KbDndGXKz8r9k3u7Qm0UnG22U6ReU2rWyNwTHr6bs4TCk0SguR3w7nWw7Amn5Ol11epGV/cx3R5KSgAam8plhmP6kiR+C4DOJbPJCI3+Nqgc83mgBYOVATO6jfronsGVCCAaFwtIX3OyUr6xAwxenRrdYjHt3UtsZlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612130; c=relaxed/simple;
	bh=CYWFMbm7NtZ2MUzbmWzb1oCbaR6ruzi5/c07NK4crIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIvwiR0OdN1+jQUMpu3L2J/kOPPWNdn+K5T8gY7SsM2rlOl15C9DfLaPC7oABF9cy4pxYEhtWo4lAChEWPu54Sobz64cMhINx8LsrYRKhnIsZ49UV1sQvhgEU7oguybl4sgmP+ISEyD14rPYTg6RV5daxXaTwL7rkHGBpSchAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dXrIv+13; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RQkEyDYM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dXrIv+13";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RQkEyDYM"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 30FD313806CC;
	Tue, 26 Nov 2024 04:08:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 26 Nov 2024 04:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732612127; x=1732698527; bh=tEuJJtj/W+
	KG64/nkUrRcgfRUT0iA4xsIKNke5523xs=; b=dXrIv+13PLYYtCOwbgjxrgQHc/
	X4eWluT0nO3FbkvVELZlnMYSxTBra/DVr8f2oUz4EvVY4Z0huFJLwRZHXrhoUFT9
	irw6VFa18tLMAR0CIJjmWJUI87NxIVATd6tm8w0Dp+aY5ULx6uPpH0bJ+2o3g8YM
	JMHgDv79HsB/lRzgt3csnFcYb7/jf63+dIJ0qgGGKTbJ79JDLF123GEF1Ux8RCZt
	YjtGQeSDLBarwiQEBAdeZW9UhRamQUbQA/ifKUO9oRNYo0KMOhQkWz6/7NCEI+YX
	J+gadivDGV1g3V3P0J5Nqh2kS1d2iJajfFXm/BzeCwNmo5rph0FkRn3pxpMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732612127; x=1732698527; bh=tEuJJtj/W+KG64/nkUrRcgfRUT0iA4xsIKN
	ke5523xs=; b=RQkEyDYMVdUffsAIYF9ukB/hfEdBdfDvbGLh0SfWLXhn8qN1iZS
	F1TBCSxJp8O4uEEqmEfWaQ+q1yTgAsw2gD6ZOSOw5VDCSt/uBgSqtQdL6AtXh/YT
	/t09CFXJyjmgSUVPh9l4b/9ToXte/Ep+2FSQM4R8/2ZBINSH7bZxPupvw+X5s1SN
	lLv7pjzPxWMhm+Mz0/N8S5PJMiHa7ZnqSjnpUC8LE2DpkJAWSx4kdlhkm3uGvOyi
	FarJybRvc1oGuBM6ZFQEhtDS2wRtqVhmfA0eEa4x4QDo4I5dsmDbTtg1B9/AWVIW
	rQ08vPEIaZvYXVgHog7QYydmNnWJ/2T9x5Q==
X-ME-Sender: <xms:H5BFZ2tQU0udd13P-MRmhjdZzMmWwYDtaQ3MgjimTOSkOJrzp_gmrw>
    <xme:H5BFZ7d7UyE6DYCAtAltmaJe4T3cxd_ZEGFopH04EJVq9YATC-flLOygyWFpnO9Qm
    HIdDJ62vYF4rUl3kQ>
X-ME-Received: <xmr:H5BFZxxvxucAnSwU3qPz987mcvsvxNpq2WMv2ooTlXR2nRmrKEyoSEiQ_cI_qmP4NBCwHBm9C1uBlv8Tlpdn-q6JoryzGmirYjtNEnPXPa_Or9Mv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:H5BFZxPjA_IV8jeU66fJapgFneoQQYvhNH86NY6RiscVIXhwdg6Pag>
    <xmx:H5BFZ2-FcpWh4Hl7q3XxJJYxQLCFn-mtbdGYILd7S-e1a1cQnScBBw>
    <xmx:H5BFZ5Um30pNZc_nAYoHnBPxe8k6hyleNU8UmHoA7z6ZveaaczIzzA>
    <xmx:H5BFZ_fcppfRGMYPk1iPn72sPjCEIoZPuXSEvab8XNYPcrQiAwhsDA>
    <xmx:H5BFZ4IxeVvokoKCUaMlN890hl97dGtC97wcY838cinnSbYHg71eyFeR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 04:08:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d54e1c9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 09:07:42 +0000 (UTC)
Date: Tue, 26 Nov 2024 10:08:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] bundle: add bundle verification options type
Message-ID: <Z0WQC7mFvT4pKn0n@pks.im>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241121204119.1440773-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121204119.1440773-2-jltobler@gmail.com>

On Thu, Nov 21, 2024 at 02:41:15PM -0600, Justin Tobler wrote:
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 0df66e2872..ed3afcaeb3 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -361,12 +361,16 @@ static int copy_uri_to_file(const char *filename, const char *uri)
>  
>  static int unbundle_from_file(struct repository *r, const char *file)
>  {
> -	int result = 0;
> -	int bundle_fd;
> +	struct verify_bundle_opts opts = {
> +		.flags = VERIFY_BUNDLE_QUIET |
> +			 (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0)

This is missing its trailing comma.

> diff --git a/bundle.h b/bundle.h
> index 5ccc9a061a..bddf44c267 100644
> --- a/bundle.h
> +++ b/bundle.h
> @@ -39,6 +39,10 @@ enum verify_bundle_flags {
>  int verify_bundle(struct repository *r, struct bundle_header *header,
>  		  enum verify_bundle_flags flags);

Curious. I would have expected that `verify_bundle()` should receive the
full `verify_bundle_opts` because these are so similarly named. Like
this we have the weird situation where `unbundle()` seemingly receives
the options that are intended for `verify_bundle()`, but we never pass
them through in the first place.

> +struct verify_bundle_opts {
> +	enum verify_bundle_flags flags;
> +};
> +
>  /**
>   * Unbundle after reading the header with read_bundle_header().
>   *
> diff --git a/transport.c b/transport.c
> index 47fda6a773..7e0ec4adc9 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -176,6 +176,8 @@ static int fetch_refs_from_bundle(struct transport *transport,
>  				  int nr_heads UNUSED,
>  				  struct ref **to_fetch UNUSED)
>  {
> +	struct verify_bundle_opts opts = { .flags = fetch_pack_fsck_objects() ?
> +							    VERIFY_BUNDLE_FSCK : 0 };

This is weirdly formatted and should rather follow what you have done
further up in `unbundle_from_file()`.

Patrick
