Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A09AC433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 05:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EE0613DD
	for <git@archiver.kernel.org>; Fri,  7 May 2021 05:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhEGFnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 01:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhEGFnp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 01:43:45 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC00DC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 22:42:46 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso6991342otg.9
        for <git@vger.kernel.org>; Thu, 06 May 2021 22:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HOfOCMXtT2pH8MWkc3B7IFC6aJzUp2mHcjiAxZgqIDU=;
        b=J/zCU63kTUWdgr2SJfPn9C5SIZ3d1KIYw+w4/X6TPPkIWbdLe6UOvvqOkT6bPmFwd5
         iwwdroS/HheRlHoiZIiAvZR1pnXgKRuLQgxHLPTkB412BybT/XQLBwOVE+vuEYOTLLfA
         hcJXqOXKY089VtaWsRA6LuYm/zbfZHezG/+1WLKIHI3jLgChkoeDpyY+oUWdLPYvkJA9
         wKLFMI6vI4A0pOZNIxxETGLvr2Dh2sQQEX+ah9C3YhYB0TQhBJpl0qOP50aQ9dvQJ6Is
         5gTad8gNJqeuPLbd5n3O0VceEjBEJWhYdC5QMan/vUOiV296thYuTsxh62tJ5kKBB2fU
         alag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOfOCMXtT2pH8MWkc3B7IFC6aJzUp2mHcjiAxZgqIDU=;
        b=PsoxYWHaxtNmA2NBD0DILqglSgW69cA98PbGtHNYx/Em8vZpa27YyGwAkVQ3XNtVRF
         78KnEIV9UBZNNEpgxR5cLmK89/cl5v5ICUhxeK8BPp9qaMb1PkQQTbeBv4MlWGXZoqtR
         h9mShhlvzDXFb8vjNi9XpryR+Sn9l0LJz+VcSy86FYmdkFIOx3XfQCUM0UCdJtLuugc5
         7hgq3cpytfCOmkkjsLDJl8CG3LUBqBuuPOHZFv7bLrwdeGnhcbPGGSiI4TOixe7JTKPL
         nUziN8FCW7vnOmAyMpoX9gqSJ/ERBvkY97WvvzV+nIGU8xZNKza7m7zLLSsjb0WEnykV
         EX/Q==
X-Gm-Message-State: AOAM531+yEjM8O9aO2VMOd077fWjzNdpgNSFx1SrwEVlQNrBiQzxEN1W
        n53tVjdq7IV6UTCtJkQRB39GJjtMno7UTAJLg/M=
X-Google-Smtp-Source: ABdhPJyUXoyXcOPo22ceoVKyOx8xOaLnAYNip8A/IBtajYdmOwweaO4fP8+FYMsPb06jdUBJ+gICWLSzW2eH386yges=
X-Received: by 2002:a9d:7085:: with SMTP id l5mr6776203otj.345.1620366165656;
 Thu, 06 May 2021 22:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
 <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
 <CAPig+cTzvKhUaNEXwRAVwV1Vkb7jpHNkcOytEPq0Gg33TrJXNg@mail.gmail.com>
 <CABPp-BGzUBF8S8t3nixi3TCkiBe7oS1fQ5cNCozicb20iZxshA@mail.gmail.com> <CAPig+cR3Z1dy8ibLEr+64C57dgrivPbgTveirnmSt-5D1wo59Q@mail.gmail.com>
In-Reply-To: <CAPig+cR3Z1dy8ibLEr+64C57dgrivPbgTveirnmSt-5D1wo59Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 May 2021 22:42:34 -0700
Message-ID: <CABPp-BFYpGYvy1wNdZBGObcRuVHMP=MxZtmikugA2hOUEHb-=w@mail.gmail.com>
Subject: Re: [PATCH 1/5] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 6, 2021 at 10:32 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, May 7, 2021 at 1:01 AM Elijah Newren <newren@gmail.com> wrote:
> > On Thu, May 6, 2021 at 9:27 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > Is this expensive/slow loop needed because you'd otherwise run afoul
> > > of command-line length limits on some platforms if you tried creating
> > > the entire mess of directories with a single `mkdir -p`?
> >
> > The whole point is creating a path long enough that it runs afoul of
> > limits, yes.
> >
> > If we had an alternative way to check whether dir.c actually recursed
> > into a directory, then I could dispense with this and just have a
> > single directory (and it could be named a single character long for
> > that matter too), but I don't know of a good way to do that.  (Some
> > possiibilities I considered along that route are mentioned at
> > https://lore.kernel.org/git/CABPp-BF3e+MWQAGb6ER7d5jqjcV=kYqQ2stM_oDyaqvonPPPSw@mail.gmail.com/)
>
> Thanks, I read that exchange (of course) immediately after sending the
> above question.
>
> > > > +               while test ! -f directory-random-file.txt; do
> > > > +                       name=$(ls -d directory*) &&
> > > > +                       mv $name/* . &&
> > > > +                       rmdir $name
> > > > +               done
> > >
> > > Shouldn't this cleanup loop be under the control of
> > > test_when_finished() to ensure it is invoked regardless of how the
> > > test exits?
> >
> > I thought about that, but if the test fails, it seems nicer to leave
> > everything behind so it can be inspected.  It's similar to test_done,
> > which will only delete the $TRASH_DIRECTORY if all the tests passed.
> > So no, I don't think this should be under the control of
> > test_when_finished.
>
> I may be confused, but I'm not following this reasoning. If you're
> using `-i` to debug a failure within the test, then the
> test_when_finished() cleanup actions won't be triggered anyhow
> (they're suppressed by `-i`), so everything will be left behind as
> desired.

I didn't know that about --immediate.  It's good to know.  However,
not all debugging is done with -i; someone can also just run the
testsuite expecting everything to pass, see a failure, and then decide
to go look around (and then maybe re-run with -i if the initial
looking around isn't clear).  I do that every once in a while.

> The problem with not placing this under control of
> test_when_finished() is that, if something in the test proper does
> break, after the "test failed" message, you'll get the undesirable
> alpine-linux-musl behavior you explained in your earlier email where
> test_done() bombs out.

Unless I'm misunderstanding the test_done() code (I'm looking at
test-lib.sh, lines 1149-1183), test_done() only bombs out when it
tries to "rm -rf $TRASH_DIRECTORY", and it only runs that command if
there are 0 test failures (see test-lib.sh, lines 1149-1183).  So, if
something in the test proper does break, that by itself will prevent
test_done() from bombing out.
