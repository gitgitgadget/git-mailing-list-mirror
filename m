Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404A1A275
	for <git@vger.kernel.org>; Thu, 15 May 2025 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294781; cv=none; b=jw/lBFXPSLlWpfg0s7G3hY/Qya115KwQx/7zL6ccQMa3kl3n/34HAtGkabqgI9ezs/RVucCyc9oVfv6ovKMrBNMQ7/0ZB36qGIrmFkBRm5z47rygZtr73PN4f9WZOc9VqBSMueKhTRjMBy+GSktY5BBWd3Aon03mLxjsykZSxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294781; c=relaxed/simple;
	bh=/LgbvS4fXWMCXMr8C0s4rY9JDM7VoGI3TV5jyKpdwSk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=mdyeNYtosFT9QSPKaYBIUnxJ2RUxVulSAa7bq4cdNERxvfFXKZcFyXbCTBWE4SEnXHXky5scUx5ofulFH6iTxU8oGrF8uZYZGqQNgIN/+80yLea9eI0En/e8XFmSZOcgXyPpwFmfcnYsuxRsXtZ5o+j21GDg+V5pyvU9to8ii6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPiP6LE7; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPiP6LE7"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4de6f1cb406so222394137.1
        for <git@vger.kernel.org>; Thu, 15 May 2025 00:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747294778; x=1747899578; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LgbvS4fXWMCXMr8C0s4rY9JDM7VoGI3TV5jyKpdwSk=;
        b=aPiP6LE73msbu1k5doTZwkFiaCkB0OO/+u4Kk78nK7i7zxL5Rewn5rG+ThZkzJl0/N
         ri+BOQYu9He1lQer1KUom2xfiwX56P7NlxeFI+HTW4UHSMiOnsuXNSSAbWGlx18gaI7r
         09lwTCFpjRaTN8mwJb/7Ng5fDS0iHyyJ9VVB4WrS9dl6T/lWLeIFp30+RhM5ZySBwQ5u
         cO4EoaUzMFZ+Lnw2CMt38u7jN9UHluj5zOom/9c590DGyhIne3RfNx/8xUxTTSlX4P5V
         SYJbJ+CbbRcdXFfT9bqOW931MCZ81YyhQCM0toGpkr14gCI0k/0sBpQX7Cb+F3uzwdVp
         6BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747294778; x=1747899578;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LgbvS4fXWMCXMr8C0s4rY9JDM7VoGI3TV5jyKpdwSk=;
        b=qjHjyQVIed2me/FOyKJRIoW6niCtM0cqXmNIT1uK0tcz9VQ2zDSR1dkhlaC0B4+XQO
         bNsDdIHiWBoHupAzH4Vhggdnsr7iajh9PIDrKtjj4TKSvLBvOp58VVFIWiCW5yRyr7VY
         7jkpnQemJfeyt+MWnvX2+MBKU0+9sbsdz2zjuuTPRj9+FoVQC2LqfLhU658et9i+0OA1
         /oGQD/Nx+RF30TuCQrTsO+MubBjZhCmSroQMUH9t9qdMPMoEN2xNsMyV8ER9udxGRxsx
         +Je3FlDmSubZM24g0R/EQFyy8ZWJDt3t3AngCzUqYzlp3jFTI2OdLhD14I3URnK+XCyc
         UqaA==
X-Forwarded-Encrypted: i=1; AJvYcCUkAXsrUi83qgxIutLdSEvJNdPUDEvtNsigIXmkkfVNkOsQdGwOS8fLTRLeZUCXibPHnVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2P+/J716Cwgc/9f+iLgDwmCHDbmp7LNw2vxhXCJvZpkbG+e7w
	EtV15wyhzFJIwC7dIppDLoKskI/Zrnw88AJIutTnjSRXzT0K2+884gVeaVZbF6gdJqMCU5rKfBc
	icEgusQZsSs5WBJDOoRAzFkcLx1LMCLCZ
X-Gm-Gg: ASbGncuWvN10jwKmJxaeTkP5ksCLsNosFbPt2Uy74OTvRP9WDa+nZ34w6rholsPkTRi
	BpRpgKA/tmuVt6S6Dh1rm8Wtyt3+h3Fc7TxZhlBuQslaRJX852jt+z13G4e8/47MFjOiN5ldIRs
	00O2JhgE3LdAX3RxZ77iOotgQf1IAxbRE=
X-Google-Smtp-Source: AGHT+IG/Br/NEX27RYB9zcHylUUa5Yny6xRl8JdtZmED1Klbu4rcISPPriFZjafF9H8FkpPzO8xwqmgq1VFEr3qQKF4=
X-Received: by 2002:a05:6102:3e24:b0:4c4:df5b:330f with SMTP id
 ada2fe7eead31-4df95673dbcmr930596137.17.1747294778251; Thu, 15 May 2025
 00:39:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 00:39:37 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 00:39:37 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250506-pks-meson-tap-v1-3-5aaab2942a4c@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im> <20250506-pks-meson-tap-v1-3-5aaab2942a4c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 May 2025 00:39:37 -0700
X-Gm-Features: AX0GCFtlCtxPSEBUSXTSf9rhvvzQXW_wW7wamhGTeXUofrWhPt6c-MBu8q9NRN0
Message-ID: <CAOLa=ZQ=JfJ+KPShnoam5xkhxg6wbX5hqguXYbpxkLvf2e8kOQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] meson: introduce kwargs variable for tests
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000093a944063527c4b8"

--00000000000093a944063527c4b8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Meson has the ability to create a kwargs dictionary that can then be
> passed to any function call with the `kwargs:` positional argument. This
> allows one to deduplicate common parameters that one wishes to pass to
> several different function invocations.
>
> Our tests already have one common parameter that we use everywhere,
> "timeout", and we're about to add a second common parameter in the next
> commit. Let's prepare for this by introducing `test_kwargs` so that we
> can deduplicate these common arguments.
>

This is a nice cleanup and a good to know. Looks good.

[snip]

--00000000000093a944063527c4b8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 813d67470a60504f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nbG1qY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmk0Qy80c2hZWkFVOFUxeTl0Q21CTmUycjdISFVFNwpaL3Z6VVVkV1ls
dUd5T2EwNDM4N1VzZDhEc0l5bUJBcGZLWjNuaUpsS2tadzZwVFpscTNnei9kKzI2WThPOHRBCkQr
MDZ5SlROS09aV1lycnRFZmxicHdCaTlUNWhhK253YkxtYUtldWhqRG45c0Nic0lGUk13aFZPUDdy
b2xYMDEKRm50TTJIVFFUcm92WTZhL2NBTFM1N1RSVjFvMHZlVk5RYkxFOG9mR0I1ekdSOWlIZkFZ
MTFjNUx1bStpeDBvWAowYXVKbUtFTkNEQVE2OE5DNCswN29hWElzOExPVHd5SFQzcXR4ZWV5bHkv
T0hVaG9BM1ZmT21aajJGbzNHb0h1CkdrQURYTTF1NHhpSE5WWmNVL2RrYWo4c20wT3pEMVZyTHNJ
MW1MemF4WnF2YWpGTXdmbEMvcnU0aWpXODRBZHoKcGRHUytSSFhCblR3STlkTXQrVnIyNFZEdWJq
cjZOelBreXZxUnNzbXU4d1lQd2k1TlhncTg1Y1dJb3VuckszeAptK056OG1KbmhNTkZRMTNFOFBR
SXJRQWdUVlFUQi9Idi9zdVNGNlpWdDExMzFnSTFhTHhuTHBjYjhUUUZyc25sCjc5WklhaCtDRkZy
Y2hlZk5WYnFiUEpiTmZlZ3ZEK2ZKS3hRd0QwOD0KPW1yWjEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000093a944063527c4b8--
