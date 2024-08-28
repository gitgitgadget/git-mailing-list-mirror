Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD18181328
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851030; cv=none; b=ZJk3tifegmPclZgE/ZneO3Y+4vEY9Jc6LqsFHJ/RoWU+jlGbmmZzOlEpUHek+LwwqHQ5MtNnQQJ+Xts1ZJ79bLdPRbh4rRpdXYBTTcmoOO86FXggLFntfRN0vJjIfoWgRpwfOwOoFURLfgfvRyGBf3piO0AqvogQ13NCxEsbs5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851030; c=relaxed/simple;
	bh=hUnpcez5Wg3QNbupn75LMiuQ6E1ctaAH8qbWYLGI2OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBkGrmsV4XhOsDRBPPU9RNEbYIt1pbSpjXFERLd6viu3ejM5OU/unFXAOCfxv9uJz/ZxLB+oiufvA0Mz+RATrdHecf53v6S9BteUcpNRbYaNPSJ/FGfdGG2XP0B4DfmkwpHc3e6CfQg7OqJMlDwHfb3B/3pEXKAG0XslLmoG+3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9L4CrEz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9L4CrEz"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a83597ce5beso110048766b.1
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 06:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724851026; x=1725455826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FMhEZ0/z1UdI6QTwKy2jHDlxywwGLgduQ9TmMqbDEnI=;
        b=Z9L4CrEzpCPlup/WOiPlO6M1tl7wZjhmTnnHVB8WbtCGOHhEqgUZAVHsQv+Cr96mms
         TbrKGFMnpGXGv+RbPaJEZG4z4Kov4wRdzZRMVXxl5408rzF8WztmPSJ6dWsy7G5OKK/k
         k4TfNvUgCDYFG9Skys7SS7pRLexVnjIY3thX9+SWdlneNYzgigSIP7cbnxodxBMaIotc
         InppnIhMFp6q3TW6ZqF4mHLDU81Hzxfl0xGk/+aWXVku1UrJjcqlL4ybSz03APVNsILJ
         jQ6RMVrKAZmc63hC7wLPe4x+ns7cq3yPdwtqQCM7QO2L9XJ/EKMsF5dOgEIRJohgRHDf
         azhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724851026; x=1725455826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMhEZ0/z1UdI6QTwKy2jHDlxywwGLgduQ9TmMqbDEnI=;
        b=eKVfRg7EMjRvJS6y/r6TfNVeRSnjdSAWBLRPzSqgwR9PzG2uSri4NYXJSIY71VpFdu
         bRxOWwV4Fp7ofVWxdE7gPB7+x3rhZYDH18XRwvekQdtyT886fMxOvE+mX6tnQxsj5qKT
         XC502xiSagE1X1eUAk0LSpAoaaeb26vFI/nyV3z3SPuuzWxF2LEFAuUBlog3AzfBzqeK
         ryYEXyl4pqv6Tcxm5d9pYyMmTjLcDERqb+Lly5UcR3GwHyIoQAoqSDR+g7D51DMA8vov
         Zdvf/LKkDHmcYIL5MRUU8A/ROPxYcW96shlZAADjvJlfjOifpA8jAt1SNX5nEbdWHBHi
         Gd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVE1ZdbknlDVHawGJMy1+h0y3xInTwO3GFIQvIc9vtZZ4HaGUOmJc0alEIG/VC8WdYHhmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdAvsqUtstonIWzG/J7IrZxultFwczVKWccRqut+q9kL75Geys
	kMoXndkUDf69Jydihcrp0bazuUcjC4ygV+w6UY1R0cKlkLksQYRH
X-Google-Smtp-Source: AGHT+IFvTxS7U0eOmgrMmBx3cTtSQiqFJSz6pyGY6Jek0FHnCDA2xIzBPfpM6B/b/jWYfxordjnwSQ==
X-Received: by 2002:a17:907:7210:b0:a7a:ac5f:bbef with SMTP id a640c23a62f3a-a870ab0b7bdmr223487266b.31.1724851025391;
        Wed, 28 Aug 2024 06:17:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549cfbfsm245184666b.77.2024.08.28.06.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 06:17:04 -0700 (PDT)
Message-ID: <c6f13f6b-7899-4bbd-986a-9bb1649b214f@gmail.com>
Date: Wed, 28 Aug 2024 14:17:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 11/13] t/unit-tests: convert strvec tests to use clar
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1722415748.git.ps@pks.im> <cover.1724159966.git.ps@pks.im>
 <b3b8df048725c25b14860513b7950b158a6990ea.1724159966.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <b3b8df048725c25b14860513b7950b158a6990ea.1724159966.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 20/08/2024 15:02, Patrick Steinhardt wrote:
> Convert the strvec tests to use the new clar unit testing framework.
> This is a first test balloon that demonstrates how the testing infra for
> clar-based tests looks like.
> 
> The tests are part of the "t/unit-tests/bin/unit-tests" binary. When
> running that binary, it generates TAP output:

It would be interesting to see a comparison between the current 
framework and clar of the output from a failing test - the TAP output 
for passing tests is pretty much the same regardless of the framework used.

>      # ./t/unit-tests/bin/unit-tests
>      TAP version 13
>      # start of suite 1: strvec
>      ok 1 - strvec::init
> [...] 
> The binary also supports some parameters that allow us to run only a
> subset of unit tests or alter the output:
> 
>      $ ./t/unit-tests/bin/unit-tests -h
>      Usage: ./t/unit-tests/bin/unit-tests [options]
> 
>      Options:
>        -sname        Run only the suite with `name` (can go to individual test name)
>        -iname        Include the suite with `name`
>        -xname        Exclude the suite with `name`
>        -v            Increase verbosity (show suite names)

The output above seems to include the suite name - are we running the 
tests with '-v' from our Makefile?

>        -q            Only report tests that had an error

This option is incompatible with TAP output. As we force TAP output we 
should find a way to stop displaying this help.

>        -Q            Quit as soon as a test fails
>        -t            Display results in tap format

We force TAP output by adding '-t' to argv in main() so this line is not 
very helpful

>        -l            Print suite names
>        -r[filename]  Write summary file (to the optional filename)

> diff --git a/t/unit-tests/strvec.c b/t/unit-tests/strvec.c
> [..]
> +#define check_strvec(vec, ...) \
> +	do { \
> +		const char *expect[] = { __VA_ARGS__ }; \
> +		cl_assert(ARRAY_SIZE(expect) > 0); \

As there are a lot occurrences of ARRAY_SIZE(expect) it is probably 
worth adding

	size_t expect_len = ARRAY_SIZE(expect);

above.

> +		cl_assert_equal_p(expect[ARRAY_SIZE(expect) - 1], NULL); \
> +		cl_assert_equal_i((vec)->nr, ARRAY_SIZE(expect) - 1); \
> +		cl_assert((vec)->nr <= (vec)->alloc); \

The conversion here loses the values of nr and alloc which is a shame as 
they would be useful when debugging a test failure.

> +		for (size_t i = 0; i < ARRAY_SIZE(expect); i++) \
> +			cl_assert_equal_s((vec)->v[i], expect[i]); \

The original test also printed the array index of the failing check. As 
the elements of the test vectors all seem to be unique that is less of a 
worry than if we had tests with repeating elements.

> +	} while (0)
> +
> +void test_strvec__init(void)
> +{
> +	struct strvec vec = STRVEC_INIT;

If we're rewriting the tests perhaps we can take the opportunity to add 
a blank line to each one after the variable declarations in accordance 
with our coding guidelines.

It might be a good opportunity to show the set-up and tear-down 
facilities in clar as well instead of repeating the initialization in 
each test.

Best Wishes

Phillip

> +	cl_assert_equal_p(vec.v, empty_strvec);
> +	cl_assert_equal_i(vec.nr, 0);
> +	cl_assert_equal_i(vec.alloc, 0);
> +}
> +
> +void test_strvec__dynamic_init(void)
> +{
> +	struct strvec vec;
> +	strvec_init(&vec);
> +	cl_assert_equal_p(vec.v, empty_strvec);
> +	cl_assert_equal_i(vec.nr, 0);
> +	cl_assert_equal_i(vec.alloc, 0);
> +}
> +
> +void test_strvec__clear(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_push(&vec, "foo");
> +	strvec_clear(&vec);
> +	cl_assert_equal_p(vec.v, empty_strvec);
> +	cl_assert_equal_i(vec.nr, 0);
> +	cl_assert_equal_i(vec.alloc, 0);
> +}
> +
> +void test_strvec__push(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +
> +	strvec_push(&vec, "foo");
> +	check_strvec(&vec, "foo", NULL);
> +
> +	strvec_push(&vec, "bar");
> +	check_strvec(&vec, "foo", "bar", NULL);
> +
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__pushf(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_pushf(&vec, "foo: %d", 1);
> +	check_strvec(&vec, "foo: 1", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__pushl(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +	check_strvec(&vec, "foo", "bar", "baz", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__pushv(void)
> +{
> +	const char *strings[] = {
> +		"foo", "bar", "baz", NULL,
> +	};
> +	struct strvec vec = STRVEC_INIT;
> +
> +	strvec_pushv(&vec, strings);
> +	check_strvec(&vec, "foo", "bar", "baz", NULL);
> +
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__replace_at_head(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +	strvec_replace(&vec, 0, "replaced");
> +	check_strvec(&vec, "replaced", "bar", "baz", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__replace_at_tail(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +	strvec_replace(&vec, 2, "replaced");
> +	check_strvec(&vec, "foo", "bar", "replaced", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__replace_in_between(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +	strvec_replace(&vec, 1, "replaced");
> +	check_strvec(&vec, "foo", "replaced", "baz", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__replace_with_substring(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_pushl(&vec, "foo", NULL);
> +	strvec_replace(&vec, 0, vec.v[0] + 1);
> +	check_strvec(&vec, "oo", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__remove_at_head(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +	strvec_remove(&vec, 0);
> +	check_strvec(&vec, "bar", "baz", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__remove_at_tail(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +	strvec_remove(&vec, 2);
> +	check_strvec(&vec, "foo", "bar", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__remove_in_between(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +	strvec_remove(&vec, 1);
> +	check_strvec(&vec, "foo", "baz", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__pop_empty_array(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_pop(&vec);
> +	check_strvec(&vec, NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__pop_non_empty_array(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +	strvec_pop(&vec);
> +	check_strvec(&vec, "foo", "bar", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__split_empty_string(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_split(&vec, "");
> +	check_strvec(&vec, NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__split_single_item(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_split(&vec, "foo");
> +	check_strvec(&vec, "foo", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__split_multiple_items(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_split(&vec, "foo bar baz");
> +	check_strvec(&vec, "foo", "bar", "baz", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__split_whitespace_only(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_split(&vec, " \t\n");
> +	check_strvec(&vec, NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__split_multiple_consecutive_whitespaces(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	strvec_split(&vec, "foo\n\t bar");
> +	check_strvec(&vec, "foo", "bar", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__detach(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	const char **detached;
> +
> +	strvec_push(&vec, "foo");
> +
> +	detached = strvec_detach(&vec);
> +	cl_assert_equal_s(detached[0], "foo");
> +	cl_assert_equal_p(detached[1], NULL);
> +
> +	cl_assert_equal_p(vec.v, empty_strvec);
> +	cl_assert_equal_i(vec.nr, 0);
> +	cl_assert_equal_i(vec.alloc, 0);
> +
> +	free((char *) detached[0]);
> +	free(detached);
> +}
> diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
> deleted file mode 100644
> index c4bac8fc91b..00000000000
> --- a/t/unit-tests/t-strvec.c
> +++ /dev/null
> @@ -1,211 +0,0 @@
> -#include "test-lib.h"
> -#include "strbuf.h"
> -#include "strvec.h"
> -
> -#define check_strvec(vec, ...) \
> -	do { \
> -		const char *expect[] = { __VA_ARGS__ }; \
> -		if (check_uint(ARRAY_SIZE(expect), >, 0) && \
> -		    check_pointer_eq(expect[ARRAY_SIZE(expect) - 1], NULL) && \
> -		    check_uint((vec)->nr, ==, ARRAY_SIZE(expect) - 1) && \
> -		    check_uint((vec)->nr, <=, (vec)->alloc)) { \
> -			for (size_t i = 0; i < ARRAY_SIZE(expect); i++) { \
> -				if (!check_str((vec)->v[i], expect[i])) { \
> -					test_msg("      i: %"PRIuMAX, \
> -						 (uintmax_t)i); \
> -					break; \
> -				} \
> -			} \
> -		} \
> -	} while (0)
> -
> -int cmd_main(int argc, const char **argv)
> -{
> -	if_test ("static initialization") {
> -		struct strvec vec = STRVEC_INIT;
> -		check_pointer_eq(vec.v, empty_strvec);
> -		check_uint(vec.nr, ==, 0);
> -		check_uint(vec.alloc, ==, 0);
> -	}
> -
> -	if_test ("dynamic initialization") {
> -		struct strvec vec;
> -		strvec_init(&vec);
> -		check_pointer_eq(vec.v, empty_strvec);
> -		check_uint(vec.nr, ==, 0);
> -		check_uint(vec.alloc, ==, 0);
> -	}
> -
> -	if_test ("clear") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_push(&vec, "foo");
> -		strvec_clear(&vec);
> -		check_pointer_eq(vec.v, empty_strvec);
> -		check_uint(vec.nr, ==, 0);
> -		check_uint(vec.alloc, ==, 0);
> -	}
> -
> -	if_test ("push") {
> -		struct strvec vec = STRVEC_INIT;
> -
> -		strvec_push(&vec, "foo");
> -		check_strvec(&vec, "foo", NULL);
> -
> -		strvec_push(&vec, "bar");
> -		check_strvec(&vec, "foo", "bar", NULL);
> -
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("pushf") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_pushf(&vec, "foo: %d", 1);
> -		check_strvec(&vec, "foo: 1", NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("pushl") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -		check_strvec(&vec, "foo", "bar", "baz", NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("pushv") {
> -		const char *strings[] = {
> -			"foo", "bar", "baz", NULL,
> -		};
> -		struct strvec vec = STRVEC_INIT;
> -
> -		strvec_pushv(&vec, strings);
> -		check_strvec(&vec, "foo", "bar", "baz", NULL);
> -
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("replace at head") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -		strvec_replace(&vec, 0, "replaced");
> -		check_strvec(&vec, "replaced", "bar", "baz", NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("replace at tail") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -		strvec_replace(&vec, 2, "replaced");
> -		check_strvec(&vec, "foo", "bar", "replaced", NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("replace in between") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -		strvec_replace(&vec, 1, "replaced");
> -		check_strvec(&vec, "foo", "replaced", "baz", NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("replace with substring") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_pushl(&vec, "foo", NULL);
> -		strvec_replace(&vec, 0, vec.v[0] + 1);
> -		check_strvec(&vec, "oo", NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("remove at head") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -		strvec_remove(&vec, 0);
> -		check_strvec(&vec, "bar", "baz", NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("remove at tail") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -		strvec_remove(&vec, 2);
> -		check_strvec(&vec, "foo", "bar", NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("remove in between") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -		strvec_remove(&vec, 1);
> -		check_strvec(&vec, "foo", "baz", NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("pop with empty array") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_pop(&vec);
> -		check_strvec(&vec, NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("pop with non-empty array") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> -		strvec_pop(&vec);
> -		check_strvec(&vec, "foo", "bar", NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("split empty string") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_split(&vec, "");
> -		check_strvec(&vec, NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("split single item") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_split(&vec, "foo");
> -		check_strvec(&vec, "foo", NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("split multiple items") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_split(&vec, "foo bar baz");
> -		check_strvec(&vec, "foo", "bar", "baz", NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("split whitespace only") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_split(&vec, " \t\n");
> -		check_strvec(&vec, NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("split multiple consecutive whitespaces") {
> -		struct strvec vec = STRVEC_INIT;
> -		strvec_split(&vec, "foo\n\t bar");
> -		check_strvec(&vec, "foo", "bar", NULL);
> -		strvec_clear(&vec);
> -	}
> -
> -	if_test ("detach") {
> -		struct strvec vec = STRVEC_INIT;
> -		const char **detached;
> -
> -		strvec_push(&vec, "foo");
> -
> -		detached = strvec_detach(&vec);
> -		check_str(detached[0], "foo");
> -		check_pointer_eq(detached[1], NULL);
> -
> -		check_pointer_eq(vec.v, empty_strvec);
> -		check_uint(vec.nr, ==, 0);
> -		check_uint(vec.alloc, ==, 0);
> -
> -		free((char *) detached[0]);
> -		free(detached);
> -	}
> -
> -	return test_done();
> -}
