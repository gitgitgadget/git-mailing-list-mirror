Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A01FC2D0EC
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7F7206A1
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmzEUCc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDHBWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:22:08 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35744 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgDHBWI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 21:22:08 -0400
Received: by mail-wr1-f51.google.com with SMTP id g3so5981678wrx.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 18:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=boui5qiyRaRoRo+uO9+lSkZ8xHghPsMsmT11so6TBJE=;
        b=UmzEUCc7WK/7ehDWzif/7H4vjOjr32B2egOeVrZ26BRUI1bVbzNDmMthVbqe2/541/
         mQ8UCISWZnhcEj30Ctg9Nrf0T8cD+KEzY7dLxBTIi8Kh8OFJGyLGdi+DamC7DCPXadX0
         4nacICxDgcLfxYdNMjnnFTPN4kr6S69xYIT0h/VeQE7fe+R+Ihy4T9TbQwW9zqzEFPdY
         tUqF+UHQ4XsnGmSwR/4Iy/vyljWOl0usXBPkw0W9DwHoyWdHl0d2VlAohAAIaqN1xAxs
         2u2OoCXVz5e3kAJEbl9DBBLbfK388uwS5cU+JMu2BtMgQE8mCLSanCJcwX2HVUQlQvRF
         0PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=boui5qiyRaRoRo+uO9+lSkZ8xHghPsMsmT11so6TBJE=;
        b=DkDe6hgbZ4tkxnuN2mGxV6KvXM56TLbDpnWQMm1wgWGfVKc/na3IeU0+3aCgMajGze
         b0O1UfkRRI3euof0w1KraA9OqbuzbQ0UmruFyNHNc/GU+3DRNc2ZPdoXSql6farKtUOl
         9Tz0gukfPYMNxb5LA5BBnqeMVaKsdadvsjUioSxu06EBv6lAGsvgvbXZmPqQY4vTa8ud
         WUyOvlTEI7Y11ctc09DHXpM0sVgnn3LguNNlDjB3lUJM/ZfDH+QJZQ1Pz2p2dsLyMWG7
         Ax9fCmPXyII3NsyTyJ9Gr2g+t4GMTZe8MbHvuftH7aVW1+Z/U0eRH4+WErPAsllc0jn9
         KL5g==
X-Gm-Message-State: AGi0PuaTQ/OmfoLv9vPLRgZrrCeKhZ47TdMhY8y4cehGOFXh4Fvpe0Bl
        u0vpCPyBm64aVeBZAHb+AS5EyOXx
X-Google-Smtp-Source: APiQypLcLV3UIoFcbLZeG8vi5rOcxFqK3Qmu4YKDRvfE+ybZOB0oWiQf5NTooj8xDbSB7Ik3O1+0Og==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr5613794wrp.409.1586308924423;
        Tue, 07 Apr 2020 18:22:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22sm4619904wmc.42.2020.04.07.18.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 18:22:04 -0700 (PDT)
Message-Id: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 01:22:03 +0000
Subject: [PATCH] revision: --include-diversions adds helpful merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The default file history simplification of "git log -- <path>" or
"git rev-list -- <path>" focuses on providing the smallest set of
commits that first contributed a change. The revision walk greatly
restricts the set of walked commits by visiting only the first
TREESAME parent of a merge commit, when one exists. This means
that portions of the commit-graph are not walked, which can be a
performance benefit, but can also "hide" commits that added changes
but were ignored by a merge resolution.

The --full-history option modifies this by walking all commits and
reporting a merge commit as "interesting" if it has _any_ parent
that is not TREESAME. This tends to be an over-representation of
important commits, especially in an environment where most merge
commits are created by pull request completion.

Suppose we have a commit A and we create a commit B on top that
changes our file. When we merge the pull request, we create a merge
commit M. If no one else changed the file in the first-parent
history between M and A, then M will not be TREESAME to its first
parent, but will be TREESAME to B. Thus, the simplified history
will be "B". However, M will appear in the --full-history mode.

However, suppose that a number of topics T1, T2, ..., Tn were
created based on commits C1, C2, ..., Cn between A and M as
follows:

  A----C1----C2--- ... ---Cn----M------P1---P2--- ... ---Pn
   \     \     \            \  /      /    /            /
    \     \__.. \            \/ ..__T1    /           Tn
     \           \__..       /\     ..__T2           /
      \_____________________B  \____________________/

If the commits T1, T2, ... Tn did not change the file, then all of
P1 through Pn will be TREESAME to their first parent, but not
TREESAME to their second. This means that all of those merge commits
appear in the --full-history view, with edges that immediately
collapse into the lower history without introducing interesting
single-parent commits.

The --simplify-merges option was introduced to remove these extra
merge commits. By noticing that the rewritten parents are reachable
from their first parents, those edges can be simplified away. Finally,
the commits now look like single-parent commits that are TREESAME to
their "only" parent. Thus, they are removed and this issue does not
cause issues anymore. However, this also ends up removing the commit
M from the history view! Even worse, the --simplify-merges option
requires walking the entire history before returning a single result.

Many Git users are using Git alongside a Git service that provides
code storage alongside a code review tool commonly called "Pull
Requests" or "Merge Requests" against a target branch.  When these
requests are accepted and merged, they typically create a merge
commit whose first parent is the previous branch tip and the second
parent is the tip of the topic branch used for the request. This
presents a valuable order to the parents, but also makes that merge
commit slightly special. Users may want to see not only which
commits changed a file, but which pull requests merged those commits
into their branch. In the previous example, this would mean the
users want to see the merge commit "M" in addition to the single-
parent commit "C".

Users are even more likely to want these merge commits when they
use pull requests to merge into a feature branch before merging that
feature branch into their trunk.

In some sense, users are asking for the "first" merge commit to
bring in the change to their branch. As long as the parent order is
consistent, this can be handled with the following rule:

  Include a merge commit if it is not TREESAME to its first
  parent, but is TREESAME to a later parent.

I call such merge commits "diversions" because they divert the
history walk away from the first-parent history. As such, this
change adds the "--include-diversions" option to rev-list and log.
To test these options, extend the standard test example to include
a merge commit that is not TREESAME to its first parent. It is
surprising that that option was not already in the example, as it
is instructive.

In particular, this extension demonstrates a common issue with file
history simplification. When a user resolves a merge conflict using
"-Xours" or otherwise ignoring one side of the conflict, they create
a TREESAME edge that probably should not be TREESAME. This leads
users to become frustrated and complain that "my change disappeared!"
In my experience, showing them history with --full-history and
--simplify-merges quickly reveals the problematic merge. As mentioned,
this option is expensive to compute. The --include-diversions option
_might_ show the merge commit (usually titled "resolving conflicts")
more quickly. Of course, this depends on the user having the correct
parent order, which is backwards when using "git pull".

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    Add a new history mode
    
    This --include-diversions option could use a better name.
    
    An experienced developer in the Windows OS Engineering Systems team
    pointed out how hard it is to find out when a change was "introduced" in
    the Windows OS repo. Due to their multi-leveled, long-lived branch
    organization, a commit could be part of hundreds of pull requests as the
    branches are merged across the organization.
    
    My default answer was "this is complicated not because of Git, but
    because of how you are branching." I then tried to explain how finding
    the "first merge" to include a commit is incredibly difficult and
    requires performing multiple reachability queries. As I was working it
    out on paper, I realized that was true if we relied only on the
    commit-graph shape to inform our qurey.
    
    If we use the TREESAME information, then suddenly we get a much clearer
    picture! Let's simply pick out those merge commits that "introduced a
    change" because they are TREESAME to a non-first-parent (and not
    TREESAME to the first parent).
    
    My name of "diversions" could probably use some work, but I like the
    basic concept of this option.
    
    I welcome any and all feedback. Thanks!
    
    -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-599%2Fderrickstolee%2Fnew-history-mode-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-599/derrickstolee/new-history-mode-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/599

 Documentation/rev-list-options.txt |  6 ++++
 revision.c                         | 16 ++++++++++-
 revision.h                         |  1 +
 t/t6012-rev-list-simplify.sh       | 44 ++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index bfd02ade991..0c878be94a9 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -342,6 +342,12 @@ Default mode::
 	branches if the end result is the same (i.e. merging branches
 	with the same content)
 
+--include-diversions::
+	Include all commits from the default mode, but also any merge
+	commits that are not TREESAME to the first parent but are
+	TREESAME to a later parent. This mode is helpful for showing
+	the merge commits that "first introduced" a change to a branch.
+
 --full-history::
 	Same as the default mode, but does not prune some history.
 
diff --git a/revision.c b/revision.c
index 8136929e236..915d8febdc4 100644
--- a/revision.c
+++ b/revision.c
@@ -870,7 +870,19 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			}
 			parent->next = NULL;
 			commit->parents = parent;
-			commit->object.flags |= TREESAME;
+
+			/*
+			 * A merge commit is a "diversion" if it is not
+			 * TREESAME to its first parent but is TREESAME
+			 * to a later parent. In the simplified history,
+			 * we "divert" the history walk to the later
+			 * parent. These commits are shown when "diversions"
+			 * is enabled, so do not mark the object as
+			 * TREESAME here.
+			 */
+			if (!revs->diversions || !nth_parent)
+				commit->object.flags |= TREESAME;
+
 			return;
 
 		case REV_TREE_NEW:
@@ -2265,6 +2277,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--full-diff")) {
 		revs->diff = 1;
 		revs->full_diff = 1;
+	} else if (!strcmp(arg, "--include-diversions")) {
+		revs->diversions = 1;
 	} else if (!strcmp(arg, "--full-history")) {
 		revs->simplify_history = 0;
 	} else if (!strcmp(arg, "--relative-date")) {
diff --git a/revision.h b/revision.h
index 475f048fb61..f06a73cbcd8 100644
--- a/revision.h
+++ b/revision.h
@@ -129,6 +129,7 @@ struct rev_info {
 			no_walk:2,
 			remove_empty_trees:1,
 			simplify_history:1,
+			diversions:1,
 			topo_order:1,
 			simplify_merges:1,
 			simplify_by_decoration:1,
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index a10f0df02b0..9c91226f737 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -154,4 +154,48 @@ test_expect_success '--full-diff is not affected by --parents' '
 	test_cmp expected actual
 '
 
+#
+# Modify the test repo to add a merge whose first parent is not TREESAME
+# but whose second parent is TREESAME
+#
+# A--B----------G--H--I--K--L--N
+#  \  \           /     /     /
+#   \  \         /     /     /
+#    C------E---F     J     /
+#     \  \_/               /
+#      \                  /
+#       M-----------------
+test_expect_success 'expand graph' '
+	git switch -c branchM C &&
+	echo "new data" >file &&
+	git add file &&
+	test_tick &&
+	test_commit M &&
+
+	git checkout master &&
+	git merge -Xtheirs branchM -m "N" &&
+	note N
+'
+
+check_result 'M C A' -- file
+check_result 'N M C A' --include-diversions -- file
+
+check_result 'N M L K J I H F E D C G B A' --full-history --topo-order
+check_result 'N M L K I H G F E D C B J A' --full-history
+check_result 'N M L K I H G F E D C B J A' --full-history --date-order
+check_result 'N M L K I H G F E D B C J A' --full-history --author-date-order
+check_result 'N M K I H E C B A' --full-history -- file
+check_result 'N M K I H E C B A' --full-history --topo-order -- file
+check_result 'N M K I H E C B A' --full-history --date-order -- file
+check_result 'N M K I H E B C A' --full-history --author-date-order -- file
+check_result 'N M I E C B A' --simplify-merges -- file
+check_result 'N M I E C B A' --simplify-merges --topo-order -- file
+check_result 'N M I E C B A' --simplify-merges --date-order -- file
+check_result 'N M I E B C A' --simplify-merges --author-date-order -- file
+check_result 'M C A' --topo-order -- file
+check_result 'M C A' --date-order -- file
+check_result 'M C A' --author-date-order -- file
+check_result 'H' --first-parent -- another-file
+check_result 'H' --first-parent --topo-order -- another-file
+
 test_done

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget
