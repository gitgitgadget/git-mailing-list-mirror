Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63749C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335D3208C4
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jos1E3t/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgAGOzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:55:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52465 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGOzv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 09:55:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so19280612wmc.2
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 06:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JpQHJTs7L1OB1+SbbJoySS+E0kSU/Js9OqF20iUIlbk=;
        b=jos1E3t/xPMWGJ7i/mQK1pERZaCUIPn3DO0CSLBcp8JUp/YtroFyLhPUsjX9s9094I
         kUa47rHTOdOuCGv4D2QwqUMEcjI2eCUtKMXUPJ83OtEi7ctNrihGj2unzGB2yk8ZEh87
         gScvSEjeENz+U3DHpoRs6LyJqxiYIL9WNhAJABnaAx+GWB/6gqUZoOuhYvi0Z7OAKpk0
         LqeU4JvbYsk9Wsmm4hfl9UWvhMGJLYK268KSG8FnKmt7vDd4kyOLJUfzC9HNlxzHMyrI
         eNGgBPt6Lm6ehz4/dWMY6n+SDk4SyxlBtzw1kPFaEP8sc/KdSO+Q5X1BBHDczI/ftknl
         Vj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JpQHJTs7L1OB1+SbbJoySS+E0kSU/Js9OqF20iUIlbk=;
        b=SS8A3XUqx/HLyo/jImgvTGvfWpWGILJgPF0cWsDojynhP9SBM/SPvptuB2fGZnbR7e
         jDqlGOjUWBbt3EV2AbzkYvUcljCuJTdB7gNYdMf1uneR2frfDCjxsEoNhwv2kzKplxfk
         pdBxAQ6ZPeB3EzGBghzsqVFuBCOhlVDCG08pKaL15y/WR3agE+WFHW6SnLqy2eOTJLVo
         vMtvzNLHlQuJfpIzd/oLGqNpYdLSwcf13ws2JcYXvOk49ZXUy8wp34MtvTMbqcccuiVd
         BDxaX9ooYaz2NaIZAGDlirvJz5IZ51zqRjzyZLtC/TLSVoXHQvwYFFX+TRJsTC055XYn
         2cxg==
X-Gm-Message-State: APjAAAXycHrUnNZQtAvR8zjav6zRHAYigzoYZ8A6WFicclCtjTpMwaAg
        d3aGOxa8TfawG2TC2re0DOgzggCs
X-Google-Smtp-Source: APXvYqzJmdwjWiXAOAy3hzxT4WHvibN7cqrHrDP4hBrYxcrNZtGh0CSwVS48ARR7z7MTQsy2D7AVjQ==
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr40449266wmk.1.1578408948848;
        Tue, 07 Jan 2020 06:55:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm62464wrr.75.2020.01.07.06.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:55:48 -0800 (PST)
Message-Id: <65186f3ded251e0bcf1fcb18160163a3efd97c37.1578408947.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.517.git.1578408947.gitgitgadget@gmail.com>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 14:55:45 +0000
Subject: [PATCH 1/3] graph: fix case that hit assert()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, brad@brad-smith.co.uk, sunshine@sunshineco.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

A failure was reported in "git log --graph --all" with the new
graph-rendering logic. Create a test case that matches the
topology of that example and uses an explicit ref ordering instead
of the "--all" option. The test would fail with the following error:

	graph.c:1228: graph_output_collapsing_line: Assertion
		      `graph->mapping[i - 3] == target' failed.

The situation is a little complicated, so let's break it down.

The assert was introduced by eaf158f8 ("graph API: Use horizontal
lines for more compact graphs", 2009-04-21), which is quite old.
This assert is trying to say that when we complete a horizontal
line with a single slash, it is because we have reached our target.

This assertion is hit when we have two collapsing lines from the
same merge commit, as follows:

    | | | | *
    | |_|_|/|
    |/| | |/
    | | |/|
    | |/| |
    | * | |
    * | | |

It is actually the _second_ collapsing line that hits this assert.
The reason we are in this code path is because we are collapsing
the first line, and it in that case we are hitting our target now
that the horizontal line is complete. However, the second line
cannot be a horizontal line, so it will collapse without horizontal
lines. In this case, it is inappropriate to assert that we have
reached our target, as we need to continue for another column
before reaching the target. Dropping the assert is safe here.

Second, the horizontal lines in that first line drop their coloring.
This is due to a use of graph_line_addch() instead of
graph_line_write_column(). Using a ternary operator to pick the
character is nice for compact code, but we actually need a column
to provide the color.

Helped-by: Jeff King <peff@peff.net>
Reported-by: Bradley Smith <brad@brad-smith.co.uk>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 graph.c                      | 17 ++++++++-------
 t/t4215-log-skewed-merges.sh | 42 ++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/graph.c b/graph.c
index 66ae18add8..aaf97069bd 100644
--- a/graph.c
+++ b/graph.c
@@ -1063,7 +1063,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 	int i, j;
 
 	struct commit_list *first_parent = first_interesting_parent(graph);
-	int seen_parent = 0;
+	struct column *parent_col = NULL;
 
 	/*
 	 * Output the post-merge row
@@ -1117,12 +1117,17 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			graph_line_addch(line, ' ');
 		} else {
 			graph_line_write_column(line, col, '|');
-			if (graph->merge_layout != 0 || i != graph->commit_index - 1)
-				graph_line_addch(line, seen_parent ? '_' : ' ');
+			if (graph->merge_layout != 0 || i != graph->commit_index - 1) {
+				if (parent_col)
+					graph_line_write_column(
+						line, parent_col, '_');
+				else
+					graph_line_addch(line, ' ');
+			}
 		}
 
 		if (col_commit == first_parent->item)
-			seen_parent = 1;
+			parent_col = col;
 	}
 
 	/*
@@ -1219,13 +1224,9 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 			 *
 			 * The space just to the left of this
 			 * branch should always be empty.
-			 *
-			 * The branch to the left of that space
-			 * should be our eventual target.
 			 */
 			assert(graph->mapping[i - 1] > target);
 			assert(graph->mapping[i - 2] < 0);
-			assert(graph->mapping[i - 3] == target);
 			graph->mapping[i - 2] = target;
 			/*
 			 * Mark this branch as the horizontal edge to
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 18709a723e..ddf6f6f5d3 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -240,4 +240,46 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
 	EOF
 '
 
+test_expect_success 'log --graph with multiple tips' '
+	git checkout --orphan 6_1 &&
+	test_commit 6_A &&
+	git branch 6_2 &&
+	git branch 6_4 &&
+	test_commit 6_B &&
+	git branch 6_3 &&
+	test_commit 6_C &&
+	git checkout 6_2 && test_commit 6_D &&
+	git checkout 6_3 && test_commit 6_E &&
+	git checkout -b 6_5 6_1 &&
+	git merge --no-ff 6_2 -m 6_F &&
+	git checkout 6_4 && test_commit 6_G &&
+	git checkout 6_3 &&
+	git merge --no-ff 6_4 -m 6_H &&
+	git checkout 6_1 &&
+	git merge --no-ff 6_2 -m 6_I &&
+
+	check_graph 6_1 6_3 6_5 <<-\EOF
+	*   6_I
+	|\
+	| | *   6_H
+	| | |\
+	| | | * 6_G
+	| | * | 6_E
+	| | | | * 6_F
+	| |_|_|/|
+	|/| | |/
+	| | |/|
+	| |/| |
+	| * | | 6_D
+	| | |/
+	| |/|
+	* | | 6_C
+	| |/
+	|/|
+	* | 6_B
+	|/
+	* 6_A
+	EOF
+'
+
 test_done
-- 
gitgitgadget

