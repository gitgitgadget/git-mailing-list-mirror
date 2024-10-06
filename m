Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D22156228
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 04:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728189265; cv=none; b=gs6RF2xK0onF+qPWogbN7sA6R+GPTCD3+8gKT7Cbozw1YZ6DV9nxsN0T7fICxO/sWuULeMK4SbcnduHn6AACizzNUOUHCRU9vlBanQD9n17z7Krvuu/RspkJfc9IksLebygQimbS9c/Z09aD1dhqp4+1scU9oS74UiWXY0PRHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728189265; c=relaxed/simple;
	bh=ohuYL9eai46yWmTF1SJHkzSx3FaqGjO3i/oANK+btWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHGbIZvR/8CxsKPBoao9z+WBHGWayQHt9Z+d8ZnmgIoe+PEr43+dY3fgAczkgbpmtU2bHRnQwexUy+X33T8JPQ3NBMV+R0BnOO5hfjpp6Lh1SFgbFGKgueBiEllSLRGDh7KTdcf3dcj3faflVexA5GTi88iZ0AXu7vFLqjnJ3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0Ihjr5Y; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0Ihjr5Y"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4a3baeb9f3fso1110431137.0
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 21:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728189259; x=1728794059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohuYL9eai46yWmTF1SJHkzSx3FaqGjO3i/oANK+btWw=;
        b=H0Ihjr5YV6TPQHel4hD8+tc0aTx6fj8znyFn91eI6WGVN870q7ODXTMGG5NYezXSZ0
         MFEobrW7OAvpZw6Plh07KfwnUNSAAEZ79Bvykn9QdKOQHwpeOOVB2z7c6IbN8ICbAIs2
         DvjB1vX5d796lYf3tOUVZM6GUnPi7ABJ94Mt99VTUXiUCRpiNLpfNZWepQ0SMwlEhehc
         BS5wXKtzgutatwPtbVjjGF/TrVP6uA0R8DVEOXadnCH7GJ828C/8BLH1RSwc/cDC07TK
         QETndcz6Up6iE+6P+Qx1x0/MyJdgwBeSF2fCnat7sNKCLQqwGoqrAL+qciP+2oK+hq0V
         EM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728189259; x=1728794059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohuYL9eai46yWmTF1SJHkzSx3FaqGjO3i/oANK+btWw=;
        b=e0Yy2pnvHIfOJR5Q90TDThlw5DyMpEugj2B0LcYT0f/9+6s8SOX/5gGEWMtF4i/JWF
         9cyGZI6DiB4MBW5JpdN9Qtr20RRbpBDE1n94/vZxx6LHCCyw6hfDD3u1G+pIF0Iw9Sn7
         ITNn/9Fbc3Hwmca5b9cTPwT1PJZ2OweNnwrQhnaR3LnUrjtaswjeiSiZwkO8C98TbQ9L
         4XCLVZAgOJWVBvGWcenhnVaKjgLAF+A4MHt3Req4mO+6AYIqvdRac6auDOO9hXNN9CzK
         FV472nOFAhIabSx+1vK4EyAO7EtJb36W/LiB6GsQatrybM8wth9b+5iMSMoE3VaUpPRg
         6QTw==
X-Forwarded-Encrypted: i=1; AJvYcCV4K9VmtDs4UZFDZ2xHilq2KhwQeVoE3rn/ay+l4abJ3sAKN/5Wmf+lDe7aMK+JIvHXgyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMbMH6FQ7cFep3IX+pF+Yr0X7+6a/+GvvlsktFAo6KGgD5UyY8
	GdjU24CHbycCTmN2kKhI2YVbukBSfkYqm3Juz50Y6xDzJ0AaDep8orG5Bsv5TAYczjJytUgQ5V1
	iDDqAUY8EuQ++of7zxsLb846rTPA=
X-Google-Smtp-Source: AGHT+IH3UqYsumt1n/fxpBKzrIRajLMb5XdR1oheBtbM2OtTsn6XODo4NDtJqPl7YOinNprwg9FpkTDAlzvbd0BnTik=
X-Received: by 2002:a05:6102:290c:b0:4a3:f9e8:2fb9 with SMTP id
 ada2fe7eead31-4a4058f48f3mr4350258137.24.1728189258756; Sat, 05 Oct 2024
 21:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM-+4VFsHkBW8Y3ncY-kjxvAXSOdSom=zBQzTNd-JK+HxA@mail.gmail.com>
 <Zv0-Wv03hSea_Tje@pks.im> <CAPSxiM_fTMCzXg3OrcbJrn=UskyCaR3D=xgR4d6PrnnAdoYcCQ@mail.gmail.com>
 <CAP8UFD2QN59LVAJgqwj5V6dJ9sTCHjdDG=XtuWcFkgANmfvnrQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2QN59LVAJgqwj5V6dJ9sTCHjdDG=XtuWcFkgANmfvnrQ@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 6 Oct 2024 04:34:07 +0000
Message-ID: <CAPSxiM8jTxFXZB5ek6nNFy8arKan7GfoiRmaj4jQ81Xfhcf7eQ@mail.gmail.com>
Subject: Re: [Outreachy] Potential intern.
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your reply.

I make changes but, I need someone to allow me to be able to send my
patch using gitgitgadget.

I had two links as the first was failing some test which I solved.

Below is the github link.

https://github.com/git/git/pull/1805 - updated patch.
https://github.com/git/git/pull/1803

Also, I will be glad for any review of my approach on using gitgitgadget.

Thank you.

On Sat, Oct 5, 2024 at 6:22=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Usman,
>
> On Sat, Oct 5, 2024 at 6:42=E2=80=AFPM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> >
> > Hi Patrick,
> >
> > Following this, I have gone through [1], [2] and some other resources.
> >
> > I was able to get potential three interesting MiniProject which I can
> > work on. I have also checked through the mailing list to ensure no one
> > is working on any of the particular file. As advised, I am sending
> > this just to be sure if it=E2=80=99s worth doing and if it=E2=80=99s ap=
propriate for a
> > miniproject. I am sending three MiniProjects so I can have one to work
> > with in case any of them is not appropriate.
>
> Great, thanks for your interest in working on Git!
>
> > 1. Use test_path_is_* functions in test scripts
> > An approved sample -
> > https://lore.kernel.org/git/20240304095436.56399-2-shejialuo@gmail.com/
> >
> > Two email threads of discussion and feedback from maintainers.
> >
> > https://lore.kernel.org/git/CAPig+cR2-6qONkosu7=3DqEQSJa_fvYuVQ0to47D5q=
x904zW08Eg@mail.gmail.com/
> > https://public-inbox.org/git/CAPig+cRfO8t1tdCL6MB4b9XopF3HkZ=3D=3DhU83A=
FZ38b-2zsXDjQ@mail.gmail.com/
> >
> > Two potential test files which I saw that I can work one.
> >
> > t/t7003-filter-branch.sh
> >
> >
> > test_expect_success 'test that the file was renamed' '
> > test D =3D "$(git show HEAD:doh --)" &&
> > ! test -f D.t &&
> > test -f doh &&
> > test D =3D "$(cat doh)"
> > '
>
> Yeah, this looks like a good instance where test_path_is_* functions
> could be used.
>
> > t/t2003-checkout-cache-mkdir.sh
> >
> > test_expect_success 'use --prefix=3Dpath2/' '
> > rm -fr path0 path1 path2 &&
> > mkdir path2 &&
> > git checkout-index --prefix=3Dpath2/ -f -a &&
> > test -f path2/path0 &&
> > test -f path2/path1/file1 &&
> > test ! -f path0 &&
> > test ! -f path1/file1
> > '
>
> This looks like another good instance.
>
> > These two are asserting that if a file exists, it can be changed to
> > test_file_exist
>
> There is no test_file_exist() function in our test framework as far as
> I can see. I think you should use test_path_is_file() or
> test_path_is_missing() to replace `test -f ...` and ` test ! -f ...`
> respectively.
>
> > 2. Avoid suppressing git=E2=80=99s exit code in test scripts
> >
> > Sample email thread about the same issue.
> > https://public-inbox.org/git/pull.885.v2.git.git.1603032125151.gitgitga=
dget@gmail.com/
> >
> > First file - t/t6050-replace.sh
> > code sample
> > test_expect_success 'replace the author' '
> > git cat-file commit $HASH2 | grep "author A U Thor" &&
> > R=3D$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object
> > -t commit --stdin -w) &&
> > git cat-file commit $R | grep "author O Thor" &&
> > git update-ref refs/replace/$HASH2 $R &&
> > git show HEAD~5 | grep "O Thor" &&
> > git show $HASH2 | grep "O Thor"
> > '
>
> Yeah, I think it would be a good change to remove the pipes after git
> commands in that code.
>
> > Second File - t/t3404-rebase-interactive.sh
> > code sample that needs improvement
> >
> > test_expect_success 'retain authorship' '
> > echo A > file7 &&
> > git add file7 &&
> > test_tick &&
> > GIT_AUTHOR_NAME=3D"Twerp Snog" git commit -m "different author" &&
> > git tag twerp &&
> > git rebase -i --onto primary HEAD^ &&
> > git show HEAD | grep "^Author: Twerp Snog"
> > '
>
> Yeah, here too, I think it would be a good change to remove the pipes
> in that code.
>
> > 3. Modernise test.
> > Description
> > https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2S=
S_b7V8Hg@mail.gmail.com/
> > Sample code t/t7611-merge-abort.sh test_expect_success 'Reset index
> > (but preserve worktree changes)' '
> > git reset "$pre_merge_head" &&
> > git diff > actual &&
> > test_cmp expect actual
> > '
>
> From the sample, it's not clear that the code would benefit a lot from
> being modernized, so I would recommend focusing on improving one of
> the other code you mention above.
>
> Thanks,
> Christian.
