Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5F85284
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563585; cv=none; b=OffT/3o8ww9X0mqNT+UOy1txJLaFDy3eAnaxTZr7kX8Q4U4e7r/c1sWSHUek+tKM/fs6+IQQYci4cTsBT603mgO2+VofukVDF8YXLMtyiWRghElsMZL7Aev8cn7NkdnrDIDJf7njrhOSJL8M9TBJYeC4RbF6vDnGK0Xqhh5dw5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563585; c=relaxed/simple;
	bh=5Ul9eTrfCfexQlE1e4m+JL9kxeHqqVXOsr5RyXXVmzE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crw6DBdmdXM6EBRyIYNaHKVwXHStQV0foF6oR0b7oyVgm1dWTGN3QA+itSsymk9l96L0/H1Yio/hQR6ENZTKVGecqMg/m3FK8hY6gfbEEG7Yiv4+Wd4uLKKxul1RJnrtaiAtl8NHbYz2m0eyMUljJ2SB5i2p3e8Mk8n2Xh0xdnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaaYqwv3; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaaYqwv3"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22efc6b8dc5so1534877fac.0
        for <git@vger.kernel.org>; Fri, 19 Apr 2024 14:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713563583; x=1714168383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7cH8igxpbcNRiVPJyRp047lGe0YP5tTsTZ3RChKFHn0=;
        b=CaaYqwv3+aoX9kMVYYfpNSnP9bVUe/P883q7FoTg6lgw44PFGf8/F4JxyWZu+r85c/
         XbDyRaxWnkAPcxeVTuJEsZbkgSjx7Jrd2H9rrRMJUKOS/0KkWEc9FY4jc/qvK6lKjczK
         N+LJ0Ar8inVrAsZ7wau/CsxQ3asvQeAjdIzFMVq4ma5PFNyJK/OKk7rlUyfLhfjnEuiA
         XHgCZBpIYMUdz0lKzfOS5q6a/WG4UDYYd5ff1i5idbbhI5h0MI+WlqZq9WjUJzW7pgz2
         odZLG5lnrfyjPC4G4HQQPCeRxTjvoHgZz/7K8rSszHt/wFZQgLFSAFrM9KTDizlCpPjS
         AJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713563583; x=1714168383;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cH8igxpbcNRiVPJyRp047lGe0YP5tTsTZ3RChKFHn0=;
        b=UgLEMGfIy15qlCLEgkXy86Vtoh+3tD1fQ3e70vnVUgWxqgKrPHrqwHwE33qOzNCzxL
         6yMzvV8frPzGS1rYokkcIUyAyGJ/1ppK6TGciKgsEcc7UQYnMCw9l6yvDKcTDkPhiIW4
         8SI0TXEQH1DZqinPxqba5IC5tNCev5ibJHBbp36yHqnG+Yyji0ppEe0jkP0GL5HCECXj
         TsnxR0d7C3hB4IAcKlcjOZkHUWxsdcgREgYgUQsCBmRtPVhgY64hxMBLcfgrrF6zGJ02
         1+Qmo8rfAo4ljRr0FqYw/iU1bkBORTnjrdtv90CwpHFSTzG7H4eJm/EwzwBFNUJ5SZjR
         R08g==
X-Forwarded-Encrypted: i=1; AJvYcCXCcsW5Ug7SNpRw6Lq3M6mIAmyGROWiN/noaLVQjV+6uvJzYMfi2EUgPO1DhgegkvrSBc+azVC0vZeb5lfxoxA/AOy9
X-Gm-Message-State: AOJu0Yx54mgTqI1Pp+EXpuS8Bpnx/z4fJE/Plx0rcHLOUkvrsknLxLDT
	uvdyLqwIyJFmJCQ9TOZkEoYqnLwbEWiZwHDqxEmeaFX+hQgxBRuIcodvgc3A+0nwrGmY+kqwoAN
	9SGr49flUZ/BOQ0wF5x9gzBZPX6U=
X-Google-Smtp-Source: AGHT+IHUCd8FHJUtjAd+33B6frAf26hIH3W56qQfmfPtB8LZmE6zCmnbZSgk2dao9xYOauo2j4AQ6OJ6g67jemqXw/E=
X-Received: by 2002:a05:6870:96a1:b0:221:bf34:b15f with SMTP id
 o33-20020a05687096a100b00221bf34b15fmr3765831oaq.25.1713563583202; Fri, 19
 Apr 2024 14:53:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Apr 2024 14:53:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZiI8DmqrbvdCDWt0@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-3-knayak@gitlab.com> <ZiI8DmqrbvdCDWt0@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Apr 2024 14:53:01 -0700
Message-ID: <CAOLa=ZQJmxrQ+n060P0X8BW4ay2XMvOHHyJ3vxrW7C+j+5kWSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] update-ref: add support for symref-verify
To: Patrick Steinhardt <ps@pks.im>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000ad618906167a1c3a"

--000000000000ad618906167a1c3a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
>> +symref-verify::
>> +	Verify symbolic <ref> against <old-ref> but do not change it.
>> +	If <old-ref> is missing, the ref must not exist.  Can only be
>> +	used in `no-deref` mode.
>
> Should this say "is zero or missing", like the comment for "verify"
> does?
>

We don't allow users to enter OID here, we do convert it to zero OID
internally. But the user input is expected to be old_ref or nothing.

> [snip]
>> @@ -297,11 +321,48 @@ static void parse_cmd_verify(struct ref_transaction *transaction,
>>  		die("verify %s: extra input: %s", refname, next);
>>
>>  	if (ref_transaction_verify(transaction, refname, &old_oid,
>> -				   update_flags, &err))
>> +				   NULL, update_flags, &err))
>> +		die("%s", err.buf);
>> +
>> +	update_flags = default_flags;
>> +	free(refname);
>> +	strbuf_release(&err);
>> +}
>> +
>> +static void parse_cmd_symref_verify(struct ref_transaction *transaction,
>> +                                    const char *next, const char *end)
>> +{
>> +	struct strbuf err = STRBUF_INIT;
>> +	struct object_id old_oid;
>> +	char *refname, *old_ref;
>> +
>> +	if (!(update_flags & REF_NO_DEREF))
>> +		die("symref-verify: cannot operate with deref mode");
>
> This feels quite restrictive to me. Wouldn't it be preferable to simply
> ignore `REF_NO_DEREF` here? It basically means that this command can't
> ever be used in a normal `git update-ref --stdin` session.
>

We do support 'option' with the '--stdin' flag. So technically a user
should be able to do.

   $ git update-ref --stdin
   no-deref
   symref-verify refs/heads/symref refs/heads/master
   update-ref refs/heads/branch 0b3b55ad0e593ead604f80fe3f621239b34cce7e

I guess we could make it implicit, but I thought it's better to keep it
explicit so the user knows that there is no dereferencing taking place
here, eventhough the default option is to dereference.

[snip]
>>
>>  	update->flags = flags;
>>
>> -	if (flags & REF_HAVE_NEW)
>> -		oidcpy(&update->new_oid, new_oid);
>> -	if (flags & REF_HAVE_OLD)
>> -		oidcpy(&update->old_oid, old_oid);
>> +	/*
>> +	 * The ref values are to be considered over the oid values when we're
>> +	 * doing symref operations.
>> +	 */
>
> I feel like this is a statement that should be backed up by a deeper
> explanation of why that is. I'm still wondering here why we cannot
> assert that the old value is an object ID when I want to update it to a
> symref, or alternatively why it would even be possible to have both
> `REF_SYMREF_UPDATE` and a set of other, incompatible fields set. It
> feels like this should be a `BUG()` instead if this is supposedly an
> unsupported configuration rather than silently ignoring it.
>
> In any case, I feel like it would be easier to reason about if this was
> introduced together with the actual user. As far as I can see this code
> shouldn't ever be hit for "verify-symref", right? Currently, the reader
> is forced to figure out what is and isn't related to the new command.
>

I've changed this now to no longer have this condition and also added
'BUG' for cases where both old_{ref,target} and new_{ref,target} exist.

[snip]
>> @@ -2464,8 +2495,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>>  			       struct strbuf *err)
>>  {
>>  	struct strbuf referent = STRBUF_INIT;
>> -	int mustexist = (update->flags & REF_HAVE_OLD) &&
>> -		!is_null_oid(&update->old_oid);
>> +	int mustexist = (update->flags & REF_HAVE_OLD) && !is_null_oid(&update->old_oid);
>
> This change is a no-op, right? If so, let's rather drop it.
>

Yeah, will do.

>>  	int ret = 0;
>>  	struct ref_lock *lock;
>>
>> @@ -2514,6 +2544,18 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>>  					ret = TRANSACTION_GENERIC_ERROR;
>>  					goto out;
>>  				}
>> +			}
>> +
>> +			/*
>> +			 * For symref verification, we need to check the referent value
>> +			 * rather than the oid. If we're dealing with regular refs or we're
>> +			 * verifying a dereferenced symref, we then check the oid.
>> +			 */
>> +			if (update->flags & REF_SYMREF_UPDATE && update->old_ref) {
>> +				if (check_old_ref(update, referent.buf, err)) {
>> +					ret = TRANSACTION_GENERIC_ERROR;
>> +					goto out;
>> +				}
>>  			} else if (check_old_oid(update, &lock->old_oid, err)) {
>>  				ret = TRANSACTION_GENERIC_ERROR;
>>  				goto out;
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index 4c5fe02687..21c6b940d8 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -749,4 +749,11 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
>>   */
>>  struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store);
>>
>> +/*
>> + * Helper function to check if the new value is null, this
>> + * takes into consideration that the update could be a regular
>> + * ref or a symbolic ref.
>> + */
>> +int null_new_value(struct ref_update *update);
>
> When adding it to the header we should probably prefix this to avoid
> name collisions. `ref_update_is_null_new_value()` might be a mouth full,
> but feels preferable to me.
>

Makes sense.

>>  #endif /* REFS_REFS_INTERNAL_H */
>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index 6104471199..7a03922c7b 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -938,7 +938,28 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>>  		 * individual refs. But the error messages match what the files
>>  		 * backend returns, which keeps our tests happy.
>>  		 */
>> -		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
>> +		if ((u->flags & REF_HAVE_OLD) &&
>> +		    (u->flags & REF_SYMREF_UPDATE) &&
>> +		    u->old_ref) {
>> +			if   (strcmp(referent.buf, u->old_ref)) {
>
> s/   / /
>
>> +				if (!strcmp(u->old_ref, ""))
>> +					strbuf_addf(err, "cannot lock ref '%s': "
>> +						    "reference already exists",
>> +						    original_update_refname(u));
>> +				else if (!strcmp(referent.buf, ""))
>> +					strbuf_addf(err, "cannot lock ref '%s': "
>> +						    "reference is missing but expected %s",
>> +						    original_update_refname(u),
>> +						    u->old_ref);
>> +				else
>> +					strbuf_addf(err, "cannot lock ref '%s': "
>> +						    "is at %s but expected %s",
>> +						    original_update_refname(u),
>> +						    referent.buf, u->old_ref);
>
> I'd use better-matching error messages here. I know that we talk about
> "cannot lock ref" in the next branch, as well. But the only reason we
> did this is to have the same error messages as the "files" backend.
> Semantically, those errors don't make much sense as the "reftable"
> backend never locks specific refs, but only the complete stack.
>

Fair enough, will change.

>> +				ret = -1;
>> +				goto done;
>> +			}
>> +		} else if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
>>  			if (is_null_oid(&u->old_oid))
>>  				strbuf_addf(err, _("cannot lock ref '%s': "
>>  					    "reference already exists"),
>> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
>> index ec3443cc87..d8ffda4096 100755
>> --- a/t/t1400-update-ref.sh
>> +++ b/t/t1400-update-ref.sh
>> @@ -890,17 +890,23 @@ test_expect_success 'stdin update/create/verify combination works' '
>>  '
>>
>>  test_expect_success 'stdin verify succeeds for correct value' '
>> +	test-tool ref-store main for-each-reflog-ent $m >before &&
>>  	git rev-parse $m >expect &&
>>  	echo "verify $m $m" >stdin &&
>>  	git update-ref --stdin <stdin &&
>>  	git rev-parse $m >actual &&
>> -	test_cmp expect actual
>> +	test_cmp expect actual &&
>> +	test-tool ref-store main for-each-reflog-ent $m >after &&
>> +	test_cmp before after
>>  '
>>
>>  test_expect_success 'stdin verify succeeds for missing reference' '
>> +	test-tool ref-store main for-each-reflog-ent $m >before &&
>>  	echo "verify refs/heads/missing $Z" >stdin &&
>>  	git update-ref --stdin <stdin &&
>> -	test_must_fail git rev-parse --verify -q refs/heads/missing
>> +	test_must_fail git rev-parse --verify -q refs/heads/missing &&
>> +	test-tool ref-store main for-each-reflog-ent $m >after &&
>> +	test_cmp before after
>>  '
>
> The updated tests merely assert that the refs didn't change, right?
>

Yes, also that we didn't add anything unexpected to the reflog.


>>  test_expect_success 'stdin verify treats no value as missing' '
>> @@ -1641,4 +1647,74 @@ test_expect_success PIPE 'transaction flushes status updates' '
>>  	test_cmp expected actual
>>  '
>>
>> +create_stdin_buf ()
>> +{
>
> The curly brace should go on the same line as the function name.
>

Right, will change.

>> +	if test "$1" = "-z"
>> +	then
>> +		shift
>> +		printf "$F" "$@" >stdin
>> +	else
>> +		echo "$@" >stdin
>> +	fi
>> +}
>> +
>> +for type in "" "-z"
>> +do
>
> We should probably indent all of the tests to make it easier to see that
> they run in a loop.
>
> Patrick
>

I was a bit confused about this, I saw smaller tests with loops
indented, while some larger ones not indented. I think its better to do
so too, let me do that.

--000000000000ad618906167a1c3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 81370a2799ccf95d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZaTU3c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFpIREFDUTQwZ25IeWFlNVpJcUx6anVoazl3T1FXTQpjMFZockQvZFdi
emJNS1pCcU9BdWRMM2dEMVZXMFBWODIzdkU2R2FYUmYxKzhrZklwYWRFMkh6ZWNLZ01mTFYrCmEz
cVIwZnJpd0ZkYTJCNi8zbXBlV0J0cENkQXN1UTNlMm9IVHZXSk9oWW9TZlFWUnR2QzlsWk1YWnoy
MXZ0NUUKQ2tPRTR0czJkRmdzbEpwUFh2U0txUWcvNFpNeXdIT3VYUVhSZGpmTFdNc2dVVW9FemR1
cUdGdDJ6aWpYeUhEbApkNUxQcVZkMGZEenlDY0piWEpyNVFReS9nNTd4OUM4dE5vaVhXQkFlOUZJ
TmIrZUhmT2E2T0wvQ1BVQzRlWVhzCnNOYkN0anBmV054TnhqbTFDT293N2pzUERjQURMMmxLUzBw
Kzc1YjFaakFUcG91d3VHK2dwSjRuSXBnQ2VIOVQKSjJESTFhMld3Z244aGdzVjZQaGRONmxuREw5
eUpwZld2YnlBME04ejRlOW5acHdtdWxIYjBkZmRLYldCQVVuYgp0Mm5EbUl0ZmVtcHRvVWNaNFM3
SVVLZ2JUaHBaNFRsb0lmckQ0NGgyUnBiQm5mVVBnbWlWMjZjdWluSFBIRndjCjhOcHFIYWRxVVU1
eGNzdFdBWktBT29XL0gwd3cwU0o2YnRLY1hBVT0KPXUxTC8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ad618906167a1c3a--
