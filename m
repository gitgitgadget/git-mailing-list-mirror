Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D616C686
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851135; cv=none; b=KAR57fgzRdcuMeB79MvoBd+yKIwgFulBLUcIfKaTDpIgGuO5MnUqr8nKFjv0ILOmdCWVTox6xP6pTtTGZUWnr6qPl7DL4DioJjb3G9Ww2kBKsufxxTt8Xx+AsiHe9jg264G3hpRfubd7BODqUP/vNweX6G18VnI8vxz4+t7qEQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851135; c=relaxed/simple;
	bh=VGBxwKJwcqNh2i1UFPgYuVyMqPn9dfOvV2neej5WYvA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k+ZX5k3E1+5/cBxCKNTIlN6AS8bZSsNaZZCgZkfsz8L5g1+znDoYw21nN6OHkho0Hnc9WKvyeW96Oq7oSaK+noO1dfqz5iy8B7meGkKQz89DK6xWg0SazlmEeuBf36r01qVnx9ZtMfsI+Af3/RBCqXjCdMkZF8EDne3vxdRisdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7VwlnWl; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7VwlnWl"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53346132348so8080045e87.2
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724851130; x=1725455930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSMEyDLl7N8p68wnfU0JpSXnu4Tq2iuy38IH++id9p8=;
        b=e7VwlnWlHRRDqilFOYYkFWifBqJy+r1wXpCMNzVlh4cbIg9Jfxl8F+auaoQEM4aVuE
         3+/nE46TyajNqQQBC3LSX4TAdjIVcxeK9Ip/Pqxlszjl8WnxBsU4ut2uDM1Tf/Dn2bfR
         zd88oWAItOHnn1Wk1Epq1hinHyuiXDCV1Xw98AXvTsWeVee2uUUBLTSLoWHV7PyPJ0xs
         tynwOizrBao26SwiCioUhgoWsiwWa8GgVqRq8l3tf62lbv3/fxO60N3Y1Q/Yuroq/rCH
         ZdHz4I3jOASzc1GEH+c3B/i1MbrAVtEbIy+Hu30LVejhUtPbYdHVbvBmbo1OHs6yGajP
         ATQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724851130; x=1725455930;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSMEyDLl7N8p68wnfU0JpSXnu4Tq2iuy38IH++id9p8=;
        b=gm05GvmScOrUtKRltxeB/6W31Z//DBYizHQ7egkFlmLw06eyhJnouw8u7uUIOVQAOL
         qTbMFsedTKz9twtO/sI+oOaHc2y+ppMIcw3oixyoCTQDUPfrsLDMAWNvDHC6NeAP8OVt
         EqrEB9sowc1zenA417/hKD37rioS0WemufbR1IA6ZUL4uuwITYHwXJlomB1sj+T3AuTz
         wHS2WaHJfc3OKvQAsIRvzU9NrsLQqoNVBsO2N2YC2JbfAZ1Ew73KFL64IMgZJUrGICja
         jiV3BlwqdoALnAjitnRcUZ/25Zm786WI6dXXyVHO2AusJJKLrO97tzBrIJpFUpnXj6TX
         g8DA==
X-Forwarded-Encrypted: i=1; AJvYcCXf6tBAPW21KdbWjjm9UmKXGNSHhy5USlH9lia/LDkA0VuSwFKLSGSLVLmLwVOi+ZpduBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiu1Zi9X9qfn3PYa7egIzS1qeW0O0Rm+ZYhH7zgajz9egEBinu
	n8SJvGhC1/+YqAvrYF/pUqoOk0csoqy0i3x3PGiFmFO+En85PSjy
X-Google-Smtp-Source: AGHT+IGD1W5kc58gbhUfj+ZohW6VBgSGBjduktqYwDMxPTzJtGlCFHZZJAH003GsutFxwBflbP1/JA==
X-Received: by 2002:a05:6512:10d6:b0:533:47b5:c023 with SMTP id 2adb3069b0e04-53438778b75mr10738868e87.13.1724851129499;
        Wed, 28 Aug 2024 06:18:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5878a60sm247443766b.174.2024.08.28.06.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 06:18:48 -0700 (PDT)
Message-ID: <e9c015a6-7fc2-4783-9ef6-05359adf46cc@gmail.com>
Date: Wed, 28 Aug 2024 14:18:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 00/13] Introduce clar testing framework
Reply-To: phillip.wood@dunelm.org.uk
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1722415748.git.ps@pks.im> <cover.1724159966.git.ps@pks.im>
Content-Language: en-US
In-Reply-To: <cover.1724159966.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2024 15:02, Patrick Steinhardt wrote:
> Hi,
> 
> this is another version of my patch series that introduces the clar
> testing framework for our C unit tests.

I've left some comments on the code, most of them are points I made in 
the last round that received no response. My main concern is that the 
assertions offered by clar are not as convinent as the check_* macros.

What's the plan for converting our current tests if this gets merged? If 
we were to add wrappers that provide check_int() etc. that would greatly 
simplify the conversion. I think it would offer a more ergonomic api for 
writing new tests than the verbose and non-typesafe cl_assert_equal_i() 
and friends.

Best Wishes

Phillip

> Changes compared to v5:
> 
>    - Rebased on top of `master` to fix some merge conflicts. This series
>      is now built on bb9c16bd4f (The sixth batch, 2024-08-19).
> 
>    - Introduce `cl_failf()` as a nice way to print formatted error
>      messages.
> 
>    - NULL-terminate the argv array again and move the changes into the
>      correct patch.
> 
>    - Most of the changes were done by Dscho to port clar over to Windows,
>      including CMake build instructions to make this usable with MSVC. I
>      plan to upstream these changes when this series lands in Git.
> 
>    - Introduce CMake support, also by Dscho.
> 
> Thanks for all the feedback, and thanks to Dscho for helping out with
> porting this to Windows.
> 
> GitHub pipeline: https://github.com/git/git/actions/runs/10472008177/
> GitLab pipeline: https://gitlab.com/gitlab-org/git/-/pipelines/1419946971
> 
> Patrick
> 
> Johannes Schindelin (4):
>    clar: avoid compile error with mingw-w64
>    clar(win32): avoid compile error due to unused `fs_copy()`
>    clar: stop including `shellapi.h` unnecessarily
>    clar: add CMake support
> 
> Patrick Steinhardt (9):
>    t: do not pass GIT_TEST_OPTS to unit tests with prove
>    t: import the clar unit testing framework
>    t/clar: fix compatibility with NonStop
>    Makefile: fix sparse dependency on GENERATED_H
>    Makefile: make hdr-check depend on generated headers
>    Makefile: do not use sparse on third-party sources
>    Makefile: wire up the clar unit testing framework
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
>   t/unit-tests/{t-ctype.c => ctype.c}        |  70 +-
>   t/unit-tests/strvec.c                      | 222 ++++++
>   t/unit-tests/t-strvec.c                    | 211 ------
>   t/unit-tests/unit-test.c                   |  18 +
>   t/unit-tests/unit-test.h                   |  10 +
>   31 files changed, 3409 insertions(+), 235 deletions(-)
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
>   rename t/unit-tests/{t-ctype.c => ctype.c} (70%)
>   create mode 100644 t/unit-tests/strvec.c
>   delete mode 100644 t/unit-tests/t-strvec.c
>   create mode 100644 t/unit-tests/unit-test.c
>   create mode 100644 t/unit-tests/unit-test.h
> 
> Range-diff against v5:
>   1:  832dc0496fb =  1:  e48a6461137 t: do not pass GIT_TEST_OPTS to unit tests with prove
>   2:  36906079330 =  2:  1710e9f9ff7 t: import the clar unit testing framework
>   3:  db53673294e =  3:  5c21aa87aa2 t/clar: fix compatibility with NonStop
>   -:  ----------- >  4:  06d2bce0d82 clar: avoid compile error with mingw-w64
>   -:  ----------- >  5:  f88b3421a09 clar(win32): avoid compile error due to unused `fs_copy()`
>   -:  ----------- >  6:  5fb4c55be33 clar: stop including `shellapi.h` unnecessarily
>   4:  b6199c88dd7 =  7:  e0dcbd5ca83 Makefile: fix sparse dependency on GENERATED_H
>   5:  06364b2b722 =  8:  77a03f8df70 Makefile: make hdr-check depend on generated headers
>   6:  88ea94ce16c =  9:  c91dd7327e3 Makefile: do not use sparse on third-party sources
>   7:  05bcb5bef6c = 10:  115c15aa9ae Makefile: wire up the clar unit testing framework
>   8:  8f56b4d6264 ! 11:  b3b8df04872 t/unit-tests: convert strvec tests to use clar
>      @@ Makefile: THIRD_PARTY_SOURCES += sha1dc/%
>        UNIT_TESTS_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
>        UNIT_TESTS_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
>        UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
>      -@@ Makefile: UNIT_TEST_PROGRAMS += t-reftable-merged
>      - UNIT_TEST_PROGRAMS += t-reftable-record
>      +@@ Makefile: UNIT_TEST_PROGRAMS += t-reftable-record
>      + UNIT_TEST_PROGRAMS += t-reftable-tree
>        UNIT_TEST_PROGRAMS += t-strbuf
>        UNIT_TEST_PROGRAMS += t-strcmp-offset
>       -UNIT_TEST_PROGRAMS += t-strvec
>      @@ Makefile: UNIT_TEST_PROGRAMS += t-reftable-merged
>        UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
>        UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
>       
>      - ## t/unit-tests/t-strvec.c => t/unit-tests/strvec.c ##
>      + ## t/unit-tests/strvec.c (new) ##
>       @@
>      --#include "test-lib.h"
>       +#include "unit-test.h"
>      - #include "strbuf.h"
>      - #include "strvec.h"
>      -
>      - #define check_strvec(vec, ...) \
>      - 	do { \
>      - 		const char *expect[] = { __VA_ARGS__ }; \
>      --		if (check_uint(ARRAY_SIZE(expect), >, 0) && \
>      --		    check_pointer_eq(expect[ARRAY_SIZE(expect) - 1], NULL) && \
>      --		    check_uint((vec)->nr, ==, ARRAY_SIZE(expect) - 1) && \
>      --		    check_uint((vec)->nr, <=, (vec)->alloc)) { \
>      --			for (size_t i = 0; i < ARRAY_SIZE(expect); i++) { \
>      --				if (!check_str((vec)->v[i], expect[i])) { \
>      --					test_msg("      i: %"PRIuMAX, \
>      --						 (uintmax_t)i); \
>      --					break; \
>      --				} \
>      --			} \
>      --		} \
>      ++#include "strbuf.h"
>      ++#include "strvec.h"
>      ++
>      ++#define check_strvec(vec, ...) \
>      ++	do { \
>      ++		const char *expect[] = { __VA_ARGS__ }; \
>       +		cl_assert(ARRAY_SIZE(expect) > 0); \
>       +		cl_assert_equal_p(expect[ARRAY_SIZE(expect) - 1], NULL); \
>       +		cl_assert_equal_i((vec)->nr, ARRAY_SIZE(expect) - 1); \
>       +		cl_assert((vec)->nr <= (vec)->alloc); \
>       +		for (size_t i = 0; i < ARRAY_SIZE(expect); i++) \
>       +			cl_assert_equal_s((vec)->v[i], expect[i]); \
>      - 	} while (0)
>      -
>      --static void t_static_init(void)
>      ++	} while (0)
>      ++
>       +void test_strvec__init(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      --	check_pointer_eq(vec.v, empty_strvec);
>      --	check_uint(vec.nr, ==, 0);
>      --	check_uint(vec.alloc, ==, 0);
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>       +	cl_assert_equal_p(vec.v, empty_strvec);
>       +	cl_assert_equal_i(vec.nr, 0);
>       +	cl_assert_equal_i(vec.alloc, 0);
>      - }
>      -
>      --static void t_dynamic_init(void)
>      ++}
>      ++
>       +void test_strvec__dynamic_init(void)
>      - {
>      - 	struct strvec vec;
>      - 	strvec_init(&vec);
>      --	check_pointer_eq(vec.v, empty_strvec);
>      --	check_uint(vec.nr, ==, 0);
>      --	check_uint(vec.alloc, ==, 0);
>      ++{
>      ++	struct strvec vec;
>      ++	strvec_init(&vec);
>       +	cl_assert_equal_p(vec.v, empty_strvec);
>       +	cl_assert_equal_i(vec.nr, 0);
>       +	cl_assert_equal_i(vec.alloc, 0);
>      - }
>      -
>      --static void t_clear(void)
>      ++}
>      ++
>       +void test_strvec__clear(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_push(&vec, "foo");
>      - 	strvec_clear(&vec);
>      --	check_pointer_eq(vec.v, empty_strvec);
>      --	check_uint(vec.nr, ==, 0);
>      --	check_uint(vec.alloc, ==, 0);
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_push(&vec, "foo");
>      ++	strvec_clear(&vec);
>       +	cl_assert_equal_p(vec.v, empty_strvec);
>       +	cl_assert_equal_i(vec.nr, 0);
>       +	cl_assert_equal_i(vec.alloc, 0);
>      - }
>      -
>      --static void t_push(void)
>      ++}
>      ++
>       +void test_strvec__push(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      -
>      -@@ t/unit-tests/strvec.c: static void t_push(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_pushf(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++
>      ++	strvec_push(&vec, "foo");
>      ++	check_strvec(&vec, "foo", NULL);
>      ++
>      ++	strvec_push(&vec, "bar");
>      ++	check_strvec(&vec, "foo", "bar", NULL);
>      ++
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__pushf(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_pushf(&vec, "foo: %d", 1);
>      -@@ t/unit-tests/strvec.c: static void t_pushf(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_pushl(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_pushf(&vec, "foo: %d", 1);
>      ++	check_strvec(&vec, "foo: 1", NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__pushl(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      -@@ t/unit-tests/strvec.c: static void t_pushl(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_pushv(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      ++	check_strvec(&vec, "foo", "bar", "baz", NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__pushv(void)
>      - {
>      - 	const char *strings[] = {
>      - 		"foo", "bar", "baz", NULL,
>      -@@ t/unit-tests/strvec.c: static void t_pushv(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_replace_at_head(void)
>      ++{
>      ++	const char *strings[] = {
>      ++		"foo", "bar", "baz", NULL,
>      ++	};
>      ++	struct strvec vec = STRVEC_INIT;
>      ++
>      ++	strvec_pushv(&vec, strings);
>      ++	check_strvec(&vec, "foo", "bar", "baz", NULL);
>      ++
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__replace_at_head(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      -@@ t/unit-tests/strvec.c: static void t_replace_at_head(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_replace_at_tail(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      ++	strvec_replace(&vec, 0, "replaced");
>      ++	check_strvec(&vec, "replaced", "bar", "baz", NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__replace_at_tail(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      -@@ t/unit-tests/strvec.c: static void t_replace_at_tail(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_replace_in_between(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      ++	strvec_replace(&vec, 2, "replaced");
>      ++	check_strvec(&vec, "foo", "bar", "replaced", NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__replace_in_between(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      -@@ t/unit-tests/strvec.c: static void t_replace_in_between(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_replace_with_substring(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      ++	strvec_replace(&vec, 1, "replaced");
>      ++	check_strvec(&vec, "foo", "replaced", "baz", NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__replace_with_substring(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_pushl(&vec, "foo", NULL);
>      -@@ t/unit-tests/strvec.c: static void t_replace_with_substring(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_remove_at_head(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_pushl(&vec, "foo", NULL);
>      ++	strvec_replace(&vec, 0, vec.v[0] + 1);
>      ++	check_strvec(&vec, "oo", NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__remove_at_head(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      -@@ t/unit-tests/strvec.c: static void t_remove_at_head(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_remove_at_tail(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      ++	strvec_remove(&vec, 0);
>      ++	check_strvec(&vec, "bar", "baz", NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__remove_at_tail(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      -@@ t/unit-tests/strvec.c: static void t_remove_at_tail(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_remove_in_between(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      ++	strvec_remove(&vec, 2);
>      ++	check_strvec(&vec, "foo", "bar", NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__remove_in_between(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      -@@ t/unit-tests/strvec.c: static void t_remove_in_between(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_pop_empty_array(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      ++	strvec_remove(&vec, 1);
>      ++	check_strvec(&vec, "foo", "baz", NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__pop_empty_array(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_pop(&vec);
>      -@@ t/unit-tests/strvec.c: static void t_pop_empty_array(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_pop_non_empty_array(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_pop(&vec);
>      ++	check_strvec(&vec, NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__pop_non_empty_array(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      -@@ t/unit-tests/strvec.c: static void t_pop_non_empty_array(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_split_empty_string(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      ++	strvec_pop(&vec);
>      ++	check_strvec(&vec, "foo", "bar", NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__split_empty_string(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_split(&vec, "");
>      -@@ t/unit-tests/strvec.c: static void t_split_empty_string(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_split_single_item(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_split(&vec, "");
>      ++	check_strvec(&vec, NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__split_single_item(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_split(&vec, "foo");
>      -@@ t/unit-tests/strvec.c: static void t_split_single_item(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_split_multiple_items(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_split(&vec, "foo");
>      ++	check_strvec(&vec, "foo", NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__split_multiple_items(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_split(&vec, "foo bar baz");
>      -@@ t/unit-tests/strvec.c: static void t_split_multiple_items(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_split_whitespace_only(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_split(&vec, "foo bar baz");
>      ++	check_strvec(&vec, "foo", "bar", "baz", NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__split_whitespace_only(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_split(&vec, " \t\n");
>      -@@ t/unit-tests/strvec.c: static void t_split_whitespace_only(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_split_multiple_consecutive_whitespaces(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_split(&vec, " \t\n");
>      ++	check_strvec(&vec, NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__split_multiple_consecutive_whitespaces(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	strvec_split(&vec, "foo\n\t bar");
>      -@@ t/unit-tests/strvec.c: static void t_split_multiple_consecutive_whitespaces(void)
>      - 	strvec_clear(&vec);
>      - }
>      -
>      --static void t_detach(void)
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	strvec_split(&vec, "foo\n\t bar");
>      ++	check_strvec(&vec, "foo", "bar", NULL);
>      ++	strvec_clear(&vec);
>      ++}
>      ++
>       +void test_strvec__detach(void)
>      - {
>      - 	struct strvec vec = STRVEC_INIT;
>      - 	const char **detached;
>      -@@ t/unit-tests/strvec.c: static void t_detach(void)
>      - 	strvec_push(&vec, "foo");
>      -
>      - 	detached = strvec_detach(&vec);
>      --	check_str(detached[0], "foo");
>      --	check_pointer_eq(detached[1], NULL);
>      ++{
>      ++	struct strvec vec = STRVEC_INIT;
>      ++	const char **detached;
>      ++
>      ++	strvec_push(&vec, "foo");
>      ++
>      ++	detached = strvec_detach(&vec);
>       +	cl_assert_equal_s(detached[0], "foo");
>       +	cl_assert_equal_p(detached[1], NULL);
>      -
>      --	check_pointer_eq(vec.v, empty_strvec);
>      --	check_uint(vec.nr, ==, 0);
>      --	check_uint(vec.alloc, ==, 0);
>      ++
>       +	cl_assert_equal_p(vec.v, empty_strvec);
>       +	cl_assert_equal_i(vec.nr, 0);
>       +	cl_assert_equal_i(vec.alloc, 0);
>      -
>      - 	free((char *) detached[0]);
>      - 	free(detached);
>      - }
>      ++
>      ++	free((char *) detached[0]);
>      ++	free(detached);
>      ++}
>      +
>      + ## t/unit-tests/t-strvec.c (deleted) ##
>      +@@
>      +-#include "test-lib.h"
>      +-#include "strbuf.h"
>      +-#include "strvec.h"
>      +-
>      +-#define check_strvec(vec, ...) \
>      +-	do { \
>      +-		const char *expect[] = { __VA_ARGS__ }; \
>      +-		if (check_uint(ARRAY_SIZE(expect), >, 0) && \
>      +-		    check_pointer_eq(expect[ARRAY_SIZE(expect) - 1], NULL) && \
>      +-		    check_uint((vec)->nr, ==, ARRAY_SIZE(expect) - 1) && \
>      +-		    check_uint((vec)->nr, <=, (vec)->alloc)) { \
>      +-			for (size_t i = 0; i < ARRAY_SIZE(expect); i++) { \
>      +-				if (!check_str((vec)->v[i], expect[i])) { \
>      +-					test_msg("      i: %"PRIuMAX, \
>      +-						 (uintmax_t)i); \
>      +-					break; \
>      +-				} \
>      +-			} \
>      +-		} \
>      +-	} while (0)
>       -
>       -int cmd_main(int argc, const char **argv)
>       -{
>      --	TEST(t_static_init(), "static initialization");
>      --	TEST(t_dynamic_init(), "dynamic initialization");
>      --	TEST(t_clear(), "clear");
>      --	TEST(t_push(), "push");
>      --	TEST(t_pushf(), "pushf");
>      --	TEST(t_pushl(), "pushl");
>      --	TEST(t_pushv(), "pushv");
>      --	TEST(t_replace_at_head(), "replace at head");
>      --	TEST(t_replace_in_between(), "replace in between");
>      --	TEST(t_replace_at_tail(), "replace at tail");
>      --	TEST(t_replace_with_substring(), "replace with substring");
>      --	TEST(t_remove_at_head(), "remove at head");
>      --	TEST(t_remove_in_between(), "remove in between");
>      --	TEST(t_remove_at_tail(), "remove at tail");
>      --	TEST(t_pop_empty_array(), "pop with empty array");
>      --	TEST(t_pop_non_empty_array(), "pop with non-empty array");
>      --	TEST(t_split_empty_string(), "split empty string");
>      --	TEST(t_split_single_item(), "split single item");
>      --	TEST(t_split_multiple_items(), "split multiple items");
>      --	TEST(t_split_whitespace_only(), "split whitespace only");
>      --	TEST(t_split_multiple_consecutive_whitespaces(), "split multiple consecutive whitespaces");
>      --	TEST(t_detach(), "detach");
>      +-	if_test ("static initialization") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		check_pointer_eq(vec.v, empty_strvec);
>      +-		check_uint(vec.nr, ==, 0);
>      +-		check_uint(vec.alloc, ==, 0);
>      +-	}
>      +-
>      +-	if_test ("dynamic initialization") {
>      +-		struct strvec vec;
>      +-		strvec_init(&vec);
>      +-		check_pointer_eq(vec.v, empty_strvec);
>      +-		check_uint(vec.nr, ==, 0);
>      +-		check_uint(vec.alloc, ==, 0);
>      +-	}
>      +-
>      +-	if_test ("clear") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_push(&vec, "foo");
>      +-		strvec_clear(&vec);
>      +-		check_pointer_eq(vec.v, empty_strvec);
>      +-		check_uint(vec.nr, ==, 0);
>      +-		check_uint(vec.alloc, ==, 0);
>      +-	}
>      +-
>      +-	if_test ("push") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-
>      +-		strvec_push(&vec, "foo");
>      +-		check_strvec(&vec, "foo", NULL);
>      +-
>      +-		strvec_push(&vec, "bar");
>      +-		check_strvec(&vec, "foo", "bar", NULL);
>      +-
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("pushf") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_pushf(&vec, "foo: %d", 1);
>      +-		check_strvec(&vec, "foo: 1", NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("pushl") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      +-		check_strvec(&vec, "foo", "bar", "baz", NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("pushv") {
>      +-		const char *strings[] = {
>      +-			"foo", "bar", "baz", NULL,
>      +-		};
>      +-		struct strvec vec = STRVEC_INIT;
>      +-
>      +-		strvec_pushv(&vec, strings);
>      +-		check_strvec(&vec, "foo", "bar", "baz", NULL);
>      +-
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("replace at head") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      +-		strvec_replace(&vec, 0, "replaced");
>      +-		check_strvec(&vec, "replaced", "bar", "baz", NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("replace at tail") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      +-		strvec_replace(&vec, 2, "replaced");
>      +-		check_strvec(&vec, "foo", "bar", "replaced", NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("replace in between") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      +-		strvec_replace(&vec, 1, "replaced");
>      +-		check_strvec(&vec, "foo", "replaced", "baz", NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("replace with substring") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_pushl(&vec, "foo", NULL);
>      +-		strvec_replace(&vec, 0, vec.v[0] + 1);
>      +-		check_strvec(&vec, "oo", NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("remove at head") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      +-		strvec_remove(&vec, 0);
>      +-		check_strvec(&vec, "bar", "baz", NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("remove at tail") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      +-		strvec_remove(&vec, 2);
>      +-		check_strvec(&vec, "foo", "bar", NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("remove in between") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      +-		strvec_remove(&vec, 1);
>      +-		check_strvec(&vec, "foo", "baz", NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("pop with empty array") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_pop(&vec);
>      +-		check_strvec(&vec, NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("pop with non-empty array") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
>      +-		strvec_pop(&vec);
>      +-		check_strvec(&vec, "foo", "bar", NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("split empty string") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_split(&vec, "");
>      +-		check_strvec(&vec, NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("split single item") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_split(&vec, "foo");
>      +-		check_strvec(&vec, "foo", NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("split multiple items") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_split(&vec, "foo bar baz");
>      +-		check_strvec(&vec, "foo", "bar", "baz", NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("split whitespace only") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_split(&vec, " \t\n");
>      +-		check_strvec(&vec, NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("split multiple consecutive whitespaces") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		strvec_split(&vec, "foo\n\t bar");
>      +-		check_strvec(&vec, "foo", "bar", NULL);
>      +-		strvec_clear(&vec);
>      +-	}
>      +-
>      +-	if_test ("detach") {
>      +-		struct strvec vec = STRVEC_INIT;
>      +-		const char **detached;
>      +-
>      +-		strvec_push(&vec, "foo");
>      +-
>      +-		detached = strvec_detach(&vec);
>      +-		check_str(detached[0], "foo");
>      +-		check_pointer_eq(detached[1], NULL);
>      +-
>      +-		check_pointer_eq(vec.v, empty_strvec);
>      +-		check_uint(vec.nr, ==, 0);
>      +-		check_uint(vec.alloc, ==, 0);
>      +-
>      +-		free((char *) detached[0]);
>      +-		free(detached);
>      +-	}
>      +-
>       -	return test_done();
>       -}
>      -
>      - ## t/unit-tests/unit-test.c ##
>      -@@ t/unit-tests/unit-test.c: int cmd_main(int argc, const char **argv)
>      - 	int ret;
>      -
>      - 	/* Append the "-t" flag such that the tests generate TAP output. */
>      --	ALLOC_ARRAY(argv_copy, argc + 2);
>      -+	ALLOC_ARRAY(argv_copy, argc + 1);
>      - 	COPY_ARRAY(argv_copy, argv, argc);
>      - 	argv_copy[argc++] = "-t";
>      --	argv_copy[argc] = NULL;
>      -
>      - 	ret = clar_test(argc, (char **) argv_copy);
>      -
>   9:  ca09d19fd51 ! 12:  1ac2e48a7f2 t/unit-tests: convert ctype tests to use clar
>      @@ Commit message
>           t/unit-tests: convert ctype tests to use clar
>       
>           Convert the ctype tests to use the new clar unit testing framework.
>      +    Introduce a new function `cl_failf()` that allows us to print a
>      +    formatted error message, which we can use to point out which of the
>      +    characters was classified incorrectly. This results in output like this
>      +    on failure:
>      +
>      +        # start of suite 1: ctype
>      +        ok 1 - ctype::isspace
>      +        not ok 2 - ctype::isdigit
>      +            ---
>      +            reason: |
>      +              Test failed.
>      +              0x61 is classified incorrectly
>      +            at:
>      +              file: 't/unit-tests/ctype.c'
>      +              line: 38
>      +              function: 'test_ctype__isdigit'
>      +            ---
>      +        ok 3 - ctype::isalpha
>      +        ok 4 - ctype::isalnum
>      +        ok 5 - ctype::is_glob_special
>      +        ok 6 - ctype::is_regex_special
>      +        ok 7 - ctype::is_pathspec_magic
>      +        ok 8 - ctype::isascii
>      +        ok 9 - ctype::islower
>      +        ok 10 - ctype::isupper
>      +        ok 11 - ctype::iscntrl
>      +        ok 12 - ctype::ispunct
>      +        ok 13 - ctype::isxdigit
>      +        ok 14 - ctype::isprint
>       
>           Signed-off-by: Patrick Steinhardt <ps@pks.im>
>       
>      @@ Makefile: THIRD_PARTY_SOURCES += sha1dc/%
>       -UNIT_TEST_PROGRAMS += t-ctype
>        UNIT_TEST_PROGRAMS += t-example-decorate
>        UNIT_TEST_PROGRAMS += t-hash
>      - UNIT_TEST_PROGRAMS += t-mem-pool
>      + UNIT_TEST_PROGRAMS += t-hashmap
>       
>        ## t/unit-tests/t-ctype.c => t/unit-tests/ctype.c ##
>       @@
>      @@ t/unit-tests/t-ctype.c => t/unit-tests/ctype.c
>        	size_t len = ARRAY_SIZE(string) - 1 + \
>        		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
>        		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) == sizeof(char)); \
>      --	int skip = test__run_begin(); \
>      --	if (!skip) { \
>      +-	if_test (#class " works") { \
>       -		for (int i = 0; i < 256; i++) { \
>       -			if (!check_int(class(i), ==, !!memchr(string, i, len)))\
>       -				test_msg("      i: 0x%02x", i); \
>       -		} \
>       -		check(!class(EOF)); \
>       -	} \
>      --	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
>       +	for (int i = 0; i < 256; i++) \
>      -+		cl_assert_equal_i(class(i), !!memchr(string, i, len)); \
>      ++		if (class(i) != !!memchr(string, i, len)) \
>      ++			cl_failf("0x%02x is classified incorrectly", i); \
>       +	cl_assert(!class(EOF)); \
>        } while (0)
>        
>      @@ t/unit-tests/t-ctype.c => t/unit-tests/ctype.c
>       +{
>       +	TEST_CHAR_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");
>        }
>      +
>      + ## t/unit-tests/unit-test.h ##
>      +@@
>      + #include "git-compat-util.h"
>      + #include "clar/clar.h"
>      + #include "clar-decls.h"
>      ++#include "strbuf.h"
>      ++
>      ++#define cl_failf(fmt, ...) do { \
>      ++	char *desc = xstrfmt(fmt, __VA_ARGS__); \
>      ++	clar__fail(__FILE__, __func__, __LINE__, "Test failed.", desc, 1); \
>      ++	free(desc); \
>      ++} while (0)
>   -:  ----------- > 13:  131036c398e clar: add CMake support

