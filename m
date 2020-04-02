Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D77C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 03:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46842063A
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 03:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5orHp8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbgDBDCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 23:02:46 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:34911 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732498AbgDBDCq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 23:02:46 -0400
Received: by mail-oi1-f173.google.com with SMTP id t25so1582672oij.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 20:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DS6WxF8ga71LLCtJiu44yEL2TJ78UeZz1yeYhuGEjSE=;
        b=k5orHp8JL5ccGP8DeDdpx0ybzq8fqbkD7po9hCCh7n1BYJPT9PRiQped7bk3XppN86
         5HWRh6uiAo3AjJ1QFo9DzEr0o8o/PYD3ICnie+0427E7B7GgOrEnAz+0vckxh2zh9ynM
         jgPkKPxaeTD2KP686RMLV1C9C+SRdEAtEbLEZlDg2wJZeTpgVFd0xmThUMzqI9xx4oaB
         VXzqAX1x1Ao+EyL6WSl7N4H0GVXMwRk0MlknmheF1l6SUribFWRdvwLaM6UUqgxK/rsd
         6GbHDDTzvb1sO5qf2TXrbao7+ysSYoLm8+dHJBgzbg4er41waHNmnoQdY/PiPGVOnh6j
         XDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DS6WxF8ga71LLCtJiu44yEL2TJ78UeZz1yeYhuGEjSE=;
        b=tXIzn1rhr0UQC5NKAVK6P1bPqBMgU92w+6Oc8I9TKFGtigZUK41EwP3BpszSinjZFL
         i8xGyZfWimwuwYGk5vamE30EiAGKxEndX67BF2SbSZ7g0WaZu6RPaF63cU4SFQG9QNx1
         qXdmd4U9Iw9Y+Gj9mQs34y3ihCXgL2GXqC+Ec9OhA2dUnaRmpkPfFKzbSpt4cyRDOfs0
         E7RA+UDzVQJj8QQBuhOX1UtalDZ/F+CoeCjp1ynYIOCFtc2wc0ZdQBVNgDnil8UZwro8
         0xLCFoer88I/zd1nik1fvXLm6gUzGYASU4hnVJrePCD3h3QZ4SsnzkDNzXRyokWsStMC
         fKLg==
X-Gm-Message-State: AGi0PuaxAYSbyJIpya1SCMZzzeMhuGBOSNaIDehw3gkS3nkpYersr1jX
        9KETIbjOqDn+ZYxsm+9FERgs4f4ssN9g8iZ7TXo=
X-Google-Smtp-Source: APiQypLIturQBwK4LaUYHj3qR1TjsXzJUS3h/NAGLESZdr1G9H8EOyYvCBa2hvyFvV6GZdnVh//hI5rwZFFv/t6Tduw=
X-Received: by 2002:a05:6808:12:: with SMTP id u18mr800989oic.167.1585796565065;
 Wed, 01 Apr 2020 20:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-FUjCefwGjvCcwmjO=GADd5S0cU_=S_tVy4nMaj07+rQA@mail.gmail.com>
 <CABPp-BFDx2j5Kf584Myb6wuEq5G7wbogJ2vos8OTDsh+ySfk8w@mail.gmail.com> <CAGyf7-FTNOgDbWEoniaOWueWGXwH6=0gj_FzDqP35422vxhYEA@mail.gmail.com>
In-Reply-To: <CAGyf7-FTNOgDbWEoniaOWueWGXwH6=0gj_FzDqP35422vxhYEA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 1 Apr 2020 20:02:34 -0700
Message-ID: <CABPp-BEYqmU76yqnaC3AdgACpfWeCCytX_ixnB94xQk_4KnK_w@mail.gmail.com>
Subject: Re: Rebase-via-merge behavior difference between Linux and Windows
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryan,

On Wed, Apr 1, 2020 at 6:16 PM Bryan Turner <bturner@atlassian.com> wrote:
>
> On Tue, Mar 31, 2020 at 11:35 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Tue, Mar 31, 2020 at 4:25 PM Bryan Turner <bturner@atlassian.com> wrote:
> > >
> > > Using our merge test repository[1], one such test performs the following steps:
> > > * Unzip bare repository
> > > * `git clone --shared -b branch_that_differ_by_empty_commit_trgt
> > > <unzipped> rebase-test`
> > > * `git rebase -q --no-verify 7549846524f8aed2bd1c0249993ae1bf9d3c9998
> > > 298924b8c403240eaf89dcda0cce7271620ab2f6`
> > >
> > > 298924b8c40 is an empty commit (i.e. `git commit --allow-empty`), and
> > > is the only commit not already reachable from 7549846524f.
> > >
> > > On Linux, when this test completes, "HEAD" in "rebase-test" is
> > > 7549846524f because the empty commit was discarded. This is the
> > > expected behavior. On Windows, "HEAD" is a new empty commit, which
> > > causes our test to fail.
> >
> > I don't have a Windows box to test, but it's good that you are seeing
> > the correct behavior there.  I do have a Linux box, and cannot
> > duplicate the behavior you state, even downloading the zip you
> > mentioned and following your steps to reproduce.  Actually, I did
> > reproduce that behavior the first time because I was accidentally
> > using git-2.25.0.  But with git-2.26.0 on Linux, I see a new empty
> > commit after rebasing, as expected.
> >
> > Is there any chance you accidentally ran with an older git version
> > when on Linux?  If you really were using git 2.26.0 on Linux...then
> > I'm totally confused at how you got that behavior.
>
> I went back through our build logs and confirmed that we _are_ running
> Git 2.26 (phew). I then set up a local Git 2.26 environment and...it
> produced the same new behavior as 2.26 on Windows (so the correct
> behavior, per the documented changes).
>
> At that point I dug further into our builds and found that while we
> were using the right Git version, we _weren't_ running all the same
> tests on Linux and Windows. So the successful build on Linux was not
> because the tests pass--I've adjusted the builds and confirmed that
> the tests _don't_ pass--but rather because the relevant tests weren't
> being run at all.
>
> Very sorry for wasting your time, Elijah. I should have looked into
> our builds more closely to verify they were running the same tests
> before I took the question to the list.

Hey, no worries; you provide good comments on the list and it was
really nice that your report came with very detailed steps to follow,
so it ended up not taking that long to check.  Thanks for double
checking to verify that I wasn't insane (or at least that this one
issue doesn't prove I am).  Anyway, not a big deal at all; keep
reporting potential issues you run across in the future.

Elijah
