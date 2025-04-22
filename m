Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A623909F
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306894; cv=none; b=RjKUABg4qBQHrwMlRNfIbuplzYl/5zfM8AeAGha70WN8gnrdvrdzYjAiZfGzbU3WYnTZ3KCy8X+eZjBzKUyApmNpllvY0UdDowZsxASVd9F5kJ/eZEScQKEazHsKKe1pdENlqd5CJSKPEzPaxx+mGnkovmQ0kCDd4cA7xEeaypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306894; c=relaxed/simple;
	bh=aOTEAk5qbaCOQU9ipVJoN+zHv/C0QJpZYnl+RRWWeKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qit6uhRA33A9JEGJJ35yiQAlIf3UpMqEx5jt4C2QXE69fa5978IdEF+9cnrOLmv0diwUec4ysGdFos5Oo+Spd2Qt1ptKPXQ+w7/oGd2r1fcLuzBgOv2QU4rMoEYnmaTF8bfS5SUjjGmlAChSfkDudFDFWgLjWU47soDKjkk5PHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMneI681; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMneI681"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so671278966b.0
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745306891; x=1745911691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zddVSyfEhfIEnQO/Nmb5w7GAm/ITfcmoAoLqvHpRdyI=;
        b=PMneI681P88g7WQM+BsDAcT/Za4D4sj5urRzpD7xwgdKeCvnt2Q5DmnWzavXBU3SmL
         qTlGY9v9YKph4/k6Ky9ia/I3eALJKkaB+8amO2TtbXyczaVUdg0y5qhRD3AEpf/EERhQ
         Q2Bv33pnSuF6k5nC4GJegDHw1EY039hZcbu6GiMVIMrSdgUmLu1dng82k89GByGh98sd
         W4dnovoeBjwqSkn9w4LiCCaOyydIep7SffpLIBVuKws0nKO41fSokaq0xkrm3Kxfq024
         qqAalOqbrQ9bYGil48bVqliuOx3XqLfRARiZewGH73fpvAF4QNZ/5ceOnrqAo9nYwH7D
         PMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745306891; x=1745911691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zddVSyfEhfIEnQO/Nmb5w7GAm/ITfcmoAoLqvHpRdyI=;
        b=o+bKfsp11iuZ+DEpEcA238Y5Nyo1TS1TJTNs7bT1lcLdvFr4K+JrjKR/nPWHX6c+2c
         H29GaSZb0sDntG0IOTX5ZMxFF0JAkfurRUwClYj9wcgIo5pSyGROQCfWk6BaSXzTKS1z
         R51NFDkka5GC5OMKbg/AdGJqDY1EZcuSKStgDaVMH4yeXvaKeSyqvTGJXt9j0mo+uDHe
         19+eGcZZywhUMHCS/WQsWH3zsdBbGfPpZqJUfq3Xxeby4ZBFytWG+7EA4qEFKGYh6Go4
         MzdD7csvHyv8bJFXIbz/JUCjOBPj4T8v3csddDYJ6DZrDWtaqIry9/CDIVYMTDWusie9
         NEUA==
X-Gm-Message-State: AOJu0YwPKzVel2kHCiQ/9Y83Bj0rbcj8LjuP54yJ6rjtiisapKYVE6pW
	I88qRc1h3g5ieNydxl5X20AW8Vy/UOOtr+eYnpTt1HEw/pyISA++gf7Trx2hc2rEMd+lNDZ+BEV
	lx4GdHILZ2OcBIcbw1oGsxYSAzWU=
X-Gm-Gg: ASbGnct5okNoH9yVfvAvTFASkChcshjI966y97uiJh15RGiQMgUUgOdocWmJJ1zY0oB
	zC3MaDehoLpfrtjttQH2CPTgxpF0pWl1OGNsFGsXgxcTGoR1WdjZvT/JmoUI9m+XDsfGJeLatH9
	sJxsz46qj78fdQDIP6tNzB15VbSsB7/I5tgmlnF/nj1M0/v8XPzikCTw==
X-Google-Smtp-Source: AGHT+IF08GBsRzvU37wE298Bi8kpWPA66hdFQKsUGpE241akkHxf4ERS9FcwYkZ7EgpflW73W+iY9ENH9IYRyHCjUko=
X-Received: by 2002:a17:907:3fa1:b0:abf:6f87:c720 with SMTP id
 a640c23a62f3a-acb74b505e8mr1065542166b.29.1745306890349; Tue, 22 Apr 2025
 00:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im> <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
In-Reply-To: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 22 Apr 2025 09:27:57 +0200
X-Gm-Features: ATxdqUGGwByo3TP1KnWH4Nypjj89Sjpq-ISYSPSrmhkERZaNcrQ58PVwiBdIVz8
Message-ID: <CAP8UFD3Nr_f7WSzjv4AEKzH9Kpsf6soOd+VSO9ng=-ZSws6P3g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] meson: wire up support for benchmarks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 8:50=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> this small patch series implements support for running our benchmarks in
> "t/perf" via Meson. The series does not aim to replace "t/perf/run",
> which is more fully-featured and allows running benchmarks against
> multiple different trees. Instead, this series only allows running the
> benchmarks against the current tree. Users are thus expected to continue
> using "t/perf/run" for more advanced usecases.
>
> Changes in v2:
>   - Adapt "aggregate.perl" to use a "/usr/bin/env perl" shebang.
>   - Link to v1: https://lore.kernel.org/r/20250331-pks-meson-benchmarks-v=
1-0-b2ace85616a3@pks.im
>
> Changes in v3:
>   - Document how to run benchmarks in "meson.build".
>   - Expand the message for the commit that enables out-of-tree
>     benchmarking.
>   - Link to v2: https://lore.kernel.org/r/20250414-pks-meson-benchmarks-v=
2-0-04377080a167@pks.im

In https://lore.kernel.org/git/CAP8UFD2jKwYzmc40knXY7k+FQabjZbGTqs9fowF=3D-=
0OqfNYp_w@mail.gmail.com/
I wrote:

"I wonder what happens when we run `meson test -C build --benchmark`
but 'time' is not found."

because I wasn't sure if it would just do nothing in that case which
might not be very user friendly.

Otherwise it looks like my concerns have been addressed.

Thanks.
