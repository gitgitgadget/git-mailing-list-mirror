Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3291F12FC
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263863; cv=none; b=Zm23esf/H8ZLOGFOZIlSFSDoODq2MG7NIQbPwkygYa96G20Xh7UlvCDuC9x5awQtjwMDgI6dV75Atqd6KnUeJh9mmuiGkF18ehVjw6go2m0VjozLhypH1xF51DNFdu0+pKhNiy6592wVjw8aj3u5V8G76/xc0mCPaPAJpoZNenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263863; c=relaxed/simple;
	bh=3UnR73GTtifLICN8stfTJilSCo3nLALgm1y+Qv4ynbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQ2pDZC3j4ATtrve37peUt3vJCGfgsnrAfs4JEUST/wMjP3wSzGxQviANAdFkaKA4y1POjWGagsvijFwltaL/P9ip5+PZ/gLXBl1zoDD63PDDzAdM00H5YvWzNo3cGmpRtUgQQoMp7TYd/SU4AjUdh4aDHf5jIttpRArwB1slO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeyWbkLL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeyWbkLL"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa0c039d47so7638566a91.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 00:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739263860; x=1739868660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G36treEwss/9WNMzHAXXug4APvUl7PF1Bzub2QZpVIs=;
        b=JeyWbkLLj17xzDmFAggko4ODCBGZxtq/grC5nI9ZscftPFOAd+kF5lZNlsDfflqS+B
         yqshBOdo4V5fe962bkSloIfGdEhfXE3kyVYEsQi7ciOjKw3X0u3iY1TDC2HCp1Q0Paod
         n13N8zxXTQizaotyTOyE+sDihVO2GXDzJ5tOIebUN9x15a3uETqbVlnaXwQNVaEDqWnR
         Hl9Jcm0RQcoNmvKBwa022jzMbLK0O5GjM4MkIH8MADC6+jEysIO6FVW73aQ2Vam8LH9G
         khelJr30Fr6yHiFIz+4sSc7KPp39FQ4uErbcZnKvRZGaucBrrcDLo2ny4GbiXVk1cpsA
         S2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263860; x=1739868660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G36treEwss/9WNMzHAXXug4APvUl7PF1Bzub2QZpVIs=;
        b=fIC6+8z11aWq7y4vC+76PDUBC7JZWFmGwnbkIePWTEVD2sicKJ5EkZBwMB97k01UFI
         W/qDPmgaQe+A8mRoo949Bach0hQynvl/bg9f6z7v6Lujjw7rBrCNaAkQFGLiPamxCWZq
         Mwlk8quuLwrJa5KyHHGC4EJppzON5BRyw7i0/KQM1RtC78ef8rIz2vmd7zmsjpQFKY5E
         kAhMBHL/GGc6eHIh/1heD49ZqqbfNGtO3QR5JsvPMDxffGQJ2uliW8fzufW6aXpaqRFN
         ddKsiqSC6KwWj8C5mo9Yf0JdB4AGEnEIjODYH/2+4yFaIWIRJfiDzXNvSV9X+4HjOPrM
         BUuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3iuD+BHW+yTvdVWmFCFtwDoEe+wa6CjNdw5DhsWd/wkmKrLt1oTAopZeY3i8Vrnb6mRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPgSiWoq0VKmSSsX4d2azLKkYfCWJ/EhU7gBVcTpEWDeu+hEzx
	C9RkkkAnMxo5OYn+AGWhbgI8DQWHUVB0uXefzAvTO5smJSscSHtvtZQxbxDq
X-Gm-Gg: ASbGncskdiSIaxl5CROnL3TWq1r8kWW4QORSgOPLrIlfDTGtQwPJEHM/2LDF4oc71g3
	5PeSl0KJThaZu2tNxtU/+PiT11lBmahyMsY3GQh19ivQrkTisZ0L+/aBg/dbZvnN8noUSOps3Og
	r42OwvaDWmCzZp2FLT45yC/DkD6O2Jq1u0l7XOR7pFUXUzJ+BLRF0iqrYkE7yr2UfjA506ww6sE
	o0arLMkXsiXRO0ImFh39W4M8Mu+weKF0zmm+RWH1AGyFycUWff2AVOGjlXOwh/4CNuBnCIrGJeE
	eU23KM0KbggQq5ApJ0la8o0/Wtx7NPDzWBnoL7Q=
X-Google-Smtp-Source: AGHT+IFukAfhKqckZ18oUry7iMoJIlq0nAaNdqkUKCGuLo1giqpfoisawihcaFyhEcSkHzgq6Oxfsg==
X-Received: by 2002:a17:90b:4b0b:b0:2fa:ba3:5455 with SMTP id 98e67ed59e1d1-2fa23f55dcdmr27026693a91.7.1739263860508;
        Tue, 11 Feb 2025 00:51:00 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:3858:1e16:caad:e1d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a46534sm10201701a91.21.2025.02.11.00.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:51:00 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v4 06/10] diff: --patch-{grep,modifies} arg names for -G and -S
Date: Tue, 11 Feb 2025 00:50:18 -0800
Message-ID: <20250211085028.3923875-7-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206014324.1839232-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most arguments have both short and long versions.  Long versions are
easier to read, especially in scripts and command history.

This change mostly keeps existing uses of -G and -S as is in the tests,
documentation and help output.

Tests that check just the option parsing are duplicated to check both
short and long argument options.

Signed-off-by: Illia Bobyr <illia.bobyr@gmail.com>
---
 Documentation/diff-options.adoc |  2 ++
 Documentation/gitdiffcore.adoc  |  3 ++-
 diff.c                          | 12 ++++++----
 diff.h                          |  8 +++++--
 t/t4209-log-pickaxe.sh          | 42 +++++++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index 640eb..07413d 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -650,6 +650,7 @@ Note that not all diffs can feature all types. For instance, copied and
 renamed entries cannot appear if detection for those types is disabled.
 
 `-S<string>`::
+`--patch-modifies=<string>`::
 	Look for differences that change the number of occurrences of
 	the specified _<string>_ (i.e. addition/deletion) in a file.
 	Intended for the scripter's use.
@@ -663,6 +664,7 @@ very first version of the block.
 Binary files are searched as well.
 
 `-G<regex>`::
+`--patch-grep=<regex>`::
 	Look for differences whose patch text contains added/removed
 	lines that match _<regex>_.
 +
diff --git a/Documentation/gitdiffcore.adoc b/Documentation/gitdiffcore.adoc
index 0d7d66..e934b9 100644
--- a/Documentation/gitdiffcore.adoc
+++ b/Documentation/gitdiffcore.adoc
@@ -245,7 +245,8 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 
 This transformation limits the set of filepairs to those that change
 specified strings between the preimage and the postimage in a certain
-way.  `-S<string>` and `-G<regex>` options are used to specify
+way.  `--patch-modifies=<string>` (`-S<string>` for short) and
+`--patch-grep=<regex>` (`-G<regex>` for short) are used to specify
 different ways these strings are sought.
 
 `-S<string>` detects filepairs whose preimage and postimage
diff --git a/diff.c b/diff.c
index bd9db..ac2cd 100644
--- a/diff.c
+++ b/diff.c
@@ -4877,15 +4877,17 @@ void diff_setup_done(struct diff_options *options)
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
 		die(_("options '%s', '%s', and '%s' cannot be used together"),
-			"-G", "-S", "--find-object");
+			"-G/--patch-grep", "-S/--patch-modifies", "--find-object");
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
 		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s'"),
-			"-G", "--pickaxe-regex", "--pickaxe-regex", "-S");
+			"-G/--patch-grep", "--pickaxe-regex",
+			"--pickaxe-regex", "-S/--patch-modifies");
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK))
 		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s' and '%s'"),
-			"--pickaxe-all", "--find-object", "--pickaxe-all", "-G", "-S");
+			"--pickaxe-all", "--find-object",
+			"--pickaxe-all", "-G/--patch-grep", "-S/--patch-modifies");
 
 	/*
 	 * Most of the time we can say "there are changes"
@@ -5862,10 +5864,10 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_SET_INT_F(0, "ita-visible-in-index", &options->ita_invisible_in_index,
 			      N_("treat 'git add -N' entries as real in the index"),
 			      0, PARSE_OPT_NONEG),
-		OPT_CALLBACK_F('S', NULL, options, N_("<string>"),
+		OPT_CALLBACK_F('S', "patch-modifies", options, N_("<string>"),
 			       N_("look for differences that change the number of occurrences of the specified string"),
 			       0, diff_opt_pickaxe_string),
-		OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
+		OPT_CALLBACK_F('G', "patch-grep", options, N_("<regex>"),
 			       N_("look for differences where a patch contains the specified regex"),
 			       0, diff_opt_pickaxe_regex),
 		OPT_BIT_F(0, "pickaxe-all", &options->pickaxe_opts,
diff --git a/diff.h b/diff.h
index 787bb..ed48a 100644
--- a/diff.h
+++ b/diff.h
@@ -606,8 +606,12 @@ void diffcore_fix_diff_index(void);
 "                try unchanged files as candidate for copy detection.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
-"  -G<regex>     find differences where patch contains the specified regex.\n" \
-"  -S<string>    find filepair who differ in the number of occurrences of string.\n" \
+"  -G<regex>\n" \
+"  --patch-grep=<regex>\n" \
+"                find differences where patch contains the regex.\n" \
+"  -S<string>\n" \
+"  --patch-modifies=<string>\n" \
+"                find filepair who differ in the number of occurrences of string.\n" \
 "  --pickaxe-grep\n" \
 "                treat <string> as a regex in the -S argument.\n" \
 "  --pickaxe-all\n" \
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index ed70c..ab14b 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -60,24 +60,48 @@ test_expect_success 'usage' '
 	test_expect_code 129 git log -S 2>err &&
 	test_grep "switch.*requires a value" err &&
 
+	test_expect_code 129 git log --patch-modifies 2>err &&
+	test_grep "option.*requires a value" err &&
+
 	test_expect_code 129 git log -G 2>err &&
 	test_grep "switch.*requires a value" err &&
 
+	test_expect_code 129 git log --patch-grep 2>err &&
+	test_grep "option.*requires a value" err &&
+
 	test_expect_code 128 git log -Gregex -Sstring 2>err &&
 	grep "cannot be used together" err &&
 
+	test_expect_code 128 git log -Gregex --patch-modifies string 2>err &&
+	grep "cannot be used together" err &&
+
+	test_expect_code 128 git log --patch-grep regex -Sstring 2>err &&
+	grep "cannot be used together" err &&
+
+	test_expect_code 128 git log --patch-grep regex --patch-modifies string 2>err &&
+	grep "cannot be used together" err &&
+
 	test_expect_code 128 git log -Gregex --find-object=HEAD 2>err &&
 	grep "cannot be used together" err &&
 
+	test_expect_code 128 git log --patch-grep regex --find-object=HEAD 2>err &&
+	grep "cannot be used together" err &&
+
 	test_expect_code 128 git log -Sstring --find-object=HEAD 2>err &&
 	grep "cannot be used together" err &&
 
+	test_expect_code 128 git log --patch-modifies string --find-object=HEAD 2>err &&
+	grep "cannot be used together" err &&
+
 	test_expect_code 128 git log --pickaxe-all --find-object=HEAD 2>err &&
 	grep "cannot be used together" err
 '
 
 test_expect_success 'usage: --pickaxe-regex' '
 	test_expect_code 128 git log -Gregex --pickaxe-regex 2>err &&
+	grep "cannot be used together" err &&
+
+	test_expect_code 128 git log --patch-grep regex --pickaxe-regex 2>err &&
 	grep "cannot be used together" err
 '
 
@@ -89,7 +113,13 @@ test_expect_success 'usage: --no-pickaxe-regex' '
 	test_expect_code 128 git log -Sstring --no-pickaxe-regex 2>actual &&
 	test_cmp expect actual &&
 
+	test_expect_code 128 git log --patch-modifies string --no-pickaxe-regex 2>actual &&
+	test_cmp expect actual &&
+
 	test_expect_code 128 git log -Gregex --no-pickaxe-regex 2>err &&
+	test_cmp expect actual &&
+
+	test_expect_code 128 git log --patch-grep regex --no-pickaxe-regex 2>err &&
 	test_cmp expect actual
 '
 
@@ -104,9 +134,13 @@ test_log_icase	expect_second	--author person
 test_log_icase	expect_nomatch	--author spreon
 
 test_log	expect_nomatch	-G picked
+test_log	expect_nomatch	--patch-grep picked
 test_log	expect_second	-G Picked
+test_log	expect_second	--patch-grep Picked
 test_log_icase	expect_nomatch	-G pickle
+test_log_icase	expect_nomatch	--patch-grep pickle
 test_log_icase	expect_second	-G picked
+test_log_icase	expect_second	--patch-grep picked
 
 test_expect_success 'log -G --textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
@@ -122,14 +156,22 @@ test_expect_success 'log -G --no-textconv (missing textconv tool)' '
 '
 
 test_log	expect_nomatch	-S picked
+test_log	expect_nomatch	--patch-modifies picked
 test_log	expect_second	-S Picked
+test_log	expect_second	--patch-modifies Picked
 test_log_icase	expect_second	-S picked
+test_log_icase	expect_second	--patch-modifies picked
 test_log_icase	expect_nomatch	-S pickle
+test_log_icase	expect_nomatch	--patch-modifies pickle
 
 test_log	expect_nomatch	-S p.cked --pickaxe-regex
+test_log	expect_nomatch	--patch-modifies p.cked --pickaxe-regex
 test_log	expect_second	-S P.cked --pickaxe-regex
+test_log	expect_second	--patch-modifies P.cked --pickaxe-regex
 test_log_icase	expect_second	-S p.cked --pickaxe-regex
+test_log_icase	expect_second	--patch-modifies p.cked --pickaxe-regex
 test_log_icase	expect_nomatch	-S p.ckle --pickaxe-regex
+test_log_icase	expect_nomatch	--patch-modifies p.ckle --pickaxe-regex
 
 test_expect_success 'log -S --textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-- 
2.45.2

