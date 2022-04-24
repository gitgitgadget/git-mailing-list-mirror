Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866CAC433EF
	for <git@archiver.kernel.org>; Sun, 24 Apr 2022 11:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiDXMAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Apr 2022 08:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiDXMAm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Apr 2022 08:00:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABF2DE84
        for <git@vger.kernel.org>; Sun, 24 Apr 2022 04:57:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id k27so259848edk.4
        for <git@vger.kernel.org>; Sun, 24 Apr 2022 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxcxugKhRPYkGNmyVjB4RRjEH9MUa8wfLxiFY93CKm0=;
        b=YLAvhcOllalSIDt4AnwOUu8mDJnB6xA4mKgOhH3s2ll+TwZ7k1X7HkezywNhoGLo+x
         z6KVHof4EkzKwBP3tz513TPYNyT8NA0l8eOLljuUUQHBaWBUdShTsVVPFMKIW67sAAGJ
         2z5p9x03VKbSsFPpqQHCB3W9kIHblxgrnHT3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxcxugKhRPYkGNmyVjB4RRjEH9MUa8wfLxiFY93CKm0=;
        b=VoJpxwutHjht6Pi/8bCmSSkZSFzJeFbHKSYpjrYrKnUPYiatDoflQPok/PcMtMysTv
         zU7fuegcIpzW1rDqvxh7AWkd+9fauMdXqXy9lMiTTNSUbfMFgccAAwFEZu3vhir3k/L8
         yiKRa6uJH+xezx0DDZv0DVjZn1nGi18WsYOVm1ol7PkMJalPp3/kP4BQ9Xkw6tuGc78o
         GwzM2iRvipg0mgXCcCbdce0KgKN7qb+x99oG7L4rn/rkW27oaMLMbSk8c6Xm7EdZ4iop
         5hwnefLPafwCzn9VuSBjOOzBYT8niRyapzynuKgCYbf/GMQKmSAkiAWKUJRWndKqEFAK
         bpgA==
X-Gm-Message-State: AOAM532InM9V951CU7CVG8jT7jEnd4r3qYfU7NndpqM5oIM73QO3siVC
        j3BYsLJtyGnRh4KQKjPVn/EEmPzOdqVV+L7l79KlCg==
X-Google-Smtp-Source: ABdhPJxH8TuJCtvzP1XgvN3DSUcPweWPivDQ7TuZ2z3t8CTF0J2AlFoenrwZ3xTuxioy3nAUZhwHDRc4FznkSB+RHPU=
X-Received: by 2002:a50:bae3:0:b0:425:b2b5:6248 with SMTP id
 x90-20020a50bae3000000b00425b2b56248mr13747663ede.281.1650801460405; Sun, 24
 Apr 2022 04:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
 <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com> <Yl2qwO0SMPOhb5h9@google.com>
 <CAPMMpogY5vZU8gyRSYh+BM4goPPtJw0cCiM-31sy-s_uGRv8uA@mail.gmail.com>
 <xmqqczhbr6pv.fsf@gitster.g> <CAPMMpohQei9vBBm=7hC=N5LPwzMCED=fZcXyePnrkLCHfCJTZw@mail.gmail.com>
 <xmqqlevzkxrf.fsf@gitster.g> <CAPMMpoiCD+fG=bs2j4Rin5Pvip9Mre9iqLcOb2LYnDQK9cuRxw@mail.gmail.com>
 <xmqqzgkddf8m.fsf@gitster.g> <CAPMMpoj+g-XFKXoAXzW4d6WZRSBO_uE6MRsw2jWUPAjqWFQt2A@mail.gmail.com>
 <xmqqv8v02yu9.fsf@gitster.g>
In-Reply-To: <xmqqv8v02yu9.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sun, 24 Apr 2022 13:57:29 +0200
Message-ID: <CAPMMpohn6+RQV=jg9fQc4nt1tK6zE38xAwejxNfGh+-4Dp_JNw@mail.gmail.com>
Subject: Re: [PATCH v4] merge: new autosetupmerge option 'simple' for matching branches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2022 at 6:44 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> >> "none", probably.  Much better than "current" that can create new
> >> branches on the other side, which you would want to do with an
> >> explicit end-user instruction (i.e. not with "git push", but with
> >> "git push origin topic").
>
> Sorry, "nothing" was what I meant.  Those non-simple branches are
> left unconfigured with ASU=simple.  We both agree that the user does
> not want to see the "with push.default=simple you have, you cannot
> push from it" but the reason why they do not want to see can be
> multiple.  You are assuming that they want to push to somewhere
> else.  I am taking into account that they may not want to push them
> at all, but only use locally.  If the intended workflow is
>
>         git checkout -b main [origin/main] ;# assuming DWIM is on
>         git checkout -b topic origin/main
>         ... work work work ...
>         git checkout main
>         git merge topic
>         ... test test test ...
>         ... ahh, no it does not work, back to fix topic ...
>         git reset --hard ORIG_HEAD
>         git checkout topic
>         ... work work work ...
>         git rebase -i ...
>         git checkout main
>         git merge topic
>         ... test test test ...
>         ... yay, this time it is perfect and we can push it out ...
>         git push

(two interesting/surprising things here:
1) The user chooses to merge to master *before* testing (does not test on topic)
2) The user does not use CI pipelines of any kind
)

>
> i.e. matching "simple" branches like main are used to locally bundle
> what you locally worked on, and the result is pushed out to the
> other side from there, while non-simple branches like topic are used
> to locally work on your real changes, it is reasonable to expect
> that the user wants "git push" to fail when the 'topic' branch is
> checked out.

I would argue that the user who wants push to fail here is a very rare
user. Presumably they thought they were somewhere else, and the "git
push" was a complete mistake? (why else would you run the command??)

For users of a central repo (github, gitlab, bitbucket, teamhub, etc
etc) when they say "git push" it is normally/typically to, well...
push their changes to the remote! To back them up because they're
worried about losing them, or to share them with
teammates/collaborators, to run CI, or for any other reason.

I'm not arguing that "nothing" is useless to everyone, but I am
arguing that for the workflow you have highlighted above, "nothing" is
not a valuable setting. It provides close to no practical safety
benefits, and makes pushing shared branches much more awkward.

>
> But unfortunately that does not work at the last step, as "nothing"
> unfortunately affects the last step that tries to check out 'main',
> too.  push.default='simple' would make it work.
>

OK

> > I would argue that git generally has a "problem", in that
> > "branch.XXX.merge" entries have two classes of
> > meanings/interpretation:
> > * That is the "parent branch"
> > ** The one I want changes from, when I say "update me with changes"
> > ** The one I eventually want to get my changes to
> > * That is the "remote instance/address" of *this* branch
> > ** If I pull, it's to get changes to the same branch that others might have made
> > ** When I push, it's to get this branch onto the server (not to get my
> > changes into the "upstream")
>
> Yes, that is very well known, and there arey mechanisms to support
> some workflows that separates "where I get changes from" and "where
> I publish my work" (look for "triangular workflows" in the list
> archive).

Yes, the best/simplest summary I've seen so far is the github blog
post https://github.blog/2015-07-29-git-2-5-including-multiple-worktrees-and-triangular-workflows/

In the particular model highlighted there, you use "branch.XXX.merge"
entries to indicate "the parent branch" while keeping the "remote
branch instance" separate, by leveraging the "push.default=current"
setting, but of course this "parent branch" information is still
local-only, and you cannot collaborate on your feature/topic branch
with others. If someone else checks out your topic branch from your
server and pushes some changes to it, then your flow breaks, because
your "git pull" means "bring in changes from the parent", not "bring
in any changes that might have occurred on the topic branch".

I understand there are techniques/flows that users can choose to use,
but I don't think this changes the fundamental and, for beginners,
problematic, ambiguity of meaning of "branch.XXX.merge". The
"branch.autosetupmerge=simple" proposal is to simplify it down to
"branch.XXX.merge entries indicate what the remote instance of this
branch is, and will normally be aligned with the name of the local
branch". This "simplification" is incompatible with the particular
triangular workflow highlighted above.

>
> > In suggesting the user could/should have done that (in order to get a
> > sane workflow, presumably), you are also suggesting that they should
> > keep the state of that "local version of the upstream they eventually
> > want to get their changes into" up-to-date: They should first check
> > out master (for example), pull on master to get the state they expect,
> > and *then* create their new differently-named local branch.
>
> FWIW, I am not.

Fair enough, sorry I misunderstood. What I meant is that you need to
"maintain" your local master when you do eventually want to push up
any topic branch, *and* any other time you do want to "catch up" with
upstream changes; assuming you work on multiple topic branches in
parallel (which is one of the "superpowers" of git), the local master
has lots of different reasons to change.

>
> I do not think it is healthy nor necessary to make your local work
> "catch up" too often with the outside world unnecessarily, be it
> done with rebase or with merge.  They _can_ update 'master' when
> outside world has something worth adding to your topic extra
> dependency on and then update 'topic' to include what you took to
> 'master' from the outside.  Dissociating the 'topic' from outside
> world is one way to encourage a better workflow.

On this we agree, I guess :)


I will have another go at proposing a complete, easy-to-understand,
easy-to-enter, "simple" workflow that emphasises local and remote
branch "correspondence" by encouraging "branch.XXX.merge" to always
and automatically be set to the same-name branch on the remote (and
not any other "parent" you might have branched from when creating a
topic branch), and a reasonable non-intrusive, non-misleading way to
on-ramp into it.
