Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1686256C8D
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974780; cv=none; b=Jn6mUj0nZYxMfo0VBHi1SnvMcfgww+Iua+rpFyavSf70PZBoSgfBH4QnwYwOJkfNvFrv19MKStIKpc3iTHS0tY5AJhT1iE6muVVMWDNRhbYzCdrx5IH6WwoDy+SUdxsihgjLl37srLCN/arBohNwpAGOoGvEumny//XatfGV6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974780; c=relaxed/simple;
	bh=x0r1UZfbdGjntmjLoH+jr0RgdTrtlsyqEI0aRQFbn0Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJDp8SlKrSwoAc7cz7UnIawZfvyrgQ499sQW1xBcNLb8DErGJVkuTNpNEMaXRTeGtwoTXnYQap+JTGV4hC15IURpLO3feQahjMSQBXvVKNgUckll1rV4e4qwU9NPxm8CS4aYGRiFlbNEN1wQ2ikfRgcyPi/Dnao5oHz43SjbZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjrI86km; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjrI86km"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86fea8329cdso2370605241.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 04:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751974777; x=1752579577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x0r1UZfbdGjntmjLoH+jr0RgdTrtlsyqEI0aRQFbn0Y=;
        b=CjrI86kmUxO7Ydfc5TbSBMhuHX3OaFXnbNnQKhpWsUHpdJyUoFObINBAtVkID2eALv
         f/uNg8E8W97e5BhjtRFYqj+MYcf4aDslLXYouilNYWL7PasFJH1tEdCwM+j6zQ0wuF3m
         2dYEMdlIfU2lBA53VpdYBqmiM7cJkDSaIWn79EC2/WfmzYXq79IpKoWHlsStTvyroTrW
         hB2fxT8JmvVeBe+OUm2T4uEbGH0HYDnri61ApDQwUuUpJ2Kxi4n5EHbA+sYoZWE5Qt5g
         cjHUeM4aIuxPqhLj4vK4ZkSeo4GVuJY6Vuk9K34IFhelAjRrjL0Iln+8+AE3aOrjB2Sm
         EohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751974777; x=1752579577;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0r1UZfbdGjntmjLoH+jr0RgdTrtlsyqEI0aRQFbn0Y=;
        b=Kiu/SruiU7ywfuBZ7zAfdtKn1S0liXJmEmoeUwVTY2+MQOpGYj0CTg7zb9urWTI/Ou
         BXhdAfm7eLdD0YcqPkWS1G3ZyQMtO8JuiEBYumyJf/YgsY7AmempLSLrG/2A8HvJ5Jxf
         apkEvRxxuzFTJK++uImghy2Q+dXwCXYtB9DLpn1i1wyIMyIlNPrD7JCG9B8k8rFmiuTZ
         KGrQUp6yQrcFCgIIqZsmS6VEaN9OxAs/d2kwVbh1QSljKAF/C1L8YI2lzdMKBgzk354H
         x9CaZzaIiRJXSBtQOJ4KIuwiX098kJ1PgLWcZ+LX1xXHIwVglgHLTcFOGJYsPZi8JK7d
         zDEg==
X-Forwarded-Encrypted: i=1; AJvYcCXV9Xy6iYC0wkHbOMPL8dvCUA+gTu+G/CVC99MhXl1WIllJMHhwY+rEtnZGZqG1o4qsPVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIlW5d0LAs5v59XzsdULrQY45PXe8+fvz9wiB8NsnwE3ji4bF
	Kpwyyoy4f4WAsuIKr6idzu/PAL4xCGSdQnS0CJR2BI6iLUhj/z3D3jELCPRhw5RgbdGAsHr6ZqH
	+ERO4YLRCAGw46IlY1SoYjSKVCo2ImAQ=
X-Gm-Gg: ASbGncsIhKM2Zr+iEESPjVJnfgXMOtP441e3aMnMCjm2OjZmvRfTO90sN7DHYvm4g7f
	bp/sgHKA+g1gsLV49JAjvEtpgUTHrkRMZjW/ImxFqurxy/GGojLW5W7FHds+HQHwijaOd6f2Eaw
	2CUgW4zpCBJldR0Bsgk9Ebw4KXvvZkIOChP5gqGpCSU3utpIG9/9UxXc0LjNU6GsfJ9IXTGlEJs
	r6Y8w==
X-Google-Smtp-Source: AGHT+IEJ8WZg4piLgdYl5HR7x7+TlNI0LRLRqoZt1fQiHlButDdcy4tGJituqTdOGhM223zpi1ZfG9CcSrDA4MTQ4tw=
X-Received: by 2002:a05:6102:c04:b0:4e9:8f71:bd4f with SMTP id
 ada2fe7eead31-4f34047d2cfmr1760781137.3.1751974777580; Tue, 08 Jul 2025
 04:39:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 07:39:36 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <3d95d37c-7352-4e57-8d50-6fd4fcb77095@gmail.com>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
 <87ms9kcbtq.fsf@igel.home> <CAOLa=ZS0uP+5xso_SEG2GJZHeac-0F2_wMJKtvbFj_wROKbBkw@mail.gmail.com>
 <xmqqa55jc3md.fsf@gitster.g> <CAOLa=ZTDcssjQcNcvDOA4-r-j2asp-XHCy2D_qoHEidz+KsKCQ@mail.gmail.com>
 <3d95d37c-7352-4e57-8d50-6fd4fcb77095@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Jul 2025 07:39:36 -0400
X-Gm-Features: Ac12FXzIHp1l1MQg4Yv3MKi2tUYoUtu9o2wFvlZM5Ax5vSO2LIkn7xeGwww1vTI
Message-ID: <CAOLa=ZRodyDB5_ZESeDe43Et29dXWNV2+RcNJ14D8BAp7WtJ_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] for-each-ref: introduce seeking functionality via '--skip-until'
To: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000004611fd0639696af8"

--0000000000004611fd0639696af8
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 07/07/2025 09:59, Karthik Nayak wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>> I do agree, I was modelling this after what would be the best approach
>> within the Git codebase.
>
> That was my fear when I asked about using a numeric offset. Patrick has
> made a principled argument for using a ref name rather than a numeric
> ofsset - I think you should build the motivation for this series around
> that and the documentation should explain the implications of references
> being added and deleted while paging them.
>

Yeah, I'll add something on those lines in the next version. I do
appreciate these checks/questions.

>> With that I think '--start-after' sounds like the best option. I'll
>> modify for the next version accordingly.
> That sounds like a good name
>

Thanks!

> Thanks
>
> Phillip

--0000000000004611fd0639696af8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2ec297a22f2bfc89_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1odEEzWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMzY4Qy85V2dkc3loYWxwQnZKWk9VTDVzWGI0MmFaNApmb2FjVzFuVFU1
MEJFdFl4d3NHTTlqYVZuMkRSNVQrWkhJY1VjdzZpaDhxY1VPcjRzOTJFSWNJM2FCWDB3eE1XClZK
azRBaExNdUozOGxpSnRnQzdKRW9teHhra1BGTCtkRjRlcFBoZlBPS1RLV1UwcFJsZzl2ZEtjUGxD
ZWhaK0oKaC92V1B1Snh0K1IzYVZ1d2lHeE1ySTVZbWJ5Q0c4L2lVUzc4Um1HdllCRWVxUTIySlV5
SkZDZ1BrYVVkcjNXNgpJMFlmSUVLV3JSYkNNZGF2QkYrd0pzWU1FUHQ0NUZnd242SjFIakpZRGNH
bkFocWhNdE12bzZUazk2QmNRY0NLCk5aMlVDdHRzMDd5cUtvUndpcWxHUk1BNXFvbml3WUl6SUdt
dk1kc0FjRVBsWG44WEhPWVN5d0Y2N1QrY1Q1TjEKZ1JVTGRLZ1ZOTUZDdWJIQVVMdjVOUCs0SWxV
Q04wQ0NxaHEwUmlEY3REb0JBZlJ4VCtxd1pnUWpBYlM1eTdBagp6M3RUQm81ME1PT2JBbkErOFZV
N2N6djdEUzZwbkh1S0U4cjFLMExDMlZDckpXcy9NL3RqQ2p2U3JWSXNjbUtYCmlrTncyT091emR1
dzREekJOM0daOTE0UnRuT1gvdEx5ZmNsWW1qST0KPWJXaUQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004611fd0639696af8--
