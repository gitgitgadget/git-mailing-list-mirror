Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D55B269CEC
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481694; cv=none; b=EzKPd05RLK1/v9Zs3sF+Fa2woiSXIDwM+Fx24S0BKHkA3YL4nZ3gdUukKmHcCjKy4PxjD/ILm6Gg30k/VtYu2i3hxHLcuxHO8pW6cKumRpSldSHAlSM2+Waai24pJs0lEcsAwkTrebsvbqox5DsP5PPSe49A16W2y/byqKnx6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481694; c=relaxed/simple;
	bh=kcv33ozEIYI6culQmK7m+0udo8wC52YDUdeDPjR9AeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdvlYfkmFbzf/YxuSIymPG2PezE03U8F3X16bgYTB6W1zM6gwD3Am6ND2R771KEQ+ro0BnNoAMefPmIbgN+WcgjE8lFWF5K6eO6+iH/55Q8fwlH1Pwu9SpAQykrQ6mWnbrNJT1c1B9g5sMBrAPACPqV5pnbsDG2PGTDDCA3QtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KPOu6vXA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a8n5TyLj; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KPOu6vXA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a8n5TyLj"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 431B8114010F;
	Tue, 25 Feb 2025 06:08:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 25 Feb 2025 06:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740481691; x=1740568091; bh=7xKp3DAZRW
	o0q6/j/Lj2v7Qf3wABsNB1MoF0RnnG0Zw=; b=KPOu6vXA7gdzK1BwG5KbMlq+JZ
	ixlrJ1sEQsfMorV2REmiWDI2sr8hXzOjqEsmGX8VztYQybpgyo3JL49r+MJJHidr
	LV7pz5khsQfwVdki6gS1AzZ6n+zeI3FWacM8LctTTEVPp5z2YdHa1A4AvCLmZvHI
	IZA+8fkbu/s7vFlxFImKMgDF60DLtEHa5zCiKYB0rZ7i8Q6XVS7STE8n8XCP9qMY
	Ou7vGDz8SzyNBrrisK2JQSr84nsnPWEKmgvHDN0IMfrUeRRXTp+o4EZTnHMW8vv9
	vIXFcsd0kFCj6HBSURoMG7+0Pq4LmS0n2lVpxjVf3GBjiPTrTPpuRJQSKm5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740481691; x=1740568091; bh=7xKp3DAZRWo0q6/j/Lj2v7Qf3wABsNB1MoF
	0RnnG0Zw=; b=a8n5TyLjHMAepFD/VZlUSKdtjmjwUYBAy9472gtI6jMsQLA/JY8
	B17gy7oc8O+GNVAnuhuCBpSClc/xcn9p+tKOizivUu/VsLZFaunylGTUgM3yzTLq
	PCkiheErmdojh/4jEzsNPWw3lsjBzTYAbSUKcUoik7NX4fMTDVpgdaE5Q2PvNqhR
	fgZDfBV9EHZ1UpviVZdsHv0EA1r8RMzJwSzmI64Ejf6ECGiYDnKd546r9Wq1DFxC
	K1Deot1FKPgz2W7tlApakk63B/WFOrOYxEYUQIqalTD+iKzQbb2RWfNRrPXDXUhh
	DA5l++BLMoqguBcwy3VXiF3K86Gbj3wuHKg==
X-ME-Sender: <xms:mqS9Z1vA7uJXp_uJFoeHGTyhlj8WME9sudGPK7EVBcNL80JNExl9QQ>
    <xme:mqS9Z-fEU6ZeQcMCameu36zOH8ezn29gkftUe2lCymo520FzpRu-f30QkuXw2RZUG
    f96WOrYe5gwRow4cQ>
X-ME-Received: <xmr:mqS9Z4y45uLT9P_YntlbbRcx_wSCNZF4xOHT5UYXE2WvOR8xPyPP_9hj-7oSZITeViwfQ-6iXENFP1fARC1et6GqbW1QgcPvEL-jEla63JwOSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mqS9Z8PH_bMmFLw5VV3bUn8StM0ZI8RBQUf0tINKknetTA2m3xEjWA>
    <xmx:mqS9Z18EjyKPwjhnXtma-tUs6FMDo-_mCwUN0vnO0zzsbx40BrCttw>
    <xmx:mqS9Z8XSTB8y28io67D8dDVFTl_UWuEw9SDqbmNvbEOQPWvVH4Dq4g>
    <xmx:mqS9Z2dNTO8ZVYlXdpat07yNdDBL5ltRhofEAFRhMYP3X4zJvccJGg>
    <xmx:m6S9ZxaCvbqGsAEEJ8wSI9JY0oPY4KsrRIZIhUOA41QkckQ3KiuC1lZ_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 06:08:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9e2648ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 11:08:09 +0000 (UTC)
Date: Tue, 25 Feb 2025 12:08:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v2 5/7] refs: introduce enum-based transaction error types
Message-ID: <Z72kmFUARRSukMBe@pks.im>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
 <20250225-245-partially-atomic-ref-updates-v2-5-cfa3236895d7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-245-partially-atomic-ref-updates-v2-5-cfa3236895d7@gmail.com>

On Tue, Feb 25, 2025 at 10:29:08AM +0100, Karthik Nayak wrote:
> diff --git a/refs.h b/refs.h
> index b14ba1f9ff..8e9ead174c 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -16,6 +16,31 @@ struct worktree;
>  enum ref_storage_format ref_storage_format_by_name(const char *name);
>  const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format);
>  
> +/*
> + * enum transaction_error represents the following return codes:
> + * TRANSACTION_OK: success code.
> + * TRANSACTION_GENERIC_ERROR error_code: default error code.
> + * TRANSACTION_NAME_CONFLICT error_code: ref name conflict like A vs A/B.
> + * TRANSACTION_CREATE_EXISTS error_code: ref to be created already exists.
> + * TRANSACTION_NONEXISTENT_REF error_code: ref expected but doesn't exist.
> + * TRANSACTION_INCORRECT_OLD_VALUE error_code: provided old_oid or old_target of
> + * reference doesn't match actual.
> + * TRANSACTION_INVALID_NEW_VALUE error_code: provided new_oid or new_target is
> + * invalid.
> + * TRANSACTION_EXPECTED_SYMREF error_code: expected ref to be symref, but is a
> + * regular ref.
> + */
> +enum transaction_error {
> +	TRANSACTION_OK = 0,
> +	TRANSACTION_GENERIC_ERROR = -1,
> +	TRANSACTION_NAME_CONFLICT = -2,
> +	TRANSACTION_CREATE_EXISTS = -3,
> +	TRANSACTION_NONEXISTENT_REF = -4,
> +	TRANSACTION_INCORRECT_OLD_VALUE = -5,
> +	TRANSACTION_INVALID_NEW_VALUE = -6,
> +	TRANSACTION_EXPECTED_SYMREF = -7,
> +};

Nit: how about we name this `ref_transaction_error` and adapt the the
enum values accordingly? We may eventually also introduce similar errors
for the object database, so it may make sense to have the errors be
specific. Doing both the enum and changing the name might be a bit hard
to review, so we could also rename in a preparatory commit. Or we just
punt on it for now and do it once it becomes necessary, that would also
be fine with me.

I also wonder whether we really want to introduce `TRANSACTION_OK`. It's
always a bit of a mouthful, and in many cases one ends up with a mixture
of `ret < 0`, `ret != TRANSACTION_OK` and `ret != 0`, which may lead to
confusion. Continuing to use `0` for the successful case should be fine.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 3247871574..75e1ebf67d 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1672,7 +1676,8 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
>  		data->own_lock = 1;
>  	}
>  
> -	if (write_with_updates(refs, &transaction->refnames, err))
> +	ret = write_with_updates(refs, &transaction->refnames, err);
> +	if (ret)
>  		goto failure;
>  
>  	transaction->state = REF_TRANSACTION_PREPARED;

Do we also want to change the local variable declaration of `int ret` to
use the new type?

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 2c1e2995de..e1fd9c2de2 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1255,11 +1255,12 @@ static int prepare_single_update(struct reftable_ref_store *refs,
>  					   "but is a regular ref"),
>  				    ref_update_original_update_refname(u),
>  				    u->old_target);
> -			return -1;
> +			return TRANSACTION_EXPECTED_SYMREF;
>  		}
>  
> -		if (ref_update_check_old_target(referent->buf, u, err)) {
> -			return -1;
> +		ret = ref_update_check_old_target(referent->buf, u, err);
> +		if (ret) {
> +			return ret;
>  		}
>  	} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
>  		if (is_null_oid(&u->old_oid)) {

Nit: superfluous braces that we could remove while at it.

Patrick
