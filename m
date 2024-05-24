Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5239974407
	for <git@vger.kernel.org>; Fri, 24 May 2024 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583141; cv=none; b=Mj88urFO+VHk2PjLJih0dFMDqtU9bT3DmwFoBzoprb1P02zMXing+OX5EFJodt7T/yxX9MQPzjU/LhulzO2BOdVYmVPT1iXtM7IkFVgYMRbAiDt4YflEnLehRqLeqEgGqS71UtHFwKVuDw/M+U9SK2jr2E3vDq6RZg6aX/3VSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583141; c=relaxed/simple;
	bh=4tfKYM+CYGvfsknTOZ9cC2bHzKxX1FJJIb1PlOArofc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=fp447dVM6B4wN8zdL/8wsl0Reff6CtOuZpL4dCDghX6rrlBQMccOcuJhLWbt7j9xvEdvAk+KOh3nuUKCGEoZAbpDGRmcoZFcGCCJzxMPX2KI7kF037sJwVhQcdsQtPxW+Ctzj8sxyfCyW6O23LTj9DiFnzafllcm27IN9BNdvvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO/uQLTO; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO/uQLTO"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-248f7fdc323so3848940fac.1
        for <git@vger.kernel.org>; Fri, 24 May 2024 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716583139; x=1717187939; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tfKYM+CYGvfsknTOZ9cC2bHzKxX1FJJIb1PlOArofc=;
        b=GO/uQLTO2q2rmBCcOECML5xuh8sotBhN9VMqO7fhGTYCj0unPD3sgUOrFXC7EQCMdV
         bm3aVyfuqWZVa5xzV2/882fruRN0TXqnoGf9ZO7vfniwg4yP3sS6VuDSgNgrhkUrkgHf
         gPwyjOsKOYxFdbhnyj3vR4azLoaNsObr1W/S/P8Aa6cmQ0wScAXFP8sn2I1yG6oRizoj
         zyDVUsA+sO6xuA2FvbtsbeMnxlPgQTGco8DRznoUF0Tivmk32CPxWoNJCUfJMTN5v/kT
         kCQBCPH9TZLs7QhAZbqZcPh/LKv23W/4rJQB/OB0xaI5HVJmUN8D4ITzQtaJAB/+3msX
         MxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716583139; x=1717187939;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tfKYM+CYGvfsknTOZ9cC2bHzKxX1FJJIb1PlOArofc=;
        b=ivApLCld6MZgmEyAg4sIIO49YxRvGd1Ed3uFzZsV6zB6i/VN2qy9IoGdYFJ688hTh7
         Qml2z+4VMLjG4UkTu8NQX16ETmfGRxFVWfMbYTsRRmCzf2iFbEI5nlDeXs5BXCo2ZiyM
         kWXKt5n3Qoq/9my+WQO58ZYfOwJYMVLQq6eZWvSrXQyJ9yEEMTQ3zc7iZM9xh/Nrrs9o
         NniT4LpDFKvQjxj7Ru2yqITDQMBb+YeUM6Gf5Hi/6z011tTEmwncAxiDMlFJdkeX5PnL
         bVPTcylhi0yTKrZOIvpA/Pt9YeMYyMEVXzJ/AerZstcWWnlInCg9t4ip4zLyQMux27m5
         LMeg==
X-Forwarded-Encrypted: i=1; AJvYcCVrW+K/neVPFtKfb8gfi2MGTQK5kLGcjwAczf9ApnFfKJCRb6kiSYntGRxgyVct6eKQ0hvJIe5swGcIsXPWOMHbkY/U
X-Gm-Message-State: AOJu0YyBgx0T06+tnJvdOtAQcAoBwo3xrKi43KYw8c6yZJZYkmN5BA4t
	Jpk20Pm8QoAXQ9LFnZVujfHUlf8xLIftCt3f1OwI17+ODTi2MUwGfGmOYfwManLFr4WIbXzsWDJ
	RBlbImBvIVrXYnqTnqF0vcimVFyc=
X-Google-Smtp-Source: AGHT+IFj/VUki6CHzvSJSwLOI6poU4kLji4KmFh9JVdDx94ik55C2kjnGQPGTmdUtzSy6+Gxxvf7W5Vr3Q5gEbFlPv4=
X-Received: by 2002:a05:6870:8a12:b0:24c:a395:1957 with SMTP id
 586e51a60fabf-24ca3952a94mr3951723fac.26.1716583139280; Fri, 24 May 2024
 13:38:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 May 2024 20:38:58 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <05fbadbae2184479c87c37675dde7bd79b3e32ab.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im> <05fbadbae2184479c87c37675dde7bd79b3e32ab.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 May 2024 20:38:58 +0000
Message-ID: <CAOLa=ZS09FYrFUvUYzoBy27q3NSEXEO--4mCCqLSwZXDCD155Q@mail.gmail.com>
Subject: Re: [PATCH 02/20] transport-helper: fix leaking helper name
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003eaaa106193928cb"

--0000000000003eaaa106193928cb
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When initializing the transport helper in `transport_get()`, we
> allocate the name of the helper. We neither end up transferring
> ownership of the name, nor do we free it. The associated memory thus
> leaks.
>
> Fix this memory leak and mark now-passing tests as leak free.
>

So this is done by removing the `const` from the `name` field in
`helper_data` so we can assign and free its memory. Looks good.

[snip]

--0000000000003eaaa106193928cb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ad4d2af79398a1b5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aUSt0OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNUNvQy85Z1ZWOWRwS2xlOEZGcVNwdGZJcC9HaUhXbAppU0xldnFJd2Y2
NncrWXdQMTQvcFBjRDNjMjRVYVVMcUZlQi9qeVRpT1BqYzNucHVaSVlPOGFDQlJBVVdLYVFRCngw
NFpaUTd4eFV6aTlpL3l0R2c2M2x5SjdsUWtGOUFoMExpYWoxMXN0b3RuaGtYQXhLRHZ4UzVaT2R3
TnlJU3cKSldrMVpabEE2akFFUzBMbXNySzh6NEVTTWh1MVFMbGllYWJDc0lFdUZpenZ2N2dMRmxy
QnFGclp5SERNelM2egpWc0pDSVpqZTB5WlVuRzZhWVhnZFVBRmN0bWpFNXp2OG9yNjd1bGlRMlpp
aUI4ODhUZFVleUFiaWtrazMwT3JGCnFmb1RGc1NYOHppR3pHUG5DdlV0TjV3S0REWXNtbDRFbmY5
aXAzZnpjdjU4UWZva1NCekdtMHhjUTlFSkltQmUKc3AwWGdRUlJEckNqaXQvTWFhbktPS3M0Vy9n
UmFqL2plcjR3eFNoZ285TW9vT2dyKzc0bTlRd3l5Y3lxd2J1WApnYmRZZ3RlOGg1dEg0bGMzbXRG
Q1F6T2ZKTCtrMlFiR2psTzRXM3F6d1YzOXptRTRld0ZPU2hraEFzZ3doOHFPCno4WHZpbS8zSVVm
V0x2VS9DeUxLVlRWd0J3UW5YQ01pSzNGd0RHRT0KPVRCa0kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003eaaa106193928cb--
