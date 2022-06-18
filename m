Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E732FC43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383712AbiFRAVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383658AbiFRAVL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314DC59322
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c21so7538545wrb.1
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qp5R/2nEDrwidqRUvDGZRkgucr9emIb2r0juqChWThw=;
        b=I+DQIiqwpBjfMuFoTYoVnPmv0CV9BRK7DA8GE45mY8rhFvvmRMIaTFEtbgydHHnisl
         H0eFal20YsH4r46AhBVuvcqH813WwJtDDPajOqyDqz+NJkx0Y5DBr0vDoEyZztE38ZVK
         8TGo+k1S8pICTs4WPbim/oI+ZFvJvVfNZdN4IQretUxLWm4O8/QRYE6QnEM2th8lLeVW
         4xYQmsoJI3kP11lW0wgNB9ZMSsrsctdGeLbtrce4372iBYxWeHKUupp+YdQe09l/K/Bo
         NlCd4/QbM8W+O2gg1hfjA1wKfp8edKAbLmkPTex3MKQGUoPOqUyKnCXVqGEfPqOSfz4T
         nNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Qp5R/2nEDrwidqRUvDGZRkgucr9emIb2r0juqChWThw=;
        b=wu8b6XaYCUrOm+LVhQbFW/HU6KTAY32sSgN+6xY72/ym6mu/J+MGLVmSvjVetwfimM
         CCgXei/MHVCLEoivNkCH++4Tj99ryzbnB/imX4HEkcJyRoLiaScjSU2JpzcQkZITlKpN
         m0AjMHm1s5hI16szFngXTTTZNaabZjHpEK+3MbZwgZCChxZLMKIE8TwFWN/Ic5/SJc6O
         HaB/y2ksgJwSSTyJ68EGiuewsG5vY2nfIXP+68kdBO7Y+Bqy4eW11KBj2tQvTBUjPASk
         L4ZLaMijPTEeuDMliiFnAjb+QkhGS8egJlh7m3wW4kyaVjPnIzVxVWFga4Nw67hyzfFf
         U1Xw==
X-Gm-Message-State: AJIora+6u2zR0qtuL8FMOr+Z6P2RQBk7O9NAfhiqXTEO7dCVKKd7uEz6
        OZg/zQ1cyVm5ykDm3E+2rxq/6nNSe0RcyA==
X-Google-Smtp-Source: AGRyM1t+EGVOIiyLVAyN9FwNKu6I250V9I46vEyzmdOTmSAp8HnRVlwfVRePLBe6yqdZmj/+Ibe5kg==
X-Received: by 2002:a05:6000:1e04:b0:217:88ff:eb86 with SMTP id bj4-20020a0560001e0400b0021788ffeb86mr11570990wrb.351.1655511667172;
        Fri, 17 Jun 2022 17:21:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i30-20020a1c541e000000b0039c15861001sm10033094wmb.21.2022.06.17.17.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:06 -0700 (PDT)
Message-Id: <697470e50aeeb546e055e6c57b17aea32d9ea451.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:47 +0000
Subject: [PATCH v7 04/17] merge-tree: implement real merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This adds the ability to perform real merges rather than just trivial
merges (meaning handling three way content merges, recursive ancestor
consolidation, renames, proper directory/file conflict handling, and so
forth).  However, unlike `git merge`, the working tree and index are
left alone and no branch is updated.

The only output is:
  - the toplevel resulting tree printed on stdout
  - exit status of 0 (clean), 1 (conflicts present), anything else
    (merge could not be performed; unknown if clean or conflicted)

This output is meant to be used by some higher level script, perhaps in
a sequence of steps like this:

   NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
   test $? -eq 0 || die "There were conflicts..."
   NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
   git update-ref $BRANCH1 $NEWCOMMIT

Note that higher level scripts may also want to access the
conflict/warning messages normally output during a merge, or have quick
access to a list of files with conflicts.  That is not available in this
preliminary implementation, but subsequent commits will add that
ability (meaning that NEWTREE would be a lot more than a tree in the
case of conflicts).

This also marks the traditional trivial merge of merge-tree as
deprecated.  The trivial merge not only had limited applicability, the
output format was also difficult to work with (and its format
undocumented), and will generally be less performant than real merges.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt |  98 ++++++++++++++++++++++++----
 builtin/merge-tree.c             |  41 +++++++++++-
 t/t4301-merge-tree-write-tree.sh | 106 +++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+), 13 deletions(-)
 create mode 100755 t/t4301-merge-tree-write-tree.sh

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 58731c19422..2a9c91328de 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -3,26 +3,100 @@ git-merge-tree(1)
 
 NAME
 ----
-git-merge-tree - Show three-way merge without touching index
+git-merge-tree - Perform merge without touching index or working tree
 
 
 SYNOPSIS
 --------
 [verse]
-'git merge-tree' <base-tree> <branch1> <branch2>
+'git merge-tree' [--write-tree] <branch1> <branch2>
+'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (deprecated)
 
+[[NEWMERGE]]
 DESCRIPTION
 -----------
-Reads three tree-ish, and output trivial merge results and
-conflicting stages to the standard output.  This is similar to
-what three-way 'git read-tree -m' does, but instead of storing the
-results in the index, the command outputs the entries to the
-standard output.
-
-This is meant to be used by higher level scripts to compute
-merge results outside of the index, and stuff the results back into the
-index.  For this reason, the output from the command omits
-entries that match the <branch1> tree.
+
+This command has a modern `--write-tree` mode and a deprecated
+`--trivial-merge` mode.  With the exception of the
+<<DEPMERGE,DEPRECATED DESCRIPTION>> section at the end, the rest of
+this documentation describes modern `--write-tree` mode.
+
+Performs a merge, but does not make any new commits and does not read
+from or write to either the working tree or index.
+
+The performed merge will use the same feature as the "real"
+linkgit:git-merge[1], including:
+
+  * three way content merges of individual files
+  * rename detection
+  * proper directory/file conflict handling
+  * recursive ancestor consolidation (i.e. when there is more than one
+    merge base, creating a virtual merge base by merging the merge bases)
+  * etc.
+
+After the merge completes, a new toplevel tree object is created.  See
+`OUTPUT` below for details.
+
+[[OUTPUT]]
+OUTPUT
+------
+
+For either a successful or conflicted merge, the output from
+git-merge-tree is simply one line:
+
+	<OID of toplevel tree>
+
+The printed tree object corresponds to what would be checked out in
+the working tree at the end of `git merge`, and thus may have files
+with conflict markers in them.
+
+EXIT STATUS
+-----------
+
+For a successful, non-conflicted merge, the exit status is 0.  When the
+merge has conflicts, the exit status is 1.  If the merge is not able to
+complete (or start) due to some kind of error, the exit status is
+something other than 0 or 1 (and the output is unspecified).
+
+USAGE NOTES
+-----------
+
+This command is intended as low-level plumbing, similar to
+linkgit:git-hash-object[1], linkgit:git-mktree[1],
+linkgit:git-commit-tree[1], linkgit:git-write-tree[1],
+linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
+used as a part of a series of steps such as:
+
+       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
+       test $? -eq 0 || die "There were conflicts..."
+       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
+       git update-ref $BRANCH1 $NEWCOMMIT
+
+[[DEPMERGE]]
+DEPRECATED DESCRIPTION
+----------------------
+
+Per the <<NEWMERGE,DESCRIPTION>> and unlike the rest of this
+documentation, this section describes the deprecated `--trivial-merge`
+mode.
+
+Other than the optional `--trivial-merge`, this mode accepts no
+options.
+
+This mode reads three tree-ish, and outputs trivial merge results and
+conflicting stages to the standard output in a semi-diff format.
+Since this was designed for higher level scripts to consume and merge
+the results back into the index, it omits entries that match
+<branch1>.  The result of this second form is similar to what
+three-way 'git read-tree -m' does, but instead of storing the results
+in the index, the command outputs the entries to the standard output.
+
+This form not only has limited applicability (a trivial merge cannot
+handle content merges of individual files, rename detection, proper
+directory/file conflict handling, etc.), the output format is also
+difficult to work with, and it will generally be less performant than
+the first form even on successful merges (especially if working in
+large repositories).
 
 GIT
 ---
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 0f9d928e862..2332525d8bd 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -2,6 +2,9 @@
 #include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
+#include "help.h"
+#include "commit-reach.h"
+#include "merge-ort.h"
 #include "object-store.h"
 #include "parse-options.h"
 #include "repository.h"
@@ -398,7 +401,43 @@ struct merge_tree_options {
 static int real_merge(struct merge_tree_options *o,
 		      const char *branch1, const char *branch2)
 {
-	die(_("real merges are not yet implemented"));
+	struct commit *parent1, *parent2;
+	struct commit_list *merge_bases = NULL;
+	struct merge_options opt;
+	struct merge_result result = { 0 };
+
+	parent1 = get_merge_parent(branch1);
+	if (!parent1)
+		help_unknown_ref(branch1, "merge-tree",
+				 _("not something we can merge"));
+
+	parent2 = get_merge_parent(branch2);
+	if (!parent2)
+		help_unknown_ref(branch2, "merge-tree",
+				 _("not something we can merge"));
+
+	init_merge_options(&opt, the_repository);
+
+	opt.show_rename_progress = 0;
+
+	opt.branch1 = branch1;
+	opt.branch2 = branch2;
+
+	/*
+	 * Get the merge bases, in reverse order; see comment above
+	 * merge_incore_recursive in merge-ort.h
+	 */
+	merge_bases = get_merge_bases(parent1, parent2);
+	if (!merge_bases)
+		die(_("refusing to merge unrelated histories"));
+	merge_bases = reverse_commit_list(merge_bases);
+
+	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
+	if (result.clean < 0)
+		die(_("failure to merge"));
+	puts(oid_to_hex(&result.tree->object.oid));
+	merge_finalize(&opt, &result);
+	return !result.clean; /* result.clean < 0 handled above */
 }
 
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
new file mode 100755
index 00000000000..6d321652e21
--- /dev/null
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+
+test_description='git merge-tree --write-tree'
+
+. ./test-lib.sh
+
+# This test is ort-specific
+if test "$GIT_TEST_MERGE_ALGORITHM" != "ort"
+then
+	skip_all="GIT_TEST_MERGE_ALGORITHM != ort"
+	test_done
+fi
+
+test_expect_success setup '
+	test_write_lines 1 2 3 4 5 >numbers &&
+	echo hello >greeting &&
+	echo foo >whatever &&
+	git add numbers greeting whatever &&
+	test_tick &&
+	git commit -m initial &&
+
+	git branch side1 &&
+	git branch side2 &&
+	git branch side3 &&
+
+	git checkout side1 &&
+	test_write_lines 1 2 3 4 5 6 >numbers &&
+	echo hi >greeting &&
+	echo bar >whatever &&
+	git add numbers greeting whatever &&
+	test_tick &&
+	git commit -m modify-stuff &&
+
+	git checkout side2 &&
+	test_write_lines 0 1 2 3 4 5 >numbers &&
+	echo yo >greeting &&
+	git rm whatever &&
+	mkdir whatever &&
+	>whatever/empty &&
+	git add numbers greeting whatever/empty &&
+	test_tick &&
+	git commit -m other-modifications &&
+
+	git checkout side3 &&
+	git mv numbers sequence &&
+	test_tick &&
+	git commit -m rename-numbers
+'
+
+test_expect_success 'Clean merge' '
+	TREE_OID=$(git merge-tree --write-tree side1 side3) &&
+	q_to_tab <<-EOF >expect &&
+	100644 blob $(git rev-parse side1:greeting)Qgreeting
+	100644 blob $(git rev-parse side1:numbers)Qsequence
+	100644 blob $(git rev-parse side1:whatever)Qwhatever
+	EOF
+
+	git ls-tree $TREE_OID >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Content merge and a few conflicts' '
+	git checkout side1^0 &&
+	test_must_fail git merge side2 &&
+	expected_tree=$(git rev-parse AUTO_MERGE) &&
+
+	# We will redo the merge, while we are still in a conflicted state!
+	test_when_finished "git reset --hard" &&
+
+	test_expect_code 1 git merge-tree --write-tree side1 side2 >RESULT &&
+	actual_tree=$(head -n 1 RESULT) &&
+
+	# Due to differences of e.g. "HEAD" vs "side1", the results will not
+	# exactly match.  Dig into individual files.
+
+	# Numbers should have three-way merged cleanly
+	test_write_lines 0 1 2 3 4 5 6 >expect &&
+	git show ${actual_tree}:numbers >actual &&
+	test_cmp expect actual &&
+
+	# whatever and whatever~<branch> should have same HASHES
+	git rev-parse ${expected_tree}:whatever ${expected_tree}:whatever~HEAD >expect &&
+	git rev-parse ${actual_tree}:whatever ${actual_tree}:whatever~side1 >actual &&
+	test_cmp expect actual &&
+
+	# greeting should have a merge conflict
+	git show ${expected_tree}:greeting >tmp &&
+	sed -e s/HEAD/side1/ tmp >expect &&
+	git show ${actual_tree}:greeting >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'Barf on misspelled option, with exit code other than 0 or 1' '
+	# Mis-spell with single "s" instead of double "s"
+	test_expect_code 129 git merge-tree --write-tree --mesages FOOBAR side1 side2 2>expect &&
+
+	grep "error: unknown option.*mesages" expect
+'
+
+test_expect_success 'Barf on too many arguments' '
+	test_expect_code 129 git merge-tree --write-tree side1 side2 invalid 2>expect &&
+
+	grep "^usage: git merge-tree" expect
+'
+
+test_done
-- 
gitgitgadget

