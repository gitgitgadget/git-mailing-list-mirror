Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1A101EE
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463486; cv=none; b=FgU0p4flEyLrG8qnFyS1PXcntCSJvX8Ulh8AGKXE9Z2GUdOtQPJm+9lsTYd/IbYUwGVjArjVF1HkK00aF1So6iQ6ZpAVVEQCMeMNe1j+24EzrcyLe/mBWm3lNBOLuauEo1E48FYcGbpFIuGJ6VzamMSuv+NlYB29CBfAlKdk94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463486; c=relaxed/simple;
	bh=dT0ZVFG/4mDo1rlMPGYAd3w2tHRwyWHCbukRBtUVxx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHT2lmeplLSeDeFdrn0jS04awODaq64L5r8/mhi4cX7A0lKQWwVtAZzYh3foly52avMpOZZPF+aD94TmlQGqVFfxWzOk382w8KJG8AddNeVjVq1/h7Xth4NKiwmCSYZqzcN+DC/eLh+q1gxg9XzuXXqSZFWh91wXfc+mWaShroM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m2LDqcae; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2LDqcae"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7abf92f57bso820646066b.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 15:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722463482; x=1723068282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWzXsUAedkwyYqezW48VvsmaFpytwqk7QBa9Td7iom8=;
        b=m2LDqcae9C7+GsWNLogotmza8M97lyi/gPeyP9Yfy9DrvI622fOnt2a3+hu+CWWiEv
         CwngvpDXVWNAISuXJsrBpfCrHWvY50M+rD2B8VW/dsXNfa6nM3yAQR+8A0uwPJvxf8Ke
         CQqP5J4E6wCdn/ju2kf/Fhd1BoYrp60gZjbTHN4Zo5l8+kKdUoKJiPV3VQdpx2HQJcF3
         IKnyh8Fo+Je0olpiH7YUzdaBLhynC830aIxYPHva3UiPRFNu0k+epXrFU3m3SWsbZZM5
         JW7BT4BjXDxPXIQ4B1FpLSVbt4mY9hauelW8w/G1M5qODnvA1oe9txXK8UaueU6xKJDD
         BL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722463482; x=1723068282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWzXsUAedkwyYqezW48VvsmaFpytwqk7QBa9Td7iom8=;
        b=eL5Xi48lOQPeThfgFbsx8V5hX2DxztPFjMm8KSqOFIJQ0+EL3rg/B0gi4eaZrsUgVz
         VOXTRqPOZPnDrRyKVfnWoPK+HNj0upY10+dWam1iAtQv5O6W9cLYcgEsMT2NMKCe8hDN
         RQtGpayzXFnlJqGbF6yAQzJSfsk92Vs5KgSjfeXhKaJyPr5B+u6m0HrzI+Ne/OaHnuOV
         QmVj/wj+6s5lH3bemNOxsSyL+5QXrjYPMk9T9L3UQKx6NpF51D42Trm0dUw5OzRVSkZN
         Xy1zoxNWkeqFRm5vUOvmZ9ZCzGS3wnqu4FlwoDYEvH08BDipN36ctu09fTEARVCTaaJ0
         9tTQ==
X-Gm-Message-State: AOJu0YxmurKp5dvvUlZZKvgXXWx2aI5kKjLDIszZqfAU0STjiQgWCNTX
	MZfPGE4diNHnNHz4y1tM5FZjiX6V9jHRbmcynqgHIcK9uk+yvE6dMCDfAmu/TWwEsQyE0+9FhPI
	sbwRS5hPclYQNQ4eEWYMYuyOdneJjq2AjeRnf
X-Google-Smtp-Source: AGHT+IFf3pME3zJo19Ot/A+BVBBAOxwkZJVc9yN2HeUc02wSBegmY2hYGVL2+FuPYUnuHJlUl0/We4q6KgIFS6o0n8U=
X-Received: by 2002:a17:907:c1f:b0:a72:8066:c76f with SMTP id
 a640c23a62f3a-a7daf76a1dcmr37630766b.63.1722463482046; Wed, 31 Jul 2024
 15:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de> <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
 <da902de9-288e-4783-8b4b-a2a968d1e1f8@web.de>
In-Reply-To: <da902de9-288e-4783-8b4b-a2a968d1e1f8@web.de>
From: Kyle Lippincott <spectral@google.com>
Date: Wed, 31 Jul 2024 15:04:25 -0700
Message-ID: <CAO_smVh_2FEbTAqJDMZAKMsfTKrB=NH36G6jNmMTaEOtRaP2Pg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] unit-tests: add if_test
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 7:08=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> The macro TEST only allows defining a test that consists of a single
> expression.  Add a new macro, if_test, which provides a way to define
> unit tests that are made up of one or more statements.
>
> if_test allows defining self-contained tests en bloc, a bit like
> test_expect_success does for regular tests.  It acts like a conditional;
> the test body is executed if test_skip_all() had not been called before.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  .clang-format               |  5 +++++
>  t/helper/test-example-tap.c | 33 +++++++++++++++++++++++++++++++++
>  t/t0080-unit-test-output.sh | 35 ++++++++++++++++++++++++++++++++++-
>  t/unit-tests/test-lib.c     | 29 +++++++++++++++++++++++++++++
>  t/unit-tests/test-lib.h     | 20 ++++++++++++++++++++
>  5 files changed, 121 insertions(+), 1 deletion(-)
>
> diff --git a/.clang-format b/.clang-format
> index 6408251577..4c6d317508 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -169,6 +169,11 @@ ForEachMacros:
>    - 'strmap_for_each_entry'
>    - 'strset_for_each_entry'
>
> +# A list of macros that should be interpreted as conditionals instead of=
 as
> +# function calls.
> +IfMacros:
> +  - 'if_test'
> +
>  # The maximum number of consecutive empty lines to keep.
>  MaxEmptyLinesToKeep: 1
>
> diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
> index 79c12b01cd..914af88e0a 100644
> --- a/t/helper/test-example-tap.c
> +++ b/t/helper/test-example-tap.c
> @@ -94,5 +94,38 @@ int cmd__example_tap(int argc, const char **argv)
>         test_res =3D TEST(t_empty(), "test with no checks");
>         TEST(check_int(test_res, =3D=3D, 0), "test with no checks returns=
 0");
>
> +       if_test ("if_test passing test")
> +               check_int(1, =3D=3D, 1);
> +       if_test ("if_test failing test")
> +               check_int(1, =3D=3D, 2);
> +       if_test ("if_test passing TEST_TODO()")
> +               TEST_TODO(check(0));
> +       if_test ("if_test failing TEST_TODO()")
> +               TEST_TODO(check(1));
> +       if_test ("if_test test_skip()") {
> +               check(0);
> +               test_skip("missing prerequisite");
> +               check(1);
> +       }
> +       if_test ("if_test test_skip() inside TEST_TODO()")
> +               TEST_TODO((test_skip("missing prerequisite"), 1));
> +       if_test ("if_test TEST_TODO() after failing check") {
> +               check(0);
> +               TEST_TODO(check(0));
> +       }
> +       if_test ("if_test failing check after TEST_TODO()") {
> +               check(1);
> +               TEST_TODO(check(0));
> +               check(0);
> +       }
> +       if_test ("if_test messages from failing string and char compariso=
n") {
> +               check_str("\thello\\", "there\"\n");
> +               check_str("NULL", NULL);
> +               check_char('a', =3D=3D, '\n');
> +               check_char('\\', =3D=3D, '\'');
> +       }
> +       if_test ("if_test test with no checks")
> +               ; /* nothing */
> +
>         return test_done();
>  }
> diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
> index fe221f3bdb..3c369c88e2 100755
> --- a/t/t0080-unit-test-output.sh
> +++ b/t/t0080-unit-test-output.sh
> @@ -50,7 +50,40 @@ test_expect_success 'TAP output from unit tests' - <<\=
EOT
>         # BUG: test has no checks at t/helper/test-example-tap.c:94
>         not ok 18 - test with no checks
>         ok 19 - test with no checks returns 0
> -       1..19
> +       ok 20 - if_test passing test
> +       # check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:100
> +       #    left: 1
> +       #   right: 2
> +       not ok 21 - if_test failing test
> +       not ok 22 - if_test passing TEST_TODO() # TODO
> +       # todo check 'check(1)' succeeded at t/helper/test-example-tap.c:=
104
> +       not ok 23 - if_test failing TEST_TODO()
> +       # check "0" failed at t/helper/test-example-tap.c:106
> +       # skipping test - missing prerequisite
> +       # skipping check '1' at t/helper/test-example-tap.c:108
> +       ok 24 - if_test test_skip() # SKIP
> +       # skipping test - missing prerequisite
> +       ok 25 - if_test test_skip() inside TEST_TODO() # SKIP
> +       # check "0" failed at t/helper/test-example-tap.c:113
> +       not ok 26 - if_test TEST_TODO() after failing check
> +       # check "0" failed at t/helper/test-example-tap.c:119
> +       not ok 27 - if_test failing check after TEST_TODO()
> +       # check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/=
test-example-tap.c:122
> +       #    left: "\011hello\\\\"
> +       #   right: "there\"\012"
> +       # check "!strcmp("NULL", NULL)" failed at t/helper/test-example-t=
ap.c:123
> +       #    left: "NULL"
> +       #   right: NULL
> +       # check "'a' =3D=3D '\n'" failed at t/helper/test-example-tap.c:1=
24
> +       #    left: 'a'
> +       #   right: '\012'
> +       # check "'\\\\' =3D=3D '\\''" failed at t/helper/test-example-tap=
.c:125
> +       #    left: '\\\\'
> +       #   right: '\\''
> +       not ok 28 - if_test messages from failing string and char compari=
son
> +       # BUG: test has no checks at t/helper/test-example-tap.c:127
> +       not ok 29 - if_test test with no checks
> +       1..29
>         EOF
>
>         ! test-tool example-tap >actual &&
> diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
> index 989dc758e6..fa1f95965c 100644
> --- a/t/unit-tests/test-lib.c
> +++ b/t/unit-tests/test-lib.c
> @@ -16,6 +16,8 @@ static struct {
>         unsigned running :1;
>         unsigned skip_all :1;
>         unsigned todo :1;
> +       char location[100];
> +       char description[100];
>  } ctx =3D {
>         .lazy_plan =3D 1,
>         .result =3D RESULT_NONE,
> @@ -125,6 +127,8 @@ void test_plan(int count)
>
>  int test_done(void)
>  {
> +       if (ctx.running && ctx.location[0] && ctx.description[0])
> +               test__run_end(1, ctx.location, "%s", ctx.description);
>         assert(!ctx.running);
>
>         if (ctx.lazy_plan)
> @@ -167,13 +171,38 @@ void test_skip_all(const char *format, ...)
>         va_end(ap);
>  }
>
> +void test__run_describe(const char *location, const char *format, ...)
> +{
> +       va_list ap;
> +       int len;
> +
> +       assert(ctx.running);
> +       assert(!ctx.location[0]);
> +       assert(!ctx.description[0]);
> +
> +       xsnprintf(ctx.location, sizeof(ctx.location), "%s",
> +                 make_relative(location));
> +
> +       va_start(ap, format);
> +       len =3D vsnprintf(ctx.description, sizeof(ctx.description), forma=
t, ap);
> +       va_end(ap);
> +       if (len < 0)
> +               die("unable to format message: %s", format);
> +       if (len >=3D sizeof(ctx.description))
> +               BUG("ctx.description too small to format %s", format);
> +}
> +
>  int test__run_begin(void)
>  {
> +       if (ctx.running && ctx.location[0] && ctx.description[0])
> +               test__run_end(1, ctx.location, "%s", ctx.description);
>         assert(!ctx.running);
>
>         ctx.count++;
>         ctx.result =3D RESULT_NONE;
>         ctx.running =3D 1;
> +       ctx.location[0] =3D '\0';
> +       ctx.description[0] =3D '\0';
>
>         return ctx.skip_all;
>  }
> diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
> index 2de6d715d5..f15dceb29e 100644
> --- a/t/unit-tests/test-lib.h
> +++ b/t/unit-tests/test-lib.h
> @@ -14,6 +14,23 @@
>         test__run_end(test__run_begin() ? 0 : (t, 1),   \
>                       TEST_LOCATION(),  __VA_ARGS__)
>
> +/*
> + * Run a test unless test_skip_all() has been called.  Acts like a
> + * conditional; the test body is expected as a statement or block after
> + * the closing parenthesis.  The description for each test should be
> + * unique.  E.g.:
> + *
> + *  if_test ("something else %d %d", arg1, arg2) {
> + *          prepare();
> + *          test_something_else(arg1, arg2);
> + *          cleanup();
> + *  }
> + */
> +#define if_test(...)                                                   \
> +       if (test__run_begin() ?                                         \
> +           (test__run_end(0, TEST_LOCATION(),  __VA_ARGS__), 0) :      \
> +           (test__run_describe(TEST_LOCATION(),  __VA_ARGS__), 1))
> +

I personally prefer this implementation much more than the `for_test`
implementation, thanks. I think the extra functionality/usability from
having `test__run_end` automatically called is also very useful.

I'm still not wild about the name, and I'm still not convinced of the
readability improvements. I still want to read `if_test(...)` as
having a condition in the parenthesis. Tests "skipping everything"
seems like an internal implementation detail that there's disagreement
on whether to expose to the test author/reader or not; maybe we should
redesign if we don't migrate to clar or some other test framework. Do
we get significant benefits from a test function continuing to execute
after the "skip everything" flag has been set?

Specifically, the only current user of `test_skip_all` is t-strbuf.c.
Maybe we do this in t-strbuf.c, and remove the "skip everything"
logic? Below, `test_skipping_remainder` does most of the stuff that
`test_skip_all` does, except:
- automatically calls test_done()
- "poison"s some state so that we can't call `test__run_begin`
anymore, if test author forgets to `return` from this

  int cmd_main(int argc, const char **argv)
  {
    if (!TEST(t_static_init(), "static initialization works"))
-     test_skip_all("STRBUF_INIT is broken");
+    return test_skipping_remainder("STRBUF_INIT is broken");
    TEST(t_dynamic_init(), "dynamic initialization works");
    TEST(setup(t_addch, "a"), "strbuf_addch adds char");
    TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
    TEST(setup_populated(t_addch, "initial value", "a"),
         "strbuf_addch appends to initial value");
    TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
    TEST(setup_populated(t_addstr, "initial value", "hello there"),
         "strbuf_addstr appends string to initial value");

    return test_done();
  }

With that out of the way, I think that `test__run_begin()` always
returns true, and calling `test__run_end()` isn't necessary, so this
would be able to become:

#define if_test(...) \
    if (test__run_describe(TEST_LOCATION(), __VA_ARGS__), 1)  /*
automatically calls test__run_begin() */

At that point, the `if` is just used to allow this syntax:

if_test("example if_test") {
    check_int(1, =3D=3D, 1);
    check_int(1, !=3D, 2);
}

But it's equivalent, since we don't have any conditional that we're
actually checking, to:

{
    if_test("example if_test");  /* note the semicolon; leaving it off
doesn't matter, as long as compiler doesn't complain about empty if
block */
    check_int(1, =3D=3D, 1);
    check_int(1, !=3D, 2);
}

Or even doing that without the {}. At that point, we can remove the
`if` aspect of the name, and get something like this, where you can
use {} blocks if needed or desired:

#define multiline_test(...) test__run_describe(TEST_LOCATION(), __VA_ARGS__=
)

multiline_test("equality");  /* semicolon required */
check_int(1, =3D=3D, 1);
check_int(2, =3D=3D, 2);
multiline_test("inequality");
check_int(1, !=3D, 2);
check_int(2, !=3D, 1);


>  /*
>   * Print a test plan, should be called before any tests. If the number
>   * of tests is not known in advance test_done() will automatically
> @@ -153,6 +170,9 @@ union test__tmp {
>
>  extern union test__tmp test__tmp[2];
>
> +__attribute__((format (printf, 2, 3)))
> +void test__run_describe(const char *, const char *, ...);
> +
>  int test__run_begin(void);
>  __attribute__((format (printf, 3, 4)))
>  int test__run_end(int, const char *, const char *, ...);
> --
> 2.46.0
