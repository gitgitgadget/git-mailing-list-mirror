Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A30C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985B361156
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhGQPkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 11:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbhGQPkP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 11:40:15 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DDFC06175F
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:37:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w127so14780015oig.12
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AM6ARNVvmd4mL1q2Swe4QJD5qYALiWRj6SeFuGZ0Sq4=;
        b=tCHybB5qQ6yjHiz1Z71Iu+eBLkWsb4fiU1WPU0aeajctqoxAnJnoBA22cdNE4qUdAz
         0Oux1rN8wH/rZQKxclcMhKPDiSRmss5l93mFmJLXgBejyHAYTfTihCpjzm9VOPg5HU0f
         Tdb6gRi8zcGwN6SOGINeYkNIWhfpzIlV1y/TDxkN3m8B1ummFNARLaqSJ2Evngf5dNEm
         aFE41vt662Z7EvUJHArIvcAezGuMxfA1wy8zO7tzjCiWvVy8dVPVBMOCkA246S6lOmwF
         t/Qv+5YVPptraloCN6DIVOB1B/TGoPz34GzWzsk7v28QVoluABev2Olss/OpQGIfrW0F
         hXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AM6ARNVvmd4mL1q2Swe4QJD5qYALiWRj6SeFuGZ0Sq4=;
        b=DCM9zP72pgxuLzqioKdWHGzvvzQ/ZRt+HBckY81BBljbgGHdLLYPCJsKdtypljBEBz
         aHTh30EFOBWdX7DAbjIHUTqAFPQHzlEW73xpwLa806ua0XxQqYFRpOBGtvag1ZrOUO1v
         waikD9bvt+Bg8Y6V5MWTMYzpo+Tg8NPXVh4V7vyy7qGncZ+o85kKMZZHWI+JnhpuueMa
         NziI86U3eioa01DEduItU9/a7Ul+OX99lH7xiHX/IF1zfzzxKc7WfZCglFx2pqrLGMyR
         tb7NV+n2NKvRDWe1BOrrtjFHhFvG1K9ICIYKRiBq2uNrrzUZEniXtb9o4ajwhgasvPt0
         RtiA==
X-Gm-Message-State: AOAM532l+0DvITP02JlxoNlQYeb+SyC8dYexcyZSAErmLu0Au85+Aj9D
        7NO2N0TTN8/Gwaa3/jJpSwQI/S80H2xw/HzkItk=
X-Google-Smtp-Source: ABdhPJxjbWqaz8Vak0Jod35WZCUlJDobaOrSnoVXs65Xn6wRw85GwOOQyCDalTVTv7xe3OoMQVn2uqESfIRO6BM11BY=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr16056884oie.167.1626536238583;
 Sat, 17 Jul 2021 08:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
 <CABPp-BF_i1QRCXaeKzqoc6Q2=3un-wku7aKUEdBbXfeVfTG8xg@mail.gmail.com>
 <b362c428-eec9-39e3-55a0-0738431e1d98@gmail.com> <c127ceed-10fd-9ad0-e858-db79bec0cf8d@gmail.com>
In-Reply-To: <c127ceed-10fd-9ad0-e858-db79bec0cf8d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 17 Jul 2021 08:37:07 -0700
Message-ID: <CABPp-BGCnV-xHH-+S58pqFFhPbPj_0Rt=_QUf_ShAbTCyW9deA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Sparse index: integrate with commit and checkout
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 6:59 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/12/2021 2:46 PM, Derrick Stolee wrote:
> > On 7/9/2021 5:26 PM, Elijah Newren wrote:
> >> On Mon, Jun 28, 2021 at 7:13 PM Derrick Stolee via GitGitGadget
> >> <gitgitgadget@gmail.com> wrote:
> >>>
> ...
> > Further, I expect it to be simpler to modify the behavior
> > here to match the full checkout case than to make the
> > sparse-index case match the normal sparse-checkout case.
> > The "natural" thing would be to keep the staged "folder1/"
> > directory, but that would present as adding all contained
> > content, not just the single staged entry.
> Taking a closer look at the full checkout case, I discovered that the
> 'git checkout df-conflict' command succeeds in the full checkout case if I
> apply it directly to the 'master' branch. In that situation, it completely
> removes the staged change to folder1/edited-content! This seems like
> incorrect behavior, and has nothing to do with the sparse-checkout feature.

I was not able to reproduce.  Do you have other modifications to git,
or is there some other special setup required to trigger the bug that
I am missing in reading the paragraph above?  Here's what I see:

<Add an "exit 1 &&" right after "init_repos &&" in the 'diff with
directory/file conflicts' test, run until first failure, then:

$ cd trash directory.t1092-sparse-checkout-compatibility/full-checkout
$ git reset --hard
$ git checkout rename-in-to-out
$ echo more stuff >>folder1/edited-content
$ git add -u
$ git checkout df-conflict
error: Your local changes to the following files would be overwritten
by checkout:
folder1/edited-content
Please commit your changes or stash them before you switch branches.
Aborting

This looks like the expected behavior to me, and is what I'd also
expect from the sparse-checkout and sparse-index cases.

> It just happens that a sparse-checkout will have a _different_ kind of
> incorrect behavior!
>
> However, when adding the test on top of the ds/status-with-sparse-index
> branch, the full checkout case matches the sparse-checkout! I bisected
> this to the additions of files adjacent to folder1/ (folder1. folder1-,
> etc) in e669ffb (t1092: expand repository data shape, 2021-07-14). If I
> switch the test to conflict on folder2, then I get the strange behavior
> that I was noticing on 'master'.
>
> Some very subtle things are going on here, and they don't necessarily
> involve the sparse index. Adding the sparse index to the mix creates a
> third incorrect behavior to this already-broken case.
>
> If we agree that the correct thing to do here is to reject the merge and
> fail the command, then I can start working on making that change in
> isolation (because _none_ of the existing behaviors are correct).

Yes, rejecting the merge is the correct behavior.  This is implied by
the existing documentation for both the --merge and --force options to
checkout.

> That leaves a question as to whether we should hold up this series for
> that reason, or if I should pursue a fix to this kind of conflict as a
> forward fix on top of it. What do you think, Elijah and Junio?

I only dug in and found the sparse-checkout/sparse-index bugs because
the D/F changes you made to twoway_merge() looked clearly wrong to me
and I was trying to find a case that would demonstrate it and make it
easier for you to fix up.  I still think the patch is wrong and that
it adds a bug.  If you can drop that patch, and still get correct
behavior in your tests, then I think we can ignore other bugs in this
area, but I'm not happy with that particular patch.  If you need that
patch, then it needs to be corrected, which probably means figuring
out all these bugs.
