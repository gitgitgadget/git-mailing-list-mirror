Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB515B554
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322667; cv=none; b=a+6oBrCp6o3Xh0ost15LhW+nVx62kRVJS2k1G6ByZ3CDwXRO/ZcFWoZvlsTRXr/GdzjQxKVrAwSYB1SlQP1VYyQlZLTZuUxgtxIn6Z2f+rAp9UyveAkYgkAj/NFSzCaE9xB7tC5MHeHYgW1CjB5tJfI9an0wXaKeEqLPw8H/WSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322667; c=relaxed/simple;
	bh=y4EnjxMU6ZcGPUweO500WNSEKEfVRfz8qUIR6tWutDo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=DjxmwQVBVN5MRsBYhMnEGESJTKY2k5frsSHNABvuMNxPDpRPjcdzeCdWMmRBsO8Kkvtar0cHVQbLDW5m9FIu3MvNxDFjOWmKlp0IW2RAXbw9UuLn0x/97B/unoKfTvqi+3q3YvKnd5qA5Li6ZhL7mLCEZqJd5mkdqXvkLfKEV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdUqfJA4; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdUqfJA4"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fccf51df1so1692945241.2
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 02:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731322664; x=1731927464; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/Yp8cNgNLVq5Al7W++8giaAOs98UduSg1kmj0xDUo0=;
        b=YdUqfJA4pW44DLruBVXskaRiuoMqGTZDXn+x+V8OJR0+tPk5ji6rT8Byc7x2Mnmmkx
         YvGxsb16aFjtymqEJFpRkzdJ2UGHRIcIM891V6W3j9CSe5cs52BkMO7e4TweIFq7+Uvg
         BkUT6tQa2zntWvtC9msQJRAsTK1aMho+m/tMOMtzm2+Y6PrjSOoIpLFUo7HdRQCb4LfL
         wRseXR510aWfVEajBvyGYdvebS/5LTm2D9SG3YYTLVyocJiKBXecafiXFPg4OuzvLrdb
         BBbGBSsPtN1kzj0edf/7ur0ql4hhgz/wurjOriGU4Z8Py7wtPWWoyYwlpHSC+In023IQ
         BBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322664; x=1731927464;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/Yp8cNgNLVq5Al7W++8giaAOs98UduSg1kmj0xDUo0=;
        b=EBOxSGbz/uJnR5KtjzNazVXARLXJM6kxA2DvS/Lw0ivrYxPhSM7+wCMXGazaPQxr8C
         m6iY3QXXTMTPq7U7mgrmm0bXK/m6+PQwYMjQlV6WewNEy+8SmhIOCWtEnrtZRI+d+gue
         S+nKWyDRa0QUHWg2WDBStdjww7dGObJ5yxoo7e2JB6pdUk+lp2TnpPY4vQcsbgthFy20
         faJ7kga8AYgL5MWK5Co3ROPlXXSKPMYbpbeX0mdP9aFRQKU0vN90u+fRZ/HCIXCsy2tn
         xrAbEax0f4/Ch/pbItxpgMZk4ZXA9fk/oytK8fNn3O9AN5moutE/19+soIYXUgMfpDlL
         DcpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmGEDyZR10N5cWAwF8gojU0mFcCADi0ovk6EG6sL22gWEhrKrv3A88Lnud+GIwFHmh1jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQ3abWla8j3Xwx+F8lZJDH6yat6qwW67h9QWSQ2EQX3gz9fp3
	QyOGFS8z1DiLmSGqtwyQU0Q+oc4tnhu4e4NQ6GSw3ftk9fv6+34X6OwpIbW9jADCxzlNnVDWQUv
	5Z4iNFLu2aSm3ussxNU2CkVRKHuPFwi3f
X-Google-Smtp-Source: AGHT+IEvRfN/WcdD3ZBvWBOTwzX4AHbAXnmS6NZ1ChPm1KN8GhLM+6cQwoJd2LMyggJXF+JFXTYME4uaFexoJSy7YH0=
X-Received: by 2002:a05:6102:2ad5:b0:4a4:841f:bb95 with SMTP id
 ada2fe7eead31-4aae166523fmr9629374137.26.1731322664527; Mon, 11 Nov 2024
 02:57:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Nov 2024 05:57:43 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Nov 2024 05:57:43 -0500
Message-ID: <CAOLa=ZTGtGJDnMmuv++FS9Rv4KiRQewOepo_qOY=6h1xtNmNZA@mail.gmail.com>
Subject: Re: [PATCH 00/10] refs: optimize ref format migrations
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006948a40626a0f86f"

--0000000000006948a40626a0f86f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> I have recently learned that ref format migrations can take a
> significant amount of time in the order of minutes when migrating
> millions of refs. This is probably not entirely surprising: the initial
> focus for the logic to migrate ref backends was mostly focussed on
> getting the basic feature working, and I didn't yet invest any time into
> optimizing the code path at all. But I was still mildly surprised that
> the migration of a couple million refs was taking minutes to finish.
>
> This patch series thus optimizes how we migrate ref formats. This is
> mostly done by expanding upon the "initial transaction" semantics that
> we already use for git-clone(1). These semantics allow us to assume that
> the ref backend is completely empty and that there are no concurrent
> writers, and thus we are free to perform certain optimizations that
> wouldn't have otherwise been possible. On the one hand this allows us to
> drop needless collision checks. On the other hand, it also allows us to
> write regular refs directly into the "packed-refs" file when migrating
> from the "reftable" backend to the "files" backend.
>
> This leads to some significant speedups. Migrating 1 million refs from
> "files" to "reftable":
>
>     Benchmark 1: migrate files:reftable (refcount =3D 1000000, revision =
=3D origin/master)
>       Time (mean =C2=B1 =CF=83):      4.580 s =C2=B1  0.062 s    [User: 1=
.818 s, System: 2.746 s]
>       Range (min =E2=80=A6 max):    4.534 s =E2=80=A6  4.743 s    10 runs
>
>     Benchmark 2: migrate files:reftable (refcount =3D 1000000, revision =
=3D pks-refs-optimize-migrations)
>       Time (mean =C2=B1 =CF=83):     767.7 ms =C2=B1   9.5 ms    [User: 6=
29.2 ms, System: 126.1 ms]
>       Range (min =E2=80=A6 max):   755.8 ms =E2=80=A6 786.9 ms    10 runs
>
>     Summary
>       migrate files:reftable (refcount =3D 1000000, revision =3D pks-refs=
-optimize-migrations) ran
>         5.97 =C2=B1 0.11 times faster than migrate files:reftable (refcou=
nt =3D 1000000, revision =3D origin/master)
>
> And migrating from "reftable" to "files:
>
>     Benchmark 1: migrate reftable:files (refcount =3D 1000000, revision =
=3D origin/master)
>       Time (mean =C2=B1 =CF=83):     35.409 s =C2=B1  0.302 s    [User: 5=
.061 s, System: 29.244 s]
>       Range (min =E2=80=A6 max):   35.055 s =E2=80=A6 35.898 s    10 runs
>
>     Benchmark 2: migrate reftable:files (refcount =3D 1000000, revision =
=3D pks-refs-optimize-migrations)
>       Time (mean =C2=B1 =CF=83):     855.9 ms =C2=B1  61.5 ms    [User: 6=
46.7 ms, System: 187.1 ms]
>       Range (min =E2=80=A6 max):   830.0 ms =E2=80=A6 1030.3 ms    10 run=
s
>
>     Summary
>       migrate reftable:files (refcount =3D 1000000, revision =3D pks-refs=
-optimize-migrations) ran
>        41.37 =C2=B1 2.99 times faster than migrate reftable:files (refcou=
nt =3D 1000000, revision =3D origin/master)
>
> Thanks!
>
> Patrick
>

I read through the series, apart from a few small nits, the patches
look good and straightforward.

Thanks

--0000000000006948a40626a0f86f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fa6f4199e08f5180_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jeDR5WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2dOQy9rQkRiOWRkQm9YbXhLZktCOWVvWSs2SUhkcgpQWm1vTU5TWGJt
Y0dBeUJVbG1DZGZrUzlrY3BBSi9YZkYrU0hGSUQvb2Uyc1JrWnpFc0gvdzNlUXlwaTVuSnNQCmly
RGJlQVpiZGVYeTR5NENkMXAwbTdNOW9zNDgwZG1JTjJIQVhUWnJINk04eGxNR28vSUVORUs4bWR0
MGRxQmgKRjNrTnB4VWZqSGduMkUwem42MTFxV1R1MENFck5wdlUrVGduTXdjN2U1QWMzU0F0V3dt
K29QWjFzUnA0c29qRAp2K3R1Z014RTl0dytac1RvWG9ZU2t0TmFTaXFCYWhuNFQxdlJhc1M4TmRW
eXFHcEFXYTdmanN1RlkzT3dOanRiCnh6cnRnOERSQ01YZmV3SkdXamNEUFdreU1Vd1JpUElzdVBO
cm1UNDhSb21adkczYlZJZnhWUjVEYzB6bkJkZEcKaSt4WWVzdlZFR2plZUNoOWhxb1dpVlVUMHRB
dHJFNTV2UHgwdzRvbk15ejVCblhoYlRIMThreGNaTXNwc3l6MgpZRDVyU3QwZ080YkJjR3ZqVzlx
UWRoWmVtdTRkeklrWEQvY2FmWVBGT0U4NnluVTJ3eWtISmprYUV5MEVaR2J6CmV2SHBmVU9odnB3
V1cxRG5Oa25wbzE0bjVJbm9LNlBiZXRmaW55MD0KPVZ1TFYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006948a40626a0f86f--
