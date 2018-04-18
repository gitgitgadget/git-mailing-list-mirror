Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0AD71F42D
	for <e@80x24.org>; Wed, 18 Apr 2018 16:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeDRQb6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 12:31:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36456 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbeDRQb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 12:31:57 -0400
Received: by mail-pf0-f194.google.com with SMTP id g14so1172931pfh.3
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RIXxhkoK+ea/tD2Ev8W3I/7TYKgdOqZ6EgYJyqk92y0=;
        b=hrejiJ8B/ih3Ymv3v4YB+C51kfNQC65o5VuLaslfNElqr4CT9M6mFcOYJvtSw0VbAm
         2+83Mjgs9HqykW1UW6VJUeAWwn5i/iRGmnsCWacUdJpOUwHwISLQLIB88L0YHqZP9mC+
         OVFsVUv6Fu0x/DSQnqlAQzkAFqcHMb24jlNcNd2Rw9ppQJTnAziwFX0+wrMHSzSvH0xG
         7lUIRcfpu8x8liUkb6xAhF9jr6pw9a7ngd68NE4aZJALmM+IBywtTnzDlNG4mYoni0Zt
         PmNWKMIzjq7sQ3OxhdCv88okGBUoDozHUTQN8EUC97FlvpV6ZzYimPDx7CchYV1Uf1zq
         A69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RIXxhkoK+ea/tD2Ev8W3I/7TYKgdOqZ6EgYJyqk92y0=;
        b=gcFicTcc5w1ZKdzmAhXkWLE5/sLc1qWozFJO0sWodFtBtuk+uwehrHQKWZqvOyrTPU
         fdJqH1iwqEDnZt16VNpGFVEiYVysTMsI/Iy++oxuQ7EU++H/udCjJ9Mk9Qc5uPz2EFiH
         7Hi6euxbgmG8gxX8cA8/+uELvCNjYUD4CTOs/bfmWDQyn+N82U0sgXThyS95fjFTVUgs
         1Yd5hBLIyDtZdioMKzy1tQA3U1UZmAh23OatAmRAu44zaifsYMA8dFJXpXBWRHHLh75d
         qvOLkZxN5Xj2Md6KUZeJuqGuPiw6SNy3Y4d5j7EXAbloZFR8/xxxZiQwBGM3fjqhzv4s
         luNg==
X-Gm-Message-State: ALQs6tBzi5OcbkjWozNQ+PuIc2OevFioFK0K1oUPWOI677xSUsFrXVpS
        z8EzkItKgtnJqBVqBCxq+Pqp6mIt
X-Google-Smtp-Source: AIpwx4/W6f5A3PFGBZw90lbx3BTuUsopxe2acgmRaFck8iGSnOMa7CMWbOVscrPnx4bFH3NXt+/qkg==
X-Received: by 10.98.152.5 with SMTP id q5mr2602098pfd.178.1524069116989;
        Wed, 18 Apr 2018 09:31:56 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-236-28-204.dsl.chi2ca.sbcglobal.net. [76.236.28.204])
        by smtp.gmail.com with ESMTPSA id 81sm3404990pfl.92.2018.04.18.09.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Apr 2018 09:31:56 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH 1/2] commit: fix --short and --porcelain
Date:   Tue, 17 Apr 2018 23:06:54 -0400
Message-Id: <20180418030655.19378-2-sxlijin@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180418030655.19378-1-sxlijin@gmail.com>
References: <20180418030655.19378-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make invoking `git commit` with `--short` or `--porcelain` return status
code zero when there is something to commit.

Mark the commitable flag in the wt_status object in the call to
`wt_status_collect()`, instead of in `wt_longstatus_print_updated()`,
and simplify the logic in the latter function to take advantage of the
logic shifted to the former.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7501-commit.sh |  4 ++--
 wt-status.c       | 39 +++++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index fa61b1a4e..85a8217fd 100755
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
diff --git a/wt-status.c b/wt-status.c
index 50815e5fa..26b0a6221 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -718,6 +718,19 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
 }
 
+static void wt_status_mark_commitable(struct wt_status *s) {
+	int i;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d = (s->change.items[i]).util;
+
+		if (d->index_status && d->index_status != DIFF_STATUS_UNMERGED) {
+			s->commitable = 1;
+			return;
+		}
+	}
+}
+
 void wt_status_collect(struct wt_status *s)
 {
 	wt_status_collect_changes_worktree(s);
@@ -726,7 +739,10 @@ void wt_status_collect(struct wt_status *s)
 		wt_status_collect_changes_initial(s);
 	else
 		wt_status_collect_changes_index(s);
+
 	wt_status_collect_untracked(s);
+
+	wt_status_mark_commitable(s);
 }
 
 static void wt_longstatus_print_unmerged(struct wt_status *s)
@@ -754,26 +770,25 @@ static void wt_longstatus_print_unmerged(struct wt_status *s)
 
 static void wt_longstatus_print_updated(struct wt_status *s)
 {
-	int shown_header = 0;
-	int i;
+	if (!s->commitable) {
+		return;
+	}
+
+	wt_longstatus_print_cached_header(s);
 
+	int i;
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
-			s->commitable = 1;
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
-- 
2.16.2

