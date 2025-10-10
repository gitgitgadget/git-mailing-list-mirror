Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEDA1FA178
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095375; cv=none; b=KM2wTb/BA5/9uNfGr6+8Xx4hmh1TV09bab6OC2TP9IuUo5vz9E5RdNSscvDR0YCBTWg4vpOH57YQnxgif+Dnrp4L0wv5/HtqR1cXH+rq+Vcy4c0nV9DjUILO8MVYekK7tLUvULHSOaSyGm7Quwj4L3R2MjOV09amAkWPWS4X9Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095375; c=relaxed/simple;
	bh=27l6YYYvvlCZE3m7WWZ/WWC7b/BblqTut1+t6kpmMb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2e8mXhkixm5KXHNJtCBsqCGocGrbxWLnE8QhDJ1FJ3g70h2DC6nDgH1lR+PTG+RN/cYmYOCsWhLoJKrSCH1dhUtsnaSP0LnqzZj5GoDq5OWS+WaqW87kESpMckQiFRZop1m5a+05vU4NrzH0ckXJQWaeKZBAT6Hfk5sLdNydGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NPEfbiwI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zWE97sTf; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NPEfbiwI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zWE97sTf"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9619D14000B8;
	Fri, 10 Oct 2025 07:22:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 10 Oct 2025 07:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760095372; x=1760181772; bh=Lr3NNVVfie
	YEnsvZeRt3tzxTwTBy/Ho9yyr/KTa5n2w=; b=NPEfbiwIamcOqLjygI99qKecIs
	FPlC+vhuTLEz0+m4iNdYOTuLkw4k+soNWbf7ehcPjm8O8fhS9YAv3LiKyc3Kkv6q
	zUhLxgFGqztg7c65McHs9XXVh11w7bXkwfA5ZxLrSrbmrB/FmOMpDH2cI6bBn+zT
	WvW1jdChI3eEOiimHIQGv7Cr7sVFa7fa/bKjwGu4hJkmd+n7eTwlmwZH09u46NtI
	OM2EUyuJvGXaZ0TefN3zHZQUC68lRDCkP6V43Q/ZUhiaVqN4Iebf+oZIHTQ50VWh
	9GKjuVaXBPkjTzqc97XaizpNxqB9HxI+2hkvWtZKB7w8Sw0UZq0iBCceLc0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760095372; x=1760181772; bh=Lr3NNVVfieYEnsvZeRt3tzxTwTBy/Ho9yyr
	/KTa5n2w=; b=zWE97sTfLMRvk75IvVVfGkHg/OMglo2vFhY2cUVRlRh5GVz+RXZ
	EVU33kpd6AHlAPGEOV5CrqM9XhndTQ+E2cYy/+lUawtZOm+l5Q0UN2jguT/T4o3Q
	XMKZs8WsdTDyGTs/8sjkd8gax2eS1gQcvaEHDpUguZovou1lb7scbjkdA3yyGo+l
	tcJidu69T5njH6C78XJJowj/HRsjymZnR2MG432cozhv932E/sy9oJGjert0OuK4
	vL48UhqtbpCtsD52uxLbS5uCtt16lTWpG5IR0/ntfOKxGPqIpT8jHx94xXMNteqv
	FtSwHdUcpCdSkRZfKMOSUl8HXEBHOHHnsqQ==
X-ME-Sender: <xms:jOzoaG0Rykf_Vk3nAYMmFtifOAOKWwQD2cx82Pj9hbSZORVqa6FIiw>
    <xme:jOzoaPH4wIs_SrHhCkq4jZDD_ieyDl1uaj4GL3JnrvBUl4swLfbRyXcBLtPivNabC
    hdTrC90nvP-ySbcCvGNBOxqjiKCGlxU6A56MG3jbxBXHwrrAkwcdQ>
X-ME-Received: <xmr:jOzoaMh6R5HqiQx4q3BV6eu-imgp2jOqHGVKgwFvZBihDMPqM8XeQZP-zUmxG_OMHMMXkPo6GKcccW_Gtcwp5l_p0LiYEgp_KUv-F0AzTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:jOzoaC9A-dsLhKYazYqifNdrKVAreflGWdQ9hSZXL-pKcq2jBzZvLQ>
    <xmx:jOzoaLoL5W9p5HqKnQsNAfYRFfsN2-COhkZeRWRXC8TiMji3r2oUcg>
    <xmx:jOzoaJ8FHyZgVmmx3gp8CKiDRQc9Au6nQAFbEdhkHXtQblB26KUyhg>
    <xmx:jOzoaHXxagZ5zQxgpNr98K-w8Pn4y4bsdSK8Ml1wpL2-1P0qm_Zn1g>
    <xmx:jOzoaDmbZ0cWA-tFiUB63WBYLuZAtsbH4wAZV0ZkccLbZnBPScuY5BWs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 07:22:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f6f8a14 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 11:22:50 +0000 (UTC)
Date: Fri, 10 Oct 2025 13:22:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/9] refs: add a `optimize_required` field to `struct
 ref_storage_be`
Message-ID: <aOjsh4102DYctgQE@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-8-c7962be584fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-8-c7962be584fa@gmail.com>

On Fri, Oct 10, 2025 at 12:27:12PM +0200, Karthik Nayak wrote:
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 1c37899006..c262ae1a7b 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1513,6 +1513,16 @@ static int files_optimize(struct ref_store *ref_store,
>  	return 0;
>  }
>  
> +static int files_optimize_required(struct ref_store *ref_store,
> +				   struct optimize_refs_opts *opts,
> +				   bool *required)
> +{
> +	struct files_ref_store *refs = files_downcast(ref_store, REF_STORE_READ,
> +						      "optimize_required");
> +	*required = should_pack_refs(refs, opts);
> +	return 0;
> +}

Okay, this is nice and straight-forward. One might argue that we could
also have the following (uncompiled, so pseudo-code-y) implementation:

	static int files_optimize_required(struct ref_store *ref_store,
					   struct optimize_refs_opts *opts,
					   bool *required)
	{
		struct files_ref_store *refs = files_downcast(ref_store, REF_STORE_READ,
							      "optimize_required");
		*required = should_pack_refs(refs, opts) ||
			refs_optimize_required(refs->packed_refs, opts);
		return 0;
	}

But on the other hand we know that they aren't ever repacked, so it's
probably dumb.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index acaa5a6e57..c94948f618 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1784,6 +1784,17 @@ static int packed_optimize(struct ref_store *ref_store UNUSED,
>  	return 0;
>  }
>  
> +static int packed_optimize_required(struct ref_store *ref_store UNUSED,
> +				    struct optimize_refs_opts *opts UNUSED,
> +				    bool *required)
> +{
> +	/*
> +	 * Packed refs are already optimized.
> +	 */
> +	*required = false;
> +	return 0;
> +}

Yup.

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index d77714366a..df39fe9b38 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1732,6 +1732,29 @@ static int reftable_be_optimize(struct ref_store *ref_store,
>  	return ret;
>  }
>  
> +static int reftable_be_optimize_required(struct ref_store *ref_store,
> +					 struct optimize_refs_opts *opts,
> +					 bool *required)
> +{
> +	struct reftable_ref_store *refs = reftable_be_downcast(ref_store, REF_STORE_READ,
> +							       "optimize_refs_required");
> +	struct reftable_stack *stack;
> +
> +	if (refs->err)
> +		return refs->err;
> +
> +	stack = refs->worktree_backend.stack;
> +	if (!stack)
> +		stack = refs->main_backend.stack;
> +
> +	if (opts->flags & OPTIMIZE_REFS_AUTO)
> +		return reftable_stack_compaction_required(stack, required);
> +	else
> +		*required = true;

This doesn't make much sense. We should only indicate that we require
repacking when there are at least two tables in the stack.

Patrick
