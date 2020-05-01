Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05361C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC0120757
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWcGvdkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgEAOWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 10:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728981AbgEAOW3 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 10:22:29 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349A9C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 07:22:29 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c16so4575720ilr.3
        for <git@vger.kernel.org>; Fri, 01 May 2020 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sxrqC9kfpPqHe+K0S++RNwAVn6+nW+FoBCLW5v/3xW8=;
        b=VWcGvdkRuLfuFYp21WGmjSU1G0a+IrbReTPk8+Upz935epyDKD0A4HEHwmVdmeptXH
         n0Axem7g/30KXP2RsYI4SyayWuALnBIPu/dfgkVHuuxq4vHhG+5965fQTnW1vx70jh5u
         fu4YBUmyPBUtyGF/TQ2Fld0jdCVQzJoCRZOldeqgMR/Mt65tb1UhMpYf6sw13d2E3IyU
         JhgQaD7Q2yhFPQy5wq3VPdVtCVspKv/xwYcbIFcdMpxth1f6HTmpVFHTpR89TYxrKnho
         /BHMyc6gLDORPQTspAJz9WUvhxfMgCwBcu7uVhiIYI8igphOkN6fvmqDtey1fPuYFevC
         SdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sxrqC9kfpPqHe+K0S++RNwAVn6+nW+FoBCLW5v/3xW8=;
        b=WTeuI8+YeAuxR4mN/11TsC2qA6t2q6SLLrFVm99YHExn50prnSDQMZOKSDYn78I7/I
         gDMG7zsAnhKBsMrtDNtr4rBqOG/b907I6BVPNgwxGgjwvS+BImitWLdSr/qiNpSSdpep
         154TzUJh/Cw5KCq9T86JzsqIU771cKL17RrJrF/VMdqyzk7bB9E54o8OBfku/lMNFmEd
         Z6k+ebjxI+fTuttNING1vLlOjxM9FQlaD2D21f2s6H9wAcuYPzXxGfXWQGFvjRMA/kgz
         JBhH2YHmx+NGjTI/WanIArQzyOZ6IWpSCsMKgVp0s+e/581pJWTyR9jFMi4dkJYz46av
         NxHg==
X-Gm-Message-State: AGi0PuaDrdsEhdx9BDPGZI8S4tb2XS9flGu0Mv5X5YLBb30hGZYstNKT
        Yz7QWpS8NLlSrnyDre8YLz0=
X-Google-Smtp-Source: APiQypLoKNKEjCObHtMttrxxPr3Y7hHf7bzCf0UGtWoWfhZQl1hg/bJ8W8NSmlI3HIIb8USJsfVuzQ==
X-Received: by 2002:a92:dc43:: with SMTP id x3mr4051425ilq.102.1588342948504;
        Fri, 01 May 2020 07:22:28 -0700 (PDT)
Received: from ?IPv6:2601:8c0:37f:6012:e01d:d556:c354:b051? ([2601:8c0:37f:6012:e01d:d556:c354:b051])
        by smtp.gmail.com with ESMTPSA id e89sm1314174ill.26.2020.05.01.07.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 07:22:28 -0700 (PDT)
Subject: [PATCH 2/3 v3] Teach git-rev-list --ignore-merge-bases
From:   Antonio Russo <antonio.e.russo@gmail.com>
To:     git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
 <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
Message-ID: <1716d20d-6f0d-3872-cf36-6fc8d7bdb457@gmail.com>
Date:   Fri, 1 May 2020 08:22:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new option simplifies the graph of commits for merges.  Commits are
shown before their parents, but edges from those commits to commits
reachable from the first parent are removed.  Being disconnected from
the branch from which they were forked, these amputated merges
effectively lose all information about their merge base.

When used with --graph, this amputation can dramatically reduce the
width of the displayed graph and the total time taken to draw all
output.

The implementation traverses all reachable commits with a
depth-first-search to produce a spanning tree.

Signed-off-by: Antonio Russo <antonio.e.russo@gmail.com>
---
 Documentation/rev-list-options.txt |  9 ++++
 object.h                           |  2 +-
 revision.c                         | 85 ++++++++++++++++++++++++++++++
 revision.h                         |  5 ++
 4 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 04ad7dd36e..3f5d196985 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -363,6 +363,15 @@ Default mode::
 	merges from the resulting history, as there are no selected
 	commits contributing to this merge.

+--ignore-merge-bases::
+	Show commits that are introduced by each merge before showing
+	the first parent of the merge but remove edges from those commits
+	to commits reachable from the first parent. When used with
+	`--graph`, this can help visualize repositories with many merges
+	when you are not interested in the merge base used for each
+	merge. It also reduces the width of the graph visualization
+	when used with `--graph`.
+
 --ancestry-path::
 	When given a range of commits to display (e.g. 'commit1..commit2'
 	or 'commit2 {caret}commit1'), only display commits that exist
diff --git a/object.h b/object.h
index b22328b838..0bf6fb0d55 100644
--- a/object.h
+++ b/object.h
@@ -59,7 +59,7 @@ struct object_array {

 /*
  * object flag allocation:
- * revision.h:               0---------10         15                   25----28
+ * revision.h:               0---------10         15                   23----28
  * fetch-pack.c:             01
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
diff --git a/revision.c b/revision.c
index 5bc96444b6..ae81175e34 100644
--- a/revision.c
+++ b/revision.c
@@ -2082,6 +2082,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->simplify_by_decoration = 1;
 		revs->limited = 1;
 		revs->prune = 1;
+	} else if (!strcmp(arg, "--ignore-merge-bases")) {
+		revs->limited = 1;
+		revs->ignore_merge_bases = 1;
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->sort_order = REV_SORT_BY_COMMIT_DATE;
 		revs->topo_order = 1;
@@ -3095,6 +3098,86 @@ static void simplify_merges(struct rev_info *revs)
 	}
 }

+static void cleanup_ignore_merge_bases(struct commit *commit) {
+	struct commit_list *stack;
+	struct commit_list *parents;
+	stack = NULL;
+
+	commit_list_insert(commit, &stack);
+	while (stack) {
+		commit = pop_commit(&stack);
+		commit->object.flags &= !IGN_MRG_BASES_VISITING;
+
+		parents = commit->parents;
+		for (parents = commit->parents; parents; parents = parents->next)
+			commit_list_insert(parents->item, &stack);
+	}
+}
+
+static void do_ignore_merge_bases(struct commit *commit) {
+	struct commit_list *stack, *list_lr;
+	struct commit_list **parents;
+	struct commit *parent;
+	stack = NULL;
+	list_lr = NULL;
+
+	/* process every commit to be displayed exactly once */
+	commit_list_insert(commit, &stack);
+	commit->object.flags |= IGN_MRG_BASES_VISITED | IGN_MRG_BASES_VISITING;
+	while (stack) {
+		commit = pop_commit(&stack);
+		/*
+		 * process the parent nodes: removing links to
+		 * commits already visited (creating a spanning tree)
+		 */
+		parents = &(commit->parents);
+		while (*parents) {
+			parent = (*parents)->item;
+			if (parent->object.flags & IGN_MRG_BASES_VISITING) {
+				/*
+				 * We have already visited this commit, from the same root.
+				 * We do not explore it at all.
+				 */
+				pop_commit(parents);
+				continue;
+			}
+			if (!(parent->object.flags & IGN_MRG_BASES_VISITED)) {
+				/*
+				 * If we visited this commit before, but from a different root,
+				 * leave it attached, but do not explore it further.
+				 *
+				 * If we have not visited this commit yet, explore it, as usual.
+				 */
+				parent->object.flags |= IGN_MRG_BASES_VISITED | IGN_MRG_BASES_VISITING;
+				commit_list_insert(parent, &list_lr);
+			}
+			parents = &((*parents)->next);
+		}
+
+		/*
+		 * Feed the parents, right to left (reversed) onto the
+		 * stack to do a depth-first traversal of the commit graph.
+		 */
+		while (list_lr)
+			commit_list_insert(pop_commit(&list_lr), &stack);
+	}
+}
+
+static void ignore_merge_bases(struct rev_info *revs)
+{
+	struct commit_list *iter_list;
+	struct commit *prev = NULL;
+
+	for (iter_list = revs->commits; iter_list; iter_list = iter_list->next) {
+		if (iter_list->item->object.flags & IGN_MRG_BASES_VISITED)
+			continue;
+		if (prev)
+			cleanup_ignore_merge_bases(prev);
+		prev = iter_list->item;
+		do_ignore_merge_bases(prev);
+	}
+}
+
 static void set_children(struct rev_info *revs)
 {
 	struct commit_list *l;
@@ -3392,6 +3475,8 @@ int prepare_revision_walk(struct rev_info *revs)
 	if (revs->limited) {
 		if (limit_list(revs) < 0)
 			return -1;
+		if (revs->ignore_merge_bases)
+			ignore_merge_bases(revs);
 		if (revs->topo_order)
 			sort_in_topological_order(&revs->commits, revs->sort_order);
 	} else if (revs->topo_order)
diff --git a/revision.h b/revision.h
index c1af164b30..93b318b304 100644
--- a/revision.h
+++ b/revision.h
@@ -37,6 +37,10 @@

 /* WARNING: This is also used as REACHABLE in commit-graph.c. */
 #define PULL_MERGE	(1u<<15)
+
+#define IGN_MRG_BASES_VISITED	(1u<<23)
+#define IGN_MRG_BASES_VISITING	(1u<<24)
+
 /*
  * Indicates object was reached by traversal. i.e. not given by user on
  * command-line or stdin.
@@ -132,6 +136,7 @@ struct rev_info {
 			no_walk:2,
 			remove_empty_trees:1,
 			simplify_history:1,
+			ignore_merge_bases:1,
 			show_pulls:1,
 			topo_order:1,
 			simplify_merges:1,
-- 
2.26.2

