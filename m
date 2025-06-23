Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992F8AD51
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670806; cv=none; b=Ri9TPW47B3Facb2dHmtsLY+Bm6TjPjrLQWfr0UbQWSwJxfllyE8ib8CHu1Wkc1+bKyBvMDVnJ/TYcT5k6MCabX/LfEUy5oGRQQmYA4B9f0LrX1NhBxeX2UyKsAfyVNhwPj8SwA98fWqcbQ16FDfIyKqZ/x+rCwSi08S7c3yb2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670806; c=relaxed/simple;
	bh=WnPjYD6sY7faFUQCqD6KRfZYd1BDv9Whh7oWyltcVtM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EH1jGbA1EGJkBRDjoYHwflDwlDUBV2pgClGggJ2ClIDtXjvauK04DJZm1LOQq+3zMODwhvO+qfH0CH6LsHoM/eV60AgS81IwjE+Xp9b262bGZgWHAerfLrUH5LgHiFZU5D4Eg7eKQJKX6VbqTQiycoC4T0pWogW7urQmtaFZRG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPCAbqR4; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPCAbqR4"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e8110ac0f5so908493137.0
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 02:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750670803; x=1751275603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bXWWfhHT6ya0OUSueWDSFRq6Q43bWmmRl3C18aOJWE4=;
        b=SPCAbqR45TlRyTUGe1GmAUDDAeMcfRRYyX904/Rzyhl4c03VJrvOUGhDUrk4dENVG8
         h6nd7zObbm0rZgVNbmNPKXiCEu3A0uz5syC8Bws5/S4J1viLHdhl+tYccofbRlJRIoIi
         YkGkTolh8+HXEiKF0dQxDMErSkUmkEpHD1mXtlZgU5PyARB4Ej9OCmd52M2tAhaiAxbn
         ues0WoIuI8BJ96S251cginFevBUCK1lmBEweAj2OB8S4hNa5+e0qU1rY7ttDZKQNLbUB
         ZnumbivbzQxOT/vXIBRfR7QKvYMh7v3l5Jc5+Yrj6J8rm7789wZ8uRGb4j4W9kEt/V/i
         x/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750670803; x=1751275603;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXWWfhHT6ya0OUSueWDSFRq6Q43bWmmRl3C18aOJWE4=;
        b=ajm4hqgg6KjYfMI8RKFskHGXxafJwwDEO86U5yJl+DmKuQhJJ7v4OKJJEKCfWW0ZO9
         xQewmi1SpN9THULp4GTu2pAd+wK6ehHi9phMBMAbv5f3p2CzlMWVBmpeeSbmCEF4B0Br
         5QLX3MqbXXKuT7NIZbmO/mhwjcXLCaqSKPj2dmGtZu4doFQ7fV+vRpndhXf0rIdOSK9B
         vaNS9R6BClEjoN9aD9yH8MmPKytkoqxn5LGhHUv/nrFyF0vvrRpu2jBwXzxDdzivcMYb
         /Cm5ve/GNmW/+e+UQz0TWWLzwT5pHGf/NZ4Qhi7nUBOZgiRwPMD/gBggKQ6/kE4NYr15
         J+FA==
X-Gm-Message-State: AOJu0YyZSUK47fZ3sxSw8X/I6Azki8l+FFIe/49VNy//zeFIqjTJf/5X
	OzSW8HRS3udIEb7FEgjg65OqPShDJnM+qiDKU5tRtQeiSaN1rojvCU5EObDXqw5DiUVkbv7HwXT
	xXzSupqc3d0kszHmjnWsOiz4+QT2XWhC+xVRrTWMysg==
X-Gm-Gg: ASbGncsBr2nWiGM6et/tS+6McIej4Fiop4Ypi2jlZEkEA0h1YhwFM2Se5gcxcPng0NQ
	PYQN04W/LV6SfB1SVEk9eR+0V3KCk0mksXfDqrn8apF3Z7TSXqzT8LR8WnyXZ13geUI9DckhdCX
	mepkXnXZpFwXCjWLW4EV5pcwEFMFqH8a+A1evOWHBV
X-Google-Smtp-Source: AGHT+IFbtn8xzyTST29N+1vpp47ac1hr3/4JJAhszzUHyJ4PrqFE2WhsM/tbFZNniFOVA6JJPu0BfxsGjw8wxwRxD7I=
X-Received: by 2002:a67:e708:0:b0:4e7:dbd2:4604 with SMTP id
 ada2fe7eead31-4e9c2a0487emr7117840137.17.1750670803514; Mon, 23 Jun 2025
 02:26:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Jun 2025 02:26:42 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq1pre14ae.fsf@gitster.g>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com> <20250619225751.99699-5-lucasseikioshiro@gmail.com>
 <xmqq1pre14ae.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Jun 2025 02:26:42 -0700
X-Gm-Features: Ac12FXw14lAwigsTpXQoeOiMtlUz8INYDgW0239ElRVEvYsw2SbyYFFy9aqvKIM
Message-ID: <CAOLa=ZTCoc9vfeMrWxqU5psmbxGzW=B-QULeSR+uvF9kQi9WzQ@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH v2 4/7] repo-info: add the --allow-empty flag
To: Junio C Hamano <gitster@pobox.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, ben.knoble@gmail.com
Content-Type: multipart/mixed; boundary="0000000000005cd363063839cf54"

--0000000000005cd363063839cf54
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
>
>> Add a flag --allow-empty, which will force the output data to be empty
>> when no field is requested.
>
> I still think we should flip the polarity of the option and give "--all"
> to iterate over all variables, and by default show nothing.
>

I thought the idea was that we would show a subset of the fields by
default when no user input is provided. Which would mean we have the
following:

  * `git repo-info` which would show a subset of all fields, giving
    important repository information.
  * `git repo-info --all` which would show all available fields.
  * `git repo-info <fields>` which would only show the requested fields.

With this context, I'm not entirely sure where '--allow-empty' fits in.

If this is/not the case, it would be nice to talk about this in more
detail in the cover message and also in the individual patches.

This is also a good time to think about if we should make the default to
not show anything as Junio mentioned.

--0000000000005cd363063839cf54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 63478f84876c3e90_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oWkhkRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNm9tQy80c3pIRGo1QTAzZUh0ckdUU3dCb2FuL0xZTgpHRDRLUDRpK2ZG
OVFLWm5NYUUycmZ6SEtGbVNBMll6NWZLTnVkTzNxRXVad21ON0FqR1Q4N2ZXU3UzZldDSVVXCnN3
MzFOa3Q4cjc1R1BKWXpwNlF6T1NFZlFDejFkUkVmLzJHMnNqTUhiUkxwNld6Y2lGaTc4NnlPcXlU
cjJlR1oKZ1RzUzhpelRzcFNJNWdEQU9pQnE0V2pKQmFEdUZwQm5MbzFEZ2VablNFWHBJUWtTeUIy
KzJFU0p3azd5NzkvVQpQRExRRFZod0FmQzFvYmZsVHlaNGM4bmpGdnZ1T3hncm1KbTRYbjFQODRw
enNTK014TnIrMVJKd09CcDRhaUxuCkw5ckFDSk1ZYndKWnY2V09Wbm5MZ3ZlRG5GbExFeXlpS2sv
Z2x1bE5wY3dZZjJIVDJyREh2ZU40V0lHay9BZXEKemZ2VnNjV3VudTIxbnFTZjExOXkwUEVZQ3Jl
b1RqMFNqR3pFeTVaOEY4KzMweFhSdzVBbml4WEZFamNnOU9EeAphYmk1ck5rcEt5amdMdzg0NHBI
K0VLdTU2cGVGb2FXb3BnTE4rTGVFYXdHVUQzcUdaTmp5ajRaYlUrUVhZMlBKCkRRbWhkNUZzL3BG
cmNmMmoyN1FuaEg0eDZzMzRIZFp0RmNLVEY4Zz0KPTRUVDgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005cd363063839cf54--
