Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A68C433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19FC2074B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc2gQ2Rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgG3A1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgG3A1r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 20:27:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC6EC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:27:47 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j187so24078812qke.11
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oU2ejGl4W9fONXvfZmpLyiRXsg8+yV90Da+ZU+TPRsY=;
        b=nc2gQ2Rlacj+1G+xJDcS278c6PgzMX1D/LSrH4UD7mqcXBc4k00V+vLRhRWMlNJ2ZX
         EHhITq1xlTw6Gk5LvS5zadOt6l91z1l+s7nrb55fJYIrepiWqvmXAJDtvIit0qy1H0ib
         49lhgBFKYubJJYIIiLD1fpeoReTkfHK7kg5OVjSNI6y2BUnpsP3RFK4sF2ROMaXATH7h
         fCOg5NCHUxmxmRHqkMnNl7xFPMXyIixo2hgIq/F9bkcDkwKxv7RjJHM4KeNjDoA3m6el
         u52ScLB+rQTJ00UqG5HlSJjI3e9H+2Yf5ZK1sbXkVqfO+GmeWYfh39idA/QrQX9zcleE
         /Ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oU2ejGl4W9fONXvfZmpLyiRXsg8+yV90Da+ZU+TPRsY=;
        b=rEZG9pPb4xVBXABfgL2Z3RWJQUE8b65+D7Dn50q3/cjwlaYRHNhq+FjWI03u+QUKtF
         ooz6GNSLrUP4Hg/A+t55veBJytH44BNcGNZE4I7iHelBvi4FZQ8k9914Z1ZNfcN5Avac
         StBBjQL7y7xYNxQGGpdX29YRRVLFtZvYqR3e5nRy9q+C2EWI6aBaznyGnb5HRaHJdF57
         81AafuWMmPBiqCDaqMFfVHmrnBTzktFh9zd1SFI5vadRQ9FT/FBGSQcHQgKNm7/nc3+k
         eVjFuyCegnjFmeNM93Zdps8SN2cCa7LK7lr0TEeE3IGxjb61rrY9m9TqR1PSA9AQIwjO
         1Ohw==
X-Gm-Message-State: AOAM532iUvBmW1UYQLsrHumUox+7CpM/Fg5uJV72VDT+U+mOZeMUCDlX
        5lY8dq7/95fPu4aPl47ti8pbDrPkK2E=
X-Google-Smtp-Source: ABdhPJy584D2i04tWHQyA660WrNkK8PKgr+Xg4OANmR0LmnxhFkB0voEak/AerJCzinC2SxSUli1mQ==
X-Received: by 2002:a37:8286:: with SMTP id e128mr36168971qkd.101.1596068866010;
        Wed, 29 Jul 2020 17:27:46 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id m32sm3239391qtd.94.2020.07.29.17.27.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 17:27:45 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v2 3/3] bisect: combine args passed to find_bisection()
Date:   Wed, 29 Jul 2020 20:27:35 -0400
Message-Id: <20200730002735.87655-4-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200730002735.87655-1-alipman88@gmail.com>
References: <pull.686.git.1595951056.gitgitgadget@gmail.com>
 <20200730002735.87655-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that find_bisection() accepts multiple boolean arguments, these may
be combined into a single unsigned integer in order to declutter some of
the code in bisect.c

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
Based-on-patch-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 bisect.c           | 37 ++++++++++++++++++++++---------------
 bisect.h           |  5 ++++-
 builtin/rev-list.c |  9 ++++++++-
 3 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/bisect.c b/bisect.c
index b495a19192..07a7760a72 100644
--- a/bisect.c
+++ b/bisect.c
@@ -88,7 +88,7 @@ static inline void weight_set(struct commit_list *elem, int weight)
 	**commit_weight_at(&commit_weight, elem->item) = weight;
 }
 
-static int count_interesting_parents(struct commit *commit, int first_parent_only)
+static int count_interesting_parents(struct commit *commit, unsigned bisect_flags)
 {
 	struct commit_list *p;
 	int count;
@@ -96,7 +96,7 @@ static int count_interesting_parents(struct commit *commit, int first_parent_onl
 	for (count = 0, p = commit->parents; p; p = p->next) {
 		if (!(p->item->object.flags & UNINTERESTING))
 			count++;
-		if (first_parent_only)
+		if (bisect_flags & BISECT_FIRST_PARENT)
 			break;
 	}
 	return count;
@@ -260,7 +260,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights,
-					     int find_all, int first_parent_only)
+					     unsigned bisect_flags)
 {
 	int n, counted;
 	struct commit_list *p;
@@ -272,7 +272,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		unsigned flags = commit->object.flags;
 
 		*commit_weight_at(&commit_weight, p->item) = &weights[n++];
-		switch (count_interesting_parents(commit, first_parent_only)) {
+		switch (count_interesting_parents(commit, bisect_flags)) {
 		case 0:
 			if (!(flags & TREESAME)) {
 				weight_set(p, 1);
@@ -315,13 +315,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			continue;
 		if (weight(p) != -2)
 			continue;
-		if (first_parent_only)
+		if (bisect_flags & BISECT_FIRST_PARENT)
 			BUG("shouldn't be calling count-distance in fp mode");
 		weight_set(p, count_distance(p));
 		clear_distance(list);
 
 		/* Does it happen to be at exactly half-way? */
-		if (!find_all && halfway(p, nr))
+		if (!(bisect_flags & BISECT_FIND_ALL) && halfway(p, nr))
 			return p;
 		counted++;
 	}
@@ -338,7 +338,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 
 			for (q = p->item->parents;
 			     q;
-			     q = first_parent_only ? NULL : q->next) {
+			     q = bisect_flags & BISECT_FIRST_PARENT ? NULL : q->next) {
 				if (q->item->object.flags & UNINTERESTING)
 					continue;
 				if (0 <= weight(q))
@@ -362,21 +362,21 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
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
-		    int *all, int find_all, int first_parent_only)
+		    int *all, unsigned bisect_flags)
 {
 	int nr, on_list;
 	struct commit_list *list, *p, *best, *next, *last;
@@ -412,9 +412,9 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	weights = xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, find_all, first_parent_only);
+	best = do_find_bisection(list, nr, weights, bisect_flags);
 	if (best) {
-		if (!find_all) {
+		if (!(bisect_flags & BISECT_FIND_ALL)) {
 			list->item = best->item;
 			free_commit_list(list->next);
 			best = list;
@@ -1004,23 +1004,30 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 	enum bisect_error res = BISECT_OK;
 	struct object_id *bisect_rev;
 	char *steps_msg;
-	int first_parent_only = read_first_parent_option();
+	unsigned bisect_flags = 0;
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
 		die(_("reading bisect refs failed"));
 
+	if (read_first_parent_option())
+		bisect_flags |= BISECT_FIRST_PARENT;
+
+	if (!!skipped_revs.nr)
+		bisect_flags |= BISECT_FIND_ALL;
+
 	res = check_good_are_ancestors_of_bad(r, prefix, no_checkout);
 	if (res)
 		return res;
 
 	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
-	revs.first_parent_only = first_parent_only;
+
+	revs.first_parent_only = !!(bisect_flags & BISECT_FIRST_PARENT);
 	revs.limited = 1;
 
 	bisect_common(&revs);
 
-	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr, first_parent_only);
+	find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
diff --git a/bisect.h b/bisect.h
index 8ee80f5b48..402ddcfb5e 100644
--- a/bisect.h
+++ b/bisect.h
@@ -12,7 +12,7 @@ struct repository;
  * best commit, as chosen by `find_all`.
  */
 void find_bisection(struct commit_list **list, int *reaches, int *all,
-		    int find_all, int first_parent_only);
+		    unsigned bisect_flags);
 
 struct commit_list *filter_skipped(struct commit_list *list,
 				   struct commit_list **tried,
@@ -23,6 +23,9 @@ struct commit_list *filter_skipped(struct commit_list *list,
 #define BISECT_SHOW_ALL		(1<<0)
 #define REV_LIST_QUIET		(1<<1)
 
+#define BISECT_FIND_ALL		(1u<<0)
+#define BISECT_FIRST_PARENT	(1u<<1)
+
 struct rev_list_info {
 	struct rev_info *revs;
 	int flags;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d1a14596b2..1536ea6f28 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -637,8 +637,15 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if (bisect_list) {
 		int reaches, all;
+		unsigned bisect_flags = 0;
 
-		find_bisection(&revs.commits, &reaches, &all, bisect_find_all, revs.first_parent_only);
+		if (bisect_find_all)
+			bisect_flags |= BISECT_FIND_ALL;
+
+		if (revs.first_parent_only)
+			bisect_flags |= BISECT_FIRST_PARENT;
+
+		find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 
 		if (bisect_show_vars)
 			return show_bisect_vars(&info, reaches, all);
-- 
2.24.3 (Apple Git-128)

