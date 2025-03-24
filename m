Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7B261366
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828103; cv=none; b=lokHR8e5XbgdMJkc87LUL6jQAfv7vJxe1aXhvsZY10JiMybIl3yA56V2oVIfDzo+Z6737Ig1VFZsy5UPw+7qQH8YjhPDPkWstK4ywT64MVLM0K8DLvLW3iwj8JqpoJjintIOwLAkRe0mZwdewfaTiRM535JNcYVubqpmtYSCDvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828103; c=relaxed/simple;
	bh=DFMHVullVw76hdirDciOOfMBLxk+hKiP+lVmlPl8R2o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdXVU3t/nzZ/sb52YXvbRbFBrNhjTXWHnAtTVi26/QsDiwLvIAEKbIOOaeAPYZhnXIJRypfKrZLJpc9Pa1+X5SvDFz0cOxWLJ/PzTpAdgAT4YZH65T9VuCaYCXYqUPOQpGciY609zBIuPd3GOLnNsn5LFi4kKFHu2xI5+lAtGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv0wAnU7; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv0wAnU7"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-523f19d39d3so2107481e0c.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742828100; x=1743432900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C28f0wCTXGMis/bYT6k1uPrxXX0MLUqmJHCEVw0n8as=;
        b=Fv0wAnU7+6rJzfvmtuoff08uTOKFF2h1vN3n649KUuKshRU7N8AxdMCTKSwRtvLSPt
         fZBOaZLG1prxeGYFTbbU0FhBBdnpNK1W612NeSFvJRzYzFXsziKWwA7D6ERDDYGjCV6L
         QkrSU7cmBTIlSEv+0Qw0/E4f76dic4n9QQV64A7onRDHe7YxXvwm0sX51QZ7e4sH3NlP
         u4Qy0Z3dh7l0L4EW18Lzs8ewlUbkgMiSZ9WzOYri9DBPdVu+dvA452U2BEkdhrmPfk9h
         7vd6JXI77oKMUQRagdSNC466RgLzJP/UvLH+Y+caeS84KXztFmQ0i+5v1vMURfXirOFr
         ow8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828100; x=1743432900;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C28f0wCTXGMis/bYT6k1uPrxXX0MLUqmJHCEVw0n8as=;
        b=PGh8zceWmva2CPYV0TSnapYmTFbAp1HQi5MkzPtyiU6k+YeRrFwqDp3urAD/ftSqJd
         OGMLbytF4vtXY9xsYSX/G/44Zi5OUVD9seohAUPr02RUyqhwQUlGd/RzauRpG2vGD4G3
         DGo+H5UH8lXFuGjNpP/dZGvvmJ0UX0oBaWuKjHGOUeSIZCQkV3m2oM/WjTmBDw+332Yl
         9eHXsylcPIc1YO6HTZVQZxzhOn1WYWiLqi9gIUj7pDZUEhRd0ZySZRqWH2O8m8LVYntP
         D7Gv8sblPXClTb0FScmCIPBdDCHD3Z6ewfguERgXqgcAb8M1GlwkjZWxbYqXAMJEN9qa
         5TCw==
X-Gm-Message-State: AOJu0YzLUUd+tpld9ZYq34V7kJ+KlifZrsHSsOPaexjnK3nYyO+lMlv7
	T9o+vAzizj8Jn26vS/qqe0OK1yMunvKp/MobIGe8XYdmBbK24FemqPlPriU8uXIGu3htlAqL30l
	1QfCp/nwGBYByRDY3uf0TIYdZGkY=
X-Gm-Gg: ASbGncsvUUucbcHkjYGuoHFJsCISO6V/8IfepZgKbSXv55A7+S2qe35sPDf3h/SPWJC
	w7i2el0wY0247j4nsJQmowX6q/VsQ7W8+Gob1RjN/MZ8ZIZqJBvKpUU3uL+9yzq+Idxv8JqKxs+
	sapupJp+eiNyUuOL5iCpE5J/MLQbz+f7ef/qfN7CpwYHXuV4r/IQ9ejcVXu7wX
X-Google-Smtp-Source: AGHT+IGDNX0B6tgwMX8DVZTJGNsRT05uJMJxQENcpm7qxP8YIln3VfFCPhpJ6obV2sYdKWkCONUWEIicrBVhBGJq9ww=
X-Received: by 2002:a05:6122:2207:b0:520:5a87:66eb with SMTP id
 71dfb90a1353d-525a8341f73mr8317894e0c.3.1742828100439; Mon, 24 Mar 2025
 07:55:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Mar 2025 10:54:59 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z9x590KcwP8WGGG-@pks.im>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
 <20250320-245-partially-atomic-ref-updates-v4-6-3dcc1b311dc9@gmail.com> <Z9x590KcwP8WGGG-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 10:54:59 -0400
X-Gm-Features: AQ5f1JoaigtZx0N3HeGHYlK9KukVPwAvF1-YxlwyTjjNqqHedfB4icqVVsBJ73I
Message-ID: <CAOLa=ZQ7nYNMZ2rHBao=vf-HxpWOy6g_jywi0bU5nTf6Tx=F+g@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] refs: implement batch reference update support
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000d4fbcf063117c971"

--000000000000d4fbcf063117c971
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Mar 20, 2025 at 12:44:01PM +0100, Karthik Nayak wrote:
>> diff --git a/refs.c b/refs.c
>> index 3d0b53d56e..b34ec198f5 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1206,11 +1210,45 @@ void ref_transaction_free(struct ref_transaction *transaction)
>>  		free((char *)transaction->updates[i]->old_target);
>>  		free(transaction->updates[i]);
>>  	}
>> +
>> +	if (transaction->rejections)
>> +		free(transaction->rejections->update_indices);
>> +	free(transaction->rejections);
>> +
>>  	string_list_clear(&transaction->refnames, 0);
>>  	free(transaction->updates);
>>  	free(transaction);
>>  }
>>
>> +int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
>> +				       size_t update_idx,
>> +				       enum ref_transaction_error err)
>> +{
>> +	if (update_idx >= transaction->nr)
>> +		BUG("trying to set rejection on invalid update index");
>> +
>> +	if (!(transaction->flags & REF_TRANSACTION_ALLOW_FAILURE))
>> +		return 0;
>> +
>> +	if (!transaction->rejections)
>> +		BUG("transaction not inititalized with failure support");
>> +
>> +	/*
>> +	 * Don't accept generic errors, since these errors are not user
>> +	 * input related.
>> +	 */
>> +	if (err == REF_TRANSACTION_ERROR_GENERIC)
>> +		return 0;
>> +
>> +	transaction->updates[update_idx]->rejection_err = err;
>> +	ALLOC_GROW(transaction->rejections->update_indices,
>> +		   transaction->rejections->nr + 1,
>> +		   transaction->rejections->alloc);
>> +	transaction->rejections->update_indices[transaction->rejections->nr++] = update_idx;
>> +
>> +	return 1;
>> +}
>
> If we had a `struct ref_update_rejection` we could store the update
> index and rejection errors in the same location, which might be a bit
> easier to reason about.
>

I struggled with this a bit, I was thinking the same at the start. But
then I was also thinking that a rejection is specific to an update so it
should lie in `ref_update`, however tracking failed updates in a
transaction is specific to a transaction and should lie in
`ref_transaction`. It probably would be easier code-wise to have them
both in the same place, but it didn't feel like the correct place.

>> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
>> index d90bd815a3..7bf57ca948 100644
>> --- a/refs/packed-backend.c
>> +++ b/refs/packed-backend.c
>> @@ -1327,10 +1327,11 @@ static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
>>   * remain locked when it is done.
>>   */
>>  static enum ref_transaction_error write_with_updates(struct packed_ref_store *refs,
>> -						     struct string_list *updates,
>> +						     struct ref_transaction *transaction,
>>  						     struct strbuf *err)
>>  {
>>  	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
>> +	struct string_list *updates = &transaction->refnames;
>>  	struct ref_iterator *iter = NULL;
>>  	size_t i;
>>  	int ok;
>> @@ -1411,6 +1412,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
>>  						    "reference already exists",
>>  						    update->refname);
>>  					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
>> +
>> +					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
>> +						strbuf_setlen(err, 0);
>
> Nit: you can use `strbuf_reset()` for this and other instances.
>

Yes, indeed, will change!

> Patrick

--000000000000d4fbcf063117c971
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7716ff7fb36b2f86_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1maGNrSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMGJFQy8wYkVpa3BBQ3dUS2ViamIyR29mMlZsYmRFbQo5dWljTkRyZ25R
akZ2bmttTXk1YXJROGFmVkpyeGRrVEFaUzdRcmh6RnZ5ZFR6RUhsdGJoc2NKZFBFb0UySUhJCjFE
NXFIRkYxWWM2bHhjYXRDT3ZDMVdUdnhnK1lSRXlCOHI4M1IxdFljeGtGcWMzUUtlWXEwWGdVZFgz
NDF2Y2YKUENoM1pLdE4rdnJxTW8zbExDS0ZNa3VyS0VZeEtpZDR3MDFFaWhXaVdGVWQwOGU4a0Zi
OVBZSEFSbER3NGdEUApYVy90SnZXN3NXSWpzaVJhdzVvMnRZanJOZXg2UEZqdWd0TTNQSms2VUN3
VEpZazQwc3FlQjFVTnl0UVRMMkF2CnVkSC9pZGtWY2J3WTRiZHFXTythbFJ0UzVNeEZ6WEtMYjMr
anUzTWJvQi90TE9EY1F1TlgwVGs0S2FYTUpPUnAKek1qYmNxRVlTc2cwZ1JZRWpwZU42NENuSStS
NEN4aUI0aW5jdm02djZiVmM0b3VHejQxV0xCV0VXTzVqZzBlTAppWmF3MEFiNEdrZWd1MWZDY09t
OThVUnM3YTNqalVyODBEelMyWVJjNjRJeHhmQUZSbEpramJxV0sweFhXMmhCCjg1bVordVZjZUZ1
UGlPQ0lxUHJrMHRhZ1BmUS9hZ1dxNFFNcUZJTT0KPVRvanEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d4fbcf063117c971--
