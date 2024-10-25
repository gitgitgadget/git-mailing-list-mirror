Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55822B668
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858675; cv=none; b=MOTmhYbeH8MkomXTQvIn/EyzK9KgtHtyv55ZsAkCZkjzk328Gcj6JJEJJcYBVtLzvgkAlhwrMbRm4BFnDp/a9DHBc2GmDdSWWCgW31u1vc37vpZqZGTxLH8fqbj5RtgM/cIlCb6wPEfLCge7xsYYNn9C2zKR2FlQKw6sv3XcaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858675; c=relaxed/simple;
	bh=TAI0lj3gvOC70Bd4chHXd6r5NE6OfKCwWEtA3AcGyNI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tozurIPxKe6gjcbyalEvb2q3BuSTkRwgKzvK7WRhH62JvOQHQ49tb1iobKkYXrnMXkLGB7KNIILreuJbquar2y1wDGLIc+pnJm8P6g6PHvi6rQicmkwf8yuNt+t4VrK08PG4LtmUmi2RZ1Rh6896oXuM/6VVtkkRBKmsTNWhq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT5TP/3D; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT5TP/3D"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a74a77878dso623210137.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 05:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729858672; x=1730463472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+47OXbumwvT/Y16hcaTejlP1PaIjXq0ctbJlcwjp/OU=;
        b=OT5TP/3DG1GAN+hL1sW+HNevXig1VO/hl4xzO4fiwSHbcD8NkBolAjSZzSO9AQGlZI
         3ta0Mk5O6NAI3RDs22F92J7WlTOlX0eimwRUfC7dczo4xBX8hAVcPRnHurXh6UTMeIPX
         stIUcwn8MYLHsneKG++eExy9SDQIDCacw7ltsaFsPlQWa9XxBuqaNXM3B7rYjN58EI/D
         L3gNdZhRw17MQ91CeEQyLz/yPp39JRv9UFd8zb3VOlRZEG/ObURl7A3QObD3CXUM/ARx
         v/k1j4EZf1YVdN15zww31WxvGfj63HRbNQbTmrvAZJFfcpMN3D7+q2pQVzlS+i2d+iP1
         vSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729858672; x=1730463472;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+47OXbumwvT/Y16hcaTejlP1PaIjXq0ctbJlcwjp/OU=;
        b=fdAJWKlzQixtgZozECGH3G1c55aeDaEihLWRRD6Q5q2ZD+7aIjMjmFEKE2h2fznX+U
         pYGUS9UfeDHoplqyXQ2yWBTpa2RlJQAYFYJm2INPmcP5kVGqSoay1o00ojZv43kUZnGX
         zNl1LJ2X0UtTG9zFiXDzHBuaElUIgeWeVDyA2I8k8RfJFU9MM+7QizwDVRoqmhJnlbXJ
         0oQDFCIHi9oFj8JzVYkKqCKDBoliFEAwHiS5z04nbc+SJkdoViTJx64cpzKQ6K9HU4KY
         pivB6kNY/MEa8+fe3qzrdWqJRzwKRKxF5vfGDigPeKgD3WuGgOsWLEsTzSVlDx+4kMoa
         9yiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaon9HUT0HhAi2qwlnsVjZrBRxus076XYut0c8kbKudWGiBMq1Vh19DuDPcFoB70pelh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0e3cW/ntYlWm63WO4iy5rjvY+zoSj9oDnTaLqURpwRHswyNp5
	UmgketO55vQqQcYPvrq1HJvycE4QVDnSdZAagna177XP0g4E5UUs2VGOAVzvT0TEGIgoOIR6vid
	bnrQZl7sDcdmEzvjmjhPuL8fmVZweS1M3
X-Google-Smtp-Source: AGHT+IH0yVMhaG3A72on1Xo8y02tODUbeGc3EtiUWHrP9rN4nK/VAATpyfyoRoBdlAH7XlVxdSrBlm8/+48kKPZ9BF8=
X-Received: by 2002:a05:6122:3196:b0:50d:35d9:ad5f with SMTP id
 71dfb90a1353d-50feafd4319mr6064899e0c.7.1729858671879; Fri, 25 Oct 2024
 05:17:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Oct 2024 14:17:50 +0200
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1729506329.git.ps@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1729506329.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Oct 2024 14:17:50 +0200
Message-ID: <CAOLa=ZR6cnhxy7K7TChxLafm7Ep0XUVFSK+LgNPtNX8yVLyWtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] t/unit-tests: improve clar platform compatibility
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>, 
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>, Ed Reel <edreel@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Edgar Bonet <bonet@grenoble.cnrs.fr>, Jeff King <peff@peff.net>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: multipart/mixed; boundary="000000000000a6504206254c1be0"

--000000000000a6504206254c1be0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series that addresses some
> platform compatibility issues with clar. Changes compared to v1:
>
>   - I've merged the CMake fixes at [1] into this patch series to avoid
>     conflicts. @Taylor, please drop that other series, which is
>     "ps/cmake-clar".
>
>   - I've fixed up the "generate-clar-decls.h" script.
>
>   - I've updated the clar such that it includes upstreamed changes for
>     improved uClibc support when we lack support for `wchar_t`.
>
> Thanks!
>

I went through the patches, played around with it locally too, couldn't
find any issues. So looks good to me!


[snip]

--000000000000a6504206254c1be0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6769254c3a2644_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jYmpHc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memFWQy85NmVnWU5TUkdKdEl4aWZMdjZZVEw4M0pabgp4SXBWQkZaNEZi
N1kzMXNhU3BDZk9FVkFuN0FHdHJKY3dlMDdVczE2bmdua1RSOW8yNEU1OWkrelJ0Y0FuTmR6CjJ2
VnZaVFh0azJERngvMDlIM2l2RnNlNG1MN0NsN3MxVEJhZ3RNcERPSEpaRFU3UlduZTNaWForeERP
b2JVUGUKaFVySE9SR25FL29UUWZnSnIxT2pHRlFucEhDMWhScHVERCsxWHdKNHRoeXdmcXB4cHp4
OHBNRmg2a1RBYzRwcQpjdXh1K3UvUTcycTNlT0JucVd2WTRGcWNjT0g3M1o2bDA0VXdqNXZyR2hq
c2lrRHdMVzRSTFcraE8yZ0wxbEljClJOai9tY0lPUTJtRDVqL0VtTmFRbFowVnU2SVUyWENCQlJ4
NXFQdGlwbzAybysycWkrZk1zMzlkdmVJVjZEdEcKM3pXZzVCQVRCQk53OUE5VTdCeGFaWTFKOXBP
QWdlK2FMUnVVN1pZUUxvUXZPcVJOWVNjRTliTVpFakhKSTNrVApZeTN0a2dFTzd6amFnSS9LM2U3
U08vNUFhZS9nYzJBVUsrNitRcnJnTUJ2anFJM1dsQit1WWVOT0paMGdySjUyCitkVWFndjZhQit2
WUhLUU5WNzk1b2JUUXhteGZyRHNZdUFiam1wQT0KPW95ajMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a6504206254c1be0--
