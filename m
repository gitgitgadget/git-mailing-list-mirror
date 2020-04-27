Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697FCC55199
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 05:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9FB208FE
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 05:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiKOkuK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgD0FHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 01:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726178AbgD0FHL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 01:07:11 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53D5C061A0F
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 22:07:10 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e8so15480315ilm.7
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 22:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VrBvS6P4p90+NI1H07Cou5w1gIYL2D10aNE+uRf/hx8=;
        b=LiKOkuK/NNhaKauZ0pMskN5tjoTxlXijYBdunvB67gSvjP2xRvhsin7iZPSmU1Ubu2
         GHZjbwUm1cCO+moWBzN+yC2YiwO1Sn954f/tinetDblwTjVD8Oq2aJD5kNfm2PaDt7um
         DOI2UPE2sOjoOuXLEQqQVBMUFeSUJvqfg0q+NU6WiNlhZVlnl6ntZmGLRjoJFluO6qLM
         u0tEg1ybCN7QGnlb4IjPk3eFnr1SVYCplUOichdhoDJ3RyDZbw0iiQZ3Nq0LGGPrSW2m
         7TDQMXpYchuPQUU8gvelyI+QyorjOr79J5CbnSIswFuyPTEU059+xhlvkoLlYadw0LBa
         3kqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VrBvS6P4p90+NI1H07Cou5w1gIYL2D10aNE+uRf/hx8=;
        b=q3xnRzGdA25qM0/MANG9BwktxnRuR4TIjYTY/ldIxz+fQwmu3bdlDzHd1xcMzV7TjX
         /teUZfKYqX0PA53wjbwZEf1Ek7N+S1CCT+c6HROYVWzGCC1CJTrhb1UKjTJqETHrXnn+
         WIy/UpvzBMXKWMDylqQ12NelOMalB5DW7WeReN4E/4CETK3DvgY+/6aZO9+Iq45OHz25
         4/c41+YWqxhtBh4rj0wMCq2v1fTeQPr/DNj9uSg416Qbdcx3nDJEMVFUXZOjTTqIyRBM
         68dhjLGhz2mLTystmkVvcVWwjBoPHzDYjry4PzmheX9plVmb9c3cILptkravHkI43BXd
         tiKA==
X-Gm-Message-State: AGi0PuaXyJpYTi/en/trEUm9ztRCBsc7a4z1OnKRYpgG5Uh021yFGldT
        BwxXybLZ1txsxGd5BaNAqUM=
X-Google-Smtp-Source: APiQypK6YZ15jMDXBW7kk9osNv+hO8yM4S3EF3mg5vwKvUmeQSwirfH3123zfclx9LO1kaSxzEwX6A==
X-Received: by 2002:a92:8545:: with SMTP id f66mr14239730ilh.70.1587964030069;
        Sun, 26 Apr 2020 22:07:10 -0700 (PDT)
Received: from ?IPv6:2601:8c0:37f:6012:9ce7:d4e2:d147:76ea? ([2601:8c0:37f:6012:9ce7:d4e2:d147:76ea])
        by smtp.gmail.com with ESMTPSA id t5sm4522820iom.3.2020.04.26.22.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 22:07:09 -0700 (PDT)
From:   Antonio Russo <antonio.e.russo@gmail.com>
Subject: [PATCH] Teach git-rev-list --simplify-forks
To:     git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
Date:   Sun, 26 Apr 2020 23:07:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
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
 revision.c                                 | 67 +++++++++++++++++++++-
 revision.h                                 |  6 ++
 t/t6016-rev-list-graph-simplify-history.sh | 50 ++++++++++++++++
 4 files changed, 130 insertions(+), 1 deletion(-)

Hello,

I'm trying to address a long-standing problem I've had visualizing complex
git repositories with git log --graph.  I think that a picture is worth a
thousand words, so I'll just show what the patch does for git master:

% git log --graph --abbrev-commit --pretty=oneline --simplify-forks e870325ee8

> * e870325ee8 (HEAD -> master, origin/master, origin/HEAD) The third batch
> *   a397e9c236 Merge branch 'jk/credential-parsing-end-of-host-in-URL'
> |\
> | * 4c5971e18a credential: treat "?" and "#" in URLs as end of host
> *   d6d561db1c Merge branch 'jt/rebase-allow-duplicate'
> |\
> | * 0fcb4f6b62 rebase --merge: optionally skip upstreamed commits
> *   c7d8f69da5 Merge branch 'en/rebase-no-keep-empty'
> |\
> | * 50ed76148a rebase: fix an incompatible-options error message
> | * b9cbd2958f rebase: reinstate --no-keep-empty
> | * 1b5735f75c rebase -i: mark commits that begin empty in todo editor
> *   8b39dfdf47 Merge branch 'js/mingw-is-hidden-test-fix'
> |\
> | * 176a66a748 t: restrict `is_hidden` to be called only on Windows
> | * 9814d0a4ad mingw: make test_path_is_hidden more robust
> | * 7c2dfca7e8 t: consolidate the `is_hidden` functions
> *   a41b41ca74 Merge branch 'js/mingw-isilon-nfs'
> |\
> | * 23eafd924a mingw: cope with the Isilon network file system
> *   33feaca6bf Merge branch 'js/flush-prompt-before-interative-input'
> |\
> | * 1f09aed834 interactive: explicitly `fflush` stdout before expecting input
> | * 08d383f23e interactive: refactor code asking the user for interactive input
> *   9af3a7cb4d Merge branch 'ds/revision-show-pulls'
> |\
> | * 8d049e182e revision: --show-pulls adds helpful merges
> *   82fa169d55 Merge branch 'ma/simplify-merge-config-parsing'
> |\
> | * 9881b451f3 merge: use skip_prefix to parse config key
> *   b3eb70e0f8 Merge branch 'js/mingw-fixes'

Compare this to before:

% git log --graph --abbrev-commit --pretty=oneline e870325ee8

> * e870325ee8 (HEAD -> master, origin/master, origin/HEAD) The third batch
> *   a397e9c236 Merge branch 'jk/credential-parsing-end-of-host-in-URL'
> |\
> | * 4c5971e18a credential: treat "?" and "#" in URLs as end of host
> * |   d6d561db1c Merge branch 'jt/rebase-allow-duplicate'
> |\ \
> | * | 0fcb4f6b62 rebase --merge: optionally skip upstreamed commits
> * | | c7d8f69da5 Merge branch 'en/rebase-no-keep-empty'
> |\| |
> | * | 50ed76148a rebase: fix an incompatible-options error message
> | * | b9cbd2958f rebase: reinstate --no-keep-empty
> | * | 1b5735f75c rebase -i: mark commits that begin empty in todo editor
> * | |   8b39dfdf47 Merge branch 'js/mingw-is-hidden-test-fix'
> |\ \ \
> | * | | 176a66a748 t: restrict `is_hidden` to be called only on Windows
> | * | | 9814d0a4ad mingw: make test_path_is_hidden more robust
> | * | | 7c2dfca7e8 t: consolidate the `is_hidden` functions
> * | | |   a41b41ca74 Merge branch 'js/mingw-isilon-nfs'
> |\ \ \ \
> | * | | | 23eafd924a mingw: cope with the Isilon network file system
> | |/ / /
> * | | |   33feaca6bf Merge branch 'js/flush-prompt-before-interative-input'
> |\ \ \ \
> | * | | | 1f09aed834 interactive: explicitly `fflush` stdout before expecting input
> | * | | | 08d383f23e interactive: refactor code asking the user for interactive input
> | |/ / /
> * | | |   9af3a7cb4d Merge branch 'ds/revision-show-pulls'
> |\ \ \ \
> | * | | | 8d049e182e revision: --show-pulls adds helpful merges
> | |/ / /
> * | | |   82fa169d55 Merge branch 'ma/simplify-merge-config-parsing'
> |\ \ \ \
> | * | | | 9881b451f3 merge: use skip_prefix to parse config key
> | |/ / /
> * | | |   b3eb70e0f8 Merge branch 'js/mingw-fixes'
> |\ \ \ \

Roughly, the tool produces a spanning tree by traversing the commit graph,
leftmost parents first. It forgets information about where forks occurred,
removing the "tails" that connect branches back to their original fork
point.  These "tails" can be very long and often do not contain information
that is very important for someone glancing through commits.

=== Details

It's about 40% faster.  Tested this on current master (of git):

git log --graph --pretty=oneline --simplify-forks e870325ee8 > /dev/null  0.83s user 0.06s system 99% cpu 0.886 total

git log --graph --pretty=oneline e870325ee8 > /dev/null  1.41s user 0.03s system 99% cpu 1.443 total

This is because the produced graph is much simpler---it is a tree in the
above case (though not in general).

The exact approach uses two flags (reusing bits 27 and 28 that are used
by the topological sort walk).  One says whether the commit has been ever
visited, and the other says whether the commit was visited from the current
root.  The walk does not continue down any commit that was visited, and
leaves the connection to the parent only if has not been visited from the
current root.  Each commit that is to be shown is treated as its own root
(most of these root commits are immediately skipped, because they are
likely visited in an earlier traversal).

=== Problems

Travis CI is showing issues with the tests I've added [1].  I cannot
reproduce them locally, neither with gcc 4.8.5 (RHEL) nor 9.3.0 (Debian).
They're also only failing on one of the runners.


Thank you for taking the time to look at this,
Antonio Russo


[1] https://travis-ci.org/github/aerusso/git
[2] https://github.com/aerusso/git/tree/mrs/simplify-history-forks

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
index 5bc96444b6..06d9697306 100644
--- a/revision.c
+++ b/revision.c
@@ -2082,6 +2082,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->simplify_by_decoration = 1;
 		revs->limited = 1;
 		revs->prune = 1;
+	} else if (!strcmp(arg, "--simplify-forks")) {
+		revs->simplify_forks = 1;
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->sort_order = REV_SORT_BY_COMMIT_DATE;
 		revs->topo_order = 1;
@@ -3095,6 +3097,63 @@ static void simplify_merges(struct rev_info *revs)
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
@@ -3392,10 +3451,16 @@ int prepare_revision_walk(struct rev_info *revs)
 	if (revs->limited) {
 		if (limit_list(revs) < 0)
 			return -1;
+		if (revs->simplify_forks)
+			simplify_forks(revs);
 		if (revs->topo_order)
 			sort_in_topological_order(&revs->commits, revs->sort_order);
-	} else if (revs->topo_order)
+	} else if (revs->topo_order) {
+		if (revs->simplify_forks)
+			simplify_forks(revs);
 		init_topo_walk(revs);
+	} else if (revs->simplify_forks)
+		simplify_forks(revs);
 	if (revs->line_level_traverse)
 		line_log_filter(revs);
 	if (revs->simplify_merges)
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

