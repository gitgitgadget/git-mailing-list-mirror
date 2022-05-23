Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A3BC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiEWNnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiEWNnE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:43:04 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD702C10B
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:43:02 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x7so9324730qta.6
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rMUSIOO4si7K5ywapz4oyym5D2dDV2yKdZFZy7//WZE=;
        b=ALTNv3sMpILAHg0LPlOnycsDzXquMTm+7ihd+NwMFTe10TnHrMu5aLiSWqJD5LsEvq
         CULw85qJSUMhyrGbQX3FbbQZgPpQKQifsS5NerF2zRhe0MEz2jLENxFnr7dH7h7d+Uzv
         Whtx9kkRYoE+mVlFa47g9e10veLZcGFtr7Qoc5fs3HsVJ5pKU/bktxY03Hl3OIUmYb+C
         yjuaVogoB8/Cpmj1LRs18kzoHJ9ctLOYxj4ULP1v4ECRpT8nPL7X5rPIj+eT9N3i+ZLU
         fGXPkfHKub3qpDuFcuRc8nm+baGSl+6yQWWwx3OhwSxDS/mLlOa38KoHES0slWt7jYYK
         3YFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rMUSIOO4si7K5ywapz4oyym5D2dDV2yKdZFZy7//WZE=;
        b=tLTcV/f9pJ+mDtnH9VjIe5woyK6PxOisxVn0Ed0f+EgJi5UFVUq1fCAQ8XiZE177qO
         +Mt71KlBq4K1+w36N4VrLIISV9BzbSBVHXz0miY8gxN4xpOFGPQCPe+Y5dYYc9mqyUw9
         i4Ae0BLVwjxpIpePQZvET+zsKJ+GaOOsXfeiM0geog8CK5vzd3I0IUK8P1h9qfxli/3h
         BntzjqFwLCfCRlZeGckFIhrvGnsPHQ7g+cbMsyvwkxq4TMHQrZEBqxTz3WK3tMKufDJ6
         nS4TV9tuvhh9LM8BhtcTs7PtxFrwBd1OSYP0VdFfEsLI8eqf6KS0Qq4wJ4FlwGaCCkrA
         QaGw==
X-Gm-Message-State: AOAM530ktSzIhMiXzdgRCTrYusUxH1Wy0qyDqNb8kSCA+QhkH0l0B3FO
        uZkcohtmVKAJQNuopbdBCqG9dQpTK2ZFGsSIBgs=
X-Google-Smtp-Source: ABdhPJwqYvNKDRVxBHewG1S2E4RrNlGuk8emKkpodM7kKDB88WCTVJCbl/+FEmexinY4anrLo4jzwKxODwsRgvtPi+Q=
X-Received: by 2002:ac8:5896:0:b0:2f3:d231:58a9 with SMTP id
 t22-20020ac85896000000b002f3d23158a9mr16418707qta.131.1653313381290; Mon, 23
 May 2022 06:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220519081548.3380-1-worldhello.net@gmail.com>
 <20220523012531.4505-1-worldhello.net@gmail.com> <220523.86v8twzp6a.gmgdl@evledraar.gmail.com>
 <220523.86ilpwzmne.gmgdl@evledraar.gmail.com>
In-Reply-To: <220523.86ilpwzmne.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 23 May 2022 21:42:49 +0800
Message-ID: <CANYiYbF8NDawCijZ1Hf=2zdi329=WSdYqL05Tz8+NOyJAFgpLA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Incremental po/git.pot update and new l10n workflow
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

On Mon, May 23, 2022 at 4:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, May 23 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > On Mon, May 23 2022, Jiang Xin wrote:
> >
> >> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >>
> >> A workflow change for translators are being proposed.
> >>
> >> Changes since v2:
> >>
> >>  1. Patch 1/9: reword.
> >>  2. Patch 2/9: reword.
> >>  3. Patch 3/9: reword, and add "FORCE" to prerequisites of "po/git.pot=
".
> >>  4. Patch 6/9: remove "FORCE" from prerequisites of "po/git.pot".
> >>  5. Patch 8/9: reword, and reuse "$(gen_pot_header)" to prepare pot
> >>                header for "po/git-core.pot".
> >>  6. Patch 9/9: various updates on po/README.md.
> >
> > From skimming this the *.c.po v.s. *.c extension is still left in
> > comments. I'm not saying you need to go for my suggestions, but it woul=
d
> > be very useful in CL's to note things that were suggested but not
> > changed, such as that.
> >
> > Right now I haven't paged that v2 discussion into my brain again, so I
> > don't know if that was the only thing, it's the only thing I remember
> > right now...
>
> This fix-up below implements what I suggested on v2, so now the comments
> in the generated file are correct, and don't refer to our intermediate
> files:
>
>         $ grep '#-#' po/git.pot
>         #. #-#-#-#-#  git-add--interactive.perl  #-#-#-#-#
>         #. #-#-#-#-#  add-patch.c  #-#-#-#-#
>         #. #-#-#-#-#  git-add--interactive.perl  #-#-#-#-#
>         #. #-#-#-#-#  branch.c  #-#-#-#-#
>         #. #-#-#-#-#  object-name.c  #-#-#-#-#
>         #. #-#-#-#-#  grep.c  #-#-#-#-#
>
> I gathered that the reason you preferred the whole "grep -q PRItime" was
> because you wanted to mitigate the effects of your IDE discovering these
> files.
>
> With the below you can define AGGRESSIVE_INTERMEDIATE and when you "make
> pot" the generated *.c files will only exist for as long as they're
> needed to generate the next step.
>
> But if you do a subsequent "make pot" will be slower, as we'll of course
> need to generate them again.
>
> I think it's better to go in this direction, and rename that
> AGGRESSIVE_INTERMEDIATE to something like
> MAKE_AVOID_REAL_EXTENSIONS_IN_GITIGNORED_FILES or whatever.
>
> I.e. our correctness shouldn't suffer because we're trying to work
> around some issue in a specific (and optional) developer tooling.
>
> There's also the fix there for the "header" dependency, but as noted in
> another reply it should probably be dropped altogether...
>
> diff --git a/Makefile b/Makefile
> index d3eae150de9..0b96b55b63f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2736,6 +2736,7 @@ endif
>  ## "po/git.pot" file.
>  LOCALIZED_ALL_GEN_PO =3D
>
> +LOCALIZED_C_GEN_C =3D $(LOCALIZED_C:%=3D.build/pot/po-munged/%)

Intermediate C source files copied from the original location, and
PRItime will be replaced by PRIuMAX, if any.

>  LOCALIZED_C_GEN_PO =3D $(LOCALIZED_C:%=3D.build/pot/po/%.po)
>  LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_C_GEN_PO)
>
> @@ -2745,26 +2746,19 @@ LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_SH_GEN_PO)
>  LOCALIZED_PERL_GEN_PO =3D $(LOCALIZED_PERL:%=3D.build/pot/po/%.po)
>  LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_PERL_GEN_PO)
>
> -## Gettext tools cannot work with our own custom PRItime type, so
> -## we replace PRItime with PRIuMAX.  We need to update this to
> -## PRIdMAX if we switch to a signed type later.
> -$(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %
> +ifdef AGGRESSIVE_INTERMEDIATE
> +.INTERMEDIATE: $(LOCALIZED_C_GEN_C)

Intermediate files "$(LOCALIZED_C_GEN_C)" will be removed automatically.

> +endif
> +$(LOCALIZED_C_GEN_C): .build/pot/po-munged/%: %
>         $(call mkdir_p_parent_template)
> -       $(QUIET_XGETTEXT) \
> -           if grep -q PRItime $<; then \
> -               (\
> -                       sed -e 's|PRItime|PRIuMAX|g' <$< \
> -                               >.build/pot/po/$< && \
> -                       cd .build/pot/po && \
> -                       $(XGETTEXT) --omit-header \
> -                               -o $(@:.build/pot/po/%=3D%) \
> -                               $(XGETTEXT_FLAGS_C) $< && \
> -                       rm $<; \
> -               ); \
> -           else \
> -               $(XGETTEXT) --omit-header \
> -                       -o $@ $(XGETTEXT_FLAGS_C) $<; \
> -           fi
> +       $(QUIET_GEN)sed -e 's|PRItime|PRIuMAX|g' <$< >$@

Copy each source files in $(LOCALIZED_C) to corresponding intermediate
file ($(LOCALIZED_C_GEN_C)) in ".build/pot/po-munged/", replacing
PRItime with PRIuMAX if any.

> +
> +$(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: .build/pot/po-munged/%
> +       $(call mkdir_p_parent_template)
> +       $(QUIET_XGETTEXT)( \
> +               cd $(<D) && \
> +               $(XGETTEXT) $(XGETTEXT_FLAGS_C) --omit-header -o - $(<F) =
\
> +       ) >$@

For each intermediate C source files in ".build/pot/po-munged/", call
xgettext to create corresponding po file in ".build/pot/po/"
directory.

>  $(LOCALIZED_SH_GEN_PO): .build/pot/po/%.po: %
>         $(call mkdir_p_parent_template)
> @@ -2786,11 +2780,24 @@ sed -e 's|charset=3DCHARSET|charset=3DUTF-8|' \
>  echo '"Plural-Forms: nplurals=3DINTEGER; plural=3DEXPRESSION;\\n"' >>$@
>  endef
>
> -.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
> +.build/pot/git.header:

No. We should rebuild the pot header if any po file need to be update,
because we want to refresh the timestamp in the "POT-Creation-Date:"
filed of the pot header.

>         $(call mkdir_p_parent_template)
>         $(QUIET_GEN)$(gen_pot_header)
>
> -po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
> +# We go through this dance of having a prepared
> +# e.g. .build/pot/po/grep.c.po and copying it to
> +# .build/pot/to-cat/grep.c only because some IDEs (e.g. VSCode) pick
> +# up on the "real" extension for the purposes of auto-completion, even
> +# if the .build directiory is in .gitignore.
> +LOCALIZED_ALL_GEN_TO_CAT =3D $(LOCALIZED_ALL_GEN_PO:.build/pot/po/%.po=
=3D.build/pot/to-cat/%)
> +ifdef AGGRESSIVE_INTERMEDIATE
> +.INTERMEDIATE: $(LOCALIZED_ALL_GEN_TO_CAT)
> +endif
> +$(LOCALIZED_ALL_GEN_TO_CAT): .build/pot/to-cat/%: .build/pot/po/%.po
> +       $(call mkdir_p_parent_template)
> +       $(QUIET_GEN)cat $< >$@

Copy each po file in ".build/pot/po/" to another location
".build/pot/to-cat/", but without the ".po" extension.

Let's take "date.c" as an example:

1. Copy "date.c" to an intermediate C source file
".build/pot/po-munged/date.c" and replace PRItime with PRIuMAX in it.

2. Call xgettext to create  ".build/pot/po/date.c.po" from the
intermediate C source file ".build/pot/po-munged/date.c".

3. Optionally remove intermediate C source files like
".build/pot/po-munged/date.c". To have two identical C source files in
the same worktree is not good, some software may break. So I choose to
remove them.

4. Copy the po file (".build/pot/po/date.c.po") created in step 2 to
an intermediate fake C source file ".build/pot/to-cat/date.c" which is
a file without the ".po" extension. Please note this intermediate fake
C source file ".build/pot/to-cat/date.c" is not a valid C file, but a
PO file.

5. Call msgcat to create "po/git.pot" from all the intermediate fake C
source files including  ".build/pot/to-cat/date.c".

6. Optionally remove all the intermediate fake C source files in
".build/pot/to-cat/". I choose to remove them, because leave lots of
invalid C source files in worktree is not good.

For example, ".build/pot/po/date.c.po" was created from
> +
> +po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_TO_CAT)
>         $(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@

7. "po/git.pot" depends on the intermediate fake C source files. If
any single C source file has been changed, will run step 6 to copy all
po files in ".build/pot/po" to corresponding fake C source files in
".build/pot/to-cat/", if we choose to remove these intermediate fake C
source files.

This implementation is too heavy to solve a trivial issue. I think we
can push forward this patch series and leave these comments in
"po/git.pot":

>         $ grep '#-#' po/git.pot
>         #. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#
>         #. #-#-#-#-#  add-patch.c.po  #-#-#-#-#
>         #. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#
>         #. #-#-#-#-#  branch.c.po  #-#-#-#-#
>         #. #-#-#-#-#  object-name.c.po  #-#-#-#-#
>         #. #-#-#-#-#  grep.c.po  #-#-#-#-#
