Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C9EC05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 16:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjBJQ6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 11:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjBJQ6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 11:58:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CA9BB87
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 08:57:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDDFCB82596
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 16:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E958C433EF
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 16:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676048245;
        bh=rtLuRe3wqhv00EDW3Ix90qjIZN+9Ni5tH6nC1iSFXlw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F0gHdNJfUe6P+/Vhq6WUEklJA9g9PyAXpk8wfygMcQEnvJtL/Ap3VO+jMFlseSKWw
         97k2YMRbdrGiilgWwERL4tmRhizQFUvIZAIY3j0DLdVsPUWcl5Gsqa9qhjccksqdt/
         IJs03hDXmkV24gKRcL47iM54Nm8i/c+asdQXQNntIBCMFNUVIL8pT21p3ksnfUkosk
         9I6qNwhT8oLSf+ogWiQODowoRC3OqDFRdFLvcUlNDA6UBwuqQOcnWIJ+1gX3MTrSa1
         FheK+AT34/jCZi0PlJwsfkvfBTUJndbHJkJwPENPQC82BgBSarwjtyclaQxBXXbHU0
         zprzqqQUYMp7A==
Received: by mail-oi1-f170.google.com with SMTP id bx13so4905215oib.13
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 08:57:25 -0800 (PST)
X-Gm-Message-State: AO0yUKWZPbj/CLOVuH5peOkw6Lqvi+Z3/DZn4JzeSxBhfAhYWw5mPIUj
        R4ENMqOGeqpknqe1c0bZeb0bKxov5fUtQvTQSiM=
X-Google-Smtp-Source: AK7set9969wO2KxiQxuh8DVDwMlHoqnDGwWJTeMYlK021vL7xsfJ2UoBVYJE+FPL17vOdilar28ozERo+iIEVI/Da0o=
X-Received: by 2002:aca:210c:0:b0:35e:7c55:b015 with SMTP id
 12-20020aca210c000000b0035e7c55b015mr1335802oiz.287.1676048244884; Fri, 10
 Feb 2023 08:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20230210075939.44949-1-masahiroy@kernel.org> <20230210075939.44949-2-masahiroy@kernel.org>
 <230210.861qmxwtbz.gmgdl@evledraar.gmail.com>
In-Reply-To: <230210.861qmxwtbz.gmgdl@evledraar.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 11 Feb 2023 01:56:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNASLR6VLoX+Mf5MTemAMbts81kqf=dM5Bzne1QdZpT7tgQ@mail.gmail.com>
Message-ID: <CAK7LNASLR6VLoX+Mf5MTemAMbts81kqf=dM5Bzne1QdZpT7tgQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] git-compat-util: add isblank() and isgraph()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2023 at 10:20 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Feb 10 2023, Masahiro Yamada wrote:
>
> > git-compat-util.h implements most of is*() macros.
> >
> > Add isblank() and isgraph(), which are useful to clean up wildmatch.c
> > in a consistent way (in this and later commits).
>
> You are on a journey to fix wildmatch.c, so...
>
> > The same issue already exists for isspace().
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> > [...]
> > -#ifdef isblank
> > -# define ISBLANK(c) (ISASCII(c) && isblank(c))
> > -#else
> > -# define ISBLANK(c) ((c) =3D=3D ' ' || (c) =3D=3D '\t')
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
> You make this change, but not others in tree.
>
> Personally I wouldn't mind seeing this expanded to fix the various other


I wouldn't mind seeing somebody use this for tree-wide cleanups.
I do not see any reason to do that in this patch set, either.





> trivially convertable cases in-tree, e.g.:
>
>         $ git -P grep -n "(' '|'\\\t').*\|\|.*(' '|'\\\t')"
>         builtin/am.c:602:               if (*sb.buf =3D=3D '\t' || *sb.bu=
f =3D=3D ' ')
>         compat/regex/regex_internal.h:60:# define isblank(ch) ((ch) =3D=
=3D ' ' || (ch) =3D=3D '\t')
>         compat/regex/regex_internal.h:73:   return (c =3D=3D ' ' || c =3D=
=3D '\t');
>         config.c:893:   while (c =3D=3D ' ' || c =3D=3D '\t')
>         fsck.c:837:     while (*p =3D=3D ' ' || *p =3D=3D '\t')
>         mailinfo.c:749:     (line->buf[0] =3D=3D ' ' || line->buf[0] =3D=
=3D '\t')) {
>         sequencer.c:2476:                (*p =3D=3D ' ' || *p =3D=3D '\t'=
 || *p =3D=3D '\n' || *p =3D=3D '\r' || !*p) &&
>         sequencer.c:2536:                  (*bol =3D=3D ' ' || *bol =3D=
=3D '\t')) {
>         sequencer.c:2540:                                 (*bol =3D=3D ' =
' || *bol =3D=3D '\t')) {
>         sequencer.c:2594:       if (is_command(TODO_PICK, &bol) && (*bol =
=3D=3D ' ' || *bol =3D=3D '\t'))
>         sequencer.c:2597:                (*bol =3D=3D ' ' || *bol =3D=3D =
'\t'))
>         t/helper/test-json-writer.c:443:                if (c =3D=3D '\n'=
 || c =3D=3D '\r' || c =3D=3D ' ' || c =3D=3D '\t')
>         t/helper/test-json-writer.c:449:        while (*buf =3D=3D ' ' ||=
 *buf =3D=3D '\t')
>         t/t4256/1/mailinfo.c:737:           (line->buf[0] =3D=3D ' ' || l=
ine->buf[0] =3D=3D '\t')) {
>         t/t4256/1/mailinfo.c.orig:726:      (line->buf[0] =3D=3D ' ' || l=
ine->buf[0] =3D=3D '\t')) {
>         trailer.c:630:          if (c !=3D line && (*c =3D=3D ' ' || *c =
=3D=3D '\t')) {
>         wildmatch.c:34:# define ISBLANK(c) ((c) =3D=3D ' ' || (c) =3D=3D =
'\t')
>
> Some of those are false positves, but most are not.



--
Best Regards
Masahiro Yamada
