Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F71FECBA
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218127; cv=none; b=t+ttm9vLr9yN6N0SEOTZ3JlufwJLk65ECaS0Y41coUAbI2YleFhMffxbNym5aLTgBd276KB3SfoyuM4wGbe1aKvaUQl+IoiQd7ySBHpxXVRzFyxBcvjEE0xJoHx0GCA9E1zdS8EUJ4E+Ml2yp/IC/6kkeKYNvhHyWGKL/X3c3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218127; c=relaxed/simple;
	bh=x/x6haZqtLAgdVeXugFJBALMCNh2Ise7haRz8FHsaAI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMFf2+shBre19WTyp7HbUGWLhk9ye742l0gSYefIurmEhZsBwp++n8LWk/rqRLn9CmaJSmm+YoVsSVkqkdWL+YhLYC1mHn3aj7bP2Jh2FBwCK4NMwMEFHXMaDCeaj5gRwLv0f4XPFpkUoM44OP4mxdGpAstSCM4u1a+7MNDKD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/4JroTG; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/4JroTG"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-93f56a97064so1924712241.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 03:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768218125; x=1768822925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/x6haZqtLAgdVeXugFJBALMCNh2Ise7haRz8FHsaAI=;
        b=E/4JroTGN6ZABgx0568CLNuUmgMlBgAB5iORPCkiigBzsCucpEiECXyCfim41NHPjm
         ReQa+vPuDiLfJJk6Egb+VfwsBVTk8Aujy52ovUxRrgM82syybfzUlOK3XqB9SotZcCOJ
         ig14dMzatcbJfe8MO9RYKwnmiEi930uMxTS0GDEXTXeUI/gA0SyFWzKpgOIbVa93m1vH
         H04mXaj6fr2vCThnJuGpaS/+9hr/idt1uXs14zxv0f3ad1hue0cWcLNKOaIUzuf6nKFs
         i7Y3a3RQHp+eCC9GkbqZk4627qjchPyln0IvAB1m+owpfOt3T2Sz7k6WyhTfxlcr/Cp/
         n+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768218125; x=1768822925;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/x6haZqtLAgdVeXugFJBALMCNh2Ise7haRz8FHsaAI=;
        b=bBuWrFrtubcl4l9TtGYy6h3RaBUk9Nz3Mx38xj5tA/maFQq6CN9/xHuWLTqzVgMh1E
         4f9/WG7lEfK1/NIAidGFumghQ1A+DmVnnCevTU+j0VsLHECT1IkDxtnaMX0c4jwgCz70
         E6+5k3heBUjlnlfascxncDsx/pxIHW3RlNa4ZqmOqIAtO0WLsprgoKxxr+BLa03A6/0g
         0NFWDzBoUfCoLCgQ9ZYS66WPU6PwmJIv3I9eKewFZ4DK9KUtmNKNLHoQAVvV0d4Q3MM2
         769tXZ4sCcPKexs/tKSQK6W1s8rfMeDWp8RWhtz80KFqIRF6O7v6nsMH8PX3ehQunsza
         POow==
X-Forwarded-Encrypted: i=1; AJvYcCW/zcEwCiVavYHjWsEo4nQNZELnOJxJ5M4hvOux9c9RXqYWMkzT6Zfa7W0aLYbzYNSBByM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNGpf5JbSymUOUSBTah5uuieB0y3yrV/3kPNpnE+JGg/u8XC5
	Zb9qwxhWBx9PmMU2MRam4ncSqAQMhehHqXnTfrt1UXFdxIstJgHHu5/DOkL6dEFYEjmH3qYq3y/
	1EehiRr7Oo/wYMmcLPsjINmEcEEtUXXFJ6w==
X-Gm-Gg: AY/fxX6Et7TDBxdfol5UJ229ufDcAMYarN+j/UOJw3DNqLy6vTz1+JbuLEg7Cdlb/BV
	8yXf20VXuPk57ARmB0EQL2r4tkxE2J5x7D0qs2ci8AQsOcdfJluV8wnyqpY9xxy1oV2gzoGij/j
	7mJV3fbgK1dnZY5begcnGSveUSCGrDae4Y5P8mg0L4ZRDG+ricPTtWH611zsabXWrChLRnMy4ia
	BaMmO/I2Wx2IzspVnnV4+ZN4vGzhrRjjxquSExTDvlKOQJOFrLKZqdXds6jiljXD7yPMA3Fs40K
	0PdBNpDim+9ZpyFKPsLCM4rD4nJfEtjmP5eho2hv
X-Google-Smtp-Source: AGHT+IH9NcfFwnuBzU3YsXgXkC8UM3TWhoTKJKtavW2WxLuFSSk06HSjY66PNXwoUh+TxHZs4KWn+Xl+5wnx79qBAY8=
X-Received: by 2002:a67:e704:0:b0:5df:b5d4:e45d with SMTP id
 ada2fe7eead31-5ecb6974d48mr7364490137.33.1768218125435; Mon, 12 Jan 2026
 03:42:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 06:42:04 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 06:42:04 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-10-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im> <20260112-pks-refs-verify-fixes-v2-10-2e9e453bd6c3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Jan 2026 06:42:04 -0500
X-Gm-Features: AZwV_QgD5cOJHvz8TArvuoPZDmkrY0L_feYYAuFBPI3z1cLQaSRONHBcePQ32is
Message-ID: <CAOLa=ZRMvbRT64+XdKobM5RZhgiPd=2k5_Yf=rgKyjWnbpMg1A@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] refs/files: introduce function to perform normal
 ref checks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000040a25206482f5de7"

--00000000000040a25206482f5de7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In a subsequent commit we'll introduce new generic checks for direct
> refs. These checks will be independent of the actual backend.

I don't think we've used the terminology 'direct refs' before. Took
me a second to understand. We generally use 'regular refs', but that
includes symrefs, so I think this does make sense.

[snip]

--00000000000040a25206482f5de7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b1fb864fe8bbdc6f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sazNnc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUg4Qy85UG0yTkZLaU5OLzIzNnlveElTTnFjOFE2MwpJbklFUE1DTHpx
QUEra3FNK1VOTHpYNlJnbGVoWm9zQVlKK0NnN3lhNzZBZjJsSFVsQVdBbHA2ZmtFMUE3bC9YCjd6
MmlqTmgyY04ycmJWVlZnWk1LY05wRTFLUlM1NktBNjJrL0REcW5pbytMalo0bTY4Q1MzcStTTDBk
NEpvQmcKSzlvWDdHZzcraUFpeEkyc3R6c2QyMndJM3VHME9pcW1VV2VmcHc4QUYvUzY4KzZqamM4
ZVdVdmQ3Q1Qvem11WAphdW54Nzk2N3hzSlB2MGcvckNPRGNCVlJnc29sRGtVZmNrSlB4ckNIL0hi
YjlZazZ6THladE1CcGhWNW0wVHM5CkpBSnlvYTN4SEthdFJmbWlsWDYvN2NPU0hBS3JUQ3k4V2Zz
TFFJbzBxZE45N1ZjeTJ6MThtNE5zWVVRR1BOME8KVlYrVzBlY3lXZVRibTJxRnJhTnluZTJsNEpB
NGttMHFGR1AwMDVSSGZxakYxTCszL3RhQTI1Q2VGVUxObVErWApNVWtXWUFIMHlxZHdldDNmYVkz
Njg5QzBHemYvdG1mUkRxSDdUMk1hVUlRNkhYVG03ekJnMVhkV3k4eDRuNGZoCm9WU1ZrKzk3YTRM
Q3FLS3VjN3d4THNKVXJNb09BZ1RvTVZ1b3BaQT0KPWtjdlIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000040a25206482f5de7--
