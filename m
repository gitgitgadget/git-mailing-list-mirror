Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77BC30596F
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780355; cv=none; b=lBGmC3TK8TQzVwwxwl0blrati9YEGOZuHu4zLK76avhqHpEOOTeLfObso9sBkxGD8GBX7/gmONcoY7QLRJ4YSgJtDrhAgjXvrmHOFVtlDzi5GSl03QpICAmBFWfEx/wjLidrSfd2H+UbLxNzieSL1gdVFY7Fu83HfYez5F3GWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780355; c=relaxed/simple;
	bh=LBQVsHLH2bUcufYNPrZ9R6+VDeA1ymW2XRypWMkPnl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmZ0fMKobsXn85+sx6jzMia+BBfIMHjGrjbDRrnRdzQGkX1zmap9oosDBaj2RkgDTPeZ2ABSa+IWm06ZOYPFMJXkJLEseAk/I56V0+3rf01BonNEYAaAVtGWGvWDiDSvSt/ecIEYuKr2A2ysVsyIrhKellzepC9QwSLLLc6j03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ei9+/wde; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HKqUaMPY; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ei9+/wde";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HKqUaMPY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C553CEC026B;
	Wed,  7 Jan 2026 05:05:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 07 Jan 2026 05:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767780351; x=1767866751; bh=lo3+03nA2X
	BWudpvB8HoT8IQqGJTKGRMOFSywUQxQIk=; b=ei9+/wde8oeZR2YxYfoYP9a0RT
	btO2KV2SpqTxXi9kpG/Vitg5Cyhxkxw/OpGOY+tv16HEZ4bdB+82F1UQuKeXV9eG
	Nvvpz6KTVPbW943J8TBHEAe/C0SczeHjrs1shC2G9B+N/8prrd0iWeSkmVi/QA7j
	RlV9+A1fr/v6F5EGrfYs25OVvar1BHL0rvnuARdoAY3fk8449aCjsfGAswyB6pHm
	wYy+jZncqPSs1DdehYN448IIrXmHYHC8D3yXEN5ZSP0It2njxdVkj2iUC+lZ9G4R
	n0xlRdc2qcxJvPIBtPKV2/tJ7Vu/OUS6ON6IG295NP3iPuByh1U3aKsdDu4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767780351; x=1767866751; bh=lo3+03nA2XBWudpvB8HoT8IQqGJTKGRMOFS
	ywUQxQIk=; b=HKqUaMPYZ73oNjNmkz+9EdzXLtNpdE1HJBb/Q4DIBYFw+3XW3Sw
	x2C8f9LM4Jb2WITHKDVPn+6XDfMy9HEnEtjtHhh7JBkWX+V1t+FiMIOqovju4AIA
	1ILI3X6T45bRisy+HZHm8jbb2LhwA3mhBf/bANwNZ1KDr/2NCUSR92B3Iaf3UTCZ
	hEsq+zOdxuGKeQ5VD2x+K23wz5lhdgPJyV0JPM2XJkm6D+D39WFtDZu/mj1ANGOE
	otCB7iiOO3jh3w/KOOJJtEr4GjDPdstG283aDty0tVPWQj2LFp3qj3WAZ+VCyyA9
	7MsWskrdnHuazBO5NLW1AShjNhVq2ib4luQ==
X-ME-Sender: <xms:_y9eafOUWgc9cGiZsM5jUHQEZ_MnPQJTuTO6DD5YWw-Ryeq6-AxlNg>
    <xme:_y9eacPBNYypNXe_d5Oz3ACaNk0fB264L_4AtDwb4-3J8uxBXxSeGHcuZXXr6UQEl
    csqfv8rKhtgQeIzQc3WMUQm0uQ2yfRnIci0vWRSW2WFu9-kaFV4aw>
X-ME-Received: <xmr:_y9eaQiOAKQrW41fTNdcdvaWW6W2YV7J9bDcpmiTGKWl87s5dzRDEZYQuIuxwAMiL-Eoiuxsr64dGM3HcOVoTxpqlHLL09zY-VcR2Z_DwL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdr
    udekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuug
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:_y9eaZsX58H7oc_4dT3NkgQuUwge1XMNIXDHWvGpIVrsLuk1i0GEog>
    <xmx:_y9eaWQjM6N_NU_3KilsqZaZqZWLm2ofDPowOPrBWO2zXT3dsuPGig>
    <xmx:_y9eaV1JDxks51GLS00RpYCIQ5rveJC1WlE9NOoP6foatBeHfdqTsg>
    <xmx:_y9eaTsmAiND75JMZeK7I_TsfCqEeOV1ig19Ypr4uu0K1WJsny022g>
    <xmx:_y9eaS-dt1upCQtiIzEi_nyOrHOfc2f5X359gwnDptAyfU4SbiDueIey>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:05:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1fbe6bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:05:50 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:05:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 9/9] fetch-pack: wire up and enable auto filter logic
Message-ID: <aV4v--FYaHCLLrPz@pks.im>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-10-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223111113.47473-10-christian.couder@gmail.com>

On Tue, Dec 23, 2025 at 12:11:13PM +0100, Christian Couder wrote:
> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index 70a9818331..f7432d4b29 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -92,11 +92,20 @@ precedence over the `fetch.output` config option.
>  	Use the partial clone feature and request that the server sends
>  	a subset of reachable objects according to a given object filter.
>  	When using `--filter`, the supplied _<filter-spec>_ is used for
> -	the partial fetch. For example, `--filter=blob:none` will filter
> -	out all blobs (file contents) until needed by Git. Also,
> -	`--filter=blob:limit=<size>` will filter out all blobs of size
> -	at least _<size>_. For more details on filter specifications, see
> -	the `--filter` option in linkgit:git-rev-list[1].
> +	the partial fetch.
> ++
> +If `--filter=auto` is used, the filter specification is determined
> +automatically by combining the filter specifications advertised by
> +the server for the promisor remotes that the client accepts (see
> +linkgit:gitprotocol-v2[5] and the `promisor.acceptFromServer`
> +configuration option in linkgit:git-config[1]).

Okay, so if "promisor.acceptFromServer" enables a subset of advertised
promisors we will automatically use their advertised filters. But what
about the case where we already have a set of local promisors with their
own filters, would those also honored by "--filter=auto"?

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 186e5498d4..41bbaea72a 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1001,6 +1001,8 @@ int cmd_clone(int argc,
>  		NULL
>  	};
>  
> +	filter_options.allow_auto_filter = 1;
> +
>  	packet_trace_identity("clone");
>  
>  	repo_config(the_repository, git_clone_config, NULL);
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b984173447..ddc30a0d30 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2439,6 +2439,8 @@ int cmd_fetch(int argc,
>  		OPT_END()
>  	};
>  
> +	filter_options.allow_auto_filter = 1;
> +
>  	packet_trace_identity("fetch");
>  
>  	/* Record the command line for the reflog */

Nice that both of these changes are so easy now.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 40316c9a34..12ccea0dab 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1661,6 +1662,25 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
>  	int i;
>  	struct strvec index_pack_args = STRVEC_INIT;
> +	const char *promisor_remote_config;
> +
> +	if (server_feature_v2("promisor-remote", &promisor_remote_config)) {
> +		char *remote_name = promisor_remote_reply(promisor_remote_config);
> +		free(remote_name);
> +	}
> +
> +	if (args->filter_options.choice == LOFC_AUTO) {
> +		struct strbuf errbuf = STRBUF_INIT;
> +		char *constructed_filter = promisor_remote_construct_filter(r);
> +
> +		list_objects_filter_resolve_auto(&args->filter_options,
> +						 constructed_filter, &errbuf);
> +		if (errbuf.len > 0)
> +			die(_("couldn't resolve 'auto' filter: %s"), errbuf.buf);

Now that I see it being used I think that the calling convention of this
function is a bit weird. I would've expected the function to return an
error code that the caller can consult instead of having to check for
`errbuf.len`.

Patrick
