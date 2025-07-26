Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3776523CEF8
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753548845; cv=none; b=UQrx7BnS5yKNnGNJgMQydOpAdRC2ABHfG/+kVRU6445kYS+c0e7ZXK0pLLyD6CNNzhojIPEBzmQMjZkWHUjMFf/0nKCC5azyIQ4OSuPMDOz0tSXPvTsx56AfgZBmp1bszqc/lVg7TtXgmqtyTTRA5hRoOxMQkRTGJAXRplVcxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753548845; c=relaxed/simple;
	bh=G70HPS2rQwuISVioN0ZP/5FygHxYSXP5ulDZHKsgyXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMJvfi5j0g7iNngkHOdqWz6awa5QfsrR3z+h2OJBr8iBcVU9nVKRArQUVeG0NJDtVGu/Ci3rIE9bZ5IU0gvbpAJixhxjsFYJwc2f6CO240Ix1ZPrZUgxLbIYGszvW2nv8wv9BdGe5KQ83aFsjSu3wQ/7iy58qA7dzOUZbfHJGqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jObnCr1C; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jObnCr1C"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7180bb37846so25161847b3.3
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753548843; x=1754153643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u7TS4XZqMS4o+LGbiBVnjPzal9R4M8+Wuxgy4hwnis=;
        b=jObnCr1CGex7HrD4iitF/TphDHFOPvLsN/Lh/q4K1i4z0AiKBVC9DddryRJvCH/Jt5
         xt1T/6VFHlG8bYgf6h1bXyuTtjrMFLQ2m2Aaso5xTORaNjwOJaSUdYqVrBE+qG+53bLk
         fxowYYJmNDrPNd6RxqaJJVRRjeU9zIwJks3llshaOLN/ph2LIxkwa1mwpBRvOjCv96Rw
         cJQivP1Aqe6rVg9X5uNygtoRipbBpGSjxB2SLcPGscOwWqMWJQ0I1mquSLyBV8R3tZkz
         oqulBx2lYiSi2AETwiKhq4cHNj4+LbCxiY1LHt1cwZAWCfUzsNrlfrfobRb0yySRlDl+
         d8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753548843; x=1754153643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/u7TS4XZqMS4o+LGbiBVnjPzal9R4M8+Wuxgy4hwnis=;
        b=SOa0vZVixAw6UDJDWmc+mWGHsY1QzOJ37qv8M1+EQGwlVAUZeb6WUXl0plBg5VWf75
         r8A86ucF6m0/X6SJGDDYG10g4Ob/AWmMtJo+IM3NCMj2YhFCh0ecxc9Gfx46zWDK0pL9
         xzAy7Arh1C+imGmY/BBvKXCZ2b6DW97kl1UqN7Y2dbUBSQAD9kfBHgJdYIAkosoEx0so
         r0ERk39ZcOf+c+yYz5IyvnJnBqVWPT28MZK+WJc2q5oH4TLaBoE/k/UUNA8zSTSj66Y3
         vN1rGCOHGjMLA0spnYtSSngMDhntIoWazCJTx/SMzqpf6RpEH0877kTUAxALIeo7j+u6
         Gzlg==
X-Gm-Message-State: AOJu0YyP2swS/b5dYSp2BJpnRcg/2BJ2wtKrBq77N4GyaTNL8tORC8M9
	vqjYOBqHZFi9vR4jwoWTrhKMuNNT2RHSb70RHyN5xWRrhN7LcAuWzixoBZPWTA9L
X-Gm-Gg: ASbGnctjRWXkr0fMz3VTIOoLA9QMWg88drXP1FPQYEXn66OsyImoAUjbDBfv8HjCO2M
	tyo981evfaglGTgrLFq5k0mRWksTs2M/Zr3F7fSudsmqunmIJJ3T2/Te0UwqTO1FF3rbRwudvqx
	C9eLN/afEr/wtrdZBh1ObOy9OmpobLeV+3XHoxoFnb+RejFH7fm8Gde06PZrH8ia6JBrmgGqEYF
	lAYUXEaICU05QJavcaS8K655X8yudRXcMjS92vT5PV3OMb+q8zbseGNaRR6swEMAi1hpeXmJnRI
	Iul/zyEDR8VRZqKEfyMSyUmk604wSRrUDLb5wHgtyofTgxtiS+OODMWIL7nF6s8B++cU1A8rYxL
	m4vZUD1otfV9UqrsWsWyalHyTuXveI6s26ZauyajlHgR6rUYgyAVjzEcHIlEBHXAcXbsJISRv
X-Google-Smtp-Source: AGHT+IE2hsOH+C+C8QEEsrKzY11+2OSaR7z7wBnK1Ly9O6eRNTBH0eFssVz92dM+1HfWaC9VjUDDkw==
X-Received: by 2002:a05:690c:9c10:b0:70e:142d:9c4e with SMTP id 00721157ae682-719e342b83amr81025997b3.26.1753548842768;
        Sat, 26 Jul 2025 09:54:02 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:2412:fdcb:5dca:324c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f2152de0sm4964067b3.2.2025.07.26.09.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 09:54:02 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Lessley Dennington <lessleydennington@gmail.com>,
	Jeff King <peff@peff.net>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] builtin: also setup gently for --help-all
Date: Sat, 26 Jul 2025 12:53:13 -0400
Message-ID: <20250726165320.4039-4-ben.knoble+github@gmail.com>
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

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes:
    On interposition points:
    
    I originally considered leaving out the changes to
    show_usage_with_options_if_asked and relying on the parse-options API to
    do the right thing. Unfortunately, most commands can't make it all the
    way to parse-options when setting up gently, and trying to parse options
    without a repo creates myriad dependency problems (like: we might read
    config after parsing CLI options, so we have to make sure the parsed
    options overrride config).
    
    Some usage.c callers, like check-ref-format, probably deserve to be
    ported to parse-options at this point.
    
    I opted not to do anything too invasive with merge-recursive (like a
    prepatory "migrate to newer usage APIs") since I think it's going the
    way of the dodo?

 builtin/merge-recursive.c |  3 ++-
 git.c                     |  2 +-
 parse-options.c           | 11 ++++++++---
 t/t1517-outside-repo.sh   |  4 ++++
 usage.c                   |  3 ++-
 5 files changed, 17 insertions(+), 6 deletions(-)

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
index c3222cc9bb..e3ed42f709 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1464,9 +1464,14 @@ void show_usage_with_options_if_asked(int ac, const char **av,
 				      const char * const *usagestr,
 				      const struct option *opts)
 {
-	if (ac == 2 && !strcmp(av[1], "-h")) {
-		usage_with_options_internal(NULL, usagestr, opts, style_normal, to_out);
-		exit(129);
+	if (ac == 2) {
+		if (!strcmp(av[1], "-h")) {
+			usage_with_options_internal(NULL, usagestr, opts, style_normal, to_out);
+			exit(129);
+		} else if (!strcmp(av[1], "--help-all")) {
+			usage_with_options_internal(NULL, usagestr, opts, style_full, to_out);
+			exit(129);
+		}
 	}
 }
 
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index e235ecccde..b26a03d8a0 100755
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

