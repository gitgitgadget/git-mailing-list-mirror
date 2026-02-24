Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A93A1A33
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945528; cv=pass; b=fwtaoiS0rztHFB1uv0TCK9xjMXnY67B6agfhNvLdG/4YLgwva3JDkQZ1C+Kvbl7D9QmvkrqO9qPMk+bCcFghHk8TAGNmu8CSp70uuoV0rEUoPft8mSdJH+q55rZDxPeJqhB0xu0F5tAxXfrnJRYsc+zcvG+drdo4E9mK4PIg1Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945528; c=relaxed/simple;
	bh=lVOPKboopoKy3EvoQRHexdG+IPeai/A9HDm8hpe/bsk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVpvgDK2ZST15sJX259D8R+Qt3BJCHzVR3Mmo1h4zX5bLnWeHY96ztxlHcoj87adQyPXNhsemv6da/bQvyWl68Bx52MyrdufNwKEoAMeSxuWSP6IfWZK+wsoMTVxG+iCQOpaHsx9PKZ7kVYaOvsMf4n49tye9CCdSPhJjwaMRMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMaQLSN2; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMaQLSN2"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5fa26e497abso4296210137.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 07:05:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771945526; cv=none;
        d=google.com; s=arc-20240605;
        b=Pnuqy2l34U2vDIwOymDcbhzeO+CTRabxZ0aooQCg6ID6KozsC46kU5/uFna+F7QOQL
         wfH00ayPhA30KssJEEqhL1V+/NSDOhyi7klLJyHo6WYynOq7s8Uak1zv9m82l6ob2xbA
         G7LlQ8aQHURBM+C4A5QKQs9SOvU/PyQnLzKtQvfRNIAuRhULodpRmHI/yzjYXwHioUeW
         aNhFeU3jtlgrOEwBFB7d423tVTlnl/Zf9I5G9+/yvrxBwXwiQZEnBh9SP6INzcosSjTR
         xwaKdkoHAkpE42y17wGaCKk7hBhnA9zYO7d7LjsMO+tBJ8R0cjjJAhtDUqyucqJd8smT
         ZH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8lj+PyjdwLqiv2dcyPp/tEKE5FP3LPBOKicDhDO4Fzg=;
        fh=hImDYwWi9knb8tJt2pN3jEjFrKjowbhmf2aPrWQu36Q=;
        b=WJWeuaDuSu/HHVRQNJ0azWKgkE4K2faZrA7X33GslkC5NF9bfJps7x5PyfZranJklv
         e1TKGWoD6pAwYZeDJGmzLYP2XyOog2Fz0/eIvBgQxvRY0YR2wXyNapKyIVFOrcd7lomr
         MuHD8hWqG3xFQHl3ls4PDk1n+iF6SOIAnZGbu/FxEK+ksbM0lgLOAIhMioQO/qKoAIly
         ByboWEripjGjL0emMV5UsggSetn07G0sAcFgr0i9P9Xmq9AfFIpSTvEFHB066ec25931
         SOZfBZu0Xu8L4M+Nn4QQNGVHNHdLAXL6j81lhO1xKVs8KlNHYU/3FVzJ3Vo7sHygpYys
         fGmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771945526; x=1772550326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lj+PyjdwLqiv2dcyPp/tEKE5FP3LPBOKicDhDO4Fzg=;
        b=NMaQLSN2Ne4U7NaC/7EZsNBPb51jJe7ZA9F4QMv4M9j9QRqV39k+XlH8RhQlNO/AAh
         xcqqhxb+GLAD0SelZyC0+h5M6+NwoUgLWt+tK9yrliD9Y57OLi2bPQi3nqJ2QwFgiHmm
         W+zJBvWkKyPjijlbQA+7LOJClpgIOxjyrRgyZUcmtU7UOzLKqfweJHQ9kowQSLkYagOW
         AFs7wCTZkLQIn2Xel3LsCbdTY5PSly38KEdkOpolmPPMS9U/OkTF9m1XZUVz7e/Of8vI
         C4Bc3/d4ac8jlKRTzIdYEpmc1D8RyQaEenJULFW7pnk8GIAwxWhO6eIkV4t19/JZJLie
         VcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771945526; x=1772550326;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lj+PyjdwLqiv2dcyPp/tEKE5FP3LPBOKicDhDO4Fzg=;
        b=I34hNx43j6rMhOBSBLp4J5uEWj0J9315xam7av7oMDxvg2QsvlbudY++P5Qx4JOosC
         gFPXQA6z1jjXY9U2/ekHtt3a72tP0qqNyQZCsnMeGWZNtgBOk4NwdzBS1p/ZlMF3iOzF
         gCEQ2Xs1p7TszYML2V7I7WWxN1iXt2p74B6iMh236ivKTr5fNIC4NnkCS0NOrXvZF1Xi
         6F+IiKU/fL97touvAUGZMjfhrJZSK13SWgAqFoFZ2cx0sWe0Y5hVz4j1N0oFKM6Ei/Oo
         bVEBrb6WYCGbaVyiJNV6A5RRsfG1vuebnYOj4VMtHgJ5MiqsGFTPrsChZOJvev++HdRf
         UufQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLnfJw0smhxjym6wkywCpnECoP5vIKq7c87gHNOJt4CMa0ob7Kdlt9YLqG9CGVoM7X1iM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/TwUampcwxB6FOwdW5V/tltcbVVzgNicM0ds8fURkZ43dlIX
	98laKELgx2frRcqFVcezzlcDO9u+5yZrEwrvylTQQOtvi6rv8V+4XdOR/OCGAsKTZcHr7ruikvE
	vgB/WXl5ks3US872q/D/QOW8pHKHIc1Y=
X-Gm-Gg: ATEYQzxKZPIZHozdFauSFuMMtnVnpG8IKBG0XFt3ZiUj6KJzhphdKYoC7g3jLLT2Izo
	pOQNDlQyu7ijYcNt5M2p7Sgt0gau3C7quc0VfYLPVq17ibxcpR5Wakm0qvIiEnTWSFh3HY7P7Uq
	OGMeLygXNkp/h1Dx2RXovnYzj1gGAscEH6bUyBPJkcTdnwM0qvug3Xwu4F9edJ440eTtAHW95vo
	IkgOFAY6IsJ4aj42PybfeMxeaYntdozlcbh2JhjYgCYwSxiV+sGo9SCfgNzvG/V8P2goBPAPvHE
	ZSDx4V3fOs0BXP/7A997/N/udZ7v2bdDPR0eDDOceg==
X-Received: by 2002:a05:6102:41a8:b0:5ef:49d0:5862 with SMTP id
 ada2fe7eead31-5feb30d374fmr7386603137.34.1771945526079; Tue, 24 Feb 2026
 07:05:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 10:05:25 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 10:05:25 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <78ade921-321c-493e-ae4a-dbada55b0fff@app.fastmail.com>
References: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
 <20260223-kn-alternate-ref-dir-v8-5-0509c132a203@gmail.com>
 <3af8a2ba-dfe4-4e43-8f86-b03a0cbc3698@app.fastmail.com> <CAOLa=ZTJ3-7OSbfRYbYuTaZBsPSSXrHHJ5LkCO_HSMw=y5+Gfg@mail.gmail.com>
 <78ade921-321c-493e-ae4a-dbada55b0fff@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Feb 2026 10:05:25 -0500
X-Gm-Features: AaiRm52Mm_PB-c-rwBFa8Z5fO7wpNB_wOyiFE50H1q_E6eQGIcWUbaperJ-hRkY
Message-ID: <CAOLa=ZT6ws=CMVcrktnN2MAahosKYHHccgz-8E5+fUHbW9FNFw@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] refs: allow reference location in refstorage config
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="000000000000a4d677064b93377d"

--000000000000a4d677064b93377d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Feb 24, 2026, at 14:09, Karthik Nayak wrote:
>> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>
>>> On Mon, Feb 23, 2026, at 09:01, Karthik Nayak wrote:
>>>[snip]
>>> It looks like dropping the list continuations fixes it.
>>>
>>>     Supported format names are:
>>>
>>>     include::../ref-storage-format.adoc[]
>>>
>>>     The payload is passed directly to the reference backend. For the fi=
les and
>>>     [...]
>>>
>>> Maybe because you are inside an open block? I don=E2=80=99t know.
>>>
>>
>> I don't know either. But this seems to fix it, let me know if it does
>> for you too.
>>
>> --8<--
>>
>> diff --git a/Documentation/config/extensions.adoc
>> b/Documentation/config/extensions.adoc
>> index 3e51da36d3..329d02b3c4 100644
>> --- a/Documentation/config/extensions.adoc
>> +++ b/Documentation/config/extensions.adoc
>> @@ -67,13 +67,13 @@ refStorage:::
>>    format and payload (e.g., `reftable:///foo/bar`).
>>
>>  Supported format names are:
>> -+
>> +
>>  include::../ref-storage-format.adoc[]
>> -+
>> +
>>  The payload is passed directly to the reference backend. For the files =
and
>>  reftable backends, this must be a filesystem path where the references =
will
>>  be stored. Defaulting to the commondir when no payload is provided. Rel=
ative
>> -paths are resolved relative to the $GIT_DIR. Future backends may suppor=
t
>> +paths are resolved relative to the `$GIT_DIR`. Future backends may supp=
ort
>>  other payload schemes, e.g., postgres://127.0.0.1:5432?database=3Dmyrep=
o.
>>  --
>>  +
>>
>>
>>>>[snip]
>
> Yeah it does. Thanks!

Awesome. Thanks for noticing.

--000000000000a4d677064b93377d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 33a611a0f2aa6874_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tZHZqTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMXYxQy80di8zWHBpb1JMMTdVakJ5TU5jdWhyQmpJcAprTnpuRWFOUWU4
ejcvVzFIRG02aUxSOWZJSkFqeFpBdzdUSnpySkJzUEU4bzhhempQbVNldnpyMHAvejlTQkRBCkhB
bnJxSTl3RE0wV0pKT1BseFJwdEt6YzNOU1VZMUlvTXJ6S01DOUJGNXIwOGV0QlNaU1JnL0Zmck9J
UlNlWisKbmpzYk1pTXZHd3FLSW0rZU5CSHowSnI3SWgzVUhWYk41ODFpcVRic2NtbkJhZ3NUNlQz
cjFDb1l0eFZZWHE4ZQp4TmhIMVkwUURENkpiYVltR3UxajNiN2R3VEZQaHRxdSsvbkN5UWhNMnBJ
YjlBQ0NzRWJLK1pKT1loQnh1eCs0ClpwR3ZUTjJrcDR4ZW9HMW1BYUIrcVhKWXVFRG1nMk5RYVdr
UUl2bUR4UU9uYkljMUtzWmo1bDZCZEIzMXNsNmcKVWIxS0NHOHlkNld0NFNjZkVuakpXaDZDOEdD
c2FkNUo4MkVrdnRBRkw3ZUNZM1ZlSHFHc3lERndOeEhpd252QwpmaVNReGp1K1Y2c1psa1BMODMv
QXpIQnRxQktxdEhYN3MzMkFvYVRsZnFIL2h4WFE0SXBNUFd5REJ6OXJiZlNpCkUrdUxlVUpybDhH
aVZZVnZLUW8wNTNMbEswc0NDem03Z2dkZFZjQT0KPXNCOUcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a4d677064b93377d--
