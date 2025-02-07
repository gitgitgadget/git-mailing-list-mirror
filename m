Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985EF22539B
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738944777; cv=none; b=afMhMOQ8kEdRZ17mi8LGtR53iPX48TLEY9oCocwdbyGXzp/KlAWWXNrfdxOqIZsEoYIAg7+2SY/RKWFNebrr/miT6WK/wQvwYdmk/Gkie3p1MEzcJi7qdsS9Oj1jdv4+qfhPdM7StUKBjkUOA0M9t4jUziMx7o/WM+ZOzROcv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738944777; c=relaxed/simple;
	bh=lb7v8YPJAm0V3p0fueA6qzgQPA+KkUjWubqirzGNwsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfY6w0P2PH7HulxxkzqWLspO1GWwrPuufj10pfVPX2R6Je43iHBmEyb4u8/lrQxSUsM0SbqX2vbWly6S/h9thbkhhv8lhw5EsE0w6N7Z0yOH4cdF5I4G57p1p4ZvBAd38DcJJkf/QHJe1psU+2ejfeJAY++3EtxxY4Ac+NRnsfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k+hJLA7q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FOPBTurd; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k+hJLA7q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FOPBTurd"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CD1621140186;
	Fri,  7 Feb 2025 11:12:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 11:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738944774; x=1739031174; bh=Hzrf+p2msl
	M/sdG+gwjrDCbgYyKy/G9TjqdbL9wLIEE=; b=k+hJLA7qIyV1LYtM18tZ4YHiTq
	SbhEpJ0wKT3UHZlpXxkNDG/7oq6mKyIPHvJP7snWYU7RU6+0l3kkEIfk5XjUPy5Z
	vMkCek13xp08bK10OMm+ACpEiv+xJsS9bY3ryIMeaaAy/+AQIwtWgECJffd1H6EG
	VdBkO9UvWfjAtTu2nSNdEcYYQ9wZ35D/HCm3wynIonKklzWPaf6mhekiEfXB70hM
	6te080kNLXV0dnn4O+iVdd+V4XxvzSCW7ucVZDZhCb4OiQDta5hMvk2uF0E0fUtr
	xnGSx0IsQcymDMGlUEyQ3M1ht2Zik5RXnZYyOp8h/7N3606l5oIK6Wnr+uAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738944774; x=1739031174; bh=Hzrf+p2mslM/sdG+gwjrDCbgYyKy/G9Tjqd
	bL9wLIEE=; b=FOPBTurdP9K1olMtUm3K/F/XYZL+3TJVsf6claLGDJyxgCaA8fl
	wf67SqwOdjTKlQ5Vxtkbhn8BWkkbcYx4Fi74omaFH+RIgtHetanmUjTuX7KgOEOw
	rhFNbb9VpHPN7GKw5ceExE0obWfCGbI2ZoWCg1FQewDdAWI4B3BWtESfTvScjQEj
	fUL2b+3KQQET+3Z+b64hkRju7RJZ0fP85abLcU+k9TCK/wtIllhTcjAUAMUI8pEE
	0aAryJou3h9Rv+KwW1dY4DDxmhp05tG9RfIkrdKxAN/TWSF+2AI/gVFmArv1id4l
	qrY7tWQNHC7N04IkwhB4mo7yk+PkJ9OTBcg==
X-ME-Sender: <xms:BjGmZ8lPp1LltPbNT1xwpjEF9ztqu0XxobtJ7YruLJrsM7PBuJ49lg>
    <xme:BjGmZ72qLaa10565WHotA1yoIyD-q4Gx25WAQSybw-2W-MEOlU4S_qET-DG147oVf
    DSfcjjwtKvcAyBVvw>
X-ME-Received: <xmr:BjGmZ6rYcwwyPnW5x5MhKtWubLOmiuZoKC-zi3UIfC_wwAhL4eAk7WOnEPrR1mfd5uDOljgGw3V9SXfRyvFZoS1-uOZ2dW0RvXxprFC1JR2jvw7z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BjGmZ4lol891Gg8RA9rPIIyQU6XjMYw6ckY9yW8lAA1mp39AyWCaTw>
    <xmx:BjGmZ61c8tP1gyFrVpcUiKd5xGV6Q-PfEKeg2F5AhJRKgI0jBXvxJg>
    <xmx:BjGmZ_t_1_MHBCdiGRhZQYyX3KWZYPqjPKX71xyWApyWZr1Zkj8e9Q>
    <xmx:BjGmZ2WRvodqoDFYNEAyNoeGR2226MKdx3dmPySYkvFIjN7aWSIJXA>
    <xmx:BjGmZ_zJM5HPz1FertSMcS4et0u6cpixa_tUtwJe9EFpswrqzDzOijey>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 11:12:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8bce7d46 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 16:12:52 +0000 (UTC)
Date: Fri, 7 Feb 2025 17:12:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH 5/6] refs: implement partial reference transaction support
Message-ID: <Z6YxA4BlhNwbeYk-@pks.im>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250207-245-partially-atomic-ref-updates-v1-5-e6a3690ff23a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-5-e6a3690ff23a@gmail.com>

On Fri, Feb 07, 2025 at 08:34:40AM +0100, Karthik Nayak wrote:
> Git's reference transactions are all-or-nothing: either all updates
> succeed, or none do. While this atomic behavior is generally desirable,
> it can be suboptimal when using the reftable backend, where batching
> multiple reference updates into a single transaction is more efficient
> than performing them sequentially.

In fact it's even inefficient for the "files" backend. The whole
machinery around creating a new transaction, preparing it, committing it
and then cleaning up its state does bring a bunch of overhead with it.
But true, for the "reftable" backend it's way more impactful.

> diff --git a/refs.c b/refs.c
> index b420a120102b3793168598b885bba68e4f5f5f03..75dbd84acbc41658d4b8b6b5e7763c04e78d0061 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1211,6 +1212,14 @@ void ref_transaction_free(struct ref_transaction *transaction)
>  	free(transaction);
>  }
>  
> +void ref_transaction_add_rejection(struct ref_transaction *transaction,
> +				   size_t update_idx, struct strbuf *err)

"add" to me sounds like you're adding a new thingy to the transaction,
but you rather update something. How about `ref_update_set_rejected()`
or `ref_transacton_set_rejected()`?

> +{
> +	struct ref_update *update = transaction->updates[update_idx];

Do we want to `BUG()` in case `update_idx >= transaction->nr`?

> +	update->rejected = 1;
> +	strbuf_addbuf(&update->rejection_err, err);
> +}

Do we really need a string as rejection error? I'd expect that the set
of failures that lead to rejection should be rather limited, which means
that we could use an enum instead. This would unify the errors across
backends and also allows us to figure out the root cause of rejection in
other subsystems.

If we introduced an enum, we could eventually even iterate a bit on the
mechanism and rather trivially tell the backends which kind of failures
are acceptable. As an example, a conflicting ref update may for example
be ignored and not cause failure, a conflicting path name might cause
failure.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 9fc5454678340dd7c72539bfa0f15ee7eb24b1ff..99ec29164fbd30635125cc2325aab3d300cf906c 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2852,8 +2852,18 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  
>  		ret = lock_ref_for_update(refs, update, transaction,
>  					  head_ref, err);
> -		if (ret)
> +		if (ret) {

I wonder whether we want to accept all failures. Some failures are
certainly benign, like for example mismatching expected OIDs or a
conflict due to a preexisting ref that blocks the path. But other kinds
of failures which are unexpected might be a bit more on the dangerous
side to accept, so I think we should be careful here.

The same comment also applies to the other backends.

Patrick
