Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B900117BBF
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748828055; cv=none; b=UUvKQHliSUBgctXgJ2rRU+HxgUzpZYAvVj0vcxbYFVWKvs8EzewCn8g5fAOW8/GOb6P0Q09oQPaZeahRJTO9M9+7sYjtD3dmODC6S0NmJB1Wfx32r4a7SmgLNZppe3u4ZCZKZJryd4qpWkhPluzcD0ZglNrbBMTZks/otvUA1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748828055; c=relaxed/simple;
	bh=9hL/pshnQHTf9haq1u6gvNXbHCB46Kh6HAxUKrAXihg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=riB2Eqp8YYdds2xASxgT/e2UVLRfy3nFxwtxiExSC9XHP5+ThanjRdd5wEA0ovRksgcXOdv2FYXkvl8Z0oeqRFBMhXClyfPKNpTWiIgaQaIFS+v32nFUCpBX42XKqtmxTnCYXHSOO1TtI06dwbkuucBHX7NjjSXcCMKkTx9IHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNALoPn2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNALoPn2"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2351227b098so25093555ad.2
        for <git@vger.kernel.org>; Sun, 01 Jun 2025 18:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748828053; x=1749432853; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWJ0+kI/XOFagJpavnOablYoRzTcq/mCDmLZ/3ljWzY=;
        b=MNALoPn2hkEZ7A/JcL4DsdV7+UFldH8WBeFlGUTYmnoPe5kdPUjN0iXbFivB3HBRp8
         Ry0TNgMOD2JjaWzwTSl16Da6ZBOXDkbvfYgA+q8lBoLBD0AacClr98VZry3lrQJhx1uo
         JAHgd/BWf7fZvg9N8T9nZQ/ejAbr4+l8ekC9iZg6SwslnBrryJuv7FjepIqZpdc3TdlN
         P2Lehiqp9p3vuEYdVHmF0JRLqgtFR9ryQjmneTEmHxUFY5GixWTjEjsJH34LoBLjb0Bu
         6hA7WBWuU+llN8YhYqFuQFbYuP10AhFLPOLS59/BZQxsNODyWJiMh1J+KE3tYgNMW1G2
         2Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748828053; x=1749432853;
        h=mime-version:user-agent:message-id:date:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWJ0+kI/XOFagJpavnOablYoRzTcq/mCDmLZ/3ljWzY=;
        b=JpZtBJNgcKBpMe1ZMJ2CBCI4wGKfbqVkm7fuKcVUfv6pXCh1JP7mN44qGW6us2ztlh
         +VxxQuuTOIjfohUV8vVvPigwqpBhxTUtgujUIbmHXQ1hBPeluZ3gKgygfr0OKqSNE4/R
         ycYoUwxIps9okUJrdqeK6GrkrnPgMMMTg4YSRcXTfgBNdYhGHMml5PSaZZRa5lBINtMS
         /W8CYq1eeCDK8Q5EMepJu0RZBBoAbjl5KijvltMCQmaELpEdoFp44EpauPZcayqVWnI+
         xtXaxFaP8kRdASY/+eOgwsdcPK40GCUywHVVL/UzrJnGAb8fuT5MXbX6qRzcxFiMuWvJ
         cNNw==
X-Forwarded-Encrypted: i=1; AJvYcCX0w+Mt4su89flwF8kNTswECtUc974I3Blm2uzko1my6JwlnQuJ+AWytNppUGry/Kv4wgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQuT3VOo0dbfRKUkhPdw2CBIZVW3cTIKo4pInVAQNWISH8s66l
	mYDUN/EGYpWv6islD4BQq4ksI1YSm674YKsKqq8TMEaxP0gKHAIIMVoMP926GQ==
X-Gm-Gg: ASbGncuLlwlifXhzll8VGpyzZvoZK7kH3aLYkKvLEdzZmmfreWc6J21g5029sG//bX8
	+Fdge1gccTpWs7ggNjtZRQTsYNXpITM48kHElOO6k8Kqhhn0/Bz3TXIJQZhx94wbLZrR+MCZ4eW
	u09XAHEyWxOr4tNilCXdliXs8Towq9Ez3LbFXvk6hHzipn8+XLtzY69zdZENjq/M96aA7P2SfWp
	TIY+OElUrdEATDYMWzuaNas/yx5zKoJO4xVzM0GKdM0l9oW4jpDMqoi6QYmENPcbKZadiUEfAwh
	sqaeTvMhXkhn7SPj9bzk6dxSRv8cedki
X-Google-Smtp-Source: AGHT+IF/05Fwj478AQtTCBvfDNohSJarGGRblziqrby96Pt4V7gohpTh9jFTOsNGnyauyRJSQDWRlg==
X-Received: by 2002:a17:902:d4c2:b0:234:cc7c:d2e8 with SMTP id d9443c01a7336-2355f78016fmr97761935ad.37.1748828052748;
        Sun, 01 Jun 2025 18:34:12 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::eef5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd34edsm60494315ad.126.2025.06.01.18.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 18:34:12 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Brad Smith <brad@comstyle.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/gc: correct physical memory detection for
 OpenBSD / NetBSD
Date: Sun, 01 Jun 2025 18:34:11 -0700
Message-ID: <87h60z6i5o.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Brad,

You wrote:

> OpenBSD / NetBSD use HW_PHYSMEM64 to detect the amount of physical
> memory in a system. HW_PHYSMEM will not provide the correct amount
> on a system with >=4GB of memory.
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
> builtin/gc.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

I confirm this patch is correct.

Reviewed-by: Collin Funk <collin.funk1@gmail.com>

I also used the following test program:

------------------------------------------------------------------------
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/sysctl.h>
#define ARRAY_SIZE(array) (sizeof array / sizeof *array)
int
main (void)
{
  {
    unsigned int physmem;
    size_t len = sizeof physmem;
    static int mib[2] = { CTL_HW, HW_PHYSMEM };
    if (!(sysctl (mib, ARRAY_SIZE (mib), &physmem, &len, NULL, 0) == 0
          && len == sizeof (physmem)))
      abort ();
    printf ("HW_PHYSMEM: %jd\n", (intmax_t) physmem);
  }
  {
    int64_t physmem;
    size_t len = sizeof physmem;
    static int mib[2] = { CTL_HW, HW_PHYSMEM64 };
    if (!(sysctl (mib, ARRAY_SIZE (mib), &physmem, &len, NULL, 0) == 0
          && len == sizeof (physmem)))
      abort ();
    printf ("HW_PHYSMEM64: %jd\n", (intmax_t) physmem);
  }
  return 0;
}
------------------------------------------------------------------------

On NetBSD 10.0:

    $ ./a.out
    HW_PHYSMEM: 4294967295
    HW_PHYSMEM64: 17153662976

OpenBSD 7.6:

    $ ./a.out
    HW_PHYSMEM: 4286128128
    HW_PHYSMEM64: 17171030016

Thanks for the fix.

Collin
