Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56A75215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754808AbeD3P4d (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:56:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42160 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754786AbeD3P4b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:56:31 -0400
Received: by mail-pf0-f196.google.com with SMTP id a11so7053633pfn.9
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OeBRu6E7P+uexDNtnaaeQ98o9KrVMvO51ykZ8034Svs=;
        b=O8gpcl2e7kaus75Bm+H53WopL2n4GbXUsmHOEornL2HNagrsdWSv6HpuZmN0S2fJig
         1R2He5zIzOtfnWx8kT4DleyvP0VCSUWA+zqgox/UT1uiOb5EgOweq/oRgIqb1ME16zCK
         xDjNogurjbIbE5uykRq3Q8oJ4Igi5YKcG2Yj5Hhv9GF8pE9y9s9EnZOJuzX+127atO/M
         obly5R6S9k3drh1pOaKIsZKYXOKaQ4gWRDNc7m1LYmMRLJ/nnexrl4+IpNMy23geTMoh
         WY7kaVOpgxNQ0hzcpyNLC/Hqw5QHGlbXcfQUrNeM2G9WklyvNWFZMiErlq8Cljm4pv8G
         PdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OeBRu6E7P+uexDNtnaaeQ98o9KrVMvO51ykZ8034Svs=;
        b=GNCOXUTn1iNNcfDkqejYSeqgCxbCiN0oX7WB+BDFM/sENumnj8z5LkzL9/Gwkaa/Xb
         bDffN1aXj7sLhZa6XzQy2i8I6tFpyB1aT2/Q8eaYsGT8rgY5cjVXzDPjcL9FClocrTg0
         gszkwHFPSoZRoRIkkfgt14AkjR02RVCqZ4jEbk7VuSEA4hmbtEjFXvlps2DI0y6dCqTI
         meSIrKA9c6mOfKXmhWGsIs4ZXtNhsk7tP0z1d7Xwzt5e8VT2qe+jR5ZSk5NE6fW+zUXD
         QDdAMPO1RU0aOLEOJnAHLCn6AtL2qb2tpvJsdySul+g4cqVaeM9yOIJ6h/3uTWEfBgmN
         0EmQ==
X-Gm-Message-State: ALQs6tAGbRKMlcpkfT7B2YjgQrjzHCs46rybmb8KjMLADEuwt+SfhFjY
        i1yIrpR6m9wRiRdgJTeZrP5x/Lse
X-Google-Smtp-Source: AB8JxZo3l1aNE+8SkQ8Ty+hPWdBnTjfUlUNC6umRdN57/EDw0rgfsf1uexzQOtrMIRnuqNUzqbDZmw==
X-Received: by 10.98.67.135 with SMTP id l7mr8275233pfi.55.1525103790203;
        Mon, 30 Apr 2018 08:56:30 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-236-28-204.dsl.chi2ca.sbcglobal.net. [76.236.28.204])
        by smtp.gmail.com with ESMTPSA id a12sm19392146pfe.78.2018.04.30.08.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 08:56:29 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2 2/2] wt-status: const-ify all printf helper methods
Date:   Thu, 26 Apr 2018 05:25:24 -0400
Message-Id: <20180426092524.25264-3-sxlijin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426092524.25264-1-sxlijin@gmail.com>
References: <20180426092524.25264-1-sxlijin@gmail.com>
In-Reply-To: <20180418030655.19378-1-sxlijin@gmail.com>
References: <20180418030655.19378-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the method signatures of all printf helper methods to take a
`const struct wt_status *` rather than a `struct wt_status *`.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 wt-status.c | 18 +++++++++---------
 wt-status.h |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 2e5452731..4360bbfd7 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -33,7 +33,7 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NIL,    /* WT_STATUS_ONBRANCH */
 };
 
-static const char *color(int slot, struct wt_status *s)
+static const char *color(int slot, const struct wt_status *s)
 {
 	const char *c = "";
 	if (want_color(s->use_color))
@@ -43,7 +43,7 @@ static const char *color(int slot, struct wt_status *s)
 	return c;
 }
 
-static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
+static void status_vprintf(const struct wt_status *s, int at_bol, const char *color,
 		const char *fmt, va_list ap, const char *trail)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -89,7 +89,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 	strbuf_release(&sb);
 }
 
-void status_printf_ln(struct wt_status *s, const char *color,
+void status_printf_ln(const struct wt_status *s, const char *color,
 			const char *fmt, ...)
 {
 	va_list ap;
@@ -99,7 +99,7 @@ void status_printf_ln(struct wt_status *s, const char *color,
 	va_end(ap);
 }
 
-void status_printf(struct wt_status *s, const char *color,
+void status_printf(const struct wt_status *s, const char *color,
 			const char *fmt, ...)
 {
 	va_list ap;
@@ -109,7 +109,7 @@ void status_printf(struct wt_status *s, const char *color,
 	va_end(ap);
 }
 
-static void status_printf_more(struct wt_status *s, const char *color,
+static void status_printf_more(const struct wt_status *s, const char *color,
 			       const char *fmt, ...)
 {
 	va_list ap;
@@ -192,7 +192,7 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_longstatus_print_cached_header(struct wt_status *s)
+static void wt_longstatus_print_cached_header(const struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 
@@ -239,7 +239,7 @@ static void wt_longstatus_print_other_header(struct wt_status *s,
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_longstatus_print_trailer(struct wt_status *s)
+static void wt_longstatus_print_trailer(const struct wt_status *s)
 {
 	status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 }
@@ -332,7 +332,7 @@ static void wt_longstatus_print_unmerged_data(struct wt_status *s,
 	strbuf_release(&onebuf);
 }
 
-static void wt_longstatus_print_change_data(struct wt_status *s,
+static void wt_longstatus_print_change_data(const struct wt_status *s,
 					    int change_type,
 					    struct string_list_item *it)
 {
@@ -768,7 +768,7 @@ static void wt_longstatus_print_unmerged(struct wt_status *s)
 
 }
 
-static void wt_longstatus_print_updated(struct wt_status *s)
+static void wt_longstatus_print_updated(const struct wt_status *s)
 {
 	int i;
 
diff --git a/wt-status.h b/wt-status.h
index 430770b85..83a1f7c00 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -135,9 +135,9 @@ int wt_status_check_bisect(const struct worktree *wt,
 			   struct wt_status_state *state);
 
 __attribute__((format (printf, 3, 4)))
-void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...);
+void status_printf_ln(const struct wt_status *s, const char *color, const char *fmt, ...);
 __attribute__((format (printf, 3, 4)))
-void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
+void status_printf(const struct wt_status *s, const char *color, const char *fmt, ...);
 
 /* The following functions expect that the caller took care of reading the index. */
 int has_unstaged_changes(int ignore_submodules);
-- 
2.17.0

