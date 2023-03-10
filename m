Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E5C74A4B
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 22:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCJWKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 17:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjCJWKL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 17:10:11 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8D46A438
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 14:09:55 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-540cb2fb5b9so19867957b3.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 14:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678486194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mejVJczwKtMOP/hqTX7+Li3OuuKBTcWxZ5Sijvztk9Y=;
        b=Cuy/ACe3ekOIfs7na8QCXkWnu30bEpuriZ+BUSX8/kFwlOkE8vEokl47Wx73bC9fiY
         +298sDcBx/j4PQd/ryeTl+gfA7MJMh3WfjjcT9peTaeabRxJKiGV1s6T0R/EiF9cHCoA
         rJfKPa/5toFxRUj6Zv0ccVRj4vP7wQ5GZDyzUUBnTEzYoCKzRvfuXROZyg9n3isnjcvY
         nAUlxl4EnBCZPxm0YCo3WUG2a3vlYQgfM9y8FnkwxztbdrpVzuMk09CEY7bjDb61dNXx
         efqyRtRtJg+7cUt1qXhTeHvlMFdkSUaoZsfMhl+mif3+EdZ/FhYTuGBC3lOaNQZyVJoW
         g1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678486194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mejVJczwKtMOP/hqTX7+Li3OuuKBTcWxZ5Sijvztk9Y=;
        b=Cizi3QYNRgEVCeNCGuyMPCRW6dfh9bQqwN0RMfB6eKW+sUiF/e4JrLHterD5FIdQ3F
         dqaaEflRYZ6zU5z61oqqCRAXsSrYFhOZMYu+QgiQBvAUrOQnyCwAw5RI0JnOcI0RGjBT
         39gueGOt2Lc/6wxYyGWa2LoOEtsvSjFMLPSZHhMi5Fw5gr2xMLvEqOuM6xwBou80zqTI
         jglKYiMC8dTtUdBbIPAOmk4fzI3y5ZFHfxCo/Xqj9/ki986pEro/aTp3+Ie4XPMoTAaz
         GgaZ2yAibDQPqCjF6TOGyYKvvyDPgYgBQroQyOy/V88ISa2SrbfxQIkH9RIXjJJI/p2L
         MB6A==
X-Gm-Message-State: AO0yUKW4jQlL1S/Fyu7H5NCveY/+oStKT7DopQtVsNBKihiDIYuHEuZm
        5AFQch2CArYW+sBiLAu/OcpghlNyfkaEoh0h5Y5a4YrsTXY=
X-Google-Smtp-Source: AK7set+v8rR5frUHsPkhTVFp+YBPLEZ7MPoSeXAjU2eF5RbHFdEw8Kr0bZ0kgNK+fCZY/5nyL3qE8bmAwSCfZXvJKSI=
X-Received: by 2002:a81:ac21:0:b0:535:cdde:9a63 with SMTP id
 k33-20020a81ac21000000b00535cdde9a63mr17589009ywh.7.1678486194397; Fri, 10
 Mar 2023 14:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20230309220405.219212-1-anarcat@debian.org> <CAMP44s2=qzmF1Odc_auCaKQmTBYD53YYtaJv_LGwvoFDmTxPSA@mail.gmail.com>
 <87356ctvta.fsf@angela.anarc.at>
In-Reply-To: <87356ctvta.fsf@angela.anarc.at>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 10 Mar 2023 16:09:43 -0600
Message-ID: <CAMP44s30GBC7PFovzgaORMLLGYW=1mFVG4WH-dUfUW5-1sMd1Q@mail.gmail.com>
Subject: Re: [RFC PATCH] hooks--pre-push.sample: identify branch point
To:     =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2023 at 10:28=E2=80=AFAM Antoine Beaupr=C3=A9 <anarcat@debi=
an.org> wrote:
>
> On 2023-03-09 17:22:55, Felipe Contreras wrote:
> > Hi Antoine,
> >
> > On Thu, Mar 9, 2023 at 4:34=E2=80=AFPM Antoine Beaupr=C3=A9 <anarcat@de=
bian.org> wrote:
> >
> >> https://stackoverflow.com/a/71193866/1174784
> >>
> >> There are currently a whopping twenty-five answers to that question in
> >> that thread, and I'm hoping the community here will have a more
> >> definitive answer to this question. I have picked the answer that uses
> >> the least possible external commands, but it still uses a `tail -1`
> >> which I'm somewhat unhappy about. I have thought of using
> >> `--max-count` for this instead, but I understand that probably does
> >> the equivalent of a `head -n` *and* it's applied before `--reverse`,
> >> so there's not other way to do this.
> >
> > I spent an inordinate amount of time trying to answer that question a
> > decade ago, and my conclusion after trying every possible combination
> > is that it's simply not possible. Every solution at the end of the day
> > will be a hack that can be broken with a corner case. It has already
> > been discussed in this mailing list [1], and nobody found a solution.
>
> That's what I have gathered from reading through that Stack Overflow
> thread as well.
>
> > That's why I wrote a patch to implement a branch@{tail} helper to show
> > an auxiliary ref to the beginning of the branch. I don't think I ever
> > sent it to the mailing list, as my patches are rarely merged, but I'm
> > sure I have it somewhere.
>
> That would be interesting for the world to see, I bet, if only as a
> future reference to avoid other people trying to bang their head on the
> problem the same way. :)

OK, I've rebased my patches on top of the current master (which wasn't
easy) and sent them to the mailing list [1]. They are pretty hacky,
but they show what an actual solution could look like.

> > The other solution I thought of was adding an update-branch hook that
> > could be run every time a branch is updated, and then the hook would
> > update the branch tail reference [2]. As expected, that patch wasn't
> > merged either.
>
> That seems like a major change in workflow though, adding basically a
> new ref for each branch, right?

There's no change in the workflow, the user keeps typing the same
commands, there's just extra information.

But yeah, every branch now has two refs.

> > It's interesting how we keep coming back to the same problems; right
> > now there's a discussion in the git-users mailing list precisely about
> > the same topic: how to find the branch point, in particular so `git
> > name-rev` shows the correct branch a commit belongs to (which is
> > otherwise just a bad guess).
>
> Well, it's a need people certainly seem to have. :)
>
> I feel we are letting perfection be the enemy of good here. No, there
> are no solutions that work for the general case, you always find a
> corner case that breaks it. But what if we could have a simple solution
> that works for *most* cases and then *fails* gracefully for the corner
> cases?

I did propose such a solution, I wrote extensive tests to make sure it
worked properly, but it was largely ignored [2].

The solution with --exclude-first-parent-only fails my tests in a very
complex case:

   X (master)
    \
     A (topic)

Sure, it's probably easy to fix, but the point is that a reliable and
robust solution everyone agrees with doesn't exist.

> In the case of the pre-push hook, specifically, we don't absolutely need
> something completely rock solid; if your branches are a mess of merges
> and cherry-picks and cross merges, yes, it might get confused but it's
> not like it's going to lose a commit or something. The worse case is
> that it's going to miss *checking* a commit and for this case it's not
> satisfying, but it's also not data loss.

But I bet you want the simple case of a sequence of commits with no
merges to properly detect something.

> > FWIW my motivation at the time was to prove Mercurial users wrong
> > regarding features that they have and Git doesn't, I contended that
> > Mercurial named branches (aka commit labels) were not necessary, and
> > everything they achieved could be achieved in Git through different
> > means. That turned out to be untrue, as there is one thing Mercurial
> > can do that Git can't: show the precise point a branch started from.
>
> I have given up on Mercurial a long, long time ago. It's extremely rare
> that I find myself in such a situation and typically, there various
> hacks that answer the need without going into too much complexity.
>
> The only reason I raise the issue here is because I wasn't satisfied
> hardcoding "master" (or main, for that matter) in the hook because I
> wanted a more generic answer. I suspect many people could be perfectly
> fine with hardcoding that in their hook or, failing that, with the
> incomplete heuristic I am proposing.
>
> Or they could even have a per-branch .git/config entry to map the branch
> to an upstream branch, and *that* could even "default" to "main" or
> whatever that setting is called now. :)

Sounds like you are talking about the upstream tracking branch [3].
Are you familiar with that?

Cheers.

[1] https://lore.kernel.org/git/20230310214515.39154-1-felipe.contreras@gma=
il.com/
[2] https://stackoverflow.com/a/10821591/10474
[3] https://felipec.wordpress.com/2013/09/01/advanced-git-concepts-the-upst=
ream-tracking-branch/

--=20
Felipe Contreras
