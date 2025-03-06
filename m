Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF715383D
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270367; cv=none; b=fxhMBRFu5spWzusNS2Rn5iOX8rGgNGmVoNMZtf+68DTIozIZLV40Pljs6dFp6tYHyLcxFJ8IqlOivpMph8D3s4UjP0uODzOmg6hqTVPMFd0fClaZLQmZlufbkTTCFNgNJyKdV+8T2C09Lj3K1Hm8DJ8My7d8PUzoN6k4sPyDHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270367; c=relaxed/simple;
	bh=oNatWBZ8SSWPoKZ4TvfgoK+XSEXPZVRrJZ6fhFtOQU4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqUYEujius/Tf8X7lijVAgsv8nD5ywVNzIK7Ppm1ESzDHP56fu8Au55y1d7Prp6EftzuYnSNco+5kJ7905CGn59PkHy2Zqphx///ywMgG9Mqh73d56V5196A0VDSZTkE4IFoxOoYzX0Uhlc1idMk1cSnKn4OmwvQMJu96R/7e6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR+zTm3v; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR+zTm3v"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-523dd512bb8so147306e0c.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741270364; x=1741875164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNatWBZ8SSWPoKZ4TvfgoK+XSEXPZVRrJZ6fhFtOQU4=;
        b=BR+zTm3vm+M/Zx3SDrGHB3CPMxoj19SZaFh/QI/gr6l74dSEHHlVmhS5rx363XZF/9
         tBA7EfRYjNh6m0NJikbctfheUD6tB+EllgvW/q620OP5/S86KAsPs1RpHlh5yToIXZBA
         u0nOkRSQ4z3B8OHxyy1n/JgidBV4bcTqXro9iNIsxE/9Dvvz+M5uAjV6Q1c+18jZNx0q
         Gg2CPGVWfqpmhuNo6vvn3xoOnlmk/ywakHszhxVb6byc0xf6bs3NmIPyOIja1yLwMWOM
         ke4eVJ41bN/R1iY21LHE2B4A/t+Q6tNsjaRNrR3cf+OSEdUFlugmmXy1dI/IO3l3pBmC
         tiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270364; x=1741875164;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNatWBZ8SSWPoKZ4TvfgoK+XSEXPZVRrJZ6fhFtOQU4=;
        b=CsSpr1sWbTYpnkX6ufBCpwl0sBX+mX43Tk9jrfwQKStmy8rqRoLJiHSBoKY71oqLIu
         JXVSBtlMSLa4Vh2EydmcBRDXm9tU63r33114pIjdy+Ggo+4v7YWaUSqvSDVWTnNKp8rY
         Whv+15SDs2FR4RHNch5vj02dWpnbiAQrIe9l8lPzmJTVbjkySFYo1HLvukNL7uO91JHp
         Ikp/cvG4bNkrN53CQIPrGfR/bwqeO9skX/2biHEo0BSU7ez3osLM0ms89u30zuahIoXm
         lEYUpXueqHZUjhUVdmxqs1DyouTmQNd5iFh/YVgUs8A2pfjqJH8R6u7Co6lKrtwcZ0bz
         FGDw==
X-Forwarded-Encrypted: i=1; AJvYcCWf3ocI8KdJLxRu7ZYSb76YOsRzgwtO0cgJ9Ady8acc3TBDAgJBP5VUmZ0V7KFLcgYrtaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdbxWoXnBWf5W7ms5OAnphiLWdxNPmXMOJ9uuvYz9ov+uopSS4
	oRp6ziA0xti2mO+qzRSm8Hx2/W09Pw8Fme1i/9WY4OXU63lIY+AM9fT9XBJBZH3/OEECIsby9O4
	sqYZYw4EhsVwCXs6QE6OMojRDUac=
X-Gm-Gg: ASbGncvgeZLT5Qs4tz0DWcFmlNGIGBR7XQBmj4KAuxgEFOM+vVNhjEf/Pm33L73JkfZ
	TqSimOVE60GRs0hFSVcX+DAs5LWZ5ULMwqyDa4L0IwmRMD5wTdApVV+g9xDMAns9AYfT49kbHKy
	2kZ18iqevbdWIa51UUVz3kLxzy93o=
X-Google-Smtp-Source: AGHT+IGiyV5pyAAbtGP69GyDG3shYoO0IIOY8VfTnVAKS+6/aAMHg+wJf5cMwZSPnbD8e43ImzzvkQz6Ominfp0uI3E=
X-Received: by 2002:a05:6122:3d42:b0:520:3914:e6bb with SMTP id
 71dfb90a1353d-523c625a516mr4670049e0c.7.1741270364409; Thu, 06 Mar 2025
 06:12:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 09:12:41 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZRUxYEOgsMOJCR1WGNFtkP2NU=PykRLCqYvQR=EnuUbUw@mail.gmail.com>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
 <20250228-pks-update-ref-optimization-v4-5-6425c04268b5@pks.im> <CAOLa=ZRUxYEOgsMOJCR1WGNFtkP2NU=PykRLCqYvQR=EnuUbUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 09:12:41 -0500
X-Gm-Features: AQ5f1JoW0fvwPy6C742GkHIP_yyFfJiXJFbsyaNmxgcRTsvWLaxzUZZTv0GSj_8
Message-ID: <CAOLa=ZRg=qUV_9kZpUnx=pJ6nBhrPQjGaVHQRjwHSa2omx93fw@mail.gmail.com>
Subject: Re: [PATCH v4 05/16] refs/reftable: batch refname availability checks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000879727062fad190b"

--000000000000879727062fad190b
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Refactor the "reftable" backend to batch the availability check for
>> refnames. This does not yet have an effect on performance as we
>> essentially still call `refs_verify_refname_available()` in a loop, but
>> this will change in subsequent commits.
>>
>
> I thought this patch removes it from the loop. Which loop are you
> talking about?
>

Looking at future patches, maybe this 'loop' is a reference to how
'refs_verify_refnames_available()' still loops over all references,
which we start optimizing in patch 08 and onward?

[snip]

--000000000000879727062fad190b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2db7c3e84be5c2c3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSnJWZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHVzQy80djRwdWhTK2RlTmZvRVVOZVlPUDQ5TXU4NgpGdStqUWE0dHFy
OW03eVA3eGEvS3h0ak1hRExMK1dSQWdYcDdBWUpJNzU5T21LdWxKd1N0QkpqaDBJcmphYzFLCkt2
WTYyZC9QbGpBMm9jbjBmYzRyNXMySmc3OHhQZDVISFAvV2lzdFk3MHR0RmxCMm5MaEt2R2kyWnhY
TmpKUlgKYW94TEw4UWgwVUVHc1NFYkJTb3J2MWtia1J2UzFoakNmYU9FdnZnd29rbmpVaGhZVnNW
c2R6T2RIUnhWcHdNMgphbGhXWE5jY3FjTkdmVDU0UU1mL3BCeFVUSzZjZEwwdndMVk1LOHdCdS93
REFPc1E3cVVLS2xEQWwwaWYxMHRWClpHMk1GUGpLNEl3Vm4ySVBOaExRRm1XUnhmcFV1RDR3Zzdk
YVVEOVV0OEovY2lyeUhmRWh6SEhhZjNUWktSMmkKNk9sRHJWbjRtMzkxRmJ4MDl6ckZJN2NLeS9O
dHFoQ00wWjh1ejhJZXU2ZmJFenhETys3M3BxbnJsT2dpVmtLMApNYnVqT1BnaUtiUlNPbjRKa0dB
RXFlOG9PdjRrWVRNV3c0V09FamF0dnZQRXNMOG9GQTVSNGlwQVdPVHB3ZTUrCittemhuYytvbFJY
cXl6K1hTSXZoZnM5dU8wSFROdFE4bFZqRmFZZz0KPVA5RzcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000879727062fad190b--
