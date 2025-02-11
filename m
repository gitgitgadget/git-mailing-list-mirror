Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ABF1F4295
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270009; cv=none; b=uDvj4mPvIPKSwQPVxY/6LkofQXmSIcYWxTicY6PQdlMJgL9AXgPN9W5/VUo47yXsu5Oq+8h5fwX4ozu2/ROvSzk2Hk8VS153pS6yZ7fUAgyODl5yOrUeTFV6kQMREHWMpPofc7pZK3mPwdUY1dwzyzeXlb8IaS69gki+vQpXhCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270009; c=relaxed/simple;
	bh=bViFZhIG7GxKtpBFolW/uh/pERu5lRXXtcWEiBQWXWg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUKn+YggUb3Cm9z03QKIgvgz2nt4CjvJl4UEaO739ahz90lXS6YHnvUprQyVuEhAogq/y2/FNq/jLOqoUkbUZU+JRTcUTXBzEdvsxid5oL2MkPKqs6iF7Rxu3pFJggdyBZaJBAWYxC/FziKI49M2V4/sY0qKU4gklMc1e+L4a0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba1HbWYp; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba1HbWYp"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4bbc047a3c3so1487494137.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 02:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739270006; x=1739874806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mdI9XLRLDbpX//zGEAbMEcLfqLPAjsQjmmALxBDSMDE=;
        b=ba1HbWYp1eogjGgada68a5yQDkVvrwx1ndLBEUqA730PLiHHPA/0DEG4WlmUogtcfk
         mT2uQurVSWZRgeer9+BU/WOYA36at4Wz2ZUbSiDsYgVN9vuiszQagoVfdis3TkP56KOW
         oAiqsVJI7Ma+5Y3/lJcQR113sDMXiV9g2myrw4sKSNfTiFaTgdHh7L/AV4H4JlTxPpWC
         rn+xUUyIvVnIalIqXq4rqquYzHyRrgE7tZPJJ5TwqjkshpfBhY3zZ0QkJ6iI47+nfcC+
         4ZvhERmQ9RJUPgq+kvMnjvUjamtYa1wFhhfpLNpVR+2x/CpjeSxpUmY6YpoopxvRlKjj
         iZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739270006; x=1739874806;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdI9XLRLDbpX//zGEAbMEcLfqLPAjsQjmmALxBDSMDE=;
        b=TrpmEbPljM2JvRV82eLc/+e5jcVIqzmpIbmsqbSYxNLmzZZCilf3uVcQLYoXy/5DnW
         6S/v5lzzXKVlKJnbYIks4b0dWQU17lgMrh5rawsTE/5Alm9EKooLkcfZKPjOObcbSxhW
         MmZM1ydFw1b8oYVvB9WTB9dR8udyK6lxt3GX41xczv85N/Y4/uCfssPNJKPEpApE2aEw
         djLquW6sUmrgNCMbcOvMb1OBd1TIC9jtSECJKFLdWHvxM+tXHVrV4lsAsrAHHCPj5bho
         1OFsouorBUgP/FyzvURp/GCXimYdWgH4vNaH+s9CeN6aOXp3AXDCPy5lDGz/3yzIhFDc
         XVAw==
X-Gm-Message-State: AOJu0YzPlxCvYQKhw/Jl8Z3Yy+8epIOSgiu8hktbl6qR/3cDWKLX+aCQ
	kjiOxB6jZhfRYaZMT8Pmjz2j7t8KQC2HeIqir3q4k2oKq4V/QLvMDl6gEgAGawGNKnMkFr1QkDE
	iLB4fSzV0KGNjzy78j5cZCJKfv4UjHxNA
X-Gm-Gg: ASbGnct1KtW9qXlnQbLL1WeGO+WZMrx7SfoS9vGnZms/zi/wDmru15AKy9rzvQQvrJp
	yCunjOsOFC82BrOb0bB2a2AE/704dpRkK4xicHmGwK96oeTfc2sljZyRg+X+Hwb/sletZ8ulJUK
	IwEFXI2o0IfLNFE8VAw7kcewkEM12Pzm0=
X-Google-Smtp-Source: AGHT+IEfOuz07QBATXbKOSF458SbNPfh8BF7uOraC4PV9FjWpEJA7TtXPO89Ve6cZLYy5CH8rCoQ7erwyTkqWHbacoc=
X-Received: by 2002:a05:6102:c8b:b0:4bb:e1c9:80b4 with SMTP id
 ada2fe7eead31-4bbe1c983ecmr1505909137.0.1739270006241; Tue, 11 Feb 2025
 02:33:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 05:33:25 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z6Yw_f6PGJ2X_Iue@pks.im>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250207-245-partially-atomic-ref-updates-v1-2-e6a3690ff23a@gmail.com> <Z6Yw_f6PGJ2X_Iue@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Feb 2025 05:33:25 -0500
X-Gm-Features: AWEUYZkxYYrgXNjb9fIcA3GoRECuKyFYBbZJgALSiSo4PfiGEllDAmr5Yrcfkj0
Message-ID: <CAOLa=ZT+uFOCDR1nJpOoCneBVT=fKDLMhmSwVHJxVOPeaX3W2w@mail.gmail.com>
Subject: Re: [PATCH 2/6] refs: move duplicate refname update check to generic layer
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000e420e5062ddb5a87"

--000000000000e420e5062ddb5a87
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Feb 07, 2025 at 08:34:37AM +0100, Karthik Nayak wrote:
>> Move the tracking of refnames in `affected_refnames` from individual
>> backends into the generic layer in 'refs.c'. This centralizes the
>> duplicate refname detection that was previously handled separately by
>> each backend.
>
> Exciting, this has been on my TODO list for quite a while already.
>

Yeah, I saw that you left a TODO in the reftable backend too. This
change was not really needed for partial transactions. But it does make
things a bit nicer and easier.

>> Make some changes to accommodate this move:
>>
>>   - Add a `string_list` field `refnames` to `ref_transaction` to contain
>>     all the references in a transaction. This field is updated whenever
>>     a new update is added.
>>
>>   - Modify the backends to use this field internally as needed. The
>>     backends need to check if an update for refname already exists when
>>     splitting symrefs or adding an update for 'HEAD'.
>
> Okay. Is this actually necessary to be handled by the backends? I
> would've expected that it is possible to split up symref updates so that
> we insert both symref and target into the list. I wouldn't be surprised
> if this wasn't easily possible though -- the logic here is surprisingly
> intricate.

It is a bit intricate and requires a bit of unwinding to move it to the
generic layer. But it is possible, I tried to timebox it for this patch
series, but unfortunately it needs a lot more time. So perhaps,
something for later.

>
>>   - In the reftable backend, in `reftable_be_transaction_prepare()`,
>>     move the instance of `string_list_has_string()` above
>>     `ref_transaction_add_update()` to check before the reference is
>>     added.
>>
>> This helps reduce duplication of functionality between the backends and
>> makes it easier to make changes in a more centralized manner.
>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs.c                  | 17 ++++++++++++
>>  refs/files-backend.c    | 69 ++++++++++---------------------------------------
>>  refs/packed-backend.c   | 25 +-----------------
>>  refs/refs-internal.h    |  2 ++
>>  refs/reftable-backend.c | 53 ++++++++++++-------------------------
>>  5 files changed, 50 insertions(+), 116 deletions(-)
>
> Nice.
>
>> diff --git a/refs.c b/refs.c
>> index f4094a326a9f88f979654b668cc9c3d27d83cb5d..4c9b706461977995be1d55e7667f7fb708fbbb76 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1175,6 +1175,7 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
>>  	CALLOC_ARRAY(tr, 1);
>>  	tr->ref_store = refs;
>>  	tr->flags = flags;
>> +	string_list_init_dup(&tr->refnames);
>
> Do we actually have to duplicate strings? I would've expected that we
> keep strings alive via the `ref_update`s anyway during the transaction's
> lifetime.
>

True. I was more thinking along the lines of the keeping the memory
concerns separate. Also, I  sure if there are any scenario's that
a `ref_transaction` could outlive a `ref_update`.

> It might also be interesting to check whether using a strset for this
> is more efficient. But that is certainly outside the scope of your patch
> series and can be done at a later point. #leftoverbit
>

Agreed.

>> @@ -1245,6 +1248,16 @@ struct ref_update *ref_transaction_add_update(
>>  		update->msg = normalize_reflog_message(msg);
>>  	}
>>
>> +	/*
>> +	 * This list is generally used by the backends to avoid duplicates.
>> +	 * But we do support multiple log updates for a given refname within
>> +	 * a single transaction.
>> +	 */
>> +	if (!(update->flags & REF_LOG_ONLY)) {
>> +		item = string_list_append(&transaction->refnames, refname);
>> +		item->util = update;
>> +	}
>> +
>>  	return update;
>>  }
>> @@ -2397,6 +2410,10 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
>>  		return -1;
>>  	}
>>
>> +	string_list_sort(&transaction->refnames);
>> +	if (ref_update_reject_duplicates(&transaction->refnames, err))
>> +		return TRANSACTION_GENERIC_ERROR;
>> +
>>  	ret = refs->be->transaction_prepare(refs, transaction, err);
>>  	if (ret)
>>  		return ret;
>
> Okay, we keep the list unserted initially, but sort it later before
> passing it to the backends so that `string_list_has_string()` works
> correctly. Good.
>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index c6a3f6d6261a894e1c294bb1329fdf8079a39eb4..18da30c3f37dc5c09f7d81a9083d6b41d0463bd5 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2425,7 +2423,6 @@ static int split_head_update(struct ref_update *update,
>>  	 */
>>  	if (strcmp(new_update->refname, "HEAD"))
>>  		BUG("%s unexpectedly not 'HEAD'", new_update->refname);
>> -	string_list_insert(affected_refnames, new_update->refname);
>>
>>  	return 0;
>>  }
>
> Previously we would've inserted "HEAD" into the list of affected
> refnames even if it wasn't directly updated. Why don't we have to do
> that now anymore?
>

We still do, right above this code, there is a call to
`ref_transaction_add_update()`. So any ref_update added to the
transaction via `ref_transaction_add_update()` will also add the refname
to `transaction->refnames`.

>> @@ -2441,7 +2438,6 @@ static int split_head_update(struct ref_update *update,
>> @@ -2491,15 +2487,6 @@ static int split_symref_update(struct ref_update *update,
>>  	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
>>  	update->flags &= ~REF_HAVE_OLD;
>>
>> -	/*
>> -	 * Add the referent. This insertion is O(N) in the transaction
>> -	 * size, but it happens at most once per symref in a
>> -	 * transaction. Make sure to add new_update->refname, which will
>> -	 * be valid as long as affected_refnames is in use, and NOT
>> -	 * referent, which might soon be freed by our caller.
>> -	 */
>> -	string_list_insert(affected_refnames, new_update->refname);
>> -
>>  	return 0;
>>  }
>
> Same question here, but for symref updates.
>

Same as above. In summary, the need for adding new refnames to the list
is now centralized and a part of adding a ref update to the transaction.

It's a good question, so I'll also add a hint in the commit message.

>
>> @@ -3030,13 +2995,8 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>>  	if (transaction->state != REF_TRANSACTION_PREPARED)
>>  		BUG("commit called for transaction that is not prepared");
>>
>> -	/* Fail if a refname appears more than once in the transaction: */
>> -	for (i = 0; i < transaction->nr; i++)
>> -		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
>> -			string_list_append(&affected_refnames,
>> -					   transaction->updates[i]->refname);
>> -	string_list_sort(&affected_refnames);
>> -	if (ref_update_reject_duplicates(&affected_refnames, err)) {
>> +	string_list_sort(&transaction->refnames);
>> +	if (ref_update_reject_duplicates(&transaction->refnames, err)) {
>>  		ret = TRANSACTION_GENERIC_ERROR;
>>  		goto cleanup;
>>  	}
>
> Can't we also make this check generic for initial transactions?
>

This one is handled in the next commit, I mostly separated them out
because I was not sure why this needs to be here and to draw attention
if I'm missing something when removing this.

>> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
>> index a7b6f74b6e35f897f619c540cbc600bbd888bc67..6e7acb077e81435715a1ca3cc928550147c8c56a 100644
>> --- a/refs/packed-backend.c
>> +++ b/refs/packed-backend.c
>> @@ -1653,34 +1648,16 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
>>  	 */
>>
>>  	CALLOC_ARRAY(data, 1);
>> -	string_list_init_nodup(&data->updates);
>>
>>  	transaction->backend_data = data;
>>
>> -	/*
>> -	 * Stick the updates in a string list by refname so that we
>> -	 * can sort them:
>> -	 */
>> -	for (i = 0; i < transaction->nr; i++) {
>> -		struct ref_update *update = transaction->updates[i];
>> -		struct string_list_item *item =
>> -			string_list_append(&data->updates, update->refname);
>> -
>> -		/* Store a pointer to update in item->util: */
>> -		item->util = update;
>> -	}
>> -	string_list_sort(&data->updates);
>> -
>> -	if (ref_update_reject_duplicates(&data->updates, err))
>> -		goto failure;
>> -
>>  	if (!is_lock_file_locked(&refs->lock)) {
>>  		if (packed_refs_lock(ref_store, 0, err))
>>  			goto failure;
>>  		data->own_lock = 1;
>>  	}
>>
>> -	if (write_with_updates(refs, &data->updates, err))
>> +	if (write_with_updates(refs, &transaction->refnames, err))
>>  		goto failure;
>>
>>  	transaction->state = REF_TRANSACTION_PREPARED;
>
> This change is a lot more straight-forward because the packed backend
> does not support symrefs at all. Nice.
>

Yes indeed.

>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index d39a14c5a469d7d219362e9eae4f578784d65a5b..dd2099d94948a4f23fd9f7ddc06bf3d741229eba 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -1202,12 +1184,11 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>>  				goto done;
>>  			}
>>
>> -			new_update = ref_transaction_add_update(
>> -					transaction, "HEAD",
>> -					u->flags | REF_LOG_ONLY | REF_NO_DEREF,
>> -					&u->new_oid, &u->old_oid, NULL, NULL, NULL,
>> -					u->msg);
>> -			string_list_insert(&affected_refnames, new_update->refname);
>> +			ref_transaction_add_update(
>> +				transaction, "HEAD",
>> +				u->flags | REF_LOG_ONLY | REF_NO_DEREF,
>> +				&u->new_oid, &u->old_oid, NULL, NULL, NULL,
>> +				u->msg);
>>  		}
>>
>>  		ret = reftable_backend_read_ref(be, rewritten_ref,
>
> Equivalent question as for the files backend.
>

I hope my answer earlier helps, especially since the diff here shows the
call to `ref_transaction_add_update()`.

>> @@ -1277,6 +1258,15 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>>  				if (!strcmp(rewritten_ref, "HEAD"))
>>  					new_flags |= REF_UPDATE_VIA_HEAD;
>>
>> +				if (string_list_has_string(&transaction->refnames, referent.buf)) {
>> +					strbuf_addf(err,
>> +						    _("multiple updates for '%s' (including one "
>> +						    "via symref '%s') are not allowed"),
>> +						    referent.buf, u->refname);
>> +					ret = TRANSACTION_NAME_CONFLICT;
>> +					goto done;
>> +				}
>> +
>>  				/*
>>  				 * If we are updating a symref (eg. HEAD), we should also
>>  				 * update the branch that the symref points to.
>
> This change surprised me a bit. You mention it in the commit message,
> but don't state a reason why you do it.
>

When a `ref_update` is added to the `transaction` via
`ref_transaction_add_update()`, the refname is automatically added to
`transaction->refnames`. As a result, checking for the refname in this
list will always return true. I'll clarify this in the commit message.

> Patrick

--000000000000e420e5062ddb5a87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e78bb5a520ecfcba_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lckozTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmt1Qy80NndYejhnTXpOQlFnZHZLRVpFQTdCa2x2dwp4L3BDdkNGQ2xS
VFdYMEtKd1c5bmdaNE9ENjBQYUF3R016Mkx4RUNzc0RwNWZmMXFFVHY4WjNoakoveUc3YVY5Ckoy
NDAwc1dTVUxyR1dPOU1PM2U0SXIweGVMSlFMbmRhckhQVWZVc29VU0FRUGw2OVZRa1JhbC9PQkcw
dUQ4dy8KY0drWENSeWdtRTdFeCtOa3QxVjJRNjVQZFlEczdpUGg1TGpzb3lTSlovaGxZYWUrekoy
WXpwZ0loN1VReURyYQpxR0FuMWQ1ZFZaYWNINnlRcjdMakFEY1E3MGtKc1hzV2NXamp6SWdjaXU3
ZDVlNUR6T2ExTTBTekRCTll0RW04Cnlqb0tzTDhSZVNzYkwxaDJRaDVPbnBmUkhWRGNmU2hHRm5q
WG5GR2QweWk3VEJyU3E1aTYyQTFod1Yzb3l5bmoKVVc4djBXZXZXdDB2WGNkeFRoamlSMHlNb3ZU
YzBtZ1NlYnNvWHBlUTlSY0tGUGVxZUlKQVdMWkFiQVZFOEs1WAovbG5oL0xYTzFuYUtreldpYVZq
TnhPVVhuKzByK3hVb2RZcnhva0ZWYmx3YnhPK1J6NHZYZW1XUDMwNzk4K2ExCitxZFU4OUwxZGxq
dEczY3dBL1hQVzRQRExFbmpEYXo2SmZQR2lBMD0KPVY3VG4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e420e5062ddb5a87--
