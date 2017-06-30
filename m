Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D72F201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbdF3Ux0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:26 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33292 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbdF3UxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:24 -0400
Received: by mail-pg0-f42.google.com with SMTP id f127so68712095pgc.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gIoTZtAiyZKiIQ5V8CTyOrTgFbsDn7OEWnz1ZDQkBbg=;
        b=nZm4Km8kk7s/RuxSzCtsnS6Rmb8UmSifYThWrPj0MiZvh6qf6Y83ZwqsOOBOenPMeA
         eCFKmeEYnU4UmuwEi5f0XTeKfOn9rHbfsuSFhiqpEsO3xGKb8pFJb0wd1o8/OcyrRKEJ
         /K9d2PXPGqezk7FpCDzMaOixlUfdv3bRhOuaYZ3Vbc9xLaPuq/HWPweX6Ww8YPm9BmKd
         u6nGnTiWxogDy10fGK1NZsegk3sgpQzi0J0/UPUjggP6KVbwPb+TlFq5f/8DsRC5PRje
         kvVMglDfr5BvWkq21d5LV9LEjBtQ48JG96Ep/LvsE5IclAKytnbVFzxdDXulDbW3mhMg
         uQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gIoTZtAiyZKiIQ5V8CTyOrTgFbsDn7OEWnz1ZDQkBbg=;
        b=R44qmr4RQdfiMDk+O0mnaMfQq39kWcHDLyITHg5CstNi+qAdOaBxlsh7SvL7lmNP0o
         Jld1Lexrg2cwrUXho0kkLnu+rUpjTTtj5f9MFPaJytHXOteWVwZLk3OWz3euuU+DH/Tv
         12DkA5swlqBjjpoYCMgIARoJ5zx9iWstkKFYthTPUIPd8kgPAv9GSECJ22lmLp/2i4vc
         XLX58LwRKNq8FKqEIM9gMz2qXOMUZzt5veYjOaN79i2ziiGWsQ54NluZF3c7+Z6SB0sB
         FeiqoDn3+tmkbSSgnLE6aS8CNViJZiBPHvg+d6NW0tq6o7b/S7Ne2llfS2zdPhzMtY2i
         t+7A==
X-Gm-Message-State: AKS2vOyj0FwtWm4Hi/nONHjg0vcS5NB3h1QT9T1LLuE+Zb7XXOICzSR3
        xXh0QsZWq3jPrhu/
X-Received: by 10.98.97.1 with SMTP id v1mr24143994pfb.33.1498856003283;
        Fri, 30 Jun 2017 13:53:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id i27sm8096726pfi.82.2017.06.30.13.53.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 07/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
Date:   Fri, 30 Jun 2017 13:52:52 -0700
Message-Id: <20170630205310.7380-8-sbeller@google.com>
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
 diff.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 6e48a129ed..488096b757 100644
--- a/diff.c
+++ b/diff.c
@@ -561,6 +561,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_NO_LF_EOF,
 	DIFF_SYMBOL_CONTEXT_FRAGINFO,
 	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
@@ -569,8 +570,16 @@ enum diff_symbol {
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len)
 {
+	static const char *nneof = " No newline at end of file\n";
 	const char *context, *reset;
 	switch (s) {
+	case DIFF_SYMBOL_NO_LF_EOF:
+		context = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		putc('\n', o->file);
+		emit_line_0(o, context, reset, '\\',
+			    nneof, strlen(nneof));
+		break;
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
 		emit_line(o, "", "", line, len);
 		break;
@@ -751,7 +760,6 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 			       int prefix, const char *data, int size)
 {
 	const char *endp = NULL;
-	static const char *nneof = " No newline at end of file\n";
 	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
 
 	while (0 < size) {
@@ -769,13 +777,8 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		size -= len;
 		data += len;
 	}
-	if (!endp) {
-		const char *context = diff_get_color(ecb->color_diff,
-						     DIFF_CONTEXT);
-		putc('\n', ecb->opt->file);
-		emit_line_0(ecb->opt, context, reset, '\\',
-			    nneof, strlen(nneof));
-	}
+	if (!endp)
+		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0);
 }
 
 static void emit_rewrite_diff(const char *name_a,
-- 
2.13.0.31.g9b732c453e

