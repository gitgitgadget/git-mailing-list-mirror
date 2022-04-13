Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555E7C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiDMTcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiDMTb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:31:59 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31671166
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:29:30 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b16so3064752ioz.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3O1QSm9EQ+Z21bPytaf24SjB2DlASgdTpWvS2nRUfm8=;
        b=nENxfRtR/fd/GaaAmKsrmmNleYt7ODZdNtA7wlJut7I3UybACKSgnKvHXuVqEaxIw8
         o1oe1Ku4EiAdNkdaMhPmBsDXOjz3qAdVdGUA7E3Ji7uCF/ZZTC0OG4J9z7kt5s4JKqm8
         fXFWPIQESJSiHELwRq5IzO1v8N/0axBfLJB7IoyEMz9DkoBANK8NB9aWLNrbrCP33SOF
         R/NSTcFqWnKfzEI21v605io3t28ql5SznM4J6ZOMBkT7mWe1yZT1YQD6XqdalvaxsCSO
         BauVI5ErvdebJ5ijNO7sR3ULuU//QXwnrriHy2ts39U8U8Jd3LXEQ6sE/bpB1wQ/VGTv
         61Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3O1QSm9EQ+Z21bPytaf24SjB2DlASgdTpWvS2nRUfm8=;
        b=FypgiTSxsLl1HZa37d4HccAg6b/lsnwLdOrjnx5PzNB4rVF21auBszVnbvZHmBzFST
         whJs28NtHCtbzAbYkO16B/n4URaZwC5YXiEi+BB9wPRPWmdohGmWlIIHURVr1znXT7r5
         fVVCTXTQ/8lHh4x9i1dS2+Yp3Cb539KmzpzTjO9Ahc5GKMfOF7CnTUw0xqnjz0wLmAu5
         OsNFj60f9IueX//w9jGFkkLYozjEilGm02PnuXCZNJnfDFWagzAdVIfCEHO0AfDW0We8
         CyWeZ9TE/yslwowzP6jczAc00nZ+jPVfKRvyTS5Z8YNBNfBq5LiZCMo6nhrar9B8JMP4
         iiKw==
X-Gm-Message-State: AOAM533G6X0eb/B5OiivHPTvFfqKWlfh1/mCG499QJPq/Fdfl7r0jD+I
        X/FD+uqiHtoPN+XyADhmg2+VJg==
X-Google-Smtp-Source: ABdhPJwChI7izK1SsxuRzEcVVj3WtXQrVUIkrJPYuH3EUVa8lvGRkGKxrKj1Ra+D6zLxCHm1mPJXtw==
X-Received: by 2002:a6b:7a49:0:b0:645:d134:830f with SMTP id k9-20020a6b7a49000000b00645d134830fmr17988987iop.136.1649878170114;
        Wed, 13 Apr 2022 12:29:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d15-20020a92360f000000b002c81e1fdae1sm397740ila.85.2022.04.13.12.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:29:29 -0700 (PDT)
Date:   Wed, 13 Apr 2022 15:29:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][RFC][PROPOSAL] Reachability bitmap improvements
Message-ID: <YlckmDHRAYnE1J5t@nand.local>
References: <20220406200440.27010-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220406200440.27010-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Thu, Apr 07, 2022 at 01:34:40AM +0530, Abhradeep Chakraborty wrote:
> Hello everyone,
>
> Here is the initial version of my proposal on "Reachability bitmap
> improvements". I would really love to have comments on it. If you
> find any mistakes please notify me about that.

Thanks so much for submitting this proposal! I have been excited to look
through it, and am sorry for not getting to it sooner. Let me take a
look now and give some of my thoughts.

> ## About Me
>
> I am Abhradeep Chakraborty, currently pursuing B.Tech in Information
> Technology (now in my 3rd year) at Jalpaiguri Government Engineering
> College, India.
>
> In the last two years, I mainly concentrated on learning and building
> web development things. I mainly use Django, React for my projects. But
> for the past 6 months, I have been learning about devops, cloud technologies
> ( e.g. docker, Kubernetes, AWS etc.), computer networking and core
> technologies (such as git, linux, gcc etc.). I also have an interest in
> some research based technologies like WebRTC, Web3 etc.
>
> My ultimate objective is to be a dedicated and active contributor to all
> of these technologies. So, I want to start this contribution journey with
> `git` and therefore I want to be a part of this GSoC program.

Great! It sounds like working on Git would give you some new experience
in a different domain than some of your past projects, and help you
learn more about how it works and is developed.

> ## Me & Git
>
> I have started exploring the Git codebase since Sept 2021. At first, I
> mainly focused on knowing the git internals. During this time I read
> documentations (Under `Documentation` directory). `MyFirstContribution.txt`[1],
> `MyFirstObjectWalk.txt`[2] and `Hacking Git`[3] helped me to learn about the git
> contribution workflow, how `git log` ( in other words `object walk`) works
> internally.
>
> Though I had read many documentations, I was still not able to fully
> understand the terminologies (like `refs`, `packfiles`, `blobs`, `trees`
> etc.). (ProGit)[https://git-scm.com/book/en/v2] helped me tremendously here.
> I read the full book and it cleared almost every doubt that came into my mind.

Terrific! I am really glad that the MyFirst... documents were helpful
and made it easier for you to contribute. The ProGit book is a great
resource, too.

If you are looking for more resources, I would encourage you to search
around for blog posts written by Git contributors, particularly related
to reachability bitmaps (at least for this GSoC project). Some helpful
places to start there would be:

    https://github.blog/2015-09-22-counting-objects/
    https://github.blog/2021-04-29-scaling-monorepo-maintenance/

> ## Proposed Project
>
> ### Abstract
>
> While sending large repositories, git has to decide what needs to be
> sent, how to be sent. For large repositories, git creates pack files
> where it packs all the related commits, trees, blobs( in the form of
> deltas and bases ), tags etc. Now, finding the related objects among
> all the objects might be very expensive.

Note that commits and trees can be stored as deltas against other
commits and trees (which themselves might be packed as deltas) and so
on. But we only consider a pair of objects to be delta candidates for
one another when they share a common type (e.g., we would never delta a
tree object against a blob or vice-versa).

> As git only knows about the branch tips, it is very expensive to find
> the related objects from all the objects if we try to traverse down
> from the branch tips to all their respective related objects. It becomes
> more expensive as the number of objects (i.e. commits, trees, blobs
> etc.) increases. Ultimately resulting in slow fetching from the git
> daemon.
>
> To counter that, reachability bitmaps were introduced. It uses bitmap
> data structure (an array of bits) to detect if an object is reachable
> from a particular commit or not. The commit messages of this
> (patch series)[https://lore.kernel.org/git/1372116193-32762-1-git-send-email-tanoku@gmail.com/]
> are itself a documentation of how it is achieved. All the bitmap
> indexes for selected commits (in a EWAH compressed form) are stored in
> a `.bitmap` file which has the same name of its respective packfile.

Exactly; though note that since that series we now have multi-pack
bitmaps, too, which use a slightly different ordering called the
"pseudo-pack" order, which (more or less) looks like all of the objects
in a MIDX first sorted by which pack they came from, and then sorted by
their order within the pack, removing duplicates in favor of the
"preferred" pack.

More thorough documentation on this can be found in the
"multi-pack reverse indexes" section of
"Documentation/technical/pack-format.txt".

> The current task is to improve the performance of this bitmap approach.
> There are three points that we need to work on -
>
> 1. Decompression of bitmaps is slow with EWAH. To know if an object is
>    related to a particular commit, we have to decompress the whole thing.
>    So, we have to consider other alternative techniques besides EWAH.

Right, we can't begin to interpret the bitmaps until after decompressing
them (ditto for operations that involve compressed bitmaps, e.g., we
can't OR two EWAH compressed bitmaps together without first
decompressing them).

But I want to be careful about the word "slow" here. They might be slow,
or it might be really fast to decompress a given bitmap, depending on
the disk performance, CPU pressure, how large the bitmaps are, and so
on. So I think a good first step here is to validate our assumption that
EWAH decompression is even slow to begin with.

(Of course, the literature on newer formats will readily tell you that
the old stuff is slower, but I think it's worth reevaluating those
statements in the context of a practical application instead of in
theory / benchmarks).

> 2. Loading a `.bitmap` file can be slow for large bitmaps. This is because
>    we need to read the file sequentially in order to discover the offset of
>    each bitmap within the file. It would be better if we can create a `table
>    of contents` for these bitmaps.

Same comments here about whether or not this is slow to begin with. From
my experimental patches in this area earlier, I found that we could get
a significant speed-up in some cases, but that the speed-up was
basically obliterated whenever we had to do any follow-on traversal if
the bitmap coverage wasn't completely up-to-date.

> 3. Regenerating bitmaps can take a long time. One possible approach is to
>    add a new mode which only adds new bitmaps for commits introduced between
>    successive bitmap generations.

Definitely true. Another way to look at this is that it's now possible
to do some "incremental" work as far as repacking a repository goes, but
that updating its bitmap is still much less "incremental" than it could
be.

> 4. If we solve the above points, we would think of other aspects like
>    rethinking how we select which commit receives bitmaps etc.

Arguably we could do this whether or not we solve the above, but doing
some combination of the above may make it easier (e.g., if we wanted to
change the bitmap selection to store dramatically more commits, then we
may want to investigate how much of a bottleneck the sequential read
requirement of .bitmap files would become for different numbers of
selected commits).

> ### Previous Work
>
> I didn’t find any previous patches regarding point no. 1. But there were
> some discussions about this. Derrick’s
> (comment)[https://lore.kernel.org/git/1685a358-f033-64e0-2e12-df3a1c10af19@gmail.com/]
> suggested considering the
> (Roaring+Run)[https://roaringbitmap.org/about/]
> technique. It is much faster than the currently implemented
> (EWAH)[https://arxiv.org/abs/0901.3751].
>
> Taylor initiated the `developing a table of contents for bitmap` work
> by creating a
> (branch and committing some patches)[https://github.com/git/git/compare/master...ttaylorr:tb/bitmap-commit-table]
> in that branch. From the
> (discussion)[https://lore.kernel.org/git/YNuiM8TR5evSeNsN@nand.local/]
> and the performance test results provided in that discussion,  it seems
> that it would improve overall performance. So, this would work as a
> reference for me while developing the table of contents for bitmaps
> (obviously after running performance tests and discussing the best
> approach).

This is a great summary of some of the existing work in this area!

> ### The plan
>
> As this project includes three ( actually four) sub projects, I would
> address them one by one -
>
> 1. Firstly I will understand the working of EWAH compression better.
>    I have gone through their documentation and have seen git’s
>    implementation code for it. The commit messages were really helpful
>    here. But I think I should research more. After that,  I can compare
>    (and discuss) each approach with respect to the EWAH approach on
>    some parameters (like amount of computation in each approach,
>    simplicity, memory usage, correctness i.e. does it always give the
>    correct output etc.). This comparison would lead me to take the
>    most ideal approach in this case. There are several techniques which
>    may work/perform better than the current EWAH implementation. I
>    have researched some of these techniques. One of them is obviously
>    the Roaring+Run method. I have gone through their
>    (research paper)[https://arxiv.org/pdf/1709.07821v6.pdf]
>    on this technique; it seems like a good approach to me. Other than
>    that, there is a golang package called
>    (sroar)[https://dgraph.io/blog/post/serialized-roaring-bitmaps-golang/]
>    (i.e. Serialized Roaring bitmaps), which is an open source package
>    ( mainly built for (Dgraph)[https://dgraph.io/])
>    and the creator of this package claims it is
>    (7x faster using 15x less memory)[https://github.com/dgraph-io/sroar#benchmarks].
>    It doesn’t require any encoding/decoding step. I would look into
>    it ( It needs to be implemented in C language though). I have also
>    looked into approaches like
>    (bloom filter)[https://en.wikipedia.org/wiki/Bloom_filter],
>    (Hyperloglog)[https://en.wikipedia.org/wiki/HyperLogLog]. These are
>    very fast and use very less memory. But they give probabilistic
>    answers and sometimes they may give wrong answers. So, those
>    would not be a good fit for us I guess.

For bitmaps, the number one thing we care about is correctness. I have
never thought about using Bloom filters before; even though the
one-sided nature of their errors means that we would never forget to
send an object that we should have, having an absolute result is vastly
preferred.

After that, I think we mostly care about how quickly they can be
decompressed. And after that, I think we care about things like "how
fast can they be written", and "how large are they".

> 2. I will understand the bitmap related files such as
>    `pack-bitmap-write.c`[4], `pack-bitmap.c`[5] etc. It would
>    help me to decide where and how I can add the code related to
>    `table of contents` for bitmap.
>    Taylor’s (branch work)[https://github.com/git/git/compare/master...ttaylorr:tb/bitmap-commit-table]
>    would work as a reference for me. As the Project idea section
>    suggests, I would also include performance tests to continuously
>    check whether my approach is really improving the performance or
>    not.

Developing some performance tests up-front (including expanding on the
existing ones in the t/perf suite) I think is a good first step after
doing some basic research. That will help keep us honest about whether
our changes are moving us in the right direction or the wrong one.

> 3. As I understand more about bitmap related files, I will surely
>    be able to think whether `adding a new mode` is really necessary
>    or not (It is conceptually a good idea though). If necessary,
>    then I would first make the flow design and discuss it with the
>    community. If all is good, I will start working on it. Creating
>    and running performance tests is a must.

> 4. While developing all of these, my understanding of bitmap and
>    its implementation will get better. So, that would help me to
>    think more practically about the questions provided in the `Project
>    Idea` section. Then I would work on it accordingly.

This all sounds very good and ambitious. Keep in mind, though, that
these projects have a tendency to take much more time than expected ;-).
If we get one done, I'll be thrilled! (The goal with suggesting a few
potential directions to go in is not to say: "let's do all of these
things", but rather to give you some options in terms of what you find
most interesting and exciting to work on).

So I think it makes sense to try and find a way you can dip your toes
into 2-3 of the sub-projects and get a sense for what feels most doable
and interesting, then focus on that before allocating time for more
projects in the future.

> ## Estimated Timeline

Like I said, I'm fine if you spend your entire GSoC project working on
just one of these projects. So I don't want to get hung up on specific
timelines just yet. If you end up working on this, I would suggest
budgeting a week or so to try out a couple of different sub-projects,
and then decide where to spend your time from there.

> ## Blogging about Git
>
> I love to write blogs and technical articles. Those are my ways to
> connect and communicate with the developers community. I have
> previously written articles about Django in a portal named
> (GeeksForGeeks)[https://auth.geeksforgeeks.org/user/riter79/articles].
> Recently I started writing  blogs on
> (Medium platform)[https://medium.com/@abhra303].
>
> During the GSoC event, I will frequently write blogs about my
> progress. I will also share the problems I face and the solutions
> of those problems that I consider.

Great!

> I got interested in git by reading Olga’s GSoC blogs. That led me
> to contribute to this codebase. So, someone like me will hopefully
> be motivated by seeing my blogs ;-)
>
> ## Availability
>
> I intentionally freed my summer slot for GSoC. So, there wouldn’t
> be much disturbance/inactive days while working on my project.
> Generally, I can spend nearly 35-40 hours a week on this project.
> If the college gets closed for some reason, then the amount of
> available time will increase. Smart India Hackathon finale would
> be held in July. So, I may be inactive for a few days. But overall,
> I will be available most of the time.

All sounds good to me.

> I hope you’ll give me a chance to make an impact among the developers
> community by considering my application.

Thanks very much for your interest and the time you spent putting this
proposal together. I hope that some of my comments were helpful in
refining it, and that you didn't mind my slow response too much.

Thanks,
Taylor
