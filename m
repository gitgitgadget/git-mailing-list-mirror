Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039FC199E89
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754237449; cv=none; b=b5OxPOsuiodhzqjea4P+dRhzAj8qpfddabckd+NrqYT28ijFBigHohshj5xCsY602M5hNNlO3rg5iPYZ5qc8+XqnBIPVwOFy9X7Gp2XH+eMdRJe6Rpm8xVk402RteurQuNbIlrhmApAS7JUiE6ZaXPiLnF3kqjMohNnhwWKrBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754237449; c=relaxed/simple;
	bh=R4S2GZy70RwfdW1CCN3ZQa3bomIHyzJfPf6P65Cfi54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LS20j3w/95N8bEfhXf4CShWmDIw2fpTPjTgsXDtayQF7z5rArNtaMMawNGlUzk1b/8xKoU54L57iWvzrvlY4A9S00MWejazbZWwaRA4wFg4YBeR0wBnDdMvfOHS26yFgVb1PofeHvft+MB81HzqTBSBJY/9fWYv7gOwNlrGDL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CU7ckkPa; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU7ckkPa"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8fe4942e68so1390883276.2
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754237447; x=1754842247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLv1phfPWbFdIBIqkraNnqZqiOovxu/zyBlxTcLFfjQ=;
        b=CU7ckkPasErrNtu2WxoGmKEUrTZrjIjRfiOAuGD/KAQclp9lZlWupZlHh+Cn9cuc2c
         obL/Hx15r6XT5QgWmsOcHfAcFdZjnDLNMMVXnZHX4yGGuXXM0prt1HHkWOwwpEJKWtke
         1+cUaH82o3RTCVjON7Vpivy2E9Dzq82ttGLKQ3U5hMOYvrnL86r2/PJzUaykrqimaqdu
         gLnNvJzB4koUgRe2Oxd+wlPyuw7nDjdaMYC1qh7FRdJ67lwkabGN5mdecEvFKlQHV8+I
         Ahx68Z8RhMAQ9Yb5mZuZ9KjCABZg+QHN53Dw5dzn1AkU0yVYW/JtS5FQkoXJqA07rKmN
         fuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754237447; x=1754842247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YLv1phfPWbFdIBIqkraNnqZqiOovxu/zyBlxTcLFfjQ=;
        b=kSRPQWdu0gChBogltAldVDGINGcassiEDH6Po0SW/mlP5lGa6nEL+89bj1QuhPH5ZH
         5/ymNeb55rOsYvQfhtVGr+r8TYe3Lyf969/qiEZ9qpbdk+7eS4QPXfm3jQfccfuC/wEb
         0dbgS+DXrLQVfy51VbjPEm0EDrmnIwJcTR91fEBIIzVbm/3KNX7qu65oGzK1ER3sA+hV
         NXS7yQPlgCCDxNe1+BISdroYL1h1teiMYjOIgJ2/cBSTaQB3JOLId2mp7emeINOgjqIQ
         y0r03FG473SX70hKiR3bzLKRav4mNIQIfq1NsVQ0opNXy0CEpK1whZMwa7jiVud9pVtC
         8E7w==
X-Gm-Message-State: AOJu0Yw0EX2b4TzB/2xQvNxBDKOC5/yauENYBhlzNZDDMLL8mKSeWJYJ
	i5kTHRB2MQb0FycJfNlE2ceU+OqMFHM90mlH18/r59MdbQLVrXMruY5bedDO6HXk
X-Gm-Gg: ASbGncupbxGa45j7PwRsXyUliRx6QG2lz++CAmZH5yh4Yy2TxtnT0Uf/Qq+v2rgq51F
	uc0ymrg/SRmvQJpKt98bvP42fuR3YsTTtzAstBaBt+IXY2qLOg1phzmidBkRjY0mv52ua/0oc8P
	iEoQ6Cpq8gqc9HNjVJ5etbRb+1Vab/vkqkuhIS9wgvOInuC9YucjGZ7eew1idsBl8OvEwMsIKGi
	kyHcUhOYoMlGda1DtV3LsLqGr9iX1mJoz5pr3wqoost6tfh0/tum/vZ3Eqd1wNWe/6LITXQ18w0
	pFr7VuNGBOtDd3QvArX8miHcB4u4AOGQpu6AJ/QpPiZF2vSJCBuFajHBmfab6Z+V3f5OOwW7sf/
	8aqL/9qeWy5okS1ATeFUG0VmxW6+nKBSC8HBZwoGmwWRgfjYVpS91vwYoby1ue8ERmUlVvLGViF
	WVQNOWUA==
X-Google-Smtp-Source: AGHT+IGmwcMzlI//HAXvP17pXMJ9v5zQCHN1qhWdabk0I9pZqmncbaJIEumKQraovUu2aNCVaG1IJg==
X-Received: by 2002:a05:6902:4187:b0:e81:e494:eee0 with SMTP id 3f1490d57ef6-e8fee0d5256mr7541506276.27.1754237446616;
        Sun, 03 Aug 2025 09:10:46 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:a173:55da:e3b1:53f])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3713e9fsm3100175276.5.2025.08.03.09.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 09:10:45 -0700 (PDT)
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
Subject: [PATCH v3 3/3] builtin: also setup gently for --help-all
Date: Sun,  3 Aug 2025 12:10:27 -0400
Message-ID: <20250803161033.77696-4-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250803012613.54086-1-ben.knoble+github@gmail.com>
References: <20250803012613.54086-1-ben.knoble+github@gmail.com>
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
index 3dc602872a..e34321dd44 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -133,6 +133,10 @@
 		test_expect_code 129 nongit git $cmd -h >usage &&
 		test_grep "[Uu]sage: git $cmd " usage
 	'
+	test_$expect_outcome $prereq "'git $cmd --help-all' outside a repository" '
+		test_expect_code 129 nongit git $cmd --help-all >usage &&
+		test_grep "[Uu]sage: git $cmd " usage
+	'
 done
 
 test_done
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

