Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287B255F24
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758744835; cv=none; b=TMdzhUj5NoG40aSBAL2ZVxPkKsUk+vhX0nBr7GVejDyETA54Zfr1jL75ZO+p3B51bUFqTXalmpWYtgHQiCuwn8cOoUFZZhrhyU1Gd2HFUbRkrodGNufKjt+vXzKyaToPHkTr5mDZfe0oWaduWn6sEOWu1K012K9cS1FGYY8dOLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758744835; c=relaxed/simple;
	bh=hIzmU8aflRRyJ6L9Ih1/LCfzMkwR/4qzrUhpXhm51dk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeOFV6y10jRzi1YapkOXZ4b1pwQyKb9c2jxl14iEQLVXABHav/0zXWQazOPr2Ju8vvacMLb+EnUrFaNFBPNPqGNTXEuTjHqH01eLKEmP0FrUzaCmMUb9CrflaScPJ9RF08btj2uIMzl19ry/R+aMd4k4LHop1WsFgjUzEreeKHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPBs4ymw; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPBs4ymw"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-890190c7912so61874241.2
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758744832; x=1759349632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WaosAhM+63L0bn1vJokP1YBBjznWnuE+vxNrKuquTCs=;
        b=JPBs4ymwksFYJ6gxDmVHjNq1IxkNLfolHLJ2AcXkgSCTPyWIK1bjAggKIbSpGSTWPY
         DSPAPOUv9h48dVMqpoSEXdf24TLFCbJhw9xd53JquO2KICPBmm6RCRwQXjL4VqiK04RG
         +BZu8y4FZtLrvY7SFn3dxAzQ9XM3F0g5TC/V3hM7o0ITYRiUtYpPlMpuDRQSCJFOiR3R
         anfWvabxHz/jwvpWLcjtBZpRVSlPp7dAC0Rj4Iq2Uf8xOI6SBmycYz8llUIBmR+tVT66
         /2H6m6gbgXHpeuLXpqsT737eyQT1/ck0IbP5nQde2sExAKy9hmJ6/KXU6Kztzj2CiC9z
         2Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758744832; x=1759349632;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WaosAhM+63L0bn1vJokP1YBBjznWnuE+vxNrKuquTCs=;
        b=ATards3FX9GAwQ9U5x7LsnCPTPOs0gQfwf6XsKihErY0i69kOJ+8UlpUnxxlzdQaVF
         4j5SCZBahq0jg4upRcwklWeWVT6QlMALLoJiXBLg0+ojB+U2dEUZnCXi3hzgwrHXZuVm
         qIZqKYBd6YsWV1RLFzTcMedu+umI1N+Cz8yA1bDi75ebl9d4iPXBaJ5GDDcqeiPdA/Lh
         SI1963oO4gwhAvq5QfLDlw3pFmCWM8XuMYfsur2bE2ZCazQRfImgF/KxiljPGyS1CiKb
         TW2IL3uqZ3VHcabOCDDQ5+LwisoT1G5VIsVlDuMhHrMb/Ej+fXPKKlBOqfbWWjTyhn4h
         2Ddw==
X-Forwarded-Encrypted: i=1; AJvYcCX1ENnCpjsOvmCDZ4llW6na+ENJfJU9uvSQzu6W8WEVnqjNBktG2W7YHV5aSohMSJt0+eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynzRnP3EgUweAKP+43nUGqJqhP8chQ8MUcrJlUYfOq9EKn4UXA
	Cb/LncMWuymGDuvpPTqAhBua5KFV89cGSKnVhx519uejnBW0cCyw1NHMc5VqbqPgssVg+ECff0v
	vg+HZdQwIFFD9yTrFagFbZxZaESPQwjQ=
X-Gm-Gg: ASbGncvAB/r5EewWweTAVhA7Ce1QjGchFd8KlsGqgB9aeHPzczYA1Qt/y6FqDP7NfvV
	+lswT+o3T0o1IhLfHn8FHzsrmeZwRPoaweFTRT1KBKgkz+D5cx3DrJ99pKQzCNOR3QnUxlxAcDr
	hScg8+ucwbcBt1VE3R1ig49pGatL5l/EZfb3RMTKCHlO90xmJk0GkBVg6xLZHV0CMOgeNleP+NZ
	56dXVFHvyVvQkV8+Bpgg4ULeLY9wZsSnRdOdDSCkQ==
X-Google-Smtp-Source: AGHT+IFi40owCE5b/FJAf8nqaDfT/6VjWFLWd6zT8Atl0Gcql/KNrPwyrTq4PyINDT29XeRQsnpZCGrlhH1YYt85qdE=
X-Received: by 2002:a05:6122:3126:b0:54a:9e47:7624 with SMTP id
 71dfb90a1353d-54bea253b8dmr600422e0c.14.1758744832251; Wed, 24 Sep 2025
 13:13:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Sep 2025 13:13:51 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Sep 2025 13:13:51 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqikh7lob7.fsf@gitster.g>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-4-271af03eb34d@gmail.com>
 <aNOHl65jYyoNXou_@pks.im> <CAOLa=ZTf7KL23+=Fggfg=4LXt1Dsd6nRCFg3q_Dhuom2Bk+L7A@mail.gmail.com>
 <xmqqikh7lob7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Sep 2025 13:13:51 -0700
X-Gm-Features: AS18NWBsqDdPBvFTsvv39hrlWk1PCdwQHWbnDpxZwkF3rQ1prziES--Dn7kF1bo
Message-ID: <CAOLa=ZQxM_iRMLoKt2ZoTSngkQ3EzXiJJ9hiJxRqHSaq2o0Nfw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] reftable: ensure tables in a stack use sequential
 update indices
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="000000000000fa3723063f91b0ce"

--000000000000fa3723063f91b0ce
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:


>>> Now if we compact the second and the third table, the compaction will
>>> realize that r2 is deleted and thus no longer needs to be part of the
>>> compacted table. So the new state is:
>>>
>>>   - A base table with record r1 and update index r1.
>>>   - The compacted table with record r3 with update index 3.
>> ...
>> However, I think your point  holds. I do think eventually we could
>> optimize this to ensure that we do something like you described.
>>
>> I will make changes accordingly.
>
> If you allow gaps in the indices, it is a bit confusing to call them
> "sequential"; "monotonically increasing" is less confusing and it
> conveys the author's intention to allow gaps clear (otherwise the
> author wouldn't be using such an awkward two-word phrase instead of
> "sequencial").

Wouldn't 'monotonically increasing' suggest that
prev_table.max_update_index can be equal to cur_table.min_update_index?
I have locally changed it to 'ascending order' for similar reasons.

--000000000000fa3723063f91b0ce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cb46e05a08dfee88_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qVVVQMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkx3Qy80K2c0Ukt6VWx6My9sN3YvNGwwOHJBdGxMOQp4U3k1a3RzK3J3
VHZEcS8xYkxNZW8yT1dxOEpwZlh6N2lLbmRIUEd0TDA0TnA2NUtONndVVVF2NmM0QWwwcVRICis1
ajFlemc2eTltUnVDeXlWRTI0UGNGbExKNTZHOGVyRFNYTTA3QitudDJqb0xTL2N3NlNoSjFQbGw5
YmZTRncKckZONkJRRjFXUDZRUkQ5Z3N5Y29MNmg3Sm9zREwwek9reis0emk5Q1Z5OTg0T3hlanEz
SWp0d0lDZis1OWFteAo1U1RpeVVBOHFuajNheTNmRE15eXFBWFJlbGg1MHUwT2hmaENNN2l2WmlE
TmgxVllZOVhWR09IT3AyWnVHdTllCjZnT1NxMnlNVHR4TXhXeUM4L2ZCdGIzTmtxMG11eHkyQ3hx
eXFXNVZEcEZZYlpCMHNpbmJEZk9iTlFJMmxWK2IKN3VodEJvbmEzbWcvTThJRmxGMWp3Qk03RzZs
dU43Y1RReHBnQnp3Y2VGQjlyRnppcmlueFc3elFVaS9uaUl0bQprYmxoNlh1TklGQ24wYzlYVzNp
QmROUWdHU0tZWDlDa0RhVDFNeVlyNEJ4KzdCUmxWckYvQVZXSTF0ejBvVU8vCmM1dUtQck1YWXNU
R2pVQTBkTkh2S1VsSzQ3MnM2bVdnZEdnbUNzVT0KPXU5NXAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fa3723063f91b0ce--
