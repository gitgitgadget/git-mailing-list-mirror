Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85AF51F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932973AbeFTUFo (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:05:44 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34000 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932958AbeFTUFm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:05:42 -0400
Received: by mail-oi0-f68.google.com with SMTP id i205-v6so773726oib.1
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 13:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xmdMJeUgEculr9KRo4hkLm+jA4I3fRVbjgnLPVDq8gI=;
        b=cMtOFDF0G4qbbKIMWMl9sLNabJ+rf1dvyXzZu0/eG0JB28T2Nbi+0x+/k4Hp0gfh6C
         Rb5MZp9rhwzioU2uHZKAxKT63VSOceJL+cfNPTgftsF/eUNOinTBzo+sxbzM6fJjK/Jn
         dq0MkIfOtZkxJ088ofuXNR5w7CKY3gTL9Xv4WFooOsk7hsA3didNaMk9j2aPMc/bzl1s
         RIy2OK2paKvYtMNWS+pzzMgIR8nw6sqeBAuI9MRkVamzMGwduGt4SJHOkduPE576dspd
         s5K6zb/eZbB1p9s4zxmxqw9+FTg5VpqFPdAWEGvZzhQBoahElqyizvwFPsdnlxyHA9UH
         YAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xmdMJeUgEculr9KRo4hkLm+jA4I3fRVbjgnLPVDq8gI=;
        b=idE6PqNUOgHaQidQiaiXEQz8kOQO/jLqZFWeBja+vJbWrmybxWYnxICMZk+O8WYs/k
         AbQRMkUHYbYjp/WTMKotvr9EMXviNs/XU763c1aEv0QcuI+Kms/+3jV+w9w6yjhgG/OY
         gMjI/oepnNRKpwuDTtql5fTWGVw0ECxQ2P8lamEEHSpYfGkW7UepQDdQVNfD9INrZAxP
         G6d/+VEycoYnPu89oyyd9u7tCAES6Ph7fV+BL/0QH/mOrGAXC7AYCXZoNHy9Hji7c6yc
         B2vbAijioSKB9LLKlAZSjGGuCna+lPZ0aar8Whnc0pzGLz5pkPcf4onh4QfGqi84aUY4
         Rq6Q==
X-Gm-Message-State: APt69E1MP6abvINNFbtbm86dJFqGlxA9TwA7EhRwAX0X1ZM2WW+i/MZj
        U8i3DJVjFUqT6FMtzbNJzTZmGtBodkc=
X-Google-Smtp-Source: ADUXVKKmwf4sJlg+5b1iATq1ujFHxXgpk88lcEGARCOlma9M87GjqfzbOUJF/ABT31A6krfyOBuhmQ==
X-Received: by 2002:aca:fdcb:: with SMTP id b194-v6mr11729152oii.24.1529525141404;
        Wed, 20 Jun 2018 13:05:41 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id b4-v6sm1434728otf.79.2018.06.20.13.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 13:05:40 -0700 (PDT)
Date:   Wed, 20 Jun 2018 15:05:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v2 3/7] grep.[ch]: extend grep_opt to allow showing matched
 column
Message-ID: <d66124e7930b0e70628b3359378aeff26f9732ac.1529524852.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529524852.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529524852.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To support showing the matched column when calling 'git-grep(1)', teach
'grep_opt' the normal set of options to configure the default behavior
and colorization of this feature.

Now that we have opt->columnnum, use it to disable short-circuiting over
ORs so that col and icol are always filled with the earliest matches on
each line. In addition, don't return the first match from match_line(),
for the same reason.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 33 +++++++++++++++++++++++++++------
 grep.h |  2 ++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/grep.c b/grep.c
index dedfe17f93..d56d4a3a37 100644
--- a/grep.c
+++ b/grep.c
@@ -46,6 +46,7 @@ void init_grep_defaults(void)
 	color_set(opt->color_filename, "");
 	color_set(opt->color_function, "");
 	color_set(opt->color_lineno, "");
+	color_set(opt->color_columnno, "");
 	color_set(opt->color_match_context, GIT_COLOR_BOLD_RED);
 	color_set(opt->color_match_selected, GIT_COLOR_BOLD_RED);
 	color_set(opt->color_selected, "");
@@ -155,6 +156,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->extended_regexp_option = def->extended_regexp_option;
 	opt->pattern_type_option = def->pattern_type_option;
 	opt->linenum = def->linenum;
+	opt->columnnum = def->columnnum;
 	opt->max_depth = def->max_depth;
 	opt->pathname = def->pathname;
 	opt->relative = def->relative;
@@ -164,6 +166,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	color_set(opt->color_filename, def->color_filename);
 	color_set(opt->color_function, def->color_function);
 	color_set(opt->color_lineno, def->color_lineno);
+	color_set(opt->color_columnno, def->color_columnno);
 	color_set(opt->color_match_context, def->color_match_context);
 	color_set(opt->color_match_selected, def->color_match_selected);
 	color_set(opt->color_selected, def->color_selected);
@@ -1284,16 +1287,23 @@ static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x, char *bol,
 				    icol, 0);
 		break;
 	case GREP_NODE_OR:
-		if (!collect_hits)
+		if (!(collect_hits || opt->columnnum)) {
+			/*
+			 * Don't short-circuit OR when given --column (or
+			 * collecting hits) to ensure we don't skip a later
+			 * child that would produce an earlier match.
+			 */
 			return (match_expr_eval(opt, x->u.binary.left, bol, eol,
 						ctx, col, icol, 0) ||
 				match_expr_eval(opt, x->u.binary.right, bol,
 						eol, ctx, col, icol, 0));
+		}
 		h = match_expr_eval(opt, x->u.binary.left, bol, eol, ctx, col,
 				    icol, 0);
-		x->u.binary.left->hit |= h;
+		if (collect_hits)
+			x->u.binary.left->hit |= h;
 		h |= match_expr_eval(opt, x->u.binary.right, bol, eol, ctx, col,
-				     icol, 1);
+				     icol, collect_hits);
 		break;
 	default:
 		die("Unexpected node type (internal error) %d", x->node);
@@ -1316,6 +1326,7 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
 		      enum grep_context ctx, int collect_hits)
 {
 	struct grep_pat *p;
+	int hit = 0;
 
 	if (opt->extended)
 		return match_expr(opt, bol, eol, ctx, col, icol,
@@ -1325,11 +1336,21 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
 	for (p = opt->pattern_list; p; p = p->next) {
 		regmatch_t tmp;
 		if (match_one_pattern(p, bol, eol, ctx, &tmp, 0)) {
-			*col = tmp.rm_so;
-			return 1;
+			hit |= 1;
+			if (!opt->columnnum) {
+				/*
+				 * Without --column, any single match on a line
+				 * is enough to know that it needs to be
+				 * printed. With --column, scan _all_ patterns
+				 * to find the earliest.
+				 */
+				break;
+			}
+			if (*col < 0 || tmp.rm_so < *col)
+				*col = tmp.rm_so;
 		}
 	}
-	return 0;
+	return hit;
 }
 
 static int match_next_pattern(struct grep_pat *p, char *bol, char *eol,
diff --git a/grep.h b/grep.h
index 399381c908..08a0b391c5 100644
--- a/grep.h
+++ b/grep.h
@@ -127,6 +127,7 @@ struct grep_opt {
 	int prefix_length;
 	regex_t regexp;
 	int linenum;
+	int columnnum;
 	int invert;
 	int ignore_case;
 	int status_only;
@@ -159,6 +160,7 @@ struct grep_opt {
 	char color_filename[COLOR_MAXLEN];
 	char color_function[COLOR_MAXLEN];
 	char color_lineno[COLOR_MAXLEN];
+	char color_columnno[COLOR_MAXLEN];
 	char color_match_context[COLOR_MAXLEN];
 	char color_match_selected[COLOR_MAXLEN];
 	char color_selected[COLOR_MAXLEN];
-- 
2.17.0.582.gccdcbd54c

