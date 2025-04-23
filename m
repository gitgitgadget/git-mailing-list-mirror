Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD4E13B797
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428821; cv=none; b=oJq5lwdYsmhA1z1TVVYlA6VOyMlLy34Wxv4qEZbtkgrMIqWYlVtE7qQadKZw1MyZ20+mkS+7pjQh9CxLk9njwZLmTG5UYQTCzemgE6DlHagN4n09HyKdUcl6fufrdWc9UumNt3BdUyd4Yx0H2+6/otnOvr+pyzucDqL/tfOMdpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428821; c=relaxed/simple;
	bh=AVQnpgLSoSEvMNMv1W1aux30FksW1N2hCgpGQ2POapU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=nhgI5/b4JMgKDx867ALrinpJT/P9oSVDdkNjVajcafv/NPgjusNs/QZ2TbCy1HNEqb8ZI9jlPkDESJrtIxCgjEACFxQW/B7axjhlzMXREgbSuKfFHMGFT6sLhhCSXLVFrhQf+I5c2KdzYaHgLmS2NRDW+2V0kMTdqnehNwSiszA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlUvH/7/; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlUvH/7/"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-523ffbe0dbcso81067e0c.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745428819; x=1746033619; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJ+Bfkl/njVgRrZ426nmD61X8l0tZnXi/4N8EiGMo2w=;
        b=FlUvH/7/8Mqw2Nhb0e/oB4AIwdkmZZb+LmyrLLT8ZsP7Q5AmR+5dELZDMIhqHOr0Pf
         23yN+vZd/z1FzNb0ADkYmY/ppAb2VwfOonjOSeUVko12f3IjT07f3QpsUsTJ2TM9KK7R
         E2+bMMeOdV07vRJ5iJ7zqmii3/gnAxBa4nYm6B5xVrLzght0WnOQJ4j/GyoLIhcnDDzm
         f1NqXJFvUtzvwolSAozjMpoQhK4hCS57qc8BgFLkA1SVaKUBZdqVVBUi9YCtlElVamJP
         1icbYFb5qfcb4k0/3nbGkkcVQptAlzrEFfFNCpUrWnuF+lPUdGROxArlCTDNU+soUfML
         7Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428819; x=1746033619;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJ+Bfkl/njVgRrZ426nmD61X8l0tZnXi/4N8EiGMo2w=;
        b=XYzeKVJGnvlIGjFzWlkqKCpEB11Epa+2cCrc/TD4p0cWwlp0nw5AlrZ10NweqUGlTj
         Dqxsf5rp2Xnf3mUMTSnQm34U0szoXkR8X5BSvPJUQ+Ksnv+t7DEZ7wHpo+P24ANjYp5G
         ifrWL1oY5rrVLpB6ggonIZKeIdz8poQ5Ahj91KxE1WQGKZrhoSXaUHYFAbePqmfIhc/A
         ji2cLVRN01tA1KcSdkwinq3Dn75Z/O313/sj9wctb/4ZeXa0ChSS6KEriknG4XKvbXM0
         du7ifYjOF5qCQElP0I0+LPOWYokzyjjLyTmmkX9abTKCuynu648GEFXHa7CCLoEWIxO/
         0+8A==
X-Forwarded-Encrypted: i=1; AJvYcCWHzwlyteBWXCIWzk1uAZeFD1Eo/e7rizv/QcPfdzofzro1LM4ASytzvh96VMUvS7mPOos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUwmKv64tSdBHbNhHqtDc8DgdmRJ2sY2lLU1mdBy6+/w48/D+k
	2MRa6JzVAZJ5Ud8nqAaIuyA8mgKAEI1m9FpA8c0lmnzERpQG0oFxbLZMlnTAO7ychmtx1xsdIBA
	gLs+HDxJouWggDLvktf3CW8bkwPnY2bK7
X-Gm-Gg: ASbGncsF4HEUgBZ0WokEUjYrJebga6+nfYEtF9b9Kk9rlO+bRgS1Exrpsn6kvqblFlo
	r9xAUnuFAh3BBs+E8gZEYqsKwR0z9Dz3jbALVPYAsGKWi3c183l1Dqzai4H1vrsrubXcD8plvfT
	5JMIOSUZJus3r727xB69A8/4Zel3rUISK5gTq7Dp7QIn6lMJT9S7NmRhQw
X-Google-Smtp-Source: AGHT+IHqWLO7qrKEwpOxOs+OpjfGBH9mgVXtWh+Nq24WEShjO42iJnt3/atyfo9022ANn3cYLes0hg20JTWHgw+2Wnw=
X-Received: by 2002:a05:6122:3d0c:b0:520:63e6:79d1 with SMTP id
 71dfb90a1353d-52a76b89884mr120132e0c.10.1745428818866; Wed, 23 Apr 2025
 10:20:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:20:18 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:20:18 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 10:20:18 -0700
X-Gm-Features: ATxdqUFCMNchiiJJVgi7ObpJpHoK5oqAtrXBpyERJrw7yzCSQKY9E9Ezn7XTA50
Message-ID: <CAOLa=ZQ45v33yj2bUNrN6ZJYawR2KVyjHAtsY0RZ58fkhkTbSw@mail.gmail.com>
Subject: Re: [PATCH 00/13] object-store: a handful of cleanups
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000bad468063375505f"

--000000000000bad468063375505f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series contains a handful of cleanups to the object store
> subsystem:
>
>   - A couple of definitions are moved out of "object-store.h" as they
>     belong to other subsystems.
>
>   - Some functions are dropped and/or renamed.
>
>   - The biggest part is the removal of `repo_has_object_file()`. This
>     function and its `_with_flags()` variant are marked as deprecated,
>     with the replacement being `has_object()`. The benefit of that
>     function is that it doesn't reload packfiles and doesn't fetch
>     promisor objects by default so that it becomes more explicit when
>     one really wants to do so.
>
> These cleanups are in preparation for getting rid of `the_repository` in
> "object-store.c".
>

Apart from the few nits I mentioned, the series looks great! I must say
the split of commits was really nice to go through :)

[snip]

--000000000000bad468063375505f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f26580f4be6d3f26_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSklWQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODZ0Qy8wV0pZdWVKclBWT052V28yRms5VVZqY3FKeQoraTJVQ3FBdXpw
cFNKRFU5ZFJrWFkwRXpnL3QwZHU1OVlkd0Y4dExIQXhpcVYweWM5aVJwTTNEZWNVWjRlVk92Cnkv
dnozVUJVSGZ0SVVRTEd2cU5BZW1hTzZvVkFkN0NUS0VCRFpLUzA0M1RlVWlGRUR0TXFYaUt4MjNy
alRXNkoKK3RyNFdQcnZZUjBxT3NOK1piRFlpbERvcjBtVlRCaFdwZzEvR216T2hqQ2YrVTRHTU9J
MzhVaEdKK2xva2RuWgpQMDZwVUFOSjN5ZGlHQ1p0MTZ2eXFucTlueXVMSi9kZHdLTkJ2bWd3b3Mw
eUFnS0VVMEp3OTdpUnovdDBHZXY3CnBqcVJLa1dLTlZ2eGJhZ0plV0NuNEhGNThsSVlxa1BONlp1
aFZZYnJaVGNTT0orTnA2eDJ4eDNSYm5Ybm9sY2cKZEdSY29BQ2xLdUtRbVRhZlBHQi9xeVdEbFp2
NHI5QTRkVUQwQ1RRRDBFTFJOZ0tWL3lTQko3Mk15VmVWcGZPSQp3Yk1scnlMU2lXd2ZnZDdwQWxR
RWNmUVpTalRKZElWa3M1QWVxODFXcVBsMW5ka2FRRHlHQlFTNXlqa1llVU9YClh6djN3YmQzTUhC
L3ZlYXZJeGptS0xia0F6VnJPQXpFMVFHSEFsaz0KPUhyZFcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bad468063375505f--
