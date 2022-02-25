Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17B1C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 15:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbiBYP7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 10:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbiBYP7v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 10:59:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A661ACA09
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 07:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645804755;
        bh=+NHP1qstkkj6urr1n7u8vU8KuhsPprVy0A4QBNL7uMY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V9RrfpexOOeQFemeRFf6q/1P6HXxY9rsZ++NbCCxfcU8yrNDU+rEDx5ndMtJ9lJdP
         V2FzlTV6CYVTPeAfM42FZl42sfuXNjYEzd33bLpCTF0ouN/pPQDMs2a4xEV9ZOZUZz
         9EZf7tIdGwetsYu+Jg50Ijb1oGAf4cZOoX8MkeBA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCb5-1njmYV3qqX-00VBq0; Fri, 25
 Feb 2022 16:59:15 +0100
Date:   Fri, 25 Feb 2022 16:59:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 11/14] bisect: move even the option parsing to
 `bisect--helper`
In-Reply-To: <220223.86v8x56g7g.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202251647370.11118@tvgsbejvaqbjf.bet>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com> <dc04b06206bbb833ce3a7fa893d724d00fe58a74.1645547423.git.gitgitgadget@gmail.com> <220223.86v8x56g7g.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1005679065-1645804754=:11118"
X-Provags-ID: V03:K1:7geJUZ6tmr6hIx6kyIlQmy46fv9IUDvm4Gp2TwAPPnnzbX+ksw0
 YY/PtbiACrLTly1Aq528KcYKUM23jp4cQXfwO0oLswoelPYq7J2NohOzdlSjCPMgFbk9sRJ
 kqIcydBv0Je0+VRMD6u+KqFhKq3Tnjg5pHFDt+YBetUUDi7vjBt/SZYLJkLc27F+D2bxsyZ
 PzLUeDPu5LcP0ep8/syRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:im0X5X1TqWc=:gyIclPcloUiELnbnGCQwaO
 mBsECPgYe+v3BoN5MCcZ1lHZVpJRDZnZABz/Gohk9QpQtz01pqqGHCIdDsY87BbhbnCx3ZVZg
 UGgXyEqTe8rALucuC3zzMM77pFMndUU4o8eMWjwxID6CE9tNc4uLQSjOCi53ohxJ3i5a6bW//
 joq21gD+glDB/oUg+zas4UnBzE2jQ5P6Kf1pCU5Krvx11kWYM3GvAqHMv4z3EnEaH8j1CY39d
 wslFB/Z+IThYpDN0morgeMVaJuj2+xWvjs1xaltUlug3JcueciOnIWMjs+kcAlr5/jeIJ7TkD
 9HlS3fVvj9GQpBWVCgFH+hG6T9257BPDzzpJTnzr2EFosYoIiQ0zK0HQ07tHAN1B4fabHZ0Z3
 xsVoSdsQS3SsaRWVMvTLeOIHlnPQH5jS6MHsVXKTPn8w3K1l0JeyZQ+xyfZ5om3Ut+3MIIshn
 DAqAIffvZu+TLdZANA1BFLQCNEvMj/OUtkarUkklDIzb+ooEGmXjMAGwXyYrx57P7D8rmziFi
 3/1ds9qBgFny2Uo1onpBe8KlNxVG8vkCYdsA9CgVrROk4fX6bSlX5itqDK5fturn/H7lL0s/Q
 00BW79wZcVqyrXgxDWD+MBrKKDSRPD4X13x7wv3Jz/VQOwOjOxaTSMk3AkHhCCb/rh42A8PDQ
 pR66akC1XVbkfylOg0c299LQqwu1h9UypqqljxsaNTVfuMRBX+eA163uN5bjqCkNuOk6pZlkW
 fBD+lB+cOOQ1Jxeao7s4cYbS8VpDyBXL4c0zJmoWWunW7hlJvC4sgU4Hi/ALa69puUM3oaIKA
 ivX9qF7D6oqVvgCzqhg7FoxPmoVEY9P8WAXOtYWcxAGdCjaAAzFHz17tXRln20M3CoLIVwss9
 A/CFLGiDffSrLu4B0FDktIuXjTWsESOQ8gfMOv7VOvRDnys8FLXQz8cC1laDWt1lvawTEV5RS
 eSzx2Hk1AoQ/qXxhxIrfPn2z1NHlk67UCxw5hDTxjL3JWU0uKHAQKcvfe95OvxWg64UVEbsmx
 6kqRtt2H0W4eTfcMh8rHMu3IO7Rues8nRXdW67kQsia+QPgaQV+aEWZA+77IKunwcEi085AoD
 bLaRPsSHU8kWOQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1005679065-1645804754=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 23 Feb 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Feb 22 2022, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > On our journey to a fully built-in `git bisect`, this is the
> > second-to-last step.
> >
> > Side note: The `if (!strcmp(...)) ... else if (!strcmp(...)) ... else =
if
> > (!strcmp(...)) ...` chain seen in this patch was not actually the firs=
t
> > idea how to convert the command modes to sub-commands. Since the
> > `bisect--helper` command already used the `parse-opions` API with neat=
ly
> > set-up command modes, naturally the idea was to use `PARSE_OPT_NODASH`
> > to support proper sub-commands instead. However, the `parse-options` A=
PI
> > is not set up for that, and even after making that option work with lo=
ng
> > options, it turned out that `STOP_AT_NON_OPTION` and `KEEP_UNKNOWN`
> > would have to be used but these options were not designed to work
> > together. So it would appear as if a lot of work would have to be done
> > just to be able to use `parse_options()` just to parse the sub-command=
,
> > instead of a simple `if...else if` chain, the latter being a
> > dramatically simpler implementation.
>
> As I noted in
> https://lore.kernel.org/git/220129.86pmobauyt.gmgdl@evledraar.gmail.com/=
:
>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/bisect--helper.c | 133 ++++++++++++++++----------------------=
-
> >  git-bisect.sh            |  49 +--------------
> >  2 files changed, 56 insertions(+), 126 deletions(-)
> >
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index 5228964937d..ef0b06d594b 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -20,18 +20,34 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISEC=
T_NAMES")
> >  static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARE=
NT")
> >  static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
> >
> > -static const char * const git_bisect_helper_usage[] =3D {
> > -	N_("git bisect--helper --bisect-reset [<commit>]"),
> > -	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --=
term-bad | --term-new]"),
> > -	N_("git bisect--helper --bisect-start [--term-{new,bad}=3D<term> --t=
erm-{old,good}=3D<term>]"
> > -					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] =
[<paths>...]"),
> > -	N_("git bisect--helper --bisect-next"),
> > -	N_("git bisect--helper [--bisect-state] (bad|new) [<rev>]"),
> > -	N_("git bisect--helper [--bisect-state] (good|old) [<rev>...]"),
> > -	N_("git bisect--helper --bisect-replay <filename>"),
> > -	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
> > -	N_("git bisect--helper --bisect-visualize"),
> > -	N_("git bisect--helper --bisect-run <cmd>..."),
> > +static const char * const git_bisect_usage[] =3D {
> > +	N_("git bisect help\n"
> > +	   "\tprint this long help message."),
> > +	N_("git bisect start [--term-{new,bad}=3D<term> --term-{old,good}=3D=
<term>]\n"
> > +	   "\t\t [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [=
<pathspec>...]\n"
> > +	   "\treset bisect state and start bisection."),
> > +	N_("git bisect (bad|new) [<rev>]\n"
> > +	   "\tmark <rev> a known-bad revision/\n"
> > +	   "\t\ta revision after change in a given property."),
> > +	N_("git bisect (good|old) [<rev>...]\n"
> > +	   "\tmark <rev>... known-good revisions/\n"
> > +	   "\t\trevisions before change in a given property."),
> > +	N_("git bisect terms [--term-good | --term-bad]\n"
> > +	   "\tshow the terms used for old and new commits (default: bad, goo=
d)"),
> > +	N_("git bisect skip [(<rev>|<range>)...]\n"
> > +	   "\tmark <rev>... untestable revisions."),
> > +	N_("git bisect next\n"
> > +	   "\tfind next bisection to test and check it out."),
> > +	N_("git bisect reset [<commit>]\n"
> > +	   "\tfinish bisection search and go back to commit."),
> > +	N_("git bisect (visualize|view)\n"
> > +	   "\tshow bisect status in gitk."),
> > +	N_("git bisect replay <logfile>\n"
> > +	   "\treplay bisection log."),
> > +	N_("git bisect log\n"
> > +	   "\tshow bisect log."),
> > +	N_("git bisect run <cmd>...\n"
> > +	   "\tuse <cmd>... to automatically bisect."),
> >  	NULL
> >  };
>
> Even that doesn't explain why this needs to be changed as
> well.

True. The explanation is easy: I am not in the business of changing the
usage shown by `git bisect -h`.

> we no longer understand "git bisect <subcommand> -h", but did before
> etc.

... for some definition of "understand" ;-) See for yourself:

	$ git bisect visualize -h
	usage: git bisect--helper --bisect-reset [<commit>]
	   or: git bisect--helper --bisect-terms [--term-good | --term-old | --te=
rm-bad | --term-new]
	   or: git bisect--helper --bisect-start [--term-{new,bad}=3D<term> --ter=
m-{old,good}=3D<term>] [--no-checkout] [--first-parent] [<bad> [<good>...]=
] [--] [<paths>...]
	   or: git bisect--helper --bisect-next
	   or: git bisect--helper --bisect-state (bad|new) [<rev>]
	   or: git bisect--helper --bisect-state (good|old) [<rev>...]
	   or: git bisect--helper --bisect-replay <filename>
	   or: git bisect--helper --bisect-skip [(<rev>|<range>)...]
	   or: git bisect--helper --bisect-visualize
	   or: git bisect--helper --bisect-run <cmd>...

	    --bisect-reset        reset the bisection state
	    --bisect-next-check   check whether bad or good terms exist
	    --bisect-terms        print out the bisect terms
	    --bisect-start        start the bisect session
	    --bisect-next         find the next bisection commit
	    --bisect-state        mark the state of ref (or refs)
	    --bisect-log          list the bisection steps so far
	    --bisect-replay       replay the bisection process from the given fil=
e
	    --bisect-skip         skip some commits for checkout
	    --bisect-visualize    visualize the bisection
	    --bisect-run          use <cmd>... to automatically bisect.
	    --no-log              no log for BISECT_WRITE

That's not a helpful usage for `git bisect visualize`. It's better to
leave it to a future patch for `bisect_visualize()` to handle `-h`.

In other words, what you point out as a bug is actually fixing one.

I find the other comments on not using the `parse_options()` machinery
similar, and your feedback seems to flatly dismiss the side note in the
commit message as irrelevant.

To be clear: I spent a substantial amount of time trying to extend the
`parse_options()` machinery to support dash-less subcommands. The end
result was neither elegant nor particularly useful.

So, with all due respect, I disagree with your disagreeing.

Ciao,
Johannes

--8323328-1005679065-1645804754=:11118--
