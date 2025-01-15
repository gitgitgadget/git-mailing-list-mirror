Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085FC33DB
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736957875; cv=none; b=lmAAVcimSTUQeudF8ubM+4nepwCGRn6Yyk1YLzk6/GnNAcIKdpgZI7YQPkGFLudys/kJn8f0DYVNNEE1k9xhf/n4Q58FtK1xRGusdgHTfaEiQ+Y5WFowb8lrfB8nUIDZtLQUwtT5z5s1fKzkKSqBsd60tvVJ6zzIsVXjyzi3r0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736957875; c=relaxed/simple;
	bh=12h9j70NANXJbdROKIroANKxIoGJ8oUzKrzUGyJjBZs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkWIbYT9i+lJjXexJGpsPXsBrqlyoC4m2ivtRiToBQg5qzv8G07gVoB10HFvrflQRHHyIDhxsuHmtoM5SjI0CxRHEEnXFHkz3wpQmtRhlb0rkTcwE4oDj8UW6XjzIfotwbBygzrU0Z4LYmaDvdip5wpuaEPRin/KOTfoEUDZ4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/0zPPB3; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/0zPPB3"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-518a861612eso574473e0c.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 08:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736957873; x=1737562673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=12h9j70NANXJbdROKIroANKxIoGJ8oUzKrzUGyJjBZs=;
        b=T/0zPPB3GmyOzWiAeOe+u/jlpZ8y/vV/LiZTdFDx5+zPTBAPveduplyxrl3L+gR8j0
         mZ5Z+uYHfKbCiyCvIeqviBTjxkJl3H0QCUA4vtQfn1gEjEqE1RaX0JMsl2Kmbf2EPLK2
         C6ufABq+QEE4ciDJKB0V9mudZ8TMab/ktQS3PM/t8OEHv4ti1gSSEzUUNoMxaMyNXH3M
         iYnSBglmSYUNsu+vDOT2Zw7qe2XSpNG5Cj4v4UX0mKRWPOzzv0JwYLGw2xk059W7PKLX
         0l0Ls4HuMUFV0H3D3wBg5NpNUvtq+/VIV36DNlx6ZSBqkYTIx9z9P4tLRAAExHiij4pm
         CH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736957873; x=1737562673;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12h9j70NANXJbdROKIroANKxIoGJ8oUzKrzUGyJjBZs=;
        b=MdkA57ew4yRWYeyq1kb5XbDmuRcQXO1w47xN3NViLWvQE6e010ZvemYFnmRJDG1Gyt
         i2Iq2JkC392wPXlhc75OvZDjto1I8hutLZtMMCMlJA28DP4D0+YZHIx7cDqyZ4FhFXEa
         9HiMDiyNC3hXkag8/LaYmcdImBOctcndgJFX4Yma2wlFBUMGOzRkV+0ePccXTREVM8I8
         FF9Uu8h+iUM40D1BEkQRbS5Fy/YPmiqkgJOeRz83wjqO3erdntWznP7ytwV+IwuIEAUy
         8FwMFItlSz6tuxovxMNZQuM3rSYlsapbHi0LG8lBGIzTcUNm5AsNaaI3iO51p0AQ40Ch
         0TeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiCh9hKf+xyzI+xWn7SQgglIQvUcOi/QOemD3jmB2jgC0MAugdsGzkeLKjtdqo47HMIMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuZyLT09KMFOazJ7kivspjvGhMhaltHI34UIbxuBFKY4+NU+Pd
	jFWipPE6S0PiRR/bZzI+C/BDioIuSdEmvtNkHPi/4DFE8yzTLwLYhSHvtqrsWMO3PTFqTI3YvsS
	ToEBGGJHuZu3IwsjmSjPZGI59g1s=
X-Gm-Gg: ASbGnctRQOT5uKRBMYtgz3Gqy8fyQqyTgia4sc1AfdiyaULaoH6fbsJfcKjcRACWfn1
	i0B8Z1hB7u32AIMqD9p0tL93LVfqJxXfrpnmiAtw=
X-Google-Smtp-Source: AGHT+IE7xhrl3msXV/85ovpzt0vnUYrGOuT2eHX5K8i3u87rlwxM3zDQT70Xw07TGMJhpeO4dCBD3O0zej7OENN//g0=
X-Received: by 2002:a05:6122:918:b0:516:dc0f:c925 with SMTP id
 71dfb90a1353d-51cd983a309mr2751502e0c.6.1736957872854; Wed, 15 Jan 2025
 08:17:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jan 2025 16:17:52 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-7-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im> <20250114-b4-pks-compat-drop-uncompress2-v2-7-614a2158e34e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jan 2025 16:17:52 +0000
X-Gm-Features: AbW1kvZoMuvrq0OAUN818KykFqOSNVbjsGFUydehAQsIncC6djQa36-QxoMh2DU
Message-ID: <CAOLa=ZSGr6y8TE=OcyE_Rzc2sA4LLN6oC3nApsGLXsThkBea4Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] git-zlib: cast away potential constness of
 `next_in` pointer
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="000000000000008112062bc105f9"

--000000000000008112062bc105f9
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `struct git_zstream::next_in` variable points to the input data that

s/that//

> and is used in combination with `struct z_stream::next_in`. While that
> latter field is not marked as a constant in zlib, it is marked as such
> in zlib-ng. This causes a couple of compiler errors when we try to
> assign these fields to one another due to mismatching constness.
>
> Fix the issue by casting away the potential constness of `next_in`.

[snip]

--000000000000008112062bc105f9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3443ace0069f8235_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lSDM2MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMS92Qy9rQmJESHVhckx2b21neVdNWlZtMmhEZ3o5ZwpHZEpCWjFwaGJo
dUtqUDliS0c0UmVDVVVFSXlxRExsVElNWlpPUGI3NldCbWxoUDdSR0VkVWRwOWpFYWtKbE5XClNo
aUZ6N1EwVkw3LzdHZmtzVW1NUEdjektEYmtycFpnUGRPMDdON09MNnh3d1Y4MlQwOEVZK3VwTUFK
djBTSGgKWEJxUUg1WjJUUHZMYUVJeGlTNjFJT2QySWt5R1JpR3ZZZ3NxV256S04xYm5yRFhpZEtz
RDV5cjBNaTJONzFWZQowY29vbnNMNDBJTzVtQVRkb3p0NUV0VUdTaDNHZmlVTTFOVENWdFU3U2Mr
VERjYkpLcGVwLzZkUnA3QWVLNU41Cm82aXBNdlBiMGdPbzcyT2RMV0pmMUNEZzg1WGx5bXRBeVRM
VDFVNHNlMFR1R3FzZG9SK21tcThySGMxazh5V20KWFJjWERhOFRNVnBHVnlnY21oeWdUL1NDUFFE
UHc4ZXZEOEZTVHcxNkowL0ZLcG1Dc3BPQlFybDR1QUUvSEh0ZgpxL0lVM3hjdjhtRW5wblRUMHI3
VWpUKzZ0YWlMWVBMWklkK2czRldDRUNiUXEvQnZpWFB1QnJ5U0l4bzVFZ3QvCmRLUFFZeTVXbDlM
N2duclErb2ZleHZsSVV4ZVprZG4rZ2N2bmJxUT0KPTdZSFIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000008112062bc105f9--
