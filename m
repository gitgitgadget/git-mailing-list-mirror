Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81881DA10D
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456941; cv=none; b=IQ9LpCLfTuaYw5nmd9c88Z/710RLr086lInrUvQK7Ne7gBRyiSOYwOUQpuLBJ5/ItRyBDLfuK0svnXTiBOUTbvyFScYx3v+6xAFncgOZRRS7/FK47x2Qe5xsP4uhoRQ04F4nFLJvz+hwsvLssm2aoHxRNq+Yn0gSLPs84CnJ5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456941; c=relaxed/simple;
	bh=+xcHtNLuGWvXXz3Y8nMvYs6PxCKI0LPC8/92gUWCVMI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lwUIM2PIyqOsSBF5Zy1nEJePUU5fDkAU9HNXyvLqE7AmLeNo3PhUQZzcknjWJ0FIf2hV5tehgTtYVCYV+Jl0TsOo/TPyjqTcM/+4/n8YVHbi4woEpSufL8B+VmpvSXeBvBvqohY9p9Ad19o5aekiCaQosixJHNW5SzNedtbIik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpPIRR4l; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpPIRR4l"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86b64ebd8aso393943466b.1
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725456936; x=1726061736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPh7b2ciCzJeyIj0JUwgvfpzndfrA41r3Xv1qCvst/Y=;
        b=HpPIRR4lRLTWHzEhPMwjvTWom3ZNl0gePMzpBx1mFaeE10IpZZ+dPMPVn7uRRiAuyj
         m8ny/VPqxI1v0NLwWZCABhL2K2m+OjvZHyICVxEe718ulBHdQkNZoFIz5O/4Xlh6IRJj
         qewG2oOqwQXySJ75bfPth5WhiTgGJGiKkeIPogoFlmduvw4YXrF9QE/1sVB9fiONwU8a
         8S/nmsuMQBTPn5FxRcfq1n1Tov4YGx7q+ogcGa942F8WUfPzPOOMQGaxsqAr3pqH2sQ9
         Mm3N7FS9lNoV1RtIBVe+GXZombR3RYcdjV14thMMy3L30VdJTO+tFXOzWmVhm8fAbpd5
         5Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456936; x=1726061736;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPh7b2ciCzJeyIj0JUwgvfpzndfrA41r3Xv1qCvst/Y=;
        b=HrkdUiFWMo0n6lBibvmNqF7dxrDAhzzSKin4z6qpvZxe8s6bUbTXi0TgmTWyVPF1IF
         vDBiST2lZ+619bNEjEoPG8TuGn6MR9xoU4YDdgs9lyOMKDFp3m8UkaPUI5pSBaCPy+rn
         jiS0WwS+3R9zLhqSZiurPu4fR1eGy+fYLTrvt7VJRKwI+L3lwN2w40+oRs8qhoUTzLp0
         e0YZJy0thQkFimvhR8AGdvxzuoQR5s5scUhJkw9dGyF08DvdQWZEDPvRPhaeewDOXnwA
         YOWeOeH8/3VBEuqbnQQf/U0b21JU3wwhJsh8zHWqr3Bv7zEJEXHKJ8RC5qJP4vEa8G+y
         mwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjZFgJMVeIvv1DP6eaYNKyfpTRZ1Du2THhsiKQWcyJi6xTB7eIC+BM2Lmo7M78iQ50ARM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyQyMlC0qQ0WS/ank00qz0NJ7O+YQ5p+qa8iq252WvDJOXgAFv
	kYYc2YQFwB9GliUjq0p0fsB5t1HE2r7dqOqFC1Ev9Og+1EFFWgBq
X-Google-Smtp-Source: AGHT+IHHNKZitm6Ra7y//U/3gVILMBsrY/LXQclEQD77jlNBLYCQJ/Tz+5e+ytPPKJjN34MNGRHrDQ==
X-Received: by 2002:a05:6402:2089:b0:5c3:cb56:e67b with SMTP id 4fb4d7f45d1cf-5c3cb56e710mr511130a12.35.1725456935237;
        Wed, 04 Sep 2024 06:35:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c2502f86ebsm4642703a12.77.2024.09.04.06.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:35:34 -0700 (PDT)
Message-ID: <b177ffce-f5cb-4df9-8b81-79128f9185d0@gmail.com>
Date: Wed, 4 Sep 2024 14:35:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 00/14] Introduce clar testing framework
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1722415748.git.ps@pks.im> <cover.1725349234.git.ps@pks.im>
Content-Language: en-US
In-Reply-To: <cover.1725349234.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 03/09/2024 10:14, Patrick Steinhardt wrote:
> Hi,
> 
> this is the seventh version fo my patch series that introduces the clar
> unit testing framework.
> 
> Changes compared to v6:
> 
>    - Add some explanations for why we introduce clar in the first place
>      to the second commit message.
> 
>    - Split out implementation of the test driver, that is the main
>      function, into a separate commit.
> 
>    - Reimplement argument parsing ourselves. This allows more flexibility
>      and gets rid of some options that do not make sense for us.
> 
>    - Add an empty line between declarations and code.
> 
>    - Improve the test messages in ctype tests to also mention our
>      expectations.
> 
>    - Adapt `cl_failf()` to not use `xstrfmt()`, but `snprintf()` with a
>      static buffer instead.

I've left some comments on patch 11 which is new. Apart from that 
range-diff looks fine to me.

Thanks for working on this

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
>   t/unit-tests/unit-test.c                   |  45 ++
>   t/unit-tests/unit-test.h                   |  10 +
>   31 files changed, 3457 insertions(+), 234 deletions(-)
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
> Range-diff against v6:
>   1:  e48a6461137 =  1:  b67f10ec0b0 t: do not pass GIT_TEST_OPTS to unit tests with prove
>   2:  1710e9f9ff7 !  2:  55a9b46e65f t: import the clar unit testing framework
>      @@ Metadata
>        ## Commit message ##
>           t: import the clar unit testing framework
>       
>      +    Our unit testing framework is a homegrown solution. While it supports
>      +    most of our needs, it is likely that the volume of unit tests will grow
>      +    quite a bit in the future such that we can exercise low-level subsystems
>      +    directly. This surfaces several shortcomings that the current solution
>      +    has:
>      +
>      +      - There is no way to run only one specific tests. While some of our
>      +        unit tests wire this up manually, others don't. In general, it
>      +        requires quite a bit of boilerplate to get this set up correctly.
>      +
>      +      - Failures do not cause a test to stop execution directly. Instead,
>      +        the test author needs to return manually whenever an assertion
>      +        fails. This is rather verbose and is not done correctly in most of
>      +        our unit tests.
>      +
>      +      - Wiring up a new testcase requires both implementing the test
>      +        function and calling it in the respective test suite's main
>      +        function, which is creating code duplication.
>      +
>      +    We can of course fix all of these issues ourselves, but that feels
>      +    rather pointless when there are already so many unit testing frameworks
>      +    out there that have those features.
>      +
>      +    We line out some requirements for any unit testing framework in
>      +    "Documentation/technical/unit-tests.txt". The "clar" unit testing
>      +    framework, which isn't listed in that table yet, ticks many of the
>      +    boxes:
>      +
>      +      - It is licensed under ISC, which is compatible.
>      +
>      +      - It is easily vendorable because it is rather tiny at around 1200
>      +        lines of code.
>      +
>      +      - It is easily hackable due to the same reason.
>      +
>      +      - It has TAP support.
>      +
>      +      - It has skippable tests.
>      +
>      +      - It preprocesses test files in order to extract test functions, which
>      +        then get wired up automatically.
>      +
>      +    While it's not perfect, the fact that clar originates from the libgit2
>      +    project means that it should be rather easy for us to collaborate with
>      +    upstream to plug any gaps.
>      +
>           Import the clar unit testing framework at commit 1516124 (Merge pull
>           request #97 from pks-t/pks-whitespace-fixes, 2024-08-15). The framework
>           will be wired up in subsequent commits.
>   3:  5c21aa87aa2 =  3:  f24401f0a87 t/clar: fix compatibility with NonStop
>   4:  06d2bce0d82 =  4:  658a601c541 clar: avoid compile error with mingw-w64
>   5:  f88b3421a09 =  5:  0b8a6ac5fed clar(win32): avoid compile error due to unused `fs_copy()`
>   6:  5fb4c55be33 =  6:  c50e7a0ea68 clar: stop including `shellapi.h` unnecessarily
>   7:  e0dcbd5ca83 =  7:  b8f3f16dd27 Makefile: fix sparse dependency on GENERATED_H
>   8:  77a03f8df70 =  8:  3d3fe443b9a Makefile: make hdr-check depend on generated headers
>   9:  c91dd7327e3 =  9:  7d0f494850a Makefile: do not use sparse on third-party sources
> 10:  115c15aa9ae ! 10:  9c74c5ae019 Makefile: wire up the clar unit testing framework
>      @@ Commit message
>           anything. Thus, it would cause a compiler error if a function name was
>           mistyped and thus not picked up by "generate.py".
>       
>      +    The test driver "unit-test.c" is an empty stub for now. It will get
>      +    implemented in the next commit.
>      +
>           Signed-off-by: Patrick Steinhardt <ps@pks.im>
>       
>        ## .gitignore ##
>      @@ t/unit-tests/unit-test.c (new)
>       @@
>       +#include "unit-test.h"
>       +
>      -+int cmd_main(int argc, const char **argv)
>      ++int cmd_main(int argc UNUSED, const char **argv UNUSED)
>       +{
>      -+	const char **argv_copy;
>      -+	int ret;
>      -+
>      -+	/* Append the "-t" flag such that the tests generate TAP output. */
>      -+	ALLOC_ARRAY(argv_copy, argc + 2);
>      -+	COPY_ARRAY(argv_copy, argv, argc);
>      -+	argv_copy[argc++] = "-t";
>      -+	argv_copy[argc] = NULL;
>      -+
>      -+	ret = clar_test(argc, (char **) argv_copy);
>      -+
>      -+	free(argv_copy);
>      -+	return ret;
>      ++	return 0;
>       +}
>       
>        ## t/unit-tests/unit-test.h (new) ##
>   -:  ----------- > 11:  8bd5b3e2b29 t/unit-tests: implement test driver
> 11:  b3b8df04872 ! 12:  3c3b9eacdfb t/unit-tests: convert strvec tests to use clar
>      @@ Commit message
>           clar-based tests looks like.
>       
>           The tests are part of the "t/unit-tests/bin/unit-tests" binary. When
>      -    running that binary, it generates TAP output:
>      +    running that binary with an injected error, it generates TAP output:
>       
>               # ./t/unit-tests/bin/unit-tests
>               TAP version 13
>      @@ Commit message
>               ok 1 - strvec::init
>               ok 2 - strvec::dynamic_init
>               ok 3 - strvec::clear
>      -        ok 4 - strvec::push
>      -        ok 5 - strvec::pushft_pushf
>      +        not ok 4 - strvec::push
>      +            ---
>      +            reason: |
>      +              String mismatch: (&vec)->v[i] != expect[i]
>      +              'foo' != 'fo' (at byte 2)
>      +            at:
>      +              file: 't/unit-tests/strvec.c'
>      +              line: 48
>      +              function: 'test_strvec__push'
>      +            ---
>      +        ok 5 - strvec::pushf
>               ok 6 - strvec::pushl
>               ok 7 - strvec::pushv
>               ok 8 - strvec::replace_at_head
>      @@ t/unit-tests/strvec.c (new)
>       +#define check_strvec(vec, ...) \
>       +	do { \
>       +		const char *expect[] = { __VA_ARGS__ }; \
>      -+		cl_assert(ARRAY_SIZE(expect) > 0); \
>      -+		cl_assert_equal_p(expect[ARRAY_SIZE(expect) - 1], NULL); \
>      -+		cl_assert_equal_i((vec)->nr, ARRAY_SIZE(expect) - 1); \
>      ++		size_t expect_len = ARRAY_SIZE(expect); \
>      ++		cl_assert(expect_len > 0); \
>      ++		cl_assert_equal_p(expect[expect_len - 1], NULL); \
>      ++		cl_assert_equal_i((vec)->nr, expect_len - 1); \
>       +		cl_assert((vec)->nr <= (vec)->alloc); \
>      -+		for (size_t i = 0; i < ARRAY_SIZE(expect); i++) \
>      ++		for (size_t i = 0; i < expect_len; i++) \
>       +			cl_assert_equal_s((vec)->v[i], expect[i]); \
>       +	} while (0)
>       +
>       +void test_strvec__init(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	cl_assert_equal_p(vec.v, empty_strvec);
>       +	cl_assert_equal_i(vec.nr, 0);
>       +	cl_assert_equal_i(vec.alloc, 0);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__dynamic_init(void)
>       +{
>       +	struct strvec vec;
>      ++
>       +	strvec_init(&vec);
>       +	cl_assert_equal_p(vec.v, empty_strvec);
>       +	cl_assert_equal_i(vec.nr, 0);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__clear(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_push(&vec, "foo");
>       +	strvec_clear(&vec);
>       +	cl_assert_equal_p(vec.v, empty_strvec);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__pushf(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_pushf(&vec, "foo: %d", 1);
>       +	check_strvec(&vec, "foo: 1", NULL);
>       +	strvec_clear(&vec);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__pushl(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>       +	check_strvec(&vec, "foo", "bar", "baz", NULL);
>       +	strvec_clear(&vec);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__replace_at_head(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>       +	strvec_replace(&vec, 0, "replaced");
>       +	check_strvec(&vec, "replaced", "bar", "baz", NULL);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__replace_in_between(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>       +	strvec_replace(&vec, 1, "replaced");
>       +	check_strvec(&vec, "foo", "replaced", "baz", NULL);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__replace_with_substring(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_pushl(&vec, "foo", NULL);
>       +	strvec_replace(&vec, 0, vec.v[0] + 1);
>       +	check_strvec(&vec, "oo", NULL);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__remove_at_head(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>       +	strvec_remove(&vec, 0);
>       +	check_strvec(&vec, "bar", "baz", NULL);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__remove_at_tail(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>       +	strvec_remove(&vec, 2);
>       +	check_strvec(&vec, "foo", "bar", NULL);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__remove_in_between(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>       +	strvec_remove(&vec, 1);
>       +	check_strvec(&vec, "foo", "baz", NULL);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__pop_empty_array(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_pop(&vec);
>       +	check_strvec(&vec, NULL);
>       +	strvec_clear(&vec);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__pop_non_empty_array(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>       +	strvec_pop(&vec);
>       +	check_strvec(&vec, "foo", "bar", NULL);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__split_empty_string(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_split(&vec, "");
>       +	check_strvec(&vec, NULL);
>       +	strvec_clear(&vec);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__split_single_item(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_split(&vec, "foo");
>       +	check_strvec(&vec, "foo", NULL);
>       +	strvec_clear(&vec);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__split_multiple_items(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_split(&vec, "foo bar baz");
>       +	check_strvec(&vec, "foo", "bar", "baz", NULL);
>       +	strvec_clear(&vec);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__split_whitespace_only(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_split(&vec, " \t\n");
>       +	check_strvec(&vec, NULL);
>       +	strvec_clear(&vec);
>      @@ t/unit-tests/strvec.c (new)
>       +void test_strvec__split_multiple_consecutive_whitespaces(void)
>       +{
>       +	struct strvec vec = STRVEC_INIT;
>      ++
>       +	strvec_split(&vec, "foo\n\t bar");
>       +	check_strvec(&vec, "foo", "bar", NULL);
>       +	strvec_clear(&vec);
> 12:  1ac2e48a7f2 ! 13:  c8360db2f86 t/unit-tests: convert ctype tests to use clar
>      @@ Commit message
>           on failure:
>       
>               # start of suite 1: ctype
>      -        ok 1 - ctype::isspace
>      -        not ok 2 - ctype::isdigit
>      +        not ok 1 - ctype::isspace
>                   ---
>                   reason: |
>                     Test failed.
>      -              0x61 is classified incorrectly
>      +              0x0d is classified incorrectly: expected 0, got 1
>                   at:
>                     file: 't/unit-tests/ctype.c'
>      -              line: 38
>      -              function: 'test_ctype__isdigit'
>      +              line: 36
>      +              function: 'test_ctype__isspace'
>                   ---
>      +        ok 2 - ctype::isdigit
>               ok 3 - ctype::isalpha
>               ok 4 - ctype::isalnum
>               ok 5 - ctype::is_glob_special
>      @@ t/unit-tests/t-ctype.c => t/unit-tests/ctype.c
>       -				test_msg("      i: 0x%02x", i); \
>       -		} \
>       -		check(!class(EOF)); \
>      --	} \
>      -+	for (int i = 0; i < 256; i++) \
>      -+		if (class(i) != !!memchr(string, i, len)) \
>      -+			cl_failf("0x%02x is classified incorrectly", i); \
>      ++	for (int i = 0; i < 256; i++) { \
>      ++		int actual = class(i), expect = !!memchr(string, i, len); \
>      ++		if (actual != expect) \
>      ++			cl_failf("0x%02x is classified incorrectly: expected %d, got %d", \
>      ++				 i, expect, actual); \
>      + 	} \
>       +	cl_assert(!class(EOF)); \
>        } while (0)
>        
>      @@ t/unit-tests/unit-test.h
>       +#include "strbuf.h"
>       +
>       +#define cl_failf(fmt, ...) do { \
>      -+	char *desc = xstrfmt(fmt, __VA_ARGS__); \
>      ++	char desc[4096]; \
>      ++	snprintf(desc, sizeof(desc), fmt, __VA_ARGS__); \
>       +	clar__fail(__FILE__, __func__, __LINE__, "Test failed.", desc, 1); \
>      -+	free(desc); \
>       +} while (0)
> 13:  131036c398e = 14:  d51c146cd9d clar: add CMake support
