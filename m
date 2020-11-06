Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D55EC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 20:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A62208C7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 20:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7k+vqNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgKFU1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 15:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgKFU1T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 15:27:19 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F9EC0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 12:27:19 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id k26so2685435oiw.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 12:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyrwaVqw8YlSQNsj0OhCyu9BnKiWdXUXu301OGfX1a4=;
        b=k7k+vqNe0auoCVb9eayC5QVZYigzIIoMK1NpUCw0kgW5crPdr542KmfLshXHp56U72
         lWlYZDQlJwG+6ndwB5Udwz9mgYNJhQhuZOzOxuS1X+b4BYX/9UQmHs8hjETCS3Sr5GAs
         wxn9xD1MCU3CJJepfiC8v5zMxYbWxK1hyvw1riuM0ItsH46gvb/cJsszzHK60Pom7Qqj
         nwT95bpwJEFUeD1RM4/rZ+cUk9khle4GgpcaFYdvnU5tV7BfjGB+CzvU9CRvSSE38A07
         Iq/5p11CDoxN/uzJXV0s57VcURcorD6tJe+sYdHGAy+lre0w6Jh9TP3UcgTBzpdh5+h/
         nShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyrwaVqw8YlSQNsj0OhCyu9BnKiWdXUXu301OGfX1a4=;
        b=jTlgS5OtmabfGKLCaROMyJy+YPZ4tZlcwE/hBfwAFLbDQY6/vXekJHfnuS+E0sCBFg
         JyC65PV5wymTEV4vVoGtRzVe09wcAFWhHdU7r0IELpPEIolMHNdUI2pnBc6sv5ocDUAs
         dL5MyVs652qpHcn2n5YUqtVy3Ar/fHbscSCnahIw8L+NViJz9dyrHrn6aoy9v0UqWm65
         6V2XwlahBE3y2yg9S/xkP1/BMCMyUbnp6w+NeXlvrmgE/aZbgJc1/Qw9HW/a3Bu2ttRM
         XgEbdDA2ZXmF5fEgJ0NDdvRCJblBnxDYjR4Fgd6WBh56meNcLg2JdFb76MdF1deygKkb
         MNSw==
X-Gm-Message-State: AOAM531/c1ZI8Bewz6kF5vkLKC5GgtnNrKebYTKIPqkIqvRJ8KxKfnKr
        X3TU0HKoDr0uHmHsacfdgzxGuOlINhbirHuvK+U=
X-Google-Smtp-Source: ABdhPJxbZNTWPEbK01QFSGrBQAr6w2Aa+6LUbO5RsshOV0uxovn5tMrHnxNtXLOhlCHtNaVnMoLCJs+xeoLd7BZXvzU=
X-Received: by 2002:aca:b4d7:: with SMTP id d206mr2290295oif.39.1604694439011;
 Fri, 06 Nov 2020 12:27:19 -0800 (PST)
MIME-Version: 1.0
References: <1526558917.20201106203213@yandex.ru>
In-Reply-To: <1526558917.20201106203213@yandex.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Nov 2020 12:27:08 -0800
Message-ID: <CABPp-BGAJiaU5aeC3sGvp3znQw1esrn9c19gyOZQBymYvNFCaw@mail.gmail.com>
Subject: Re: git rebase/git rebase --abort cause inconsistent state
To:     Eugen Konkov <kes-kes@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 6, 2020 at 10:41 AM Eugen Konkov <kes-kes@yandex.ru> wrote:
>
> Hi
>
> I try to rebase, get conflicts. So I decide to --abort
>
> After --abort I expect state before rebasing, but I get conflicts.
>
> I  suppose this  is  because `git rebase` switches to not branch and
> --abort can not return to branch I was on before rebasing
>
> Is this a bug?
>
>
>
>
> kes@work ~/t/lib/MaitreD $ git rebase dev local/dev
> Created autostash: 566876c8
> warning: Cannot merge binary files: share/ChangeAgreement.docx (HEAD vs. f2442d9a... Update Docs.pm)
> Auto-merging share/ChangeAgreement.docx
> CONFLICT (content): Merge conflict in share/ChangeAgreement.docx
> error: could not apply f2442d9a... Update Docs.pm
> Resolve all conflicts manually, mark them as resolved with
> "git add/rm <conflicted_files>", then run "git rebase --continue".
> You can instead skip this commit: run "git rebase --skip".
> To abort and get back to the state before "git rebase", run "git rebase --abort".
> Could not apply f2442d9a... Update Docs.pm
> kes@work ~/t/lib/MaitreD $ git rebase --abort
> Applying autostash resulted in conflicts.
^^^^^^

Looks like you have rebase.autostash set to true and have some
uncommitted changes before your rebase started; it looks like it was
the reapplying of that stash at the time you abort is the thing that
failed.

According to the rebase docs for the --abort flag:
"If <branch> was provided when the rebase operation was started, then
HEAD will be reset to <branch>"
which suggests that the abort should switch you back to the original
branch, where the application of your local changes should be safe.
I'll cc the two most prolific committers to builtin/stash.c to get
their comments.

Some questions they may be interested in, though:  Is this bug
repeatable?  Can you find steps to reproduce and/or share your
repository?  Can you verify that you don't get this bug when
rebase.autostash is off?  What do your local changes before the rebase
look like and what are the nature of the conflicts afterwards (how
does a "git diff" before the rebase compare to a "git diff" after)?


> Your changes are safe in the stash.
> You can run "git stash pop" or "git stash drop" at any time.
>
> Here is a tree before rebasing:
> > a9597aaa (HEAD -> dev) Use DateTime with correct timezone
> > 822ff801 Add link to Podio into mail
> > 65575afe Update Docs.pm
> | < e0003861 (local/dev) Update podio.t - test person contacts
> | < 28ab8630 Create docdate if agreement is new and update test for that
> | < 208ead68 Specified checking of person
> | < f2442d9a Update Docs.pm
> |/
> o 6d9c2159 (xtucha/test, xtucha/dev) Leave only one example in month
>
> Here is conflicts:
> HEAD detached from 142c1b15
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
> 1       modified:   ../../Makefile
> 2       modified:   ../../etc/maitre_d.development.conf
> 3       modified:   Command/bank_statement.pm
> 4       modified:   Command/invoicing.pm
> 5       modified:   Command/reminding.pm
> 6       modified:   Controller/Cart.pm
> 7       modified:   Controller/Saldo.pm
>
> Unmerged paths:
>   (use "git restore --staged <file>..." to unstage)
>   (use "git add <file>..." to mark resolution)
> 8       both modified:   Controller/Podio.pm
>
> $ git --version
> git version 2.28.0
>
>
> --
> Best regards,
> Eugen Konkov
>
