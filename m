Return-Path: <SRS0=73cz=AB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E3CC433E0
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 20:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDFE24697
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 20:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fITm3UAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgFTUbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Jun 2020 16:31:47 -0400
Received: from mail-vk1-f177.google.com ([209.85.221.177]:33011 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgFTUbq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jun 2020 16:31:46 -0400
Received: by mail-vk1-f177.google.com with SMTP id p187so3092823vkf.0
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 13:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otR2ngT5yYLKCJrx1zhVBFCg3nQysTjkWNUYwlV61Hg=;
        b=fITm3UAe2SkYMlj+KskuZf9D+ShWG9LDpizvQVOlRXjSwAGO30j5i+omKDM+6bxb1S
         vdrQPMDNZcFBWdmWn38/0yarNxp+q+cmO99fZ58HWSehfffkgD+a9FP7OgbPi4f6qYS4
         D3GHOxXp2LRhS9lk84ZCYL3sfjjMjBvDSvABuIK04QewFqpHNVNP8t7T9RDOQfKg1D3z
         DlQS8qWpKLfV8mpLk6tBWnvfbPpjlkmze+5VqSJJfYfn/M7lcvyjnAUt1DxFH926BTbN
         6PxU9BO06kl+PluY5hC5eZKJR5UkMUAcCl5CyGeWg9bPLjJtrSUCh59pHqQp1pEjyYoc
         J6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otR2ngT5yYLKCJrx1zhVBFCg3nQysTjkWNUYwlV61Hg=;
        b=qoqK9MjRIto2YdK50nrPn3MZ3U1G2j+MC8uV2oS2lG6wMitVrtEoh+Y/PmTCGmnYTH
         aF6qe41foFP4iflgE9dHKJBCRh6YqY7Z8xNnPDtUCu+gWU4BFwxK39RJOlRhZ9dULX0D
         jTHmYtuPiQKF03cFTzSCwNvDdOHLGgGOyskeXAubvUaMIjdh6A/3OVfV+VGQlEMB84li
         ++RzK64iI64wkjxwv4BbN6gbj5jio9doOEXxHiq9xreAQoRSLllntMzCmsyOkUnvn2MM
         clLpq3ibz3S+0VcgYGQOepj6ARw5UeiOmlHHFPMs6HfFc9zyfTOiIN6sZ7h7oMeDc4Ss
         Clxw==
X-Gm-Message-State: AOAM530ZFVrUsAVNT6u7JuFNSn15mzWSYaR72IvhfrUWDyco0zNnRez2
        0Gz0L12Y+i4/7BsZvbPp+lR7ThOS3EIE8axcmYO4bWUn
X-Google-Smtp-Source: ABdhPJxEGlqp/9DYy8bJhJnOylU7PUuxmujR/8o88iLFGLhgasq2sudBci4gMs5xCIY65sUNBTExWlUOBoYhOLr0kHg=
X-Received: by 2002:a1f:9508:: with SMTP id x8mr10986085vkd.47.1592685045499;
 Sat, 20 Jun 2020 13:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <CANtMP6qbX_U_0sWtUvNQVtMboMLJshsHc=n-5eA4_XXNGEnzLQ@mail.gmail.com>
 <xmqqo8pdekqu.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8pdekqu.fsf@gitster.c.googlers.com>
From:   Solomon Ucko <solly.ucko@gmail.com>
Date:   Sat, 20 Jun 2020 16:30:08 -0400
Message-ID: <CANtMP6o8025ZcFWZ081jgHp8dykcBje7QCQh-MtzwSz4CKuSSg@mail.gmail.com>
Subject: Re: reset --merge documentation typo?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 20, 2020 at 12:59 PM Junio C Hamano <gitster@pobox.com> wrote:
> > The documentation for `git reset --merge` states:
> It is talknig about `git reset --merge <commit>`.

Yep, that's what I meant to say.

>     I am on the commit at `HEAD`; I want to move to <commit> as if I
>     did "git checkout <otherbranch>", updating the files in the
>     working tree to that of <otherbranch> except that if I had local
>     changes from `HEAD` for a path, and the path is identical
>     between `HEAD` and <otherbranch>, carry my local changes along,
>     but I am not flipping to a different branch---instead I am
>     resetting the tip of the current branch.
>
> It allows the user to pretend as if the user started making these
> local changes _after_ "git reset --hard <commit>", on top of
> <commit>, and that is only possible because the command makes sure
> that the paths involved in these local changes are the same between
> `HEAD` and <commit>.

That makes sense, thanks.

> > Where it says "`HEAD`", should it say "the index"?
> No.

I wrote a simple bash script (let me know if I should send it) to test
the behavior of `git reset --merge <commit>`, and got the following
results. I hard-coded the combinations; did I miss any?

    (working tree, index, (HEAD), target commit => resulting working tree)
    AA(A)A => A
    AA(A)B => B
    AA(B)A => A
    AA(B)B => B
    AA(B)C => C
    AB(A)A => abort
    AB(A)B => A
    AB(A)C => abort
    AB(B)A => abort
    AB(B)B => A
    AB(B)C => abort
    AB(C)A => abort
    AB(C)B => A
    AB(C)C => abort
    AB(C)D => abort

It appears that the file contents in HEAD have no effect on the result.

Also, the AB(A)B => A case only seems to make sense with "`HEAD`"
replaced with "the index" in the explanation, since the version in the
working tree matches the version in `HEAD`, but is kept anyways, since
it differs from the index's. Since the index's file matches the target
commit's, the operation is not aborted.

Same thing for the AA(B)B => B and AA(B)C => C cases: the working tree
differs from `HEAD`, so the working tree's version should have been
kept, but instead, since the working tree matches the index, the
target's version is used.

FYI, I'm testing with git version 2.20.1. Was this behavior changed recently?

Solomon Ucko
