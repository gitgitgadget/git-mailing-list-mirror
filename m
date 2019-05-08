Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9B41F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfEHPxu (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:53:50 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:35611 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfEHPxu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:53:50 -0400
Received: by mail-ed1-f52.google.com with SMTP id p26so4698445edr.2
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=T2ziGXIu/XuHKSRFGHStNcFU+SgTRAo1/WFAflNPSH0=;
        b=nZtQO8yjuw1r/b8rZG3mPnjwAFtBt2/FyHLjdGyGmj0E8WIWbzY/6NGsYDk1kU0u8s
         JDBU1AKQ3dqmZUJzgiui69FjkJErISwo3iFO0AmcaRuMs6Q+VtEHMrC7aNsaQ2Wx+fCl
         oF84Wbhq9n9CwSKllNKffeDyhtSOY1vktLy26FuEHMSJfi1jksFj0QkztmB5BB2zSHBh
         FYaAcFC0yKiwrhd18mAriutaphdupGKaq6lpcHZduPbTFGSEMChgCcGKuqY8YocC4EdE
         OlK8hZ/fnrzVOczomS3eLZCXj901iRpNIWMMoC2/62hNvfxASLXgo96GZvgh4c0Jr4Lv
         O2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T2ziGXIu/XuHKSRFGHStNcFU+SgTRAo1/WFAflNPSH0=;
        b=SNeVFo8iY5vmsySitaaIEHpdvErbzomWCYOwBC3+3mpTH0HPsrwsGvLXvuDwsW1sk/
         6v+L7gtihdkP1XPSvLL+6tBf7i7UmyXCnfKq7Ef2G4drwX2JDyCI8pqltwZWI5+IrT8V
         fvWEpSa9UXGM1uIfALaHnPOkjYMuy4NaR+y5K2SurnIw9p0kWmLWITVqgIljVWrZa2Ll
         ucwOuSMDKH1C5o3qojgHsvj8BlzjouyRiiUbmIxYuv+3yGXdmkrmV0+IInR4RhsGPSNR
         CgRt04PgAWPla5udtQvLEdXrxwjzMpXqPGPUzpl5vu08WJrXHzWqhddlKNcyhjv5o2nX
         Heqg==
X-Gm-Message-State: APjAAAXwNzhIT3U/O0d/fvfALCoOYqKGcbOGNVQa+NBcfG0fq8C+/U0H
        6IClVRhsnEBe5H+hbtavt8UDuKh7vF0=
X-Google-Smtp-Source: APXvYqyRNl8KO0ajowEr0b4zR75lDidt49r7Pnl1hSIaqBUDRG6/KD7xuaN4PG0KDKtlUbjJ3DeDOg==
X-Received: by 2002:a17:906:29d3:: with SMTP id y19mr30397327eje.122.1557330828054;
        Wed, 08 May 2019 08:53:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j55sm5366623ede.27.2019.05.08.08.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:47 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:47 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:29 GMT
Message-Id: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 00/17] [RFC] Commit-graph: Write incremental files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is marked as RFC quality because it is missing some key
features and tests, but hopefully starts a concrete discussion of how the
incremental commit-graph writes can work. If this is a good direction, then
it would replace ds/commit-graph-format-v2.

The commit-graph is a valuable performance feature for repos with large
commit histories, but suffers from the same problem as git repack: it
rewrites the entire file every time. This can be slow when there are
millions of commits, especially after we stopped reading from the
commit-graph file during a write in 43d3561 (commit-graph write: don't die
if the existing graph is corrupt).

Instead, create a "stack" of commit-graphs where the existing commit-graph 
file is "level 0" and other levels are in files 
$OBJDIR/info/commit-graphs/commit-graph-N for positive N. Each level is
closed under reachability with its lower levels, and the idea of "graph
position" now considers the concatenation of the commit orders from each
level. See PATCH 12 for more details.

When writing, we don't always want to add a new level to the stack. This
would eventually result in performance degradation, especially when
searching for a commit (before we know its graph position). We decide to
merge levels of the stack when the new commits we will write satisfy two
conditions:

 1. The expected size of the new file is more than half the size of the tip
    of the stack.
 2. The new file contains more than 64,000 commits.

The first condition alone would prevent more than a logarithmic number of
levels. The second condition is a stop-gap to prevent performance issues
when another process starts reading the commit-graph stack as we are merging
a large stack of commit-graph files. The reading process could be in a state
where the new file is not ready, but the levels above the new file were
already deleted. Thus, the commits that were merged down must be parsed from
pack-files.

The performance is necessarily amortized across multiple writes, so I tested
by writing commit-graphs from the (non-rc) tags in the Linux repo. My test
included 72 tags, and wrote everything reachable from the tag using 
--stdin-commits. Here are the overall perf numbers:

git commit-graph write --stdin-commits:         8m 12s
git commit-graph write --stdin-commits --split:    45s

The test using --split included at least six full collapses to the full
commit-graph. I believe the commit-graph stack had at most three levels
during this test.

This series is long because I felt the need to refactor write_commit_graph()
before making such a sweeping change to the format.

 * Patches 1-4: these are small changes which either fix issues or just
   provide clean-up. These are mostly borrowed from
   ds/commit-graph-format-v2.
   
   
 * Patches 5-11: these provide a non-functional refactor of
   write_commit_graph() into several methods using a "struct
   write_commit_graph_context" to share across the methods.
   
   
 * Patches 12-16: Implement the split commit-graph feature.
   
   
 * Patch 17: Demonstrate the value by writing a split commit-graph during 
   git fetch when the new config setting fetch.writeCommitGraph is true.
   
   

TODO: There are several things missing that need to be added before this
series is ready for full review and merging:

 1. The documentation for git commit-graph needs updating for the --split 
    option.
    
    
 2. We likely want config settings for the merge strategy. This is mentioned
    in the design doc, and could be saved for later.
    
    
 3. We want to update the git commit-graph verify subcommand to understand
    the commit-graph stack and optionally only verify the tip of the stack.
    This allows faster (amortized) verification if we are verifying
    immediately after writes and trusting the files at rest.
    
    
 4. It would be helpful to add a new optional chunk that contains the
    trailing hash for the lower level of the commit-graph stack. This chunk
    would only be for the commit-graph-N files, and would provide a simple
    way to check that the stack is valid on read, in case we are still
    worried about other processes reading/writing in the wrong order.
    
    
 5. Currently, --split essentially implies --append since we either (a)
    don't change the existing stack and only add commits, or (b) add all
    existing commits while merging files. However, if you would use --append 
    with --split, the append logic will trigger a merge with the current tip
    (at minimum). Some care should be taken to make this more clear.
    
    

Thanks, -Stolee

[1] 
https://github.com/git/git/commit/43d356180556180b4ef6ac232a14498a5bb2b446
commit-graph write: don't die if the existing graph is corrupt

Derrick Stolee (17):
  commit-graph: fix the_repository reference
  commit-graph: return with errors during write
  commit-graph: collapse parameters into flags
  commit-graph: remove Future Work section
  commit-graph: create write_commit_graph_context
  commit-graph: extract fill_oids_from_packs()
  commit-graph: extract fill_oids_from_commit_hex()
  commit-graph: extract fill_oids_from_all_packs()
  commit-graph: extract count_distinct_commits()
  commit-graph: extract copy_oids_to_commits()
  commit-graph: extract write_commit_graph_file()
  Documentation: describe split commit-graphs
  commit-graph: lay groundwork for incremental files
  commit-graph: load split commit-graph files
  commit-graph: write split commit-graph files
  commit-graph: add --split option
  fetch: add fetch.writeCommitGraph config setting

 Documentation/technical/commit-graph.txt | 157 +++-
 builtin/commit-graph.c                   |  31 +-
 builtin/commit.c                         |   5 +-
 builtin/fetch.c                          |  17 +
 builtin/gc.c                             |   7 +-
 commit-graph.c                           | 946 ++++++++++++++++-------
 commit-graph.h                           |  19 +-
 commit.c                                 |   2 +-
 t/t5318-commit-graph.sh                  |  28 +-
 9 files changed, 887 insertions(+), 325 deletions(-)


base-commit: 93b4405ffe4ad9308740e7c1c71383bfc369baaa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-184%2Fderrickstolee%2Fgraph%2Fincremental-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-184/derrickstolee/graph/incremental-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/184
-- 
gitgitgadget
