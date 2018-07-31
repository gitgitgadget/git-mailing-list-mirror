Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CD191F597
	for <e@80x24.org>; Tue, 31 Jul 2018 00:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbeGaCJb (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 22:09:31 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:46663 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732009AbeGaCJb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 22:09:31 -0400
Received: by mail-ua0-f202.google.com with SMTP id g12-v6so4577482ual.13
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 17:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=WpcJ427qcsox9mSYy4gp4RVxIKKdzSA53wu+W95xtic=;
        b=tp7XWD2uAiV/OzXj/DISolagf2trb4lhq40+2Xk2vnKGfKq1hrrUu48kkqZwOeLzaE
         xKdRCDTBK9yh3ON8+TBb9llmg8B034jopqk8e2f2EmRGDLEc7grHKnvTKTaRI/tNZpWy
         hBnIOsyZ6fhbjaGYx0fyGWB2Szj+6oin2CsJ3+4qcCRn5nKrhB1LHgM85/Rhec6/6llH
         0EV9WrkjgNVPJ6tJV5m+mfPMgeKcRdv218mvFpcN5jLZmcidnpW3x97KVeu2OVQNq3nJ
         WTfKUbEhspYuk9EpPaMgaNa1sLlb2oEFWnsMc3iVhRQK33WGyxgAYDqg150yztLiev6E
         n5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=WpcJ427qcsox9mSYy4gp4RVxIKKdzSA53wu+W95xtic=;
        b=dATvuHmFU1ER8L+kRVG56YKinBcihsXQK29/Kt65pXrPin7SI/pC4HTJ969VHI5dv5
         ISpL1FiONoXGOlFMGBbQkgT8Nh0Ue80A1CF/QpiP/JIgf5Gqt1TWW6z6ip43pC2eVfKy
         VRPjC346kP1LLRV1v0BhL5I39KCz8qqQ0i6uMmaO2DNkazjpD47Uy29uoIMkiyk9haqY
         4wqLBvhaCBpXhPdta1i+jAUx+YfGel6DYlOveocx61lC8uFj93BUDws4YgkequY53/Q7
         HdEtDHI7X0DoPr4yvZrVWCzqgiVe172SbBNmZL97pgzCAECh62T/GcVKcRzLEv9LChOg
         chKA==
X-Gm-Message-State: AOUpUlGAc1DTlyFfm4uSw9tvLWH1JAWeoHrfzy4iAv1irY1EL5/CA1lL
        7hyLeLVL4FwGfoXDFiN8Ky/m3ogJ8Krz
X-Google-Smtp-Source: AAOMgpf1w9FUjsnGCqVieqybI/UPIglcd9eaUzdihlbXWIkyHkolHTW61tSww5vpQfCyBSxpYulsXP7qXXdA
MIME-Version: 1.0
X-Received: by 2002:a1f:73c1:: with SMTP id o184-v6mr9713485vkc.104.1532997119401;
 Mon, 30 Jul 2018 17:31:59 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:31:38 -0700
In-Reply-To: <20180731003141.105192-1-sbeller@google.com>
Message-Id: <20180731003141.105192-6-sbeller@google.com>
References: <20180728030448.192177-1-sbeller@google.com> <20180731003141.105192-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 5/8] diff.c: add set_sign to emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        sunshine@sunshineco.com
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
2.18.0.132.g195c49a2227

