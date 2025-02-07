Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06904197556
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738944771; cv=none; b=s5IAeKgX5h77iJIS/NYevNR21x0W1ECgSh56TpnigZqAVNXwDyyoHn8ybIOY1C721w1pCRMksX1U3n0LdId/wkb7/4mDqsjhB2lK9/a8GLp7cygcXIuXTP60qcvhXAz9EiMKRPMDQyyhG1OYSnaPvpde2pOp9n+JhD6PkS2dyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738944771; c=relaxed/simple;
	bh=z7RdHsuemJKTLcgA1Vz3+o3f3CzPYl5+zVQeYHgpRiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJX5hSJVq5WE9vxwNjWb6dbMh7UpE8atmB8h2NVLiHcg+Vjok7nJdtWv1+DWq97gOXTkpwgQ4m/E/GwIH4M1q5/Qsz4Jmceu//UkVQBYOUYGI7Oi64S3pXO4WgRON9wq3LWdLXEqxMvD1CgYlxvKVDs/w+BOI23zluKVwuCRHqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r9JhSKjk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KJ5GRfGz; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r9JhSKjk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KJ5GRfGz"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E6CBF1140158;
	Fri,  7 Feb 2025 11:12:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 07 Feb 2025 11:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738944767; x=1739031167; bh=S/MVJ5rdWi
	qIEmeTEhTDrxT/6E86H/JtdWM5IRdBRjs=; b=r9JhSKjkkW5opZVCIDrDk77XPG
	NnrpbgjdsJiHoGV8K1fmtgoCWQ5+H8gewJ3nqNyNrFzCHQjq8AMuKH4qc+FvZOe0
	9h7RPrIV2ZojBmzzHGqgKMtSFTNdrVuH7WxbhxJMDz66hMEUO2i6lHk0OCBMN0cj
	EKO/mFUT8uOzjn5u/oAFmPji0XrtjJoztDTWOG7E5y1EbuTbDxFQVo2r0yzXHIte
	VI4vMNISD+sPHgzigEhKK7V0J0QusFeJNpu3RV492uL6cIZtzNa9TvkeL/+EzPte
	xZyBiAHbrXRc1GF7XM1jePRNl0mzg9QHQcK+bhtC4CCXtDxOmzSTfqbwOrjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738944767; x=1739031167; bh=S/MVJ5rdWiqIEmeTEhTDrxT/6E86H/JtdWM
	5IRdBRjs=; b=KJ5GRfGzL2irpos+CBtot1a6JPsPiWH0jfLbxjsgS2EtJCcBLyo
	VMMDTVk9uxHgtOpFhxwnyeSMTRs9QdtgqUlP/byknFB8KM6r92qSGorue/pB+nLz
	Q/rZ0Y3Q3UBzc6Z5R/Ax3OhknmuXopUbaTeuaEuExRi0f8PwYNAYpx1dNfCoiCac
	uQdgcKsZzqhW5b8dVDug4cV8Wy1oAc/hC6YFHcGoOLoSImNS3qqR0cXarFBohpxq
	FvA4cEa94G8Dhp3bf8+FUovbii2E9/WcA6PEIqQIrJLFxV39ArLAW7Q+8J61sIVR
	VsIFauFLNPD2GuywD9J6Mm1uv6nj/0kh/Rw==
X-ME-Sender: <xms:_zCmZ_4nf8TBqLd-iAWrZBALt0jNTVwb2kC0elRJTIHkS612t4zrkg>
    <xme:_zCmZ05XMFL16E3iHE9FHGD9H9INrY079kQgEc-_ghS0mD3MRZ16-DMUHoOx4w_TR
    XZijoIcHF61VyhvpA>
X-ME-Received: <xmr:_zCmZ2eYTYSuIqxQbwiow4z5YKJrMnjclWcrkdshJsiaPQiLiE3pgf4_FSEO8h3JLCxvJCI0VjYXSJSPAdR2m72EUxAEKQlEvS30k17PMYrU9kWr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:_zCmZwLazSEb8M945afSw9gZ0sS_EX2XP1fYsYghLWkgouhcpkKTNA>
    <xmx:_zCmZzJjn0jeVBJKsSupqp3pv5pQvjLXAMpICm_GIOljCs9fSPXJxA>
    <xmx:_zCmZ5zE-m3ayOD7_fadciBNp_hWJEJcBtuPTVLS5RgcnkhlONVyhw>
    <xmx:_zCmZ_Jv1xrHZGEEW-uP4TI0SDZrvdTh5v3iJZ6QSGt4GpX4pvUh9Q>
    <xmx:_zCmZ72hpCHNwxLYk5w9Qr6uXcvsLS1h2NK-B5PupDmbmrFIGjOz2hi5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 11:12:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 424e7a5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 16:12:46 +0000 (UTC)
Date: Fri, 7 Feb 2025 17:12:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH 2/6] refs: move duplicate refname update check to generic
 layer
Message-ID: <Z6Yw_f6PGJ2X_Iue@pks.im>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250207-245-partially-atomic-ref-updates-v1-2-e6a3690ff23a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-2-e6a3690ff23a@gmail.com>

On Fri, Feb 07, 2025 at 08:34:37AM +0100, Karthik Nayak wrote:
> Move the tracking of refnames in `affected_refnames` from individual
> backends into the generic layer in 'refs.c'. This centralizes the
> duplicate refname detection that was previously handled separately by
> each backend.

Exciting, this has been on my TODO list for quite a while already.

> Make some changes to accommodate this move:
> 
>   - Add a `string_list` field `refnames` to `ref_transaction` to contain
>     all the references in a transaction. This field is updated whenever
>     a new update is added.
> 
>   - Modify the backends to use this field internally as needed. The
>     backends need to check if an update for refname already exists when
>     splitting symrefs or adding an update for 'HEAD'.

Okay. Is this actually necessary to be handled by the backends? I
would've expected that it is possible to split up symref updates so that
we insert both symref and target into the list. I wouldn't be surprised
if this wasn't easily possible though -- the logic here is surprisingly
intricate.

>   - In the reftable backend, in `reftable_be_transaction_prepare()`,
>     move the instance of `string_list_has_string()` above
>     `ref_transaction_add_update()` to check before the reference is
>     added.
> 
> This helps reduce duplication of functionality between the backends and
> makes it easier to make changes in a more centralized manner.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c                  | 17 ++++++++++++
>  refs/files-backend.c    | 69 ++++++++++---------------------------------------
>  refs/packed-backend.c   | 25 +-----------------
>  refs/refs-internal.h    |  2 ++
>  refs/reftable-backend.c | 53 ++++++++++++-------------------------
>  5 files changed, 50 insertions(+), 116 deletions(-)

Nice.

> diff --git a/refs.c b/refs.c
> index f4094a326a9f88f979654b668cc9c3d27d83cb5d..4c9b706461977995be1d55e7667f7fb708fbbb76 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1175,6 +1175,7 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
>  	CALLOC_ARRAY(tr, 1);
>  	tr->ref_store = refs;
>  	tr->flags = flags;
> +	string_list_init_dup(&tr->refnames);

Do we actually have to duplicate strings? I would've expected that we
keep strings alive via the `ref_update`s anyway during the transaction's
lifetime.

It might also be interesting to check whether using a strset for this
is more efficient. But that is certainly outside the scope of your patch
series and can be done at a later point. #leftoverbit

> @@ -1245,6 +1248,16 @@ struct ref_update *ref_transaction_add_update(
>  		update->msg = normalize_reflog_message(msg);
>  	}
>  
> +	/*
> +	 * This list is generally used by the backends to avoid duplicates.
> +	 * But we do support multiple log updates for a given refname within
> +	 * a single transaction.
> +	 */
> +	if (!(update->flags & REF_LOG_ONLY)) {
> +		item = string_list_append(&transaction->refnames, refname);
> +		item->util = update;
> +	}
> +
>  	return update;
>  }
> @@ -2397,6 +2410,10 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
>  		return -1;
>  	}
>  
> +	string_list_sort(&transaction->refnames);
> +	if (ref_update_reject_duplicates(&transaction->refnames, err))
> +		return TRANSACTION_GENERIC_ERROR;
> +
>  	ret = refs->be->transaction_prepare(refs, transaction, err);
>  	if (ret)
>  		return ret;

Okay, we keep the list unserted initially, but sort it later before
passing it to the backends so that `string_list_has_string()` works
correctly. Good.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index c6a3f6d6261a894e1c294bb1329fdf8079a39eb4..18da30c3f37dc5c09f7d81a9083d6b41d0463bd5 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2425,7 +2423,6 @@ static int split_head_update(struct ref_update *update,
>  	 */
>  	if (strcmp(new_update->refname, "HEAD"))
>  		BUG("%s unexpectedly not 'HEAD'", new_update->refname);
> -	string_list_insert(affected_refnames, new_update->refname);
>  
>  	return 0;
>  }

Previously we would've inserted "HEAD" into the list of affected
refnames even if it wasn't directly updated. Why don't we have to do
that now anymore?

> @@ -2441,7 +2438,6 @@ static int split_head_update(struct ref_update *update,
> @@ -2491,15 +2487,6 @@ static int split_symref_update(struct ref_update *update,
>  	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
>  	update->flags &= ~REF_HAVE_OLD;
>  
> -	/*
> -	 * Add the referent. This insertion is O(N) in the transaction
> -	 * size, but it happens at most once per symref in a
> -	 * transaction. Make sure to add new_update->refname, which will
> -	 * be valid as long as affected_refnames is in use, and NOT
> -	 * referent, which might soon be freed by our caller.
> -	 */
> -	string_list_insert(affected_refnames, new_update->refname);
> -
>  	return 0;
>  }

Same question here, but for symref updates.

> @@ -3030,13 +2995,8 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  	if (transaction->state != REF_TRANSACTION_PREPARED)
>  		BUG("commit called for transaction that is not prepared");
>  
> -	/* Fail if a refname appears more than once in the transaction: */
> -	for (i = 0; i < transaction->nr; i++)
> -		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
> -			string_list_append(&affected_refnames,
> -					   transaction->updates[i]->refname);
> -	string_list_sort(&affected_refnames);
> -	if (ref_update_reject_duplicates(&affected_refnames, err)) {
> +	string_list_sort(&transaction->refnames);
> +	if (ref_update_reject_duplicates(&transaction->refnames, err)) {
>  		ret = TRANSACTION_GENERIC_ERROR;
>  		goto cleanup;
>  	}

Can't we also make this check generic for initial transactions?

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index a7b6f74b6e35f897f619c540cbc600bbd888bc67..6e7acb077e81435715a1ca3cc928550147c8c56a 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1653,34 +1648,16 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
>  	 */
>  
>  	CALLOC_ARRAY(data, 1);
> -	string_list_init_nodup(&data->updates);
>  
>  	transaction->backend_data = data;
>  
> -	/*
> -	 * Stick the updates in a string list by refname so that we
> -	 * can sort them:
> -	 */
> -	for (i = 0; i < transaction->nr; i++) {
> -		struct ref_update *update = transaction->updates[i];
> -		struct string_list_item *item =
> -			string_list_append(&data->updates, update->refname);
> -
> -		/* Store a pointer to update in item->util: */
> -		item->util = update;
> -	}
> -	string_list_sort(&data->updates);
> -
> -	if (ref_update_reject_duplicates(&data->updates, err))
> -		goto failure;
> -
>  	if (!is_lock_file_locked(&refs->lock)) {
>  		if (packed_refs_lock(ref_store, 0, err))
>  			goto failure;
>  		data->own_lock = 1;
>  	}
>  
> -	if (write_with_updates(refs, &data->updates, err))
> +	if (write_with_updates(refs, &transaction->refnames, err))
>  		goto failure;
>  
>  	transaction->state = REF_TRANSACTION_PREPARED;

This change is a lot more straight-forward because the packed backend
does not support symrefs at all. Nice.

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index d39a14c5a469d7d219362e9eae4f578784d65a5b..dd2099d94948a4f23fd9f7ddc06bf3d741229eba 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1202,12 +1184,11 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  				goto done;
>  			}
>  
> -			new_update = ref_transaction_add_update(
> -					transaction, "HEAD",
> -					u->flags | REF_LOG_ONLY | REF_NO_DEREF,
> -					&u->new_oid, &u->old_oid, NULL, NULL, NULL,
> -					u->msg);
> -			string_list_insert(&affected_refnames, new_update->refname);
> +			ref_transaction_add_update(
> +				transaction, "HEAD",
> +				u->flags | REF_LOG_ONLY | REF_NO_DEREF,
> +				&u->new_oid, &u->old_oid, NULL, NULL, NULL,
> +				u->msg);
>  		}
>  
>  		ret = reftable_backend_read_ref(be, rewritten_ref,

Equivalent question as for the files backend.

> @@ -1277,6 +1258,15 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  				if (!strcmp(rewritten_ref, "HEAD"))
>  					new_flags |= REF_UPDATE_VIA_HEAD;
>  
> +				if (string_list_has_string(&transaction->refnames, referent.buf)) {
> +					strbuf_addf(err,
> +						    _("multiple updates for '%s' (including one "
> +						    "via symref '%s') are not allowed"),
> +						    referent.buf, u->refname);
> +					ret = TRANSACTION_NAME_CONFLICT;
> +					goto done;
> +				}
> +
>  				/*
>  				 * If we are updating a symref (eg. HEAD), we should also
>  				 * update the branch that the symref points to.

This change surprised me a bit. You mention it in the commit message,
but don't state a reason why you do it.

Patrick
