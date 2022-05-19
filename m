Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF94C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 12:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiESMlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 08:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbiESMlv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 08:41:51 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DE0A776B
        for <git@vger.kernel.org>; Thu, 19 May 2022 05:41:49 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id v14so4687295qtc.3
        for <git@vger.kernel.org>; Thu, 19 May 2022 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZO1kam2IJMk1d37y61EpBU7Y6jiAfply8K2ETQijaHg=;
        b=gO6XZReCgrT3EigrtQ46L/PSJOHtnSWHpx+U5417SpHe9ddnXzBegh4zipe1t7bG+c
         tAIVCkqNfXgpbnNj6Rk/fkFBGAVZ6vZO1KR26jrLn3IVuV9qa1y9fYh670b9ZJ7VYK82
         MI8Z1Clz13aPldaGYpPDtEkSIaKa4vOJFWs59a8hLSMiYdWWW2lbihYvTfRR4SliKIqU
         uPN0EBibXiz003aDfkVtP49ZI0kETppEH5+j/9eg1gat4KetZ+LYwqvmQFuBbFBi3UIV
         ycIvuf/RPWEaT050OWmnhq/GOuCukjUcEOLxcruN/zL+wjts7Zpz4ySV5fHzRkdhEWNm
         FNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZO1kam2IJMk1d37y61EpBU7Y6jiAfply8K2ETQijaHg=;
        b=ZEgF0hplsoc+cmjn4dJXG3LB+DRWsCVWPmbdnTYFPhjELGsynBhlP2NoEsMXoxiSUc
         HG1SXduh3wj2/oKeFoegs+NFetreESZPC1idS6QY0fOZyBMC5+t+YA33abLvf00diQAk
         vMviKI/Xf+91CShJrPtijiA9Ok4H2yrnlfUgG/FJzabC2wP6gBZY1soi8yYSazB4cCez
         c8T/M6BhKtH25cSsiiPDxge2LmeyyWVhbGGJ33qF4sXy9tJpZYRxiNRzvu7V0jjm52DZ
         sfzcK5AlIMtNBu9CA99PgcX1Rppn+MCpCAelM3ZqGfucBtQ8/NWRnvzDtZmtai47xytC
         ypxw==
X-Gm-Message-State: AOAM531hKJhI9Bc7tudYfkCcm8EsaxiaUp0e5aNStKbK/APkmm3HNc4F
        cNaFVXGUNLyC7xuQpfXR16OCcX31ho54u9NjsmI=
X-Google-Smtp-Source: ABdhPJx0/ZBoqTZ16P1NCgBjhJ5sM97H+2+sMYY/Bmi6e64DqaJ3YKAUv+s9X9y5cnjTuc1ZtwZ37k45c28Z0GIYUn0=
X-Received: by 2002:a05:622a:1010:b0:2f3:d8f4:6cb4 with SMTP id
 d16-20020a05622a101000b002f3d8f46cb4mr3573216qte.180.1652964108928; Thu, 19
 May 2022 05:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-2-worldhello.net@gmail.com> <220519.86tu9l6fw4.gmgdl@evledraar.gmail.com>
In-Reply-To: <220519.86tu9l6fw4.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 19 May 2022 20:41:37 +0800
Message-ID: <CANYiYbHBPVRto2ijF_f5VdSCem59=hjZj3kb=zF30hxrCPoT+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] Makefile: sort "po/git.pot" by file location
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 19, 2022 at 5:17 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, May 19 2022, Jiang Xin wrote:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > Before feeding xgettext with more C souce files which may be ignored
> > by various compiler conditions, add new option "--sort-by-file" to
> > xgettext program to create stable message template file "po/git.pot".
> >
> > With this update, the newly generated "po/git.pot" will has the same
> > entries while in a different order. We won't checkin the newly generate=
d
> > "po/git.pot", because we will remove it from tree in a later commit.
> >
> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Makefile b/Makefile
> > index f8bccfab5e..83e968e2a4 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2706,6 +2706,7 @@ XGETTEXT_FLAGS =3D \
> >       --force-po \
> >       --add-comments=3DTRANSLATORS: \
> >       --msgid-bugs-address=3D"Git Mailing List <git@vger.kernel.org>" \
> > +     --sort-by-file \
> >       --from-code=3DUTF-8
> >  XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --language=3DC \
> >       --keyword=3D_ --keyword=3DN_ --keyword=3D"Q_:1,2"
>
> I'm not opposed to this change, but between this and 2/9 I'm still
> unsure what the aim is exactly, and if the results are desired.

We will change the order of input files to feed xgettext to create
"po/git.pot" in patch 2/9, and we may change the order of input files
in future version. With the option "--sort-by-file" we can get a
stable "po/git.pot" and better compression ratios for future versions
of "po/*.po*".

> In 2/9 you correctly point out that we have messages we've missed due to
> LOCALIZED_C being platform-specific.
>
> That should never happen (although your implementation in 2/9 may have
> some small issues, I'll reply there separately), i.e. we should always
> have "make pot" generate the same po/git.pot from the same commit
> whether you're on linux, mac os x etc.

l10n translators may work on different platforms or have different
compiler conditions, and their contributions may have different base
templates (po/git.pot). It is hard for the l10n coordinator to choose
a base template to check contributions from different l10n
contributors.

> But AFAICT we have a "stable" sort order now, it's in whatever order we
> feed the files to xgettext, which ultimately comes down to e.g. the list
> of $(LIB_OBJS) in the Makefile.
>
> I've been looking over the libintl documentation to see what exactly
> these sort options do, and how they differ from the default, and it's
> not really described.
>
> AFAICT the xgettext behavior we have now is that we'll process the files
> we have in order, and for those files extract the messages we have as we
> see them.
>
> One fringe benefit of that is that e.g. "make pot
> XGETTEXT_INCLUDE_TESTS=3DY" (which I think I've only ever used, and
> probably only ~10 years ago) will get added at the end, but now it'll be
> added wherever t/t0200 sorts.
>
> Then because compose the builtin objs and lib objs by concatenation, but
> don't $(sort) them in the Makefile most of this change is due to us
> e.g. sorting builtin/* before parse-options.c or whatever.
>
> But oddly we also have cases like this:
>
>         strbuf_addf(&header, print_file_item_data.modified_fmt,
>                     _("staged"), _("unstaged"), _("path"));
>
> Before this we'd list those in that order in the git.pot, but now
> because of --sort-by-file we'll list any messages on the same line in
> sorted msgid order, not in the orderd they appear in. Another example is
> e.g. this in builtin/blame.c:
>
>     OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ign=
ore <rev> when blaming"))
>
> Where before we'd list them in that order, but now it's with "ignore.."
> before "rev".

These side effects of changing the order of entries in the same line
of the same source file have little effect on the l10n translation.

> I think this change would be easier to follow & explain if you first
> made this change:
>
>         diff --git a/Makefile b/Makefile
>         index 61aadf3ce88..3726fe8064a 100644
>         --- a/Makefile
>         +++ b/Makefile
>         @@ -2715,10 +2715,9 @@ XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --=
language=3DShell \
>                 --keyword=3Dgettextln --keyword=3Deval_gettextln
>          XGETTEXT_FLAGS_PERL =3D $(XGETTEXT_FLAGS) --language=3DPerl \
>                 --keyword=3D__ --keyword=3DN__ --keyword=3D"__n:1,2"
>         -LOCALIZED_C =3D $(C_OBJ:o=3Dc) $(LIB_H) $(GENERATED_H)
>         -LOCALIZED_SH =3D $(SCRIPT_SH)
>         -LOCALIZED_SH +=3D git-sh-setup.sh
>         -LOCALIZED_PERL =3D $(SCRIPT_PERL)
>         +LOCALIZED_C =3D $(sort $(C_OBJ:o=3Dc) $(LIB_H) $(GENERATED_H))
>         +LOCALIZED_SH =3D $(sort $(SCRIPT_SH) git-sh-setup.sh)
>         +LOCALIZED_PERL =3D $(sort $(SCRIPT_PERL))
>
>          ifdef XGETTEXT_INCLUDE_TESTS
>          LOCALIZED_C +=3D t/t0200/test.c

I do not need this intermediate commit and submit new generated
"po/git.pot" file to observe changes of the "po/git.pot" file, because
I have a diff driver install as described here:

    https://github.com/git-l10n/git-po-helper/tree/main/contrib/diff-dirver

So I can tell the newly generated "po/git.pot" will have the same
entries while in a different order. If I want to see changes on raw
files, I can use command:

    git diff --no-textconv

> Which would sort things within C, SH and Perl files (but not among
> them). Then this change would AFAICT only:
>
>  * Change that "within one line" sort order, as noted above
>  * Sort across C/SH/Perl.
>
> I'm mostly "meh" on the result, but it's also because I genuinely don't
> get what the goal was. Is it because in 2/9 you'll end up using
> $(FOUND_C_SOURCES), which we derive from either "git ls-files" or
> "find", the latter of which has an unstable sort order?

The goal is to have a constant order of entries in "po/git.pot" and
"po/*.po", so we can save the space of our repository by better
compression ratio on files inside "po/".

--
Jiang Xin
