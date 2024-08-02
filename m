Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD5E57D
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559750; cv=none; b=CIiKAUBma1k0bz6QQd+RWxgQQSwiAD8nA0esUKFYT6qPRUd7kYmHkQjxZ4d4WrKfwbaNxxMbrRQfDP4EQKi1uHyymuAK7rZJnSmJti+vBqvDyIEgOymgI0LLMeUHZntwFkxYNFot9VUHsQsaWiR4KhRtAJVDtr+nmdJwp122Fy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559750; c=relaxed/simple;
	bh=Ce8AwsEV7K7eZpjeQPHI8nNzp0smOLOnWo4BRE5CRZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEg1RoX9zAqQ5MwDDH9KAUP0iMrG8d/NyyQDH7Rjcx1E2JCyJDbhIBi6xTYfiqeO/Rixa5YvbwtkFuZWeOwUFMwnCPOpjWiiw9ZR2YjBsT4UeoHxEPlEyKrpZs8fjGBhwpjb0BdjQGzdB8XByf+wEBGGFJ67SkFESsqMC0iK4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QN+a2qk6; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QN+a2qk6"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so11804954e87.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 17:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722559747; x=1723164547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6boaAZK96wQJExqhznQLyW1qetJ7xl5uU+NC93Vy5sY=;
        b=QN+a2qk6hY0fdrGYm1wL/Q3IDqI8o6vawGShgAQHnFUjPDzEMmsmMTR1fDnCS3PeBv
         1cM0fjF3F3q7WNRupX5vRXyYHl8QR3z2uPGqnPjfLGXCfqWvC9UxiCscFFcAXaEByKJ4
         51GuSjUBFOdkXCFSkJbJ2JWma8Bpp4d3QBlj34JXDw2DJR9UUYoN3w+WYZo7vy0t/wtD
         4e/7ZhZeUVvVaAQFTGmS90nrGb6pi1ii5Iflt8kyT7anZI+ABYUeO8LtTpYQPorFRYgC
         HKLgABbDqAhA2yCfpKpmpyjtFWI3tExyhQJkYZg8wULpcny8MwlGKJPgY8FB3I30n4Ri
         WxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722559747; x=1723164547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6boaAZK96wQJExqhznQLyW1qetJ7xl5uU+NC93Vy5sY=;
        b=UDITfTBA5Uz3Pgjro47Wt7WQbfM6A30k3vfJ1cSspxWEL2pRKV62smGpqcFYl3jjSn
         x/PqZlBZ/S/e7Vnb1WHCxUguzSbRkEGH13u1LNwhQxEpdR8337MkCeCOGYCt+17Wg+Bm
         EqV2PIQBC1lkym8+vyMF44ZrfE0nYZrO/7/AUMwHb1xLjiOrn9uMxwlEJhfZIJIYiWu9
         oYPQ3bwfi34VkcG9Zbg9uHzB+umBeS+qpPqxBLrK/kQ1hzPHe4BCMfOuA32ELAwoZvRg
         6dsc9R17QdBAxcg7nqMLRmOHUVg7PTr2KPdUhZdBMMh5PKJXT5kgv86DBJk5CtRTHtWp
         RBsQ==
X-Gm-Message-State: AOJu0YwRNfikleimMcD5QSXF6N2Qr1E3BQtT7Mf03NuX3+qi38b+W7gI
	9Ilu4TOIyQAClvI8aIlFoq9Ob7F0jH6cULm6f8WEXdQVZ+GnUY+9c/O3A5w2e3QDtzVnEBeBI9D
	fm9LwGwNTMVVtcJ6VoETYZP4SZCYORM3ABTqitYR4rryZk2sA46mS
X-Google-Smtp-Source: AGHT+IHuV+Bggmy167S2YlmE/taQvUmpDIhG8rcXNPEDwSCLVGKTBunBzXhwwRcd/+LoukFgtInxqfkSemCIos1oI5I=
X-Received: by 2002:a05:6512:3d10:b0:52e:7448:e137 with SMTP id
 2adb3069b0e04-530bb366526mr1070739e87.6.1722559746331; Thu, 01 Aug 2024
 17:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de> <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
 <da902de9-288e-4783-8b4b-a2a968d1e1f8@web.de> <CAO_smVh_2FEbTAqJDMZAKMsfTKrB=NH36G6jNmMTaEOtRaP2Pg@mail.gmail.com>
 <51ec32ed-f2f1-4993-92e5-1acfcdbb7c79@web.de>
In-Reply-To: <51ec32ed-f2f1-4993-92e5-1acfcdbb7c79@web.de>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 1 Aug 2024 17:48:50 -0700
Message-ID: <CAO_smVi6hxYLYWPXautyHyYKV2eZitm3j0EFuSo7qbBAoGZvAw@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] unit-tests: add if_test
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 12:32=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> Am 01.08.24 um 00:04 schrieb Kyle Lippincott:
> >
> > I'm still not wild about the name, and I'm still not convinced of the
> > readability improvements. I still want to read `if_test(...)` as
> > having a condition in the parenthesis. Tests "skipping everything"
> > seems like an internal implementation detail that there's disagreement
> > on whether to expose to the test author/reader or not; maybe we should
> > redesign if we don't migrate to clar or some other test framework. Do
> > we get significant benefits from a test function continuing to execute
> > after the "skip everything" flag has been set?
>
> The idea is that the unit test framework may allow to skip individual
> tests in the future; see
> https://lore.kernel.org/git/c2de7f4e-e5dc-4324-8238-1d06795a2107@gmail.co=
m/

I see. This functionality isn't currently available, but we may want
it in the future. If that future ever happens, then we may be able to
avoid some cleanup if we keep the setup the way it is, where
`test__run_start` returns whether or not the test actually started.
This future `--run` flag for the unit tests would be based on either
(a) position in the file, like the integration tests, or (b) some
substring of the description. Since the tests don't have a name,
there's no ability for `--run` to operate based on that. Ok.

I still don't like the name, but I might be in the minority on this.
Yes, there's a control structure in use to make this work with the
syntax you desire, but unlike with `for_test`, there's many fewer edge
cases added because of it: `break` and `continue` won't do anything
with `if_test`. I suppose that we would still need to be concerned
about the possibility of someone writing this:

if (condition)
    if_test("...")
        check_int(1, =3D=3D, 1);
else
    ...

I'm also still not personally sold on the value here.
Single-expression tests can be written with `TEST(check_int(1, =3D=3D, 1),
"equality")`, and having a single large function with all
multi-statement tests in it is harder to follow, in my opinion, than
the alternative where the tests are in a separate function. I can only
really think of the case where the tests have inter-dependencies (ex:
test 2 sets some state that test 5 relies on) for wanting them all in
the same function, because then that dependency becomes a bit more
obvious. However, getting that inter-test dependency to _not_ happen
actually seems like a worthwhile goal (except for cases like strbuf,
where if strbuf is inherently broken, we need to check that first and
bail out). There's increased risk that someone will write a test like
this (purely hypothetical example of some state being carried from one
test to another; yes, you can accomplish the same terribleness with
global variables, but more people have immediate negative reactions
about globals):

int cmd_main(int argc UNUSED, const char **argv UNUSED)
{
    char tmp_path[PATH_MAX];
    if_test("alpha") {
        /* perform basic functionality checks, like strbuf does */
    }
    if_test("beta") {
        /* or some other "expensive" initialization we don't want to
do if everything is broken */
        sprintf("/tmp/tmp.%d", rand());
        do_something(tmp_path, ...);
    }
    if_test("gamma") {
        /*
         * if beta didn't run, or if tests get reordered such that
gamma executes before beta,
         * things are going to go very poorly here
        */
        do_something_else(tmp_path, ...);
    }
    return tests_done();
}

That said, I'm still not opposed enough to the idea to veto (plus I
don't have anywhere near that kind of power, and shouldn't :)). I just
don't think I'd ever use it.
