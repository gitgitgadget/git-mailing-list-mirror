Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF98C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 00:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8F122482
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 00:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgLDAyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 19:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgLDAyE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 19:54:04 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6917DC061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 16:53:18 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id b23so2337359vsp.9
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 16:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+iv3ySemNuBG86lc2J351Wq23kolSmntgvXaJ4+yLs=;
        b=rYTZbRst3COFpdLlC1cZAflUUbwbNHsUkiptfMPdjvzErrTdJJV02AoxXXSkeOMBMa
         RiiSpjTF2Fzlg5011nMq+qdQvURkOSvta3GVjiVHWkygCTIHLaAaZJwr0+ifE3VlBFGB
         6k0+niLHcQ2kPljNYmEdjBhH6uz+ZkMKzpEfBUjMdlFYezkxjt004tw5czeQFMBO8XAB
         cKO0xYmmcbsvNHbh/+G4wfilW9ISZWi5JCW8EfJ5qk+so+Gxz/8qHrVxgrg7hVxxHiXE
         nAe/pzgIVgGRe8Rw86axYN1Ki8LSjU6ml+zs71iLMyiQQ8fxt9QqT0UleXXyv0pc3OX6
         loqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+iv3ySemNuBG86lc2J351Wq23kolSmntgvXaJ4+yLs=;
        b=MCmMA3Gh4CT4ev0XHlcoMvHyyzLpq002/XEarw/bkJENxsQ7yT7oksUA6R/R1s4+2g
         1sZjEIeEfFq05PHpiLFPcx44P/bv6stQC4L3XmT32mcrLuA6yLQtIkou4iO4gE3kDVhI
         Ys9Q06G6XaW5DZqPSt91dpcYtX5iQl9gpHMLphlQ3cir1kZBfOcXH5ObJZkNM/lpC1zr
         h5jlkYG5ycBK4EEAJ3O9UaA871VuNbYroD3QJTq4BMC//c8LAxodkADo005/+lJl79AW
         /wLVv/X2g5YDMETTZFvU/RK0MkbG5iD1fTrU1YPweMMp4JPx1I1VGwCzUlxeFSrvIMPT
         X8xA==
X-Gm-Message-State: AOAM5306aSz3CAxYgdrTKJhgSVhmloDmJjWUSN+HWWtZQKp7G6GrDefF
        sVsnOsBMy+mZJ5ACDQkb3Rb9cA6io/3RtLIMahs881ikW3k=
X-Google-Smtp-Source: ABdhPJz6Ssbra34GQRzT89GgQteusuIHI6QvMy9UfggLTVvZvLC3CAdS/OUUxO7MbRy6MCFkpqyqH9nAFbMJo50RQsc=
X-Received: by 2002:a67:6781:: with SMTP id b123mr2013581vsc.10.1607043197595;
 Thu, 03 Dec 2020 16:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
 <20201125020931.248427-2-alexhenrie24@gmail.com> <xmqqmtyviq9e.fsf@gitster.c.googlers.com>
 <CAMP44s1Hwun+P=j5BBbVUT-ACS4hJCyRCJT-=6WvwK913fXq7g@mail.gmail.com>
 <xmqq7dpyix1d.fsf@gitster.c.googlers.com> <xmqqmtyuhemi.fsf@gitster.c.googlers.com>
 <CAMP44s0K48xJy0gD6jLoiDr9GYDmD3MVmWYVbsNyXyBnPcvj1Q@mail.gmail.com>
In-Reply-To: <CAMP44s0K48xJy0gD6jLoiDr9GYDmD3MVmWYVbsNyXyBnPcvj1Q@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 3 Dec 2020 16:53:07 -0800
Message-ID: <CA+P7+xq1QNzKbnZAwNn4bf6b4g5KS1ySB0dvgp7n1jyk13Vrog@mail.gmail.com>
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is not
 set either
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git <git@vger.kernel.org>, "Raymond E. Pasco" <ray@ameretat.dev>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 3:08 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 1:30 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > >> That would require changing the semantics of --ff-only, so that "git
> > >> pull --no-rebase --ff-only" doesn't make sense (as --ff-only is
> > >> overridden by --no-rebase).
> > >
> > > I do not think such a conclusion follows from "we do not want to use
> > > the 'by default force the --ff-only' when the user chooses between
> > > merge and rebase".  Specifically, I do not agree with "as --ff-only
> > > is overridden" in your statement.
> >
> > Ah, sorry, I mis-read your three lines above.
> >
> > There are currently two ways "git pull" consolidates your work with
> > the other history.  By default, you are "pulling" work from your
> > contributors (and that is what "pull request" means---contributors
> > ask you to pull, and you take their work at your discretion) and the
> > only way that makes sense is to merge their history into yours.
>
> And this is the reason why I warn about using one's worldview too
> much. The *vast* majority of users do not use "git pull" this way;
> there are more contributors than maintainers.
>
> What they want is to "merge your history into theirs", not the other
> way around. So the only way they can do that correctly is by doing
> "git fetch" + "git merge". Which is why so many people say to avoid
> "git pull" altogether.
>
> So, a newcomer that doesn't know much about git and does a "git pull",
> is pretty much guaranteed to do something unintended. If he/she is a
> user, the merge will have the parents the other way around, but even
> as a maintainer, the project might not like merges, and he/she will
> introduce an unwanted merge, or worse; an evil merge.
>

As someone who spends a significant amount of energy at work educating
newcomers to git, this is a significant problem.

> > The other is you are updating your branch by rebasing your work on
> > top of what happend in their history.
>
> Again, what the user might want is the opposite. If the user is a
> maintainer, these two:
>
>   git pull --merge github john
>   git pull --rebase github john
>
> Should be about their history to yours (or on top of yours).
>
> > And if we introduce a third-way, i.e. "we do not handle the case
> > where you have your own development at all, this is only to maintain
> > pristine copy from your upstream", and repurpose "--ff-only" for
> > that purpose, yes, what you said above does make sense.  At that
> > point, there is no reason to disagree with "as --ff-only is
> > overridden" part of your statement---in your new world, "--ff-only"
> > is redesigned to act that way.
>
> That's right. Otherwise "git pull --no-rebase" will fail; you will
> have to specify --ff (or --no-ff) for it to work. And that doesn't
> make sense to me.
>
> Specifying --no-rebase should override the default --ff-only mode (or
> pull.mode=ff-only).
>
> > In retrospect, "git pull --rebase" was a UI mistake.  What the other
> > side means is totally different in the operation from what the other
> > side is in "git pull".  The former is for you to catch up with your
> > upstream and the latter is for you, who _is_ the upstream to others,
> > to take others work in as their upstream.  If we instead introduced
> > a separate command, say "git update", that is "fetch followed by
> > rebase" (just like "git pull" is "fetch followed by merge"), to
> > rebase your work on top of updated upstream, there wouldn't be a
> > need for us to be having this discussion.
> >
> > It probably is water under the bridge at this point.  Perhaps if
> > somebody builds a time-machine for me, I'll go back 13 years and
> > give my younger self this wisdom ;-)
>
> You don't have to go back 13 years ago, you can go back 6 years ago
> when I wrote all the patches for git update [1], explained the summary
> of the problem [2], and others urged git developers to pay more
> attention to the patch [3].
>
> But as you say; water under the bridge.
>


> Today there are 3 things to do:
>
> 1. Improve the annoying warning
> 2. Consider changing the semantics of --ff-only, or implement pull.mode=ff-only
> 3. Consider a new "git update" command
>
> Since my new (2020) patches for pull.mode (solve 1 and 2) have not
> been reviewed, I'm thinking there's too much inertia and perhaps it's
> time to cash in the chips and concentrate only on 1.
>

I think that solving (1) is relatively simple and worth doing. I think
solving (2) is trickier but worth doing in the medium time frame.

Doing (3) may have value.. We did it for git checkout already
recently, by adding git switch and git restore-files.. But it's a
bigger undertaking.

I personally like changing the default of pull to be "I will only fast
forward, and you need to tell me what to do if history isn't fast
forward". This does cause some strain as it forces users to now have
to understand and pick which thing they want, (rebase or merge) when
combining history.. But I think that's better than users not being
asked to pick and just having merge be the default unless they go out
of their way to set the rebase by default option.

> Cheers.
>
> [1] https://github.com/felipec/git/commit/d38f1641fc33535aa3c92cf6d3a30334324d3488
> [2] https://lore.kernel.org/git/5366db742d494_18f9e4b308aa@nysa.notmuch/
> [3] https://lore.kernel.org/git/CAGK7Mr4uucBN=17ph5pBjrz7yP60By1sERU9oBL+c2-gsMDmrw@mail.gmail.com/
>
> --
> Felipe Contreras
