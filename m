Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B71DED47
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330842; cv=none; b=GUDjPMtDBYYmskavsehDh6jlaXJCQGfDst3b+fkJoUviBPvxGr0fJ/GUpxxMrlxkIgAx7Xy01fCLEBmLyXvCB4xQXXaMPJJI54XChe2kcQnw1UU5lJYw68euXJ0zv+7poUl9DUlE5EPlOWKFbC3O1cByg0Pcg/iHkN9aKRGFFYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330842; c=relaxed/simple;
	bh=28IzWsWn7PsJXZb78l3jLfm8gf/S4/HRZazYxiTSX18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIKpxkMLJzWBtXEPhEeWMdLIshLGtzUsK5xNDl61VkTgPmQXrouaAc/xaOFP3f5UlZ5ViEW8jRkI4gYgkyVfjrk3GjAHc9OOZWeshgjYryXfoAAh42SN9QUQKQOFJLcmgScdM8rznRNxbxGhVJksKtbOosW+GjgMZPRNfmAHyEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrW+nC8q; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrW+nC8q"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f6d264221so47666425ad.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330840; x=1739935640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Erv8a5fqvim9awrB1iO+/Ads0N6mWJlJ1qKWl3/7hU0=;
        b=GrW+nC8q1nN5IdDQBzjZIUsJa+pjB0tOfKFHwOk5AUTuuihzFaUc0z3Ii5oztI7R2E
         No9WOBVZyM1U1PXkzWwBrWAjmyTetI5g2hEhKOKQxZ+pw9e/AiUxU/jSuXSCC5Xjb/Xd
         eRGW6JMC+WEV0u6e3MiY49G8gAPG5qfOjS//CXCZ2S8C8zAxgsMm53Ha0IJb+asQZyka
         4js2ZEM64oFYMwau41SM9L04yoUdCpAla+R172seTUHy4Ep1qjz8xwEis6d8NFGbJHDW
         kqTthCD6Iz/rS+9JcFVKg5OsOkVI0CDprZDbPYJikAsfW7tRhtWUR1Bq9OdL4G/rC8Cd
         xjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330840; x=1739935640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Erv8a5fqvim9awrB1iO+/Ads0N6mWJlJ1qKWl3/7hU0=;
        b=toN+kjqMLU78HpL2aeZdIV+gOaY3yrOSqOIKFVKeOcaVUzPvoN+o0RRRPPGt4nl74r
         Um9y2rSRSAzOEMyrX10CH2bf5OEfxrijJJLiBN1PO9PR97E0GYDgVfdC62EkyerfblR/
         pM6j5JNSNZdWDN25IElgIiNtCtO2mF2ievSVq8ONpwf+Xroq76WzRtk9J7v+CDhSOld7
         StefXt9avWRj84rNBFEla4doqqtD74zTnmaS9dSDVh6WZH/q67D882+wEf+GrfJuGxIU
         Q1vXhEx9slgW0TROBk+UOvmGwr5m0ss5VR8At70Tb2XAIHq5x6AdnkVm0NOcprXEwsAw
         yySA==
X-Forwarded-Encrypted: i=1; AJvYcCXXLO+xo5LRSp/83NtW4y7OQ3EDRAhPQpK+kYqldTF+01ytnG5lR+oH8LgiG8SQZV7115w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9XPICbz1MhBwHtPAX4hsksbJXxbnAUaJ39DY6o9uCS8EOxJcv
	ynVO6X0YEfJHhv/5aTgtiS51Zn1r250qtmeBqwYC4xMhj5BXamDS
X-Gm-Gg: ASbGncu3TTM70pY9rQrlKhM2MnCx8mQeaIYwTDBSjI0K3ru4UmCIfXUubokN2WKGhM8
	yE54kmvhHI5zO84jzCYEKlDTBbYlio7loi6b3TkbkITGFIobhV0otcAzi6T7lljhWfWopnpiUsS
	Jq8e/4SsGAXyH5ouvk8cixOreWL649nTpOLIJGdHqv6iALfWhNxgBgJv1nyKDTR5GEbjrQdhYdB
	IUG3nL5fMSiR91hjOXusdwAgroJuazrE6DWG39AA9olfy0C+UM4z8xqAC12dyGmrXu9FyzjQa/W
	wIhv1OGabNpob0twtlP8smbEaUofWmhaORTtu/8=
X-Google-Smtp-Source: AGHT+IH3v8ESwdNyoBTIiXjpUGwmJi7TmwonMGMoXJtU6aPRXSlqip9nij6JECUkHH7E/9+Ua7fqpg==
X-Received: by 2002:a05:6a00:3283:b0:730:949d:2d3f with SMTP id d2e1a72fcca58-7322c388652mr1962883b3a.7.1739330839759;
        Tue, 11 Feb 2025 19:27:19 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:508a:741e:539b:1c5c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm10129577b3a.74.2025.02.11.19.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:27:19 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v5 06/10] diff: --patch-{grep,modifies} arg names for -G and -S
Date: Tue, 11 Feb 2025 19:26:50 -0800
Message-ID: <20250212032657.1807939-7-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250212032657.1807939-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
 <20250212032657.1807939-1-illia.bobyr@gmail.com>
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
 Documentation/diff-options.txt |  2 ++
 Documentation/gitdiffcore.txt  |  3 ++-
 diff.c                         | 12 ++++++----
 diff.h                         |  8 +++++--
 t/t4209-log-pickaxe.sh         | 42 ++++++++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 640eb..07413d 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
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
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 0d7d66..e934b9 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
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

