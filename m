Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472E0C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 00:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1114C613CA
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 00:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241638AbhDFAfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 20:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbhDFAfn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 20:35:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E4FC06174A
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 17:35:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o126so20051701lfa.0
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 17:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GRs4Ku/zJN96RhXUy+JNgl1tY/3lbCOFSGW9U0jdNlY=;
        b=mY5Eq1MuW+RzrYTAHo50yPlrc5oyl5msFx4rN3zpagfHC6XhYtYKxJ613TwMACiXqR
         NiCiCnLi4M3n3CyUP+R6xR9NTqX5OdOSf+p+uKDb9N6MhDvzMqJcOPPxazY14f+indQJ
         bj9Mq2mp4rnCxeAwN4t9YaWV5KTTfEarAuNtZ3nktaemp4KyLVTosceh6xL8x0uWkarN
         l+gOcy7qSuGktbXIzl8/L7bfuH61ajFXuFikiUISqe2QhxS2qLR7d6Hjt0sYaL8acmQJ
         rdWdKy+JeSjQrlnT3P0IlI1UkIJXnS7AFWIGpY5o6qvIAyDHJLzGReP0wqmqg3gOF8Lk
         ANOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GRs4Ku/zJN96RhXUy+JNgl1tY/3lbCOFSGW9U0jdNlY=;
        b=nxO612P9itKihHemMygJAxvSb74qoR0Wpm4+urgbrOzerbQqDGv1q09z17BgR1TjI3
         GbAW3Hz3FXcg2NkwgGE76whAF2pd5MzjrqRhaC/yo1zDDU/AXYMSfuY4Hd/K3ifVJorU
         19/RsFHlfU7oi6g3oOdfZBEHqfKzFnQBv7Sl1Vb/zfWauIF9w6HGw+bgbSSk0MuUmKfB
         qq/bGrkXbdvkQAy/yuItWbjWSHlsTdtTpADm/F4AJ5iONjiD7+wuOMuLvpVeOlQvrdzv
         BGg/ZiG+rQg19cXml/S1FPI580oJGoP7iSOUNX5aKtgtnvgl8pCHygcJNKo1izCRSi32
         BuKQ==
X-Gm-Message-State: AOAM5327Jr5eDWnaKQRCPnArp5ANe30IF4Na5T7asyllYtPn7kGMx0bW
        L8RD4Jn2uG1t8wmtRSLV3wY3j3Ucoij2JT/OINhETPZJo2HZbg==
X-Google-Smtp-Source: ABdhPJwZUPNrnxuIl13xSO2funastmBgj0jCtEVnrvc8cFcFiRr7rnaqSMVThYfWcsOEnPFzHFgbTgmgSvqGbY0WKY4=
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr19597508lfq.52.1617669333654;
 Mon, 05 Apr 2021 17:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com> <87im5nzbe6.fsf@evledraar.gmail.com>
In-Reply-To: <87im5nzbe6.fsf@evledraar.gmail.com>
From:   Albert Cui <albertqcui@gmail.com>
Date:   Mon, 5 Apr 2021 17:35:22 -0700
Message-ID: <CAMbkP-SX2PvjWaNGfO4YUVaWHhAr_KHb170sb_pp8_CiSydQFg@mail.gmail.com>
Subject: Re: [PATCH] hooks: propose repository owner configured hooks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 19, 2021 at 3:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Mar 18 2021, Albert Cui via GitGitGadget wrote:
>
> > We propose adding native Git functionality to allow project maintainers=
 to
> > specify hooks that a user ought to install and utilize in their develop=
ment
> > workflows. This patch documents the requirements we propose for this fe=
ature
> > as well as a design sketch for implementation.
>
> I like this goal. It's something I proposed (off-list) before and did a
> small write-up of here:
> https://lore.kernel.org/git/87zi6eakkt.fsf@evledraar.gmail.com/
>
> As far as I recall the response in the room at the time was the expected
> combination of "sure that would be neat" and "let's see the
> patches". I.e. I don't think there's hard objections to the existence of
> such a facility, but of course the devel is in the details, and
> obviously I never followed-up with actually trying to implement it.
>
> With config-based hooks this'll be much easier for the hook case, and
> I've tried to help that along[A]. I'd be interested in reviewing any
> effort in this area as well. The ".githooks/*" case in that proposal
> goes away with config-based hooks (since they wouldn't be special
> anymore, just config).
>

Thanks for the context and the support. Agreed, I think this is a
natural evolution of config-based hooks.

[...]
> > +* As part of the fetch subcommand, Git prompts users to install the co=
nfigs
> > +contained there.
> > +
> > +    ** User responses to that prompt could be "sticky" - e.g. a user c=
ould reply
> > +    "no (this time)", "no (never)", "yes (this time)", or "yes (always=
)".
> > +    Always/never indicate that the user trusts the remote this config =
is coming
> > +    from, and should not apply to configs fetched from other remotes.
>
> As noted in the proposal I linked I think anyone thinking about this
> would do well to examine the trade-off Emacs's implementation of this
> uses, since it manages to safely open arbitrary files that'll
> potentially run arbitrary code on-open, but only if the user opts-in.
>

In [0], I proposed only allowing pre-clone opt-in to suggested hooks
if allowlisted in the config for the given remote, which seems similar
to your previous proposal. Extending this idea to any config settings
seems very reasonable. I'd love other people's thoughts about this.

In your proposal, you wrote:

> It would work really well with includeIf, e.g. I could clone all my work =
repos to a "safe" area in ~/work which is allowed to set more options, e.g.=
 aliases.

It seems much safer to do this for a given remote, opposed to a local
file path, no?

> > +Later, we might want to do this before the initial clone is performed;=
 that
> > +workflow looks like:
> > +
> > +* During clone, perform ls-refs as normal
> > +
> > +* If the server has a "magic" config branch, fetch only that config br=
anch.
>
> ...the reason for the magic branch is this before-clone use-case?
>
> Unless there's a really strong use-case for that I'd think the
> per-branch .gitconfig would be a better trade-off, but even then there
> would be ways to make that work obviously in the many-many case, and
> still e.g. have a branch advertise a config blob for its "main" branch
> as a special case or something.
>
> I also suspect an unstated constraint of having this in a magic branch
> is the limitation of some git hosting provider's ACL
> implementations. More on that later...
>

Mentioned in [0], the primary motivation for a magic config branch
that lived outside of the worktree was "since the configuration is
separate from the code base, it allows you to go back in history or to
older branches while preserving "improvements" to the hooks
configuration e.g. maybe the project has shifted to using a newer
version of a linter."

[...]
> > +Future Work
> > +~~~~~~~~~~~
> > +
> > +* Extending this to allow repository owners to specify specific config=
urations
> > +in general e.g. this repository should use partial-clone with these pa=
rameters.
>
> I don't see why such a proposal should narrowly confine itself to hooks.
>
> Once we have config-based hooks then hooks are just configuration.
>
> If we're going to pick up arbitrary configuration from remotes/repos on
> request then we'd be starting with the most dangerous configuration.
>

Summarizing from [0]: Based on this feedback, I'm hearing "we should
have a design for suggested configuration in general," but I don't
think that necessitates that we should pursue generic configuration
before hooks configuration.

> I think a better way to start such an effort incrementally would be:
>
> 1. Audit git's config parser for the safety of parsing arbitrary config,
>    we parse .gitmodules now, do we feel it's safe enough to parse
>    arbitrary config (probably, but worth checking).
>
> 2. Add reflection to git's own config variables. Right now we have this
>    in the binary generated via a grep from the documentation. Similar to
>    Emacs's implementation we should/could categorize all our known
>    config variables by safety.
>

To clarify, are you saying, today, git's config variables are pulled
from the documentation? I.e. the documentation is the source of truth
for what config variables are supported? o.0

>    Hooks are the least safe, something like a diff.context=3DN setting th=
e
>    repo wants to suggest a -U<n> setting much safer (just tweaking our
>    existing diff algorithm) etc. But even in those cases we'd want to
>    proceed slowly, e.g. is that config parsing for that -U<n> defensive
>    enough to be safe for arbitrary data?
>

To clarify, this proposal is just to set the hooks config that
config-based hooks enabled e.g. running `git config --add
hook.pre-commit.command pylint` on behalf of the user, so I'm not sure
what "arbitrary data" you're referring to. At least, any problems I'd
think we'd already address with config-based hooks.

> 3. Users should be able to e.g. configure "yes, for any repo I clone
>    they can tweak 'safe'" variables. This would reduce user dialog
>    fatigue, and thus increase safety. I.e. a repo who wants to set a
>    thing like hooks would stand out, but something that e.g. wants to
>    change the diff order would pass on existing global configuration.
>
> 4. Smarter ACL that magic remote+magic branch: It seems like an obvious
>    thing to me to want that if I clone e.g. a random clone of git.git
>    that I'd want to setup config for it IFF the .gitconfig in it is
>    reachable from a tag GPG signed by <approved key>.
>
>    Git's a distributed system, so while I don't think it's bad to have
>    some feature like "I always trust config from this remote" (e.g. a
>    corporate environment where you know its .gitconfig is
>    guarded/audited) we should think about more distributed-friendly
>    solutions first and if possible guide users towards those.

This seems like an OK alternative to allow-listing based on remote,
but are you expecting users to add a GPG key to their .gitconfig?
Remote URLs seem much more user friendly (think IP address vs URL).

[0]: https://lore.kernel.org/git/CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9k=
J_oWO__qw@mail.gmail.com/
