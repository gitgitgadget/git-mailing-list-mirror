Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FDD0202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbdF3AIV (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:08:21 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34329 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbdF3AHr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:47 -0400
Received: by mail-pg0-f41.google.com with SMTP id t186so55417182pgb.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i8eyV7P6dd+X4n90TsUkbdSLyllMbFVD/oW+a/nI70M=;
        b=Nc8PwnN37UgW+VsBWHd2GQsRy0VcYPqcxmSTk7fkDnqLNkVbHjuBiEgySq4lsUcPkx
         0WLomI5hBo5dyqWQNGzoxd95Kc+stM8lKLyjz+VdkDrQ2qx1S33RdtgGhZ1nH5sLiyJE
         1BRkpv5c4+RRdd9IyakjwnHF76G6DRgBjwxBSz3rkMchD3UKtjIT490zH8YIF4w09q8x
         uVda8W40EFBk2+msYvSVffp4+4EN3Y3PfeatEq1eOmfYQs6qKfkfSaCJFb9TzR0iN8Ss
         tY7V0Y6xh7raNs38xKxJaFzM2B9QO5LSmxPRahpw9EUmSlbnFcAqiZIO+9fSjB+bB8TG
         nHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i8eyV7P6dd+X4n90TsUkbdSLyllMbFVD/oW+a/nI70M=;
        b=n8WkDkT8wbDYc4XUoyLXi4J0itjIMOREaIRp6j+CrQs6QBi8abcKtg43GupQ4zgRy2
         9HArIsxjHOpexohNXw4lfsQTfr7y7A9ddGEPUr6EGDuPpIjf28wW/YpHwUAxfBhAoDSP
         SV/fKHxuWO0GGZIoGtPSsbSWe/9AWmdJOZ4kfMieLw6I03acN0mCTXS0Agapqza3zC+t
         4yO+Q2GwWPj74FOy5pnc5jxYy/Y/JUxw5kSvwcrxnZ072EJPLgLaBU3jbJ3nIT7qhsw4
         7NaFUoVDNlVEnB0Sq2K4gFHp2n1sZPdZG59u1bk+uGhY6q+E2Upwc/yW2VSLp/PfXz4Q
         zEHg==
X-Gm-Message-State: AKS2vOyOLYkvgNuEzhVHErdF16Pw77Y4PQ60+8TknjNbxccMoTEJU6ng
        qfNYEqlV+AHDiJ1Q4UJMCg==
X-Received: by 10.99.178.83 with SMTP id t19mr17932359pgo.34.1498781261272;
        Thu, 29 Jun 2017 17:07:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id 5sm11873542pfe.60.2017.06.29.17.07.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 14/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
Date:   Thu, 29 Jun 2017 17:06:59 -0700
Message-Id: <20170630000710.10601-15-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
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

