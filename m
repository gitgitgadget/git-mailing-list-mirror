Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0D1F9415
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649109; cv=none; b=fdksvkDdLEr3ETe9ZYRiEWUvrlCo1MdKUmF/dut3mdj2lwX+vontaJcvPBMED+vJvSdGkqDsbudHfgsWGlxhjl4Kk7z/YozHqg6qCh6MEwJgcRxc65oVAP0h7gj+tCQea4Gnsi2KloKcfgNt3PusJs5flAdVBaU9Iu20+5veUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649109; c=relaxed/simple;
	bh=mkGTkoHjZrifXLaOp6cCjUcFEYqAEIipji3B7Yg/Y98=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDgUNXHw+a/sNqcD5yPoAPFpUeVil4Sgjef/2OQ1tciSzmyBKZ5dMS2lV78lFbDkujS6lymfvtvS62Z8NaLXtsyR1k5tZupqhMJoFmm+Z4SHFrg9nSwbrGKvOpx8RhABPlF1+T5UfBguDcL1dRcSu4EztSbwrAzC1x/8PYnQsF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkiyyUP7; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkiyyUP7"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50ac27e3530so1688603e0c.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728649107; x=1729253907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cf05sKNVVi4XGi9qvLN4zzAUzrbs6DBuhJkfW853F4=;
        b=JkiyyUP71a6Y3DkGnNThWHd4w20Qg+v/4M97ahwq7/gUXUlyMkvlAJhzaNTawqQPwJ
         SKPTPMvwei4fsKwnpAlnA1TzgcAqZiwhlvUI+pNlDcsoxv+x2mtxnjieGAKF9ZYxBxVC
         YHP2uRV7DUkIzaVE1e0OZ6//BuZWlaRpOfRSuE2gHC08EjY4YzPztp+hvVfCKf2DxQ8l
         R/ryJz0f4UrvJB1OmeJaq+RpwJVRndzRYo6K6Now3tFsvSCjDF81ajBvOLydJa42s5Pe
         1tYI2iz9KD7bYjJFiwhlUIemsYC3wmtPMqzwtUN53/wiXBOzkufhose9zOR+yQTw3joq
         xsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728649107; x=1729253907;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cf05sKNVVi4XGi9qvLN4zzAUzrbs6DBuhJkfW853F4=;
        b=faGc3VMuNIu7plzzKWLOj1flj3002UwJaWJFK3KDdd/BxAFVE0IryrnG/sSudv6+Xx
         0/iTVrxdv2mrGR5qWuHoTZjqCB3X2K4d1JKuH5poHp88Y3+RTy49yrc+uS1BtfyMqYgq
         bYTnS12K9iebL89+dpr+ynFQcJeLBzRLRrPSEoiXfX6W6rdzSVU7Q2rhj04KptYlExkC
         UvVqlJY3bYFfK2Nje+qBhhoNVZjDsuKxBPdI18elkfH3f/3t9XwVKXvPaiAhmv+eTrP/
         u8U3172icWnJY0lxkGcClTIq/ouT24aNOQY5kkyWiQ+/utLWIsgw5abWjMatZ3Pv20cE
         j4mA==
X-Forwarded-Encrypted: i=1; AJvYcCUVduufEL5FmycUdZvFOEOCpxSvQTMdHsnPucBsiWJxBWLO92C+/9BDk/BNqE48ufaIbRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsqOwHeL959y08R7Amdv91w03FlUCaezcZ+PkNNRxG+EqDNX6w
	lVX3aHVxeXqXW0gSVMX5g6HS8eQb5WK+muQBYCwVQt2SPCiA5R9QIWvjK3FzIlqLFvraVQj3qmH
	SCXxpam2mvN6X+bDEfLBW8sDwk5Y=
X-Google-Smtp-Source: AGHT+IEuVLTv2XYbeZV+CUcsqQuk2UZaLArFpp2h6j/nKXQ4qHR5in5EntauYx1JZoRwTPcbIwuPTc9CVQok4eA4eA0=
X-Received: by 2002:a05:6122:178a:b0:50a:b54e:79b with SMTP id
 71dfb90a1353d-50d01963076mr5474001e0c.1.1728649107014; Fri, 11 Oct 2024
 05:18:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Oct 2024 05:18:26 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1728629612.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Oct 2024 05:18:26 -0700
Message-ID: <CAOLa=ZR_fcq0NyraV01FQBeOZ=uv7JWLV0+tSsi=zsvt+VZOdw@mail.gmail.com>
Subject: Re: [PATCH 00/10] reftable: stop using `struct strbuf`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Content-Type: multipart/mixed; boundary="000000000000f7351d0624327b74"

--000000000000f7351d0624327b74
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second patch series on my quest to make the reftable library
> become a standalone library again that can be used by libgit2 without
> pulling in all kinds of dependencies from the Git codebase. This part
> makes us lose the dependency on `struct strbuf`, which is done due to
> three reasons:
>
>   - To make us independent of libgit.a.
>
>   - To ensure that we use the pluggable allocators that users can set up
>     via `reftable_set_alloc()`.
>
>   - To make it possible to handle memory allocation failures.
>
> While this leads to some duplication, we're only talking about ~70 lines
> of code.
>

I only have a few small comments, but overall this series looks good.
Thanks

[snip]

--000000000000f7351d0624327b74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c1e6ee8548116c8f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jSkY0OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHNlREFDTVBqS0ozUkF5N0tIa24vamcvaXczaGhDSQp2QkdsaXBhb3h4
djRoYmd2T3Fzdll1dzRIbjZGenQ2Sy9EVjcvUHF3cE02WU9BTERpanJ6WEdjR1llNFBCd3NMCm1P
b2dnZGV5dDgzLytrdDBjUEdsTUhXWEdUTnRuV2I3RC81NXpYcm4zTUJ4ZnlXNHhHaVZ6dnNZcWIy
dDhSRGwKK2RXSW1XRzdtbTZTTDIxeUQrZWEzYXN5RFpHSEYySFY2Q3dBUHlNT2twWXNiQVpieS92
RHVlYlpYZUpFU1lCQgozd3FwRVR5SzJGcWpVeVFUdTFZMzExUTh3T2VTUlM4UEx6MEpRUGw3K2F4
aitvbi9PdVlja0NnZ2IzOHV0RysvCkN0djU0ZEt5T3hFZEFpY1o2SlpKUTRoNkJPaG95SzVNYm52
SFJtQ3JtRkZNQjd6UitTd1NhMUpmRmZOaXVFUVEKZTg1ZG5CS1R0YzVVV3JlMWM3L3FNZllMRlps
WnZqWmVmNktnZ2hnRVRyQUxmM1djWDVBNTZpWlRHVWpyRnluaAp2Y0g2U1FLeFBLZnpTL2ZSaUtG
ekpYdG5TUlIvc1N1ZmdtbkYzNFNtaGIraFZwU3pzRkpFSllGZU5TWm5RRXNqClJBQVNkbldqTXh1
ekd3SWpHU0JWZDQwejFDL2NuQnhXOU0rWm5saz0KPVcxbEoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f7351d0624327b74--
