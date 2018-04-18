Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95EAA1F42D
	for <e@80x24.org>; Wed, 18 Apr 2018 16:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeDRQcE (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 12:32:04 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44077 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeDRQcD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 12:32:03 -0400
Received: by mail-pl0-f68.google.com with SMTP id s13-v6so1426618plq.11
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SN/cjoZ5yyPrTteQFsd6Yl3oOjRkrSmQaPpdiDf9oP4=;
        b=tT7aoIWboqje8qvuEKW4kfi8UUirTU1z25mOBeYNe0vCJ87Mq1wJtg1WF+hjfhVtcs
         N1OYPv3MTZcRkucR30pd4U11HYQ8ZJxIDQ7sEkXvDV+/kg73IA+tWvqZfnXLLQfKP6ez
         KPRsj/yAAixUVKzg8oqhVxOo7Tz2xJB6WGGwLiOAJqFo3zonfuo3qLC8SFlXWXS2fDt9
         BHTWv0ewfunwHuOL0jkoUdzbseYTiKQtN1QXGAVAai9kj1jKUgJLQOa3ZKOwcgLvc2xP
         hS3CBH5ecfQ7EANevQ089B4arify4okmHkWTrzkS8yb6rWRzIjg0u33yt8a2i3yfipaY
         dcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SN/cjoZ5yyPrTteQFsd6Yl3oOjRkrSmQaPpdiDf9oP4=;
        b=eEBRDvymU46ERF2O36KPdEIlk8rd1Ijou/gbttEPUPwxJcCtR41YC2U+cSDxVDX4N7
         cn/X/iF3eRIpM95GEuke2LxNyzcnldjRUbfmW73Co7xC48JjmrVjouxuCLCiE4Abu/ab
         PsplAu5fbCz+RWZSHRlR2jt3uKU/D0JXT1TK+OEqwE3AwUVZiHpJqnkAHeDvAfvnF645
         oi/OGk1JNKLkfWLZvZ73r/kJO7gjy7D/dV2aPNuzKp/1dU2xNxfC66QWmuLpeb9Je0hj
         XqzJGXEfcDw7wkmznuwbx+71e43XnW3gOQZoN27YbZo1B7IDoSI/AsJaGX7dgaYtkd9a
         Rc4A==
X-Gm-Message-State: ALQs6tDgSqh7Rr7MDB4yZKzmNmGC8iEk0T2Dwm35zGLJNtHyYcATK+dD
        IgY2OLx9/LVE8sRDgmQN8taExSgF
X-Google-Smtp-Source: AIpwx49HvaIP3NdpFxUb+8F+pBqGc/1Brk1w9NJTowlAa73Rgd7vuaYg/eLt7t7FuZTm3KlRzinKVg==
X-Received: by 2002:a17:902:aa94:: with SMTP id d20-v6mr2795208plr.323.1524069123114;
        Wed, 18 Apr 2018 09:32:03 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-236-28-204.dsl.chi2ca.sbcglobal.net. [76.236.28.204])
        by smtp.gmail.com with ESMTPSA id 81sm3404990pfl.92.2018.04.18.09.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Apr 2018 09:32:02 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH 2/2] wt-status: const-ify all printf helper methods
Date:   Tue, 17 Apr 2018 23:06:55 -0400
Message-Id: <20180418030655.19378-3-sxlijin@gmail.com>
X-Mailer: git-send-email 2.16.2
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
index 26b0a6221..55d29bc09 100644
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
 	if (!s->commitable) {
 		return;
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
2.16.2

