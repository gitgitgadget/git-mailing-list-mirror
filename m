Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4918DB3F
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254385; cv=none; b=scEWjRhTU3w+Z1HvK1MPaG127q0OqB8gskN5hKeKe7sK+RGpA8LQNPYhv+QmvvmKvQSXOUvFC6BAD6ipBi0Cl+y17VSD7xrh3EDUT+v646kD95jQ0nMqRy5DLflgpPlvR0XYZi16jbwdGJuvmWwMdBZaISkmJIOCjddn/bvkHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254385; c=relaxed/simple;
	bh=eoLevWZjD0jkec8wcL2KyV2NKcmdxq0ZX0ELUs/aCSk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ki4XybRKPwM1xkJZ6vpCNo+Gd9FZ7c8wDssXR7hG4TSLc0SpwTpaQmMg4R00MComUWdgG8nNA7keLj0E2n7MRo65TbdAhOjflmHsQFUu9ddpav9F78l2zwy14NYUNObJpLxuznfEOCP7qbl5WC+HtmCHCMWdcOE0G+TwwHa/9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN+IsY74; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN+IsY74"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-523dc366e42so108495e0c.2
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 01:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741254383; x=1741859183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sM4W5CWhdJM6A4MVbZk0z+XEytdygtseLVSFvAIPK0I=;
        b=KN+IsY74W0XA33eUkuqkMbKXdM+T3wLRxmdy8v1p84hc/ZOCywoDjOqVH4B+3xfgxi
         mHM2ZyfqC9gpEHRw66yMz7FQzlXI/qHvJmElJb2nj2Xt+V7hgkjEpTuGG4VLJLW+dQf5
         1Gkn4gJgQulsmsP6ZOkhFoVo9My/EoQQpRgA8R50K+rgAFDZTwGrJX7cW0zW45SFXfpH
         V0WCBFb6pdFHcKyR6g/5DWDROYyznoP2pUp8c1fQuE5LQvMaBFHRxHbmjzlsa2qBvUOw
         DDCsqzdhDqXhateTTGqxCGRMq/QpvyADWqXD70I8iO9MVR4bR/iODhZckVaHA+CpjuJ0
         eDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254383; x=1741859183;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sM4W5CWhdJM6A4MVbZk0z+XEytdygtseLVSFvAIPK0I=;
        b=ewmnGSfwLPuvTd23YrGlkyEyaJsXjgZNvcgyj3RPJTnTYbDREemU7YqhwqIYXrsTKp
         87g+4a21Bupzi7KsXKET5WtTs5+AVwlBXZXkjFCCIDejsHlQql3cuISwLaE5LzAkIqXJ
         IIlQIBq3rsW483I/X0ORmA+SSlhwpj/cUahtTVQPxcCj1uEUf8dZupBZlbOEKnkdUskZ
         2Hgy4uqUukLl0Wz+1IbBj2GDVfTSZUcMxGkwjLpK+yOa1q9MYTYZ6lK4ZsnMhvug3jaz
         rSl8pPRXH6Y+u+AIIF4GkHzK3DXO5O6cRmiHoHM3NjjE5A3kdoLT1yz1d19AhL4N5MDp
         CFvw==
X-Gm-Message-State: AOJu0YyExtVFAr1e8iKdWC7jc492WNpxR1UHyRrxKzot2N47H1Yw2UYQ
	u2jiIqBcw0FtaS2aum2PrPFUgGkV/Ysw/mTL9ZcQo3AXXr40RrDsiWdMHH967UgOh74NVWw0Hwf
	cObQM3TCkfb7fuMNxs0UHG/Eafi6kBw==
X-Gm-Gg: ASbGncviPplm85T0zcO3ygNU83VwUiRn36IiGnIiAYpJWRHVEMjVHTfXnOBJqQrxoxe
	fWKuVjs7VOIRbfLKIJbOEieNqfcuq6Xcyx+wpH6GbDHg8FoaLlrfnSc71BJMNR4gTyqYWUqScKE
	hmmbmkZVyKzrYA3ILQdp5Kl7XfcOE=
X-Google-Smtp-Source: AGHT+IGEYKcXu2ybkIMXPE68Bghw03rm304mj+u8TrjODShFLlasChQ1DvK0iKRhCKmwbXp+TNTYEKTQq5t/QQerfgI=
X-Received: by 2002:a05:6122:2a14:b0:520:42d3:91b7 with SMTP id
 71dfb90a1353d-523c6114152mr2881496e0c.1.1741254382769; Thu, 06 Mar 2025
 01:46:22 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 04:46:22 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq5xknkup2.fsf@gitster.g>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-2-0c64e3052354@gmail.com> <xmqq5xknkup2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 04:46:21 -0500
X-Gm-Features: AQ5f1JoWZ38xU3IQd6zo7ZZKh_JdqmoQOe6KNxQeLdzLsoTR-fTNarRS1hz-P3M
Message-ID: <CAOLa=ZSW9TaD5_-9oQ97=hZXinZUGAkLOSeyDsg-YrTiOOorvw@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] refs: move duplicate refname update check to
 generic layer
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000f2f63f062fa960e2"

--000000000000f2f63f062fa960e2
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Move the tracking of refnames in `affected_refnames` from individual
>> backends into the generic layer in 'refs.c'. This centralizes the
>> duplicate refname detection that was previously handled separately by
>> each backend.
>>
>> Make some changes to accommodate this move:
>>
>>   - Add a `string_list` field `refnames` to `ref_transaction` to contain
>>     all the references in a transaction. This field is updated whenever
>>     a new update is added via `ref_transaction_add_update`, so manual
>>     additions in reference backends are dropped.
>
> The transaction object is the most logical place to keep track of
> what is involved in the transaction.  Nice.
>
>>   - Modify the backends to use this field internally as needed. The
>>     backends need to check if an update for refname already exists when
>>     splitting symrefs or adding an update for 'HEAD'.
>
> The above reads to me as if you are saying that the files backend
> needs to notice that it is updating "HEAD", notice that it is a
> symbolic ref that points at "refs/heads/main", notice that "HEAD"
> and "refs/heads/main" are the two things involved in the
> transaction, and must check if an update is already queued.
>
> But when an update changes a symbolic ref in the sense that the
> underlying ref gets updated through it, the need to update both the
> underlying ref and the symbolic ref is common across backends, isn't
> it?  IOW, shouldn't "splitting symrefs" (which I take to mean "ah,
> we are updating HEAD so we need to update it and at the same time
> update the underlying refs/heads/main, two updates in total") be
> done also at the generic layer?

Yup that is correct, in the files backend, we do this via the
'split_symref_update()' function and in the reftable backend it is
directly handled in the 'reftable_be_transaction_prepare()' function.

I don't have a reason for why I didn't undertake that too in this
series. Mostly I think I didn't observe it. But it something that
can/should be done in the future.

>
> And if that happens at the generic layer, should .refname member
> even be visible to backends?
>

It shouldn't be necessary anymore with that change. I think this is good
step in that direction.

>>   - In the reftable backend, within `reftable_be_transaction_prepare()`,
>>     move the `string_list_has_string()` check above
>>     `ref_transaction_add_update()`. Since `ref_transaction_add_update()`
>>     automatically adds the refname to `transaction->refnames`,
>>     performing the check after will always return true, so we perform
>>     the check before adding the update.
>
> This change makes perfect tense.  It is the most natural to check
> and modify at the transaction layer the .refnames member, as it
> belongs at the transaction layer after all.
>
>> This helps reduce duplication of functionality between the backends and
>> makes it easier to make changes in a more centralized manner.
>
> Nice.

--000000000000f2f63f062fa960e2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b14a65b81f87bbd2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSmJ1d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNUI5Qy85K3VQOHRFMEtXbm5xOXZla3JpSk5ETVJjMgpiUVI3MGxzTjJ3
bUdqenhJV3dRc3N0R1BzSTg1SVBZb3NZY3l2cG1nemwvYzRqenpKSFFVSmRwWlVkdnVQcWRGCkVq
UGt3a2c3empEWm1JWVNacVdWYUdPd1QzZ3QyWlVxKzNFY1FkR0VibmV5T3Q2WEY1c20vZTZwVnNj
U0tLQnAKUjgvdk80QW84eDBwc1FIekdVaGIwWHRWNTVoUVVqU2R2SURMRk5NZ2pveHRhd0RQRTJa
RFhrOGI2ZWUxdWtiZApCQmF1bmZmR1lpMDJpZVhoZzRzOTBsc2p0MjR6SW1jRi9UVU9yZmJlYXJ6
ZEV4R0hobU9HMWVPcmlac0ZGbENQCmcrS0QrNTM0bXhxWTdyVThlbXFpZ2NMam4rSm5MQytEeFlV
VDBENE1NWk42b1pXaUFOZmhqNUh5UnZlRHo3WnQKTkZYRFkwOWt0MUxhRmRyTENrWUVzQmxyUnBq
Rm4vM2xmU3Z3RGoyVWxKS1NFWTlvaFkxdEZlN0swbnBNY3NMawpMZVpvYTV0U25JcXJ0dWRuV3gw
WEMrQVlQc3NMbzlIbTRuRGNqWHRLN2xqbjFPYTdIdGxJWjVGbUROZk1NQVNDClJ2RWR4SmZhRDRB
UGhJZFU0aFF2MHRkaGJWSkUxS040M096UFhxRT0KPXlYOEMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f2f63f062fa960e2--
