Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F119134B0
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736949619; cv=none; b=VJM3HFoy8Pjas8pikl6b0kZmgAYg6gIYnfGSGWfx5t2JCdKL7abXLJ1OOASljNZeLKl/H+uAXqZCN8+maZOCsDqTYLduA2RDbSYAayym3p59IF2ZMZlE6cUBR4QGLMSWcWDqxMbfZsUSAzpXdFGSQ91dR0FhXt4Fb37sO/yHPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736949619; c=relaxed/simple;
	bh=E0KsYZzGfYP2Ae4Si6CBTr2OLZjQVMjSpvIiKwk45K0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWxF44At9g0yt6XQxhZ7KIX2PdBNIAirwsUff3irYPmEjN3FE8xx+qml6fJTc7Qm3YNb+tpow3WG1DZRcZpXUlpMImZShpT/g7mnZ2wrIUC8q4f2RkAiE4B0AmLV1mNx/4Wc+8CIKxtpqPkbr87VWRS9t/ujt8bjd9os1OFynLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP64SuSp; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP64SuSp"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-518a52c8b5aso2111834e0c.2
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 06:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736949616; x=1737554416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRkqb1uqEZ/s/d45M6A9z0Ki5+GFyJqkiPDTIlaKb0g=;
        b=SP64SuSpPKl2qBdaaMHHDmeykZ0g7lfqyKzZx9sxCFz72exzAE7rF/ee7+rA+XJX/N
         Zu3aeBGzWMoz3pSlsl7Ly1Cwwna0fc7ewdNalUjpYpIZ9sXZxcg0VZSpmwnOS72ugLjU
         sLDtNKCZB2vMaXutJfcwgGROMqyans9Ac3jZnNHvJRzkeNJ6JBARKutR2Kct0i2S85UR
         lKEEV57kUf+Fr52aX9WVgFj9+xySni4eHykgeqx0SXYzKcuL840bxJg/8+B9sCmEMjZi
         S2D7KJu7tF09psUSDu7D2AxwwLD+tbjfo93XhMtrzHObyjlYbd4YpmD4ZlckNDplaCLO
         R9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736949616; x=1737554416;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRkqb1uqEZ/s/d45M6A9z0Ki5+GFyJqkiPDTIlaKb0g=;
        b=npOwYjgOXuwRPnnrzUwc5YmrrX8RrjbSvvIU2lVjEflScEkTHh0eaEX0iOUhHn4gfX
         28R5ZhpugJoH1aunoCe5YKg1WEvUy7VxLSPfaNXShU+V9UO0mKLyfxB/vM2nU/cM6VpT
         dplE9xgFIhvht5+9g31yu8rpc7mCZDfoK6iIplH2Q9aSn5REkCvL0yvSKFVKCMdFag6M
         vXB5+yij7SikELAzBXjgJ22pY8jzuPNvYb8eooPaf1v6XLPM/KW25zMdXrMHkWJmTlq2
         gInFmlOnCzv9A5nTyEC1RvNqjLiX0z8Pmc5EuOrTz3QE/p7s079t+Di9KFFQmu33tqC+
         ln8g==
X-Forwarded-Encrypted: i=1; AJvYcCU6NQgRw1SWWn5UXpL3xq12WWcDEcsqYRTPnkEFiwJlXMapkvWbGpzFrUqUNW93II32bRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdeIsdroCuy9W1rIjEULfwDRUAt8nyJLsWtWCNsH8yVHMe5tBY
	ACh+eb4e+p5mGfngcR+hZ/6f6LrGQK/tpV6YyQQf+aXtbH3waZOueUP3KlW14QfLEH5HqOOLBk4
	agn2gKPZ4yActcDYMaH8QMgX+2suZCNjn
X-Gm-Gg: ASbGncv5vCQGG4AfgC7s2iTCnuaidGsQd0luFuYvWwywoCsB7fIrLSpM+emn4Esf376
	GCD7x2MVvIvQNPtjgaEbjP3sJSxfnjjKuEDTa6RM=
X-Google-Smtp-Source: AGHT+IG0i/3lV9RUF1mMDn5qJVYoMhADE46ipQMtQFSXy53gNIxv7Am5ZC5VPsGh9d8VCvR97GIogPqSJFblWzL+ryE=
X-Received: by 2002:a05:6122:2090:b0:50a:b728:5199 with SMTP id
 71dfb90a1353d-51c6c50fa92mr24356667e0c.7.1736949616277; Wed, 15 Jan 2025
 06:00:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jan 2025 14:00:15 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-3-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im> <20250114-b4-pks-compat-drop-uncompress2-v2-3-614a2158e34e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jan 2025 14:00:15 +0000
X-Gm-Features: AbW1kvaXLPBddnFQTMqB9wYM-4ABdbX9h9-S5ZRNfZKBB0Jh7MU0pBpnI-jRJ7Y
Message-ID: <CAOLa=ZTvW2T3rds3YN0m9iWQC+sAaSCsiRw+fo57FqqF24pMaQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] compat: introduce new "zlib.h" header
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="000000000000df1efb062bbf1880"

--000000000000df1efb062bbf1880
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Introduce a new "compat/zlib-compat.h" header that we include instead of
> including <zlib.h> directly. This will allow us to wire up zlib-ng as an
> alternative backend for zlib compression in a subsequent commit.
>
> Note that we cannot just call the file "compat/zlib.h", as that may
> otherwise cause us to include that file instead of <zlib.h>.
>

TIL. This would be an issue if we added "compat/" to the list of paths
the compiler checks for headers no? I couldn't find anything in our
Makefile doing this, or did I miss it?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  compat/zlib-compat.h | 6 ++++++
>  git-compat-util.h    | 2 +-
>  reftable/block.c     | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..bc20b884efab72028d5f696923e9800e39b08ce3
> --- /dev/null
> +++ b/compat/zlib-compat.h
> @@ -0,0 +1,6 @@
> +#ifndef COMPAT_ZLIB_H
> +#define COMPAT_ZLIB_H
> +
> +#include <zlib.h>
> +
> +#endif /* COMPAT_ZLIB_H */
> diff --git a/git-compat-util.h b/git-compat-util.h
> index c4b4b372b473ca0af2a4f5f60554f6d3df74f112..1ca26713221ba0270818ac61b6940f03cdf8b460 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1537,7 +1537,7 @@ int cmd_main(int, const char **);
>  int common_exit(const char *file, int line, int code);
>  #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
>
> -#include <zlib.h>
> +#include "compat/zlib-compat.h"
>
>  /*
>   * This include must come after system headers, since it introduces macros that
> diff --git a/reftable/block.c b/reftable/block.c
> index 9858bbc7c5f7aa63fbcaf1acf9f4b5738e0b6d27..bc9b07963448e613ae14d2c4194b48764718290d 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -13,7 +13,7 @@ license that can be found in the LICENSE file or at
>  #include "record.h"
>  #include "reftable-error.h"
>  #include "system.h"
> -#include <zlib.h>
> +#include "compat/zlib-compat.h"
>
>  int header_size(int version)
>  {
>
> --
> 2.48.0.257.gd3603152ad.dirty

--000000000000df1efb062bbf1880
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 11301f53e37f49b0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lSHYyd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1pPQy85NnZSeThHeWliRzZ1ZFdERzFhTTVsWTJRTAowL0g1ZXl1emYw
aFhBN3IzRExDTVFMaUwwVTBGUFB3bmdkd2RHamJkUFF3ZU9ZbUZWcXVkbXMzVEdTdThHL1grCno2
dkUvY3RFaFg5QmIvaGxKbkljKzNmZHJyV1VXRWVEWWIyQzNHWEgxZWdmUE5oOEQ3U09IZGIrU1Iv
cVBMd1MKb01kNldId2ZEVG81ejByU0FzTDVuL0wvYStqcmYrVzJkL1BFeDNvZ1hRQ0owNVhPeDBT
eVpwRTNGK2Q2UGlzVgpOMUFidHZKZUE1Z0NiazV6bGhvOC9iUnh5aHp2a3IvcElLdEcvOUYxeGc0
K014UWFoRUpXYTdpaEVpQWFHTmJpCjRuNlhvWk9FcHI2dllOdVFkUTdyOWRsc1VoYUwzeWFYWWxL
Z05SOS9NM1g2MThVa2J1OTRCOGxhdWtITnB0SXoKNmFmeWd2QjdzZnBUbkQ0R1RkWEExKytQbWF4
M1d6MHdKS3VocGJnbzVNVW84djRzTGI1VWJYZGk0NGkwNk1xcgpTV29POU1UMlBxTndacTJOVzMw
TEw0bGpjODI1MG1BK1BlT0p4SzNOcUd3WTBvYmpNT2xaNFNUSkxIcGdkTDVICjdNS2NzOXZyRTB3
NXQ5YkIzU1FjTmFVQjFlUmpjSXU0VmJPaWFVMD0KPUVibm8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000df1efb062bbf1880--
