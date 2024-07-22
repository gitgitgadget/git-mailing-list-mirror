Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FA3D969
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721688110; cv=none; b=uQCxUz1knado15lVj7E6FPoIwkL5eiRgi0vVYSA/MpNJkdtCk1oIWpcT9WTYGf6FlPhj4hPtW++ShLnUt0B2f6+Rnp1ClYfftu35Zsz8LebTbPmbAd812jgApnx6lg5wO6oWe3VZAQeAPIlOlJFF+KxUfsCX1Vg5XuSBEmBAJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721688110; c=relaxed/simple;
	bh=jYp5FQkRoYR61vQ8Us/fYLBn5BEreKO89XNzxymy9EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFpaPxB8Zx0lVWan8kDzLkjhccfUoxkBpjBYQKNVQmfzf2b6c9pJKmr8SNJSFUqmPo3pPrbRjH7uDl5nyUkaODcjxuIMOSEwjAlr3SlqVSv9EhvcaBf4TIkmBA9n2EeII7k/67DBMOzEPhbPxqtmrIczfhotx9kHWuvA1UW+Zc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DdMG6JjR; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DdMG6JjR"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ef95ec938so2769015e87.3
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721688107; x=1722292907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QchSzFBMCQG3P0Yil05xMtSMFnoAYcUaCpFoyrlXC/U=;
        b=DdMG6JjRANzfI1Sk66t10ifWOjgQcxZuL2QDFqKlX8q50QVkLqsP59xTMwaRVK4cFV
         MMzXntSim+XIJGCiUPR4Wk3tryMlTbKRRryYkSyrveWnx5lJn/dki3tZ/HK/ukhuTYp1
         sfijKMgiDRw58iSx3MmeVve4zIRaPDu9kHyh0IX7lktk5F8mw5nRT/mkBVNr4b0Ef2Xg
         iN/U8cdweAA3SqAqSeWek3dTWlfXCtLq3QxwMsH0q0OvU7IZcVmkeUMLpqsOmHToBfec
         9prYtgF4i+hyCoUV4rUhRG5AVNoFBhngvz6iYrUgB7Qz42ozEUDXMgQQSj+XS3NIPeVW
         4pbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721688107; x=1722292907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QchSzFBMCQG3P0Yil05xMtSMFnoAYcUaCpFoyrlXC/U=;
        b=whxa5r3gazXnwe8enNhulpc/ypExlrryKzmVKBTrtI9QlH669aUQpPG65mVCgHYc6i
         CeAJ4X1rhv+GsKC51sSQSdYfUx3Qu2e8EvqQT3m9UVFIXw07VfWdyFSC0u3AzgCltb82
         1PqFN2OsRdSD42lcqu4kU062B340V+APwSLq4T2dX7VC6o1N9sqcFSDJu63m3RvA3egE
         s1di/A9xyOasl1LxEXfoowOpvRDtgKc3gx/9m1t3UB2GWUu+hHkpeWeOBEXxVbeO2z8w
         J65HZK9HrzicfVZy458vQFEvHokXFRc407TQOcD2Pl42A4t6910J2Qap6Yj0FInKxJKc
         V58w==
X-Forwarded-Encrypted: i=1; AJvYcCVE0bmW8cVKikCPP9S0uRROM7eUkXI1v+frxmwQ6Dfwn+Jw02rDgKDn8rowdhc648S0p4IGJ+LQDMZLydTCGemLLzwU
X-Gm-Message-State: AOJu0YwXho1yPlZ2gSJ68K5CUg3W6obGxxfAyWK66G6m31lFLJGp7xAs
	TwSSL3Dv35XGJn7ECsDEldTrkSfOdHZJsv/rVmL31SQKgIF+7Zo7chpA3LIlHoGSfqRq/Yxo1Ct
	Qo401F9TE8Tqmrruy4sWv/Vi5+fD15DGHZUfS
X-Google-Smtp-Source: AGHT+IGv0QljUfKQRJSG+N+8mETYEF31uNj75i+w53gz01XEftMDKVJS3Q1iMADUSTDnpB7hACCBCM/9r+NtFEHfYcw=
X-Received: by 2002:a05:6512:b1e:b0:52c:d617:f4da with SMTP id
 2adb3069b0e04-52fc406f122mr826034e87.41.1721688106813; Mon, 22 Jul 2024
 15:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de> <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de> <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g>
In-Reply-To: <xmqq1q3lb4me.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 22 Jul 2024 15:41:31 -0700
Message-ID: <CAO_smViu2AtdU3GceEJkGXK-pXZr+QyvrWk5sYRVLypyFp1PeA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 12:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Kyle Lippincott <spectral@google.com> writes:
>
> > I can see based on this description where the name came from, but
> > without this context, it's not clear when reading a test what it
> > actually does. The name comes from an implementation detail, and is
> > not describing what it _does_, just _how_ it does it.
> >
> > Maybe a name like `small_test` or `quick_test` or something like that
> > would better express the intended usage?
>
> Names that explicitly have C keyword for control structures, e.g.
> "if_somecondition_test()", "while_foo_test()" or "for_test()" is
> vastly preferrable than these, in order to make it clear that we are
> introducing a macro that defines control structure.

Perhaps expression_test or something, then? It's testing an expression
(I think blocks are a type of expression? I never remember which is
'larger': expressions or statements, and that might only be a C++
thing, C might not have the same terminology).

I was going to suggest a lint check that checks to ensure that we
don't have a semicolon immediately after the description, or a lint
check that enforced that even single-statement tests are wrapped in {}
(inverting the style guide requirements), but realistically neither
are actually needed: `test__run_begin` already asserts that a test
isn't currently running. `check_int` and friends already assert that a
test _is_ running. So this is already defended against:

for_test ("test description");
    check_int(1, =3D=3D, 1);   /* `assert`s: not in the middle of a test */

What we don't have is defense against a completely empty test, or a
test without any actual conditions:

for_test ("test one");
for_test ("test two") {
    printf("this test doesn't actually _test_ anything\n");
}

Adding that is doable, and improves the first case: the `for_test
("test description");` line fails because the test didn't do anything,
not the `check_int` line.

>
> >> +       for_test ("for_test passing test")
> >> +               check_int(1, =3D=3D, 1);
> >
> > I'm concerned that users will write this like:
> > +       for_test ("for_test passing test");
> > +               check_int(1, =3D=3D, 1);
>
> And that is exactly why we want the macro name to include C keyword
> for control structures.
>
> > And the issue won't be caught.
>
> You are right.  Making an empty body somehow catchable by the
> compiler would be a vast improvement.
>
> >> +#define for_test(...)                                                =
  \
> >> +       for (int for_test_running_ =3D test__run_begin() ?            =
    \
> >> +               (test__run_end(0, TEST_LOCATION(), __VA_ARGS__), 0) : =
1;\
> >> +            for_test_running_;                                       =
  \
> >> +            test__run_end(1, TEST_LOCATION(), __VA_ARGS__),          =
  \
> >> +               for_test_running_ =3D 0)
> >
> > IMHO: this is borderline "too much magic" for my tastes. I think
> > having multiple test functions is generally easier to understand, and
> > the overhead isn't really relevant. It's not _as_ compact in the
> > source file, and requires that we have both the TEST statement and the
> > function (and forgetting the TEST statement means that we won't invoke
> > the function). If that is the main issue we're facing here, I wonder
> > if there's some other way of resolving that (such as unused function
> > detection via some compiler flags; even if it's not detected on all
> > platforms, getting at least one of the CI platforms should be
> > sufficient to prevent the issue [but we should target as many as
> > possible, so it's caught earlier than "I tried to send it to the
> > list"])
>
> Interesting.
>
> > If others agree that this is a good simplification for the people
> > reading the test code (and hopefully for the test author), I'm fine
> > with this going in (with a different name). I'm not trying to veto the
> > concept.
>
> OK.  But what you suggested in the previous paragraph has merit.
> Are there other things that could be improved in the existing unit
> test helpers, that would help those who do not use this new for_test()
> thing?  Let's see how the patches to improve them would look like.
>
> Thanks.
>
