Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F6150980
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535402; cv=none; b=cq7HjmEnPbMur1YG6a1tBz9tedeeVDnv8wIxyg7y6yrfUWAFRoAjBOpEyq7bnvK1LSR8EB9UN+AYwiieFgQtx6u69b2gWq+jkuWEYwMsxfX1+9WCduNZN5BW0HyXMwL56JFOaZee2jgQLTTuQvcuzeN+/B3pM3GVu3BSGu8b7bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535402; c=relaxed/simple;
	bh=vYii1hkovVDc9XLVTnAa+oUjxMRhoLMeaSix+3zI4xU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5lecYSAL3cxfrORHbHoMoesDwwGlUdicHOigxlg4w8vYMkCCW3lf+ojjdLJNma8hB0ODLfA7nXAK6Nh2WjCML1hbs/JRPFWlytV+TAJWHi+fXjAT9usB3FDURy1+sOui7Oo/KURUvRIb6upoDpvUksmeuyEjP11aGPN9Viulc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjxpQFRx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjxpQFRx"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2efa856e4a4so4791406a91.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 07:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734535400; x=1735140200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vYii1hkovVDc9XLVTnAa+oUjxMRhoLMeaSix+3zI4xU=;
        b=VjxpQFRxtgULKwyzRiSKv3CcbHAYsWuORwu4/ZiBzrykJ+wt7hp2zOqX0yLlxWa2mo
         3PhoKh8qJX/Xu8G2X3r3r/Hizuf0U4KZcGzpACmQ9wpWUHQia6W3SzN87+VmXm5WW/um
         8ZnR4jc1RM0nhX/XWIdMn6lM6766il509cMb6ZYZ5DA4xqJBBeAnvqPyZImqDitQ4o1l
         01HbMrLCAmiK8abQyudTRQPMHNnHkClEYIe0L/JyJio3Kee3HrRCaBtrK4rj4oFiQcvj
         WSatiRjJI00r8x7rKBzDrx8XlmX3IEdD/TiptwsFVhgvBzpbrF4t4I7t9P9Hlktbpf9l
         jGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734535400; x=1735140200;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYii1hkovVDc9XLVTnAa+oUjxMRhoLMeaSix+3zI4xU=;
        b=pB4c9GrNmJml5UhS6h9B0b5gStHMuubRxzePrn+23BSV44VR0T8W7Y7gHx5cazrE+b
         OohwXH6qtFLu4v/sRZD4lx8sqnHHh85TSFh8NJUlYz/dcPxbQVzcm3wMt8jdO5zix2/l
         /KIjEn7rptdGQzlVk+kVjmN3JBMSYSmrjUzLmZDlYWlAkfxr6MA1B4R5yDXOEhL1wKmq
         csW5bfYHNnv28PEBQAgPZLN8gW7SfUqY7Xf3EIcg3CCLDzV04qbHJ79cDtA5DY21LYzi
         uLuZks/JxhrIOiYhZyRpKgj/PO4iYI4KR/QeEsOGEAX/nypA+4DETPs0CezFRR6F0WH5
         VYCw==
X-Forwarded-Encrypted: i=1; AJvYcCVki5I7zpw5bcriAFS3C1Xo4Xw5ZNEF4lkCQXuAdjs422Sy8OqCzAINM9OaK/Pcf356L6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0D0qPeNnpc6PNAOiUPZ8Uz8Z7P06iZ+TY75v2uZHKlX0fLqqb
	4WyqHwNQR1UaPzvKvVEtgNcvQVj1ttGUBFB0nWMC95j8Y6vNoGYe85O0A3uyKYWY5sr+X8MASns
	HNRocfTrcq/vf2R24obH1eqiGpLU=
X-Gm-Gg: ASbGnctJTS3Vs0yWkR6sBRwTlsFLlbagI4XmAZ2HSCtb8/7VQnFRiO4dJpuF+7J1UU3
	QMoQONU2g3M6KvK0cy24IC1NWNC2Lsj4ah5/Z
X-Google-Smtp-Source: AGHT+IE2+MaFv525H4SSX8KaLhAlxvDnJnKqciq4rKZwzeb+HgZ9WxvNwtmL3SXTLqYLzmgIVolHXRZMzjGdEQ88qjE=
X-Received: by 2002:a17:90b:5250:b0:2ee:863e:9fe8 with SMTP id
 98e67ed59e1d1-2f2e9302ea1mr4479905a91.18.1734535398435; Wed, 18 Dec 2024
 07:23:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Dec 2024 07:23:16 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241218111715.1030357-1-meetsoni3017@gmail.com>
References: <20241218111715.1030357-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Dec 2024 07:23:16 -0800
Message-ID: <CAOLa=ZQbB=mSyHJpd+yVHKAW_jAvL3jt_Z=z-yQuKHJ=ie2gHg@mail.gmail.com>
Subject: Re: [GSoC] [PATCH] t7611: replace test -f with test_path_is* helpers
To: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, kaartic.sivaraam@gmail.com, ps@pks.im, 
	shyamthakkar001@gmail.com, shejialuo@gmail.com, chandrapratap3519@gmail.com
Content-Type: multipart/mixed; boundary="00000000000046559f06298cfe22"

--00000000000046559f06298cfe22
Content-Type: text/plain; charset="UTF-8"

Meet Soni <meetsoni3017@gmail.com> writes:

> test -f does not provide verbose error message on test failures, so use
> test_path_is_file, test_path_is_missing instead.

While `test -f` checks to ensure that the file exists and is a regular
file, I also notice that the patch contains changing `test ! -f`. This
is a bit more tricky, since:
1. It can be used to check if a regular file doesn't exist
2. It can be used to check if a directory exists instead of a file

The commit message only talks about the former.

The patch itself look great, but I just noticed that the subject
mentions 'GSoC'. As Patrick has already mentioned in your previous email
to the list [1], we still don't have any plans with regards to GSoC 25.
So marking a patch in that context, doesn't make much sense (yet).

[1]: https://lore.kernel.org/git/Z2AwhvaE4DLAxzDy@pks.im/

[snip]

--00000000000046559f06298cfe22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 26c3ba681ee01b81_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kaTZPSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN1BBQy85NzJRN0ZZUlFLa3ozOUNxK1pCQXFGRVlIdApCdVFPSUNLcWo0
RWlvQm9SNmhpYm9QNTcyUkdkNy9oYUxUbkdNNGcrRkl6UFAwM2tOa0lWZU1JdmNGMllKS2drCjZH
ODJhWlI5SU9wVWxhU09rZi83WjA2SVl2S2lwdmtMM2ZHTWNTOEhIL0RTbDhaei9BMHIyVE1RQnVU
VXRZTkMKTXdxRUl6bjN1VVdlL1U0NU1GTEFLMzM1VVArK0ZnUGR5Z3BBL05JNEQ3NXRQUjJqSTJU
eXBaT1UzTDlYWDlyZgpXNlFWRkVScmVNSFcwcjNyUkIxWk8zREE1NzAzRmZwRXMvQU5Yb00xS0xo
eE9vcmcrUmlEQW9HVm11S2JXc1puCjJOdDdOWW1ZRUw2OTRWV050VElBRTg3Mkc3WTlnS0Z5YWVS
Sm5ZbkZjVS9CclVuWVE5L24xcmRjY3dTbkNnMnQKK1p0NFZPcDczNkhHWjI4VjMzMktUamk4b21O
MWRlNmVkVDA0dW9uZ3BhQkVSUmVQOVlNdzBEcnhwRDFVZEVlNwpIVktNZWRDOG54TzljQzlVMUVj
QTBJYS82MXRSWWFVeXJvcExGbTNKQVdjUzRaTDhzaGNLT1ZDMEIxbHFhUy9mCnlPUlk5ZlV5Rkp1
TUxiUXZWd0hDcUladzM5TEhnNHBIVC80dDJLRT0KPTFsTDcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000046559f06298cfe22--
