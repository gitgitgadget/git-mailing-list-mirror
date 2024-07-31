Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423BE1BC40
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459839; cv=none; b=sQnkcGGOfLFTGDg/vLmuYvimztHi4e5b4jAHo9PCvN8FKqdP4Ay6S2Fmp8l2uFPylX1DeiLU7k3pdbjrv4b9fa3/Ziifxv4TtVwj8B7Gf9TlpJf05IxkucQxYkMXe4/sC8R+AD0OmBF50qQw++c7+pnFUzvvyW58wNNQMRjUS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459839; c=relaxed/simple;
	bh=tIefSMNWQcbRUAsYZDK5jlLEdpgw8dn+7w4tOsj/Qkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bm8Zgx0l9sZKBbTIJFnt/O9FLH5uRKumT0WV15Gti12X49n0aYN4IVBpxqM/fPeHQWysvhBgGiwZ5fV7WUPaW8mRqUYhmLCw/68fs41E5UBtIax79XBJvhTgyfHSFincQGvYhn0P/T3IdJ8rdrVukLxE9/gwl1ySfexVtcy3hRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=08qtSide; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="08qtSide"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c667b28c82so775139eaf.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722459837; x=1723064637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLtji4iXhRtDsHeUeIHqFy27igwdF+3dz1/Q/8wRX6c=;
        b=08qtSide+IGNyZbw789UPyswLo36mCqMyE/cMkIPd3u9YKxrJ4XCqMQ9++Bpc2k0s2
         GlAWS9TwDurCYZjm2IdYqftKbF+Rwoc8q+XUS4MNptA2dB6Tnxc+gn8OANBJ9+WAUsBA
         Wwm/Osn4BC5M+V+4sBORxgyfI2rHmN/Mdt/UYkfX87zC20JRBdpChBe4BICG7a/71Lfd
         E948VLEppj/ISbcrk6ZeifTqeFmZbpEMPkG/kzXyc8AF6VSCmxvBy94Ac7rgAa59Bi5w
         c6lcXiQDBWcET3yWi03vUmFGO2zLMBaKUj6LK6MUacB35CSErZQYuTyfrSQ+YNv8Kp3C
         pipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722459837; x=1723064637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLtji4iXhRtDsHeUeIHqFy27igwdF+3dz1/Q/8wRX6c=;
        b=nfT71EgT+o6KjJagARuMpA/MQBD/ivlhDFBTT2Qf8v5rVU1rNWSXZrmF+0x/MYjIxu
         1gEW2Vv4+/cBX4+Vr83nmYQ+yHFf+6ccl0m6koC8lwQI7tYz2E2gb6p69vDldfD6AjvP
         SwEIEN3QfSQihwMR2y5rCs4B8ZjkpTE8YVokisUXPDqn1xrflVRWiKLqU6hBa+SDfk5m
         wV7ouXpaZc/Npa1sNjfep+/BVKPrZP1I7AstRFzZK9Vnyqrd6p5+Vyu/PehP/wARXTVl
         yTfEjuvlV7Yuc5+/n5713ImwHhUz50vYqoTFDX/sKdU8BvaDe+wFm2LmDGJ9ilPcbTcP
         w4/w==
X-Gm-Message-State: AOJu0YzTuT1Wv1LYMEuQj798VAgeGa3LAU1FnTORPeFYo4RvF8S1AVRq
	m7GEbYFIk3GQmoCj6xUbN0CxdQLMTA73ApRBjjsMedHBNKMArEmQlfzodgNie1tPYX4GwPnaxQZ
	rqlg8sJNNPc3lodp2Q6hklve0QK8WJJa733EIMK/dnxMXwHfj7g==
X-Google-Smtp-Source: AGHT+IF1f2feAjnm85F4s8gxKonvqnnE7lCGUFl3FElfeMcg8avU1+zbMceN1wficPmpwPpLunHwWc1M1BcNOAr6kEU=
X-Received: by 2002:a05:6820:614:b0:5ce:3ccb:2118 with SMTP id
 006d021491bc7-5d61f593156mr165755eaf.3.1722459837002; Wed, 31 Jul 2024
 14:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de> <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
 <4b27cee7-98eb-41ac-a68b-44f42e15a5d2@web.de>
In-Reply-To: <4b27cee7-98eb-41ac-a68b-44f42e15a5d2@web.de>
From: Kyle Lippincott <spectral@google.com>
Date: Wed, 31 Jul 2024 14:03:31 -0700
Message-ID: <CAO_smVgs1+os+Mh+c_tEoD_W6m+oJG-w1QQZ8YSuzHGeWkmfcQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] unit-tests: show location of checks outside of tests
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 7:07=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> Checks outside of tests are caught at runtime and reported like this:
>
>  Assertion failed: (ctx.running), function test_assert, file test-lib.c, =
line 267.
>
> The assert() call aborts the unit test and doesn't reveal the location
> or even the type of the offending check, as test_assert() is called by
> all of them.
>
> Handle it like the opposite case, a test without any checks: Don't
> abort, but report the location of the actual check, along with a message
> explaining the situation.  The output for example above becomes:
>
>  # BUG: check outside of test at t/helper/test-example-tap.c:75
>
> ... and the unit test program continues and indicates the error in its
> exit code at the end.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  t/helper/test-example-tap.c | 2 ++
>  t/t0080-unit-test-output.sh | 5 +++--
>  t/unit-tests/test-lib.c     | 7 ++++++-
>  3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
> index d072ad559f..79c12b01cd 100644
> --- a/t/helper/test-example-tap.c
> +++ b/t/helper/test-example-tap.c
> @@ -72,6 +72,8 @@ static void t_empty(void)
>
>  int cmd__example_tap(int argc, const char **argv)
>  {
> +       check(1);

Let's include a comment that describes why we have this outside of the
TEST() macros so that people don't try to "fix" it, and so that people
realize it's not meant to be a _good_ example :)

> +
>         test_res =3D TEST(check_res =3D check_int(1, =3D=3D, 1), "passing=
 test");
>         TEST(t_res(1), "passing test and assertion return 1");
>         test_res =3D TEST(check_res =3D check_int(1, =3D=3D, 2), "failing=
 test");
> diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
> index 9ec47b7360..fe221f3bdb 100755
> --- a/t/t0080-unit-test-output.sh
> +++ b/t/t0080-unit-test-output.sh
> @@ -7,9 +7,10 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
>
>  test_expect_success 'TAP output from unit tests' - <<\EOT
>         cat >expect <<-EOF &&
> +       # BUG: check outside of test at t/helper/test-example-tap.c:75
>         ok 1 - passing test
>         ok 2 - passing test and assertion return 1
> -       # check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:77
> +       # check "1 =3D=3D 2" failed at t/helper/test-example-tap.c:79
>         #    left: 1
>         #   right: 2
>         not ok 3 - failing test
> @@ -46,7 +47,7 @@ test_expect_success 'TAP output from unit tests' - <<\E=
OT
>         #    left: '\\\\'
>         #   right: '\\''
>         not ok 17 - messages from failing string and char comparison
> -       # BUG: test has no checks at t/helper/test-example-tap.c:92
> +       # BUG: test has no checks at t/helper/test-example-tap.c:94
>         not ok 18 - test with no checks
>         ok 19 - test with no checks returns 0
>         1..19
> diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
> index 3c513ce59a..989dc758e6 100644
> --- a/t/unit-tests/test-lib.c
> +++ b/t/unit-tests/test-lib.c
> @@ -264,7 +264,12 @@ static void test_todo(void)
>
>  int test_assert(const char *location, const char *check, int ok)
>  {
> -       assert(ctx.running);
> +       if (!ctx.running) {
> +               test_msg("BUG: check outside of test at %s",
> +                        make_relative(location));

Below, `test_msg` emits a message like `skipping check '1 =3D=3D 2' at
<loc>`. Should we include 'check' as part of the message here, or is
it not possible or not useful for some reason?

> +               ctx.failed =3D 1;
> +               return 0;
> +       }
>
>         if (ctx.result =3D=3D RESULT_SKIP) {
>                 test_msg("skipping check '%s' at %s", check,
> --
> 2.46.0
