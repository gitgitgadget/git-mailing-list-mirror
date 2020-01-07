Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DD7C33C9E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 21:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045DE2187F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 21:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUS/Ut7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgAGV1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:27:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42231 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgAGV1G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 16:27:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id q6so1128118wro.9
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 13:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F3dL74uJgq8o1W97Ob2A6XIOIwcpqzGvEO+gVhGFwP0=;
        b=FUS/Ut7qUZe8EfSrLYNbHHFwLBhKutH2/QRKp2wTG33sQZOgDfsupnYtoCxXVqkUzY
         1LxHq+t9QTj1JL2Dgd634vROq2m0Vq+2Mdq7fWXfIF6gVLHM6TmI3RAQWF+03Vist9/C
         hp2at8ltEgKM9lcy9exoYgZypiWkvjwTs76hQXm7hiztThpB113UDLgozjvrbO/A9h2d
         1Vkq9gegvLMKyzsS590iXCQSVrjjjJrn0qxvPivGU7Gx0C00F9JgCymIc5GfWg8CNmQ0
         ILzjqWvnZdSR1McXZHiQqxedqjMi1T0kNX+j8wCZPl2EDAgMRkEsZFDxoGcMmcretIdE
         F2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F3dL74uJgq8o1W97Ob2A6XIOIwcpqzGvEO+gVhGFwP0=;
        b=BtBdyuUYPGBl4BOjn/DOpd7cyl6apIDPOnOcqb5c+eh5wG3jacQi1Cq64x14hOspaL
         FewZ2i9hjIj+WljIcilgHfNdT8sen8HX7AndauCG6LEmXcvJ+3emOw011R3cdKFu02GJ
         0eUlNIuyg25ZxyLbWbrHFy51UynKDSaw8G46XwePNR9BGb16Of75/sI6hss+TxROGP/k
         AqTY3nIQdWptjZzqH0hejouipvsKrF0bAY4xSqD9PiTi3nY5vT7sX7h5k7GSg4wWhDR2
         xRljKw87UuQOYz2McspAIsNdIMfenaWml6Zx0u3hD7ZWTA55shiRjorl/fh1hhYWMypq
         GWnw==
X-Gm-Message-State: APjAAAVyzXQ0vubveF7iGeWwcOTOM7GbYvxgiY99m7DtJkmzITSscITa
        QHSog4zufg8f/hLU3l/a1haPTP5u
X-Google-Smtp-Source: APXvYqy+5R5kHlbt5HTFfG95ymo8GhhkEanOtotCTlNcZ82L0fKqDzyZXqUCzdUkjeX1lwMJ+heJZQ==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr1005312wrw.370.1578432423389;
        Tue, 07 Jan 2020 13:27:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm1044565wmc.12.2020.01.07.13.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 13:27:02 -0800 (PST)
Message-Id: <pull.517.v2.git.1578432422.gitgitgadget@gmail.com>
In-Reply-To: <pull.517.git.1578408947.gitgitgadget@gmail.com>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 21:27:00 +0000
Subject: [PATCH v2 0/2] Fix two bugs in graph.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, brad@brad-smith.co.uk, sunshine@sunshineco.com,
        James Coglan <jcoglan@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a possible fix for the bug reported in [1].

The first commit fixes the runtime failure due to the assert() statement.

The second commit replaces the assert() statements with a macro that
triggers a BUG().

The third commit adds another test that shows a more complicated example and
how the new code in v2.25.0-rc1 has a behavior change that is not
necessarily wanted.

Thanks, -Stolee

[1] 
https://lore.kernel.org/git/CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com/

Derrick Stolee (2):
  graph: fix case that hit assert()
  graph: fix lack of color in horizontal lines

 graph.c                      | 17 +++++----
 t/t4215-log-skewed-merges.sh | 71 ++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 8 deletions(-)


base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-517%2Fderrickstolee%2Fgraph-assert-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-517/derrickstolee/graph-assert-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/517

Range-diff vs v1:

 1:  65186f3ded ! 1:  c05fe2c37a graph: fix case that hit assert()
     @@ -3,17 +3,11 @@
          graph: fix case that hit assert()
      
          A failure was reported in "git log --graph --all" with the new
     -    graph-rendering logic. Create a test case that matches the
     -    topology of that example and uses an explicit ref ordering instead
     -    of the "--all" option. The test would fail with the following error:
     +    graph-rendering logic. The code fails an assert() statement when
     +    collapsing multiple edges from a merge.
      
     -            graph.c:1228: graph_output_collapsing_line: Assertion
     -                          `graph->mapping[i - 3] == target' failed.
     -
     -    The situation is a little complicated, so let's break it down.
     -
     -    The assert was introduced by eaf158f8 ("graph API: Use horizontal
     -    lines for more compact graphs", 2009-04-21), which is quite old.
     +    The assert was introduced by eaf158f8 (graph API: Use horizontal
     +    lines for more compact graphs, 2009-04-21), which is quite old.
          This assert is trying to say that when we complete a horizontal
          line with a single slash, it is because we have reached our target.
      
     @@ -30,18 +24,45 @@
      
          It is actually the _second_ collapsing line that hits this assert.
          The reason we are in this code path is because we are collapsing
     -    the first line, and it in that case we are hitting our target now
     +    the first line, and in that case we are hitting our target now
          that the horizontal line is complete. However, the second line
          cannot be a horizontal line, so it will collapse without horizontal
          lines. In this case, it is inappropriate to assert that we have
          reached our target, as we need to continue for another column
          before reaching the target. Dropping the assert is safe here.
      
     -    Second, the horizontal lines in that first line drop their coloring.
     -    This is due to a use of graph_line_addch() instead of
     -    graph_line_write_column(). Using a ternary operator to pick the
     -    character is nice for compact code, but we actually need a column
     -    to provide the color.
     +    The new behavior in 0f0f389f12 (graph: tidy up display of
     +    left-skewed merges, 2019-10-15) caused the behavior change that
     +    made this assertion failure possible. In addition to making the
     +    assert possible, it also changed how multiple edges collapse.
     +
     +    In a larger example, the current code will output a collapse
     +    as follows:
     +
     +            | | | | | | *
     +            | |_|_|_|_|/|\
     +            |/| | | | |/ /
     +            | | | | |/| /
     +            | | | |/| |/
     +            | | |/| |/|
     +            | |/| |/| |
     +            | | |/| | |
     +            | | * | | |
     +
     +    However, the intended collapse should allow multiple horizontal lines
     +    as follows:
     +
     +            | | | | | | *
     +            | |_|_|_|_|/|\
     +            |/| | | | |/ /
     +            | | |_|_|/| /
     +            | |/| | | |/
     +            | | | |_|/|
     +            | | |/| | |
     +            | | * | | |
     +
     +    This behavior is not corrected by this change, but is noted for a later
     +    update.
      
          Helped-by: Jeff King <peff@peff.net>
          Reported-by: Bradley Smith <brad@brad-smith.co.uk>
     @@ -50,36 +71,6 @@
       diff --git a/graph.c b/graph.c
       --- a/graph.c
       +++ b/graph.c
     -@@
     - 	int i, j;
     - 
     - 	struct commit_list *first_parent = first_interesting_parent(graph);
     --	int seen_parent = 0;
     -+	struct column *parent_col = NULL;
     - 
     - 	/*
     - 	 * Output the post-merge row
     -@@
     - 			graph_line_addch(line, ' ');
     - 		} else {
     - 			graph_line_write_column(line, col, '|');
     --			if (graph->merge_layout != 0 || i != graph->commit_index - 1)
     --				graph_line_addch(line, seen_parent ? '_' : ' ');
     -+			if (graph->merge_layout != 0 || i != graph->commit_index - 1) {
     -+				if (parent_col)
     -+					graph_line_write_column(
     -+						line, parent_col, '_');
     -+				else
     -+					graph_line_addch(line, ' ');
     -+			}
     - 		}
     - 
     - 		if (col_commit == first_parent->item)
     --			seen_parent = 1;
     -+			parent_col = col;
     - 	}
     - 
     - 	/*
      @@
       			 *
       			 * The space just to the left of this
 2:  5dd305d2f0 ! 2:  11887bd38d graph: replace assert() with graph_assert() macro
     @@ -1,100 +1,86 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    graph: replace assert() with graph_assert() macro
     +    graph: fix lack of color in horizontal lines
      
     -    The assert() macro is sometimes compiled out. Instead, switch these into
     -    BUG() statements using our own custom macro.
     +    In some cases, horizontal lines in rendered graphs can lose their
     +    coloring. This is due to a use of graph_line_addch() instead of
     +    graph_line_write_column(). Using a ternary operator to pick the
     +    character is nice for compact code, but we actually need a column to
     +    provide the color.
      
     -    Reported-by: Eric Sunshine <sunshine@sunshineco.com>
     +    Add a test to t4215-log-skewed-merges.sh to prevent regression.
     +
     +    Reported-by: Jeff King <peff@peff.net>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/graph.c b/graph.c
       --- a/graph.c
       +++ b/graph.c
      @@
     - #include "revision.h"
     - #include "argv-array.h"
     - 
     -+#define graph_assert(exp) if (!(exp)) { BUG("assert failed: "#exp""); }
     -+
     - /* Internal API */
     - 
     - /*
     -@@
     - 	struct git_graph *graph = data;
     - 	static struct strbuf msgbuf = STRBUF_INIT;
     - 
     --	assert(opt);
     -+	graph_assert(opt);
     - 
     - 	strbuf_reset(&msgbuf);
     - 	if (opt->line_prefix)
     -@@
     - 	 *
     - 	 * We need 2 extra rows for every parent over 2.
     - 	 */
     --	assert(graph->num_parents >= 3);
     -+	graph_assert(graph->num_parents >= 3);
     + 	int i, j;
       
     - 	/*
     - 	 * graph->expansion_row tracks the current expansion row we are on.
     - 	 * It should be in the range [0, num_expansion_rows - 1]
     - 	 */
     --	assert(0 <= graph->expansion_row &&
     -+	graph_assert(0 <= graph->expansion_row &&
     - 	       graph->expansion_row < graph_num_expansion_rows(graph));
     + 	struct commit_list *first_parent = first_interesting_parent(graph);
     +-	int seen_parent = 0;
     ++	struct column *parent_col = NULL;
       
       	/*
     + 	 * Output the post-merge row
      @@
     - 	 * (We should only see boundary commits when revs->boundary is set.)
     - 	 */
     - 	if (graph->commit->object.flags & BOUNDARY) {
     --		assert(graph->revs->boundary);
     -+		graph_assert(graph->revs->boundary);
     - 		graph_line_addch(line, 'o');
     - 		return;
     + 			graph_line_addch(line, ' ');
     + 		} else {
     + 			graph_line_write_column(line, col, '|');
     +-			if (graph->merge_layout != 0 || i != graph->commit_index - 1)
     +-				graph_line_addch(line, seen_parent ? '_' : ' ');
     ++			if (graph->merge_layout != 0 || i != graph->commit_index - 1) {
     ++				if (parent_col)
     ++					graph_line_write_column(
     ++						line, parent_col, '_');
     ++				else
     ++					graph_line_addch(line, ' ');
     ++			}
     + 		}
     + 
     + 		if (col_commit == first_parent->item)
     +-			seen_parent = 1;
     ++			parent_col = col;
       	}
       
       	/*
     --	 * get_revision_mark() handles all other cases without assert()
     -+	 * get_revision_mark() handles all other cases without graph_assert()
     - 	 */
     - 	graph_line_addstr(line, get_revision_mark(graph->revs, graph->commit));
     - }
     -@@
     - 
     - 			for (j = 0; j < graph->num_parents; j++) {
     - 				par_column = graph_find_new_column_by_commit(graph, parents->item);
     --				assert(par_column >= 0);
     -+				graph_assert(par_column >= 0);
     - 
     - 				c = merge_chars[idx];
     - 				graph_line_write_column(line, &graph->new_columns[par_column], c);
     +
     + diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
     + --- a/t/t4215-log-skewed-merges.sh
     + +++ b/t/t4215-log-skewed-merges.sh
      @@
     - 		 * the graph much more legible, since whenever branches
     - 		 * cross, only one is moving directions.
     - 		 */
     --		assert(target * 2 <= i);
     -+		graph_assert(target * 2 <= i);
     + 	EOF
     + '
       
     - 		if (target * 2 == i) {
     - 			/*
     - 			 * This column is already in the
     - 			 * correct place
     - 			 */
     --			assert(graph->mapping[i] == -1);
     -+			graph_assert(graph->mapping[i] == -1);
     - 			graph->mapping[i] = target;
     - 		} else if (graph->mapping[i - 1] < 0) {
     - 			/*
     -@@
     - 			 * The space just to the left of this
     - 			 * branch should always be empty.
     - 			 */
     --			assert(graph->mapping[i - 1] > target);
     --			assert(graph->mapping[i - 2] < 0);
     -+			graph_assert(graph->mapping[i - 1] > target);
     -+			graph_assert(graph->mapping[i - 2] < 0);
     - 			graph->mapping[i - 2] = target;
     - 			/*
     - 			 * Mark this branch as the horizontal edge to
     ++test_expect_success 'log --graph with multiple tips and colors' '
     ++	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
     ++	cat >expect.colors <<-\EOF &&
     ++	*   6_I
     ++	<RED>|<RESET><GREEN>\<RESET>
     ++	<RED>|<RESET> <GREEN>|<RESET> *   6_H
     ++	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET><BLUE>\<RESET>
     ++	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> * 6_G
     ++	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 6_F
     ++	<RED>|<RESET> <GREEN>|<RESET><RED>_<RESET><YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>/<RESET><GREEN>|<RESET>
     ++	<RED>|<RESET><RED>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET><GREEN>/<RESET>
     ++	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET><GREEN>/<RESET><BLUE>|<RESET>
     ++	<RED>|<RESET> <GREEN>|<RESET><GREEN>/<RESET><YELLOW>|<RESET> <BLUE>|<RESET>
     ++	<RED>|<RESET> <GREEN>|<RESET> * <BLUE>|<RESET> 6_E
     ++	<RED>|<RESET> * <CYAN>|<RESET> <BLUE>|<RESET> 6_D
     ++	<RED>|<RESET> <BLUE>|<RESET> <CYAN>|<RESET><BLUE>/<RESET>
     ++	<RED>|<RESET> <BLUE>|<RESET><BLUE>/<RESET><CYAN>|<RESET>
     ++	* <BLUE>|<RESET> <CYAN>|<RESET> 6_C
     ++	<CYAN>|<RESET> <BLUE>|<RESET><CYAN>/<RESET>
     ++	<CYAN>|<RESET><CYAN>/<RESET><BLUE>|<RESET>
     ++	* <BLUE>|<RESET> 6_B
     ++	<BLUE>|<RESET><BLUE>/<RESET>
     ++	* 6_A
     ++	EOF
     ++	git log --color=always --graph --date-order --pretty=tformat:%s 6_1 6_3 6_5 >actual.colors.raw &&
     ++	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
     ++	test_cmp expect.colors actual.colors
     ++'
     ++
     + test_done
 3:  f74e82bea6 < -:  ---------- t4215: add bigger graph collapse test

-- 
gitgitgadget
