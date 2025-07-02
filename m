Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A04B245032
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448320; cv=none; b=iKI0FEyU8ISDGZi5NFUTNAk+QKEdAlZTa72NRafHCoW2p/aoz+jaYadkuabykPlo8mUqwdiSedfDp+R/mlwIWiFRNnBdQtQeJeVgMJypfuwC8ncxSAqln2+0YUPdY1QSm5YFB/Kw87220ovH3We3eypWnzr1OGV/e7d0+QMsddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448320; c=relaxed/simple;
	bh=BH5OpTEEWKD10ak5Et0Gh3BtNo06zjF5eGgYLq+BvqQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=iYRH0q8O6VnxAZbEcnt0ZwI5q5OkMrdvS+LBh7nMBYy8Cbh5OEReCFACiR3OvkilTU/PZZQlUWXxcnH6p+NUUfYr1yqyzmreWIk55GCWImWWWtqQ4y8Cx7loqHRdYLATiT+SfmNiHeQf1CibDRN61AvfSrQ2i8yPrEPw6gDhrWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mme4jddF; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mme4jddF"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4e80d19c7ebso4046599137.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751448318; x=1752053118; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nuh3Olk/QZTSxL1bIsgTJtpr8q5XWtjdVc+7t7Lf/8c=;
        b=Mme4jddFK4lQQoUHWn16FXIWTyu756J5fANXmlMh2NXZd0F9rxDDnPbqLfn+SS3VWm
         XXymkwbkO0eaImCNqjpMmCRdXkGjN06BOrp8KuXL37rN5Ynbi60rtCIf3fMhJG0JH9vL
         y/H0ZYYJe6rWCv0AiavsUyqTIFwZ3uU0yHSp8ywj5LbAL1YxzaQPfJREDoiEs+S1gQ9Q
         4ZdJquxfY2d7aMz703y21Ld974Zu/6PKd4S0DCTCZ3sribtmriCFvAL+hK09DUiW98f7
         XClpYNfjqe2TdblvokgdXsgR5yTlMZSDzgh9aWSvxdkds797zxMDo75hrtmfb6AIP2/C
         3E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751448318; x=1752053118;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nuh3Olk/QZTSxL1bIsgTJtpr8q5XWtjdVc+7t7Lf/8c=;
        b=uawb31Fc4J7cNR22KydYL4IUkbXqhnAZvh6/1o8Lbuvp2LG9zJ9h0HjrsBiy95MvAd
         JfMkI70+NB4NKQcvcs57+Cg3OrpQtylzxsRV2TjY0ieiJ4UIyrtMksKP71RBvdgVBVU0
         DWWfo/pWrtdIrL5fKbytDgyjaJeQF/NT7u/OuIhzizblbAdqkTIN9kTyPWJf4CEWKHbB
         kirePPPm0tHopONfNMa+jAi+ZO3Ai8OEa7hVnFF09YAJ7otGKDzSifDJSl6wfMORVkl3
         OevHGqFcaAE9rxU6iMk9c0r7emQtjZLpl3TVTMffJK6HMXDn7WfSzF48L6Lr3aTPCw65
         loQg==
X-Forwarded-Encrypted: i=1; AJvYcCVtRGIEhU9UPHvYiVXoceaNsyTykJbkjTqTqPrA5YLV544jhxhRx3b9csi5Ez9FAqAPufI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfzB85UaCds+rdrR+iuRlXgn/Ty1uFCGhaUh8mwRy4HLmQzqUA
	7lUvRwGF+FKeATJ3SU+UXq4/aCHvYxAK5SkGy6+L31AFjBLxqrLD/MpZBKHVJr7mZadPIzhTIgN
	ag6nhBYXbnMGSiDn0O0eTJGhAj/8dkaE=
X-Gm-Gg: ASbGncuUAT3r4Pe/bSjjmlk96WYIBHkdyES5FVB3zQvz8w40j1MQ9YvY15Z2Z400Pr2
	dLb2DeS4PY1pzTfbRbJaG7LoiM8dK544pois0vBuwzxWEmMpEk7ROxfbELpgKHuGf8azqcRx9sP
	K5Irep2fbsKNfRyfi547Vpubd95cfYGsb9rURDjyF1TK/MTbgrYN9vUA5LfOlVsCnu6ORnCal2n
	XeHew==
X-Google-Smtp-Source: AGHT+IHXPRs0LwY7t71uCFJfyCBgHIMg6mreWrezDpoptK6jP5wvHPEvN4rOdNHsXFMinSzabKM/mxjt+FwDAnQM4m4=
X-Received: by 2002:a05:6102:4488:b0:4e6:f86b:b663 with SMTP id
 ada2fe7eead31-4f1611fa5d2mr798087137.20.1751448318399; Wed, 02 Jul 2025
 02:25:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Jul 2025 04:25:17 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqwm8rh00m.fsf@gitster.g>
References: <xmqqwm8rh00m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 2 Jul 2025 04:25:17 -0500
X-Gm-Features: Ac12FXxB7bF4OLMndxrOUi1hDL_kADsk2D8CoxUfUVeb2kw7Si5-Cv570dbg_C0
Message-ID: <CAOLa=ZS4A-VonwLGTMZE7pA-dozY9ERoHD4F=u0pKN_mMg-mWw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2025, #01; Tue, 1)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000dc6e3f0638eed6e6"

--000000000000dc6e3f0638eed6e6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> * kn/clang-format-updates (2025-06-30) 3 commits
>  - meson: add rule to run 'git clang-format'
>  - clang-format: add 'RemoveBracesLLVM' to the main config
>  - clang-format: set 'ColumnLimit' to 0
>
>  Update ".clang-format" and ".editorconfig" to match our style guide
>  a bit better.
>
>  Will merge to 'next'.
>  source: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
>

I sent in a new version, with a small change in the third patch.

--000000000000dc6e3f0638eed6e6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2e979b640184fb02_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oayt2c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mME0xQy85M2c0Q1RyeUVTZysvUlc0UitzOHhQNHdlZgpoTlpwdWFWbXcx
Zkd2c2NUdGtVN3RjaFdwRFF4OGpqOFhyTEFFSXNERjIrR0cxTERaUzFPMTgrMGlTTUJabVQ0CmhG
VnRxMzRCOFNhYmphNUlTWWxja1RUV1J5UHdhYWJtczBqeXY1NG0rbTJqR21ONEtkV1JoWk9aaVdQ
QVVka0wKVTNHcGpxUVp6czlrNXdGbnJ4cjJkbmxoeHhBcCtFcUczdUxKQ1hnMjVIRkR4Y1gwZWR5
WWdIL3dVZXNONTdQTQpRQXFhbU94SThNemZBWUVaelVOMXRhRnNLTlBEc1hrQWZrZlU4RXg5aHZU
WjNyNi9SRUx2SjVzcGltdGFZck1RCmdPQW5VclJzSFF1V05qTEdPbHU3c1NCTGFONTU0czhaR3VB
OHYrQlFWUHp2bGJXOWtJTWkwb3krZ0ZIRGdLUFkKVGRIZ0J6V1RnNHZoUXZhTmpQRU9VNGlEY2Na
SzJoQlpjVFljYVJFRzdGV3EzTlBxVkxrY3h5VWtFNk45dUZMSQplakthdUR1WWtET2N3TTA5ZGp4
UWkxSERNS3Z3YnUydU4wSE1wS3ZmcmRkRnByQjV2UlNnUDJZRkRmd1ZlTFdLCjY5NTBGNm5OT1pJ
VEpiY3QyZGE2UC9kZVJFNUN2RWIxcFZYSjFmOD0KPTc1M0MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dc6e3f0638eed6e6--
