Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C922BEC20
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821281; cv=none; b=Wlzn78WC5VuMIKIHTBig24gSYg80kOnRFtzgyxkHKz1J/oqBXf+S6bPO+0K1wpzw+0qM8G4tsUg9D7rKUYFfKMTFcjd8G/3fObh5qv1fOCBqEFHT8For9sb+2geWNbix43AXcdBYVEvJoCQ+HuU8zJm8tYLtoPXiXApXdmp9Xw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821281; c=relaxed/simple;
	bh=VUdwnuX7ApeO1E6+sfavOheh0MKrJ8qHuh5LdaMXp5M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=IOf72ytF6EBrEa1Oyd7Si5dqF/WlRDDSG3roIDjI1iCsvYCdXyI75U/z/21DMR7LPWXjEdzGtYno8yfLsoNKo/MCj5IiXYMTzQ6WKi6tz/ym7EA5xlWUB9ao3IJZqd6J0fNL6bAA56zZ/Wzmir1Z5a8fZDr6b1QnVXh807MB9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWcnbLx+; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWcnbLx+"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5ce093debf6so978162137.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 03:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761821279; x=1762426079; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ewytxFQKWEPP8ksVLrFNMpG0Im51NlWWKRtb1uDOsQ=;
        b=WWcnbLx+V9tfhQGPgQmPPuQNWR3D4iX1ZwdyvLqtlZ4b+FKyUehPi+fZSs3gqsrT53
         BND1fWDdCcGqv8kw1g+OVnkDMUSAtvGKg+pmdgl6zD4mOkCuAFE9YQ7HR1q1r1r5GlAd
         AEzR1wo8FeCPArFRYJ7R9gDuoE2WjUphZe3ykEzyZmXyV0nQD5P5tDbzfVDckz3F64Ll
         nUmp317Kd8qIUEk9UGuZyQ0DyLrGN+x99GFw26Ug+RsxqnBK/fPdX5SVzoQCVlk//262
         GjQNnCzisysoh3HYBLpj31V/SB8AxnFimlgljVr8eTCo9F6DK3XBQtWvQkskIZH+lANt
         pJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821279; x=1762426079;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ewytxFQKWEPP8ksVLrFNMpG0Im51NlWWKRtb1uDOsQ=;
        b=pt/Q6uw5HVF94TriXTruTeTL7yBbADjZ5VbAHdmOzNkgyvOSRAmox6VsWvCiAftFfM
         wu6amqndvykLFqkrr3k1WTkN2hZvJIBO5yTUoTmoR8SNjhk0ulorGsHSKZ41IrnBgUKP
         2DgT7/owsKTLmwKge9YdTNjsXh+3b1XDMSWWVE7syXe5glgqgmnkTvczTFYTu4jaJL6l
         iDNeKgH4ADhfcyekns5mceQ0tOWEQr6z9EVd/jUOBpoJ2svIyDwc4PlsTpou2wA/YJr1
         lxbHzFudtVLQw9042tuMj+GTssNaRAiIdpuZwtx7cX6Kkq5rOQhX6ur1Tdf+DByghY07
         V2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmjkDnDc6qNEep0H/JSRowDlrnzKRBvn9yxa/j06U8oSY6Kx/cvaEeLxJjBarAaPCaOpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBr02YpcoPd8jPm4dY6SkRqU/KzGh4mxpMoDa+dmp/RQKchl2q
	bS30+8hHkLV4ynlN0553O0n4ie9o19rtAk7Qc0MuVdr78NeEdEJevdYTkInAvF4476Xslp91uJa
	XkALZzxuHbrSVN49oFyVp6QwaY2eiJdo=
X-Gm-Gg: ASbGncs1K05gk2u4qeArrHUhjIqCWnTG1z+iN0RvyixqX3Sfwm+r0mSNJkbzBzsZClz
	r7oQi7BpWzJyrIBFNBY9B5cdv959pp3JWDnXc8wWTRcaDmhlhJsGjOq5oW1aF3y2ncNuxT3KEtl
	kjlQyyZHqsOYuL8oomVisll/1wacckcREjclWuQ4aSLeWLR7sz+pRS5QEmq4DY61Mum0fSIJfbw
	nloERj5rx5M79Sylg7O9v1W2BiHJnlrR40c9P90UDwgYKqtQhE/+vkwKZtlZkw/8daI5XUNMfJT
	6HasxVHMauMbj9nY1g==
X-Google-Smtp-Source: AGHT+IGwMelwYxmpNRuXjlbV6Bn8MAFDdUmiAPpvIbrVgA2uHBHqdazaw4wlBrxiCUlG7EglfzBKlza1rFMZKGlHo2Y=
X-Received: by 2002:a05:6102:3fab:b0:5d5:f766:75f1 with SMTP id
 ada2fe7eead31-5db90601534mr2254193137.11.1761821279139; Thu, 30 Oct 2025
 03:47:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 03:47:58 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 03:47:58 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-5-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im> <20251024-b4-pks-odb-loose-backend-v1-5-1a4202273c38@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Oct 2025 03:47:58 -0700
X-Gm-Features: AWmQ_bnsps3_M40BsWbYnoQ3H4b8W81p3HnEdLtLbZVSMzsheFL5BSmjGsn_agw
Message-ID: <CAOLa=ZQdit7N0aQWyqYHAoO6nuXaU3QqZbQmsbp52jW8C-zbzA@mail.gmail.com>
Subject: Re: [PATCH 05/13] object-file: introduce `struct odb_loose_source`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000080512006425dfb32"

--00000000000080512006425dfb32
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Currently, all state that relates to loose objects is held directly by
> the `struct odb_source`. Introduce a new `struct odb_loose_source` to
> hold the state instead so that it is entirely self-contained.
>

I wonder if the naming should instead be `struct obd_source_loose` that
way other backends (if added) would be something like:

    struct obd_source_loose
    struct obd_source_postgres
    struct obd_source_mongo

This is easier to read and also for autocompletion it leads nicely into
the 'obd_source_...' namespace.

The patch looks good.

[snip]

--00000000000080512006425dfb32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ac7374ded92cf92d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rRFFsd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMTgrQy8wZHloWUVyQ0Z2cGdlVjJacmoyQzVlL0FiUApmWW5hdmFFSkQ4
Mm5IeDVoR091Uy8zcG94TUVMN3BXSm5nQWpwSmRxZ01pM1Y4cVgxazZZUXdzclpkZE9mUWxzCnQz
RkZhOHpBZHJoNTdxcG1rUG5WZTB0d1FGdzA3a25oK3hhNDNrNnh4dDFSZGdvUmFwd1pOYm9xNkdh
N0FRK1IKS2Z3a2pzUUkvY0szakdkYTVhZDJlODAvWGwySVJHb05IWGMvdi9la3g0WmZiZ2lnQWRn
bWpENGxXVk1OYzJaSwpOQWlKcGVvUTZqRTYxdVlHbjhKR0I5dHBjclFZNm5uVTZwWGlFTzdaYlQ3
VS9YVXJSS1EyY00xRzZVUW16K0VwCmJTVUpBZlB6L1piNHR5SmZPMUt0em5Qdk9JT1RvUkZ1OGZ1
SkNBQTNZbGxxNFg3VUVheDlDYmRxbjRYa1VlbXAKbjV5dU82b3BINmhrN1drdFI2dHNrMjVoNVVa
OFpRbkNhZW84YWF4L3lwS3BrTjNTdi9UQjl2MkFRaFQyNjdHagpnZ244Zlp3WTZrWkFsUmtoRlJU
U2Myajh2SlBZeHJwNDE5dTRVcUN1eWtmQzB3b1lLbHFsM1BPVjlpV0IwdDd3CmNZR3dDOHJ3QUxa
N1BoL3VUanZFTE1ZQUN0SS8zdXlHMmcveFFaTT0KPXU0bGcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000080512006425dfb32--
