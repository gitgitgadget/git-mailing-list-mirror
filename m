Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D966213F43A
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498298; cv=none; b=DVtKcV5+AZ6cIGf8UGeHq6csxhL3WDCaYY6Y449/HXAQCb/4zaYzzz8yRKkc5D8mbjr9mIYzkLomg9MXQZPuhQ4COja4QgBGttKdCnDaZwrdNmHNAKLC5EFgDPXR8rVAwIRG4FoainZIWV7jXZ7qUqIM0wRQ0timnAQskiTWA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498298; c=relaxed/simple;
	bh=qCpOxAXxmzWo3oBJBWYdbN0TOdYMJt198tdklo5Evk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRmXj+xJ7RhuKOzJNMHLP+FC4GJ9VHn6XZV6s8Oi1zBV+/xM5H+nxNPVeqqFNF4YtB1XtyjHdrziozABg3RAgPTULoRpw7Ln6A3M6WhQxnaNgO4MvdjqvitEw4Su4mmoFz8uudnyb3w1P56cmRkOvdVW8Lf1AWlAXbSemUsgVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duMZl7Z2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duMZl7Z2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso693215e9.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 11:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728498294; x=1729103094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fGamuGYrRoT5iZycqUc7R6Ku4hZAyM/XfTIKlq6Nv4=;
        b=duMZl7Z2cWLrgPS7jrz+TKLRH37aPieeXYgitK2I/YHoYBycvE5n8O/zI20SHDasXQ
         lJParKotHE7KzEFXqJnSZVeMjHHJDa8sGQymu/wc7EkiOMlP+6FrqUGYO9Tn4mjyrNTy
         FJ6h1c/hgkjT3159IJXuW3QQbucaVyTvw7G8rTZPr50S9BoVAR9B9LK47DyEbyZbeNIL
         3nqL3UPtFSl37Rhst6gpP67/PigMUw+vO+NpY9SvCOV+GNqEg1RAsKvDYxgFiNWfKy5/
         lRm95QRubgXvDWS+EQvXKzu2TWR+CoDOFl4JJwmfcSvCdSY5Q5zgnxbeHEYnPXW1jFSj
         Y8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728498294; x=1729103094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fGamuGYrRoT5iZycqUc7R6Ku4hZAyM/XfTIKlq6Nv4=;
        b=VJWXlH/yDwFtZ3qcPJ0CR/Fi3AQZr6eIR1iGuz0un6Dj+Hcz3uYBEbkhGp6C4hX4XI
         5kE03gtKeR6g1r6ehVZi4Ei7YMmFGYP8QzCx284OUqObrSy6gHpI0dHftZRQQlJ3tbkB
         LlRLH5Tz405TaZMB9kswZoyOvYx6sVMfYcitt6njIezPVV4KgSJnvPI5zcbBqAG6nXW+
         ZrVheKo4Z1cB5bogKrpCMstBNfsEE656lOV2nWM69IJn7nTnaAaGdWgOLFt+ygMt1DMG
         Tn/VdrvqP5YvyeTu0LnZK39WWpyRqvbluVdQJgn6WUomvXouzbeZBQOtAwq0dU3b2Vup
         eM6w==
X-Forwarded-Encrypted: i=1; AJvYcCWmZM6X0zeQ9uyQugQ2YkCLZUDMVvJfJW7eGYNLEX/+MnLe/t+Ta+ShHOq55TvF02+i2xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0LfD9XKpQNW+B0aIO6Xe+1OO0IBU8YR93K+90i4nL08appqi
	Q+Y7+xHFyV2BedEFgsQmDCBvEh7p79RMQ0kRBF52EoVyrID/7qVwXlDmbLrcT5hy8d9aLKmpqit
	crPc4rbRDlrIFLDoG22dCO2duzmU1E9xlfhjsYw==
X-Google-Smtp-Source: AGHT+IEhZuNuuMRWuR1DpiV0KmVdRaTCOANWD7ImVHxVgEUNM/oWsLGnh/RZIGezDgNfY38/A0gGIWS7FDfLycZpJJg=
X-Received: by 2002:a05:600c:1c8b:b0:42c:b508:750e with SMTP id
 5b1f17b1804b1-430ccf1b32amr36194625e9.11.1728498293864; Wed, 09 Oct 2024
 11:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1811.v2.git.1728390135644.gitgitgadget@gmail.com>
 <pull.1811.v3.git.1728493350545.gitgitgadget@gmail.com> <xmqqzfndtbgv.fsf@gitster.g>
In-Reply-To: <xmqqzfndtbgv.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Wed, 9 Oct 2024 19:24:43 +0100
Message-ID: <CADYq+fbgKNc-=0sqNA=wNWSF9PA653Eo-SzkBPB_6fU8BW53-g@mail.gmail.com>
Subject: Re: [PATCH v3] t7300-clean.sh: use test_path_* helper functions for
 error logging
To: Junio C Hamano <gitster@pobox.com>
Cc: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> >
> > This test script uses "test - [def]", but when a test fails because
> > the file passed to it does not exist,
> > it fails silently without an error message.
> > Use test_path_* helper functions, which are designed to give better
> > error messages when their expectations are not met.
> >
> > I have added a mechanical validation that applies the same transformati=
on
> > done in this patch, when the test script is passed to a sed script as s=
hown
> > below.
> >
> > sed -e 's/^\( *\)test -f /\1test_path_is_file /' \
> >     -e 's/^\( *\)test -d /\1test_path_is_dir /' \
> >     -e 's/^\( *\)test -e /\1test_path_exists /' \
> >     -e 's/^\( *\)! test -[edf] /\1test_path_is_missing /' \
> >     -e 's/^\( *\)test ! -[edf] /\1test_path_is_missing /' \
> >        "$1" >foo.sh
> >
> > Reviewers can use the sed script to tranform the original test script a=
nd
> > compare the result in foo.sh with the results of applying the patch.
> > You will see an instance of "!(test -e 3)" which was manually replaced =
with
> > ""test_path_is_missing 3", and everything else should match.
> >
> > Careful and deliberate observation was done to check instances where
> > "test ! - [df] foo" was used in the test script to make sure that the t=
est
> > instances were expecting foo to EITHER be a file or a directory, and NO=
T a
> > possibility of being both as this would make replacing "test ! -f foo" =
with
> > "test_path_is_missing foo" unreasonable.
> > In the tests control flow, foo has been created as EITHER a
> > reguar file OR a directory and should NOT exist
> > after "git clean" or "git clean -d", as the case maybe, has been called=
.
> > This made it reasonable to replace
> > "test ! -[df] foo" with "test_path_is_missing foo".
>
> This is a good place to stop (but perhaps have a paragraph break
> before "In the tests control").  The "examples" you have below is
> like telling readers to go read the patch and verify the correctness
> of it themselves, which is not adding much value.
>
> Other than that, looking very good.
>
> Thanks.

Thank you very much, I have submitted an updated patch.
>
> >  t/t7300-clean.sh | 370 +++++++++++++++++++++++------------------------
> >  1 file changed, 185 insertions(+), 185 deletions(-)
> >
> > diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> > index 0aae0dee670..5c97eb0dfe9 100755
> > --- a/t/t7300-clean.sh
> > +++ b/t/t7300-clean.sh
> > @@ -29,15 +29,15 @@ test_expect_success 'git clean with skip-worktree .=
gitignore' '
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test ! -f a.out &&
> > -     test ! -f src/part3.c &&
> > -     test -f docs/manual.txt &&
> > -     test -f obj.o &&
> > -     test -f build/lib.so &&
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_missing a.out &&
> > +     test_path_is_missing src/part3.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_file obj.o &&
> > +     test_path_is_file build/lib.so &&
> >       git update-index --no-skip-worktree .gitignore &&
> >       git checkout .gitignore
> >  '
> > @@ -47,15 +47,15 @@ test_expect_success 'git clean' '
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test ! -f a.out &&
> > -     test ! -f src/part3.c &&
> > -     test -f docs/manual.txt &&
> > -     test -f obj.o &&
> > -     test -f build/lib.so
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_missing a.out &&
> > +     test_path_is_missing src/part3.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_file obj.o &&
> > +     test_path_is_file build/lib.so
> >
> >  '
> >
> > @@ -64,15 +64,15 @@ test_expect_success 'git clean src/' '
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean src/ &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test -f a.out &&
> > -     test ! -f src/part3.c &&
> > -     test -f docs/manual.txt &&
> > -     test -f obj.o &&
> > -     test -f build/lib.so
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_file a.out &&
> > +     test_path_is_missing src/part3.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_file obj.o &&
> > +     test_path_is_file build/lib.so
> >
> >  '
> >
> > @@ -81,15 +81,15 @@ test_expect_success 'git clean src/ src/' '
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean src/ src/ &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test -f a.out &&
> > -     test ! -f src/part3.c &&
> > -     test -f docs/manual.txt &&
> > -     test -f obj.o &&
> > -     test -f build/lib.so
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_file a.out &&
> > +     test_path_is_missing src/part3.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_file obj.o &&
> > +     test_path_is_file build/lib.so
> >
> >  '
> >
> > @@ -98,16 +98,16 @@ test_expect_success 'git clean with prefix' '
> >       mkdir -p build docs src/test &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so src/te=
st/1.c &&
> >       (cd src/ && git clean) &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test -f a.out &&
> > -     test ! -f src/part3.c &&
> > -     test -f src/test/1.c &&
> > -     test -f docs/manual.txt &&
> > -     test -f obj.o &&
> > -     test -f build/lib.so
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_file a.out &&
> > +     test_path_is_missing src/part3.c &&
> > +     test_path_is_file src/test/1.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_file obj.o &&
> > +     test_path_is_file build/lib.so
> >
> >  '
> >
> > @@ -163,16 +163,16 @@ test_expect_success 'git clean -d with prefix and=
 path' '
> >       mkdir -p build docs src/feature &&
> >       touch a.out src/part3.c src/feature/file.c docs/manual.txt obj.o =
build/lib.so &&
> >       (cd src/ && git clean -d feature/) &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test -f a.out &&
> > -     test -f src/part3.c &&
> > -     test ! -f src/feature/file.c &&
> > -     test -f docs/manual.txt &&
> > -     test -f obj.o &&
> > -     test -f build/lib.so
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_file a.out &&
> > +     test_path_is_file src/part3.c &&
> > +     test_path_is_missing src/feature/file.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_file obj.o &&
> > +     test_path_is_file build/lib.so
> >
> >  '
> >
> > @@ -182,16 +182,16 @@ test_expect_success SYMLINKS 'git clean symbolic =
link' '
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       ln -s docs/manual.txt src/part4.c &&
> >       git clean &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test ! -f a.out &&
> > -     test ! -f src/part3.c &&
> > -     test ! -f src/part4.c &&
> > -     test -f docs/manual.txt &&
> > -     test -f obj.o &&
> > -     test -f build/lib.so
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_missing a.out &&
> > +     test_path_is_missing src/part3.c &&
> > +     test_path_is_missing src/part4.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_file obj.o &&
> > +     test_path_is_file build/lib.so
> >
> >  '
> >
> > @@ -199,13 +199,13 @@ test_expect_success 'git clean with wildcard' '
> >
> >       touch a.clean b.clean other.c &&
> >       git clean "*.clean" &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test ! -f a.clean &&
> > -     test ! -f b.clean &&
> > -     test -f other.c
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_missing a.clean &&
> > +     test_path_is_missing b.clean &&
> > +     test_path_is_file other.c
> >
> >  '
> >
> > @@ -214,15 +214,15 @@ test_expect_success 'git clean -n' '
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean -n &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test -f a.out &&
> > -     test -f src/part3.c &&
> > -     test -f docs/manual.txt &&
> > -     test -f obj.o &&
> > -     test -f build/lib.so
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_file a.out &&
> > +     test_path_is_file src/part3.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_file obj.o &&
> > +     test_path_is_file build/lib.so
> >
> >  '
> >
> > @@ -231,15 +231,15 @@ test_expect_success 'git clean -d' '
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean -d &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test ! -f a.out &&
> > -     test ! -f src/part3.c &&
> > -     test ! -d docs &&
> > -     test -f obj.o &&
> > -     test -f build/lib.so
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_missing a.out &&
> > +     test_path_is_missing src/part3.c &&
> > +     test_path_is_missing docs &&
> > +     test_path_is_file obj.o &&
> > +     test_path_is_file build/lib.so
> >
> >  '
> >
> > @@ -248,16 +248,16 @@ test_expect_success 'git clean -d src/ examples/'=
 '
> >       mkdir -p build docs examples &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so exampl=
es/1.c &&
> >       git clean -d src/ examples/ &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test -f a.out &&
> > -     test ! -f src/part3.c &&
> > -     test ! -f examples/1.c &&
> > -     test -f docs/manual.txt &&
> > -     test -f obj.o &&
> > -     test -f build/lib.so
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_file a.out &&
> > +     test_path_is_missing src/part3.c &&
> > +     test_path_is_missing examples/1.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_file obj.o &&
> > +     test_path_is_file build/lib.so
> >
> >  '
> >
> > @@ -266,15 +266,15 @@ test_expect_success 'git clean -x' '
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean -x &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test ! -f a.out &&
> > -     test ! -f src/part3.c &&
> > -     test -f docs/manual.txt &&
> > -     test ! -f obj.o &&
> > -     test -f build/lib.so
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_missing a.out &&
> > +     test_path_is_missing src/part3.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_missing obj.o &&
> > +     test_path_is_file build/lib.so
> >
> >  '
> >
> > @@ -283,15 +283,15 @@ test_expect_success 'git clean -d -x' '
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean -d -x &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test ! -f a.out &&
> > -     test ! -f src/part3.c &&
> > -     test ! -d docs &&
> > -     test ! -f obj.o &&
> > -     test ! -d build
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_missing a.out &&
> > +     test_path_is_missing src/part3.c &&
> > +     test_path_is_missing docs &&
> > +     test_path_is_missing obj.o &&
> > +     test_path_is_missing build
> >
> >  '
> >
> > @@ -300,15 +300,15 @@ test_expect_success 'git clean -d -x with ignored=
 tracked directory' '
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean -d -x -e src &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test ! -f a.out &&
> > -     test -f src/part3.c &&
> > -     test ! -d docs &&
> > -     test ! -f obj.o &&
> > -     test ! -d build
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_missing a.out &&
> > +     test_path_is_file src/part3.c &&
> > +     test_path_is_missing docs &&
> > +     test_path_is_missing obj.o &&
> > +     test_path_is_missing build
> >
> >  '
> >
> > @@ -317,15 +317,15 @@ test_expect_success 'git clean -X' '
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean -X &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test -f a.out &&
> > -     test -f src/part3.c &&
> > -     test -f docs/manual.txt &&
> > -     test ! -f obj.o &&
> > -     test -f build/lib.so
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_file a.out &&
> > +     test_path_is_file src/part3.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_missing obj.o &&
> > +     test_path_is_file build/lib.so
> >
> >  '
> >
> > @@ -334,15 +334,15 @@ test_expect_success 'git clean -d -X' '
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean -d -X &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test -f a.out &&
> > -     test -f src/part3.c &&
> > -     test -f docs/manual.txt &&
> > -     test ! -f obj.o &&
> > -     test ! -d build
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_file a.out &&
> > +     test_path_is_file src/part3.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_missing obj.o &&
> > +     test_path_is_missing build
> >
> >  '
> >
> > @@ -351,15 +351,15 @@ test_expect_success 'git clean -d -X with ignored=
 tracked directory' '
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean -d -X -e src &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test -f a.out &&
> > -     test ! -f src/part3.c &&
> > -     test -f docs/manual.txt &&
> > -     test ! -f obj.o &&
> > -     test ! -d build
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_file a.out &&
> > +     test_path_is_missing src/part3.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_missing obj.o &&
> > +     test_path_is_missing build
> >
> >  '
> >
> > @@ -382,29 +382,29 @@ test_expect_success 'clean.requireForce and -n' '
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean -n &&
> > -     test -f Makefile &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test -f a.out &&
> > -     test -f src/part3.c &&
> > -     test -f docs/manual.txt &&
> > -     test -f obj.o &&
> > -     test -f build/lib.so
> > +     test_path_is_file Makefile &&
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_file a.out &&
> > +     test_path_is_file src/part3.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_file obj.o &&
> > +     test_path_is_file build/lib.so
> >
> >  '
> >
> >  test_expect_success 'clean.requireForce and -f' '
> >
> >       git clean -f &&
> > -     test -f README &&
> > -     test -f src/part1.c &&
> > -     test -f src/part2.c &&
> > -     test ! -f a.out &&
> > -     test ! -f src/part3.c &&
> > -     test -f docs/manual.txt &&
> > -     test -f obj.o &&
> > -     test -f build/lib.so
> > +     test_path_is_file README &&
> > +     test_path_is_file src/part1.c &&
> > +     test_path_is_file src/part2.c &&
> > +     test_path_is_missing a.out &&
> > +     test_path_is_missing src/part3.c &&
> > +     test_path_is_file docs/manual.txt &&
> > +     test_path_is_file obj.o &&
> > +     test_path_is_file build/lib.so
> >
> >  '
> >
> > @@ -453,11 +453,11 @@ test_expect_success 'nested git work tree' '
> >               test_commit deeply.nested deeper.world
> >       ) &&
> >       git clean -f -d &&
> > -     test -f foo/.git/index &&
> > -     test -f foo/hello.world &&
> > -     test -f baz/boo/.git/index &&
> > -     test -f baz/boo/deeper.world &&
> > -     ! test -d bar
> > +     test_path_is_file foo/.git/index &&
> > +     test_path_is_file foo/hello.world &&
> > +     test_path_is_file baz/boo/.git/index &&
> > +     test_path_is_file baz/boo/deeper.world &&
> > +     test_path_is_missing bar
> >  '
> >
> >  test_expect_success 'should clean things that almost look like git but=
 are not' '
> > @@ -624,9 +624,9 @@ test_expect_success 'force removal of nested git wo=
rk tree' '
> >               test_commit deeply.nested deeper.world
> >       ) &&
> >       git clean -f -f -d &&
> > -     ! test -d foo &&
> > -     ! test -d bar &&
> > -     ! test -d baz
> > +     test_path_is_missing foo &&
> > +     test_path_is_missing bar &&
> > +     test_path_is_missing baz
> >  '
> >
> >  test_expect_success 'git clean -e' '
> > @@ -638,10 +638,10 @@ test_expect_success 'git clean -e' '
> >               touch known 1 2 3 &&
> >               git add known &&
> >               git clean -f -e 1 -e 2 &&
> > -             test -e 1 &&
> > -             test -e 2 &&
> > -             ! (test -e 3) &&
> > -             test -e known
> > +             test_path_exists 1 &&
> > +             test_path_exists 2 &&
> > +             test_path_is_missing 3 &&
> > +             test_path_exists known
> >       )
> >  '
> >
> > @@ -649,7 +649,7 @@ test_expect_success SANITY 'git clean -d with an un=
readable empty directory' '
> >       mkdir foo &&
> >       chmod a=3D foo &&
> >       git clean -dfx foo &&
> > -     ! test -d foo
> > +     test_path_is_missing foo
> >  '
> >
> >  test_expect_success 'git clean -d respects pathspecs (dir is prefix of=
 pathspec)' '
> >
> > base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
