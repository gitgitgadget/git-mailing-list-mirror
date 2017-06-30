Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436C6201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbdF3UyT (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:54:19 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36505 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbdF3Ux1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:27 -0400
Received: by mail-pf0-f182.google.com with SMTP id q86so72399176pfl.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DKCmUm271quFz59evQjwsdKNJ5oQ4hRUvaTdnfdaVW4=;
        b=ZVbz20sWUmRBxE9s6IcDh7bQCJkUpZ2LT2XoKI1Qcg9EEUQgpqgjhCW4/pHbyqg+hv
         2/4gU1IOk+Z3Z/IQwi4o6qvbR59GfNvHuwhJgXUU0LrpWEKUjbabAERqBbiL92LQI+kK
         DtvqONgbzJEpuatW/N5qp3xoh2YfCFt/NzE7W0V12laPevPHBNl9wJhYMziZ2nbeNEDO
         rQpxcdrBM67BSTI8t8c3t36SJfgsBa0TE2Y2jRt0e0DaGfpmz8u06p/ZPE1t/Td5H8EA
         jhMthI/X9YNin4lUw/2Bhdzr084le8a4eljR9HVTDDfttqBXtepGd1lymCl9pnR326nY
         UMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DKCmUm271quFz59evQjwsdKNJ5oQ4hRUvaTdnfdaVW4=;
        b=Wv5OPgqicEWLxiXsqmV81ipXeTfqaogGWyDof5QjIhsMoSaXCoPvdXHg/BsR0L9qMl
         jVcumXGGOBk61gHiy81jVXxQ5bCGk6E510+qnNCuBUwjTCRMnc5H1BQEKa+dmZz2yvM/
         W2/Og5z/iJ5uHNab3nT388BAyXTkceP4YitVa8tUK18WEr/O3edQ+EytBLk11PL2jaf7
         KcWJ60u9DNhn0oCmd8u/Ksg+sIUZl2kldL999XK2D3hrimabB+q1lDpVZbqSQAuj7gcB
         ZO+na9Yz1yEnspYOFxl8RY+RalXjx2SREL7e5AnLr3AUCwTqRArc62sHjJftvza2CT/p
         Q6Zw==
X-Gm-Message-State: AKS2vOy4W7Pg1P2cKZOM/40XE4itJKHibVKQr8KPwkmYIo32fHI43Ug9
        kgcyH+rP1WXG4/Vd
X-Received: by 10.99.131.193 with SMTP id h184mr23591252pge.80.1498856006717;
        Fri, 30 Jun 2017 13:53:26 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id o6sm16154803pgs.43.2017.06.30.13.53.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 10/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
Date:   Fri, 30 Jun 2017 13:52:55 -0700
Message-Id: <20170630205310.7380-11-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The context marker use the exact same output pattern, so reuse it.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 85bfd9310d..b2b2a19fcf 100644
--- a/diff.c
+++ b/diff.c
@@ -564,6 +564,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_WORDS_PORCELAIN,
 	DIFF_SYMBOL_WORDS,
 	DIFF_SYMBOL_CONTEXT,
+	DIFF_SYMBOL_CONTEXT_INCOMPLETE,
 	DIFF_SYMBOL_PLUS,
 	DIFF_SYMBOL_MINUS,
 	DIFF_SYMBOL_NO_LF_EOF,
@@ -622,6 +623,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
 		emit_line(o, "", "", line, len);
 		break;
+	case DIFF_SYMBOL_CONTEXT_INCOMPLETE:
 	case DIFF_SYMBOL_CONTEXT_MARKER:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
@@ -1448,8 +1450,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	default:
 		/* incomplete line at the end */
 		ecbdata->lno_in_preimage++;
-		emit_line(o, diff_get_color(ecbdata->color_diff, DIFF_CONTEXT),
-			  reset, line, len);
+		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
+				 line, len, 0);
 		break;
 	}
 }
-- 
2.13.0.31.g9b732c453e

