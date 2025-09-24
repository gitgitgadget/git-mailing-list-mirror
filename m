Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3095723D7EE
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 05:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693301; cv=none; b=gyD4aAOMTIh4I86FIolELqWe9LRNKj2dW9A0UFELarWso2M3T+flMzNC1D+4k907PzufIkzJEZo1G0FU5rYRRWaqEpdmdzIqZXbpfRDaOMlNtWI492w6Wiy4Rb1E9xagFUYNSz/fpqvFJ8FhhvqQJdXFF3CKs0PlYeh+ANMB1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693301; c=relaxed/simple;
	bh=YQOP1FzBEbYORP0EKL1mWgsWeC/dXKqVeIDDwa4xbrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVMvTv2G0L6t+cQTALrbf3wxRAAa1xcYkYa9PrA7aw0w2xdjyDomeea/s3jxB6AxRbxpTxqm9Dv64JM8CdqOQRS/0R3GcMiP6mqH1PIShXLU8KZmB8LrXIvNKD9VmL7mdFX+ADPgoMGiF5Q06RZ5dqwLGfkprnzwQlUMxKt33wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J9K8N7Ot; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fs4LS09X; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J9K8N7Ot";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fs4LS09X"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 71E4FEC0090;
	Wed, 24 Sep 2025 01:54:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 24 Sep 2025 01:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758693299; x=1758779699; bh=Ow/byj7yji
	BaeIcOTxSBs5C/V5ANF5mfw9G13IfBgpw=; b=J9K8N7OtASGufuskBLaiJ8DCTW
	EekMK33zNhcFFvmFYCH5jacBcLXvXHKtKrTqZfMpHXLfi+6iJG4rZpYQnXdwPkUD
	ypPYMEeVo4LMUkxuLr7YF6fMeLo+1y9X3prcNGXql4YM5FwxY7xBP4Rk0uXiin/v
	U9npH12b6kmyprFE7Dl06A2628k4raBaRwTJArDP3/gcKlxEDHx4TFjhMXl+1gpW
	hRlSoeKazkZXS9NRQqFlsD9jL6P/Otoh+ymcE3qBVBdsejsehISjRC8xWgJc/qgm
	R65aAWeZ0Kn+L5eQMLlQrZtqA4z234VBessuZyLi+LA3OcScPnjrDBaSaLhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758693299; x=1758779699; bh=Ow/byj7yjiBaeIcOTxSBs5C/V5ANF5mfw9G
	13IfBgpw=; b=Fs4LS09XT+rrMyrFiPDYq7UHsQ6Vsyw+9HQ6GFn1dhKPdr1k0Cj
	MsMC8DrEX2krjevOD82CA/gf4EF0E6cb28KGaI/iw5tPhJGjQtqZui/N8PdZ5Ux0
	IrZDiAgNvmHpmi4P1u/MYpfUTxFix+RjUU/USVPKvQKuuDxr5qPYZl4EBNlbWqZu
	xHPCHWVBRUYz1bwtyiG2/KmzcnUBHET5i48oUSnV2hncNVa+PyAQwzSQGsqyhOYb
	iiLSE52eHYhpOhFHEdpIo2mldDGCGGzMAi3CH08iS/eEMDT7jCpnYcZVgj9QGOC+
	En7o7YZYcztgzB21+7oDQxefhEP64mzeRtw==
X-ME-Sender: <xms:s4fTaLM_xRSjfcSOTNZ-e-FOXH6BsvJs09lDh4Hr-dnTdyiCwkrc5g>
    <xme:s4fTaM-xaWUvnI0ihr92KeUv3p8C2_6GBXv-lZXLXzLj7B0_C4YfhKKCyv-MbunuY
    ysy8z75gfZaWyW33xMBGYZjDkG5t5JedgOwM62_gsEwrq0Q7kDZbQ>
X-ME-Received: <xmr:s4fTaPS8fv5Y0EvULJ8Ukj9WUgoJnkr-f5IGe4STW86KfCDe8KMFvZabKWRBG0o_9IYOEzU5yCMmCfCqxPprN3g8kydQxvEnRo1hJoqa6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:s4fTaOm5ydt8h-WtbJBxFQQ3W8OB3strsEowKJbbnUDUuS-JOZ2BiQ>
    <xmx:s4fTaPSz-O9zlTglD0Pc5TjgAECmccqNFQH0bBMyC04_rPK-57gr0Q>
    <xmx:s4fTaMMkGGoRfUcqe6jEnsGFTpzYYIKEeQoQgMWm1GjwQvqYrd6jrQ>
    <xmx:s4fTaIXs_WKxETqTJt2iDLW31UowLh49BtblOqCgqwFz8Ke7UlAtMw>
    <xmx:s4fTaCwcoKatzcolgIq72zmCKcBhwVE8jJT-uShbEHY2cSB38ERizFMA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 01:54:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52bac9db (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 05:54:58 +0000 (UTC)
Date: Wed, 24 Sep 2025 07:54:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Subject: Re: [PATCH v3 8/8] refs/reftable: add fsck check for checking the
 table name
Message-ID: <aNOHr7lm4WXUyHa5@pks.im>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-8-271af03eb34d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-228-reftable-introduce-consistency-checks-v3-8-271af03eb34d@gmail.com>

On Thu, Sep 18, 2025 at 10:11:49AM +0200, Karthik Nayak wrote:
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 2152349cb9..1a18f4bf92 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -2707,11 +2709,57 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
>  	return ret;
>  }
>  
> -static int reftable_be_fsck(struct ref_store *ref_store UNUSED,
> -			    struct fsck_options *o UNUSED,
> +static void reftable_fsck_verbose_handler(const char *msg, void *cb_data)
> +{
> +	struct fsck_options *o = cb_data;
> +
> +	if (o->verbose)
> +		fprintf_ln(stderr, "%s", msg);
> +}
> +
> +static const enum fsck_msg_id fsck_msg_id_map[] = {
> +	[REFTABLE_FSCK_ERROR_INVALID_FILE_TYPE] = FSCK_MSG_BAD_REFTABLE_FILETYPE,
> +	[REFTABLE_FSCK_ERROR_TABLE_NAME] = FSCK_MSG_BAD_REFTABLE_TABLE_NAME,
> +};
> +
> +static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
> +				       void *cb_data)
> +{
> +	struct fsck_ref_report report = { .path = info->path };
> +	struct fsck_options *o = cb_data;
> +	enum fsck_msg_id msg_id;
> +
> +	if (info->error < 0 || info->error >= REFTABLE_FSCK_MAX_VALUE)
> +		BUG("unknown fsck error: %d", info->error);

`info->error` is an enum, and whether or not it is signed is an
implementation detail of the platform. But I wonder whether this check
may cause some platforms to warn about an impossible condition.

> +
> +	msg_id = fsck_msg_id_map[info->error];
> +
> +	if (!msg_id)
> +		BUG("fsck_msg_id value missing for reftable error: %d", info->error);

Yup, makes sense.

Patrick
