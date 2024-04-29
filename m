Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7A839FD
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417076; cv=none; b=j0vcS5+WjAjcSyXpKqjVZ3ZRWgFKGr7YFRsMzuA6u+16SysFqMf7otInAumLGwKY9bVk4QSw4erp6CL4RKbhF6yLT9MPly4NKVqxKQtgPZMlPGPHmn2VtKTJc1RHYT4StG3QELWGJtkMewGd8miFp7Ueh6xXwGhF2MofSKc3c94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417076; c=relaxed/simple;
	bh=8SYCUuaLtGP4l8JOWFNzI83AGKPkjwZv/lgJZL1gDf4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aqvzm/Go9kbdNNnnwnrWxMbKlPVYD10a2qpsbto31gIkBBvak7bfK7wWKuMdtHvFVmRrVHnWJehsJBbokCBoD7O2y56Q68ac6ZUtT26l6mu3zolZdeKJNEq+eDrrgr39gVfTIPn6hKL175+9uHMxps+zoxJJIcdLMn/4262s9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoFXMs9+; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoFXMs9+"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-22e6b61d652so1580026fac.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417074; x=1715021874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8SYCUuaLtGP4l8JOWFNzI83AGKPkjwZv/lgJZL1gDf4=;
        b=hoFXMs9+z2F2vIuWhKR/zcfSPR49JXGT6/+j2tJ7PHHr914j6oa+VNPksPiDcRdSqB
         6Pb0MsnuNBMth0ztzuBxstqVZCFs5zmXxGqRDO6Kz2MU/1XcaJbBHgjY0At6Daewn72e
         b8AuDJs/DORxaEsFYdNQtC3u1h/HBw1kR2GP34dz0kk+HvtQdvvqVKBJPHlUjXBydlGW
         KP0YIR+vv3+dD3VvelV6bbYEKsQffO3gJ9Kqs3SOX85MPoP2QiZXJ5cDZOh2HG6UvgOw
         5xApMRhYBG6oZJ8M+06Ir4WBYPZdxqvUMS54W6vhp/Okckz5HAt4hVi1P4uYFNlWCrRS
         MMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417074; x=1715021874;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SYCUuaLtGP4l8JOWFNzI83AGKPkjwZv/lgJZL1gDf4=;
        b=K3wFzwmqQ2Hy9X0Copy5cqfvRkQ7tqVL1Oq8Z/kQUrWE3u8L7Ytp6zhtUroourEVIA
         BvyPs4YVeRF/oLCsvlzrp9kPYht3H0MyVoxeqtMPzT/0HA8ay5crPCmgXGBinbg3OfVT
         lO8nj99ae9qhLHy9ddD1vKXPu68+ToYN9K2zldLBGsAK0V6zBtZb0W/P4r6imyS83ufc
         OaIMJ7gd3iOBOmZDZuoD15JhlZXw4ZERwpN9CFhqbtz0cPcOAc0Bz9/SJFPhjRxUHWDI
         yyfb6V/iU9FQ9F0CPt+omhTT7Z2X7cW3ovKo4XOiS878VtgmFTdovC3lRTeqnAI2H3DO
         sSkg==
X-Forwarded-Encrypted: i=1; AJvYcCVtNeUPqZpbeVzJotZp7B+32gKo0Z5aoI3bf9ePEgLZaq4xxy13RBPm68NYgXXxCPPwRHwWT4x5L8QoHzIhO2zzQXR5
X-Gm-Message-State: AOJu0YxIAtpbYm8bd8sP6Xf0wr7+EIGKeUztn16GhEhr+pdAwOjBS5l8
	Jn3I3IwUTO8InOrvoAsCM1xvJ1uHgEWEDITknVvWGD4jXQXy3/p94SRrj8YcQsTkDpJV7TlMMH3
	aF+HGQYh7tDnsmo00rog/0kPaDgxvrQ==
X-Google-Smtp-Source: AGHT+IHOaBELq5st5F7jmH4BjQe4HvWfGVm9mxBBfpBCQW+1pU6mDg9uOVgTjwOJZEQw1da8l0L8ieFZ72YKFELGa7Y=
X-Received: by 2002:a05:6870:4208:b0:22e:ace7:81b9 with SMTP id
 u8-20020a056870420800b0022eace781b9mr12760483oac.2.1714417074334; Mon, 29 Apr
 2024 11:57:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Apr 2024 11:57:53 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <88822afe950318c0312de5541a411942a163b139.1714398019.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im> <88822afe950318c0312de5541a411942a163b139.1714398019.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Apr 2024 11:57:53 -0700
Message-ID: <CAOLa=ZTCCgtQiQbm_GU--1+Yq-qYJANzTvRmvVrqNmzchkVevw@mail.gmail.com>
Subject: Re: [PATCH 3/3] refs: fix segfault in `is_pseudoref()` when ref
 cannot be resolved
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000b6901e061740d4eb"

--000000000000b6901e061740d4eb
Content-Type: text/plain; charset="UTF-8"

> It is somewhat questionable in the first place that we declare a ref to
> be a pseudorefe depending on whether it resolves to an object ID or not.

s/pseudorefe/pseudoref

[snip]

Phillip Wood <phillip.wood123@gmail.com> writes:
>> via the uninitialized value when calling `is_null_oid()`, which causes
>> us to segfault.
>>
>> It is somewhat questionable in the first place that we declare a ref to
>> be a pseudorefe depending on whether it resolves to an object ID or not.
>
> If I remember rightly Karthik added that check to avoid the files
> backend calling a file with a name that matched the pseudoref syntax a
> pseudoref when it wasn't actually a pseudoref.

Not sure I follow. I think it was strictly done to ensure we don't
consider symrefs as pseudorefs [1].

[1]: https://lore.kernel.org/git/xmqqfrymeega.fsf@gitster.g/

--000000000000b6901e061740d4eb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4e4376e4018eb6ee_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZdjdhOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEloREFDQUVuMEpQcGVsMFNLNFdJdEliRXY3Wkh6NgplWUJ2Q3dvYU04
VmRIN2ZVRTRPTXoveVYwNytXaXJFaFAxMi9GWXIwTTFiUnRUbnV6U3o4TzNvNE1HTHQ2cGRnCkJ3
d05HMHdZaVF4Z3FEU2lBVTRXaENMc3pHeXU1b05tRmlPRWZtcnNFWGV6ejMvK0lLOVVFcmFFVWtz
UW93ZlMKcXBIL1daY294L2p4Q1ZCL2FYdVIwNWJLL0JrN0ZIU2ppTnliMDFXcUh2TDNHdksxQmlq
UEszeTl1NWtsMXh0ZQowWkEzMTdEZm5oQWZobGdwWnNmWjNDZldJR1YvcC9vVklsV2VINlAyOURP
S1I0OG1kckZWTVBaRmpkSUR4RzNuCnc3MzB2bUgzTUJOaCs0WlFibnhFaFpJOU5UYXR3NUQ0cFFW
ZVNJOFJ0VmhHM2NHbzJmYVNvclExQTZKU1Q3bDkKTGI3OVZaTkNENFdtWFFCRjg4S2hXVXB6VWxD
QlI0RkVhRDhmTExEaHJqSFBBb05OV3pPUWJ0RVY3MFhuSTR6UAp4UXM0a0JYbVU3d1dLeCtMV3Np
M1lyckRDa3VXTDJiQkZ6bzl0QzY1T2E2MU04bHIrUitmZlE3bElHREpmVTh1CktEelBMNUhoUjRx
MEp1SVZPbGgrMEp1Y3YyL2tZVzRpdWlVckxQOD0KPU9NajcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b6901e061740d4eb--
