Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF621DFD83
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033268; cv=none; b=FOCR1LuCA4BXtiQMjbmSk2zLYXcui4Cq8UgGTB286F/YU4DuaitSCqI/GCPO6H0+gXFUo4+SqRWhX1EQDBsbKaeq9TGcWx7gKSd1/9jk7SbUE8NWNqsQD1ACLLCv7wUaTCREO4c1sbrS3gQ91q+Ddf2j5RWiquDsy2+HAqJQFv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033268; c=relaxed/simple;
	bh=nQhWSYCjM+WCjZ3+tBaqADe4F1lwf9AHIzETmcIGy/4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYXcN2RbnNyK7C1Vwhc0ZH71BYVi4frkNy1VQiSzir7gtfrSTgzDWO25acLNckQ338eo1fiqg3SFE8avZzhcfJBAXXupl4h2c+aOHAa8vFK5+CVGgxe2bCbhOK1Vsk+KoDI917vVJd0hI+eAwgBFH6GFYcyodUrt/jxPkYtjSqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSOL2RcB; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSOL2RcB"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-51eb1a6954cso2019481e0c.0
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 12:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741033265; x=1741638065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ny1uUjNygFlj0ArLH8Im/yeWut8GspiJHp+zapyAZ+c=;
        b=YSOL2RcBsNhFx0kMDmRX7/ySXQQFu2p46+BHS0W562PkjISpUCWFAi5rwQp2Ra32kK
         UvBFYlZ5eCBeq9UptrNjSw7PlsZ+DcE8q6tuYmkOkjktmrl1iT8sIAtcgXj/xv1HphaJ
         ig3WriRk1yuzJZS/jm/57Mt/hBEkaMuUUOfan85bnEapFg37DMwDXJbqPoO4MMqttuV+
         h64/1xBlZ5ZKB/pOim5RpdmXP6qpllHNcOLMx9kMMyjMw5Gcu9zjeTUjjnH+RN77r5eQ
         3O5/qSyqoM5Kivkf3i9WtW/II3z93DY4tXq+VdXZ3knu6sLMh1KgjuaRIaU1XvXnJQpq
         R0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033265; x=1741638065;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ny1uUjNygFlj0ArLH8Im/yeWut8GspiJHp+zapyAZ+c=;
        b=fKNIvgfwxyNeaBk/xFvqp9mLbKuinmJ83RUaj86NyCt2xf7pdSvfEXQCctnGaPhX22
         zb5D8Ryk6j40ljLf5YlZUjX8nOz3R2HZd1oZ122Arz6aKEbAzfc6jtg0TihziX7WNxEg
         xc8E4JV7U/+ULw4lzqyZH9MJPQwfJ6zLORGrnUxEoKFhTTvYU+3Q3b6Wejk49TuXBoRp
         IKDzSR+LVfElUO5NMMVvKp5MTi6rn4EhWJdQBbKniUGZfh+E4YFW02V4N7vdSp7jeZcV
         td+JKzH2Z7Bb8s3ay0accTNHbDIu2LiaGb5c8Q8O5DhDObI3cADjqH0Zk2gIbnvFba8I
         xVKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvi9P46y04RJNtlEccyEKJqqRwfj5e5o9pITyV9tWpE9lTmS0/N1ArhSIcmf2etuCDWgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWK1+V6A1QctChYdbX6JRdLNfHInorEwruS7BHSlY2zwLihDjA
	uQuqYfhUdnFgaotwl2vVsAdt27J8nJ2H/sIBsWzsXeRUFi+Ds0IgRbBhVCD3yYiKzbh3IjL5Mhz
	Wy3g3Zfu8sQfJrHzyBkATfQbQIQmLT6+u
X-Gm-Gg: ASbGncv/pSP0HlFaF3ZHoFl4KxklfH7EWKZXnyLvTKRaAqFUnONmSmlkxEZEqqiq4VG
	joaEEKcgPyIHUlG7ZzSPLlvZf+UniA39lf9CBQkmFjTkTVWLogesC+Yy2MLzHFcFHxnU7INq8rz
	cvlyL1195YGVJQENLzuyY1ipu5DBn5M15rVjFIrdBLawtZDbREJU0Wrf0RB/E=
X-Google-Smtp-Source: AGHT+IFqZPtIWmZMTDfnXm3CKvot3DRDkGWo9XW4wGztTC4G7I6DNid505R1f7MHXRCPNElrqhCxeLav2CfxQkPjS/c=
X-Received: by 2002:a05:6102:1512:b0:4b2:c391:7d16 with SMTP id
 ada2fe7eead31-4c0448b9b00mr9695622137.7.1741033265279; Mon, 03 Mar 2025
 12:21:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Mar 2025 12:21:04 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <2755fb78-d587-4ad9-b22f-b60dfa752d7a@gmail.com>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
 <20250225-245-partially-atomic-ref-updates-v2-6-cfa3236895d7@gmail.com> <2755fb78-d587-4ad9-b22f-b60dfa752d7a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Mar 2025 12:21:04 -0800
X-Gm-Features: AQ5f1Jp75Drkuve-2PBdqJ4LwRhsAnT7hBobceq6nbxhZjz9Psh1Qm29oM-X80g
Message-ID: <CAOLa=ZQCWFGsaPN+J8R9eQMBJqNNyoeDLkLwCFBbBzTG_R_-sg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] refs: implement partial reference transaction support
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="00000000000051d382062f75e50d"

--00000000000051d382062f75e50d
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

Hello Phillip!

> Hi Karthik
>
> On 25/02/2025 09:29, Karthik Nayak wrote:
>> Git's reference transactions are all-or-nothing: either all updates
>> succeed, or none do. While this atomic behavior is generally desirable,
>> it can be suboptimal especially when using the reftable backend, where
>> batching multiple reference updates into a single transaction is more
>> efficient than performing them sequentially.
>>
>> Introduce partial transaction support with a new flag,
>> 'REF_TRANSACTION_ALLOW_PARTIAL'. When enabled, this flag allows
>> individual reference updates that would typically cause the entire
>> transaction to fail due to non-system-related errors to be marked as
>> rejected while permitting other updates to proceed. Non-system-related
>> errors include issues caused by user-provided input values, whereas
>> system-related errors, such as I/O failures or memory issues, continue
>> to result in a full transaction failure. This approach enhances
>> flexibility while preserving transactional integrity where necessary.
>>
>> The implementation introduces several key components:
>>
>>    - Add 'rejection_err' field to struct `ref_update` to track failed
>>      updates with failure reason.
>>
>>    - Modify reference backends (files, packed, reftable) to handle
>>      partial transactions by using `ref_transaction_set_rejected()`
>>      instead of failing the entire transaction when
>>      `REF_TRANSACTION_ALLOW_PARTIAL` is set.
>>
>>    - Add `ref_transaction_for_each_rejected_update()` to let callers
>>      examine which updates were rejected and why.
>
> I think this is a much better design. I wonder if we want to signal to
> the caller of ref_transaction_commit() that there were ignored errors
> rather than forcing them to call ref_transaction_for_each_rejected() to
> find that out. Another possibility would be to call the callback from
> ref_transaction_commit() but that would mean changing the signature of
> ref_transaction_begin() to take the callback and user data when
> REF_TRANSACTION_ALLOW_PARTIAL is passed.
>

Yes, I did toy around modifying `ref_transaction_*` at first, but I
think the current implementation is slightly better. Users of the ref
API do not have to worry about complexity of partial transactions unless
they really need to. So in that case, for most users, the API remains
simple and clean, and for specific users who do want partial transaction
support, they can activate it via the flag and use the iterator to
collect the rejections at the end.

> Best Wishes
>
> Phillip
>
[snip]

--00000000000051d382062f75e50d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b89146f431864246_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mR0R5OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menpJQy80MklIRnpXNnFZM0x6SXRaNHlselJVQjJNdgpuVDNlZHczNFVr
ZTYxOCtWakwyd25WNG9oTnVSTHB0RVFVbnR5YkRyMDVPcjhGck1uTVI1Zm15RFFVUjBDQW9hCkN4
VFEwY2h4enNLK0R3Q0NlUUhBeFFnbHlSdnhWb3BYTitpcUgxRjhScmJ5RWZCMTY2WVpaZGd3UG5y
OWhFNnkKRFRaM01EYnlYT2hoTzdIdmU4UkxZV1VHakJnNVpxU3FPczF4b1UwT1BPeGV2c2VPVGhl
REpaVUtPUkZieHJNWQpFc1pGRk9HNVNtUUIwZGxXNkg3eFljU0ozU2dFUFphTzdlLzVNL25ydG5z
VGJZN0QwWStZYlBZOElLYjdKL0lSCjVSOW44enJUZm5hN3piNzJWajROVkEwQXY5N3NzZ0hRczFO
T3BCRXI4aTNPU00zRUNaRnRBcjRkbmFNN2I5VjEKNlEzUGwyL25zZDhwdlRZK1ROVnhMcEFFdW9B
eDF2aUJnZ0hBY2hsZHpIWStFT2MvWnViTENIY3NmRVByMks3bwo5cmxhcUYwcDVHVHpDOVY2STVG
ck1LL2Q5TisxODliRTdEVWNNc1d1MXNGdVN5Rm4zeHQxdHUrZmJpNysxNVNWCk5PVGxWRklnalpz
UzJrdWwzZFFZNHVvUmlKb0dYbWIxSzNUUDIvTT0KPWIyU3EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000051d382062f75e50d--
