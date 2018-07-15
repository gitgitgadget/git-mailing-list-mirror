Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0864A1F597
	for <e@80x24.org>; Sun, 15 Jul 2018 21:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeGOWVI (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 18:21:08 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40408 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeGOWVI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jul 2018 18:21:08 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so5000523plp.7
        for <git@vger.kernel.org>; Sun, 15 Jul 2018 14:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dRbrIk5iWBvIwvTTYFkymqUmUeKf7WEtIUr9j6lRrFk=;
        b=ZWwcRnNdTDUjUQ1bEuqC7NxvabOxAlHx+A3vLGgJLyy6yerM/iZ0uv4hf+/vNLmFuy
         16jeYMb8we29fOjAMWtoii9LOCfTX98gI5/VnFCUrMUJRnkO71CmFbAJg67v/+11Id2T
         dqNZArq8aDfYZo7DpxoXF1jANpc2rpS05zek9b1cyfCq+IYfBEO8bVujwNOzHPN6dkg5
         HSXTMiiqdB3iobRdueXvR0+trnCvxPro39xLn8pyVEwq89NehTpxbJCiR+nqQyBCnQp4
         AAG9bIv9GI0GE4aUcpqxO89yIfOTWGc24KuuQ3CaSao0+NHqjrHUu0IEdmqIQULUpR/s
         fc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dRbrIk5iWBvIwvTTYFkymqUmUeKf7WEtIUr9j6lRrFk=;
        b=hrphDZkvD9t7quV46p1Ku5b+ecifmvtPEJDHv92qc20V0W3oW+KDde3owonrZ9p9KG
         471PPmb5hWL+e9kKmtkUwIFL7KQJ4dwltajqEjnWYe/xhA4chWWUYmHGtwKpUqy7egIK
         C/CODdGZSOxAcmN/6ZHRGb5sP3rqRPW5pFrZ00T1EzUMqcMoXey2UqfloQxmU69D0rTA
         oYRYlGI853Eii0+sLQM9l8AS3bn17vYw2thWf43Fuo3nr8co0okeohbG/oysX4qYLRsr
         1j0DTlhw6YWJx0qd128vubfcM6DWgbxVGma36wAITWtL5VXWvzMD+3THHrg9VXZIh1mC
         7hBw==
X-Gm-Message-State: AOUpUlEq4ZeZqFs+x/twpS+9kan4F7EkM2UTephJkPvEmfwpXkGAdqy1
        b+zG98lx/kHQKn9DUoXsfKfVlRnT
X-Google-Smtp-Source: AAOMgpeDJOpegM/RviIECANvex4LC/DrIb+XedSdNF/JWV/uCohUOtV/jjmkaFh5RFsTIA+15L0kRw==
X-Received: by 2002:a17:902:b406:: with SMTP id x6-v6mr5689556plr.34.1531691808032;
        Sun, 15 Jul 2018 14:56:48 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-236-28-204.dsl.chi2ca.sbcglobal.net. [76.236.28.204])
        by smtp.gmail.com with ESMTPSA id e82-v6sm81924819pfk.87.2018.07.15.14.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 14:56:47 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v3 3/3] commit: fix exit code for --short/--porcelain
Date:   Sun, 15 Jul 2018 07:08:07 -0400
Message-Id: <20180715110807.25544-4-sxlijin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180426092524.25264-1-sxlijin@gmail.com>
References: <20180426092524.25264-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In wt-status.c, the s->commitable bit is set only in the call tree of
wt_longstatus_print(), which means that when there are changes to be
committed or all merge conflicts have been resolved, --dry-run and
--long return the correct exit code, but --short and --porcelain do not,
even though they both imply --dry-run.

Teach wt_status_collect() to set s->committable correctly so that
--short and --porcelain return the correct exit code in the above
described situations and mark the documenting tests as fixed.

Also stop setting s->committable in wt_longstatus_print_updated() and
show_merge_in_progress(), and const-ify wt_status_state in the method
signatures in those callpaths.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7501-commit.sh |  8 ++---
 wt-status.c       | 82 +++++++++++++++++++++++++++++------------------
 2 files changed, 55 insertions(+), 35 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index be087e73f..b6492322f 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -87,12 +87,12 @@ test_expect_success '--dry-run with stuff to commit returns ok' '
 	git commit -m next -a --dry-run
 '
 
-test_expect_failure '--short with stuff to commit returns ok' '
+test_expect_success '--short with stuff to commit returns ok' '
 	echo bongo bongo bongo >>file &&
 	git commit -m next -a --short
 '
 
-test_expect_failure '--porcelain with stuff to commit returns ok' '
+test_expect_success '--porcelain with stuff to commit returns ok' '
 	echo bongo bongo bongo >>file &&
 	git commit -m next -a --porcelain
 '
@@ -691,11 +691,11 @@ test_expect_success '--dry-run with conflicts fixed from a merge' '
 	git commit --dry-run
 '
 
-test_expect_failure '--short with conflicts fixed from a merge' '
+test_expect_success '--short with conflicts fixed from a merge' '
 	git commit --short
 '
 
-test_expect_failure '--porcelain with conflicts fixed from a merge' '
+test_expect_success '--porcelain with conflicts fixed from a merge' '
 	git commit --porcelain
 '
 
diff --git a/wt-status.c b/wt-status.c
index 75d389944..4ba657978 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -718,6 +718,39 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
 }
 
+static int has_unmerged(const struct wt_status *s)
+{
+	int i;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		d = s->change.items[i].util;
+		if (d->stagemask)
+			return 1;
+	}
+	return 0;
+}
+
+static void wt_status_mark_committable(
+		struct wt_status *s, const struct wt_status_state *state)
+{
+	int i;
+
+	if (state->merge_in_progress && !has_unmerged(s)) {
+		s->committable = 1;
+		return;
+	}
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d = (s->change.items[i]).util;
+
+		if (d->index_status && d->index_status != DIFF_STATUS_UNMERGED) {
+			s->committable = 1;
+			return;
+		}
+	}
+}
+
 void wt_status_collect(struct wt_status *s, const struct wt_status_state *state)
 {
 	wt_status_collect_changes_worktree(s);
@@ -728,6 +761,8 @@ void wt_status_collect(struct wt_status *s, const struct wt_status_state *state)
 		wt_status_collect_changes_index(s);
 
 	wt_status_collect_untracked(s);
+
+	wt_status_mark_committable(s, state);
 }
 
 static void wt_longstatus_print_unmerged(const struct wt_status *s)
@@ -753,28 +788,28 @@ static void wt_longstatus_print_unmerged(const struct wt_status *s)
 
 }
 
-static void wt_longstatus_print_updated(struct wt_status *s)
+static void wt_longstatus_print_updated(const struct wt_status *s)
 {
-	int shown_header = 0;
 	int i;
 
+	if (!s->committable) {
+		return;
+	}
+
+	wt_longstatus_print_cached_header(s);
+
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		struct string_list_item *it;
 		it = &(s->change.items[i]);
 		d = it->util;
-		if (!d->index_status ||
-		    d->index_status == DIFF_STATUS_UNMERGED)
-			continue;
-		if (!shown_header) {
-			wt_longstatus_print_cached_header(s);
-			s->committable = 1;
-			shown_header = 1;
+		if (d->index_status &&
+		    d->index_status != DIFF_STATUS_UNMERGED) {
+			wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
 		}
-		wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
 	}
-	if (shown_header)
-		wt_longstatus_print_trailer(s);
+
+	wt_longstatus_print_trailer(s);
 }
 
 /*
@@ -1056,21 +1091,7 @@ static void wt_longstatus_print_tracking(const struct wt_status *s)
 	strbuf_release(&sb);
 }
 
-static int has_unmerged(const struct wt_status *s)
-{
-	int i;
-
-	for (i = 0; i < s->change.nr; i++) {
-		struct wt_status_change_data *d;
-		d = s->change.items[i].util;
-		if (d->stagemask)
-			return 1;
-	}
-	return 0;
-}
-
-static void show_merge_in_progress(struct wt_status *s,
-				const struct wt_status_state *state,
+static void show_merge_in_progress(const struct wt_status *s,
 				const char *color)
 {
 	if (has_unmerged(s)) {
@@ -1082,7 +1103,6 @@ static void show_merge_in_progress(struct wt_status *s,
 					 _("  (use \"git merge --abort\" to abort the merge)"));
 		}
 	} else {
-		s-> committable = 1;
 		status_printf_ln(s, color,
 			_("All conflicts fixed but you are still merging."));
 		if (s->hints)
@@ -1576,12 +1596,12 @@ void wt_status_clear_state(struct wt_status_state *state)
 	free(state->detached_from);
 }
 
-static void wt_longstatus_print_state(struct wt_status *s,
+static void wt_longstatus_print_state(const struct wt_status *s,
 				      const struct wt_status_state *state)
 {
 	const char *state_color = color(WT_STATUS_HEADER, s);
 	if (state->merge_in_progress)
-		show_merge_in_progress(s, state, state_color);
+		show_merge_in_progress(s, state_color);
 	else if (state->am_in_progress)
 		show_am_in_progress(s, state, state_color);
 	else if (state->rebase_in_progress || state->rebase_interactive_in_progress)
@@ -1594,7 +1614,7 @@ static void wt_longstatus_print_state(struct wt_status *s,
 		show_bisect_in_progress(s, state, state_color);
 }
 
-static void wt_longstatus_print(struct wt_status *s, const struct wt_status_state *state)
+static void wt_longstatus_print(const struct wt_status *s, const struct wt_status_state *state)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
-- 
2.18.0

