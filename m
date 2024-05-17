Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3D50297
	for <git@vger.kernel.org>; Fri, 17 May 2024 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951325; cv=none; b=JgasfxGXAQ7ALSAztuNyTCmLZzpH2gka/8MeAoUmcGL9ojSyADpqZAdGRO/GCETTHz/hXzQF2HII0Wue+K/Rw7OqkzTQyEvMxAU2kD6ek1ExNUGqVZmx0WhZW3WZXXXi3X/mKNeXq+xBol02+9h0MHekJ/tp5A7ZJbV5gehy9Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951325; c=relaxed/simple;
	bh=+7oK952aGaEXPThQyqfeFqE0fdFa/AMSQeXWF/GtTAs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+FqK37qO9j/ggcGB2nyjPXbCHzcar50L341hShJlnpjPyD4tvfTmq8c9zz7O3xQLY2s+2XFAiHojKtHuh57V/xGIWQgOPpm0Y17WdGHwz22QK92HLViCXt/F+y5UhOJWNtRjU7crG69muo0/jlRYqCwDIBz1urF/izh9AXa4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpK9KfGD; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpK9KfGD"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23e78ef3de7so632478fac.1
        for <git@vger.kernel.org>; Fri, 17 May 2024 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715951323; x=1716556123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c3nObcgur+VIm6CxwK9qTC2QuU9UcCgroiHZig0f2V4=;
        b=JpK9KfGDLyupjxFo+cumYj0AJhEwfwAP58NgYLMLX81CIqMHnMwIfgUZI4qtZuQJHe
         UiKGw7SaH3xlIUWmkwkSvEZ/YV+X6So3stV2cW38m97zO3zbBlVTKQDNRJOggzEQ+pDA
         bJO6UUeic/He7mRY7L+38Ex2TirGfpECQWFNFmmLJ7jYNEoEljZzaNvdQZnMxn/5XdNl
         Pht/5hEVGiOkk+nWedKigcwdDn/tVTJEY1qUlYx2p6dJch05Xud/typ1TunTrOvil+vj
         oZil6x06CdVjXw25baWLFCq2jTCHFLucXZNzj4xyVPnwx8dqxAN8VZOvohaYlypHiM7S
         Dixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715951323; x=1716556123;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3nObcgur+VIm6CxwK9qTC2QuU9UcCgroiHZig0f2V4=;
        b=BkAe5LyR6qsgsIo1xjz+i1kpDHKPPQb75sOFhS6sqYF+A6Hxvfd2lmVjm/pr91TuQ0
         XwDNECZ9VY+V5nLCkb0Sg/HBC6MtKNF0SKUROkBgX0n56tin45fTF2TPhff6P3d0sjzT
         NGpo0rglJgqPcP7A0s3QnD2I/AJUv+wjkJjfNw0ntWLHNRBFAYsKwumO+vlLlhdupaEi
         Om3/dW2li3reYO3XXCJYS2PDtGbDhJW9p94Uztybs1Zl2zmmN+udvALMNRuqrHK7bSy4
         49DBry+HdDAApq9PNfLOAP3lWcQnr+PRAN/1w+WJ3CpJXNSXlEc29vB7CxVzqgrIH1mb
         IZ7Q==
X-Gm-Message-State: AOJu0YxXzi9zSUwIhbp77641SoYs2YKIj+DBjE5Xgq5Wm9MTW3a9rWNu
	FBSClOKETZrdcmAt8J3QqcnZNQn0A3awGG+a0mKCw1KDPp7btEARJYpkNc6JUS7bCsnsnnyBgSZ
	dmBTZHdzDDcqnfB+3MGEoPRo3u5khew==
X-Google-Smtp-Source: AGHT+IGdjvK1i6mJSbyxu8DJCxWkuBbLnPmn729+H5Eyu4aJEWhH2zNKOZy8BtRwXil6OWUj74glhRjFt50z6q95l/8=
X-Received: by 2002:a05:6870:4209:b0:22e:bcfd:debc with SMTP id
 586e51a60fabf-24172a90478mr32304674fac.13.1715951322758; Fri, 17 May 2024
 06:08:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 May 2024 13:08:41 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZkXpW0BPvR3vr2jx@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com> <20240514124411.1037019-2-knayak@gitlab.com>
 <ZkXpW0BPvR3vr2jx@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 May 2024 13:08:41 +0000
Message-ID: <CAOLa=ZQz=adrazym_bPehDMGOLN1Lt-7QOcd_LgZb5K+trg=EA@mail.gmail.com>
Subject: Re: [PATCH 1/6] refs: create and use `ref_update_ref_must_exist()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000000b99580618a60d23"

--0000000000000b99580618a60d23
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, May 14, 2024 at 02:44:06PM +0200, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The files and reftable backend, need to check if a ref must exist, so
>> that the required validation can be done. A ref must exist only when the
>> `old_oid` value of the update has been explicitly set and it is not the
>> `null_oid` value.
>>
>> Since we also support symrefs now, we need to ensure that even when
>> `old_target` is set a ref must exist. While this was missed when we
>> added symref support in transactions, there are no active users of this
>> path. As we introduce the 'symref-verify' command in the upcoming
>> commits, it is important to fix this.
>>
>> So let's export this to a function called `ref_update_ref_must_exist()`
>> and expose it internally via 'refs-internal.h'.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs.c                  | 6 ++++++
>>  refs/files-backend.c    | 3 +--
>>  refs/refs-internal.h    | 6 ++++++
>>  refs/reftable-backend.c | 2 +-
>>  4 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index fa5471d219..59858fafdb 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2863,3 +2863,9 @@ int ref_update_check_old_target(const char *referent, struct ref_update *update,
>>  			    referent, update->old_target);
>>  	return -1;
>>  }
>> +
>> +int ref_update_ref_must_exist(struct ref_update *update)
>> +{
>> +	return (update->flags & REF_HAVE_OLD) &&
>> +		(!is_null_oid(&update->old_oid) || update->old_target);
>> +}
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 3957bfa579..2df204f891 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2411,8 +2411,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>>  			       struct strbuf *err)
>>  {
>>  	struct strbuf referent = STRBUF_INIT;
>> -	int mustexist = (update->flags & REF_HAVE_OLD) &&
>> -		!is_null_oid(&update->old_oid);
>> +	int mustexist = ref_update_ref_must_exist(update);
>
> Okay. So we didn't notice this was broken because even though we started
> writing symrefs via transactions now, none of the calles ever assert
> that the old ref exists?
>

Yup, that's correct. The `git-symbolic-ref(1)` command doesn't ever
check for the old value and it is the only user of transactional symrefs
at this point.

>>  	int ret = 0;
>>  	struct ref_lock *lock;
>>
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index 53a6c5d842..5da3029e6c 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -765,4 +765,10 @@ int ref_update_has_null_new_value(struct ref_update *update);
>>  int ref_update_check_old_target(const char *referent, struct ref_update *update,
>>  				struct strbuf *err);
>>
>> +/*
>> + * Check if the ref must exist, this means that the old_oid or
>> + * old_target is non NULL.
>> + */
>> +int ref_update_ref_must_exist(struct ref_update *update);
>
> Seeing `ref_update_ref_must_exist()` as a standalone function wouldn't
> quite tell me what it really does. It sounds a bit like this would
> already assert the ref exists at the time of calling it.
>
> We could call this `ref_upate_expects_existing_old_ref()`, which might
> clarify the intent a bit.
>
> Patrick

Yeah, that's better, will change. Thanks.

--0000000000000b99580618a60d23
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 545725016c4a8d0a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aSFZ0Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmwrQy80OWlBVkt0SWNnSE1NOXZIekJ2RUNaeEZiMwo2ODlGMksvTWxt
MXdHbXYwY3FnWStJNUhSRUYrNUZZcSt4ekRuaUdvSk1IQks4UGJOZFVBMUFkNVI1RTRaeExsCkhp
ZWlENmNCaHQ5Y0hHK3hsMXp1dTFHb2J1UFdmMUxIYXp2OVpXM0JVYkRlYlNBMDEyU1NqWENncW0y
SFI5WTgKeS94RjBQdUwyaWFLZFJuQXY2eDliNVFTYitYNkNUQmFUTGtHQTNReGJtaCtlS3kxdFpD
anc3dmtHRTRHSzYxaApBZmJYYVNRUWtzWWM1WDhCYWVmZGdxUVJqejBGNVlUU3NDRDc3WFoyOXo0
c2hOWkZMYkZDT0NhaWtLYk9qckdFClFHSEdGc0E2QnNMUkZKY0pJYWJGbGROU05CNWNvbXh4MWxC
K0JzZ1RaNnNDYmpKSkpwTjRyN3E4Z0xOdTlEY2EKaVdQTVBGZUlTd2VkU0xUbzh5bUlLTFc4TjdG
Ui8xOFRGVHFsK25iWG5tdWkxRDZKOWhqWWlEMmsvSHU4eEtUbgpNNUxsY2dWRmtRTXpKT3Uvay9F
RGRNNngyeHVUR3ZKU2pxNEdwQ1lYTWRhQ1dLRTlFUFdTQStxYlpFaHJjanhKCmQ1N1ZmL0lFWG9p
OU5IbFAvSUFSWnBPVXVnRkJ5Vk9JYWVsSUlGOD0KPUxNZmMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000b99580618a60d23--
