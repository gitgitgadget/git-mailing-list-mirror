Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E87580D
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041239; cv=none; b=RQCW3gw0qbgYn6I8SzFo2CsP/g0YrOJh1/cdlTTUCvr+msqETnB3NZAXrQaR+6uRxEtBKQ5HG5BoEfrlvwJ2XmYwRykZLXdMKocI0+2EM4s5zwi31nOQVYzVHVJT43C0w7Sswx7nU7r2KLc0lBy3mx85hgbd9WKKvi5XY/7hApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041239; c=relaxed/simple;
	bh=OFZyxHoHg2T2x+SF2gxheYowZ7Fw9XkZCa/fOGstu+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJAKQb2eRVBB6zn6UogBLM74PA2yakATbTdYdX0prJWPbrsg2ax9kz7oD8dAQYpgwlZCtmwhUUP11qhCRE2BPurmTdZq2g0bT9VIDzjgp8Bcw9Y/BYBsedg7G07oECvo+dpv8hGFKQzjJbUGnyBTgf4r8iC3krehwuiiTTo7y7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpWQhqMv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpWQhqMv"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so213369566b.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723041236; x=1723646036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGlNBXBMtek47yOHOu+Yv0rTsXCsCleYogxNyrDBTms=;
        b=MpWQhqMvU31/fM06LqQZFqzNBsBI5g4XBg6Isxcn4z1/Enjl+91nKoNOpBpewF9D5B
         Jb3rl1OIVY3SNBGiBtDKsvA3m90t/s7aUFBbyqs72jlyWWpFVFzPgE3R7x+3cZeyAT/4
         CIutOcG5ZbER5v9hGsxIBxkmg/xkYrrnqJGFxdjJOyrC2dib/10bTkZIWGxQA/DpohNA
         cX3tMXwX5t7QB8KdFBw44V/0WZAakfqJb8t44vCOLyUShGSD3FQqz0Z6dvyWtTclVwXj
         gX7WRdrClTrNS59Sqrx+Xt3Jk8LK36YayBgUgBkctNvk7qv6MgtPrJd1nkz/R8OIOc3L
         mMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041236; x=1723646036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGlNBXBMtek47yOHOu+Yv0rTsXCsCleYogxNyrDBTms=;
        b=N1UoaseuFhfnokupAXH9ngcQ2J/shCMmVfiXpWLzfkgyk8IBwrF85fObG+DwUIp5+C
         zrPjHNrIg679a6ppPESuPmX/eUoSK1GSgZpgcLir32394SYVQ+CiQFDD72q/a4o2eyG5
         qP+OiX6BQfJ68YRPO2dx+0j4dhlHm8x7T2+imD5Vd0xjQPxS9koh2IotrJxljt4pDhxY
         A1DfENzBkVk0vRPiaofDkrYZrLA+/9/uBqW4NHPG5+Lx57oBfedXLmB5vpvt3grq05DL
         q2gFEE/RM2hsU99zos5HCQjIy5sQeUpH7e+cd6xef4rupubTYYT2pkLuli6YQRtMm3IL
         6Dyg==
X-Gm-Message-State: AOJu0YwiHD80mkDnCDpFTaGWr/y4c9K4eGHjXD74FhtMi+b1+DoEcqIR
	8MspPF/GlcMaUxLpnV9aZsxbl5SmPqzPPnUh7wFxJFPJab9FJC9PGMJlqP+SlBPpG4HGBsjpq+9
	iSx7RX+lrDbn2awpVPRetcXUEPpY=
X-Google-Smtp-Source: AGHT+IEGv2rW59KLUq+8+m7DqAX+HEA/6pP2qV9UcBcpYXFR8d5yPYsDRc1POY8rMj1/TFBjHPt3NJ6iqm3SrSqDCeQ=
X-Received: by 2002:a17:907:94cb:b0:a7a:9ece:ea5f with SMTP id
 a640c23a62f3a-a7dc4fbac55mr1380560966b.41.1723041235622; Wed, 07 Aug 2024
 07:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730115101.188100-1-author@example.com> <20240803133517.73308-2-shyamthakkar001@gmail.com>
In-Reply-To: <20240803133517.73308-2-shyamthakkar001@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 7 Aug 2024 16:33:43 +0200
Message-ID: <CAP8UFD3VwiAbGvzgi14EcEQLX6Gs7pNy+dvZcXkPOueKpJS7HA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5] t: port helper/test-hashmap.c to unit-tests/t-hashmap.c
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 3:35=E2=80=AFPM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> helper/test-hashmap.c along with t0011-hashmap.sh test the hashmap.h
> library. Migrate them to the unit testing framework for better
> debugging, runtime performance and concise code.
>
> Along with the migration, make 'add' tests from the shell script order
> agnostic in unit tests, since they iterate over entries with the same
> keys and we do not guarantee the order. This was already done for the
> 'iterate' tests[1].
>
> The helper/test-hashmap.c is still not removed because it contains a
> performance test meant to be run by the user directly (not used in
> t/perf). And it makes sense for such a utility to be a helper.
>
> [1]: e1e7a77141 (t: sort output of hashmap iteration, 2019-07-30)
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Helped-by: Josh Steadmon <steadmon@google.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> Changes in v5:
> - modify one of the inputs and queries inside t_get() to better check
>   ignore-case scenario. This should address the comments from
>   Christian in v4.

Yes, the only comment I had about the patch itself is addressed. There
were also comments about the email author, but that is fixed too.

> Range-diff against v4:

Nit (not worth a reroll): the range-diff usually goes before the
actual patch in the section starting with a line containing only 3
dashes

> 1:  04022c4cb9 ! 1:  49cb2db9c8 t: port helper/test-hashmap.c to unit-tes=
ts/t-hashmap.c
>     @@ t/unit-tests/t-hashmap.c (new)
>      +  const char *key_val[][2] =3D { { "key1", "value1" },
>      +                               { "key2", "value2" },
>      +                               { "fooBarFrotz", "value3" },
>     -+                               { ignore_case ? "TeNor" : "tenor",
>     -+                                 ignore_case ? "value4" : "value5" =
} };
>     ++                               { ignore_case ? "key4" : "foobarfrot=
z",
>     ++                                 "value4" } };
>      +  const char *query[][2] =3D {
>      +          { ignore_case ? "Key1" : "key1", "value1" },
>      +          { ignore_case ? "keY2" : "key2", "value2" },
>      +          { ignore_case ? "FOObarFrotz" : "fooBarFrotz", "value3" }=
,
>     -+          { ignore_case ? "TENOR" : "tenor",
>     -+            ignore_case ? "value4" : "value5" }
>     ++          { ignore_case ? "FOObarFrotz" : "foobarfrotz",
>     ++            ignore_case ? "value3" : "value4" }
>      +  };

Yeah, the above are the changes I suggested.

With this all the suggestions made by others and me have been taken
into account and this patch should be good to go.

Thanks.
