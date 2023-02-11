Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652F8C61DA4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 07:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBKHCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 02:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKHCC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 02:02:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D91C311D7
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 23:02:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB71CB826F4
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 07:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA95C433EF
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 07:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676098918;
        bh=2IDqcY5sJYRAy+pe+PrED7oOaXHJ7B5PrUNH7erzlWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q+0HoBXHhUOZfUuKXQdjFB/jfKpASSoP/Z2AIFcqSCUKr/vFsxzvxXbzUgrVi1u/s
         +qewkFMCarGTOueTgslkBcuPB9DIttq4pAoxvrbZCL8DB+GOX7VMyd/srDngSA3+Ll
         OaOhZ2jfdiPCliUeEUSZgb+1A3uFp3L+joyNHGQYWXKj04OXmIDILd5ItIf4Uw4ixh
         mcSthvZAzsV6yJtjF7kvhnvFDk1F8jlcHOIgRTidFp6YsonKWVMgXm3W0KEUOSbI9O
         UFOICi+usn4ZrgF9CqEfblHjKFQ9pYogz6xDC/jd19FTrEhFMT20zqHis7I3nmswjD
         OH4Wb7DJJ9eVw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-15fe106c7c7so9419256fac.8
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 23:01:58 -0800 (PST)
X-Gm-Message-State: AO0yUKVZzqht4z94auh32Wf8Q54VLF1ZJwH35gRkbh0Q9JFMdbUHcQEg
        JXL49Qa7emTjhHMwV8Fzj2dxk1zI8QbZimiM9lo=
X-Google-Smtp-Source: AK7set8CZNgIHn+yewBu5+1HzNBsdQD/4LMpHnsWNeIVCB0bH2NFYtWBC9jaBykcW4w1fsM02LCyxccjjg7dpE9/Wjk=
X-Received: by 2002:a05:6870:f628:b0:163:a45a:9e41 with SMTP id
 ek40-20020a056870f62800b00163a45a9e41mr1462006oab.194.1676098917386; Fri, 10
 Feb 2023 23:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20230210075939.44949-1-masahiroy@kernel.org> <20230210075939.44949-2-masahiroy@kernel.org>
 <654092a2-6d3e-7ab4-a747-1ce36daad03d@web.de>
In-Reply-To: <654092a2-6d3e-7ab4-a747-1ce36daad03d@web.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 11 Feb 2023 16:01:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNATHnjNe0Bagd4HOkNKXS_-5C5oU0cgQ-rFT6sgF33G+1A@mail.gmail.com>
Message-ID: <CAK7LNATHnjNe0Bagd4HOkNKXS_-5C5oU0cgQ-rFT6sgF33G+1A@mail.gmail.com>
Subject: Re: [PATCH 1/5] git-compat-util: add isblank() and isgraph()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 11, 2023 at 7:03 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 10.02.23 um 08:59 schrieb Masahiro Yamada:
> > git-compat-util.h implements most of is*() macros.
> >
> > Add isblank() and isgraph(), which are useful to clean up wildmatch.c
> > in a consistent way (in this and later commits).
> >
> > Use them with care because they are not robust against the pointer
> > increment, like isblank(*s++).
> >
> > The same issue already exists for isspace().
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  git-compat-util.h |  4 ++++
> >  wildmatch.c       | 14 ++------------
> >  2 files changed, 6 insertions(+), 12 deletions(-)
> >
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 4f0028ce60..90b43b2bc9 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -1212,10 +1212,12 @@ extern const unsigned char tolower_trans_tbl[25=
6];
> >  /* Sane ctype - no locale, and works with signed chars */
> >  #undef isascii
> >  #undef isspace
> > +#undef isblank
> >  #undef isdigit
> >  #undef isalpha
> >  #undef isalnum
> >  #undef isprint
> > +#undef isgraph
> >  #undef islower
> >  #undef isupper
> >  #undef tolower
> > @@ -1236,10 +1238,12 @@ extern const unsigned char sane_ctype[256];
> >  #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask))=
 !=3D 0)
> >  #define isascii(x) (((x) & ~0x7f) =3D=3D 0)
> >  #define isspace(x) sane_istest(x,GIT_SPACE)
> > +#define isblank(x) (isspace(x) || (x) =3D=3D '\t')
>
> Our isspace() matches \t, \n, \r and space.  A standard implementation
> would also match \v (vertical tab) and \f (form feed).  Anyway, your
> isblank() here is the same as isspace() because the check for \t is
> redundant...


My bad - I missed 'Z' in cane_ctype[].


>
> >  #define isdigit(x) sane_istest(x,GIT_DIGIT)
> >  #define isalpha(x) sane_istest(x,GIT_ALPHA)
> >  #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
> >  #define isprint(x) ((x) >=3D 0x20 && (x) <=3D 0x7e)
> > +#define isgraph(x) (isprint(x) && !isspace(x))
> >  #define islower(x) sane_iscase(x, 1)
> >  #define isupper(x) sane_iscase(x, 0)
> >  #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
> > diff --git a/wildmatch.c b/wildmatch.c
> > index 7e5a7ea1ea..85c4c7f8a7 100644
> > --- a/wildmatch.c
> > +++ b/wildmatch.c
> > @@ -28,18 +28,8 @@ typedef unsigned char uchar;
> >  # define ISASCII(c) isascii(c)
> >  #endif
> >
> > -#ifdef isblank
> > -# define ISBLANK(c) (ISASCII(c) && isblank(c))
> > -#else
> > -# define ISBLANK(c) ((c) =3D=3D ' ' || (c) =3D=3D '\t')
>
> ... and that's not the case for the original code, which only
> matches \t and space.
>
> We already use eight bits for the lookup table values in sane_ctype.
> Perhaps it's time to move GIT_GLOB_SPECIAL, GIT_REGEX_SPECIAL,
> GIT_PATHSPEC_MAGIC and GIT_PUNCT to their own table to make room for
> flags for isprint(), isgraph() and isblank().



I think that is a good idea.

If we can have more room for isupper() and islower(),
we will be able to delete sane_iscase().


(I was thinking 'unsigned short', but having two tables is OK.)



So, how can I proceed with this patchset?



[A] After somebody refactors ctype.c table,
    I will rebase this series on top of that.

[B] keep isblank() and isgraph() local to wildmatch.c
    until that happens, so I can proceed without
    depending on the ctype.c refactoring.

    Apparently, wildmatch.c is not using a pointer
    increment with isblank() or isgraph().

[C] If 'somebody' in [A] is supposed to me,
    my v2 will include ctype refactoring.



Thought?





> > -#endif
> > -
> > -#ifdef isgraph
> > -# define ISGRAPH(c) (ISASCII(c) && isgraph(c))
> > -#else
> > -# define ISGRAPH(c) (ISASCII(c) && isprint(c) && !isspace(c))
> > -#endif
> > -
> > +#define ISBLANK(c) (ISASCII(c) && isblank(c))
> > +#define ISGRAPH(c) (ISASCII(c) && isgraph(c))
> >  #define ISPRINT(c) (ISASCII(c) && isprint(c))
> >  #define ISDIGIT(c) (ISASCII(c) && isdigit(c))
> >  #define ISALNUM(c) (ISASCII(c) && isalnum(c))
>
--
Best Regards
Masahiro Yamada
