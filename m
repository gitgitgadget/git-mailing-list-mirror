Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C652A201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbdF3UxX (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:23 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33288 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbdF3UxW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:22 -0400
Received: by mail-pg0-f48.google.com with SMTP id f127so68711904pgc.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jj5x3EumxnRYZC+c4Z8UVT7eT5zlcupbZZXmx/kSec8=;
        b=gdTOIgJcDkU577Jn4soTycd3RQ6Yp7ywoIZFg4PAbYmiNJw7SL7eA6tse7zAuRllNy
         6AANgz0VHXb9xznrwx1mvLoDd++v1wB2sZe66TRqpBlwq0t8EqxH4lUmY1/+OGivGswY
         EbAsXo8Pk3Keo+ald6HFIRLTGaeviNY5JPaEKwu7+D/5GMOnc8DOWEiux4DPugWorfHF
         r3/9VOmUHfH2D/xvzMcOoY5eBvIO4EVnl5sQ2hcpgqIqhcdk+q/WLbGw81LNT1e7wVL/
         vddVr80ezJqMDfdea+3Afslxpzv4w4TkoBuJgEYzkEchEAEZf8zF4WaQNx6BUpS/6Y7Y
         fb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jj5x3EumxnRYZC+c4Z8UVT7eT5zlcupbZZXmx/kSec8=;
        b=OmVh3DOifvIFRnB2RRwgx6u9VQoXxYhnxhclA0/QRK+TDmnW2vz5WRM6Zx9pZP+Gh2
         +gR3AYgG8jdIWh91u0zKeL6dga189sDtdIxecsSq4v2Pg96+fikSfwrfPGGDeLK6gIBW
         nfagHKd5+WwAzbMtsk4EOJeVC6wnnkrtY0ygFUKil8uSeYq9mPngDWFbcUyw+8MYALju
         rF12sOLidjwvC3iAkyNNFDyw7CcVnNTrmtOcr82BR1tCrIz/3I/5ift8UGVZojRHFf3A
         +T9daGZQ79kkcknhCoMq5ltlL94OoxxTm3UiBE6BL/TcGnccdYwfpYnmzHINBjGrY9/N
         M2lw==
X-Gm-Message-State: AKS2vOwMCljaU3pfhgQlvX5UydpA39TeKqhbCjK5qVTsFHD0SCwuS9tN
        q/o4iL7k6v9aBHXLtIv67g==
X-Received: by 10.84.130.40 with SMTP id 37mr26268420plc.192.1498856002119;
        Fri, 30 Jun 2017 13:53:22 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id f10sm19492506pgu.54.2017.06.30.13.53.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:21 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 06/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
Date:   Fri, 30 Jun 2017 13:52:51 -0700
Message-Id: <20170630205310.7380-7-sbeller@google.com>
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
 diff.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 75b996c4cf..6e48a129ed 100644
--- a/diff.c
+++ b/diff.c
@@ -561,6 +561,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_CONTEXT_FRAGINFO,
 	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
 };
@@ -570,6 +571,9 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 {
 	const char *context, *reset;
 	switch (s) {
+	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
+		emit_line(o, "", "", line, len);
+		break;
 	case DIFF_SYMBOL_CONTEXT_MARKER:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
@@ -705,8 +709,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 
 	strbuf_add(&msgbuf, line + len, org_len - len);
 	strbuf_complete_line(&msgbuf);
-
-	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
+	emit_diff_symbol(ecbdata->opt,
+			 DIFF_SYMBOL_CONTEXT_FRAGINFO, msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
 
-- 
2.13.0.31.g9b732c453e

