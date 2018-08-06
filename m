Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA6C6208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 22:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbeHGAhM (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 20:37:12 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:37430 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731138AbeHGAhM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 20:37:12 -0400
Received: by mail-ua0-f202.google.com with SMTP id w15-v6so9968135uao.4
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DaQWAik133LeRdD+p6GRqP/s60kFeSWshCx1dJkS7S8=;
        b=rGp47eye+o9zFxAR2Jv7UKWugkSKPLEfk9OiEGce3f5t6Yo0dUwYLs6Vy1+D1L0pc3
         hNDtEDelkE5fuwVwFaulj1WEI5FYrQwAC5PEdKxR7me9yA3NMvrx8RVAt7HxAm1w/+8I
         Gv4vrUbZM0DhMcE1oYS6DpS7Dh2HNaul6RFF4SE6Gw50ELV6kpgMmS2i8P/mLgI8otH3
         niA7lNtKFm1Ty8BE9g6OB1b1yQ/XZdGK9kN2dh0jfnTPtPrxeyHXZsCTI+STYLNZoZpz
         kbNAzqNpudba1ESaQKiytpX5eHeaE4ldQK4DrTbw8SaZhNzitYPy6hi4IyzPU6PVyYAW
         Zj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DaQWAik133LeRdD+p6GRqP/s60kFeSWshCx1dJkS7S8=;
        b=s2O8sgduN9sS42shmYtjvMYDOzEaG4QbSItc3q3aJN/K3F18zeMgs1ZRRRkBZyzKsV
         dlVug3SUMC/A0X+QzK8qHF4fJBIoI+0Pu3JDDG5sLcoEjHMq/+dcGHs2fAXayNRytA+v
         /PvcEOxzmzje7K2zTpYchBbWHfNf/lsVUaoGFhJIH2UrKUB1OQlHOsjZ/GHzKHkJN+OI
         2iZO1BRNGbg+va8cLQeZtl0j4Fd+IGOPBdhVD8rmp4aDYi1lSVwXiWZ5NLmBnIX4p0Uo
         Rg6N7S0Npo/37sI34OBGInxzUk9zZ2OtyFJMNgpPE9jDkcCQvv2p6VK7MQyLboUmcrOW
         yVrg==
X-Gm-Message-State: AOUpUlGDgfyrlAml4xcynJ/tmkJ+uJyAvH6sZz/ZlEwCQaNENLn049Oc
        gOY0OU7fG5kxOEhnCLVcPKz90WX9n2+X
X-Google-Smtp-Source: AAOMgpfj/yiRyUbhhrFjj1uEeS2r7Oo8rIIBaFDJrKFmPNAGfawvUpGNbfuJO1e1NP3FdBNZiPix/Yyyhb+D
X-Received: by 2002:a1f:600c:: with SMTP id u12-v6mr10460019vkb.21.1533594361037;
 Mon, 06 Aug 2018 15:26:01 -0700 (PDT)
Date:   Mon,  6 Aug 2018 15:25:51 -0700
In-Reply-To: <20180724044051.GA208393@aiede.svl.corp.google.com>
Message-Id: <20180806222551.132628-1-sbeller@google.com>
Mime-Version: 1.0
References: <20180724044051.GA208393@aiede.svl.corp.google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] Documentation/diff-options: explain different diff algorithms
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a user I wondered what the diff algorithms are about. Offer at least
a basic explanation on the differences of the diff algorithms.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-options.txt | 10 +++++++---
 Documentation/git-diff.txt     | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f394608b42c..eae033a21ea 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -91,14 +91,18 @@ appearing as a deletion or addition in the output. It uses the "patience
 diff" algorithm internally.
 
 --diff-algorithm={patience|minimal|histogram|myers}::
-	Choose a diff algorithm. The variants are as follows:
+	Choose a diff algorithm. See the discussion of DIFF ALGORITHMS
+ifndef::git-diff[]
+	in linkgit:git-diff[1]
+endif::git-diff[]
+	. The variants are as follows:
 +
 --
 `default`, `myers`;;
 	The basic greedy diff algorithm. Currently, this is the default.
 `minimal`;;
-	Spend extra time to make sure the smallest possible diff is
-	produced.
+	The same algorithm as `myers`, but spend extra time to make
+	sure the smallest possible diff is produced.
 `patience`;;
 	Use "patience diff" algorithm when generating patches.
 `histogram`;;
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index b180f1fa5bf..b182389aaae 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -119,6 +119,40 @@ include::diff-options.txt[]
 
 include::diff-format.txt[]
 
+DIFF ALGORITHMS
+---------------
+`Myers`
+
+A diff as produced by the basic greedy algorithm described in
+link:http://www.xmailserver.org/diff2.pdf[An O(ND) Difference Algorithm and its Variations].
+with a run time of O(M + N + D^2). It employs a heuristic to allow for
+a faster diff at the small cost of diff size.
+The `minimal` algorithm has that heuristic turned off.
+
+`Patience`
+
+This algorithm by Bram Cohen matches the longest common subsequence
+of unique lines on both sides, recursively. It obtained its name by
+the way the longest subsequence is found, as that is a byproduct of
+the patience sorting algorithm. If there are no unique lines left
+it falls back to `myers`. Empirically this algorithm produces
+a more readable output for code, but it does not garantuee
+the shortest output.
+
+`Histogram`
+
+This algorithm finds the longest common substring and recursively
+diffs the content before and after the longest common substring.
+If there are no common substrings left, fallback to `myers`.
+This is often the fastest, but in corner cases (when there are
+many common substrings of the same length) it produces bad
+results as seen in:
+
+	seq 1 100 >one
+	echo 99 > two
+	seq 1 2 98 >>two
+	git diff --no-index --histogram one two
+
 EXAMPLES
 --------
 
-- 
2.18.0.597.ga71716f1ad-goog

