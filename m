Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0892DBF40
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903983; cv=none; b=CopQPYYaxRZT2/JPTdw71uZCZaM/Yugg+ln6N1swjqW6iJI3cbNQVtLyx+bj3aMozqId6PHdRAT36+f7DPOcgce3OcLGc0JKahFvt+G7i3RJvi8RiK+fv+5hjQTREBTUhI7uhw28MlyvlAC0BkTjJ8hM13V9E5L6p0M0iWT+NFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903983; c=relaxed/simple;
	bh=SX3UvGHJkfwLUF53mwFBPI81dfz0kLFzio0aKi/DjSk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DryCRXWfTPzR07Ue+bGFinuPi56n6ZnNgpMw+R/sz7il2LRYTfpjMxTvf/MQidR65MWMQ1nyhUxk+CAfIa9SlpNbsYwBmhJD8nUBItuYkyjMHf12L8Zy2xUXkMz/xb5FL3wbCDxubx0QMbJUHjesENNdcSKdQyvluPB2IVG+UBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2lf+hWc; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2lf+hWc"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4fd210f8448so5664631137.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 02:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754903981; x=1755508781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QGhXpUZZu+0q3oXmdzKWIa2/Ec6wFhy0h2L3MxphJYU=;
        b=U2lf+hWcEiOnhaCZyyHQg2dTc2MOfViXUtPrglSo0Vz3AmVQlWY/kZWqERhSlatBMA
         pa9HVHihYQLqg+M/acHO0H6Ecxz8AWop7Oufez5mIN3g3puKn8gaMOGNNi8bkaTaMUGq
         CVDOK5us7NSPujDd+DBJMNnOkzvNrJkV3IEAOGkmerLu2w9U4ceVze0wyzb8DDg9Zq/g
         d/YuVPoImENP1wufcShhryMy7rdbQTiDa4NmuYUWlfbZ9vfVDLht2aBXpMXJ5a7rC5Qt
         8uEt2LX1ej3/vtBqq5Hr1dXE7aVfFrbdk4xndtk9DlkPYGozAJmSwKMatZ2cFj56bmQ9
         w8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754903981; x=1755508781;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGhXpUZZu+0q3oXmdzKWIa2/Ec6wFhy0h2L3MxphJYU=;
        b=deFuZnuwZQZd18qjbvqL9Y+0oNLPTSXX/2G+hfklWbd6UPU0pMIuKO2yA+kNxrWGQD
         jpBwU/S7cYNMBOoRXRwYW2nc9mYEZ/7mX9S0epCQZ3MjaYt7kOSPRO4a+UjRU7OYWWcU
         tElf91N7f0VWAA1SiaecxyE3CqlyU1fPrD+qhKwfWUycvvWB4FmspEs0H+Krm67CNSZv
         EoHVURpS+lF/1Prb/ZLkml7Ftvdx1BC90yCrWz5T7wRcviyQ8TK+wt26A0Zrt9jT/Y5x
         BnhZlOHSEvoU65dLSTc6111SPX0Cx+C/TzorJNzzKKQ4zxTe6ZicJykftHQXIOQe/Vzt
         M/PA==
X-Forwarded-Encrypted: i=1; AJvYcCX3A+KbXbDlqqMYd6t4awnjQSMaKvW0bvGX9UW+1QYmX5CIqhxTdpx5GVnvXj/yqyGH0z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLoZueJQT4/DR0LfRRdFWRhrF+fDy3kAGs1iAyPcT9xSTOWW5v
	7KJg2eCbP0K8JxfQAbsKnS+0nH7nQ9UoNLCm4x7QI0En9EfXT37Df0Bj1gmqQLrIwlyj1ZBIk6E
	sVugkkQEEuZbl9gk11fKEY4+3VyYhQN/RZw==
X-Gm-Gg: ASbGncvixneTBoNwSTrWGFhhlu5gpWefwx5PdJomjqO9zpORPK67LcQNESium943Dme
	qMY8xXt6J06/TUJomEP4NYvdY9y4mVz3t6UPscpFPo17XP8xX50EQQg2Hgr9mxfN4pZqEpzTPjI
	lpzi2aqK3xijljIuHkjs1T3RotchxO8w46QqAWbNv4TZrLfacLDuneHcmxXYqVZL5SgRqyXmf/1
	WOLmQ==
X-Google-Smtp-Source: AGHT+IGGt2+KkA7x8PUrd5IQG3twoFF/noHyWbYvAMksd6H48T9OnfAF+FLfyhYgde9owRRXXNNR70oeS8KynKShFFo=
X-Received: by 2002:a05:6102:5114:b0:4fd:53e0:b522 with SMTP id
 ada2fe7eead31-5060eed30d9mr3868845137.19.1754903981030; Mon, 11 Aug 2025
 02:19:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Aug 2025 02:19:39 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Aug 2025 02:19:39 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <1a32a666-fcf4-4f05-a468-2afa07fa0e2d@web.de>
References: <1a32a666-fcf4-4f05-a468-2afa07fa0e2d@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Aug 2025 02:19:39 -0700
X-Gm-Features: Ac12FXyt66qGv5PV5pmGb4z9AFomGddzBgoBKIXt56_OYpTKDwyuV1i7DKiGNsE
Message-ID: <CAOLa=ZQqY8MDTs846mkVsxXrmOmC5O_sv6BxUHqYjGk1Ag+Osw@mail.gmail.com>
Subject: Re: [PATCH] for-each-ref: call --start-after argument "marker"
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000067a790063c136cc6"

--00000000000067a790063c136cc6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> dabecb9db2 (for-each-ref: introduce a '--start-after' option,
> 2025-07-15) added the option --start-after and referred to its argument
> as "marker" in documentation and usage string, but not in the option's
> short help.  Use "marker" there as well for consistency and brevity.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/for-each-ref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 8b5fe7b65e..222637a2c0 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -46,7 +46,7 @@ int cmd_for_each_ref(int argc,
>  		OPT_GROUP(""),
>  		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show only =
<n> matched refs")),
>  		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to=
 use for the output")),
> -		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-after")=
, N_("start iteration after the provided marker")),
> +		OPT_STRING(  0 , "start-after", &filter.start_after, N_("marker"), N_(=
"start iteration after the provided marker")),
>

Ah! I did fix a typo here, but your fix is better. Thanks.

>  		OPT__COLOR(&format.use_color, N_("respect format colors")),
>  		OPT_REF_FILTER_EXCLUDE(&filter),
>  		OPT_REF_SORT(&sorting_options),
> --
> 2.50.1

--00000000000067a790063c136cc6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 99fdf11e7f4df8c7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pWnRhb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUxWQy8wZnN5cXEvQTM4R0JUeDVRT2YyMDVOM052eApjZ2hOek5UZjBR
ZEF2VXJ5clZXNExxenBWYmJUbEdGQTd1ZlhJUmVJdWFEVFlHMVFIWEo0RVFhR1htVzNOSk5OCjZQ
SHV5THMvOHJnWk5WOTg4VzdnamlENWI4OUZRUVphNmx5SzJzWDVRdUdoWFVidFJaNHAxK1lpa2Fi
L1pGZHUKZzRrMDZaN1llbXNRSzFwbG5xb29jd2xyK0pCd0laaEFPWU1QaGpERnRSVlpRWjZ5UlNJ
V0c3M2tqcmlDQmQ0bQp2enBrNllPQ2lYTkIxOVgzUDloOHYrSlNYZUtGeGxYTk1mbkpSWFdBTWJV
alcvUnhYZnRBSTRJN1o0UU12cGJNCnNvRU1URlpIaDMyUjB5ZFFhc3NyaWFFVk41OFNnNk1xWkdn
a0l6YUkzaVNoektGVmFaN2pFdWdTbldRU2NZNGUKQ2tFNVFZMEhkdGg4QjNSWjJIbkN3ZnJ3N3Yv
NjZxcGFURWhhUnMwVlgrMEdINC9mVWJhMnYrQ29hSkxreGVvRQpncGk5YnM5RkcvNzUyVStTbFYy
SHIrUmJDcDVhOVVWNWNMbkE2VmxlTWJMZTF4MmtONkplMjZpL2tvcHE5dHQxCnpmWUx6Q2ZGZ29S
Y0hNYkNxUTFMaWFKMTBMZDNkOFJIbXBzbUtBZz0KPUhUU0kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000067a790063c136cc6--
