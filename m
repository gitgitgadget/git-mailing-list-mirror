Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E2231F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeDJM4p (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:56:45 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39551 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752847AbeDJM4m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:56:42 -0400
Received: by mail-pl0-f67.google.com with SMTP id e7-v6so5447789plt.6
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BV83dQMjITRwXmRpn7dvqR43c4UsFjaEdOHbgjrDm/I=;
        b=AXXcO8Jeul+Yu3BZ7chKolKUGolflzHXy5dAtRJlS/UWgGUCKvU4Srwco4TOqGwjIA
         fiHWsQ+Vl6Pjgq+Vdp341EyWKD2dPJRePxydmFv/QR+seB+1aD3zUPO9LEVWCYT+gezY
         8ZaxCnqzljDS1QS4GBuVpR5Y84uW7BgOmwFK9Jfx6kK1o8S5MiAK0nKaOQBR8eke+h6j
         IJGW3/hBCWiim49bJrU5JFnwpWCQBYQgyzG7sJG5cZGRkvuWUhHmKDZ2kWMFxOYenPvr
         dHBMCzNZveQwc/jVxeJdy5TwYQAoayCD94hbSz4+v/GqqbuHAWK3oZnnLbE60kC3m9Nz
         NC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BV83dQMjITRwXmRpn7dvqR43c4UsFjaEdOHbgjrDm/I=;
        b=fYGr95aJvnvjg6h05wlxy7HIBn614ZbayrbNbJABfvO3XFoATwlNOsN2KfXZCmJh6Z
         9Ty+9CgE/J8CouorlnO5aVjoYkuomzfnf31X7SURsYV9gzGGHBQ+aqBLFDgBPWVWMW6B
         xW5dc4xlRK4I1A3RLl1edhi5DuOftW2zaGQWjpyS5xIaIiy2/Q8NJp215sjiqze4OF1d
         4HP/+WHFICbYzzk6pAx0xbRgYNwJRsaul9p5zukc+iPdtG20AmPWJTX8rk/BZu+YxbGe
         67KSwgfcRjAomXjMtXLz5ci66iaSe5EEaP1Ahe9YrmQDBUEPKgRjgNiGpT+vKSi+l1Q7
         fu3Q==
X-Gm-Message-State: ALQs6tCtSWj/tJKuzcubPmfNsAv7HaHI+xKEWOIB5xaCIN0xAPP+37th
        1oKl0N2HSog0wq6pWoEzgq0HP1pb5Go=
X-Google-Smtp-Source: AIpwx4+tB4fn4htdgHnZtPL/PUxiTjB2GAXly5TdgAY2Mt82Qv6MeHp+kMQHx2T2ZI0NwvXNDsZLqA==
X-Received: by 2002:a17:902:780d:: with SMTP id p13-v6mr291711pll.281.1523365002087;
        Tue, 10 Apr 2018 05:56:42 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id l10sm4421666pgp.35.2018.04.10.05.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 05:56:41 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v8 04/14] graph: add commit graph design document
Date:   Tue, 10 Apr 2018 08:55:58 -0400
Message-Id: <20180410125608.39443-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410125608.39443-1-dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add Documentation/technical/commit-graph.txt with details of the planned
commit graph feature, including future plans.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 163 +++++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 Documentation/technical/commit-graph.txt

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
new file mode 100644
index 0000000000..0550c6d0dc
--- /dev/null
+++ b/Documentation/technical/commit-graph.txt
@@ -0,0 +1,163 @@
+Git Commit Graph Design Notes
+=============================
+
+Git walks the commit graph for many reasons, including:
+
+1. Listing and filtering commit history.
+2. Computing merge bases.
+
+These operations can become slow as the commit count grows. The merge
+base calculation shows up in many user-facing commands, such as 'merge-base'
+or 'status' and can take minutes to compute depending on history shape.
+
+There are two main costs here:
+
+1. Decompressing and parsing commits.
+2. Walking the entire graph to satisfy topological order constraints.
+
+The commit graph file is a supplemental data structure that accelerates
+commit graph walks. If a user downgrades or disables the 'core.commitGraph'
+config setting, then the existing ODB is sufficient. The file is stored
+as "commit-graph" either in the .git/objects/info directory or in the info
+directory of an alternate.
+
+The commit graph file stores the commit graph structure along with some
+extra metadata to speed up graph walks. By listing commit OIDs in lexi-
+cographic order, we can identify an integer position for each commit and
+refer to the parents of a commit using those integer positions. We use
+binary search to find initial commits and then use the integer positions
+for fast lookups during the walk.
+
+A consumer may load the following info for a commit from the graph:
+
+1. The commit OID.
+2. The list of parents, along with their integer position.
+3. The commit date.
+4. The root tree OID.
+5. The generation number (see definition below).
+
+Values 1-4 satisfy the requirements of parse_commit_gently().
+
+Define the "generation number" of a commit recursively as follows:
+
+ * A commit with no parents (a root commit) has generation number one.
+
+ * A commit with at least one parent has generation number one more than
+   the largest generation number among its parents.
+
+Equivalently, the generation number of a commit A is one more than the
+length of a longest path from A to a root commit. The recursive definition
+is easier to use for computation and observing the following property:
+
+    If A and B are commits with generation numbers N and M, respectively,
+    and N <= M, then A cannot reach B. That is, we know without searching
+    that B is not an ancestor of A because it is further from a root commit
+    than A.
+
+    Conversely, when checking if A is an ancestor of B, then we only need
+    to walk commits until all commits on the walk boundary have generation
+    number at most N. If we walk commits using a priority queue seeded by
+    generation numbers, then we always expand the boundary commit with highest
+    generation number and can easily detect the stopping condition.
+
+This property can be used to significantly reduce the time it takes to
+walk commits and determine topological relationships. Without generation
+numbers, the general heuristic is the following:
+
+    If A and B are commits with commit time X and Y, respectively, and
+    X < Y, then A _probably_ cannot reach B.
+
+This heuristic is currently used whenever the computation is allowed to
+violate topological relationships due to clock skew (such as "git log"
+with default order), but is not used when the topological order is
+required (such as merge base calculations, "git log --graph").
+
+In practice, we expect some commits to be created recently and not stored
+in the commit graph. We can treat these commits as having "infinite"
+generation number and walk until reaching commits with known generation
+number.
+
+Design Details
+--------------
+
+- The commit graph file is stored in a file named 'commit-graph' in the
+  .git/objects/info directory. This could be stored in the info directory
+  of an alternate.
+
+- The core.commitGraph config setting must be on to consume graph files.
+
+- The file format includes parameters for the object ID hash function,
+  so a future change of hash algorithm does not require a change in format.
+
+Future Work
+-----------
+
+- The commit graph feature currently does not honor commit grafts. This can
+  be remedied by duplicating or refactoring the current graft logic.
+
+- The 'commit-graph' subcommand does not have a "verify" mode that is
+  necessary for integration with fsck.
+
+- The file format includes room for precomputed generation numbers. These
+  are not currently computed, so all generation numbers will be marked as
+  0 (or "uncomputed"). A later patch will include this calculation.
+
+- After computing and storing generation numbers, we must make graph
+  walks aware of generation numbers to gain the performance benefits they
+  enable. This will mostly be accomplished by swapping a commit-date-ordered
+  priority queue with one ordered by generation number. The following
+  operations are important candidates:
+
+    - paint_down_to_common()
+    - 'log --topo-order'
+
+- Currently, parse_commit_gently() requires filling in the root tree
+  object for a commit. This passes through lookup_tree() and consequently
+  lookup_object(). Also, it calls lookup_commit() when loading the parents.
+  These method calls check the ODB for object existence, even if the
+  consumer does not need the content. For example, we do not need the
+  tree contents when computing merge bases. Now that commit parsing is
+  removed from the computation time, these lookup operations are the
+  slowest operations keeping graph walks from being fast. Consider
+  loading these objects without verifying their existence in the ODB and
+  only loading them fully when consumers need them. Consider a method
+  such as "ensure_tree_loaded(commit)" that fully loads a tree before
+  using commit->tree.
+
+- The current design uses the 'commit-graph' subcommand to generate the graph.
+  When this feature stabilizes enough to recommend to most users, we should
+  add automatic graph writes to common operations that create many commits.
+  For example, one could compute a graph on 'clone', 'fetch', or 'repack'
+  commands.
+
+- A server could provide a commit graph file as part of the network protocol
+  to avoid extra calculations by clients. This feature is only of benefit if
+  the user is willing to trust the file, because verifying the file is correct
+  is as hard as computing it from scratch.
+
+Related Links
+-------------
+[0] https://bugs.chromium.org/p/git/issues/detail?id=8
+    Chromium work item for: Serialized Commit Graph
+
+[1] https://public-inbox.org/git/20110713070517.GC18566@sigill.intra.peff.net/
+    An abandoned patch that introduced generation numbers.
+
+[2] https://public-inbox.org/git/20170908033403.q7e6dj7benasrjes@sigill.intra.peff.net/
+    Discussion about generation numbers on commits and how they interact
+    with fsck.
+
+[3] https://public-inbox.org/git/20170908034739.4op3w4f2ma5s65ku@sigill.intra.peff.net/
+    More discussion about generation numbers and not storing them inside
+    commit objects. A valuable quote:
+
+    "I think we should be moving more in the direction of keeping
+     repo-local caches for optimizations. Reachability bitmaps have been
+     a big performance win. I think we should be doing the same with our
+     properties of commits. Not just generation numbers, but making it
+     cheap to access the graph structure without zlib-inflating whole
+     commit objects (i.e., packv4 or something like the "metapacks" I
+     proposed a few years ago)."
+
+[4] https://public-inbox.org/git/20180108154822.54829-1-git@jeffhostetler.com/T/#u
+    A patch to remove the ahead-behind calculation from 'status'.
-- 
2.17.0

