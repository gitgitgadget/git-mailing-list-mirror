Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0C1C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BBF2072E
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye02AtPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIQHpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgIQHon (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 03:44:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EB0C061756
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w7so689205pfi.4
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6WDQb6DLaMu3ZAs0jPlojRIsxKhYKMU+2bn31DnqMw=;
        b=Ye02AtPzOCLy8SkymuqMTU1DSB98TeclG0bKyKsQrGcRr9I/etisHFw8gCrC83gCiK
         RbeoVarxQBKg4w+02KVNMRVbkdH3k01DhmX6gYbFExRMO1wwjMh5SKBakxF/1BGWJ5u6
         7pubH/pbEhKyANv47cFD6kzn+Weem5Zzc4dYor0Oh8r+6lDlz9i1c+Jnm7CaY6AzayPf
         V9V/y1T1IYmb7NvaX5k34Pvu3ts3f0OcAalPZHvzJYXIAnKprqs5RfwIelHmADpi6hMm
         Co1tPRfqkfVzDze+Knt64+DN85RiB6xKrNv0lSgANr4NiagWtbaROG9Z1pQxFYd57TAL
         FyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6WDQb6DLaMu3ZAs0jPlojRIsxKhYKMU+2bn31DnqMw=;
        b=V58VK8prutELJErp3I4uCRZlTbD52Xaya153rXY8VhV8wnqqBHobx+4+Kpu0Jf5b55
         UiNrPPvLYOGNs68mmuovZoT7j7qyNOdx1CS3t8yZ+YqRIqMWU7/RVHuhBmZtNf8Pcqhh
         fO7WZE2sruvYWGsx+4JQGw2Uoz7OnnZGnpvB/HYrC181ZodSAf+hv1OjlZsskkgWh58D
         oefZfyuxXzkV0y9GzLL1tAkNnViKe9Z+0iktaAKXF7ttbqhpaSUaXs+A6W1UmqeXogq7
         c2S0nMYxFFI7/iQL63XP75XkYOShPbFLXTLeWiCCPL9nU4gQHot3F929xVJ3FBpgo1VG
         GH/A==
X-Gm-Message-State: AOAM533m0fx6FlHuQZ2EJcCJV/AHZ+OD3En3YqwbNYE5VuGQKNYMigqu
        1lOx6h51tND/6iEGpDfryIJAZkGQGsuEDA==
X-Google-Smtp-Source: ABdhPJxQzEXxTqAlBFQKmpwia8dLBguaD/yixYCMxhvzzHYMeSX4k8WZ1jqrzOWY0Tfc6fDttip4rQ==
X-Received: by 2002:a63:8ac8:: with SMTP id y191mr21388637pgd.159.1600328682244;
        Thu, 17 Sep 2020 00:44:42 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j9sm4931711pfc.175.2020.09.17.00.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:44:41 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
Date:   Thu, 17 Sep 2020 00:44:13 -0700
Message-Id: <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1600328335.git.liu.denton@gmail.com>
References: <cover.1599723087.git.liu.denton@gmail.com> <cover.1600328335.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to get the diff between a commit and its merge base, the
currently preferred method is to use `git diff A...B`. However, the
range-notation with diff has, time and time again, been noted as a point
of confusion and thus, it should be avoided. Although we have a
substitute for the double-dot notation, we don't have any replacement
for the triple-dot notation.

Introduce the --merge-base flag as a replacement for triple-dot
notation. Thus, we would be able to write the above as
`git diff --merge-base A B`, allowing us to gently deprecate
range-notation completely.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-diff-tree.txt      |  7 ++++-
 Documentation/git-diff.txt           |  9 ++++---
 builtin/diff-tree.c                  | 18 +++++++++++++
 builtin/diff.c                       | 40 +++++++++++++++++++---------
 t/t4068-diff-symmetric-merge-base.sh | 34 +++++++++++++++++++++++
 5 files changed, 91 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 5c8a2a5e97..2fc24c542f 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git diff-tree' [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]
-	      [-t] [-r] [-c | --cc] [--combined-all-paths] [--root]
+	      [-t] [-r] [-c | --cc] [--combined-all-paths] [--root] [--merge-base]
 	      [<common diff options>] <tree-ish> [<tree-ish>] [<path>...]
 
 DESCRIPTION
@@ -43,6 +43,11 @@ include::diff-options.txt[]
 	When `--root` is specified the initial commit will be shown as a big
 	creation event. This is equivalent to a diff against the NULL tree.
 
+--merge-base::
+	Instead of comparing the <tree-ish>s directly, use the merge
+	base between the two <tree-ish>s as the "before" side.  There
+	must be two <tree-ish>s given and they must both be commits.
+
 --stdin::
 	When `--stdin` is specified, the command does not take
 	<tree-ish> arguments from the command line.  Instead, it
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 762ee6d074..d3b526e00a 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -11,8 +11,7 @@ SYNOPSIS
 [verse]
 'git diff' [<options>] [<commit>] [--] [<path>...]
 'git diff' [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
-'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]
-'git diff' [<options>] <commit>...<commit> [--] [<path>...]
+'git diff' [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
 'git diff' [<options>] <blob> <blob>
 'git diff' [<options>] --no-index [--] <path> <path>
 
@@ -62,10 +61,14 @@ of <commit> and HEAD.  `git diff --merge-base A` is equivalent to
 	branch name to compare with the tip of a different
 	branch.
 
-'git diff' [<options>] <commit> <commit> [--] [<path>...]::
+'git diff' [<options>] [--merge-base] <commit> <commit> [--] [<path>...]::
 
 	This is to view the changes between two arbitrary
 	<commit>.
++
+If --merge-base is given, use the merge base of the two commits for the
+"before" side.  `git diff --merge-base A B` is equivalent to
+`git diff $(git merge-base A B) B`.
 
 'git diff' [<options>] <commit> <commit>... <commit> [--] [<path>...]::
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 802363d0a2..823d6678e5 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -111,6 +111,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	struct setup_revision_opt s_r_opt;
 	struct userformat_want w;
 	int read_stdin = 0;
+	int merge_base = 0;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(diff_tree_usage);
@@ -143,9 +144,26 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 			read_stdin = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--merge-base")) {
+			merge_base = 1;
+			continue;
+		}
 		usage(diff_tree_usage);
 	}
 
+	if (read_stdin && merge_base)
+		die(_("--stdin and --merge-base are mutually exclusive"));
+
+	if (merge_base) {
+		struct object_id oid;
+
+		if (opt->pending.nr != 2)
+			die(_("--merge-base only works with two commits"));
+
+		diff_get_merge_base(opt, &oid);
+		opt->pending.objects[0].item = lookup_object(the_repository, &oid);
+	}
+
 	/*
 	 * NOTE!  We expect "a..b" to expand to "^a b" but it is
 	 * perfectly valid for revision range parser to yield "b ^a",
diff --git a/builtin/diff.c b/builtin/diff.c
index 1baea18ae0..ad78bc89b3 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -26,8 +26,7 @@
 static const char builtin_diff_usage[] =
 "git diff [<options>] [<commit>] [--] [<path>...]\n"
 "   or: git diff [<options>] --cached [<commit>] [--] [<path>...]\n"
-"   or: git diff [<options>] <commit> [<commit>...] <commit> [--] [<path>...]\n"
-"   or: git diff [<options>] <commit>...<commit>] [--] [<path>...]\n"
+"   or: git diff [<options>] <commit> [--merge-base] [<commit>...] <commit> [--] [<path>...]\n"
 "   or: git diff [<options>] <blob> <blob>]\n"
 "   or: git diff [<options>] --no-index [--] <path> <path>]\n"
 COMMON_DIFF_OPTIONS_HELP;
@@ -172,19 +171,34 @@ static int builtin_diff_tree(struct rev_info *revs,
 			     struct object_array_entry *ent1)
 {
 	const struct object_id *(oid[2]);
-	int swap = 0;
+	struct object_id mb_oid;
+	int merge_base = 0;
 
-	if (argc > 1)
-		usage(builtin_diff_usage);
+	while (1 < argc) {
+		const char *arg = argv[1];
+		if (!strcmp(arg, "--merge-base"))
+			merge_base = 1;
+		else
+			usage(builtin_diff_usage);
+		argv++; argc--;
+	}
 
-	/*
-	 * We saw two trees, ent0 and ent1.  If ent1 is uninteresting,
-	 * swap them.
-	 */
-	if (ent1->item->flags & UNINTERESTING)
-		swap = 1;
-	oid[swap] = &ent0->item->oid;
-	oid[1 - swap] = &ent1->item->oid;
+	if (merge_base) {
+		diff_get_merge_base(revs, &mb_oid);
+		oid[0] = &mb_oid;
+		oid[1] = &revs->pending.objects[1].item->oid;
+	} else {
+		int swap = 0;
+
+		/*
+		 * We saw two trees, ent0 and ent1.  If ent1 is uninteresting,
+		 * swap them.
+		 */
+		if (ent1->item->flags & UNINTERESTING)
+			swap = 1;
+		oid[swap] = &ent0->item->oid;
+		oid[1 - swap] = &ent1->item->oid;
+	}
 	diff_tree_oid(oid[0], oid[1], "", &revs->diffopt);
 	log_tree_diff_flush(revs);
 	return 0;
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetric-merge-base.sh
index 49432379cb..03487cc945 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -156,4 +156,38 @@ do
 	'
 done
 
+for cmd in diff-tree diff
+do
+	test_expect_success "$cmd --merge-base with two commits" '
+		git $cmd commit-C master >expect &&
+		git $cmd --merge-base br2 master >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$cmd --merge-base commit and non-commit" '
+		test_must_fail git $cmd --merge-base br2 master^{tree} 2>err &&
+		test_i18ngrep "fatal: --merge-base only works with commits" err
+	'
+
+	test_expect_success "$cmd --merge-base with no merge bases and two commits" '
+		test_must_fail git $cmd --merge-base br2 br3 2>err &&
+		test_i18ngrep "fatal: no merge base found" err
+	'
+
+	test_expect_success "$cmd --merge-base with multiple merge bases and two commits" '
+		test_must_fail git $cmd --merge-base master br1 2>err &&
+		test_i18ngrep "fatal: multiple merge bases found" err
+	'
+done
+
+test_expect_success 'diff-tree --merge-base with one commit' '
+	test_must_fail git diff-tree --merge-base master 2>err &&
+	test_i18ngrep "fatal: --merge-base only works with two commits" err
+'
+
+test_expect_success 'diff --merge-base with range' '
+	test_must_fail git diff --merge-base br2..br3 2>err &&
+	test_i18ngrep "fatal: --merge-base does not work with ranges" err
+'
+
 test_done
-- 
2.28.0.618.gf4bc123cb7

