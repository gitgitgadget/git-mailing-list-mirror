Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621332D6E49
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989535; cv=none; b=cFeSLd6IcubGSlhBa0piP2V6xHVA7uOSjb7lUivlf/XSXn8PE2tL/B5uFYlR97iTy4oxI98M7ONsnDhBW0NWXhh4o0p+ddUpJef+wUP1qqA5wg4FNyEMuLIK8j32UGimaN8IuErqS8fawmCfm1B612eddXTjz9ZJzmHHUo+jcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989535; c=relaxed/simple;
	bh=dYa7oe2DfFHnufRLmkYGj8FbrWZxFyopllVpbZAO8Ig=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9sQQ8wespz6oMVkRMuU3bh5mf8JswOrpiMzw4iqPXTtoN+E3w+T+eZdz706N+n6LzNKQtWBggWj5W4UmCm5MhuGTc4AZcDgUyi8lzX/1++hN5q2y0b2xIaXw+Eh8eShyWA0yej1K+jq75PwfcaVdFqcWvstSRnNIjtkFTLIMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHeKAHos; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHeKAHos"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5058e95a2bdso1182252137.2
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754989533; x=1755594333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ejL1D7tHfZ91QLCEKzbyK1GaWYVlgzAyoPotRd1CW7M=;
        b=CHeKAHoslTtv5AnBIy1DEnnIybKdb3KMWspNL1Tin1kCOqQMhxpTNPK3UqxENTi3ce
         JDLKF+J1ZCTSP1I93WCxq8ObEaPEq6YWB7tKbdhu0BF0VRfsNZZu8zUQO7jM35UUdGnu
         Y5EcguHEy2yLZTN3RgxsZZ5QI/4cpY2HY4+zuahrUja+meb9N5niMGBcPjPfQGOIMXhM
         Lxl6u3FPPxki3iCEEF4o2RYyLhCFqxhzS1UePaqdBVgLX6u4RyXSz3Z0Qo3TaVFzwqot
         Vb/8UowtciPT+Reg9rxwJXzcsCIGJ46BZz6Ko4kDOkZwr5QF0UvzOkWNXoP0cQK5tlLO
         MCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989533; x=1755594333;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejL1D7tHfZ91QLCEKzbyK1GaWYVlgzAyoPotRd1CW7M=;
        b=XHuHL5t0Nek5xM+XsrPn2RGUPMxPU+FivfOAdSCndxLBGTluDE8/Cvc1S82ffOXhtc
         KZScbJRmVR4fA206xPkAl/++dPlZ3IG0XzMqwXKRlS3w98Ybouuk9nxG7vpYbyyqBdgD
         DhvgsKSrydCd12hxgCaiTOivyz3aGf4foLMLRSGOk1lZWQzF9fC3z2c7Kpfl4r9nMmG7
         59d1zX2j/UEdrOv3dtn9UZLFg57hlbtHneZIDF2pourQXln8OUhiI9TJuzlgnFBT+1kK
         7Eq3aW2e4NfC6F97r8jmpydeDclMH+mA/MKgooK2hJA7Wa8J0nk2Ovt+0E5y+le5Ps5w
         AU/A==
X-Forwarded-Encrypted: i=1; AJvYcCU0Dmnb62YkminVXujirLXfHHLNVv3RGhaXScWQVUTxVFrOe9yFGUC5UzEGK2/okJn36G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNH8Xo2DqmMaL1CmXuNH6MgsB964xNf7/nLxbk5yNypPUGe3p
	oIRx6mq3PGibFZgdULDn7ZQ4qnFKhNemgXLJ7kdypCCA20tOeQfmoaRaBvw+P/EfXjmYFYofimF
	ULI90WmSTewUiQmmxtkvZA2+wR/zqLjo=
X-Gm-Gg: ASbGncsBR0lVHp11o7QhYzrEvNV/FKJIAjoPbilKl1Kz8YtQGEd1SccQf9OZPDMCCPc
	s8L3CganbEvbazb9zqB4phoLrWFRte0w75166mWSUKFMUgGK+TtKeAioueKg4yKcu/vr1zFTeNC
	jAKZZAEr0cthlBt9nEMoKoH8ATFQ2QRS9cDlFT19QsY6/26bpZS2mqaiPUgOFRkE9m+cM1CsiY5
	/gJCsLJ6CRyAcW85g==
X-Google-Smtp-Source: AGHT+IGaGAgaep9hjr7jNawppxUzjK96JAPayvSPwmY5h6qzGH3m2TT8p1PIhr888tT0R45lUP6H6+IJS9BSKsgcuTQ=
X-Received: by 2002:a05:6102:1489:b0:4fc:670:fbf with SMTP id
 ada2fe7eead31-50cbee6a5bdmr1119798137.18.1754989533110; Tue, 12 Aug 2025
 02:05:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Aug 2025 02:05:30 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Aug 2025 02:05:30 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <46477AC9-8363-453D-8A57-F599A451D36D@gmail.com>
References: <CAOLa=ZSTaAaWJWeXBkoxPx46g_Equo-sHWgCESE9G6vk3HZeqA@mail.gmail.com>
 <46477AC9-8363-453D-8A57-F599A451D36D@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Aug 2025 02:05:30 -0700
X-Gm-Features: Ac12FXxpCokqmSnNjvV8IPpHMYh_laRRyjjCpoM8npsTrAN8bHLVl9L4SFCVOzM
Message-ID: <CAOLa=ZSCJ6NuNPeF7yN63rjgfKojsenGxyO5yfrKkX8TKTdi8Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] doc: git-rebase: start with an example
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Julia Evans <julia@jvns.ca>
Content-Type: multipart/mixed; boundary="000000000000b4c953063c275762"

--000000000000b4c953063c275762
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 11 ao=C3=BBt 2025 =C3=A0 05:29, Karthik Nayak <karthik.188@gmail.com>=
 a =C3=A9crit :
>>
>> =EF=BB=BF"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>> Signed-off-by: Julia Evans <julia@jvns.ca>
>>> ---
>>> Documentation/git-rebase.adoc | 49 ++++++++++++++++-------------------
>>> 1 file changed, 23 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.a=
doc
>>> index 956d3048f5a6..449f01fba560 100644
>>> --- a/Documentation/git-rebase.adoc
>>> +++ b/Documentation/git-rebase.adoc
>>> @@ -16,6 +16,29 @@ SYNOPSIS
>>>
>>> DESCRIPTION
>>> -----------
>>> +Transplant a series of commits onto a different starting point.
>>> +
>>> +For example, imagine that you have been working on the `topic` branch =
in this
>>> +history, and you want to "catch up" to the work done on the `master` b=
ranch.
>>> +
>>> +------------
>>> +          A---B---C topic
>>> +         /
>>> +    D---E---F---G master
>>> +------------
>>> +
>>> +You want to transplant the commits you made on `topic` since it diverg=
ed from
>>> +`master` (i.e. A, B, and C), on top of the current `master`.  You can =
do this
>>> +by running `git rebase master` while the `topic` branch is checked out=
.  If you
>>> +want to rebase `topic` while on another branch, `git rebase master top=
ic` is a
>>> +shortcut for `git checkout topic && git rebase master`.
>>> +
>>
>> Nit: now that `git-switch(1)` is no longer experimental, we should start
>> recommending it over `git-checkout(1)` as necessary. So perhaps, we
>> could s/checkout/switch here?
>
> Junio previously recommended checkout (a prior version used switch): I su=
spect because checkout will detach head without extra syntax (where switch =
will not)?

I totally missed that, that makes sense!

--000000000000b4c953063c275762
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 399bdd2c9a002079_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pYkE5WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1melZlQy85R0RheW92TSt4YnN6SUJqQzRVSWlaQ2xrcAp3YnNZT1JjZU1x
QWp2SUpuMW1KdEtKbVZUTkRNUUtnMFBPRThscWxKZUY4TUZaQWk5L0hEeVlva2lhUktVMXltCllX
eFIwUDZvZ1gxdDh5TGc3K2hpM3cvZTg0NVdKdGNEMHNpd1IxSzNmZnVwNmw4NFEwaXZacUNjTktB
eXBIL3EKRm1aOGlFN0tsUHluM1ZzTjZoUXNzdUdCRVRKNVBlSWJYeDBWY0dsTGRZWkdiaGFudFhk
eStHVHRkNmR3Z3kxTApXODlEbmN4Y3dUNnVSS3lwSFlTZHhLbitsU2dmWHpUdkQ1L1lCWWNqVkZN
RUtMcUtmOHJFV1l1WDlzUGNCVXkvCmJBSHpKODhjTHRZaG1ieXA2a3Nic3dURWhrOWhSS2FVTnh6
NDVTM2U5eDlOQVI4NXRYOFVhSXVleHl4cVZXTFgKRzhxS2NoeFBDVkhYSkRWWkMzTXgrK01IeTM0
UUpuRk9GaUo1ZTFkZ3F4RkM0QVh5V2VRTVNHL0czRDBJTUJLNgp5VUVOSDZJUEZ1Tytac2k1K0Ny
RHMvR1pHczh0S3F6MytieDZldGJhQklqSlpZV0RPT0d2Z2ZSL2tZK3U5ZFBnCmdxSCtZcDRpL2JS
cXFBcGVuRTZHNElBRmdVOHo3ZmFFdnJLcUZnRT0KPUt4eGcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b4c953063c275762--
