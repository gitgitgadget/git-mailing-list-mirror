Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E9CC282DD
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 01:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1B220721
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 01:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9SAv3Ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgAKBQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 20:16:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39023 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgAKBQX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 20:16:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so3787524oty.6
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 17:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pGaWmhjsYi6Za49MQR4qrftImPIWZpexKwAiIlvjZQ=;
        b=Q9SAv3Ec8fas21RCoiEtt6zepU1iCy6BLio8ZdBtzWJM0k97WEc1MFSbDsJjaDB3oN
         WTSpAomu4Naqc8LOMYMvHZznpbDi4FaLHhMROLxQlTVqVvEkPYfMZUGW1h0ZWyyOZ/gp
         ls2O8HJ2q2IkVIIFyyfJidknOhhqn59gZ35ZTHSELKgTl5UYcty+uxb9bbWLkhpvBdQN
         CWMsrwcGG5/RdV/SiwLr9Hc1YeuDQBOyv3SfxQz2fa7gdzCZrpTa2/G/+7dR9y/XrUql
         1RToTBPWyyjTqbI+sf61WhJXpgGI68GN9nxhVaNxM0h561/yZJvemxT+2UkswRRoohpj
         bj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pGaWmhjsYi6Za49MQR4qrftImPIWZpexKwAiIlvjZQ=;
        b=j7E2ketiLNqCi1/QPJpxhnS+tg0VBZVfJh2AFproaf5FK0DhUgZXwJiXBOHFBm6eVN
         A4RM3OEGwc7oRaV8c+LnnzAMYTwZ1h/YMyFvmQluWy4ZfuMAEkAYf+c6k5O65g2yEs+z
         kjU7lMn9rhD8TEyiWIMAKuT+vL0gDrptcmoN1WTtQ9agLIhZAZ6zgXOmFYD1wzklOaaB
         CoOO1H5ZLEQQ3TBxtrU37AhVl9FgzcXGZTAGs26G7x3S0ibWBkYkF4ysYvPubDCXIj56
         R1B4tijW9t6esQIocVtvxY0hWSTSQ8nqLAdRRrEVYUB/sPCJbNTwJs7KpN0geZGEHXmI
         7qYQ==
X-Gm-Message-State: APjAAAVPVRExVRBtQ1djlu5BJHiBhnaf5jmCokcxq0kE4pOz84rZe+Js
        t954VfQoF7LxMmgUqZVsOC7RkoaFK4AyFJwIhY4JHw==
X-Google-Smtp-Source: APXvYqz6yuZSMwJGIwn/t/kRGgdkW2eKR7jllAf9athI7OQVNO/wn+pYZBf7SkFNccmlTNeqlvVYCzAa5b9MUP0xOKc=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr5225776otp.316.1578705382771;
 Fri, 10 Jan 2020 17:16:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com> <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
 <20200110231436.GA24315@google.com>
In-Reply-To: <20200110231436.GA24315@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Jan 2020 17:16:11 -0800
Message-ID: <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to "merge"
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
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

Hi Jonathan,

On Fri, Jan 10, 2020 at 3:14 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Elijah Newren via GitGitGadget wrote:
>
> > The am-backend drops information and thus limits what we can do:
> >
> >   * lack of full tree information from the original commits means we
> >     cannot do directory rename detection and warn users that they might
> >     want to move some of their new files that they placed in old
> >     directories to prevent their becoming orphaned.[1]
> >   * reduction in context from only having a few lines beyond those
> >     changed means that when context lines are non-unique we can apply
> >     patches incorrectly.[2]
> >   * lack of access to original commits means that conflict marker
> >     annotation has less information available.
> >
> > Also, the merge/interactive backend have far more abilities, appear to
> > currently have a slight performance advantage[3] and have room for more
> > optimizations than the am backend[4] (and work is underway to take
> > advantage of some of those possibilities).
> >
> > [1] https://lore.kernel.org/git/xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com/
> > [2] https://lore.kernel.org/git/CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+h+t4Mn4A@mail.gmail.com/
> > [3] https://public-inbox.org/git/CABPp-BF=ev03WgODk6TMQmuNoatg2kiEe5DR__gJ0OTVqHSnfQ@mail.gmail.com/
> > [4] https://lore.kernel.org/git/CABPp-BGh7yW69QwxQb13K0HM38NKmQif3A6C6UULEKYnkEJ5vA@mail.gmail.com/
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/git-rebase.txt           |  2 +-
> >  builtin/rebase.c                       |  4 ++--
> >  t/t5520-pull.sh                        | 10 ++++++----
> >  t/t9106-git-svn-commit-diff-clobber.sh |  3 ++-
> >  4 files changed, 11 insertions(+), 8 deletions(-)
>
> Thanks for writing this.  We finally rolled this out to our internal
> population at $DAYJOB and ran into a couple of issues:

Cool, thanks for testing it out.

>  1. "git rebase --am" does not invoke the post-commit hook, but "git
>     rebase --merge" does.  Is this behavior change intended?
>
>     Noticed because jiri[1] installs a post-commit hook that warns
>     about commits on detached HEAD, so this change makes rebases more
>     noisy in repositories that were set up using jiri.

I've never used a post-commit hook or seen one in the wild.  Certainly
wasn't intentional, but it's not clear to me if it's wrong or right
either.  I don't see why it would make sense to distinguish between
any of git rebase --am/--merge/--interactive, but it isn't too
surprising that by historical accident the two rebase backends which
happened to call git-commit behind the scenes would call a post-commit
hook and the other rebase backend that didn't call git-commit
wouldn't.

But the big question here, is what is correct behavior?  Should rebase
call the post-commit hook, or should it skip it?  I haven't any clue
what the answer to that is.

>  2. GIT_REFLOG_ACTION contains "rebase -i" even though the rebase is
>     not interactive.

Yep, as does --keep, --exec, --rebase-merges, etc.  There are lots of
rebases which use the interactive machinery even if they aren't
explicitly interactive.  I've never seen the "-i" in the reflog
message defined, but clearly it has always been used whenever the
interactive machinery was in play regardless of whether the rebase was
interactive.  In that regard, I figured that --merge fit in rather
nicely.  (And I noted the fact that reflog messages were different
between the backends among the "BEHAVIORAL DIFFERENCES" section of
git-rebase.txt).  But if others think we should just drop the -i (much
as we did for the bash prompt), I'd be happy with that too.  If we go
that route, I think I'd rather drop the -i in the reflog for all
rebases, not just the
using-the-interactive-machinery-but-not-explicitly-interactive ones.

>  3. In circumstances I haven't pinned down yet, we get the error
>     message "invalid date format: @@2592000 +0000":
>
>         $ git rebase --committer-date-is-author-date --onto branch_K branch_L~1 branch_L
>         $ git checkout --theirs file
>         $ git add file
>         $ git rebase --continue
>         fatal: invalid date format: @@2592000 +0000
>         error: could not commit staged changes.
>
>     This isn't reproducible without --committer-date-is-author-date.
>     More context (the test where it happens) is in [2].

Interesting.  Do you happen to know if this started happening with
ra/rebase-i-more-options, or did it just become an issue with
en/rebase-backend?  I looked around at the link you provided and feel
a bit confused; I'm not sure which test does this or how I'd
reproduce.

>  4. I suspect the exit status in the "you need to resolve conflicts"
>     case has changed.  With rebase --am, [3] would automatically
>     invoke rebase --abort when conflicts are present, but with rebase
>     --merge it does not.
>
> Known?

Nope, but I would certainly hope that "you need to resolve conflicts"
would result in a non-zero exit status.  If it doesn't, that sounds
like a bug in the interactive backend that we need to fix.  I'll dig
in.



Thanks for the reports!
Elijah
