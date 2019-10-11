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
	by dcvr.yhbt.net (Postfix) with ESMTP id A1A771F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 17:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfJKRIx (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 13:08:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44544 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfJKRIx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 13:08:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so12729292wrl.11
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9QcgPVFmppsA3xG3PF5c3sURmboZqnPSLo6Dv8CbMAg=;
        b=WbNUFuWwD/zYKjjCK2c4AsgIKQx5pKtIqDbfTWd21tjtr9kqSaWHHy1y1rVD3sIUGA
         glItSBYjm7EWmqNXBpVVImuiBiRflNfvGNzb84wSd/dgytXFbskQcLzm2tT44i1ac+Xg
         9oQEXkth2by6jn7XTTvo8ps/XExuv6trv0XpUnX1C1KCFTyubI5QBKnEtbijGlwMnK9z
         a05X0WmvvNH+ONRyW3IGxpXUBr422GPQ2zqo7HifRUdHe+c9bTI4idAUdUR5aorZkilT
         T+PwdnFskC1j6r0lqyNFDR3/RELQz28ajmi8kr37sLSWm25dm/fnpO7yKL6kxjNXwOpe
         6z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9QcgPVFmppsA3xG3PF5c3sURmboZqnPSLo6Dv8CbMAg=;
        b=gKJVF80SP2PKpogTB5qn49osH3SdNf3tFNY9rNPjP7UcwKae/X/qaTB+kCFHj2YY3O
         FxLkpxKXErkxtPeTk/3fRFJ8nmJgtY4UvBlyXxJkhv4ZyajCyuKj/q2wrVOJWdYg9znF
         k6ylBS7BJJFzbTwkg5o7GYURawK1GgqqYEo9u338ak25BAcMo3G3zrW3eB8LEXM6A1Lx
         yiza16XoKzw/M4C98azR3CQa3b1GY4vJa7dkxeUPpYhz3ikE7oPl7OtPsH1jyVx4JOHI
         0+3TTKFEEEESqY6kE5ePemesPRMdfKnVY9byviasKzKYzyyGI+uSULBvLr0R6q6KzXnz
         gf0A==
X-Gm-Message-State: APjAAAVp+nO394OgQv2U0iFQ8ifnP6vhRxOvjlP9jPAa8qJaJzdu1dT4
        fZVR5OjjjxrCZt//RXNiKY0=
X-Google-Smtp-Source: APXvYqwNCqHZUtjGmI9TrAMR34CKQKHPnkZA84l+jHJ/OlbTNgvZHFTPQM/arHMGr08VZPqQA+9mvQ==
X-Received: by 2002:adf:ef0f:: with SMTP id e15mr1873665wro.385.1570813729052;
        Fri, 11 Oct 2019 10:08:49 -0700 (PDT)
Received: from liskov.home (host109-157-47-110.range109-157.btcentralplus.com. [109.157.47.110])
        by smtp.gmail.com with ESMTPSA id o70sm12792801wme.29.2019.10.11.10.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:08:48 -0700 (PDT)
Subject: Re: [PATCH 01/11] graph: automatically track visible width of
 `strbuf`
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.383.git.gitgitgadget@gmail.com>
 <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
From:   James Coglan <jcoglan@gmail.com>
Message-ID: <16547350-2997-d250-d48b-43c6ae49b3c3@gmail.com>
Date:   Fri, 11 Oct 2019 18:08:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 10/10/2019 22:07, Johannes Schindelin wrote:
> Hi James,
> 
> On Thu, 10 Oct 2019, James Coglan via GitGitGadget wrote:
> 
>> From: James Coglan <jcoglan@gmail.com>
>>
>> All the output functions in `graph.c` currently keep track of how many
>> printable chars they've written to the buffer, before calling
>> `graph_pad_horizontally()` to pad the line with spaces. Some functions
>> do this by incrementing a counter whenever they write to the buffer, and
>> others do it by encoding an assumption about how many chars are written,
>> as in:
>>
>>     graph_pad_horizontally(graph, sb, graph->num_columns * 2);
>>
>> This adds a fair amount of noise to the functions' logic and is easily
>> broken if one forgets to increment the right counter or update the
>> calculations used for padding.
>>
>> To make this easier to use, I'm adding a `width` field to `strbuf` that
>> tracks the number of printing characters added after the line prefix.
> 
> This is a big heavy-handed: adding a `width` field to `struct strbuf`
> and maintaining it _just_ for the purpose of `graph.c` puts an
> unnecssary load on every other `strbuf` user (of which there are a
> _lot_).

I was anticipating there might be objections to modifying a widely used struct. There are other idea I had for solving this that I can share -- I'll post an alternative to this patch shortly that does not involve changing `strbuf`.
 
> So my obvious question is: what makes `width` different from `len`?
> Since we exclusively use ASCII characters for the graph part, we should
> be able to use the already-existing `len`, for free, no?

`len` counts the number of bytes in the buffer, which may include non-printing bytes used to apply color formatting. For padding graph lines, we need to know the number of display columns the buffer will use, and that's what `width` was added for.

> I could imagine that the `strbuf` might receive more than one line, but
> then we still would only need to remember the offset of the last newline
> character in that `strbuf`, no?

As far as I know, it does not contain multiple lines when used in graph.c, but I agree the implementation I've submitted here is obviously wrong if you wanted to use it to get the width of multi-line text. Putting code in strbuf that only works in graph.c and not more broadly was probably a mistake on my part.
> 
>> It's set to 0 at the start of `graph_next_line()`, and then various
>> `strbuf` functions update it as follows:
>>
>> - `strbuf_write_column()` increments `width` by 1
>>
>> - `strbuf_setlen()` changes `width` by the amount added to `len` if
>>   `len` is increased, or makes `width` and `len` the same if it's
>>   decreased
>>
>> - `strbuf_addch()` increments `width` by 1
>>
>> This is enough to ensure that the functions used by `graph.c` update
>> `strbuf->width` correctly, and `graph_pad_horizontally()` can then use
>> this field instead of taking `chars_written` as a parameter.
>>
>> Signed-off-by: James Coglan <jcoglan@gmail.com>
>> ---
>>  graph.c  | 68 ++++++++++++++++++++++----------------------------------
>>  strbuf.h |  8 ++++++-
>>  2 files changed, 33 insertions(+), 43 deletions(-)
>>
>> diff --git a/graph.c b/graph.c
>> index f53135485f..c56fdec1fc 100644
>> --- a/graph.c
>> +++ b/graph.c
>> @@ -115,11 +115,20 @@ static const char *column_get_color_code(unsigned short color)
>>  static void strbuf_write_column(struct strbuf *sb, const struct column *c,
>>  				char col_char)
>>  {
>> +	/*
>> +	 * Remember the buffer's width as we're about to add non-printing
>> +	 * content to it, and we want to avoid counting the byte length
>> +	 * of this content towards the buffer's visible width
>> +	 */
>> +	size_t prev_width = sb->width;
>> +
>>  	if (c->color < column_colors_max)
>>  		strbuf_addstr(sb, column_get_color_code(c->color));
>>  	strbuf_addch(sb, col_char);
>>  	if (c->color < column_colors_max)
>>  		strbuf_addstr(sb, column_get_color_code(column_colors_max));
>> +
>> +	sb->width = prev_width + 1;
>>  }
>>
>>  struct git_graph {
>> @@ -686,8 +695,7 @@ static int graph_is_mapping_correct(struct git_graph *graph)
>>  	return 1;
>>  }
>>
>> -static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb,
>> -				   int chars_written)
>> +static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb)
>>  {
>>  	/*
>>  	 * Add additional spaces to the end of the strbuf, so that all
>> @@ -696,8 +704,8 @@ static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb,
>>  	 * This way, fields printed to the right of the graph will remain
>>  	 * aligned for the entire commit.
>>  	 */
>> -	if (chars_written < graph->width)
>> -		strbuf_addchars(sb, ' ', graph->width - chars_written);
>> +	if (sb->width < graph->width)
>> +		strbuf_addchars(sb, ' ', graph->width - sb->width);
>>  }
>>
>>  static void graph_output_padding_line(struct git_graph *graph,
>> @@ -723,7 +731,7 @@ static void graph_output_padding_line(struct git_graph *graph,
>>  		strbuf_addch(sb, ' ');
>>  	}
>>
>> -	graph_pad_horizontally(graph, sb, graph->num_new_columns * 2);
>> +	graph_pad_horizontally(graph, sb);
>>  }
>>
>>
>> @@ -740,7 +748,7 @@ static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
>>  	 * of the graph is missing.
>>  	 */
>>  	strbuf_addstr(sb, "...");
>> -	graph_pad_horizontally(graph, sb, 3);
>> +	graph_pad_horizontally(graph, sb);
>>
>>  	if (graph->num_parents >= 3 &&
>>  	    graph->commit_index < (graph->num_columns - 1))
>> @@ -754,7 +762,6 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
>>  {
>>  	int num_expansion_rows;
>>  	int i, seen_this;
>> -	int chars_written;
>>
>>  	/*
>>  	 * This function formats a row that increases the space around a commit
>> @@ -777,14 +784,12 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
>>  	 * Output the row
>>  	 */
>>  	seen_this = 0;
>> -	chars_written = 0;
>>  	for (i = 0; i < graph->num_columns; i++) {
>>  		struct column *col = &graph->columns[i];
>>  		if (col->commit == graph->commit) {
>>  			seen_this = 1;
>>  			strbuf_write_column(sb, col, '|');
>>  			strbuf_addchars(sb, ' ', graph->expansion_row);
>> -			chars_written += 1 + graph->expansion_row;
>>  		} else if (seen_this && (graph->expansion_row == 0)) {
>>  			/*
>>  			 * This is the first line of the pre-commit output.
>> @@ -800,19 +805,15 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
>>  				strbuf_write_column(sb, col, '\\');
>>  			else
>>  				strbuf_write_column(sb, col, '|');
>> -			chars_written++;
>>  		} else if (seen_this && (graph->expansion_row > 0)) {
>>  			strbuf_write_column(sb, col, '\\');
>> -			chars_written++;
>>  		} else {
>>  			strbuf_write_column(sb, col, '|');
>> -			chars_written++;
>>  		}
>>  		strbuf_addch(sb, ' ');
>> -		chars_written++;
>>  	}
>>
>> -	graph_pad_horizontally(graph, sb, chars_written);
>> +	graph_pad_horizontally(graph, sb);
>>
>>  	/*
>>  	 * Increment graph->expansion_row,
>> @@ -842,11 +843,9 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
>>  }
>>
>>  /*
>> - * Draw the horizontal dashes of an octopus merge and return the number of
>> - * characters written.
>> + * Draw the horizontal dashes of an octopus merge.
>>   */
>> -static int graph_draw_octopus_merge(struct git_graph *graph,
>> -				    struct strbuf *sb)
>> +static void graph_draw_octopus_merge(struct git_graph *graph, struct strbuf *sb)
>>  {
>>  	/*
>>  	 * Here dashless_parents represents the number of parents which don't
>> @@ -890,13 +889,12 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
>>  		strbuf_write_column(sb, &graph->new_columns[i+first_col],
>>  				    i == dashful_parents-1 ? '.' : '-');
>>  	}
>> -	return 2 * dashful_parents;
>>  }
>>
>>  static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
>>  {
>>  	int seen_this = 0;
>> -	int i, chars_written;
>> +	int i;
>>
>>  	/*
>>  	 * Output the row containing this commit
>> @@ -906,7 +904,6 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
>>  	 * children that we have already processed.)
>>  	 */
>>  	seen_this = 0;
>> -	chars_written = 0;
>>  	for (i = 0; i <= graph->num_columns; i++) {
>>  		struct column *col = &graph->columns[i];
>>  		struct commit *col_commit;
>> @@ -921,14 +918,11 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
>>  		if (col_commit == graph->commit) {
>>  			seen_this = 1;
>>  			graph_output_commit_char(graph, sb);
>> -			chars_written++;
>>
>>  			if (graph->num_parents > 2)
>> -				chars_written += graph_draw_octopus_merge(graph,
>> -									  sb);
>> +				graph_draw_octopus_merge(graph, sb);
>>  		} else if (seen_this && (graph->num_parents > 2)) {
>>  			strbuf_write_column(sb, col, '\\');
>> -			chars_written++;
>>  		} else if (seen_this && (graph->num_parents == 2)) {
>>  			/*
>>  			 * This is a 2-way merge commit.
>> @@ -948,16 +942,13 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
>>  				strbuf_write_column(sb, col, '\\');
>>  			else
>>  				strbuf_write_column(sb, col, '|');
>> -			chars_written++;
>>  		} else {
>>  			strbuf_write_column(sb, col, '|');
>> -			chars_written++;
>>  		}
>>  		strbuf_addch(sb, ' ');
>> -		chars_written++;
>>  	}
>>
>> -	graph_pad_horizontally(graph, sb, chars_written);
>> +	graph_pad_horizontally(graph, sb);
>>
>>  	/*
>>  	 * Update graph->state
>> @@ -984,12 +975,11 @@ static struct column *find_new_column_by_commit(struct git_graph *graph,
>>  static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
>>  {
>>  	int seen_this = 0;
>> -	int i, j, chars_written;
>> +	int i, j;
>>
>>  	/*
>>  	 * Output the post-merge row
>>  	 */
>> -	chars_written = 0;
>>  	for (i = 0; i <= graph->num_columns; i++) {
>>  		struct column *col = &graph->columns[i];
>>  		struct commit *col_commit;
>> @@ -1017,7 +1007,6 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
>>  			assert(par_column);
>>
>>  			strbuf_write_column(sb, par_column, '|');
>> -			chars_written++;
>>  			for (j = 0; j < graph->num_parents - 1; j++) {
>>  				parents = next_interesting_parent(graph, parents);
>>  				assert(parents);
>> @@ -1026,19 +1015,16 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
>>  				strbuf_write_column(sb, par_column, '\\');
>>  				strbuf_addch(sb, ' ');
>>  			}
>> -			chars_written += j * 2;
>>  		} else if (seen_this) {
>>  			strbuf_write_column(sb, col, '\\');
>>  			strbuf_addch(sb, ' ');
>> -			chars_written += 2;
>>  		} else {
>>  			strbuf_write_column(sb, col, '|');
>>  			strbuf_addch(sb, ' ');
>> -			chars_written += 2;
>>  		}
>>  	}
>>
>> -	graph_pad_horizontally(graph, sb, chars_written);
>> +	graph_pad_horizontally(graph, sb);
>>
>>  	/*
>>  	 * Update graph->state
>> @@ -1181,7 +1167,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
>>  		}
>>  	}
>>
>> -	graph_pad_horizontally(graph, sb, graph->mapping_size);
>> +	graph_pad_horizontally(graph, sb);
>>
>>  	/*
>>  	 * Swap mapping and new_mapping
>> @@ -1199,6 +1185,8 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
>>
>>  int graph_next_line(struct git_graph *graph, struct strbuf *sb)
>>  {
>> +	sb->width = 0;
>> +
>>  	switch (graph->state) {
>>  	case GRAPH_PADDING:
>>  		graph_output_padding_line(graph, sb);
>> @@ -1227,7 +1215,6 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
>>  static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
>>  {
>>  	int i;
>> -	int chars_written = 0;
>>
>>  	if (graph->state != GRAPH_COMMIT) {
>>  		graph_next_line(graph, sb);
>> @@ -1245,19 +1232,16 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
>>  		struct column *col = &graph->columns[i];
>>
>>  		strbuf_write_column(sb, col, '|');
>> -		chars_written++;
>>
>>  		if (col->commit == graph->commit && graph->num_parents > 2) {
>>  			int len = (graph->num_parents - 2) * 2;
>>  			strbuf_addchars(sb, ' ', len);
>> -			chars_written += len;
>>  		} else {
>>  			strbuf_addch(sb, ' ');
>> -			chars_written++;
>>  		}
>>  	}
>>
>> -	graph_pad_horizontally(graph, sb, chars_written);
>> +	graph_pad_horizontally(graph, sb);
>>
>>  	/*
>>  	 * Update graph->prev_state since we have output a padding line
>> diff --git a/strbuf.h b/strbuf.h
>> index f62278a0be..3a98147321 100644
>> --- a/strbuf.h
>> +++ b/strbuf.h
>> @@ -66,11 +66,12 @@ struct string_list;
>>  struct strbuf {
>>  	size_t alloc;
>>  	size_t len;
>> +	size_t width;
>>  	char *buf;
>>  };
>>
>>  extern char strbuf_slopbuf[];
>> -#define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
>> +#define STRBUF_INIT  { .alloc = 0, .len = 0, .width = 0, .buf = strbuf_slopbuf }
>>
>>  /*
>>   * Predeclare this here, since cache.h includes this file before it defines the
>> @@ -161,6 +162,10 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
>>  {
>>  	if (len > (sb->alloc ? sb->alloc - 1 : 0))
>>  		die("BUG: strbuf_setlen() beyond buffer");
>> +	if (len > sb->len)
>> +		sb->width += len - sb->len;
>> +	else
>> +		sb->width = len;
>>  	sb->len = len;
>>  	if (sb->buf != strbuf_slopbuf)
>>  		sb->buf[len] = '\0';
>> @@ -231,6 +236,7 @@ static inline void strbuf_addch(struct strbuf *sb, int c)
>>  		strbuf_grow(sb, 1);
>>  	sb->buf[sb->len++] = c;
>>  	sb->buf[sb->len] = '\0';
>> +	sb->width++;
>>  }
>>
>>  /**
>> --
>> gitgitgadget
>>
>>
