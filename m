Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C703A2A1A4
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502397; cv=none; b=OKE2HIDo3ExnedJOwws1hFT5c+X2Uvr7MwqBGFsPsTaJstZWmabxJ4dzfXL8WkulczmJ9WmnuMMVWGTN3RUX1UU5VFaN8mgvfrEJxxVwg2FtL92ibjheDX08G4ijpDVkdV48ubt4cDsWAOT6L2vhP9m9wzYvgfxM3OPB44Njcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502397; c=relaxed/simple;
	bh=Eq9DtGqZA7YjG8QaaItIxJ4ghKn05mBdrA5uHj9kjcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM7hedHem3+L+EPFAdoGm+Xc2NakAsFWOxj7R9gkR4nTHf1mzysymb5vY/S0ngXKaB2j1RHu/i1p4ucmhaBSgB/MWqMY9KI67vL1s+LSMPAqtNQm8wT55tdCvY2UzFbNidvVl1rTMAcASxobXfGFNCt8ff+A5nzYYl3Vjv714sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rl7BPrj4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lWcuZlK4; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rl7BPrj4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lWcuZlK4"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id E3A6713833D4;
	Thu, 20 Mar 2025 16:26:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Thu, 20 Mar 2025 16:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742502393; x=1742588793; bh=tGFQgQ4xf5
	y/G8LWBl9PZ71ol4Vu5oiomAuXUR0IeUs=; b=Rl7BPrj4YldiHwjyFsJKmiiIWd
	W1He3uQ9/z41XLjVaqoWxsF44qZruEyhN/uSUcQLfChvvVlJHKDpF95BpiLNRkbE
	MEhj7YyjE3NL4nkBj2XKiYJNVA25vw6iQFFHp784Xdpt1vFTl8IjjTpjqOF4wfLI
	jFwsMboyC3PwNggL08Y0lWr5xjqx7d7cPEBqM/ws1y9urWq6ITcnbEzl6f8jrs3h
	Q1xR7wkI7RVJdFNkDmbTQfupr9WOEkQ4Lgox/hKAZOF2ZEozDoDFRLdOyONaiORJ
	dU5uNv2dWkZTkYmfb8ndlonSmpM6LvusO8DYPH3TeVC06RvEarFovh8V1FEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742502393; x=1742588793; bh=tGFQgQ4xf5y/G8LWBl9PZ71ol4Vu5oiomAu
	XUR0IeUs=; b=lWcuZlK4AvGzTz+YyVzrCtTXkbBTJtYvvf2ufsUCztZTnBXV14C
	xE4YYCUr7ADHTSvZq7X+Pk5j6pI2godElZCoriy2ilcO4LoyM//uRahKKryQRyWW
	Y+mafND2hs3LVK86oxzEl26OeRUjQ+vW7uoHcQ8b08G4SqQvLxz6JOIN+NUFmAUb
	jJIyrDC47tbbZUNiDreiv1GSzVTnImhV9snFIdE1HrqSMY1f2xB7S6W9PFMy08jd
	DMEYnmyqIqyNXoLJnxPD43acX0igo/6WPC8aoFZ5brKwSJI83d4/2NiJaTDZElJS
	0mOqjLJRxz2lGygCizhfFTe1OvBr6e0O3Ig==
X-ME-Sender: <xms:-XncZyste30GAQFQLIM1d-fQtxr16LzYL1vSH_twJXTGXfeOrhMEGg>
    <xme:-XncZ3f5oE2kP_X46bmG6DM71g_Rh8RI09vAKEYkJhY7tqrQy5mmEs-UI3-LvpiwC
    P2DFXWCA2pCSx919A>
X-ME-Received: <xmr:-XncZ9x5v9Ag1du4Cnht5dNgY_0GfvFVP3EiVqNUOcLr56TfIh8eqa5eRzp_k_3LLMx0-puPwsvN9P9tL_CFwMStC87aQZiOzggRqBTbJ5uTxZB8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeludejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:-XncZ9P2tUy727HE9bDip8XJAW1g-9RzgUanMyJ2kMgiGmhiKi2gyw>
    <xmx:-XncZy9uA-ZSKkEWf_mXHCydZvB-KlcIIy0VAYM3UUsHt0P7UfGiuQ>
    <xmx:-XncZ1XArtp7CTpyuggvzlVAWoFJTa1EW4BP3t9ZkWMolIJ34yXaaw>
    <xmx:-XncZ7fTLZReosAuyzMzzGQK9jJ5BB9kessh_O0ExG-cTbWCHXBmIQ>
    <xmx:-XncZ2aCyyf6XD60_mE15v180nP6KRZXMyPPTxpumAdkNnmR4cd8Aw6N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 16:26:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3bb2111 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 20:26:32 +0000 (UTC)
Date: Thu, 20 Mar 2025 21:26:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 6/8] refs: implement batch reference update support
Message-ID: <Z9x590KcwP8WGGG-@pks.im>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
 <20250320-245-partially-atomic-ref-updates-v4-6-3dcc1b311dc9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-245-partially-atomic-ref-updates-v4-6-3dcc1b311dc9@gmail.com>
X-TUID: Z7NNJoz7lAmk

On Thu, Mar 20, 2025 at 12:44:01PM +0100, Karthik Nayak wrote:
> diff --git a/refs.c b/refs.c
> index 3d0b53d56e..b34ec198f5 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1206,11 +1210,45 @@ void ref_transaction_free(struct ref_transaction *transaction)
>  		free((char *)transaction->updates[i]->old_target);
>  		free(transaction->updates[i]);
>  	}
> +
> +	if (transaction->rejections)
> +		free(transaction->rejections->update_indices);
> +	free(transaction->rejections);
> +
>  	string_list_clear(&transaction->refnames, 0);
>  	free(transaction->updates);
>  	free(transaction);
>  }
>  
> +int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
> +				       size_t update_idx,
> +				       enum ref_transaction_error err)
> +{
> +	if (update_idx >= transaction->nr)
> +		BUG("trying to set rejection on invalid update index");
> +
> +	if (!(transaction->flags & REF_TRANSACTION_ALLOW_FAILURE))
> +		return 0;
> +
> +	if (!transaction->rejections)
> +		BUG("transaction not inititalized with failure support");
> +
> +	/*
> +	 * Don't accept generic errors, since these errors are not user
> +	 * input related.
> +	 */
> +	if (err == REF_TRANSACTION_ERROR_GENERIC)
> +		return 0;
> +
> +	transaction->updates[update_idx]->rejection_err = err;
> +	ALLOC_GROW(transaction->rejections->update_indices,
> +		   transaction->rejections->nr + 1,
> +		   transaction->rejections->alloc);
> +	transaction->rejections->update_indices[transaction->rejections->nr++] = update_idx;
> +
> +	return 1;
> +}

If we had a `struct ref_update_rejection` we could store the update
index and rejection errors in the same location, which might be a bit
easier to reason about.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index d90bd815a3..7bf57ca948 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1327,10 +1327,11 @@ static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
>   * remain locked when it is done.
>   */
>  static enum ref_transaction_error write_with_updates(struct packed_ref_store *refs,
> -						     struct string_list *updates,
> +						     struct ref_transaction *transaction,
>  						     struct strbuf *err)
>  {
>  	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
> +	struct string_list *updates = &transaction->refnames;
>  	struct ref_iterator *iter = NULL;
>  	size_t i;
>  	int ok;
> @@ -1411,6 +1412,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
>  						    "reference already exists",
>  						    update->refname);
>  					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
> +
> +					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
> +						strbuf_setlen(err, 0);

Nit: you can use `strbuf_reset()` for this and other instances.

Patrick
