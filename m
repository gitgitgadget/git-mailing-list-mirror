Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4D1D5CD3
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016521; cv=none; b=XV8LKwZiwnfRZoa08RyyeB2aZGe+r+9yV0hrYQm/lwgxdjDQ34EKniScy/rOwddRxXzW80uVRNB8DcfbrFDojce966TIcqVWTG7X+fYkX991TIWjJB4aN6JYHT5XdgMw4xGiiqHZNFcdK9G4fRgonzUd+FxToMytmBirQQli6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016521; c=relaxed/simple;
	bh=M+suCmnW4pJMY+v8gwxmqmfHNyBQ0QUzdSpmVn5oxJ8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAy2GX/9RRsYPJlpr7EVCRHhgEzL+wo3gzx+AETEAYrSxYmZUHZHLle/Ik4BaU+UuSTxAFdvXzAkiMsLRoQdx3cZkttbTi55SgAcg/hbpnlyU+69aoYQKJsfhhhqoKZLBNrdvE96lzH15Z6puNLbFOIjrZRYxvT92V+rL4X8BGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbR0dolE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbR0dolE"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2efb17478adso1224663a91.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 00:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737016519; x=1737621319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EI+YaZ2ETVOiKtSjHedY0cmnXj2+mvfKhF4SvLuPtC8=;
        b=EbR0dolEk/LdnxWEClWue7hM3K93peqUCCeAlUgLq6S8iH1G6Cy2Wbk9jcSHx6DodJ
         a6Vq/75ySW9HNEIvyczOjImaz+tguIAUwIaJOVsQc9SJ9fkAP4hYqYjKQxl1w4XqFPSp
         DZkrbfg4UJzVWBRiwQh3+dtKzu+Ybw4/1fKv8E/EpXWXNlhE+nXsyMPZhWH6dF5qcdUS
         py4iox/Jfh5kRiz5rzBRaejozxsVKUiyB18vm7W2Cc/YQAZkmHSlSuS4pCPhxSnnGtsf
         cmGITCTZBzDX+ycEjV39EjOIa9K+6jFteHRuUWi1VcwhK3sEzZ/Gc+oQ3v9FdujXyghF
         Us2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737016519; x=1737621319;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EI+YaZ2ETVOiKtSjHedY0cmnXj2+mvfKhF4SvLuPtC8=;
        b=AQRUKp7EYFkAU5rqUFenE7LcxvOyg4gk1M4ebFvn+iCa74aIHhTUeGBI3SmL7It9Y0
         jofuhEAer/7ZW1rQLX0/ckL88XhxTp3emMPzHZsUBX/7wtClDkswpCVehhv48WudqDh3
         MyMPoPC6Upx7CKbQ6+uworkFzw5iEvVQuX983dOu8RGcaKDS+igWlYY9XMJEJAojCIj/
         svqeXBEQMfkbxElDMOoKJ864pgt9g7XBfpAEDhrOo9wgHbWwKC8hglkhWLm/QRfQv1tO
         kNx0BUMnto9UZ9d14tspf1F1rpPTJgjnV4x3PilDpyNPUIVzFWmZGAFB47fw+PCDdGHG
         ee/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4NfdTnMrg9z9YIw6TfIbq9eFSGQme5RSAtezV99bbD2V+2wf03VmRDMWPzbgpbVxhBtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF0JCThmoICVnw+HPuvh0tMZpWqxOb7Q6Q60Q4lOUMjJ/4jHCI
	XIEm36Za6Ny6p+/ycYB2oJqggJylk350kJx4wql7WZRe8a2IJVnu9n8dH3tcsdrpBX6RNXsMJ6w
	9fHHmtPoIebVWcKcPscj9WC73UAs=
X-Gm-Gg: ASbGncuLLOKzYLYClSMqN7N18v7YOKPQ54I13nDQwaXQYSefVhEPXwzUd6mVuRaiGXB
	FfDK44zb29UF/u3nONGGBqWkx1wIcUjk5EiQBl6s=
X-Google-Smtp-Source: AGHT+IGzLdtMoy+WutX51lVCIizwooJuG6HDmNC4GtxRPbP3Ze+IVuX6huvtmlBcuvLP4TOH4Xo9Tp53fLrU1oxXrkY=
X-Received: by 2002:a17:90b:51c2:b0:2ee:e945:5355 with SMTP id
 98e67ed59e1d1-2f548f448eemr43712518a91.19.1737016519493; Thu, 16 Jan 2025
 00:35:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jan 2025 03:35:18 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im> <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Jan 2025 03:35:18 -0500
X-Gm-Features: AbW1kvZbsiUL88kxI8m-UPXU9biRRnc0eJqMIb0P9O0CpwkxEXktp4S7xhQYk08
Message-ID: <CAOLa=ZQ7bZySS2dwa_u0YEQB-qC7_VWMzqkHNbBZdUS4YNbn0A@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] compat/zlib: allow use of zlib-ng as backend
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="0000000000009d27bc062bceac7c"

--0000000000009d27bc062bceac7c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> I have recently started to play around with zlib-ng a bit, which is a
> hard fork of the zlib library. It describes itself as zlib replacement
> with optimizations for "next generation" systems. As such, it contains
> several implementations of central algorithms using for example SSE2,
> AVX2 and other vectorized CPU intrinsics that supposedly speed up in-
> and deflating data.
>
> And indeed, compiling Git against zlib-ng leads to a significant speedup
> when reading objects. The following benchmark uses git-cat-file(1) with
> `--batch --batch-all-objects` in the Git repository:
>
>     Benchmark 1: zlib
>       Time (mean =C2=B1 =CF=83):     52.085 s =C2=B1  0.141 s    [User: 5=
1.500 s, System: 0.456 s]
>       Range (min =E2=80=A6 max):   52.004 s =E2=80=A6 52.335 s    5 runs
>
>     Benchmark 2: zlib-ng
>       Time (mean =C2=B1 =CF=83):     40.324 s =C2=B1  0.134 s    [User: 3=
9.731 s, System: 0.490 s]
>       Range (min =E2=80=A6 max):   40.135 s =E2=80=A6 40.484 s    5 runs
>
>     Summary
>       zlib-ng ran
>         1.29 =C2=B1 0.01 times faster than zlib
>
> So we're looking at a ~25% speedup compared to zlib. This is of course
> an extreme example, as it makes us read through all objects in the
> repository. But regardless, it should be possible to see some sort of
> speedup in most commands that end up accessing the object database.
>
> This patch series refactors how we wire up zlib in our project by
> introducing a new "compat/zlib.h" header function. This header is then
> later extended to patch over the differences between zlib and zlib-ng,
> which is mostly just that zlib-ng has a `zng_` prefix for each of its
> symbols. Like this, we can support both libraries directly, and a new
> Meson build options allows users to pick whichever backend they like.
>
> In theory, these changes shouldn't be necessary because zlib-ng provides
> a compatibility layer that make it directly compatible with zlib. But
> most distros don't allow you to install zlib-ng with that layer is it
> would mean that zlib would need to be replaced globally. Instead, they
> typically only provide a version of zlib-ng that only has the `zng_`
> prefixed symbols.
>
> Given the observed speedup I do think that this is a worthwhile change
> so that users (or especially hosting providers) can easily switch to
> zlib-ng without impacting the rest of their system.
>
> Changes in v2:
>   - Wire up zlib-ng in our Makefile.
>   - Exercise zlib-ng via CI by adapting our "linux-musl" job to use
>     Meson and installing zlib-ng.
>   - Link to v1: https://lore.kernel.org/r/20250110-b4-pks-compat-drop-unc=
ompress2-v1-0-965d0022a74d@pks.im
>

Apart from a few typos, Patrick has already answered two of questions
and the series already looks good to me!

Thanks

[snip]

--0000000000009d27bc062bceac7c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1c7d7fbe955280a3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lSXhNTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3JrQy85d1VreUo2SzdEbkJML3ordXRsb3dqRi9xVwo4d2N5YkRTRUVY
dlV4eWdiYm5hbXM4WE8wVlNOTkhBVzE0VFBNVXBnZ0hoSFhaelV2cGRreDNkSVdhZXlzQUJ3Cjll
cTFSbEVQRWVlTlowSlNwZVNaYmZKMDZhR3lSYVY5NGZLM0NEbFR1bjVXLzR3Uk9EY1J5WjExaEdN
ZDd6clEKODM4bHErbmVuZ0oyc3Y1dnpBZTF1L0V4NnByVVYrdmozaXhocWtjemlvck4vc1E5aFZJ
UzRvVkIwOHBVQ21IZgptVkxBVE8wWDVjME5KM1hMc1Q1VnlGZlhqNWJuWlVYbmI0eE9SSlZnMmc5
Q0pMdmd5NmxXcmxKQzN2S00xS1dPCjNPZWNyazAzalptK3U4bHc1ai9KUmd6NnJRWWhhdGY4T09K
MEQ1Y3FWbHlWN0xiR25zeWdERjl5eGwwYitINTYKN1Rnam5ZMDlmVnNXMGRxL0NJWHlzeS9ybGM5
OVZrVFA5M3lUbUVzZTE2a2ZCZzFSMUQwaFlwdjBmV2RubUU1RQp3NVE2NjBNM0ozU1F1ejhvMFps
V25aOE5QRHMrUVlqZEp6Rzl0emp5VGtDU0VmNDZBZ0duZEtwMmFZQzZHak93ClUra24vL29rMElk
VTBDUEU4Zm1KY1VqeEtPb0JJZDlkVUVDMmpiMD0KPXd3LzgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009d27bc062bceac7c--
