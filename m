Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36F45000
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015270; cv=pass; b=uQ70xitIwoyhTWSkijDBEnmD3F7FaOhREja5dOXrQCy9S6F8TJPvyDhmwbokrxHIz+SeQjLj+dYwYGI9ug6lCnX+ka5Y+VurCWa5kPf4pIYWhXGTKClSkykC01/aAXh3vlK0N1j/LsNJeB5brBIWBwnpOMsLsEzb6hGXhKlI13Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015270; c=relaxed/simple;
	bh=tDkv2bU9HWtU8oONSqRPoIrmaAy5Zn0Q88n2clGWWtA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ot/MfIoV01lMWnyp7nO7/6gun8YjbT3AmZwtL5IMF7qvb103zJwTxXTBdfLi6WITngkCgAXB3IAWdEb1R4hDvcHTeHhsxgEmlpU1xSwPMvE3l9VbUl0Nx12Ywoa4z4Na6zP43XEw5FstrLG2Y7fTD4dvvk67oToRSnr6tTc5xyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb/OC+5I; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb/OC+5I"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-745659c70ccso472268137.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786015267; cv=none;
        d=google.com; s=arc-20260327;
        b=mpOhDb7X5hedAZitQDheRJtwOVr+/QC+F4XwyFHNKqOtIEFLer8d2xpT7FHzwofjnZ
         zgEevUP8kXQGQXvKAsW7WhkS2jJ1bYaZeKBQl434RCMNhE8gCttEQyyOSoIF8gmpKYqV
         dhSoFuoRg1j044KH4TTv2d0xL9RmbG9UPwBuWXrR7nXioH0JSDn9DIeDSB1fcv62V/c/
         WxK2T/yu4c/nyYzm1Lzf0ZI2ezOhvTRTrnNeqsazy6Km1Jhv3Jzm7zl+2olT+vQhFcte
         jCbs1LbvJyAbQisBFuqpZLeBNGxTRI4uIheY3Y2Pu9fQLqIQv+nrcJqyNTT4WE1PiEjS
         yWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=tDkv2bU9HWtU8oONSqRPoIrmaAy5Zn0Q88n2clGWWtA=;
        fh=Mwb6KwTf6AeyALkQw2Bnbhl0B9iwAWttKpDFmBfOV0E=;
        b=RGr9lD31OWi9E3lYTA/kT/pFI4nEeuDZV7VPv4NEb/1x3lMzlBInDS7PkqwAx6dNEv
         7/T7kKJyt5+2WRMEtIDBGtowA3oq5O5Cax+qXgR99msqybdbs/PiTgBnr2jCcsFa6KOr
         33z3oF5k0Z481Yu0wbRbV6Y2vph4lJTwc2AiQSig0pLA1jxx567+8dA8JNk5YQ+q6s9/
         erwF9c8Q1gWeNy/BhmYLXXbIEbkdTsodQB18LsEGTwhMwdD+9D/rpladfNb/08wVLYSW
         RR53c8J1EQ/tGaCVh6GBJ8ESahWZdRZMlHXO1HDrmT/MjQkAskWq4TuC7YGTWL1kbLGp
         plSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786015267; x=1786620067; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDkv2bU9HWtU8oONSqRPoIrmaAy5Zn0Q88n2clGWWtA=;
        b=cb/OC+5I/GWic82Lun7OuPAqRHBMecn+6IVFuOyTWiqSetoF159DTDc8uaWDlSfO7w
         S+9cZ7PIIiZnpNtsEfXxHfNZgZCwntKuU49ZtsmSsV9/zPj7A5Py9RnwJwntRN/72bGj
         Xxt7rUDYH/KUQWEH+dlzHFXAQxR8PfIVoZD3tgwr2sdX/FKLettkhaYxkh6/9OyJtVJ+
         zzqmqGT13sLvtG0N1P49/eItPjWP1I1Ofr8W5vF84bLwZ9ep/EBz7Gj+rzZ5bYSwicmE
         6yx4bCgTRDmYEOGrh/4/quo08w66Ls6JKQjkLviVaI8+u6EfcpJHAdGBlmXxk3LkZ9nl
         sLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015267; x=1786620067;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tDkv2bU9HWtU8oONSqRPoIrmaAy5Zn0Q88n2clGWWtA=;
        b=LT5uAJFSD6JivtBbDwixGTJHY4SumQM650ih7UVldYY1t+hegJXH8XJdfw6piTI7Ru
         smZF+N50OqlBJl/q0KPAf0o1mWvDPdxf6r86NZVG0oJlMC2ix9VuhBlCLRsQfv2RwVb9
         QgaSQqMS9p7zfhd9t/iEf5A1eo4JFjNPtLIU2Snet0dYNXwI2jydGtxqSlQRGVzlfjqU
         6V/zJ1w7ilJaVogUBVPb0DB6EMt18k0t/6kuitwUXVlHrPTCx6Hi4pi4nxwgWL0r2Psu
         tX/FuDmzz/uwUGcYQpCKGST/Zx+FI4+AlDGtJJlQOMjCIBo3tGoEgBbnAm//dB+2eDwk
         rJ/A==
X-Forwarded-Encrypted: i=1; AHgh+RrUHFGitaSsWjtKq1mloCkgRwIFKSttHqDIcyQn2fDeBIo+10vRa8fxF3D81H60zEwHr50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDEUWXrQMubTVA95msK5Z4xYQnINczhtfnGvIBZKnGfMBDgypn
	7gr4PVndon6FfTFkst2B/CBIRi5G4waW/WS4CrLQE58C2wN5FaeM+4OwDyCywQlWhcTxjvCGOUy
	kKj8v4xeV7gTuAzjXr2Py6OzoJ2kKjUE=
X-Gm-Gg: AR+sD10Tz6Bbr+QAFHHj1yevVGm8PYzlVdHD8AjU0XiHQajpY6cBylckmAi0uaodO6J
	U9JlChawQeWtAM5eVD90L0DI7mERoDIO+HKK2aUt9Ux4pofmTkt/weG0aJwGlFQrdsAz1dKbbs/
	hqiJLq3l2xAzEOOjTkIZ1uqCPbz7/o+a3oRyD/WWkPF9T2+gL+7giKde+25Qk/YK2ns7jtPn40B
	g79Ov6SBKZIKrGxtdmfMu3vYDPeR71D80hnX4VBBFYYyqMR+8Btpf0NFHcIhCPJsRv0JxxICNFo
	xZmADuLX+0nV7Vk9Mx0n6tJyv/K2ddY+HYGKyqCZRJQwr3P7vcDeHDE021MDy5NwNCtL0b/kigy
	x2h1w9+qBlf3PByOYrw67jbwgfWiuXcQi
X-Received: by 2002:a05:6102:f09:b0:6f0:3ba3:7d84 with SMTP id
 ada2fe7eead31-760e77f0ff5mr3190323137.5.1786015267573; Thu, 06 Aug 2026
 04:21:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Aug 2026 04:21:06 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Aug 2026 04:21:06 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260804-objecttype-support-v4-3-31511b0231be@gmail.com>
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com> <20260804-objecttype-support-v4-3-31511b0231be@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Aug 2026 04:21:06 -0700
X-Gm-Features: AUfX_mwoiyORXRzWrS6DzfE2fhtp906nT7lNL7PRQT8Y83x-9OKbgBIV2kXU8eE
Message-ID: <CAOLa=ZT_Zv82cWdhK6rJiAQm05WjdPwfG0p7nLO9pZ-hiX4g3Q@mail.gmail.com>
Subject: Re: [PATCH GSoC v4 3/9] fetch-object-info: pass arguments directly
 instead of a struct
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, gitster@pobox.com, peff@peff.net
Content-Type: multipart/mixed; boundary="000000000000966d0706585f15c0"

--000000000000966d0706585f15c0
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> struct object_info_args groups three pointers that already live in the
> transport and are given to fetch_object_info().
> Grouping them into a struct reduces the number of parameters, but it
> suggests that the three belong together, when they are unrelated and end
> up being accessed as args->* independently.
>

This reads much better and explains why we make the change.

> Drop the struct and pass those parameters directly to
> fetch_object_info() and send_object_info_request(). This should have no
> change in behavior.

[snip]

The changes too look in order.

--000000000000966d0706585f15c0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c3d51cd48e2be247_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wMGJpQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWpzQy85dGlXOXZSWXEzZjRSMGFnbXNwY2g4WXRoTApkNXliWGd3THQ4
V1AwY1U3eUdONnBxNDV0VWZzN0g4TlVGaXYzWFFtU0ZvSTZwZ0dFYWJEWUpTR0hqOTROdmpvCjd5
VXdCK1k1dTJmdll0NmRhUVBybjhVdjUwNi9iaHI3WVJlajhSbWlrc1lTY0Uwd2UvdkovNTJ0RzJK
QkxrK1cKeXUvY1ZwNWZzdDltQjdBVjRLelFhOFFFRjF2T2JYUGdxUFZwTWRraEtFamM0Nzczb2FF
Zk82c3V6eTB2WnBqcwo0d2VNemhHYkNuVitSS3o2dEFWQy93Mm1Bd3AvMjZIMzRFYmpZNEJzdEd6
cW5hYll0SERyTkljMzB0OVpwdEVTCnZZb2FSdmVYOHF2T2NYTkczL1hDSWp1ejNUV05FZnNsa0Y1
YVd0by9iN2ZGcFpzTXVoUEJCVFVZaVQ3RmV5c0EKbFRVZThSVzMvVzRhNzdpZ0t4L1lidjZ0N3Fy
RFdyWW1Ta1RJM0VLOGFVMm1Rc1BvMEdCSlUxK3VxVUNJRVNXSQpycWFTcU4zRUlPd29hRWhnMlZJ
dkl4RDZpZzlkU0daMklYR0o3NlFNMnhqRGNOSGEyS1JTaVJsUEFnMGxKM1BtCmlrRERPMnhqWkZO
RGlPWmpmVlVUd0d3d1B6SFU1WjhXOVlqcWU1ST0KPUJOMFMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000966d0706585f15c0--
