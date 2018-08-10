Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078911F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeHKAus (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:50:48 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:36516 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeHKAus (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:50:48 -0400
Received: by mail-it0-f73.google.com with SMTP id m185-v6so3271804itm.1
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3s1iTQLOL2Wiy+lrYe3gAZ2VkTmqDr9D8ncFic9LlqE=;
        b=dDfqJbmcgBSM7AhWS3bPVSPm5Pt+PZsjcmaCHnW1/nGk2FQ0PN1JrhO1VAZ8GY4XU7
         vpe1oCG43lv7k1J05pB8SJk8ULlfFRlAamdOnsNIA4Xr6LiUmI8sWJTQAvTTLV8Odqmr
         atMWTH637sh3IxPlma+65NuLBnSQfN/IFxOC+pqUtvEzZu6nq4rXBSwBSHDtTrqZ4qq5
         wlZ7LccsXF+22+avAames/O9PmJyvCEn+41Xf443S+HBrtkumsGU9ZfGwGONMt9zAE/s
         ygVvRvV3Bd13BUbZJMF7CAHQaMdXR8g+tQRSVo1pM+PNnwupp8CHntPF85Np6Y43wEow
         Dgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3s1iTQLOL2Wiy+lrYe3gAZ2VkTmqDr9D8ncFic9LlqE=;
        b=YcbcYIONZjd1haVY8xHiZy872NScczoOb/7gj+Dq4vJCTR0UL5fHls3ozlXJ9E45VV
         U/XIXMeeTwJJM9mkcq+uotMmjcFQaDIJpwtn4g559KfTefMvaGhXXZieo6CVCeTJ1Av3
         916v3ZvWO0fvl+0telrjFdhMCWp5PBCpYG9XMoxszjhYkOsrreMtPuaXdgfAlcrrM74w
         rYy68kCTIcbypO8oTinwpH6XgmhkF9YRtoLuVlAA82Vz84z/TcnWA5rZdVjRgGuSIzT2
         7lY72JD8oqCB08eVPVW6WtPykikLoctcEe/8PhG3ZN0JB+DMrcMNdCPIrsn368riigEo
         tDfg==
X-Gm-Message-State: AOUpUlFoYYzqcDOUA3PJPiqgn23D5wcOa6UdbfaAfYCgcvLnRuABsEO+
        YROqG590Kat4BlXyVQwVqfexDwgQaXaG
X-Google-Smtp-Source: AA+uWPyiBWpDZ/DlF8iH1CeA3P6xRFKpTRrTkp9EgiJzbUrxAqgb7znr0pPfHOXkeAYko2vsGUPAeJpL6/bL
X-Received: by 2002:a6b:4a16:: with SMTP id w22-v6mr3365446iob.132.1533939541354;
 Fri, 10 Aug 2018 15:19:01 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:18:57 -0700
In-Reply-To: <CAGZ79kZR_gj00JORH3WB_T+_mgtQm5PGt6+DSMFUbJM+C4FxVw@mail.gmail.com>
Message-Id: <20180810221857.87399-1-sbeller@google.com>
Mime-Version: 1.0
References: <CAGZ79kZR_gj00JORH3WB_T+_mgtQm5PGt6+DSMFUbJM+C4FxVw@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH] Documentation/diff-options: explain different diff algorithms
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a user I wondered what the diff algorithms are about. Offer at least
a basic explanation on the differences of the diff algorithms.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Not sure if this is finished, I just want to put out the state that I
 have sitting on my disk.

 Documentation/diff-options.txt | 10 +++--
 Documentation/git-diff.txt     | 72 ++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f394608b42c..00684b8936f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -91,14 +91,18 @@ appearing as a deletion or addition in the output. It uses the "patience
 diff" algorithm internally.
 
 --diff-algorithm={patience|minimal|histogram|myers}::
-	Choose a diff algorithm. The variants are as follows:
+	Choose a diff algorithm. See the DIFF ALGORITHMS section
+ifndef::git-diff[]
+	in linkgit:git-diff[1]
+endif::git-diff[]
+	for more discussion. The variants are as follows:
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
index b180f1fa5bf..8837492ed05 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -119,6 +119,78 @@ include::diff-options.txt[]
 
 include::diff-format.txt[]
 
+DIFF ALGORITHMS
+---------------
+
+This section explains background on the diff algorithms. All of them
+operate on two input sequences of symbols. In Git each symbol is
+represented by a line of a file unless the option to diff based on
+words is given. The following diff algorithms are available:
+
+`Myers`
+
+A diff as produced by the basic greedy algorithm described in
+link:http://www.xmailserver.org/diff2.pdf[An O(ND) Difference Algorithm and its Variations].
+with a run time of O(M + N + D^2). To understand this algorithm, one
+can imagine a table spanned by the two input sequences with slides
+where there are the same symbols. For example the sequences 'ABCD' and 'ADB'
+the graph would look like
+
+	S | A | B | C | A
+	---------------------
+	A | \ |   |   | \ |
+	---------------------
+	D |   |   |   |   |
+	---------------------
+	B |   | \ |   |   |
+	---------------------
+	  |   |   |   |   |F
+
+and a greedy algorithm is used to find the cheapest path from start S to
+finish F, with each horizontal and vertical step having a cost of one and
+the diagonal slides having a cost of zero.
+
+This is simplified as the real algorithm only needs O(N+M) in terms of memory.
+In addition it employs a heuristic to allow for a faster diff at the small
+cost of diff size. The `minimal` algorithm has that heuristic turned off.
+
+`Minimal`
+The exact algorithm as described in the `Myers` paper without the heuristic
+that trades execution time for slightly worse diffs.
+
+`Patience`
+
+This algorithm by Bram Cohen originally for the bzr version control
+system matches the longest common subsequence of unique lines on
+both sides, recursively. It obtained its name by the way the longest
+subsequence is found, as that is a byproduct of the patience sorting
+algorithm. If there are no unique lines left it falls back to `myers`.
+Empirically this algorithm produces a more readable output for code,
+but it does not guarantee the shortest output.
+
+`Histogram`
+
+This algorithm by Shawn Pearce, originally implemented for
+JGit, finds the longest common substring and recursively
+diffs the content before and after the longest common substring.
+If there are no common substrings left, fall back to `myers`.
+This is often the fastest, but in corner cases (when there are
+many common substrings of the same length) it produces unexpected
+results as seen in:
+
+	seq 1 100 >one
+	echo 99 > two
+	seq 1 2 98 >>two
+	git diff --no-index --histogram one two
+
+
+Note how both `patience` and `histogram` use a concept that is abbreviated
+as 'LCS' (longest common subsequence and longest common substring).
+The longest common subsequence is a sequence of symbols that are found
+on both sides in the same order. The symbols do not need to be adjacent.
+The longest common substring is a sequence of adjacent symbols in order
+on both sides.
+
 EXAMPLES
 --------
 
-- 
2.18.0.865.gffc8e1a3cd6-goog

