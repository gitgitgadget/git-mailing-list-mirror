Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1592EC83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 08:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF0A20787
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 08:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxeTvsrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgD2IBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbgD2IBc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 04:01:32 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21F5C03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 01:01:31 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id x2so1497683ilp.13
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 01:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f1+E1JsVOpIru4Y9uxEBcCDV6eWow2CyY5Jv7XdYFvU=;
        b=FxeTvsrXEQYwUkW6gb0Qr8iu6fBkaiTJVLaU1DYEl7mYpXsK3Oz5sjU5xVZT8an49g
         8LRzsUfQ3XLO1ZckWkf2fHem3A8f7egkQ8l9LnvJwWJj6N4aj6t7ld5jZvBk6PEK9ygd
         pHafCP/MdJRnpd+l6K9e+JDs7iOYWBnJQEPcj3/GXN4Y2Yo4/4Y0li8hxpnAWwfsZRxT
         aCEXA87wzD039i0eIV+xD3BkQBRLndRJnJ4tWIQq3I+eam0vNhI4+2mdTc9tIi78Ek56
         WEW4SoXgeA8kQ1HneAeB9Z/U/S4MuiE+Ds6QUq1VVk3SqlqdEU6biGgfB4aiqdOu8Uas
         JuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f1+E1JsVOpIru4Y9uxEBcCDV6eWow2CyY5Jv7XdYFvU=;
        b=ecKAWWTyZWqOLG2Ar65iuMt+S+hnWkk3DD/gZpuGFuj9e5djAGZvrw2OcRXFAmvaAX
         QN6otkni2iFjBTWi1/o4KuAjgmH1dr8TLmPFwh8KwJQv7onXDReyA0nfwmpHGkYbVkWk
         1lqnYi4N6ZP4137LiGun8xz3RJtE/wJ2r5kayQIKO0pXDXjbd2cfc1/zzp+3ONI27++Y
         y/R25kvQ+Leq3kPHgJzyIWNQhxy+eC73ZyNh9LKw0MDAo1STkpyE8CLY/Gw6fpL3u/Bf
         33fpH2Ez0DCPuuQwZQMSt0aGlIb81/uUH2qjCl31cgsauNf93bYnLZ0Jms1w6BMdb2uv
         v9Qg==
X-Gm-Message-State: AGi0PuYr0yRvrbaLgDXPSj7xXsXz5zYEg8pVvXOyYbvFmrC25pceXbEG
        RJ9koHW62QwPwkxzPc+nbfIW4PM4GvU=
X-Google-Smtp-Source: APiQypKKNJajHbD1fe92VIeKuybGmG8CF5EWW5qlcCIKnmetsSMrB8tgYqxdr4+iLHJueXUPFSr9uA==
X-Received: by 2002:a92:d94b:: with SMTP id l11mr31531006ilq.114.1588147290231;
        Wed, 29 Apr 2020 01:01:30 -0700 (PDT)
Received: from ?IPv6:2601:8c0:37f:6012:b42c:57cd:fff4:b8c7? ([2601:8c0:37f:6012:b42c:57cd:fff4:b8c7])
        by smtp.gmail.com with ESMTPSA id w7sm527287ior.51.2020.04.29.01.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 01:01:29 -0700 (PDT)
Subject: [PATCH v2] Teach git-rev-list --simplify-forks
From:   Antonio Russo <antonio.e.russo@gmail.com>
To:     git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
Message-ID: <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
Date:   Wed, 29 Apr 2020 02:01:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When used with --graph, instead of displaying the full graph, display a
spanning subgraph produced by a depth-first search of the graph visiting
parents from left to right.  Edges to already visited commits are
discarded.  This process is repeated for every commit to be displayed.

This is valuable to reduce visual clutter when there are many merges
that were not rebased onto each other and the user is primarily
interested in the state of the branch being merged into.

Also adds documentation and tests of the above.

Signed-off-by: Antonio Russo <antonio.e.russo@gmail.com>
---
 Documentation/rev-list-options.txt         |  8 +++
 revision.c                                 | 62 ++++++++++++++++++++++
 revision.h                                 |  6 +++
 t/t6016-rev-list-graph-simplify-history.sh | 50 +++++++++++++++++
 4 files changed, 126 insertions(+)

Hello,

This second revision of the patch sets revs->limited.  This forces the
graph of commits to be loaded, and simplfiy_forks() therefore reliably
traverses it.  This addresses the test failures mentioned before (see [1]).

Antonio

[1] https://travis-ci.org/github/aerusso/git/builds/680894920

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 04ad7dd36e..cbac09028c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -363,6 +363,14 @@ Default mode::
 	merges from the resulting history, as there are no selected
 	commits contributing to this merge.

+--simplify-forks::
+	Convert the commit graph into a spanning subgraph produced by a
+	depth-first-search of the history graph, searching the leftmost
+	parent first, and discarding edges to commits already visited.
+	Useful with `--graph` to visualize repositories with many merges
+	when you are interested in was added to master, and not when the
+	branch was last rebased.
+
 --ancestry-path::
 	When given a range of commits to display (e.g. 'commit1..commit2'
 	or 'commit2 {caret}commit1'), only display commits that exist
diff --git a/revision.c b/revision.c
index 5bc96444b6..51dbe21847 100644
--- a/revision.c
+++ b/revision.c
@@ -2082,6 +2082,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->simplify_by_decoration = 1;
 		revs->limited = 1;
 		revs->prune = 1;
+	} else if (!strcmp(arg, "--simplify-forks")) {
+		revs->limited = 1;
+		revs->simplify_forks = 1;
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->sort_order = REV_SORT_BY_COMMIT_DATE;
 		revs->topo_order = 1;
@@ -3095,6 +3098,63 @@ static void simplify_merges(struct rev_info *revs)
 	}
 }

+static void simplify_forks(struct rev_info *revs)
+{
+	struct commit_list *stack, *list_lr, *iter_list;
+	struct commit_list **parents;
+	struct commit *commit, *parent;
+
+	stack = NULL;
+	list_lr = NULL;
+
+	clear_object_flags(SIMP_FORK_VISITED);
+
+	for(iter_list = revs->commits; iter_list; iter_list = iter_list->next) {
+		/* process every commit to be displayed exactly once */
+		if(iter_list->item->object.flags & SIMP_FORK_VISITED)
+			continue;
+		clear_object_flags(SIMP_FORK_VISITING);
+		commit_list_insert(iter_list->item, &stack);
+		iter_list->item->object.flags |= SIMP_FORK_VISITED | SIMP_FORK_VISITING;
+		while(stack) {
+			commit = pop_commit(&stack);
+			/* process the parent nodes: removing links to
+			 * commits already visited (creating a spanning tree)
+			 */
+			parents = &(commit->parents);
+			while(*parents) {
+				parent = (*parents)->item;
+				if(parent->object.flags & SIMP_FORK_VISITING) {
+					/* We have already visited this commit, from the same root.
+					 * We do not explore it at all.
+					 */
+					pop_commit(parents);
+				} else if(parent->object.flags & SIMP_FORK_VISITED) {
+					/* We visited this commit before, but from a different root.
+					 * Leave it attached, but do not explore it further.
+					 */
+					parents = &((*parents)->next);
+				} else {
+					/* We have not visited this commit yet. Explore it, as usual.
+					 */
+					parent->object.flags |= SIMP_FORK_VISITED | SIMP_FORK_VISITING;
+					commit_list_insert(parent, &list_lr);
+					parents = &((*parents)->next);
+				}
+			}
+
+			/* feed the parents, right to left (reversed) onto the
+			 * stack to do a depth-first traversal of the commit graph
+			 */
+			while(list_lr) {
+				commit_list_insert(pop_commit(&list_lr), &stack);
+			}
+		}
+	}
+
+	clear_object_flags(SIMP_FORK_VISITED | SIMP_FORK_VISITING);
+}
+
 static void set_children(struct rev_info *revs)
 {
 	struct commit_list *l;
@@ -3392,6 +3452,8 @@ int prepare_revision_walk(struct rev_info *revs)
 	if (revs->limited) {
 		if (limit_list(revs) < 0)
 			return -1;
+		if (revs->simplify_forks)
+			simplify_forks(revs);
 		if (revs->topo_order)
 			sort_in_topological_order(&revs->commits, revs->sort_order);
 	} else if (revs->topo_order)
diff --git a/revision.h b/revision.h
index c1af164b30..f1abdb26b0 100644
--- a/revision.h
+++ b/revision.h
@@ -51,6 +51,11 @@
 #define TOPO_WALK_EXPLORED	(1u<<27)
 #define TOPO_WALK_INDEGREE	(1u<<28)

+/* Re-use the TOPO_WALK flagspace for simplify_forks
+ */
+#define SIMP_FORK_VISITED	(1u<<27)
+#define SIMP_FORK_VISITING	(1u<<28)
+
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2

@@ -132,6 +137,7 @@ struct rev_info {
 			no_walk:2,
 			remove_empty_trees:1,
 			simplify_history:1,
+			simplify_forks:1,
 			show_pulls:1,
 			topo_order:1,
 			simplify_merges:1,
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index f5e6e92f5b..d99214b6df 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -85,6 +85,28 @@ test_expect_success '--graph --all' '
 	test_cmp expected actual
 	'

+# Make sure that simplify_histpry_forks produces a spanning tree
+test_expect_success '--graph --simplify-forks --all' '
+	rm -f expected &&
+	echo "* $A7" >> expected &&
+	echo "*   $A6" >> expected &&
+	echo "|\  " >> expected &&
+	echo "| * $C4" >> expected &&
+	echo "| * $C3" >> expected &&
+	echo "* $A5" >> expected &&
+	echo "*-.   $A4" >> expected &&
+	echo "|\ \  " >> expected &&
+	echo "| | * $C2" >> expected &&
+	echo "| | * $C1" >> expected &&
+	echo "| * $B2" >> expected &&
+	echo "| * $B1" >> expected &&
+	echo "* $A3" >> expected &&
+	echo "* $A2" >> expected &&
+	echo "* $A1" >> expected &&
+	git rev-list --graph --simplify-forks --all > actual &&
+	test_cmp expected actual
+	'
+
 # Make sure the graph_is_interesting() code still realizes
 # that undecorated merges are interesting, even with --simplify-by-decoration
 test_expect_success '--graph --simplify-by-decoration' '
@@ -157,6 +179,20 @@ test_expect_success '--graph --full-history -- bar.txt' '
 	test_cmp expected actual
 	'

+test_expect_success '--graph --simplify-forks --full-history -- bar.txt' '
+	rm -f expected &&
+	echo "* $A7" >> expected &&
+	echo "*   $A6" >> expected &&
+	echo "|\\  " >> expected &&
+	echo "| * $C4" >> expected &&
+	echo "* $A5" >> expected &&
+	echo "* $A4" >> expected &&
+	echo "* $A3" >> expected &&
+	echo "* $A2" >> expected &&
+	git rev-list --graph --simplify-forks --full-history --all -- bar.txt > actual &&
+	test_cmp expected actual
+	'
+
 test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
 	rm -f expected &&
 	echo "* $A7" >> expected &&
@@ -172,6 +208,20 @@ test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
 	test_cmp expected actual
 	'

+test_expect_success '--graph --simplify-forks --full-history --simplify-merges -- bar.txt' '
+	rm -f expected &&
+	echo "* $A7" >> expected &&
+	echo "*   $A6" >> expected &&
+	echo "|\\  " >> expected &&
+	echo "| * $C4" >> expected &&
+	echo "* $A5" >> expected &&
+	echo "* $A3" >> expected &&
+	echo "* $A2" >> expected &&
+	git rev-list --graph --simplify-forks --full-history --simplify-merges --all \
+		-- bar.txt > actual &&
+	test_cmp expected actual
+	'
+
 test_expect_success '--graph -- bar.txt' '
 	rm -f expected &&
 	echo "* $A7" >> expected &&
-- 
2.26.2

