Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90952C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657EA60FED
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhIKR3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhIKR3K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 13:29:10 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ACFC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 10:27:57 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s20so7929375oiw.3
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SwoL5iC4/DIb/1ZDKg5RNbEuJGDxoMx0jQVySZUK4r0=;
        b=oggvThR5REnQ5X3irkA+ESqFLNP7ml10iFKnoXB5KWQqvcdKEDg0XK+bGTXtfw8BkQ
         239R3iyKk0vQu5X6qtGSifYCG4uRSnEGb22F61N4dKRcn4ff4s7G6202oZdNq+jQnozI
         aN0JE6EFAdBEOCfvhtaCY/1HKGfMJHgtz0hqvYYEuYbykbqObROC6ZGG7ZQXUf5bRSgg
         ih+V5Dq80ofOfGM6RIxQ/VxvppD0FHS8Y0++DtOtDUbz1hHnf7+PyWrzS7ST5MkEjvfR
         uqEVKigw783iogozx4M+Ikxtkx1Z+jIZZBGYglR7UXHGDXrzsOAoM4R/xUeq5/RCjcHv
         HaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwoL5iC4/DIb/1ZDKg5RNbEuJGDxoMx0jQVySZUK4r0=;
        b=ftMDF6X1g+TmL4VH9IEtTTBV/F6DL4BX603VoEY2L380nI76czrvgrNDzSd2189mff
         338bp5dLj3nXOQkL4WQetH5JV6HaGImamiZbDlMunTKXotN933mQDNH4v6YDvAZMF0Az
         bQqUfClWTrKs03v/f9YxGf74pMrDWUWjx9G6l7XV/5/3sVv+tDP5PTgI8Sx8S012OYQ9
         p9L2llrCnvzFvg7URTU1jEdoBcDcIBbbmHQF9z1954SKMZI8XhsjMo48GHUF2bqJ62Rd
         bzstXQ0AlEZ4/dIdz5DpMih9c/QT1u6gMH5xjhf8uZiDZ0TqGQsH3OEEwgl75A8/AqpQ
         6HrQ==
X-Gm-Message-State: AOAM531Kn7Bx1mpSM5nPBIXIsjYPJVcPoDsfSXQfpxSgvN+2A06Hyu7X
        8Dq3pi4ndJ6uPW3ddeNm5zJSTkVAuxgLwppF5WLwNHH7RdI=
X-Google-Smtp-Source: ABdhPJxZu5sqrpiBb+fra2b6QuBjoyzlm0xSO5U5+DIFqKtqiLi/tZj5fUJir5gDpU+zA4L2mRI1djqGJ1DbpoNw5w0=
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr2454048oiw.31.1631381276457;
 Sat, 11 Sep 2021 10:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsfycqdxi.fsf@gitster.g>
In-Reply-To: <xmqqsfycqdxi.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 Sep 2021 10:27:45 -0700
Message-ID: <CABPp-BGR3dfJE7TZ+jkjDdWyeXYowmJhtoFaQ8_Abn=ZROhB5Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #03; Fri, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 3:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> --------------------------------------------------
> [New Topics]
>
> * en/stash-df-fix (2021-09-08) 3 commits
>  - stash: restore untracked files AFTER restoring tracked files
>  - stash: avoid feeding directories to update-index
>  - t3903: document a pair of directory/file bugs
>
>  Fix "git stash" corner case where the tentative change involves
>  changing a directory to a file (or vice versa).

I've got a v2 out to address all the feedback from Dscho, Stolee, and
you (https://lore.kernel.org/git/pull.1087.v2.git.git.1631269876.gitgitgadget@gmail.com/)

Relatedly, I also have a v2 of am-issues that hasn't been picked up
yet: https://lore.kernel.org/git/pull.1087.v2.git.git.1631269876.gitgitgadget@gmail.com/.
v1 was acked by Dscho; v2 has some fixes related to your feedback.

> * en/zdiff3 (2021-06-15) 2 commits
>  - update documentation for new zdiff3 conflictStyle
>  - xdiff: implement a zealous diff3, or "zdiff3"
>
>  "Zealous diff3" style of merge conflict presentation has been added.
>
>  Expecting a reroll.
>  cf. <CABPp-BE7-E03+x38EK-=AE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.com>

I just sent a reroll, since I did have some fixes from Phillip and
some new testcases, but it fails one of the testcases I made and I saw
another suboptimal case that I lost but would like to include.  I
still have this labelled RFC and it's definitely not ready.

I do plan to get back to it eventually, but am focusing more on other
topics, so you may want to eject this from seen for now.

> * ms/customizable-ident-expansion (2021-09-01) 1 commit
>  - keyword expansion: make "$Id$" string configurable
>
>  Instead of "$Id$", user-specified string (like $FreeBSD$) can be
>  used as an in-blob placeholder for keyword expansion.

Kinda disappointing to see mis-designs from CVS not only persist but
get extended.  Perhaps I'm just biased...

> * js/retire-preserve-merges (2021-09-07) 11 commits
>   (merged to 'next' on 2021-09-10 at f645ffd7a3)
>  + sequencer: restrict scope of a formerly public function
>  + rebase: remove a no-longer-used function
>  + rebase: stop mentioning the -p option in comments
>  + rebase: remove obsolete code comment
>  + rebase: drop the internal `rebase--interactive` command
>  + git-svn: drop support for `--preserve-merges`
>  + rebase: drop support for `--preserve-merges`
>  + pull: remove support for `--rebase=preserve`
>  + tests: stop testing `git rebase --preserve-merges`
>  + remote: warn about unhandled branch.<name>.rebase values
>  + t5520: do not use `pull.rebase=preserve`
>
>  The "--preserve-merges" option of "git rebase" has been removed.
>
>  Will merge to 'master'.

I'm not objecting, but I'm kind of surprised to see this after your
and Dscho's previous discussion at
https://lore.kernel.org/git/xmqqv939uis8.fsf@gitster.g/; I thought
it'd stay in next for a while.  Was this a mistake?

> * en/remerge-diff (2021-08-31) 7 commits
>  - doc/diff-options: explain the new --remerge-diff option
>  - show, log: provide a --remerge-diff capability
>  - tmp-objdir: new API for creating and removing primary object dirs
>  - merge-ort: capture and print ll-merge warnings in our preferred fashion
>  - ll-merge: add API for capturing warnings in a strbuf instead of stderr
>  - merge-ort: add ability to record conflict messages in a file
>  - merge-ort: mark a few more conflict messages as omittable
>
>  A new presentation for two-parent merge "--remerge-diff" can be
>  used to show the difference between mechanical (and possibly
>  conflicted) merge results and the recorded resolution.
>
>  What's the status of this one?

Well...you asked lots of good high level questions that I think you
felt I answered adequately.  I think that suggests the high level
ideas are at least okay.  It's also been tested in the wild for months
(and with the additional change of making `log -p` imply
--remerge-diff), so that suggests it won't blow up.

But as for actual patch review, the only one who has taken a look is
Sergey, who reviewed the diff-merges portion of patch 6 and was happy
with it.

It'd be great to get some more of these patches reviewed.  In
particular, if someone had time for just one patch, I'd really like to
see someone review one of these:
  * the tmp-objdir.c changes (patch 5)
  * the integration of all the pieces in log-tree.c and revision.c (patch 6)
  * the ll-merge.c changes (patch 3)
