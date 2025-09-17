Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606B2F549E
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123022; cv=none; b=SbF5XMJ6xUc/ptHt1NoPzAKJnll9L3Dr4zE3lMqX6Do6OG9dAi7YhhFPzWQTZh7KzZyp0y17hSsZ9c5cdYPW42Sl9V4UqUR/e9U4JhzAaXP4P6nfPUcnwOeEiQ4WABWy/xQOGZpX/iY+j0vmYwcYFvufq4RZ8tUd1qlP5OVR6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123022; c=relaxed/simple;
	bh=vgHl01t716+vXTZ2TE6YmXRq6Nfsyxi09znoUqZMMY4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZC6AFhH/VuotiRNQUVqY8+j5HOnygwBYmhLnIUg/FauDmIq3lwhVBjdJDTFZsQvL+Z3Y/kAJBcqe25IuDLGQztPNOm/6lCL1+8/EDcd+mizFB4REaaNLFOzTcCdxuEW7fcb08z5jO9/k7zb7Eu3w/luBaMJistG9d2Fv26i1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVONsoPp; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVONsoPp"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-55716f2d3b9so4173739137.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758123019; x=1758727819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4RolVMrZmtMVEajYWOqeZxsRneQvjCushmfToUGpMek=;
        b=cVONsoPpth+pEB2swMLEGNkDvczkdnjdoC7tf0vpFyuJoifYUx2Kub4BrlTbq0eppm
         MKIxz+5jdZnS5WYKyi0SuedS5Q2x5oj0b6Fkn4wQ7zwoK3z+yegiZ08patBJZFfAFQqF
         D9Oq8eZHwtYVA6tVCOmqYCuMoNFoE4c2V3nck5wk9OJxbvWtNMTdBNjwi4xHa8udz7dy
         XtloN9JM8z2g9anVhWagZnpVC0GRbFBcOLUF5rvDCDQrk1xghwF7ycN1C2mTj2ATnQMq
         l6uQGOROTTcMrpNB1yFYk1vGnpNcU8sjXsDI93IVS64FAevMkQgEMTbhvzRaJutnCVWm
         h56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123019; x=1758727819;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RolVMrZmtMVEajYWOqeZxsRneQvjCushmfToUGpMek=;
        b=XT3qOBWhYkhf47rowVZTSY8QDGpscNIMc7GKA2UZsFSccHZ+KuAphvZcyEQUB26jqp
         z0Ai+3dCMzWrUJbZeldT8aqdeosuXO2NEMnhCFPYYEnacPRzZTgZ5TRPPjcTTCGg8hqH
         LfXhnKx3SqO/lgNZhLS1VvpMbPhxMK7QoPg3SxfjlGTITqdoQ57Hw0gyo02XKR2g4Te7
         uEbpk3cP8vmpx21+t60587IZTgJabyoPhgWg24oSL3fHpw9E57yqs60mZ+9JJBlij3NB
         +1/TPEwC2/wVmFZ+ebm0ELDCPXy63jp5UB2kUNgYikM5MudifyZh/w/EGAMSyN69KyUm
         g9rA==
X-Gm-Message-State: AOJu0YzeHDDfgpPOxZ5Ii2UIRoQc1+kvRFev5sTNtPj2Q4cqH73OULH+
	JFwvU/ae+dewxMOZkycS78AzQ5PFhKZ9q7Lp7wi+M6gWQbKnuRmRyMT/+9opx2vt7JzPDLwWxCI
	VbRwXln4kUqUbpqpdf4GA0ZwVsYBrqb0=
X-Gm-Gg: ASbGncvCm6PcKez7MdIlUXKDslIaXU7jtOGj67lX/hFOt/NDmLs77HtjbxtYPmio3Qw
	dMr47JHmjVWtDXqn1euRc4TxXX6NWco3oTrBKn+6Oen2kDH+QE3XU5ZXojHupHGVCQeUpypUpvK
	0egFUFoEWf/PGLKVBIA1kroFNPiiBzlY98T8t6UVhIAebtbmrRT/K1MBAIBtJoMvWnzTs4tA2BJ
	AbqjtIfYIcH/Pat9nVWlut2ZgTiZ1Tmitk/yBu0LarZu8++dFD0
X-Google-Smtp-Source: AGHT+IH1uG+tp49guVpmQbDVzX7Jbqvljd4ABYr/rZRMg6eZY+HFH0yA6apo1R2+85X8aqhDndj63rBGXWRbbygKu0k=
X-Received: by 2002:a05:6102:3c84:b0:523:712d:448d with SMTP id
 ada2fe7eead31-56d6ac4b536mr881181137.30.1758123019146; Wed, 17 Sep 2025
 08:30:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 08:30:18 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 08:30:18 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZR1LNs0i5TDPFG_QvUYS3=CMx3ov-68ph6QKNM273JUHQ@mail.gmail.com>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-1-195569740b57@gmail.com>
 <uv4ifkvxcujjjj3lsc4tf5b5dnc7pkaaw62t6ahagnskxn4kg6@oyxjgupdilrc> <CAOLa=ZR1LNs0i5TDPFG_QvUYS3=CMx3ov-68ph6QKNM273JUHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Sep 2025 08:30:18 -0700
X-Gm-Features: AS18NWAaeIyE1jgrC575MNI4qbgy3mHLiSzSkYkwDAZ8akH79HFWrCEpdn3ho8k
Message-ID: <CAOLa=ZQ7RBhqQCd4zgq4htcORWLxDsDX6t=diN+Z=TmR7H32bw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] refs/files: catch conflicts on case-insensitive file-systems
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, ps@pks.im, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000000736c6063f00ea9c"

--0000000000000736c6063f00ea9c
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

>>> +
>>>  /*
>>>   * Lock refname, without following symrefs, and set *lock_p to point
>>>   * at a newly-allocated lock object. Fill in lock->old_oid, referent,
>>> @@ -677,16 +697,17 @@ static void unlock_ref(struct ref_lock *lock)
>>>   * - Generate informative error messages in the case of failure
>>>   */
>>>  static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>>> -					       struct ref_update *update,
>>> +					       struct ref_transaction *transaction,
>>>  					       size_t update_idx,
>>>  					       int mustexist,
>>>  					       struct string_list *refnames_to_check,
>>> -					       const struct string_list *extras,
>>>  					       struct ref_lock **lock_p,
>>>  					       struct strbuf *referent,
>>>  					       struct strbuf *err)
>>>  {
>>>  	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
>>> +	struct ref_update *update = transaction->updates[update_idx];
>>> +	const struct string_list *extras = &transaction->refnames;
>>>  	const char *refname = update->refname;
>>>  	unsigned int *type = &update->type;
>>>  	struct ref_lock *lock;
>>> @@ -776,6 +797,9 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>>>  			goto retry;
>>>  		} else {
>>>  			unable_to_lock_message(ref_file.buf, myerr, err);
>>
>> huh, so if if we have a lockfile error due to a case-insensitve
>> filesystem, does this mean we print the error message from
>> `unable_to_lock_message()` and the new message?
>>
>> If so, I wonder if we would be better off skipping the former since it
>> could be a bit misleading.
>>
>
> I would say both are necessary. The errors added here are more technical
> and really talk about why we faced an issue. The error in
> 'builtin/fetch.c' is more about guidance to how to overcome that issue.
>
> Also this error is client agnostic, so we'd add the error here for users
> of both regular transactions and batched updates. The error in
> 'builtin/fetch.c' is very specific to users of 'git-fetch(1)'. So I
> think both hold value.
>

My response was a bit confusing here. To answer your question directly.
No we do not print both messages. The error message is appended to the
`strbuf err` as you see.

This 'strbuf' is provided by the callee, specifically in 'git-fetch(1)',
we only print this error message if the ref transaction failed. Since
'git-fetch(1)' uses batched updates, the transaction will only fail when
we encounter a GENERIC error type. Otherwise, the transaction succeeds
with/without rejected updates. After which 'git-fetch(1)' will print out
specific messages for rejected updates.

For example, with the test added in this patch:

  $ ~/code/git/build/bin-wrappers/git fetch -f origin
"refs/heads/*:refs/heads/*"
  remote: Enumerating objects: 3, done.
  remote: Counting objects: 100% (3/3), done.
  remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
  Unpacking objects: 100% (3/3), 713 bytes | 713.00 KiB/s, done.
  From ../base
   * [new branch]      bRanch1    -> bRanch1
   * [new branch]      branch1    -> branch1
   * [new branch]      master     -> master
   * [new branch]      bRanch1    -> origin/bRanch1
   * [new branch]      branch1    -> origin/branch1
   * [new branch]      master     -> origin/master
  error: You're on a case-insensitive filesystem, and the remote you are
  trying to fetch from has references that only differ in casing. It
  is impossible to store such references with the 'files' backend. You
  can either accept this as-is, in which case you won't be able to
  store all remote references on disk. Or you can alternatively
  migrate your repository to use the 'reftable' backend with the
  following command:

      git refs migrate --ref-format=reftable

  Please keep in mind that not all implementations of Git support this
  new format yet. So if you use tools other than Git to access this
  repository it may not be an option to migrate to reftables.

  error: fetching ref refs/remotes/origin/branch1 failed: reference
conflict due to case-insensitive filesystem

Hope that clarifies it!

--0000000000000736c6063f00ea9c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 49a2ec9331f375e6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qSzFBa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkRZREFDV2cvQmU0dHRwbEZaTzRvQ1FDcnJLWStUZwpYdWw5SWRyWG5N
Z29wd1U1bjlLWm9wVFBjdlBNTnVaZDQzT1JYNURVNnpUSVNqbGgyRkp5ZnRIdjdPQ2tYdDVDCkp0
OVpmOTc3NXRWOVozOC9CanVHZk1hZFRGNVZqYWpLa3BCS3VWTkxzeG1JMlhVS05SL2xWVDJ6enZ3
K3RPMEoKQkRjbHBhMkZZZGl5VXE3RlljODZndU9KcXJMaDFVSTF3UExNQ2NhMDFaTmtERlk4SHJQ
MjZORlNJUyt1SzZrQgpRVHFnTWNOdUlPU2FWNkpMM2R5UG1Bb1QxaFkxbEFtTnBybHBCQm1DTnRU
TWJLQURQdUFCSENYVFQ4TkJWbHEyCjZRckpIaEFwbUcrRnBSekNKRWpBdHd1WHVBT1FCUEF3S245
RmpycVZ4RFBBOUE3SzFQVGVTSHlIbzNLVGdHR2YKTDQ1cjdoYmNRRmVreFVnTnB0dnRmNHBpMnlG
Ykh4cFJIa2ZFSGRsSkVaUUFNUGZud3N1K3VScDRIL2tGdmxwdgpwUmF5QXkrV1UxcDhPZzc0OGF0
TzJwRWdmU1FCUHZYM2RXcGphTWg1RVZlMlhCSU5WYzRTYUdPZlVYU2pNVVpqCmFMcjNJd0lveXJJ
bDB4WHZvYktWU0dIbVNHRnl5TWVsMkdxcXdqOD0KPVVQbGUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000736c6063f00ea9c--
