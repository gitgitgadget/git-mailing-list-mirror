Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01F4DDB5D
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013290; cv=none; b=mEaTkwioqGCdh6sHSFePLGkju/o7iCheJlJP+lVOiOs4ctjYNCWAbmTagHLd3FdeWx3PEzNHumDYRL/eVdXCBhz/tKMsh8fUQ4QHcGipvZMCFtEi5mtQ2T7I2kHPfO8fYdf3k4qz8q7oA/a1mMdIxST1rUcgGWaTBasaAsJ+8/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013290; c=relaxed/simple;
	bh=Inwywfbs6anb8k872H/atWvZCW2cUIKdalU044+uNSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FZ9VRBRKLe8KMcLBC4KFs7U29tJXhOKHZCZCzJNGfl4zSPMmSU9Tj8RmZVi2hZJppKfPCI1kAlNFaSeePrmEpw8BO0OxtFe4Nx46XMnEaU9NENG1DA6vnTdIWIYXI4wdJBVG3+NEGoAsEaFa7mHjKJE4jqpYwXWYtEC27YTCDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rxtuj99U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E7iYh4JP; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rxtuj99U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E7iYh4JP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 413191400172;
	Mon, 21 Sep 2026 13:54:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 21 Sep 2026 13:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790013287; x=1790099687; bh=zJ6U5RjATK
	xTGx7EP90DXKV1anb3H51RY+vMsTI4LkQ=; b=rxtuj99UphmbseR76nFr+QKeOg
	UnE6Ft0rZiv2+k7ceJ/SJlvuskTwKFg/9EEh62B5T8pk+0RNp6KC0me04KTi/bzB
	NfhO9ETNFAtza3Iv6LkgyPEiGelYcCdab5Qi5RjicbcMP146yJk5w532aqDqQVH9
	6fIAxLYwO+x4Gv9//sLWBKBn8wkJbQ0H4aSq5LdQ4ScO4FslA+3QwqOpFM6q2obu
	sDdov10tuqhLusQFETdmqqsocUTGemLBx7RHKev/hduwNAtMLEyuf52UwGpe30Ce
	yGTKfeQ619EvBrNXLJPwtGyYRMChv+ElM9VneQgr/g27OvJJbStq5LU7/80A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790013287; x=1790099687; bh=zJ6U5RjATKxTGx7EP90DXKV1anb3H51RY+v
	MsTI4LkQ=; b=E7iYh4JPFr3wL/K6ktpRML1ZjBYIx6vPNv6ilBcjg5en7RrLLcI
	jbq6Dti71CNN+dJ+iuNcH7YZa8hwxVdwVm7XVv0QydR4+2G4bfxe40w8kGR6byW+
	4n1xaou0VFkYCtxiPP/2XDqYyXJuAkLschVorA9R1pte7KXYQ5nKmy/oZC2NDBjz
	ttNhVRZcLKaG+LAhnLjwPX0/zC7zK73WG6GA44GmJIilhsf4SnuIyP8Xi89LLOZi
	cf8se+eql9vh/EEY25sUqv/sXbSpheoSwjffZ24grCvFYW+MksUqrtGOqHYKVBz8
	97x1X5AheAr6YcDkHNIDexXypsNLQZ+x7qA==
X-ME-Sender: <xms:Z2-xagSK-izth_3dR1O455I-oKcu-ghLv7h06QZv_x0cpVfNLK8GoA>
    <xme:Z2-xakwci1Vu0l_wcz1p-WGqou1fJYn6f08stDv6BIvHJSP1tImIF4RNt6KWV3f6W
    7ut82lgID2oMOptXhUQwtYZW7e864uAP63wsLQnYmeUIPDqle7s5ddR>
X-ME-Received: <xmr:Z2-xai1iodOinJLhqUkY5-f3GBUreAnFQfl54NxEkujypGMiG9SXwJq7M0NlEzttymOXORyxqaHmq-wl06hJ63ywaeDA_3LoSRKB>
X-ME-Proxy-Cause: dmFkZTGvPIgu0ZBIeYRrOpMsWDuR3MDpEO5iwkkux7B/uOjjyxkX+RYIWb6r/sCD6CVTBF
    zsSqBQp1RG4P3DpnOSToHUbW5xZfvxCmQiKnJ4e/SI/q+VLZUH+tdzW2Zl8rDtDxrZsfv5
    Sq8wJ9gCLg/Ovt40yfeDlAd1KIZyRiSrfTEZfbwEwel0k/7oDBZnWFJ/J464DAPk/oqGpp
    2ptnVxxMVkMsGaSF20VZtSOlU1daeeHrsDg3+2x4+4Rl/f+MyFNmdEU8O7D61WDbtxH2d0
    9O1JQNPafPl1dkGRFDH8xNCF1u9X0bqVFZr3IZqjEdD/9yfMT2+kvDg6Pq1dV3UZHPLEQi
    WgrK5XycFCkdViLAF2BBy9oPEO30T5WddNsS/4eFnbm0x6PGE8uktMkMgVHaB98T369fOJ
    oxTF7O6gZsCZPuX1AXidtsv4m4mt88bb0lDpKh0TErwCjtnyh+0ugAXVtLwWgwSBm7cC5m
    LvJVCddcDIVU8CVdASS6zCzmRazK0KqEY7Hgwlnk+Mu3ew3W9jGFHf+SmKF4LIeK6InK1e
    7DBrhbq/cagNpd7ZVGj5q51ogmnHiHX9GRB/F2/xPMt6OBnHS0DIxfjzoFA9udxcFKLWwu
    HdZw07fLQCYT9jkSEiuEn4evwd2ZQMnhx82keOTEmUPRYaMC6iYbMpuOWaAw
X-ME-Proxy: <xmx:Z2-xai5Jh3qSQR3JJA6snT4ea-x1dnviNKGDkt28K0E4-ryzY4417g>
    <xmx:Z2-xalWyAr8f2rZVFRaV4ehQtu2bJPp1SkzkZTUzbCbDz8ZzPzxUDw>
    <xmx:Z2-xahCaUCszj07FEA8wI6V40sxNmcQyWEkIg9NcUauX7n7dinNpoA>
    <xmx:Z2-xak4MZ0rTJ2MT1r-d6pEpo7xGPSlQdZAFG-AlaKNDkSWWSOGYyA>
    <xmx:Z2-xaqUit4ifrJwtLYiiWmtBXGrtIrqRshmVMTUM4TN0Gwb6UR9ngEuk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:54:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] refs: run copy and rename through transactions
In-Reply-To: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com> (Maciej
	Ciemborowicz's message of "Sun, 20 Sep 2026 18:50:37 +0200")
References: <CAOLa=ZTN1TU2A1sgEhiw=ymMYr6Ge11cMEubSaeKqr4WNU=2EQ@mail.gmail.com>
	<20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
Date: Mon, 21 Sep 2026 10:54:45 -0700
Message-ID: <xmqqjyoemqvu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> Reference copy and rename operations currently bypass the transaction API.
> Consequently, the reference-transaction hook sees only the source deletion
> with the files backend and no useful update with the reftable backend.
>
> Represent both operations as reference transactions containing their
> logical updates. A rename is a deletion of the old reference and creation
> of the new reference in the same transaction. Retain backend-specific
> reflog handling: the files backend stages its existing rename procedure
> across prepare, finish and abort, while reftable stages an addition while
> holding the stack lock. Suppress hooks for the files backend's nested
> deletion transactions so that callers observe one logical transaction.
>
> Record and verify the source and destination values after taking backend
> locks. This rejects concurrent changes instead of applying a rename or copy
> that differs from the payload shown to the preparing hook. Preserve D/F
> renames and restore overwritten references and reflogs when a prepared hook
> rejects the operation.
>
> Add coverage for rename, copy, forced updates, both directions of D/F
> conflicts, concurrent updates and prepared-hook rollback.
>
> Helped-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
> ---

Drop unnecessary "currently" to the first sentence, and add "test"
to the laste sentence somewhere, and this would be perfect.

Very pleasing to see an exceptionally well-written proposed commit
log message by a new contributor.

>  refs.c                           | 137 ++++++++++++---
>  refs.h                           |   3 +
>  refs/debug.c                     |  25 ---
>  refs/files-backend.c             | 276 +++++++++++++++++++++++++++----
>  refs/packed-backend.c            |   2 -
>  refs/refs-internal.h             |  38 +++--
>  refs/reftable-backend.c          | 194 ++++++++++++++++------
>  t/t1416-ref-transaction-hooks.sh | 142 ++++++++++++++++
>  8 files changed, 679 insertions(+), 138 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 92d5df5b7..22c000f7f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1004,15 +1004,17 @@ long get_files_ref_lock_timeout_ms(struct repository *repo)
>  	return timeout_ms;
>  }
>  
> -int refs_delete_ref(struct ref_store *refs, const char *msg,
> -		    const char *refname,
> -		    const struct object_id *old_oid,
> -		    unsigned int flags)
> +int refs_delete_ref_with_transaction_flags(struct ref_store *refs,
> +					   const char *msg,
> +					   const char *refname,
> +					   const struct object_id *old_oid,
> +					   unsigned int flags,
> +					   unsigned int transaction_flags)
>  {
>  	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
>  
> -	transaction = ref_store_transaction_begin(refs, 0, &err);
> +	transaction = ref_store_transaction_begin(refs, transaction_flags, &err);
>  	if (!transaction ||
>  	    ref_transaction_delete(transaction, refname, old_oid,
>  				   NULL, flags, msg, &err) ||
> @@ -1027,6 +1029,15 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
>  	return 0;
>  }
>  
> +int refs_delete_ref(struct ref_store *refs, const char *msg,
> +		    const char *refname,
> +		    const struct object_id *old_oid,
> +		    unsigned int flags)
> +{
> +	return refs_delete_ref_with_transaction_flags(refs, msg, refname,
> +						      old_oid, flags, 0);
> +}
> +
>  static void copy_reflog_msg(struct strbuf *sb, const char *msg)
>  {
>  	char c;
> @@ -1270,6 +1281,10 @@ void ref_transaction_free(struct ref_transaction *transaction)
>  
>  	string_list_clear(&transaction->refnames, 0);
>  	free(transaction->updates);
> +	free(transaction->old_refname);
> +	free(transaction->new_refname);
> +	free(transaction->logmsg);
> +	free(transaction->destination_target);
>  	free(transaction);
>  }
>  
> @@ -2710,7 +2725,8 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
>  		return REF_TRANSACTION_ERROR_GENERIC;
>  
>  	/* Preparing checks before locking references */
> -	ret = run_transaction_hook(transaction, "preparing");
> +	ret = transaction->flags & REF_TRANSACTION_FLAG_SKIP_HOOK ? 0 :
> +		run_transaction_hook(transaction, "preparing");
>  	if (ret) {
>  		ref_transaction_abort(transaction, err);
>  		die(_(abort_by_ref_transaction_hook), "preparing");
> @@ -2720,7 +2736,8 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
>  	if (ret)
>  		return ret;
>  
> -	ret = run_transaction_hook(transaction, "prepared");
> +	ret = transaction->flags & REF_TRANSACTION_FLAG_SKIP_HOOK ? 0 :
> +		run_transaction_hook(transaction, "prepared");
>  	if (ret) {
>  		ref_transaction_abort(transaction, err);
>  		die(_(abort_by_ref_transaction_hook), "prepared");
> @@ -2750,7 +2767,8 @@ int ref_transaction_abort(struct ref_transaction *transaction,
>  		break;
>  	}
>  
> -	run_transaction_hook(transaction, "aborted");
> +	if (!(transaction->flags & REF_TRANSACTION_FLAG_SKIP_HOOK))
> +		run_transaction_hook(transaction, "aborted");
>  
>  	ref_transaction_free(transaction);
>  	return ret;
> @@ -2781,7 +2799,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  	}
>  
>  	ret = refs->be->transaction_finish(refs, transaction, err);
> -	if (!ret && !(transaction->flags & REF_TRANSACTION_FLAG_INITIAL))
> +	if (!ret && !(transaction->flags & (REF_TRANSACTION_FLAG_INITIAL |
> +					 REF_TRANSACTION_FLAG_SKIP_HOOK)))
>  		run_transaction_hook(transaction, "committed");
>  	return ret;
>  }
> @@ -3123,28 +3142,100 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
>  	return ret;
>  }
>  
> -int refs_rename_ref(struct ref_store *refs, const char *oldref,
> -		    const char *newref, const char *logmsg)

It is annoying that we have to give random callers an unrestricted
way to skip calling hooks.  I suspect it may come from "this
function should call hook when invoked as the top-level operation,
but when it is used as a subroutine for a different top-level
operation, we want to skip hooks" kind of reasoning, but is this
something we can avoid by rearranging the call chain?

> +static int refs_copy_or_rename_ref(struct ref_store *refs, const char *oldref,
> +				   const char *newref, const char *logmsg,
> +				   int copy)

Will this function ever gain a third mode of operation other than
copy or rename?  If not, perhaps "bool copy"?

>  {
> -	char *msg;
> -	int retval;
> +	struct ref_transaction *transaction = NULL;
> +	struct object_id old_oid, new_oid;
> +	struct strbuf new_target = STRBUF_INIT;
> +	struct strbuf err = STRBUF_INIT;
> +	char *msg = normalize_reflog_message(logmsg);
> +	int old_flags, new_flags = 0, new_exists = 0, ret = 1;
>  
> -	msg = normalize_reflog_message(logmsg);
> -	retval = refs->be->rename_ref(refs, oldref, newref, msg);
> +	if (!strcmp(oldref, newref)) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	if (!refs_resolve_ref_unsafe(refs, oldref,
> +				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +				     &old_oid, &old_flags)) {
> +		error("refname %s not found", oldref);
> +		goto out;
> +	}
> +	if (old_flags & REF_ISSYMREF) {
> +		error("refname %s is a symbolic ref, %s it is not supported",
> +		      oldref, copy ? "copying" : "renaming");
> +		goto out;
> +	}
> +
> +	transaction = ref_store_transaction_begin(refs, 0, &err);
> +	if (!transaction)
> +		goto error;
> +	transaction->type = copy ? REF_TRANSACTION_TYPE_COPY :
> +		REF_TRANSACTION_TYPE_RENAME;
> +	transaction->old_refname = xstrdup(oldref);
> +	transaction->new_refname = xstrdup(newref);
> +	transaction->logmsg = xstrdup(msg);
> +	oidcpy(&transaction->source_oid, &old_oid);
> +
> +	if (!copy && ref_transaction_delete(transaction, oldref, &old_oid, NULL,
> +					    REF_NO_DEREF, msg, &err))
> +		goto error;
> +
> +	if (refs_resolve_ref_unsafe(refs, newref,
> +				    RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +				    &new_oid, &new_flags)) {
> +		new_exists = 1;
> +		if ((new_flags & REF_ISSYMREF) &&
> +		    refs_read_symbolic_ref(refs, newref, &new_target) < 0) {
> +			strbuf_addf(&err, "unable to read symbolic ref %s", newref);
> +			goto error;
> +		}
> +	} else {
> +		oidclr(&new_oid, refs->repo->hash_algo);
> +	}
> +	transaction->destination_exists = new_exists;
> +	if (new_flags & REF_ISSYMREF)
> +		transaction->destination_target = xstrdup(new_target.buf);
> +	else if (transaction->destination_exists)
> +		oidcpy(&transaction->destination_oid, &new_oid);
> +
> +	if (ref_transaction_update(transaction, newref, &old_oid,
> +				   (new_flags & REF_ISSYMREF) ? NULL : &new_oid,
> +				   NULL,
> +				   (new_flags & REF_ISSYMREF) ? new_target.buf : NULL,
> +				   REF_NO_DEREF | REF_SKIP_CREATE_REFLOG,
> +				   NULL, &err))
> +		goto error;
> +
> +	if (ref_transaction_commit(transaction, &err))
> +		goto error;
> +
> +	ret = 0;
> +	goto out;
> +
> +error:
> +	error("%s", err.buf);
> +out:
> +	ref_transaction_free(transaction);
> +	strbuf_release(&new_target);
> +	strbuf_release(&err);
>  	free(msg);
> -	return retval;
> +	return ret;
>  }

That's quite a lot of new code.  I see ref_transaction_delete(),
ref_transaction_update() and others are already reused from existing
code paths, which is good.

> +struct files_copy_or_rename_transaction_data {
> +	struct ref_lock *lock;
> +	struct object_id orig_oid;
> +	struct object_id destination_oid;
> +	char *destination_target;
> +	int logmoved;
> +	int destination_exists;
> +	int destination_log_backed_up;
> +};

Good to have a type that can be used to hold pieces of information
specific to the operation.  Can't we do without rename/copy specific
addition to the generic ref_transaction struct by following the same
principle?

The comment above the members does make it understandable, but ...

> @@ -240,6 +253,21 @@ struct ref_transaction {
>  	void *backend_data;
>  	unsigned int flags;
>  	uint64_t max_index;
> +
> +	/*
> +	 * Rename and copy operations need backend-specific reflog handling.
> +	 * Their logical updates still live in `updates`, so hooks see the
> +	 * operation like any other reference transaction. The fields below
> +	 * retain the state that backends verify after taking their locks.
> +	 */
> +	enum ref_transaction_type type;
> +	char *old_refname;
> +	char *new_refname;
> +	char *logmsg;
> +	struct object_id source_oid;
> +	struct object_id destination_oid;
> +	char *destination_target;
> +	unsigned int destination_exists:1;
>  };

... is it the best we can do to contaminate a rather generic data
structure for such a details relevant only to one specific
operation?

Thanks.
