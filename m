Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB010C388F7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 23:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6169520786
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 23:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd6KrPaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbgKDXhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732763AbgKDXhw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 18:37:52 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0738EC0613CF
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 15:37:52 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id l2so180750lfk.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 15:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=aSCisp6XQ5d/yHqkS3s31z7Ax2yQQ8KJWiqNyNqKtqU=;
        b=Hd6KrPaBBGdp4iPV8lByYdiqpzWYRWMheUi/sy19f9otrp/XtHMwsrrgXX7FSJqF2b
         BHYrdpJexUMMDGL1gbPs+Izo1NzDUuPcF8K6C6FTUcf7kH0NiVmBZj3YcTwX4sdnE/SV
         UbgGXXhpTMRuEvP0aUmzjznQnnn/X7HDkmtFbQE4J/SCePWE42bjRfMA9wGce8LD1Zok
         DWIG7Y/CMucC0ouRB4ZfMYlGdNC8y0mHCpmut1Kt7BySa6xPph+M5opJOgWIJl4FkAUe
         TyLRIYZr96DWVXh0GYBhJFgsRzKzjzw8a9LUTrWugbK0zqetIYd3iWJVouGHaTlSi5XU
         BJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=aSCisp6XQ5d/yHqkS3s31z7Ax2yQQ8KJWiqNyNqKtqU=;
        b=mimW+hdzlcyI1XSp8JdbHg3vBPto4d1jZIDPAxe8KIWzomQJ1N09K7LCxUCG0SUXhY
         Csp2Sa5ezkwZMD2fnkZftwaX4h467NzN7S531NVMLXRFv4Tj1KRW/FYL/Bj3oIONOPiQ
         RBMX2AZUafDZoF5OVPLgiYw487v2+dlo1zpnR2b0EBuk2iHJkBU0xVbQX2SRjMLkqbVJ
         /vS+hT624IVUHP5DB+TOj0Fvzpo66ePrxRBpXWfd4erKfyqBuS/wfALUyFen6k6pIfAJ
         OqTKp2OMBSAf5GAVwZRf5phIW17vDXayECsChD3nEo02U9fQc539kl1jWFHbfqdmjoXK
         vWdQ==
X-Gm-Message-State: AOAM533YPHwd8cMOv2Ql04mHbyNhtGA07WF0YkCW7JEI+MHYDDL/roVH
        22h/lujPS4wHn8gdREFV8Ug=
X-Google-Smtp-Source: ABdhPJyBCq2Nlgg7KBiLbv6XaIDTRK6BDl+PVopD2wnqoD2lYVzPtqq8xhrBCxpgD29zb2qqtrRPrw==
X-Received: by 2002:a19:2d5:: with SMTP id 204mr36934lfc.117.1604533070311;
        Wed, 04 Nov 2020 15:37:50 -0800 (PST)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id j24sm548138lfb.9.2020.11.04.15.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:37:49 -0800 (PST)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v4 00/10] [GSoC] Implement Corrected Commit Date
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
Date:   Thu, 05 Nov 2020 00:37:49 +0100
In-Reply-To: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com> (Abhishek
        Kumar via GitGitGadget's message of "Wed, 07 Oct 2020 14:09:35 +0000")
Message-ID: <85tuu4lmlu.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhishek,

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series implements the corrected commit date offsets as generat=
ion
> number v2, along with other pre-requisites.

Thanks a lot for continued working on this patch series.

>
> Git uses topological levels in the commit-graph file for commit-graph
> traversal operations like git log --graph. Unfortunately, using topologic=
al
> levels can result in a worse performance than without them when compared
> with committer date as a heuristics. For example, git merge-base v4.8 v4.=
9=20
> on the Linux repository walks 635,579 commits using topological levels and
> walks 167,468 using committer date.

Very minor nitpick: it would make it easier to read if the commands
themself would be put inside single quotes or backticks, e.g. `git log
--graph` and `git merge-base v4.8 v4.9`.

I wonder if it is worth mentioning (probably not) that this performance
hit was the reason why since 091f4cf3 `git merge-base` uses committer
date heuristics unless there is a cutoff and using topological levels
(generation date v1) is expected to give better performance.

>
> Thus, the need for generation number v2 was born. New generation number
> needed to provide good performance, increment updates, and backward
> compatibility. Due to an unfortunate problem 1

Minor issue: this looks a bit strange; is there an error in formatting
this part?

> [https://public-inbox.org/git/87a7gdspo4.fsf@evledraar.gmail.com/], we al=
so
> needed a way to distinguish between the old and new generation number
> without incrementing graph version.
>
> Various candidates were examined (https://github.com/derrickstolee/gen-te=
st,=20
> https://github.com/abhishekkumar2718/git/pull/1). The proposed generation
> number v2, Corrected Commit Date with Mononotically Increasing Offsets=20
> performed much worse than committer date (506,577 vs. 167,468 commits wal=
ked
> for git merge-base v4.8 v4.9) and was dropped.
>
> Using Generation Data chunk (GDAT) relieves the requirement of backward
> compatibility as we would continue to store topological levels in Commit
> Data (CDAT) chunk.

Nice writeup about the history of generation number v2, much appreciated.

>                    Thus, Corrected Commit Date was chosen as generation
> number v2. The Corrected Commit Date is defined as:

Minor nitpick: it would be probably better to use "is defined as
follows." instead of "is defined as:".

>
> For a commit C, let its corrected commit date be the maximum of the commit
> date of C and the corrected commit dates of its parents plus 1. Then=20
> corrected commit date offset is the difference between corrected commit d=
ate
> of C and commit date of C. As a special case, a root commit with timestamp
> zero has corrected commit date of 1 to be able distinguish it from
> GENERATION_NUMBER_ZERO (that is, an uncomputed corrected commit date).

Very minor nitpick: s/with timestamp/with *the* timestamp/, and
s/to be able distinguish/to be able *to* distinguish/ (without the '*'
used to mark the additions).

>
> We will introduce an additional commit-graph chunk, Generation Data chunk,

Or "Generation DATa chunk", if we want to emphasize where its name came
from, or even "Generation DATa (GDAT) chunk". But it is fine as it is
now, though it would be good idea to write "Generation Data (GDAT)
chunk" to explicitly state its name / shortcut.

> and store corrected commit date offsets in GDAT chunk while storing
> topological levels in CDAT chunk. The old versions of Git would ignore GD=
AT
> chunk, using topological levels from CDAT chunk. In contrast, new versions
> of Git would use corrected commit dates, falling back to topological level
> if the generation data chunk is absent in the commit-graph file.

Nice writeup of handling the backward compatibility.

>
> While storing corrected commit date offsets saves us 4 bytes per commit (=
as
> compared with storing corrected commit dates directly), it's possible for
> the offset to overflow the space allocated. To handle such cases, we
> introduce a new chunk, Generation Data Overflow (GDOV) that stores the
> corrected commit date. For overflowing offsets, we set MSB and store the
> position into the GDOV chunk, in a mechanism similar to the Extra Edges l=
ist
> chunk.

Very minor suggestion: perhaps it would be better to use "it's however
possible".

Very minor suggestion: "it's possible for the offset to overflow" could
be simplified to just "the offset can overflow"... though the simplified
version loses a bit of hint that the overflow should be very rare in
real repositories.

But it is just fine as it is now; I am not a native English speaker to
judge which version is better.

>
> For mixed generation number environment (for example new Git on the comma=
nd
> line, old Git used by GUI client), we can encounter a mixed-chain
> commit-graph (a commit-graph chain where some of split commit-graph files
> have GDAT chunk and others do not). As backward compatibility is one of t=
he
> goals, we can define the following behavior:
>
> While reading a mixed-chain commit-graph version, we fall back on
> topological levels as corrected commit dates and topological levels cannot
> be compared directly.
>
> While writing on top of a split commit-graph, we check if the tip of the
> chain has a GDAT chunk. If it does, we append to the chain, writing GDAT
> chunk. Thus, we guarantee if the topmost split commit-graph file has a GD=
AT
> chunk, rest of the chain does too.
>
> If the topmost split commit-graph file does not have a GDAT chunk (meaning
> it has been appended by the old Git), we write without GDAT chunk. We do
> write a GDAT chunk when the existing chain does not have GDAT chunk - when
> we are writing to the commit-graph chain with the 'replace' strategy.

I think the last paragraph can be simplified (or added to) by explicitly
stating the goal:

  When adding new layer to the split commit-graph file, and when merging
  some or all layers (replacing them in the latter case), the new layer
  will have GDAT chunk if and only if in the final result there would be
  no layer without GDAT chunk just below it.

>
> Thanks to Dr. Stolee, Dr. Nar=C4=99bski, and Taylor for their reviews.

You are welcome.

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
> Changes in version 4:
>
>  * Added GDOV to handle overflows in generation data.
>  * Added a test for writing tip graph for a generation number v2 graph ch=
ain
>    in t5324-split-commit-graph.sh
>  * Added a section on how mixed generation number chains are handled in=20
>    Documentation/technical/commit-graph-format.txt
>  * Reverted unimportant whitespace style changes in commit-graph.c
>  * Added header comments about the order of comparision for
>    compare_commits_by_gen_then_commit_date in commit.h,
>    compare_commits_by_gen in commit-graph.h
>  * Elaborated on why t6404 fails with corrected commit date and must be r=
un
>    with GIT_TEST_COMMIT_GRAPH=3D1 in the commit "commit-reach: use correc=
ted
>    commit dates in paint_down_to_common()"
>  * Elaborated on write behavior for mixed generation number chains in the
>    commit "commit-graph: use generation v2 only if entire chain does"
>  * Added notes about adding the topo_level slab to struct
>    write_commit_graph_context as well as struct commit_graph.
>  * Clarified commit message for "commit-graph: consolidate
>    fill_commit_graph_info"
>  * Removed the claim "GDAT can store future generation numbers" because it
>    hasn't been tested yet.
>
> Changes in version 3:
>
>  * Reordered patches as discussed in 2
>    [https://lore.kernel.org/git/aee0ae56-3395-6848-d573-27a318d72755@gmai=
l.com/]
>    .
>  * Split "implement corrected commit date" into two patches - one
>    introducing the topo level slab and other implementing corrected commit
>    dates.
>  * Extended split-commit-graph tests to verify at the end of test.
>  * Use topological levels as generation number if any of split commit-gra=
ph
>    files do not have generation data chunk.
>
> Changes in version 2:
>
>  * Add tests for generation data chunk.
>  * Add an option GIT_TEST_COMMIT_GRAPH_NO_GDAT to control whether to write
>    generation data chunk.
>  * Compare commits with corrected commit dates if present in
>    paint_down_to_common().
>  * Update technical documentation.
>  * Handle mixed generation commit chains.
>  * Improve commit messages for "commit-graph: fix regression when computi=
ng
>    bloom filter", "commit-graph: consolidate fill_commit_graph_info",
>  * Revert unnecessary whitespace changes.
>  * Split uint_32 -> timestamp_t change into a new commit.

After careful review of those 10 patches it looks like the series is
close to being ready, requiring only small changes to progress.

> Abhishek Kumar (10):
>   commit-graph: fix regression when computing Bloom filters

    All good, beside possible improvement to the commit message.
    Thanks to Taylor Blau for discovering possible reason for strange
    no change in performance.

>   revision: parse parent in indegree_walk_step()

    Looks good.

>   commit-graph: consolidate fill_commit_graph_info

    Needs to fix now duplicated test names (minor change).
    Proposed possible improvement to the commit message.

>   commit-graph: return 64-bit generation number

    Needs fixing due to mismerge: there should be no switch from
    using GENERATION_NUMBER_ZERO to using GENERATION_NUMBER_INFINITY.
    Possible minor improvement to the commit message.

>   commit-graph: add a slab to store topological levels

    Possible minor improvement to the commit message.
=20=20=20=20
    There is also not very important issue, but something that would be
    nice to explain, namely that checks for GENERATION_NUMBER_INFINITY=20
    can never be true, as topo_level_slab_at() returns 0 for commits
    outside the commit-graph, not GENERATION_NUMBER_INFINITY.  It works
    but it is not obvious why.

>   commit-graph: implement corrected commit date

    The change to commit-graph verification needs fixing, and we need to
    decide how verifying generation numbers should work.  Perhaps a test
    for handling topological level of GENERATION_NUMBER_V1_MAX could be
    added (though this might be left for ater).

    The changes to `git commit-graph verify` code could be put into
    separate patch, either before or after this one.

>   commit-graph: implement generation data chunk

    Proposed possible improvement to the commit message.
    The commit message does not explain why given shape of history is
    needed to test handling corrected commit date offset overflow.

    Proposed minor corrections to the coding style.

    Instead of looping again through all commits when handling overflow
    in corrected commit date offsets, while there should be at most a
    few commits needing it, why not save those commits on list and loop
    only through those commits?  Though this _possible_ performance
    improvement could be left to the followup...

    test_commit_with_date() could be instead implemented via adding
    `--date <date>` option to test_commit() in test-lib-functions.sh.

    Also, to reduce "noise" in this patch, the rename of
    run_three_modes() to run_all_modes() and test_three_modes() to
    test_all_modes() could have been done in a separate preparatory
    patch. It would be pure refactoring patch, without introducing any
    new functionality.  But it is not something that is necessary.

>   commit-graph: use generation v2 only if entire chain does

    Proposed possible improvement to the commit message.
    Proposed minor corrections to the coding style (also in tests).

    There is a question whether merging layers or replacing them should
    honor GIT_TEST_COMMIT_GRAPH_NO_GDAT.

    Tests possibly could be made more strict, and check more things
    explicitly. One test we are missing is testing that merging layers
    is done correctly, namely that if we are merging layers in split
    commit-graph file, and the layer below the ones we are merging lacks
    GDAT chunk, then the result of the merge should also be without GDAT
    chunk -- but that might be left for later.

>   commit-reach: use corrected commit dates in paint_down_to_common()

    This patch consist of two slightly interleaved changes, which
    possibly could be separated: change to paint_down_to_common() and
    change to t6404-recursive-merge test.

    In the commit message for the paint_down_to_common() we should
    explicitly mention 091f4cf3, which this one partially reverts.

    Possible accidental change, question about function naming.

>   doc: add corrected commit date info

    Needs further improvements to the documentation, like adding
    "[Optional]" to chunk description, and leftover switching from
    "generation numbers" to "topological levels" in one place.

>
>  .../technical/commit-graph-format.txt         |  21 +-
>  Documentation/technical/commit-graph.txt      |  62 ++++-
>  commit-graph.c                                | 256 ++++++++++++++----
>  commit-graph.h                                |  17 +-
>  commit-reach.c                                |  38 +--
>  commit-reach.h                                |   2 +-
>  commit.c                                      |   4 +-
>  commit.h                                      |   5 +-
>  revision.c                                    |  13 +-
>  t/README                                      |   3 +
>  t/helper/test-read-graph.c                    |   4 +
>  t/t4216-log-bloom.sh                          |   4 +-
>  t/t5000-tar-tree.sh                           |  20 +-
>  t/t5318-commit-graph.sh                       |  70 ++++-
>  t/t5324-split-commit-graph.sh                 |  98 ++++++-
>  t/t6404-recursive-merge.sh                    |   5 +-
>  t/t6600-test-reach.sh                         |  68 ++---
>  upload-pack.c                                 |   2 +-
>  18 files changed, 534 insertions(+), 158 deletions(-)
>
>
> base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-676%2Fa=
bhishekkumar2718%2Fcorrected_commit_date-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-676/abhish=
ekkumar2718/corrected_commit_date-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/676
[...]

Best,
--=20
Jakub Nar=C4=99bski
