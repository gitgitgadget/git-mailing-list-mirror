Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486CB1E489
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783000; cv=none; b=ooZ6oMkUh3m4hnrsB5zIq7U2cka/B++/BEtNOkBaOvT+aSnveDhfmqonapQhio80iyr0D1Ha1acccRy/dayxpWjdgVdPZGBbfnmjflDp0vGB8lYoLH9b9VE24c3ULOK8bdIvHvSefnjS1Axkr/E9IukMJVrHO2qPTVWOAQvvY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783000; c=relaxed/simple;
	bh=xT24Gs2FCgFVW6q9azxCwlVPerlVJc4zJymF2GSzjIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5r48Hgy5N3QWW2zsiys0J7N//dtHW6Zao4jUEIx6nGCjnDJNYtiouMbOK6wr+oTblh0aUHI0q05WLH89h+/Q3zMw36XjY68FIH0irxSoKJA58Cq4zIKRTh/qRQQ/hmhZwVeyaLaxcoNDoBSvgy3bZKtVtVylPoc5LyOBNaRvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGZk0wnP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGZk0wnP"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2232aead377so32517305ad.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741782998; x=1742387798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vRvHrHvLSksZYNtRc3+BJsQ82vfKOHxACn0MPCA60Gg=;
        b=hGZk0wnPnWAASi2U8VaAS7vAShMV93MueRKfLMx3VjQi2f5sY0IansOPPnTesnHG4J
         357SMqip67DfL7aefmBrrFint3HFzMoQWlvDrNT3RYCpZJo+7PBsUMfBqPO7fScwSjzn
         y0lNN7nd6fcslISZfWjFEIKZJ3PFscwOkIEpOEUT1n/4kfonEcSN1hCSjZXg2m1GaQ/S
         2MKKVrRF/YL5gr/tTS8ZRrp102DFjgUiQWLUzSFRIdnCuTzjofeik6k52IVmldOKWp3c
         hE/IO24UwJfaLEYsRNvkmY5kTobd6plcNWX7j1WOahibWv8vWnUEdzBxJcJ4lOG9hcQj
         i2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782998; x=1742387798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRvHrHvLSksZYNtRc3+BJsQ82vfKOHxACn0MPCA60Gg=;
        b=Kk2Klgh9qF58L5Ikc7UYpYhQrAeuQmVxb3hxdFs6VRVX+YlZq07popMTHR5hPrYIxb
         pxvgbEG8TkvW0tjDUkIBQYmbH7rcIu6eOGET4ZhkCNfQ4FvTgFzTY1j9Ut9+vSwJmwD3
         c7uwCWOGJryJEJt6uWdCK2W2GOdf//S9rkXMvSz0yH8E/IhcaY8/o59EOeQmgH/8UPUn
         T9ovwaO0kKjR3rJvGZfru20SB1ZxzJZskOhxLQOOsd7UXAquoBjJqNoxSwQEzkMBDPDW
         22aNw/VNn3IhP176/efxo4kleIerUDmXqIJGVsr6sSntvSrfRM3lyuFFgcrtNsaYCcYe
         v9Jg==
X-Gm-Message-State: AOJu0Yyk9YX2REA4+ZsQYgX2dfgL0vBVMD448dk0HOQk9W3V5gqpCShU
	dEA7nzrpQdNtqgLgLG2jl/ySWH2uEhdEsTY4m908BwrXPgkIL/ZR
X-Gm-Gg: ASbGncvMBiU8CLEW3oDxF1XJmq45MKYyW/OhW5ebHBlDsApJziv7dABNv+TMViUE4RS
	wokIBgUTg9cgstJBkf31jDzo85RozbSVWOkP7+b8Yt/vjitOMs6ebZvnl9unztBT+Bvr2sQVKPE
	byqL7GMW2k5QF07iM3nG9TSMQKU+thffObyjnw2iQ7S7IKT4Wz+PhGaRYzxtADcTs5YOTIyks/c
	GPWHCWRg6UoB/X6gHIBQ8blm1zhwTqezUfgAjrjWDZtoZwLTjg3J6a8Ns1B2RwmEJowgEK1WzJI
	xasaOVHUcNReT52BIcLh7mOjvWoWgU+Np0t6KwbV
X-Google-Smtp-Source: AGHT+IGBZfOZKbDjxmSMnStSms3Xq3QlPPDMyJdrlZtHcxC35Y9iJH/HShh2AhO8l7BzC9ftQ4ApgQ==
X-Received: by 2002:a17:902:ce8f:b0:224:1c41:a4bc with SMTP id d9443c01a7336-224288951edmr337398705ad.12.1741782998295;
        Wed, 12 Mar 2025 05:36:38 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301182186dcsm1643387a91.1.2025.03.12.05.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:36:37 -0700 (PDT)
Date: Wed, 12 Mar 2025 20:36:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 04/16] refs: introduce function to batch refname
 availability checks
Message-ID: <Z9F_3xu6RXeelXJK@ArchLinux>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-4-dcb2ee037e97@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-pks-update-ref-optimization-v5-4-dcb2ee037e97@pks.im>

On Thu, Mar 06, 2025 at 04:08:35PM +0100, Patrick Steinhardt wrote:
> The `refs_verify_refname_available()` functions checks whether a
> reference update can be committed or whether it would conflict with
> either a prefix or suffix thereof. This function needs to be called once
> per reference that one wants to check, which requires us to redo a
> couple of checks every time the function is called.
> 
> Introduce a new function `refs_verify_refnames_available()` that does
> the same, but for a list of references. For now, the new function uses
> the exact same implementation, except that we loop through all refnames
> provided by the caller. This will be tuned in subsequent commits.
> 

After reading this patch, I think we may could add more motivation here.
What's the advantage of checking batch refname? From my understanding,
we want to check the group of refnames and if we find one which is not
good we will just return and we don't need to check further more thus
avoiding unnecessary checks which improves speed.

When I read the commit message, I wonder if we will loop through all
refnames, we still need to handle the same number of refnames. So how do
we avoid this?

I think we should make this clear.

> The existing `refs_verify_refname_available()` function is reimplemented
> on top of the new function. As such, the diff is best viewed with the
> `--ignore-space-change option`.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 169 +++++++++++++++++++++++++++++++++++++----------------------------
>  refs.h |  12 +++++
>  2 files changed, 109 insertions(+), 72 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index f4094a326a9..5a9b0f2fa1e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2467,19 +2467,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  	return ret;
>  }
>  
> -int refs_verify_refname_available(struct ref_store *refs,
> -				  const char *refname,
> -				  const struct string_list *extras,
> -				  const struct string_list *skip,
> -				  unsigned int initial_transaction,
> -				  struct strbuf *err)
> +int refs_verify_refnames_available(struct ref_store *refs,
> +				   const struct string_list *refnames,
> +				   const struct string_list *extras,
> +				   const struct string_list *skip,
> +				   unsigned int initial_transaction,
> +				   struct strbuf *err)
>  {
> -	const char *slash;
> -	const char *extra_refname;
>  	struct strbuf dirname = STRBUF_INIT;
>  	struct strbuf referent = STRBUF_INIT;
> -	struct object_id oid;
> -	unsigned int type;
>  	int ret = -1;
>  
>  	/*
> @@ -2489,79 +2485,91 @@ int refs_verify_refname_available(struct ref_store *refs,
>  
>  	assert(err);
>  
> -	strbuf_grow(&dirname, strlen(refname) + 1);
> -	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
> -		/*
> -		 * Just saying "Is a directory" when we e.g. can't
> -		 * lock some multi-level ref isn't very informative,
> -		 * the user won't be told *what* is a directory, so
> -		 * let's not use strerror() below.
> -		 */
> -		int ignore_errno;
> -		/* Expand dirname to the new prefix, not including the trailing slash: */
> -		strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
> +	for (size_t i = 0; i < refnames->nr; i++) {

Nit: we may just use `for_each_string_list_item` instead of use the raw
"for" loop.

> +		const char *refname = refnames->items[i].string;
> +		const char *extra_refname;
> +		struct object_id oid;
> +		unsigned int type;
> +		const char *slash;
> +
> +		strbuf_reset(&dirname);
> +
> +		for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
> +			/*
> +			 * Just saying "Is a directory" when we e.g. can't
> +			 * lock some multi-level ref isn't very informative,
> +			 * the user won't be told *what* is a directory, so
> +			 * let's not use strerror() below.
> +			 */
> +			int ignore_errno;
> +
> +			/* Expand dirname to the new prefix, not including the trailing slash: */
> +			strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
> +
> +			/*
> +			 * We are still at a leading dir of the refname (e.g.,
> +			 * "refs/foo"; if there is a reference with that name,
> +			 * it is a conflict, *unless* it is in skip.
> +			 */
> +			if (skip && string_list_has_string(skip, dirname.buf))
> +				continue;
> +
> +			if (!initial_transaction &&
> +			    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
> +					       &type, &ignore_errno)) {
> +				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
> +					    dirname.buf, refname);
> +				goto cleanup;
> +			}
> +
> +			if (extras && string_list_has_string(extras, dirname.buf)) {
> +				strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
> +					    refname, dirname.buf);
> +				goto cleanup;
> +			}
> +		}
>  
>  		/*
> -		 * We are still at a leading dir of the refname (e.g.,
> -		 * "refs/foo"; if there is a reference with that name,
> -		 * it is a conflict, *unless* it is in skip.
> +		 * We are at the leaf of our refname (e.g., "refs/foo/bar").
> +		 * There is no point in searching for a reference with that
> +		 * name, because a refname isn't considered to conflict with
> +		 * itself. But we still need to check for references whose
> +		 * names are in the "refs/foo/bar/" namespace, because they
> +		 * *do* conflict.
>  		 */
> -		if (skip && string_list_has_string(skip, dirname.buf))
> -			continue;
> +		strbuf_addstr(&dirname, refname + dirname.len);
> +		strbuf_addch(&dirname, '/');
> +
> +		if (!initial_transaction) {
> +			struct ref_iterator *iter;
> +			int ok;
> +
> +			iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
> +						       DO_FOR_EACH_INCLUDE_BROKEN);
> +			while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
> +				if (skip &&
> +				    string_list_has_string(skip, iter->refname))
> +					continue;
> +
> +				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
> +					    iter->refname, refname);
> +				ref_iterator_abort(iter);
> +				goto cleanup;
> +			}
>  
> -		if (!initial_transaction &&
> -		    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
> -				       &type, &ignore_errno)) {
> -			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
> -				    dirname.buf, refname);
> -			goto cleanup;
> +			if (ok != ITER_DONE)
> +				BUG("error while iterating over references");
>  		}
>  
> -		if (extras && string_list_has_string(extras, dirname.buf)) {
> +		extra_refname = find_descendant_ref(dirname.buf, extras, skip);
> +		if (extra_refname) {
>  			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
> -				    refname, dirname.buf);
> +				    refname, extra_refname);
>  			goto cleanup;
>  		}
>  	}
>  
> -	/*
> -	 * We are at the leaf of our refname (e.g., "refs/foo/bar").
> -	 * There is no point in searching for a reference with that
> -	 * name, because a refname isn't considered to conflict with
> -	 * itself. But we still need to check for references whose
> -	 * names are in the "refs/foo/bar/" namespace, because they
> -	 * *do* conflict.
> -	 */
> -	strbuf_addstr(&dirname, refname + dirname.len);
> -	strbuf_addch(&dirname, '/');
> -
> -	if (!initial_transaction) {
> -		struct ref_iterator *iter;
> -		int ok;
> -
> -		iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
> -					       DO_FOR_EACH_INCLUDE_BROKEN);
> -		while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
> -			if (skip &&
> -			    string_list_has_string(skip, iter->refname))
> -				continue;
> -
> -			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
> -				    iter->refname, refname);
> -			ref_iterator_abort(iter);
> -			goto cleanup;
> -		}
> -
> -		if (ok != ITER_DONE)
> -			BUG("error while iterating over references");
> -	}
> -
> -	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
> -	if (extra_refname)
> -		strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
> -			    refname, extra_refname);
> -	else
> -		ret = 0;
> +	ret = 0;
>  
>  cleanup:
>  	strbuf_release(&referent);
> @@ -2569,6 +2577,23 @@ int refs_verify_refname_available(struct ref_store *refs,
>  	return ret;
>  }
>  
> +int refs_verify_refname_available(struct ref_store *refs,
> +				  const char *refname,
> +				  const struct string_list *extras,
> +				  const struct string_list *skip,
> +				  unsigned int initial_transaction,
> +				  struct strbuf *err)
> +{
> +	struct string_list_item item = { .string = (char *) refname };
> +	struct string_list refnames = {
> +		.items = &item,
> +		.nr = 1,
> +	};
> +
> +	return refs_verify_refnames_available(refs, &refnames, extras, skip,
> +					      initial_transaction, err);
> +}
> +
>  struct do_for_each_reflog_help {
>  	each_reflog_fn *fn;
>  	void *cb_data;
> diff --git a/refs.h b/refs.h
> index a0cdd99250e..185aed5a461 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -124,6 +124,18 @@ int refs_verify_refname_available(struct ref_store *refs,
>  				  unsigned int initial_transaction,
>  				  struct strbuf *err);
>  
> +/*
> + * Same as `refs_verify_refname_available()`, but checking for a list of
> + * refnames instead of only a single item. This is more efficient in the case
> + * where one needs to check multiple refnames.
> + */

Should we talk about more about why this is more efficient?

> +int refs_verify_refnames_available(struct ref_store *refs,
> +				   const struct string_list *refnames,
> +				   const struct string_list *extras,
> +				   const struct string_list *skip,
> +				   unsigned int initial_transaction,
> +				   struct strbuf *err);
> +
>  int refs_ref_exists(struct ref_store *refs, const char *refname);
>  
>  int should_autocreate_reflog(enum log_refs_config log_all_ref_updates,
> 
> -- 
> 2.49.0.rc0.416.g627208d89d.dirty
