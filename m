Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D03C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 15:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiBVPNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiBVPNN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 10:13:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70553124C0B
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645542764;
        bh=N5BL18B0aRUJC1oemhaCUtl8Hzokq3tKkT1RJRwj+/Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Y0tnaJnAVWwMZe3sN6rbHlro9dUizCUWifRIa6HgoCRdcVetLflVFeUfVBPzxUiQn
         ACSnol0F2LV8bQ3vVj7nJAUpiN4W07l1uRZgJ1orhrhyB1tOIwEc4E6S7q/5sp3n7P
         M9CVgFnUBea26p+MfMDNuGXcKKuLUHluvOsqxnnQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sn1-1oJNeV30TH-018Ian; Tue, 22
 Feb 2022 16:12:44 +0100
Date:   Tue, 22 Feb 2022 16:12:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH 06/11] bisect--helper: make `--bisect-state` optional
In-Reply-To: <CABPp-BHvGOH5copWukeTy55dXDz1yq47VJcrZRj_b8cZgTy_VQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221612020.11118@tvgsbejvaqbjf.bet>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <eddbdde222a01113d8facdcb17d6ec85676edbe7.1643328752.git.gitgitgadget@gmail.com> <CABPp-BHvGOH5copWukeTy55dXDz1yq47VJcrZRj_b8cZgTy_VQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WSmlv/HWOrx5zr+Fg8NxU8a9c7jKTZwqsCwdrpr6LKpkwXuRUkM
 aYX72kLAWw9c0m+vn+yOKF4w6YbdKyGRbN/GC0F2eaXIbOd6zm9UckTuXETdqOBULNqA85G
 TsEunAoxnNsYqdws7Tg4hJEqgyYB0zB5K7jyX9iPU1JGy1gnNjy3GeimPFtT2xSs5BjraHz
 92H0P8xycwShDxBAuCE8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e8AQrWQZ9DY=:7X9DPAaWtbmn8/ZUNPll6n
 xl9FRiVWxKkY20QzVdpHMiGf5GH+j/ydQAAO/MfO/CozAn6p0pWbdvSf3NA+GwHUFqV6agcYJ
 RQVp6kSPVwAzqWK9qcfOFywDF1H9IkeDtmf+St1zNXAimILw3VZH0niR6PcAho2J+n0uT2so3
 ULiUWlQabGeC1mZ7N9vdLZjylyV+cwJTp4J95egDck/In+3B5RwS6Zznu/YXPYQBRheNSSJV7
 /lIB/xiVAJC3tYXtpahjj4LK93PbL74qCcGR+6Yw3UJvB2e4SOgNvsKLjsxc7hjl9/QERpxKe
 8nj5VUi1pAgb224zfCTe+opq15NGo+htKIhC64X6Qa4xg1k1pSy/hVRXZiuMgIOuNZX8fuleA
 oUT5eZ51LHieis8+YGtKGbgn8D06lydppKzJKhY0nL08txtiXomYVNk+CGoos8BpzG66hctuJ
 +7DqteqZOmlhXhbKMyM6Nox8jVmSbiUln4QtXtcRM//1XaV4ITUfGb+Q0sMneHDSBVn9258Po
 ooKWKUEj8tp16y2LID4/W8kOewO3GUSdkYNat/xfzyMyqyaAW5JJTG5+ga3G/MYdbgOyUATNz
 RzJwP+xW4EODSkT3DsOFkGDGVAAIfH7ZHTq3NezaKLkFcmTG0X13PRsmZHdimxOl51I6TmaSH
 +Gb99k3h8kU7GG4sl2uI1hcm8t+uxkZouhkVid99jvSz6lfgm+Jfqp3a7zg39sFNBacFw+Klv
 D6RsBAJtT/9pFcuGdQy0Y2aHq67XnrCnfSSGk/+ATlQYJ1qNqOeNtvuTG8VdvqCzmo6jQt3Hn
 tlU6QHBU2AaUzZO7KrLCxHidQumVht6BOgMweSP18SM0klG2/0pLrwxMf7AhVC+MaL+atfpRM
 lHovNUquyLY+wTIVpfmVYKLqvXCmqR8K/lDulaGIoN4SnyBZPnP3L3dtGEe3unlA2x5LyKgD3
 Bh6EnSfi4QFE1GiNmE57gvPJ7M7nY9d9Uh9eaBy/p06WFfvyK7eq/VJynDGLRWoPWjsTeqURe
 4xyFclofYOi6BGt0lYv4nQQYKkis6HPKOEUZb013Crmb7m3UqAT75ewdiFhtO1jklSXmW8511
 b2I//ztKw/4PeY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 8 Feb 2022, Elijah Newren wrote:

> On Fri, Jan 28, 2022 at 3:52 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In preparation for making `git bisect` a real built-in, let's prepare
> > the `bisect--helper` built-in to handle `git bisect--helper good` and
> > `git bisect--helper bad`, i.e. do not require the `--bisect-state`
> > option to be passed explicitly.
> >
> > To prepare for converting `bisect--helper` to a full built-in
> > implementation of `git bisect` (which must not require the
> > `--bisect-state` option to be specified at all), let's move the handli=
ng
> > toward the end of the `switch (cmdmode)` block.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/bisect--helper.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index cc5a9ca41b9..219fa99cd0b 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -26,8 +26,8 @@ static const char * const git_bisect_helper_usage[] =
=3D {
> >         N_("git bisect--helper --bisect-start [--term-{new,bad}=3D<ter=
m> --term-{old,good}=3D<term>]"
> >                                             " [--no-checkout] [--first=
-parent] [<bad> [<good>...]] [--] [<paths>...]"),
> >         N_("git bisect--helper --bisect-next"),
> > -       N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
> > -       N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
> > +       N_("git bisect--helper [--bisect-state] (bad|new) [<rev>]"),
> > +       N_("git bisect--helper [--bisect-state] (good|old) [<rev>...]"=
),
> >         N_("git bisect--helper --bisect-replay <filename>"),
> >         N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
> >         N_("git bisect--helper --bisect-visualize"),
> > @@ -1210,6 +1210,13 @@ int cmd_bisect__helper(int argc, const char **a=
rgv, const char *prefix)
> >                              git_bisect_helper_usage,
> >                              PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_=
UNKNOWN);
> >
> > +       if (!cmdmode && argc > 0) {
> > +               set_terms(&terms, "bad", "good");
> > +               get_terms(&terms);
> > +               if (!check_and_set_terms(&terms, argv[0]))
> > +                       cmdmode =3D BISECT_STATE;
> > +       }
> > +
> >         if (!cmdmode)
> >                 usage_with_options(git_bisect_helper_usage, options);
> >
> > @@ -1218,11 +1225,6 @@ int cmd_bisect__helper(int argc, const char **a=
rgv, const char *prefix)
> >                 set_terms(&terms, "bad", "good");
> >                 res =3D bisect_start(&terms, argv, argc);
> >                 break;
> > -       case BISECT_STATE:
> > -               set_terms(&terms, "bad", "good");
> > -               get_terms(&terms);
> > -               res =3D bisect_state(&terms, argv, argc);
> > -               break;
> >         case BISECT_TERMS:
> >                 if (argc > 1)
> >                         return error(_("--bisect-terms requires 0 or 1=
 argument"));
> > @@ -1265,6 +1267,13 @@ int cmd_bisect__helper(int argc, const char **a=
rgv, const char *prefix)
> >                 get_terms(&terms);
> >                 res =3D bisect_run(&terms, argv, argc);
> >                 break;
> > +       case BISECT_STATE:
> > +               if (!terms.term_good) {
> > +                       set_terms(&terms, "bad", "good");
> > +                       get_terms(&terms);
> > +               }
> > +               res =3D bisect_state(&terms, argv, argc);
> > +               break;
> >         default:
> >                 BUG("unknown subcommand %d", cmdmode);
> >         }
> > --
> > gitgitgadget
>
> Does it make sense to also include something like this:
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 405cf76f2a..fbf56649d7 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -60,7 +60,7 @@ case "$#" in
>         start)
>                 git bisect--helper --bisect-start "$@" ;;
>         bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
> -               git bisect--helper --bisect-state "$cmd" "$@" ;;
> +               git bisect--helper "$cmd" "$@" ;;
>         skip)
>                 git bisect--helper --bisect-skip "$@" || exit;;
>         next)
>
> to prove that you've made it optional?  (Well, assuming one has run
> the tests with that change, but I did...)

Good point! That code will go away within the same patch series, of
course, but it is good to keep this in an intermediate commit.

Thanks,
Dscho
