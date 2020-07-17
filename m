Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB82BC433E0
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 22:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20A52074B
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 22:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTWTde1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgGQWtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQWtP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 18:49:15 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73ABC0619D2
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 15:49:14 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d17so14476317ljl.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 15:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-transfer-encoding;
        bh=G/90Psg8dhfk4NbMQTEvQn7qtcXHR7pim7Etmn4A5YU=;
        b=bTWTde1byl7yFwAf3OIxhn2O7z0+g85LAlrqiXNGSy/9M80VYmlVGgzkJOpvqhit/I
         VX6+zxH7HIcPNGk8jArqJQXxIsBwy8BJUUPKaJKmWGNeMTftzy+BhdfbPCXA0VWcWNxm
         fTHCihgvUL46vfJhFYZRZ36yR5hZe2tQLI6kgtZsAOn+QIWZzP6+SR7My5X9wkz9aWeY
         PoaWrV7iG21L2j4Foe+0FE8YwZp6ZlVWIjpy/OcWXxiBbvQwZQBel/d4MhsU9FKoZtEw
         KHXkvkorh4MhuB7A1/r6vKmPmqWIgZH5aLq2ELkCHfXt1hhYs3unoTo0NhbI74ybB8/j
         ptJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-transfer-encoding;
        bh=G/90Psg8dhfk4NbMQTEvQn7qtcXHR7pim7Etmn4A5YU=;
        b=IZaYujS38UOOn6nIvYIa9AYxH2y/2GyCmdVO+PeMKgGeP49BKxwe/Cdq1gxGY1mLmr
         O5wb9HUuq9k5T4QsXvQiUglu5XsR1e0k6UQaNw1Lj8u74Xom9MF9qfqEeO7lGURbhya8
         uciGtWV6IgTeG6b9/Up6/8n/kzsqhNClQzm2you6P+plx70z4oR4VBZxz031wXGSsU7G
         W+ddHXrYNpERABmTYQ4zm6E+caXOP/XTcAYvZNw22ThlX0BpWtRhy6gOVcMAjzqpV9j9
         gVq8PEZ6wF3zicxwbSi/NGvRZuVDe3YfKv4eLwiQxP6mxnnTucC3MHRL7YCWTcy63XpH
         WOCw==
X-Gm-Message-State: AOAM531adg/d61ApqkTggTeS1Dhl8t2ALJg7sdfc2mpS3ZOoASsaPVz0
        Ea7N2szQPWGVhLKY2wAUIV8=
X-Google-Smtp-Source: ABdhPJxJGtEm7g0j6HOW2KZxakQQ3GiSz2q9EmSEM76HL8nBiW6DrF2y9sd2TGwDmUsdG+h07jL7XA==
X-Received: by 2002:a05:651c:1105:: with SMTP id d5mr5689436ljo.62.1595026153334;
        Fri, 17 Jul 2020 15:49:13 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id l4sm1872448ljc.83.2020.07.17.15.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 15:49:12 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSOC] Blog about week 6
In-Reply-To: <20200714063236.GB10242@Abhishek-Arch> (Abhishek Kumar's message
        of "Tue, 14 Jul 2020 12:02:36 +0530")
References: <20200714063236.GB10242@Abhishek-Arch>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
Date:   Sat, 18 Jul 2020 00:49:11 +0200
Message-ID: <85k0z1pxjs.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> Hello everyone!
>
> Over the last week, I started implementing generation number v2. Based
> on the performance numbers and subsequent discussion, we have decided to
> use generation data chunk approach, storing topological levels into CDAT
> and corrected commit date offsets into GDAT chunk. Do note that we are
> maintaining backward compatibility using topological level, not with
> monotonic offsets.
>
> I also found a performance regression with `commit-graph write
> --reachable --changed_path` that sneaked in along with the patch on
> moving generation and graph positions into commit-slab.
>
> https://github.com/gitgitgadget/git/pull/676
>
> Yes, I pushed without signing off or a cover letter. It's still a work
> in progress.

All right.  Did you send this series of patches to git mailing list for
a review already, or is it only a working version?

>
> https://abhishekkumar2718.github.io/gsoc/2020/07/12/gsoc-week-6.html

Reply to the blog contents follows:

----------------------------------------------------------------------

> GSoC - Weeks 6
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Very minor nitpick / correction - I think you meant "Week" not "Weeks"
here in the title of this blog.

> Over the last week, I worked on implementing corrected commit date
> with generation data chunk and boy, was it painful!
>
> While working on the prototype, I used the space allocated for graph
> position to store topological level before writing it into CDAT chunk.

First, I assume that if we choose to not compute topological levels and
simply store GENERATION_NUMBER_MAX in the 30-bits in CDAT set for
generation number v1 we would not have this problem, isn't it?

Second, isn't `graph_pos` nowadays on the commit slab? Why reuse it,
which can lead to problems if other parts of code assume things about
its syntax, rather than making use of _new_ uint32_t `topo_level` commit
slab?  We have many different ad-hoc entries stored on the slab, what's
one more...

> However, while computing bloom filters, we call `get_bloom_filter()`.

Ah, I guess this happens when `git commit-graph write` is called with
the `--changed-paths` option, so we compute both generation numbers v1
and v2, and Bloom filters for changed paths.

> This function checks if the commit belongs to the commit-graph. If it
> does, load the bloom filters (avoiding a lot of computation).
> Otherwise, compute the filters and return it. Since I am storing
> topological levels in graph position, Git mistakenly thinks that we
> are reading a graph and tries to load bloom filter, segfaulting right
> away.

So don't do that; don't store topological level in graph position.

> Faced with the problem, I could think of three ideas:
>

> 1. Extend generation to be 64-bits (which we were planning on anyway)
>    and store topological levels within higher 32 bits and corrected date
>    offsets within lower 32 bits. Code for calculating corrected date
>    offsets, topological levels would be littered with bit shifts and
>    ANDs, but code for parsing and using generation numbers would be
>    clean.

If I remember it correctly, extending `generation` to 64-bits in
`struct commit_graph_data` (stored on slab) is there to store and
operate on the corrected commit(ter) date, instead of storing and
fiddling with offsets?

>
> 2. Use two 32-bits variables, level and odate, and use the contiguous
>    64 bits to store generation (while reading commit-graph): Code for
>    writing commit-graph is clean, but reading generation is much trickier
>    as we try to coerce value stored in (graph_data + 4) into a timestamp.

I don't quite get this idea.  For backward compatibility we have to
store topological levels in appropriate 30-bit wide field in CDAT chunk.
Storing topological levels in higher 32-bits of 64-bit GDAT chunk would
not provide it.

> 3. Split get_bloom_filters() into two functions - First checks if the
>    commit is from the graph and tries to load whereas the other computes
>    bloom filter. Then we could directly call the second function when
>    writing a commit-graph. I was not sure if this would have worked, but
>    I wanted not to change things unless required.

4. Store topological level data in a separate commit slab entry.
   This way any code that examines `commit_graph_data.position`,
   like `get_bloom_filter()`, wouldn't be mislead.

About the 4th possibility: does Git use both graph position and
generation number in the same process?  Because if it is not, then
perhaps putting graph_position and graph_generation_number in a
composite type `struct commit_graph_data` on slab might have been a
mistake.  Due to how modern CPUs work (with data prefetching and
pipelining) it might be more advantageous wrt performance to have
subsequent data for graph position or for generation number to be packed
and not strides, as it is now -- at least when accessing commits in the
commit.index order.

> I felt the first two approaches were too unreadable.
>

I think the 3rd approach is worth doing on its own, as it makes the code
bit clearer... but I have not actually examined the commits in the pull
request.

> In the end, I compromised by using a 64-bit generation and a 32-bit
> level in the initial commit and will restrict the ugly conversion to
> reuse 64-bits in a focused patch later in the series.

I would have to examine the patch in question in more detail, but I am
waiting for the series to be posted to Git mailing list (though I can be
persuaded to do pre-review on GitHub pull request, as pre-release step).

> Regression when computing bloom filters
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> While wrestling with the problem above, I noticed that
> `commit_gen_cmp()` lies in =E2=80=9Ccommit-graph write=E2=80=9D path but =
uses the
> helpers. But the helper would always return `GENERATION_NUMBER_MAX`
> as we found while moving generation number into a slab.
>
> Digging through git logs, I found [the patch][1], which introduced
> `commit_gen_cmp()`. Sorting commits make the computing bloom filters
> much, much faster. The helper returns the same value every time, which
> makes sorting pointless and nullifies the performance boost. Fixing
> this was easy, bypass the helper and access generation number.
>
> [1]: https://github.com/git/git/commit/3d11275505694ce4e5256516de1c5dd90e=
749303

Good catch!

Best,
--
Jakub Nar=C4=99bski
