Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1F526989A
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481689; cv=none; b=g+OMIqu6UdjA+VPgLl3tFz2qRoCJEwkojviUcNYc1h9R7nyepUs2Qq37pM0PU7bFRcWnHnStWIQQ4CZwDR8B4+Mzg+Gzcut811ayOfbEqCbqa4Em8mV42mNDR8H8tgmP/ZVq4HPG8BQ4GKDsUZ28ZTAtNlHQW1dyGVRO95MDNNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481689; c=relaxed/simple;
	bh=K+a73lHekCm1D4Yb8CXh22D9HPMqDukjI2wxQl6/wt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aERBPNjZs+LYy1CluWc360Zayph0AIxr+9MYOmts0dF57m7nZ19wdHaTwD6I5n6mpQ3aOqR/dYUXB4vTb0FRQiZjjwYEjykBeSav4CpPja5GK2BbyRn6QnQhl0k6JIiNk8PRsyfSyHGs38Fah/zhfH7V7+S1Y5ZHTy+ruzqw41E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MLApMAb0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TvbHpFpB; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MLApMAb0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TvbHpFpB"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 034C8114011E;
	Tue, 25 Feb 2025 06:08:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 25 Feb 2025 06:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740481685; x=1740568085; bh=3EikLttYzU
	bEToLbxqXbdv8oxaOpXUWgipY1A229x6k=; b=MLApMAb0fs5djhYPpClbel5DlY
	6HQXo39nXqvuNlcxpZR+b5yIFWhHbL/pW3ZU2OXUxd+A4YfLqoikDcQFFLaTOTtO
	S/n/zoqBaqMji6BfJ0RWdTbezqhRT5fRbmug4dBb719L/VXqmMZk06QLbq4whYvG
	Fp4y3n+FGykgqbPQlVOzYJtSVjgdv49qz88xm0zEZI99vNPtIuDQNcogKxgmXltv
	RqaYLV1AztZ5b+T4mF/9yCTmoYkz44hn8Zv2PyWDFMuPxZsnLvVVpjrc8fU50VKs
	m+aLg2aziyljeVxeVHFDcYB0KK1g/egp8DPdgPr1Jbf2I2DA9R0oZZl2Apsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740481685; x=1740568085; bh=3EikLttYzUbEToLbxqXbdv8oxaOpXUWgipY
	1A229x6k=; b=TvbHpFpBVzsK7DIeh9M8apRINt6pSm2FXHgyW7WemFhknREH/cq
	wEU9P3k5En0w1fXDCjVy8XlI+yUyoBaEbjA+YW5894gqciHniD4q/MxwUWUqwStq
	M7NI8az5GumajG9sKK5wHXOqEFarg1YDK539X0A/kFXx2EIQSHIHTZvjmFd53kYy
	l+Qv9FNoFXqkMVscJ8Bu88cv90+CMdAjL4f7EQKAfIbzQ5uvQbBtKMyU7Hb91fuq
	o7Ip1Bu8ZH8ltDXGfSZ0HVRTKq6DXZGw3FkIwclulBuYuuRmaiwOwryV6qI5eZAB
	LdSxThOTbp4x6y9n1srEL2A7woyD9DI61Gw==
X-ME-Sender: <xms:laS9Zy9f4vdzLOQOSXnSigr6GuXalv4GpH4RZDRrPOVUudsneX1rYQ>
    <xme:laS9ZyvdMLYigV9b826ixxPwmzgZ1-iIPvV-JwV8hANV1kUcwVGAaPq0QFLlAeHWn
    dEitBfMirssGavJxg>
X-ME-Received: <xmr:laS9Z4Alh56QTkwv9XMrfrFg64qCLxrngsrZzCrFqrUSBwKddNo-B00WK_yDd9cgYfiBaqS5zERVhrUjm6bqwtVVCM1CPokhsFRpBl88gFTmhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:laS9Z6djH8LT_YtVh6MEp0FEw2YFjjpwwqg-J4W6AOTQOX1SxoL8nA>
    <xmx:laS9Z3M8HcfK0OT6NqjgQc3PSa7czWTPTPMgSA90FblCvd--YWBVFg>
    <xmx:laS9Z0mrrAA04SLkLBTKY2DTMs7TyigKIrqiaJ04mE3sgTmnbyEmFg>
    <xmx:laS9Z5sVUhNjRhVf_40i64ObXRob1SZW5JfyFpuzaKL3ixSPX6wX3w>
    <xmx:laS9Z8qcWDIjAET9CzGmZYxmG1StY5ocC-bsJ24dRf6CjQyBhRtL-5cH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 06:08:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6a6cf109 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 11:08:02 +0000 (UTC)
Date: Tue, 25 Feb 2025 12:07:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v2 6/7] refs: implement partial reference transaction
 support
Message-ID: <Z72kjTRDNOM6iFkY@pks.im>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
 <20250225-245-partially-atomic-ref-updates-v2-6-cfa3236895d7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-245-partially-atomic-ref-updates-v2-6-cfa3236895d7@gmail.com>

On Tue, Feb 25, 2025 at 10:29:09AM +0100, Karthik Nayak wrote:
> diff --git a/refs.c b/refs.c
> index f989a46a5a..243c09c368 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2726,6 +2736,27 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
>  	}
>  }
>  
> +void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
> +					      ref_transaction_for_each_rejected_update_fn cb,
> +					      void *cb_data)
> +{
> +	if (!(transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL))
> +		return;
> +
> +	for (size_t i = 0; i < transaction->nr; i++) {
> +		struct ref_update *update = transaction->updates[i];
> +
> +		if (!update->rejection_err)
> +			continue;

This kind of proves my point that `TRANSACTION_OK` is pointless and
leads to a mixture of using and not using the enum :)

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 3b0adf8bb2..d0a53c9ace 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2851,8 +2851,18 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  		ret = lock_ref_for_update(refs, update, transaction,
>  					  head_ref, &refnames_to_check,
>  					  err);
> -		if (ret)
> +		if (ret) {
> +			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL &&

Hm. If the error values were defined as a bitfield we could refactor
this to not be a flag, but have a `transaction->accepted_rejections`
instead that allows the caller to ask for only a subset of rejections to
be accepted.

I'm not quite sure whether it is a good idea, but the logic to handle
all of that could be self-contained in `ref_transaction_set_rejected()`:
if it returned an error code itself, it would swallow any errors in case
the transaction allows a given error, and bubble up the error again in
case the error is not allowed. The function could use a rename in that
case though, e.g. `ref_transaction_maybe_set_rejected()`.

Patrick
