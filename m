Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A8EC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 08:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445175AbiDVIpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 04:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiDVIpg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 04:45:36 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09A552E7F
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 01:42:43 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q19so6815608pgm.6
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EDx5hIqoruyU2Y/doeoAM7jKQHUWDlg9LRs6xn7+rJg=;
        b=XSzQLpy7Uj7f7DKtoWXplOc8kiATCo415u6OhCiJKZ1gM8XnIz5YbDxQRve84kwCsL
         muCesBF5R/WX1MUhZGg5/zaWYYNFQKzLc41IkbFS2ntFYpecrymYyJEvDHnVNcBTn6Sc
         j0ySApt7sbKYBzqqHWJxLIMdpemXECqbRrli78tUm9AFsijiuXnY347sONFGr2gP1tAn
         YKo0HnbYhVyXL7dCghsghK0SeJiCAOtJBy65GqyThoc/0RHqCbl1YKrmBvMoSUmA5UAJ
         7j71qLoNq6dJJLqKpEE16Q/3MhqdIvjAj7LcRn9AlWRK2zHGrud3IVRnQXu+prr/oMFu
         OLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EDx5hIqoruyU2Y/doeoAM7jKQHUWDlg9LRs6xn7+rJg=;
        b=c4zJUtoe0kCXLzJoE3IZ8zHJ1qTGBh+ke7TwF1G7sTw/VPdkPAVbKiqif+vDxNZrhL
         MriRPByJ7zJmoDUAp0gryNSwEdpIJXPfH1irA0ipEDNQPZdZEhNaJeuWcV1QXUynpWMe
         iyvd7xWYFb43/ZoMNB0/JNHGiGOM0nWQn+92sFVA4i10A2QzUWDSUL1dQygfAidPSeLf
         B4z9mB3UHxcdI3YD8jCzuDW6PKfxkrjwag5Ysv/+4fUJesFl+SA+AWw0BM34RV1oQqbw
         oreEMPKIgB7dhtJpA760GWdtiIf6vj4+w0x6T457Jd2fw0uQybGe2j3b+i64o8Vni7fI
         MWvQ==
X-Gm-Message-State: AOAM530igF1dwYDUCB5a41rPzeFnWqj3f7qB3O9USr+bwJ4fB0IPeG5A
        zBazOkW7cu7t9VsHsKa1sUCe5Y92TI7xM+RcScBIn8sgrvM=
X-Google-Smtp-Source: ABdhPJz9llNc+eOpG1wKs5nInOv2CdYe2RrmbrEoX5b1Kz5wD44bJjEmOAXH0Juv2WFP5HMshjpPEfGWX2gK+dzZOsc=
X-Received: by 2002:a63:f749:0:b0:3aa:361c:8827 with SMTP id
 f9-20020a63f749000000b003aa361c8827mr3026221pgk.361.1650616962433; Fri, 22
 Apr 2022 01:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <7f2e9c1b-1d01-00af-810f-c81dd38c12ad@gmail.com>
In-Reply-To: <7f2e9c1b-1d01-00af-810f-c81dd38c12ad@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 22 Apr 2022 10:42:30 +0200
Message-ID: <CAP8UFD0xwDYj-qxeZjFXzpbDCTs-U4j1=XwOUQXb-XqZP+8Mxg@mail.gmail.com>
Subject: Re: [GSoC][RFC][Proposal] Unify ref filters in pretty.{c,h}
To:     Jaydeep Das <jaydeepjd.8914@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Apr 17, 2022 at 11:08 PM Jaydeep Das <jaydeepjd.8914@gmail.com> wro=
te:
>
> Sorry for being late in submitting the proposal. My end semester
> examinations were over just yesterday so I somehow made this proposal
> during the exam time.

So here is a first review from me of your proposal. I think that you
cannot update your proposal on the GSoC web site, but it would be nice
if you could send an updated proposal to this mailing list soon.

> ## About me:
>
> I am a first year undergraduate at National Institute of Technology,
> Silchar  pursuing B.Tech in Computer Science and Engineering. My
> interests include FOSS development, Data Science and Robotics. I have
> been writing Python, C and shell scripts for about 3 years now. Apart
> from that I also blog[1] whenever I find an interesting topic to blog
> about. During the GSoC period I also plan to blog about the new things
> in git that I hope to learn.
>
> [1]: https://jdeep.me/

Nice that you already have a blog, as we indeed suggest GSoC
contributors to blog about their GSoC work.

> ## Micro-Project:
>
> I am still a newbie in git development and made my first (minor)
> contribution in Feb 2022 [1]. This was a patch I made just to get
> familiar with the patching and sending patches to the mailing list. For
> my micro project, I worked on adding diff driver for the Kotlin language.=
[2]
> The main objective was to make an xfuncname regex which matches keywords
> in Kotlin syntax so that they are considered as a single token
> whenever diffs are generated. Along with that, a word_regex regex pattern
> was also needed so that variable names, compound operators etc are not
> broken into individual tokens by git diff when there is a change in them.
> For ex,  if a =3D=3D b is changed to  a !=3D b , then the diff should sho=
w
> that entire
> `=3D=3D` token is replaced with the token `!=3D`. While working on this m=
icro
> project, I learned a lot about the contribution and review workflow of
> git. It took 7 patches to incorporate all the reviews and suggestions so
> yeah, It did require some patience :-).
>
>
> Minor patch(merged in master)
> [1]:
> https://public-inbox.org/git/20220208092339.651761-2-jaydeepjd.8914@gmail=
.com/
>
> Micro Project(merged in master)
> [2]:
> https://public-inbox.org/git/20220312044832.718356-1-jaydeepjd.8914@gmail=
.com/

Nice!

> ## Proposal:
>
> Git has an old problem of duplicated implementations of some logic. For
> example, Git has at least 4 implementations to format commands for
> different commands. Previously, Olga Telezhnaya[1] and Hariom Verma[2]
> worked on this and eliminated most of the duplicate logic. But still,
> there are still some things left to do. Current task is to reuse
> ref-filter logic in pretty.
>
> [1]: https://github.com/telezhnaya/git/commits/format
> [2]:
> https://public-inbox.org/git/pull.707.git.1597841551.gitgitgadget@gmail.c=
om/
>
> ## Previous Work:
> Previous GSoC mentee Hariom Verma worked on this[1]. He worked on
> removing duplicate logic and reuse ref-filter=E2=80=99s logic in pretty.
> However, as per his report, some tasks are still left to do.
>
> -> Around 30% log related tests are failing
> -> Teach pretty-lib.{c,h} to handle incorrect formatting option

Maybe: s/option/options/

> -> Email/MBoxed commit format needs work
>
> [1]: https://harry-hov.github.io/blogs/posts/the-final-report

It would be nice if you could elaborate on the different tasks that
are left to do, for example by answering the following questions:

  - What are the different test failures left? Can you find or guess
the cause of the failures?
  - What are the incorrect formatting options that pretty-lib.{c,h}
doesn't handle well yet? What currently happens and what should happen
when such an incorrect option is passed?
  - What kind of work is needed for the Email/MBoxed commit format?

> ## GSoC Planning:
> The main objective would be to start from where Hariom left and make
> further improvements in the related field if time permits.
>
> Currently, because my end sems were just over yesterday, I am yet to do
> a full reading/understanding of the pretty and ref-filter code. I plan
> to first read the documentation of git-log and study the pretty formats
> and their implementation. Next would be to read the code and understand
> how it is working under the hood and try to find possible bugs and edge
> cases where the tests fail. I have already gone through the various
> must-read documentations suggested in the Hacking git[1] section of the
> git-scm website:
>
> My First Contribution Tutorial[2]
> My First Object Walk[3]

You say that you want to start where Hariom left, but you don't seem
to mention the tasks Hariom suggested in the planning.

> Apart from that, I also have a decent understanding of git internals,
> objects and porcelain commands from the Git Internals[4] documentation.
> I want to start as early as possible since my main motivation for
> contributing to git is to improve something that millions of people,
> including me, use everyday in their day to day life.
>
> [1]: https://git.github.io/Hacking-Git/
> [2]: http://git-scm.com/docs/MyFirstContribution
> [3]:
> https://github.com/git/git/blob/master/Documentation/MyFirstObjectWalk.tx=
t
> [4]: https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain
>
>
>
> Estimated Timeline:
>
> -> April 20 - May 14
> Read the docs and go through the codebase. Make small code contribution
> if possible.
>
> -> May 14 - May 21
> Inactive Period
> The covid lockdown is almost lifted and I would need to report back
> offline to college. So I would probably be busy for a week to get
> settled there.

Ok, thanks for mentioning the inactive periods.

> -> May 22 - June 5
> Community Bonding Period
> Get in touch with the possible mentors(Christian Couder and Hariom
> Verma) and discuss the possible solutions.
>
> -> June 6 - June 11
> Inactive Period
> Will be inactive for the week due to mid semester examinations
>
> -> June 11 - July 24
> Coding Phase 1
> Fix the test cases that are failing
> Eliminate more duplicate logic in pretty.{c,h}.
> Update the documentation
>
> July 25 - August 20
> Coding Phase 2 (part 1)
> Teach pretty.{c,h} to handle incorrect formatting options.
> Make improvements in email/mboxed commit formats.
> Update documentation
>
>
> August 22 - August 27
> Inactive Period
> Will be inactive for the week due to end semester examinations.
>
> August 27 - September 19
> Coding Phase 2 (part 2)
> Start where it left off in part 1 of coding phase 2.

The GSoC website says:

"The standard timeline accounts for 12 week coding projects. Mentors
and GSoC Contributors can agree to extend the coding period up to 22
weeks."

I think it would be nice if you could tell somewhere which of the
standard 12 coding weeks each of the Coding Phase corresponds to, for
example like:

"-> June 11 - July 24
Coding Phase 1 (coding weeks 1 and 2)
..."

> During the coding phase 1, I would be able to dedicate 4 - 5 hours every
> working day. On weekends, I could dedicate the entire day or take a
> break depending upon the number of assignments I get. During the coding
> phase 2 part 1, I will be able to dedicate 4 - 5 hours easily except the
> hours may decrease some days before the end semester examinations.

Ok.

> ## Blogging during the contribution period:
> I plan to write bi monthly/monthly blogs during the contribution period
> which I would post on my personal website[1].

We prefer weekly blog posts if possible, especially during the coding
weeks, even if the posts are smaller.

> I would write about my
> progress and the new things that I will learn when I contribute to git.
> I also plan to make a complete video tutorial after the GSoC period
> about the contribution workflow in the git codebase since I believe it
> would have greatly helped newcomers (like me) to get started quickly.
>
> [1]: https://jdeep.me/posts/

Nice idea!

> ## Post GSoC:
> I would love to explore the git codebase and I am particularly
> interested in the sparse index feature of git. I would also love to
> co-mentor someone someday when I get more experience in the codebase. I
> have also noticed that there are some lesser known/underrated features
> of git ( like partial clones, sparse checkout, worktrees) and I plan to
> make video tutorials on these topics too.
>
> ## Closing Remarks:
> As a whole, I feel it would be a great learning experience for me as
> this would be the first =E2=80=9Creally=E2=80=9D big open source project =
where I would
> be contributing to. I am really excited about being a part of the git
> community.
>
> Eagerly waiting for review.

Thanks,
Christian.
