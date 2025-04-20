Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC82110
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745143241; cv=none; b=JolaMstmEvaPy4+79JafZZZbf+E3Be4UJYH5SI8nF8PW3GA7K/PePPsW+47jDaiSV38wb6dIvcmbcvqFZ3TCP06/1vFp9UL9GU0owLXeNG7zSvzTgB0z2GfT2ZBkjL5zWBGQYLjGgu3pI34Yq+kvNRaoOMxfonDlx/aB6XuCNDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745143241; c=relaxed/simple;
	bh=Io5rAIJ4ajJyoZK3mkMoWVy/4QHhx9Mo542ZMMyoA9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmZKT1s8eS6n5Q79dvFNf5/lL7ARdqJbHc8/Lv4jTXEEKg3Gmsp17ZLoulLR2WRugqs0zRqM33QmkuhJZVJ3ahNlBbYn8EGcO8SWP6k8UVFgNScbIk4t+RTEhQstfYqUpMpPWzSZwcCtSih1CKm4tB+nJU7EHoAkLvU8t+ariIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTH4/7Bm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTH4/7Bm"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abbb12bea54so477300466b.0
        for <git@vger.kernel.org>; Sun, 20 Apr 2025 03:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745143237; x=1745748037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9xcWSM/59T18EZwycAxQQiGSL1RXMkTnAXk5R3UAC0=;
        b=PTH4/7BmT8t+wG1/Et9upBjLdKCcNDyQ1e55k3UMnF32vYOGb8YInKPCBl3+gCgy3D
         Ae9eQ+1PH9rrW3N7F6SQeomjLaYFNuZVFERjnLeDBil2UT3brxvsayH8RUe+K+55J7Tm
         C59UGr8MrNHVLBVGtivOAGQopEmUargkrv1cORzQjcLNqt88i+Kuu6qkmwQox85W/6xp
         1BQyJ7hCzOCn/ujfpHvWQN64r6S8jZFttMjBvfnRE/cqcs5xPG/xfKpvS5WApod2qKy6
         Q4jJx3C4eANSc++V21s7BEPtH6qocBI0xtRlKi75KzLlYdo8jb5NESg8Kzlx3tIwgeGN
         c+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745143237; x=1745748037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9xcWSM/59T18EZwycAxQQiGSL1RXMkTnAXk5R3UAC0=;
        b=stl+C1s8XECxzVPDJynrjs7Rxbs+6tK+D5JbW5MbIclD5lcqIvTxucsFL6r9tczK+z
         fKxtOww8Qpdaz88a2rM0KZdJAykJNYeQN7nhgXVzKvONJiD3QeBpF2FsdjaL6eshoM9v
         SebqR+AQlNFocBe+GZo0VTJ/HQZ9kZ1umu8P1zBvQVkE66xFNG94Apk7TP4qbfzAbEhI
         hMyRFpUnYxuUdrxz1ke2nUReFcUMfpHIeRkAzAtz/GGSMVYbKDMKtnbZouTMQnFc4dsO
         2yHTDx4gtldiRao8qjR4JnGGs75LUwhCkj4LaYo7fPvjjEYyj4hPK4daFn513rq5h93v
         PG6g==
X-Gm-Message-State: AOJu0YyfPUxesOca0i6z91JjQS4GtOHr2mmaYXBYLexHZBH+wIyKctTC
	+PiCG6qE4ZOwoPMzqrhRbBRbX8t9AKQ+mTpH3zkx40lrBFnsEu7OZ9YU7Tt/3f8PlSmOa1C5Jny
	vAiZv+wI6k/zQu1AQRMO03zaYGKQ+5A==
X-Gm-Gg: ASbGnctVj81ks5ns+ifT3QFzdxY9tfg7+tBfHoWxCkZaCO7Q9F79isGnI3aw/DWP7ei
	SdlqYMuYYQR6zbUDYt6Ji+p2gxhRAUigpOV/iItdQUF0/r7jBar5m2qT8ylj9EDo7wHlOutZuEw
	GEWXGcPBilMZYLwnMMUBWZffII115k4myoVUODZEMnve3XO8PyUtAjHyVIUCUbh3BD
X-Google-Smtp-Source: AGHT+IE3d0azuzAINC8X8CMmPKthQ5HspCAcviXOwAseCZXpVUav/EIY4WVwnqUv/rha1XbEKJTONdXvwm9kO6jpfCw=
X-Received: by 2002:a17:907:868f:b0:acb:893:8c40 with SMTP id
 a640c23a62f3a-acb74b388edmr854745166b.19.1745143237364; Sun, 20 Apr 2025
 03:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im> <20250414-pks-meson-benchmarks-v2-4-04377080a167@pks.im>
In-Reply-To: <20250414-pks-meson-benchmarks-v2-4-04377080a167@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 20 Apr 2025 12:00:25 +0200
X-Gm-Features: ATxdqUEOwBxJpTLBTm0Zm2kiZcArB691gRegcVM6aHPJFVrPPIkjQWYUkkghYD4
Message-ID: <CAP8UFD2jKwYzmc40knXY7k+FQabjZbGTqs9fowF=-0OqfNYp_w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] meson: wire up benchmarks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 8:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Wire up benchmarks in Meson. The setup is mostly the same as how we wire
> up our tests. The only difference is that benchmarks get wired up via
> the `benchmark()` option instead of via `test()`, which gives them a bit
> of special treatment:
>
>   - Benchmarks never run in parallel.
>
>   - Benchmarks aren't run by default when tests are executed.
>
>   - Meson does not inject the `MALLOC_PERTURB` environment variable.
>
> Using benchmarks is quite simple:
>
>     ```
>     $ meson setup build
>     # Run all benchmarks.
>     $ meson test -C build --benchmark
>     # Run a specific benchmark.
>     $ meson test -C build --benchmark p0000-*
>     ```

Instead of just here, I would have expected that something like this
would appear towards the top of the top level meson.build file, maybe
in a "Benchmarking" section, where there is the rest of the meson
documentation for Git.

> Other than that the usual command line arguments accepted when running
> tests are also accepted when running benchmarks.
>
> Note that the benchmarking target is somewhat limited because it will
> only run benchmarks for the current build. Other usecases, like running
> benchmarks against multiple different versions of Git, are not currently
> supported. Users should continue to use "t/perf/run" for those usecases.

s/usecases/use cases/

> The script should get extended at one point in time to support Meson,
> but this is outside of the scope of this series.

Fair enough.

> +if time.found()
> +  benchmark_environment =3D test_environment
> +  benchmark_environment.set('GTIME', time.full_path())
> +
> +  foreach benchmark : benchmarks
> +    benchmark(fs.stem(benchmark), shell,
> +      args: [
> +        fs.name(benchmark),
> +      ],
> +      workdir: meson.current_source_dir() / 'perf',
> +      env: benchmark_environment,
> +      depends: test_dependencies + bin_wrappers,
> +      timeout: 0,
> +    )
> +  endforeach
> +endif

I wonder what happens when we run `meson test -C build --benchmark`
but 'time' is not found.
