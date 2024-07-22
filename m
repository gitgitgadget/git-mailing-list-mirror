Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8636317C7C
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721675601; cv=none; b=BoyLf94Y/TIK+1k+wVgQJdb0efUuESPNQ5LD3Z+xDpiDbejF5B+2rfn05M10bctWcFg9vllCMzpv2p1B4RjIgPn2PSxlwLilZuiAaUWxLjizrftOQZJSY7LGUucXJAjcIJMxiHH3Ak2qrM8elMl/xfF4lB0mP5C8FXFRlyxnwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721675601; c=relaxed/simple;
	bh=m8ljtuuyATyLc2JPTP57sgycx1zY/rZ7+jjpiiib+rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FR1Sm+FPxxTf/7VF4DnjpHZenFB8Sgp0JRJ+9uz2C6NkPPqggf/vrMuQbysuTD6bnRDSdClhs96UbQ1gVkKB9jCA6Is6l8imVsTWhYwm7/S5OXdGX/V/ivkhHBb+f1b9PpICwbndwcQdjRlWV7C637iYMlBlw+OD8HxCGWLouB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvsvMOZM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvsvMOZM"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so4194417a12.0
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 12:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721675598; x=1722280398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdPGBRsVcJNKoURp7CvTFDIHeLS7dW2UWPi/0SdmGpM=;
        b=JvsvMOZM2Ko96fdptiD3icNZf0/0zBrbsnKPs/sgUCXHNAY9G7yU3fdHrhPy/u6B6o
         QnR3LMj4T85fzwAm3j0K+aACHkyyfuJvqK67pq/7jD7BfHBmeK1dmsYxp4Agp2lqqzjz
         9stVs/gtWqd5HxS8vV0ejMfzd5egYCpYzX8jLiSZzuhyl/kVhRL02rqN6+Jmb3UW87Cw
         6sux0UEKAC1q7lJVKc6nCWjRfM9TAvrHJ0Qg6eDdqtujzpPfy+M88PJ0aTBmZPX7ZJfL
         2nLBEAz4m/RNIPc89T2egfB97Op2Be2+8joiMTkrwNQj6EzhWfgq+WHvkLiOxhgATmrM
         y2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721675598; x=1722280398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdPGBRsVcJNKoURp7CvTFDIHeLS7dW2UWPi/0SdmGpM=;
        b=QT4eOzXsTJ88iTE4sXS4BQq3KvIXUgDFgODTvluuvuXAWcPJaveFoyam+8fxWFGqlo
         ofMBBxNYr5NrbBj1ivzRlqCo+1lTbZSQvb34e8PpWgRMQVXcXTc0j7XTKncQ+iiedJ2n
         kQFNnOBCWk6lq0rjeQFjd5FE74//03Ec97vUlCgQ3jDYwTqqVoggt8iP6AHKnakGJQOa
         mZB5eTULQR+81SeHwsWWUU3MdlvzmT8NpGBQV0Tc2ycfiPcXLKhxjARg9qT3iL2fbjf1
         RWzmW1VVIRTSjgY9vwZfZeVK1GPRMt9uhResxrVKqO0a8+Yi+wLgnKJC+FhFWxhsYyPr
         1t0Q==
X-Gm-Message-State: AOJu0YxD0SKmVpDxdnqA21jHn+NMZuzdZEhQqOa5e156ezLHjHZVSv5S
	zH8zJqv0+CIxgoHnSLgDCdzcIjHlLlr1ycLUiJz386jjy0qSgjYx+2tn1CjmwdtpUEP9/llv/uU
	ssTj8pRwGBbL0uT/dIjjZxyuVaWCYCIcL9uQtlQ93BANKBrN2KQ==
X-Google-Smtp-Source: AGHT+IFmdo+r00pvUTKOMIjJRcNmulehKDd5b09PBEgR69I7U+HWrBYmtXRBDDt+ZxVgB8WUk5HWPsG8hHR46l1xEwQ=
X-Received: by 2002:a17:907:7285:b0:a77:dd1c:6270 with SMTP id
 a640c23a62f3a-a7a4bf39d1bmr552711366b.5.1721675597152; Mon, 22 Jul 2024
 12:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de> <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
In-Reply-To: <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 22 Jul 2024 12:13:00 -0700
Message-ID: <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 11:22=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> w=
rote:
>
> The macro TEST only allows defining a test that consists of a single
> expression.  Add a new macro, for_test, which provides a way to define
> unit tests that are made up of one or more statements.
>
> for_test allows defining self-contained tests en bloc, a bit like
> test_expect_success does for regular tests.  It acts like a for loop
> that runs at most once; the test body is executed if test_skip_all()
> had not been called before.

I can see based on this description where the name came from, but
without this context, it's not clear when reading a test what it
actually does. The name comes from an implementation detail, and is
not describing what it _does_, just _how_ it does it.

Maybe a name like `small_test` or `quick_test` or something like that
would better express the intended usage?

>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  .clang-format               |  2 ++
>  t/helper/test-example-tap.c | 33 +++++++++++++++++++++++++++++++++
>  t/t0080/expect              | 35 ++++++++++++++++++++++++++++++++++-
>  t/unit-tests/test-lib.h     | 19 +++++++++++++++++++
>  4 files changed, 88 insertions(+), 1 deletion(-)
>
> diff --git a/.clang-format b/.clang-format
> index 6408251577..863dc87dfc 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -151,6 +151,7 @@ Cpp11BracedListStyle: false
>  # function calls. Taken from:
>  #   git grep -h '^#define [^[:space:]]*for_\?each[^[:space:]]*(' |
>  #   sed "s/^#define /  - '/; s/(.*$/'/" | sort | uniq
> +# Added for_test from t/unit-tests/test-lib.h manually as a special case=
.
>  ForEachMacros:
>    - 'for_each_builtin'
>    - 'for_each_string_list_item'
> @@ -168,6 +169,7 @@ ForEachMacros:
>    - 'strintmap_for_each_entry'
>    - 'strmap_for_each_entry'
>    - 'strset_for_each_entry'
> +  - 'for_test'
>
>  # The maximum number of consecutive empty lines to keep.
>  MaxEmptyLinesToKeep: 1
> diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
> index d072ad559f..51d5e6e75b 100644
> --- a/t/helper/test-example-tap.c
> +++ b/t/helper/test-example-tap.c
> @@ -92,5 +92,38 @@ int cmd__example_tap(int argc, const char **argv)
>         test_res =3D TEST(t_empty(), "test with no checks");
>         TEST(check_int(test_res, =3D=3D, 0), "test with no checks returns=
 0");
>
> +       for_test ("for_test passing test")
> +               check_int(1, =3D=3D, 1);

I'm concerned that users will write this like:
+       for_test ("for_test passing test");
+               check_int(1, =3D=3D, 1);

And the issue won't be caught. Maybe that's fine; the only issue here
is that it's not going to be as descriptive if it fails, right?

> +       for_test ("for_test failing test")
> +               check_int(1, =3D=3D, 2);
> +       for_test ("for_test passing TEST_TODO()")
> +               TEST_TODO(check(0));
> +       for_test ("for_test failing TEST_TODO()")
> +               TEST_TODO(check(1));
> +       for_test ("for_test test_skip()") {
> +               check(0);
> +               test_skip("missing prerequisite");
> +               check(1);
> +       }
> +       for_test ("for_test test_skip() inside TEST_TODO()")
> +               TEST_TODO((test_skip("missing prerequisite"), 1));
> +       for_test ("for_test TEST_TODO() after failing check") {
> +               check(0);
> +               TEST_TODO(check(0));
> +       }
> +       for_test ("for_test failing check after TEST_TODO()") {
> +               check(1);
> +               TEST_TODO(check(0));
> +               check(0);
> +       }
> +       for_test ("for_test messages from failing string and char compari=
son") {
> +               check_str("\thello\\", "there\"\n");
> +               check_str("NULL", NULL);
> +               check_char('a', =3D=3D, '\n');
> +               check_char('\\', =3D=3D, '\'');
> +       }
> +       for_test ("for_test test with no checks")
> +               ; /* nothing */
> +
>         return test_done();
>  }
> diff --git a/t/t0080/expect b/t/t0080/expect
> index 0cfa0dc6d8..583f41b8c9 100644
> --- a/t/t0080/expect
> +++ b/t/t0080/expect
> @@ -40,4 +40,37 @@ not ok 17 - messages from failing string and char comp=
arison
>  # BUG: test has no checks at t/helper/test-example-tap.c:92
>  not ok 18 - test with no checks
>  ok 19 - test with no checks returns 0
> -1..19
> +ok 20 - for_test passing test
> +# check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:98
> +#    left: 1
> +#   right: 2
> +not ok 21 - for_test failing test
> +not ok 22 - for_test passing TEST_TODO() # TODO
> +# todo check 'check(1)' succeeded at t/helper/test-example-tap.c:102
> +not ok 23 - for_test failing TEST_TODO()
> +# check "0" failed at t/helper/test-example-tap.c:104
> +# skipping test - missing prerequisite
> +# skipping check '1' at t/helper/test-example-tap.c:106
> +ok 24 - for_test test_skip() # SKIP
> +# skipping test - missing prerequisite
> +ok 25 - for_test test_skip() inside TEST_TODO() # SKIP
> +# check "0" failed at t/helper/test-example-tap.c:111
> +not ok 26 - for_test TEST_TODO() after failing check
> +# check "0" failed at t/helper/test-example-tap.c:117
> +not ok 27 - for_test failing check after TEST_TODO()
> +# check "!strcmp("\thello\\", "there\"\n")" failed at t/helper/test-exam=
ple-tap.c:120
> +#    left: "\011hello\\"
> +#   right: "there\"\012"
> +# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:12=
1
> +#    left: "NULL"
> +#   right: NULL
> +# check "'a' =3D=3D '\n'" failed at t/helper/test-example-tap.c:122
> +#    left: 'a'
> +#   right: '\012'
> +# check "'\\' =3D=3D '\''" failed at t/helper/test-example-tap.c:123
> +#    left: '\\'
> +#   right: '\''
> +not ok 28 - for_test messages from failing string and char comparison
> +# BUG: test has no checks at t/helper/test-example-tap.c:125
> +not ok 29 - for_test test with no checks
> +1..29
> diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
> index 2de6d715d5..12afd47ac9 100644
> --- a/t/unit-tests/test-lib.h
> +++ b/t/unit-tests/test-lib.h
> @@ -14,6 +14,25 @@
>         test__run_end(test__run_begin() ? 0 : (t, 1),   \
>                       TEST_LOCATION(),  __VA_ARGS__)
>
> +/*
> + * Run a test unless test_skip_all() has been called.  Acts like a for
> + * loop that runs at most once, with the test description between the
> + * parentheses and the test body as a statement or block after them.
> + * The description for each test should be unique.  E.g.:
> + *
> + *  for_test ("something else %d %d", arg1, arg2) {
> + *          prepare();
> + *          test_something_else(arg1, arg2);
> + *          cleanup();
> + *  }
> + */
> +#define for_test(...)                                                  \
> +       for (int for_test_running_ =3D test__run_begin() ?               =
 \
> +               (test__run_end(0, TEST_LOCATION(), __VA_ARGS__), 0) : 1;\
> +            for_test_running_;                                         \
> +            test__run_end(1, TEST_LOCATION(), __VA_ARGS__),            \
> +               for_test_running_ =3D 0)

IMHO: this is borderline "too much magic" for my tastes. I think
having multiple test functions is generally easier to understand, and
the overhead isn't really relevant. It's not _as_ compact in the
source file, and requires that we have both the TEST statement and the
function (and forgetting the TEST statement means that we won't invoke
the function). If that is the main issue we're facing here, I wonder
if there's some other way of resolving that (such as unused function
detection via some compiler flags; even if it's not detected on all
platforms, getting at least one of the CI platforms should be
sufficient to prevent the issue [but we should target as many as
possible, so it's caught earlier than "I tried to send it to the
list"])

If others agree that this is a good simplification for the people
reading the test code (and hopefully for the test author), I'm fine
with this going in (with a different name). I'm not trying to veto the
concept.


> +
>  /*
>   * Print a test plan, should be called before any tests. If the number
>   * of tests is not known in advance test_done() will automatically
> --
> 2.45.2
>
