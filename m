Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A59131F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 02:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfJACaE (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 22:30:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37112 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJACaE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 22:30:04 -0400
Received: by mail-io1-f67.google.com with SMTP id b19so15773394iob.4
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 19:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3XMA9ji2PAMM9IRBeBY0Uh+dWt5AKD+7+X4PELliQeI=;
        b=Nr1Bo64tz4E+NX67oGf7HKDMFMfPkOALRJ/JIcvGLGo7m+t8WYz1yaM/pHn7XE3rwj
         7nRhSkX9vwFRnsvhQtENqcnfaUp+ta4MBfOvMbHdNVS8PSDBupBqlipS6NzH7ZtxSuOe
         CyanIhpHu+Fm3U3Ga9yy0Fqo9Eo2XSUHOJKikuBHxXfidxsda6/Uze69aZEVdjLgb91M
         cRdfQYzvPCoLihIbqTvWMQoz0D67Cv8w0eSElSlRcpKDS4xPhu6VpsNGSM+IUYGiFbDB
         zsMtSFtsZdKYQ9ZVcnt3I4BmqBoGI3hp1erPucyyFIJj9UzW4PpGu0+lBJ80xiKKViUE
         0sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3XMA9ji2PAMM9IRBeBY0Uh+dWt5AKD+7+X4PELliQeI=;
        b=VieDrSS4SNx7OcNeb1pF8MZkqEBaXqD2can2Jnugf3qIPazjPqe4orLVpRaSUSnAAb
         bVf++mcfGKM3VS7tGiD9N69FttutfDPAAMYrnsm7sAmFMeQVDimjjlR+MQ4EwG+oV5kK
         UISo94i/aMuME8w/EsbCRV5ZP9twIyFdsQObJrAY6Xelmv7xjY49onl1kTakMu/BdDT5
         8vcJtvKZbnCKbu1Ow65zIqA9IPGRiFxMnfD2Lpp2z8MNbN+ieuhRcAkiOZR9M9V1h0/l
         C5a0cxNX+Tvio+FbIDVP3lEoRmZ8IAoI++AOd/OVAs7of1X5eujQCT2SaKstEk1tqdU8
         MImA==
X-Gm-Message-State: APjAAAUobxf+AxvFeY5zXw6PPYQfdoG/w5UfUm6+d9SabzPWLNJwYE2c
        tG+xw1Lv5Rm8k1nDXap2Gwuw5Shmqgw=
X-Google-Smtp-Source: APXvYqw40FcWc147AmQRGAYjyQtkcf6Tb0z3WpuaXO5ZF5/t525LkxYOZl6jJ+TPQQsRyO1XYAxu7Q==
X-Received: by 2002:a6b:5003:: with SMTP id e3mr163627iob.208.1569897003130;
        Mon, 30 Sep 2019 19:30:03 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:3837:c90c:13fa:5c01])
        by smtp.gmail.com with ESMTPSA id c19sm6415765ila.19.2019.09.30.19.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 19:30:02 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        cb@hashpling.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v5] commit-graph: remove a duplicate assignment
Date:   Mon, 30 Sep 2019 20:29:34 -0600
Message-Id: <20191001022936.1757141-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leave the variable 'g' uninitialized before it is set just before its
first use in front of a loop, which is a much more appropriate place to
indicate what it is used for.

Also initialize the variable 'num_commits' just before the loop instead
of at the beginning of the function for the same reason.

Reviewed-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 commit-graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9b02d2c426..4028508e9c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1522,8 +1522,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 {
-	struct commit_graph *g = ctx->r->objects->commit_graph;
-	uint32_t num_commits = ctx->commits.nr;
+	struct commit_graph *g;
+	uint32_t num_commits;
 	uint32_t i;
 
 	int max_commits = 0;
@@ -1535,6 +1535,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 	}
 
 	g = ctx->r->objects->commit_graph;
+	num_commits = ctx->commits.nr;
 	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
 
 	while (g && (g->num_commits <= size_mult * num_commits ||
-- 
2.23.0

