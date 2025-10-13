Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2A2FB624
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345682; cv=none; b=pcuiz2xGJtunZ4BxGk1Q7qTCOqnPLdbzHu1ooo3UuyAOMygJkHgJfX5C/UUvEy/hTE+o2ITd/PWkAd2unffsLF/YyzTaUXP6bkY+4r1/c9nVMiEn1dP4IcNaU/TwJcxyGSN8pOPmRISiun7TJrgqk5Ij8hvVhEaBqu2Xq6vTeCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345682; c=relaxed/simple;
	bh=apycV02a1ykclSlANkfqnCSJvq7VpklP5epfX7Gu4Jw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdQoj9/1C4T835ImQ04LJTw9Wun2jLpp8nTdA2SH0OmPf4Q2clOyvi281aCsUUCNTOgMGNSmoDs3hyOyhUHw6lZ5NAKOKO2J666YcE1f3RLiOr2K4mbMWYx4tl1zFyRmg2kfDKn4uH4gmT8cyGzMU0YE1nyvJ2WZMLpT5+4vH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9Sc4VKq; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9Sc4VKq"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5d4018cb45fso1595591137.2
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 01:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345679; x=1760950479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DC5vZWgComVRyeogoEFyWZVoDzzWensS+k7GhT/Vh4=;
        b=Z9Sc4VKqMWkNcGPdPYJI0S0LpIe1pQMZf9/AUBp9hWsniv5TOM8LGpYrwHHyXOZpOH
         3XJ4V2a639A6/svSvBMiaf5xK3S9+sDxCsDKkj0bFB4/XcjJTgIoQLbzemcpejgFOqwG
         XQLW6K47Ca2GJ7GRvaDx3MMGN/9ye1xAzFisn/PLG+CYWqb+J1QKr9ef2Trtm9dCLgQl
         YLH7Lo62DKimaXOJbXtzCLlNiukxV/EmMzmihP95yq0m5AVzxRlMC/en36G2d11aMgMM
         G04Fuc5V94tBmFyMuVgYYiSGLIhXoBRVpQb1yMBPWV5r4/bspQ/dPLx9r86ft3kEBftT
         5y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345679; x=1760950479;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DC5vZWgComVRyeogoEFyWZVoDzzWensS+k7GhT/Vh4=;
        b=AKBWZoibs4a7x4BRcdhefTCPt4z2wwDATUVWBoFS9pJUdFUOQJDc4hpvtAE+DheQoi
         7GExkke61aKadLxGpx670ArjCind0CL0FfiHFt25jXVg3UAiJLrDs3lmgFAwDB3Uyp1F
         xATCtsy5xpd0h/QIKaLASiQa4zpLaWXpAswTmF+W17fWcZTO1QSxccxSpjoQDSMJtSuL
         PTrC1+6DllM6HtXvzH8kXmOnm/4lAAHoV+wzR64LI9yLH24cPTVVxfkEM4zffK1aWf9C
         ATMmNidCFdrTZuMEI2uGrUG29A7XUwo5nGE1coacPXBLDNt4wKXPXzvZIec6vbab9UvW
         KjVg==
X-Gm-Message-State: AOJu0YwAx9W2YFEVumLLGGbLRlgeF3Pt+DR/XNioHPqZ94J1ILqjqXGX
	aBMGT++ebW4q+a6XE+KdV0MxWR2Pdvj1DyXH+ftOMUB0IYWdaoEIh1lExbu2O4ui85ejKAK2M3K
	HGnS32Jgn6slDeuFDUpNDfPvcvbNwOO6H/Ja4
X-Gm-Gg: ASbGnctIorrK+5Al55N/2c8xYnR6NU96aBIj+NdbhkCpZX2v/mGUgXbSYJL/wD3dwQm
	V+tT5k/Buik0A1TJ1pp/08oDgRPveuRwmzEqfq6wZl8vnJBkPnI/0BuCm9+JH6oxB6NHih+tc22
	QfE5PtmivUD8mpFt1/+1Yh4XH/f87dMfKP3w4f3dUHirVDOvRLpCjxLvqdmHloGc74Dq0+yftNn
	cU2bwFmnhLkTBkbhe2o6vT8v24Yv1/5yff/UMavYDPeQuWWZt/C0hNvguM=
X-Google-Smtp-Source: AGHT+IGC8xFdp7kczgGCHfGx7ZjSyPxaQzVvKqeDRezc/ofNa9k0JUyiUKmZMNZDIHftGDT8eKS1WZN+P9giCLkdtmY=
X-Received: by 2002:a05:6102:32cb:b0:5d5:f912:f891 with SMTP id
 ada2fe7eead31-5d5f912f94dmr4303755137.19.1760345679527; Mon, 13 Oct 2025
 01:54:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 08:54:38 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 08:54:38 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aOjsdtXFgVb8QcJF@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-4-c7962be584fa@gmail.com>
 <aOjsdtXFgVb8QcJF@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Oct 2025 08:54:38 +0000
X-Gm-Features: AS18NWDu2JW8NL6cv3BHpty-pQYzMy7qOw5I5gV6eRUeez9gEbrQKvmbycPU7z8
Message-ID: <CAOLa=ZQMHY7q1rj0j_x7KnuXoasae9kXhDGcq+gdVrnmza4Rsg@mail.gmail.com>
Subject: Re: [PATCH 4/9] t/pack-refs-tests: move the 'test_done' to callees
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e918ca0641066a17"

--000000000000e918ca0641066a17
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 10, 2025 at 12:27:08PM +0200, Karthik Nayak wrote:
>> diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
>> index 095823d915..6a71838ffa 100644
>> --- a/t/pack-refs-tests.sh
>> +++ b/t/pack-refs-tests.sh
>> @@ -460,4 +460,3 @@ test_expect_success 'pack-refs does not store invalid peeled tag value' '
>>  	)
>>  '
>>
>> -test_done
>
> There's an empty trailing line now.
>
> Patrick

Oops, this must have snuck in when I rebased on top of
'ps/ref-peeled-tags'. Will fix.

--000000000000e918ca0641066a17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7bf2dedbdbb623bc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qc3Zrd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meTBiQy80K25qUkhpRys0QllrbHIvdGxxbzdwTFphawovN1lBTUQ0REFk
WE9uQlRRT3ljUmYxTGYwYWc2WDRzNGhaRFNmVTl6MFJFM0U2UkFRUGRaYmo5V2RRUWNzOUVHCjFo
aXBLYTBaWS83d01ZNWFidVAybXQ1K2kwa2pqNjdjSFRoNC9rR3RyNUs3TjErenc4WGxmSkJXYmph
SkRsS1EKUzgzd0RMb05GWkUwYU8yN0Z3VmptdVlBZFozYlZHUlZJZHo2TndXS3NZU0pBd2tqZVY0
cjRwQXliWlI0UWYySApXT0o3WXlnUXh5VnY0aXY3MzdkMkJ0Njg4cnhCc05PakVtTDFaemgxcUZV
TTFZOUhmM3o2R3NIWmRIbWd5dkxaCk00djVWSVZTUUZsYWhma1o1T3IybGdKWldzYThwTGtSM3V0
YjhueXdCc1o4VytmTzVpcTJTS0xOMnkzVDlsUXEKa1JZOXRpZU1uNm9TdFg4bTNsK2pIZzIrbHBD
b0NabHQwdUs1ZDkrdU9sM3hrckhiTC9RTDk2dzE0dzZSY04xRApCZXNTWkxXMHdMck5QVnVhdy94
c0NFUWNlUWQ2QXhEOUFZNHlOOGUvckgrYTRDZFExc1ZlcDUySUNFbncxUlNLClhJRkJkSjhLWGJW
dHU2TGNPYlFuZDdzeUk2MW84RjZJQnNvZ2JhYz0KPUgrcUsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e918ca0641066a17--
