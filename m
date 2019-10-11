Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A79871F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 17:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfJKRUt (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 13:20:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36582 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfJKRUt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 13:20:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id m18so10953576wmc.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QWTAncvjrQZ4/E9kgGneKoTGtz+QfeeNd+s/3QhfHKc=;
        b=gotW1ewri3G0VmVhCTXYmyJdt34aIiaA04hg5R9HkJBplJUBXzvy/MQw6okDOytCEZ
         RXL/UunGjl4SWs2TNu/C3gfY8Ek/BQIWSAVcuHrDFke35Gz3r/uVYpbIqAiEbZoLY/CI
         bt/MrOs+YDDevBJienrKVTRKl7RP7vRJSQfqN9Q1DIKVHumPS8GzFM7Je/9EifSPuU49
         jg6qbpRK/Dl/9v+hJdBlQaCOjNajv+k9rDldejiUQiq0uXyMaW0juLDM+dWMtHVMokrZ
         2ZyvBva2QuYfAGVj5okDhlgCmM7YM2TI5Fn4wQdkxEHHiu0qF2Ilc10DcVOModmJsj7h
         +y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QWTAncvjrQZ4/E9kgGneKoTGtz+QfeeNd+s/3QhfHKc=;
        b=ZAaT/iKkmZdVSbYY1aDvnxAh44dysYvr/q7oxUrqim/av5m6yCmFFu0h7fTSEnXU+W
         jhjRerKXYomm+Zd8oFm0HLOsZvgoHDbVV7AgPBmbay2tl/oxmJ4PyoMOBcyM8s5PNSDL
         4uPIeXwQdlFBGeN6acLKkmlZnPNJsHYOK1RMWGd5efLtjQK8BlIU5rFbs8xoD2UUeuaE
         6FMrOZS6DkuoJsqo8yOl6nsdFW2yaoFc5p5k6sIZrmpNnCt/6ov/TbhHRibLIW4tJi+E
         1hB6a7SUw4knbugu3sHazFGVjhk3A3lau8GssQuIDBvbV2tMyaNzfr/o5XdbMd1YF4tZ
         vaRw==
X-Gm-Message-State: APjAAAUgIrF0twCoIkm6mKbnECh4Svc30uBRJLL9EiwggL8gNO7y3bGi
        pwFz/mS9lQHloQcVZN45X+dZ7xXDDSo=
X-Google-Smtp-Source: APXvYqxG16STcxjaZnTIShR7kzM2v13pP1EA6Udd0jhlo2Usvtrx4iE0H857It6YWCgYdz43SYKvRg==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr4088303wmk.30.1570814444647;
        Fri, 11 Oct 2019 10:20:44 -0700 (PDT)
Received: from liskov.home (host109-157-47-110.range109-157.btcentralplus.com. [109.157.47.110])
        by smtp.gmail.com with ESMTPSA id a204sm17034970wmh.21.2019.10.11.10.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:20:44 -0700 (PDT)
Subject: Re: [PATCH 01/11] graph: automatically track visible width of
 `strbuf`
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.383.git.gitgitgadget@gmail.com>
 <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
 <20191010230550.GA42541@generichostname>
 <xmqq7e5cjbwj.fsf@gitster-ct.c.googlers.com>
 <20191011050111.GA94866@generichostname>
 <nycvar.QRO.7.76.6.1910111800220.46@tvgsbejvaqbjf.bet>
From:   James Coglan <jcoglan@gmail.com>
Message-ID: <79463ee5-a171-53a8-4903-84a825c4e8d8@gmail.com>
Date:   Fri, 11 Oct 2019 18:20:43 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910111800220.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/2019 17:02, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 10 Oct 2019, Denton Liu wrote:
> 
>> On Fri, Oct 11, 2019 at 10:42:20AM +0900, Junio C Hamano wrote:
>>> Denton Liu <liu.denton@gmail.com> writes:
>>>
>>>> 	static int calculate_width(const struct strbuf *row)
>>>> 	{
>>>> 		int in_termcode = 0;
>>>> 		int width = 0;
>>>> 		int i;
>>>>
>>>> 		for (i = 0; i < row.len; i++) {
>>>> 			if (row.buf[i] == '\033')
>>>> 				in_termcode = 1;
>>>>
>>>> 			if (!in_termcode)
>>>> 				width++;
>>>> 			else if (row.buf[i] == 'm')
>>>> 				in_termcode = 0;
>>>> 		}
>>>> 	}
>>>
>>> Not every byte that is outside the escape sequence contributes to
>>> one display columns.  You would want to take a look at utf8_width()
>>> for inspiration.
>>>
>>
>> Heh, I guess you're right. Looking right below the definition of
>> utf8_width, I realised we have the utf8_strnwidth function. We should be
>> able to just call
>>
>> 	utf8_strnwidth(row.buf, row.len, 1);
> 
> Correct me if I'm wrong, but don't we want to keep track of the columns
> *only* in the part with the actual line graph, i.e. we're not at all
> interested in the onelines' widths?
> 
> If so, I could imagine that a good idea would be to introduce
> 
> 	struct graphbuf {
> 		struct strbuf buf;
> 		int width;
> 	};
> 
> and then introduce wrappers for `_addch()` and whatever else is used in
> `graph.c`, these wrappers will increment the width together with the
> `buf.len` field, and one additional helper that adds color sequences to
> that graphbuf that leaves `width` unchanged.

That's exactly what I've spent this afternoon doing, in response to the feedback here. I took into consideration that:

- We don't want a general solution to this problem for everything `strbuf` could be used for; it only needs to address the graph padding problem.

- We only want to count printing characters, not color formatting sequences.

- We only need to consider the width of a small set of characters: { | / \ _ - . * }. We don't need to worry about Unicode, and the simple character counting in graph.c was working fine.

- Attempting to count the characters in a `strbuf` after the fact is problematic, because sometimes the line prefix (`diff_options.line_prefix`) is included when `graph_pad_horizontally()` is called, and sometimes the prefix has already been sent to stdout and is not included in the `strbuf`. We need to know how many printing characters were added only during `graph_next_line()`.

To this end I've prepared a different implementation that introduces the indirection described above, and does not modify `strbuf`:

diff --git a/graph.c b/graph.c
index f53135485f..24bf1f4fe1 100644
--- a/graph.c
+++ b/graph.c
@@ -112,14 +112,38 @@ static const char *column_get_color_code(unsigned short color)
 	return column_colors[color];
 }
 
-static void strbuf_write_column(struct strbuf *sb, const struct column *c,
-				char col_char)
+struct graph_strbuf {
+	struct strbuf *buf;
+	size_t width;
+};
+
+static inline void graph_strbuf_addch(struct graph_strbuf *sb, int c)
+{
+	strbuf_addch(sb->buf, c);
+	sb->width++;
+}
+
+void graph_strbuf_addchars(struct graph_strbuf *sb, int c, size_t n)
+{
+	strbuf_addchars(sb->buf, c, n);
+	sb->width += n;
+}
+
+static inline void graph_strbuf_addstr(struct graph_strbuf *sb, const char *s)
+{
+	strbuf_addstr(sb->buf, s);
+	sb->width += strlen(s);
+}
+
+static void graph_strbuf_write_column(struct graph_strbuf *sb, const struct column *c,
+				      char col_char)
 {
 	if (c->color < column_colors_max)
-		strbuf_addstr(sb, column_get_color_code(c->color));
-	strbuf_addch(sb, col_char);
+		strbuf_addstr(sb->buf, column_get_color_code(c->color));
+	strbuf_addch(sb->buf, col_char);
+	sb->width++;
 	if (c->color < column_colors_max)
-		strbuf_addstr(sb, column_get_color_code(column_colors_max));
+		strbuf_addstr(sb->buf, column_get_color_code(column_colors_max));
 }
 
 struct git_graph {
@@ -686,8 +710,7 @@ static int graph_is_mapping_correct(struct git_graph *graph)
 	return 1;
 }
 
-static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb,
-				   int chars_written)
+static void graph_pad_horizontally(struct git_graph *graph, struct graph_strbuf *sb)
 {
 	/*
 	 * Add additional spaces to the end of the strbuf, so that all
@@ -696,12 +719,12 @@ static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb,
 	 * This way, fields printed to the right of the graph will remain
 	 * aligned for the entire commit.
 	 */
-	if (chars_written < graph->width)
-		strbuf_addchars(sb, ' ', graph->width - chars_written);
+	if (sb->width < graph->width)
+		strbuf_addchars(sb->buf, ' ', graph->width - sb->width);
 }
 
 static void graph_output_padding_line(struct git_graph *graph,
-				      struct strbuf *sb)
+				      struct graph_strbuf *sb)
 {
 	int i;
 
@@ -719,11 +742,11 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
-		strbuf_write_column(sb, &graph->new_columns[i], '|');
-		strbuf_addch(sb, ' ');
+		graph_strbuf_write_column(sb, &graph->new_columns[i], '|');
+		graph_strbuf_addch(sb, ' ');
 	}
 
-	graph_pad_horizontally(graph, sb, graph->num_new_columns * 2);
+	graph_pad_horizontally(graph, sb);
 }
 
 
@@ -733,14 +756,14 @@ int graph_width(struct git_graph *graph)
 }
 
 
-static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_skip_line(struct git_graph *graph, struct graph_strbuf *sb)
 {
 	/*
 	 * Output an ellipsis to indicate that a portion
 	 * of the graph is missing.
 	 */
-	strbuf_addstr(sb, "...");
-	graph_pad_horizontally(graph, sb, 3);
+	graph_strbuf_addstr(sb, "...");
+	graph_pad_horizontally(graph, sb);
 
 	if (graph->num_parents >= 3 &&
 	    graph->commit_index < (graph->num_columns - 1))
@@ -750,11 +773,10 @@ static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
 }
 
 static void graph_output_pre_commit_line(struct git_graph *graph,
-					 struct strbuf *sb)
+					 struct graph_strbuf *sb)
 {
 	int num_expansion_rows;
 	int i, seen_this;
-	int chars_written;
 
 	/*
 	 * This function formats a row that increases the space around a commit
@@ -777,14 +799,12 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	 * Output the row
 	 */
 	seen_this = 0;
-	chars_written = 0;
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		if (col->commit == graph->commit) {
 			seen_this = 1;
-			strbuf_write_column(sb, col, '|');
-			strbuf_addchars(sb, ' ', graph->expansion_row);
-			chars_written += 1 + graph->expansion_row;
+			graph_strbuf_write_column(sb, col, '|');
+			graph_strbuf_addchars(sb, ' ', graph->expansion_row);
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
@@ -797,22 +817,18 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
 			    graph->prev_commit_index < i)
-				strbuf_write_column(sb, col, '\\');
+				graph_strbuf_write_column(sb, col, '\\');
 			else
-				strbuf_write_column(sb, col, '|');
-			chars_written++;
+				graph_strbuf_write_column(sb, col, '|');
 		} else if (seen_this && (graph->expansion_row > 0)) {
-			strbuf_write_column(sb, col, '\\');
-			chars_written++;
+			graph_strbuf_write_column(sb, col, '\\');
 		} else {
-			strbuf_write_column(sb, col, '|');
-			chars_written++;
+			graph_strbuf_write_column(sb, col, '|');
 		}
-		strbuf_addch(sb, ' ');
-		chars_written++;
+		graph_strbuf_addch(sb, ' ');
 	}
 
-	graph_pad_horizontally(graph, sb, chars_written);
+	graph_pad_horizontally(graph, sb);
 
 	/*
 	 * Increment graph->expansion_row,
@@ -823,7 +839,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		graph_update_state(graph, GRAPH_COMMIT);
 }
 
-static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_commit_char(struct git_graph *graph, struct graph_strbuf *sb)
 {
 	/*
 	 * For boundary commits, print 'o'
@@ -831,22 +847,20 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 	 */
 	if (graph->commit->object.flags & BOUNDARY) {
 		assert(graph->revs->boundary);
-		strbuf_addch(sb, 'o');
+		graph_strbuf_addch(sb, 'o');
 		return;
 	}
 
 	/*
 	 * get_revision_mark() handles all other cases without assert()
 	 */
-	strbuf_addstr(sb, get_revision_mark(graph->revs, graph->commit));
+	graph_strbuf_addstr(sb, get_revision_mark(graph->revs, graph->commit));
 }
 
 /*
- * Draw the horizontal dashes of an octopus merge and return the number of
- * characters written.
+ * Draw the horizontal dashes of an octopus merge.
  */
-static int graph_draw_octopus_merge(struct git_graph *graph,
-				    struct strbuf *sb)
+static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_strbuf *sb)
 {
 	/*
 	 * Here dashless_parents represents the number of parents which don't
@@ -886,17 +900,16 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
 
 	int i;
 	for (i = 0; i < dashful_parents; i++) {
-		strbuf_write_column(sb, &graph->new_columns[i+first_col], '-');
-		strbuf_write_column(sb, &graph->new_columns[i+first_col],
-				    i == dashful_parents-1 ? '.' : '-');
+		graph_strbuf_write_column(sb, &graph->new_columns[i+first_col], '-');
+		graph_strbuf_write_column(sb, &graph->new_columns[i+first_col],
+					  i == dashful_parents-1 ? '.' : '-');
 	}
-	return 2 * dashful_parents;
 }
 
-static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_commit_line(struct git_graph *graph, struct graph_strbuf *sb)
 {
 	int seen_this = 0;
-	int i, chars_written;
+	int i;
 
 	/*
 	 * Output the row containing this commit
@@ -906,7 +919,6 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 	 * children that we have already processed.)
 	 */
 	seen_this = 0;
-	chars_written = 0;
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
@@ -921,14 +933,11 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 		if (col_commit == graph->commit) {
 			seen_this = 1;
 			graph_output_commit_char(graph, sb);
-			chars_written++;
 
 			if (graph->num_parents > 2)
-				chars_written += graph_draw_octopus_merge(graph,
-									  sb);
+				graph_draw_octopus_merge(graph, sb);
 		} else if (seen_this && (graph->num_parents > 2)) {
-			strbuf_write_column(sb, col, '\\');
-			chars_written++;
+			graph_strbuf_write_column(sb, col, '\\');
 		} else if (seen_this && (graph->num_parents == 2)) {
 			/*
 			 * This is a 2-way merge commit.
@@ -945,19 +954,16 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
 			    graph->prev_commit_index < i)
-				strbuf_write_column(sb, col, '\\');
+				graph_strbuf_write_column(sb, col, '\\');
 			else
-				strbuf_write_column(sb, col, '|');
-			chars_written++;
+				graph_strbuf_write_column(sb, col, '|');
 		} else {
-			strbuf_write_column(sb, col, '|');
-			chars_written++;
+			graph_strbuf_write_column(sb, col, '|');
 		}
-		strbuf_addch(sb, ' ');
-		chars_written++;
+		graph_strbuf_addch(sb, ' ');
 	}
 
-	graph_pad_horizontally(graph, sb, chars_written);
+	graph_pad_horizontally(graph, sb);
 
 	/*
 	 * Update graph->state
@@ -981,15 +987,14 @@ static struct column *find_new_column_by_commit(struct git_graph *graph,
 	return NULL;
 }
 
-static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_post_merge_line(struct git_graph *graph, struct graph_strbuf *sb)
 {
 	int seen_this = 0;
-	int i, j, chars_written;
+	int i, j;
 
 	/*
 	 * Output the post-merge row
 	 */
-	chars_written = 0;
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
@@ -1016,29 +1021,25 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
 			par_column = find_new_column_by_commit(graph, parents->item);
 			assert(par_column);
 
-			strbuf_write_column(sb, par_column, '|');
-			chars_written++;
+			graph_strbuf_write_column(sb, par_column, '|');
 			for (j = 0; j < graph->num_parents - 1; j++) {
 				parents = next_interesting_parent(graph, parents);
 				assert(parents);
 				par_column = find_new_column_by_commit(graph, parents->item);
 				assert(par_column);
-				strbuf_write_column(sb, par_column, '\\');
-				strbuf_addch(sb, ' ');
+				graph_strbuf_write_column(sb, par_column, '\\');
+				graph_strbuf_addch(sb, ' ');
 			}
-			chars_written += j * 2;
 		} else if (seen_this) {
-			strbuf_write_column(sb, col, '\\');
-			strbuf_addch(sb, ' ');
-			chars_written += 2;
+			graph_strbuf_write_column(sb, col, '\\');
+			graph_strbuf_addch(sb, ' ');
 		} else {
-			strbuf_write_column(sb, col, '|');
-			strbuf_addch(sb, ' ');
-			chars_written += 2;
+			graph_strbuf_write_column(sb, col, '|');
+			graph_strbuf_addch(sb, ' ');
 		}
 	}
 
-	graph_pad_horizontally(graph, sb, chars_written);
+	graph_pad_horizontally(graph, sb);
 
 	/*
 	 * Update graph->state
@@ -1049,7 +1050,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
-static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_collapsing_line(struct git_graph *graph, struct graph_strbuf *sb)
 {
 	int i;
 	short used_horizontal = 0;
@@ -1159,9 +1160,9 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 	for (i = 0; i < graph->mapping_size; i++) {
 		int target = graph->new_mapping[i];
 		if (target < 0)
-			strbuf_addch(sb, ' ');
+			graph_strbuf_addch(sb, ' ');
 		else if (target * 2 == i)
-			strbuf_write_column(sb, &graph->new_columns[target], '|');
+			graph_strbuf_write_column(sb, &graph->new_columns[target], '|');
 		else if (target == horizontal_edge_target &&
 			 i != horizontal_edge - 1) {
 				/*
@@ -1172,16 +1173,16 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 				if (i != (target * 2)+3)
 					graph->new_mapping[i] = -1;
 				used_horizontal = 1;
-			strbuf_write_column(sb, &graph->new_columns[target], '_');
+			graph_strbuf_write_column(sb, &graph->new_columns[target], '_');
 		} else {
 			if (used_horizontal && i < horizontal_edge)
 				graph->new_mapping[i] = -1;
-			strbuf_write_column(sb, &graph->new_columns[target], '/');
+			graph_strbuf_write_column(sb, &graph->new_columns[target], '/');
 
 		}
 	}
 
-	graph_pad_horizontally(graph, sb, graph->mapping_size);
+	graph_pad_horizontally(graph, sb);
 
 	/*
 	 * Swap mapping and new_mapping
@@ -1199,24 +1200,26 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 
 int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 {
+	struct graph_strbuf gsb = { .buf = sb, .width = 0 };
+
 	switch (graph->state) {
 	case GRAPH_PADDING:
-		graph_output_padding_line(graph, sb);
+		graph_output_padding_line(graph, &gsb);
 		return 0;
 	case GRAPH_SKIP:
-		graph_output_skip_line(graph, sb);
+		graph_output_skip_line(graph, &gsb);
 		return 0;
 	case GRAPH_PRE_COMMIT:
-		graph_output_pre_commit_line(graph, sb);
+		graph_output_pre_commit_line(graph, &gsb);
 		return 0;
 	case GRAPH_COMMIT:
-		graph_output_commit_line(graph, sb);
+		graph_output_commit_line(graph, &gsb);
 		return 1;
 	case GRAPH_POST_MERGE:
-		graph_output_post_merge_line(graph, sb);
+		graph_output_post_merge_line(graph, &gsb);
 		return 0;
 	case GRAPH_COLLAPSING:
-		graph_output_collapsing_line(graph, sb);
+		graph_output_collapsing_line(graph, &gsb);
 		return 0;
 	}
 
@@ -1227,7 +1230,7 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int i;
-	int chars_written = 0;
+	struct graph_strbuf gsb = { .buf = sb, .width = 0 };
 
 	if (graph->state != GRAPH_COMMIT) {
 		graph_next_line(graph, sb);
@@ -1244,20 +1247,17 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 
-		strbuf_write_column(sb, col, '|');
-		chars_written++;
+		graph_strbuf_write_column(&gsb, col, '|');
 
 		if (col->commit == graph->commit && graph->num_parents > 2) {
 			int len = (graph->num_parents - 2) * 2;
-			strbuf_addchars(sb, ' ', len);
-			chars_written += len;
+			graph_strbuf_addchars(&gsb, ' ', len);
 		} else {
-			strbuf_addch(sb, ' ');
-			chars_written++;
+			graph_strbuf_addch(&gsb, ' ');
 		}
 	}
 
-	graph_pad_horizontally(graph, sb, chars_written);
+	graph_pad_horizontally(graph, &gsb);
 
 	/*
 	 * Update graph->prev_state since we have output a padding line


