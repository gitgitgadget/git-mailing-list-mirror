Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646CA201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbdF3Uxj (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:39 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36502 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753066AbdF3Uxg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:36 -0400
Received: by mail-pf0-f170.google.com with SMTP id q86so72399011pfl.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wz3+ygNjCIs8sVknYTnFQ56NbzgzTxHIn20tg/4TMrk=;
        b=buTJKuPvBsSOIWBOior4+IdkFeY2Yx7fMpZDNli1kO5Eo09/umRpqCpPi2Oyzx8UbH
         mxexPvEqv4G8zHElXUeJLLy80Hw8PaVdCqDMVi2iulr8h+l4NtYj7JPMtcY0qk1f4vhR
         XBIFDUEUh0Y6nte1xFpM8HIKZm2UFIlUWpZY85BMqGu7Gy/aEB/i4bM5rF+bO05LNVWF
         QZF2NLN+wBko7GZcuUULfeBHHDBNyiXTvdrc7xregnCCzjdk4kTmP0xzrzyJJhDyErxf
         qcGboO0ttZB6VVPuTeEOFsrzGnkBhKl4T0So/XgTHjTdZaogRs+Vw+JEYU2hOV5GhzZg
         B6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wz3+ygNjCIs8sVknYTnFQ56NbzgzTxHIn20tg/4TMrk=;
        b=LfojK5DHWMrNNsc3gCNSDL/R2cwcdZd7838JldsJdaqzf8xqgTltFO/Z+6aaHDY65a
         NMnG725g4+dCE9imYeDeRAUHKAEn0tcSty75ln8CKqOVY32CjXwxmSCwizez2IWQ1+ou
         v3pdSy85/vy7ibIIx+1/TT55Y6T3bNjmMrblwz86dXjMDqavOq9DLrGnp2itdJ3xKmP0
         30anW2oh8FfwQaV87DG8WtK9y3JzyaAxTdECWCqZ7cKxS7iAs14d0jtW0wuEPbj2Jhw+
         so5jFkGgkGij4Ohl+TZl9VyzQykpTPZQ2FW+JJHDgC15TGaqwFWSdHwXbMBwzCtvbjvR
         quTA==
X-Gm-Message-State: AKS2vOwQteQqwtfYzhhnVNzMHdKMI+yxGf93pc41qPUz7KWlku3VnubA
        B6H3mv/N257lP/un
X-Received: by 10.98.7.11 with SMTP id b11mr24753387pfd.188.1498856005628;
        Fri, 30 Jun 2017 13:53:25 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id k129sm20252645pfc.87.2017.06.30.13.53.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 09/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS[_PORCELAIN]
Date:   Fri, 30 Jun 2017 13:52:54 -0700
Message-Id: <20170630205310.7380-10-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index e5430d56da..85bfd9310d 100644
--- a/diff.c
+++ b/diff.c
@@ -561,6 +561,8 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_WORDS_PORCELAIN,
+	DIFF_SYMBOL_WORDS,
 	DIFF_SYMBOL_CONTEXT,
 	DIFF_SYMBOL_PLUS,
 	DIFF_SYMBOL_MINUS,
@@ -649,6 +651,26 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 		emit_line_ws_markup(o, set, reset, line, len, '-',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
+	case DIFF_SYMBOL_WORDS_PORCELAIN:
+		context = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line(o, context, reset, line, len);
+		fputs("~\n", o->file);
+		break;
+	case DIFF_SYMBOL_WORDS:
+		context = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		/*
+		 * Skip the prefix character, if any.  With
+		 * diff_suppress_blank_empty, there may be
+		 * none.
+		 */
+		if (line[0] != '\n') {
+			line++;
+			len--;
+		}
+		emit_line(o, context, reset, line, len);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -1342,7 +1364,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	struct emit_callback *ecbdata = priv;
 	const char *meta = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
-	const char *context = diff_get_color(ecbdata->color_diff, DIFF_CONTEXT);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
 	const char *line_prefix = diff_line_prefix(o);
@@ -1384,6 +1405,9 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 
 	if (ecbdata->diff_words) {
+		enum diff_symbol s =
+			ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN ?
+			DIFF_SYMBOL_WORDS_PORCELAIN : DIFF_SYMBOL_WORDS;
 		if (line[0] == '-') {
 			diff_words_append(line, len,
 					  &ecbdata->diff_words->minus);
@@ -1403,21 +1427,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			return;
 		}
 		diff_words_flush(ecbdata);
-		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
-			emit_line(o, context, reset, line, len);
-			fputs("~\n", o->file);
-		} else {
-			/*
-			 * Skip the prefix character, if any.  With
-			 * diff_suppress_blank_empty, there may be
-			 * none.
-			 */
-			if (line[0] != '\n') {
-			      line++;
-			      len--;
-			}
-			emit_line(o, context, reset, line, len);
-		}
+		emit_diff_symbol(o, s, line, len, 0);
 		return;
 	}
 
-- 
2.13.0.31.g9b732c453e

