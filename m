Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE2BC433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 05:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578F86113E
	for <git@archiver.kernel.org>; Fri,  7 May 2021 05:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhEGFCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 01:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhEGFCD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 01:02:03 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE56C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 22:01:02 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so6958206oth.5
        for <git@vger.kernel.org>; Thu, 06 May 2021 22:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CkC6uxXkLFI9gWdi5JaXY8B4ANRqmEi3Rq7Fc1fr2c8=;
        b=CTzQRAdd7kufEj+9KeTCc9fDhsHuGLCj2ROcqtOkPh24BIS3dSLyk7sgoN1uAPPEGv
         6AtpjPNCVlQ4yfW8OsT1oKQAmk2V3j5REdhOZsmSvVFSc15eRYLGdjd63//TV/UM9aW7
         /gIdTM7uUpp5+BRML9mVb0JR8Jeittn7GUtQSpmgqc9ftBlyquKJXqB69l2HXX2VFyp5
         /84zmkg5UbfFA9Zy7x3U7nTRXopvLdF/rDM+k+402tJ5EcNBOb8E+iXEwgqz3o2h0deg
         6wMytJeumxfs9OT+6Z8mbzVm5iWvIZKbVtnAJlsjiwwF2rLofAoLqUwkTJFOoC5euqbO
         KCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkC6uxXkLFI9gWdi5JaXY8B4ANRqmEi3Rq7Fc1fr2c8=;
        b=O/pi8mY6HuiOMFA4g6r1Nso6JDnwaNW6b3Zd0z3eCkC2kDg+Sd82izoAIjj5m06iu8
         mfQx76RYKwrYc7aq1mCoCDnCFh47HNNH6Xt5AkXesq6Soir7SAwmygzypEF74eCV2sGq
         hQED7yL9ZB5s6n4eYkF+YQQ67/YZu1WBZSu4RUH7wdTh5vNNY1ihjtx6ga2BbrlWRNRj
         IuUHJ+p5BxJxtwB9y3aer94T91aVfHKeuF6IUYyC81y1ILlL68/p088rsA4ygBL2wS4z
         A4cieXtF6VnaB/hsjxjv0RB3S3cwQe3DlEP6S28L1tW3rmKIJA+8JSlLbPbNgud1Irov
         xChA==
X-Gm-Message-State: AOAM530kkx29DWS80ByKsMtA1pcvdxVJPR5yBeoFJQKXk6AjozOTzrHN
        FwfjEEDiXQKzLiquz0LqxevWHIlSeqV9rGoaHx4=
X-Google-Smtp-Source: ABdhPJxK6Yg8OkpF1gkvmzupL7dC2p6xbw2n9lfhSj22DyQSf/jsLfX8KFUmB+9iHbwXIXqbkshZ9ZEQnRhvTY2J6GM=
X-Received: by 2002:a9d:7085:: with SMTP id l5mr6664352otj.345.1620363660612;
 Thu, 06 May 2021 22:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
 <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
 <CAPig+cTzvKhUaNEXwRAVwV1Vkb7jpHNkcOytEPq0Gg33TrJXNg@mail.gmail.com>
In-Reply-To: <CAPig+cTzvKhUaNEXwRAVwV1Vkb7jpHNkcOytEPq0Gg33TrJXNg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 May 2021 22:00:49 -0700
Message-ID: <CABPp-BGzUBF8S8t3nixi3TCkiBe7oS1fQ5cNCozicb20iZxshA@mail.gmail.com>
Subject: Re: [PATCH 1/5] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 6, 2021 at 9:27 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, May 7, 2021 at 12:05 AM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > PNPM is apparently creating deeply nested (but ignored) directory
> > structures; traversing them is costly performance-wise, unnecessary, and
> > in some cases is even throwing warnings/errors because the paths are too
> > long to handle on various platforms.  Add a testcase that demonstrates
> > this problem.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> > @@ -746,4 +746,44 @@ test_expect_success 'clean untracked paths by pathspec' '
> > +test_expect_failure 'avoid traversing into ignored directories' '
> > +       test_when_finished rm -f output error &&
> > +       test_create_repo avoid-traversing-deep-hierarchy &&
> > +       (
> > +               cd avoid-traversing-deep-hierarchy &&
> > +
> > +               >directory-random-file.txt &&
> > +               # Put this file under directory400/directory399/.../directory1/
> > +               depth=400 &&
> > +               for x in $(test_seq 1 $depth); do
> > +                       mkdir "tmpdirectory$x" &&
> > +                       mv directory* "tmpdirectory$x" &&
> > +                       mv "tmpdirectory$x" "directory$x"
> > +               done &&
>
> Is this expensive/slow loop needed because you'd otherwise run afoul
> of command-line length limits on some platforms if you tried creating
> the entire mess of directories with a single `mkdir -p`?

The whole point is creating a path long enough that it runs afoul of
limits, yes.

If we had an alternative way to check whether dir.c actually recursed
into a directory, then I could dispense with this and just have a
single directory (and it could be named a single character long for
that matter too), but I don't know of a good way to do that.  (Some
possiibilities I considered along that route are mentioned at
https://lore.kernel.org/git/CABPp-BF3e+MWQAGb6ER7d5jqjcV=kYqQ2stM_oDyaqvonPPPSw@mail.gmail.com/)

> > +               git clean -ffdxn -e directory$depth >../output 2>../error &&
> > +
> > +               test_must_be_empty ../output &&
> > +               # We especially do not want things like
> > +               #   "warning: could not open directory "
> > +               # appearing in the error output.  It is true that directories
> > +               # that are too long cannot be opened, but we should not be
> > +               # recursing into those directories anyway since the very first
> > +               # level is ignored.
> > +               test_must_be_empty ../error &&
> > +
> > +               # alpine-linux-musl fails to "rm -rf" a directory with such
> > +               # a deeply nested hierarchy.  Help it out by deleting the
> > +               # leading directories ourselves.  Super slow, but, what else
> > +               # can we do?  Without this, we will hit a
> > +               #     error: Tests passed but test cleanup failed; aborting
> > +               # so do this ugly manual cleanup...
> > +               while test ! -f directory-random-file.txt; do
> > +                       name=$(ls -d directory*) &&
> > +                       mv $name/* . &&
> > +                       rmdir $name
> > +               done
>
> Shouldn't this cleanup loop be under the control of
> test_when_finished() to ensure it is invoked regardless of how the
> test exits?

I thought about that, but if the test fails, it seems nicer to leave
everything behind so it can be inspected.  It's similar to test_done,
which will only delete the $TRASH_DIRECTORY if all the tests passed.
So no, I don't think this should be under the control of
test_when_finished.
