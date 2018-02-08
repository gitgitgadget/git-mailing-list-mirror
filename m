Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37EB1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeBHUhx (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:37:53 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:41988 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBHUhw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:37:52 -0500
Received: by mail-qk0-f176.google.com with SMTP id f68so7327927qke.9
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iT2wlCyGNfUNsCJ4/5uEVEDL0ig5agEPEqhhZJzqL1Q=;
        b=I+XoXgsrfwaUwJcX0uF7BO0bG+eB0YQik/VmJ6PZ3BZ6P+9hy3t/+hjG+AvR2SB74B
         Nj6yiNPoiFYsgj20BuvEj9AX3uDM2Zga53LroVivX9uGyf+nGrFGFloqSZM6qdmutX7O
         BMuiCTE6cnmXqZrNpOwxOlEzf5B8++4YSlLhvwArF7Iuy2BCU2nD94hpB/IPDIpEG8yk
         q8+szT2mygTdBFKAOEWNKpGsO+fGskAbltKg7XwunuQfmKg1RkMm2wPmxq9djCyQK7do
         QLqyjmsKgDsIOrJz6/nm7k23RGuIjNyI6nicsVOB8t/W7mCZO1rr04bIHUFrlYCOOftI
         qBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iT2wlCyGNfUNsCJ4/5uEVEDL0ig5agEPEqhhZJzqL1Q=;
        b=L78P58QQnG5HlgsZ6XWpw8TS2VOVmpWGZ1vi0v7SZYNVxGK+dFk4FXjmczdttLTZC/
         Gsb9KT61FDRdc93pQliXMmgWz+O7bvfhg6dzJGrDt3s30UBp7xlbtQjSv84K8K/7SHiu
         KR2DUJNAAjFA6JYxgKpYK+7o1txuwgI08b2QRx/tQoJRPyCeH6IA06qkdOnrc1K3O3Pd
         G/aDBuxfe7fOrryyEMluvugowY1IWr83e68fj+TXKisTT7A6LRkt1cKzhtJWQZnsra4V
         IPrT+qDwb4ZhnOoD4l7bk98VhLGHRixuOKNM/auXMHFziJh+1ynMdQlCp3WHileAYlxt
         kPIQ==
X-Gm-Message-State: APf1xPAnY9J4WYT9/aVrwCJPMe/eVcNH7veK2xb62dZs4VqgN6YsAwFs
        0gstfwCfsebDm2m6uiENKhI+OhwPk2Q=
X-Google-Smtp-Source: AH8x226P2kHPgGKLXArgb+AnO8rHZsFHC3sTNDw0mDd9nXQK1vt0o1kDbjFYJlh/Tp1EGIM66QKf7Q==
X-Received: by 10.55.71.87 with SMTP id u84mr390292qka.255.1518122271428;
        Thu, 08 Feb 2018 12:37:51 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:37:50 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 00/14] Serialized Git Commit Graph
Date:   Thu,  8 Feb 2018 15:37:24 -0500
Message-Id: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to everyone who gave comments on v1 and v2.

Hopefully the following points have been addressed:

* Fixed inter-commit problems where certain fixes did not arrive until
  later commits.

* Converted from submode flags ("git commit-graph --write") to
  subcommands ("git commit-graph write").

* Fixed a bug where a non-commit OID would cause a segfault when using
  --stdin-commits. Added a test for an annotated tag.

* Numerous style issues, especially in the test script.

I also based my patches on the branch jt/binsearch-with-fanout to make
use of the bsearch_hash() method.

I look forward to your feedback.

Thanks,
-Stolee

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
  git show-ref -s | git commit-graph write --update-head --stdin-commits

The second command writes a commit graph file containing every commit
reachable from your refs. Now, all git commands that walk commits will
check your graph first before consulting the ODB. You can run your own
performance comparisions by toggling the 'core.commitgraph' setting.

[1] https://public-inbox.org/git/d154319e-bb9e-b300-7c37-27b1dcd2a2ce@jeffhostetler.com/
    Re: What's cooking in git.git (Jan 2018, #03; Tue, 23)

[2] https://github.com/derrickstolee/git/pull/2
    A GitHub pull request containing the latest version of this patch.

Derrick Stolee (14):
  commit-graph: add format document
  graph: add commit graph design document
  commit-graph: create git-commit-graph builtin
  commit-graph: implement write_commit_graph()
  commit-graph: implement 'git-commit-graph write'
  commit-graph: implement 'git-commit-graph read'
  commit-graph: update graph-head during write
  commit-graph: implement 'git-commit-graph clear'
  commit-graph: implement --delete-expired
  commit-graph: add core.commitGraph setting
  commit: integrate commit graph with commit parsing
  commit-graph: close under reachability
  commit-graph: read only from specific pack-indexes
  commit-graph: build graph from starting commits

 .gitignore                                      |   1 +
 Documentation/config.txt                        |   3 +
 Documentation/git-commit-graph.txt              | 115 ++++
 Documentation/technical/commit-graph-format.txt |  91 +++
 Documentation/technical/commit-graph.txt        | 189 ++++++
 Makefile                                        |   2 +
 alloc.c                                         |   1 +
 builtin.h                                       |   1 +
 builtin/commit-graph.c                          | 335 ++++++++++
 cache.h                                         |   1 +
 command-list.txt                                |   1 +
 commit-graph.c                                  | 828 ++++++++++++++++++++++++
 commit-graph.h                                  |  60 ++
 commit.c                                        |   3 +
 commit.h                                        |   3 +
 config.c                                        |   5 +
 environment.c                                   |   1 +
 git.c                                           |   1 +
 log-tree.c                                      |   3 +-
 packfile.c                                      |   4 +-
 packfile.h                                      |   2 +
 t/t5318-commit-graph.sh                         | 228 +++++++
 22 files changed, 1874 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/git-commit-graph.txt
 create mode 100644 Documentation/technical/commit-graph-format.txt
 create mode 100644 Documentation/technical/commit-graph.txt
 create mode 100644 builtin/commit-graph.c
 create mode 100644 commit-graph.c
 create mode 100644 commit-graph.h
 create mode 100755 t/t5318-commit-graph.sh

-- 
2.7.4

