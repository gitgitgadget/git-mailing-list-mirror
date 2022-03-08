Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D788C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 08:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbiCHI02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 03:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiCHI01 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 03:26:27 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B23F32C
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 00:25:30 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b24so768207edu.10
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 00:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VuTJld7xgjav/Hoz1q6qWBSEif57ClUOcFu3J8Z+6s8=;
        b=O52jlSVqqIXth/yHsdBqqKBYFJniv0SEJ6zEmY+yHyR4SYPcCtlYJnSWe59Ayt6ARL
         YOR/8vfoDPkgJInLh/NbX3OOxjx62AN05C1M53h1tudiDzC3iyajA3xTfT++RIhZn38q
         +8CNzXd4qtBk3CgeFx6nlPwwHmvUEJg/eWh37ip+fXlvuBK+svUKiodeN63F8yGYKwtS
         WQ0f4oIPWMH7SmBCr5LR8zHKqAjYJCq+n7GLsUndJe+T9EPqBOgXIj7Yxfzv3tWn6LAl
         v5w4Mwr/OvNNS3APxMrp8PfbjStDe2ByS3+dub7MMJQiIVzpWXGDytw2iKvpdBp+awxW
         I5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VuTJld7xgjav/Hoz1q6qWBSEif57ClUOcFu3J8Z+6s8=;
        b=EGSvzPaPtP/jiOVHuMQND+9vUaxaqAjPf5YjuMMeC4IkOfNlq8kr/c5JkfIw6CsR9u
         MSP12gkXAXCJW1hsXWC8nprw/KWMqczNlVQuxDCSLVZWFK6pk3aqa7OIPULupNTGtVzs
         n58F0bijb+Yz+x8QapkOik2t0vfv856GA1INeIBIRvpHG0b2jMo0KLyJVR2uV+/dzxl8
         ObUC/UXtwbHSKsZpqH8oylRsHAtO+yFUqnHOnb61SDYvj9c+0rFA9gKiroMQDaWQ8Tdo
         5j6Lvr3ThG6xpR75FOr1iPbsnepq1jyVNJKGtJSg692D60Budk6YyE86oIhlhE1RdR4X
         K87g==
X-Gm-Message-State: AOAM530Qs/2GQl9STpBNhatSU2cqv6ECVMwn8OBQbdWp8PLrxcoBsdDT
        hfHun6Q9btz5B00mgoXtEEM7SFcq8UGs5ZT6zMc=
X-Google-Smtp-Source: ABdhPJyrF3YFJKY1UMJVVTfYI5Pu74ZUEa71mbMjJdFT4xKVg7UlmUZR0yyiDX0T+rRyqgKmS6LTKglL29fvISUq/pM=
X-Received: by 2002:a05:6402:1385:b0:413:2bc6:4400 with SMTP id
 b5-20020a056402138500b004132bc64400mr15168443edv.94.1646727928604; Tue, 08
 Mar 2022 00:25:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet> <CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2203071718090.11118@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2203071718090.11118@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Mar 2022 00:25:16 -0800
Message-ID: <CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com>
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

On Mon, Mar 7, 2022 at 8:27 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Fri, 25 Feb 2022, Elijah Newren wrote:
>
> > On Fri, Feb 25, 2022 at 8:31 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Tue, 22 Feb 2022, Elijah Newren wrote:
> > >
> > > > On Mon, Feb 21, 2022 at 2:46 AM Johannes Schindelin
> > > > <Johannes.Schindelin@gmx.de> wrote:
> > > > >
> > > > > Concretely: while I am not currently aware of any web UI that allows
> > > > > to resolve simple rename/rename conflicts, it is easily conceivable
> > > > > how to implement such a thing. When that happens, we will need to be
> > > > > able to teach the server-side code to discern between the cases that
> > > > > can be handled in the web UI (trivial merge conflicts, trivial
> > > > > rename/rename conflicts) as compared to scenarios where the conflicts
> > > > > are just too complex.
> > > >
> > > > Um, I'm really worried about attempting to make the conflict notices
> > > > machine parseable.  I don't like that idea at all, and I even tried to
> > > > rule that out already with my wording:
> > > > """
> > > > In all cases, the
> > > > <Informational messages> section has the necessary info, though it is
> > > > not designed to be machine parseable.
> > > > """
> > > > though maybe I should have been even more explicit.  The restrictions
> > > > that those messages be stable is too rigid, I think.  I also think
> > > > they're a poor way to communicate information to a higher level tool.
> > > > I would much rather us add some kind of additional return data
> > > > structures from merge ort and use them if we want extra info.
> > >
> > > Okay.
> > >
> > > I thought that we could keep the `CONFLICT (<type>)` constant enough to
> > > serve as such a machine-parseable thing.
> >
> > That _probably_ is, but I thought you wanted to parse all N paths
> > embedded in the message after that part as well?
>
> Actually, no, sorry for being unclear. My main aim with the
> machine-parseable messages was to detect whether a given failed merge
> contains _only_ conflicts of the sort that a particular UI can handle.

...and in order to do that, you'd need to parse all the filenames to
determine whether files were involved in multiple conflict types,
since you earlier suggested you would just bail on such conflicts (at
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet/).
In particular, I think the "mod6" and "rrdd" and "rad" cases kind of
triggered those comments, and rename/rename is involved in two of
those.

Further, even if you could assume there'd only be simple conflicts
such as the simple rename/rename case, you'd still need the files so
that you know _which_ of the modes/oids in the <Conflicted file info>
section relate to the message you are looking at.  (As mentioned
previously, sorting the <Conflicted file info> to attempt to put them
together is not feasible and is a no-go.)

> > > And then presenting
> > > `<path>NUL<message>NUL` could have served my use case well...
> >
> > Would it?  Wouldn't you need something more like
> >
> > <number-of-paths>NUL<path1>NUL<path2>NUL<pathN>NUL<stable-short-type-description>NUL<message>NUL
> >  ?
>
> Probably, you're right.
>
> > I mean, if rename/rename is what you want to handle, there are three
> > paths in that message.  And you need to know all three paths in order
> > to combine the relevant parts of the <Conflicted File Info> section
> > together.
> >
> > (Also, while we're at it, I decided to throw a stable short-type
> > description string (e.g. "CONFLICT (rename/rename)") in there, which
> > will _probably_ be the first part of the message string but still
> > allow us to change the message string later if we want.)
>
> Yes, I very much like that idea to keep the prefix in a format that we can
> guarantee to be stable enough for applications (or server backends) to
> rely on.

Um, I explicitly avoided saying the prefix would be stable by
introducing a separate short string just so that we could change the
prefix later if wanted.  The short string is _probably_ the current
prefix or something close to it, but that stable string wouldn't
necessarily remain the prefix of the message string, since the entire
message string would be allowed to change.

> > Also, we'd want those parsing this information to keep in mind that:
> >   * Any given conflict can affect multiple paths
> >   * Any path can be part of multiple conflicts
> >   * (The above two items imply a potentially many-to-many relationship
> > between paths and conflicts)
> >   * Paths listed in these logical conflicts may not correspond to a
> > file in the index (they could be a directory, or file that was in a
> > previous version)
> >   * Some of these "logical conflicts" are not actually conflicts but
> > just notices (e.g. "auto-merging" or "submodule updated" or "WARNING"
> > or "<submodules are weird>" messages)
> >
> > and we'd have to do some work to make sure the paths in the given
> > messages lined up with the files actually recorded in the index (e.g.
> > with distinct types we rename both files to avoid the collision, but
> > print the conflict notice for the original path rather than the new
> > paths)
> >
> > [...]
> > > > But I'm going to reserve the right in merge-ort to modify, add, or
> > > > delete any of those messages passed to path_msg(), which might wreak
> > > > havoc on your attempts to parse those strings.  I think they're a bad
> > > > form for communicating information to a script or program, and trying
> > > > to transform them into such risks making them suboptimal at
> > > > communicating info to humans.  These messages should optimize the
> > > > latter, and if we want something for the former, it should probably be
> > > > a new independent bit of info.
> > >
> > > Makes sense.
> > >
> > > So we need something in addition to those messages.
> >
> > Yes.  Does the proposal above sound like it'd cover your needs?  If
> > so, we'd probably need to go through all the callers to path_msg() and
> > either add an immediate call to another function immediately
> > afterwards that stores this additional information or somehow change
> > the path_msg() call itself to somehow take an additional arbitrary
> > list of arguments representing the paths and short-desc we want to
> > store somewhere.
>
> Yes, you're right, the proper thing to do is to go through the callers to
> `path_msg()` so that we can provide that stable output you proposed. A
> couple of thoughts about this:
>
> * These are not informal messages, i.e. I think we would need another flag
>   that would then trigger another double-`NUL`-separated section to be
>   shown, probably between the conflicted file info and the informational
>   messages.

Why would that be a separate section, though?  While we don't want
machines parsing the informal messages and trying to determine the
components of that message, they definitely should be able to tell
which informal messages are associated with which paths (otherwise how
can you group the <Conflict message info> as per your needs and how do
you know which message to show the user when dealing with that
particular conflict?).  That requirement suggests the informal
messages should be part of the same section.  Thus my suggestion to
just make it be the <message> part at the end of my earlier suggestion
of

<number-of-paths>NUL<path1>NUL<path2>NUL<pathN>NUL<stable-short-type-description>NUL<message>NUL

> * Instead of _adding_ the calls, we could look into refactoring the
>   existing `path_msg()` calls, introducing yet another function that would
>   call `path_msg()` but also optionally generate that machine-parseable
>   conflict info.

So of the two alternatives I suggested above, it sounds like you're in
favor of the "or somehow change the path_msg() call itself to somehow
take an additional arbitrary list of arguments representing the paths
and short-desc we want to store somewhere" option I suggested.  I
think I prefer that one too.

> * None of this needs to hold up `en/merge-tree`. I am sorry that I am the
>   blocker (unintentionally so, I guarantee you that!).

Sometimes I find it frustrating that changes don't merge down for
months, particularly when the topic was already finished weeks and
weeks (if not months) ago and/or when there's a follow-on series
depending on it.  But in this case I have no follow-on series ready to
send, and this topic has been under (very!) active discussion
essentially the whole time.  And, perhaps even more importantly, I'd
like to avoid solidifying the "machine parseable output format"
prematurely and making it harder to work around later.  I think
addressing this issue you bring up requires fundamentally redoing the
informational messages section as per my proposal, and it makes me
wonder what should even be shown without the -z option (thoughts
welcome).

So, this is one series where even if everyone else says to merge it
already, I'd like to wait a bit longer on it until I feel confident we
have a solution that handles at least the current usecases.
