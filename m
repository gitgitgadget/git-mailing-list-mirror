Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB727C48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 19:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01BD61992
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 19:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhF0T45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 15:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhF0T4y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 15:56:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C491C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 12:54:30 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a16so21796665ljq.3
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 12:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6mh7Od7ceZPIfC1ytIeaXYtGQSSW9CsAE5Xm3vhEC8=;
        b=HMWtKyjYMoeER/NZoltP4ecHxHyGFEyKFjYccQOS+f9ezcTz5VWVUCZVie/mpFv19f
         cQ070sgyG3ycO2DGxLIA8ZlA01GrtQzr5Z56x9UeROPuUPssebZUn7AKoZDEEpzCFi2Z
         Q6FvKu2QJVyw1XBzzCSyq5cb4KhuN1jtuCjMdXXBRUIkoHPZQ+1nZZzV+lvA9gOqyCMu
         8IU1kgDJYa1zY4r1ERCfgRhAWQHOfN4MZ10v3qhdond7I8tOBfoTuVCVJdg8D1hNU0CD
         SfimBBXyAPhT+9SoICG6bLhoWrc/eXkJ2Re21PY0H2gbIBSg/IcT6Xzb27xc98RgiPUL
         M/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6mh7Od7ceZPIfC1ytIeaXYtGQSSW9CsAE5Xm3vhEC8=;
        b=O0EPZ9RoBTmaMrZpPT0tEdyrExRPk5c1Pq4muvByKT6AvitrsHsP4abZZcRgCGOJV8
         TOYLTL9rtmnNJZ4Dv1A3+sJN+iq6Ci/IHrooLM8rHx5IyWqHtJLCZsP6ntgg4wrlHg9f
         uo69wJKzGKCoRjMoLoOrTnA8wF8ieR2XeaRcH7/hEQwFTcX1gvAvbYHldIf0tPAJKvFL
         dka6J4Jw//o5KVh4EjydqhVDnHQK0XW8h4OksiG+cUF1RIXkaXaI8lWQAk4Zl5LH0R2x
         rzTYkQ8UtjEIdx1a3gDdmOJorstCIki3pUIS+2ym4ZoXyznCliMXz/eMrspk3zUlkDmI
         66cQ==
X-Gm-Message-State: AOAM533SsgFgK/t80ihV7sdgkJB+L8W55pP6l2c4TJ1D2dqt9fxVHyFt
        FDw5Ydx6jWl6tI/hEvxkhTt72FFJ2xE6FD9llqY=
X-Google-Smtp-Source: ABdhPJzFU1XocNFr97qIn4D1+sW4V8z9IAHTvD4DyGIqAt/oWnoV4WMuptXIK3VEDbrYUnabWfV2+Bv9U9AuNvuL5pE=
X-Received: by 2002:a2e:502:: with SMTP id 2mr17152616ljf.36.1624823667609;
 Sun, 27 Jun 2021 12:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210627000855.530985-1-alexhenrie24@gmail.com>
 <CABPp-BGko7BP6ZMyRKwKrv0xz7FM9ehe67HSAtzgHF9eV2TD3A@mail.gmail.com>
 <60d7fbb770397_b8dfe2087d@natae.notmuch> <CABPp-BGXQ4vbFf6Gx21X-Ms+1VQsZfod1waNJZQxVmB7b-gD7Q@mail.gmail.com>
 <60d8ab7fe0761_ba5a2208b@natae.notmuch>
In-Reply-To: <60d8ab7fe0761_ba5a2208b@natae.notmuch>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 27 Jun 2021 13:54:16 -0600
Message-ID: <CAMMLpeQaY0z_baVQspJhAX0wanaJwneFoM5rG=xwFUmLEE-QaQ@mail.gmail.com>
Subject: Re: [PATCH] pull: abort by default if fast-forwarding is impossible
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 26, 2021 at 7:34 PM Elijah Newren <newren@gmail.com> wrote:
>
> Thanks for working on this.

Thanks for all the feedback. I will incorporate your suggestions about
the commit message and documentation into the next revision, whenever
that is.

On Sat, Jun 26, 2021 at 10:12 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Also, a bunch of tests are broken after this change:
>
>   t4013-diff-various.sh
>   t5521-pull-options.sh
>   t5524-pull-msg.sh
>   t5520-pull.sh
>   t5553-set-upstream.sh
>   t5604-clone-reference.sh
>   t6409-merge-subtree.sh
>   t6402-merge-rename.sh
>   t6417-merge-ours-theirs.sh
>   t7601-merge-pull-config.sh
>   t7603-merge-reduce-heads.sh
>
> If you didn't mean this patch to be applied then perhaps add the RFC
> prefix.

I actually did run `make test` before sending the patch, but when so
many seemingly unrelated tests failed, I foolishly assumed that they
were pre-existing failures. I should have run the tests on master for
comparison, sorry. Or at least put "RFC" in the subject instead of
"PATCH" as you suggest. I sincerely apologize for my lack of due
diligence and I know that I need to do better at self-reviewing
patches before sending them.

> Alex Henrie wrote:
>
> > +           "You can replace \"git config\" with \"git config --global\" to set a default\n"
> > +           "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> > +           "or --ff-only on the command line to override the configured default per\n"
> > +           "invocation.\n"));
>
> Can I?
>
>   git -c pull.rebase=true pull --ff-only
>
> `--ff-only` doesn't seem to be overriding the configuration.

Ahh, so /that's/ what you meant by "3. Fix all the wrong behavior with
--ff, --no-ff, and -ff-only". That does seem like something worth
trying to fix before making the switch.

On Sat, Jun 26, 2021 at 10:16 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
>
> > The code changes look good, but you'll need to add several test
> > changes as well, or this code change will cause test failures.
>
> Wouldn't you consider sending a patch without running 'make test'
> "cavalier"?
>
> > Thanks for working on this.
>
> Such a completely different tone for a "cavalier" patch depending 100%
> on the person who sent it. Weird.

I'm trying to make things better, as I'm sure you are as well, and I
know that I make a lot of mistakes and need the help of more
experienced contributors like you. So please be nice, even if others
are mean to you, because regardless of whether these comments were
directed at me, this kind of comment just makes me feel like giving
up.

On Sun, Jun 27, 2021 at 10:46 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> I don't throw personal attacks, nor do I chastise contributors for
> attempting to improve the project. That's your department.

"That's your department" is a personal attack. How about we all go
spend some time enjoying the weather, and then get back to working on
Git problems later this week.

-Alex
