Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF85201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbdF3Uxh (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:37 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35354 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753055AbdF3Uxc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:32 -0400
Received: by mail-pf0-f170.google.com with SMTP id c73so72473130pfk.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i8eyV7P6dd+X4n90TsUkbdSLyllMbFVD/oW+a/nI70M=;
        b=K5tdwU1xXAhnhusMuELCBEUeinsr2jSKxBak0w1AeuXHmpVUxM3RHv5StKbGQOAES4
         wZPL4q9gIL5I3NcB/W6FlNtsUTd8cqqmR4aVkCCumEePMLaOls+Nfj4urXIVk9NuCRR9
         LQe86XkJiHV/xcSgN3P+HcgL7hpSnVND2nHNcl7Y9l8LzZSSw3BqfD1G5enIWMucPDBL
         fSLpwJaMotJkvdVldO6oT7xzTgyJD74EPh144wiXeA+NISPrInrGvCsU4teQk9wmP+bg
         1z87ulHPLxCbqyg+iY60+hXWRh1wQcP473kSkGE2Tk9yzQLggFqfjJNOOq5wBgROZsg8
         qTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i8eyV7P6dd+X4n90TsUkbdSLyllMbFVD/oW+a/nI70M=;
        b=ZmCDjYpvsGkfRhUgLqzvlKvHJrxJGcZFrO57xD2BA/wzx9l9POKEJiGVpGTkao+iA9
         hkH2P5lVqFhmYLF3J6YtNudAN9iupm4SOsKmS9uXNk9rv85k7DS+v4/L1gBpw7VzxUhx
         7PdulaZuDLC/Z5i/18TlfAsH1l83vrqJ6enM6AmvpWNzq+zIZY3iqaD/Gl9eVBIDjmsc
         o3Wik4br/fyxJEee4T+4ube/RudHHaV7brN+/V9gWZf1fpq5ItwyYP2S/EXnKrl/ifC/
         qNvmISD6TwXXfTIYmlCZcgBI7cd9JHNqqq2OQDU+jYw3yVx65zscalglIUcpbGonErtZ
         s7KQ==
X-Gm-Message-State: AKS2vOzsFSIp1cLNzy+6MzkX9gRjhJqy19ugMWX87b8v/6f8wrMK/dAh
        VsxyFFOr7C7ASLgd
X-Received: by 10.98.13.219 with SMTP id 88mr24750288pfn.191.1498856011809;
        Fri, 30 Jun 2017 13:53:31 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id l22sm19767587pfb.55.2017.06.30.13.53.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 14/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
Date:   Fri, 30 Jun 2017 13:52:59 -0700
Message-Id: <20170630205310.7380-15-sbeller@google.com>
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
 diff.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 1d0f8b509f..5c428e02b6 100644
--- a/diff.c
+++ b/diff.c
@@ -561,6 +561,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_REWRITE_DIFF,
 	DIFF_SYMBOL_BINARY_FILES,
 	DIFF_SYMBOL_HEADER,
 	DIFF_SYMBOL_FILEPAIR_PLUS,
@@ -615,7 +616,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len, unsigned flags)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset, *set, *meta;
+	const char *context, *reset, *set, *meta, *fraginfo;
 	switch (s) {
 	case DIFF_SYMBOL_NO_LF_EOF:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
@@ -695,6 +696,11 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_HEADER:
 		fprintf(o->file, "%s", line);
 		break;
+	case DIFF_SYMBOL_REWRITE_DIFF:
+		fraginfo = diff_get_color(o->use_color, DIFF_FRAGINFO);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line(o, fraginfo, reset, line, len);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -817,17 +823,17 @@ static void remove_tempfile(void)
 	}
 }
 
-static void print_line_count(FILE *file, int count)
+static void add_line_count(struct strbuf *out, int count)
 {
 	switch (count) {
 	case 0:
-		fprintf(file, "0,0");
+		strbuf_addstr(out, "0,0");
 		break;
 	case 1:
-		fprintf(file, "1");
+		strbuf_addstr(out, "1");
 		break;
 	default:
-		fprintf(file, "1,%d", count);
+		strbuf_addf(out, "1,%d", count);
 		break;
 	}
 }
@@ -866,14 +872,12 @@ static void emit_rewrite_diff(const char *name_a,
 			      struct diff_options *o)
 {
 	int lc_a, lc_b;
-	const char *fraginfo = diff_get_color(o->use_color, DIFF_FRAGINFO);
-	const char *reset = diff_get_color(o->use_color, DIFF_RESET);
 	static struct strbuf a_name = STRBUF_INIT, b_name = STRBUF_INIT;
 	const char *a_prefix, *b_prefix;
 	char *data_one, *data_two;
 	size_t size_one, size_two;
 	struct emit_callback ecbdata;
-	const char *line_prefix = diff_line_prefix(o);
+	struct strbuf out = STRBUF_INIT;
 
 	if (diff_mnemonic_prefix && DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		a_prefix = o->b_prefix;
@@ -917,14 +921,17 @@ static void emit_rewrite_diff(const char *name_a,
 	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_PLUS,
 			 b_name.buf, b_name.len, 0);
 
-	fprintf(o->file, "%s%s@@ -", line_prefix, fraginfo);
+	strbuf_addstr(&out, "@@ -");
 	if (!o->irreversible_delete)
-		print_line_count(o->file, lc_a);
+		add_line_count(&out, lc_a);
 	else
-		fprintf(o->file, "?,?");
-	fprintf(o->file, " +");
-	print_line_count(o->file, lc_b);
-	fprintf(o->file, " @@%s\n", reset);
+		strbuf_addstr(&out, "?,?");
+	strbuf_addstr(&out, " +");
+	add_line_count(&out, lc_b);
+	strbuf_addstr(&out, " @@\n");
+	emit_diff_symbol(o, DIFF_SYMBOL_REWRITE_DIFF, out.buf, out.len, 0);
+	strbuf_release(&out);
+
 	if (lc_a && !o->irreversible_delete)
 		emit_rewrite_lines(&ecbdata, '-', data_one, size_one);
 	if (lc_b)
-- 
2.13.0.31.g9b732c453e

