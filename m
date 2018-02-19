Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABBE01F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeBSSxd (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:53:33 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36340 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753370AbeBSSxc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:53:32 -0500
Received: by mail-qt0-f193.google.com with SMTP id q18so13456875qtl.3
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6aSgfqYYOvTdlN9NwjjPNafsbTeKG+Z0bTlgcCRWj9Y=;
        b=rWJUq6eIGmfx76i9V1VT9bR2dJwtJ/2x36Yrv56Upxd4eDGYsoNldBLN3SUWhJrOYz
         WZZtFTj8/ZaQMtvEHidlN/Hb+d0cAm2PxrUxNhuTkWiJpZKhhZln1xlVlNz4+a7nwng2
         Jdsa3sT3Q6gDHzcgASUgS/ok5yJAUAmUJURB+SwttA2gidf8WtPA5LpkLw9FodtoSp8m
         mtzO6olV+R/8eE8w/rBTxdVp8wL3WHBOqTSMq7RF6JN95pwleINBpQddUC1eJAFElAuH
         XGPZ5+vNjjwbR4/ekjrQZTIv0sUZuAsnuD1ZQMrh+e5xLuNlTydOJtEE3FKxbXxgLPfh
         yfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6aSgfqYYOvTdlN9NwjjPNafsbTeKG+Z0bTlgcCRWj9Y=;
        b=DMtZrPlzmMp4WptrzKvilm+ZEKb9FVU2FVRb1/JbAf4K63VLyT8tgkeUAp4Q3JVwtO
         q9KaPara/ShUmewrq+Z9XZcHT429F5rFLrST2l8j70N4mqE+jsK8KdVO6ECoNwbF1wV7
         Sj485EK4AF7UH4aSiEZ1WWgzTtMnmQTVzPLlU/ypU6bksnarKZBUTZjT71t9ao25Z3EC
         kAyI+jH4peNQOybCCln/VUZsMUc21//2gFcYNc6vf2donvwwt1XQEihEFtL5u9N0z4G6
         2DQT6hDZ+ktovzWZ2NIjAb4VqDMSkBwrvBDpD+zSO9KnnPoKEDDLwv18N31clDe0Txo9
         uN9Q==
X-Gm-Message-State: APf1xPBW2CTNuFyX+Y7UQevShN3ryJ/sdVc3FQFo3kU+Q0urk0MMvOy1
        1au7ZkoGzeUJXhW1Tt2RgNs6d145eII=
X-Google-Smtp-Source: AH8x226GQbb6aK5lra3TZdN4/kgpNLWWwmYc+hg0UP3R4vHsp59vn6CgOVlu5KWEa4GEDeqPouGk/A==
X-Received: by 10.200.26.196 with SMTP id h4mr26170844qtk.223.1519066410842;
        Mon, 19 Feb 2018 10:53:30 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id o12sm1672631qke.81.2018.02.19.10.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 10:53:30 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     peff@peff.net, jonathantanmy@google.com, szeder.dev@gmail.com,
        sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 00/13] Serialized Git Commit Graph
Date:   Mon, 19 Feb 2018 13:53:13 -0500
Message-Id: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all of the feedback. I've learned a lot working on this patch.

As discussed [0], this version changes several fundamental structures
and operations, including:

* Graph files are stored in .git/objects/info

* The "graph-head" file is now called "graph-latest" to avoid confusion
  with HEAD. We use "--set-latest" argument instead of "--update-head".

* The graph format no longer stores the hash width, but expects the hash
  version to imply a length. This frees up one byte for future use while
  preserving 4-byte alignment.

* The graph format is more explicit about optional chunks and no longer
  dies when seeing an unknown chunk. The large edges chunk is now optional.

* There is no longer a "clear" subcommand to git-commit-graph.

* Fixed the bug related to "--stdin-commits" and check that the command
  only includes commits reachable from the input OIDs.

* The struct packed_oid_list type is now an array of struct object_id
  instead of an array of pointers. In my testing, I saw no performance
  difference between these two options, so I switched to the simpler
  pattern.

* My patch is based on jt/binsearch-with-fanout (b4e00f730), with the
  newer method prototype since v3.

Thanks,
-Stolee

[0] https://public-inbox.org/git/1517348383-112294-1-git-send-email-dstolee@microsoft.com/T/#m22bfdb7cf7b3d6e5f380b8bf0eec957e2cfd2dd7

-- >8 --

As promised [1], this patch contains a way to serialize the commit graph.
The current implementation defines a new file format to store the graph
structure (parent relationships) and basic commit metadata (commit date,
root tree OID) in order to prevent parsing raw commits while performing
basic graph walks. For example, we do not need to parse the full commit
when performing these walks:

* 'git log --topo-order -1000' walks all reachable commits to avoid
  incorrect topological orders, but only needs the commit message for
  the top 1000 commits.

* 'git merge-base <A> <B>' may walk many commits to find the correct
  boundary between the commits reachable from A and those reachable
  from B. No commit messages are needed.

* 'git branch -vv' checks ahead/behind status for all local branches
  compared to their upstream remote branches. This is essentially as
  hard as computing merge bases for each.

The current patch speeds up these calculations by injecting a check in
parse_commit_gently() to check if there is a graph file and using that
to provide the required metadata to the struct commit.

The file format has room to store generation numbers, which will be
provided as a patch after this framework is merged. Generation numbers
are referenced by the design document but not implemented in order to
make the current patch focus on the graph construction process. Once
that is stable, it will be easier to add generation numbers and make
graph walks aware of generation numbers one-by-one.

Here are some performance results for a copy of the Linux repository
where 'master' has 704,766 reachable commits and is behind 'origin/master'
by 19,610 commits.

| Command                          | Before | After  | Rel % |
|----------------------------------|--------|--------|-------|
| log --oneline --topo-order -1000 |  5.9s  |  0.7s  | -88%  |
| branch -vv                       |  0.42s |  0.27s | -35%  |
| rev-list --all                   |  6.4s  |  1.0s  | -84%  |
| rev-list --all --objects         | 32.6s  | 27.6s  | -15%  |

To test this yourself, run the following on your repo:

  git config core.commitGraph true
  git show-ref -s | git commit-graph write --set-latest --stdin-commits

The second command writes a commit graph file containing every commit
reachable from your refs. Now, all git commands that walk commits will
check your graph first before consulting the ODB. You can run your own
performance comparisions by toggling the 'core.commitgraph' setting.

[1] https://public-inbox.org/git/d154319e-bb9e-b300-7c37-27b1dcd2a2ce@jeffhostetler.com/
    Re: What's cooking in git.git (Jan 2018, #03; Tue, 23)

[2] https://github.com/derrickstolee/git/pull/2
    A GitHub pull request containing the latest version of this patch.

Derrick Stolee (13):
  commit-graph: add format document
  graph: add commit graph design document
  commit-graph: create git-commit-graph builtin
  commit-graph: implement write_commit_graph()
  commit-graph: implement 'git-commit-graph write'
  commit-graph: implement git commit-graph read
  commit-graph: implement --set-latest
  commit-graph: implement --delete-expired
  commit-graph: add core.commitGraph setting
  commit-graph: close under reachability
  commit: integrate commit graph with commit parsing
  commit-graph: read only from specific pack-indexes
  commit-graph: build graph from starting commits

 .gitignore                                      |   1 +
 Documentation/config.txt                        |   3 +
 Documentation/git-commit-graph.txt              | 105 ++++
 Documentation/technical/commit-graph-format.txt |  90 +++
 Documentation/technical/commit-graph.txt        | 185 ++++++
 Makefile                                        |   2 +
 alloc.c                                         |   1 +
 builtin.h                                       |   1 +
 builtin/commit-graph.c                          | 261 +++++++++
 cache.h                                         |   1 +
 command-list.txt                                |   1 +
 commit-graph.c                                  | 724 ++++++++++++++++++++++++
 commit-graph.h                                  |  49 ++
 commit.c                                        |   3 +
 commit.h                                        |   3 +
 config.c                                        |   5 +
 environment.c                                   |   1 +
 git.c                                           |   1 +
 log-tree.c                                      |   3 +-
 packfile.c                                      |   4 +-
 packfile.h                                      |   2 +
 t/t5318-commit-graph.sh                         | 244 ++++++++
 22 files changed, 1686 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/git-commit-graph.txt
 create mode 100644 Documentation/technical/commit-graph-format.txt
 create mode 100644 Documentation/technical/commit-graph.txt
 create mode 100644 builtin/commit-graph.c
 create mode 100644 commit-graph.c
 create mode 100644 commit-graph.h
 create mode 100755 t/t5318-commit-graph.sh

-- 
2.15.1.44.g453ed2b

