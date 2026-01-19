Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE73350A19
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812794; cv=none; b=Vx1rsxjVL6ohtpipC9l0ArygcmcImCbiPd6CNk852yv7zGZFkkSo3QXMfygzuagRozO/hgq+ebAPf25ZABVoxf+fmax0T9GHPwhVMohMjzqUyOg3+PzH4zSv4W9YRZebTMTSvWfS7HfsT6UYEXU5cRl+f2hJqUp2OTvsUZUAsec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812794; c=relaxed/simple;
	bh=moISCIBvx5IlukspghYFjbt1VQysPnunNgAoB94zVoM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L28Bo4YyDhAiCMi9A4kwHhYGu8WvAtnosbjbx/ceRnZ1Ip/Z/jqgE+z31XVrEd4cNWXpUNs4fCmSAkSW8NqqS6YQmsBdwpAYYI77vPjphGHgI4giKgqoBdxB0OyZGfk904i7e+23mON6pN3tJh8dYuazUUbOgozPvs9h3Uuv7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4kXDgWe; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4kXDgWe"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5ec8781f5c9so1847707137.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 00:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768812789; x=1769417589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IF7OcLYh09w0gbQkLyS1FAaVX1a7wbjeHGI5mV+Oib8=;
        b=f4kXDgWe+7mPaw/LfrHNf5+NTRsZJcCLfRMkErNnH+c24q9jQ7IrGuKN86GQTlZ+t3
         bXwF81dZB2xJ937pTzpz04UtJW2Jq8SIi8dNg4k7qeG2Es8xNzsg6fxg3PEmZcVSsrjg
         ast+YtEkSYg3K7wEI7cVDLrwK5YTXRsEtXiPnxga06ri+B3h/v6jdMX6iWNZpROjZlXi
         q/cO9FP2RycmG6if2difeyyW4NXj/aSo6nME30iujXJYwfEiXxUHcwoFobUb5h2STjPw
         lx+ugUa7cqVO+l7EV2ptAvcY7Vr4YreOwugk24NbBJjr3/ulzF9r66Zi4dot6jC9M3Ct
         Z6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768812789; x=1769417589;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IF7OcLYh09w0gbQkLyS1FAaVX1a7wbjeHGI5mV+Oib8=;
        b=aINJkfuFrAOmwXVp7VeFDeRGN2Pzd5z6Zf/uqUo4BAtHtTHjk6tUmL3rjFxznqep09
         mIT4K1ZgOEryz1O2LSzew2/GKomaY2XoxJROfLFA+lI8/0B1RWO0AlXvVFErm8+/njIY
         gLa36YgFlxV36TimxdmlGctRdpk8xSjzy8gk1vGag2GxcGsTTaPMhRpyY9TBf7QVXj/N
         jOeo8j1S4EVIoqOWvhx3D22J2CcCKCWBut+mhkRzs5wCKJoKq1Ng+qIuq5YdKxbvK8NQ
         /KRQNhBxbRxew6chiJsiWL+ML18jhdopCtl4SVTfjRiIteiBU5Cp7pMpeCHiiR7boWfN
         Gx3g==
X-Gm-Message-State: AOJu0YzSFqpX14FMn+SG8aDe3ARmM1MDZpevBqXWM3tI6CFRTpWxswvQ
	VFbgS6p+FSDDXVMcXFvCQov6bCAOu6KbIyojGycw9UOKfxWOgHmplSlDu6Uq+b6/iqOSORXN8Jk
	p1EfQiwkdDDyb8dWRMf2SxE0cS/7JmVY=
X-Gm-Gg: AY/fxX4rJ0QysPVLKBS+5hKya5LuWZR6xrIIpufOPAm7p1+5ui/2ikG5Sw+g5m53ZjC
	m98AKATu3SZt/xi0+uFozxD5Ce81g+1B/kbMdiL050Pqd7bhsQ5em8n12Esh/hfgusdB6YwpDtx
	yniK6PKsYCZIcChzJLYWwI8LAvialPuq0l0H1ixuSsohe3fcxGsTflit+c/gpIqIseIVAqY/tMl
	nHdx/TXaMSZW89abxQECZl2ppAyMoJV0q0dT84FTDuX8GkkKxWKQ9b26h+z2qYhuEYuIB5LeRdH
	Ez85+E05eGBwBSXXuR3bwzYey4WIIA==
X-Received: by 2002:a05:6102:1611:b0:5e5:7055:66f5 with SMTP id
 ada2fe7eead31-5f1a5512e54mr3897659137.27.1768812789274; Mon, 19 Jan 2026
 00:53:09 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Jan 2026 03:53:07 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Jan 2026 03:53:07 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aWzM+qePiaRWz5/f@szeder.dev>
References: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
 <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-1-925a0e9c7f32@gmail.com>
 <aWzM+qePiaRWz5/f@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Jan 2026 03:53:07 -0500
X-Gm-Features: AZwV_Qilh4IyXbeBxBRSCOY6AD1bEqCZo7M4gdwUtey9xc5xuB9bNzrLAMHvYaM
Message-ID: <CAOLa=ZTuD=bcO2pin6CWYFrc9Lwnq5JWy99cUGt8bOYkGh8vHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] refs: drop unnecessary header includes
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000fab3980648b9d111"

--000000000000fab3980648b9d111
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Fri, Jan 16, 2026 at 10:27:06PM +0100, Karthik Nayak wrote:
>> The 'sigchain.h' header isn't being used and can be removed.
>>
>> Similarly, 'run-command.h' serves no direct purpose here. While it gets =
pulled in transitively through 'hook.h', we can still drop the explicit inc=
lude for clarity.
>
> The need for these #includes went away fairly recently, I think in
> 26238496a7 (hook: provide stdin via callback, 2025-12-26) and
> 7a7717427e (reference-transaction: use hook API instead of
> run-command, 2025-12-26), which were merged in f406b89552 (Merge
> branch 'ar/run-command-hook', 2026-01-06).  Unfortunately, that topic
> had some regressions and therefore was reverted in a3d1f391d3 (Revert
> "Merge branch 'ar/run-command-hook'", 2026-01-15), and as a result
> merging this topic into seen resulted in a merge commit 180b93f7ba
> (Merge branch 'kn/ref-batch-output-error-reporting-fix' into jch,
> 2026-01-16) that can't be built.
>
> I think this patch should be dropped from this series, and these
> #includes should be removed in that other topic.
>
> https://public-inbox.org/git/20251226122334.16687-1-adrian.ratiu@collabor=
a.com/T/#u
>

Sounds good, thanks for letting me know. I'll drop it from the next
version!

--000000000000fab3980648b9d111
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 127f902148e9df8f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sdDhPMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meVpFQy80N2ptZWlvMjRlNmQxdkNkNWs2OGdYRVhpWAo2elhUOXBpeTAz
YWNYTFdGdTdxSEdIb2Z2TEtocTJUbCtWM0E4QWFiK0w3bzBKZG9aVVp6c0h1Ymwvc0E4VVhkCm51
c3pPY05TbDlOaktmbGhCOTc0RVJvVXpnWDY2emJsejVIUFppeEdYK3FCL3VReTNLRFVIQXAwVVlv
L3dsSFkKVVQvMUNhL3UyQk45bXN3NDByTXprbk9XWXU1UXg5QlQzZTRzSnI1U09JdnJLQ0hiL3dT
UlFkejBuQUJaRGhycAp3a1owZjFodFgvYlMyanFWc2dBU3IydERWTFlNN0tjaTBMeS9yN1MzaUZT
Uk9iSllSOUhDRGFUdldFZ1c5ZGQyCjhUeWRNQ09HT1B3UjBQaHFsQ1pPRWxHaGlDZkJkMGlJam1L
cVZjbnoxUFY2Uyt3OTdSTEk2b1hWOE1oUVExVGgKSzV2d29pa2ZjMDFiWEw2cjA0T2pVTDB4NHlI
OTBrdERJS1NMaTFWc3RsNzMwdkw1enJ5YUN1NHB2S0N3VmVsQQo2NUpnYjN3NURVMWNKOEVqK21W
YVAzeGEwZXFQZFpub1pPdFBNZXJ1M3c2WWdhTDhhNlVQcFJob2M4SDJVOHhVClQ1Qm8yOTJSVWJH
YXVQZGhhZGUxYzY0cnBTSy83K1BRSklRZThZdz0KPWtmN3QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fab3980648b9d111--
