Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719662F3C12
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767697315; cv=none; b=jZl9FezQc0yyR8MyRyouLPR6KK0jSoJMqjuqRWmyPWJe6y00hxknwezuYlKcTBx2AQ35at4zmPdZnp3LQt2JT+IR9yFQ7zmgDG6Pvy/Aoiq2l9tsO6b9SurVnGAtBsDMeYcHWu3YWaucCfKtQRMCG43nY/MddXXxvfoh4PO+csk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767697315; c=relaxed/simple;
	bh=aifHHgve5uaGVBc8wkEzUk9pHqsXJgYGYEva9HcTxYU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXwUtBTiEWAh70FuG91tYhPgvq5keEEbo4/PDwnVWrDfu9JtIzeWhvG9SgGT2Hm6eGDTSrz9JtlkzrPkDOaWX1xm/XoRcRtKelq2wjv2ucV6vjLU8bFRp6UVrX1S6AMcOMbtE44O6w3wqCeDiJ8VZhV/LMUAXaurymSuWReYTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je/Up8sj; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je/Up8sj"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-94121102a54so473085241.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 03:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767697312; x=1768302112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aifHHgve5uaGVBc8wkEzUk9pHqsXJgYGYEva9HcTxYU=;
        b=je/Up8sjtadJ1a9RinM3YpxPH7qr98ioddzkRe/noK5y6KgCG4qxMKAbg/T6tBieTj
         AsrpgiqzvgtDMrd85BH82B6PzXKlzofJ17nCsWEpzTONAR9/VRZD9KzZr4m6yGvJN8PT
         AAIEr+GvTdMRvw1DgGswFF0Y+UD7w/MgBoLmi8VUpR5u3/W6uo64rcTWcuLhc3XP3H15
         Z8lLRyyejxJT7qmZ/dete9ZAui16CUOsyYUux3xzad13A4UGdICCdrJvKJz/8Ityv5ru
         73+vGD87lGQSSk6C85yP3RVycHEB9GqUvtTGbKU0GFml9yyWFBO1vKETnQCcXJD4AwzG
         4+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767697312; x=1768302112;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aifHHgve5uaGVBc8wkEzUk9pHqsXJgYGYEva9HcTxYU=;
        b=lDF1wiD+n96+YyRLb3gmmuaXe7OKA37wWj0F3u4k+sQr68aeF0AzxjkIZlm8Ho3GHL
         oNDR5F+VZniNcnRS+8n147hqJvm7B3m8EJ7MD5K8tprSvKYh6khgusSa0aD+sNEN85yC
         H161hygaGuQryWduu33nMGHax//p3vu7jjow0Sk5/MrSW8jw1+IdAga3JfPznuvCapDf
         evH9h2AcRzU5p3YvWBGeAaEaPCx+72xtZ+C8ltk99ad5nT1fCEIALr26kmkFfISZjCfv
         Z9muoRlCb8YVq1Qnrtq5BJhtqJCzwTgUBSNdjeyf0OnafnrCu1I5m1tVFDcT15Qwdtex
         0ZHg==
X-Forwarded-Encrypted: i=1; AJvYcCXSxR8CS21ceeENmbGvsi159PZRLmoPmyi1g+kWb41SflgKW7GXVHAFaa4lGfQQ4ox9HSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLYED+Au6XE0d2WJCYEww7WC01q5frTVrR2sQlfwzJCuCye4W
	aM07hBElR+bjZyorv1wJjiQTK6B/qd0EmwycICfQITvI2Pw5Fygs+Tvq3riE5oDEasP6/sxPW5A
	Ff1weS5riLxn4y82wTo978+dTP2vB+9I=
X-Gm-Gg: AY/fxX5aG1CqfqnUJ7+EeLD4ARceve78+vSC+sk8mIw03Tkpz8SkUIJP8ty8EaP9+xD
	TlNmZsFNDDMykkNNAAFQxRp6R41ZIlvje1alMOo8MpYoI0NYYbfswRIcZz6mwxmwChO2R1zXIzQ
	QWj8Pjl2DyEaFI344ETUoMqA2/s7dwM9DIKInh7Sl2Bn1Z8zhxAYLDg3mtblQy8r/xE8ID1J2BL
	WFYHSyJeI4yDs37BoGXt4LK/2/XvQdL8NWXcLs4Fa2ceQYN5V2qKdZHwN+ccPGbDdkYf2iYIa3s
	eNJKgw4nw9YxO+oG7qWg+u3qJdFBGg==
X-Google-Smtp-Source: AGHT+IFk077/6xDwoWLFf5VyU04XB7cTS2PQInZANPILk8VEajxla4S3t+DGZNQsJV2hLPbFIEynydeoeUhI0AyD638=
X-Received: by 2002:a05:6102:5348:b0:5df:b7f3:5871 with SMTP id
 ada2fe7eead31-5ec745a9c42mr823154137.35.1767697312396; Tue, 06 Jan 2026
 03:01:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 03:01:51 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 03:01:51 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
References: <20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im> <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Jan 2026 03:01:51 -0800
X-Gm-Features: AQt7F2qMdC5Ybb33bFx3_V8QKCteSn7AGL8WHlz1X39MDDt65jOmE7qn5p9k694
Message-ID: <CAOLa=ZQrx2T=mPC58oSW=1Y4i1cOCtneN+U7rDUmKAke9ifp7g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Update clar for improved integer handling
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000006056890647b61a0f"

--0000000000006056890647b61a0f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series updates clar. Most importantly, the update contains
> properly typed handling of integers as well as a set of new asserts that
> perform relative comparisons, like "less than" or "greater or equal".
>
> Thanks!
>

I went through the changes and they look good. I didn't know about
double evaluation of arguments in macros before, so that was good to
read about. Thanks

> Patrick
>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://lore.kernel.org/r/20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im
>

Easter egg? :)

- Karthik

--0000000000006056890647b61a0f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ac2988edc6f321ee_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sYzY1MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1VTQy85VVBaMUtYOVZtbFlhM200cHdxZHZkbW41UwoyUHZ0V1FRWXQr
MWhOME1xY3VMUWplOTNiWkJIRU5Kb0EzaTRQa3lTYldmNVNRYUxxL21yY041S1BIclVwNUVuCjQx
cUJPODBTMmtPZ2FlSWx0R1hibW5BWGFidGRQNk8yVnFaMXpPYmxUTHBkSTM5ZG54cXZTekNtRTBn
K0FIYjQKK0dZb3cyRStsZ3VmSTJYanNTaHE4MjZINFA2dU5YcEdBaVZ5OUg4bEw5UTcxQzM5N2lp
LzdIdDl5ODQyVFJlZQpjOVlIN3hKNHpzRC9MZ1YxN0xlTmNhQTF2MHlmZXNxRDFsbXd2RjlkNVph
S2lpSllvcEUwaGQ2N09JV245R1RhCkF3cmhSYUlPR1c0VE1ESnJwVm41b3dEb0RmQTcyL1dJNW5D
ZEFXMjhoY1krQ0w1M1hJUG5Pdk5KTkx1T2YwaFIKU1M0S0JycTZqTllSeTBIWnVYWlpibG9rZFVG
Ym5HOUZQZkVwSkpEWkpKWU5wb2o1UWpPOVVhRHp0TVMyZWhtVgpnR21NZzRiU2U2N1pLbmsxTnhl
K3VwWjJIY00rVWdWRlhkTkpBaWUySTNQZ0Z4MEFXNjIzVnNiUFRPVlBsYzBxCkV1dWs0VWVmaktw
dm1oZE02VmhLdG1tVHNERHZyZG1JOGVnRFVlND0KPU5PdlMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006056890647b61a0f--
