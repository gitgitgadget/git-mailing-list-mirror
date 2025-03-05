Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C883F24394F
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184425; cv=none; b=sxJdIYSY9RVWGNcWM/g8UsC9mYHAvluZrAvBggXHURI3LBQ7UuuBDlbCUcoi8ZNooNBYho5NnnXRVRnqTszq9QD0d8xCE6Du+5xtJ5U7+aa3Hsg2viXcGEDGpUIq1dLo3KXaklKbgmM1bT7WDR92/uKsp20Pahj/V4dPSNYoltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184425; c=relaxed/simple;
	bh=5xKfPb2Ryxek4vJ2urLpBwaL3EMbwr3ygTV8TEcZfP0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8+qaj394xKYAG2RZAd60XcOCoDQeUTGPPhII7bps5Sn7LGk847aVZ0lf/J1mlUWE96m2WItLVDg+Y/OEoU65os8H8wtg9F9l8TxvVgBCXNGTUjj96HHkjubT8fCBQwSiOAjZnO7i4WIicO/1TvVorBn9iRwnTxo0YFAMqeuXmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LATmzFdF; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LATmzFdF"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-521b84da5e9so2582558e0c.0
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741184422; x=1741789222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EvKTB/S7pGLdgHZNI3Kcen+V52VCiwhVwu3k1X4TLfs=;
        b=LATmzFdFhkDMejHjRz3eQQrwTaJUUC1rdyHKb3ftmkuOJ4t4Yf0106DKrAoPEzvdyK
         GQQZXH+SWaOe7iG7YcbwEnwPIliJsmdYmtVIDlJye8frb9+U3Rj/rDwo1p8nU8UmQX90
         F0EcBIKZNi9MFJLpcKOIbFe2c0AQv0ZOIcRUyXaCM3skY9pfgh7fL8HGA1qlgPDFU5g7
         jIovCMvXqtfs3z0c/N9UnqvnxdnMlZNHJsRcV7c63dSCZlU/+yREOL8yI4+iB9/QGOHb
         OTFa9r2dTb4AoeE3ZAK2N20y1TR0vbw0LYV0fVIfj9Pc5BSyTBju5rrsvyIbA7zH2Hmn
         obtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741184422; x=1741789222;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvKTB/S7pGLdgHZNI3Kcen+V52VCiwhVwu3k1X4TLfs=;
        b=PBx02ivioc7iux0DVQrQkSi78IZSXm2Y0qFD6KafDvdT+1FvNHqiDDcKkZ/Vy/ud7J
         HSj4B4u5So19RDFZIe3lFZ5Yc0Is7+Mu7IbCm6IgN63OGRuTjUzXq8nUF+tB0iCehnX/
         q/yId1HaaaljaG0K+u16CVP7JiA/GlGjmGdGQY6abelkmjZreFvoQhuxjt3DuprlYwqP
         fJ67+AwBJfCwzANAbW1GDT0xtJSZ7t/qLkKweN6zF7lwgUBjVNGxHRkv0bm7gnSVe/v0
         11BUQQB3Gr9eOKgx1U/LVfLFGmK5A8QGjdydqaX1QVOFQJgdpb2JY0HzM6h99RHQYTSU
         KMXA==
X-Forwarded-Encrypted: i=1; AJvYcCUnAbAqwG6Kvcu77w/deHO9BQ6LgA1/m73ox/Z7Rxa1VRclM8arWGazjgLCVupV0156Nzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqyQ3JV+nH1mPOXG+91qWr3MhyC9GBu7TxDJECs2wZoXNmfx/q
	9ghOMGUeOq4KPGSqLl89x4PeCDPwp5Mw8weFm/TW1iWJZPsbBpw6u4TsWnK8iy127LzE/HtgE4Y
	u7qu2F/iTANJeL6D2SkB0NtFYVYVllhbi
X-Gm-Gg: ASbGncvtK0tyXK2sTz5fQ8XqWiU+/0SxjGYarlTBtFNO8QU2ZrxM8okaqwesW3VGoNZ
	u2GpdfzD7JNwGzSHFTXBFSq8BPE4QesZZPEbdfdpVl7ELCJJwW/1qiQZcIz8MQpkbTs58ojP6lC
	YgqaolZcaj2ga8M9Xf2QxVsWLqZI+/jWCE6gCfCp5YxvBjeIUSQAM3gTU7k74A
X-Google-Smtp-Source: AGHT+IFaDkUHA9403lvAG8uJiJOsZjtsx1BRS0yXyZDpy493Vyen3uL1L2Q5aVT8Iw4MNTmXl4QEdWcAoRaNu1ozBZk=
X-Received: by 2002:a05:6122:1995:b0:520:5f0a:b5a5 with SMTP id
 71dfb90a1353d-523c6274badmr1602038e0c.6.1741184422483; Wed, 05 Mar 2025
 06:20:22 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Mar 2025 15:20:21 +0100
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <33e6e65e-c68b-4b88-a66b-53b808745a24@gmail.com>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
 <20250225-245-partially-atomic-ref-updates-v2-6-cfa3236895d7@gmail.com>
 <2755fb78-d587-4ad9-b22f-b60dfa752d7a@gmail.com> <CAOLa=ZQCWFGsaPN+J8R9eQMBJqNNyoeDLkLwCFBbBzTG_R_-sg@mail.gmail.com>
 <33e6e65e-c68b-4b88-a66b-53b808745a24@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 5 Mar 2025 15:20:21 +0100
X-Gm-Features: AQ5f1JqZdu5d8SXYqnQZGIZnoeZngWZd52f5V0pyJd4JhIxdJ0f9pQT-t2Ci3hQ
Message-ID: <CAOLa=ZQ-_yoPHAy5f_Z=OpPXKfiy_m2yuPqa8ekk+pKZGryafw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] refs: implement partial reference transaction support
To: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk, 
	git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000fdb6ca062f9916bb"

--000000000000fdb6ca062f9916bb
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 03/03/2025 20:21, Karthik Nayak wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> On 25/02/2025 09:29, Karthik Nayak wrote:
>>>> Git's reference transactions are all-or-nothing: either all updates
>>>> succeed, or none do. While this atomic behavior is generally desirable,
>>>> it can be suboptimal especially when using the reftable backend, where
>>>> batching multiple reference updates into a single transaction is more
>>>> efficient than performing them sequentially.
>>>>
>>>> Introduce partial transaction support with a new flag,
>>>> 'REF_TRANSACTION_ALLOW_PARTIAL'. When enabled, this flag allows
>>>> individual reference updates that would typically cause the entire
>>>> transaction to fail due to non-system-related errors to be marked as
>>>> rejected while permitting other updates to proceed. Non-system-related
>>>> errors include issues caused by user-provided input values, whereas
>>>> system-related errors, such as I/O failures or memory issues, continue
>>>> to result in a full transaction failure. This approach enhances
>>>> flexibility while preserving transactional integrity where necessary.
>>>>
>>>> The implementation introduces several key components:
>>>>
>>>>     - Add 'rejection_err' field to struct `ref_update` to track failed
>>>>       updates with failure reason.
>>>>
>>>>     - Modify reference backends (files, packed, reftable) to handle
>>>>       partial transactions by using `ref_transaction_set_rejected()`
>>>>       instead of failing the entire transaction when
>>>>       `REF_TRANSACTION_ALLOW_PARTIAL` is set.
>>>>
>>>>     - Add `ref_transaction_for_each_rejected_update()` to let callers
>>>>       examine which updates were rejected and why.
>>>
>>> I think this is a much better design. I wonder if we want to signal to
>>> the caller of ref_transaction_commit() that there were ignored errors
>>> rather than forcing them to call ref_transaction_for_each_rejected() to
>>> find that out. Another possibility would be to call the callback from
>>> ref_transaction_commit() but that would mean changing the signature of
>>> ref_transaction_begin() to take the callback and user data when
>>> REF_TRANSACTION_ALLOW_PARTIAL is passed.
>>>
>>
>> Yes, I did toy around modifying `ref_transaction_*` at first, but I
>> think the current implementation is slightly better. Users of the ref
>> API do not have to worry about complexity of partial transactions unless
>> they really need to. So in that case, for most users, the API remains
>> simple and clean, and for specific users who do want partial transaction
>> support, they can activate it via the flag and use the iterator to
>> collect the rejections at the end.
>
> That makes sense. I have a slight concern that iterating through the
> errors is O(number of ref updates) rather than O(number of errors). If
> we expect most updates to succeed that it is a shame to have to check
> them all just to see there were no errors. Maybe we could be store the
> errors in a separate list of (update-index, error) pairs to avoid that.
>

That is a good point, let me add in a array inside 'ref_transaction'
which will track rejected updates.

> Best Wishes
>
> Phillip

Thanks!

--000000000000fdb6ca062f9916bb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4226ca42b3cce964_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSVhhTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlRKQy80cFRpS3VaUGoxaHBzaGhQVnF4M0o1bkNPSApJZXpMZ1N2Q1A4
dWpCM2lxRjl0SnBhbXpLME9EOXBNeHpPWVg4clVnWnFPWUpBaFoxaUQxYTcvUW8xZE1iQU5nCnFi
SGd3aStHS05PbFZrbHhjamdIbEhDeUhaTWpaeDlQd1dpdllKdWIwd2ViaUlxczREUncrOE5ObUpG
TXgybDEKdEp5M25UZURpdVVMUlJ6ZEdhUVR1eTNLZDRNTDNldiszRTlEeUlMM1dOL05zbDFVTHBE
UFpWMmc5SWdENW5mZgpsaGxLQnE2ZHVUTWpTRDRwY1hUZ1h4Vkdpd3dsQ3ZaYkVUSkk0MjdkaGhF
dlBpa09YTUlVdDZ2aWh1Vm9IZGFMCnZpa2RXdjJrVGwzUnFITDFqUTg5d1FWWmxhcHhxb2YrQ0xE
Q2dZMVcxeTZFY3o2QzRwQzRiZ0ZRVlkwSkZjNTUKSXNlMG1vYjBBS2UwK3UxTFRsZlF2OFJQV3Jj
bk5KK09RRmI4VkxxV2JvK1hpRUp4TVlPU1l2Rk5nNi84RnJuWQp3aTAvSnlHdy9qM1E0MUd3azNU
VSszRzBrQlBERHJQVUdpMHJESmwweWYyYytSSFNpNE1yalpsTGRQSFNuYzRmCmF6V09pU0NSdWor
Qm5kSndMNERwUmVvb1VsbnBKeUI5VHFFZC9OVT0KPXdjV2QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fdb6ca062f9916bb--
