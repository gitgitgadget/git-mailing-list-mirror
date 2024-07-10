Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903BA16D4F9
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603115; cv=none; b=Qg5bZ4Fq9CB7v+wPDiNq+iCeirr+XMJyJ/Y65Za8QZ/VcBJVJAlrXkgdasxLVgCEL+5LhbIxMTivaC4EaRwooEx+CYK63goJBqPqO17NQ1l92AanhlXyO45ul9gc2uT98HtXx+TVIXWAYEeJivIrWk5yT1UmD23OjmWZh+eIGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603115; c=relaxed/simple;
	bh=KDBaljPNPIckH0k/xmUD7324W2WxZx3lyAjao6lzqLg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyv0z6X6rPCqkKXmHpTo8ZKYxX5za2dsjLas0DXtgTvK/lfI/lOjaNYMCxp5Tc6XGCL/X5dOizzVCLYUdvqN4M6tqjN5GwktlWL29aw7JoqpzDX2+XoxkJFRA4ub4Z1P1QM/kw++c9CDst+S/TH+LcJlROlsHoKgI+AQJXuTalA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0alAlOV; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0alAlOV"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25e15406855so3681173fac.0
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 02:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720603112; x=1721207912; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3tE/xg8gxA3QHwFibUEAE00EnkcNaMe6hT/cIj1IsY=;
        b=D0alAlOVG3kW38tfWxLCpLYlIECo4IaonSVYYHXbrMqvO7W91QjN8FUthetv4x9l5e
         QD5WpMo2gLhtnw0detwlmn2zh0j6F78KDBQJWpQzr2MEmLXyzGRlC5LMWZyy6486e4vu
         Q3azbOQ1dvWa7VeRemjRT0l/hl0pu+FuUI27ah7hlnV7hsRyHc1AmWds5psghsupo572
         1fWPFUBuqwtsCFlXETqjE5ncTePaIOygkrhytDKFIIkSraGBWRE8KgkLuOACVs0UWeSu
         88jhsjg1M2mttmkQNfn2q0QaZE44MfwJkXpKD8qtTkI/vHYycJwz9IVbxmo9TTo2oCZ/
         BtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720603112; x=1721207912;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3tE/xg8gxA3QHwFibUEAE00EnkcNaMe6hT/cIj1IsY=;
        b=DefD+ukdV3EW2yqVq6ueKJ7ZgZTvjnk+rEFj4n9qAU0jA41FNJQcjbQTEY/JvGcet7
         K2HiapRsBsIBeeqfBzMfZEdoZRh1mSPSsTH2h0nTjtcb1XNjAwLqK8kLLj+i2xo9Gabr
         9o71LjqF9PY3Y522t+31ni7+0tFviVYLKLV8c4aH485AixUOQ4Q2KU6K1ay9ybVrEbRN
         TA91/JdcG3LoUd1g1UgBDx1kBANyBxFd6flRtipZAeMJ1P8QS1NNCyLgc8UY3b2pUwU4
         CpDv/Qj3zQTZPfL3HyoUuOBonOYti+ieriDEtIrYP84OcsFBjpUFycZUp0SzOM8OYgGb
         ePZw==
X-Forwarded-Encrypted: i=1; AJvYcCUBrfUrPM4AdGgTD7MhSMKp3vShvtnOtLNlCFeWMuPOtkLYFgW2rpSC53QLgL2WEkm9JyYeHNXOvT+9+C8ppCMnDW8y
X-Gm-Message-State: AOJu0YyGkSoV+3DBq7jtIIPNY24K3pW7OtuchtMsSWZyFvpYfgOxZqD5
	wD8EDscMkVR3CVqrAt1HrcHqwGHIIZmb/mLIPc136oY3b8XgjppD5n/PSARi3ldGUPzspYAtR7o
	BNvcr5SFTbQbq73Oz4Y51YDhy260=
X-Google-Smtp-Source: AGHT+IGHIphvKLpwXQi6aYdvZLuE/P3hHEeD0TBOcTrjEHVIAvMf2/hD/u3EgypTjGLvcu4bS+AfNLZeXXHrQTY2sTg=
X-Received: by 2002:a05:6871:611:b0:25e:1610:9705 with SMTP id
 586e51a60fabf-25eae784630mr4196312fac.2.1720603112492; Wed, 10 Jul 2024
 02:18:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jul 2024 02:18:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240709053847.4453-8-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
 <20240709053847.4453-1-chandrapratap3519@gmail.com> <20240709053847.4453-8-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jul 2024 02:18:31 -0700
Message-ID: <CAOLa=ZQOdH4cTQ4iymZAZu0Q_WYTepF0y6zWKQAxtBVirfhsgw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] t-reftable-merged: add test for REFTABLE_FORMAT_ERROR
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="00000000000051f532061ce12103"

--00000000000051f532061ce12103
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> When calling reftable_new_merged_table(), if the hash ID of the
> passsed reftable_table parameter doesn't match the passed hash_id

s/passsed/passed

> parameter, a REFTABLE_FORMAT_ERROR is thrown. This case is
> currently left unexercised, so add a test for the same.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-merged.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
> index e0054e379e..50047aa90b 100644
> --- a/t/unit-tests/t-reftable-merged.c
> +++ b/t/unit-tests/t-reftable-merged.c
> @@ -11,6 +11,7 @@ license that can be found in the LICENSE file or at
>  #include "reftable/constants.h"
>  #include "reftable/merged.h"
>  #include "reftable/reader.h"
> +#include "reftable/reftable-error.h"
>  #include "reftable/reftable-generic.h"
>  #include "reftable/reftable-merged.h"
>  #include "reftable/reftable-writer.h"
> @@ -440,6 +441,8 @@ static void t_default_write_opts(void)
>  	check_int(hash_id, ==, GIT_SHA1_FORMAT_ID);
>
>  	reftable_table_from_reader(&tab[0], rd);
> +	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA256_FORMAT_ID);
> +	check_int(err, ==, REFTABLE_FORMAT_ERROR);
>  	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA1_FORMAT_ID);
>  	check(!err);
>
> --
> 2.45.2.404.g9eaef5822c

--00000000000051f532061ce12103
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fac8675f127bc208_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hT1VlWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mek1zQy80c3FmODFDZUs0TnRnN0NzTmFsZW1JcHgrdgpGZkhYb2ZrZjVM
MjdQNVNpWXE2am1lc0pPTHFTczlJbmRGeXJWUEhiS1BDeEhiODU4MTJ4YmgxZ3BjZFBOdnFGCm5w
ejRYaU50THpiRkJ1WE9iQ2RxM09yK3JsV3EraFNieUpFV21Zbi96MTZkbEYxVmFUN3FUeFRSV3Ny
YnVtcUYKRUU0eW5OVHNxOTR2VWtUWUNua0REWlJSWHJXVWRKWlJPNnZyOTRRTS9LK2poMkRmZWRw
Z0hYVVFHNytrT1hRcApKV2FwQk03SitscGR2QmF4ekltaGRzc3l6am1nSFZFbldrQWVlYkFpSFFE
RVRtLzI3aFh4V0JWNTlDOVZBa1prCkRmaGFkdjdFU2NabEVHV0lYVm54NnZRZWQ2Znl3Q2JOMWVu
Zm43QVQxMmJuMktaUmZGenN1M0JVZmRQZGw0YXIKRlBVbWtwWEJ0aFAzdmtYTlNaa29LQndDb05T
emRoQUV3c1NIL1F1c2RSZzNIUSt0YUMvQ2FBOXpReDZCNkZpeApWTDE4REZzL3E3QlBjS3JwSWxW
UzJhVGRFeVZFSENXUWJNcmVSK1QrazBtMXBFNlpWZ2VvanMzazAxUFRySUM4CnEwNlBwQ3N5dlov
amkwNUk0STI3YlhsR3JJVEg4bzUvMTkxWlpzYz0KPW5mOTYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000051f532061ce12103--
