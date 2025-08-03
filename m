Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B782CCC0
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 01:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754184408; cv=none; b=FAOrssGWhLRf4dn1duDzFO3xIUHObs5ilRVRPQXp0mpTx/wgwqT9ayB4Fb9c3+/oGVFwwcSUSdgItDpHmv5jlvdcilOPp9Mp6zhWitqmm1S4O/awr5I/olpr3ECR1uwqpvK+wL0BfQvW+Un76VFvFCX67gZLdClnYEHtNVgoJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754184408; c=relaxed/simple;
	bh=5sKxHMOAW1vQX1WPJq1obD5YqcFXQ5Ku0VIhgbdtZfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bs3wBQ1GA0+Tf81z3PCLGvsgeZotfBAtOTzAGlMbfGYQgPgSlKwcP5moXeTEmg3/G5jk2SIN8ip6fFiK0n6zn5tKLIWurtSTkg+12MITsGTpaSXNTONNK/dd4mlUKyYzZt4J/2mo/rYRe20HvhWaVO+Cj1RJJ2Dyg2qoQy607vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3+om+0A; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3+om+0A"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8fd59485d8so1935314276.3
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 18:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754184405; x=1754789205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMKqL3DvdaE16LmQgfBYpSreTFc4brmpkKdj2Q4ypA8=;
        b=e3+om+0AhOt/YcIkGUDPJJPURTxlxBCTUOeLr0ZHgIXu+4o0Q7zCLaYSDFUVTz8Ma6
         YzOWFJZ3zi5p6F2TtSpFAjlOe1a2ketwn/4wPt1/jYzBIXySDx6vp65yCEwAuUjVr2H0
         rZEGStVVD+SYiB7zVI2mbUB7WNf9QvTWRaHV5q1tUP0jmazDChOWHc7NBN8GNUixjqLc
         R+ph7Tm99oBiSgkcjy73a0N+FJ2l/dq0la5IM7DU+QUqVG7BC9W5Xsn1bVvKCLvMNOlz
         H86Rh5aom2O6BiOvFUsT8rKaEDcrC1gi/uVB3P5xVJTelFmwv8+Botg9eX5oFpw+lP0e
         eKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754184405; x=1754789205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JMKqL3DvdaE16LmQgfBYpSreTFc4brmpkKdj2Q4ypA8=;
        b=gJf3PlCrWXOzyiSAHjmsIYL6l77FVu6j9M2z45kHG6FWnRzNJ/HiwdMQfMZKeGYCAp
         qVc07q/bVfKlccR1+cC02ZCQeUfWeUIYfdp9slaqXOheUEIraHgvpmOLmnTQCJVLnD3A
         0r2xgUz6OC28xY0WZa2zbb8BBrL4RdkVvFiWLbU8tNtoIuD2Lg1p5k9blwSmS1V9la+U
         h3YWqAIIjGUzk37FfqFQqC588FEHmF6wgfhBIceVr892DKZ6ZjCJLudjIK/rd2KMCzWE
         iWsdDyIXuELsrZTIZPJX1SW9AtSb8Ai+ZHB9ptlgBEEu5d8l7qFD+sC7hFyMrsCHrnwP
         WFZw==
X-Gm-Message-State: AOJu0Ywia0PlibmP8eNToa/npg1h6ZUoeuevlSd35ZdvLO49S41fHcuW
	3/cN/AuKHug2V7vdb8yan4L/PPG2K9QgYfdv/nhFmrmKYFzXxYjGVmWAWVvc98b6
X-Gm-Gg: ASbGncsInx583Bu5pYGghkBWvYnCJ3XSaurLsL20yY1lzgiphp15ZrF/4/ny3iiSNK5
	gYEUFcdFrBhvJYCT47Og7ZAuQeJ7j0QGDm2uK7T801Y2eC3abfJ9a3HUtL0mDWkWE7abppdwg3c
	7QamJeRgKBfdnxjkCFv7cmCOvUNOMdgs018LtNJhoI2CQ6yYU88PYK1mqR082ZC4yhAm9jmBTu7
	vd84XSbasRnuo1QsHyru43z6qtaF45kZIEEoFCUyev8eWEzQsYFoIacnquyKNi7ayQi8xifcgrB
	3qAy+FP5sGW7ubNb5XTTfbkk0fzqxrkQcPideDKeHYqtJ38icpYDUbmPLqsvu0vun00tMSMXwzK
	lFpxzQi4gnWIXFb7deO8wK2PDNBkAHOKr2q+E+neBvn+yHKrv0ogyKFfvnPp4QZxz20/wBGkcpS
	8c+g==
X-Google-Smtp-Source: AGHT+IFwxjoMGFeAzv/UjcsWcyOiOfmKb9ywBkVVhX3z+g0y3bw71nVDXysdKdYQECzRQhyd3nhZ6Q==
X-Received: by 2002:a05:6902:2385:b0:e8b:6b8e:9549 with SMTP id 3f1490d57ef6-e8fee1e86ecmr5129224276.44.1754184404829;
        Sat, 02 Aug 2025 18:26:44 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:88ae:3d99:b445:935b])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd38ba780sm2673602276.43.2025.08.02.18.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 18:26:43 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Lessley Dennington <lessleydennington@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: [PATCH v2 3/3] builtin: also setup gently for --help-all
Date: Sat,  2 Aug 2025 21:26:04 -0400
Message-ID: <20250803012613.54086-4-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726165320.4039-1-ben.knoble+github@gmail.com>
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git experts often check the help summary of a command to make sure they
spell options right when suggesting advice to colleagues. Further, they
might check hidden options when responding to queries about deprecated
options like git-rebase(1)'s "preserve merges" option. But some commands
don't support "--help-all" outside of a git directory. Running (for
example)

    git rebase --help-all

outside a directory fails in "setup_git_directory", erroring with the
localized form of

    fatal: not a git repository (or any of the parent directories): .git

Like 99caeed05d (Let 'git <command> -h' show usage without a git dir,
2009-11-09), we want to show the "--help-all" output even without a git
dir. Make "--help-all" where we expect "-h" to mean
"setup_git_directory_gently", and interpose early in the natural place
("show_usage_with_options_if_asked").

Do the same for usage callers with show_usage_if_asked.

The exception is merge-recursive, whose help block doesn't use newer
APIs.

Best-viewed-with: --ignore-space-change
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes:
    Some usage.c callers, like check-ref-format, probably deserve to be
    ported to parse-options at this point.

 builtin/merge-recursive.c |  3 ++-
 git.c                     |  2 +-
 parse-options.c           | 14 ++++++++++----
 t/t1517-outside-repo.sh   |  4 ++++
 usage.c                   |  3 ++-
 5 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 03b5100cfa..17aa4db37a 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -38,7 +38,8 @@ int cmd_merge_recursive(int argc,
 	if (argv[0] && ends_with(argv[0], "-subtree"))
 		o.subtree_shift = "";
 
-	if (argc == 2 && !strcmp(argv[1], "-h")) {
+	if (argc == 2 && (!strcmp(argv[1], "-h") ||
+			  !strcmp(argv[1], "--help-all"))) {
 		struct strbuf msg = STRBUF_INIT;
 		strbuf_addf(&msg, builtin_merge_recursive_usage, argv[0]);
 		show_usage_if_asked(argc, argv, msg.buf);
diff --git a/git.c b/git.c
index 07a5fe39fb..40d3df1b76 100644
--- a/git.c
+++ b/git.c
@@ -445,7 +445,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	const char *prefix;
 	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
 
-	help = argc == 2 && !strcmp(argv[1], "-h");
+	help = argc == 2 && (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help-all"));
 	if (help && (run_setup & RUN_SETUP))
 		/* demote to GENTLY to allow 'git cmd -h' outside repo */
 		run_setup = RUN_SETUP_GENTLY;
diff --git a/parse-options.c b/parse-options.c
index 169d76fb65..d9f960b7b5 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1461,10 +1461,16 @@ void show_usage_with_options_if_asked(int ac, const char **av,
 				      const char * const *usagestr,
 				      const struct option *opts)
 {
-	if (ac == 2 && !strcmp(av[1], "-h")) {
-		usage_with_options_internal(NULL, usagestr, opts,
-					    USAGE_NORMAL, USAGE_TO_STDOUT);
-		exit(129);
+	if (ac == 2) {
+		if (!strcmp(av[1], "-h")) {
+			usage_with_options_internal(NULL, usagestr, opts,
+						    USAGE_NORMAL, USAGE_TO_STDOUT);
+			exit(129);
+		} else if (!strcmp(av[1], "--help-all")) {
+			usage_with_options_internal(NULL, usagestr, opts,
+						    USAGE_FULL, USAGE_TO_STDOUT);
+			exit(129);
+		}
 	}
 }
 
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index deb72da66e..a780c54133 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -127,6 +127,10 @@
 		test_expect_code 129 nongit git $cmd -h >usage &&
 		test_grep "[Uu]sage: git $cmd " usage
 	'
+	test_$expect_outcome "'git $cmd --help-all' outside a repository" '
+		test_expect_code 129 nongit git $cmd --help-all >usage &&
+		test_grep "[Uu]sage: git $cmd " usage
+	'
 done
 
 test_expect_success 'prune does not crash with -h' '
diff --git a/usage.c b/usage.c
index 81913236a4..4c245ba0cb 100644
--- a/usage.c
+++ b/usage.c
@@ -192,7 +192,8 @@ static void show_usage_if_asked_helper(const char *err, ...)
 
 void show_usage_if_asked(int ac, const char **av, const char *err)
 {
-	if (ac == 2 && !strcmp(av[1], "-h"))
+	if (ac == 2 && (!strcmp(av[1], "-h") ||
+			!strcmp(av[1], "--help-all")))
 		show_usage_if_asked_helper(err);
 }
 
-- 
2.48.1

