Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA131E48A
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375512; cv=none; b=aDBO7RRMioDUX0yo82NBnoCuXtqulqzuOFGefZShF0iD3sXBMaxEBm094Y9TJl8LE5nxKt11uMpoc3nb/uxC8MYRLMMmsVGDroffuYh2SgIcxu3KvWDAfJMW56VwPranbq0sBpmwiU9JLe627s2ZA4IP5OYdHCKRFyZ/LSpzckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375512; c=relaxed/simple;
	bh=+ZsvadTZX5hIF1ALaHhKIG/CPRqbntHffMHrADQ5NcA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=QvUoG9fovO/JGLey+fgvhjcJ2VzOuFH1Idrwp9bLMJBlW2QWRkdjTfFpP1pe9J/71rQaWnWvnZ/wHnbA8WfxBeyrpEEhrFiEjFQ42Bvz0cevob930NYZOgrRyVlQp0PmFdgG9j8gHbCEbSMpC+1JUqLp1y03UYl03uKsYywGcpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET74llql; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET74llql"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22ed075a629so11618fac.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713375510; x=1713980310; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZsvadTZX5hIF1ALaHhKIG/CPRqbntHffMHrADQ5NcA=;
        b=ET74llqljuFv5f/0YKMroc5rFnAL9dX2tGG3aBqkbCgJ0fLUo+GG1wxMLFNg05xn0I
         z8VdueMoVAoEDEq1fkNMzsgM35IbZgKbzzD4tS4fW7Y24eaiJqVPKKzEKTczj8FbDaK1
         BNHGvC1eBD5Q9NYMt3GpvMZU0Mj8D5y/yTOvN4uZmOiShX3f+2NtCT16uvJNKoQuZgnQ
         riGfHtXfOfC5+HMDDbQsbPS/VtF4oH1d060aANMtYr80BU4qKXdupZC+eAqZxCKJp+rT
         yP4HQJKK8MwFS3wTVtEzW9wVqsvlmWdL06DImk1CAmH1qRul/o67+bXjNVbhaM/SoGMp
         Sdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713375510; x=1713980310;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZsvadTZX5hIF1ALaHhKIG/CPRqbntHffMHrADQ5NcA=;
        b=mfumhVnPPrWoyOnkY4m13OZpO1YrRl+QkuwEshsU48DUbGpKNBfg7nDcLGQdon/0mW
         IBI9KIyYjX8ofn8X4/cTV6LZ30F//ELep9CXYEvJiEYqS/LPfcfJovPFr1ZAubRZR4C+
         KtHJPuxd+En9h8FYrMobueL7ee1gmyoZFqLSDRos78Pw55Bwwk287b+m3MYnc1WcRbKH
         sG90kT3BEmfHiXfzbb38vTODvWQmkloKsCksOyH79R9tnC0Ngl65579c+txcW1+7Vmub
         ZHpjWHyEYCnmsZq6kxWyUB8DznlgY69UlwZj8ktrqXo2CGjnDSwGQaFAdKnOpJeSDeNm
         roTg==
X-Forwarded-Encrypted: i=1; AJvYcCUyMdy8nCyScCQ5T3uOw36r61S4kyx7eYgxi+L2FPG/3pcet3CAoGzZMpfJpAg30fBorPFrX4LuncYzDUx7UwnKgj2t
X-Gm-Message-State: AOJu0YzBDiu6LkCE2lQsb9vejROc74HNreYr4tjglypH4/05qScjv9rx
	mKa8W0wpZfEZjE7BWEdEakWNB34+X4qY4MNtkgIJskzO3/sN6kUNTRdBYdpHwVxIAny5h4hmBrb
	yqbE7PLzXhh1jbhOibodDMjPv4EY=
X-Google-Smtp-Source: AGHT+IEoSTx3Ldc9sa55u8+4yQulK701+eiRMliIxAwoOTl4iibksp4nPs3LULjZ+D/2obuO8b78ZkFOU2J9TZg0fKc=
X-Received: by 2002:a05:6871:62c4:b0:22e:ddd1:4641 with SMTP id
 rf4-20020a05687162c400b0022eddd14641mr260254oab.35.1713375509886; Wed, 17 Apr
 2024 10:38:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Apr 2024 17:38:29 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <96256f9eb30e5aca632942169d5c311b1f245b40.1713180749.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im> <96256f9eb30e5aca632942169d5c311b1f245b40.1713180749.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Apr 2024 17:38:29 +0000
Message-ID: <CAOLa=ZQHGSvpzupNPTBQ=j8rd7txMWt9mbGQpQUSJTgr-pP5uA@mail.gmail.com>
Subject: Re: [PATCH 3/5] repository: initialize index in `repo_init()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a25dd506164e5255"

--000000000000a25dd506164e5255
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Refactor the code and create a common `initialize_repository()` function
> that gets called from `repo_init()` and `initialize_the_repository()`.
> This function sets up both the repository and the index as required.
> Like this, we can easily special-case when `repo_init()` gets called
> with `the_repository`.
>

Nit: `initialize_the_repository()` calling `initialize_repository()`
doesn't really indicate what each of them does and why we have two
functions which are similarly named but calling each other. Maybe we
should rename them?

--000000000000a25dd506164e5255
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6a42183494b3a6bc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZZ0NSTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWtPREFDTnl0N0Z3M3NVL1FTRzdFcVI4akVyb0FoQgo1bEE4dngvVUVp
WUwvOE5KaUlnRWpXVFExREdBQjVwTXZBR3ZFajVyME5YcFlTeGdKZU1UL3VOMkFXeHRDa2tHCmVw
NEkveE42M2hEUFhxbWFhUUJTNS9mMnI1TlE0ZUxoODlCSlZhb1RwM3pZeGFGUHM2OGpjSTVKWlZ2
ZGtaVGoKcnh4MVRVeGVkbUJYKzRnWlFWd2l3VTlsZSs0WGxEY3RKYklUamRoeGhKUXZvWmhucFFk
ZmJpc0ZmeEZIWThUTgp5SzZEVTV3RU1rTklMU3RXNmxIcE1nU2lTNlNWTGJkNTB5aGl2VVNjUXNk
Q1k4UkNoUm0yWjN6bFVCaStOUXk0CitYK1AxRzVhdVprWm1YUEx2VTJkQmkybEhFeGEza1pnRzdn
OEhBWE96aHBGYWxCWnFJclJsV1hvc2ZrK1NxR3EKS1BoR0IxSVFzRGRsSVZJSjZ6d3d1S2hVNlNy
UE5qQ2dQWWM2TmtoV0E1S0ZaelhOd2dHRFpPRGJvajZwSTFXSwp5d241T1hiQnRlS1d4bkdPM1Ez
a2ZmRVQxblBLRWdNamtpMUliZHFpdFNYQWJseWViUHhNbkJqUG41UDBlMkRMCllNNkVHaGZTWHBJ
cnBZbVZJUDBoNi92RUdxUG8xd2U1VTRVUTVVcz0KPUhRdXMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a25dd506164e5255--
