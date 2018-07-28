Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EECBC1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 03:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeG1E3s (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 00:29:48 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:56480 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeG1E3s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 00:29:48 -0400
Received: by mail-yb0-f201.google.com with SMTP id e6-v6so3475472ybk.23
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 20:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HTvfVXzmYRO0ga3wnWW8Zh8lJXJzNWiSP5Km1N36WIE=;
        b=jGxes+Snl3qBLUQoVwNhwMu9b80JDR16TLN5nTP42Z25RNwpDtWedm0tVn3Sa6d83M
         kymA8VFi507GZGyFiJmQAmcSrXtAEKZPMn8xJW61UAhN9/inMDsjJsS0x+etUAz4Vpkr
         v8ab4HKGCtaQDT9txOqfccQRq0uBEdbsE6Pdx5MDtEXGjHQMHZkdQlBpbvF8W0xBkRLr
         us+XXlOQhObwUnqXeQq59G7eoQnNyFkprLH63+nxVCndO5hbL9SLMLFsXOiJnIdnHsD3
         2G2ys1sqVQmhSrnkp2lljhSSOoK/CXqXa02k9dRH7dYQzFMMoTqM62vADK5wtgJSla0L
         NvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HTvfVXzmYRO0ga3wnWW8Zh8lJXJzNWiSP5Km1N36WIE=;
        b=kQciCL1DxHMRgVZiwRWaQbjv53w07SG4sSyveYDWWQtMwDGBhtZUkq4aHwsj4LEglZ
         t0lA9TeMnpm3gvsAUo5oSrcFTdnYH9I8oGS6WgFgnUoWoYNF2wwL+OvwGvguMYxY8rXx
         VMSMjYtMbyZ8Pr3QfWfUG2mLQ+/AupAtjBLyXMlChM9Lkag7bUonexX5MXtNEyBbUxvc
         45KkS7/VYbz4Mp9cG0TfGLrG9Bylz387+AA8dZHWLl0Zq+EXYKQ4K2u4wV9clLVJLcXI
         rKPj2kRf1e75s3LHzEElqW02No8aWuzFOOuecgUZxigRYUmXbqJMmg9DHRXtovs3cszR
         IuiQ==
X-Gm-Message-State: AOUpUlGkHljRK6nyU/xLNGNYfwzZNQpc/O/r1rcGpE9gQ7/juqMZFuMx
        JsOs0wUAOS3EkoCt+DGGeJ345MiAH6FwUKUTPzWJnobnBByPbqaKzreTWCNGkGJ6rmQdScVBLRq
        1iLMssEiDBorofgaC78OQrp0nGe+kfDWBzNUjbYWI5foHwp0Anpu4sH+qXkPi
X-Google-Smtp-Source: AAOMgpc0BMz6rHD1/AXKDtzNgyp0LshAhIpW2iR+8lqtTkaiHD5IAeLX7LhEwQ75Z/ljqoX0oQea1E0nP6TN
X-Received: by 2002:a81:4fce:: with SMTP id d197-v6mr2667696ywb.178.1532747102248;
 Fri, 27 Jul 2018 20:05:02 -0700 (PDT)
Date:   Fri, 27 Jul 2018 20:04:44 -0700
In-Reply-To: <20180728030448.192177-1-sbeller@google.com>
Message-Id: <20180728030448.192177-5-sbeller@google.com>
Mime-Version: 1.0
References: <20180728030448.192177-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 4/8] diff.c: reorder arguments for emit_line_ws_markup
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The order shall be all colors first, then the content, flags at the end.
The colors are in order.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index f7251c89cbb..8fd2171d808 100644
--- a/diff.c
+++ b/diff.c
@@ -980,9 +980,9 @@ static void dim_moved_lines(struct diff_options *o)
 }
 
 static void emit_line_ws_markup(struct diff_options *o,
-				const char *set, const char *reset,
-				const char *line, int len,
-				const char *set_sign, char sign,
+				const char *set_sign, const char *set,
+				const char *reset,
+				char sign, const char *line, int len,
 				unsigned ws_rule, int blank_at_eof)
 {
 	const char *ws = NULL;
@@ -1066,7 +1066,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else if (c == '-')
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, ' ',
+		emit_line_ws_markup(o, set_sign, set, reset, ' ', line, len,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1109,7 +1109,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
 			flags |= WS_IGNORE_FIRST_SPACE;
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
+		emit_line_ws_markup(o, set_sign, set, reset, '+', line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1152,7 +1152,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else
 				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, '-',
+		emit_line_ws_markup(o, set_sign, set, reset, '-', line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
-- 
2.18.0.345.g5c9ce644c3-goog

