Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926128A1EB
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428321; cv=none; b=T6E6FyzZJRytAR8Ja4pDfr+m5av0rGK/YGZQK3QUmdBs02KgxmflKH5bSpc9A8DEbRhtbX+YEAJh3IVRQZj+gcDYwqjoFSsGnDGycneLjeP5r+0kpJ0EoIKEDnOnRMX1LMab1oAKf4U4hjbwBE/XerqMpnLCr6ktz2FxFKoEXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428321; c=relaxed/simple;
	bh=CsBidVKOQwe9f1xgbg6KxdC+LFU9SYbaD0tMkcKAfKA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Odo4k4djUEaZIuPbFktSaIkJQGMlIR7ZTnAzmpngeItL8uKXk2hz6LRZ/pD3WmLEpgLBY/vX/EHSp8Fb8SjF1bbjy4ub1N5IPYPVVejXJw/xKUM19gnRej/nH7sCagp0Yw6MBkzCKyuFb1Yx56/nkdOGaGsl304MQSES53+QekY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiNM6J+A; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiNM6J+A"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-524038ba657so94544e0c.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745428318; x=1746033118; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKPEADy5znnV8WWkzEDHap5abnHDXagMfIuX5Ixy2hA=;
        b=RiNM6J+ALK4Wv2vClnmaPpthZ8hOe2PRGI5kXj26rICUrraRDSSJ5WH57DtipRAx6D
         pHbVlNJCxV1O4EBZR/aOgmHP6jfI9gUSrSrJoEZBe+zA9AvJ5KwA8A5G/S4k2F7TeSL0
         Gu5DzZYACHE12BwTOCykhJLxzfoFm8EU3prHNQdX2KEsjOEhP80Zxbw8pGLOwXA/Hm/Y
         MR3MoS7eBENLWqOCt68ZZx3Iswd27MxvrA+3bcNIS/WTMf3NXc9b+7eOodJj7hj0xSZ6
         DIxzkpESJFEWR1KocvGSUDhtisT2P80rTRBts85ZxHci/tDEPvO/x1IBYssauuMHm7m0
         NWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428318; x=1746033118;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKPEADy5znnV8WWkzEDHap5abnHDXagMfIuX5Ixy2hA=;
        b=JdGa7FSVDSOSL1kk+GxgLxcRowhcwu/3ZYNjW3uILlRpX1P9a4h1pb0ye4LNyzMjtw
         nG29XFyowECngA4baWr/n94ITd6PLR81b8281maaJUMbFcsd1I5QCvj0CEHtfh0EBqoY
         yo+u/1YIxgCkNIL2/62CWqI7/WNoFk87YbPqnLLXkcLH7+V78YR9ztD4++ZS/EL8+Vds
         QXisfcr4QHe8CfzrE+jv7F/sXKWOH7/VE3V/1jPXCQq/559n2ksHGSDwv2jCJ+rh4XNj
         it/Qr97SIJyZx9ULBB6CB9uJKGZ91sehtD/OYe//4AQfjwqo4UgQaxRoEO1MTkhWpDR7
         H0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUXjzw9ubdkZTMguTsXVOT5odsgOe3mOYKkZDNdSV40RR++cvqWrRplwBc0929yTep/zhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUw9YIMJP65NnodY5+/HfMaHCGKch9UDmp/wFwJYmHviJ91Irx
	vcFRQX56AhqeGMwjEBK+WQ5JP/9MV149OOtu54m4fSKRjKboH3SjS60Zx+IXL0gnNzfEs59BeZk
	uylOP6AUNxhH9TbUO9yPWwa00DT5acQRE
X-Gm-Gg: ASbGncthyF+VGi6G6L/Ry4AyRxnfvi0PfIxUSQStEEA/CJMdvloKxT+DkrqK8baptNZ
	KlXtRPOh4ApzRU556n0K395Fpl4yZpCmsCn8eCtg4TE/K6bn8DAJK8mJtKF6ZDQqFrldGo/9bh7
	GIqg8UB+nzMyCPYZaA9FOVI4AZUt3SDZOd3WLi9YLnwkHOQxa8OGEyXIjFDAV7aCsa97Y=
X-Google-Smtp-Source: AGHT+IE0LXfICVcwCwyBwv4PQbnO3Rxxdcxqb00LtXaFi5v+QPX9S8iUGneDDKm7DBxmlmpHxVHbPZ/JdYIDDoxrJuI=
X-Received: by 2002:a05:6122:4b11:b0:523:eb47:2884 with SMTP id
 71dfb90a1353d-52a6a18b62bmr3178630e0c.6.1745428318603; Wed, 23 Apr 2025
 10:11:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:11:57 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:11:57 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-9-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im> <20250423-pks-object-store-cleanups-v1-9-81f8411a5d08@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 10:11:57 -0700
X-Gm-Features: ATxdqUEg9-BwvMKSYHy7YS8IcH9-BDZJEf_h07Fykc5O6e75Gr1IuJC5JgtGtTM
Message-ID: <CAOLa=ZRn=+kSzHqME4AM-O-Z_05bojkHu5_hymNpH1aoLb2zEQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] refs: don't fetch promisor objects in `ref_resolves_to_object()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e9a6b5063375326e"

--000000000000e9a6b5063375326e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Similar to the preceding commit, don't try to fetch objects pointed to
> by references. Any reference whose object does not exist is broken by
> definition an, so we should report it accordingly.
>

s/an//

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 6559db37890..0492cf0d13a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -376,7 +376,7 @@ int ref_resolves_to_object(const char *refname,
>  {
>  	if (flags & REF_ISBROKEN)
>  		return 0;
> -	if (!repo_has_object_file(repo, oid)) {
> +	if (!has_object(repo, oid, HAS_OBJECT_RECHECK_PACKED)) {
>  		error(_("%s does not point to a valid object!"), refname);
>  		return 0;
>  	}
>
> --
> 2.49.0.901.g37484f566f.dirty

--000000000000e9a6b5063375326e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b1be06eca548a4b7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSkgxd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekRUQy93UGQ4Uy9TVTNmK1k5aFpIUlJ2RUJPS0RBcQptak82bHE3b2dI
dGFxWlkrYW5mTC9TbE1LWk1iMVZ0dUw5UGJYRjUxbnlER2xFVVVNZ0hTSEhCb0JJVzZUK2RmCnZj
cGtSKzRlRE4ySFBiMUhWZTJQYkoxek1OTFR6andWVmRhSzA1cjRMUEMyTmRaU3loSXgrblNrMTdC
bzNIMHAKdGt3MHh4MGlKdi9Hb2k5UFFZWloyVVJJYUpPeEdMVXA0VHM2RlFKRUVtQzlkYnhzeGNH
VC9hYWllWTUwdFp3cgpIMnNIdHJEQ3JlV285eG85SVlGbjVjR1NBN2xDYWwxS3JiM3pjdlBrMXVE
eUsxZU5sQVM4NUUva25GSG91WXA0CjdZSzMyWEhVM2wvcVUzY3Vzd01DeUpPdktNa21hVlREL0dJ
YU9MNjhNSEhyTWRjZERMS3RWQXhUZmkyYVhHYzkKeGMwVHlBR2xtZncxUUdXQ3VseXVyendRSjZw
VmoxYmZkMXpQQWoxNnIzTnF5dFdOaHJJRXZZcnR0aFRZMlJHOQpkYVEwQXIzWHRCV2lwRFlFN0tn
N2l3SWhoT1g4d0lkSE1xV1ZMWmlUcEQ3VVVucUFhaUNZbW5Yb20rN2FDRDI5CnEzM3pxcVVXL0lT
TnRNYVJLSDBPN2VTQ0xieFlrOWZPb1JsZjY0OD0KPXhuWnQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e9a6b5063375326e--
