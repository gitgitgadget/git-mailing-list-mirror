Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF5EC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 16:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 603D764DCF
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 16:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhBQQTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 11:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbhBQQTM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 11:19:12 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF5CC061786
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 08:18:31 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id v193so15486770oie.8
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 08:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VXuGUQAFo3kFuM+XSrpZ04pWgPLQVDdOcMsu5y2t49o=;
        b=uGoiv8bZlbQWqY431+EUgW/FwWXW62HChhIfNhexQ0eN+aPVqv7n+A+PvZVkl5IlIb
         dVqmVdTrvItYhdxAFetZn1c5z0IsBd1otgEmIvApXSMTg4M5wumOVprgVpk7cxtZn5u8
         VOKyKaSAUa+d+HvreXS8dOzNWIPL+iSY1QZzPnmOS81x3BJWvr71eYt8roP8WXXVhVat
         xEAYuN872VvzZkrFVCUqNCJqUTmAwD8z0K7dABrCNheNXhporOT+aYAiu7xYZ0SBjudI
         fG9iKN2+t3gcI5o4zhq5WWXmLql2JZ3zli7CDrOEUndatvgRjzeX4MrdElFboxJZMjCq
         rbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VXuGUQAFo3kFuM+XSrpZ04pWgPLQVDdOcMsu5y2t49o=;
        b=CMekaRhfggg2OqWmTDBqcTf8WjTGTUAU1oRmX4eUOb7UlRV/IfAHB0T+X5Fyk8zXNp
         eAT19BGJ4iaWByJX5OwXj190lp9g4op+fGI731OVKdoHO6Ailnd6xmxW/1Go6VTElLbm
         jqmvQcmVuhdZWplIWEosGTzz07uraS/oxwNetNM/p4pZTX7jeJBAjd4nWaTskIuLlayY
         FqXBV8eBw2GHy8b2W+bgn38aJJlEJH83mw7dmNMB3iLG0k7bKB8PX3gGwEJvXDoAU5et
         IRV/HtN5d7EDP3j5ompqKv4eLtJPrPS4zHQOM+//z7mK1iukr5XLrLPEr+ItQ1zJJX+k
         f0Gg==
X-Gm-Message-State: AOAM533A2cYqJuuDuqk0qBY4Mu7UzJ1rr2Um5XL49yWdeweQzENuxcEd
        ohorWR8vfumfFYmYOWadYFZB4I0b2UmvZSjbl1g=
X-Google-Smtp-Source: ABdhPJwIFsAusCcUwPKwLV4ic788X2tdIfEEDCHeAetWoodGiZUpTtQCh5r/ga7b2+anLBiz5BP9NSKhp5YhnMxlmI8=
X-Received: by 2002:aca:52d1:: with SMTP id g200mr6378912oib.44.1613578711397;
 Wed, 17 Feb 2021 08:18:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
 <pull.870.v5.git.1613480198.gitgitgadget@gmail.com> <98e2707ee2faf653e972b0706311ddd099765ce5.1613480198.git.gitgitgadget@gmail.com>
 <xmqq8s7nm1dv.fsf@gitster.g>
In-Reply-To: <xmqq8s7nm1dv.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 18 Feb 2021 00:18:18 +0800
Message-ID: <CAOLTT8QSuNs6=Um=E0FOBWM+xXx3sbmCx1j+GkeyomTsuwjjKw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] difftool.c: learn a new way start at specified file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:31=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > `git difftool` only allow us to select file to view in turn.
> > If there is a commit with many files and we exit in the search,
>
> I am not sure what "in the search" refers to.  "in the middle" I
> would understand, though.
>
> > We will have to traverse list again to get the file diff which
>
> Let's downcase this "We".
>
> > we want to see. Therefore, here is a new method: user can use
> > `git difftool --rotate-to=3D<filename>` or `git difftool --skip-to=3D<f=
ilename>`
> > to start viewing from the specified file, This will improve the
> > user experience.
>
> Do we need both?  I'd rather not to give end-user-facing commands
> too many knobs that would do similar things.  Too many choices to
> choose from without clear answer to "which one should I prefer to
> use?" is a bad combination for end-users.
>
So users will not need to use `git difftool --skip-to`? Then I am confused
about the meaning of `git difftool --skip-to`.
> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
> > index 7c5b3cf42bcc..aa2b5c11f20b 100644
> > --- a/Documentation/diff-options.txt
> > +++ b/Documentation/diff-options.txt
> > @@ -701,7 +701,7 @@ components matches the pattern.  For example, the p=
attern "`foo*bar`"
> >  matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
> >
> >  --skip-to=3D<file>::
> > ---rotate-to=3D<file::
> > +--rotate-to=3D<file>::
> >       Discard the files before the named <file> from the output
> >       (i.e. 'skip to'), or move them to the end of the output
> >       (i.e. 'rotate to').  These were invented primarily for use
>
> Thanks for correcting, but this change should not be a part of this
> patch.  Instead, you help the other's topic by giving a review (and
> you could just have said "there there is closing '>' missing").
>
Okay, I will pay attention later.
> > diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftoo=
l.txt
> > index 484c485fd06c..c64dff69c976 100644
> > --- a/Documentation/git-difftool.txt
> > +++ b/Documentation/git-difftool.txt
> > @@ -34,6 +34,16 @@ OPTIONS
> >       This is the default behaviour; the option is provided to
> >       override any configuration settings.
> >
> > +--rotate-to=3D<file>::
> > +     Internally call `git diff --rotate-to=3D<file>`,
> > +     show the change in the specified path first.
> > +     Files before the specified path will be moved to the last output.
> > +
> > +--skip-to=3D<file>::
> > +     Internally call `git diff --skip-to=3D<file>`,
> > +     skip the output to the specified path.
> > +     Files before the specified path will not output.
> > +
>
> This, unlike the "diffcore" stuff, is end-user facing, and it is
> better not to force the readers even know what --skip-to option
> to the diff does (after all, difftool users are using 'git difftool'
> and they are not necessarily 'git diff' users).
>
>     --skip-to=3D<file>::
>             Start showing the diff for the given path, skipping all
>             the paths before it.
>
> or something, perhaps.
>
> > +test_expect_success 'difftool --skip-to' '
> > +     difftool_test_setup &&
> > +     test_when_finished git reset --hard &&
> > +     git difftool --no-prompt --extcmd=3Dcat --skip-to=3D"2" HEAD^ >ou=
tput &&
> > +     cat >expect <<-\EOF &&
> > +     2
> > +     4
> > +     EOF
> > +     test_cmp output expect &&
> > +     test_must_fail git difftool --no-prompt --extcmd=3Dcat --skip-to=
=3D"3" HEAD^
> > +'
>
> This probably should be split into two independent tests.  One to
> check that the non-failing case works as expected, the other to
> check that a bogus command line option errors out as expected.
>
I will finish it.
> Thanks.

Besides, I have some curiosity about one place in the code in your
patch:
> int cmd_diff_tree(...)
> ...
> if (read_stdin) {
> ...
> opt->diffopt.rotate_to_strict =3D 0;
> ...
}
This is the only place where rotate_to_strict is set to zero,
So the "git log -p" you mentioned earlier is here Called this code
to avoid exiting  the program because of the wrong path, right?

Thanks.
