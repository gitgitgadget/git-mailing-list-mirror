Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B89EC433ED
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 13:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A87361184
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 13:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhDXNee (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 09:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhDXNe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 09:34:27 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB524C061574
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 06:33:47 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z14so1156502ioc.12
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 06:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S/iEuBU+l9fdzQmT61r/I9V2PMDGjiFLGtXbQSesog8=;
        b=JTBCfI2CnvSVo3wYvf5J5lCon8gXhr34hkvNoHbNnR88VYr4dFQSHA8+rx+CwR+2Ej
         UYhWrD1tkPa7xJ4Vj7wqP5fNtIPOVPjbJvNXqPIcsZv8A9DH3m5bi0RFjOTlFrZowJYA
         hP0tfPhNCKiigst8aryt8tpqF+ZOHCaDys5wg+TIsnrYVGUDwO32nZtk7IAIjcE8k4Kj
         u4/ZC6Z4t8I2WlBrvu6UTvCj0hDp3/prEKm6lxPc3UIMSwXKQHFAjnhVAmcW1yCizcRH
         CJ7BuN8yxb7fn14F+I/M6CEFzjCX7S1MCJ8K3+PQKyHuP8jTkufkg2PouDlnAiQz2ann
         AoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S/iEuBU+l9fdzQmT61r/I9V2PMDGjiFLGtXbQSesog8=;
        b=EB4EevxJwq3TdHYGpFxXT72KL094vidL+rkp9VcPxWRHyDgsCLv1ICttCtbAoXQHB2
         0VhoTf6PXRzJLGkBAdYb1Sa1/lfJQUMMxQ0zxBOi2PSIpDbpuIsoRRHwY9JVIZNJSXq6
         yGo9r04QVoDcktSlVzygYWEZf+OkB85gG49yhS043v1ji78BwR05vJW2h/4dWGBDE0XO
         kkpmM956F9Gdj6qsaCwPS3iqbndXsVEbfBbxjX3Xh2RFcvuDVHZiApkaiAVckww2e7/M
         cNRmdrU13IH5LGOV7Hl64Z3Lryaf5XcCpBdwOEcMk5RuHJ0+dMyDCWYI1rU2pgGzsz27
         82ng==
X-Gm-Message-State: AOAM5306w6CMIMlyzJsCP2ls+1zh24PpCSNSR+nLnMTvnA9XIcXFb8od
        293FMjJRAH9OgzX4etxGO+oRCml5qTMalhb3IOs=
X-Google-Smtp-Source: ABdhPJyfLIFubhyjKLXxEytI5iAWlInmTvxxjDYTN/2lGh2kPZU5sCN4B7oKZjKSOt4d03aMMdIW7IiSlJUTz31fNM0=
X-Received: by 2002:a05:6602:2f10:: with SMTP id q16mr7104146iow.106.1619271227189;
 Sat, 24 Apr 2021 06:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.939.git.1619195245606.gitgitgadget@gmail.com> <c6b43262-7ce4-b32e-3ff4-9edb66f2a20b@iee.email>
In-Reply-To: <c6b43262-7ce4-b32e-3ff4-9edb66f2a20b@iee.email>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 24 Apr 2021 21:33:34 +0800
Message-ID: <CAOLTT8SJW7+9Mxa7baTj+dSjkOyYQKNhWJbBdQAHKRp49j1yZA@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] pretty: provide human date format
To:     philipoakley@iee.email
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> =E4=BA=8E2021=E5=B9=B44=E6=9C=8824=
=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=885:10=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On 23/04/2021 17:27, ZheNing Hu via GitGitGadget wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Add the placeholders %ah and %ch to format author date and committer
> > date, like --date=3Dhuman does, which provides more humanity date outpu=
t.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] pretty: provide human date format
> >
> >     Reasons for making this patch: --date=3Dhuman has no corresponding
> >     --pretty option.
> >
> >     Although --date=3Dhuman with --pretty=3D"%(a|c)d" can achieve the s=
ame
> >     effect with --pretty=3D"%(a|c)h", but it can be noticed that most t=
ime
> >     formats implement the corresponding option of --pretty, such as
> >     --date=3Diso8601 can be replaced by --pretty=3D%(a|c)i, so add
> >     "--pretty=3D%(a|c)h" seems to be a very reasonable thing.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-939%2=
Fadlternative%2Fpretty_human-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-939/adlt=
ernative/pretty_human-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/939
> >
> >  Documentation/pretty-formats.txt | 2 ++
> >  pretty.c                         | 3 +++
> >  t/t4205-log-pretty-formats.sh    | 6 ++++++
> >  3 files changed, 11 insertions(+)
> >
> > diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
> > index 45133066e412..9cdcdb8bb414 100644
> > --- a/Documentation/pretty-formats.txt
> > +++ b/Documentation/pretty-formats.txt
> > @@ -190,6 +190,7 @@ The placeholders are:
> >  '%ai':: author date, ISO 8601-like format
> >  '%aI':: author date, strict ISO 8601 format
> >  '%as':: author date, short format (`YYYY-MM-DD`)
> > +'%ah':: author date, human style
>
> An example may be useful. There's no other mention of human date style
> in the pretty-formats doc. Or a link to the definitive man page.
>

Thanks for the suggestion. Note that the explanation here is relatively sma=
ll,
and human style has many different situations, so I may just go to link it =
to
`rev-list-option.txt`, This is more convenient than showing multiple situat=
ions'
examples.

> >  '%cn':: committer name
> >  '%cN':: committer name (respecting .mailmap, see
> >       linkgit:git-shortlog[1] or linkgit:git-blame[1])
> > @@ -206,6 +207,7 @@ The placeholders are:
> >  '%ci':: committer date, ISO 8601-like format
> >  '%cI':: committer date, strict ISO 8601 format
> >  '%cs':: committer date, short format (`YYYY-MM-DD`)
> > +'%ch':: committer date, human style
> Likewise, an `(e.g. ????)` to unconfuse readers.
> >  '%d':: ref names, like the --decorate option of linkgit:git-log[1]
> >  '%D':: ref names without the " (", ")" wrapping.
> >  '%(describe[:options])':: human-readable name, like
> > diff --git a/pretty.c b/pretty.c
> > index e5b33ba034bd..b1ecd039cef2 100644
> > --- a/pretty.c
> > +++ b/pretty.c
> > @@ -745,6 +745,9 @@ static size_t format_person_part(struct strbuf *sb,=
 char part,
> >       case 'I':       /* date, ISO 8601 strict */
> >               strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_S=
TRICT)));
> >               return placeholder_len;
> > +     case 'h':       /* date, human */
> > +             strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(HUMAN)));
> > +             return placeholder_len;
> >       case 's':
> >               strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
> >               return placeholder_len;
> > diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
.sh
> > index cabdf7d57a00..d4d75b0b350e 100755
> > --- a/t/t4205-log-pretty-formats.sh
> > +++ b/t/t4205-log-pretty-formats.sh
> > @@ -539,6 +539,12 @@ test_expect_success 'short date' '
> >       test_cmp expected actual
> >  '
> >
> > +test_expect_success 'human date' '
> > +     git log --format=3D%ad%n%cd --date=3Dhuman >expected &&
> > +     git log --format=3D%ah%n%ch >actual &&
> > +     test_cmp expected actual
> > +'
> > +
> >  # get new digests (with no abbreviations)
> >  test_expect_success 'set up log decoration tests' '
> >       head1=3D$(git rev-parse --verify HEAD~0) &&
> >
> > base-commit: b0c09ab8796fb736efa432b8e817334f3e5ee75a
> --
> Philip

Thanks!
--
ZheNing Hu
