Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74EA820D0C
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbdFTCtA (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:49:00 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34337 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFTCs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:58 -0400
Received: by mail-pg0-f45.google.com with SMTP id e187so4232222pgc.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eD1VdoKQr41yevXFxzuKvilZaZRAcoeWZ1gGk1R3pkc=;
        b=QW3CUJz5jVY1tH9+ydivW/N8rDOMyHrZCApEctpkxsvhIH4XlGgv6dSyPy82ZfxWNc
         5GH8u6ZApikFcugAWDYagQvSVQCmdbNqDxFJkZSlgRtTGK4kzwlzb/kqVgv9fbeW+Tr9
         Brh/qNfqA/hx0RaBr+E+vQpYgHKQlgVeGwslFsebY1xnbwo132KwdPc0BHsSUhglhRFV
         PeD/mD1H1TvnYEiLR9WVwdoDZRXpCbxteZSGcRSh+UxKAGQR+XOgAL3GpNuBRHEkyjz9
         sclmocAufvXEIgurtJQhuXVIazphkOD4ykHSgRfc6v4ABb4jMw2LhkRluHP0T+lwyXuU
         g/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eD1VdoKQr41yevXFxzuKvilZaZRAcoeWZ1gGk1R3pkc=;
        b=EHOcseQ/J0V9HmN/hE4APbEhYeInLQ5yw8I86Nyo5hc1SLYaFebAswIgTSEoncwZhC
         7sTA5XEbbnRhBsBR+OQdlc97F5nFzXaPGsE+a/0Yov2e4vwsIratbJytda2UYBwlP9So
         rw9a65avt+ogai+nWfuohPxjUU1fBN+sz6hxfuW6Zj3mSHcyfoC7LY8stxnrdaBkCGYE
         DUiU/KqP7D42vs7dh1nZrQXysbvXE/vPfqFrZbiitjx82ueXFHIcXCViXDyY8kxooEVz
         aY/6wr1Y7k+HHQ5NjvPsUNdYQCMGvBOT2kSHPUAltGRxg+zbyTau3Xh4ptjRaIjdb608
         txGQ==
X-Gm-Message-State: AKS2vOzITWpYx3kBsQNV4sy6zV+jdHsVGRNfdgTUuPbfAx2spA6pm8RM
        QwFMNzYQ+Ux+Q1QT
X-Received: by 10.84.133.15 with SMTP id 15mr12240820plf.291.1497926937497;
        Mon, 19 Jun 2017 19:48:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id y9sm22237142pgc.27.2017.06.19.19.48.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [showing-off RFC/PATCH 26/26] diff.c: have a "machine parseable" move coloring
Date:   Mon, 19 Jun 2017 19:48:16 -0700
Message-Id: <20170620024816.20021-27-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar asked for it, this is how you would do it.
(plus documentation, tests, CLI knobs, options)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 15 +++++++++++----
 diff.h |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 7756f7610c..61caa057ff 100644
--- a/diff.c
+++ b/diff.c
@@ -997,6 +997,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	static const char *nneof = " No newline at end of file\n";
 	const char *context, *reset, *set, *meta, *fraginfo;
 	struct strbuf sb = STRBUF_INIT;
+	int sign;
 
 	enum diff_symbol s = eds->s;
 	const char *line = eds->line;
@@ -1058,8 +1059,11 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		default:
 			set = diff_get_color_opt(o, DIFF_FILE_NEW);
 		}
+		sign = '+';
+		if (flags & DIFF_SYMBOL_MOVED_LINE && o->machine_readable_moves)
+			sign = '*';
 		reset = diff_get_color_opt(o, DIFF_RESET);
-		emit_line_ws_markup(o, set, reset, line, len, '+',
+		emit_line_ws_markup(o, set, reset, line, len, sign,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1086,8 +1090,11 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		default:
 			set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
+		sign = '-';
+		if (flags & DIFF_SYMBOL_MOVED_LINE && o->machine_readable_moves)
+			sign = '_';
 		reset = diff_get_color_opt(o, DIFF_RESET);
-		emit_line_ws_markup(o, set, reset, line, len, '-',
+		emit_line_ws_markup(o, set, reset, line, len, sign,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
@@ -5475,7 +5482,7 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	static struct emitted_diff_symbols esm = EMITTED_DIFF_SYMBOLS_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
 
-	if (o->color_moved)
+	if (o->color_moved || o->machine_readable_moves)
 		o->emitted_symbols = &esm;
 
 	for (i = 0; i < q->nr; i++) {
@@ -5485,7 +5492,7 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	}
 
 	if (o->emitted_symbols) {
-		if (o->color_moved) {
+		if (o->color_moved || o->machine_readable_moves) {
 			struct hashmap add_lines, del_lines;
 			unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
 
diff --git a/diff.h b/diff.h
index 98abd75521..b6c4d7ab0f 100644
--- a/diff.h
+++ b/diff.h
@@ -194,6 +194,8 @@ struct diff_options {
 		COLOR_MOVED_ZEBRA = 2,
 		COLOR_MOVED_ZEBRA_DIM = 3,
 	} color_moved;
+
+	int machine_readable_moves;
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
-- 
2.12.2.575.gb14f27f917

