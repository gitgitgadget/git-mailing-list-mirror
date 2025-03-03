Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF7225390
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032772; cv=none; b=aCbwnhMtmn7R/7L+IJteZ5KfYFNNodDCw7E6fSHbeMOg6ZkPD1/8CoD3ZADsKVkLB6QVlBdW2J5QIaacmGPlMesVIKV70Pufz3ciRn4FyXSkBB6MQIpVp+s6F+oRDbPLRqdACe74qDdDUkkS2y6nja5S5VKaW0c7MH5L3hZkiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032772; c=relaxed/simple;
	bh=NZmRTrf8AiHgXRiUO54tBqkGmzaj4vfNIho7h4pmmE0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSS3kJnL67iK7F1NrbM2QZcA6yerDanRBvv+2Ll+esXNd4pP8N6w3X08eXsF2/LDEp40xL9qRmF3iaIsfLSP5bYprQK6IbqFvEN70tBvqAZ+FjxbR1mmcp7dNYc57zGfckY76R0q9LkbtEQ7bQqxlCuidODGTOw3ljz/hN0w61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ4TLZPi; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ4TLZPi"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-523a00c9d96so438703e0c.3
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 12:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741032770; x=1741637570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vW7L2Wa2/o/hSsiIuQrI54W3/Hxq3c14bwR2SwhZ7Aw=;
        b=UZ4TLZPiHG+UucDBpSQVlfAYkcvP8brKDyANFyI+p5OwVVHnFpAHZiKA2I4ALFecNe
         kSs5THpoPD4K9Ztn83fw5fpYmbm5uUpjBhsa6rhsH1FGZimM0+OrvJSBcr3+DvxWjHQM
         v1Fug79HxH8eH132AOW32XJ3FhTAbokNB6ip7kMHLW1HXT2GPA+xKKVm764wpo4Kp7xN
         Dc9g5ONAkFT7LzBHPlKLzvn4vCZuwj7pKplAQcMn9SH4WA8E+j/gVU9j75VysjafFe7L
         xjJonEnqcW18W6W3L7QAUw5pz3B5ClVAo/5FlPXW5ePvUHkgaf5jT8/h/eJnGx54Cz+G
         KbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741032770; x=1741637570;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vW7L2Wa2/o/hSsiIuQrI54W3/Hxq3c14bwR2SwhZ7Aw=;
        b=XfiyqHbgRokeMEq/O8YixpyUMhQhKvfRqDAxU8uc/D1ikMU6d8/irxLZVJInQvyjoO
         qEN+soxnx6+0Fp9Xiucz23PwY+FFJo+U1BYWIc4R2WaffK5uAg653QqFngdhfEI8qZQl
         xkSn2HfDHirXVnEsG4o41xRgCidrgs1lVZy3FHf/zgm+gYMfhE6s8a1LrSGNjUAC0TPQ
         ir/XJIrLkOz/dvZRL0ZAWVPqKh9wXpq6kyTkmbM52lPmG33fjmw3P/Q1750eyWaOXanZ
         CQKufJUr/SnntL03uUEU62xuKnSQGAKrI0UK+JvR/FEjpTlvLgeOuFtmqxOzuPelaA+v
         hC9Q==
X-Gm-Message-State: AOJu0YxtLX5Nf2pZREgA7qGWWgSlHdTtgNlhJ7S1w8D0x/mofxyuyTLH
	EfrqfsTGWf3y5mymDBNNN2kMIPS9wpH6wW9HnbuLC3ra5N7kWNQ9JqasLGHP7KYDmxZ7hGbRZli
	H435W+19EHSYZWtD4NP7UG5MHBx4eWF6q
X-Gm-Gg: ASbGncsRG//nCsjwiqDrdGibWgGvvjdAhpvUH5SvMdWrQ4adNrhrlTSY5xR/myayImt
	Rrieue1VyBU0J4nSoHl5g9WMcuj2PX+h1DAm3Sv91PEWVziR2hO3laOxj55EGCX2mVma9NmKBBh
	C7374k9CQgNhSY6XnCvX/3FfZ1v8iC7lFgJXssnz4ApEkGbmg3w4quWTA25QA=
X-Google-Smtp-Source: AGHT+IGOxyeruSoOdN4bBWvfL7R/+3wfJ8nvzt3tKgLKvgDzbSoEWDOD80Ow3olzor3DUfZcKKKSV4TE5spcO+BYr4s=
X-Received: by 2002:a05:6122:3a11:b0:516:230b:eec with SMTP id
 71dfb90a1353d-5235b76fb2dmr9095087e0c.5.1741032769725; Mon, 03 Mar 2025
 12:12:49 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Mar 2025 12:12:47 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z72kmFUARRSukMBe@pks.im>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
 <20250225-245-partially-atomic-ref-updates-v2-5-cfa3236895d7@gmail.com> <Z72kmFUARRSukMBe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Mar 2025 12:12:47 -0800
X-Gm-Features: AQ5f1JrbdJSlvfNRwa6sCDVDFrU410sBtpedYIcyWOw3driS1l7xoI1hu5vo1Sg
Message-ID: <CAOLa=ZRVHUspvZ9PJiNbj+rqrHSGg-EamLN3AkVX0XuJkL3OHQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] refs: introduce enum-based transaction error types
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000c845eb062f75c70e"

--000000000000c845eb062f75c70e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Feb 25, 2025 at 10:29:08AM +0100, Karthik Nayak wrote:
>> diff --git a/refs.h b/refs.h
>> index b14ba1f9ff..8e9ead174c 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -16,6 +16,31 @@ struct worktree;
>>  enum ref_storage_format ref_storage_format_by_name(const char *name);
>>  const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format);
>>
>> +/*
>> + * enum transaction_error represents the following return codes:
>> + * TRANSACTION_OK: success code.
>> + * TRANSACTION_GENERIC_ERROR error_code: default error code.
>> + * TRANSACTION_NAME_CONFLICT error_code: ref name conflict like A vs A/B.
>> + * TRANSACTION_CREATE_EXISTS error_code: ref to be created already exists.
>> + * TRANSACTION_NONEXISTENT_REF error_code: ref expected but doesn't exist.
>> + * TRANSACTION_INCORRECT_OLD_VALUE error_code: provided old_oid or old_target of
>> + * reference doesn't match actual.
>> + * TRANSACTION_INVALID_NEW_VALUE error_code: provided new_oid or new_target is
>> + * invalid.
>> + * TRANSACTION_EXPECTED_SYMREF error_code: expected ref to be symref, but is a
>> + * regular ref.
>> + */
>> +enum transaction_error {
>> +	TRANSACTION_OK = 0,
>> +	TRANSACTION_GENERIC_ERROR = -1,
>> +	TRANSACTION_NAME_CONFLICT = -2,
>> +	TRANSACTION_CREATE_EXISTS = -3,
>> +	TRANSACTION_NONEXISTENT_REF = -4,
>> +	TRANSACTION_INCORRECT_OLD_VALUE = -5,
>> +	TRANSACTION_INVALID_NEW_VALUE = -6,
>> +	TRANSACTION_EXPECTED_SYMREF = -7,
>> +};
>
> Nit: how about we name this `ref_transaction_error` and adapt the the
> enum values accordingly? We may eventually also introduce similar errors
> for the object database, so it may make sense to have the errors be
> specific. Doing both the enum and changing the name might be a bit hard
> to review, so we could also rename in a preparatory commit. Or we just
> punt on it for now and do it once it becomes necessary, that would also
> be fine with me.
>

I'm happy to rename it, should be easier now. We can always change later
if needed.

> I also wonder whether we really want to introduce `TRANSACTION_OK`. It's
> always a bit of a mouthful, and in many cases one ends up with a mixture
> of `ret < 0`, `ret != TRANSACTION_OK` and `ret != 0`, which may lead to
> confusion. Continuing to use `0` for the successful case should be fine.
>

Fair enough, let me remove it!

>> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
>> index 3247871574..75e1ebf67d 100644
>> --- a/refs/packed-backend.c
>> +++ b/refs/packed-backend.c
>> @@ -1672,7 +1676,8 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
>>  		data->own_lock = 1;
>>  	}
>>
>> -	if (write_with_updates(refs, &transaction->refnames, err))
>> +	ret = write_with_updates(refs, &transaction->refnames, err);
>> +	if (ret)
>>  		goto failure;
>>
>>  	transaction->state = REF_TRANSACTION_PREPARED;
>
> Do we also want to change the local variable declaration of `int ret` to
> use the new type?
>

Yes! Good catch.

>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index 2c1e2995de..e1fd9c2de2 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -1255,11 +1255,12 @@ static int prepare_single_update(struct reftable_ref_store *refs,
>>  					   "but is a regular ref"),
>>  				    ref_update_original_update_refname(u),
>>  				    u->old_target);
>> -			return -1;
>> +			return TRANSACTION_EXPECTED_SYMREF;
>>  		}
>>
>> -		if (ref_update_check_old_target(referent->buf, u, err)) {
>> -			return -1;
>> +		ret = ref_update_check_old_target(referent->buf, u, err);
>> +		if (ret) {
>> +			return ret;
>>  		}
>>  	} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
>>  		if (is_null_oid(&u->old_oid)) {
>
> Nit: superfluous braces that we could remove while at it.
>

Indeed, will fix.

> Patrick

--000000000000c845eb062f75c70e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1fce57fd8d2f1c40_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mR0RUMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOWFEQy85ai90d1JHeUVPUlVVd0txV0RBWm5WQzZSZgphSjBSVVgxWTNY
bUg0ZEY1RFhEVkp5OVFoZW5ZeDRpcjlCdEJuUVJNY0FnaTU4eGtEUU83UVVBUXk3bE5leHpBCnk4
QjRtVG5SV3p1dUcxSzhPcVpmUjFKczZLNHhVWkpUdkVMRmMwY2tFVDVIRjdjVndvencvemxyd05q
QnBjcHgKRXV1Tkk4TytXT0pobFFhSlNTakhCS3NaLzRFZDBCNC9lei82Q3dHSDRtb2FYSWFrd1J2
WFFMaHQ2QlBKQjBmcApSb0crQ0oxcTIzQVVMem5PeXZ5UHkzZHR5bUVGRTdOR0pNNkVWSU1XUjVz
MU5INVpObTlkWXdwOW9qd0s5bFByCmJHSVBHbmtTSEdVWWxxbjBqVmpKNy9sMHNUVTVDRFVZMGNU
WVlQNnRFWDF1U1RlVHRIanJQMWVIRDZIVjRhTUsKSmcxbWpXRTdpek4vNER1NlovZk9wLzRyY0dP
dHR1Y2R1RW1ncTZNU0swZ2NwaEdmaFE4bUN5REZFZVZVbUdIMQpkMVJwTUJVVUs2ZzQyMWw5WGlH
VC9qeTdYNFJ0d3M0RXhoTFhsUUFKMlVTMVc2TzU1aVV0WlRITWRzalNJWlRwCmxtdWpxNzBTWHBi
THZ6ckpMa2xqMWtydlhLeURmNzg3amVRZlFEaz0KPUtCb1UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c845eb062f75c70e--
