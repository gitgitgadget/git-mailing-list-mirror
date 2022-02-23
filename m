Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16573C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 02:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbiBWCP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 21:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbiBWCPz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 21:15:55 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77193B57A
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 18:15:28 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id bq11so20166031edb.2
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 18:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpU9ATNsb0z1CTDO7tBqGQew1IFt0D6itoAZ5vxyr6A=;
        b=Tpk1IKKAJrKivBCrTWGTb2YH+JobskysWW/OlxhltKywcUmh3e7XBjMIuUj6xMLgVC
         I6T1H6Cvg/u70qhuNhHs+toZ+DPjpZRLf+YGw/dIINFyS78wkxzDIZ7m9FJyVYik9Tn4
         dcW9WgO/7f298CPkCzWtZRU0RWElV5UN5dxeh8N2/R6+YqiOiH5N7ze4uV0MJXURVwuX
         2d2enagPFVxVwrb/a+aNQhv/dW7wos2zCtbrqX6xvnWakQDa58KEnHEEPdEDTmOL/8t7
         xTX+dWrr9/M5lKhk+xwJ/Y2YV8SpfEOQldnmopQbJsYGBhhA6jU9rHU7ax1q2h7m9Y/4
         RphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpU9ATNsb0z1CTDO7tBqGQew1IFt0D6itoAZ5vxyr6A=;
        b=w2ZE1zqU737X9brtDWE5UCUojx2ZnYrwqwQbuEWZQLHZ7qd5AK4TX09hqHaxZPrxWw
         weFQjBwJ5bd1mKBMHHGsREzhAjNzhLP4vlwNgcfHeDY7/owO6ZmxOQMTOd3DkFhxWtxm
         OmX/GsQ/0cGQTkeT4X14/uPAj4HOibGYK18er9SVJwm2jZyZjsNKAQVp+arv6cYtGDHk
         FfYd0TENbyugJhgZJQHVCam2rmYDFz6Dj+6aI+N/ZPeOZHbdRFwgCQ6qOXrRe+TAQM//
         ZtSxQSB5Fu978+qlloVob0EVABSSMR0MQbh4GDGb46oyRyyrkGO99IHdzdQ+ts+VP16f
         n0WQ==
X-Gm-Message-State: AOAM533ccZPl68k3yFo6sW4iSbOVn0mzar0CqBJ5Cy/g7hOgiD7JI9qp
        bP3Qr0wUL4NGa+nHCVEJqWZdd1IhOI7YewLzpgg=
X-Google-Smtp-Source: ABdhPJw/SHh4du/I1u4Lf1bMqve/AKEHVmuVadPkXZx+zVa/pab6hsjEtXgJsuibgtqLbJXm07YIRbxGV8Yzxa5t9ew=
X-Received: by 2002:aa7:c04e:0:b0:400:4daf:bab1 with SMTP id
 k14-20020aa7c04e000000b004004dafbab1mr29204165edo.101.1645582527251; Tue, 22
 Feb 2022 18:15:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Feb 2022 18:15:15 -0800
Message-ID: <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 2:46 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Fri, 4 Feb 2022, Elijah Newren wrote:
>
> > On Fri, Feb 4, 2022 at 3:10 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Sat, 29 Jan 2022, Elijah Newren wrote:
[...]
> > I've thought about this problem long and hard before (in part because
> > of some conversations I had with Edward Thompson about libgit2 and
>
> Not a big deal for _me_, but I seem to remember that Ed cared a lot about
> having no p in their surname ;-)

Eek!  My apologies to Ed; I'll try to remember and do better.

> > merging at Git Merge 2020).  It wasn't at all clear to me that libgit2
> > had considered anything beyond simple rename cases.  The only rules I
> > ever figured out that made sense to me was "group the stages by target
> > filename rather than by logical conflict" (so we get `ls -files -u`
> > populated) and print a meant-for-human message for each logical
> > conflict (found in the <Informational Messages> section for
> > merge-tree), and make NO attempt to connect stages by conflict type.
> >
> > I'm sure that's not what you wanted to hear, and maybe doesn't even
> > play nicely with your design.  But short of ignoring the edge and
> > corner cases, I don't see how to solve that problem.  If you do just
> > want to ignore edge and corner cases, then just ignore the
> > rename/rename case you brought up in the first place and just use
> > `ls-files -u`-type output as-is within your design.  If you don't want
> > to ignore edge cases and want something that works with a specific
> > design that somehow groups conflicted file stages by conflict type,
> > then we're going to have to dig into all these questions above and do
> > some big replumbing within merge-ort.
>
> There is sometimes a big difference between what I want to hear and what I
> need to hear. Thank you for providing so many details that I needed to
> hear.
>
> So let's take a step back and look at my goal here, as in: the
> over-arching goal: to use merge-ort on the server side.
>
> From what you said above, it becomes very clear to me that there is very
> little chance to resolve such conflicts on the server side.

No, it's still resolvable on the server side.  It's just that attempts
to break up the information into individual logical conflicts is
problematic; if you provide _all_ the informational conflict messages
to the user, and iterate through the paths with conflicts, then things
are fine.  It's only when you attempt to find "the relevant subset"
that things become hard.  Of course, providing it all at once might be
a UI that you hate (perhaps because it's too much like how the command
line behaves...)

> For example, if a topic branch renames a file differently than the main
> branch, there is a really good chance that the user tasked with merging
> the topic branch will have to do a whole lot more than just click a few
> buttons to perform that task. There might very well be the need to edit
> files that do not contain merge conflict markers (I like to call those
> cases "non-semantic merge conflicts"), and almost certainly local testing
> will be necessary.

Sidenote: Do you lump in binary merge conflicts with "non-semantic
merge conflicts"?  You would by your definition, but I'm not sure it
matches.

I tend to call things either content-based conflicts or path-based
conflicts, where content-based usually means textual-based but also
includes merges of binaries.

> So I guess the best we can do in those complicated cases is to give a
> comprehensive overview of the problems in the web UI, with the note that
> this merge conflict has to be resolved on the local side.
>
> Which brings me to the next concern: since `merge-tree` is a low-level
> tool meant to be called by programs rather than humans, we need to make
> sure that those messages remain machine-parseable, even if they contain
> file names.
>
> Concretely: while I am not currently aware of any web UI that allows to
> resolve simple rename/rename conflicts, it is easily conceivable how to
> implement such a thing. When that happens, we will need to be able to
> teach the server-side code to discern between the cases that can be
> handled in the web UI (trivial merge conflicts, trivial rename/rename
> conflicts) as compared to scenarios where the conflicts are just too
> complex.

Um, I'm really worried about attempting to make the conflict notices
machine parseable.  I don't like that idea at all, and I even tried to
rule that out already with my wording:
"""
In all cases, the
<Informational messages> section has the necessary info, though it is
not designed to be machine parseable.
"""
though maybe I should have been even more explicit.  The restrictions
that those messages be stable is too rigid, I think.  I also think
they're a poor way to communicate information to a higher level tool.
I would much rather us add some kind of additional return data
structures from merge ort and use them if we want extra info.

> Here's an excerpt from t4301:
>
> -- snip --
> Auto-merging greeting
> CONFLICT (content): Merge conflict in greeting
> Auto-merging numbers
> CONFLICT (file/directory): directory in the way of whatever from side1; moving it to whatever~side1 instead.
> CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified in side1.  Version side1 of whatever~side1 left in tree.
> -- snap --
>
> This is the complete set of messages provided in the `test conflict
> notices and such` test case.
>
> I immediately notice that every line contains at least one file name.
> Looking at https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1899, it
> does not seem as if the file names are quoted:
>
>                 path_msg(opt, path, 1, _("Auto-merging %s"), path);
>
> (where `path` is used verbatim in a call to `merge_3way()` before that,
> i.e. it must not have been quoted)
>
> I would like to register a wish to ensure that file names with special
> characters (such as most notably line-feed characters) are quoted in these
> messages, so that a simple server-side parser can handle messages starting
> with `Auto-merging` and with `CONFLICT (content): Merge conflict in `, and
> "throw the hands up in the air" if any other message prefix is seen.
>
> Do you think we can switch to `sq_quote_buf_pretty()` for these messages?
> For the `Auto-merging` one, it would be trivial, but I fear that we will
> have to work a bit on the `path_msg()` function
> (https://github.com/git/git/blob/v2.35.1/merge-ort.c#L630-L649) because it
> accepts a variable list of arguments without any clue whether the
> arguments refer to paths or not. (And I would be loathe to switch _all_
> callers to do the quoting themselves.)
>
> I see 28 calls to that function, and at least a couple that pass not only
> a path but also an OID (e.g.
> https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1611-L1613).
>
> We could of course be sloppy and pass even OIDs through
> `sq_quote_buf_pretty()` in `path_msg()`, knowing that there won't be any
> special characters in them, but it gets more complicated e.g. in
> https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1648-L1651, where we
> pass an `strbuf` that contains a somewhat free-form commit message.
>
> I guess we could still pass those through `sq_quote_buf_pretty()`, even if
> they are not paths, to ensure that there are no special characters in the
> machine-parseable lines.
>
> What do you think?

Switching to single quoting paths as a matter of style might make
sense, but only if we go through and change every caller to do so so
that we can make sure it applies to all paths.  And only paths and not
OIDs.

But I'm going to reserve the right in merge-ort to modify, add, or
delete any of those messages passed to path_msg(), which might wreak
havoc on your attempts to parse those strings.  I think they're a bad
form for communicating information to a script or program, and trying
to transform them into such risks making them suboptimal at
communicating info to humans.  These messages should optimize the
latter, and if we want something for the former, it should probably be
a new independent bit of info.
