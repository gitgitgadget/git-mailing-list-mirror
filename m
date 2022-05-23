Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD49FC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 16:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbiEWQNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 12:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbiEWQNT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 12:13:19 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB083151C
        for <git@vger.kernel.org>; Mon, 23 May 2022 09:13:17 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bs17so13182210qkb.0
        for <git@vger.kernel.org>; Mon, 23 May 2022 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4tpWmKzkKKmw7amytGGC7/Bhau2++E6B+vOswvwN3Pk=;
        b=cr1OZKGzdWWZdu+tz5kJwWvjPfLDElAFLhc8L5FpGZceRLM/JuQAjRb9f0rYLadwBV
         k352Eb+WRE4s9eqyUk8l7S2ZmnVOGxKVyqIT4ZyhbRNhcHKB8ThDtkVBnzwKN99M6m6U
         BkbUY4AL1yM7JT0mMs/Efn/JV0VmLD6mfCjy89b+U7eCkmwt20+OFbqCcM3rSpMvb83Q
         YEYA/M4xi05yuKIuMRTLp3ja92vtQ4Cbiz5FNN3O7zrZaaxeEUulILq9ZApnBf7UOR37
         TtF5ZRmE1DngjcNodHxr+XVcspMLKj/bKvlO0BfzphiPvsqYtBnpiq/+ffAu+94I1JS7
         dsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4tpWmKzkKKmw7amytGGC7/Bhau2++E6B+vOswvwN3Pk=;
        b=r1HlurJMq1CdeksNTZRttIDiqRGrUk/oOk/wJRE9jtBg1t97rQfVAPSZjDMB/XVywG
         5U2cpNR8JQ12bHGkkb13gGv+Bm7LmU2IvRR/UkhVi8uponk9mOFkKVFXOu0KsSCqIrWQ
         gswHpvVRiSBgWMuvjJ39M8FNsXTqwPz/i3ZaTVSiKl0LRqJFD/OKTtXGUgcI/aYca2Wz
         b+ezlLOaHfyahS3jDTMabls1swgnTU9RRwVP0ZqRQ9SQhqe2iBZqxmtYW/SFeVoEz3mB
         c85ZfGV2u2YKbYvs1HGlJFM3A3zGrdQwzxJ14hlfERiQMP9696q9pn9zkT/CZs4pGlen
         VItA==
X-Gm-Message-State: AOAM5338v92qeyqu9oo74yT75ugGANV78I0rkGnC96sPzD1xAIxT4h3J
        lQCUzTQ8iEnr2818atdLEQNTi0jZlVj1Qh58bqw=
X-Google-Smtp-Source: ABdhPJyF3zf9VHqBgf21+IQkJpVtNhHQo7SXRgP0IToByiYKsFVFfXU+PoU8RLAa/V7armxNkV4+pc7mewSPq5nLdLo=
X-Received: by 2002:ae9:e406:0:b0:6a3:86e7:88fa with SMTP id
 q6-20020ae9e406000000b006a386e788famr3746614qkc.71.1653322396923; Mon, 23 May
 2022 09:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220519081548.3380-1-worldhello.net@gmail.com>
 <20220523012531.4505-1-worldhello.net@gmail.com> <220523.86v8twzp6a.gmgdl@evledraar.gmail.com>
 <220523.86ilpwzmne.gmgdl@evledraar.gmail.com> <CANYiYbF8NDawCijZ1Hf=2zdi329=WSdYqL05Tz8+NOyJAFgpLA@mail.gmail.com>
 <220523.86sfp0xpoz.gmgdl@evledraar.gmail.com>
In-Reply-To: <220523.86sfp0xpoz.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 24 May 2022 00:13:05 +0800
Message-ID: <CANYiYbGozxEw6i-dGPPD_Y2CNttnpsa30akstb=C1qzXrq-dfA@mail.gmail.com>
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

On Mon, May 23, 2022 at 10:56 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, May 23 2022, Jiang Xin wrote:
>
> > On Mon, May 23, 2022 at 4:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> >>  $(LOCALIZED_SH_GEN_PO): .build/pot/po/%.po: %
> >>         $(call mkdir_p_parent_template)
> >> @@ -2786,11 +2780,24 @@ sed -e 's|charset=3DCHARSET|charset=3DUTF-8|' =
\
> >>  echo '"Plural-Forms: nplurals=3DINTEGER; plural=3DEXPRESSION;\\n"' >>=
$@
> >>  endef
> >>
> >> -.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
> >> +.build/pot/git.header:
> >
> > No. We should rebuild the pot header if any po file need to be update,
> > because we want to refresh the timestamp in the "POT-Creation-Date:"
> > filed of the pot header.
>
> Okey, I did leave a question about this in an earlier E-Mail though,
> i.e. does anything actually rely on this, or the header at all, or is
> this just cargo-culting?
>
> I haven't found anything in our toolchain that cares about the header at
> all (for the *.pot, not *.po!) let alone the update timestamp.

When creating a new po/XX.po manually using msginit from POT file with
or without a header, the new generated po/XX.po has different header.

  $ msginit -i po/git.pot -o po/XX-with-header.po \
      --locale=3Dja --no-translator
  $ msginit -i po/git-headless.pot -o po/XX-without-header.po \
      --locale=3Dja --no-translator
  $ diff po/XX-with-header.po po/XX-without-header.po
  1,5d0
  < # Japanese translations for Git package.
  < # Copyright (C) 2022 THE Git'S COPYRIGHT HOLDER
  < # This file is distributed under the same license as the Git package.
  < # Automatically generated, 2022.
  < #
  8,11c3
  < "Project-Id-Version: Git\n"
  < "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
  < "POT-Creation-Date: 2022-05-23 23:27+0800\n"
  < "PO-Revision-Date: 2022-05-23 23:27+0800\n"
  ---
  > "Project-Id-Version: git 2.36.0.7.g31429651cf.dirty\n"
  16c8
  < "Content-Type: text/plain; charset=3DUTF-8\n"
  ---
  > "Content-Type: text/plain; charset=3DASCII\n"

Should we ignore this change?

>
> >>         $(call mkdir_p_parent_template)
> >>         $(QUIET_GEN)$(gen_pot_header)
> >>
> >> -po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
> >> +# We go through this dance of having a prepared
> >> +# e.g. .build/pot/po/grep.c.po and copying it to
> >> +# .build/pot/to-cat/grep.c only because some IDEs (e.g. VSCode) pick
> >> +# up on the "real" extension for the purposes of auto-completion, eve=
n
> >> +# if the .build directiory is in .gitignore.
> >> +LOCALIZED_ALL_GEN_TO_CAT =3D $(LOCALIZED_ALL_GEN_PO:.build/pot/po/%.p=
o=3D.build/pot/to-cat/%)
> >> +ifdef AGGRESSIVE_INTERMEDIATE
> >> +.INTERMEDIATE: $(LOCALIZED_ALL_GEN_TO_CAT)
> >> +endif
> >> +$(LOCALIZED_ALL_GEN_TO_CAT): .build/pot/to-cat/%: .build/pot/po/%.po
> >> +       $(call mkdir_p_parent_template)
> >> +       $(QUIET_GEN)cat $< >$@
> >
> > Copy each po file in ".build/pot/po/" to another location
> > ".build/pot/to-cat/", but without the ".po" extension.
> >
> > Let's take "date.c" as an example:
> >
> > 1. Copy "date.c" to an intermediate C source file
> > ".build/pot/po-munged/date.c" and replace PRItime with PRIuMAX in it.
> >
> > 2. Call xgettext to create  ".build/pot/po/date.c.po" from the
> > intermediate C source file ".build/pot/po-munged/date.c".
> >
> > 3. Optionally remove intermediate C source files like
> > ".build/pot/po-munged/date.c". To have two identical C source files in
> > the same worktree is not good, some software may break. So I choose to
> > remove them.
> >
> > 4. Copy the po file (".build/pot/po/date.c.po") created in step 2 to
> > an intermediate fake C source file ".build/pot/to-cat/date.c" which is
> > a file without the ".po" extension. Please note this intermediate fake
> > C source file ".build/pot/to-cat/date.c" is not a valid C file, but a
> > PO file.
> >
> > 5. Call msgcat to create "po/git.pot" from all the intermediate fake C
> > source files including  ".build/pot/to-cat/date.c".
> >
> > 6. Optionally remove all the intermediate fake C source files in
> > ".build/pot/to-cat/". I choose to remove them, because leave lots of
> > invalid C source files in worktree is not good.
> >
> > For example, ".build/pot/po/date.c.po" was created from
> >> +
> >> +po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_TO_CAT)
> >>         $(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
> >
> > 7. "po/git.pot" depends on the intermediate fake C source files. If
> > any single C source file has been changed, will run step 6 to copy all
> > po files in ".build/pot/po" to corresponding fake C source files in
> > ".build/pot/to-cat/", if we choose to remove these intermediate fake C
> > source files.
> >
> > This implementation is too heavy to solve a trivial issue. I think we
> > can push forward this patch series and leave these comments in
> > "po/git.pot":
>
> If you find it too "heavy" & are trying to optimize it for some reason
> then that whole extra special-dance can be made conditional on
> MAKE_AVOID_REAL_EXTENSIONS_IN_GITIGNORED_FILES.
>
> But really, it's 15MB of .build/pot in my local HEAD with this fix-up,
> it's 1.4MB without it, but this whole thing just seems like premature
> optimization. Especially given:
>
>     $ git hyperfine -r 3 -L rev origin/master,HEAD~,HEAD,avar/Makefile-in=
cremental-po-git-pot-rule~,avar/Makefile-incremental-po-git-pot-rule -p 'gi=
t clean -dxf; git reset --hard' 'make pot' --warmup 1
>     Benchmark 1: make pot' in 'origin/master
>       Time (mean =C2=B1 =CF=83):      1.970 s =C2=B1  0.014 s    [User: 1=
.683 s, System: 0.353 s]
>       Range (min =E2=80=A6 max):    1.955 s =E2=80=A6  1.982 s    3 runs
>
>     Benchmark 2: make pot' in 'HEAD~
>       Time (mean =C2=B1 =CF=83):     931.3 ms =C2=B1   4.7 ms    [User: 3=
358.5 ms, System: 1088.7 ms]
>       Range (min =E2=80=A6 max):   927.0 ms =E2=80=A6 936.3 ms    3 runs
>
>     Benchmark 3: make pot' in 'HEAD
>       Time (mean =C2=B1 =CF=83):      1.506 s =C2=B1  0.389 s    [User: 4=
.655 s, System: 1.363 s]
>       Range (min =E2=80=A6 max):    1.257 s =E2=80=A6  1.955 s    3 runs
>
>     Benchmark 4: make pot' in 'avar/Makefile-incremental-po-git-pot-rule~
>       Time (mean =C2=B1 =CF=83):      1.015 s =C2=B1  0.002 s    [User: 3=
.615 s, System: 1.224 s]
>       Range (min =E2=80=A6 max):    1.013 s =E2=80=A6  1.017 s    3 runs
>
>     Benchmark 5: make pot' in 'avar/Makefile-incremental-po-git-pot-rule
>       Time (mean =C2=B1 =CF=83):      1.014 s =C2=B1  0.008 s    [User: 3=
.540 s, System: 1.068 s]
>       Range (min =E2=80=A6 max):    1.007 s =E2=80=A6  1.023 s    3 runs
>
>     Summary
>       'make pot' in 'HEAD~' ran
>         1.09 =C2=B1 0.01 times faster than 'make pot' in 'avar/Makefile-i=
ncremental-po-git-pot-rule'
>         1.09 =C2=B1 0.01 times faster than 'make pot' in 'avar/Makefile-i=
ncremental-po-git-pot-rule~'
>         1.62 =C2=B1 0.42 times faster than 'make pot' in 'HEAD'
>         2.12 =C2=B1 0.02 times faster than 'make pot' in 'origin/master'
>
> I.e. all of this is much faster than what we have on "master" now. My
> 22434ef36ae (Makefile: avoid "sed" on C files that don't need it,
> 2022-04-08) (avar/Makefile-incremental-po-git-pot-rule) is then just 10%
> slower than the "grep or xgettext", its "~" is the corresponding
> unoptimized.
>
> The HEAD here is with my fix-up, and HEAD~ is your series here.
>
> Anyway, if you really feel strongly about it let's go with your way of
> doing it.
>
> It just sounded like you weren't actually trying top optimize anything,
> but to work around your editor. So if we had a method to do that....

But for users who prefer to delete all the intermediate files in
".build/pot/to-cat" and ".build/pot/po-munged/", then they will get
performance penalty.

> ...except it seems you also care about making it much faster than
> "master" (or care about <20MB of disk space), which to be blunt seems a
> bit crazy to me :) Last I checked "make test" ended up creating ~1GB of
> data (not all at once, but in parallel testing a lot more than 10MB is
> often in play at once).
>
> As this was a pretty obscure target that I only expect CI, you,
> translators & me to run in practice a small difference in the initial
> run didn't seem to matter, especially as it's all an improvement over
> "master".
>
> Anyway, you do whatever you think is best with that :)
>
> >>         $ grep '#-#' po/git.pot
> >>         #. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#
> >>         #. #-#-#-#-#  add-patch.c.po  #-#-#-#-#
> >>         #. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#
> >>         #. #-#-#-#-#  branch.c.po  #-#-#-#-#
> >>         #. #-#-#-#-#  object-name.c.po  #-#-#-#-#
> >>         #. #-#-#-#-#  grep.c.po  #-#-#-#-#
>
