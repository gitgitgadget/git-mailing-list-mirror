Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2270EC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0B920748
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/aFZW1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbgAPVav (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:30:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33608 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAPVav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:30:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so5434878oig.0
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 13:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsU8N9VAx9XIgUgjPv8vcqoturBO/WX0G1aA2b606RU=;
        b=l/aFZW1MxtV8mXBaUXGT3AJtsw+ofsmQEhVO6ycn8UXWlA/xBVYa4hOR0XF00pgqZK
         qqCSo16wm+Aw3SJUpn5ROOPOhMaoN+iHUtQ8WtFuxdna3/eyYPyidVkB26QJmp97QIvV
         HpoczHxeaIOkjdKhIjEb7k7C5O79bkEupYbEFXRga44j1pQAqj8HDYOWOm5qTzqQc3AA
         8iEs4QO1UWX9svp8jQ2Q4DY7yYUqJnqyILGO0surN7dNzWUR2TuQgXe+P2Q1CqewuzQ9
         lUDKRjYaPlRt4eWFc0rR0RyOSKwL37DHSb7d9sPlr27msfmHvgdlFnacyJKColtbECqd
         1NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsU8N9VAx9XIgUgjPv8vcqoturBO/WX0G1aA2b606RU=;
        b=jzAjAe/Tm3hupfTb0lnZqRildKUz6g6aWBe8bdwkN5kzEQmWxXg13ALdUPvOUyDwq+
         osiOXyDp26VV6z+PQ370pUvApsFjPWZzgAvMkafKc9WyhTT9HwZi8aPnJc4rO1GOGiSX
         tLIhrM8BSZ2YRSUdTWtPFOUWuE2/HnZ03D1GMOPaVg933XWfUuhqwj0bpvK05ACbdeK3
         MS31o7Naay9tSlljqtIgqKGCKx0fkh7QqdWeAd0CchU0N56Uzybya0mkmldS/R2njIcj
         8xS4i7E/Ooo/+ljhtLzBuEqVxP+D/PUbljpjsBgdinDFzFKCv3V92dEGzK1U4kC+gkW7
         +XDA==
X-Gm-Message-State: APjAAAWRx2wZ4mBmBcv5qsbPCTs3G+TqfU3zjpSIt6IiZjnNoMwa7ik4
        /MQU3MzKwDDaQI7ITyUETzXjK/puPfltzFAIWX0hpLTN
X-Google-Smtp-Source: APXvYqwVuywTvqMTVjRjf7Kv3fOpd15x3JzDtIsv7Y5B7wAnwbJMSHRuczw+9DkhGje1qdvM8lHXEUn1u+zm9/8JTBM=
X-Received: by 2002:aca:5588:: with SMTP id j130mr952164oib.122.1579210249879;
 Thu, 16 Jan 2020 13:30:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
 <20200110231436.GA24315@google.com> <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
 <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com> <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
 <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
 <20200116075810.GB242359@google.com> <20200116080624.GA253496@google.com>
 <CABPp-BHODjbN3-snoFt4LDHGnoxhpDCQHhGVZp14gP1RZFp=hQ@mail.gmail.com> <20200116203521.GA71299@google.com>
In-Reply-To: <20200116203521.GA71299@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 16 Jan 2020 13:30:38 -0800
Message-ID: <CABPp-BHiYDLRgPX4A1-8f-zgfsDqf6PkToStaV3ukC5Dsq=3-w@mail.gmail.com>
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

On Thu, Jan 16, 2020 at 12:35 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> > Of course, arguing against myself, we could always tell them to just
> > implement a post-rewrite hook.
>
> That's an interesting facet I hadn't thought about before.
>
> It's tempting since it kind of minimizes the blast surface while
> providing people a way to keep doing what they had wanted.
>
> Historically "git cherry-pick" ran "git commit", causing it to run the

What do you mean "historically"?  I'm pretty sure this piece of code
is shared in the sequencer between rebase -i, rebase --merge, and
cherry-pick, so all three currently call post-commit unless I'm
mistaken.

> post-commit hook.  There's some related discussion at
> https://lore.kernel.org/git/20f33df8-7ba8-af26-e0c8-16152345c85b@talktalk.net/
> of other side effects of having run "git commit".
>
> ... oh! git cherry-pick doesn't run post-rewrite.  Interesting.
>
> To summarize what we've discussed so far:
>
>  A. run post-commit hook consistently in rebase --am and --merge modes

Could you spell these out a bit more?  I think by this option you mean
"Always run post-commit when commits are created", which includes
whether those commits were created by git-commit, git-rebase (any
backend), git-merge, git-cherry-pick, git-revert, git-am, etc. (but
with a glaring exception for fast-import and things that call it, much
like the exception post-rewrite already carves out for it).

Much as I don't see a reason to make rebase --merge different than
rebase --am, I don't see a reason to differentiate between git-merge
and git-commit.  I also don't see why rebase --am should be different
than am.

>     Advantages:
>     * consistent with historic "rebase -i" behavior
>     * supports hooks like ctags generation that want to update state to
>       match what has been committed in the worktree (especially when
>       preparing for the rebase to stop due to conflicts)
>     * consistent with other commands like "git cherry-pick" that run the
>       post-commit hook
>
>     Disadvantages:
>     * invokes hooks more often in a setting they are not used to being
>       invoked in
>     * slows down rebase
>     * when post-commit hooks are used for deployment, exposes
>       intermediate states in the middle of a rebase to the deployment
>       environment
>     * inconsistent with "git am"

I don't want to introduce additional inconsistencies.  git-am and git
merge should be changed at the same time if we go this route.

>     Mitigations:
>     * could go through the normal warn about change, opt-in config,
>       opt-out config cycle to make the change smoother
>     * could provide new hooks (e.g., one run after a batch of objects
>       is created for applications similar to "git gc --auto", one run
>       when HEAD is updated for applications like the ctags one, one
>       run on ref update for applications like the deployment case) and
>       encourage authors to migrate to them
>     * could run the post-commit hook in "git am", too



>  B. stop running the post-commit hook in rebase

AND sometimes in both cherry-pick and git-revert, depending on the
number of commit(s) picked/reverted (see below).

Also, even if we go this route, I think the post-commit hook should be
added to git-merge whenever it creates a merge commit.

>     Advantages:
>     * makes --am and --merge consistent with minimal user impact

...and also makes --interactive and --exec and other cases consistent too.

>     Disadvantages:
>     * meaning of the post-commit hook remains a muddle

Why?  "Commands which create no more than one commit (git-commit,
git-merge, maybe single-commit git-revert or git-cherry-pick) call
post-commit, commands which create several commits derived from others
(git-am, git-rebase, git-cherry-pick, sometimes git-revert ) call
post-rewrite instead for performance reasons" (with the standard
exception for fast-import; also, git-merge could probably call
post-rewrite in fast-forward cases since no new commit is created to
call post-commit on).

Or we could just say that commands which can create multiple commits
(cherry-pick & revert) only call post-rewrite even in cases where they
are only called with one commit (since am and rebase can also be
called on just one commit).

>     * in particular, "git am" and "git rebase" would not be consistent
>       with "git cherry-pick"

Yeah, I'd rather not introduce more inconsistencies; we should pick a
rule and enforce it universally.  Thus, I'd say option B would
probably be thought of as the "always creates at most one commit" vs.
"creates multiple commits" split for post-commit vs. post-rewrite.

>     Mitigations:
>     * could provide new hooks for people to migrate to to replace that
>       muddle
>
>  C. stop running the post-commit hook in rebase --merge or commit --amend
>
>     Advantages:
>     * produces a consistent definition of post-commit ("it's about new
>       commits only")

But cherry-pick never creates "new" commits if commit --amend doesn't,
so we'd also want to turn the post-commit hook off for cherry-pick,
right?  And we'd want to turn post-commit on for git-merge, at least
for non-fast-forward cases since those create new commits.

>     * hook authors get the same expressiveness using the post-rewrite hook

Isn't this also an advantage for case B?  Any reason it was left off up there?

>     Disadvantages:
>     * the change to historical "git commit --amend" behavior is likely
>       to be surprising

That is certainly one issue, but I'd say this case is riddled with
problems and is the most muddled of all.  Once you change git commit
--amend behavior because it's about *new* commits only then you've got
a huge can of worms from rebase -i:

For interactive rebases, we have to avoid the post-commit hook for
anything that is a pick, but if they break or edit and insert new
commits then we have to call the post-commit hook for those.  If the
rebase stops due to a merge conflict, then the next commit created
needs to avoid the post-commit hook.  If they pick to squash or fixup
commits, then we have to deploy rename/break detection to determine
whether the commit is "new" or not and thus whether the post-commit
hook should be triggered for it.  Actually, maybe we need the
rename/break-detection logic when the rebase stops at a conflict too
due to user edits.  And then we start getting into questions about
whether the normal heuristics for rename/break-detection apply or if
"new-ness" should have its own set of heuristics...

Also,  I can't tell if a reverted commit count as "new" or not.  Even
if it does, what about the case of a reverted revert, or higher order
iterations of reverts (which I see occasionally)?

Does this definition mean we should use the git-cherry machinery on
any new commits to search for "newness" (maybe even with an extension
to search across all branches) before we decide whether to call the
post-commit hook?

I think case C is opening up a pandora's box of craziness.

>     Mitigations:
>     * could go through the warn, opt-in config, opt-out config cycle
>
> Any bits I've missed?
>
> Thanks,
> Jonathan


I think it was useful to phrase it this way and list the various
advantages, disadvantages, and mitigations; thanks.

Is there anything I've missed in my additional details?  Anything
sound crazy (beyond what I said I think case C leads to)?


Elijah
