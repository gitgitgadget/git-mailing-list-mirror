Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813641F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeHKBGr (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:06:47 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:43547 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKBGr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:06:47 -0400
Received: by mail-oi0-f74.google.com with SMTP id e23-v6so10695498oii.10
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TZeBD+5uMv4WiYmea7yNQf4Fpo3+y3iHkqpoMAOicpI=;
        b=Z7OolZIzC14fIK8nnb7c5coe1MPlSmK3Kv5/6p2hZSqY76vj/fhSXvGRhNU7zpUM3M
         2r1ZGIbxhqMfNGlHwo7Lq/b8FV+mUoKrGsWIt9iAMirHGIGCbsirErIpi8uEmkWka6x+
         U/8mo/+++uhJf9xfPxCB4nMF2HGlW0zrxsxwEcclT/m0xX1hVd2FtRW2PQQT2mhQTkSG
         lh7oQtGSSmzL8YjeDAWUcBkkUjKkizRRjDfyQhGWe9uAMDRKB/A7FistjKi/eMJ5zrWW
         QDdN31vCu5ghuVhEqwSzjmgapPc0n/9funXRbgtAWBcE5BH/d3Q3U+Yox/YrCxfBHQvA
         b5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TZeBD+5uMv4WiYmea7yNQf4Fpo3+y3iHkqpoMAOicpI=;
        b=fjTbMU3fduH2+QOExji6jvVuFvrU3CTbr48dCnilTqDFJL9NqZ6Ur+Lgz6gFMbS0eT
         Eu6QSeZM4cn21dl8XOiqmqpJukv/srdJPWibW2QyUWBwYzEIf83wIpI5p+ZeksU+7hnZ
         7DeZz5wd9W7vNiL5pkNtsnLyJnw60zKDQmuJYECNKjAxvgN/yx7brf8HTChOV1nXOc99
         EPNVnTGisV4xvuh7Z7LleLHqGvDGI1jYaPdVCEq2wixIAFgTZDteMkB1YVWGIYjVb8NS
         vPzHwJd+PgHIjxkMsJ0ZKpk8AipuiSxkTzLisqv/ZCSqPtdHcKh39tBXzlWwaqg1iAbI
         UQVQ==
X-Gm-Message-State: AOUpUlHvBf7b5uewMweaX8xHLdejGlR0MPoHojq8Fqtds5KeIHUwRzVy
        UouOznt0LP+w10HC9UWq0fAi9kW5Jml+
X-Google-Smtp-Source: AA+uWPz8/2rhzjzNkcAb8zHwNQ8TjcamdiFNZm0JI2RQZgOJOQh5awvfk8p/LNusxnBw2kTDr32ApneJQkcR
X-Received: by 2002:aca:d98a:: with SMTP id q132-v6mr4596730oig.39.1533940497772;
 Fri, 10 Aug 2018 15:34:57 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:34:38 -0700
In-Reply-To: <20180810223441.30428-1-sbeller@google.com>
Message-Id: <20180810223441.30428-6-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 5/8] diff.c: add set_sign to emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For now just change the signature, we'll reason about the actual
change in a follow up patch.

Pass 'set_sign' (which is output before the sign) and 'set' which
controls the color after the first character. Hence, promote any
'set's to 'set_sign' as we want to have color before the sign
for now.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index ab6e6a88a56..5eea5edca50 100644
--- a/diff.c
+++ b/diff.c
@@ -622,7 +622,7 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 }
 
 static void emit_line_0(struct diff_options *o,
-			const char *set, unsigned reverse, const char *reset,
+			const char *set_sign, const char *set, unsigned reverse, const char *reset,
 			int first, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
@@ -652,9 +652,12 @@ static void emit_line_0(struct diff_options *o,
 	if (len || !nofirst) {
 		if (reverse && want_color(o->use_color))
 			fputs(GIT_COLOR_REVERSE, file);
-		fputs(set, file);
+		if (set_sign && set_sign[0])
+			fputs(set_sign, file);
 		if (first && !nofirst)
 			fputc(first, file);
+		if (set)
+			fputs(set, file);
 		fwrite(line, len, 1, file);
 		fputs(reset, file);
 	}
@@ -667,7 +670,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, 0, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, NULL, 0, reset, line[0], line+1, len-1);
 }
 
 enum diff_symbol {
@@ -1199,17 +1202,17 @@ static void emit_line_ws_markup(struct diff_options *o,
 	}
 
 	if (!ws && !set_sign)
-		emit_line_0(o, set, 0, reset, sign, line, len);
+		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
 	else if (!ws) {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign, !!set_sign, reset, sign, "", 0);
-		emit_line_0(o, set, 0, reset, 0, line, len);
+		emit_line_0(o, set_sign, NULL, !!set_sign, reset, sign, "", 0);
+		emit_line_0(o, set, NULL, 0, reset, 0, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(o, ws, 0, reset, sign, line, len);
+		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
+		emit_line_0(o, set_sign ? set_sign : set, NULL, !!set_sign, reset,
 			    sign, "", 0);
 		ws_check_emit(line, len, ws_rule,
 			      o->file, set, reset, ws);
@@ -1233,7 +1236,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, 0, reset, '\\',
+		emit_line_0(o, context, NULL, 0, reset, '\\',
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
-- 
2.18.0.865.gffc8e1a3cd6-goog

