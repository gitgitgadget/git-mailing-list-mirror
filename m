Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE8217736
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227532; cv=none; b=sT7+Ess7DhMmlgMQTiPAUj0UZPx3Iw7Pi6EjLeOv5XiY6FstVfKv+3Wlk+R7fSBUXdxmicushGJJo7KwyVpIJ6HO1EECt0zndNxgUqlQ0P5CO4SmLak1ftisSZzyBZucVDn5MyURkxX/UKRfNPvr10EN7N1bzOVncIdqYahWytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227532; c=relaxed/simple;
	bh=xhIPCoWLmn5XfI1uxg4b54je5Z1Q8s9v8CZTp+T3ybE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=h15vJLlREFYh22qhNWiMieayRGQwH6po+G/r2fy/JzS4A4NUcSzF8rPrD2576xgU9WQwwJE1qNtj1sXxaiAF+eEpCHaYpBBcmbmxxhSw9XLj3cb79V3glM7nRhITYA/mBuOWGfhcGVOo77cxhgXXjBBWj+fCD28ChrRJUFA0/hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zmgk7pWj; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmgk7pWj"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8815049d0a8so841764241.2
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 02:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752227528; x=1752832328; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qwi1Wsr3LXAzfotPmHla+o3hB4Fl6ZETiYvfHi41F7I=;
        b=Zmgk7pWjsK2DVjQv+k7Qx35x+ViaCgvDP1j7l83zeZu+YsP8GHUjcePx3WfGVpWmNb
         KHS0eZAaYm1s02yXlI16qespxkec1tX9RZaJiudRE6zjyX2sOKbJ1okYHPHb2U05it5S
         CgPmSJyJ+rXnKO6eF9ljHedecMouEh3njL2RcRnPIpdjJvmbm8tsMsqLIVp6IsYFwrjo
         ENjje4z9QzVIQwkItISvTtmYU/MAxKPIPwYigKYfjQqOlr+iLfRoaHc1tHjYMPVXs4l/
         G3w+STkzQf0C9YD9S3CHmt/S1kdSbcBz4sBHmYJKjdKqFinfH5cf0LpGc07vDnJIihy7
         kzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227528; x=1752832328;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qwi1Wsr3LXAzfotPmHla+o3hB4Fl6ZETiYvfHi41F7I=;
        b=F8aB+9nXOFbqiupC2Okx73yqHhXhT4RuxvVMCihoBlYmBXUO014AAs8KcH+9/+9QNq
         gl6ig0nS7osTIxGJKej9bEdSkq8jW/gxMtxMQ0EuABBJkV+CoiUPD/efE1TMtfRoEnVI
         4o6yBwUsTylquhxyvkKn9pACxxAGfm+TPoN/C5yChTEJdcQ5j0h2zNNbM2R55g+qgCOL
         +dogRAD9HsDC5KlGF6Se+C6wvXNdLBeeAejhHOObOSCOF4+FY46YF+klWsxnpjoo3nfT
         CZz9SuP+8vA0uSSUsfCzdclwY8HoUMyc9mU9JAC35bi1wt9iaQB+FFmH1LNRgCdE5IgJ
         hipA==
X-Forwarded-Encrypted: i=1; AJvYcCVsa/IuH3Sfux2UyoYU/xIfbjci7Ho82mRqw37SWpqEUZt/QWd+w39PQ6Zp9jRYYhSmzHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqWnnGnN+ZSEIkyFRhECHfYGVRk/T8l7xM7H1w8kPFJOPE3Cd
	XGysIU6ZzjC/Eg9+5Y+eObP1HWwclHYWPtGAfgVAU1tNBytIsZgqB7udfeXCNj6j0Zyu6Y2kye5
	oH2zyDIvfFa35MtsACoA+oz1pTV3MTM8=
X-Gm-Gg: ASbGncsJF/blyBMMgX9ihrGF84rhQB5/c9c9phoZld6iUhOfN4+BxHt0lgIQ4MsMYkA
	7Sdl1+IB+e4TgbEMte6/cddU9hMYZdLZ1CnRhaE6i4S9DyBV0fvE0d9tb+kJjF0VT07OZz9bqjX
	4efPMJEM8cudat5uPnatvjsBGkhCXF2pWw0ohEMpLAY+TsVWFUhg5MGn6w18AQvXqxS9oALrkv5
	FsxLnlLiDfwv9ND3Ib9nDCSNkTxVzbZ6Rxq8xk14IDIBXMChDU=
X-Google-Smtp-Source: AGHT+IG1VZUkf2A5Gi2B9ymUgoaTXzXZYPdWUXHH+D52knn1wOD0M0Vpn3S375fwQprZPoLhZAl19N08plkkIqhkW7I=
X-Received: by 2002:a05:6102:5cc3:b0:4ec:c549:161 with SMTP id
 ada2fe7eead31-4f64270d96bmr1509865137.21.1752227528238; Fri, 11 Jul 2025
 02:52:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Jul 2025 11:52:07 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Jul 2025 11:52:07 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-2-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-2-62627b55707f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Jul 2025 11:52:07 +0200
X-Gm-Features: Ac12FXzgQXv1H6xQNcQCFI86SD3OBPsb635fCtX7IAXeu-7982FaBYhnnI3hSds
Message-ID: <CAOLa=ZQhuaXV_XqQ6ekqVq0hA5bu8EUyt5P6vVG321eU6brcHQ@mail.gmail.com>
Subject: Re: [PATCH 02/19] object-file: stop using `the_hash_algo`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006303e30639a44390"

--0000000000006303e30639a44390
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> There are a couple of users of the `the_hash_algo` macro, which
> implicitly depends on `the_repository`. Adapt these callers to not do so
> anymore, either by deriving it from already-available context or by
> using `the_repository->hash_algo`. The latter variant doesn't yet help
> to remove the global dependency, but such users will be adapted in the
> following commits to not use `the_repository` anymore, either.
>

The 'either' doesn't make sense here.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-file.c | 40 ++++++++++++++++++++++++----------------
>  object-file.h |  1 +
>  2 files changed, 25 insertions(+), 16 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 987cf289420..bc395febc9d 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -25,6 +25,7 @@
>  #include "pack.h"
>  #include "packfile.h"
>  #include "path.h"
> +#include "read-cache-ll.h"

I wonder why we add this header.

The rest of the patch looks good.

[snip]

--0000000000006303e30639a44390
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c981a23504c1715e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1odzNzUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHh4REFDZzNqam9WNWNGeW00MGVoVkNKU3hlZUh3dgptS3JjYjZ2Zzlh
RzJKQlNqeGFSR3BDRlZOWG13R0ZzTm1DYTZESDMwNnYrUVZWTEZDT1k0SmlTSWs1UGZ6SlRECjhz
bSs4cS9LZzc1V1dYSHliZVl4YStZdXByWlBGWmdoUWVyMk5FaEVWUWp4UGRjaE5Zc0VqV3E3N1JH
TzN0TFgKZDZrd0ZuT0NFbEtCUjYzQ2x2NC9Ca3pwMmJieXFpT2JjU3Q1aEsxSk10d0RnSG03K3p2
ZDBTYWRaN3JQOEl5eQpwVTF5YXRJRlF6RGwyUStLbk9EYlRMWTZLTzVXQnJqeTR5VVlRSWVqYVdn
Kzd3R2xIN2RLVEt3QkpYTWlnY3dpCnc0QmFEcmRXVUJoQVlaRnkxZEh0ai9ZSzVNTDhoMTZMS3lW
cUROdGZWZkFXSFZ3YzVyaHFIaXpaUnUxbjZ3dEwKOENIcHplRFlsSXN4bFJoSUFNOVBKbUc1K01h
YzRRVk1aM2UrT3ZPWVQrdlRBNmR1UWlnWkxBMXNpVTlmMUtqOQp0VzR4RDg4dk9FZXpYTVRralBH
T2tIUnFveHdSRHZjS09aV29oZUFGU2liU3pLcWpJbUJuY2hpQVl3T29EallhCkE4T1dHZnl0dHZz
dGd4RFF2S09EZkFqNGM2Y0FJYVJwcWJEaTV5OD0KPW1wWWMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006303e30639a44390--
