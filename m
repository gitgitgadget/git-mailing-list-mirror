Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7055BC433E0
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 00:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFA464ECA
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 00:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhBTAAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 19:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhBTAAY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 19:00:24 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64F3C061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 15:59:44 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id o10so6667655ote.13
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 15:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QfcQe9PfNfr9ujeyTVMSQCNYCUSE7AWEvjKqHO6W03c=;
        b=l8mJI6WffAi61QO8oeZwv2d6Tkv/jtuOEJlECUbF+GNSI5S8danL6b7tUouegT4Fpw
         JHASDmjLFV8wusYmCx5a2gMARSiGxLB0uXZoCBQuNWx4VLtf4FdQ9Qo/LhW/BErXeS+p
         Ch7eolYn770qRaEu/HomWyU+zk9T2/azQsD8Sacvda2kCauNcg3Kk6WOVZHxdyNPY/BH
         Ya56jhkFU144C3LKbI+ClskpOteLuthYCVxDJ/t7RjRKUbouKkSGAQJoRxgVKAxKKnVG
         tLyNlHoMqtkLEFa2C9vWGfR9xGu006ukP6WIW+Nbbn32fqkzyPi5ITDsl9uwoeer4Z5j
         B4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QfcQe9PfNfr9ujeyTVMSQCNYCUSE7AWEvjKqHO6W03c=;
        b=dsS2kKcSJnf3P22SbdrymcbpA1F4LgJXmXD3772C2StHNfgB2JPb1lJ5NlsSt1KX5O
         v+7YoUa4p32d9fNkqxzoH0kvghUDdCvhCHshGrssweMMLzMYcBinyBAL3DiI0WnwZg1M
         WEkfEG1ZbopUYZDTnOVnRDDxZkPqeLpBWtOgwvRv0Tj1Dzzw5/k1Ocz9QZO9W8YOZZSQ
         zpjgeC+Lk39Gyr5SL4mk8c42LPM1z92uvGNtSxLmRbGTlZ63qSapyyWnbPDiNvOpiXzP
         mEeEWQYW+zlj/8kfrwVgiEYPQx1g09k9wHig+1Nz1F7zeLjwtc0AdkARZkM1Lo6jtpKc
         zPwA==
X-Gm-Message-State: AOAM5326D2bi+X+UEcZtdDmier10MHBrA5aUTcYQQCZtYjMA1VOjs0m8
        Kr4XfdHyD4pNUGRXntmREGr3havYLshcDCKSKSkrJIao1xLvUQ==
X-Google-Smtp-Source: ABdhPJxQSd62/QfkjL1My/DF0OncbKfvYDZPWF91aaH/0UO2KqwG/KygYp+9xfj83XpACxPXl9KvUMiSlmsq6Gj0t5k=
X-Received: by 2002:a05:6830:93:: with SMTP id a19mr8744048oto.345.1613779184100;
 Fri, 19 Feb 2021 15:59:44 -0800 (PST)
MIME-Version: 1.0
References: <CAD9n_qiN+qXqR79z_4d+_8_mxa9eTFB42sTUT8CTF8=oQArQaA@mail.gmail.com>
 <YDA6+vm6GPQL3Jec@camp.crustytoothpaste.net>
In-Reply-To: <YDA6+vm6GPQL3Jec@camp.crustytoothpaste.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 19 Feb 2021 15:59:33 -0800
Message-ID: <CABPp-BH4F5zHmrX9C=CsnAKhcDr=KS1Rco4EXR-RSOfEnbFjQQ@mail.gmail.com>
Subject: Re: Considering merge --dry-run to foresee conflicts ahead of time
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alireza <rezaxm@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 19, 2021 at 2:26 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-02-17 at 17:21:45, Alireza wrote:
> > I have a half baked alias for this and it proved to be extremely
> > useful even in this state.
> >
> > ```
> > check = "!f() { BRANCH=${1:-HEAD}; BASE=${2:-origin/master}; git
> > merge-tree $(git merge-base $BRANCH $BASE) $BRANCH $BASE | sed -n
> > \"/+<<<<<<< .our/,/+>>>>>>> .their/p\"; }; f"
> > ```
> >
> > Of course with large conflicts it gets less useful. Getting only file
> > names from the patch isn't straightforward either.
> >
> > So my question is what are the downsides to introducing a `merge
> > --dry-run` option and what would it look like?
>
> There aren't really any, but the current implementation of the merge
> code makes it non-trivial, since it writes directly into the working
> tree.  The new merge-ort code that Elijah Newren (CC'd) is working on
> should at least support writing conflicts only into the index, and if
> you didn't want to dirty the existing index, you could create a
> temporary one with GIT_INDEX_FILE and write to that.  It may also
> support a dry-run mode natively, but I'm not following it closely enough
> to say.  Hopefully Elijah can say a little bit more about things.
>
> In the mean time, since this is a frequently requested feature, I have a
> Rust-based tool called git test-merge[0] that runs a test merge between
> two arbitrary trees and determines whether it succeeds or fails.  It
> uses libgit2 under the hood.

I don't have that exact feature implemented, but I've got something
that could easily be reused to provide this functionality.  In my
remerge-diff branch, I've got a --remerge-diff option for log (and
show), that for any merge commit will redo the merge in-memory (not
touching the working copy or index), and then show the diff between
that result (possibly including conflict markers) and what was
actually recorded in the merge.  If the merge was clean and the user
didn't amend any changes into the merge commit, then the diff will be
empty.  If the user moved around files, added changes, or just ripped
out conflict markers, then you see all that in the diff.

One could use the same logic to make a merge --dry-run option that
would show the diff between the commit before merging and the
auto-merged state.  It probably wouldn't even be all that much code;
may half a day's worth of work.

But, it does rely on getting merge-ort reviewed and merged.  We're 6
months into that process so far.  I was hoping we'd finish it before
git-2.32 is released (note that git-2.31 isn't released yet either),
but right now git-2.33 is looking more probable.  See
https://lore.kernel.org/git/pull.844.git.1613289544.gitgitgadget@gmail.com/
and https://github.com/gitgitgadget/git/pulls?q=is%3Apr+author%3Anewren+Optimization+batch
if you'd like to help review and/or test the portions that are ready
for review.  (Or try the 'ort' or 'remerge-diff' branches of
https://github.com/newren/git if you want to try out the full set of
changes, including bits that haven't been nicely broken up in
preparation for upstream review.)
