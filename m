Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30C1EB9E1
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766767704; cv=none; b=JA5D1oj6tB/rrf0cJM9+TTrVOtzrIYWCDo6ZRSPZnXKlV+0AppfDCkMCLEAqAS/Pd1qjKkLioLSDSvAht674xRSZuGjcQqyJMvZYPxiRIrr9KoUXs67Jy3W46omuWgrvMV1v9tbNYF9RfMEwNufJTl4I2EXMYtpum24ySD0/3m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766767704; c=relaxed/simple;
	bh=IdtIxeym7kcVW18sPL3lCHSx7wMOGtus0EQ1//M5wDU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAmiCTAoONWzBzoDIq65/kX2NJwNp6T+6dihlZzc2MS7X73PSsJpSmwgKKE3sA7b4LxzBnNANaXMBiP5fg3EzgD4WK/pUfu5RWd8wfmSsfrLmvL6n7maJcf0ujW0oCmo4sURQDmi7T6CVHwfsAKY6C2MjlalSwcMUE865o7SCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8GeerCD; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8GeerCD"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dbd150efe8so2738564137.0
        for <git@vger.kernel.org>; Fri, 26 Dec 2025 08:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766767701; x=1767372501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mo6Mozfk2nj5jvhSGzr2w2AMxO7UAEXT2p6piXck5J4=;
        b=h8GeerCDF1GuLa/HCdsCnZD6qr2TxV25usHT8fiYTp5P9mA9/qPBIs6MHS8akHDglo
         TwjtXCPEd76TmiGAEp3SqR9i7yWfdO+gy9Y0NckSzYRSFyO47ezNFjpv1iTxS7qYlWpl
         kIzoAbdmvvaAAiYngrDYuiz4kGmDMraYkNzmbFeRqRJ7ImVUZZJWLx4iSe7htieCMqoG
         beG0cLuANHjxJtqXgLQAyGWAC/vQVIGR2JCHZKgf9cgLm+UVkePDs3XwAS7IACjdgyes
         k3XCtmidkYejq7tkss+wNL3U0F1hye0HFkiHDZDOsubresMriblWwuHrkuwWHM1U8k0X
         p9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766767701; x=1767372501;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mo6Mozfk2nj5jvhSGzr2w2AMxO7UAEXT2p6piXck5J4=;
        b=aHI324x0/tCOb26aY84nNuQ2UcIFm76Isb206Ui9f+LENGjvkgsU/EsQbPKvrbihMV
         B2dqMGrdfMWip4crgWhmFbZTDw8hRXYnxKm847WkjHmaLca0WRthEhfgv/lFDk3+kEtd
         fteufbsxMXJEeXqPqRWp75m+Ynp4IxXdHAfGn8oLvpqDjx5bxkPnCao3jue++9D6RNM/
         paBwwu7ie8bjEPJYg4BdVDjsAztUF16qcGahqXCO68U7KwKSiZclNdWElK05zrMmLxpo
         i8XYfdMr6C5Gkl2f0ujQUtfXq9lGDcX4aPjMbBzcaPHkKuAdUgH3Q3GX+s5BceprghRq
         1X0A==
X-Gm-Message-State: AOJu0Yy4hVhCMmxDotoVNzNnrH+HKH8QU8zKAJxB+6/8FaLAWy+ImNPD
	mAkZmOoNWf2p2zQEEf9VEjKB2fu/uYDRkknorp9SMDYiW52HtbtaSz3vnsU8M5RB05VD4t0uEpi
	TMLTDqrZhzQJXaOWDr+SqUjEYV1BoJR2KQK+HdFc=
X-Gm-Gg: AY/fxX5nInL7gYybYYkH92JY8lTlDJ5iZPYzl16siUDTsQXgve3P3/BsOcSwqybwqDa
	3R5BnLsqx/v87e/Mk55OO+CmkwY+rQT42dmqVnLvhUrCM0GTUsjXn55so0jDLTEfoEAV13jm1sE
	220XlZSm87wDTBsPKB7PL5nRYVKZ/JWsIK/acrDg51P0mhfipnyT0mdlHgUSQWL9bt1yZthnbKE
	LhJoiyODhsnpp/juLMZ4l1W8RIeqT+qFPBbGm9ebEjueR6GFFj0gNhiD2iHIom9leIOTPfk4bQE
	e0LcvVzN15Wb8L5sl7bgVYeqr96JqA==
X-Google-Smtp-Source: AGHT+IH74dOD+lxTyhc7nRPAiuKT/Vqe5Dr4mi9o30B1RiK7tOVNr6AzayQGxvZxGXQ4jWk/RTPE7ku3NtLMw+NiwKc=
X-Received: by 2002:a05:6102:3f12:b0:5db:ecdd:1826 with SMTP id
 ada2fe7eead31-5eb1a7d9f5emr6758149137.22.1766767700818; Fri, 26 Dec 2025
 08:48:20 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Dec 2025 11:48:19 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Dec 2025 11:48:19 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251224081214.GA1879908@coredump.intra.peff.net>
References: <CABPp-BGL2tJR4dPidQuFcp-X0_VkVTknCY-0Zgo=jHVGv_P=wA@mail.gmail.com>
 <20251224081214.GA1879908@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Dec 2025 11:48:19 -0500
X-Gm-Features: AQt7F2pUfdjMKI6S2t9vv3HXSbAcxbVnX-Hq_ZjvN-ee4Vuct_tJXOtivHmSH-o
Message-ID: <CAOLa=ZSOZz9aGFFeD7tiQ+PRwkMosjcoxfTSk52fQeQq0ghgaw@mail.gmail.com>
Subject: Re: Possible regression: lost diagnostic message when pushing
 non-commit objects to refs/heads/*
To: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000003556940646dda9c8"

--0000000000003556940646dda9c8
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Tue, Dec 23, 2025 at 07:32:28PM -0800, Elijah Newren wrote:
>
>> The relevant error message is still part of the code:
>> $ git grep "write non-commit object" -- '*.c'
>> refs/files-backend.c:                           "trying to write
>> non-commit object %s to branch '%s'",
>> refs/reftable-backend.c:                        strbuf_addf(err,
>> _("trying to write non-commit object %s to branch '%s'"),
>>
>> but the error message isn't displayed.  Bisecting shows that this
>> started with commit 9d2962a7c44 ("receive-pack: use batched reference
>> updates", 2025-05-19).  That commit message to me suggests that while
>> error handling was necessarily changed, that dropping the errors was
>> not intentional:
>>
>> ```
>> As using batched updates requires the error handling to be moved to the
>> end of the flow, create and use a 'struct strset' to track the failed
>> refs and attribute the correct errors to them.
>> ```
>>
>> But it's possible I'm reading it wrong.  Was it intentional, or is
>> this a regression?
>
> I didn't participate in this topic beyond a few memory-management
> nitpicks, but my gut feeling is that yes, this is a regression.
>

Definitely a regression. We did find a few regressions with this topic,
the only  bright side being fixing those also added missing tests which
would catch further breakages.

> We still format that specific error into an "err" strbuf inside the refs
> code. In the older version, we returned up the stack and eventually
> printed the error from the failed transaction to stderr (or in the case
> of receive-pack, the sideband).
>
> But in the new batched world that allows partial-batch failures, we
> throw it away. The problem (at least for the files backend) is this code
> in files_transaction_prepare():
>
>           ret = lock_ref_for_update(refs, update, i, transaction,
>                                     head_ref, &refnames_to_check,
>                                     err);
>           if (ret) {
>                   if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
>                           strbuf_reset(err);
>                           ret = 0;
>
>                           continue;
>                   }
>                   goto cleanup;
>           }
>
> We see the error from lock_ref_for_update() as before, and the useful
> message is in "err" here. But ref_transaction_maybe_set_rejected() only
> looks at "ret", the numeric error code, and decides that it is enough to
> record that.
>
> We should do something useful with the "err" string that was collected,
> rather than immediately calling strbuf_reset() to throw it away.
>
> Unfortunately we can't just dump it to stderr here, since we don't know
> what our caller would want to do with the error (and in fact for
> receive-pack we eventually want to call rp_error() which dumps it over
> the sideband). So we have to return it back to the caller somehow.
>
> We only get one "err" string to return for the whole transaction. We can
> play some games to make it multi-line, like this:
>
>   diff --git a/refs/files-backend.c b/refs/files-backend.c
>   index 6f6f76a8d8..6ad57e53c0 100644
>   --- a/refs/files-backend.c
>   +++ b/refs/files-backend.c
>   @@ -2978,13 +2978,17 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>    	 */
>    	for (i = 0; i < transaction->nr; i++) {
>    		struct ref_update *update = transaction->updates[i];
>   +		struct strbuf this_err = STRBUF_INIT;
>
>    		ret = lock_ref_for_update(refs, update, i, transaction,
>    					  head_ref, &refnames_to_check,
>   -					  err);
>   +					  &this_err);
>    		if (ret) {
>    			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
>   -				strbuf_reset(err);
>   +				if (err->len)
>   +					strbuf_addch(err, '\n');
>   +				strbuf_addbuf(err, &this_err);
>   +				strbuf_release(&this_err);
>    				ret = 0;
>
>    				continue;
>
> but even that is not quite enough. We still return success from the
> overall transaction, because we allow failures within the batch! So now
> our caller does not even look at "err" at all.
>

Yup, that's my understanding as well, we'd want to pass the error per
update being performed.

> So I guess we need to attach the failure more directly to the failed
> ref. Probably ref_transaction_maybe_set_rejected() should take the error
> string along with the ref_transaction_error enum, and attach it to the
> failed item. We also need to get those details out to the callers, which
> use ref_transaction_for_each_rejected_update(). So that interface needs
> to be expanded to pass out the details string.
>

Yup, this was what I was thinking of too, and your exploration here
seems to be on the same line.

> And then receive-pack can either dump it via rp_error(), giving the same
> behavior as the old version. Or it can stick it into the per-ref status
> field. The latter feels more "right" in the sense that the error
> messages can be reliably attached to specific ref updates in the
> machine-readable output (rather than appearing willy-nilly on stderr or
> sideband 2). But I'd guess it would make the output rather unwieldy.

The second option would be more useful to the user too. Since they can
act upon that specific update.

> The patch below does the sideband dumping, and gets back the message in
> this toy example. But as the inline comments show, it would probably
> need support in a few other spots (both generating the detailed err
> messages, and then showing them at the right spots). Plus it has a big
> memory leak, in that nobody ever frees the detail strings. ;)
>

Thanks for putting up something to show :)

> So consider it just a sketch. I'm hoping Karthik can pick it up from
> here.
>

Yeah, I can polish what you've send. I'll work on it and send something
soon-ish (I'm taking some time off, but its hard to stay away from the
laptop).

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 288d3772ea..315e791193 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1649,6 +1649,7 @@ static void ref_transaction_rejection_handler(const char *refname,
>  					      const char *old_target UNUSED,
>  					      const char *new_target UNUSED,
>  					      enum ref_transaction_error err,
> +					      const char *details,
>  					      void *cb_data)
>  {
>  	struct ref_rejection_data *data = cb_data;
> @@ -1675,6 +1676,8 @@ static void ref_transaction_rejection_handler(const char *refname,
>  	} else {
>  		const char *reason = ref_transaction_error_msg(err);
>
> +		/* probably should show "details" string here? */
> +
>  		error(_("fetching ref %s failed: %s"), refname, reason);
>  	}
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9c49174616..96daf54a09 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1853,10 +1853,12 @@ static void ref_transaction_rejection_handler(const char *refname,
>  					      const char *old_target UNUSED,
>  					      const char *new_target UNUSED,
>  					      enum ref_transaction_error err,
> +					      const char *details,
>  					      void *cb_data)
>  {
>  	struct strmap *failed_refs = cb_data;
>
> +	rp_error("%s", details);
>  	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
>  }
>
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 195437e7c6..6ef53d9886 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -573,11 +573,14 @@ static void print_rejected_refs(const char *refname,
>  				const char *old_target,
>  				const char *new_target,
>  				enum ref_transaction_error err,
> +				const char *details,
>  				void *cb_data UNUSED)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	const char *reason = ref_transaction_error_msg(err);
>
> +	/* do something with "details" string here? */
> +
>  	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
>  		    new_oid ? oid_to_hex(new_oid) : new_target,
>  		    old_oid ? oid_to_hex(old_oid) : old_target,
> diff --git a/refs.c b/refs.c
> index 046b695bb2..adf01c527b 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1238,7 +1238,8 @@ void ref_transaction_free(struct ref_transaction *transaction)
>
>  int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
>  				       size_t update_idx,
> -				       enum ref_transaction_error err)
> +				       enum ref_transaction_error err,
> +				       struct strbuf *details)
>  {
>  	if (update_idx >= transaction->nr)
>  		BUG("trying to set rejection on invalid update index");
> @@ -1264,6 +1265,9 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
>  			   transaction->updates[update_idx]->refname, 0);
>
>  	transaction->updates[update_idx]->rejection_err = err;
> +	if (details)
> +		transaction->updates[update_idx]->rejection_details =
> +			strbuf_detach(details, NULL);
>  	ALLOC_GROW(transaction->rejections->update_indices,
>  		   transaction->rejections->nr + 1,
>  		   transaction->rejections->alloc);
> @@ -2658,7 +2662,8 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>  						       &type, &ignore_errno))) {
>  				if (transaction && ref_transaction_maybe_set_rejected(
>  					    transaction, *update_idx,
> -					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
> +					    REF_TRANSACTION_ERROR_NAME_CONFLICT,
> +					    NULL)) {
>  					strset_remove(&dirnames, dirname.buf);
>  					strset_add(&conflicting_dirnames, dirname.buf);
>  					continue;
> @@ -2672,7 +2677,8 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>  			if (extras && string_list_has_string(extras, dirname.buf)) {
>  				if (transaction && ref_transaction_maybe_set_rejected(
>  					    transaction, *update_idx,
> -					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
> +					    REF_TRANSACTION_ERROR_NAME_CONFLICT,
> +					    NULL)) {
>  					strset_remove(&dirnames, dirname.buf);
>  					continue;
>  				}
> @@ -2709,9 +2715,12 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>  				    string_list_has_string(skip, iter->ref.name))
>  					continue;
>
> +				/* should we be formatting err first here and
> +				 * passing it in? */
>  				if (transaction && ref_transaction_maybe_set_rejected(
>  					    transaction, *update_idx,
> -					    REF_TRANSACTION_ERROR_NAME_CONFLICT))
> +					    REF_TRANSACTION_ERROR_NAME_CONFLICT,
> +					    NULL))
>  					continue;
>
>  				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
> @@ -2725,9 +2734,10 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>
>  		extra_refname = find_descendant_ref(dirname.buf, extras, skip);
>  		if (extra_refname) {
> +			/* format err first and pass it in? */
>  			if (transaction && ref_transaction_maybe_set_rejected(
>  				    transaction, *update_idx,
> -				    REF_TRANSACTION_ERROR_NAME_CONFLICT))
> +				    REF_TRANSACTION_ERROR_NAME_CONFLICT, NULL))
>  				continue;
>
>  			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
> @@ -2862,7 +2872,8 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
>  		   (update->flags & REF_HAVE_OLD) ? &update->old_oid : NULL,
>  		   (update->flags & REF_HAVE_NEW) ? &update->new_oid : NULL,
>  		   update->old_target, update->new_target,
> -		   update->rejection_err, cb_data);
> +		   update->rejection_err, update->rejection_details,
> +		   cb_data);
>  	}
>  }
>
> diff --git a/refs.h b/refs.h
> index d9051bbb04..4fbe3da924 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -975,6 +975,7 @@ typedef void ref_transaction_for_each_rejected_update_fn(const char *refname,
>  							 const char *old_target,
>  							 const char *new_target,
>  							 enum ref_transaction_error err,
> +							 const char *details,
>  							 void *cb_data);
>  void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
>  					      ref_transaction_for_each_rejected_update_fn cb,
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 6f6f76a8d8..b58e3a3664 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2983,8 +2983,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  					  head_ref, &refnames_to_check,
>  					  err);
>  		if (ret) {
> -			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
> -				strbuf_reset(err);
> +			if (ref_transaction_maybe_set_rejected(transaction, i, ret, err)) {
>  				ret = 0;
>
>  				continue;
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 4ea0c12299..b4b124a674 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1437,8 +1437,7 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
>  						    update->refname);
>  					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
>
> -					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
> -						strbuf_reset(err);
> +					if (ref_transaction_maybe_set_rejected(transaction, i, ret, err)) {
>  						ret = 0;
>  						continue;
>  					}
> @@ -1452,8 +1451,7 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
>  						    oid_to_hex(&update->old_oid));
>  					ret = REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
>
> -					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
> -						strbuf_reset(err);
> +					if (ref_transaction_maybe_set_rejected(transaction, i, ret, err)) {
>  						ret = 0;
>  						continue;
>  					}
> @@ -1496,8 +1494,7 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
>  					    oid_to_hex(&update->old_oid));
>  				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
>
> -				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
> -					strbuf_reset(err);
> +				if (ref_transaction_maybe_set_rejected(transaction, i, ret, err)) {
>  					ret = 0;
>  					continue;
>  				}
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index c7d2a6e50b..c5c121cc1c 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -128,6 +128,7 @@ struct ref_update {
>  	 * was rejected.
>  	 */
>  	enum ref_transaction_error rejection_err;
> +	char *rejection_details;
>

So this is where the rejection details are added. Free'ing this can be
part of `ref_transaction_free()` I assume.

>  	/*
>  	 * If this ref_update was split off of a symref update via
> @@ -153,7 +154,8 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
>   */
>  int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
>  				       size_t update_idx,
> -				       enum ref_transaction_error err);
> +				       enum ref_transaction_error err,
> +				       struct strbuf *details);
>
>  /*
>   * Add a ref_update with the specified properties to transaction, and
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 4319a4eacb..8b04a5e11c 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1401,8 +1401,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  					    &refnames_to_check, head_type,
>  					    &head_referent, &referent, err);
>  		if (ret) {
> -			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
> -				strbuf_reset(err);
> +			if (ref_transaction_maybe_set_rejected(transaction, i, ret, err)) {
>  				ret = 0;
>
>  				continue;

Overall this looks good. I'll build out something and send, but probably
in the 1st-2nd week of January!

Karthik

--0000000000003556940646dda9c8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 35e27698295091be_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sT3ZGRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXVhREFDZjVFVG0rWE1TYkxldXRDU2FvbUtJS1I3WgpxVHNUSHNMUW9n
RlBXc3ZWMittVFVBS3d3WnNseUtoYzdUMTBNTWE3Z0tOQUtZdWdkWndPOG5OeTR6T1YyWDJrCm5w
STlxR2pYU0ptekVUNExXWUphNUVIT2FvRXBBdDZMbzI3UGluS2Z5RjlzdmJJeEcxSU8wSU90bHhu
eVl6bTUKWnhud3RHK3NlS0ZNRkE0VU9YLzk0MXRzZWpYSzVvSUQ3cVpEay8wT2RGWnJ3RGh0Tnh0
Tm9GcDVENVhKalIyNQpaNzhZZHByYkgwdzkyY3MvSXAyL3JIaUNVdHJrOXlsUUJBdi9iRTFKNHlj
ZnNxb29jR3ZMbXJ5dUhEbStYMkt5ClA3RHk5TC9VZ29sRCtlenFWMHhLamhoUkNCdlorQXhRNVNP
bjBBREJKclNrNmJCWXF3TUdJWUd1RFdUQkIwdXUKc2N5WnEyL2Nkb0c2SThkZnpiM21LMGQ4WlFy
OW93OVFWWWx0SlEyeHBkand6c09qRk1uT0dnVWh5UHRLV0RCWApCS1E1SWh1b0UrZ2tmNFJmeEc4
VEJEYUQxV3p1cjFqOVpJUlRTRFdFV1lCQzJNTU9ReWgwT3FUSWg5SFZHcmFtCldVbU5sUUdkc2NT
a3dzNTVjNVB0YWRQOEZYTjlDT0w1dUwvbWhLST0KPW00UWMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003556940646dda9c8--
