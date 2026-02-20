Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B55D342CB6
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591584; cv=none; b=B5OEPwq2WnDHxc/OM0tQAihOsO5IWYEPTURYyEl2fbZyIi28Q4Z9hesuYoLL/OAVOEJaSDFeUhCQomWJj1TIDNiw5c2us3lIigGAEUMyL/ImOyyvfr4McPEspPkyhwRjza2GQmSlhzYm4w/AtS6jdO2tk+X3SP/yvdNJtb1yzLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591584; c=relaxed/simple;
	bh=BzgK1CnJaah0ghHuy2WXzKGZBkrSimqr1SAuUwGE/D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPiUHVcqf/Vb0yM0EYPAXtTn9IbUNZd3XdgVenKFh1lU57itloyEwYeOzyHcPRb8o40kmlqMQHymRTVOGClqYetzDNZCQ+UfjScdXniH7KCfCZKKmFo64+PsJ1ouCzCqGtreoQoN2C1ZUWpwHeCKi/t+b/EiXCIUFMtjlzSecos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ib9pZJvs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gAVFdXk5; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ib9pZJvs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gAVFdXk5"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 7C4BF1D001E4;
	Fri, 20 Feb 2026 07:46:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 20 Feb 2026 07:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771591580; x=1771677980; bh=J546sEKwKp
	HQDh2IagNnjNfRfgCHc04EvULDlTkXpkQ=; b=Ib9pZJvsFxukxINe0fSaqfYk0m
	PMcTuVxginngRF6aX+b/nMcYzSGvOAtQqa+m2G+EmMeEnszAtdC5DfVjE3W7P0jU
	gzhoJctItJCRdtrAwVn5meyuBKrOfqUbri0xj0JezQtHGusgoUnBA+ozSnPZii7R
	VJW6r5LfAkVATpQ05JIL3pn5ErLzM5tzUQXSoKf7G3sfAOND7NGx5T3nna6uzIj4
	/SbCNzyiEChc51/WrtDFtKIJ8NdVeSP9ZAD+xY3FKHPRoyE5ncIaVCxLcFl8vy67
	kLoyDUA0NoglP6BBFtmUKW/J3sVEKvijEav4eO4oOTjyKHC7sGIFj1vOXMVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771591580; x=1771677980; bh=J546sEKwKpHQDh2IagNnjNfRfgCHc04EvUL
	DlTkXpkQ=; b=gAVFdXk5bjax7vn8yagNacls9RJzpR55XH9x0MngjXzD9JstxiS
	ttvesIStUrMW8cNYPSOGY+Iyt1YHStMfFp+n22OdDkA1EI0kmVgeumlMdWtHOiiz
	JyDQPUieD3b40cFPQf68ogEAB2OAh1reHEglFui7KGCGxwNiwAHZq4ZMl6zyECGy
	izwK8/gvRrMJ5s6x0YlOWHGcpeqEPSGyGh9nbgoNfTVT90GVSbL8dGdWctzSlugm
	31YODpDtS9fWQH+qTZQtfriOUF4HmN73A8NW5NwtP8zUyKCFZkZPBVF4eLjTtVoZ
	pRMEjZCRid6ISAqxunYkiYmdvkyS9PXBOng==
X-ME-Sender: <xms:nFeYacogWoVylgwXQevUlMYNVvp2bEXISpRWu7b5SQ5d5H8iIUGgAg>
    <xme:nFeYaU522yVScsu5QzpPqgYHMUBLWevLJRCB_Hki9WpFPplVJX9SqruH7C1Sr2xjH
    n4FHbVGFmvCLSMNMojqaM2tBUMl8MT3fCUl1I-qbl_fvVXkNkzY6w>
X-ME-Received: <xmr:nFeYaTdP5-nJlN_1PbMi9WzNR7wGL5jrtdYEsPwoBnpvkBJNDpauSkLZGbtC_wKPnLegzJLQq_B-R9PoG4WSMPFJOAt4HpZTyCTOiTZHPMBW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggurh
    hirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepvghmihhl
    hihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:nFeYaZ6SC7DfJZswvK1qn7bjcvmYItcYl19Wme6lCMGVzHbI2cdFTQ>
    <xmx:nFeYaas1BNDJHEqlGBo8bGArz_3RJzEgnTKNDWPQ04WHyBp8j9hRow>
    <xmx:nFeYaZjb828-gJSfgpexVI8UQjlOrNyM8fef2N0ZhzR9cDDCdRf4qg>
    <xmx:nFeYaVprGXY86y8okefXVlfAv8_aa84jAdym3VVzTgjqPQDRZcHSLA>
    <xmx:nFeYaeuKTkJjmj9pN0w_uQwQPbNZ6eGk2QdKX0hoH_BMN3MKOODp1abE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 07:46:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ae0906e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 12:46:17 +0000 (UTC)
Date: Fri, 20 Feb 2026 13:46:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 3/8] hook: add "git hook list" command
Message-ID: <aZhXlrWRGDS_Bhvm@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-4-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218222352.55393-4-adrian.ratiu@collabora.com>

On Thu, Feb 19, 2026 at 12:23:47AM +0200, Adrian Ratiu wrote:
> diff --git a/builtin/hook.c b/builtin/hook.c
> index 7afec380d2..51660c4941 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -20,6 +24,61 @@ static const char * const builtin_hook_run_usage[] = {
>  	NULL
>  };
>  
> +static int list(int argc, const char **argv, const char *prefix,
> +		 struct repository *repo)
> +{
> +	static const char *const builtin_hook_list_usage[] = {
> +		BUILTIN_HOOK_LIST_USAGE,
> +		NULL
> +	};
> +	struct string_list *head;
> +	struct string_list_item *item;
> +	const char *hookname = NULL;
> +	int ret = 0;
> +
> +	struct option list_options[] = {
> +		OPT_END(),
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, list_options,
> +			     builtin_hook_list_usage, 0);
> +
> +	/*
> +	 * The only unnamed argument provided should be the hook-name; if we add
> +	 * arguments later they probably should be caught by parse_options.
> +	 */
> +	if (argc != 1)
> +		usage_msg_opt(_("You must specify a hook event name to list."),
> +			      builtin_hook_list_usage, list_options);

Error messages typically start with a lower-case letter.

> +	hookname = argv[0];
> +
> +	head = list_hooks(repo, hookname, NULL);
> +
> +	if (!head->nr) {
> +		warning(_("No hooks found for event '%s'"), hookname);

Warnings, too.

> +		ret = 1; /* no hooks found */
> +		goto cleanup;
> +	}
> +
> +	for_each_string_list_item(item, head) {
> +		struct hook *h = item->util;
> +
> +		switch (h->kind) {
> +		case HOOK_TRADITIONAL:
> +			printf("%s\n", _("hook from hookdir"));
> +			break;
> +		default:
> +			BUG("unknown hook kind");
> +		}

Good that we're being defensive here.

Patrick
