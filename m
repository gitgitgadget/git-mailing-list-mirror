Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89080C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 09:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiESJxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 05:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbiESJxI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 05:53:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A427CB25
        for <git@vger.kernel.org>; Thu, 19 May 2022 02:53:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y13so8136378eje.2
        for <git@vger.kernel.org>; Thu, 19 May 2022 02:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SSEPDp9l1DKYCTekhUZWX7P3AUjq+e2qV37OuZH8ZXk=;
        b=VtsK9r9/wZUBdOtCUeVN/DLU3WC40m/1Y5onMftN/vsAGyatGiyVVIz9/TdVvEKmUh
         H7u06cX4Jj3nKcuaCdT5sNeEeVxS+U/UMj8FQzr+ERvNPBlTsqW4c1CJExBRu3hitgK9
         YCpflN6rplAItAp/m0T9lzN4KWDGtOTDXKHVkdDbSKKg5BosFKcTuxNfus/xlnX2GVRR
         Ms5lB4mK8G1+h9ReIhbrEIrv7g88qbug+LDDijJoNSp3uNwrm+9uRNNv9f8s4innNzLe
         OPZceTUqDKl1iBDOc+8mtZioX/Ou0vbovFF6xAoN7GAImPz8AfmUNcvcvRK+jtpBBTMf
         QB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SSEPDp9l1DKYCTekhUZWX7P3AUjq+e2qV37OuZH8ZXk=;
        b=qM5ckh7O1Fwpgmn+nSdgC6fm0MOuAc9sxsP1aC+xiO4NGn9OtjGyGQuI5iS/a7dIB3
         qdUkvRG6I+JlQHWdWMWe394hRDDQ+iYl1iIa+xHF1qyUUVn/1E6HjavAcQmZMcgpVbbH
         b4dyBvBlMB5l1WZ+m0vc/gNIAvZOUn12Cz6fP/gs54MdC4AgJbWvz19A7MN4iC/f+aR4
         YIe5OVcYF/OCwTR/ofG2ha4uM2Z7DjW9COgyWYBsKbpiH3hHV8kkaOBr21UOsjdVrFaX
         raI1UDPitpH/NXlbmq568cSb72tF6ojbhPEqDgl+xr3kzSxtuLVOmk1baRW27OsS8y7c
         CVXg==
X-Gm-Message-State: AOAM533sfFPJ5AObBr6UgR/6tXJVT4UwctVmT05D0BQlTD3YfPlpxwmV
        U5izlMNxNv8xPCtixy69zlI=
X-Google-Smtp-Source: ABdhPJzuWHe2m9niUTh4gx4GZgPd7I64GEk5Gsqd/AHlLVnFJOqGlKikurP6Ey66f/17hWMvRCOYrg==
X-Received: by 2002:a17:906:16da:b0:6fe:988b:d242 with SMTP id t26-20020a17090616da00b006fe988bd242mr2165357ejd.606.1652953983975;
        Thu, 19 May 2022 02:53:03 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z22-20020a170906435600b006f4c4330c49sm1885211ejm.57.2022.05.19.02.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 02:53:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrcq5-0022Pp-As;
        Thu, 19 May 2022 11:53:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 3/9] Makefile: have "make pot" not "reset --hard"
Date:   Thu, 19 May 2022 11:43:54 +0200
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-4-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220519081548.3380-4-worldhello.net@gmail.com>
Message-ID: <220519.86leux6e82.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 19 2022, Jiang Xin wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Before commit fc0fd5b23b (Makefile: help gettext tools to cope with our
> custom PRItime format, 2017-07-20) we'd consider source files as-is
> with gettext, but because we need to understand PRItime in the same way
> that gettext itself understands PRIuMAX we'd first check if we had a
> clean checkout, then munge all of the processed files in-place with
> "sed", generate "po/git.pot", and then finally "reset --hard" to undo
> our changes.
>
> By generating "pot" snippets in ".build/pot/po" for each source file
> and rewriting certain source files with PRItime macros to temporary
> files in ".build/pot/po", we can avoid running "make pot" by altering
> files in place and doing a "reset --hard" afterwards.
>
> This speed of "make pot" is slower than before on an initial run,
> because we run "xgettext" many times (once per source file), but it
> can be boosted by parallelization. It is *much* faster for incremental
> runs, and will allow us to implement related targets in subsequent
> commits.
>
> When the "pot" target was originally added in cd5513a7168 (i18n:
> Makefile: "pot" target to extract messages marked for translation,
> 2011-02-22) it behaved like a "normal" target. I.e. we'd skip the
> re-generation of the po/git.pot if nothing had to be done.
>
> Then after po/git.pot was checked in in dce37b66fb0 (l10n: initial
> git.pot for 1.7.10 upcoming release, 2012-02-13) the target was broken
> until 1f31963e921 (i18n: treat "make pot" as an explicitly-invoked
> target, 2014-08-22) when it was made to depend on "FORCE". I.e. the
> Makefile's dependency resolution inherently can't handle incremental
> building when the target file may be updated by git (or something else
> external to "make"). But this case no longer applies, so FORCE is no
> longer needed.
>
> That out of the way, the main logic change here is getting rid of the
> "reset --hard":
>
> We'll generate intermediate .build/pot/po/%.po files from %, which is
> handy to see at a glance what strings (if any) in a given file are
> marked for translation:
>
> 	$ make .build/pot/po/pretty.c.po
> 	[...]
> 	$ cat .build/pot/po/pretty.c.po
> 	#: pretty.c:1051
> 	msgid "unable to parse --pretty format"
> 	msgstr ""
> 	$
>
> For these C source files which contain the PRItime macros, we will
> create temporary munged *.c files in a tree in ".build/pot/po"
> corresponding to our source tree, and have "xgettext" consider those.
> The rule needs to be careful to "(cd .build/pot/po && ...)", because
> otherwise the comments in the po/git.pot file wouldn't refer to the
> correct source locations (they'd be prefixed with ".build/pot/po").
>
> This changes the output of the generated po/git.pot file in one minor
> way: Because we're using msgcat(1) instead of xgettext(1) to
> concatenate the output we'll now disambiguate where "TRANSLATORS"
> comments come from, in cases where a message is the same in N files,
> and either only one has a "TRANSLATORS" comment, or they're
> different. E.g. for the "Your edited hunk[...]" message we'll now
> apply this change (comment content elided):
>
> 	+#. #-#-#-#-#  add-patch.c.po  #-#-#-#-#
> 	 #. TRANSLATORS: do not translate [y/n]
> 	[...]
> 	+#. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#
> 	 #. TRANSLATORS: do not translate [y/n]
> 	[...]
> 	 #: add-patch.c:1253 git-add--interactive.perl:1244
> 	 msgid ""
> 	 "Your edited hunk does not apply. Edit again (saying \"no\" discards!) =
[y/n]? "
> 	 msgstr ""
>
> There are six such changes, and they all make the context more
> understandable, as msgcat(1) is better at handling these edge cases
> than xgettext(1)'s previously used "--join-existing" flag.
>
> While we could rename the "pot" snippets without the ".po" extention
> to use more intuitive filenames in the comments, but that will
> confuse the IDE with lots of invalid C or perl source files in
> ".build/pot/po" directory.
>
> The addition of "--omit-header" option for xgettext makes the "pot"
> snippets in ".build/pot/po/*.po" smaller. For the pot header of
> "po/git.pot", we use xgettext to generate a "pot" header file
> ".build/pot/git.header" from an empty file at runtime, and use this
> header to assemble "po/git.pot".
>
> But as we'll see in a subsequent commit this header behavior has been
> hiding an encoding-related bug from us, so let's carry it forward
> instead of re-generating it with xgettext(1).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  .gitignore |  1 +
>  Makefile   | 73 ++++++++++++++++++++++++++++++++++++++----------------
>  2 files changed, 53 insertions(+), 21 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index e81de1063a..a452215764 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -200,6 +200,7 @@
>  *.[aos]
>  *.o.json
>  *.py[co]
> +.build/
>  .depend/
>  *.gcda
>  *.gcno
> diff --git a/Makefile b/Makefile
> index 60ca42c268..c32ac4ca30 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -569,6 +569,7 @@ INSTALL =3D install
>  TCL_PATH =3D tclsh
>  TCLTK_PATH =3D wish
>  XGETTEXT =3D xgettext
> +MSGCAT =3D msgcat
>  MSGFMT =3D msgfmt
>  CURL_CONFIG =3D curl-config
>  GCOV =3D gcov
> @@ -2706,6 +2707,7 @@ XGETTEXT_FLAGS =3D \
>  	--force-po \
>  	--add-comments=3DTRANSLATORS: \
>  	--msgid-bugs-address=3D"Git Mailing List <git@vger.kernel.org>" \
> +	--package-name=3DGit \
>  	--sort-by-file \
>  	--from-code=3DUTF-8
>  XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --language=3DC \
> @@ -2714,6 +2716,7 @@ XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --language=
=3DShell \
>  	--keyword=3Dgettextln --keyword=3Deval_gettextln
>  XGETTEXT_FLAGS_PERL =3D $(XGETTEXT_FLAGS) --language=3DPerl \
>  	--keyword=3D__ --keyword=3DN__ --keyword=3D"__n:1,2"
> +MSGCAT_FLAGS =3D --sort-by-file
>  LOCALIZED_C =3D $(FOUND_C_SOURCES) $(SCALAR_SOURCES) \
>  	      $(FOUND_H_SOURCES) $(GENERATED_H)
>  LOCALIZED_SH =3D $(SCRIPT_SH)
> @@ -2726,34 +2729,61 @@ LOCALIZED_SH +=3D t/t0200/test.sh
>  LOCALIZED_PERL +=3D t/t0200/test.perl
>  endif
>=20=20
> -## Note that this is meant to be run only by the localization coordinator
> -## under a very controlled condition, i.e. (1) it is to be run in a
> -## Git repository (not a tarball extract), (2) any local modifications
> -## will be lost.
> +## We generate intermediate .build/pot/po/%.po files containing a
> +## extract of the translations we find in each file in the source
> +## tree. We will assemble them using msgcat to create the final
> +## "po/git.pot" file.
> +LOCALIZED_ALL_GEN_PO =3D
> +
> +LOCALIZED_C_GEN_PO =3D $(LOCALIZED_C:%=3D.build/pot/po/%.po)
> +LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_C_GEN_PO)
> +
> +LOCALIZED_SH_GEN_PO =3D $(LOCALIZED_SH:%=3D.build/pot/po/%.po)
> +LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_SH_GEN_PO)
> +
> +LOCALIZED_PERL_GEN_PO =3D $(LOCALIZED_PERL:%=3D.build/pot/po/%.po)
> +LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_PERL_GEN_PO)
> +
>  ## Gettext tools cannot work with our own custom PRItime type, so
>  ## we replace PRItime with PRIuMAX.  We need to update this to
>  ## PRIdMAX if we switch to a signed type later.
> +$(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %
> +	$(call mkdir_p_parent_template)
> +	$(QUIET_XGETTEXT) \
> +	    if grep -q PRItime $<; then \
> +		(\
> +			sed -e 's|PRItime|PRIuMAX|g' <$< \
> +				>.build/pot/po/$< && \
> +			cd .build/pot/po && \
> +			$(XGETTEXT) --omit-header \
> +				-o $(@:.build/pot/po/%=3D%) \
> +				$(XGETTEXT_FLAGS_C) $< && \
> +			rm $<; \
> +		); \
> +	    else \
> +		$(XGETTEXT) --omit-header \
> +			-o $@ $(XGETTEXT_FLAGS_C) $<; \
> +	    fi
>=20=20
> -po/git.pot: $(GENERATED_H) FORCE
> -	# All modifications will be reverted at the end, so we do not
> -	# want to have any local change.
> -	git diff --quiet HEAD && git diff --quiet --cached
> +$(LOCALIZED_SH_GEN_PO): .build/pot/po/%.po: %
> +	$(call mkdir_p_parent_template)
> +	$(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
> +		-o$@ $(XGETTEXT_FLAGS_SH) $<
>=20=20
> -	@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
> -	do \
> -		sed -e 's|PRItime|PRIuMAX|g' <"$$s" >"$$s+" && \
> -		cat "$$s+" >"$$s" && rm "$$s+"; \
> -	done
> +$(LOCALIZED_PERL_GEN_PO): .build/pot/po/%.po: %
> +	$(call mkdir_p_parent_template)
> +	$(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
> +		-o$@ $(XGETTEXT_FLAGS_PERL) $<
>=20=20
> -	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
> -	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_SH)=
 \
> -		$(LOCALIZED_SH)
> -	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_PER=
L) \
> -		$(LOCALIZED_PERL)
> +.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
> +	$(call mkdir_p_parent_template)
> +	$(QUIET_XGETTEXT)$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
> +		-o - /dev/null | \
> +	sed -e 's|charset=3DCHARSET|charset=3DUTF-8|g' >$@ && \
> +	echo '"Plural-Forms: nplurals=3DINTEGER; plural=3DEXPRESSION;\\n"' >>$@
>=20=20
> -	# Reverting the munged source, leaving only the updated $@
> -	git reset --hard
> -	mv $@+ $@
> +po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
> +	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
>=20=20
>  .PHONY: pot
>  pot: po/git.pot
> @@ -3292,6 +3322,7 @@ cocciclean:
>  	$(RM) contrib/coccinelle/*.cocci.patch*
>=20=20
>  clean: profile-clean coverage-clean cocciclean
> +	$(RM) -r .build
>  	$(RM) *.res
>  	$(RM) $(OBJECTS)
>  	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)

In the previous discussion of kicking things around I lost track of what
version of mine this is picked up from, but I range-diff'd it to my
6cf9c1f7022 (Makefile: have "make pot" not "reset --hard", 2022-04-02),
which is the latest I had in avar/Makefile-incremental-po-git-pot-rule
on my branch.

A range-diff of the two follows below (yours being the RHS). Some
comments:

 * There's a bug here where you're creating .build/pot/po/pretty.c.po
   files, not .build/pot/po/pretty.c, i.e. you add a *.po extension.

   As the commit message diff shows that results in us adding comments
   to po/git.pot that reference the filename as e.g. add-patch.c.po
   instead of the correct add-patch.c.

   So while it sucks to have a pretty.c file in .build/ that's really
   just a partial *.po instead of one with a *.po extension the whole
   excercise of us sub-shelling into .build/pot/ etc. is to work around
   msgcat's and xgettext's lack specifying a custom "trust me, this is
   the filename", so we should make it *.c again.

   (We could also post-munge the file, but that would suck more)

 * We went a bit back & forth on the "if grep -q PRItime" part on the GH
   ticket. FWIW I still think just skipping that work is a better
   choice. Yes we'll have ~10MB of redundant files in .build, and it's
   marginally slower, but "make pot" isn't a hot target, better to
   optimize for simplicity.

   But if you're really set on having it I don't mind...

 * You add a "MSGCAT_FLAGS =3D --sort-by-file" here, maybe worth having
   some "common" flags variable in the earlier commit we can use here?
   I.e. share --sort-by-file with xgettext.

 * Your version is missing FORCE on po/git.pot, which is a bug. We can't
   omit it on any file that's checked in. We're about to "git rm" it
   anyway, so maybe we shouldn't worry about it though...

 * This commit breaks the non-ASCII msgid, but 4/9 is about to fix it,
   so likewise maybe not worth worrying about re-arranging them...

1:  6cf9c1f7022 ! 1:  c569d1cd688 Makefile: have "make pot" not "reset --ha=
rd"
    @@ Metadata
      ## Commit message ##
         Makefile: have "make pot" not "reset --hard"
=20=20=20=20=20
    -    Change "make pot" to work on copies of the working tree files in a=
 new
    -    ".build/pot/" directory, instead of altering them in place and doi=
ng a
    -    "reset --hard" afterwards.
    -
    -    This both speeds up the "make pot" target on an initial run, and m=
akes
    -    it *much* faster for incremental runs, and will allow us to implem=
ent
    -    related targets in subsequent commits.
    +    Before commit fc0fd5b23b (Makefile: help gettext tools to cope wit=
h our
    +    custom PRItime format, 2017-07-20) we'd consider source files as-is
    +    with gettext, but because we need to understand PRItime in the sam=
e way
    +    that gettext itself understands PRIuMAX we'd first check if we had=
 a
    +    clean checkout, then munge all of the processed files in-place with
    +    "sed", generate "po/git.pot", and then finally "reset --hard" to u=
ndo
    +    our changes.
    +
    +    By generating "pot" snippets in ".build/pot/po" for each source fi=
le
    +    and rewriting certain source files with PRItime macros to temporary
    +    files in ".build/pot/po", we can avoid running "make pot" by alter=
ing
    +    files in place and doing a "reset --hard" afterwards.
    +
    +    This speed of "make pot" is slower than before on an initial run,
    +    because we run "xgettext" many times (once per source file), but it
    +    can be boosted by parallelization. It is *much* faster for increme=
ntal
    +    runs, and will allow us to implement related targets in subsequent
    +    commits.
=20=20=20=20=20
         When the "pot" target was originally added in cd5513a7168 (i18n:
         Makefile: "pot" target to extract messages marked for translation,
    @@ Commit message
         target, 2014-08-22) when it was made to depend on "FORCE". I.e. the
         Makefile's dependency resolution inherently can't handle increment=
al
         building when the target file may be updated by git (or something =
else
    -    external to "make").
    -
    -    So we still need a FORCE on po/git.pot, but now we'll have that ta=
rget
    -    copy ".build/pot/git.pot" to "po/git.pot", and the former doesn't =
need
    -    FORCE.
    -
    -    I think 1f31963e921 was confused in the rationale for adding "FORC=
E"
    -    though, it's needed for the reasons noted above, but it's got noth=
ing
    -    to do with how we do C compilation or find headers, which it sugge=
st
    -    is the case. It was also made as a preparatory change for
    -    d85b0dff729 (Makefile: use `find` to determine static header
    -    dependencies, 2014-08-25).
    -
    -    Unlike the compiler, when we generate the "pot "file we won't recu=
rse
    -    from one header file to another, we only consider the specific tar=
gets
    -    we're given, so if we miss a bar.h included via foo.h $(LOCALIZED_=
C)
    -    the FORCE won't help us.
    +    external to "make"). But this case no longer applies, so FORCE is =
no
    +    longer needed.
=20=20=20=20=20
         That out of the way, the main logic change here is getting rid of =
the
         "reset --hard":
=20=20=20=20=20
    -    Before fc0fd5b23bc we'd consider source files as-is with gettext, =
but
    -    because we need to understand PRItime in the same way that gettext
    -    itself understands PRIuMAX we'd first check if we had a clean
    -    checkout, then munge all of the processed files in-place with "sed=
",
    -    generate "po/git.pot, and then finally "reset --hard" to undo our
    -    changes.
    -
    -    We didn't need to do this for the *.perl and *.sh files, so let's
    -    skip that and only do it for the *.[ch] files.
    -
    -    Let's then create these munged *.[ch] files in a tree in .build/po=
t/"
    -    corresponding to our source tree, and have "xgettext" consider
    -    those. The rule needs to be careful to "(cd .build/pot && ...)",
    -    because otherwise the comments in the po/git.pot file wouldn't ref=
er
    -    to the correct source locations (they'd be prefixed with
    -    ".build/git/").
    -
    -    We'll then generate intermediate .build/pot/po/% files from %, whi=
ch
    -    is handy to see at a glance what strings (if any) in a given file =
are
    +    We'll generate intermediate .build/pot/po/%.po files from %, which=
 is
    +    handy to see at a glance what strings (if any) in a given file are
         marked for translation:
=20=20=20=20=20
    -            $ make .build/pot/po/pretty.c
    +            $ make .build/pot/po/pretty.c.po
                 [...]
    -            $ cat .build/pot/po/pretty.c
    +            $ cat .build/pot/po/pretty.c.po
                 #: pretty.c:1051
                 msgid "unable to parse --pretty format"
                 msgstr ""
                 $
=20=20=20=20=20
    +    For these C source files which contain the PRItime macros, we will
    +    create temporary munged *.c files in a tree in ".build/pot/po"
    +    corresponding to our source tree, and have "xgettext" consider tho=
se.
    +    The rule needs to be careful to "(cd .build/pot/po && ...)", becau=
se
    +    otherwise the comments in the po/git.pot file wouldn't refer to the
    +    correct source locations (they'd be prefixed with ".build/pot/po").
    +
         This changes the output of the generated po/git.pot file in one mi=
nor
         way: Because we're using msgcat(1) instead of xgettext(1) to
         concatenate the output we'll now disambiguate where "TRANSLATORS"
    @@ Commit message
         different. E.g. for the "Your edited hunk[...]" message we'll now
         apply this change (comment content elided):
=20=20=20=20=20
    -            +#. #-#-#-#-#  add-patch.c  #-#-#-#-#
    +            +#. #-#-#-#-#  add-patch.c.po  #-#-#-#-#
                  #. TRANSLATORS: do not translate [y/n]
                 [...]
    -            +#. #-#-#-#-#  git-add--interactive.perl  #-#-#-#-#
    +            +#. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#
                  #. TRANSLATORS: do not translate [y/n]
                 [...]
                  #: add-patch.c:1253 git-add--interactive.perl:1244
    @@ Commit message
                  "Your edited hunk does not apply. Edit again (saying \"no=
\" discards!) [y/n]? "
                  msgstr ""
=20=20=20=20=20
    -    There are three such changes, and they all make the context more
    +    There are six such changes, and they all make the context more
         understandable, as msgcat(1) is better at handling these edge cases
         than xgettext(1)'s previously used "--join-existing" flag.
=20=20=20=20=20
    -    The removal of the "--msgid-bugs-address" here and the addition of
    -    "--omit-header" and ".build/pot/pot.header" is because we'll now
    -    always carry forward the existing po/git.pot header.
    +    While we could rename the "pot" snippets without the ".po" extenti=
on
    +    to use more intuitive filenames in the comments, but that will
    +    confuse the IDE with lots of invalid C or perl source files in
    +    ".build/pot/po" directory.
=20=20=20=20=20
    -    We'd previously generate the header with xgettext(1), but now we'l=
l be
    -    carrying forward whatever header we find in po/git.pot. Right now =
this
    -    doesn't matter, we'll even update the timestamp in the header as
    -    before when running "make pot".
    +    The addition of "--omit-header" option for xgettext makes the "pot"
    +    snippets in ".build/pot/po/*.po" smaller. For the pot header of
    +    "po/git.pot", we use xgettext to generate a "pot" header file
    +    ".build/pot/git.header" from an empty file at runtime, and use this
    +    header to assemble "po/git.pot".
=20=20=20=20=20
    -    But as we'll see in a subsequent commit our previous header behavi=
or
    -    has been hiding an encoding-related bug from us, so let's carry it
    -    forward instead of re-generating it with xgettext(1).
    +    But as we'll see in a subsequent commit this header behavior has b=
een
    +    hiding an encoding-related bug from us, so let's carry it forward
    +    instead of re-generating it with xgettext(1).
=20=20=20=20=20
         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
    +    Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
=20=20=20=20=20
      ## .gitignore ##
     @@
    @@ .gitignore
      *.gcno
=20=20=20=20=20
      ## Makefile ##
    -@@ Makefile: pdf:
    - XGETTEXT_FLAGS =3D \
    +@@ Makefile: INSTALL =3D install
    + TCL_PATH =3D tclsh
    + TCLTK_PATH =3D wish
    + XGETTEXT =3D xgettext
    ++MSGCAT =3D msgcat
    + MSGFMT =3D msgfmt
    + CURL_CONFIG =3D curl-config
    + GCOV =3D gcov
    +@@ Makefile: XGETTEXT_FLAGS =3D \
      	--force-po \
      	--add-comments=3DTRANSLATORS: \
    --	--msgid-bugs-address=3D"Git Mailing List <git@vger.kernel.org>" \
    --	--from-code=3DUTF-8
    -+	--from-code=3DUTF-8 \
    -+	--omit-header
    -+
    + 	--msgid-bugs-address=3D"Git Mailing List <git@vger.kernel.org>" \
    ++	--package-name=3DGit \
    + 	--sort-by-file \
    + 	--from-code=3DUTF-8
      XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --language=3DC \
    - 	--keyword=3D_ --keyword=3DN_ --keyword=3D"Q_:1,2"
    - XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --language=3DShell \
    +@@ Makefile: XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --language=3DShel=
l \
    + 	--keyword=3Dgettextln --keyword=3Deval_gettextln
    + XGETTEXT_FLAGS_PERL =3D $(XGETTEXT_FLAGS) --language=3DPerl \
    + 	--keyword=3D__ --keyword=3DN__ --keyword=3D"__n:1,2"
    ++MSGCAT_FLAGS =3D --sort-by-file
    + LOCALIZED_C =3D $(FOUND_C_SOURCES) $(SCALAR_SOURCES) \
    + 	      $(FOUND_H_SOURCES) $(GENERATED_H)
    + LOCALIZED_SH =3D $(SCRIPT_SH)
     @@ Makefile: LOCALIZED_SH +=3D t/t0200/test.sh
      LOCALIZED_PERL +=3D t/t0200/test.perl
      endif
    @@ Makefile: LOCALIZED_SH +=3D t/t0200/test.sh
     -## under a very controlled condition, i.e. (1) it is to be run in a
     -## Git repository (not a tarball extract), (2) any local modifications
     -## will be lost.
    -+## We generate intermediate .build/pot/po/% files containing a extract
    -+## of the translations we find in each file in the source tree. The
    -+## files have the same basename as the source due xgettext(1) not
    -+## having a way to override the basename inserted into comments.
    ++## We generate intermediate .build/pot/po/%.po files containing a
    ++## extract of the translations we find in each file in the source
    ++## tree. We will assemble them using msgcat to create the final
    ++## "po/git.pot" file.
     +LOCALIZED_ALL_GEN_PO =3D
     +
    -+LOCALIZED_C_GEN_PO =3D $(LOCALIZED_C:%=3D.build/pot/po/%)
    ++LOCALIZED_C_GEN_PO =3D $(LOCALIZED_C:%=3D.build/pot/po/%.po)
     +LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_C_GEN_PO)
     +
    -+LOCALIZED_SH_GEN_PO =3D $(LOCALIZED_SH:%=3D.build/pot/po/%)
    ++LOCALIZED_SH_GEN_PO =3D $(LOCALIZED_SH:%=3D.build/pot/po/%.po)
     +LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_SH_GEN_PO)
     +
    -+LOCALIZED_PERL_GEN_PO =3D $(LOCALIZED_PERL:%=3D.build/pot/po/%)
    ++LOCALIZED_PERL_GEN_PO =3D $(LOCALIZED_PERL:%=3D.build/pot/po/%.po)
     +LOCALIZED_ALL_GEN_PO +=3D $(LOCALIZED_PERL_GEN_PO)
     +
      ## Gettext tools cannot work with our own custom PRItime type, so
      ## we replace PRItime with PRIuMAX.  We need to update this to
      ## PRIdMAX if we switch to a signed type later.
    -+LOCALIZED_C_GEN	=3D $(LOCALIZED_C:%=3D.build/pot/in/%)
    -+$(LOCALIZED_C_GEN): .build/pot/in/%: %
    ++$(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %
     +	$(call mkdir_p_parent_template)
    -+	$(QUIET_GEN)sed -e 's|PRItime|PRIuMAX|g' <$< >$@
    -+
    -+$(LOCALIZED_C_GEN_PO): .build/pot/po/%: .build/pot/in/%
    -+	$(call mkdir_p_parent_template)
    -+	$(QUIET_XGETTEXT)(\
    -+		cd .build/pot/in && \
    -+		$(XGETTEXT) -o $(@:.build/pot/po/%=3D../po/%) \
    -+			$(XGETTEXT_FLAGS_C) \
    -+			$(<:.build/pot/in/%=3D%) \
    -+	)
    ++	$(QUIET_XGETTEXT) \
    ++	    if grep -q PRItime $<; then \
    ++		(\
    ++			sed -e 's|PRItime|PRIuMAX|g' <$< \
    ++				>.build/pot/po/$< && \
    ++			cd .build/pot/po && \
    ++			$(XGETTEXT) --omit-header \
    ++				-o $(@:.build/pot/po/%=3D%) \
    ++				$(XGETTEXT_FLAGS_C) $< && \
    ++			rm $<; \
    ++		); \
    ++	    else \
    ++		$(XGETTEXT) --omit-header \
    ++			-o $@ $(XGETTEXT_FLAGS_C) $<; \
    ++	    fi
=20=20=20=20=20=20
     -po/git.pot: $(GENERATED_H) FORCE
     -	# All modifications will be reverted at the end, so we do not
     -	# want to have any local change.
     -	git diff --quiet HEAD && git diff --quiet --cached
    -+$(LOCALIZED_SH_GEN_PO): .build/pot/po/%: %
    ++$(LOCALIZED_SH_GEN_PO): .build/pot/po/%.po: %
     +	$(call mkdir_p_parent_template)
    -+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@ $(XGETTEXT_FLAGS_SH) $<
    ++	$(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
    ++		-o$@ $(XGETTEXT_FLAGS_SH) $<
=20=20=20=20=20=20
     -	@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
     -	do \
     -		sed -e 's|PRItime|PRIuMAX|g' <"$$s" >"$$s+" && \
     -		cat "$$s+" >"$$s" && rm "$$s+"; \
     -	done
    -+$(LOCALIZED_PERL_GEN_PO): .build/pot/po/%: %
    -+	$(call mkdir_p_parent_template)
    -+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@ $(XGETTEXT_FLAGS_PERL) $<
    -+
    -+.build/pot/pot.header:
    ++$(LOCALIZED_PERL_GEN_PO): .build/pot/po/%.po: %
     +	$(call mkdir_p_parent_template)
    -+	$(QUIET_GEN)sed -n -e '/^$$/q' -e 'p' <po/git.pot >$@
    ++	$(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
    ++		-o$@ $(XGETTEXT_FLAGS_PERL) $<
=20=20=20=20=20=20
     -	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
     -	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_=
SH) \
     -		$(LOCALIZED_SH)
     -	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_=
PERL) \
     -		$(LOCALIZED_PERL)
    -+.build/pot/git.pot: .build/pot/pot.header $(LOCALIZED_ALL_GEN_PO)
    -+	$(QUIET_GEN)msgcat $^ >$@
    ++.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
    ++	$(call mkdir_p_parent_template)
    ++	$(QUIET_XGETTEXT)$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
    ++		-o - /dev/null | \
    ++	sed -e 's|charset=3DCHARSET|charset=3DUTF-8|g' >$@ && \
    ++	echo '"Plural-Forms: nplurals=3DINTEGER; plural=3DEXPRESSION;\\n"' >=
>$@
=20=20=20=20=20=20
     -	# Reverting the munged source, leaving only the updated $@
     -	git reset --hard
     -	mv $@+ $@
    -+po/git.pot: .build/pot/git.pot FORCE
    -+	$(QUIET_CP)cp $< $@
    ++po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
    ++	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
=20=20=20=20=20=20
      .PHONY: pot
      pot: po/git.pot
    @@ Makefile: cocciclean:
      	$(RM) *.res
      	$(RM) $(OBJECTS)
      	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
    -
    - ## shared.mak ##
    -@@ shared.mak: ifndef V
    - 	QUIET_AR       =3D @echo '   ' AR $@;
    - 	QUIET_LINK     =3D @echo '   ' LINK $@;
    - 	QUIET_BUILT_IN =3D @echo '   ' BUILTIN $@;
    -+	QUIET_CP       =3D @echo '   ' CP $@;
    - 	QUIET_LNCP     =3D @echo '   ' LN/CP $@;
    - 	QUIET_XGETTEXT =3D @echo '   ' XGETTEXT $@;
    - 	QUIET_MSGFMT   =3D @echo '   ' MSGFMT $@;
