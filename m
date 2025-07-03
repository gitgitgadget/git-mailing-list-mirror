Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A62D12F1
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532113; cv=none; b=SL95GXgN+WpF8e1IVMB1Ofqzn70ZLiPswtfWapjmp8bXpPNHFvXjusMHrTHF1PvnjRQ9YhOTKKZ25T8nMU4XNMCn48enNkN9LMqY1ImvaVjU3LlAU4OL/SYNQSdU2I2o1lgOj70t9xpTVawVq0itmNciIrDdaVu+uWK6iJVXyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532113; c=relaxed/simple;
	bh=lSF7POnQDNArK9qTwuI2LSiydlkezRtKAPhH1DA5l40=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oy2FbjkbW/PzGmg3F7bi9V0yFe11s9CCf87A6bOuqO5MWRazlxObCx/OjaCRQwhGOK3qpM1G0aJspXCrV/eWlq7HGwb4WPAGXCwJba9WO5YUZuKpbdb3g9BkQWVyx1C8WVcyEG9Do5Hn/yqChErRKWAn1a/abGG8/c32zJHzNA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr2bQwLO; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr2bQwLO"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e7fb730078so1653686137.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 01:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751532111; x=1752136911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BVb5dzxgzylb/BsgMo2E73UtEVA4D93v9EsqAnuyZiw=;
        b=Lr2bQwLOT/Ogux1YMZtnJrH1hRbB9eaEdpfuLs+fpK2uqzYbAW7dHpHIjL9b7CZXi3
         RLKIvPrVP+ucvStRLifoEwd/gMisgIl8ZaxsCng6E2uRNvxuZ6IBZBIv7BiByjehDpzB
         7gzvAtj1X5xG7lXzcvWQ+E/gHY9Yq78ocSpoQuUgMR55/QD5zBhtPgCRqimKqKSXo6Wt
         kgV78t2SZznFJR/4RQPE7s8xGLeiOMrgm3phZCk6zy1Sl0LEmmSukQMVcqomRXER48/4
         pOWWXwXtNOzCkQyB+e3e+xcRKNbsywIHzrHDykt25f0yS/j+fTyP1golK9lL/swk8STN
         gJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751532111; x=1752136911;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVb5dzxgzylb/BsgMo2E73UtEVA4D93v9EsqAnuyZiw=;
        b=D6TGiqFzRabeumwrWwONj0E7rgln7CwZONyZv3w0mpgcL9vYLrcDLZWRUcLh2tSG9n
         /xAoV3PxPZp48/GDiF+UfdYSJmz3Zj2/daEYUd7lo3LsX0HFxZrCV6yvzWDbHLQ1b/1W
         Y4Hn2VrdUuTJujEszaC9MuNBprQw+sB48OFhaieikDaK/p4xsRD950dpTHipsmPbrLhP
         qgcIan4NRR8pkCk+twdMjCYQj1hn+MR0ctkQTisHgRFLdywyZ3sTNdHu4rRIrBQZZIB6
         nL4O9Xzz01k10LgBfBCsWuNW31dnyh+CPhXd/kyKPXc+egNpr6x40emIU700aJRLY54I
         sNHQ==
X-Gm-Message-State: AOJu0YykYjt70vkixztLEjkCu+O1dUcj8LecSAXGJ+hIHR7XAcqNpMLY
	WLYZ9E/lpA4dhftOKDUYpA8Qt2UHFNhkJqqDuZ6VAxnd4xgR5oE//udVRz4fFxFndB/qtGWGSVt
	KuFCkXD58rre1orh9EkohOjHfTMCDLM4=
X-Gm-Gg: ASbGnct4FuO0UeEAs+ijhiUT0NQQqo1g5t6K/0ax3yW2OybSfrMCtvHuonbdZ/xkmDc
	tsX5AlQnnAE9D4dmPzLgMUY/91F4MEb+VgaYTpYvDvEQWdBWLsMa1gNu0f+1cXMyZcW9kbscv4v
	jYbYCsV2azA5sv5hmqty+r0ShsjPIKvMjw13BwFxoUmQ3gvovC6+wYkRU=
X-Google-Smtp-Source: AGHT+IGr4h10QgiBfb9y3+sfzu204w3NbgBxDuBLKmncPU2Xq7PJwwaNpCFw+Te17I1XNaOzAuJHuNG8Jyqy2Awp/kU=
X-Received: by 2002:a05:6102:689a:b0:4e5:a0a9:3ad1 with SMTP id
 ada2fe7eead31-4f17479c21emr2042298137.2.1751532111111; Thu, 03 Jul 2025
 01:41:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Jul 2025 10:41:50 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZQZcX7Bh=63Bv5Sti89jsjq=FzVbkqqsP5Tgd7NzNr96g@mail.gmail.com>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <xmqqms9niod7.fsf@gitster.g> <CAOLa=ZQZcX7Bh=63Bv5Sti89jsjq=FzVbkqqsP5Tgd7NzNr96g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Jul 2025 10:41:50 +0200
X-Gm-Features: Ac12FXzkDSvVXxEWLJpOXmw5JxomauEXeZIw3dA1B4FBhtJLJEfwPOgzpkdvgKI
Message-ID: <CAOLa=ZRkBFdKH7ui+K=ocnYiTx0uJBppXHbFuhP8svCfWnN72w@mail.gmail.com>
Subject: Re: [PATCH 0/4] for-each-ref: introduce seeking functionality via '--skip-until'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="0000000000004bc9a70639025975"

--0000000000004bc9a70639025975
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Offtopic.  After applying this topic, I asked clang-format if it
>> wants to change anything.
>>
>>     $ git clang-format --diff $(git merge-base HEAD master)
>>
>> The result was disasterous.  Can "clang-format --diff" mode be
>> taught a bit more focused to avoid touching existing entries in the
>> same array (in this case opts[] that has tons of options for the
>> "git for-each-ref" command), when only one new entry was added, I
>> wonder?
>>
>
> I couldn't find any way to do something like this.
>
>> Also I am not impressed by the change it made to the code that is
>> commented out (in refs.h).
>>
>> Line wrapping it did to refs_ref_iterator_begin() is an improvement,
>> but those to ref_iterator_seek() and do_for_each_ref_iterator() are
>> unnecessary (both of these were more readble in the original).
>>
>> Even though I found its output better for Toon's "last-modified"
>> changes, I am not impressed by what clang-format suggested for this
>> series.
>>
>
> It indeed looks really bad, I had a go with the new changes from
> 'gitster/kn/clang-format-updates'. Which seems a lot better.
>
> However, this does show a problem with using 'RemoveBracesLLVM', where
> it formats the following:
>
>   if (...) {
>      ...
>      ...
>   } else {
>      ...
>   }
>
> to:
>
>   if (...) {
>      ...
>      ...
>   } else
>      ...
>
> Which isn't our style, I think we should completely drop this too, from
> my patch series. Let me go ahead and do that. I really want to strip out
> as many rules as possible to make the number of false positives 0 so we
> can actually start enforcing clang-format. Once we enforce it, we can
> slowly see what additional rules work well for us.
>

I did some more testing here, and it seems like this was because this
particular instance was more like

   if (...) {
      ...
   } else {
      ...
   }

Where both the clauses had single line statement, but we only modified
the 'else' part of the clause in this patch series, so clang-format,
only suggested removing the braces from the 'else' clause.

So all is good here, I think we can go ahead with the
'gitster/kn/clang-format-updates' and merge it to 'next'. Sorry for
being the false positive, I thought I missed testing a particular case
and the series.

--0000000000004bc9a70639025975
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5cf897da04a28057_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1obVFrc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmtuQy85NDl0eVNKeU5sSW9lUnl5TjllOXU3RjZWYQpqcnhkbVVMa1NQ
S0puelRZOHNienZob2R3KzlBeTlaMEF5N29VQng2U05qamhHQVkxNFVObW5ZeWlLNjRiZkt6CjNK
NC9FdHN4TnhNOGUwdG12U3RWV0lWT01HQlNVRCtBVGdBSThQcjUwbXZGL00wUEhrQi9UNlVoWmxO
QXUzRWQKTGNoQnd1RUNDKzdwa2lZZGllVm1Iekp0U1c0UksrSFJSVXFjdk4vUWd5OEdGQ25WSGZF
UDJmL0JuaEczTENESQp5YmpheG56ZzFDYno1QXU4S3hMUnZpSDd4N2lFdHBGT1ZWT2xFZTFTang4
Rm0wVTYvOG9UY0wwaVBZSjlkMTd5Ck1Rd3pENzY2S1VaRkU0WWdpck9sT1Bab3Q0bW1pSzVLcWhp
S2FJSHV2YVFTTm5lMENtSE5oYjhjRFdEVlBrWlYKWXpheDZNenRDMUFHeFBaNDVuYUozQ1dLakRR
WURkUTFrQ0hpUnJBV2lWNTU3Nkd5eVBPUEhpS09ZMlhWdTlNZApIN0Q0TVRPS3M0blBYL3ZYeHJ1
aGo5R0NTdXMrU3MwMmQwbHVIVTRIdGt0UVlGbWZvS2ZxS29UbUo4bHY4d2tSCjBISnkwVkhyTnRq
Vk9SRkFYUlQrRGhNNTRMVzlwemwyODY4bkRmdz0KPUY3R3UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004bc9a70639025975--
