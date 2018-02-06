Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81CF91F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeBFAcF (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:32:05 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42118 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeBFAb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:31:57 -0500
Received: by mail-pl0-f65.google.com with SMTP id 11so135124plc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bKu1QvH0IxehEjBIFBk7C0My0q9F412TOldch9dHSsg=;
        b=RuFbrHW5eXINPWM9qheF+aV20pLSoVL58HyIToMPrjITpP2jictjKwIvsrRyHrCFsL
         fYE27ICpsyRJrzDtUHzYO8IjCWJ0kuXkMlMNzdMK63v7In4ycbMV+9X9vEAquPJ6+L9c
         T1WK8gUK+4p68obs0/dHT6N6w7kKz5nAcQzYL+HTwH4z2PW0ENQbochtpyqc5xr3yGCa
         VeEnQXwIAPxP1qiUAnEt1X11fejgoBoAhpr8fSJt63aXAB7xhVv2dhbmYbZd394rKuqe
         tuNbfXOnsK7h91SWJ64B3y8nQEM0uz1pUZ907lulMMAUhQtvSg+DclEHYqKOadvO5H4n
         G7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bKu1QvH0IxehEjBIFBk7C0My0q9F412TOldch9dHSsg=;
        b=qXU90opDjK1c/eaenpZbu92zre20YosJQMaaQVXku0rXZ5laB1e6ClYeEJyc9KQ375
         EYmFeaiQ8EXpy+Y+XrAKv8zOllA9lEClEDGwy9xTout3iOmXw74qCFmd2s5PVw+slXMi
         RyQ0+vgpX/p1fhvOJ579b7Wj5p/aZLGgT74bI7+s72u6AbCoyTt718vS/zlSde593uUJ
         1QK6N0ET1hwQofHuaAnAWzHhoncoMe+9utHPaltkZRyZsOdDdvTv4drBSfyT+c1IyzdD
         WvUovw2uN5x1AIz6ygWOjYSf3nsyN4H68pUQDLBTSRVLdp7XaJjtexxXzRXny00SpEnO
         nhTw==
X-Gm-Message-State: APf1xPDWgvBPeXStrjMP90OsOWJcxmQb/fLwuuQhglVZJ0dZMh/fge5+
        rjFfK4EceNHC2vywm2fNhCzp8byCSoQ=
X-Google-Smtp-Source: AH8x2241nYJYyHiSRa//EO1e/isOUOeKOJQYuWVtxeRvuRE4vssM6vLaVOne63yd0DyH8I/DylbCvQ==
X-Received: by 2002:a17:902:b28a:: with SMTP id u10-v6mr544211plr.241.1517877116906;
        Mon, 05 Feb 2018 16:31:56 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id s5sm19865513pfg.29.2018.02.05.16.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:31:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 187/194] commit: add repository argument to in_merge_bases_many
Date:   Mon,  5 Feb 2018 16:17:42 -0800
Message-Id: <20180206001749.218943-89-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c  | 4 ++--
 commit.h  | 3 ++-
 remote.c  | 2 +-
 shallow.c | 5 +++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index b74086d43d..98e04b949f 100644
--- a/commit.c
+++ b/commit.c
@@ -1049,7 +1049,7 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
 /*
  * Is "commit" an ancestor of one of the "references"?
  */
-int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference)
+int in_merge_bases_many_the_repository(struct commit *commit, int nr_reference, struct commit **reference)
 {
 	struct commit_list *bases;
 	int ret = 0, i;
@@ -1074,7 +1074,7 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
  */
 int in_merge_bases(struct commit *commit, struct commit *reference)
 {
-	return in_merge_bases_many(commit, 1, &reference);
+	return in_merge_bases_many(the_repository, commit, 1, &reference);
 }
 
 struct commit_list *reduce_heads(struct commit_list *heads)
diff --git a/commit.h b/commit.h
index 7bdc808018..ea2c5f528c 100644
--- a/commit.h
+++ b/commit.h
@@ -233,7 +233,8 @@ extern struct trace_key trace_shallow;
 
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
-int in_merge_bases_many(struct commit *, int, struct commit **);
+#define in_merge_bases_many(r, c, n, co) in_merge_bases_many_##r(c, n, co)
+int in_merge_bases_many_the_repository(struct commit *, int, struct commit **);
 
 extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
 extern int run_add_interactive(const char *revision, const char *patch_mode,
diff --git a/remote.c b/remote.c
index a4cf885012..0c253b82e8 100644
--- a/remote.c
+++ b/remote.c
@@ -1396,7 +1396,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			 * Is this tag, which they do not have, reachable from
 			 * any of the commits we are sending?
 			 */
-			if (!in_merge_bases_many(commit, sent_tips.nr, sent_tips.tip))
+			if (!in_merge_bases_many(the_repository, commit, sent_tips.nr, sent_tips.tip))
 				continue;
 
 			/* Add it in */
diff --git a/shallow.c b/shallow.c
index 64a4fcb57f..f43e94c8e8 100644
--- a/shallow.c
+++ b/shallow.c
@@ -720,7 +720,7 @@ static void post_assign_shallow(struct shallow_info *info,
 		for (j = 0; j < bitmap_nr; j++)
 			if (bitmap[0][j] &&
 			    /* Step 7, reachability test at commit level */
-			    !in_merge_bases_many(c, ca.nr, ca.commits)) {
+			    !in_merge_bases_many(the_repository, c, ca.nr, ca.commits)) {
 				update_refstatus(ref_status, info->ref->nr, *bitmap);
 				dst++;
 				break;
@@ -748,7 +748,8 @@ int delayed_reachability_test(struct shallow_info *si, int c)
 			si->nr_commits = ca.nr;
 		}
 
-		si->reachable[c] = in_merge_bases_many(commit,
+		si->reachable[c] = in_merge_bases_many(the_repository,
+						       commit,
 						       si->nr_commits,
 						       si->commits);
 		si->need_reachability_test[c] = 0;
-- 
2.15.1.433.g936d1b9894.dirty

