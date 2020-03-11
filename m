Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25356C10F25
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 05:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E312221655
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 05:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc1Nd90b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgCKFZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:25:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42929 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgCKFZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 01:25:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id 66so677728otd.9
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 22:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/vhXN8RqdRD4qlve93GTIa4qs/W0yplxjlsMQHiE9g=;
        b=mc1Nd90bXovNHxqjnV7gErigfWqAk7v8U3eFDE3ETJSsbZXw5MjoiArzCJRIeykq1b
         VyR7Lgj9aWpmTe9+8UhBv1DaOG3q/yAKo8mtrAPWCjPpKdgy31oLUrRdcHUo8yx9VRIN
         C0fz1jahP6QI5D5HAKOA24N5jLtCzAEeszz11XybsLsjg2NfxzqCufpfO2hCgXWg9fjL
         5m2bgbwvkxU9lCieGSQFZ9EMBReqSHtByop5BMD1ToHY3mNKlxXWlKe3/CW1J+8NMwlK
         BA9z5CYEAZuPq6jbCnkOIruaaZ5mofZNIyr3yj607Qf3HXCVK0aYBXX7NancL+DxbFaP
         NXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/vhXN8RqdRD4qlve93GTIa4qs/W0yplxjlsMQHiE9g=;
        b=uOG1GmAorIDHj4c90pDX0bUcL+3tgnskVV0wZ7tA3H7MWqk+57lcUwD7hfQRJGxYmh
         UAhP4rVvpD5NqNAobD6gNVj0rkIU9SLwEL0c2HNB1xugnPUHrm69F+f5lIimQ0pqX5/b
         kvtwa0OsHWO0MPKOgTvxi2/rNfzYUX2YSeAUHintGW2GgSkIN+lMz89tak26R5Kp5e/D
         MsTXpczEaoDpWXnB8KiKhdKbs9nX8ggnVI3ueXCighRV8JvZrnYdggh2ovoxAHAlFkt0
         MWh781L98p3FC8KO7/+eTIhcnKl3qpIW8y8SqMJpd5tCgaU23Mc61fRU0M6UDBhwUjYp
         +9Tg==
X-Gm-Message-State: ANhLgQ2lpbZdWSvXmo1Q1v0EdndrWixxe05RpPrqzLCRzrV39cOKqiIW
        c2HFJHWbhJGTcOQWwk8TMNnq6bO0naDHinBUQqCsoJ7x
X-Google-Smtp-Source: ADFU+vtQDXVyXJOUKy4mKeo1TMQFlodkXNsR1Hxd1BFDeOcupUjT317fNpfRxvyVw91jR4ukCmkAw793ORVu2nxR07M=
X-Received: by 2002:a9d:5cc8:: with SMTP id r8mr1003833oti.345.1583904355486;
 Tue, 10 Mar 2020 22:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo8t4z29k.fsf@gitster-ct.c.googlers.com> <20200310174017.GA549010@coredump.intra.peff.net>
In-Reply-To: <20200310174017.GA549010@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 Mar 2020 22:25:44 -0700
Message-ID: <CABPp-BE7zkVmsm5nO49F2e=KxmvafAXvU+Gy8qHQ9Cnsoe8qUQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.26.0-rc1
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 10, 2020 at 10:40 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Mar 10, 2020 at 07:57:11AM -0700, Junio C Hamano wrote:
>
> >  * "git rebase" has learned to use the merge backend (i.e. the
> >    machinery that drives "rebase -i") by default, while allowing
> >    "--apply" option to use the "apply" backend (e.g. the moral
> >    equivalent of "format-patch piped to am").  The rebase.backend
> >    configuration variable can be set to customize.
>
> I noticed a few behavior changes that I think are related to this
> switch. I'm not sure to what degree we'd consider these a problem
> (though the second I think may be an existing bug in the merge backend
> that's just getting more attention), but it seems like the time to raise
> the issue is now, before the release. :)
>
> The first change is that we'll now open an editor when continuing a
> conflicted rebase. You can see it by running this:
>
>   for backend in apply merge; do
>     echo "==> Running with rebase.backend=$backend"
>
>     # new repo
>     rm -rf repo
>     git init -q repo
>     cd repo
>
>     # create two conflicting branches
>     echo base >base && git add base && git commit -qm base
>     echo master >file && git add file && git commit -qm master
>     git checkout -q -b side HEAD^
>     echo side >file && git add file && git commit -qm side
>
>     # rebase on master, hit the conflict, then resolve it
>     git -c rebase.backend=$backend rebase master
>     echo resolved >file
>     git add file
>
>     # continue the rebase, noting whether we used the editor
>     GIT_EDITOR='echo >&2 running editor on:' git rebase --continue
>   done
>
> We won't run the editor the "apply" backend, but do for "merge".  I'm
> not sure how big a deal this is. It bit me because I have a script which
> runs rebase in a "while read" shell loop, with stdin coming from a pipe
> feeding the loop. It auto-continues when rerere is able to fix up the
> conflicts, but the editor complains about stdin not being a tty and
> dies.
>
> I'd imagine that's a pretty rare situation, and it was easy enough to
> fix up. But I wonder if we should be more careful about making sure the
> behavior is more identical. On the other hand, I imagine this is the way
> the merge backend has always behaved, so it would be a change in
> behavior for people who had been using it already. I guess the _most_
> compatible thing would be a merge-that-behaves-more-like-apply backend,
> but I'm not sure if we want to support that forever.

This behavior did not always exist with the merge backend, it began
with commit 68aa495b59 ("rebase: implement --merge via the interactive
machinery", 2018-12-11).  Before that, there was not too much in
sequencer.c or its predecessors for non-interactive rebases, so I
wouldn't give much weight to historical precedent for how the merge
backend behaves here.

However, as Junio argues elsewhere in this thread, the apply backend
should probably be the one that is considered to be buggy here.
Although fixing the apply backend is probably best, and adding an
escape hatch such as --no-edit as Junio suggests for the merge backend
makes sense, given where we are in the 2.26 cycle, I only sent off a
patch to document this difference for now.

> The second thing I noticed is more clearly a bug, I think. If we have a
> patch that is skipped because it was already applied, we get stuck in
> "cherry-picking" mode. Try:
>
>   for backend in apply merge; do
>     echo "==> Running with rebase.backend=$backend"
>
>     # new repo
>     rm -rf repo
>     git init -q repo
>     cd repo
>
>     echo base >file && git add file && git commit -qm base
>     # do this in two steps so we don't match patch-id
>     echo one >file && git commit -qam master-1
>     echo two >file && git commit -qam master-2
>
>     git checkout -q -b side HEAD~2
>     echo two >file && git commit -qam side
>
>     # start a rebase, which should realize that the patch is a noop
>     git -c rebase.backend=$backend rebase master
>
>     # see what state "status" reports us in
>     git status
>   done
>
> For the "apply" case, I get:
>
>   ==> Running with rebase.backend=apply
>   First, rewinding head to replay your work on top of it...
>   Applying: side
>   Using index info to reconstruct a base tree...
>   M     file
>   Falling back to patching base and 3-way merge...
>   No changes -- Patch already applied.
>   On branch side
>   nothing to commit, working tree clean
>
> So we complete the rebase, and git-status shows nothing. But for the
> merge backend:
>
>   ==> Running with rebase.backend=merge
>   dropping f8b25a2cd2a3a0e64d820efe2fcbae81dec98616 side -- patch contents already upstream
>   Successfully rebased and updated refs/heads/side.
>   On branch side
>   You are currently cherry-picking commit f8b25a2.
>
>   nothing to commit, working tree clean
>
> Oops. If I "git rebase --continue" from there, I get "No rebase in
> progress?". Doing "git cherry-pick --skip" clears it. I guess the issue
> is the continued presence of .git/CHERRY_PICK_HEAD.

Yes, definitely a bug, and new as of "the eighth batch for
git-2.26.0", a few days before 2.26.0-rc0.  I found a one-liner fix.

> As you can see from the output above (and the earlier snippet, if you
> run it), there are also a bunch of minor stderr output changes. I think
> these probably aren't worth caring about.

Agreed; also, these output differences are already documented in
"Behavioral Differences" of the git-rebase manpage.


Thanks for the careful reports; new series up at
https://lore.kernel.org/git/pull.722.git.git.1583903621.gitgitgadget@gmail.com/
to address the issues raised.
