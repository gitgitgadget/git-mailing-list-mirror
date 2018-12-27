Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9D0211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbeL0Q0F (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:26:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37103 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbeL0Q0E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:26:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so12988615lfj.4
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cka2RIEzbXW8Mc02eXJeQ6ivYDzaQWQUK3Y2L8gBTx0=;
        b=BTRmcXehreIuPVR7ujPYRMYfNCVqdYrbfFkZzOlYnrshHxr5fihTfplocWWZ5GupU2
         e6iJ5ci7r3waFMBaZeEcnYg9XDVpwnQuDM6JuUtPrJ9zchVLPhWRa83+n4TaZZi1RKHP
         uEje994MBw2hpC1kZWobsw7QVBYfRqy7EG/d6E1gf4Jy7ckckOXRZvF2UZmsbZO7xE72
         exmOlpdmdYkpJpQhcxQwc4tvrbaagj1US7qVbAXftTdQux0vaR4sW5FuPViZi3fUo8Hf
         opmXDdgH4cNDdfKmOgN9WMnUulOpH5j5niwMZsaXPRXFCVJuJe9L3c/FFwHyBU7oVf2r
         BMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cka2RIEzbXW8Mc02eXJeQ6ivYDzaQWQUK3Y2L8gBTx0=;
        b=hdh7oTSYumvpoX8HYj0f2bfnzXkZCI/hPX+xeL0QRkalDT9jhEj/F5//ek4NRptZZ8
         K3+qpIN78ZdcZlkPrrCDKoPfZqLj+1QvhCJ4S37VKz62LPfpOf59di0YLUUF4wnPqIh4
         aqCvzia7GIDDd0tx7QhO+5jgcUCNMqGE3ykacNmuVa/Tc7AmSW0yVb1SkgwJGdLThWFN
         027q5KOABebiiHomCPLGeb53YYTPnd6PUNHyfC+QrMOfGgzZiTIzHOBpkFYNUpifL+p+
         dwqvv9rAJ/qJn8HSXVZlKabWuZK15rAhrWuD5bueOZxUBn8LKCunByOCSNJyKh5+ypt8
         AyeA==
X-Gm-Message-State: AA+aEWYFARsOxRoNMl6nYZ56SrYArHa/7sDlKOFFuBSUHFzxX8hrH8ev
        VVQ9aH1EcC6wOJpzQqN8pyHeYz4k
X-Google-Smtp-Source: AFSGD/VhKq9U2f1IO6F/WTHRoE/Z7XxKxaz78UaB6jO4cXdgZtwSKRYGtSKnP6xDR3Q6Ct81AmzP7Q==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr12987028lfi.19.1545927961590;
        Thu, 27 Dec 2018 08:26:01 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:26:00 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 74/75] diff --no-index: use parse_options() instead of diff_opt_parse()
Date:   Thu, 27 Dec 2018 17:25:35 +0100
Message-Id: <20181227162536.15895-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227162536.15895-1-pclouds@gmail.com>
References: <20181227162536.15895-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at there, move exit() back to the caller. It's easier to see the
flow that way then burying it in diff-no-index.c

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/diff.c           | 21 +++--------------
 diff-no-index.c          | 49 ++++++++++++++++++++++++----------------
 diff.h                   |  3 ++-
 t/t4053-diff-no-index.sh |  3 +--
 4 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index f0393bba23..52dc3e136f 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -320,26 +320,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	repo_init_revisions(the_repository, &rev, prefix);
 
-	if (no_index && argc != i + 2) {
-		if (no_index == DIFF_NO_INDEX_IMPLICIT) {
-			/*
-			 * There was no --no-index and there were not two
-			 * paths. It is possible that the user intended
-			 * to do an inside-repository operation.
-			 */
-			fprintf(stderr, "Not a git repository\n");
-			fprintf(stderr,
-				"To compare two paths outside a working tree:\n");
-		}
-		/* Give the usage message for non-repository usage and exit. */
-		usagef("git diff %s <path> <path>",
-		       no_index == DIFF_NO_INDEX_EXPLICIT ?
-		       "--no-index" : "[--no-index]");
-
-	}
 	if (no_index)
 		/* If this is a no-index diff, just run it and exit there. */
-		diff_no_index(the_repository, &rev, argc, argv);
+		exit(diff_no_index(the_repository, &rev,
+				   no_index == DIFF_NO_INDEX_IMPLICIT,
+				   argc, argv));
 
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
diff --git a/diff-no-index.c b/diff-no-index.c
index 9414e922d1..a879f45862 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -14,6 +14,7 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
+#include "parse-options.h"
 #include "string-list.h"
 #include "dir.h"
 
@@ -233,35 +234,43 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
 	}
 }
 
-void diff_no_index(struct repository *r,
-		   struct rev_info *revs,
-		   int argc, const char **argv)
+static const char * const diff_no_index_usage[] = {
+	N_("git diff --no-index [<options>] <path> <path>"),
+	NULL
+};
+
+int diff_no_index(struct repository *r,
+		  struct rev_info *revs,
+		  int implicit_no_index,
+		  int argc, const char **argv)
 {
-	int i;
+	int i, no_index;
 	const char *paths[2];
 	struct strbuf replacement = STRBUF_INIT;
 	const char *prefix = revs->prefix;
+	struct option no_index_options[] = {
+		OPT_BOOL_F(0, "no-index", &no_index, "",
+			   PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
+		OPT_END(),
+	};
+	struct option *options;
 
 	/*
 	 * FIXME: --no-index should not look at index and we should be
 	 * able to pass NULL repo. Maybe later.
 	 */
 	repo_diff_setup(r, &revs->diffopt);
-	for (i = 1; i < argc - 2; ) {
-		int j;
-		if (!strcmp(argv[i], "--no-index"))
-			i++;
-		else if (!strcmp(argv[i], "--"))
-			i++;
-		else {
-			j = diff_opt_parse(&revs->diffopt, argv + i, argc - i,
-					   revs->prefix);
-			if (j <= 0)
-				die("invalid diff option/value: %s", argv[i]);
-			i += j;
-		}
+	options = parse_options_concat(no_index_options,
+				       revs->diffopt.parseopts);
+	argc = parse_options(argc, argv, revs->prefix, options,
+			     diff_no_index_usage, 0);
+	if (argc != 2) {
+		if (implicit_no_index)
+			warning(_("Not a git repository. Use --no-index to "
+				  "compare two paths outside a working tree"));
+		usage_with_options(diff_no_index_usage, options);
 	}
-
+	FREE_AND_NULL(options);
 	for (i = 0; i < 2; i++) {
 		const char *p = argv[argc - 2 + i];
 		if (!strcmp(p, "-"))
@@ -293,7 +302,7 @@ void diff_no_index(struct repository *r,
 	revs->diffopt.flags.exit_with_status = 1;
 
 	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
-		exit(1);
+		return 1;
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
@@ -304,5 +313,5 @@ void diff_no_index(struct repository *r,
 	 * The return code for --no-index imitates diff(1):
 	 * 0 = no changes, 1 = changes, else error
 	 */
-	exit(diff_result_code(&revs->diffopt, 0));
+	return diff_result_code(&revs->diffopt, 0);
 }
diff --git a/diff.h b/diff.h
index 8c4748ebcf..44843d8929 100644
--- a/diff.h
+++ b/diff.h
@@ -437,7 +437,8 @@ int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
 
 int diff_result_code(struct diff_options *, int);
 
-void diff_no_index(struct repository *, struct rev_info *, int, const char **);
+int diff_no_index(struct repository *, struct rev_info *,
+		  int implicit_no_index, int, const char **);
 
 int index_differs_from(const char *def, const struct diff_flags *flags,
 		       int ita_invisible_in_index);
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 6e0dd6f9e5..fb25cdb789 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -50,8 +50,7 @@ test_expect_success 'git diff --no-index executed outside repo gives correct err
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
 		test_must_fail git diff --no-index a 2>actual.err &&
-		echo "usage: git diff --no-index <path> <path>" >expect.err &&
-		test_cmp expect.err actual.err
+		test_i18ngrep "usage: git diff --no-index" actual.err
 	)
 '
 
-- 
2.20.0.482.g66447595a7

