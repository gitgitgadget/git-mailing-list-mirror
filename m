Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7083B420E9F
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831874; cv=none; b=GQ2zk1NvN1UDOICRvC9LSgUHPOap25xXgu7tbevdBpeSsl/66I5+aXBPos/xD1LXwxLQ5Yqmn7b4RGLOphQD95+demoe2ujhQqkSujt8xGsPLZrz48tL0usst7+o4l/hmXu9OMSwjoWfMlmsJ0muCpD9lxQJ4QCdbjm8tvRqGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831874; c=relaxed/simple;
	bh=ulD6heWTK+RkIdie6ArJ1QkfTvKOJ1lI7+DIbjydePg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxK1OoQPWddOLG7fNFLmNOXMEWEA8WaRSd8IVPHNL33pJbsYbaORnbLd6pXbvVglF0l/gSWcmW2OwhjZ8oRi9SgW8ONcuX2dpuMAvplFtZPedonq/O47gECaBg+ZgNgB5qJ71NZdDtMp09vuI72ZeXT3rhGwXb6GRSsvsT2qiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ily7wczS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=laQD0lWV; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ily7wczS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="laQD0lWV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 50ECA7A00E2;
	Tue,  4 Aug 2026 04:24:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 04 Aug 2026 04:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785831871; x=1785918271; bh=OpB0goVEIe
	FjYImLLa39INFv4tm3BwUyHOP6gxzZixY=; b=ily7wczSkLANaJD87xB5P9gcz3
	QRn9JDDiJAFBMJWe65dLuLkVOt2wieFTnq84zIrePpRQH4sM2Y05iRVYtXZffOQb
	WnXRLUUnTobfqpRFmaIP57mHcn9iBNvFg4EMJV4ntm2fnNy/kQAqH9G11fkM5VkC
	Ntg8IqcMo0lPqWjIWFrRWHb2ihjvn6VemdrbobVqZQUSKHIVr+5towoGYJtCB1sK
	c/Tz5tXXUn/vKDKWl/m3bLfdxCYa7cpTeRLs2LI4rpxFv2I3GDVyCtJldP7NBfbL
	iNJ9Qv6Bfhh4oqz0yrFNdlpr1LWtxVQDhzhIk5gAi4mepd9Jfu+CNTgnX4VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785831871; x=1785918271; bh=OpB0goVEIeFjYImLLa39INFv4tm3BwUyHOP
	6gxzZixY=; b=laQD0lWVL947gv+5L45pvOioletVHUu1NFXF2P6mYer429jzT4N
	tklcq3RC9XtEfOrYudRsA3N/ZpW78qjf37tOx/m187fShDTuNXfB9E7XDqgE+vb2
	7fyjSxooRTO0VFg0bPboeTPFEnB3fxabhdceTi+os1DfspDbPG8AeQMxs42YnqcT
	DsRP4FTKRVQJUQoSXUI8x6MIxSPZ884z1bLgSdeScPFHv0J1USpWa0dhOs8EV7w+
	mo8lt3CnBlJ3baBklGx5elqAci2c7QbHhx8CEExghS5u+Op79QYE4nh9TXYd4993
	z3EFzT9sur9Bok+8YjuzQ+9ZsPP0zua51jA==
X-ME-Sender: <xms:vqFxajNfgNYq7Ep6hH3hYSFMi24m9UydLUeptg1Qd4cmFx8uKRomWw>
    <xme:vqFxagNfAqbXCfMsmunXEdnbTg56622CiTQpILLVYOfMPdBCq3W9O6UldZpGthfkC
    uNBMWfhN6r8w9HMpeeqHRvwG89JVLxTqc9b08aehToigfDLTNvCRI8>
X-ME-Received: <xmr:vqFxakgCZ-woYrLQC0b8tdTXCgstIMZDbw1ArsSM58Z6uCCnA30AhF0Ek3191Ww_hnOGeGo2DbUSlpNqARQWsbe4mJlC_QPlEx09TFx6>
X-ME-Proxy-Cause: dmFkZTEixXpPE/d9am2MHcp4Wkss5Akw3/31WFoKhErNM7PLzpe2EZQsK7OVzUKUIybrx8
    vKLVOVf3rUOeJysGKuZIf4N7tyLcI6m+9SPslwNYTSubUyU+7K3nzr9Ukag3k+SrmUFq/6
    kGGLA/CBF0YoyntPT0X/ucE/aL3gic7AeyDErJJpyp4jYDPrfr1jO3BBbPJ9rbcv2IdSWM
    xFHbRfqQx00oPeNczgkT5hjFCtafhgYJLTjw1GWQEWj1Y7QJz3A77Z8qF+bcr8ofchviXk
    L2/DlMGZFyuaVX6YC7NpspTn+ZOrPv5rkjHkhblzIYRkaqsU4j2b3XvCuoUwHk5Z4Q8RTE
    KpHSFQVRQsps81i9Ua5it3IQvn1WpB2gSTlKaMb/0E4s2JPMRePhJIysb9hsKfsWc4HWPe
    0eUoBB3ASedXbT07zLRBXhy3Hazh39ExvUO19zx7RdhbyKV5bXnsHd8pTYdaJIzo8Gwb6h
    vVw7IE9x+QDbIAtMm7+NG8dvn2/Sv9A3v9yNfcAZbIFgXGn+FUW0VE+lZjsl291wNoZOAe
    RZGtDcQ0Su8JNOuCtTWkuCqsv9IlNiCO9p06Q1B2+7Zuyh7dzXdFNkwQ+LGvXleIkj1gwd
    uazyvrekq+AzRXEOtCXJcBfoIw+pItzAFRlP7KyK+pM7Uxi3Ryiwh06u6jFQ
X-ME-Proxy: <xmx:vqFxatsW-EyZQ3NiiGSAyH_q0cTjYApYhfymF3JDfmF4-CEehj2fxQ>
    <xmx:vqFxaqRRw-3fpJhbY1z95mzdc5BELM8q5ZF-mkPPCRUWW20aeNpZmA>
    <xmx:vqFxap16AIWihEa4giH9TeCAEzo2asRwpGTWWjqRYxZQOj6c4kRDOQ>
    <xmx:vqFxanue87HOF0KW8lULt1J3C3cIpWh4u3toEfOOKu3Edij45BEgqg>
    <xmx:v6Fxajd7WaP0v5fAkh4M0LrE3-fctajCU3CEqrp_gOAovcG3rN0gK7gu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 04:24:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd6faba9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 08:24:25 +0000 (UTC)
Date: Tue, 4 Aug 2026 10:24:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, five231003@gmail.com, hariom18599@gmail.com,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v2] repository: move fetch_if_missing into struct
 repository
Message-ID: <anGhtfPaGK7v3NNR@pks.im>
References: <20260715011850.3181131-1-cat@malon.dev>
 <20260716072954.582235-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716072954.582235-1-cat@malon.dev>

On Thu, Jul 16, 2026 at 03:29:54PM +0800, Tian Yuchen wrote:
> The global variable 'fetch_if_missing' controls whether a missing
> object check should prompt a lazy fetch from a promisor remote.
> In order to continue the libification effort, move it into
> 'struct repository' and initialize it to 1 by default to keep the
> previous behavior.
> 
> Note that in builtin/fsck.c and builtin/index-pack.c, when running
> related commands with the '-h' parameter, the 'repo' pointer is not
> passed in. To prevent null pointer dereferences, we defer
> operations on the repo until after parameter parsing is complete.
> 
> Additionally, update the partial clone documentation to reflect
> that this is now a per-repository flag.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
> 
> Change since V1:
> 
> - Following Patrick's advice, use the_repository whenever possible
>   without re-introducing #define USE_THE_REPOSITORY_VARIABLE.

It would be great to include the range-diff compared to the previous
version so that it's easier for the reviewer to spot what's changed.
Tools like b4 automate this for you :)

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 0793dc595c..74f9694662 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1898,15 +1898,16 @@ int cmd_index_pack(int argc,
>  	int report_end_of_input = 0;
>  	int hash_algo = 0;
>  
> +	show_usage_if_asked(argc, argv, index_pack_usage);
> +
>  	/*
>  	 * index-pack never needs to fetch missing objects except when
>  	 * REF_DELTA bases are missing (which are explicitly handled). It only
>  	 * accesses the repo to do hash collision checks and to check which
>  	 * REF_DELTA bases need to be fetched.
>  	 */
> -	fetch_if_missing = 0;
> -
> -	show_usage_if_asked(argc, argv, index_pack_usage);
> +	if (repo)
> +		the_repository->fetch_if_missing = 0;
>  
>  	disable_replace_refs();
>  

This one looks a bit weird -- we check for `repo`, but then set
`the_repository->fetch_if_missing`. We can probably just loose the
conditional completely, and furthermore we don't need to reorder any
code here at all anymore.

Other than that this patch looks good to me, thanks!

Patrick
