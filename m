Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D12149DE2
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985555; cv=none; b=p9zIWX7/X2SLVFtQbfQu228cTlccY1VVIcrAsJWlbYCrxCB6owY2kzUEURD2CUsvCcktoVFRqWuch7F94ZdiOtepzbth3/lG4zyErIBQ9RDl/f7k7NCpcZx1hBE+DSGpT9ZSobZBMM2f/esd0wkKJ9NIq93v6q+yn8IjanSxXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985555; c=relaxed/simple;
	bh=eSAsEbONJa71Vi9FI6FF5KUewlhnlv9C7cZAuoSjDj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOOTokgRbGbbumUeM3Ez02uifpPfOndbauMzvt0Kr3Qdn/MdVRIXVcEODZftiCTH0KlqO+0LEMkGJMam7/EKCMXWrwWGm3Hykx1Je6Jgw+z6P1ucz0D98vTc2523eiFSQGJ98txtqQtWpokdZCJmc81HPYhn/B73TLGjudK4S1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LkUdU/Se; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LkUdU/Se"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd70ba6a15so9510985ad.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722985552; x=1723590352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFBlR/IAxNux6geDKzitZqs6n6pYMegoBL4Brginy4w=;
        b=LkUdU/Seifb4fFWCCu6eUNKSZ0Hlb06S2tUZiQitKXPC4ZX6JhbYEuZaRn5dNzTQCV
         kh2JcWdEBXhVcC/i87sdsUdHN98PZAdIm7ZDxvem1qcpvu2drZwdDzTXzk4GOSODXmGu
         JJYUy3o70BDyxetqPxZkFSn8B8IOHmOeKKgq3pdVpAjCdvIDxt3LJZkVjAe0YlWw3TlP
         QgjI1LGv4LkDMHUMtcuRnV3MwLc/Wiux0422fmfOjFLgfIonNkEXZzRMbl1jqW7ZyxWX
         MuN1Au6M9+MSGL+r/WYeHGOKtA/qmHMPWmDGp4kFQCUHgTKGGnxSLuc623GIFNqymMkF
         IBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722985552; x=1723590352;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFBlR/IAxNux6geDKzitZqs6n6pYMegoBL4Brginy4w=;
        b=a/7R6HoRhSMBOFrsIqtzQi3Zk8RrobCgvSSh73LP553ReBHYo+cbyf+44ZFv120B05
         wvvtY//NXw/aNHwesmpyRpXzZoThPHmMOWVwXDFqdjIUTAZNSvjmckEPDZG7HtyFHo9e
         FgXRP05BkXDC0o0zijH1nFdk65WOGgFXkL/T3FZ+o+5koYIsTUeN3izogCjI+idklIwx
         FgBK63vu7T4KjzeB4g19Jn6sgM9ZkdWriyplYQqGtKdrpQU3ZJP+5cbPzz0P+zHz+lbj
         mNPnGjnioV33DiHkvFHznLZsr6OvWwiHhJftQIew9IuJi6Qw4ALEXviaHhtScCzpTWDE
         1dBQ==
X-Gm-Message-State: AOJu0YzLzfbgwz/xSqPx0jdXmH16r/e1sjzux0GpqCqV+BBsoA9befHv
	Std5DzeoM0xPwLnHCCCfHPFu9zHMuok+7ZwQ95G7SIvbBInIyxN7qZK9WUtcBB4IjaqXeNYRSlv
	MCA==
X-Google-Smtp-Source: AGHT+IH+UAa7ujUVXkQQINHuqjEowgxe1JqMVjdXCGwYsF72ENZseORcDrSUBxqKlnOHPt9oFsw3Aw==
X-Received: by 2002:a17:902:f68f:b0:1fc:6b8b:4918 with SMTP id d9443c01a7336-1ff573bfcacmr174234245ad.41.1722985552008;
        Tue, 06 Aug 2024 16:05:52 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:9b03:120a:1a2:b3bb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59295790sm93098145ad.261.2024.08.06.16.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 16:05:51 -0700 (PDT)
Date: Tue, 6 Aug 2024 16:05:46 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, rsbecker@nexbridge.com, 
	Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [RFC PATCH v2 6/7] t/unit-tests: convert strvec tests to use clar
Message-ID: <6a6z3xduic3c6v27zeag5mxclupb4rc7a3gvoov5odpa7vqz4u@glpita3ojyxx>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, rsbecker@nexbridge.com, 
	Edward Thomson <ethomson@edwardthomson.com>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1722952908.git.ps@pks.im>
 <578e657269dd448d3de2964bba03fbff869560ba.1722952908.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <578e657269dd448d3de2964bba03fbff869560ba.1722952908.git.ps@pks.im>

On 2024.08.06 16:14, Patrick Steinhardt wrote:
> Convert the strvec tests to use the new clar unit testing framework.
> This is a first test balloon that demonstrates how the testing infra for
> clar-based tests looks like.
> 
> The tests are part of the "t/unit-tests/bin/unit-tests" binary. When
> running that binary, it generates TAP output:
> 
>     # ./t/unit-tests/bin/unit-tests
>     TAP version 13
>     # start of suite 1: strvec
>     ok 1 - strvec::init
>     ok 2 - strvec::dynamic_init
>     ok 3 - strvec::clear
>     ok 4 - strvec::push
>     ok 5 - strvec::pushft_pushf
>     ok 6 - strvec::pushl
>     ok 7 - strvec::pushv
>     ok 8 - strvec::replace_at_head
>     ok 9 - strvec::replace_at_tail
>     ok 10 - strvec::replace_in_between
>     ok 11 - strvec::replace_with_substring
>     ok 12 - strvec::remove_at_head
>     ok 13 - strvec::remove_at_tail
>     ok 14 - strvec::remove_in_between
>     ok 15 - strvec::pop_empty_array
>     ok 16 - strvec::pop_non_empty_array
>     ok 17 - strvec::split_empty_string
>     ok 18 - strvec::split_single_item
>     ok 19 - strvec::split_multiple_items
>     ok 20 - strvec::split_whitespace_only
>     ok 21 - strvec::split_multiple_consecutive_whitespaces
>     ok 22 - strvec::detach
>     1..22
> 
> The binary also supports some parameters that allow us to run only a
> subset of unit tests or alter the output:
> 
>     $ ./t/unit-tests/bin/unit-tests -h
>     Usage: ./t/unit-tests/bin/unit-tests [options]
> 
>     Options:
>       -sname        Run only the suite with `name` (can go to individual test name)
>       -iname        Include the suite with `name`
>       -xname        Exclude the suite with `name`
>       -v            Increase verbosity (show suite names)
>       -q            Only report tests that had an error
>       -Q            Quit as soon as a test fails
>       -t            Display results in tap format
>       -l            Print suite names
>       -r[filename]  Write summary file (to the optional filename)
> 
> Furthermore, running `make unit-tests` runs the binary along with all
> the other unit tests we have.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Makefile                              |   2 +-
>  t/unit-tests/{t-strvec.c => strvec.c} | 119 ++++++++++----------------
>  t/unit-tests/unit-test.c              |   3 +-
>  3 files changed, 45 insertions(+), 79 deletions(-)
>  rename t/unit-tests/{t-strvec.c => strvec.c} (54%)
> 
> diff --git a/Makefile b/Makefile
> index f56b14ad6d..cf76f9b353 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1334,6 +1334,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
>  THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
>  THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
>  
> +UNIT_TESTS_SUITES += strvec
>  UNIT_TESTS_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
>  UNIT_TESTS_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
>  UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
> @@ -1351,7 +1352,6 @@ UNIT_TEST_PROGRAMS += t-reftable-merged
>  UNIT_TEST_PROGRAMS += t-reftable-record
>  UNIT_TEST_PROGRAMS += t-strbuf
>  UNIT_TEST_PROGRAMS += t-strcmp-offset
> -UNIT_TEST_PROGRAMS += t-strvec
>  UNIT_TEST_PROGRAMS += t-trailer
>  UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
>  UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
> diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/strvec.c
> similarity index 54%
> rename from t/unit-tests/t-strvec.c
> rename to t/unit-tests/strvec.c
> index fa1a041469..d782c5f73b 100644
> --- a/t/unit-tests/t-strvec.c
> +++ b/t/unit-tests/strvec.c
> @@ -1,52 +1,46 @@
> -#include "test-lib.h"
> +#include "unit-test.h"
>  #include "strbuf.h"
>  #include "strvec.h"
>  
>  #define check_strvec(vec, ...) \
>  	do { \
>  		const char *expect[] = { __VA_ARGS__ }; \
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
> +		cl_assert(ARRAY_SIZE(expect) > 0); \
> +		cl_assert_equal_p(expect[ARRAY_SIZE(expect) - 1], NULL); \
> +		cl_assert_equal_i((vec)->nr, ARRAY_SIZE(expect) - 1); \
> +		cl_assert((vec)->nr <= (vec)->alloc); \
> +		for (size_t i = 0; i < ARRAY_SIZE(expect); i++) \
> +			cl_assert_equal_s((vec)->v[i], expect[i]); \
>  	} while (0)
>  
> -static void t_static_init(void)
> +void test_strvec__init(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
> -	check_pointer_eq(vec.v, empty_strvec);
> -	check_uint(vec.nr, ==, 0);
> -	check_uint(vec.alloc, ==, 0);
> +	cl_assert_equal_p(vec.v, empty_strvec);
> +	cl_assert(vec.nr == 0);
> +	cl_assert(vec.alloc == 0);

Is there a reason you used cl_assert() instead of cl_assert_equal_i()
for the .nr and .alloc checks here and below?


>  }
>  
> -static void t_dynamic_init(void)
> +void test_strvec__dynamic_init(void)
>  {
>  	struct strvec vec;
>  	strvec_init(&vec);
> -	check_pointer_eq(vec.v, empty_strvec);
> -	check_uint(vec.nr, ==, 0);
> -	check_uint(vec.alloc, ==, 0);
> +	cl_assert_equal_p(vec.v, empty_strvec);
> +	cl_assert(vec.nr == 0);
> +	cl_assert(vec.alloc == 0);
>  }
>  
> -static void t_clear(void)
> +void test_strvec__clear(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_push(&vec, "foo");
>  	strvec_clear(&vec);
> -	check_pointer_eq(vec.v, empty_strvec);
> -	check_uint(vec.nr, ==, 0);
> -	check_uint(vec.alloc, ==, 0);
> +	cl_assert_equal_p(vec.v, empty_strvec);
> +	cl_assert(vec.nr == 0);
> +	cl_assert(vec.alloc == 0);
>  }
>  
> -static void t_push(void)
> +void test_strvec__push(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  
> @@ -59,7 +53,7 @@ static void t_push(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_pushf(void)
> +void test_strvec__pushf(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_pushf(&vec, "foo: %d", 1);
> @@ -67,7 +61,7 @@ static void t_pushf(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_pushl(void)
> +void test_strvec__pushl(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> @@ -75,7 +69,7 @@ static void t_pushl(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_pushv(void)
> +void test_strvec__pushv(void)
>  {
>  	const char *strings[] = {
>  		"foo", "bar", "baz", NULL,
> @@ -88,7 +82,7 @@ static void t_pushv(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_replace_at_head(void)
> +void test_strvec__replace_at_head(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> @@ -97,7 +91,7 @@ static void t_replace_at_head(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_replace_at_tail(void)
> +void test_strvec__replace_at_tail(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> @@ -106,7 +100,7 @@ static void t_replace_at_tail(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_replace_in_between(void)
> +void test_strvec__replace_in_between(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> @@ -115,7 +109,7 @@ static void t_replace_in_between(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_replace_with_substring(void)
> +void test_strvec__replace_with_substring(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_pushl(&vec, "foo", NULL);
> @@ -124,7 +118,7 @@ static void t_replace_with_substring(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_remove_at_head(void)
> +void test_strvec__remove_at_head(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> @@ -133,7 +127,7 @@ static void t_remove_at_head(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_remove_at_tail(void)
> +void test_strvec__remove_at_tail(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> @@ -142,7 +136,7 @@ static void t_remove_at_tail(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_remove_in_between(void)
> +void test_strvec__remove_in_between(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> @@ -151,7 +145,7 @@ static void t_remove_in_between(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_pop_empty_array(void)
> +void test_strvec__pop_empty_array(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_pop(&vec);
> @@ -159,7 +153,7 @@ static void t_pop_empty_array(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_pop_non_empty_array(void)
> +void test_strvec__pop_non_empty_array(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> @@ -168,7 +162,7 @@ static void t_pop_non_empty_array(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_split_empty_string(void)
> +void test_strvec__split_empty_string(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_split(&vec, "");
> @@ -176,7 +170,7 @@ static void t_split_empty_string(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_split_single_item(void)
> +void test_strvec__split_single_item(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_split(&vec, "foo");
> @@ -184,7 +178,7 @@ static void t_split_single_item(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_split_multiple_items(void)
> +void test_strvec__split_multiple_items(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_split(&vec, "foo bar baz");
> @@ -192,7 +186,7 @@ static void t_split_multiple_items(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_split_whitespace_only(void)
> +void test_strvec__split_whitespace_only(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_split(&vec, " \t\n");
> @@ -200,7 +194,7 @@ static void t_split_whitespace_only(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_split_multiple_consecutive_whitespaces(void)
> +void test_strvec__split_multiple_consecutive_whitespaces(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	strvec_split(&vec, "foo\n\t bar");
> @@ -208,7 +202,7 @@ static void t_split_multiple_consecutive_whitespaces(void)
>  	strvec_clear(&vec);
>  }
>  
> -static void t_detach(void)
> +void test_strvec__detach(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
>  	const char **detached;
> @@ -216,40 +210,13 @@ static void t_detach(void)
>  	strvec_push(&vec, "foo");
>  
>  	detached = strvec_detach(&vec);
> -	check_str(detached[0], "foo");
> -	check_pointer_eq(detached[1], NULL);
> +	cl_assert_equal_s(detached[0], "foo");
> +	cl_assert_equal_p(detached[1], NULL);
>  
> -	check_pointer_eq(vec.v, empty_strvec);
> -	check_uint(vec.nr, ==, 0);
> -	check_uint(vec.alloc, ==, 0);
> +	cl_assert_equal_p(vec.v, empty_strvec);
> +	cl_assert(vec.nr == 0);
> +	cl_assert(vec.alloc == 0);
>  
>  	free((char *) detached[0]);
>  	free(detached);
>  }
> -
> -int cmd_main(int argc, const char **argv)
> -{
> -	TEST(t_static_init(), "static initialization");
> -	TEST(t_dynamic_init(), "dynamic initialization");
> -	TEST(t_clear(), "clear");
> -	TEST(t_push(), "push");
> -	TEST(t_pushf(), "pushf");
> -	TEST(t_pushl(), "pushl");
> -	TEST(t_pushv(), "pushv");
> -	TEST(t_replace_at_head(), "replace at head");
> -	TEST(t_replace_in_between(), "replace in between");
> -	TEST(t_replace_at_tail(), "replace at tail");
> -	TEST(t_replace_with_substring(), "replace with substring");
> -	TEST(t_remove_at_head(), "remove at head");
> -	TEST(t_remove_in_between(), "remove in between");
> -	TEST(t_remove_at_tail(), "remove at tail");
> -	TEST(t_pop_empty_array(), "pop with empty array");
> -	TEST(t_pop_non_empty_array(), "pop with non-empty array");
> -	TEST(t_split_empty_string(), "split empty string");
> -	TEST(t_split_single_item(), "split single item");
> -	TEST(t_split_multiple_items(), "split multiple items");
> -	TEST(t_split_whitespace_only(), "split whitespace only");
> -	TEST(t_split_multiple_consecutive_whitespaces(), "split multiple consecutive whitespaces");
> -	TEST(t_detach(), "detach");
> -	return test_done();
> -}
> diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
> index 32a81299e9..82b7635e6a 100644
> --- a/t/unit-tests/unit-test.c
> +++ b/t/unit-tests/unit-test.c
> @@ -6,10 +6,9 @@ int cmd_main(int argc, const char **argv)
>  	int ret;
>  
>  	/* Append the "-t" flag such that the tests generate TAP output. */
> -	ALLOC_ARRAY(argv_copy, argc + 2);
> +	ALLOC_ARRAY(argv_copy, argc + 1);
>  	COPY_ARRAY(argv_copy, argv, argc);
>  	argv_copy[argc++] = "-t";
> -	argv_copy[argc] = NULL;
>  
>  	ret = clar_test(argc, (char **) argv_copy);
>  
> -- 
> 2.46.0.dirty
> 


