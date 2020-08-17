Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B040C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 00:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3D12075D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 00:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vg4w+sIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgHQANZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 20:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgHQANW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 20:13:22 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1D8C061786
        for <git@vger.kernel.org>; Sun, 16 Aug 2020 17:13:21 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i19so7468123lfj.8
        for <git@vger.kernel.org>; Sun, 16 Aug 2020 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=u3018+3rBvBavDaSLO1vAaWu6JLdKU9x8q1uLa8lejw=;
        b=vg4w+sIjNp1PGkNF1K5+1JS8J1byuVSDf12NlDKMYuMsl+pkCK5PoX5LAaCATBMLAg
         p3pbXa3qC2VjE3FKlyqkzPFP417TngkU/QHd0+rmwKQ7S/pQBzrXG4TA9GqEbhDCd7Ci
         MxhPYk7C6tSwj6F5TpKjy6LD2Zf1mOqZep91+bvfGIN9+ZnQr0fsB3+OY8jln4me4Uqa
         fXm4/YLNIgfUWSxbrzJZYMCFJU/8n3Xa5j2JQt5cOS+o7bWX4uLLR5D8KrUKSyKOfb0t
         gwwfPsSckXreG5xYqN5v/3FICuNpLhTor1I8HGu2bSu8ot8P+V3KDjKzmx6/dGv/UnuR
         RTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=u3018+3rBvBavDaSLO1vAaWu6JLdKU9x8q1uLa8lejw=;
        b=d/3VgKpjubnYJ9nCGhxnO0HigLC88zRTcFFLlnezZSzmEIkTmabPEkHsKK2gMmwkqe
         YMny0/Hzdslwg6QcdLIX8qGXM6h9/HewSVQ5jqwyxSirodcMQgbANlnXCe5fL7IkziSW
         5d9ohee7tEN7u2o+jHTEiGK0ht3WRhafyx2j5PWsfLO/yfFPYsVRq/L9dpGFHdtMLGiw
         ZrLainivBz+KdPtyuIK/cyrmf076Uo0f0+CcaFiY6kjq6dFYPUhDJ1X+h5rcfwg0Y52j
         IbZZqAtvU7AvcD9qmqkyu+vmy8GN1TTI5NtSNP3mWJYvYiFJ0xLARW48rCyC10gyvA3z
         +jBg==
X-Gm-Message-State: AOAM530xyJzn3d6PUuiHMjh6FzV8eN1sH9HcmOsHFD5SwcwNrDmY5aEZ
        B4Mba0oxxbt4EbHGhLqBWMfZdmRT1rAJvA==
X-Google-Smtp-Source: ABdhPJz7BEn/GngIXk1Ed/NnZx3rePfbIyTKsbom2Yc+ArCUs0t5LsheN3nVurfRdbW4WoqTbGyOUw==
X-Received: by 2002:a19:f808:: with SMTP id a8mr6204928lff.62.1597623200022;
        Sun, 16 Aug 2020 17:13:20 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id r11sm4323550lji.104.2020.08.16.17.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 17:13:19 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 00/11] [GSoC] Implement Corrected Commit Date
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 02:13:18 +0200
In-Reply-To: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com> (Abhishek
        Kumar via GitGitGadget's message of "Sat, 15 Aug 2020 16:39:32 +0000")
Message-ID: <85zh6uxh7l.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series implements the corrected commit date offsets as generat=
ion
> number v2, along with other pre-requisites.

I'm not sure if this level of detail is required in the cover letter for
the series, but generation number v2 is corrected commit date; corrected
commit date offsets is how we store this value in the commit-graph file.

>
> Git uses topological levels in the commit-graph file for commit-graph
> traversal operations like git log --graph. Unfortunately, using topologic=
al
> levels can result in a worse performance than without them when compared
> with committer date as a heuristics. For example, git merge-base v4.8 v4.9
> on the Linux repository walks 635,579 commits using topological levels and
> walks 167,468 using committer date.

I would say "committer date heuristics" instead of just "committer
date", to be more exact.

Is this data generated using https://github.com/derrickstolee/gen-test
scripts?

>
> Thus, the need for generation number v2 was born. New generation number
> needed to provide good performance, increment updates, and backward
> compatibility. Due to an unfortunate problem, we also needed a way to
> distinguish between the old and new generation number without incrementing
> graph version.

It would be nice to have reference email (or other place with details)
for "unfortunate problem".

>
> Various candidates were examined (https://github.com/derrickstolee/gen-te=
st,
> https://github.com/abhishekkumar2718/git/pull/1). The proposed generation
> number v2, Corrected Commit Date with Mononotically Increasing Offsets
> performed much worse than committer date (506,577 vs. 167,468 commits wal=
ked
> for git merge-base v4.8 v4.9) and was dropped.
>
> Using Generation Data chunk (GDAT) relieves the requirement of backward
> compatibility as we would continue to store topological levels in Commit
> Data (CDAT) chunk. Thus, Corrected Commit Date was chosen as generation
> number v2.

This is a bit of simplification, but good enough for a cover letter.

To be more exact, from various candidates the Corrected Commit Date was
chosen.  Then it turned out that old Git crashes on changed commit-graph
format version value, so if the generation number v2 was to replace v1
it needed to be backward-compatibile: hence the idea of Corrected Commit
Date with Monotonically Increasing Offsets.  But with GDAT chunk to
store generation number v2 (and for the time being leaving generation
number v1, i.e. Topological Levels, in CDAT), we are no longer
constrained by the requirement of backward-compatibility to make old Git
work with commit-graph file created by new Git.  So we could go back to
Corrected Commit Date, and as you wrote above the backward-compatibile
variant performs worse.

> The Corrected Commit Date is defined as:
>
> For a commit C, let its corrected commit date be the maximum of the commit
> date of C and the corrected commit dates of its parents.

Actually it needs to be "corrected commit dates of its parents plus 1"
to fulfill the reachability condition for a generation number for a
commit:

      A can reach B   =3D>  gen(A) < gen(B)

Of course it can be computed in simpler way, because

  max_P (gen(P) + 1)  =3D=3D  max_P (gen(P)) + 1


>                                                           Then corrected
> commit date offset is the difference between corrected commit date of C a=
nd
> commit date of C.

All right.

>
> We will introduce an additional commit-graph chunk, Generation Data chunk,
> and store corrected commit date offsets in GDAT chunk while storing
> topological levels in CDAT chunk. The old versions of Git would ignore GD=
AT
> chunk, using topological levels from CDAT chunk. In contrast, new versions
> of Git would use corrected commit dates, falling back to topological level
> if the generation data chunk is absent in the commit-graph file.

All right.

However I think the cover letter should also describe what should happen
in a mixed version environment (for example new Git on command line,
copy of old Git used by GUI client), and in particular what should
happen in a mixed-chain case - both for reading and for writing the
commit-graph file.

For *writing*: because old Git would create commit-graph layers without
the GDAT chunk, to simplify the behavior and make easy to reason about
commit-graph data (the situation should be not that common, and
transient -- it should get more rare as the time goes), we want the
following behavior from new Git:

- If top layer contains the GDAT chunk, or we are rewriting commit-graph
  file (--split=3Dreplace), or we are merging layers and there are no
  layers without GDAT chunk below set of layers that are merged, then

     write commit-graph file or commit-graph layer with GDAT chunk,

  otherwise

     write commit-graph layer without GDAT chunk.

  This means that there are commit-graph layers without GDAT chunk if
  and only if the top layer is also without GDAT chunk.


For *reading* we want to use generation number v2 (corrected commit
date) if possible, and fall back to generation number v1 (topological
levels).

- If the top layer contains the GDAT chunk (or maybe even if the topmost
  layer that involves all commits in question, not necessarily the top
  layer in the full commit-graph chain), then use generation number v2

  - commit_graph_data->generation stores corrected commit date,
    computed as sum of committer date (from CDAT) and offset (from GDAT)

  - A can reach B   =3D>  gen(A) < gen(B)

  - there is no need for committer date heuristics, and no need for
    limiting use of generation number to where there is a cutoff (to not
    hamper performance).

- If there are layers without GDAT chunks, which thanks to the write
  behavior means simply top layer without GDAT chunk, we need to turn
  off use of generation numbers or fall back to using topological levels

  - commit_graph_data->generation stores topological levels,
    taken from CDAT chunk (30-bits)

  - A can reach B   =3D>  gen(A) < gen(B)

  - we probably want to keep tie-breaking of sorting by generation
    number via committer date, and limit use of generation number as
    opposed to using committer date heuristics (with slop) to not make
    performance worse.

>
> Thanks to Dr. Stolee, Dr. Nar=C4=99bski, and Taylor for their reviews on =
the
> first version.
>
> I look forward to everyone's reviews!
>
> Thanks
>
>  * Abhishek
>
>
> -------------------------------------------------------------------------=
---
>
> Changes in version 3:
>
>  * Reordered patches as discussed in 1
>    [https://lore.kernel.org/git/aee0ae56-3395-6848-d573-27a318d72755@gmai=
l.com/]

If I remember it correctly this was done to always store in GDAT chunk
corrected commit date offsets, isn't it?

>  * Split "implement corrected commit date" into two patches - one
>    introducing the topo level slab and other implementing corrected commit
>    dates.

All right.

I think it might be good idea to split off the change to tar file tests
(as a preparatory patch), to make reviews and bisecting easier.

>  * Extended split-commit-graph tests to verify at the end of test.

Do we also test for proper merging of split commit-graph layers, not
only adding a new layer and a full rewrite (--split=3Dreplace)?

>  * Use topological levels as generation number if any of split commit-gra=
ph
>    files do not have generation data chunk.

That is good for performance.

>
> Changes in version 2:
>
>  * Add tests for generation data chunk.

Good.

>  * Add an option GIT_TEST_COMMIT_GRAPH_NO_GDAT to control whether to write
>    generation data chunk.

Good, that is needed for testing mixed-version behavior.

>  * Compare commits with corrected commit dates if present in
>    paint_down_to_common().

All right, but see the caveat.

>  * Update technical documentation.

Always a good thing.

>  * Handle mixed graph version commit chains.

Where by "version" you mean generation number version - the commit-graph
version number unfortunately needs to stay the same...

>  * Improve commit messages for
                                ^^^^^^
Something missing in this point, the sentence ends abruptly.

>  * Revert unnecessary whitespace changes.

Thanks.

>  * Split uint_32 -> timestamp_t change into a new commit.

It is usually better to keep the commits small.  Good.


Good work!

>
> Abhishek Kumar (11):
>   commit-graph: fix regression when computing bloom filter
>   revision: parse parent in indegree_walk_step()
>   commit-graph: consolidate fill_commit_graph_info
>   commit-graph: consolidate compare_commits_by_gen
>   commit-graph: return 64-bit generation number
>   commit-graph: add a slab to store topological levels
>   commit-graph: implement corrected commit date
>   commit-graph: implement generation data chunk
>   commit-graph: use generation v2 only if entire chain does
>   commit-reach: use corrected commit dates in paint_down_to_common()
>   doc: add corrected commit date info
>
>  .../technical/commit-graph-format.txt         |  12 +-
>  Documentation/technical/commit-graph.txt      |  45 ++--
>  commit-graph.c                                | 241 +++++++++++++-----
>  commit-graph.h                                |  16 +-
>  commit-reach.c                                |  49 ++--
>  commit-reach.h                                |   2 +-
>  commit.c                                      |   9 +-
>  commit.h                                      |   4 +-
>  revision.c                                    |  13 +-
>  t/README                                      |   3 +
>  t/helper/test-read-graph.c                    |   2 +
>  t/t4216-log-bloom.sh                          |   4 +-
>  t/t5000-tar-tree.sh                           |   4 +-
>  t/t5318-commit-graph.sh                       |  27 +-
>  t/t5324-split-commit-graph.sh                 |  82 +++++-
>  t/t6024-recursive-merge.sh                    |   4 +-
>  t/t6600-test-reach.sh                         |  62 +++--
>  upload-pack.c                                 |   2 +-
>  18 files changed, 396 insertions(+), 185 deletions(-)
>
>
> base-commit: 7814e8a05a59c0cf5fb186661d1551c75d1299b5
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-676%2Fa=
bhishekkumar2718%2Fcorrected_commit_date-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-676/abhish=
ekkumar2718/corrected_commit_date-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/676
[...]

Best,
--
Jakub Nar=C4=99bski
