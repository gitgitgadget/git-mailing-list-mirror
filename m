Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893A935E534
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470208; cv=none; b=sXPE9GwzvTFeX7fxndzgHAQ42J91LkbDQTwLhJs378OzbKMXP1Ir0oehaDlWmtc5Sq4LbvWkIcGKaJftq6gSZ8dArxb9oyd5S7oOISCYglHdi3pDyzbOm1jVYwMlNruU3JwbeotctvvyXa/Cl5VVXYtT0otSYG1Xsid3JPFdUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470208; c=relaxed/simple;
	bh=IV1/uvA2esYA4k8PQiUoPgD5GTAcbU16/fxUOhzc66w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/Nldo8GFIdFGd4lgFKwTOF8gLOCSqy2JBFTz6/HpWhUxG5ZfKDf9o5Ow1bB0n0qB36W3A213vUusvEAkve9xhiPH6Fz+Dhtl3nzeY/oVZsP2d0d9bBl14GraXce2LDBHGoWE/E4ibmtAp/+EH5QKju1APPKeSOeldvYivTk+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvOmPyJa; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvOmPyJa"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5635f6cb32fso258992e0c.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 01:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768470206; x=1769075006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IV1/uvA2esYA4k8PQiUoPgD5GTAcbU16/fxUOhzc66w=;
        b=KvOmPyJa6KGik68j39pSoEeSHWcnp8MrKdAq+fM6Pidxb7vriwayZMyinrAlSv7kF4
         gOQEDRUpAVwxslT3INqJ9r0+By8+mi+89D0GmIyrlPmHzwjEvzUtPL9U5hEs6SJ/+mZ0
         Q3PLgISjsLOMiCl+8sQROu+ojqYcysK8lvMYnDln+M2tY1KYS9QwHRD04hfVMDEBXAWP
         khiP5TX1nb313SXTWWOk3znKN1MmYoYccf7wlG+kcCXfxulclEyPyw2zHmeyfN7bWNIN
         C0hdVNNDgaRGI/RD+5Tz+ZL9+PdbdLA1HuD5XXJXRBipiZ6u7OiW3CDismEIG+1domaa
         xX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768470206; x=1769075006;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IV1/uvA2esYA4k8PQiUoPgD5GTAcbU16/fxUOhzc66w=;
        b=SbWC9OK9K9487FxWH9oy18vi/arl0Vslt3hccFuwkbIAQTkSX6b65h+5SgPIENtoHp
         0Ns3FMDvhBBnQ/88uKGsFrr+Tq03N8QJmhHmGWSRppMP7PB9WlHEN7WMVbKVe+sRh0kj
         OGJPFuy3R3Dgeb8PEcOCUjPN/GejsFVvhVzfBw0cRjGd/ddH2mR9GuAR1O/unRe6yCyw
         PWCz1p1+WN55A6cVzF33lR9LlwtwSZAckCrjkb7z9HVVPHFvqNsbN5ywr3wBGA0Cf3vo
         g7AQw91cLg49dIAI5ghAV03T3++AmX7BJiPeOaWf2WgjMpGF5rL/+1IxMrxFUkUbSxVI
         Jwew==
X-Forwarded-Encrypted: i=1; AJvYcCXNA3P4iIfN8uMZeR73rN2W5JH7eKPJRUWb0rv4quH58G55tYWDwtavsJpAL6wVPB2gE9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMd6bxB5HusybstruQxBX0RV5n78WPy6l7jKVLox09fv5KO+D
	CqiMaogO7BI7t9uPRZIUnTFOMAgPdcaQU6Wa+3bRqIvYnBbQsv+Lc7ysM5EWwniErXu2mMHR9Z7
	hBk/WnBhoG6pUj3QJEQkCHUh0bwgsiDQ=
X-Gm-Gg: AY/fxX5/cBObtrSNY3sb7NHSZOl8WPUqD25L84dq2RFH+Z9W0AKTKMyDwdUJaGBRORf
	b3qyAkIrUaGE+duo1QBQ/QQeXpDo8zQVhv5ZhyXZwMGo7+iZNaPu3ULowHdCGGTx7B/BEYH91+r
	njzZ365C0JTi/nXK2P9RlGHaTfXd5MyvbcgaudMwJ57jBvKUHFL27F4o5BGXk1y6jhXv5Jhfw4I
	vtfhQpxQAoaUnulTw/ID1RCwl66FZsiQa2R8Eu2Se4FxJYm06LLAokmtanRd+U9Yv/E20WZ4lAL
	SZUr
X-Received: by 2002:a05:6102:390f:b0:5dd:840f:a449 with SMTP id
 ada2fe7eead31-5f17f48b103mr2211662137.14.1768470206557; Thu, 15 Jan 2026
 01:43:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 01:43:25 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 01:43:25 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqh5sof61i.fsf@gitster.g>
References: <CAGe2LO0nxXuNNRYS0fk0JuPBDa3UCT8EDJ6G1u4GNW1d9rzRgA@mail.gmail.com>
 <CAOLa=ZT4fQdHqG+1AeviYuLUR5VG33voJk_DU1y0MzhUKBQvvw@mail.gmail.com> <xmqqh5sof61i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 01:43:25 -0800
X-Gm-Features: AZwV_QgU-8kDb_jfVyT8FzD7YXH0FRVIux_Fz1-0AAMWE64gY8xmqnE13-BgwA4
Message-ID: <CAOLa=ZTZhWscU=4mAb=FhMSNS2r1S0stE9NpCQBKpioTudhfXw@mail.gmail.com>
Subject: Re: [BUG] Git push sends too much data unnecessarily
To: Junio C Hamano <gitster@pobox.com>
Cc: Rajiv Sharma <rajiv.tilakraj.sharma@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007555e206486a0e6a"

--0000000000007555e206486a0e6a
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> So it sends all objects required to create the reference, in our case 4
>> objects, in your case GBs of data.
>
> "push.negotiate"?

Neat. Everyday there is something new to know! Thanks.

--0000000000007555e206486a0e6a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 579f62bfd396df54_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sb3Ryd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0ZjQy80ODVQK21UaVlPU240OTdISmgvQVZ2bWR1SApTVk5vOVA4WHZy
Zlc0WEhRT3JEWjlzOFAyYUdEekNUcUZURUQ3VzU0a2ZWT0NaMytYdGNZaFh4QmJWNnR1Tng1CjM1
Y1JKWmNuUzZyRmZtUnBNM1dpbS9vV2hWY21YZzR6Y3QrZnBGS2dwRkVwRXIwVnI3SW5ibkJNZnZq
MURoTmMKZ2U1aGwzam9vVzFIRHVjOGhtYTY5d1hRNGRWMkdpa2g1bnRYMnk4dUlNY3huYU5Vc1U4
a0p1ZDFFWE1CZFhESgpjS1JabjFSalRzeXl3RU5nd1diZmFsOG4yYUdKRGk5cTc4YzlITnpVM0tj
OUsvbFNMK1BhZmx2cnpCVldxcTlmClJPTTFXQXFscEIzcEJmdVlZZTU5R1p1S2R1QVc5b2RLS0FB
VnBjZU5MME91QkdwMzdQZmlhZ1NacENYeklEeFIKem9hR2RYK1NvMGJyb3laSWkxY01KWHhNN3ZN
THhnTEVNOC9KSWdCcjZFV1BsYkI3QWlWSXIyamlNcENKdGU2QwpZT2Fqcm93R2ZWT3FUWHRoaDhh
RXJHWmdSaytONG4yanZmTWtxZXZqVmw3NGNSQnVVQjkvd2t5SlN2RTlRRjlICmhvcHllemEvYmJl
R0RtWExjOFlZdnJJWkhyaHYvOGtwVzlBcFNvcz0KPWpMT0cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007555e206486a0e6a--
