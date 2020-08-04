Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E261EC433E3
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAB9207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6tr+YhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgHDWBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgHDWB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 18:01:27 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE0BC06179E
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 15:01:26 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v22so26300970qtq.8
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kk7/ry4u1aOxybhFBfiBIK1sa7OKpM/m/efGeRLKYqo=;
        b=d6tr+YhFArzNHRJTlCpM2dK7DLuGbphRoY6vv1zQzxKwZueGSWAs+B4yPOh9v0dViN
         f4ROyO3zqa0EtALOR2blGTNpaK/L5L/+XttoG8j0Phr3JrOZ2J2edKwN86r/KX5Sb8dT
         O4suSdoFCRIB0K+ErGC2DrfX8WjmdJrHGwTxvk/2y7MgQ0ZeYiTkIm3o1SQjGDBhkb4i
         swFNMFwVneIaateRjVXb/R1ue+uCXqWK7D0tQuPAhUoJuDOANmm8ntQQHlBcyWDruFGM
         0mO9U8UJ5Ft0U8J860kWeDS9zk3VzmOIBnP3VHV9W83yQ2hqp73dsgWQ4pAUAJftIKgM
         jJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kk7/ry4u1aOxybhFBfiBIK1sa7OKpM/m/efGeRLKYqo=;
        b=U081GjV8nRBwayZqYEPtn98yuFcxk0itPNN6TJsssQxSf/OZUJQT4EmErz6nWIuQOl
         xiZwHNeZv+9dMBhw7c1cACDoQkG1XBG2/xpvslWPx3YjQotmt6HS5T+WVnBo6KTce7Nk
         GxzKIji/YUMoHuN74EW6FYK0zYdnQnbULN1xolpmtk+EryosSvxqODGHCia639ILGNOv
         SKuLdog3S8ZFn51CXL/dMN8axX9jlJ21kcbqsDUn1VVPuYc/Ei6HYAt+QlUnDMx/+XPI
         /V3/zyP18c/Ie2MraVrn7ocTuNDoS1T90H4voSXbjftTZeG+Ifift3XaybTEtEb9+oYB
         Rplg==
X-Gm-Message-State: AOAM530Tk4pKxgLAWvQIEVwxMA3stTBZW6fM+AxJxKJgPkiacdIXGi/V
        tvNENXmZ/jMyBnzZcbfziIBHw8B3f/obuQ==
X-Google-Smtp-Source: ABdhPJyDHOELY20FmC+ZVLc64SCtAqpDKvD3lXP+2tdL7IkAD3k5E+y/gmm8GVtYzEp18nzD8TfqSQ==
X-Received: by 2002:ac8:118d:: with SMTP id d13mr186208qtj.87.1596578485650;
        Tue, 04 Aug 2020 15:01:25 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id n33sm231724qtd.43.2020.08.04.15.01.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 15:01:24 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v4 5/5] bisect: combine args passed to find_bisection()
Date:   Tue,  4 Aug 2020 18:01:13 -0400
Message-Id: <20200804220113.5909-6-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200804220113.5909-1-alipman88@gmail.com>
References: <20200801175840.1877-1-alipman88@gmail.com>
 <20200804220113.5909-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that find_bisection() accepts multiple boolean arguments, these may
be combined into a single unsigned integer in order to declutter some of
the code in bisect.c

Also, rename the existing "flags" bitfield to "commit_flags", to
explicitly differentiate it from the new "bisect_flags" bitfield.

Based-on-patch-by: Harald Nordgren <haraldnordgren@gmail.com>
Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 bisect.c           | 67 +++++++++++++++++++++++++---------------------
 bisect.h           |  5 +++-
 builtin/rev-list.c |  9 ++++++-
 3 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/bisect.c b/bisect.c
index bc4241b51f..1585fcc6ad 100644
--- a/bisect.c
+++ b/bisect.c
@@ -89,7 +89,7 @@ static inline void weight_set(struct commit_list *elem, int weight)
 	**commit_weight_at(&commit_weight, elem->item) = weight;
 }
 
-static int count_interesting_parents(struct commit *commit, int first_parent_only)
+static int count_interesting_parents(struct commit *commit, unsigned bisect_flags)
 {
 	struct commit_list *p;
 	int count;
@@ -97,7 +97,7 @@ static int count_interesting_parents(struct commit *commit, int first_parent_onl
 	for (count = 0, p = commit->parents; p; p = p->next) {
 		if (!(p->item->object.flags & UNINTERESTING))
 			count++;
-		if (first_parent_only)
+		if (bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY)
 			break;
 	}
 	return count;
@@ -137,7 +137,7 @@ static void show_list(const char *debug, int counted, int nr,
 	for (p = list; p; p = p->next) {
 		struct commit_list *pp;
 		struct commit *commit = p->item;
-		unsigned flags = commit->object.flags;
+		unsigned commit_flags = commit->object.flags;
 		enum object_type type;
 		unsigned long size;
 		char *buf = read_object_file(&commit->object.oid, &type,
@@ -146,9 +146,9 @@ static void show_list(const char *debug, int counted, int nr,
 		int subject_len;
 
 		fprintf(stderr, "%c%c%c ",
-			(flags & TREESAME) ? ' ' : 'T',
-			(flags & UNINTERESTING) ? 'U' : ' ',
-			(flags & COUNTED) ? 'C' : ' ');
+			(commit_flags & TREESAME) ? ' ' : 'T',
+			(commit_flags & UNINTERESTING) ? 'U' : ' ',
+			(commit_flags & COUNTED) ? 'C' : ' ');
 		if (*commit_weight_at(&commit_weight, p->item))
 			fprintf(stderr, "%3d", weight(p));
 		else
@@ -173,9 +173,9 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
 	best = list;
 	for (p = list; p; p = p->next) {
 		int distance;
-		unsigned flags = p->item->object.flags;
+		unsigned commit_flags = p->item->object.flags;
 
-		if (flags & TREESAME)
+		if (commit_flags & TREESAME)
 			continue;
 		distance = weight(p);
 		if (nr - distance < distance)
@@ -214,9 +214,9 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 
 	for (p = list, cnt = 0; p; p = p->next) {
 		int distance;
-		unsigned flags = p->item->object.flags;
+		unsigned commit_flags = p->item->object.flags;
 
-		if (flags & TREESAME)
+		if (commit_flags & TREESAME)
 			continue;
 		distance = weight(p);
 		if (nr - distance < distance)
@@ -261,7 +261,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights,
-					     int find_all, int first_parent_only)
+					     unsigned bisect_flags)
 {
 	int n, counted;
 	struct commit_list *p;
@@ -270,12 +270,12 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 
 	for (n = 0, p = list; p; p = p->next) {
 		struct commit *commit = p->item;
-		unsigned flags = commit->object.flags;
+		unsigned commit_flags = commit->object.flags;
 
 		*commit_weight_at(&commit_weight, p->item) = &weights[n++];
-		switch (count_interesting_parents(commit, first_parent_only)) {
+		switch (count_interesting_parents(commit, bisect_flags)) {
 		case 0:
-			if (!(flags & TREESAME)) {
+			if (!(commit_flags & TREESAME)) {
 				weight_set(p, 1);
 				counted++;
 				show_list("bisection 2 count one",
@@ -316,13 +316,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			continue;
 		if (weight(p) != -2)
 			continue;
-		if (first_parent_only)
+		if (bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY)
 			BUG("shouldn't be calling count-distance in fp mode");
 		weight_set(p, count_distance(p));
 		clear_distance(list);
 
 		/* Does it happen to be at exactly half-way? */
-		if (!find_all && halfway(p, nr))
+		if (!(bisect_flags & FIND_BISECTION_ALL) && halfway(p, nr))
 			return p;
 		counted++;
 	}
@@ -332,14 +332,14 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	while (counted < nr) {
 		for (p = list; p; p = p->next) {
 			struct commit_list *q;
-			unsigned flags = p->item->object.flags;
+			unsigned commit_flags = p->item->object.flags;
 
 			if (0 <= weight(p))
 				continue;
 
 			for (q = p->item->parents;
 			     q;
-			     q = first_parent_only ? NULL : q->next) {
+			     q = bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY ? NULL : q->next) {
 				if (q->item->object.flags & UNINTERESTING)
 					continue;
 				if (0 <= weight(q))
@@ -353,7 +353,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			 * add one for p itself if p is to be counted,
 			 * otherwise inherit it from q directly.
 			 */
-			if (!(flags & TREESAME)) {
+			if (!(commit_flags & TREESAME)) {
 				weight_set(p, weight(q)+1);
 				counted++;
 				show_list("bisection 2 count one",
@@ -363,21 +363,21 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 				weight_set(p, weight(q));
 
 			/* Does it happen to be at exactly half-way? */
-			if (!find_all && halfway(p, nr))
+			if (!(bisect_flags & FIND_BISECTION_ALL) && halfway(p, nr))
 				return p;
 		}
 	}
 
 	show_list("bisection 2 counted all", counted, nr, list);
 
-	if (!find_all)
+	if (!(bisect_flags & FIND_BISECTION_ALL))
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
@@ -393,16 +393,16 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	for (nr = on_list = 0, last = NULL, p = *commit_list;
 	     p;
 	     p = next) {
-		unsigned flags = p->item->object.flags;
+		unsigned commit_flags = p->item->object.flags;
 
 		next = p->next;
-		if (flags & UNINTERESTING) {
+		if (commit_flags & UNINTERESTING) {
 			free(p);
 			continue;
 		}
 		p->next = last;
 		last = p;
-		if (!(flags & TREESAME))
+		if (!(commit_flags & TREESAME))
 			nr++;
 		on_list++;
 	}
@@ -413,9 +413,9 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	weights = xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, find_all, first_parent_only);
+	best = do_find_bisection(list, nr, weights, bisect_flags);
 	if (best) {
-		if (!find_all) {
+		if (!(bisect_flags & FIND_BISECTION_ALL)) {
 			list->item = best->item;
 			free_commit_list(list->next);
 			best = list;
@@ -1000,23 +1000,30 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	struct object_id *bisect_rev;
 	char *steps_msg;
 	int no_checkout = ref_exists("BISECT_HEAD");
-	int first_parent_only = file_exists(git_path_bisect_first_parent());
+	unsigned bisect_flags = 0;
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
 		die(_("reading bisect refs failed"));
 
+	if (file_exists(git_path_bisect_first_parent()))
+		bisect_flags |= FIND_BISECTION_FIRST_PARENT_ONLY;
+
+	if (skipped_revs.nr)
+		bisect_flags |= FIND_BISECTION_ALL;
+
 	res = check_good_are_ancestors_of_bad(r, prefix, no_checkout);
 	if (res)
 		return res;
 
 	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
-	revs.first_parent_only = first_parent_only;
+
+	revs.first_parent_only = !!(bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY);
 	revs.limited = 1;
 
 	bisect_common(&revs);
 
-	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr, first_parent_only);
+	find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
diff --git a/bisect.h b/bisect.h
index 7f30b94db3..ec24ac2d7e 100644
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
 
+#define FIND_BISECTION_ALL			(1u<<0)
+#define FIND_BISECTION_FIRST_PARENT_ONLY	(1u<<1)
+
 struct rev_list_info {
 	struct rev_info *revs;
 	int flags;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d1a14596b2..25c6c3b38d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -637,8 +637,15 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if (bisect_list) {
 		int reaches, all;
+		unsigned bisect_flags = 0;
 
-		find_bisection(&revs.commits, &reaches, &all, bisect_find_all, revs.first_parent_only);
+		if (bisect_find_all)
+			bisect_flags |= FIND_BISECTION_ALL;
+
+		if (revs.first_parent_only)
+			bisect_flags |= FIND_BISECTION_FIRST_PARENT_ONLY;
+
+		find_bisection(&revs.commits, &reaches, &all, bisect_flags);
 
 		if (bisect_show_vars)
 			return show_bisect_vars(&info, reaches, all);
-- 
2.24.3 (Apple Git-128)

