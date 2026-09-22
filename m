Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A8047A898
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103351; cv=none; b=jS/pbQBln7DaW1cjLRvehA4HGqDwL7tLMhjVhSvXYzOOmbUGFNrMHrFCGCpkTozoV+pv8jgq9BrAHM6vD4nFsHtbRyFKyCTUSvbPI5fczgxl7ZLnLEi3oi0XEZpnVL7mdOD6u86xIqAwNimQeq5OSjPTJq0BuVvvLhOIVLdBWQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103351; c=relaxed/simple;
	bh=rB9LJ/+r7wRTq9r1ZJC2htvtaW2l94BqkEfzGSCoUyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=noFD2VQcNRbT8y573GLXm0P4/grnS0liTEfxzbmD37TmhKnEjHf29buSucTKqc5pb1+PVHeSooLluWjfU+6uMO4dwdmBcHXzoJ5khKpvNq4c2EeNb/oWqXBtB6jdYy/cqu5nQMqPdXbxB+mvklfe34QQJjweAFzCZ1nsi47Jma4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MPe2sQZL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cFChnjsN; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MPe2sQZL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cFChnjsN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E7524EC0171;
	Tue, 22 Sep 2026 14:55:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 22 Sep 2026 14:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790103347; x=1790189747; bh=J6RNFV/s5y
	FyXfGE1KqmrNB0QfQcnL8PYFAXNi90WJo=; b=MPe2sQZLQ36a2H2j9nGIuFJAF5
	cXfzF20ofMML/qftZJnRjNuP2gWEA07/HwwbIlTc6ARsaOQMJYpsllAO7nimedJl
	c2X5LchaCgfCOqHIOXDQHsCNi5ewP+AALue99ze3Tv4crmuuZ47iPP/z85TUguab
	SjnfJ6LFGOJsYakex8I/RnyUYP4Un/vIt59e90zL+SRBuybjv1T7U5+RRstb9USf
	muDlz35rpTYz9b06gvYdk2l4Hlm8uFfxUbVvwtITfZm4rcAOKejKeVT3DrTpNcyC
	xkQyGJV1FGC+1uFIlW+gxIHM/kphWN++BB1oqNFMBIlMNEC66lrPWLHZT+ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790103347; x=1790189747; bh=J6RNFV/s5yFyXfGE1KqmrNB0QfQcnL8PYFA
	XNi90WJo=; b=cFChnjsNtg9aPUFAjIKKkEEfrrJr0U7W3HI/t76xc7fUjTnL1q5
	+WJD2YUjfr+nUcldrnDDK9geIQRaBqgpFxeu5ViQHDgcUsWzfjzz0e0iKnpFrogN
	MwAWkGhicJ+m1tUOTCQPHRPYydBKJ67fzvaVlkPsQp/7blrYBPb/rK/8SYIkceMR
	VYDoTVatiePNEFHetXb2aVzAqN9jc466V5Y4jWT2RPmx1KPgyHX5DbMbt3/6bvGc
	3TtDaGZfe4f20j9FAvps9+nFemLsXiNlBJPMbThfCoFJx6X9IqQAU85/qIPJUzPS
	Mb0aDVppwgYpIRx27RIY+BfAgf6l3wLyCNg==
X-ME-Sender: <xms:M8-yajHzAhwsHRRb9Ti59Lt_KP-AF6zesi_ytXdbnyIDvMiyOBNMCA>
    <xme:M8-yai5yn3Xmk3PazoMs2K32Gc5N8TNJ0uV7NX_TZidgyFuTEPwGoGvCEe6gNFlLE
    dwWquXz17azAoxtNW_DWeWnO3a6XRa80ImP05Gt2iQlRUJPHsWIN64>
X-ME-Received: <xmr:M8-yaozG_gK_s2k6GMn8j4zHG632TNJL0H1wCJWxGyaEnk6pjMg5qQgoqR_Vc5-PmLX5HxPEK0s-4l7QI0zthf-gFrBgqR6zyvQV>
X-ME-Proxy-Cause: dmFkZTF9CNT01/1Hl6TINWWFL/3kCkRfMUs3eqENTgbT6LF64gfEeF8xYz2g0Wp5a+6N+G
    J5PeUITpPj//q3Av3xenLgqA5IJ9OhO+EDNX/lcJcWNnDmTcRWvvrsML/v+VAX1KRpPvfU
    EPkPyG/vY4EEdEK84aADM3JNQrI4CJWJflGv+mDeERKlrE9id0AgCnuC0HykH2EHgmZ/bX
    SZIqEJqCLghyDAjHhalDGgcT8HrN5eKjedR4oVdRHHfeHgQXmOA8n3bELpXgx2TWFxGgyj
    uKI2BTXYQFeOBVdNfz1xPVJsu6TmysJqxmlzenvLDGtHxGvj5q7+0uo+0W8RHPMsyxeYGE
    9+f1kZAB2vfZqzW/7ZkGkVlHXwAB18E9K5MXZWetXO1TRhouO55zBUfmVA6R6wIvGIDZvW
    oU+1mWGsjl/0qCRzQWrlFuZuZx1XhnqvHsMITdUuDpHo1O1ejQp7WAAxLiGC/nhhKqF3iq
    phhcoU1F5QYS+APPk45bXcl8bltjO/6MmtRZ+B4YHG32pPqyV3aqj0RjGGSnGBSBM8GuBc
    CcofSCGNj3EBPQJnyhLW14gp1+2bI/TQdos+6EJWxxryfFY1ce0OfGT1QELJnqpibtvoz6
    1kJhoyXwumMT9T18T7I2u6xjTDmUJbyKYidMamCpXI5iUFbWa3I3ltzqQsLw
X-ME-Proxy: <xmx:M8-yahMHeaunW5e3H6GeH22g1tk776BDSUqmieB-WZNVuG0qTGaoMQ>
    <xmx:M8-yaulE5z_Z1nTo21AWDH9HrxGnS-5V8hvRkyN6qq4dAxBO20ZcEw>
    <xmx:M8-yamRjz6Oka_nl3Oj_SbkM3M-_KWA5_PJQ4q48oA5FyKkbLVzyng>
    <xmx:M8-yatUl0DPxsr_52cPwP2LIl01B7K2U_1f9nSxo3fxcTho3B3ReSw>
    <xmx:M8-yatBdKLEPgUxz8jIuz_cop7P7MeU-beuk-pU6g9Jayi3pTdFQTJum>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 14:55:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Phil Hord <phil.hord@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  "D . Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 1/3] refs: allow callers to supply old OIDs for batch
 deletion
In-Reply-To: <3315d5f47ad7d8bcdbeda90b161606507c7040ea.1790079917.git.maciej.ciemborowicz@gmail.com>
	(Maciej Ciemborowicz's message of "Tue, 22 Sep 2026 14:26:07 +0200")
References: <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
	<cover.1790079917.git.maciej.ciemborowicz@gmail.com>
	<3315d5f47ad7d8bcdbeda90b161606507c7040ea.1790079917.git.maciej.ciemborowicz@gmail.com>
Date: Tue, 22 Sep 2026 11:55:45 -0700
Message-ID: <xmqqjyoddsjy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> refs_delete_refs() performs unconditional deletions, so callers cannot
> preserve old values that they have already resolved. Consequently,
> reference-transaction hooks see a null old OID.
>
> Let callers provide an optional array of expected old OIDs in parallel with
> the refname list. When the array is provided, delete the ref at position N
> only if it still points at the OID at position N. A null OID requests an
> unconditional deletion for refs whose old value cannot be resolved, such as
> broken refs.
>
> Use REF_TRANSACTION_ALLOW_FAILURE when old OIDs are supplied. This retains
> the helper's best-effort behavior: an old-OID mismatch rejects that deletion
> while independent deletions in the batch can still proceed.

The history around this area seems to look like this (you can use
"git blame" to figure this out yourself).

 * 98ffd5ff67 (delete_refs(): new function for the refs API,
   2015-06-22) started the API function to allow multiple refs in
   bulk.  The comment in refs.h that says refs_delete_refs() is not
   done in an all-or-nothing transaction has been there ever since.

 * 2fb330ca72 (packed_delete_refs(): implement method, 2017-09-08)
   started the "because these operations cannot fail, we can afford
   to run bulk deletion in a transaction without having to worry
   about making it all-or-none" for the packed backends.

 * e85e5dd78a (refs/files: use transactions to delete references,
   2023-11-14) did the same for the files backends.

 * d6f8e72982 (refs: deduplicate code to delete references,
   2023-11-14) consolidated the "because these cannot fail, we can
   afford to run bulk deletion in a transaction without making it
   all-or-none" codepaths between files and packed backends.

 * 23fc8e4f61 (refs: implement batch reference update support,
   2025-04-08) introduced REF_TRANSACTION_ALLOW_FAILURE so that some
   callers can take advantage of "ref transactions" as a batched
   update mechanism, without having to roll everything back upon a
   failure.

Doesn't the above observation suggest us that we should always be
passing to ref_store_transaction_begin() inside refs_delete_refs()
the REF_TRANSACTION_ALLOW_FAILURE flag?  I would say that it was a
missed clean-up opportunity at 23fc8e4f61 that we didn't do so back
then.

> diff --git a/refs.c b/refs.c
> index 92d5df5b7..1e0f432ed 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3069,34 +3070,60 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
>  	}
>  }
>  
> +struct delete_refs_rejection_data {
> +	int failures;
> +};

This makes readers expect that we would be counting failures, e.g.,
the caller may request deletion of 100 refs and we report 30 of them
failed to be deleted.

> +static void delete_refs_rejection_handler(const char *refname,
> +					  const struct object_id *old_oid UNUSED,
> +					  const struct object_id *new_oid UNUSED,
> +					  const char *old_target UNUSED,
> +					  const char *new_target UNUSED,
> +					  enum ref_transaction_error err,
> +					  const char *details,
> +					  void *cb_data)
> +{
> +	struct delete_refs_rejection_data *data = cb_data;
> +
> +	warning(_("could not delete reference %s: %s"), refname,
> +		details ? details : ref_transaction_error_msg(err));
> +	data->failures = 1;
> +}

But that is not what is happening.  If we wanted to count, it is a
simple matter of incrementing the data->failures member instead of
assigning 1 to it, of course.

It also might be annoying to see 30 warning messages in such a
case---or it may be what the caller is asking.  I cannot tell.  If
we wanted to squelch excessive warning messages, we could count and
cut-off after N failures, of course.

>  int refs_delete_refs(struct ref_store *refs, const char *logmsg,
> -		     struct string_list *refnames, unsigned int flags)
> +		     struct string_list *refnames,
> +		     const struct oid_array *old_oids,
> +		     unsigned int flags)
>  {
> +	struct delete_refs_rejection_data rejection_data = { 0 };
>  	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
> -	struct string_list_item *item;
> +	size_t i;
>  	int ret = 0, failures = 0;
>  	char *msg;
>  
>  	if (!refnames->nr)
>  		return 0;
> +	if (old_oids && old_oids->nr != refnames->nr)
> +		BUG("refname and old OID counts do not match");
>  
>  	msg = normalize_reflog_message(logmsg);
>  
> -	/*
> -	 * Since we don't check the references' old_oids, the
> -	 * individual updates can't fail, so we can pack all of the
> -	 * updates into a single transaction.
> -	 */
> -	transaction = ref_store_transaction_begin(refs, 0, &err);
> +	transaction = ref_store_transaction_begin(refs,
> +			old_oids ? REF_TRANSACTION_ALLOW_FAILURE : 0, &err);

This is the conditional/unconditional REF_TRANSACTION_ALLOW_FAILURE
I discussed earlier.

>  	if (!transaction) {
>  		ret = error("%s", err.buf);
>  		goto out;
>  	}
>  
> -	for_each_string_list_item(item, refnames) {
> +	for (i = 0; i < refnames->nr; i++) {
> +		struct string_list_item *item = &refnames->items[i];
> +		const struct object_id *old_oid = old_oids ? &old_oids->oid[i] : NULL;
> +
> +		if (old_oid && is_null_oid(old_oid))
> +			old_oid = NULL;

I think there was a comment by another reviewer on the previous
round around this area, which was never answered.  In general, it is
a polite thing to respond to review messages and see that your
response is acknowledged before you send an updated patch.

I _think_ the reason why you need to treat null_oid specially is
because you are using a flat array of object names, not an array of
pointers to individual object names, but in that case, I wonder if
ref_transaction_delete() should be the one who pays attention to the
NULL-ness of its old_oid parameter?  The current code does detect
and reject (old_oid && is_null_oid(old_oid)) case, but I am not sure
what we are gaining by that limitation.  Rather I wonder if the
first two lines of the function should read more like

                if (old_oid && is_null_oid(old_oid))
        -		BUG("delete called with old_oid set to zeros");
        +		old_oid = NULL;

not forcing the callers (like we see above) to do the same.

> @@ -3112,9 +3139,14 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
>  			      refnames->items[0].string, err.buf);
>  		else
>  			error(_("could not delete references: %s"), err.buf);
> -	}
> +	} else if (old_oids)
> +		ref_transaction_for_each_rejected_update(transaction,
> +						 delete_refs_rejection_handler,
> +						 &rejection_data);

I personally feel that we should be weaning ourselves off of the
assumption that presence of old_oids[] is the ONLY thing to cause
rejection.  IOW, always call for-each-rejected-update here
regardless of old_oids != NULL.

>  out:
> +	if (rejection_data.failures)
> +		failures = 1;

This is quite roundabout thing to do.  rejection_data.failures,
unlike my initial assumption, is not counting but is either 0 or 1,
so failures here is also either 0 or 1, and then ...

>  	if (!ret && failures)
>  		ret = -1;

... if we have the failures computed to non-zero, we make sure ret
is not zero.  Shouldn't we at least get rid of the local variable
failures?

And if a variable FOO is not counting the number of FOO, do not name
it FOOs.  If it is a Boolean recording if we got FOOed, call it as
such.  My preference in this code path is to actually count failures
in the member "int failures" of rejection_data structure, but if we
are not counting, then call it "bool failed", perhaps.

	out:
		if (!ret && rejection_data.failed)
			ret = -1;

