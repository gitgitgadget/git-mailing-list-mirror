Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3F4C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 23:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C7F21582
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 23:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO1Wl+CY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbgAPXUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:20:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34820 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390562AbgAPXUI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 18:20:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id i15so21032992oto.2
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 15:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++MeztK3RzdkECqdDIggpqPYe5zeoSJ6QwwoEQd6ciE=;
        b=JO1Wl+CYGxLbw8AUpohyeWD7T+ENz06RMIiruI+2GabKogdIHy+gRxdaizMz2Oc8ij
         gKwf4YOt+87H3p6ppa2VX2ATT8t85jPTXrS7lYyvClIGvLkSTAiroY+exeitsfgA5BJg
         s6ioSjEhB031ZO8jl5UpFOdYsZyZ+4mtfJI42vPWxGmc+cRVtxOYPgcKjF7wDiM/plHT
         aFJKG7mamY8F6+0lSz7fOZ3hveePJ411f6EhKQmpz26WppsygetONfqtrIRmswBTLpo9
         20+o4Mdamisg7UXKehdUU0g8b1nvvq53hdKRFqp8AupM1JiMX11Cp97gT/x27mHB3+UK
         K31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++MeztK3RzdkECqdDIggpqPYe5zeoSJ6QwwoEQd6ciE=;
        b=hZdFNz/bmiFegl5eO3Tcyck/in3jmZOXauMfSAIpaUtS7kTenEakze3n0GqWn1uEY1
         v7z07pe1mJMCvpJC5uw0fWu5XoPjvYMJN6ZFBeahfPtNJbjLXCiosiCLLp3hOyOO4cTf
         Fv7HmE4iM6aXcbJKJO5sPQaZdUyo06oqjmU/piVeMgDMRYMyg3HRHoTvqlAyom9gkncF
         L1CAQmZXOUeTTsNOLH/1WA6eTa/WykUDngbyFgQFJpWSkYSxAuoJf9Y4O760qQYiUDKe
         tyxe+gE+VYgdoudHuRi7UQygIIH1Pu1cKDCLnae+prnEc+jWrf/MwLzxCHAwX+7Ey3MH
         KifQ==
X-Gm-Message-State: APjAAAWDnD8POd90EYM+4HorgB/XHXuLXTSixijPjsAYBFBgYZyw237Y
        0dvcReK/Px7IiHWSz4ICOnR4EalOJPT81GJJjP0=
X-Google-Smtp-Source: APXvYqy2+iqRbUUa9pVz61HkOfDWXmnJ6TvyR3jB4zyuqLe3rkh1WQOOLIDzeavmacC+2ip167uFmW21Z41HzQ3NJgk=
X-Received: by 2002:a9d:7d81:: with SMTP id j1mr4085756otn.267.1579216806430;
 Thu, 16 Jan 2020 15:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20200110231436.GA24315@google.com> <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
 <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com> <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
 <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
 <20200116075810.GB242359@google.com> <20200116080624.GA253496@google.com>
 <CABPp-BHODjbN3-snoFt4LDHGnoxhpDCQHhGVZp14gP1RZFp=hQ@mail.gmail.com>
 <20200116203521.GA71299@google.com> <CABPp-BHiYDLRgPX4A1-8f-zgfsDqf6PkToStaV3ukC5Dsq=3-w@mail.gmail.com>
 <20200116223912.GB71299@google.com>
In-Reply-To: <20200116223912.GB71299@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 16 Jan 2020 15:19:55 -0800
Message-ID: <CABPp-BE9XqOCG0VqA5XgDbXm4apw0-_mOqW-JSO+PDZhisO0Rw@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to "merge"
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 16, 2020 at 2:39 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> [...]
> >>  B. stop running the post-commit hook in rebase
> >
> > AND sometimes in both cherry-pick and git-revert, depending on the
> > number of commit(s) picked/reverted (see below).
>
> Interesting.  Doesn't "git cherry-pick A..B" run post-commit after
> each commit today?  It would be possible to do (B) and retain that
> behavior.

Sure, it'd be possible to retain the post-commit calls for cherry-pick
but should we?  Isn't the primary reason the issue came up that having
batch-commit operations calling post-commit for each intermediate
commit is ugly/unexpected overhead?  If we're ripping it out of rebase
for that reason, it seems that cherry-pick should get the same
treatment.  I don't want to just move the inconsistencies around, I
want to fix them.

> > Also, even if we go this route, I think the post-commit hook should be
> > added to git-merge whenever it creates a merge commit.
>
> Agreed.

Yay!

> >>     Advantages:
> >>     * makes --am and --merge consistent with minimal user impact
> >
> > ...and also makes --interactive and --exec and other cases consistent too.
>
> Hm.  My initial thought with (B) was to stop running post-commit in
> non-interactive rebase but keep running it in rebase --interactive.
>
> I don't have a strong opinion about this, though.

I'm okay with treating them differently if there's a defining reason
why, but otherwise I think they should all behave the same.  The only
reasons I've seen for differences all fall in category C so far, which
gives me a strong opinion against treating them differently.

> >>     Disadvantages:
> >>     * meaning of the post-commit hook remains a muddle
> >
> > Why?  "Commands which create no more than one commit (git-commit,
> > git-merge, maybe single-commit git-revert or git-cherry-pick) call
> > post-commit, commands which create several commits derived from others
> > (git-am, git-rebase, git-cherry-pick, sometimes git-revert ) call
> > post-rewrite instead for performance reasons"
>
> Example: if I run "git revert A..B", following that rule we'd want to
> call post-rewrite instead of post-commit.  But post-rewrite gets input
>
>         <old-sha1> SP <new-sha1> [ SP <extra-info> ] LF
>
> so that it can be used to copy data such as notes.  What do I pass in as
> <old-sha1>?
>
> Relatedly, if I remember correctly, we don't call post-rewrite in "git
> cherry-pick" because cherry-pick is considered to represent a *new*
> commit instead of a modified version of the old one.  In C++ terms,
> it's a copy constructor instead of a move constructor. ;-)  See
> notes.rewrite.* in "git help notes" for more on that subject.

Ah, I see.  Yeah, there's some impedance mismatch between the
purpose/definition of the post-rewrite hook and what I think is needed
for B.  Perhaps create a new post-batch-commit hook
("batch-post-commit"?) and have git-rebase, git-am, git-cherry-pick,
git-revert, etc. call it while git-commit and git-merge call
post-commit.  (Or maybe even make git-commit and git-merge also call
post-batch-commit/batch-post-commit but do so with just one commit --
and just note that post-commit's design of not taking any parameters
was a mistake and any place that happens to call it beyond
"git-commit/git-merge" is solely by accident of past implementation
and is not guaranteed to continue.)

I think the realm of "copy constructor vs. move constructor" may make
sense for post-rewrite-hook, but I'm worried that trying to apply that
logic to notification of new commits may lead us into category C
craziness.

> [...]
> >>  C. stop running the post-commit hook in rebase --merge or commit --amend
> >>
> >>     Advantages:
> >>     * produces a consistent definition of post-commit ("it's about new
> >>       commits only")
> >
> > But cherry-pick never creates "new" commits if commit --amend doesn't,
> > so we'd also want to turn the post-commit hook off for cherry-pick,
> > right?
>
> With the copy/modify distinction described above, "git commit --amend"
> acts as a "modify" operation in a user's workflow, while "git
> cherry-pick" acts as a "copy" operation.
>
> That means that with this definition, post-commit is appropriate to
> run in cherry-pick but not in commit --amend.

What if there are conflicts?  Because with conflicts, aren't
cherry-picks more like the 'commit --amend' case since they behave as
a "modify"?  Conflict-dependent invoking of the post-commit hook?

> This matches the distinction used by note rewriting and the
> post-rewrite hook.  Looking back at the discussion in
> https://lore.kernel.org/git/cover.1266164150.git.trast@student.ethz.ch/
> I don't see this covered, so it's possible I'm remembering wrong (a
> pointer to the motivating discussion that inspired that patch series
> would be welcome).  In the context of note copying, this distinction
> ended up being a good decision in practice in most workflows I've
> seen.

Yeah, for note copying that distinction makes a lot of sense to me.
For "notification of new commits", it doesn't seem to jive at all for
me.

> [...]
> >>     Disadvantages:
> >>     * the change to historical "git commit --amend" behavior is likely
> >>       to be surprising
> >
> > That is certainly one issue, but I'd say this case is riddled with
> > problems and is the most muddled of all.
>
> I'm inclined to agree, based on the "git commit --amend" example.
>
> [...]
> > I think it was useful to phrase it this way and list the various
> > advantages, disadvantages, and mitigations; thanks.
> >
> > Is there anything I've missed in my additional details?  Anything
> > sound crazy (beyond what I said I think case C leads to)?
>
> To sum it up, I lean toward (B), but (A) is not so bad, either
> (especially with the "I need some time to adapt to the change" opt-out
> config described under mitigations).

Sounds like we might be starting to converge towards a similar
opinion.  I roughly feel the same with leaning towards something like
(B) _if_ we can address the inconsistencies rather than just shuffle
them around (meaning we also turn off post-commit for interactive
rebase and cherry-pick) and move all of them over to some kind of
batch-commit-notification mechanism.

> Thanks for patiently working it through with me.
>
> My two cents,
> Jonathan

Likewise.  :-)
Elijah
