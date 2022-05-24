Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166E3C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 00:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiEXA4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 20:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiEXA4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 20:56:46 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7EE55211
        for <git@vger.kernel.org>; Mon, 23 May 2022 17:56:44 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c1so14057442qkf.13
        for <git@vger.kernel.org>; Mon, 23 May 2022 17:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AJOqsJGWH4xTaANn/XF+VXflQO4itn3iyySTFe0Urp8=;
        b=fp9tgHbtRKZWpvfSszFHJ+e5DXyXT2Jw7KpK9TDAhiLO9hsCE+D/a7z231/0/wzytv
         tQ3wm6MgcRR8zoeQxyp26tChWv9Q02l5wHYpCi0OBZf6hBGXxMOdOBq6OqY6d+75/TMi
         XrEXu6SUGTiXgfP0TTrg3mrvuT8X0Bdis5P2uGbudmmGaJfXdFxsL0drOJ2m7Dkt56pa
         Wt2MleGbsnq4xRUgfcC4aW/nuFNMJdgc3d0uEMKI0l16Gbn0eDAjzK2wDstZ7blOTP5K
         wrb2n40rTQOgL1V3Lhwpg+RKQlErv7C/ZjVxx9VdL4HaenIqYAwRHJrvDG3QzaiQCrYl
         i1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AJOqsJGWH4xTaANn/XF+VXflQO4itn3iyySTFe0Urp8=;
        b=C6cyhuHzWzQgTBX44QIR6Ly1UbQi3EFklEOerhXL+Vqnl9OYFHUYkJISptsJOf735S
         Jls6JHbMouOPgHXrbhfK+H01rrYzCrRjgfGrXXR2UbfF9zogsRk6DYlWhgY1rghtRxxM
         j2nKcLfTjRLDxJ/Ppil2betZn2Oa2ArJ84BZ0lQjOKhD+8oQkNB+zD+Scxmmbw8YeYmm
         DAjxooWCMBIJb5CyN29aDNCXw322nUEd/LzmJgPZAlTDfr66q0ldfeniNprS+H0SW+Jx
         VtZIBiEAdouiO23mq5S652JNkaSOPwIaezCxeM251ioamiU9y8Mvdv2UtCBpxWDjQ5kM
         VR7w==
X-Gm-Message-State: AOAM531i6xlDFp5k2uQI+UlKUy9ajTm0Fdbws0VoHoqjXIWAtSWuEODP
        b+qQjjM+8PNvoabtuyzBHPw+0cFQnOE2JpD3J0w=
X-Google-Smtp-Source: ABdhPJzbYKaYyGaqE536gaNlD793lWmWi5U+xq/YYrBbydcGg5wCcgMKw/UJWGcfN7di8C9JpfmBWt4+WAs0e2lDoXc=
X-Received: by 2002:ae9:e406:0:b0:6a3:86e7:88fa with SMTP id
 q6-20020ae9e406000000b006a386e788famr5013441qkc.71.1653353803781; Mon, 23 May
 2022 17:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220519081548.3380-1-worldhello.net@gmail.com>
 <20220523012531.4505-4-worldhello.net@gmail.com> <220523.86mtf8zn7t.gmgdl@evledraar.gmail.com>
In-Reply-To: <220523.86mtf8zn7t.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 24 May 2022 08:56:32 +0800
Message-ID: <CANYiYbGeztgwRmu7FyKid3B+iC2JmnPJOZ3epDoeJOXNHr19Vw@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] Makefile: have "make pot" not "reset --hard"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
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
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 23, 2022 at 4:07 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, May 23 2022, Jiang Xin wrote:
>
> > From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> >
> > Before commit fc0fd5b23b (Makefile: help gettext tools to cope with our
> > custom PRItime format, 2017-07-20) we'd consider source files as-is
> > with gettext, but because we need to understand PRItime in the same way
> > that gettext itself understands PRIuMAX we'd first check if we had a
> > clean checkout, then munge all of the processed files in-place with
> > "sed", generate "po/git.pot", and then finally "reset --hard" to undo
> > our changes.
> >
> > By generating "pot" snippets in ".build/pot/po" for each source file
> > and rewriting certain source files with PRItime macros to temporary
> > files in ".build/pot/po", we can avoid running "make pot" by altering
> > files in place and doing a "reset --hard" afterwards.
> >
> > This speed of "make pot" is slower than before on an initial run,
> > because we run "xgettext" many times (once per source file), but it
> > can be boosted by parallelization. It is *much* faster for incremental
> > runs, and will allow us to implement related targets in subsequent
> > commits.
> >
> > When the "pot" target was originally added in cd5513a7168 (i18n:
> > Makefile: "pot" target to extract messages marked for translation,
> > 2011-02-22) it behaved like a "normal" target. I.e. we'd skip the
> > re-generation of the po/git.pot if nothing had to be done.
> >
> > Then after po/git.pot was checked in in dce37b66fb0 (l10n: initial
> > git.pot for 1.7.10 upcoming release, 2012-02-13) the target was broken
> > until 1f31963e921 (i18n: treat "make pot" as an explicitly-invoked
> > target, 2014-08-22) when it was made to depend on "FORCE". I.e. the
> > Makefile's dependency resolution inherently can't handle incremental
> > building when the target file may be updated by git (or something else
> > external to "make"). But this case no longer applies, so FORCE is no
> > longer needed.
> >
> > That out of the way, the main logic change here is getting rid of the
> > "reset --hard":
> >
> > We'll generate intermediate ".build/pot/po/%.po" files from "%", which
> > is handy to see at a glance what strings (if any) in a given file are
> > marked for translation:
> >
> >       $ make .build/pot/po/pretty.c.po
> >       [...]
> >       $ cat .build/pot/po/pretty.c.po
> >       #: pretty.c:1051
> >       msgid "unable to parse --pretty format"
> >       msgstr ""
> >       $
> >
> > For these C source files which contain the PRItime macros, we will
> > create temporary munged "*.c" files in a tree in ".build/pot/po"
> > corresponding to our source tree, and have "xgettext" consider those.
> > The rule needs to be careful to "(cd .build/pot/po && ...)", because
> > otherwise the comments in the po/git.pot file wouldn't refer to the
> > correct source locations (they'd be prefixed with ".build/pot/po").
> > These temporary munged "*.c=E2=80=9D files will be removed immediately =
after
> > the corresponding po files are generated, because some development tool=
s
> > cannot ignore the duplicate source files in the ".build" directory
> > according to the ".gitignore" file, and that may cause trouble.
> >
> > The output of the generated po/git.pot file is changed in one minor
> > way: Because we're using msgcat(1) instead of xgettext(1) to
> > concatenate the output we'll now disambiguate where "TRANSLATORS"
> > comments come from, in cases where a message is the same in N files,
> > and either only one has a "TRANSLATORS" comment, or they're
> > different. E.g. for the "Your edited hunk[...]" message we'll now
> > apply this change (comment content elided):
> >
> >       +#. #-#-#-#-#  add-patch.c.po  #-#-#-#-#
> >        #. TRANSLATORS: do not translate [y/n]
> >       [...]
> >       +#. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#
> >        #. TRANSLATORS: do not translate [y/n]
> >       [...]
> >        #: add-patch.c:1253 git-add--interactive.perl:1244
> >        msgid ""
> >        "Your edited hunk does not apply. Edit again (saying \"no\" disc=
ards!) [y/n]? "
> >        msgstr ""
> >
> > There are six such changes, and they all make the context more
> > understandable, as msgcat(1) is better at handling these edge cases
> > than xgettext(1)'s previously used "--join-existing" flag.
> >
> > But filenames in the above disambiguation lines of extracted-comments
> > have an extra ".po" extension compared to the filenames at the file
> > locations. While we could rename the intermediate ".build/pot/po/%.po"
> > files without the ".po" extension to use more intuitive filenames in
> > the disambiguation lines of extracted-comments, but that will confuse
> > developer tools with lots of invalid C or other source files in
> > ".build/pot/po" directory.
> >
> > The addition of "--omit-header" option for xgettext makes the "pot"
> > snippets in ".build/pot/po/*.po" smaller. But as we'll see in a
> > subsequent commit this header behavior has been hiding an
> > encoding-related bug from us, so let's carry it forward instead of
> > re-generating it with xgettext(1).
> >
> > The "po/git.pot" file should have a header entry, because a proper
> > header entry will increase the speed of creating a new po file using
> > msginit and set a proper "POT-Creation-Date:" field in the header
> > entry of a "po/XX.po" file. We use xgettext to generate a separate
> > header file at ".build/pot/git.header" from "/dev/null", and use this
> > header to assemble "po/git.pot".
> >
> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  .gitignore |  1 +
> >  Makefile   | 80 ++++++++++++++++++++++++++++++++++++++++--------------
> >  2 files changed, 60 insertions(+), 21 deletions(-)
> >
> > diff --git a/.gitignore b/.gitignore
> > index e81de1063a..a452215764 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -200,6 +200,7 @@
> >  *.[aos]
> >  *.o.json
> >  *.py[co]
> > +.build/
> >  .depend/
> >  *.gcda
> >  *.gcno
> > diff --git a/Makefile b/Makefile
> > index 46914dcd80..1962999c18 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -569,6 +569,7 @@ INSTALL =3D install
> >  TCL_PATH =3D tclsh
> >  TCLTK_PATH =3D wish
> >  XGETTEXT =3D xgettext
> > +MSGCAT =3D msgcat
> >  MSGFMT =3D msgfmt
> >  CURL_CONFIG =3D curl-config
> >  GCOV =3D gcov
> > @@ -2706,6 +2707,7 @@ XGETTEXT_FLAGS =3D \
> >       --force-po \
> >       --add-comments=3DTRANSLATORS: \
> >       --msgid-bugs-address=3D"Git Mailing List <git@vger.kernel.org>" \
> > +     --package-name=3DGit \
> >       --sort-by-file \
> >       --from-code=3DUTF-8
> >  XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --language=3DC \
> > @@ -2714,6 +2716,7 @@ XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --languag=
e=3DShell \
> >       --keyword=3Dgettextln --keyword=3Deval_gettextln
> >  XGETTEXT_FLAGS_PERL =3D $(XGETTEXT_FLAGS) --language=3DPerl \
> >       --keyword=3D__ --keyword=3DN__ --keyword=3D"__n:1,2"
> > +MSGCAT_FLAGS =3D --sort-by-file
> >  LOCALIZED_C =3D $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES=
) \
> >             $(GENERATED_H)
> >  LOCALIZED_SH =3D $(SCRIPT_SH)
> > @@ -2726,34 +2729,68 @@ LOCALIZED_SH +=3D t/t0200/test.sh
> >  LOCALIZED_PERL +=3D t/t0200/test.perl
> >  endif
> >
> > -## Note that this is meant to be run only by the localization coordina=
tor
> > -## under a very controlled condition, i.e. (1) it is to be run in a
> > -## Git repository (not a tarball extract), (2) any local modifications
> > -## will be lost.
> > +## We generate intermediate .build/pot/po/%.po files containing a
> > +## extract of the translations we find in each file in the source
> > +## tree. We will assemble them using msgcat to create the final
> > +## "po/git.pot" file.
> > +LOCALIZED_ALL_GEN_PO =3D
> > +
> > +LOCALIZED_C_GEN_PO =3D $(LOCALIZED_C:%=3D.build/pot/po/%.po)
> > +LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_C_GEN_PO)
> > +
> > +LOCALIZED_SH_GEN_PO =3D $(LOCALIZED_SH:%=3D.build/pot/po/%.po)
> > +LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_SH_GEN_PO)
> > +
> > +LOCALIZED_PERL_GEN_PO =3D $(LOCALIZED_PERL:%=3D.build/pot/po/%.po)
> > +LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_PERL_GEN_PO)
> > +
> >  ## Gettext tools cannot work with our own custom PRItime type, so
> >  ## we replace PRItime with PRIuMAX.  We need to update this to
> >  ## PRIdMAX if we switch to a signed type later.
> > +$(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %
> > +     $(call mkdir_p_parent_template)
> > +     $(QUIET_XGETTEXT) \
> > +         if grep -q PRItime $<; then \
> > +             (\
> > +                     sed -e 's|PRItime|PRIuMAX|g' <$< \
> > +                             >.build/pot/po/$< && \
> > +                     cd .build/pot/po && \
> > +                     $(XGETTEXT) --omit-header \
> > +                             -o $(@:.build/pot/po/%=3D%) \
> > +                             $(XGETTEXT_FLAGS_C) $< && \
> > +                     rm $<; \
> > +             ); \
> > +         else \
> > +             $(XGETTEXT) --omit-header \
> > +                     -o $@ $(XGETTEXT_FLAGS_C) $<; \
> > +         fi
> >
> > -po/git.pot: $(GENERATED_H) FORCE
> > -     # All modifications will be reverted at the end, so we do not
> > -     # want to have any local change.
> > -     git diff --quiet HEAD && git diff --quiet --cached
> > +$(LOCALIZED_SH_GEN_PO): .build/pot/po/%.po: %
> > +     $(call mkdir_p_parent_template)
> > +     $(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
> > +             -o$@ $(XGETTEXT_FLAGS_SH) $<
> >
> > -     @for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
> > -     do \
> > -             sed -e 's|PRItime|PRIuMAX|g' <"$$s" >"$$s+" && \
> > -             cat "$$s+" >"$$s" && rm "$$s+"; \
> > -     done
> > +$(LOCALIZED_PERL_GEN_PO): .build/pot/po/%.po: %
> > +     $(call mkdir_p_parent_template)
> > +     $(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
> > +             -o$@ $(XGETTEXT_FLAGS_PERL) $<
> > +q
> > +define gen_pot_header
> > +$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
> > +     -o - /dev/null | \
> > +sed -e 's|charset=3DCHARSET|charset=3DUTF-8|' \
> > +    -e 's|\(Last-Translator: \)FULL NAME <.*>|\1make by the Makefile|'=
 \
> > +    -e 's|\(Language-Team: \)LANGUAGE <.*>|\1Git Mailing List <git@vge=
r.kernel.org>|' \
> > +    >$@ && \
> > +echo '"Plural-Forms: nplurals=3DINTEGER; plural=3DEXPRESSION;\\n"' >>$=
@
> > +endef
> >
> > -     $(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZE=
D_C)
> > -     $(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLA=
GS_SH) \
> > -             $(LOCALIZED_SH)
> > -     $(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLA=
GS_PERL) \
> > -             $(LOCALIZED_PERL)
> > +.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
> > +     $(call mkdir_p_parent_template)
> > +     $(QUIET_GEN)$(gen_pot_header)
>
> So re a previous round I think the addition of a header to po/git.pot
> doesn't make sense, i.e. it's not needed, so we can just drop this
> entirely.
>
> But if you really want to include it anyway then this dependency is
> broken, the header just depends on this gen_pot_header you've defined,
> we don't need to re-generate it every time any single source file
> changes.
>
> Or is the intent to have its timestamp bumped if any of the source files
> change?
>
> If so I think that to the extent we need headers at all (for the *.po
> files) it might be worthwhile to just have the timestamp be the same
> epoch we use for the tests in t/, i.e. never update it and avoid the
> needless churn. If people need to check when things were last changed,
> or initially added, they can use this little thing called "git" :)

After rereading all the replies, I feel it's better to to leave a note
here to make my point clear. As we removed the "po/git.pot" file, it
is not easy to find the base version of a "po/XX.po" file, and we need
the "POT-Creation-Date:" field which comes from the header of the
generated POT file to tell us the version of the base.

    $ git -P grep POT-Creation-Date -- po/
    po/bg.po:"POT-Creation-Date: 2022-01-17 08:34+0800\n"
    po/ca.po:"POT-Creation-Date: 2022-04-06 14:40+0800\n"
    po/de.po:"POT-Creation-Date: 2022-04-13 14:52+0800\n"
    po/el.po:"POT-Creation-Date: 2019-02-15 10:09+0800\n"
    po/es.po:"POT-Creation-Date: 2021-11-04 08:34+0800\n"
    po/fr.po:"POT-Creation-Date: 2022-04-13 14:52+0800\n"
    po/id.po:"POT-Creation-Date: 2022-04-13 14:52+0800\n"
    po/is.po:"POT-Creation-Date: 2016-06-17 18:55+0000\n"
    po/it.po:"POT-Creation-Date: 2020-10-10 09:32+0800\n"
    po/ko.po:"POT-Creation-Date: 2018-06-16 22:06+0800\n"
    po/pl.po:"POT-Creation-Date: 2021-11-10 08:55+0800\n"
    po/pt_PT.po:"POT-Creation-Date: 2022-04-13 14:52+0800\n"
    po/ru.po:"POT-Creation-Date: 2020-12-21 07:10+0800\n"
    po/sv.po:"POT-Creation-Date: 2022-04-13 14:52+0800\n"
    po/tr.po:"POT-Creation-Date: 2022-04-13 14:52+0800\n"
    po/vi.po:"POT-Creation-Date: 2022-04-13 14:52+0800\n"
    po/zh_CN.po:"POT-Creation-Date: 2022-04-13 14:52+0800\n"
    po/zh_TW.po:"POT-Creation-Date: 2022-04-13 14:52+0800\n"
