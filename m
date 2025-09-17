Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBD2F5A0F
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094408; cv=none; b=AxTeYhnMqb7yWlPPGVlKjT/2TsMf/tMJ19/mOtEq5IJDo+sCNeNCMJ8x8S/4b+y1oEad54b4rcyxgLHQpiddIV2UQFd3lo9Yq/i+V/mTKiElxxkp842zozzVgX8D3rOGkGQEdxt6BSGH+aurS54ywXh3466nv/XvYz4agPaOrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094408; c=relaxed/simple;
	bh=2RddsDlCNXU1bADydOBxt1SyGhj/IvnvaHHn65MXCxI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJ44/fcwu6WRXnCejrQchsZUDzCfO8jKH5o/Ut7Wi33aJD8MS1OXXqv8vXZxqCHFgkSpxOhuKNeYq/rxvS1PANmpm+9g2Fr9SeKYQk6CTtDbNfzhXfut9/VMpH4WUjWBKRLFvQ7Ej42GR+9iwtctNiCkIBdNAbQShJJ3Np1r9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxSUfwK0; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxSUfwK0"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5357f3e2520so4779870137.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 00:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758094405; x=1758699205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eAbw/NvCfWgdkhzpQACU7w9fq6kfiQqSq74Fr8kmdFM=;
        b=MxSUfwK0lvVoI/Zh5ejBu6sco4zzxsCM1E3g4b0UkFAAbr/Hs3xhX3jS3QUIPBxBvg
         lJOMYLEHTshTQwiItbCzv1pTngwN14D19S6bFI2Cj5Glg4o9233NM9iYLub7AqHiIqbz
         OssOAervDaSAp1DHA59m/9cFhr0Nkxe9oL+lKhW5SgyYXhmUl4Z+2sUV4dgcv+6xTy4Q
         y80twYTH6IK8SNcHkkQpfEtCdnC0DKfqfLwVF5O6bvruAABd8X37VOmuQNfZJIvHY/2Y
         aXDqMV2UoHmiaw9Q2h1Z1RhRPMOQmhnVHZyCj9h/07/kmkrjYwcn7xXWLfTKr6C5cIn9
         +MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094405; x=1758699205;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAbw/NvCfWgdkhzpQACU7w9fq6kfiQqSq74Fr8kmdFM=;
        b=gbA+3n9mRliw3b+ufmkgaDYgfbynTqgmjsHfHh8j2ImUZkS7qn35lnb+MDGPdlvgK5
         WRMrGzvnj4uZebGr0d65R3p+Dz9zNkFGdFcf+5qox8teJYjGZyJK9OXsD07qCvgQ02Fq
         NXYQxoWkT95MlKp3YABNCPgGSeszQjGUaGP2aIqwxkATlDKy/iW5IJ9gyY79Ve1i4A3u
         K2+sPsqQZYd07Z8cBC2uBs0v/RyKXCdEUCfe0GJ0nc4MX2zL7k2cZXKiTt5nvT8pYrUl
         CbnLpuR7T7VWSb9ndwIneHjcov5Y6ghyiaGFgvYmCLs3pqaA449FH8dJybktb8ZTFoWZ
         ZCmQ==
X-Gm-Message-State: AOJu0YxRSXD9ychxAJ3eTcY1CSL76CygMTL7A8XDSBO8rftt88qsSRk7
	K+0L8P9O2hwgBRhWL4alMdLN6aUoG3PPx6gwLm8Ge37aoOQcti9QzkUbJTjNzloe+TZBuOXA6L1
	RvmXWEy6lNw6q/eLKF5Dkq6KuIR0ldOQ=
X-Gm-Gg: ASbGncsDEF6jAKkfJ52IPykcsu+097/ZfsG0Sl2zWz7H5ATRBk5T9obXRCNO37Z0SGP
	ClvwK89C9YZRrvM8wgv1Zf09KuYb5NwZh7+xR9pjFZvNDbktpuR//zh1l0fEr2kh7EKFfiVvLiL
	enTkfY4XcbS3TlNjcLA+xBTz8xLatK/ZCQ6lUI4Mgmbgxc1ufnQgjX6iXKJVRL+9lJganteTznu
	6BKU1xYkCgE2EZhByAXiKIxKVsqby9avzKdfQWB
X-Google-Smtp-Source: AGHT+IF3X+bhX+e2wwFvUfuWqh3Zt+s9wihKpktB6OG1lcJ+0x1FRt9kFyaZtEn6p21Ma2cd8neJEL6KfvxYekdzs8E=
X-Received: by 2002:a05:6102:4b17:b0:523:759e:b0bf with SMTP id
 ada2fe7eead31-56d64f520acmr365332137.20.1758094405268; Wed, 17 Sep 2025
 00:33:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 00:33:24 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 00:33:24 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <uv4ifkvxcujjjj3lsc4tf5b5dnc7pkaaw62t6ahagnskxn4kg6@oyxjgupdilrc>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-1-195569740b57@gmail.com>
 <uv4ifkvxcujjjj3lsc4tf5b5dnc7pkaaw62t6ahagnskxn4kg6@oyxjgupdilrc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Sep 2025 00:33:24 -0700
X-Gm-Features: AS18NWCmwBe_rwPyPjR8MqMwC7DUfkpR9jCdr8kKebXSnsM6A4bZrhw3ecKbAsk
Message-ID: <CAOLa=ZR1LNs0i5TDPFG_QvUYS3=CMx3ov-68ph6QKNM273JUHQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] refs/files: catch conflicts on case-insensitive file-systems
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, ps@pks.im, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000821b20063efa40d3"

--000000000000821b20063efa40d3
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 25/09/13 10:54PM, Karthik Nayak wrote:
>> During the 'prepare' phase of reference transaction in the files
>
> s/reference/a reference/
>

I thought 'phase of reference transaction' without an 'a' is an accepted
form.. I'll add this locally for now.

>> backend, we create the lock files for references to be created. When
>> using batched updates on case-insensitive filesystems, the entire
>> batched updates would be aborted if there are conflicting names such as:
>>
>>   refs/heads/Foo
>>   refs/heads/foo
>
> Ok so this is only a problem now because the reference updates are
> performed in a single transaction and the resulting error causes the
> entire transaction to be aborted.
>

Yup, exactly. So conflicting references within the same transaction
become an issue since they try to lock the same file.

>> This affects all commands which were migrated to use batched updates in
>> Git 2.51, including 'git-fetch(1)' and 'git-receive-pack(1)'. Before
>> that, reference updates would be applied serially with one transaction
>> used per update. When users fetched multiple references on
>> case-insensitive systems, subsequent references would simply overwrite
>> any earlier references. So when fetching:
>>
>>   refs/heads/foo: 5f34ec0bfeac225b1c854340257a65b106f70ea6
>>   refs/heads/Foo: ec3053b0977e83d9b67fc32c4527a117953994f3
>>   refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56
>>
>> The user would simply end up with:
>>
>>   refs/heads/foo: ec3053b0977e83d9b67fc32c4527a117953994f3
>>   refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56
>
> Makes sense.
>
>> This is buggy behavior since the user is never informed about the
>> overrides performed and missing references. Nevertheless, the user is
>> left with a working repository with a subset of the references. Since
>> Git 2.51, in such situations fetches would simply fail without updating
>> any references. Which is also buggy behavior and worse off since the
>> user is left without any references.
>>
>> The error is triggered in `lock_raw_ref()` where the files backend
>> attempts to create a lock file. When a lock file already exists the
>> function returns a 'REF_TRANSACTION_ERROR_GENERIC'. When this happens,
>> the entire batched updates, not individual operation, is aborted as if
>> it were in a transaction.
>>
>> Change this to return 'REF_TRANSACTION_ERROR_CASE_CONFLICT' instead to
>> aid the batched update mechanism to simply reject such errors.
>
> So does this mean that we return `REF_TRANSACTION_ERROR_CASE_CONFLICT`
> in all cases where a a lockfile already exists for a reference? Or do we
> only actually care about scenarios where the lockfile already exists
> specific to case-insensitive filesystems?
>

This patch specifically only returns when there is a conflict in
case-insensitive systems.

>> The
>> change only affects batched updates since batched updates will reject
>> individual updates with non-generic errors. So specifically this would
>> only affect:
>>
>>     1. git fetch
>>     2. git receive-pack
>>     3. git update-ref --batch-updates
>
> Just to clarify, is this saying that this new error is not ignored in a
> standard reference transaction? Only the above operations?
>

Yes, only batched updates care about error types. Regular transactions
treat all errors the same.

>> This bubbles the error type up to `files_transaction_prepare()` which
>> tries to lock each reference update. So if the locking fails, we check
>> if the rejection type can be ignored, which is done by calling
>> `ref_transaction_maybe_set_rejected()`.
>>
>> As the error type is now 'REF_TRANSACTION_ERROR_CASE_CONFLICT',
>> the specific reference update would simply be rejected, while other
>> updates in the transaction would continue to be applied. This allows
>> partial application of references in case-insensitive filesystems when
>> fetching colliding references.
>>
>> While the earlier implementation allowed the last reference to be
>> applied overriding the initial references, this change would allow the
>> first reference to be applied while rejecting consequent collisions.
>> This should be an okay compromise since with the files backend, there is
>> no scenario possible where we would retain all colliding references.
>>
>> Let's also be more pro-active and notify users on case-insensitive
>
> s/pro-active/proactive/
>

Will change.

>> @@ -1657,11 +1658,25 @@ static void ref_transaction_rejection_handler(const char *refname,
>>  {
>>  	struct ref_rejection_data *data = cb_data;
>>
>> -	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
>> +	if (err == REF_TRANSACTION_ERROR_CASE_CONFLICT && ignore_case &&
>> +	    !data->case_sensitive_msg_shown) {
>> +		error(_("You're on a case-insensitive filesystem, and the remote you are\n"
>> +			"trying to fetch from has references that only differ in casing. It\n"
>> +			"is impossible to store such references with the 'files' backend. You\n"
>> +			"can either accept this as-is, in which case you won't be able to\n"
>> +			"store all remote references on disk. Or you can alternatively\n"
>> +			"migrate your repository to use the 'reftable' backend with the\n"
>> +			"following command:\n\n    git refs migrate --ref-format=reftable\n\n"
>> +			"Please keep in mind that not all implementations of Git support this\n"
>> +			"new format yet. So if you use tools other than Git to access this\n"
>> +			"repository it may not be an option to migrate to reftables.\n"));
>
> Nice error message.
>

All thanks to Patrick!

>> +
>>  /*
>>   * Lock refname, without following symrefs, and set *lock_p to point
>>   * at a newly-allocated lock object. Fill in lock->old_oid, referent,
>> @@ -677,16 +697,17 @@ static void unlock_ref(struct ref_lock *lock)
>>   * - Generate informative error messages in the case of failure
>>   */
>>  static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>> -					       struct ref_update *update,
>> +					       struct ref_transaction *transaction,
>>  					       size_t update_idx,
>>  					       int mustexist,
>>  					       struct string_list *refnames_to_check,
>> -					       const struct string_list *extras,
>>  					       struct ref_lock **lock_p,
>>  					       struct strbuf *referent,
>>  					       struct strbuf *err)
>>  {
>>  	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
>> +	struct ref_update *update = transaction->updates[update_idx];
>> +	const struct string_list *extras = &transaction->refnames;
>>  	const char *refname = update->refname;
>>  	unsigned int *type = &update->type;
>>  	struct ref_lock *lock;
>> @@ -776,6 +797,9 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>>  			goto retry;
>>  		} else {
>>  			unable_to_lock_message(ref_file.buf, myerr, err);
>
> huh, so if if we have a lockfile error due to a case-insensitve
> filesystem, does this mean we print the error message from
> `unable_to_lock_message()` and the new message?
>
> If so, I wonder if we would be better off skipping the former since it
> could be a bit misleading.
>

I would say both are necessary. The errors added here are more technical
and really talk about why we faced an issue. The error in
'builtin/fetch.c' is more about guidance to how to overcome that issue.

Also this error is client agnostic, so we'd add the error here for users
of both regular transactions and batched updates. The error in
'builtin/fetch.c' is very specific to users of 'git-fetch(1)'. So I
think both hold value.

>> +			if (myerr == EEXIST && ignore_case &&
>> +			    transaction_has_case_conflicting_update(transaction, update))
>> +				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
>>  			goto error_return;
>>  		}
>>  	}
>
> -Justin

--000000000000821b20063efa40d3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7404a4ea0e2517cb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qS1pFTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzlIQy85UW1uWXEyejB5UDBFNFZIWlo2ZUZCaW8rOQo5eFFodmpieU5K
Z1Yxc0dhSEh4SlhXRnFFcXN6Ry9tRzFnemE2eHpaZ0IzZzN2VUR0ekIyUS9sZERnNkhPNUlICjFI
Y1Q0ZHY4UHZvS3BzMEpzczBwY2dPU0lKbExCVU94UEtZaTJkOWFwVlJ1RFZseFpWeGJIam1wY2Rv
ZXJuVVkKblRINHlZMkV1eUNyTUhkV0UzWE84UVF6U2IvQnpkSkJ1d0p5TGx5RGlqYkwvbE91YTFD
cEJqcU5UcElFNXd2bQo3OXRwMVovNE81M1VnU1lKR2l2YjkxL2YyKzVXV1gya1hEQ3gvckM1aWxE
VTl4dXVHUkFSZW45czIyQWVDNHdnCjJQVlZybHNsbklZSHlUTnNNYVZ5MFMya2hKbWRSVWdRTDdx
N2hUTWR2bVlLZDBROStHaHZsUDl1YkRyZmt0cXgKVmdZRVYxa1U3L0kwc1BoL0wrYkRLenpqQThG
Z2lxYXRTay9IZ0NMblFoTG1QK25qODNNMmtZVnRVbzBqWE9FegpZZWQyVG14ZFliQXg2U2NWd2FT
OG9BU1dteFhrdm9uaVdFc1o0cGFndmZuWExoN0h0c0FCVkZzVTV2UCtnd0IwCnJYWlZuVCtCcW9C
ZzAxRnpLNTB3MmFNbkZ4QmRPcFRObHpQc0NCbz0KPW9tUTQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000821b20063efa40d3--
