Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08F18BC07
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139697; cv=none; b=JKCyKsKZWvveSqQRmGv7IzkgDZZuitdibU6sOa9H/0UN8+V7SX/fSHshlg5fa7HIZBmqiy/FpqWePXmHboNO7R8r4oDyGUR5E8bl4Q3g4sqDYH/NdyjMp/NvaACk6UqxeVg4/y8+IjXEI9SSlSsZ+ec1GRKjiITGMTQWMg1AB2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139697; c=relaxed/simple;
	bh=HXrosVjtzb3iT1qfDkyV5/pnx+rNH9LOpoyVVDwBBes=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7EgQKomHQiuTaJHZrrL0kQvTiqyZXrwQ68xaVqBBmPz7emJ4P8pmJUJYk2ENHrFnO3x0fho0d+/cIxXbfmH23YjiHL61zsf9bo2yGSOEhAIKmFtjUORw3LKcVzZeGKsYJTiiD+nhFKlme9vMbi96fPT7cuEM8lA9dvLZWKCKM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si5ATPUX; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si5ATPUX"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50108b3749aso228115e0c.2
        for <git@vger.kernel.org>; Thu, 12 Sep 2024 04:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726139695; x=1726744495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fUEor2QIb/80X+fGFzZgDRWNooydGGM5JC3duDhMZb4=;
        b=Si5ATPUX4xaipEQhad6qdUqaEI+IPupIKZ2qoJGnrIbZ4wJOKeE5sNvCbfL2kIrt7Q
         FluMVoiJN5a/WbDij8N+U3J/kQHYMCB7T0hGoG/AHGR/D8PKcJCFJJgWaGtZ0ozucXsI
         2o3gVkZmdI3l09yZVyGQqLOuWTc+MejwSOJ0+fiboRVXXQ0FwiFCnq+1Pki4hvkExBqa
         DU7FRDL8ar5h/Xz0HQ6QwXIHjMlR77cylfvYQu8oZDywvY8ebQwMOGgO3ydYcUg3icu7
         v5xaQKm+ULBhradJdlVC3DoeKyvt6KhyS6SBJ8bDsGxSEvbPZkEUYAgyofysws7aTfoA
         9I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726139695; x=1726744495;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUEor2QIb/80X+fGFzZgDRWNooydGGM5JC3duDhMZb4=;
        b=pZLLfZe1Y+kxXOJVHUY4aUQPzhmhKOdx9iposaXYG6jvM7YsAtFxHZMGMa6W1dR77p
         KWT48ceZLY1cFHfgjo9jYgSuRC2UwkfDSTymytpqZIYAGlJW078H22+LXL/uzaEAcEpi
         brKDql8AxgvbLwO6f50Vw25vYUS7DrWwYyC+EJgv5zvrXk0SY8mqUTBncuHSxHr4xYIg
         1qspzQxKFujnTwtl9CXSh/135kGpOwUklLPGdHS2bkEwD7vT4AgHAI3qt+1IeZakXnmM
         vcBf6rGSltGlutKT53p/62u0g4F2h2xYVqmgRNJYjKJQrRxGNI2aq6gE9NjLCTZRs4hj
         qDtA==
X-Forwarded-Encrypted: i=1; AJvYcCXrCDM83VslamsjZumN1YKz2RbIu9Zcxuc9N8+pVyBt6CPwexnhdhBw4XgXvBSIMvb408E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3TLRvmqK/uffwXGoHRegt235nyP53wfjAP4yte2AAhjlM2u/
	82VlBW9xrXlGLJAMTzwRtEHlGZR7Dpau9OQHwblT4ClQgn7Wa3ItVQWEA4kj77yDCnutcEMcmW9
	GZQWyreKSNYkbnGkbGL0rcUFk678=
X-Google-Smtp-Source: AGHT+IEJWf54fKk5lVh7UM4bsJOtAR0i/yeKeNXJMnZkW4LU5r56bFlCxNqaFtI1uwFiCTnSmoXiMzDttkz/j617Ios=
X-Received: by 2002:a05:6122:1310:b0:501:3b5:ae01 with SMTP id
 71dfb90a1353d-5032d41a85cmr1730041e0c.5.1726139694757; Thu, 12 Sep 2024
 04:14:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Sep 2024 04:14:53 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1725008897.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im> <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Sep 2024 04:14:53 -0700
Message-ID: <CAOLa=ZQ20ndA6cG8_9OHO-Ci5AHu5i2K6O+2hJ8oa6+nhxaPZA@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] environment: guard reliance on `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000056ddb00621ea37fa"

--00000000000056ddb00621ea37fa
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series which guards functions and
> variables in the environment subsystem that rely on `the_repository`
> with the `USE_THE_REPOSITORY_VARIABLE` define.
>
> Changes compared to v1:
>
>   - Clean up now-unnecessary and add newly-necessary includes.
>
>   - Stop reordering includes in "setup.c".
>
>   - Fix missing `USE_THE_REPOSITORY_VARIABLE` defines in Win32 code.
>
> Thanks!
>

I haven't read v1, but this version reads nicely. I left two comments,
and I think the first one applies to the first few patches.

Thanks

[snip]

--00000000000056ddb00621ea37fa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2462ed9304adebe3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iaXpTc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meG5VQy80ZzlOTXpORjJtc1k3RGFqdFdhajZJaGhLeApFOUNEcGZmU0d0
Z0JBTDNsTjFuRHZtYlI5YlBoNTVmQzAvVjlVN0krU292WGVsRXJ0cTdOd3FOTmJ6dWRFSEJuCmZu
b2t4T3dWQWltSWhLeGpKcU5sc1JnZjJjcjhaU3E4TmtPc2hVOW9VN1drWlhmRW9RbGJ0RG5zTnpy
NnJlS1QKdTU1NVlibG5UMmFqWHdjWlRWRTNMOU5RL21LcWhPRU1vMlBkZDlZT28wRVJIWE0xdFhj
ZjFZa2RPMlVuY0VBSApSNnFGaTl3WmlvK1pXRU4xdUxzSVpYMmZKUFYwTVE1TTlCRmloaVFIRTRZ
RUpBL28weUJXOEVJTHBObFR4U1l0CjBFWmZHeXZzQXVINkxFUDZJbkM3cnFDZlpuUW96cUV1TFc5
SGhuRUlRSmV1ZVhGMHE2U0llVzhjY1Y5YllkL0UKVStLclprbEpJQVdqV1pUWnhqNXdXaG0zQTFh
dm5tR0tKNERsLytxamQ5YUxpQmRVaTFIVnBPSU90cERwSTYxTAo1L3gyREZtOWxndEVRZGptZkFs
eVVQSWVPWGFzbk1JOEhQdjkvZGRocE1wL1cyY2lZU1UwZWYxZTBrRTVkQ2RXCjdTd0U1S2hLRktC
dlBLdHI2QnVoUHBnTXNuVFBJcGUxVWp5T05KYz0KPWJsN1MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000056ddb00621ea37fa--
