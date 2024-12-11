Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB8438DE9
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927200; cv=none; b=DEXBupafU29kEk/fpiHlp1QCrug55exai0kWdEWctziQ1Zx0T+zxusLJximbIDC3XZ6kfV7AG9FWUL32IziAl/l0l8fbE6zI1AC/9VN8Hw+LkELQ3E/biSx1xzPea0RiwbQffe4VzKhg+37tsrQnfa6rPhSsJohJy7D7lI7empo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927200; c=relaxed/simple;
	bh=LmWiP8+CKS/cXff+SHrfrxycror5k3agtLvkfaydyO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zbj+9XIDhgJgCMjOwXqDm6rX7+l4hXsEKRQzLNtPGOrize0MNxB8lKMgmBHgAW2EYHr/DOQ/Clu9iexPxodPbYh8xKa/CY4JSTvR6qjxOPcBJC/ZXlcm59+tWc5bz/RnyzTj6KV2S+phw5Bs1P/igAkTE7QQ9hZ/MZ6D8l4PKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FWuau0X8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E4JbmWlp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FWuau0X8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E4JbmWlp"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAAF52540171;
	Wed, 11 Dec 2024 09:26:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Dec 2024 09:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733927195; x=1734013595; bh=Zd8LSqIAuy
	UmvuQn732o33+iTrynL/Qi9qtGFEz+00Q=; b=FWuau0X8rGoieWiX4JSTQePkZE
	i1sZeizYKh3kQJA9TorB6Ipc3EatujqYh00JMkdD8UQtP/tSk6yp1SCwpmu1Imo8
	s75yPzazKCF2cwTOaoV/JcurNlqUelR4wTJ0uan3HnTDHtnlBu7IMqQIw6+q2aAG
	+/vjwkwWSdTKJ0itHs9SN5uTOY9wG+HA1uqjJyZygp1G4R+beujM/8JTYvkIMQ24
	r3ywDPA7YUJqXu/TXAjbrl9yy2ZQAQAsiJh6hKBkjTmvhytKT1VOifAUvk3rc3ZA
	kCz9CMC+p2F9OAFkrVbX+MU96iCPImIEsFdaEPbpPmRdNB59D4ZH0MJA1l1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733927195; x=1734013595; bh=Zd8LSqIAuyUmvuQn732o33+iTrynL/Qi9qt
	GFEz+00Q=; b=E4JbmWlp11G84x0tHkT8UAJeW008KkuCHNfJER24F69AkuzFHIa
	EvCQFyNZ1ovOlTEFRmh792Ng03AKmAvnSrhnXTtRpgspCAKqh0hs6aImyniRIjO2
	vl78WnKpHe3mKxQqu1WNrlT2ObPZXx5iDIOuecdj+HDtBZ84Q/XIP4+VlnxNj1CL
	K8nzBlKlYRIeyuzHiS3zqwvSXsYItA7b2QSGzjpsmphUx1StqxymjtVwLQ/NnL68
	mSqzuAFzDgQEZPZA/pMz8+YoxzB95YGPnbKApDFCIb8by+gIknz/5TT/i8DhEXtn
	4VgEETlSmpMFnKrY+jNb4LCj+eEs5WbSDzQ==
X-ME-Sender: <xms:G6FZZ9r28EA-4t9GPUreRx7lIGtHs7RLaV6hU1IOtOQrX-DXY0_1eA>
    <xme:G6FZZ_oSTwlKuQVbqQVB7Txyjehy8FfNk66K70n6d_2voLHmsnE0nw4uxtY8yZ6Tx
    g31cud_oT5JLAdAig>
X-ME-Received: <xmr:G6FZZ6MIkEOXfTsGSENT06zTTHN4Pv52Fz60L0tVifyKcvIAoVHOCIHYh_IcHJNUhmf_cExFfgjXN5uVPb8OKoySLmy5HiGCJSeDAhrNuaBU3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfh
    grmhhilhihrdhorhhg
X-ME-Proxy: <xmx:G6FZZ46LPcH2LXAuNMYvQXd78gjYi-fZCZKvIV5EujT61SzWQuC-fg>
    <xmx:G6FZZ87DwZmgPIq-vMPPjvuyDNMzH_z8ECttm9Fuet0n8IRUfsooeQ>
    <xmx:G6FZZwgPOjRR-iEqX5lkgmJbRlxaUe0B4rKyonpD73GTU7z7LJmMpg>
    <xmx:G6FZZ-4nN6T9m3jvu-LIUVFldiq7YTvodM_rRd5g4zlBqUIvtB_3aQ>
    <xmx:G6FZZ32GQFkMO39fpSlQp-rROnKYBduI5RLhoRM4UBvix0JtDXc3A6q7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 09:26:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3cc50906 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Dec 2024 14:24:56 +0000 (UTC)
Date: Wed, 11 Dec 2024 15:26:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/7] refs: introduce the `ref_transaction_update_reflog`
 function
Message-ID: <Z1mhCWXowokIaFR5@pks.im>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-5-d4bc37ee860f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-5-d4bc37ee860f@gmail.com>

On Mon, Dec 09, 2024 at 12:07:19PM +0100, Karthik Nayak wrote:
> diff --git a/refs.c b/refs.c
> index 732c236a3fd0cf324cc172b48d3d54f6dbadf4a4..602a65873181a90751def525608a7fa7bea59562 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1160,13 +1160,15 @@ void ref_transaction_free(struct ref_transaction *transaction)
>  	free(transaction);
>  }
>  
> -struct ref_update *ref_transaction_add_update(
> -		struct ref_transaction *transaction,
> -		const char *refname, unsigned int flags,
> -		const struct object_id *new_oid,
> -		const struct object_id *old_oid,
> -		const char *new_target, const char *old_target,
> -		const char *msg)
> +struct ref_update *ref_transaction_add_update(struct ref_transaction *transaction,
> +					      const char *refname,
> +					      unsigned int flags,
> +					      const struct object_id *new_oid,
> +					      const struct object_id *old_oid,
> +					      const char *new_target,
> +					      const char *old_target,
> +					      const char *committer_info,
> +					      const char *msg)
>  {
>  	struct ref_update *update;
>  

I'd personally avoid reindenting this block. It's somewhat-common
practice to not align all arguments with the opening brace when the line
would become too long. The reindents also distract a bit from the actual
changes done in other places further down.

> @@ -1190,8 +1192,15 @@ struct ref_update *ref_transaction_add_update(
>  		oidcpy(&update->new_oid, new_oid);
>  	if ((flags & REF_HAVE_OLD) && old_oid)
>  		oidcpy(&update->old_oid, old_oid);
> -	if (!(flags & REF_SKIP_CREATE_REFLOG))
> +	if (!(flags & REF_SKIP_CREATE_REFLOG)) {
> +		if (committer_info) {
> +			struct strbuf sb = STRBUF_INIT;
> +			strbuf_addstr(&sb, committer_info);
> +			update->committer_info = strbuf_detach(&sb, NULL);

Can't we simplify this via `xstrdup()`?

> @@ -3080,10 +3081,12 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  		}
>  
>  		/*
> -		 * packed-refs don't support symbolic refs and root refs, so we
> -		 * have to queue these references via the loose transaction.
> +		 * packed-refs don't support symbolic refs, root refs and reflogs,
> +		 * so we have to queue these references via the loose transaction.
>  		 */
> -		if (update->new_target || is_root_ref(update->refname)) {
> +		if (update->new_target ||
> +		    is_root_ref(update->refname) ||
> +		    (update->flags & REF_LOG_ONLY)) {
>  			if (!loose_transaction) {
>  				loose_transaction = ref_store_transaction_begin(&refs->base, 0, err);
>  				if (!loose_transaction) {

Makes sense. While we already had REF_LOG_ONLY beforehand, it was only
used in very specific cases and thus the support implemented by the
backends is lacking. And given that the packed-ref backend does not
support reflogs we have to queue these up via the loose backend.

Patrick
