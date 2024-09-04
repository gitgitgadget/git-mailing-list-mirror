Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3F1E871
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460379; cv=none; b=PuYxEWhdprKmItjGKslwAkO5fyMnp4s1jYE2nFnm8SZvJetExoFnfdEMtBbyG26fWu79snE8laOY6fZr4GKninsfIZYOnpezY0OG3oqeZTlq18hdj0qODd+D6iNBTvICccyPZfLeONoHtR2dpBdmv5P6oeggLX7fs9Z0IUMN0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460379; c=relaxed/simple;
	bh=CMpniGEqsI6G3kE7WyD+Zh07nZ0cXrq/SJa25FOi/h4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UZQ3O9lulwKb/LLTXK5rQSmVLu/wCWDI/Zyw0NHMOG5AfzQerIDc2jts+jrBJI6PKs+fm796IFsFRPdm9JUes+dKSI/33pvH9o0UO2ima4YGsMcqE2fl3iJSizVFr7RoWyvAKKXq5Dih2o+ji2iQDibQQuw8hgHDQ1tHHCMVW+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm+w2MrL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm+w2MrL"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c26852aff1so3172868a12.3
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725460376; x=1726065176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TS1i/tnzV086ml2nf0SXxOtXzSjeU3y507HJbn5DwCI=;
        b=hm+w2MrL/ML72A2kuocLqq8IjOL4PTXMhsmiG/8kJ/eRKpbClkX2lFnXVcFiXUTlMQ
         kSwaQ9ybFW0xiMIgQw0uc1z2LuuYha2mlum7emkZg0u4EmC1b6K3mpDDCqsq+SHizqLB
         zc7AuZnKICO2LrOqvFWKb1uX+ai2IaW9SRucUtcP55mIXkapt4jdKCcRAe2CS+Kqohcs
         LPqbR2Z3JK6jR9xvH+TDDiRe6nWLv9jKNSc8o3EhUxlevmqKnket8vzhkB54Q5nRQU3B
         KYqBq4KJPKbMzyS203/LMiujMS/qnVblj5b2qi83XezYVXzE4HQmeoch4tPj4fJLr0je
         6FyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460376; x=1726065176;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TS1i/tnzV086ml2nf0SXxOtXzSjeU3y507HJbn5DwCI=;
        b=QhArN/ovzuztAhGCwf9XCVqFleSMGZ674VM6QqXtk/wehyO8doFNGZZm7oWb8tLmwd
         RtA0EnHkX9qa3ll5QG/VQFwx0Vt9LDkLtP6P+7qGOz5qZxS35PPCPoXyH8/0rc+lB4YI
         mYXeO7HxJwtoNlzP7LB9flw5aCaOPcAg0eu9OndAWZPJXcIzZIzXRjSYv8Ra34HmILjy
         GDCR/S6e4EmgVVfhrhyHPCOu0s4Df8k9RC4mtOnXpcrwCjk6+kyjtQvxa5/E7+2tIo2x
         b7K6vH+8RCuixFAbb2WnxV+S2r13sQLObK9ka5KKRDRrWvgPzx04i8zgTPJzMEbnMzKR
         vvgg==
X-Forwarded-Encrypted: i=1; AJvYcCXcwvA4nVzdZn3kYa1N3EtwI80peP2e54KOHNhD+Bm7Yc6hoxY/GQjJzh3xU3hKq1NOE0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnloykhWWfd6HS/D42vqIB5TfD2d62ODIE1c0H8z4/UCBKLgiZ
	SuGUKqnq32WlNMwV6HKMxHJwANSwtS6jaEYvvWMzCQ7+cgobcSd6
X-Google-Smtp-Source: AGHT+IHhCmM62JT9GQ7tIY+4byHDldKw5xlS4r34tlYQDFyyvAQU/BMVCN/6y0gzUcyBq3xzfwlN8g==
X-Received: by 2002:a05:6402:3512:b0:5c2:6e51:9d11 with SMTP id 4fb4d7f45d1cf-5c26e519e9amr3160481a12.27.1725460375362;
        Wed, 04 Sep 2024 07:32:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccff4bsm7735116a12.70.2024.09.04.07.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 07:32:55 -0700 (PDT)
Message-ID: <d5b1c95b-cbdc-4711-849e-c2cfc67787ee@gmail.com>
Date: Wed, 4 Sep 2024 15:32:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 00/14] Introduce clar testing framework
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1722415748.git.ps@pks.im> <cover.1725459142.git.ps@pks.im>
Content-Language: en-US
In-Reply-To: <cover.1725459142.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 04/09/2024 15:16, Patrick Steinhardt wrote:
> 
> Changes compared to v7:
> 
>    - Properly wire up the "--immediate" flag.
> 
>    - Give a hint for the syntax to run only specific suites or tests for
>      the "--run" and "--exclude" options.

As far as I'm concerned this version looks ready to be merged to next

Thanks

Phillip

> Thanks!
> 
> Patrick
> 
> Johannes Schindelin (4):
>    clar: avoid compile error with mingw-w64
>    clar(win32): avoid compile error due to unused `fs_copy()`
>    clar: stop including `shellapi.h` unnecessarily
>    clar: add CMake support
> 
> Patrick Steinhardt (10):
>    t: do not pass GIT_TEST_OPTS to unit tests with prove
>    t: import the clar unit testing framework
>    t/clar: fix compatibility with NonStop
>    Makefile: fix sparse dependency on GENERATED_H
>    Makefile: make hdr-check depend on generated headers
>    Makefile: do not use sparse on third-party sources
>    Makefile: wire up the clar unit testing framework
>    t/unit-tests: implement test driver
>    t/unit-tests: convert strvec tests to use clar
>    t/unit-tests: convert ctype tests to use clar
> 
>   .gitignore                                 |   1 +
>   Documentation/technical/unit-tests.txt     |   2 +
>   Makefile                                   |  53 +-
>   contrib/buildsystems/CMakeLists.txt        |  53 ++
>   t/Makefile                                 |   4 +-
>   t/run-test.sh                              |   2 +-
>   t/unit-tests/.gitignore                    |   2 +
>   t/unit-tests/clar-generate.awk             |  50 ++
>   t/unit-tests/clar/.github/workflows/ci.yml |  23 +
>   t/unit-tests/clar/COPYING                  |  15 +
>   t/unit-tests/clar/README.md                | 329 ++++++++
>   t/unit-tests/clar/clar.c                   | 842 +++++++++++++++++++++
>   t/unit-tests/clar/clar.h                   | 173 +++++
>   t/unit-tests/clar/clar/fixtures.h          |  50 ++
>   t/unit-tests/clar/clar/fs.h                | 524 +++++++++++++
>   t/unit-tests/clar/clar/print.h             | 211 ++++++
>   t/unit-tests/clar/clar/sandbox.h           | 159 ++++
>   t/unit-tests/clar/clar/summary.h           | 143 ++++
>   t/unit-tests/clar/generate.py              | 266 +++++++
>   t/unit-tests/clar/test/.gitignore          |   4 +
>   t/unit-tests/clar/test/Makefile            |  39 +
>   t/unit-tests/clar/test/clar_test.h         |  16 +
>   t/unit-tests/clar/test/main.c              |  40 +
>   t/unit-tests/clar/test/main.c.sample       |  27 +
>   t/unit-tests/clar/test/resources/test/file |   1 +
>   t/unit-tests/clar/test/sample.c            |  84 ++
>   t/unit-tests/{t-ctype.c => ctype.c}        |  71 +-
>   t/unit-tests/strvec.c                      | 241 ++++++
>   t/unit-tests/t-strvec.c                    | 211 ------
>   t/unit-tests/unit-test.c                   |  47 ++
>   t/unit-tests/unit-test.h                   |  10 +
>   31 files changed, 3459 insertions(+), 234 deletions(-)
>   create mode 100644 t/unit-tests/clar-generate.awk
>   create mode 100644 t/unit-tests/clar/.github/workflows/ci.yml
>   create mode 100644 t/unit-tests/clar/COPYING
>   create mode 100644 t/unit-tests/clar/README.md
>   create mode 100644 t/unit-tests/clar/clar.c
>   create mode 100644 t/unit-tests/clar/clar.h
>   create mode 100644 t/unit-tests/clar/clar/fixtures.h
>   create mode 100644 t/unit-tests/clar/clar/fs.h
>   create mode 100644 t/unit-tests/clar/clar/print.h
>   create mode 100644 t/unit-tests/clar/clar/sandbox.h
>   create mode 100644 t/unit-tests/clar/clar/summary.h
>   create mode 100755 t/unit-tests/clar/generate.py
>   create mode 100644 t/unit-tests/clar/test/.gitignore
>   create mode 100644 t/unit-tests/clar/test/Makefile
>   create mode 100644 t/unit-tests/clar/test/clar_test.h
>   create mode 100644 t/unit-tests/clar/test/main.c
>   create mode 100644 t/unit-tests/clar/test/main.c.sample
>   create mode 100644 t/unit-tests/clar/test/resources/test/file
>   create mode 100644 t/unit-tests/clar/test/sample.c
>   rename t/unit-tests/{t-ctype.c => ctype.c} (68%)
>   create mode 100644 t/unit-tests/strvec.c
>   delete mode 100644 t/unit-tests/t-strvec.c
>   create mode 100644 t/unit-tests/unit-test.c
>   create mode 100644 t/unit-tests/unit-test.h
> 
> Range-diff against v7:
>   1:  b67f10ec0b0 =  1:  b67f10ec0b0 t: do not pass GIT_TEST_OPTS to unit tests with prove
>   2:  55a9b46e65f =  2:  55a9b46e65f t: import the clar unit testing framework
>   3:  f24401f0a87 =  3:  f24401f0a87 t/clar: fix compatibility with NonStop
>   4:  658a601c541 =  4:  658a601c541 clar: avoid compile error with mingw-w64
>   5:  0b8a6ac5fed =  5:  0b8a6ac5fed clar(win32): avoid compile error due to unused `fs_copy()`
>   6:  c50e7a0ea68 =  6:  c50e7a0ea68 clar: stop including `shellapi.h` unnecessarily
>   7:  b8f3f16dd27 =  7:  b8f3f16dd27 Makefile: fix sparse dependency on GENERATED_H
>   8:  3d3fe443b9a =  8:  3d3fe443b9a Makefile: make hdr-check depend on generated headers
>   9:  7d0f494850a =  9:  7d0f494850a Makefile: do not use sparse on third-party sources
> 10:  9c74c5ae019 = 10:  9c74c5ae019 Makefile: wire up the clar unit testing framework
> 11:  8bd5b3e2b29 ! 11:  81d932bfa33 t/unit-tests: implement test driver
>      @@ t/unit-tests/unit-test.c
>       +	struct string_list exclude_args = STRING_LIST_INIT_NODUP;
>       +	int immediate = 0;
>       +	struct option options[] = {
>      -+		OPT_BOOL('i', "--immediate", &immediate,
>      ++		OPT_BOOL('i', "immediate", &immediate,
>       +			 N_("immediately exit upon the first failed test")),
>      -+		OPT_STRING_LIST('r', "run", &run_args, N_("name"),
>      -+				N_("run only test suite or individual test <name>")),
>      -+		OPT_STRING_LIST('x', "exclude", &exclude_args, N_("name"),
>      -+				N_("exclude test suite <name>")),
>      ++		OPT_STRING_LIST('r', "run", &run_args, N_("suite[::test]"),
>      ++				N_("run only test suite or individual test <suite[::test]>")),
>      ++		OPT_STRING_LIST('x', "exclude", &exclude_args, N_("suite"),
>      ++				N_("exclude test suite <suite>")),
>       +		OPT_END(),
>       +	};
>       +	struct strvec args = STRVEC_INIT;
>      @@ t/unit-tests/unit-test.c
>       +
>       +	strvec_push(&args, argv[0]);
>       +	strvec_push(&args, "-t");
>      ++	if (immediate)
>      ++		strvec_push(&args, "-Q");
>       +	for (size_t i = 0; i < run_args.nr; i++)
>       +		strvec_pushf(&args, "-s%s", run_args.items[i].string);
>       +	for (size_t i = 0; i < exclude_args.nr; i++)
> 12:  3c3b9eacdfb = 12:  604303e31aa t/unit-tests: convert strvec tests to use clar
> 13:  c8360db2f86 = 13:  ba05b9f1eef t/unit-tests: convert ctype tests to use clar
> 14:  d51c146cd9d = 14:  8441d29daa8 clar: add CMake support
