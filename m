Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EB7C2BA19
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 06:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587A720715
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 06:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="z/Am7IAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgDWGJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725562AbgDWGJn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 02:09:43 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4DFC03C1AB
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 23:09:43 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so3800493lfc.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 23:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpzdng8RDItAPHZ3j1xvGdqttBE5N/GYeXa0MqycS9g=;
        b=z/Am7IAoK1JoKLUVjr0HOe1o0ttWlGtLm2ZW0g8Gg92MkMlbMXCZRrgzgDTgmBuF+d
         rVWO/x7jvZOZ8P+M0mfjJHqYCdKyy8+1liAsE3yDsEMsIiL2zDrOk7JbMJ4Ym1uXIEim
         TpMijlzyJvHAujyP+nmRQTLJ6t0kVQuO79OIfhpQ6E1Iio5ux6yuyFiXB39cIwR+2rQV
         Pw+k5qZNNAMnDr/mQzuhwBhcrjxbchr/CktY1dNfsionpEdb7bIuLHub5IgBz1IVR4UX
         Ihp7Z/IaDkpW6cN3edEo/MTV/9eqiYhs+ly88QXM/2RlvkN9zCe1oc96wDwe5fGOiGT4
         f4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpzdng8RDItAPHZ3j1xvGdqttBE5N/GYeXa0MqycS9g=;
        b=ZhWaZEZRWZi4PCksYoqdt951yOvA3INXk4fT03K7azy4QLwHPeBoe02U3m2LDbsu7y
         98d6K9iPxpDK5bv/fWCFekuzvDTTwuPX0ajmrucluwyoBx7Lfq1IP4WP7zblIX1hDLVj
         4RxldNVNXP3aWHIo9PEfDMoenecvg5QbptLEeYLWYL696SkAMezMhs0/XJFLzidXvDWF
         dv4Y9kDQOwIL2OxUa8TLG6o8GJmypDnAap/4C2yz0Mh9fMW9Q6Besyp0TXKXwLk4PP9o
         cqAPZtfl/fGSZewvWagS6ysoo3jJtxAXhUMJiDuNs4U9HpmvGf4JR9at5MzCzvUUiJYJ
         lj2w==
X-Gm-Message-State: AGi0PuZ73gfjSfPhKyw0PvntNlcbhD1sZD84DOQ1H1lJ/OcL80tfngUG
        LxSIErImWjEwv9WIeMh44bs0X6r30tS/6XKGjWUpMQ==
X-Google-Smtp-Source: APiQypLJBIPYJW5Dr0nszWLNYjxUGkGKG03dcsv046Lu2gZtu5RpjA7XO6cLtshiWJgKbp/BhGoLwCdu31Kd8onhVvM=
X-Received: by 2002:ac2:5930:: with SMTP id v16mr1363629lfi.103.1587622181687;
 Wed, 22 Apr 2020 23:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BHbrGGjV_22kwTERn19RaWk73_Y6tzWnjwO9u4isCRpVg@mail.gmail.com>
 <CAHd-oW7yfD74ymARoOHXUqB==RcS36S-8D4M8ysAoVcC6GBR9A@mail.gmail.com>
 <CAHd-oW6PQNC-ZFj6ydbHFzfL4KpSwXVSd8s3H429tOiRgSra8A@mail.gmail.com> <CABPp-BGUf-4exGW23xka1twf2D=nFOz1CkD_f-rDX_AGdVEeDA@mail.gmail.com>
In-Reply-To: <CABPp-BGUf-4exGW23xka1twf2D=nFOz1CkD_f-rDX_AGdVEeDA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 23 Apr 2020 03:09:30 -0300
Message-ID: <CAHd-oW7xaLcBskLM6bgqgnLukXnwW+bWvGM24Ao_9UxKwdXi3A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] grep: honor sparse checkout patterns
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 21, 2020 at 12:08 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Apr 20, 2020 at 7:11 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > I've been working on the file skipping mechanism using the sparsity
> > patterns directly. But I'm uncertain about some implementation
> > details. So I wanted to share my current plan with you, to get some
> > feedback before going deeper.
> >
> > The first idea was to load the sparsity patterns a priori and pass
> > them to grep_tree(), which recursively greps the entries of a given
> > tree object. If --recurse-submodules is given, however, we would also
> > need to load each surepo's sparse-checkout file on the fly (as the
> > subrepos are lazily initialized in grep_tree()'s call chain). That's
> > not a problem on its own. But in the most naive implementation, this
> > means unnecessarily re-loading the sparse-checkout files of the
> > submodules for each tree given to git-grep (as grep_tree() is called
> > separately for each one of them).
>
> Wouldn't loading the sparse-checkout files be fast compared to
> grepping a submodule for matching strings?  And not just fast, but
> essentially in the noise and hard to even measure?  I have a hard time
> fathoming parsing the sparse-checkout file for a submodule somehow
> appreciably affecting the cost of grepping through that submodule.  If
> the submodule has a huge number of sparse-checkout patterns, that'll
> be because it has a ginormous number of files and grepping through
> them all would be way, way longer.  If the submodule only has a few
> files, then the sparse-checkout file is only going to be a few lines
> at most.

Yeah, makes sense.

> Also, from another angle: I think the original intent of submodules
> was an alternate form of sparse-checkout/partial-clone, letting people
> deal with just their piece of the repo.  As such, do we really even
> expect people to use sparse-checkouts and submodules together, let
> alone use them very heavily together?  Sure, someone will use them,
> but I have a hard time imagining the scale of use of both features
> heavily enough for this to matter, especially since it also requires
> specifying multiple trees to grep (which is slightly unusual) in
> addition to the combination of these other features before your
> optimization here could kick in and be worthwhile.
>
> I'd be very tempted to just implement the most naive implementation
> and maybe leave a TODO note in the code for some future person to come
> along and optimize if it really matters, but I'd like to see numbers
> before we spend the development and maintenance effort on it because
> I'm having a hard time imagining any scale where it could matter.

You're right. I guess I got a little too excited about the
optimizations possibilities and neglected the fact that they might not
even be needed here.

Just to take a look at some numbers, I prototyped the naive
implementation and downloaded a testing repository[1] containing 8
submodules (or 14 counting the nested ones). For each of the
non-nested submodules, I added its .gitignore rules to the
sparse-checkout file (of course this doesn't make any sense for a
real-world usage, but I just wanted to populate the file with a large
quantity of valid rules, to test the parsing time). I also added the
rule '/*'. Then I ran:

git-grep --threads=1 --recurse-submodules -E "config_[a-z]+\(" $(cat /tmp/trees)

Where /tmp/trees contained about 120 trees in the said repository
(again, a probably unreal case, for testing purposes only). Then,
measuring the time spent only inside the function I created to load a
sparse-checkout file for a given 'struct repository', I got to the
following numbers:

Number of calls: 1531 (makes sense: ~120 trees and 14 submodules)
Percentage over the total time: 0.015%
Number of matches: 300897

And using 8 threads, I got the same numbers except for the percentage,
which was a little higher: 0.05%.

So, indeed, the overhead of re-loading the files is too insignificant.
And my cache idea was a premature and unnecessary optimization.

> > So my next idea was to implement a cache, mapping 'struct repository's
> > to 'struct pattern_list'. Well, not 'struct repository' itself, but
> > repo->gitdir. This way we could load each file once, store the pattern
> > list, and quickly retrieve the one that affect the repository
> > currently being grepped, whether it is a submodule or not. But, is
> > gitidir unique per repository? If not, could we use
> > repo_git_path(repo, "info/sparse-checkout") as the key?
> >
> > I already have a prototype implementation of the last idea (using
> > repo_git_path()). But I wanted to make sure, does this seem like a
> > good path? Or should we avoid the work of having this hashmap here and
> > do something else, as adding a 'struct pattern_list' to 'struct
> > repository', directly?
>
> Honestly, it sounds a bit like premature optimization to me.  Sorry if
> that's disappointing since you've apparently already put some effort
> into this, and it sounds like you're on a good track for optimizing
> this if it were necessary, but I'm just having a hard time figuring
> out whether it'd really help and be worth the code complexity.

No problem! I'm glad to have this feedback now, while I'm still
working on v2  :) Now I can focus on what's really relevant. So thanks
again!

[1]: https://github.com/surevine/Metre
