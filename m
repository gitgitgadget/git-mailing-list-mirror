Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9ACA1F424
	for <e@80x24.org>; Sun, 15 Apr 2018 08:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeDOI7J (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 04:59:09 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43046 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbeDOI7H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 04:59:07 -0400
Received: by mail-lf0-f68.google.com with SMTP id v207-v6so17893892lfa.10
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QDVkrrHVxQbIlvT7wezlpSzbMCbI0+Eey47HjFNWz5k=;
        b=ttM/pBx6KE7qa7L+JaZIxCXDbYdY+KBJGhuevz6jUgVH8mhYNQHyJSArgK/93fG2n1
         LkwlNbrX6by1qvSMSKf9A/eHfcMKkoP4MCbZTix8+HzI04SJXtSodJ5Uk0ZF1SLRclZG
         U1zbR0+at1CY9J2I+h7VUhxMDLX2wR2Jex8PU/m56Cp4tpZeZw59TtoeWu/V0UQTvjmK
         3ukOI4FMFoIF0ise6Cf1bIIxXLqwX2WELieBnoBqaYuKIoc9wA3Dxs3d43gAWL/vS0py
         HZaJeWdjs//DAsKQldl1VPc/bG7TaPg9WEbD1j683tZKyiPiillpRUflsE0g6vGWMsCj
         Muzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QDVkrrHVxQbIlvT7wezlpSzbMCbI0+Eey47HjFNWz5k=;
        b=PYz6NC57Oy8ZpzacEG0kDlZwrKjvRbdI9g19X4qan/3WgW6flRFigpMAhV785aOO32
         C6GB8uOdApnh/EOSmZHuLw1FZnXqtWfeofK4gkUDFjeGpqvVeAFyyPkKITMsQhTIlbjo
         aEFBtcRz8tueZIxeKuPzllRe+ovb/5mOKrqx6WOJnILsq8OaEyq2WrDc1eKEzAcngGMV
         pWxY+hiHj+l0N+yd64QIgnS51rvEMCiHDByaAKw09HBX67rkI9g2MeKfqAjuKujSLFWv
         /XPJpdBqfztbcXNUwAm8gWftE1bupDCXr0mj5rEQaks+pKCkpjhqaxqs36Ux17yyFa/N
         8sWw==
X-Gm-Message-State: ALQs6tDHHakcSBJicOpHRSzpHITzQKtpHIH0TmnVOVcMhr4BNeaBnABr
        FXiqyzYdSga9j4z0xCZocafYerIe
X-Google-Smtp-Source: AIpwx48qkekjhJCHzvJmZIwEKdAM5hm1gsNYdeflwKF2xut6nkdECrFiZQcu1SdY2Wkmp1TwEzSJfg==
X-Received: by 10.46.89.78 with SMTP id n75mr2101024ljb.139.1523782744968;
        Sun, 15 Apr 2018 01:59:04 -0700 (PDT)
Received: from localhost.localdomain (c-5eea25be-74736162.cust.telenor.se. [94.234.37.190])
        by smtp.gmail.com with ESMTPSA id d4-v6sm2209894lfg.65.2018.04.15.01.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 01:59:04 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, tiago@gitlab.com,
        christian.couder@gmail.com, sbeller@google.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH] Create 'bisect_flags' parameter in find_bisection() in preparation of passing multiple options
Date:   Sun, 15 Apr 2018 10:58:41 +0200
Message-Id: <20180415085841.1269-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---

Notes:
    Preperatory patch to enable either Tiago Botelho's or my patch, to do bisection on first parents / merge commits

 bisect.c           | 21 ++++++++++++---------
 bisect.h           |  5 +++--
 builtin/rev-list.c |  6 +++---
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/bisect.c b/bisect.c
index a579b50884..d85550fd89 100644
--- a/bisect.c
+++ b/bisect.c
@@ -254,7 +254,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights,
-					     int find_all)
+					     int bisect_flags)
 {
 	int n, counted;
 	struct commit_list *p;
@@ -313,7 +313,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		clear_distance(list);
 
 		/* Does it happen to be at exactly half-way? */
-		if (!find_all && halfway(p, nr))
+		if (!(bisect_flags & BISECT_FIND_ALL) && halfway(p, nr))
 			return p;
 		counted++;
 	}
@@ -351,21 +351,21 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 				weight_set(p, weight(q));
 
 			/* Does it happen to be at exactly half-way? */
-			if (!find_all && halfway(p, nr))
+			if (!(bisect_flags & BISECT_FIND_ALL) && halfway(p, nr))
 				return p;
 		}
 	}
 
 	show_list("bisection 2 counted all", counted, nr, list);
 
-	if (!find_all)
+	if (!(bisect_flags & BISECT_FIND_ALL))
 		return best_bisection(list, nr);
 	else
 		return best_bisection_sorted(list, nr);
 }
 
 void find_bisection(struct commit_list **commit_list, int *reaches,
-		    int *all, int find_all)
+		    int *all, int bisect_flags)
 {
 	int nr, on_list;
 	struct commit_list *list, *p, *best, *next, *last;
@@ -400,9 +400,9 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	weights = xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, find_all);
+	best = do_find_bisection(list, nr, weights, bisect_flags);
 	if (best) {
-		if (!find_all) {
+		if (!(bisect_flags & BISECT_FIND_ALL)) {
 			list->item = best->item;
 			free_commit_list(list->next);
 			best = list;
@@ -942,7 +942,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
-	int reaches = 0, all = 0, nr, steps;
+	int reaches = 0, all = 0, bisect_flags = 0, nr, steps;
 	struct object_id *bisect_rev;
 	char *steps_msg;
 
@@ -957,7 +957,10 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	bisect_common(&revs);
 
-	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr);
+	if (skipped_revs.nr)
+		bisect_flags |= BISECT_FIND_ALL;
+
+	find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
diff --git a/bisect.h b/bisect.h
index a5d9248a47..d46b078871 100644
--- a/bisect.h
+++ b/bisect.h
@@ -6,10 +6,10 @@
  * commits that the best commit reaches. `all` will be the count of
  * non-SAMETREE commits. If nothing is found, `list` will be NULL.
  * Otherwise, it will be either all non-SAMETREE commits or the single
- * best commit, as chosen by `find_all`.
+ * best commit, as chosen by flag `BISECT_FIND_ALL`.
  */
 extern void find_bisection(struct commit_list **list, int *reaches, int *all,
-			   int find_all);
+			   int bisect_flags);
 
 extern struct commit_list *filter_skipped(struct commit_list *list,
 					  struct commit_list **tried,
@@ -19,6 +19,7 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
 
 #define BISECT_SHOW_ALL		(1<<0)
 #define REV_LIST_QUIET		(1<<1)
+#define BISECT_FIND_ALL		(1<<2)
 
 struct rev_list_info {
 	struct rev_info *revs;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index fadd3ec14c..88700e897d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -360,7 +360,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int i;
 	int bisect_list = 0;
 	int bisect_show_vars = 0;
-	int bisect_find_all = 0;
+	int bisect_flags = 0;
 	int use_bitmap_index = 0;
 	const char *show_progress = NULL;
 
@@ -426,7 +426,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp(arg, "--bisect-all")) {
 			bisect_list = 1;
-			bisect_find_all = 1;
+			bisect_flags |= BISECT_FIND_ALL;
 			info.flags |= BISECT_SHOW_ALL;
 			revs.show_decorations = 1;
 			continue;
@@ -538,7 +538,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list) {
 		int reaches, all;
 
-		find_bisection(&revs.commits, &reaches, &all, bisect_find_all);
+		find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 
 		if (bisect_show_vars)
 			return show_bisect_vars(&info, reaches, all);
-- 
2.14.3 (Apple Git-98)

