Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F1228381
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523038; cv=none; b=txkSytF2vxCpgpU9Aw1RpC903VQ4Z/35HS7bu22e/PC2C01JpxJ0UT8ej+NfzEQ/LMx0uRZbbIi5cA+tiCVRzfe8SSt1Yi2DUG3ROR6kcPAQTjBRXgtCfJBgi10E4kYdKD+QMeedgOxAw+S9MPmvOlmsYz8r95qSNw3sakK8EDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523038; c=relaxed/simple;
	bh=Xu56v4mJKIsojHoJJQRx4DFB6wDRAvkaTfgpZI9ZkGw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ui/z6PYZLB1pgtvFf56lr3z1jrKI6cPzC4mW/SgvO5o5zbzJmpN7BkIV0ud8J52Z4/fy3B8+o/78sSaPI9+qM+0GCVMH3pcWRaDrpeJTDt4tTpVK6lTfBhLvaLNTE/GSdnPsSFNE17grXzyjhnPJkTgmo8QpWQae7g6nRnv1P74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMsCn/Bh; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMsCn/Bh"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-868f19a9421so756725241.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 00:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739523036; x=1740127836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8h5Oz7IqPTbZGTQdzqwG+bXLAK4rj97LtM6gswXrqU=;
        b=KMsCn/BhRHfyhR/D6QTSFy09taV3950BR9VzKIytYuE6wiWZUtLfvN9EjK1d2Vvw2S
         cxOCxAJfbhy5/lE5/MswO8lUA4gUWnF8sBMCAbslxcmNV5VlBUkznxY7tuh3GSa7T5qa
         Cv7LNT/no1kT4F37vzTMGZKYh1pvfFuyDQhu//shTP/HGDEcGNY3vOcZSr/GSg4kjXMH
         8DWLVMqfVGA8UazzfVh+hILEBsu+lnQWql0TBMC0T19uN2l5soL0mlQXaW8UYal+XItg
         83P9XEpclTQXWWTRy1reRsfuTVbEevjDmyfLMmKlR7ajvV9gmqdyHDivFsH+j2uj2Nto
         UplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739523036; x=1740127836;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8h5Oz7IqPTbZGTQdzqwG+bXLAK4rj97LtM6gswXrqU=;
        b=RnooUWfeVFWf0mILkmDQdkPJlYLff/oqXIYhE/DZfq8e8FF1v3it5b2W9EjbMou0hN
         NISsaTZuC7zvwgwcr4FxaBZe/GQrGr4boF2jeIqmrn2HwELfWURK+2ZnCpQwvr2U05Oi
         HjeE2/JVcrBNxgQacAWXvXY4H4Zlc6SmsXo7kLz88JPKsmKOWWGpK4AGmMR4QjEkOZCN
         A2Tl6IlrydGTzTdh+FflXHwti6xqThd3LVBhKRuAZ5NzkLYGLbSF/xdA3qsOrAp3/DbF
         YK4cgQJGOA7cg1kcgqJ80T0p791T7ISzorUInWoMXQe72aJ5t1pYQVNMzOsdIjUfKBGi
         +zKw==
X-Gm-Message-State: AOJu0YyYiYF1RU8LRQbw+mUw6fK2WTldZoeZcX74Tx7WbcZvd9+SP/zg
	qlOrQZySXH1+/gTyuPPRDS9lKheARMZqnU0JjgVdIh5UZdahaTxMk3W7DKW1rywOtTlic2SIT15
	V3wQZu8odtYWGIVc9V3WIR/RQa5g=
X-Gm-Gg: ASbGnctah4jmdqgXRyrsXS8+0xTMCWXi7P6fD4CiW6UTfPqnLhWkzXYlTOTGZ+Ur9CN
	2Cw5h1sNk67nI0mUw+7F2bKM51UANpFMZ95Ey5o5Pxb3oNklD3shPKw7XWzphLrlCswb81WT34A
	==
X-Google-Smtp-Source: AGHT+IGFnkdwftjnkBCEzHhjuHPPrvetDVH1CxE9REuPuJ0ZSfVwJBcSU/DXhiQGBq8w6CSoCpLWo3egyeyEsGlHFFc=
X-Received: by 2002:a05:6102:4a8b:b0:4bb:cbbc:38 with SMTP id
 ada2fe7eead31-4bbf2071f12mr9016464137.5.1739523035863; Fri, 14 Feb 2025
 00:50:35 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Feb 2025 00:50:35 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq4j0xpvmu.fsf@gitster.g>
References: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
 <20250212-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v3-1-98b2c4d2bb0c@gmail.com>
 <xmqqa5aqu7g9.fsf@gitster.g> <CAOLa=ZSDLNLYQ=zsoOqJW6KhcUqeDahNfhG-n9k1t0O6B40OnA@mail.gmail.com>
 <xmqq4j0xpvmu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 00:50:35 -0800
X-Gm-Features: AWEUYZnz8Be3Wec-mn_ui8_J7wRIyNjIBzwefAEf6ar0blfNw6pV0je9dFwEMTM
Message-ID: <CAOLa=ZRVPkPVwJd_Ce4krf1FzqEudh-oSCDUPkjwYAmfRMP1=A@mail.gmail.com>
Subject: Re: [PATCH v3] builtin/refs: add '--skip-reflog' flag to bypass
 reflog migration
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000a1be77062e164488"

--000000000000a1be77062e164488
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> To just get rid of reflogs from a repository, I think 'git reflog drop'
>> or something similar would indeed be a better way to go about it. As you
>> stated, with this patch, we could still face the issue wherein the
>> administartor could re-enable reflog and we're back to square one.
>
> Exactly.
>
>> Why I think this patch is important, is because while there could be
>> existing reflogs in a repository, if one doesn't care about _reflogs_
>> there could be significant performance gains while migrating repos from
>> one backend to the other, while also leaving the reflogs behind.
>
> Sure.  It could be done with a combination of "git reflog drop &&
> git refs migrate" (or "git refs migrate && git reflog drop", if the
> migrated-to backend performs better when it drops reflogs).
>
> With "git refs migrate --skip-reflog" alone, we are very limited.
> We can lose reflogs _only_ when we are migrating.
>
> Doing it _during_ migration may very well be more efficient than
> dropping first and then migrate (or the other way around), so I do
> not have much against the "migrate --skip-reflog" existing.  But I
> find it backwards to add it first _before_ we have a tool that is
> more generally applicable to wider situations, i.e., "reflog drop".
>
> IOW, it feels as if we are worried about icing on the cake long
> before we actually bake the cake.

I understand and agree. I do see a lot of benefits having 'git reflog
drop' too, so I'll pick it up and send a patch series towards the same
next (as soon as I send in the next version of the partial transactions
series :), which is taking me a bit of time with some other ongoing work
at $DAYJOB).

Thanks!

--000000000000a1be77062e164488
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f075556650c90050_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ldkE5Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHpHQy85bFZZMWpRVVZobzdoQTYwUHJ0TEc1WlZUdgp1bSs4RHpjVHI2
NTRhNkp0VUEwTGFOcUozc1B2WVJnUFlSay8zN0Z4SG1lY0FMWkNxa05IM1VNRUhaM25oaE9KCnBu
VkdkczZZQjhOSkJieXNjRlZGelNSU1ZIV0lmbWVYYTRiaytHSFpvejd5Z2hoZWM1anErQUwyMUor
dWtQY2wKSS9HYnNhRWtBYVFYOGtIOUlxVVF3R3FVdlRZd2JjWG5LcGZNTmdGdXFYeHlMODByS1JQ
TkRxN2ZIbVloMURQQgo4VS9PREpucFM1L3p3c0gwamF5cXJrQVZlWVY4OEsyeFNXY3FVbkVrak1Y
V3I4WVdLbjJ0OHVkb2EwRjY1WVpTCnN4aHUrVnkwUTVGK3l1bUovU3RrbVpyam5JbE5OWkNWU3RX
cHRWRzZEb0owS2xITzF6N3RRZzhjMDRxVnpURmkKZUQxekVsR0tyZFV3dVgramdsZmVlWEswYy81
UGZQcWhEQkszeDNqSTgvT1d1a3Y3OCszV0dYWkQ5a0E3Mis4Vwp0UWg3N3oza0liYlFxVUtQY0E0
dVViaWN2MUNSc1JkNVNiZml3SlVMTkR1UUJTRjNTQ2U1a2xiOWpUa0Fjc0hkCmdtRDdUQ0VoaXhW
bzcyWGtsUUg5OWVYb1E5WlFzVTl3YlZYT3RXdz0KPTFiUlEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a1be77062e164488--
