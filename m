Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66799305061
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401815; cv=none; b=OBlUy+npWzn5SmNTUoP/nNVnl0o82tb6siOVkJaXY5VewUNFhiSXEfbkkTrcJjgQmDtINtoDVWwRZOz9TchzLCfloc7DviuwUCGiPE7FbYjwirGiXPDoYtd5okkaEulAnhqhp4DfrBJtTrVeRHkhGlAnQ1/iziNaexU2vS1laUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401815; c=relaxed/simple;
	bh=D0hy0u4OLCLh06Kr9QDPNFNtmJ0Vx+Q/5Yn3NSL3jHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpZjSSKcUP8STEae8t+3SadzlQ0q3fxrhTsJR0at17WDWqUOCH3AjUPvFGVTHRA5YpN1KDKP6KADkESL/ale4wzFhrivgo2vcUfxcXwcvZoUL44Ss7Z6eUcAKWRP1UMkWR119ZjMGladqvUfgW1AvKDbq5SJFQ7RjqUqgpNpigA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f91WKWZy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IBRVch84; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f91WKWZy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IBRVch84"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 5599FEC01D4;
	Tue,  9 Sep 2025 03:10:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 09 Sep 2025 03:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757401812; x=1757488212; bh=MKbSYfSot0
	TJFqTHEI7cbSvhvIvAX2AkM09JpUxLmg8=; b=f91WKWZynACn0drUnLefDD+g57
	BIqwuV58HPVgFh6D+IRPXUjFATgY8sq8MN1lV2pv1rheca786v+SumXKir2CTAmY
	zWVtBmVHHbi+9NutEmMiOddCSTXIFgZULh+3lORI3BbPBSTfaIYQRB8xJBUl3CtZ
	+mF0Zb507QL7xuvUwh/m2K3KYircXSkCJ+N35XRTguh1xnfndimVQ8LAYuIWYIRP
	zTiJLKQFUI+ApMqNjidod7KNNcOKW8YCASA9SreF8Lflm7myk8e6x/fXXuNnHXMB
	i+lLCHX5ddE7BTTmtMWUI1xKeXOgTDbzSP49QOcprEKHAtqIjsj43pQkDh1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757401812; x=1757488212; bh=MKbSYfSot0TJFqTHEI7cbSvhvIvAX2AkM09
	JpUxLmg8=; b=IBRVch84sAkq64nxBs6bSKZ76xPou5Nz9Un/WPJQJHLIrexdxMO
	t9zL1qIA3w8izzCm8lGd4pTNteGjXAelFbbzSHOi6ZSiW0mg7yiaSJihEycOKDga
	hlAAbmKsgXtDOOLcIgkq29Fmnc98WmIDvrna+mImDIs9jwfpWBnfZHpqCxUAVThI
	lLD2m8FH3SHL4nzoKHPWNA02ZQdYhQ1hn7qpkhr15KS4eUBCabV0R76Tpx01yMXv
	F9AZQaTbgYqQDS4IY+qYQ1G5mmz7evJ+1hDjLdcf0SFThLrG73hkm6ZO3VHSTOxr
	KfAF0J74UUliJSzmvm1oBLUsn9Qu9ckaX3g==
X-ME-Sender: <xms:09K_aK_9gUIh0FrFWWiZ87uZg_9nsPGD9joetjO72vlaYoU4V-NSXQ>
    <xme:09K_aGPQql2tTnduDbt7RlqtosNqh6XYdKOXQs7KXcGeZAasPGoCQGTtvZ1MQ_2-G
    1IepmZk5dKK2YbhQQ>
X-ME-Received: <xmr:09K_aGfW2NO9eNClrmBz5wZOuU3sOmQpZfhnLi8PnFReEFaOFKImmIqOen0aKINugpR8EPjobeibCnEOACLa_1Lwidv6frHrBdMRZGq9sL0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjohgvrdgurhgvfiesihhnuggvgigvgigthhgrnhhgvgdrtghomhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:09K_aNWQ_TFZRbT4Hdy_qeN368ZOr7XN9UZc9QdAlkqG5HO-rY-l3g>
    <xmx:09K_aGhiblfNuUwlVGwXKyrWV_8bm2zvC9FwbEaqT6QL4styagEPHA>
    <xmx:09K_aE-egqScIs_Rc_6f2-rC7vrUSgpSFZmETvaRF206y12NqMGSAA>
    <xmx:09K_aAajHdA6qhawDlF-Q5KqWt1lpULdI_Sw5vFGoRyj1EIGSHXgJw>
    <xmx:1NK_aGDsJ7CogiId5TAsYrhYyS5lhiVWI1QsLZkYIo6SHTGu15BD0FEi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 03:10:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba1ff4af (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 07:10:10 +0000 (UTC)
Date: Tue, 9 Sep 2025 09:10:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Joe Drew <joe.drew@indexexchange.com>,
	peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v2 4/4] refs/files: handle D/F conflicts during locking
Message-ID: <aL_SznrF61hbUMBo@pks.im>
References: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
 <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-4-b2eb2459befb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-4-b2eb2459befb@gmail.com>

On Mon, Sep 08, 2025 at 02:37:38PM +0200, Karthik Nayak wrote:
> The previous commit, added the necessary validation and checks for F/D

s/commit,/commit/

> diff --git a/refs.c b/refs.c
> index 4c1c339ed9..ec4f0e9502 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1232,6 +1232,12 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
>  	if (err == REF_TRANSACTION_ERROR_GENERIC)
>  		return 0;
>  
> +	/*
> +	 * Remove this refname from the list of refnames used for validation
> +	 */

Nit: it's obvious that we remove the refname from that list, so the
comment is not helping much. It's much more important to explain _why_
we do that though to give readers the necessary context.

> +	string_list_remove(&transaction->refnames,
> +			   transaction->updates[update_idx]->refname, 0);
> +
>  	transaction->updates[update_idx]->rejection_err = err;
>  	ALLOC_GROW(transaction->rejections->update_indices,
>  		   transaction->rejections->nr + 1,
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 85f2e14e93..ceeec272ff 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -852,6 +852,7 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>  				goto error_return;
>  			} else if (remove_dir_recursively(&ref_file,
>  							  REMOVE_DIR_EMPTY_ONLY)) {
> +				ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
>  				if (refs_verify_refname_available(
>  						    &refs->base, refname,
>  						    extras, NULL, 0, err)) {
> @@ -859,7 +860,6 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>  					 * The error message set by
>  					 * verify_refname_available() is OK.
>  					 */
> -					ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
>  					goto error_return;
>  				} else {
>  					/*

Hm, interesting. Previously we'd have returned a generic error in the
`else` branch, which reads like this:

	} else {
		/*
		 * We can't delete the directory,
		 * but we also don't know of any
		 * references that it should
		 * contain.
		 */
		strbuf_addf(err, "there is a non-empty directory '%s' "
			    "blocking reference '%s'",
			    ref_file.buf, refname);
		goto error_return;
	}

So that directory contains something, even though we've previously
verified that it shouldn't, if I understand correctly. The test case you
add does seem to indicate that there are valid cases though where this
can happen on a case insensitive filesystem?

If so, the comment definitely needs to be updated to explain this
additional error case.

One more question is whether it's the correct thing to unconditionally
return REF_TRANSACTION_ERROR_NAME_CONFLICT in that case now. Could it be
that the directory exists but contains some garbage?

Patrick
