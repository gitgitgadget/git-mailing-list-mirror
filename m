Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1162C433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbiDEVna (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457785AbiDEQrF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 12:47:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83453192BB
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 09:45:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d5so24227515lfj.9
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QvfAiTRVqdBiCcyB5PyP7aE2Z+y/mrjg64BK0f4SfCQ=;
        b=GtOFgRYV0v2Cp6ggxRQqH6s9RY+XXtz7+9R0gBAXYd/rj1PdiGeisfNJvPtGeNb69j
         Dv5soDTivumuMLXRLVfaUWmMl/q0aCmnmypVjuRrG3WNLULaZbnGCtf2nObdY4AdcNkO
         M/mup+rlXcvb3FfFTOgX9ojU2ECBPyBuBAedgoYa0LpIQhP0RH0nkMXR7LtR4rLbLzf1
         /0d1rmLOhMLhiQJ/8qXwnXZqD5ELvybaje0zzOJsaBFz19am+30YYXMHqinRU0xaf4Mb
         MSG8QNcbJR1RLAQtJ5h8exr3dPNSIQRYvcLD5Eh9BoASnBbwCGkL51oNj90Za7uArR2C
         fwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QvfAiTRVqdBiCcyB5PyP7aE2Z+y/mrjg64BK0f4SfCQ=;
        b=Cy63f/zquu3VK7tqc21K53VsCJiYDaaFDk4LaaGChBwPJgwNsZq4SryUM2KucibZYR
         KyejyQne0BI3Ril2EAW4Pz5/wc/jCOiwY82YVjYkvzR+nOte0Oyh2XxORrY6PVEirnhn
         PNBeHXHh/FDKGY2MSaPI1GPiHlDIG2bYb8aiNWNhRHS9Kog6ZCsaU+I/JtRuDJAxDZFh
         ajKVj7HBzPhc7/+5XSB8UZs996h+umaEfg08su88PXNUMMRvRr5uVJAPt8K0EEvSkI7q
         yYhOatdortWZUBPwAdqfATlfbvxYmZrAY4nk2DJx4AKy4ewXcpiilnfK/KMOmLXpm2ZC
         CBzQ==
X-Gm-Message-State: AOAM531Yw5jzfN5eL81qB/JiyV6keWmW011TN3eAbS4tB6AgG6K5lLHu
        iXSw9gH8QoK1MipxDasCOPHXY3sMn9OFOoXYcBA=
X-Google-Smtp-Source: ABdhPJyMlPe5FW2RU9yIwNAdc381bF0tiHwqNk4wh/tUQ5GyaOgt/Dp1t3ng6VpOD4L3BKXI+eUcAtop34GsFelPDjk=
X-Received: by 2002:ac2:4e0e:0:b0:44a:2607:86db with SMTP id
 e14-20020ac24e0e000000b0044a260786dbmr3268263lfr.8.1649177102365; Tue, 05 Apr
 2022 09:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220405053559.1072115-1-alexhenrie24@gmail.com> <220405.86sfqrlvoz.gmgdl@evledraar.gmail.com>
In-Reply-To: <220405.86sfqrlvoz.gmgdl@evledraar.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 5 Apr 2022 10:44:50 -0600
Message-ID: <CAMMLpeSfxMgyJvWp9zTY6vNE4FPYJyY0HwAV-yBFSodac1R-xA@mail.gmail.com>
Subject: Re: [PATCH v2] convert: clarify line ending conversion warning
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, prohaska@zib.de,
        eyvind.bernhardsen@gmail.com, Tao Klerks <tao@klerks.biz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 5, 2022 at 3:35 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Mon, Apr 04 2022, Alex Henrie wrote:
>
> Friendly hint: just for the future: Please use the --in-reply-to of
> git-format-patch when submitting re-rolls, so threading with the
> original thread won't be broken.
>
> > The warning about converting line endings is extremely confusing. Its
> > two sentences each use the word "will" without specifying a timeframe,
> > which makes it sound like both sentences are referring to the same
> > timeframe. On top of that, it uses the term "original line endings"
> > without saying whether "original" means LF or CRLF.
> >
> > Rephrase the warning to be clear about when the line endings will be
> > changed and what they will be changed to.
> >
> > On a platform whose native line endings are not CRLF (e.g. Linux), the
> > "git add" step in the following sequence triggers the warning in
> > question:
> >
> > $ git config core.autocrlf true
> > $ echo 'Hello world!' >hello.txt
> > $ git add hello.txt
> > warning: LF will be replaced by CRLF in hello.txt
> > The file will have its original line endings in your working directory
> >
> > Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> > ---
> > v2:
> > - Quote the confusing warning in the above commit message
> > - Move the file name to the beginning of the warning message
>
> In case that's in response to my v1 review, I was pointing out pretty
> much the opposite, i.e. try with this:
>
>         diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
>         index 7f80f463930..26b939566d4 100755
>         --- a/t/t0027-auto-crlf.sh
>         +++ b/t/t0027-auto-crlf.sh
>         @@ -100,7 +100,12 @@ commit_check_warn () {
>                 do
>                         fname=3D${pfx}_$f.txt &&
>                         cp $f $fname &&
>         -               git -c core.autocrlf=3D$crlf add $fname 2>"${pfx}=
_$f.err"
>         +               cp $f $fname &&
>         +               cp $f $fname.1 &&
>         +               cp $f $fname.2 &&
>         +               cp $f $fname.3 &&
>         +
>         +               git -c core.autocrlf=3D$crlf add $fname*
>                 done &&
>                 git commit -m "core.autocrlf $crlf" &&
>                 check_warning "$lfname" ${pfx}_LF.err &&
>
> Then run with -vixd, we'll without your change emit e.g.:
>
>         + git -c core.autocrlf=3Dtrue add crlf_true_attr__CRLF_mix_LF.txt=
 crlf_true_attr__CRLF_mix_LF.txt.1 crlf_true_attr__CRLF_mix_LF.txt.2 crlf_t=
rue_attr__CRLF_mix_LF.txt.3
>         warning: LF will be replaced by CRLF in crlf_true_attr__CRLF_mix_=
LF.txt.
>         The file will have its original line endings in your working dire=
ctory
>         warning: LF will be replaced by CRLF in crlf_true_attr__CRLF_mix_=
LF.txt.1.
>         The file will have its original line endings in your working dire=
ctory
>         warning: LF will be replaced by CRLF in crlf_true_attr__CRLF_mix_=
LF.txt.2.
>         The file will have its original line endings in your working dire=
ctory
>         warning: LF will be replaced by CRLF in crlf_true_attr__CRLF_mix_=
LF.txt.3.
>         The file will have its original line endings in your working dire=
ctory
>
> But with your change applied:
>
>         + git -c core.autocrlf=3Dtrue add crlf_true_attr__CRLF_mix_LF.txt=
 crlf_true_attr__CRLF_mix_LF.txt.1 crlf_true_attr__CRLF_mix_LF.txt.2 crlf_t=
rue_attr__CRLF_mix_LF.txt.3
>         warning: In 'crlf_true_attr__CRLF_mix_LF.txt', LF will be replace=
d by CRLF the next time Git touches it
>         warning: In 'crlf_true_attr__CRLF_mix_LF.txt.1', LF will be repla=
ced by CRLF the next time Git touches it
>         warning: In 'crlf_true_attr__CRLF_mix_LF.txt.2', LF will be repla=
ced by CRLF the next time Git touches it
>         warning: In 'crlf_true_attr__CRLF_mix_LF.txt.3', LF will be repla=
ced by CRLF the next time Git touches it
>
> Now, the existing message really sucks, we should really should
> buffering this up somehow and saying "here's the problem with these N
> files\n<list of N>".
>
> See Tao's recent e4921d877ab (tracking branches: add advice to ambiguous
> refspec error, 2022-04-01) for an example
>
> But having a message in the form of:
>
>     %s blah blah
>
> As opposed to:
>
>     blah blah %s
>
> Where %s is going to be expanded as a path is IMO worse, because both
> are repetative, but at least with the latter the constant part of the
> message is aligned.
>
> But anyway, while I'm still iffy about this change because it seems like
> a bit of improvement and a bit of regression.
>
> Especially as we don't offer the working directory advice at all, and
> because the clear explanation about what happens to the file has been
> replaced by some "the next time Git touches it" suggestion.
>
> Which, if I wasn't looking at the pre- and post-image would completely
> confuse me.
>
> Anyway.
>
> I'd much rather have us focus less on re-arranging the deck chairs on
> the Titanic here.
>
> The real issue is that we're emitting this long message in a loop. Now,
> I was expecting that it would be painful to do something like Tao's
> change since we're deep in the guts of convert.c, but if I set a
> breakpoint on warning in gdb I'll get:
>
>         (gdb) bt
>         #0  warning (warn=3D0x77ed12 "In '%s', LF will be replaced by CRL=
F the next time Git touches it") at usage.c:285
>         #1  0x0000000000572479 in check_global_conv_flags_eol (path=3D0x8=
a1e84 "LF", old_stats=3D0x7fffffff7af0, new_stats=3D0x7fffffff7ac8, conv_fl=
ags=3D18) at convert.c:207
>         #2  0x000000000056fd49 in crlf_to_git (istate=3D0x855f70 <the_ind=
ex>, path=3D0x8a1e84 "LF", src=3D0x8a21b0 "$Id: ", '0' <repeats 40 times>, =
" $\nLINEONE\nLINETWO\nLINETHREEHREE", len=3D73,
>             buf=3D0x7fffffff7bf8, crlf_action=3DCRLF_AUTO_CRLF, conv_flag=
s=3D18) at convert.c:537
>         #3  0x000000000056f88d in convert_to_git (istate=3D0x855f70 <the_=
index>, path=3D0x8a1e84 "LF", src=3D0x8a21b0 "$Id: ", '0' <repeats 40 times=
>, " $\nLINEONE\nLINETWO\nLINETHREEHREE", len=3D73,
>             dst=3D0x7fffffff7bf8, conv_flags=3D18) at convert.c:1428
>         #4  0x0000000000619a4b in index_mem (istate=3D0x855f70 <the_index=
>, oid=3D0x7ffff7bfda98, buf=3D0x8a21b0, size=3D73, type=3DOBJ_BLOB, path=
=3D0x8a1e84 "LF", flags=3D1) at object-file.c:2179
>         #5  0x0000000000616650 in index_core (istate=3D0x855f70 <the_inde=
x>, oid=3D0x7ffff7bfda98, fd=3D4, size=3D73, type=3DOBJ_BLOB, path=3D0x8a1e=
84 "LF", flags=3D1) at object-file.c:2265
>         #6  0x000000000061621c in index_fd (istate=3D0x855f70 <the_index>=
, oid=3D0x7ffff7bfda98, fd=3D4, st=3D0x7fffffff7e88, type=3DOBJ_BLOB, path=
=3D0x8a1e84 "LF", flags=3D1) at object-file.c:2313
>         #7  0x000000000061682e in index_path (istate=3D0x855f70 <the_inde=
x>, oid=3D0x7ffff7bfda98, path=3D0x8a1e84 "LF", st=3D0x7fffffff7e88, flags=
=3D1) at object-file.c:2334
>         #8  0x0000000000657b26 in add_to_index (istate=3D0x855f70 <the_in=
dex>, path=3D0x8a1e84 "LF", st=3D0x7fffffff7e88, flags=3D0) at read-cache.c=
:830
>         #9  0x0000000000658183 in add_file_to_index (istate=3D0x855f70 <t=
he_index>, path=3D0x8a1e84 "LF", flags=3D0) at read-cache.c:863
>         #10 0x000000000040a48a in add_files (dir=3D0x7fffffff8020, flags=
=3D0) at builtin/add.c:469
>         #11 0x0000000000409aa1 in cmd_add (argc=3D428, argv=3D0x7fffffff8=
518, prefix=3D0x0) at builtin/add.c:681
>         #12 0x0000000000407cbb in run_builtin (p=3D0x8237f0 <commands>, a=
rgc=3D429, argv=3D0x7fffffff8510) at git.c:465
>         #13 0x0000000000406772 in handle_builtin (argc=3D429, argv=3D0x7f=
ffffff8510) at git.c:719
>         #14 0x0000000000407696 in run_argv (argcp=3D0x7fffffff83bc, argv=
=3D0x7fffffff83b0) at git.c:786
>         #15 0x0000000000406531 in cmd_main (argc=3D429, argv=3D0x7fffffff=
8510) at git.c:917
>         #16 0x000000000051202a in main (argc=3D432, argv=3D0x7fffffff84f8=
) at common-main.c:56
>         (gdb)
>
> Which was a pleseant surprise, i.e. here we're dealing with the "struct
> index_state" all the way down to the warning caller.
>
> So that seems like a good candidate for this. Let's try:
>
>         diff --git a/builtin/add.c b/builtin/add.c
>         index 3ffb86a4338..189a7337fa1 100644
>         --- a/builtin/add.c
>         +++ b/builtin/add.c
>         @@ -447,6 +447,11 @@ static int add_files(struct dir_struct *dir,=
 int flags)
>          {
>                 int i, exit_status =3D 0;
>                 struct string_list matched_sparse_paths =3D STRING_LIST_I=
NIT_NODUP;
>         +       struct string_list crlf2lf =3D STRING_LIST_INIT_NODUP;
>         +       struct string_list lf2crlf =3D STRING_LIST_INIT_NODUP;
>         +
>         +       the_index.crlf2lf =3D &crlf2lf;
>         +       the_index.lf2crlf =3D &lf2crlf;
>
>                 if (dir->ignored_nr) {
>                         fprintf(stderr, _(ignore_error));
>         @@ -480,7 +485,26 @@ static int add_files(struct dir_struct *dir,=
 int flags)
>                         exit_status =3D 1;
>                 }
>
>         +       if (crlf2lf.nr) {
>         +               struct string_list_item *item;
>         +
>         +               warning("ohes noes crlf2lf:");
>         +               for_each_string_list_item(item, &crlf2lf)
>         +                       warning("\t%s", item->string);
>         +       }
>         +       if (lf2crlf.nr) {
>         +               struct string_list_item *item;
>         +
>         +               warning("ohes noes lf2crlf:");
>         +               for_each_string_list_item(item, &lf2crlf)
>         +                       warning("\t%s", item->string);
>         +       }
>         +
>                 string_list_clear(&matched_sparse_paths, 0);
>         +       string_list_clear(&crlf2lf, 0);
>         +       string_list_clear(&lf2crlf, 0);
>         +       the_index.crlf2lf =3D NULL;
>         +       the_index.lf2crlf =3D NULL;
>
>                 return exit_status;
>          }
>         diff --git a/cache.h b/cache.h
>         index 6226f6a8a53..3538cdebd61 100644
>         --- a/cache.h
>         +++ b/cache.h
>         @@ -341,6 +341,8 @@ struct index_state {
>                 struct progress *progress;
>                 struct repository *repo;
>                 struct pattern_list *sparse_checkout_patterns;
>         +       struct string_list *crlf2lf;
>         +       struct string_list *lf2crlf;
>          };
>
>          /* Name hashing */
>         diff --git a/convert.c b/convert.c
>         index 733e581cb98..e1f8386185a 100644
>         --- a/convert.c
>         +++ b/convert.c
>         @@ -185,8 +185,11 @@ static enum eol output_eol(enum convert_crlf=
_action crlf_action)
>          }
>
>          static void check_global_conv_flags_eol(const char *path,
>         -                           struct text_stat *old_stats, struct t=
ext_stat *new_stats,
>         -                           int conv_flags)
>         +                                       struct text_stat *old_sta=
ts,
>         +                                       struct text_stat *new_sta=
ts,
>         +                                       int conv_flags,
>         +                                       struct string_list *crlf2=
lf,
>         +                                       struct string_list *lf2cr=
lf)
>          {
>                 if (old_stats->crlf && !new_stats->crlf ) {
>                         /*
>         @@ -194,18 +197,20 @@ static void check_global_conv_flags_eol(con=
st char *path,
>                          */
>                         if (conv_flags & CONV_EOL_RNDTRP_DIE)
>                                 die(_("CRLF would be replaced by LF in %s=
"), path);
>         +               else if (conv_flags & CONV_EOL_RNDTRP_WARN && crl=
f2lf)
>         +                       string_list_append(crlf2lf, path);
>                         else if (conv_flags & CONV_EOL_RNDTRP_WARN)
>         -                       warning(_("In '%s', CRLF will be replaced=
 by LF the"
>         -                                 " next time Git touches it"), p=
ath);
>         +                       BUG("unreachable");
>                 } else if (old_stats->lonelf && !new_stats->lonelf ) {
>                         /*
>                          * CRLFs would be added by checkout
>                          */
>                         if (conv_flags & CONV_EOL_RNDTRP_DIE)
>                                 die(_("LF would be replaced by CRLF in %s=
"), path);
>         +               else if (conv_flags & CONV_EOL_RNDTRP_WARN && lf2=
crlf)
>         +                       string_list_append(lf2crlf, path);
>                         else if (conv_flags & CONV_EOL_RNDTRP_WARN)
>         -                       warning(_("In '%s', LF will be replaced b=
y CRLF the"
>         -                                 " next time Git touches it"), p=
ath);
>         +                       BUG("unreachable");
>                 }
>          }
>
>         @@ -534,7 +539,8 @@ static int crlf_to_git(struct index_state *is=
tate,
>                                 new_stats.crlf +=3D new_stats.lonelf;
>                                 new_stats.lonelf =3D 0;
>                         }
>         -               check_global_conv_flags_eol(path, &stats, &new_st=
ats, conv_flags);
>         +               check_global_conv_flags_eol(path, &stats, &new_st=
ats, conv_flags,
>         +                                           istate->crlf2lf, ista=
te->lf2crlf);
>                 }
>                 if (!convert_crlf_into_lf)
>                         return 0;
>
> Which, with the test change above emits:
>
>
>         $ git reset; ~/g/git/git -c core.autocrlf=3Dtrue add *
>         Unstaged changes after reset:
>         M       .gitattributes
>         warning: ohes noes lf2crlf:
>         warning:        CRLF_mix_LF
>         warning:        LF
>         warning:        crlf_true_attr__LF.err.expect
>         warning:        tmp
>
> Now, obviously that's crappy WIP code as far as the message goes., and
> the BUG() will be hit by the other caller in diff.c (which hooks in just
> before a call to convert_to_git(), or we'd fall back on that.
>
> Also, i18n with _() is needed, and the message needs to be prettier, but
> with just a tiny bit of polishing (hint hint!) this would be sooo much
> better.
>
> You could even use e4921d877ab as a template to add advice() output for
> this, so we could save ourselves the verbosity/output for users who'd
> like to configure this away.
>
> Maybe that's all a bit too much, sorry. I just get excited about
> improving some of the crappy parts of our UX sometimes. If you don't
> want to run with this I suppose it could be done as a follow-up.

Thanks for the extensive feedback. So, there are two problems here:

1. The current warning is very confusingly worded

2. The current warning is repetitive if there are a lot of files

For the moment, I'm only trying to address problem #1. Junio asked for
the file name to be moved to near the beginning of the message and for
the second sentence to be removed. Tao asked to avoid the verb "check
out" and said that "touch" was better. What wording would you suggest?

-Alex
