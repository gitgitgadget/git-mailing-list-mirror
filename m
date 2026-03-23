Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B02283FE5
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280900; cv=none; b=iy3+oCOrTKcDzeEmK4RfjvMLfD9L4mDyqlxCGR8OgcvjpOfFAyDP0ZHr7/72taB268Hk7ZGTHaR0ndgSG+SSCm4a5PgUXI0rgunqmxSzEH651dPEtpNibQDEpMbeH/X3zUr/ol6hQr/UO2iz0pZcufsAvKwDtW2s1HoqU64QhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280900; c=relaxed/simple;
	bh=07GORW9nTLWfSMU1taXrhQPxiDEXKf920C2y+OE99SQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oHc0KPMfey1DezQ9aiAce+gY8St40hOL2SsDLkB/3maLkB1LLz4HIP8n8Q09kBLUgI2XiqL6BZ/WgfhvkuPsjymVj8JtRdd0ntuZE+Nv/qezxanefArlqEXeHfjWHA3kcrrYw+D67/xCNlGqlQhvT/PHwxxnoiCAL9jfuPeNeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cqsB66iQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=52y14/TA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cqsB66iQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="52y14/TA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C30B140024B;
	Mon, 23 Mar 2026 11:48:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 23 Mar 2026 11:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774280897; x=1774367297; bh=T37655rZrW
	vgnBm+hJpk1k1N6a/cdRUoj6emz04pX4g=; b=cqsB66iQSBNKqauoAAFMNVv+CF
	4n0SKZeoi3brNhDbZ3/PM9JD/t7j9c2aHjxh9SOWKDdx+4hUS0fnm3jcJVFWFewQ
	nnPYDr19CdpNNRFHtpTYPA5TDtbmZEExd+/A87VOswFcHREU+mzqJpXQRjzliCOG
	56np84zdUXyMO1v68+bEN0s9y2rkqErQgaRAGEe6u1HYh3J+TMzvSF8vHIBmmiv+
	jO3ZvNa8u5jQlvOt9lFI+jmCCORe5fTbuV8/FoFJ13JHIJPEWy75/a3GKRdo/bmH
	/v17taCmfK9efru4TEBDtfShQStoTpU40QwcRvGykJOCLB7TxyeL1MVDfXVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774280897; x=1774367297; bh=T37655rZrWvgnBm+hJpk1k1N6a/cdRUoj6e
	mz04pX4g=; b=52y14/TATCxj3YEFcYG7P7p5tf0tJAD63IDbfK69BA9+jgY+J/1
	q+2L7MxqJjy4wPd8AGRvm5j6RVosEdr56zb+H+rj6stEant+FspQmbctw9gNQhD/
	V4Hjaf0OWJORazPj+a1es682wKYfVrctglE7Qyi4Qcg6vnZVMTtGHbESof9f9anb
	yUsQJZam1XIvB4NTJz3taT58eUB0ix50qsxijRWMJSXW0BO0wsS69H/TrRgf4mV8
	ncA1+ptUo+C7VVu9CI/nJGI3pt/V0rYL/TyHdjR5rfajqHBOY6QpYU/0+Q494yit
	uIK0mCL+rBpYEn95mQlZ6JPl/6z7E9o0I1Q==
X-ME-Sender: <xms:wWDBaU-_HgYwHWbRm9ahePLBtDe9Gv_bgWx12BsVHbmf9hf8FDkYwg>
    <xme:wWDBaUJmnsv1tjeS9uVe4Lw0W-zbxS4oEkySn5nHfj6yNPjP76wVth3KAkYHRUVI8
    FmIpTrT0QQYNReLW44tAUSlJXOulgSrN_KpijIs_ftfcJ8xmKaIMw>
X-ME-Received: <xmr:wWDBaXbepre0QxGkPJI5A3uzJ3DGSf-7bByKB7lsvvs6I1LKUFfkpt5ZcVXNFUiV8PEXNFs1pvt70ezZJKz4NzCApi3ZzyLkUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeludduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:wWDBaeI_fW8HKVBJG9nWwTuaHt5UyLOv5YCdcOWuLCun8jSiag79lQ>
    <xmx:wWDBadC6ckpOlnwLG1OhUIWN5Y_Hu_rf8xinwyiv-WRg0QEpRw3caA>
    <xmx:wWDBabrrAWn1WKoY2vjQhprwQIh3ovQVdGVWVZdzcjQddG27skgJrA>
    <xmx:wWDBaQiE5XiRop2lc0xsSz3U-1RcWL6FCFYnE-uq6mPKp621Ke5Vgw>
    <xmx:wWDBaUQdJF6N0qbiHp6zwqJyUXnbk2Wd-JFbbAbmqzxikk2lxQ2Yyh8t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:48:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 02/12] fsck: initialize fsck options via a function
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-2-e8dc79bca651@pks.im>
	(Patrick Steinhardt's message of "Mon, 23 Mar 2026 16:02:53 +0100")
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
	<20260323-b4-pks-fsck-without-the-repository-v2-2-e8dc79bca651@pks.im>
Date: Mon, 23 Mar 2026 08:48:15 -0700
Message-ID: <xmqqqzpa5yyo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +void fsck_options_init(struct fsck_options *options,
> +		       enum fsck_options_type type)
> +{
> +	static const struct fsck_options defaults[] = {
> +		[FSCK_OPTIONS_DEFAULT] = {
> +			.skip_oids = OIDSET_INIT,
> +			.gitmodules_found = OIDSET_INIT,
> +			.gitmodules_done = OIDSET_INIT,
> +			.gitattributes_found = OIDSET_INIT,
> +			.gitattributes_done = OIDSET_INIT,
> +			.error_func = fsck_objects_error_function
> +		},
> +		[FSCK_OPTIONS_STRICT] = {
> +			.strict = 1,
> +			.gitmodules_found = OIDSET_INIT,
> +			.gitmodules_done = OIDSET_INIT,
> +			.gitattributes_found = OIDSET_INIT,
> +			.gitattributes_done = OIDSET_INIT,
> +			.error_func = fsck_objects_error_function,
> +		},
> +		[FSCK_OPTIONS_MISSING_GITMODULES] = {
> +			.strict = 1,
> +			.gitmodules_found = OIDSET_INIT,
> +			.gitmodules_done = OIDSET_INIT,
> +			.gitattributes_found = OIDSET_INIT,
> +			.gitattributes_done = OIDSET_INIT,
> +			.error_func = fsck_objects_error_cb_print_missing_gitmodules,
> +		},
> +		[FSCK_OPTIONS_REFS] = {
> +			.error_func = fsck_refs_error_function,
> +		},
> +	};
> +
> +	switch (type) {
> +	case FSCK_OPTIONS_DEFAULT:
> +	case FSCK_OPTIONS_STRICT:
> +	case FSCK_OPTIONS_MISSING_GITMODULES:
> +	case FSCK_OPTIONS_REFS:
> +		memcpy(options, &defaults[type], sizeof(*options));
> +		break;
> +	default:
> +		BUG("unknown fsck options type %d", type);
> +	}
> +}

Wow, nice reorganization that migrates the earlier definitions from
the header file.

By reusing these FSCK_OPTIONS_* names as an enum elements, we will
let the compiler catch if any other branch adds new uses of these
names with their original meaning, which is a nice touch, too.

>  void fsck_options_clear(struct fsck_options *options)
>  {
>  	free(options->msg_type);
> diff --git a/fsck.h b/fsck.h
> index 65ecbb7fe1..9c973b53b2 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -180,34 +180,6 @@ struct fsck_options {
>  	kh_oid_map_t *object_names;
>  };
>  
> -#define FSCK_OPTIONS_DEFAULT { \
> -	.skip_oids = OIDSET_INIT, \
> -	.gitmodules_found = OIDSET_INIT, \
> -	.gitmodules_done = OIDSET_INIT, \
> -	.gitattributes_found = OIDSET_INIT, \
> -	.gitattributes_done = OIDSET_INIT, \
> -	.error_func = fsck_objects_error_function \
> -}
> -#define FSCK_OPTIONS_STRICT { \
> -	.strict = 1, \
> -	.gitmodules_found = OIDSET_INIT, \
> -	.gitmodules_done = OIDSET_INIT, \
> -	.gitattributes_found = OIDSET_INIT, \
> -	.gitattributes_done = OIDSET_INIT, \
> -	.error_func = fsck_objects_error_function, \
> -}
> -#define FSCK_OPTIONS_MISSING_GITMODULES { \
> -	.strict = 1, \
> -	.gitmodules_found = OIDSET_INIT, \
> -	.gitmodules_done = OIDSET_INIT, \
> -	.gitattributes_found = OIDSET_INIT, \
> -	.gitattributes_done = OIDSET_INIT, \
> -	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
> -}
> -#define FSCK_REFS_OPTIONS_DEFAULT { \
> -	.error_func = fsck_refs_error_function, \
> -}
> -
>  /* descend in all linked child objects
>   * the return value is:
>   *    -1	error in processing the object
> @@ -255,6 +227,16 @@ int fsck_finish(struct fsck_options *options);
>   */
>  bool fsck_has_queued_checks(struct fsck_options *options);
>  
> +enum fsck_options_type {
> +	FSCK_OPTIONS_DEFAULT,
> +	FSCK_OPTIONS_STRICT,
> +	FSCK_OPTIONS_MISSING_GITMODULES,
> +	FSCK_OPTIONS_REFS,
> +};
> +
> +void fsck_options_init(struct fsck_options *options,
> +		       enum fsck_options_type type);
> +
>  /*
>   * Clear the fsck_options struct, freeing any allocated memory.
>   */
> diff --git a/object-file.c b/object-file.c
> index c62e5496e0..186b2ff764 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1279,8 +1279,9 @@ static int index_mem(struct index_state *istate,
>  		}
>  	}
>  	if (flags & INDEX_FORMAT_CHECK) {
> -		struct fsck_options opts = FSCK_OPTIONS_DEFAULT;
> +		struct fsck_options opts;
>  
> +		fsck_options_init(&opts, FSCK_OPTIONS_DEFAULT);
>  		opts.strict = 1;
>  		opts.error_func = hash_format_check_report;
>  		if (fsck_buffer(null_oid(istate->repo->hash_algo), type, buf, size, &opts))
