Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D13CC1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 01:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbeHNE0b (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 00:26:31 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:49686 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeHNE0b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 00:26:31 -0400
Received: by mail-qt0-f202.google.com with SMTP id b8-v6so14590310qto.16
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 18:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SaAgV1a4GiL4Uoc0LX3SdR+qmnCQKuEtdm2W1CsBQQw=;
        b=LajyXNJ/CTHYinKZQx4hZg26QLKx2dYo0CFWtOssca82O2kWifgBoAGOLy1MC180eM
         xUJwy2oK0L3cxS43zTJlNUFn2SqkMjXL3WMuXwyMOlJzWHSoFigJSaUlDP9IIRlghlCd
         gfWnCxXftKQqa9AtcCajisyHrWLyul73Zr46YFUJWG7zXDT2g9B8rOIOPVpGUvgETG1L
         Ds0zZeQxSSQKYLsL6JLiGby+Hy49jvrjHOa/JDzBZ2lx0bSpdsN9Kv6uvEa0qFFU6E/7
         QC2MeQ7HmRWpCX/wJ4azxtwM9qeu0O2Qx2lJFkBrQe69RciUbzCmgKRtcQzvAPH9bbJU
         gDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SaAgV1a4GiL4Uoc0LX3SdR+qmnCQKuEtdm2W1CsBQQw=;
        b=kM7PdIVqU6tkO06NVStRmr0B6GPYfdlYnMWAgb3hVZREeR24GS85k14JRrL8pAAXoz
         64mgLMIQYICw7CtU24zHx99K2b6EqSuhOBfHt3QG0QLZ3xRQlFoGJG/x4BabVc/P49q3
         o2+Acwey5yQwSa1fTgWI8FeVEhx4fTN+l5P8m92+mG5FANY/cNLj5LhYPMoqV5dfbC4J
         KCeBUNH/GnExIv5DW6NBK4RtTA50jD4PE9z5iWiYPTW95r8oJvk96a1Zm3ZXEyARnVUS
         p2Pl+ahPFbzx6ZdPWl3SN7I474/KeefBzTySnYzW4J13OVTVKjO9CJRYGZ2wz0Sn4zKB
         bcVQ==
X-Gm-Message-State: AOUpUlFFTd2NKHcTEiwmf2nCAGrMT0meC2/Rg3FUZIQjpwga5JrGXG44
        fIijD65i1h7a2l/hMV8Hj4o9oel/BRCh
X-Google-Smtp-Source: AA+uWPyhzzqeyhR1QqVJVIo1fc3vqIlWRVd3cRYa4Ys7dQqAebpkk+5ikCsemFHwOItZf5dtEs4QdeFOT+rz
X-Received: by 2002:a0c:e848:: with SMTP id l8-v6mr10597032qvo.1.1534210900319;
 Mon, 13 Aug 2018 18:41:40 -0700 (PDT)
Date:   Mon, 13 Aug 2018 18:41:18 -0700
In-Reply-To: <20180814014122.30662-1-sbeller@google.com>
Message-Id: <20180814014122.30662-5-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com> <20180814014122.30662-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 4/8] diff.c: reorder arguments for emit_line_ws_markup
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The order shall be all colors first, then the content, flags at the end.
The colors are in the order of occurrence, i.e. first the color for the
sign and then the color for the rest of the line.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index f6df18af913..ab6e6a88a56 100644
--- a/diff.c
+++ b/diff.c
@@ -1185,9 +1185,9 @@ static void dim_moved_lines(struct diff_options *o)
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
@@ -1271,7 +1271,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else if (c == '-')
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, ' ',
+		emit_line_ws_markup(o, set_sign, set, reset, ' ', line, len,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1314,7 +1314,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
 			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
+		emit_line_ws_markup(o, set_sign, set, reset, '+', line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1357,7 +1357,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else
 				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, '-',
+		emit_line_ws_markup(o, set_sign, set, reset, '-', line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
-- 
2.18.0.865.gffc8e1a3cd6-goog

