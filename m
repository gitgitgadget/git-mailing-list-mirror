Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F272C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 03:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiKSDNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiKSDNN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 22:13:13 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7016B971D
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 19:13:11 -0800 (PST)
Date:   Sat, 19 Nov 2022 03:13:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1668827590; x=1669086790;
        bh=WmpQh6Gi4tIuadajBcst/K1i/+NlPVDD1CtB9q/u21M=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=v8oEy5lyZ8+SQV1qWi//EjjYkBGaG/zUIWI5QdyQMvulUr/g6M5lvfkaN+XBM5cGL
         wUY6dEUMNHrNJFekyl2wRXlALsuy7cCUErlKkzj5qKyX4rd4BGZMXmsCVhfIlIbJvo
         yeo+KoIRvRzRwzu81RzHHRLpCsC2PdFhmRoH7WQCzbHH2EGIC893wx2YMgOR/9OJqJ
         iLuh7Ibfy1YXYkZbNY1vmd0/31DWKFiCaabg4vJc9x4XRv53A+qapkLiCDAYLDzKI0
         q75Euzr4WmpEBMy9UL+e5ZcxjTHpo5IcFoR+8lo0tN0rHJp05dYVOb2KVpEgLsH9HT
         ecXnMBh3glM8A==
To:     Eric Sunshine <sunshine@sunshineco.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] worktree add: add --orphan flag
Message-ID: <20221119031254.zewmoihuzjsmtcpd@phi>
In-Reply-To: <CAPig+cQiyd9yGE_XpPZmzLQnNDMypnrEgkV7nqRZZn3j6E0APQ@mail.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221110233137.10414-3-jacobabel@nullpo.dev> <221115.86iljfkjjo.gmgdl@evledraar.gmail.com> <CAPig+cRuJVN2Hc-oNF10sx=ZzArb8skXUQ8m5Qek2e-o4c9VEg@mail.gmail.com> <221116.86a64rkdcj.gmgdl@evledraar.gmail.com> <CAPig+cQiyd9yGE_XpPZmzLQnNDMypnrEgkV7nqRZZn3j6E0APQ@mail.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/15 07:19PM, Eric Sunshine wrote:
> On Tue, Nov 15, 2022 at 6:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> > On Tue, Nov 15 2022, Eric Sunshine wrote:
> > > On Tue, Nov 15, 2022 at 4:13 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> > > <avarab@gmail.com> wrote:
> > >> But for this patch, it seems much better to link to the "checkout" d=
ocs,
> > >> no?
> > >
> > > Sorry, no. The important point here is that the --orphan option being
> > > added to `git worktree add` closely follows the behavior of `git
> > > switch --orphan`, which is quite different from the behavior of `git
> > > checkout --orphan`.
> > >
> > > The `git switch --orphan` documentation doesn't seem particularly
> > > lacking; it correctly describes the (very) simplified behavior of tha=
t
> > > command over `git checkout --orphan`. I might agree that there isn't
> > > much reason to link to git-switch for "more details", though, since
> > > there isn't really anything else that needs to be said.
> >
> > Aside from what it says now: 1/2 of what I'm saying is that linking to
> > it while it says it's "EXPERIMENTAL" might be either jumping the gun.
> >
> > Or maybe we should just declare it non-"EXPERIMENTAL", but in any case
> > this unrelated topic might want to avoid that altogether and just link
> > to the "checkout" version.
>
> Even better would be for the documentation added by this patch to be
> self-contained and not bother linking anywhere to further explain
> --orphan. That would satisfy your concern, I think, as well as my
> concern that `git checkout --orphan` documentation is inappropriate
> for `git worktree add --orphan`.
>
> > > If we did want to say something else here, we might copy one sentence
> > > from the `git checkout --orphan` documentation:
> > >
> > >     The first commit made on this new branch will have no parents and
> > >     it will be the root of a new history totally disconnected from al=
l
> > >     the other branches and commits.
> > >
> > > The same sentence could be added to `git switch --orphan`
> > > documentation, but that's outside the scope of this patch series (thu=
s
> > > can be done later by someone).
> >
> > I think I was partially confused by skimming the SYNOPSIS and thinking
> > this supported <start-point> like checkout, which as I found in
> > https://lore.kernel.org/git/221115.86edu3kfqz.gmgdl@evledraar.gmail.com=
/
> > just seems to be a missing assertion where we want to die() if that's
> > provided in this mode.
>
> I haven't read v3 yet, so I wasn't aware that the SYNOPSIS hadn't been
> updated to match the reworked --orphan behavior implemented by v3, but
> I can certainly understand how that would have led you astray. You're
> quite correct that the SYNOPSIS should not be saying that <commit-ish>
> is allowed with --orphan.
>
> > What I also found a bit confusing (but maybe it's just me) is that the
> > "with a clean working directory" seemed at first to be drawing a
> > distinction between this behavior and that of "git switch", but from
> > poking at it some more it seems to be expressing "this is like git
> > switch's --orphan" with that.
>
> "clean working directory" may indeed be ambiguous and confusing. It's
> not necessarily clear if it means "no changes to tracked files" or "no
> files in directory". We should use more precise terminology.
>
> > I think instead of "clean working tree" it would be better to talk abou=
t
> > "tracked files", as "git switch --orphan" does, which AFAICT is what it
> > means. But then again the reason "switch" does that is because you have
> > *existing* tracked files, which inherently doesn't apply for "worktree"=
.
> >
> > Hrm.
> >
> > So, I guess it depends on your mental model of this operation, but at
> > least I think it's more intuitive to explain it in terms of "git
> > checkout --orphan", not "git switch --orphan". I.e.:
> >
> >         Create a worktree containing an orphan branch named
> >         `<branch>`. This works like linkgit:git-checkout[1]'s `--orphan=
'
> >         option, except '<start-point>` isn't supported, and the "clear
> >         the index" doesn't apply (as "worktree add" will always have a
> >         new index)".
> >
> > Whereas defining this in terms of git-switch's "All tracked files are
> > removed" might just be more confusing. What files? Since it's "worktree
> > add" there weren't any in the first place.
>
> I would find it clearer not to talk about or reference `git checkout
> --orphan` at all. And, as mentioned above, it shouldn't need to
> reference `git switch --orphan` either. How about something like this
> for the description of the `add` subcommand?
>
>     Create a worktree containing no files and with an empty index, and
>     associated with a new orphan branch named `<branch>`. The first
>     commit made on this new branch will have no parents and will be
>     the root of a new history disconnected from any other branches.
>
> And then to document the --orphan command:
>
>     With `add`, make the new worktree and index empty, and associate
>     the worktree with a new orphan branch named `<new-branch>`.

I really like this approach. My original intent was that by referencing
git-checkout, users could check the source documentation for the underlying
command. Since we now call neither `git checkout` or `git switch`, just
documenting the behavior outright seems like the best course of action.

