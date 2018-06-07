Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406031F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932779AbeFGODp (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:03:45 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35572 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbeFGODn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:43 -0400
Received: by mail-qk0-f195.google.com with SMTP id d130-v6so6610335qkc.2
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AKVGwwQBg9u//cZKs+NAd3asRfxgbRAH0cDBZUTGd3A=;
        b=hqCo17FPbpat5toVvDLQ7HlnVTmqddMAzUnO3yOo5OWjPT7eqZMdNa8ovZLbY+oih9
         YAJgNqBwNTyPvFFADbVixjq6yL+KZ+Lk2pPyYXVnW8dfMT4OLOnSEZN1F46yAWNMoTwa
         K1NCGXNSsJ/dZgBYNk3ZsvbjWtESNpU/8+7GyF3/VW0LujNgv7sMksAmbx0rjAYim9hU
         uodAO9+rllweBqV4mOIZOgTKzTyeYES0U/1MoSihLe2PUryxyvfzXbFu7/Xf68TC0X8T
         WD4vK4SLM5wJxHFt3YyRmW8Rs8Fcnzj2baAku/bsodHggJ+SadSct59CrigwOmF9biUc
         ZifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AKVGwwQBg9u//cZKs+NAd3asRfxgbRAH0cDBZUTGd3A=;
        b=bEiJPx59SiloEYCa6+c6+T+IpXyVHrZfcbcj+hhKFbIcbkNoOPhFlKIiRSk8vEOKYO
         KFHjZVlYhYVm2iKLkIaXvaPhAUSP6fP8gFuzWbvFLZ1n90XF58btK+oHZK/YFptxyqGj
         c65NJTbk8jHrrCwbYcAnLFgo5QVcPf5a1sxjHwVAhXRcUgpBV965r8oE3ox6hKH0VucJ
         ZfUPZSkw0KB4NQCqNvmuNFR5RPbDX88g2YCqGsWGfrcdCm8SicAaNeZRIFL0S7YDPYbR
         r+SkW7sT3THR2A9h77wee6lmIHyzGNa8h4gmlNyjjVnTTDtPzgeVW4l6LGoE0wwrGF65
         4abw==
X-Gm-Message-State: APt69E2Sv96uvvjOQhRmTNXOMUpgeBL+qTbnppkvQMOvBEoZqJInEEuc
        ZK+tr8oIyfSVC1lbehxt2f4pifRT
X-Google-Smtp-Source: ADUXVKJUPke2+jGpoHeYhlsSD46alHnCGzX+s1ReG5LD6Bj7ZDgonXF2dj0z1WO3/+MH7lOC3V274Q==
X-Received: by 2002:a37:150b:: with SMTP id f11-v6mr1606761qkh.170.1528380222299;
        Thu, 07 Jun 2018 07:03:42 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:41 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 00/23] Multi-pack-index (MIDX)
Date:   Thu,  7 Jun 2018 10:03:15 -0400
Message-Id: <20180607140338.32440-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series includes a rewrite of the previous
multi-pack-index RFC [1] using the feedback from the
commit-graph feature.

I based this series on 'next' as it requires the
recent object-store patches.

The multi-pack-index (MIDX) is explained fully in
the design document 'Documentation/technical/midx.txt'.
The short description is that the MIDX stores the
information from all of the IDX files in a pack
directory. The crucial design decision is that the
IDX files still exist, so we can fall back to the IDX
files if there is any issue with the MIDX (or core.midx
is set to false, or a user downgrades Git, etc.)

The MIDX feature has been part of our GVFS releases
for a few months (since the RFC). It has behaved well,
indexing over 31 million commits and trees across up
to 250 packfiles. These MIDX files are nearly 1GB in
size and take ~20 seconds to rewrite when adding new
IDX information. This ~20s mark is something I'd like
to improve, and I mention how to make the file
incremental (similar to split-index) in the design
document. I also want to make the commit-graph file
incremental, so I'd like to do that at the same time
after both the MIDX and commit-graph are stable.


Lookup Speedups
---------------

When looking for an object, Git uses an most-recently-
used (MRU) cache of packfiles. This does pretty well to
minimize the number of misses when searching through
packfiles for an object, especially if there is one
"big" packfile that contains most of the objets (so it
will rarely miss and is usually one of the first two
packfiles in the list). The MIDX does provide a way
to remove these misses, improving lookup time. However,
this lookup time greatly depends on the arrangement of
the packfiles.

For instance, if you take the Linux repository and repack
using `git repack -adfF --max-pack-size=128m` then all
commits will be in one packfile, all trees will be in
a small set of packfiles and organized well so 'git
rev-list --objects HEAD^{tree}' only inspects one or two
packfiles.

GVFS has the notion of a "prefetch packfile". These are
packfiles that are precomputed by cache servers to
contain the commits and trees introduced to the remote
each day. GVFS downloads these packfiles and places them
in an alternate. Since these are organized by "first
time introduced" and the working directory is so large,
the MRU misses are significant when performing a checkout
and updating the .git/index file.

To test the performance in this situation, I created a
script that organizes the Linux repository in a similar
fashion. I split the commit history into 50 parts by
creating branches on every 10,000 commits of the first-
parent history. Then, `git rev-list --objects A ^B`
provides the list of objects reachable from A but not B,
so I could send that to `git pack-objects` to create
these "time-based" packfiles. With these 50 packfiles
(deleting the old one from my fresh clone, and deleting
all tags as they were no longer on-disk) I could then
test 'git rev-list --objects HEAD^{tree}' and see:

        Before: 0.17s
        After:  0.13s
        % Diff: -23.5%

By adding logic to count hits and misses to bsearch_pack,
I was able to see that the command above calls that
method 266,930 times with a hit rate of 33%. The MIDX
has the same number of calls with a 100% hit rate.



Abbreviation Speedups
---------------------

To fully disambiguate an abbreviation, we must iterate
through all packfiles to ensure no collision exists in
any packfile. This requires O(P log N) time. With the
MIDX, this is only O(log N) time. Our standard test [2]
is 'git log --oneline --parents --raw' because it writes
many abbreviations while also doing a lot of other work
(walking commits and trees to compute the raw diff).

For a copy of the Linux repository with 50 packfiles
split by time, we observed the following:

        Before: 100.5 s
        After:   58.2 s
        % Diff: -59.7%


Request for Review Attention
----------------------------

I tried my best to take the feedback from the commit-graph
feature and apply it to this feature. I also worked to
follow the object-store refactoring as I could. I also have
some local commits that create a 'verify' subcommand and
integrate with 'fsck' similar to the commit-graph, but I'll
leave those for a later series (and review is still underway
for that part of the commit-graph).

One place where I could use some guidance is related to the
current state of 'the_hash_algo' patches. The file format
allows a different "hash version" which then indicates the
length of the hash. What's the best way to ensure this
feature doesn't cause extra pain in the hash-agnostic series?
This will inform how I go back and make the commit-graph
feature better in this area, too.


Thanks,
-Stolee

[1] https://public-inbox.org/git/20180107181459.222909-1-dstolee@microsoft.com/T/#u
    Previous MIDX RFC.

[2] https://public-inbox.org/git/20171012120220.226427-1-dstolee@microsoft.com/
    A patch series on abbreviation speedups


Derrick Stolee (23):
  midx: add design document
  midx: add midx format details to pack-format.txt
  midx: add midx builtin
  midx: add 'write' subcommand and basic wiring
  midx: write header information to lockfile
  midx: struct midxed_git and 'read' subcommand
  midx: expand test data
  midx: read packfiles from pack directory
  midx: write pack names in chunk
  midx: write a lookup into the pack names chunk
  midx: sort and deduplicate objects from packfiles
  midx: write object ids in a chunk
  midx: write object id fanout chunk
  midx: write object offsets
  midx: create core.midx config setting
  midx: prepare midxed_git struct
  midx: read objects from multi-pack-index
  midx: use midx in abbreviation calculations
  midx: use existing midx when writing new one
  midx: use midx in approximate_object_count
  midx: prevent duplicate packfile loads
  midx: use midx to find ref-deltas
  midx: clear midx on repack

 .gitignore                              |   1 +
 Documentation/config.txt                |   4 +
 Documentation/git-midx.txt              |  60 ++
 Documentation/technical/midx.txt        | 109 +++
 Documentation/technical/pack-format.txt |  82 +++
 Makefile                                |   2 +
 builtin.h                               |   1 +
 builtin/midx.c                          |  88 +++
 builtin/repack.c                        |   8 +
 cache.h                                 |   1 +
 command-list.txt                        |   1 +
 config.c                                |   5 +
 environment.c                           |   1 +
 git.c                                   |   1 +
 midx.c                                  | 923 ++++++++++++++++++++++++
 midx.h                                  |  23 +
 object-store.h                          |  35 +
 packfile.c                              |  47 +-
 packfile.h                              |   1 +
 sha1-name.c                             |  70 ++
 t/t5319-midx.sh                         | 192 +++++
 21 files changed, 1652 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/git-midx.txt
 create mode 100644 Documentation/technical/midx.txt
 create mode 100644 builtin/midx.c
 create mode 100644 midx.c
 create mode 100644 midx.h
 create mode 100755 t/t5319-midx.sh

-- 
2.18.0.rc1

