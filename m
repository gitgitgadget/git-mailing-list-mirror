Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C47E1401B
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721688493; cv=none; b=dAM5kxbdGjl72R3VBXpmHApTo5SvalvGVm5RgGDfOh7vJKkl6V8hBxZ/DS2cQqdGZnEAL+gNvduUBylH/wG2so1ktQWQu8bZk6Kr5DYsw4Ocqcq0IP2eH4gTEKRvm24EeRnqVWfRIKay4hZYPWQIDui4Zj5ogUlBFm1N9qiUZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721688493; c=relaxed/simple;
	bh=Z/g0K0uxRY8NtrACHbOUzvpXwaZqvv2Ctr6MUzgjyh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww6tHDaZ87HyzoKPdIZ83a38rSkuZ7jODwvoOabSywwfr0J/WGIMHLiW4iRK/okoQ6l+cq8M/FvPzT0X3AuaryEziI98K/FZh1beDpX+5G15h8598GGDQaITeQFc903pLwE+Ew0yaxRcH93pMLz2bzGHVVEk38hRKLDHN65VrNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QsqgFMGJ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsqgFMGJ"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so4656645e87.0
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721688489; x=1722293289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyNkyxr5IXpjWU8PoUREbPVjtqwZHwINZTPcpT5dSu0=;
        b=QsqgFMGJBie91j5C77hMQmq6MoEJ5CvJ5JH6V9s1+Owe9cx4DZSuo9jp5jACkU+f0N
         PCg0qXUyQDPMCuxWFgTBwEaeJnrkQ5iBvtB/ZRRTwF0qsT19Qv6vFUPivoZlh4oOgmP4
         F7r6u4vpDbPry8qNbZSYWFzr5DVc2TrieTBiI0rPD3YZIrvSiEK0u1iM6eSkZPzvE6S9
         XZY40suDe3+oNUvzgap1oTYbBUeneUAuhn9tIrG3BQtwS8+n0Esiaou8YUfKyBllmTob
         EkGk0qv3K2OX1L2eyIPVdyXRgPmdr7mu8yGWxU8vlQugRTaDTInrXTlLsZ4+psHtncyy
         ajrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721688489; x=1722293289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyNkyxr5IXpjWU8PoUREbPVjtqwZHwINZTPcpT5dSu0=;
        b=F71RnxohbKbXeSX41Dbg8jGK5YihwdCBHL56F0z9drwj3Ai2UQEPR6A2VklJurEPA/
         oHSZ349VpmFrxE4sBGxAn4FYZw19SzlBtDDjYqrQh9RyygU04xtB8ZxbRekTipSTGLoF
         UTiOBzWibJjctWISDqKhzQPIe0EJeIbLScwLejOLUUqCZ2g5+GwFcHB48jmw9eDTe84I
         aZp+QubolgNvmr/In3gKYTN+XBSYSivkA0QHjK3MRAfWukZCim5x4CueEgIAD7/IGifV
         EdQQmRHazrynE9rdcnh2/TmwtgLzRuDpAKLqPITGGQsZQH3G5TsYj/NezX0ZqmpEkq1U
         tXpg==
X-Forwarded-Encrypted: i=1; AJvYcCXK+OmgHaFx9TjMga0uifmmXqoFWJOMpRYNe7BgiKphtVCnhEsVASGgn8u46AtuaHMwIzNgr/53b5YvucbXmlm+ljoo
X-Gm-Message-State: AOJu0YxfIjt2qXeVrE1rLdxxxq5F68s35VHWzz6ip6UG244RZ+OpBaSg
	3/juya9n4TN9qp89tq+NM8MLWoa7IyRsiOMScPBGRlgzUwdQCqsZeASMKhV/vi8V6yGqVIgz3l0
	1JATPNpa52r516XvWaCyhv4OpjWbOoTsaalnY
X-Google-Smtp-Source: AGHT+IFSrktOqZFNiHCM+oWNtj44YZxZYLxHAMkg9jcG/K4AYJI7DxGx4ioWLMeQixeX2I01wIL9oNexzQZMwXzmtn4=
X-Received: by 2002:a05:6512:2314:b0:52e:f907:1014 with SMTP id
 2adb3069b0e04-52fc403d295mr837730e87.8.1721688489104; Mon, 22 Jul 2024
 15:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de> <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de> <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g> <be282096-49af-4d83-b5f7-8b4f1b447edb@web.de>
In-Reply-To: <be282096-49af-4d83-b5f7-8b4f1b447edb@web.de>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 22 Jul 2024 15:47:57 -0700
Message-ID: <CAO_smViM7_Er4hY_WvxJf_xWGtKVN29gJA9APzW3t3GdAaxsgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 1:31=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> Am 22.07.24 um 21:36 schrieb Junio C Hamano:
> > Kyle Lippincott <spectral@google.com> writes:
> >
> >>> +       for_test ("for_test passing test")
> >>> +               check_int(1, =3D=3D, 1);
> >>
> >> I'm concerned that users will write this like:
> >> +       for_test ("for_test passing test");
> >> +               check_int(1, =3D=3D, 1);
> >
> > And that is exactly why we want the macro name to include C keyword
> > for control structures.
> >
> >> And the issue won't be caught.
> >
> > You are right.  Making an empty body somehow catchable by the
> > compiler would be a vast improvement.
>
> That would be nice, but I have no idea how to do that without compiler
> changes.  In the meantime the existing runtime checks will catch both
> the empty test in the first line and the out-of-test check in the second
> one and report them like this:
>
>  # BUG: test has no checks at t/helper/test-example-tap.c:75
>  not ok 1 - for_test passing test
>  Assertion failed: (ctx.running), function test_assert, file test-lib.c, =
line 267.
>
> File name and line in the second one are not as helpful as they could
> be.  Here's a patch to improve that output.
>
> --- >8 ---
> Subject: [PATCH] unit-tests: show location of checks outside of tests
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

Oh, I referenced "detect tests without checks" as a possible
improvement in my previous message, and didn't actually check whether
it was there. This statement made me go and check, and you're right,
it is there already. So I think we're well defended against the empty
check case, especially with the improvement here. Thanks!

If we have a good set of protections against misuse, does this mean
we're free to rename it? :) The concern raised for why `for` had to be
in the name was because it was using a control statement (a
at-most-1-execution for loop) to achieve its magic, and the control
statement puts certain restrictions and obligations on how to use it
correctly. If the misuse is detected reliably, we can choose a name
that's more descriptive about what it's doing.

>
>  # BUG: check outside of test at t/helper/test-example-tap.c:75
>
> ... and the unit test program continues.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  t/unit-tests/test-lib.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
> index 3c513ce59a..9977c81739 100644
> --- a/t/unit-tests/test-lib.c
> +++ b/t/unit-tests/test-lib.c
> @@ -264,7 +264,11 @@ static void test_todo(void)
>
>  int test_assert(const char *location, const char *check, int ok)
>  {
> -       assert(ctx.running);
> +       if (!ctx.running) {
> +               test_msg("BUG: check outside of test at %s",
> +                        make_relative(location));
> +               return 0;
> +       }
>
>         if (ctx.result =3D=3D RESULT_SKIP) {
>                 test_msg("skipping check '%s' at %s", check,
> --
> 2.45.2
