Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383B20DD67
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737627691; cv=none; b=VTboE5Z+6xU8JESQfvgp9g84AxDY/myrbhqfKGW+83A8Y0RTyWoGCxivGdE5cOWsxZOwxkAxxXzpSnh7eFF4ALqVzrWlaDL659mLFbmxVyAbxxLQW0Z3o4vcPEluFJwSwv0aEOb5LJ9EwpySQNrRJNfj7Mf/NvzwaBIrwyk5aog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737627691; c=relaxed/simple;
	bh=LoSRL8w88+FdZZ7T8xphoFjUvgqdf0n/RN19Z5vjkVA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mn1L5T6FPJWrHXLps/Otvz9durKIclpYfaaBGNd7HZ+l1dlOtbwiq3iogWMgrPHJL5PO99axptv4ekLrfZ5es9d4TnRIFw8nOrM7ld1VntQgliJ6LxLiG8CyvC/YONGTcNE4spq2OO6LaeplRj7h0cBdPu73ZWv0hKB5tQLtZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CljMgXSZ; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CljMgXSZ"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4b11a110e4eso209248137.1
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 02:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737627688; x=1738232488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nIrDOTi9YA4i5Usrjn4jQPHeGvweoabPYzi+qavueEE=;
        b=CljMgXSZhMCSGTK12K+GwZ3c1IKTIkj5x8XjvcYeNp5lP1Jtm9NMARHF1pTom2cgn2
         mmKiXLEwzdtEdL304k6sHgYK1kGa8yqeIGL76W7mYDJ3aMsr19uVFy1iip3q7pitZgSU
         lvEv9hPI+pZlOtVAhDRmCO7HqElf1C3fvdazKzY4Wuu2R2c7x7SA6HeXmdyQs2MiZT2L
         Xi6D1fSytufcsiRvTtlqwcyR4fxoKI0b/3ZwpgZaSyp9O0VufbJUPTDjT7qlqOU5Jzx8
         jVwCHUmPVgXyqOQE3vIR3BGm9zeKkz8o9qOOg4qbJW1fT/pOokc0yHp2HV65FKdJcUmX
         Q1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737627688; x=1738232488;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIrDOTi9YA4i5Usrjn4jQPHeGvweoabPYzi+qavueEE=;
        b=s782E2WZClPHHH9G8w8nbae4fTwoSCM3KX/h84HdZYjRawtKSnRgLlM1rKzDtn0Naz
         CLijE5/Bmiu+0wx73kod4ivoODR4PE8t4v4KGn8sUunMT2JvYbc7N8Cjk75c2mGN8OBW
         TtKPkRd3Sil+nm7oy50bKImGwqmZr6aySghK0uaXIfpn7MeBctdeMgJI54gJdo6FovgR
         r3MyXRKSQjjP4mGXIGS4ZbP5b+OXf0kuend/y/dPSYyPFhS5x4aSuZ2pgh7OIDBGtCrm
         GoRPBn5JjUZ43/OiDIjTGrfbNo0Uk5WDev8Rk7CNpUEAA/ym9zARwNk9a9mDkh1qNaI3
         6Yqg==
X-Forwarded-Encrypted: i=1; AJvYcCW8odAL4dABuaGojaWhiZsuJxngRGnrC+DtkBMUiqlqghgC001hgjCNdKcNEIsywSsIu20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLzwEDwys/DeXeBziSAuyo/NvcMV5vYHYq9HJMbMkcWTx8/5AU
	hT1kNyK12IPKvoG9MVkaQBMdhOcU84Swz/w8var40aop5pDblUeTdRLOuMQ3wPG14teFUiSnp47
	i0tgxG/R3PGah7Z0HIFp3MV7B3qTn1YSC
X-Gm-Gg: ASbGncvbN6tCDSEv3ha5yCgt+XRFWpsCN9WI+R4tc5FExWGWizcSZuvAS2nsIaVcL1O
	tcP5gsVeo2Xljri3Wh3hdi4rjQiAgfNDsVYGiujbkVagblOXbhp8UB5MlHsDoFibUwkNNGUgzrg
	==
X-Google-Smtp-Source: AGHT+IH33twGB9tDvlbE6R5uZfaV5aqIL3KlTxPQqaG3uIlLVH73DpMJthDbem6t/dkVYzZh7rSasokqmkIIuFaoNTc=
X-Received: by 2002:a05:6102:38c8:b0:4b1:11c6:d3c6 with SMTP id
 ada2fe7eead31-4b690b84bd7mr19613017137.5.1737627688517; Thu, 23 Jan 2025
 02:21:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jan 2025 02:21:27 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z5De17-Ed3K31kzh@pks.im>
References: <20250121215235.GA2753621@coredump.intra.peff.net>
 <20250122100319.2280647-1-karthik.188@gmail.com> <Z5De17-Ed3K31kzh@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 Jan 2025 02:21:27 -0800
X-Gm-Features: AWEUYZlWWREpUmlk80T1CqQYECzIOFv-e1rJtbwh77mAiUGATUjWUvISC4_M_aY
Message-ID: <CAOLa=ZT3ZHAC1mDQj=tezzdnJ_m413Oez9v20oZ4t5Rh3M5k1w@mail.gmail.com>
Subject: Re: [PATCH] refs: fix creation of corrupted reflogs for symrefs
To: Patrick Steinhardt <ps@pks.im>
Cc: peff@peff.net, git@vger.kernel.org, nika@thelayzells.com, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000205f85062c5cf92a"

--000000000000205f85062c5cf92a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jan 22, 2025 at 11:03:19AM +0100, Karthik Nayak wrote:
>> The commit 297c09eabb (refs: allow multiple reflog entries for the same
>> refname, 2024-12-16) added logic for reflogs to exit early in
>> `lock_ref_for_update()` after obtaining the required lock. This was
>> added as a performance optimization as it was assumed that no further
>> processing was required for reflog only updates. However this was
>
> s/reflog only/reflog-only
>

Will change.

>> incorrect since for a symref's reflog entry, the update needs to be
>> populated with the old_oid value. This is done right after the early
>> exit.
>>
>> This caused a bug in Git 2.48 where target references of symrefs being
>> updated would create a corrupted reflog entry for the symref since the
>> old_oid is not populated. Undo the skip in logic to fix this issue and
>> also add a test to ensure that such an issue doesn't arise in the
>> future.
>
> It's a bit curious that you describe the fix here, then in the next
> paragraph describe why we have skipped the logic only to reiterate the
> fix.
>

Let me rephrase that to make it a little clearer.

>
>> The early exit was added as a performance optimization for reflog-only
>> updates, but this accidentally broke symref reflog handling. Remove the
>> optimization since it wasn't essential to the original changes.
>
> [snip]
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 5cfb8b7ca8..29f08dced4 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2615,9 +2615,6 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>>
>>  	update->backend_data = lock;
>>
>> -	if (update->flags & REF_LOG_ONLY)
>> -		goto out;
>> -
>>  	if (update->type & REF_ISSYMREF) {
>>  		if (update->flags & REF_NO_DEREF) {
>>  			/*
>
> Okay, makes sense. The error is specific to the "files" backend, which
> might be worth mentioning in the commit message.
>

Indeed, will add to the commit message.

> One thing that made me a bit curious is that we now end up executing
> `check_old_oid()` for symref reflog entries, because we have
> `REF_ISSYMREF` and `REF_NO_DEREF` set. But that function should end up
> skipping the check because we explicitly unset `REF_HAVE_OLD` when
> queueing the update. The remainder should be skipped because we have
> `REF_LOG_ONLY` set.
>

Correct, the part which is crucial and was skipped was the call to
`refs_resolve_ref_unsafe()` right after the block in discussion.

>> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
>> index e2316f1dd4..59493dd73f 100755
>> --- a/t/t1400-update-ref.sh
>> +++ b/t/t1400-update-ref.sh
>> @@ -4,6 +4,8 @@
>>  #
>>
>>  test_description='Test git update-ref and basic ref logging'
>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>
>>  . ./test-lib.sh
>>
>
> We could use `git symbolic-ref HEAD` to resolve the branch name instead
> of overriding the branch name here.
>

Yes, will make that change.

> Patrick

--000000000000205f85062c5cf92a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 274f76972653bbf9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lU0dDVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0d1REFDWElrWmRTZmc1cTI3MFJDbVM0d1hsSzM2OQpPb0JQK1dBbGNI
RGgxcks5eWhiYnMwV05hbmE4QVFQdzg0WjArYWtpYTlLbWYzeWtuN21zSTRqb253QjJNMTQ2Cmp2
NUhDVGlZakJ5WmFOVGJ5YU5sOXdWbzUrWFJDcUxDbWcwYkhnUGdaRmRxNlU3a1liRHN2dVhvd2FZ
cjF2dFoKV212L1N0RmtGSmEvRWxMdjNkRkF5OVg5a0lLQjE0cWFOcHdwd2pMNHJORGxSYm9iRVpQ
QWwxV3lONXRmQ0hvNwpsVTcrb0s4dm1IbDlzcVovRitpSGluL243bml4dmIwN0UxQWJCRVBQSWJB
ZGoxVndtMksyWFJaTHRCdzQrMkhUCmFBMklWb2lRaWF1dXByM2ZKSllWZkhyOCtkSmFabUU5UmNB
SUlRMG9HKzdsdG43MkhiQzAyTnRrR1UxZ2NpZ2EKK3E5cTRMTHU2RUFKd0VhdDhsK3lEbElGZU14
WnpjTWxwMUkraG1Qc3dLd1RHaFZIS1ZaenhvNGpaNjlyODVuQgpXZUg1ZEt6elh0WW5OZkhBSXhm
WTdneWxvek85bmtkaXd2eDlyeWp4eEV2cjlqNTdkd1NFU1VrZkI5WWxuZjVoCkM1QWI2L0lYWXBv
aVJPY25LVjJrbHpwUkptMTZwc0RKczIxTGVXaz0KPW04T1UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000205f85062c5cf92a--
