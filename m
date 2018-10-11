Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27DE41F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 01:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeJKIqV (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 04:46:21 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52683 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeJKIqV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 04:46:21 -0400
Received: by mail-pg1-f201.google.com with SMTP id m4-v6so4968432pgq.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 18:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/u5FRCojUz1cRIROJXMKCSuMlIME31s6sEMr+cwGtKs=;
        b=XbprKt0mZXwwOg+bim5WorIVI5V/E06P+42FW64hdNfzoCLhd1H17KSZ/lAroxDVwV
         nNLZJr3CZST02pk/i1qTF4+uryDMVYkJdFkbq6+iTcdoc0xqxXkBaMegMSu3LpdwastP
         rTJxDKzLh410duvpbz4NGTBlnyc4eYF4KouGuJbUq3D1CwJSTONFNfaqmuEa8T910679
         FJFwSLZGiibbUhobpAgvBB5QN+wVPeiEwfB7x7OnC1G1R9vPybjyVhkNbTbM3ay/TS+v
         xxO4R9MNeeN8aJw6aUf3FBL9vqDogi8nJMtTN/5Zn3f+DVskkv7RV2Mbvh2ScGp2NTAC
         s6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/u5FRCojUz1cRIROJXMKCSuMlIME31s6sEMr+cwGtKs=;
        b=WCXUyemgtgHsP241OHJ9DsjC9z1s0kX8tWOQJJLwh3bEviVBwiuV8rPksXe3fLZ0ST
         DlSCzcH3H/Fy6AtE5VqI3FH8THMv1GxTunKQ2pv/Qr0hsHAUfFmAo0tzMei/qdXFV2QL
         J4SE2Td5YXLIvn2W047JJsgln5oG3e4WlPp6qqPX5159cVm4UhSAgfmLPtM8M1imNxBD
         QXH8jF4MPYqkWBNJp6+9Z7CHGLmMt85EdXSKHHaQfOtNtiau0uW8ahMMdThFPSlK19QW
         0XgzbxjjU+5NlH29tPdbGZr722f4PRQlKalQJ6TMLqCnKAN2asV2FyyfXU27XT7FtDr6
         w21Q==
X-Gm-Message-State: ABuFfogkwfAMXlzhgBjD6tHL6qAEfmuIvQrYIMutHtq4gYhhoBzJbmpE
        YlH2dzuRDgUdz1yMGerTmkYUbVqlLh1KuiiJHVBPenJop71+eUEJJ1a1uJEw4+AbTP3gbg0rpMi
        cMaFSsEm0AFalYKFEIzwQfZ5tV78MtjG7oE7MFi0Uop0gimeldAbggKC3obtsfLS7rIUpAqL0+3
        Dg
X-Google-Smtp-Source: ACcGV61TvaXe4GDq4Q/6pzEdnJC/k7OzolKW1DSA2s2kKG5fhvkyQhRtT/sOeKZIjPEBc6JrJt38kfgkoQYelcQmErw/
X-Received: by 2002:a62:2055:: with SMTP id g82-v6mr6143669pfg.28.1539220890713;
 Wed, 10 Oct 2018 18:21:30 -0700 (PDT)
Date:   Wed, 10 Oct 2018 18:21:21 -0700
In-Reply-To: <cover.1539219248.git.jonathantanmy@google.com>
Message-Id: <fb814c65d84f213778be21f49e62da2d959dd964.1539219248.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181009193445.21908-1-szeder.dev@gmail.com> <cover.1539219248.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 2/2] Only make bloom filter for first parent
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        stolee@gmail.com, avarab@gmail.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 commit-graph.c |  4 ++--
 revision.c     | 20 ++++++++++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 90b0b3df90..d21d555611 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -782,9 +782,9 @@ static void fill_bloom_filter(struct bloom_filter *bf,
 
 	for (i = 0; i < commit_nr; i++) {
 		struct commit *commit = commits[i];
-		struct commit_list *parent;
+		struct commit_list *parent = commit->parents;
 
-		for (parent = commit->parents; parent; parent = parent->next)
+		if (parent)
 			add_changes_to_bloom_filter(bf, parent->item, commit, i,
 						    &revs.diffopt);
 
diff --git a/revision.c b/revision.c
index c84a997928..5a433a5878 100644
--- a/revision.c
+++ b/revision.c
@@ -539,11 +539,11 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 }
 
 static int rev_compare_tree(struct rev_info *revs,
-			    struct commit *parent, struct commit *commit)
+			    struct commit *parent, struct commit *commit, int nth_parent)
 {
 	struct tree *t1 = get_commit_tree(parent);
 	struct tree *t2 = get_commit_tree(commit);
-	int bloom_ret;
+	int bloom_ret = 1;
 
 	if (!t1)
 		return REV_TREE_NEW;
@@ -568,17 +568,21 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
-	bloom_ret = check_maybe_different_in_bloom_filter(revs, parent, commit);
-	if (bloom_ret == 0)
-		return REV_TREE_SAME;
+	if (!nth_parent) {
+		bloom_ret = check_maybe_different_in_bloom_filter(revs, parent, commit);
+		if (bloom_ret == 0)
+			return REV_TREE_SAME;
+	}
 
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
 	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
 			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
-	if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
-		bloom_filter_count_false_positive++;
+	if (!nth_parent) {
+		if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
+			bloom_filter_count_false_positive++;
+	}
 	return tree_difference;
 }
 
@@ -776,7 +780,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			die("cannot simplify commit %s (because of %s)",
 			    oid_to_hex(&commit->object.oid),
 			    oid_to_hex(&p->object.oid));
-		switch (rev_compare_tree(revs, p, commit)) {
+		switch (rev_compare_tree(revs, p, commit, nth_parent)) {
 		case REV_TREE_SAME:
 			if (!revs->simplify_history || !relevant_commit(p)) {
 				/* Even if a merge with an uninteresting
-- 
2.19.0.271.gfe8321ec05.dirty

