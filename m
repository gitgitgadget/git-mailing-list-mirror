Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A95C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 16:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbiBYQ5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbiBYQ52 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 11:57:28 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC191EE9D7
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:56:55 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c6so8219485edk.12
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1fCrFcozyWqlA+LgbhafFfrx1Stwpkt/Qc6xF58W6G0=;
        b=WzqvhRUs4ZeMLUrJkDlS+LUmLhw8h8w8Yab7/LeLnIC0mWGgGxaYeBM7ruwyCFi8F0
         b+bn1cgxu6k6Wzn0Y7LUI8XTwtHTQwCvCBAI3ZSWEQp+skXwEpugqBnYN4H8M31QitCy
         RUgeoISPjdifgMoDijXH39W/aOsu7fdLXctmq0XFdtj68NOf6IPLomYnozHhZ2Yw8uZf
         Sq9FbaaP8hP+cJ+pjtQDZ3G4RvlQ6dAEnKboNLExkhJky/eUwIIgHsf3t2Yk5Bum5hDr
         tW+jX4Vk3hXDPJjpOVLXGZNGQe+u5HIKGjJSVsl59qdSAaeaCE2Xy7uTfMgw+drV3gqz
         inbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1fCrFcozyWqlA+LgbhafFfrx1Stwpkt/Qc6xF58W6G0=;
        b=kmWmF8UeegTKOurVBStyX4PE7D8ti4aNgSgVD6L7ES0mu/fj6ImKkLBdYehOGcmpbT
         xW4voii6LnTAeD/Wg6fJ2r21QpP9brLjA0x6u+WA25lC/O9JdN+vGXriGR7vXGK7moLe
         qEhYmTuylHQIP6DfExBmaOWQ7gygOko1TRuliMmQvk97XPXeidQYxCL6tWf7u4EKDmvu
         SCnKdHsf4Ct9SNwaGDcfZqVdNAGFrHMkoAwcwqwv/fdwtS21YdNDzwOTvsHwdNeIn4DR
         SJuWpLV9Nv6IHT44Nb7yUuyrLLpv9mhpVNtCtnZ6do2VjJeuUXK3cRs4ZLdLBE2EMJsa
         T0+w==
X-Gm-Message-State: AOAM5330iqdGGZzyGy5u+4BxZkJUbObysgT5mQ0q0aTkCBuY5rf/XQSS
        FYXgVmNssj+XEqSPe3A90wJxHEUcRZXT6Q==
X-Google-Smtp-Source: ABdhPJwSIhLIqZE3MbvV6xIdQXEJbcVp9jNEQAKNmLIgiC+3cfPHORbdq5xDhB3RrlSCOpd55Xg9Pg==
X-Received: by 2002:aa7:d594:0:b0:410:ef84:f706 with SMTP id r20-20020aa7d594000000b00410ef84f706mr7977810edq.347.1645808214261;
        Fri, 25 Feb 2022 08:56:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k8-20020aa7c388000000b00410ae55f574sm1550255edq.33.2022.02.25.08.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:56:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNdtk-000fHQ-LX;
        Fri, 25 Feb 2022 17:56:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 11/14] bisect: move even the option parsing to
 `bisect--helper`
Date:   Fri, 25 Feb 2022 17:49:26 +0100
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
 <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
 <dc04b06206bbb833ce3a7fa893d724d00fe58a74.1645547423.git.gitgitgadget@gmail.com>
 <220223.86v8x56g7g.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2202251647370.11118@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202251647370.11118@tvgsbejvaqbjf.bet>
Message-ID: <220225.86ilt27uln.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 25 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Wed, 23 Feb 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, Feb 22 2022, Johannes Schindelin via GitGitGadget wrote:
>>
>> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >
>> > On our journey to a fully built-in `git bisect`, this is the
>> > second-to-last step.
>> >
>> > Side note: The `if (!strcmp(...)) ... else if (!strcmp(...)) ... else =
if
>> > (!strcmp(...)) ...` chain seen in this patch was not actually the first
>> > idea how to convert the command modes to sub-commands. Since the
>> > `bisect--helper` command already used the `parse-opions` API with neat=
ly
>> > set-up command modes, naturally the idea was to use `PARSE_OPT_NODASH`
>> > to support proper sub-commands instead. However, the `parse-options` A=
PI
>> > is not set up for that, and even after making that option work with lo=
ng
>> > options, it turned out that `STOP_AT_NON_OPTION` and `KEEP_UNKNOWN`
>> > would have to be used but these options were not designed to work
>> > together. So it would appear as if a lot of work would have to be done
>> > just to be able to use `parse_options()` just to parse the sub-command,
>> > instead of a simple `if...else if` chain, the latter being a
>> > dramatically simpler implementation.
>>
>> As I noted in
>> https://lore.kernel.org/git/220129.86pmobauyt.gmgdl@evledraar.gmail.com/:
>>
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > ---
>> >  builtin/bisect--helper.c | 133 ++++++++++++++++-----------------------
>> >  git-bisect.sh            |  49 +--------------
>> >  2 files changed, 56 insertions(+), 126 deletions(-)
>> >
>> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> > index 5228964937d..ef0b06d594b 100644
>> > --- a/builtin/bisect--helper.c
>> > +++ b/builtin/bisect--helper.c
>> > @@ -20,18 +20,34 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISEC=
T_NAMES")
>> >  static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARE=
NT")
>> >  static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
>> >
>> > -static const char * const git_bisect_helper_usage[] =3D {
>> > -	N_("git bisect--helper --bisect-reset [<commit>]"),
>> > -	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --=
term-bad | --term-new]"),
>> > -	N_("git bisect--helper --bisect-start [--term-{new,bad}=3D<term> --t=
erm-{old,good}=3D<term>]"
>> > -					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] =
[<paths>...]"),
>> > -	N_("git bisect--helper --bisect-next"),
>> > -	N_("git bisect--helper [--bisect-state] (bad|new) [<rev>]"),
>> > -	N_("git bisect--helper [--bisect-state] (good|old) [<rev>...]"),
>> > -	N_("git bisect--helper --bisect-replay <filename>"),
>> > -	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
>> > -	N_("git bisect--helper --bisect-visualize"),
>> > -	N_("git bisect--helper --bisect-run <cmd>..."),
>> > +static const char * const git_bisect_usage[] =3D {
>> > +	N_("git bisect help\n"
>> > +	   "\tprint this long help message."),
>> > +	N_("git bisect start [--term-{new,bad}=3D<term> --term-{old,good}=3D=
<term>]\n"
>> > +	   "\t\t [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [=
<pathspec>...]\n"
>> > +	   "\treset bisect state and start bisection."),
>> > +	N_("git bisect (bad|new) [<rev>]\n"
>> > +	   "\tmark <rev> a known-bad revision/\n"
>> > +	   "\t\ta revision after change in a given property."),
>> > +	N_("git bisect (good|old) [<rev>...]\n"
>> > +	   "\tmark <rev>... known-good revisions/\n"
>> > +	   "\t\trevisions before change in a given property."),
>> > +	N_("git bisect terms [--term-good | --term-bad]\n"
>> > +	   "\tshow the terms used for old and new commits (default: bad, goo=
d)"),
>> > +	N_("git bisect skip [(<rev>|<range>)...]\n"
>> > +	   "\tmark <rev>... untestable revisions."),
>> > +	N_("git bisect next\n"
>> > +	   "\tfind next bisection to test and check it out."),
>> > +	N_("git bisect reset [<commit>]\n"
>> > +	   "\tfinish bisection search and go back to commit."),
>> > +	N_("git bisect (visualize|view)\n"
>> > +	   "\tshow bisect status in gitk."),
>> > +	N_("git bisect replay <logfile>\n"
>> > +	   "\treplay bisection log."),
>> > +	N_("git bisect log\n"
>> > +	   "\tshow bisect log."),
>> > +	N_("git bisect run <cmd>...\n"
>> > +	   "\tuse <cmd>... to automatically bisect."),
>> >  	NULL
>> >  };
>>
>> Even that doesn't explain why this needs to be changed as
>> well.
>
> True. The explanation is easy: I am not in the business of changing the
> usage shown by `git bisect -h`.

You are changing it, here's the diff between "master" and "seen":
=09
	--- b	2022-02-25 17:49:07.264273673 +0100
	+++ a	2022-02-25 17:48:46.076460197 +0100
	@@ -1,31 +1,28 @@
	-usage: git bisect [help|start|bad|good|new|old|terms|skip|next|reset|visu=
alize|view|replay|log|run]
	+usage: git bisect help
	+       	print this long help message.
	+   or: git bisect start [--term-{new,bad}=3D<term> --term-{old,good}=3D<t=
erm>]
	+       		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pat=
hspec>...]
	+       	reset bisect state and start bisection.
	+   or: git bisect (bad|new) [<rev>]
	+       	mark <rev> a known-bad revision/
	+       		a revision after change in a given property.
	+   or: git bisect (good|old) [<rev>...]
	+       	mark <rev>... known-good revisions/
	+       		revisions before change in a given property.
	+   or: git bisect terms [--term-good | --term-bad]
	+       	show the terms used for old and new commits (default: bad, good)
	+   or: git bisect skip [(<rev>|<range>)...]
	+       	mark <rev>... untestable revisions.
	+   or: git bisect next
	+       	find next bisection to test and check it out.
	+   or: git bisect reset [<commit>]
	+       	finish bisection search and go back to commit.
	+   or: git bisect (visualize|view)
	+       	show bisect status in gitk.
	+   or: git bisect replay <logfile>
	+       	replay bisection log.
	+   or: git bisect log
	+       	show bisect log.
	+   or: git bisect run <cmd>...
	+       	use <cmd>... to automatically bisect.
=09=20
	-git bisect help
	-	print this long help message.
	-git bisect start [--term-{new,bad}=3D<term> --term-{old,good}=3D<term>]
	-		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>.=
..]
	-	reset bisect state and start bisection.
	-git bisect (bad|new) [<rev>]
	-	mark <rev> a known-bad revision/
	-		a revision after change in a given property.
	-git bisect (good|old) [<rev>...]
	-	mark <rev>... known-good revisions/
	-		revisions before change in a given property.
	-git bisect terms [--term-good | --term-bad]
	-	show the terms used for old and new commits (default: bad, good)
	-git bisect skip [(<rev>|<range>)...]
	-	mark <rev>... untestable revisions.
	-git bisect next
	-	find next bisection to test and check it out.
	-git bisect reset [<commit>]
	-	finish bisection search and go back to commit.
	-git bisect (visualize|view)
	-	show bisect status in gitk.
	-git bisect replay <logfile>
	-	replay bisection log.
	-git bisect log
	-	show bisect log.
	-git bisect run <cmd>...
	-	use <cmd>... to automatically bisect.
	-
	-Please use "git help bisect" to get the full man page.

I think such changes are fine, but if you don't then actually
parse_options() would make that easier to emit with the "" delimiter,
i.e. to mark up the rest as free-form text, as it is now.

But I don't see why you'd view that as a goal, for the rest of built-in
migrations we've changed this human-readable output in various ways
while we were at it.

>> we no longer understand "git bisect <subcommand> -h", but did before
>> etc.
>
> ... for some definition of "understand" ;-) See for yourself:
>
> 	$ git bisect visualize -h
> 	usage: git bisect--helper --bisect-reset [<commit>]
> 	   or: git bisect--helper --bisect-terms [--term-good | --term-old | --t=
erm-bad | --term-new]
> 	   or: git bisect--helper --bisect-start [--term-{new,bad}=3D<term> --te=
rm-{old,good}=3D<term>] [--no-checkout] [--first-parent] [<bad> [<good>...]=
] [--] [<paths>...]
> 	   or: git bisect--helper --bisect-next
> 	   or: git bisect--helper --bisect-state (bad|new) [<rev>]
> 	   or: git bisect--helper --bisect-state (good|old) [<rev>...]
> 	   or: git bisect--helper --bisect-replay <filename>
> 	   or: git bisect--helper --bisect-skip [(<rev>|<range>)...]
> 	   or: git bisect--helper --bisect-visualize
> 	   or: git bisect--helper --bisect-run <cmd>...
>
> 	    --bisect-reset        reset the bisection state
> 	    --bisect-next-check   check whether bad or good terms exist
> 	    --bisect-terms        print out the bisect terms
> 	    --bisect-start        start the bisect session
> 	    --bisect-next         find the next bisection commit
> 	    --bisect-state        mark the state of ref (or refs)
> 	    --bisect-log          list the bisection steps so far
> 	    --bisect-replay       replay the bisection process from the given fi=
le
> 	    --bisect-skip         skip some commits for checkout
> 	    --bisect-visualize    visualize the bisection
> 	    --bisect-run          use <cmd>... to automatically bisect.
> 	    --no-log              no log for BISECT_WRITE
>
> That's not a helpful usage for `git bisect visualize`. It's better to
> leave it to a future patch for `bisect_visualize()` to handle `-h`.

Yes, it could be better, but with your changes:

    git bisect start -h

Or whatever will start a bisection session.

> In other words, what you point out as a bug is actually fixing one.

...

> I find the other comments on not using the `parse_options()` machinery
> similar, and your feedback seems to flatly dismiss the side note in the
> commit message as irrelevant.
>
> To be clear: I spent a substantial amount of time trying to extend the
> `parse_options()` machinery to support dash-less subcommands. The end
> result was neither elegant nor particularly useful.
>
> So, with all due respect, I disagree with your disagreeing.

Yes I agree that trying to get parse_option() to consider --bisect-reset
implicitly as "reset" is a dead-end.

What I'm pointing out is that we could do it exactly as bisect/stash
etc. do it. I don't see how you ended up concluding that your conversion
needed to do anything different, and failing that that you couldn't use
parse_options() at all. Just use it like those other commands use it.
