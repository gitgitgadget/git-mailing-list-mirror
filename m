Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 419101F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965454AbeF0NZn (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:43 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46591 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965447AbeF0NZi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:38 -0400
Received: by mail-qt0-f193.google.com with SMTP id h5-v6so1561246qtm.13
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mloVz9wxsdRoamJRFP+pVV52BmPCEHxN/rZwwbWkmuo=;
        b=o5N9TMu0Vb/Wgoorvc72bDsYeR30Jxad+kfBNqPwwesjlpQUPIOc+z21Ktq/TV2+UK
         3zlo1Vn6+IPbe4pg6C7UZimRymWceseEwaSNJvVg/cYFMxlDDrH7b4US3MZTgLkn3V8J
         BrA5UCbSVMatafWhdFSLY/JCB03QXYwDETGDBOznkWEvSpRWlQQeXAvF4I7zctiNvDUI
         SK79eTLkx4z3wkenhqO5Ny1dzjwCXL0zQv6G6kC2dFM0fO/C3iOBFkxPAkE7SbwaPnhg
         2f3C5AKpXsyfm71qrZYnFSufbjHyXkQm3KmnyeTHclzERBHsgOmbaXqEmtocGN3n3ui1
         RezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mloVz9wxsdRoamJRFP+pVV52BmPCEHxN/rZwwbWkmuo=;
        b=iW/fU7HFffZhjmq8YAlhsZcusrusaNzJEn//bnhzv0aJsSPVqnrruP+TSU/eXqNpAA
         fgIDGSCmEdwGwIoj6j3uvRMzyQAYc6aMaVljpXpUNGudehCjtfLjw8/P/i3QG8I+WUKD
         UOIRyidThggA0hXL0Nk5aJKL4nPx18hvbweT4U8nyNbjH0z5Q7gbXnqp+G7PaPVUJKpf
         5llKLJIRbNn69ukoy3TiENbUmE2MKecE1DybdM30E8+vubWnV4W0FSbf4IHc/JMRSrmv
         XAYdkeyeLskESv6FBwwaO/ikX6OmyqUOWliE0cMKPUGWR2dPpWJy7njbbmziimvOywHf
         9qUg==
X-Gm-Message-State: APt69E08G8qO/r5IBW05vgZNKo4fPnlo9pQN1NYDYg4u/4ICorrR4fyq
        m1HB2rvpPWitBw/PjkuM5iY94+bECfc=
X-Google-Smtp-Source: AAOMgpen8yenq33Kcrk+LpmWLslPNWZzn8L19ySBZ+2fxpFDVWiKOeS6g3AQMWdnvfC8OX3WN4ju0w==
X-Received: by 2002:ac8:5191:: with SMTP id c17-v6mr5470633qtn.35.1530105937952;
        Wed, 27 Jun 2018 06:25:37 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:37 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 22/22] commit-graph: update design document
Date:   Wed, 27 Jun 2018 09:24:47 -0400
Message-Id: <20180627132447.142473-23-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph feature is now integrated with 'fsck' and 'gc',
so remove those items from the "Future Work" section of the
commit-graph design document.

Also remove the section on lazy-loading trees, as that was completed
in an earlier patch series.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index e1a883eb46..c664acbd76 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -118,9 +118,6 @@ Future Work
 - The commit graph feature currently does not honor commit grafts. This can
   be remedied by duplicating or refactoring the current graft logic.
 
-- The 'commit-graph' subcommand does not have a "verify" mode that is
-  necessary for integration with fsck.
-
 - After computing and storing generation numbers, we must make graph
   walks aware of generation numbers to gain the performance benefits they
   enable. This will mostly be accomplished by swapping a commit-date-ordered
@@ -130,25 +127,6 @@ Future Work
     - 'log --topo-order'
     - 'tag --merged'
 
-- Currently, parse_commit_gently() requires filling in the root tree
-  object for a commit. This passes through lookup_tree() and consequently
-  lookup_object(). Also, it calls lookup_commit() when loading the parents.
-  These method calls check the ODB for object existence, even if the
-  consumer does not need the content. For example, we do not need the
-  tree contents when computing merge bases. Now that commit parsing is
-  removed from the computation time, these lookup operations are the
-  slowest operations keeping graph walks from being fast. Consider
-  loading these objects without verifying their existence in the ODB and
-  only loading them fully when consumers need them. Consider a method
-  such as "ensure_tree_loaded(commit)" that fully loads a tree before
-  using commit->tree.
-
-- The current design uses the 'commit-graph' subcommand to generate the graph.
-  When this feature stabilizes enough to recommend to most users, we should
-  add automatic graph writes to common operations that create many commits.
-  For example, one could compute a graph on 'clone', 'fetch', or 'repack'
-  commands.
-
 - A server could provide a commit graph file as part of the network protocol
   to avoid extra calculations by clients. This feature is only of benefit if
   the user is willing to trust the file, because verifying the file is correct
-- 
2.18.0.24.g1b579a2ee9

