Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26534C3F2D8
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 13:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E774A214DB
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 13:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hsf8f8Zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgCBNdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:33:11 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46845 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgCBNdK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 08:33:10 -0500
Received: by mail-ed1-f67.google.com with SMTP id y3so6675405edj.13
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 05:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S3MpqVO6TkPpDXtg6L6rpODNG/vZjdBEQ3/dF2ZOvjo=;
        b=Hsf8f8ZiSHNuy5ZtdvYNFjw3wcRk4jfsz6AAX420LuHAEXNxq5MpNoVK1uqny8Ut/m
         cktOEnCKjpnpKShElTT4YFy5gR/JlotDxMnhC38CkjyQKqUoVcXTEBRC+f49+dC2H347
         9exS05BJmSx1oePiYbJNEB5+/QX0RvD4BoV6IFoFWRcSJ7hv/apMdrJZgNojecXxew9j
         eYuAnqNk8BtJ76Vn3yroSZXU1dfC5EkgpbSVA8qlkdW6ZeMEYzhp+mHv3U9XsLgPzW+O
         Kg8hlC2vaqqnHl1cIz80UG9zkeFuUqjPcDiETc3XCKzqr00VDQSVNZA0/ZJN7cdEtk5O
         NUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3MpqVO6TkPpDXtg6L6rpODNG/vZjdBEQ3/dF2ZOvjo=;
        b=f5gtlQ0Ddlo9NFJ80CQVlZHFrEzbgU23qQNZynhpABZUVq6Nqwf24BrviALn8BICCx
         mmGGYjHQoe3dU3yXPzrBEO3/c68oP/8ubzV16mVE58XPWBw5CnnYpna57d27sPUvhJVb
         oT1F0kYKDiSEGoVijNR7LIBk65QQvdsIBMq1DDAN0HNm4kPLaixPfae2hYBI1k06GfcO
         Qfcyb1pvPG+EWCmgdtIKnNH5ZF2MHPF1ilv5RfzsHwW7sK3mnANTGUvnAZTG1mrWwNag
         wbEhh76OXzaTvu8c8iBXm6YGyR/3vBFb/nh7Xz+jeT7Lm3rjshQxb3bOFVZRGmk8bu4u
         eayw==
X-Gm-Message-State: APjAAAVpWRWGlvgQ/jP6IN2+OK327kzANIZr5f1pZFNQhHUyMxEIMOOX
        GGiJ44ibIcqV8hRuC5s8JWlEMNdcXLDy1OIT/jbaM71m4OiBzA==
X-Google-Smtp-Source: APXvYqxVVhtkTOEwnOWuHOaqRKq8HcE7seb56D8GKJ0cp2gA6w4i148a9w99Et6gGcF9PD/y+hQd19wJGUeMyo38MVw=
X-Received: by 2002:a05:6402:38c:: with SMTP id o12mr16697374edv.273.1583155987690;
 Mon, 02 Mar 2020 05:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20200225194536.20549-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200225194536.20549-1-shouryashukla.oo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 2 Mar 2020 14:32:56 +0100
Message-ID: <CAP8UFD0Ge=2a2sMpzy+pwAYZb-oJkcMZ7Jbnn5pLrSe8MB1v2w@mail.gmail.com>
Subject: Re: [GSoC][RFC] Proposal: Convert scripts to builtins
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Tue, Feb 25, 2020 at 8:45 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> I am Shourya, and this is the first draft of my proposal for the project titled:
> 'Convert scripts to builtins'. I need your feedback and more than that I need help
> to improve my project timeline.
> Specifically, I'd like your thoughts on the early commencement of the project and
> how should I adjust the timeline accordingly. Any guidance the Community can provide
> is greatly appreciated :)

Thank you or your proposal and sorry for the late answer!

> # Convert scripts to builtins
>
> ## Contact Information
> --------------------

[...]

> ## Background
>
> I am Shourya Shukla, a sophomore in Computer Science and Engineering at the
> Indian Institute of Technology Roorkee[1]. I was introduced to programming at
> a young age and I have been trying to learn new concepts everyday since. My
> interests include modern mobile networks, Internet of Things and system software
> development. I have been working on a project which involves providing cellular
> network access to users in a disaster-struck are via drones. I love low-level

I think you mean "disaster-struck area".

Do you have a link to the project you have been contributing to?

> coding and FLOSS as well. I have been an active part of the Git community since
> January of this year, contributing to Git.

Ok.

> ## Work Envinronment
>
> I am fluent in C/C++, Java and Shell script, and have an understanding of Python
> as well. I use Git as my VCS and Visual Studio Code with integrated GDB as my
> primary code editor and Ubuntu 19.10 as my primary Operating System unless the
> work specifically needs Windows.

Ok.

> ## Contributions to Git
>
> Contributing to Git helped me understand a lot about how modern & robust softwares

Maybe "software".

> work as well as how real world development takes place. I plan on contrubuting even

Maybe "contributing".

> more to Git and make my contributions count. As of now, my contributions at Git are:
>
> ---------------
> status: merged
> git/git:
> [Microproject][2]: Modernise tests and use helper functions in test script.

I think it would be better if you also provided a link to the commits
that were merged, or the tip of the branch that was merged, on GitHub
or GitLab. Also I prefer when the links are not at then end of the
document but rather part of the text.

> ## The Project: 'Convert scripts to builtins'

I think the project name should specify the script(s) that you want to
convert. Mentors might be more interested in one script being
converted than another and it's better if they don't have to look
inside your proposal.

> #### Overview
>
> There has been an ongoing work in the conversion of various Git commands
> such as `add`, `commit`, `blame`, etc. from their shell form into their C form.
> `git submodule` is one of the commands left to fully convert into its C form.
> Stefan Beller <stefanbeller@gmail.com> converted a large part of this command
> up until 2019. Prathamesh Chavan <pc44800@gmail.com> also aided in the conversion
> of the command during his GSoC project in the year 2017. In its current state, four
> subcommands are due for conversion, namely: 'add`, `set-branch`, `set-url` and `summary`.
> Also, the Command Line parsing Interface needs improvements, such as better error messages
> and support for more subcommands.

I hoped that what you mention here was detailed below, but it looks
like it isn't. It's important to show that you studied what happened
before. And that you can take advantage of it. For example maybe they
started working at porting other commands but didn't finish and you
could take advantage of their work.

You could perhaps add links to their repos and the patch series they
sent that were merged and possibly those that weren't merged too.

I would use "Previous work" rather than "Overview" as the title for
this section.

> #### Project Timeline
>
> I have been studying the code of `submodule.c`, `submodule--helper.c` and `git-submodule.sh`
> since the submission of my microproject. After studying the codes, I tried to devise an effective
> conversion strategy for `submodule`. I noticed that `submodule.c` contains various helper functions
> for `submodule--helper.c` whereas the latter houses the main "converted" command as of now.
>
> Therefore, the timeline looks like:
>
>   - Community Bonding Period (April 27 - May 18)
>     --> Get familiar with the community
>     --> Improve the project workflow

I'd like more details about this.

>   - Phase 1 (May 19 - June 6)
>     --> Convert `summary` subcommand
>     --> Improve CLI parsing
>
>   - Phase 2 (June 7- August 8)
>     --> Convert `add` subcommand
>     --> Convert `set-url` subcommand
>     --> Convert `set-branch` subcommand

You could add a bit more information, like an estimate of the number
of line of shell you will convert at each step.

>   - Final Phase (August 9 - August 17)
>     --> Documentation
>     --> Final touch-ups to code

Documentation should be part of the previous phases. Also we like to
be updated (either via a blog or emails to the mailing list) during
the course of the project, not just at the end.

> If there is some extra time left, I will try to implement some BONUS features.
>
> **BONUS features:** Consist of command touch ups and improcing some bugs such as code

Maybe "improving on".

>                     sections with 'NEEDSWORK' tags.
>
>
> ## Relevant Work
>
> I have divided the project into 3 subprojects(SP).
>
>     1. **SP 1:** Convert `summary`
>     2. **SP 2:** Convert `add` and improve CLI(Command Line Interface) parsing
>     3. **SP 3:** Convert `set-url` and `set-branch`
>
> After discussions with Christian Couder, I plan to start SP1 before GSoC itself. Currently,
> I am studying the code in detail and constructing a scaffolding for this implementation.
> I aim to complete the leftover bits of SP1 during Phase 1 and SP2 & SP3 during Phase 2 of
> GSoC.

Ok.

> As Derrick Stolee advised[3], the conversion may not be possible in one whole summer, hence,
> I think an early start might be needed to finish things in time if possible.

Yeah, probably.

> ## Availability
>
> The official GSoC period starts from April 27 and ends on August 17. My vacations start
> from May 10 and will be over by July 13. I can easily devote 45-50 hours per week until
> the commencement of my Semester. Other than this project, I have no commitments planned
> for my vacations. I shall keep the community posted in case of any change in plans.

Ok.

> ## Post GSoC
>
> Even after the completion of Google Summer of Code, I plan on continuing my contributions
> to Git, on the technical front(in terms of code and documentation contributions) as well
> as on the social front(solving people's doubts/problems on the List as well as on StackOverflow).
> I vision to convert the remaining of the commands as pointed out by Dscho[3] as well as improve
> the test files.
>
> I aim to develop mentorship skills as well as the ability to guide others and try to give back to
> the community by mentoring and guiding others as well(by reviewing their code, helping them out, etc.)

Great!

Thanks,
Christian.
