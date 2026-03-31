Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF23C1408
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943339; cv=none; b=tConALpqKCKNBMf7wwnXWv3zWOgr317vT5UKO8WkEmltOPJII3+/bEkTo1cFSQfkXs9Me7Vq7GCG1l72ym8O2RWQwfa1S9LMpGW3qR78igxEdsSPyv2C4i3e8BdRYG4zAmCfOHIC7SZoDe1mGpQnNYH/4cmgLEv/SA0Hj2pFyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943339; c=relaxed/simple;
	bh=1RN9niom0DxlLn6PiUt7bs9ONWModigCMP0fccX+eLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovnEFzvstFh240U0gwi05LxRJXzBuSdE/pj65cFk8Hmiq8wre053iWIOqjsA4npPVwHWeYWgQnUw0h2ce46AWZ5afuXKMRfcC81XACIJldI1fuQ71qyH6GKRxz1uC/eRDeOO3U+iOpuVhSYUH9omnJmEb4cSoYBp7a9q2h5Kcxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=prWuaNJY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CdhTkkw/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="prWuaNJY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CdhTkkw/"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9901B1400259;
	Tue, 31 Mar 2026 03:48:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 31 Mar 2026 03:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1774943337; x=1775029737; bh=ryKccWbEsg
	uV7Mu072y3zCam+FMdkSngwP+SZyALBgM=; b=prWuaNJYXlx01/6O9mqyJiA4QJ
	y9PIi7SMP6mZFczfNfQ4GxkMNGMFgMEJXPQr3jQkpHet/cohqzU4uXS8bOSbL8Bb
	sny6hn1cQTR24wFZzYqt8ARMKYhg+f6jXII2IQvY0PLHLhx0I9ZFbCc17aKZabp7
	6KIAMBw1y6wPbyb59h36HKQ1nYaMDT7Nid74ALl28MKZvD1iITckE5hrkgJSMZqf
	7ye0d/VVNo4cflU82UESpjbuQZ6cvcp16bfWRwm0rXbAUQJ8k8YOXbxnBpWx3Gou
	1VkLnhZgOHSLXYBJW8RztHyFydWbR/8QOEjGGyy2ngjgSlbvs7g2ASesHdfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774943337; x=1775029737; bh=ryKccWbEsguV7Mu072y3zCam+FMdkSngwP+
	SZyALBgM=; b=CdhTkkw/+Az1OTYva+bw+Z3M3h2a7oGEG0mcfy4RVaw1IDXI2LK
	AOrvMryLENY0YR1QBV7NR2g3g2A9l9NzKKj1qoERSW+rvlc3C8RT2dsR0T8bJ8s1
	2mSXHLc/BLkSfjjq2+upfQFfeiXRSsato2vPJMVNf3ihGSjaz0B4EmztcHgBTBI+
	74HwYjsweSJklAUO51XBqxVXrnhbM3P6fw+zPYACqw+2ij3XiBdLSsEBw3dXsxhv
	ZqkmBwu4wip0ujgsRZdd6V45zzJJVQnr0836G84zthK0Ok4KZ8E4XlrIro+ub6xn
	C60J1AxiKltwvZQhZFoRYXptd+3Pv+L/arA==
X-ME-Sender: <xms:aXzLaeMFZPVSa2hTttSFw5ClPsGr78gLeQe8zuvNx22Vsxd7fJwcbQ>
    <xme:aXzLaS8TuHj8lO_Jt9Feii4ZoDVBQ89Iez3T5M6WM8_pGuSJEjVCTvmXja9imC-9Y
    zMh_VpCtSf-Ta9KJV6yMWgi256VTTRSs2MDFo8eoyofX817Z-exIQ>
X-ME-Received: <xmr:aXzLaS5bOW1BmtfUpPIcYhFBAuwbvjDtnTOOh5EvwGF2JGavieaGJPR5rtj9sllLYvzbD-vUNDZsg09pz4SFaq4KGVocriMVLE62vQDKGaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aXzLaZ1vmSN4ct9A9RAfhxWpybfdefW79fvaFFCPbbTIfXaNeKt3bg>
    <xmx:aXzLaZARHveBc9-czY-3uvocJJJbv_jg3E4fBMFdc24alDnyp5U7BA>
    <xmx:aXzLab3F7OnZ0_nvVFV2uuUenPHxghJtFzBYusCfh6wOGcEr-oRcvw>
    <xmx:aXzLaTuySF9IZdO8wqWHX7-1BcH68vw4Ncw1TKoTktMeSnq3g0pW9Q>
    <xmx:aXzLaQ9nWRkWfzx9NxzQ46cQfuQ2qVf8a_NcBBE6DRHfpl7tbtY4CBP3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 03:48:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 07da1a2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 07:48:56 +0000 (UTC)
Date: Tue, 31 Mar 2026 09:48:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] odb/transaction: make `write_object_stream()`
 pluggable
Message-ID: <act8ZWi5On9uQptf@pks.im>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-7-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331033835.2863514-7-jltobler@gmail.com>

On Mon, Mar 30, 2026 at 10:38:35PM -0500, Justin Tobler wrote:
> How an ODB transaction handles writing objects is expected to vary
> between implementations. Introduce a new `write_object_stream()`
> callback in `struct odb_transaction` to make this function pluggable.
> Wire up `index_blob_packfile_transaction()` for use with `struct
> odb_transaction_files` accordingly.
> 
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  object-file.c     |  9 +++++----
>  odb/transaction.c |  7 +++++++
>  odb/transaction.h | 25 ++++++++++++++++++++++---
>  3 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/object-file.c b/object-file.c
> index 4c797d6498..b1c97faef3 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1680,10 +1680,10 @@ int index_fd(struct index_state *istate, struct object_id *oid,
>  				.data = &data,
>  			};
>  
> -			ret = index_blob_packfile_transaction(odb->transaction,
> -							      &in_stream,
> -							      xsize_t(st->st_size),
> -							      oid);
> +			ret = odb_transaction_write_object_stream(odb->transaction,
> +								  &in_stream,
> +								  xsize_t(st->st_size),
> +								  oid);
>  			odb_transaction_commit(transaction);
>  		} else {
>  			if (hash_blob_stream(the_repository->hash_algo, oid, fd,
> @@ -2146,6 +2146,7 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
>  	transaction = xcalloc(1, sizeof(*transaction));
>  	transaction->base.source = source;
>  	transaction->base.commit = odb_transaction_files_commit;
> +	transaction->base.write_object_stream = index_blob_packfile_transaction;
>  
>  	return &transaction->base;
>  }

I was originally expecting the upcast to `odb_transaction_files` in
`index_blob_packfile_transaction()` to go away in this last step, but
that of course doesn't make much sense as it now _becomes_ the
implementation of `write_object_stream()`.

But should we rename to `odb_transaction_files_write_object_stream()`?

> diff --git a/odb/transaction.h b/odb/transaction.h
> index a56e392f21..584e8de36e 100644
> --- a/odb/transaction.h
> +++ b/odb/transaction.h
> @@ -12,14 +12,24 @@
>   *
>   * Each ODB source is expected to implement its own transaction handling.
>   */
> -struct odb_transaction;
> -typedef void (*odb_transaction_commit_fn)(struct odb_transaction *transaction);
>  struct odb_transaction {
>  	/* The ODB source the transaction is opened against. */
>  	struct odb_source *source;
>  
>  	/* The ODB source specific callback invoked to commit a transaction. */
> -	odb_transaction_commit_fn commit;
> +	void (*commit)(struct odb_transaction *transaction);
> +
> +	/*
> +	 * This callback is expected to write the given object stream into
> +	 * the ODB transaction.

Should we note that for now, the expectation is to always write a blob?

Patrick
