Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993F2C433E0
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625A46196F
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCVKYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 06:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCVKXw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 06:23:52 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA13C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:23:52 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id c16so3595875oib.3
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xERa8YwC7xyr7gyA/Wz55e2NKEYAMfcL9oIbduQp/As=;
        b=JPMq4G9HCHPrKQOhjoUDi7WCi6WVB8OhUEG2ZlQ3OnIEQBhEaMwi4hG84LVBEYzH9V
         lg2LlXSiqyd2hku4FAnYF+u3V8lCbVo/7ynR3bUJvS2B16UDEDsoybL1rCrK+/0nwhRV
         +p7GYS9MjTHZXX1m+KtVhJShoicJBJTiaG7jMsoxPIx4ce5uYonTfeK8tsgZS0BBpJzS
         lRyANq1DkkIThrL2MFqPKAqpyg1nk18D2l195U8gerGWsjZwgfcA6ojXnyKRGegm+zws
         QDuYzFba/+JsjXqoe3LJnwb17Je4ws0+j1gMcuz4R4CP27FP5XUUMzAF7vQYsCEiIU0X
         BMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xERa8YwC7xyr7gyA/Wz55e2NKEYAMfcL9oIbduQp/As=;
        b=qXFdSnuakWBcXIC8+T3kbefhkEVbzlTyKQ6kHmJxXnSdGIMmRbS2JRsjU71wXVhaDY
         nK4OiBfo24J2WVjI0m3sQrcgVJNaln9IuGmAB6vsuOEtm/fXDHlPYCJ0efssYc4Tq61f
         vmYZCpUHEXlzqLMMCwaQmCjkpmhlf9sgGtTvE26plZtgBNjGqkzQFq0KHIswB6uN8b44
         zxZIhfd1xQbpd5+I1NK6oxeFW4+1qLshf24ly5S3cxjOjp0zSk2agAVpGVolkoZt2ZdQ
         R0m+dsw2WV0d5WLZts4vUwlhKeccY8x5r4guCuEU//bReT8vboEjmFO447mJbYQGdcNA
         bVpg==
X-Gm-Message-State: AOAM532lXv6Z/UcH45C1qZlNd/7rFEN1eR39ZJJsZCxem/y0OfwY5P7u
        ERDlGBD7IYZc04xXwndCsQC9ly7Ks7v3BMJQkg0=
X-Google-Smtp-Source: ABdhPJx3kZlz5Vroi/gpSoRpZR2ug/p0+b79/r9hEiRGm90mvhwxnfCYA24CnSUB8ZbHYrSkzh06aUcwMqssvHDOdiM=
X-Received: by 2002:aca:d68e:: with SMTP id n136mr9707573oig.179.1616408631277;
 Mon, 22 Mar 2021 03:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
 <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com> <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
In-Reply-To: <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 22 Mar 2021 18:23:39 +0800
Message-ID: <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8822=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:43=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Mar 22, 2021 at 5:24 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Historically, Git has supported the 'Signed-off-by' commit trailer
> > using the '--signoff' and the '-s' option from the command line.
> > But users may need to provide other trailer information from the
> > command line such as "Helped-by", "Reported-by", "Mentored-by",
> >
> > Now implement a new `--trailer <token>[(=3D|:)<value>]` option to pass
> > other trailers to `interpret-trailers` and insert them into commit
> > messages.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > Reported-by:
>
> Why is there this "Reported-by:" trailer with an empty value? If you
> are looking to add trailers to this commit message, you might want to
> add them before your "Signed-off-by".
>

Sorry, It was purely a small accident during testing and I didn't notice it=
.

> > ---
> >     [GSOC] commit: add --trailer option
> >
> >     Now maintainers or developers can also use commit
> >     --trailer=3D"Signed-off-by:commiter<email>" from the command line t=
o
> >     provide trailers to commit messages. This solution may be more
> >     generalized than v1.
>
> It's not a big deal as this is not going into the commit message, but
> at this point (v13) you might want to tell explicitly what solution v1
> implemented, instead of referring to it.

Ok.

>
> >      @@ t/t7502-commit-porcelain.sh: test_expect_success 'sign off' '> =
      + sed -e "1,/^\$/d" commit.msg >actual &&
> >       + test_cmp expected actual
> >       +'
> >      ++
> >      ++test_expect_success 'commit --trailer with -c and command' '
> >      ++ trailer_commit_base &&
> >      ++ cat >expected <<-\EOF &&
> >      ++ hello
> >      ++
> >      ++ Signed-off-by: C O Mitter <committer@example.com>
> >      ++ Signed-off-by: C1 E1
> >      ++ Helped-by: C2 E2
> >      ++ Mentored-by: C4 E4
> >      ++ Reported-by: A U Thor <author@example.com>
> >      ++ EOF
> >      ++ git -c trailer.report.key=3D"Reported-by: " \
> >      ++         -c trailer.report.ifexists=3D"replace" \
> >      ++         -c trailer.report.command=3D"git log --author=3D\"\$ARG=
\" -1 \
> >      ++         --format=3D\"format:%aN <%aE>\"" \
> >      ++         commit --trailer "report =3D author" --amend &&
> >      ++ git cat-file commit HEAD >commit.msg &&
> >      ++ sed -e "1,/^\$/d" commit.msg >actual &&
> >      ++ test_cmp expected actual
> >      ++'
>
> Nice that you have added such a test!

Thanks.

But at the same time I have two little doubt.

1.
If we have your config:

$ git config trailer.sign.key "Signed-off-by: "
$ git config trailer.sign.ifexists replace
$ git config trailer.sign.command "git log --author=3D'\$ARG' -1
--format=3D'format:%aN <%aE>'"

Then I touch a test.c and use:

$ git interpret-trailers --in-place test.c

without `--trailer`, See what is happen:

It seem like your local repo last commit "name <email>" pair
have been record in `test.c`.

Could this be considered a bug?

2.
`git interpret-trailers --in-place`  seem like work on git top-dir,
If I am in a sub-dir `b` and I want to change a file such as `d.c`,
then I must use `git interpret-trailers --in-place b/d.c` to add some
trailers.

I think the original intention of `--in-place` is to modify a file similar =
to
"$COMMIT_MSG_FILE", so make it run at top-dir, but this is not reflected
in the git documentation. This at least confuses people who use this
option for the first time. Is it worth modifying? Or is there something
wrong with the design of `--in-place`?

--
ZheNing Hu
