Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D664D1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbeGJSpw (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:45:52 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:43056 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732417AbeGJSpv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:45:51 -0400
Received: by mail-qt0-f202.google.com with SMTP id d25-v6so24430102qtp.10
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=kFFKhDIitJP3vLfeWg+pHOu87RYw70sLnUXIWrTIXHI=;
        b=gyMFiOsmJSLP/FVgaGlaPeNnZiqWOQdvHdm9jWG0R/+ekoCkDR8WFEl7UWDRe8ZKzr
         M6pyUwNkbRKQHUpDCHsnydIKg/LoOdp8soIaZ9W4r9ahH1Cvn9fPxg4rLbdDK2yj0KZa
         Za0SdeuvG7ITv4NKvSMkp2Cq+nVYcJztd2DEe87MQYDwav3TWE1mwM2IRikku0OkYb9u
         k8NBx4Y7FYF+cVrjDkCa0xxD9bkoWoI4uIpbmhN6KVtk4kndezCXMXuTkIt2nfMhZIaL
         G7ahzZ0c714DSlDiVoxxQ03sJMkC7z4xlOk3umOIPODFGv8gKGgerSouVxSwgPYGneMR
         xCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=kFFKhDIitJP3vLfeWg+pHOu87RYw70sLnUXIWrTIXHI=;
        b=msjg2P6S6rq6xy0S2mz4RvKArkUZ/zM64/KUEdoOoLaYXvKKVCWzf9q8h+a99mNVnV
         ZWMsP19qlRDCaO1RSuEW2+fsC1jC/uqEWzGoV7y9qLmlDY9lQHCnUthNw0dBl2H2Cx9g
         KSF6yXcNhXKZCT0v2Q0Di9Xq+YNFTEGms/l7tqidSny/DXzVIPGXXy632XvkkQj0rAA0
         EWyfkKXAxq9sNu/uPUOjyOq6SpcJOtLAeZtx/OFlPI6vbOjPcKLLrnonZsDdE8Qbh8Pw
         +YTCS9d4sveR1cStpSWj8MWd3y5wJ8qUbRByBOo+avMZcuFRkbqhmjDqZmIKqOPAASDQ
         qvCA==
X-Gm-Message-State: AOUpUlG1upbjOsrIPTHj+5pRWal1uKRHfbApwT3GTU1qcIuPumqWVRWh
        ArtCUXPkw4cA+G4ljqLDHpX9heotoqO6
X-Google-Smtp-Source: AAOMgpcRzttte1HLw63Jg4Z3fi+LZoCHElHMB8uBGGKOsVtQgXqiunLbPr3+Vi17b0vRcQMlUVnMvexannOn
MIME-Version: 1.0
X-Received: by 2002:a0c:d7c5:: with SMTP id g5-v6mr9970607qvj.0.1531244762726;
 Tue, 10 Jul 2018 10:46:02 -0700 (PDT)
Date:   Tue, 10 Jul 2018 10:45:51 -0700
In-Reply-To: <20180710174552.30123-1-sbeller@google.com>
Message-Id: <20180710174552.30123-2-sbeller@google.com>
References: <CAGZ79kb4RS-KxEX+x07XsFiGwgG+1AiRUha=zcxexe1=RLL8kg@mail.gmail.com>
 <20180710174552.30123-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 1/2] diff.c: convert emit_line_ws_markup to take string for sign
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the diff of diffs, we have more than one character at the beginning
of the line with special meaning, so let's pass around a string that
contains all the markup for the line

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 32500716740..028d7d9a59c 100644
--- a/diff.c
+++ b/diff.c
@@ -969,7 +969,7 @@ static void dim_moved_lines(struct diff_options *o)
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set, const char *reset,
 				const char *line, int len,
-				const char *set_sign, char sign,
+				const char *set_sign, const char *sign,
 				unsigned ws_rule, int blank_at_eof)
 {
 	const char *ws = NULL;
@@ -981,19 +981,19 @@ static void emit_line_ws_markup(struct diff_options *o,
 	}
 
 	if (!ws && !set_sign)
-		emit_line_0(o, set, 0, reset, sign, line, len);
+		emit_line_0(o, set, 0, reset, sign[0], line, len);
 	else if (!ws) {
 		/* Emit just the prefix, then the rest. */
 		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
-			    sign, "", 0);
+			    sign[0], "", 0);
 		emit_line_0(o, set, 0, reset, 0, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(o, ws, 0, reset, sign, line, len);
+		emit_line_0(o, ws, 0, reset, sign[0], line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
 		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
-			    sign, "", 0);
+			    sign[0], "", 0);
 		ws_check_emit(line, len, ws_rule,
 			      o->file, set, reset, ws);
 	}
@@ -1054,7 +1054,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else if (c == '-')
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, ' ',
+		emit_line_ws_markup(o, set, reset, line, len, set_sign, " ",
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1100,7 +1100,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				len--;
 			}
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
+		emit_line_ws_markup(o, set, reset, line, len, set_sign, "+",
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1141,7 +1141,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else if (c != '-')
 				set = diff_get_color_opt(o, DIFF_CONTEXT);
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, '-',
+		emit_line_ws_markup(o, set, reset, line, len, set_sign, "-",
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
-- 
2.18.0.203.gfac676dfb9-goog

