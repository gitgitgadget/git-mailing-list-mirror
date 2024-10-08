Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8817C9B6
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377938; cv=none; b=FaxIE/MdPV6gcHwKyRXKXLJh1CpfcMrY3dMJZvXTDrGOXXjMB+ryjLPncZQq2YVTQjdDixFW2lVz/ZudaDtTYzH6dya2rgGU+Sybjp3YGFw5aXawJeUfjvjFNW7N+NetGhABtdvbMC1NlkquYWkXwTQiFrYF3fSKU4sdupgCXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377938; c=relaxed/simple;
	bh=tJMmWDPqIOLH42yxJB/qiaf83MpCh+uArJLj+PfUGfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GO3z7rvrvYBhLo2dbGbIEFYrFhjseZm4HQgw51pIMGjN7sGVwF6Q9Z/70IqWaYxQRjh3xzaTw4jfFuaarzemCAgRDQ+6OSP7AUBUX9IkNoo5wwiap8LaPPofuAEXfqomoDt6IzvWdBKf9BXSzOH5A5Ss8cuvK3Go0QsSwgcGZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNrsT/uR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNrsT/uR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb806623eso49901715e9.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728377935; x=1728982735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbXo5U/mYPOBiza+FouPG0wlBuedPl5cr4ebK2hVj8I=;
        b=CNrsT/uR7EOziolJVuFlTKLp7/UydwcKqOHA/Vuekn2EUpJSbT7gCYxoxv3gtDg/xj
         3bxY0EEeg+KXnDcowja8lKoVwzvf14RH6sh3OEiGsyxZ87u3m0SfShTRDVhApDnT9Y+J
         4FZCwLduxWpOWXf6Anbdk4iVMkNdfruhovEHvuuClGn5XbbO1ZBOp2Q930othr8Oekh2
         NDafwGxMDIMp0pOiLRCV1eijRVoH4bL/iItaJ2VQrcVgL/4fd2+4psKI+ScwhSx9TR/z
         HBWGDjqYEMn2+AnX7JeL/dbUNPyOqChAoSf3/ZqpTlHc3S1/RbxGarPlAlFXSiMwSP3d
         gOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728377935; x=1728982735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbXo5U/mYPOBiza+FouPG0wlBuedPl5cr4ebK2hVj8I=;
        b=fHaCCHoCvi8EWQ6Htg3w0Rl7t3K1OILYnDo4dhZxtvoY2aDcs6sfbgtAYDE8+2+Ool
         k4B6QuNZ0Xsey1dClZJl/QxT6MhrRshF6+HVXFx/PIGhQZ0y/XJpKePranLnrBfvfLvy
         YJGu+dh7WXpks13LMmo/Qu4RY/n8mUpS6b1/zuxsQ2xZl9yNv9tx1adeppFwqvBCYsAf
         D0k3Ju2PqUy0FOHfdhYTBwLhRIUE5Ryeck8nmsRHyYHAy7R6griI0Cs4tt+u4TCdtqzN
         2hV301+SepOw5sXG1FvmwhIQnbF5u2xC/oF+5XHjhqoz9C8kmSPndP2UrE1lJwdmm7YJ
         r9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeZmubp41zZlaNdTlsIJlbftPqFcn1TRJVW9lJ4tFgoEa5NW1WMHYSmTk82HJ/ER3k9Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLs31jPbXlpdKVaQyfFcRblska1XWVVS34kmO/ff1VZQFHB0Kq
	jXAQRtn8yJRVOaROV7zGF27TvDmoxQBIM2uNZYRc4WG6DTD/0jMyj1V9azrasB923uCM2M7+gfq
	iGI64NF7cwEp5MKSe3MWwkNi2QNo=
X-Google-Smtp-Source: AGHT+IHLyAncHsEhcI4urSi00QNGkBcnRDVLjSi+ItF7k8KDRRNRoRBmeMuRHNHsU7szyHA1bVY3GvGHqXSTBmaKYE4=
X-Received: by 2002:a05:600c:4f14:b0:42c:b1f0:f67 with SMTP id
 5b1f17b1804b1-42f85af4350mr101257925e9.27.1728377935132; Tue, 08 Oct 2024
 01:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1811.git.1728328755490.gitgitgadget@gmail.com> <xmqq34l75pr7.fsf@gitster.g>
In-Reply-To: <xmqq34l75pr7.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 8 Oct 2024 09:58:44 +0100
Message-ID: <CADYq+fYZSGBTnO+dM+MtHj=oUMqDWt+6wu-wEzwfWQJkSomkWA@mail.gmail.com>
Subject: Re: [PATCH] t7300-clean.sh: use test_path_* helper functions
To: Junio C Hamano <gitster@pobox.com>
Cc: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	phillip.wood@dunelm.org.uk, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:48=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> >
> Manual validation is still needed for "test ! -f foo".  If the
> original expects 'foo' to be gone, and has a reason to expect 'foo'
> to be a file when the code being tested is broken, then rewriting it
> into "test_path_is_missing" is OK.  But otherwise, the original
> would have been happy when 'foo' existed as a directory and
> rewriting it into "test_path_is_missing" is not quite right.
>
> This check cannot be done mechanically, unfortunately.  Hits from
>
>    $ git show | grep -e 'test ! -[df]'
>
> need to be eyeballed to make sure that it is reasonable to rewrite
> "test ! -f foo" into "test_path_is_missing foo".
>
> For example:
>
> >       mkdir -p build docs &&
> >       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> >       git clean &&
> > ...
> > -     test ! -f a.out &&
> > -     test ! -f src/part3.c &&
>
> this test creates a.out and src/part3.c as regular files before
> running "git clean", so the expected failure modes do not include
> a.out to be a directory (which would also make "test ! -f a.out"
> happy), and rewriting it to "test_path_is_missing a.out" is fine.
>

Hi Junio,
Thanks again for your time and review.
I have gone through all the instances of "test ! - [df]" and for each
test case where "test ! -f foo" was used, foo was first created as a
regular file in the control flow before "git clean" was called and is
expected not to exist afterwards.
a few more examples are to the one you referenced above are shown below;

>         mkdir -p build docs src/test &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so src/te=
st/1.c &&
>         (cd src/ && git clean) &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test -f a.out &&
> -       test ! -f src/part3.c &&

and

>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean -d -X -e src &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test -f a.out &&
> -       test ! -f src/part3.c &&
> -       test -f docs/manual.txt &&
> -       test ! -f obj.o &&

Also for the tests where "test ! -d foo" was used, the control flow
followed similar pattern as mentioned above where foo was created as a
directory and then "git clean -d" was called. The control flow
expected foo to be a directory which could have been removed
afterwards as can be seen below.

> @@ -300,15 +300,15 @@ test_expect_success 'git clean -d -x with ignored t=
racked directory' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean -d -x -e src &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test ! -f a.out &&
> -       test -f src/part3.c &&
> -       test ! -d docs &&
> -       test ! -f obj.o &&
> -       test ! -d build

and

>  test_expect_success 'should clean things that almost look like git but a=
re not' '
> @@ -624,9 +624,9 @@ test_expect_success 'force removal of nested git work=
 tree' '
>                 test_commit deeply.nested deeper.world
>         ) &&
>         git clean -f -f -d &&
> -       ! test -d foo &&
> -       ! test -d bar &&
> -       ! test -d baz

 This was the reason for replacing "test ! -[df]" with
"test_path_is_missing" where I think is appropriate. I will appreciate
it and be very grateful if test instances in this script where
"test_path_is_missing" is inappropriate to be used are pointed out by
other maintainers as well.
Thanks once again for your time.
