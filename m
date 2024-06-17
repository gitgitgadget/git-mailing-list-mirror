Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AAD193079
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616635; cv=none; b=up5eCCN+9M1cld0Gf2Xt8HYaf8woEpknxzJxXL/H/+047H/z78jQjsbbo+KmJl2ejg+RVbSZVvNgylMfW/IhTnsMnvg2eNkMHK4QFyi0wrkLzZSl52vjPzwotV76+Mp/4Ox9hMyvp6FtHRjHpKnkRrmVCrQAlrxV/qMyjClvAio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616635; c=relaxed/simple;
	bh=CEdMn8wF2wDuidntOim3JziJ4KhoPW3gfnk4Osb14kA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaV3ZGc7n7NkS2C/1+R5OcwPv5w5UqRxhZ0X2NVDTbbFWIA9c0P2bC8uvwW9OuO28iZfsAma+JOeDC1u2yib/OI4VkNTPfltC3GlOVrfL+TI5x8E8eAzyUazIGZQ/+785K/l8rofqnwUT5j2CbTrc8WaKmJorE0ROgNMaryjyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q04wNn2P; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q04wNn2P"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2547e1c7bbeso2207402fac.2
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 02:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718616633; x=1719221433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ijl+gml6iRzlfoOYnFC+WqT4PD9ZIhufJcqqrLRW58U=;
        b=Q04wNn2P+DuWKyIk6g/c3qU0DzKRvVAGP5ptI72jQgWDCRfdIxrJmor+k4OeptSthJ
         cy9aqvJA2EYytc9+okBh1CgJLg8T1Nyh9Tfq3lYMF9WiSXevcOawl3Tl925a2NHvcj6e
         kozYs97CgKQbS1huDCjxb2LHRY4TFpFhAvzjGoxmHJEDd0kZE2QcDIdk3ALGiJPrd+cF
         RtF8GpPo2QKPzRWoCgR5w9X3hxMQoEJR04xv7EF6rC20a1YyAP6vcydMxYl7uIuiWGx4
         wxTQIG/W23fLkPRXqlmmssRxTOKH+mufqFqTBoZg+bFRo9uwPBt+U/bN1DSXnmFRJyRP
         erWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616633; x=1719221433;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ijl+gml6iRzlfoOYnFC+WqT4PD9ZIhufJcqqrLRW58U=;
        b=f1u5bRSHmWqybospQ180CeVJ0KjIhHZ7qSX8/azpcn0Ule/vKsPpVgKupLuwnoaDgS
         ekqhAHPpoHoHSSbB8LAG+Gt2OPAtWk3RMQZ7AAoEzYMXLtuNOJj9MYBUv3D+T0Y6hAqd
         pfnci3ibJUXdTBwwuMebAqXXruwc8fAmoLIjy8UfQv1kbfOBHYJFtFMWtDNzyf2I/VvE
         d1Sz3SapYvEeuq94ry3u4hcQjbnADLQoSrp1SPMTcmsdoJ6ShJzQx6BzbCfqyzrNCnis
         296gnEKUTR5FQRKZ9BX0H1SSEJpitqPlQjatCvHuBCFaQeLlNLSRGMpSgthFXIda7+BS
         VV4A==
X-Forwarded-Encrypted: i=1; AJvYcCXL8+5otlZMugT0sUWKyxEARCRHOyxujOhk5jZyGokcFOHiCcG/fVZtIdCijxEaMpX4I9BeWVK65HRFlyyu0PAyn0Pe
X-Gm-Message-State: AOJu0YwD1AKvBdz2wJ5lF34akL6YkZwzKVt9MSe8sIJuYry90T+jMz4x
	OyzxQWCZb1fYZEu7PBrwrNRqfqR32NuC2cw1wCWr386OVvL5vIuye9OxeeiqHTZ2Os7pn1t819E
	tGSoPcsHZtS2uDABWFfsCvQB6Iy0jGDFm
X-Google-Smtp-Source: AGHT+IFjokw8MFl5qYuSXPCLSbnKsRY2oUjLbuYgqfLlFCj5mdWtTcgf9c8dYXdynCTpcohHANjVdfoVgJko9pyTWzs=
X-Received: by 2002:a05:6870:9589:b0:250:3c25:ca61 with SMTP id
 586e51a60fabf-2584288b414mr11224216fac.6.1718616632955; Mon, 17 Jun 2024
 02:30:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Jun 2024 05:30:31 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <7e023a335f500658b09a0037aee48eff06c668f8.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im> <cover.1718347699.git.ps@pks.im> <7e023a335f500658b09a0037aee48eff06c668f8.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Jun 2024 05:30:31 -0400
Message-ID: <CAOLa=ZTq+sQAtSiQm9xmdLyn=T=u8Ck0oXEBFLnJvH+54O+AHA@mail.gmail.com>
Subject: Re: [PATCH v3 09/20] global: introduce `USE_THE_REPOSITORY_VARIABLE` macro
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000e9bbf3061b129d1f"

--000000000000e9bbf3061b129d1f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Use of the `the_repository` variable is deprecated nowadays, and we
> slowly but steadily convert the codebase to not use it anymore. Instead,
> callers should be passing down the repository to work on via parameters.
>
> It is hard though to prove that a given code unit does not use this
> variable anymore. The most trivial case, merely demonstrating that there
> is no direct use of `the_repository`, is already a bit of a pain during
> code reviews as the reviewer needs to manually verify claims made by the
> patch author. The bigger problem though is that we have many interfaces
> that implicitly rely on `the_repository`.
>
> Introduce a new `USE_THE_REPOSITORY_VARIABLE` macro that allows code
> units to opt into usage of `the_repository`. The intent of this macro is
> to demonstrate that a certain code unit does not use this variable
> anymore, and to keep it from new dependencies on it in future changes,
> be it explicit or implicit
>
> For now, the macro only guards `the_repository` itself as well as
> `the_hash_algo`. There are many more known interfaces where we have an
> implicit dependency on `the_repository`, but those are not guarded at
> the current point in time. Over time though, we should start to add
> guards as required (or even better, just remove them).
>
> Define the macro as required in our code units. As expected, most of our
> code still relies on the global variable. Nearly all of our builtins
> rely on the variable as there is no way yet to pass `the_repository` to
> their entry point. For now, declare the macro in "biultin.h" to keep the

s/biultin.h/builtin.h

[snip]

> diff --git a/hash.h b/hash.h
> index 39a0164be3..cb85d26a2f 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -4,6 +4,8 @@
>  #include "hash-ll.h"
>  #include "repository.h"
>
> -#define the_hash_algo the_repository->hash_algo
> +#ifdef USE_THE_REPOSITORY_VARIABLE
> +# define the_hash_algo the_repository->hash_algo

s/# define/#define/

--000000000000e9bbf3061b129d1f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5a85bc44fb1dde3a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ad0FqVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2V2REFDSklUaHg4RWxYNkpQSmZITUxheUhmMzNkSwptU0IzcU93WnJM
cUtRV2dJRDNPeC9aOHk1SktVR3QrSDlzWDgzbWxjalhsN2dOYVpxb0pydkd3MDZZZmU0MFNsClZH
Q0JBTnROandXcSthdTV1YlliVnJEcmtHNEhxMzM1RTR2dlJpdWltT1pBVnIvci9qMWFJZTk1QmVa
ZWlXbFEKV2tDRUhseVd3MVV3dFhmclNGUGZFRmxOejJDNjlKMjBiUkVrRS9PSDRLbmdkZU5TVm1h
SllWNXFlZTVEd0E0eApZVXpEVWUyRkZDMTViNWpCd21kSDNZNzNlRXNxYkFRVUpPU1pScm9MaTNY
eXBWR1AwTDhhVWZOZnVnZ3gvcE5pCjdqOXZUOFdNdXJ3Ty9HY0VUWTVudDN1Q1Zwd1dhOS9KTEor
Ujk3UDhwRFdoT25pZldWK1Y0SkFLc3hsMHVUSVgKZW9hMjlBZS9PR2FoTDhLRzFRaWF0a2puYnlt
REFnb0RaSHdoMGNCSFN3ZXNSaFJnNUtuQy90Z0d2QnRIdCtHeQpiOXprcnhraitxOGNCd0tBRXhG
NDJCN09wMy9TNTJjT3BzSEl6Q3hRSEFjYkpId2p6dkxFbFpqWEdMaXd6UW9uClduQlo1czdkWnRI
Y3BGQ2hYZC9ZRDgyay95R1NBWkMvQjJYZ3dVcz0KPUZPOWgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e9bbf3061b129d1f--
