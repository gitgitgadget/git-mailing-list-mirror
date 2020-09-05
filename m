Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590B4C43461
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1B920757
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGtU21L7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgIETJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 15:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgIETJD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 15:09:03 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C75C061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 12:09:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h2so2661770plr.0
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 12:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plN2wm577lGn+Pqcavnl6I6FixoCaKw1gMizd1/qJ3Q=;
        b=bGtU21L7pgvdFH4DQzSbMyyOVp+gND9VlEpjXt3oHIEOpjgs61hf0NmWoasSmLdFpf
         /fJmxKZQDEKb5SANNw+fcMOBpfgbMvWqLHo2koYX98EkDy1j80iGBQs6prcoY239dMcY
         6OmYgNGBnOpJpbPDPNYF58XEHGQ9vLaJ7j5l8JnXSgDEarA7A/D6KvtXceeiwSVvtK9f
         OL3NPNsHDqj2G+O7zX3DoKNYb1N7kM4lIugRheJg0z7XzplT+f0SA/hTNz+WUcTD3La1
         1LS26NMeWAgI9nxPuf9G0XgCtmdDuFIDXwtl+1dndZvQtSpSw0QUpHDr/kdFIEVWpDn0
         uf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plN2wm577lGn+Pqcavnl6I6FixoCaKw1gMizd1/qJ3Q=;
        b=pZkjnerqHGO7tXkzgHGjoDo48WkH2KK9dogaJ2SUlz1JTUKnQ0LPsfdyRxn22oRcdY
         0tTk8e01hBwE0726naiF5KPI9uN4b7nA9RhbzZ7HiIe+8GHQjUs9ylq+3c9/9ClGgoWY
         Eix0XW8Ypjwf5yw1+b969AlGUGhDT1yk848w6lfjLKvxdR96nucXci/QFGJd12L3GI4O
         74NwWsc6SFn2ndl1U2+sPQvqhytFhMhqr5J5Shll+PQFgLDM6Zu7j2ULGJ+ikDO/mX2v
         +NGsOh0yM6Y9cbXOqJBX3rY/VMUYyv8B3bRPFcbvRh6TVaFe2WmdXE+KZTXNMtDQAomg
         KAXw==
X-Gm-Message-State: AOAM5300xXhnArv2++gDBQiBqOghFQ4SNUfDp5PSNuTv7ape+bqmne96
        cyF3D2AQ7lBLDkM0Xnn4rM93Wo6OWzQ=
X-Google-Smtp-Source: ABdhPJyORdAmeTZ6IoQbeQ4D7BGhFSspgAkI0t9nb9d4cCTihLjdfuvDU7AXCuC2LHh5sYu0qI8dfw==
X-Received: by 2002:a17:902:d904:: with SMTP id c4mr13125077plz.115.1599332940651;
        Sat, 05 Sep 2020 12:09:00 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id u5sm3045459pfh.215.2020.09.05.12.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 12:08:59 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] builtin/diff: learn --merge-base
Date:   Sat,  5 Sep 2020 12:08:21 -0700
Message-Id: <231ba3f661cc4aa7a55c44e339e187c6d70c5507.1599332861.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.135.gc7877b767d
In-Reply-To: <cover.1599332861.git.liu.denton@gmail.com>
References: <cover.1599332861.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to get the diff between a commit and its merge base, the
currently preferred method is to use `git diff A...B`. However, the
range-notation with diff has, time and time again, been noted as a point
of confusion and thus, it should be avoided. Although we have a
substitute for the double-dot notation, we don't have any replacement
for the triple-dot notation.

Introduce the `--merge-base` flag as a replacement for triple-dot
notation. Thus, we would be able to write the above as
`git diff --merge-base A B`, allowing us to gently deprecate
range-notation completely.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-diff.txt | 24 ++++++++++--
 builtin/diff.c             | 59 ++++++++++++++++++++++++++++
 t/t4068-diff-symmetric.sh  | 79 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 8f7b4ed3ca..0031729794 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git diff' [<options>] [<commit>] [--] [<path>...]
 'git diff' [<options>] --cached [<commit>] [--] [<path>...]
 'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]
-'git diff' [<options>] <commit>...<commit> [--] [<path>...]
+'git diff' [<options>] --merge-base [--cached] [<commit> [<commit>]] [--] [<path>...]
 'git diff' [<options>] <blob> <blob>
 'git diff' [<options>] --no-index [--] <path> <path>
 
@@ -63,6 +63,24 @@ files on disk.
 	This is to view the changes between two arbitrary
 	<commit>.
 
+'git diff' [<options>] --merge-base [--cached] [<commit> [<commit>]] [--] [<path>...]::
+
+	In this form, the "before" side will be the merge base of the
+	two given commits.  If either commit is omitted, it will default
+	to HEAD.
++
+In the case where two commits are given, a diff is displayed between the
+merge base and the second commit.  `git diff --merge-base A B` is
+equivalent to `git diff $(git merge-base A B) B`.
++
+In the case where one commit is given, a diff is displayed between the
+merge base and the working tree or the index if `--cached` is given.
+`git diff --merge-base A` is equivalent to `git diff $(git merge-base A
+HEAD)`.
++
+In the case where no commits are given, this form behaves identically to
+as if no `--merge-base` were supplied.
+
 'git diff' [<options>] <commit> <commit>... <commit> [--] [<path>...]::
 
 	This form is to view the results of a merge commit.  The first
@@ -89,8 +107,8 @@ files on disk.
 
 Just in case you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
-in the last two forms that use `..` notations, can be any
-<tree>.
+in the `--merge-base` case and the last two forms that use `..`
+notations, can be any <tree>.
 
 For a more complete list of ways to spell <commit>, see
 "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
diff --git a/builtin/diff.c b/builtin/diff.c
index 0e086ed7c4..0af5a6c8c9 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -19,6 +19,7 @@
 #include "builtin.h"
 #include "submodule.h"
 #include "oid-array.h"
+#include "commit-reach.h"
 
 #define DIFF_NO_INDEX_EXPLICIT 1
 #define DIFF_NO_INDEX_IMPLICIT 2
@@ -371,6 +372,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	int blobs = 0, paths = 0;
 	struct object_array_entry *blob[2];
 	int nongit = 0, no_index = 0;
+	int merge_base = 0;
 	int result = 0;
 	struct symdiff sdiff;
 	struct option options[] = {
@@ -378,6 +380,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			   N_("compare the given paths on the filesystem"),
 			   DIFF_NO_INDEX_EXPLICIT,
 			   PARSE_OPT_NONEG),
+		OPT_BOOL(0, "merge-base", &merge_base,
+			 N_("use the merge base between the two commits as the diff base")),
 		OPT_END(),
 	};
 
@@ -457,6 +461,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	rev.diffopt.flags.allow_external = 1;
 	rev.diffopt.flags.allow_textconv = 1;
 
+	if (no_index && merge_base)
+		die(_("--no-index and --merge-base are mutually exclusive"));
+
 	/* If this is a no-index diff, just run it and exit there. */
 	if (no_index)
 		exit(diff_no_index(&rev, no_index == DIFF_NO_INDEX_IMPLICIT,
@@ -513,6 +520,58 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	}
 
 	symdiff_prepare(&rev, &sdiff);
+
+	if (merge_base && rev.pending.nr) {
+		int i;
+		struct commit *mb_child[2] = {0};
+		struct commit_list *merge_bases;
+		int old_nr;
+
+		for (i = 0; i < rev.pending.nr; i++) {
+			struct object *obj = rev.pending.objects[i].item;
+			if (obj->flags)
+				die(_("--merge-base does not work with ranges"));
+			if (obj->type != OBJ_COMMIT)
+				die(_("--merge-base only works with commits"));
+		}
+
+		/*
+		 * This check must go after the for loop above because A...B
+		 * ranges produce three pending commits, resulting in a
+		 * misleading error message.
+		 */
+		if (rev.pending.nr > ARRAY_SIZE(mb_child))
+			die(_("--merge-base does not work with more than two commits"));
+
+		for (i = 0; i < rev.pending.nr; i++)
+			mb_child[i] = lookup_commit_reference(the_repository, &rev.pending.objects[i].item->oid);
+		if (rev.pending.nr < ARRAY_SIZE(mb_child)) {
+			struct object_id oid;
+
+			if (rev.pending.nr != 1)
+				BUG("unexpected rev.pending.nr: %d", rev.pending.nr);
+
+			if (get_oid("HEAD", &oid))
+				die(_("unable to get HEAD"));
+
+			mb_child[1] = lookup_commit_reference(the_repository, &oid);
+		}
+
+		merge_bases = repo_get_merge_bases(the_repository, mb_child[0], mb_child[1]);
+		if (!merge_bases)
+			die(_("no merge base found"));
+		if (merge_bases->next)
+			die(_("multiple merge bases found"));
+
+		old_nr = rev.pending.nr;
+		rev.pending.nr = 1;
+		object_array_pop(&rev.pending);
+		add_object_array(&merge_bases->item->object, oid_to_hex(&merge_bases->item->object.oid), &rev.pending);
+		rev.pending.nr = old_nr;
+
+		free_commit_list(merge_bases);
+	}
+
 	for (i = 0; i < rev.pending.nr; i++) {
 		struct object_array_entry *entry = &rev.pending.objects[i];
 		struct object *obj = entry->item;
diff --git a/t/t4068-diff-symmetric.sh b/t/t4068-diff-symmetric.sh
index 60c506c2b2..0e43ed7660 100755
--- a/t/t4068-diff-symmetric.sh
+++ b/t/t4068-diff-symmetric.sh
@@ -88,4 +88,83 @@ test_expect_success 'diff with ranges and extra arg' '
 	test_i18ngrep "usage" err
 '
 
+test_expect_success 'diff --merge-base with two commits' '
+	git diff commit-C master >expect &&
+	git diff --merge-base br2 master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --merge-base with no commits' '
+	git diff --merge-base >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'diff --merge-base with one commit' '
+	git checkout master &&
+	git diff commit-C >expect &&
+	git diff --merge-base br2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --merge-base with one commit and unstaged changes' '
+	git checkout master &&
+	test_when_finished git reset --hard &&
+	echo unstaged >>c &&
+	git diff commit-C >expect &&
+	git diff --merge-base br2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --merge-base with one commit and staged and unstaged changes' '
+	git checkout master &&
+	test_when_finished git reset --hard &&
+	echo staged >>c &&
+	git add c &&
+	echo unstaged >>c &&
+	git diff commit-C >expect &&
+	git diff --merge-base br2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --merge-base --cached with one commit and staged and unstaged changes' '
+	git checkout master &&
+	test_when_finished git reset --hard &&
+	echo staged >>c &&
+	git add c &&
+	echo unstaged >>c &&
+	git diff --cached commit-C >expect &&
+	git diff --cached --merge-base br2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --merge-base with --no-index' '
+	test_must_fail git diff --merge-base --no-index expect actual 2>err &&
+	test_i18ngrep "fatal: --no-index and --merge-base are mutually exclusive" err
+'
+
+test_expect_success 'diff --merge-base with range' '
+	test_must_fail git diff --merge-base br2..br3 2>err &&
+	test_i18ngrep "fatal: --merge-base does not work with ranges" err
+'
+
+test_expect_success 'diff --merge-base non-commit' '
+	test_must_fail git diff --merge-base master^{tree} 2>err &&
+	test_i18ngrep "fatal: --merge-base only works with commits" err
+'
+
+test_expect_success 'diff --merge-base with three commits' '
+	test_must_fail git diff --merge-base br1 br2 master 2>err &&
+	test_i18ngrep "fatal: --merge-base does not work with more than two commits" err
+'
+
+test_expect_success 'diff --merge-base with no merge bases' '
+	test_must_fail git diff --merge-base br2 br3 2>err &&
+	test_i18ngrep "fatal: no merge base found" err
+'
+
+test_expect_success 'diff --merge-base with multiple merge bases' '
+	test_must_fail git diff --merge-base master br1 2>err &&
+	test_i18ngrep "fatal: multiple merge bases found" err
+'
+
 test_done
-- 
2.28.0.rc0.135.gc7877b767d

