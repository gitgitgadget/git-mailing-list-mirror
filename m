Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F58479
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463006; cv=none; b=jBUv+bAAB6/rduiSh2yoD0eyuhqnCmA6//QkPCt2ZFOahShzOX71vB3U9vRW/tOABV0zZN6no7/HAuZxzXvFeGq/i+yX8tFHS36hvg/dhOJfbpGeNG7XHavD5tGIeUIWui3ioe3X1FD5XPSC0KglVzl1FEfSL1AOP7JgoGGft9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463006; c=relaxed/simple;
	bh=lalTPTBEqQlA7/0GhvjSGMMEErt/OjmkNaD1kzWZ+Qo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=gib6W0XlRgYBZ6lsoLQnJtjBVso3YFsiKV3gb3uONthKUBfzwyE+vJM21Q9oLwj0lckeUggNMksRjyU37YrRpt9tL9G22PTxZNeiZPVfwwkKSMeWt1Z3fIFxLC3yurtf5DlAKpxxUNY54g8kefe3Eajp9FyljcKryzmWYXDaKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIe6mNtH; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIe6mNtH"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-72ce9790ab3so8045747b3.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 17:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757463003; x=1758067803; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6yD4xmkWUcIiKunIghV5DsIWV609Yh8y7H00frkMnA=;
        b=XIe6mNtH6/aawAUnWXrMo8+34QmVT8ncUujzVInMecn6298BtwJdnzZjlEUBaCySDF
         MKlhoG6CEyzuqWDPspV6d6PdzKnZDE7mYeEUwu+M5C9XgA/bf858QrDb1e+13hkKw574
         v4I7YCPWZc6o/7kA8FWJmNWPO9rm64UXg5CXoKZqm4+GqjksrM3M+hbKxS91p12Zi+Zd
         qhd7eRjEp9V2ziS3naTAWYe3OPx5ALRCNEmOGKeB8PLiI9ullTyZCl//szyI6a+oq0Rp
         iZnf6YwdEnVJqO96pDmtO6+NHi842kKTCs8fOmYl0zg+da69ChKIGLJUrPmq0mNSMa9S
         MLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463003; x=1758067803;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6yD4xmkWUcIiKunIghV5DsIWV609Yh8y7H00frkMnA=;
        b=Tg/MC0qyYi2nP6kgkX3znzR6gfVBzqDrQWoS/TgyK6THu0zcIJSOeHI5yLSyXRLRb5
         mTaa3G4R67FhdtXKtm/TtKxn75Bd55KV18wWxNCuooQ4QAVqvXcnFwGgpNIItSiSgGnI
         M1uGw0FT2zfy1x+QYT2CrIoaq7zi6s3yFFErwyspFJBur68i4VcReNLP0yjcoz45mZML
         xsRB/hr7rP5jXhgksne0IB8uxKi78HKOlt8AQ54JtwsuszOcqfGaAgvEn1X3BODHgo+4
         JhkVW+8irX2svNPq6Veam1C4hD8fA8SsAGJOYDX1ldKgbJ/FFJQCmb4ZuVM795eZtL2+
         OE7g==
X-Forwarded-Encrypted: i=1; AJvYcCVGgsEKonLxfyCgPjxYSfxck3eep1ylzEsqwSETwZYQnoiDH0qmOsJ0k3oe1Y+yH/s4lII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxArhvD/JmPxNIqMCvBfeh1Fxyxy0ETKrnxBB5KagF3z4vIGWT/
	szDBiQa4geScR2r49T5ufp3BfDi+xkL9K2WavqplDVAjKztZvNQyXD7M
X-Gm-Gg: ASbGncuKj/PkMij8D+igeZmFby1MtJj60S1OFRDcVrjmNQ/j6/x5XSFSJ9z0O2x7vhE
	pvRV8rjWavDedFKG0XuDLEobEqhUqATD91RbIRv/GKMmpcteSbV0zb6VgK+UaOB1HeU/Jmb4BAi
	t82F/DFIeUDnxfZcgFi9bmaJY/nOPIvElh9VtE2JPHOcZ0rzIu5Ar5mf7LEnLmASF1Ctjg/YJxN
	/Ezw8/jsgpcrvBlS5EGD+OLj5V0PE2K4p1Rk4tp956xgXaga0dy3X6tKccbMoXnG9q32ITwRReP
	o2NUCdRvWisyGuS78FjhsaoDEsK9saedHZjpRq3nn+GgFRql+pYVMk/NRzIsDv0t6rG0y1jyfDo
	+JvSNoR3ZE5mqoeFJZOoMXQo4IdORQnQQEUaSxiJxedS35F0ywnT25FBSiyYBrg==
X-Google-Smtp-Source: AGHT+IFYlaXTt9VQsshfZfGvLAFUyO3E4rxnnKj6jT21nIvnZog4SLu7CxW2onbXPDrv+hfhb08MIg==
X-Received: by 2002:a05:690c:620d:b0:723:9ba7:7f9e with SMTP id 00721157ae682-727f4d614famr137520927b3.25.1757463003249;
        Tue, 09 Sep 2025 17:10:03 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:a4ed:b0d1:e879:d740])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a832908dsm65814007b3.21.2025.09.09.17.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 17:10:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/4] string-list: allow passing NULL for `get_entry_index`
Date: Tue, 9 Sep 2025 20:09:52 -0400
Message-Id: <4D8F4C73-5447-4588-AA8A-7DC0646892B6@gmail.com>
References: <xmqq5xdsyjoz.fsf@gitster.g>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
In-Reply-To: <xmqq5xdsyjoz.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 8 sept. 2025 =C3=A0 12:48, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BFshejialuo <shejialuo@gmail.com> writes:
>=20
>> Callers of `get_entry_index()` are required to pass a non-NULL
>> `exact_match` parameter to receive information about whether an exact
>> match is found. However, in some cases, callers only need the index
>> position.
>>=20
>> Let's allow callers to pass NULL for the `exact_match` parameter
>> when they don't need this information, reducing unnecessary variable
>> declarations in calling code.
>>=20
>> Signed-off-by: shejialuo <shejialuo@gmail.com>
>> ---
>> string-list.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> I do not quite see the point of adding these conditional assignments
> to clutter the control flow.  What benefit do these callers gain by
> not having to have a throw-away int variable on the stack and
> passing its address to the call chain?

Wouldn=E2=80=99t the point be that (at the cost of slightly more interesting=
 library code) callers don=E2=80=99t need to introduce extra ceremony for re=
sults they don=E2=80=99t use? In other words, take the boilerplate and push i=
t down rather than up?=
