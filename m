Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BB513A417
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142737; cv=none; b=ZyZaoOxafpunHU3FMClhnUYOOcPlblLDIzDADCv7M5vDBRCdR2CIcSlM7VbGirD3aU0ae6VzeSzDoX/oWS2z0KyVqexQsJ2Aiu+aCpLsRp/pUkln3CtpBGgij3aVoIYktsXZqSF/Hwnod6X00a20vACMSCAUu/oFVoFvKpGO2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142737; c=relaxed/simple;
	bh=nLW9lcOn7fLMmWe8REy5U7NV0ZSJCYA4jCnAje2yU3w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQ4/3sV1F495ZWUp5ZXvvSpxCwQ7ERRFu9fVkUZfqxQ9MLUr5N2Yk/gSrDdDwETgEAGB0igtCoN7tkKVLCD6ThRovkUYz61gYCWy1tkw9DKioP6kqEdrs/84N7YUvKk9TbbcHPaTqQtAspn6uKYEb1ebh8D5nOzBsPTS/HweQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1q5C9c4; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1q5C9c4"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22a353217c3so3706606fac.1
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712142735; x=1712747535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=53zsoCeZ0ikdQpetuUO2minf7lPg4iweZf1Wep6UmkA=;
        b=M1q5C9c4w+UzwFdQz2/Z9RWdNjmDWW+gO2pOqRlIcQXaoPvPOeOsOK4+m3/RaudHpB
         J7cvB35eCkjncyQPvtrx4NP0QW+0QDtonZQ+nsmtPbMOYKIeAPsf5NZjv+gJuOrkRszm
         zdmZilpcJeBcTxu+BNsJMXbVes8Y90KEShHaC7CYXz4IhJfitrmHoV2oLihcQ8C+paeb
         XIvHgig109X1vsxqpK7f2MydgS+gh3JKdU+JWlKLSm1jnVPUR7DGC2Yq5/ZTrf3BP0G9
         lccA/Am9bt7d6AiCLiE5hDW/QOCJkrqR1vu6ilkADBUo7lR6KDQ41gi/PRp19dRCAKkx
         9KIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712142735; x=1712747535;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53zsoCeZ0ikdQpetuUO2minf7lPg4iweZf1Wep6UmkA=;
        b=noFDtN3ZpSaOAgoJEfnsaiO0mNtP9C4EmQw1fTsSCyFc0NKQUOmgZ1RcnE27/hgnJJ
         HCWXwD3T+7VnE9u7Oku1qDIqr18+sek71joMzrjak/6In6B3S7iH4zLMJlKwbiGw0Zr1
         dei4xLmICBE9/7Va0rW8k5QgShlL6qWIvn1meSkJCH9QrBeRuPpcMzA20FBysX3V3HpW
         fRoUO8EHCV2i2S2w91Fg8HlRZceJtqtHhR2wOu/EQi0vCjgYXP8S0o+UxlEaPzz8AS1s
         ctGoSJAWYeCxo4IGiWeYUXwJWPhiOCa2Xp8rzmjchbUi2Ul6xilAL4+u6SORYyGI8IGx
         OgGg==
X-Forwarded-Encrypted: i=1; AJvYcCWkMSrgxWI+7N0aqs8LvRMIoCmrWYlbK2X76g8apalH6cVBYIYqyZV3WBdPNfIBxZs8H2DGzqKW6WPs/JckGr7Cx5qW
X-Gm-Message-State: AOJu0YxG1aNx4hsh1GcxCbIbOZuZpe1cyugSeYXvDw740T3yEK3e4W9F
	jws/INTMsVO5ln5QofMLKxRDXH9TBMt8/zzbNXgEbh6mWVHvmTQphhnyEu56zOxOcb6G2Vv9lxZ
	IJCSEy5xQIZ6J8e2BvD9bv0ZXKwg=
X-Google-Smtp-Source: AGHT+IHdxPekRGo0Em5EeXs0toqPL3gtT8kE+Pb3+vezkCyzbKvgoDif+TXBo019pp5XqigOyPLG6/1MHeBWeaYU4ls=
X-Received: by 2002:a05:6871:80c9:b0:22a:2876:833f with SMTP id
 sm9-20020a05687180c900b0022a2876833fmr16098916oab.53.1712142735411; Wed, 03
 Apr 2024 04:12:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Apr 2024 04:12:14 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
References: <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com> <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Apr 2024 04:12:14 -0700
Message-ID: <CAOLa=ZR0odWdoVBDTN+0j5d4f=s1z5zGcTNK+2tBgDX7RjXX2Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] reftable/stack: use geometric table compaction
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008ca3af06152f4bbe"

--0000000000008ca3af06152f4bbe
Content-Type: text/plain; charset="UTF-8"

Hello,

"Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> Hello again,
>
> This is the fourth version my patch series that refactors the reftable
> compaction strategy to instead follow a geometric sequence. Changes compared
> to v3:
>
>  * Changed env name from GIT_TEST_REFTABLE_NO_AUTOCOMPACTION to
>    GIT_TEST_REFTABLE_AUTOCOMPACTION and set the default to false. This
>    should hopefully be a bit more intuitive since it avoids the double
>    negative.
>  * Updated the corresponding env var test in t0610-reftable-basics.sh to
>    assert on the number of tables added and be overall less fragile.
>  * Folded lines that were too long.
>  * Updated some comments in stack.c to more accurately explain that table
>    segment end is exclusive.
>  * Dropped reftable/stack: make segment end inclusive commit to keep segment
>    end exclusive and better follow expectations.
>
> Thanks for taking a look!
>
> -Justin
>

Just a note that this doesn't merge nicely with nice because of
conflicts with a2f711ade0c4816a59155d72559cbc4759cd4699.

--0000000000008ca3af06152f4bbe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fb8decf6e12a26e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZTk9Zd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meTg0Qy85Y25UNi9mYkxkK2xmdDladGFjWCs0SCtyYgo0Um1WaEFwamVH
WktDMlJ4WmN3V0lFSTlsajl3Z3JNaFJzems5UVNJTHNHNG5PMGtKZFlJQTNKc2tud1FOVWJUCklR
Q3A4TTBuNnJINFZOVGRZWVRUUEp4Rmp6c2srcERyeElKSDZUU2w1a3JxU296ai9LNkFqRXVreDBp
YlNwYVQKbklwcHgveHVPQy9CQU9TUTJKTlNvN1NoZ0UwcWduSmIwelNzd3hLMGprQ1NQQzAwbWh5
bDFvbEo4ZHJ6c25wUApLT01ETmZsS1FYa29LYzBIOUZ6ZGM3cE1GdHh5S3hoblh3UWVnemtIZk1R
Sm4za00wa2FvRS9vTWxmZkNFemF4ClpDYXhlZDA5Q0Z6eWgvd0dXQ3dNNkxHbzZGa3lyVWsySll0
ZUZiOGk2YndrZmY4ekNPUnpSWHRaTjdwNGkrSGgKejRzQ0kyVitJQlVER1RzVjZZaTVLR0V3N1R4
T0JWeldyWFlZRTkvdmRQOTRLdWVVdXNJMkdoUUJSejkzRWRiNApWeGlvQ3IwbUhUQ2J6c1cxS1NO
eFNIVEltTlliMUMvV0RiTUd0WmJkbFpOV2hSN2dVT1RkYmNIQUJuMlk2NHRpClVsT3FsSjFkY0ZI
SnQ3TkdYbmpJOFg3em5YeXRQQ2hlUlFTbXUzbz0KPUtiUGIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008ca3af06152f4bbe--
