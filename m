Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CD4C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 07:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA6C207EA
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 07:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRzf35hz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgIJHdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgIJHcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 03:32:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39667C061786
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 00:32:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so495230plt.9
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 00:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5OXj3SZsQtQHk6AwZhnaJeMu8d5OYb9ooBMofSGcouA=;
        b=JRzf35hzFczUIw3q4BwMKtn9I7XWkjOfZJz8dSI5RhNhavwumQucsSm4sATRoGbBtK
         NjIdM2lZ5PPBXtGIN4ryQKvdP8TCn2Tp2OBngjr2z3ZtWsXANdkLLSoqVjPKmoXDrcke
         Sf2zTTTW5QdpbS5S0fMSHfYGSeu+wb98WVNYasXTXH0yKR+nfkb9ZEEAXKOJjCozRY3a
         cQGCntigiw/bYXbMd8JOyHVq6i8zK/51wv6LN09SV8wdt7WAgh1vXMU8MuUUVunoXous
         A7xubwpwtKDQUZOHxfLdv03rBERprcKaXCd3Faj+WQBPdzCcLEfbUQH9Bgl+n6KZaaas
         0JxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5OXj3SZsQtQHk6AwZhnaJeMu8d5OYb9ooBMofSGcouA=;
        b=rbsitH5vsYWR2hz03Zq2pJR2Ck+99qQLoRee6pfldqVlNGq/FG2cQGql+Ae/hws6Xe
         34lUY9iQRPGzPKsFJ09M9zVuDlLK19KP7oPxXTTbqhHW0XiTkk6JQSbMvfcLhSNlFN90
         +nuyJpYWJZ4dC6U1sgV+aWtN9gSF89z0fyIm3+aG8LkJYENCF+HVSr8405c5Sw0GDGnG
         Vrqiv/zBxCXvogFbOHogm3yweigeq7s2HWIhGyGxbZuP+T3xTUVytWCG9tBnk+fUQEvG
         TPQjnvdXe4sVcF7nbRJSfz9bt1jaXaqgwmP0ezsKaIh5dvpHBlIcD7yl+ETU6gUQ9ggA
         MYnA==
X-Gm-Message-State: AOAM533+OFeJ/TUMkArTIBsBUKPNv6DqUVghCKxES/WCAI/r5zCF+R6I
        KF/OTLWZqXwO5bVbB/nxOXaZP+s+Yvo=
X-Google-Smtp-Source: ABdhPJyXTIt0QHi6wwxlQaVs1/45/8i4AmNzcLLMidiv3GPF5iNYRvVhLVca2ZMW9We+SMWy7bx13g==
X-Received: by 2002:a17:90a:df91:: with SMTP id p17mr4224349pjv.29.1599723165357;
        Thu, 10 Sep 2020 00:32:45 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id q127sm4990550pfb.61.2020.09.10.00.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 00:32:44 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 4/4] builtin/diff: learn --merge-base
Date:   Thu, 10 Sep 2020 00:32:20 -0700
Message-Id: <4f219cf0d1df1b92d2bd49e3449a4c387056a6cd.1599723087.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1599723087.git.liu.denton@gmail.com>
References: <cover.1599332861.git.liu.denton@gmail.com> <cover.1599723087.git.liu.denton@gmail.com>
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

Notes:
    The `--merge-base` name isn't very satisfying. If anyone has any
    suggestions for alternative names, please let me know.

 Documentation/git-diff.txt | 24 ++++++++++--
 builtin/diff.c             | 61 ++++++++++++++++++++++++++++-
 t/t4068-diff-symmetric.sh  | 79 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 8f7b4ed3ca..2cab6eabe1 100644
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
+merge base of the commit and the HEAD and the working tree or the index
+if `--cached` is given. `git diff --merge-base A` is equivalent to `git
+diff $(git merge-base A HEAD)`.
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
index 0e086ed7c4..448d2dd69a 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -19,6 +19,7 @@
 #include "builtin.h"
 #include "submodule.h"
 #include "oid-array.h"
+#include "commit-reach.h"
 
 #define DIFF_NO_INDEX_EXPLICIT 1
 #define DIFF_NO_INDEX_IMPLICIT 2
@@ -27,7 +28,7 @@ static const char builtin_diff_usage[] =
 "git diff [<options>] [<commit>] [--] [<path>...]\n"
 "   or: git diff [<options>] --cached [<commit>] [--] [<path>...]\n"
 "   or: git diff [<options>] <commit> [<commit>...] <commit> [--] [<path>...]\n"
-"   or: git diff [<options>] <commit>...<commit>] [--] [<path>...]\n"
+"   or: git diff [<options>] --merge-base [<commit> [<commit>]] [--] [<path>...]\n"
 "   or: git diff [<options>] <blob> <blob>]\n"
 "   or: git diff [<options>] --no-index [--] <path> <path>]\n"
 COMMON_DIFF_OPTIONS_HELP;
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
+			 N_("compare with the merge base between two commits")),
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
2.28.0.618.gf4bc123cb7

