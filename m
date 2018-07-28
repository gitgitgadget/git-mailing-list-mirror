Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDAC51F597
	for <e@80x24.org>; Sat, 28 Jul 2018 03:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbeG1E3u (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 00:29:50 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:50980 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeG1E3u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 00:29:50 -0400
Received: by mail-it0-f73.google.com with SMTP id n194-v6so2496066itn.0
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 20:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v+yeUkmHBXsc+FQ3n9HeIzUgf+21mv84KrANq6ANlgw=;
        b=aDGv/OSUjiubnE6EXNfm6CVcp80QwWj7sZJrZmKAsRbswr+gPtPczlmRjjlWFspnCd
         K9vYiPXzyMcGVVCfPMbyRv+Om7htnngVsqs0I09wmLzeG2KLDzyJXYR1clNzAXlCiJKn
         fvn679R0i1ly30Mf6IG4ZvoExgzdk+sHei6nwsa/nhHLWFeK9g63z94j7cb4P7ryodyS
         J+HKdCLQPY6t0GJ/emV5DOuKnqyNAD01PGJqKz5AvyG6zKoSJp2tHhcRwGQH68g6I1ol
         VbT6bvU8hqCJI+zTi/kGyI/vWwKN5M/w8uGcFeZxHBRGJYh53RGRWDZ9IGxnPyZGcTJN
         HFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v+yeUkmHBXsc+FQ3n9HeIzUgf+21mv84KrANq6ANlgw=;
        b=Q/+EdAIColcPKQlOxbHNaQ/+pa1xBnlt3LrBaEpUVby0rwgXCWh6OQNtQeWPivfHu1
         4sMLtKQ7/iYyxzhi2t0fMwQxyIzLvutura01H8uoxkj9P/r4QhlMOn01RGCn3iFLmzf5
         26ERqkkhGu/rXPX+s+j26Bs1Am/mwNywyYuWfYm0U7vRSyjGV/7HWAahTnSSn6KLBqFY
         +4UYG2wSGcZV3IOxTbp8+JI1qtHP03k7y+33Clb0tDuLwixlj7bqiyrCwmitGkPITruG
         WrxQftj2bA+LkUjJSKVu+JaVeVyao5eKdgt6AAHrAdKTplTBlT+vWYxb/DRQklSWKRGb
         glMg==
X-Gm-Message-State: AOUpUlE3PlM/59Uz2yjWMBmk+fTrYg7QfsK/GzQBjOYtNoLR05FHiCbK
        PeMNFjr+qGuNXS+kh1zRtsVw/Tw+p7EcDAbuWuCANhyPsdZ909mbwerI5XcPWFIo2Wkcb5rCooP
        /y3hqGn4zY9kmfZvp8ZdQeWfytotRx7i3ZZxOzMQL0f8yvJ/bU3UJ2mu2yFDx
X-Google-Smtp-Source: AAOMgpddd0tRn56VCIas+fHBqg7IV5gipIeXoyasOUx617gG/Z43TfMrNiVgQqLlHYO/h/WpjNSPNziAOx3J
X-Received: by 2002:a24:5353:: with SMTP id n80-v6mr4217944itb.6.1532747104503;
 Fri, 27 Jul 2018 20:05:04 -0700 (PDT)
Date:   Fri, 27 Jul 2018 20:04:45 -0700
In-Reply-To: <20180728030448.192177-1-sbeller@google.com>
Message-Id: <20180728030448.192177-6-sbeller@google.com>
Mime-Version: 1.0
References: <20180728030448.192177-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 5/8] diff.c: add set_sign to emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For now just change the signature, we'll reason about the actual
change in a follow up patch.

Pass set_sign (which is output before the sign) and set that is setting
the color after the sign. Hence, promote any 'set's to set_sign as
we want to have color before the sign for now.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 8fd2171d808..a36ed92c54c 100644
--- a/diff.c
+++ b/diff.c
@@ -576,7 +576,7 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 }
 
 static void emit_line_0(struct diff_options *o,
-			const char *set, unsigned reverse, const char *reset,
+			const char *set_sign, const char *set, unsigned reverse, const char *reset,
 			int first, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
@@ -606,9 +606,12 @@ static void emit_line_0(struct diff_options *o,
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
@@ -621,7 +624,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, 0, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, NULL, 0, reset, line[0], line+1, len-1);
 }
 
 enum diff_symbol {
@@ -994,17 +997,17 @@ static void emit_line_ws_markup(struct diff_options *o,
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
@@ -1028,7 +1031,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, 0, reset, '\\',
+		emit_line_0(o, context, NULL, 0, reset, '\\',
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
-- 
2.18.0.345.g5c9ce644c3-goog

