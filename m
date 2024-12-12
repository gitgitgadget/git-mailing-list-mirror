Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5171F20FA8A
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998281; cv=none; b=RD7rBJN91oPz5zTxIqw58maOrk3n4zC3y5EEgi2dWXIkNhms/+SXudgDVloy6rkrH6vCZHncslVp8Se3bhfsxPG6JYyAu00I+GHN/PyVexOw5DoG7Ip9RRjodPW4tOpLNW0mf+kVVxL6M8BH93AdH/b8xRBMlVoywqzLzJCxG0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998281; c=relaxed/simple;
	bh=xG35TA928OduaTYiSwBVx3tkqiIDI2Wp1Tj6CgO5RE8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUXjozNm4DbV7J0M4Z8wBNFqDhUkhov4SMabbd1wWql1WiLj8T0Nx6NyQLcT+JCIN5uk8Fw4RFn9UpxOuITZZGKgIpv6FYLXKYlU6H5HJua6D1TcgIBaJyyn8FR1uGbsyIkAzQ+tFVn4m0bGEA2RaqeZsGaTsVaLm8xgI8Mfk6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByejfSDf; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByejfSDf"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5160f1870f3so120413e0c.0
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 02:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998278; x=1734603078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kuvfXvNS+AJp85M/ZtZ8oRD+puOKaJYHY2p4mc264EI=;
        b=ByejfSDfmECkDyrLz4cX1JLdK8TMpYs8fwKNCNT4cwzyLF+1yshtxOJzIi895PqidG
         HHzQWAf19m9ayGeBnBViQptAuFxa+K3AIEGmF3Uia6gZ2tXYPvtH3ul+wP3miTiyoXSw
         Ne0fgVgkUiqbziW0Guw/nPzBXcqrjtcEe0/9YURrSQDh9xBKbd224aicKytFFb3EeVv4
         WRVP/5U9Sp33DvFRRXG3ZljdFjhKJRK4xnVrlg+cjMx9ClnSR5yzqO6ERb6iWy3fUa/T
         7f5zWRRQ6Y6hn28Eqq0JTeZdMhtlukkFMcALVmNbkt6Afrk0x0wn41EiSsp13hWuEnZf
         c8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998278; x=1734603078;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuvfXvNS+AJp85M/ZtZ8oRD+puOKaJYHY2p4mc264EI=;
        b=BAuKP8lj1RrEjYhoEd2GO5SeH25OlD9xVB+bHMLYxAWzkvY/UAt8qWkEZ0FPLa7AqP
         tdmlREQEmqc0xNsRylR7oythLQYrQgRVvru6yarxuIwqrmY+e/NwvAwy0gSww6t44mNn
         LW3cchGIlLd47Mo8ubGqImhe0zl6WYtsk8cAZ08F6l7xyIgz0ln2JrY+j2b6LG3G2rlw
         eyKmiWJDenwWjE4JNQLP8UwZ8r3IIArVRLXTN1Anq4jy41ygukVbPopCeB+DXTrYerYF
         9Ji+LSo7U8AhH8pqF8p+vgagSRZPm0goGQsVWcUznEmXhcfkX06Gnv54p7hewd3VWh2h
         C6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDZYeEUgFZpj5N4hs3iVTf3XVPi83fgPQLP8jD6Hhe60dOq5ZaNoLPtP9cHzzSuRlAYhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN77y5kI4z8CZe3EKpuYlCUk3XH44BrTfgVP7QFp+1sA/wW59m
	a3dmLVw4t8hQWpvpqGgp+BGk6F09Bnq2BlY931RZKyXEkPdfKCQi/Dngxm2h9Mf3Ll9+WG/9vVG
	Ttpqeg01Yf30FBNfjSr4E8GYbnYWDT1nn
X-Gm-Gg: ASbGncvX9QzeECzzczfhz3fQaEnQ4wUPBIMz+anz6RGFpIgoQ3i85/spfiD+3jJXOob
	9YFhdN1yZTD85IwNSvK8/iIjjXJqef5vr0aHh
X-Google-Smtp-Source: AGHT+IEUzqat0K3Xz5XOLlOKPo3GSWB4c3auieOu3JDnq9Kse417YCVDHONBnIbvisjU/C/r60jRxZvfD2amkBBzlxc=
X-Received: by 2002:a05:6102:c8f:b0:4b1:5cc6:92df with SMTP id
 ada2fe7eead31-4b2474733f5mr2915378137.0.1733998278205; Thu, 12 Dec 2024
 02:11:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Dec 2024 02:11:17 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241211-fix-bundle-create-race-v3-1-0587f6f9db1b@iotcl.com>
References: <20241211-fix-bundle-create-race-v2-1-6a18bd07edec@iotcl.com> <20241211-fix-bundle-create-race-v3-1-0587f6f9db1b@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Dec 2024 02:11:17 -0800
Message-ID: <CAOLa=ZRKZPWBV2HiVEvt5jm4SCQV_G0k9V0eoHkdnnoUsXGaUA@mail.gmail.com>
Subject: Re: [PATCH v3] bundle: remove unneeded code
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000006a083a06290fef94"

--0000000000006a083a06290fef94
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

[snip]

> Changes in v3:
> - Remove call to `false` in test that was added during debugging.
> - Link to v2: https://lore.kernel.org/r/20241211-fix-bundle-create-race-v2-1-6a18bd07edec@iotcl.com
>
> Changes in v2:
>
> - No longer user the term "bottomless bundle" and use "full bundle" and
>   "incremental bundle" instead, because they are more commonly used.
>
> - To verify the full bundle created upto tag actually contains the tag
>   object, add a test to clone from the created bundle.
>
> - Explicitly mention in the test names that annotated tags are used,
>   because it's not obvious to see the function test_commit_setvar() used
>   with option `--tag` calls git-tag(1) with `-m` which implies `-a`.
>
> - Link to v1: https://lore.kernel.org/r/20241209-fix-bundle-create-race-v1-1-e6513bdcbf8a@iotcl.com

Had a look at v2 and now v3. So they were annotated tags all along,
perfect then. Thanks for the changes, they look good to me.

[snip]

--0000000000006a083a06290fef94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 288f3feb85f9fb82_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kYXRyNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVQwQy85RHk3cjYwY0dkN2dYT29jckVYUG1LYmQ4KwpMSmgvY0F2Ynhj
VnBIQmxXa2NNdUcvWTluSVc4aWpqbGRnMXNjNlJwMyswM3IyWU92RkxGWS9tMXZnVDZMak1FCkdh
UVRyYkpmWG5pM3R2SlZqN3lMMXlEV2d0cU9YZnMzU1EzY0YvaldYYnprMlRqUm5aeElhSUxVNHJt
U1JRdTYKeDRWdGtaTWVRRHpZS1JQbE1BaHAzNERGeGlWem1iejlCR1RnNHJzUDVNZjh2UGtBb1VH
VXd1Z3pLeEdrcGhYUwpuQ21pcndxcm9YbWFkWDdDRkI0ZHlzS0Y2QUY1N0FQdER5Qlo4K0NoUWFS
YkdHNEhnM2ZablBEZkJZUmVVekZmClY3QTYwQmtVNEV2WDZBM3QxaDAxVHNFUWhXQkhoczI4UzFE
UkNwMEVDUHFLdDNWTEV2UHpaNjN3MTRiR3RnMWoKM0cwQ3RHTWtIR1FUTmhpVXBKMmF2Z2RKQkJp
ZUFkMnhpRkVsZFJ2ME40RmRYc3U4WUtMc2lOYUs1RmlaamR4OQoyN1gyUU5vV0JYZWw5V2ZvZ3dk
MTVsSDZUbmozMGdPdnQzbEF5YWNycGZrMDUyd0JYYXFHbGc2OXRTeVFtcS9BCkpIZzRqMmR3ZXNI
VDRLbWdxZS94NXM0enQ4QWFHVHo2QzhnY1E4bz0KPU5NWVEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006a083a06290fef94--
