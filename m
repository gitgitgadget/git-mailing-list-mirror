Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCBD2110
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745143224; cv=none; b=rFkf+PdllaEUczAm09dOUp6RW55X8teFeb7fTtRaWsjpvVYmINLfA3vVQTKXL9OQxz5DksQI02W8wDF/JgP2USPs0T0Ez516mfXf3q7kyLPeIfqkwaqFUDRsQ8XVW6oAL2i/fAfhzu6sXOlU1S2O1RTjPzaECOsW7uDbvRIQno4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745143224; c=relaxed/simple;
	bh=mJwSmtGxxR5wMt00MPCLWtqxLWmxqrV7C8N6G9l8WsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNZleZvJkJSZYL1p7XCKffOpn8clmQJB6Ok7vLBz6bt+/uyK+T7/W5Ldnp81KpywrO12TyHDE2mA7+524RM6fv6Ufm6yv11n1G5bK8PZswA1wU1LrttmBH7V+JizyUPN8qGVnBO0BP1UvluK4lfTYPOSi6R35sC5cMQDWcm2Xd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4J0SyP6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4J0SyP6"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acb415dd8faso492331166b.2
        for <git@vger.kernel.org>; Sun, 20 Apr 2025 03:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745143221; x=1745748021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql6aP8oSi8Lvi8/nJINenQ2qgAaBplhJmIh4ysxQagc=;
        b=Y4J0SyP6EVMBOP7Bjm7TAV8yHIVRP0lILS7K1S7P7oQZ42LYqPKr9V02GYzNHWMTGs
         Sx8weeXaqLPZn3oodr+R8sj3pLFuvR05SJBnspipNl6Rv/e7B12M9+Ao9GBh0YJmU7jn
         pyRnm4KwIlp0X4hLGJV0pnnLKyqPfyFZW06WhZJ/ps9eHiyEa3uijRK/mtIqWsOgY17C
         r30pc1Qj4m5bTc8dZlZcUDyYy+tk+h0cDnlGe6w79vNEuYMO1PUwM6THbtU5msPj4F5G
         yX3deQZEA8avk+m+M53bfoOryCUr7cwFnIY4BQQ6rXu1/dapk0fbPpTIt6j7sddmdDCY
         cy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745143221; x=1745748021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ql6aP8oSi8Lvi8/nJINenQ2qgAaBplhJmIh4ysxQagc=;
        b=XiGi1yhJqRc6ZqiSjB+DWhnFd3r6y1I944EBddSC+ys/RMMo5JasfJ4cryfdsm8w6J
         MiG4baLftJFGhLUQdABMHJ+HVmmiUuTe/cmXGpzrSBvna3n5Tsu6Vwa3HNJWJEDsSg69
         yPN5vLH5KEirqK2xzoBCpOOjKKWnuYBeoTNbLfXAx5yXUnacEj/m2aAIpzkc4kXySJ8D
         vENtUBq3YgCaNoqlV+BRjdSkj64FtIUYXhRfzA8YtmTxicU7EGPbvKzuKKAIb3CUudKG
         Nk8ZA8h7x7XpurQycc1oP97WDUQjt0ejjzp6c2munCd72v27GVR2GZDw0CyhmfYXwL1u
         JrYw==
X-Gm-Message-State: AOJu0YyV60a89CLlabCasjjiIzjmdASbPD7QiiTrqGUAXi1RQL8ZMZVI
	wCVcQRqruTluBKTrrEgsG7omjjLsfD9Yq6HZc9x/ka0SGIfc3EbCnJfG1tYTS2D9B9c29/pG4/O
	mIEJty8aQUAWPbaOHc/aITo1dMlcE+g==
X-Gm-Gg: ASbGncvT4Ie+woYfhvQtochjIVmK+8R9BfspUQCIWwHq4odxS2fc2s8BpY2kQMYTc+X
	8JUK5bAO7vot+Zp+G9luFK9zQok1M3668NVK1oKIHt8tngkaRkhU9xspO2ee1JX5fVCsHjsyNHk
	0K7tZ6lawtOogEw/6egYZIOHjzIkjHFeFnCEB86BaUqX+r+590Z6droQ==
X-Google-Smtp-Source: AGHT+IGG9yM71+IzBUIUlkpFWzhm3AICW5oGalHjcOgKrPM66Dlj4UePCtLVcyGkCiiUX/0TF8lNVX+EKVMEO+jbeIs=
X-Received: by 2002:a17:906:4fd5:b0:ac2:a42a:999b with SMTP id
 a640c23a62f3a-acb74dd4b10mr682061766b.52.1745143220745; Sun, 20 Apr 2025
 03:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im> <20250414-pks-meson-benchmarks-v2-3-04377080a167@pks.im>
In-Reply-To: <20250414-pks-meson-benchmarks-v2-3-04377080a167@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 20 Apr 2025 12:00:08 +0200
X-Gm-Features: ATxdqUGIWAyvDsrLGfGaIWuw1noL-p8wEb-VWbT0x-5EyXTCp4MfBLEvzZn8Zxc
Message-ID: <CAP8UFD3HcAVs351sabU2qd70PmMzTtGbS7P7eKYyDyUQZ4nQ2Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] t/perf: fix benchmarks with out-of-tree builds
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 8:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -25,7 +25,29 @@ TEST_OUTPUT_DIRECTORY=3D$(pwd)
>  TEST_NO_CREATE_REPO=3Dt
>  TEST_NO_MALLOC_CHECK=3Dt
>
> -. ../test-lib.sh
> +# While test-lib.sh computes the build directory for us, we also have to=
 do the
> +# same thing in order to locate the script via GIT-BUILD-OPTIONS in the =
first
> +# place.
> +GIT_BUILD_DIR=3D"${GIT_BUILD_DIR:-$TEST_DIRECTORY/..}"

Right now on 'master' there is:

GIT_BUILD_DIR=3D"${GIT_BUILD_DIR:-${TEST_DIRECTORY%/t}}"
if test "$TEST_DIRECTORY" =3D "$GIT_BUILD_DIR"
then
       echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?"=
 >&2
       exit 1
fi

so it's not exactly the same thing, even if it still probably works well.

Future readers might wonder if this discrepancy results from changes
that were made to only one of the files or if we really wanted to get
rid of the "/t" check here. In case we do want to get rid of the "/t"
check, I think it might be worth saying it clearly in the comment.

> +if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
> +then
> +       GIT_BUILD_DIR=3D"$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
> +       # On Windows, we must convert Windows paths lest they contain a c=
olon
> +       case "$(uname -s)" in
> +       *MINGW*)
> +               GIT_BUILD_DIR=3D"$(cygpath -au "$GIT_BUILD_DIR")"
> +               ;;
> +       esac
> +fi
> +
> +if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> +then
> +       echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).=
'

Maybe something like the following could help debug this:

       echo >&2 "error: GIT-BUILD-OPTIONS file missing from '$GIT_BUILD_DIR=
'"
       echo >&2 'error: (has Git been built?).'

> +       exit 1
> +fi
