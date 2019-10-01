Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33FEF1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 07:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfJAHB5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 03:01:57 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45872 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAHB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 03:01:57 -0400
Received: by mail-vk1-f196.google.com with SMTP id q192so1957702vka.12
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 00:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g1sdGp6PU7dHWN3CGMxLDOOWdFiYadi6JDPn+4t2dkw=;
        b=HYAHSA4A0kflDhEncUQOL91iac5Dg5sv8JYNin2LA74WAain5u6QU1vwGxfP5dJLfS
         s/o3H/vRFBKuisDuoz7wjurUDvreLQd25N9iqvZvc3CVCSolMhlGm72Ur12zRjsHf7xP
         NGFe7KcxrEpn/eA4rFiY2zpjzx21RnhmT4vadl1hVV5O3EnygJ9INrYnhlx1fVeL8P6y
         ZKXsaivvUQ7H9vAsDC4L9EDlMVVi3n7GuCemCB45aCcGv/UZkkn2B0k9rxMpcC6UgQ2T
         e97c+AimFpLCSgA+W/WXNBNvjKfhi8EK+LLWu3lk6OLeg5L1+8TpelEXxGLFni6jFf6X
         R0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g1sdGp6PU7dHWN3CGMxLDOOWdFiYadi6JDPn+4t2dkw=;
        b=WH5uOtQpflb8xXf5cZ8bR2Pgw47I0RffngP9/Ctmkub5Usc8X+1u5xmwly2Jq+883n
         rUmTokriOeC84wuqMwuSlwBJ6w9XPG8qYJS62NOZbwoHiPGZiD96JeekOXz0ov9TUV2e
         TsBfOfmWKxyey7VSD8C20qmQc0D6rASKg4g6IwRXrvRP4DMEIv5AKIPZpnn9HtWJg49r
         mBVPlt/eJwsfn9Bh5MFTY6dgO65WZWAHvHhKgySYz8FdgL0N0+40LNuzhLExZJuom/tL
         JNt5dS7pSSUA6sDWMo7/IeIuyi0lqGl/3irNl4+iJgFhoY5VbdK8ZUH+pJS+SSpaHtBR
         dyHQ==
X-Gm-Message-State: APjAAAXpTzTwWyxTT5cXzszmVmx9RtK4QCT2oFSlifCOr8Rsyl7Ruw+g
        LW9el+zVL5qllCsli87GajVWnKrCgRJ/LlRTPHEPv2K+
X-Google-Smtp-Source: APXvYqzQBOr/Vx51IIhiQ0lDQbANEobbliIpDR5+ZS8QNJF4i1qNlwJrswbqzJED6Jgkwjx0BKXm4432TQQtOH6eoIs=
X-Received: by 2002:a1f:3f10:: with SMTP id m16mr988697vka.15.1569913315255;
 Tue, 01 Oct 2019 00:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190927171034.GA6542@generichostname> <20190930191106.16128-1-newren@gmail.com>
 <20190930223105.GA86525@generichostname>
In-Reply-To: <20190930223105.GA86525@generichostname>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 Oct 2019 00:01:44 -0700
Message-ID: <CABPp-BGv0zRbvSkXSvF=Q55Z9gJ1od4dsDpTOSDLVv9tppkKnw@mail.gmail.com>
Subject: Re: [PATCH] dir: special case check for the possibility that pathspec
 is NULL
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 30, 2019 at 3:31 PM Denton Liu <liu.denton@gmail.com> wrote:
>
> Hi Elijah,
>
> On Mon, Sep 30, 2019 at 12:11:06PM -0700, Elijah Newren wrote:
> > Commits 404ebceda01c ("dir: also check directories for matching
> > pathspecs", 2019-09-17) and 89a1f4aaf765 ("dir: if our pathspec might
> > match files under a dir, recurse into it", 2019-09-17) added calls to
> > match_pathspec() and do_match_pathspec() passing along their pathspec
> > parameter.  Both match_pathspec() and do_match_pathspec() assume the
> > pathspec argument they are given is non-NULL.  It turns out that
> > unpack-tree.c's verify_clean_subdirectory() calls read_directory() with
> > pathspec =3D=3D NULL, and it is possible on case insensitive filesystem=
s for
> > that NULL to make it to these new calls to match_pathspec() and
> > do_match_pathspec().  Add appropriate checks on the NULLness of pathspe=
c
> > to avoid a segfault.
> >
> > In case the negation throws anyone off (one of the calls was to
> > do_match_pathspec() while the other was to !match_pathspec(), yet no
> > negation of the NULLness of pathspec is used), there are two ways to
> > understand the differences:
> >   * The code already handled the pathspec =3D=3D NULL cases before this
> >     series, and this series only tried to change behavior when there wa=
s
> >     a pathspec, thus we only want to go into the if-block if pathspec i=
s
> >     non-NULL.
> >   * One of the calls is for whether to recurse into a subdirectory, the
> >     other is for after we've recursed into it for whether we want to
> >     remove the subdirectory itself (i.e. the subdirectory didn't match
> >     but something under it could have).  That difference in situation
> >     leads to the slight differences in logic used (well, that and the
> >     slightly unusual fact that we don't want empty pathspecs to remove
> >     untracked directories by default).
> >
> > Helped-by: Denton Liu <liu.denton@gmail.com>
> > Helped-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > This patch applies on top of en/clean-nested-with-ignored, which is now
> > in next.
> >
> > Denton found and analyzed one issue and provided the patch for the
> > match_pathspec() call, SZEDER figured out why the issue only reproduced
> > for some folks and not others and provided the testcase, and I looked
> > through the remainder of the series and noted the do_match_pathspec()
> > call that should have the same check.
>
> Thanks for catching what I missed.
>
> >
> > So, I'm not sure who should be author and who should be helped-by; I
> > feel like their contributions are possibly bigger than mine.  While I
> > tried to reproduce and debug, they ended up doing the work, and I just
> > looked through the rest of the series for similar issues and wrote up
> > a commit message.  *shrug*
>
> Eh, it doesn't really matter to me. GitHub appears to have de facto
> standardised the Co-authored-by: trailer to allow credit to be split
> amonst multiple authors so _maybe_ we could use that, but I'm pretty
> impartial.
>
> >
> >  dir.c                 |  8 +++++---
> >  t/t0050-filesystem.sh | 23 +++++++++++++++++++++++
> >  2 files changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/dir.c b/dir.c
> > index 7ff79170fc..bd39b86be4 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -1962,8 +1962,9 @@ static enum path_treatment read_directory_recursi=
ve(struct dir_struct *dir,
> >                       ((state =3D=3D path_untracked) &&
> >                        (get_dtype(cdir.de, istate, path.buf, path.len) =
=3D=3D DT_DIR) &&
> >                        ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
> > -                       do_match_pathspec(istate, pathspec, path.buf, p=
ath.len,
> > -                                         baselen, NULL, DO_MATCH_LEADI=
NG_PATHSPEC) =3D=3D MATCHED_RECURSIVELY_LEADING_PATHSPEC))) {
> > +                       (pathspec &&
> > +                        do_match_pathspec(istate, pathspec, path.buf, =
path.len,
> > +                                          baselen, NULL, DO_MATCH_LEAD=
ING_PATHSPEC) =3D=3D MATCHED_RECURSIVELY_LEADING_PATHSPEC)))) {
> >                       struct untracked_cache_dir *ud;
> >                       ud =3D lookup_untracked(dir->untracked, untracked=
,
> >                                             path.buf + baselen,
> > @@ -1975,7 +1976,8 @@ static enum path_treatment read_directory_recursi=
ve(struct dir_struct *dir,
> >                       if (subdir_state > dir_state)
> >                               dir_state =3D subdir_state;
> >
> > -                     if (!match_pathspec(istate, pathspec, path.buf, p=
ath.len,
> > +                     if (pathspec &&
> > +                         !match_pathspec(istate, pathspec, path.buf, p=
ath.len,
> >                                           0 /* prefix */, NULL,
> >                                           0 /* do NOT special case dirs=
 */))
> >                               state =3D path_none;
> > diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> > index 192c94eccd..edb30f9eb2 100755
> > --- a/t/t0050-filesystem.sh
> > +++ b/t/t0050-filesystem.sh
> > @@ -131,4 +131,27 @@ $test_unicode 'merge (silent unicode normalization=
)' '
> >       git merge topic
> >  '
> >
> > +test_expect_success CASE_INSENSITIVE_FS 'checkout with no pathspec and=
 a case insensitive fs' '
> > +     git init repo &&
> > +     (
> > +             cd repo &&
> > +
> > +             >Gitweb &&
> > +             git add Gitweb &&
> > +             git commit -m "add Gitweb" &&
> > +
> > +             git checkout --orphan todo &&
> > +             git reset --hard &&
> > +             # the subdir is crucial, without it there is no segfault
>
> We should either remove this comment or change the justification. A
> future reader may be confused at what particular segfault this refers
> to.

Yep, good point, I'll just go ahead and remove it.

> > +             mkdir -p gitweb/subdir &&
> > +             >gitweb/subdir/file &&
> > +             # it is not strictly necessary to add and commit the
> > +             # gitweb directory, its presence is sufficient
>
> Same here, its presence is sufficient to... what?

I will clean this one too and send a v2 tomorrow; it's getting late.

Thanks for all the digging you did on this bug to get it sorted out,
Denton; I really appreciate it.

Elijah
