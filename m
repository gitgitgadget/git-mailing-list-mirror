Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF2C45C18
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738806225; cv=none; b=MO5WYb5vV2tmw7RkhTWlejxlf0UOFPj3REUqEqXVrivbP4dNLd8x5EmoGva7OwODxYni5Z0rYaN7aBq7C53K/mWNByxtCRBOUI4YGUEGBdb6exsxh+W7n6+AkA68S4VDOuOwGjPumND18rsZTqR2cLgDlwrxS3CJdEjhsJoCyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738806225; c=relaxed/simple;
	bh=yEDH1VRAUATaVmjRawCJsiHulPIUDZromUFBGl7a+pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8PaNRKie02pRkN15AjmfnyggZoCI2VeHswRpTq7/o4c8fnlnTYqmfvZpjuWRUdwlCAsJWkHEmtYC4cYDdHGl7scejx6L9++/yw2SQUEa5d9nLrTQagMbDcinDT9VINDC5ODwq36ioHpSdRKaYJXSXnsPidKKOC8Pg2Gy3OwDfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhRuxD/J; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhRuxD/J"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9f6a2fa8dso480169a91.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 17:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738806223; x=1739411023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6k3o7yrdePuCkVWI0eLbWs9wf7+EOAXvk04N/TMl3Y=;
        b=HhRuxD/J9qIAERHH9W07UMNyo2Uiewg6l2sWav8ID6mDPobWjczpPU7L/tNoKsyY4c
         5j4Ls0SPg2V9Bd+9bHyoDXcHgGLyKpe5aO8/DZGSyn/4YzTbg8Nb4tf1HbGABGMU51lj
         L9x6PLbo94RJYkyst15N+X5tdZsndGFq8VOW3R41g9Cr+XlEKmwCCAPGzeq/gw3cURwb
         704PrFk+esdxpxVNhdjZcC4f1FPERVMK3vexJdpdsqe5bwFpqDhEzDqhmpTlsYktK4NI
         uJDQsG/J82rt3/G4VUF9pSZMzYgcl4hHDdHHcQEmxHGGZr927pNO4yhjMaDhJqpoTe0M
         wTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738806223; x=1739411023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6k3o7yrdePuCkVWI0eLbWs9wf7+EOAXvk04N/TMl3Y=;
        b=X0bI544vaPNbNXwmO1y4hTjC7jRPsb0r5eZ5pE82CjYt7qRQ3nJCIeXMF2WyZFoq6x
         zbtCr6UTBPvfqSyQazvGRkFaK95HBxF+iGMkS6aeoRI7h3hjJB7guzmuaaXgRux81HVl
         EF6fvRw74Quk5UDPlHf1SwzhK3Wl+2sxboVGQghhDxIybCx6jNVEGaixMfBXClKKvEX3
         b7Qafp13Pa1T25bD5BhtGcfjm84QeecBqtzAk9M073QF0OQhv7JSaMd8qcwYInoI6mRs
         zHHr/C+0qEhvUAZ2ci1Dn00CV0eaSez4Zrh6bT2WKxLc8PFdzxPaByf5kHJQT2hFD0wv
         3Xig==
X-Forwarded-Encrypted: i=1; AJvYcCUB4gkMg7e7ajvGPu5lKes0NCkWYzLb5AsxlTpxxPHi4k8kmandO4a8b4Htvx+yBkQvoc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvUPKu+oRDKqY6uloApBuMECww2frhXkMoKMgyH1EbZhASziiB
	p68oTb68S26HSXh7fuNiSysZeZrICz1KqglnwVzg7+zGg3qMX5q6
X-Gm-Gg: ASbGncvWQjvLVxwPUfR0lLUwxQ+qQFr4jee92GlXdVisgj0iU+emT9U0b4j05uxCSIn
	AQGAt+k3DDnsqcXaWmQ7uo55ITldlF36DKl4Fhklh3fUMp8QqAClydDAxWWObV7TOa0dGHq1Uwl
	Aw6bH7ceUM8Oqce1aU38jnR/NtV6A4xjOWzw1EDN/qo+xMCg4TOhMLLfc3SuKgXXDj9LD8+E3Yo
	YRFVhOJh4MYwUZPzV4rXSMF2TdOW+YxNrivlGuVVd9olz4j+YkwZiiefySha/7hKOLxVZS6bRzj
	4UN53dODG3bIIbDWWQapZL8A8tPPAtSJzOo30VA=
X-Google-Smtp-Source: AGHT+IFf9GYpeIfJLJFVnbOaMhvqz5WBeEND+AnQ1ZI0KE/eZtPFtY6hQN/Z7uNH9r4FpCEda6iMjQ==
X-Received: by 2002:a05:6a00:884:b0:726:41e:b310 with SMTP id d2e1a72fcca58-7303511d84emr7781415b3a.12.1738806222462;
        Wed, 05 Feb 2025 17:43:42 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:c1bf:72b5:6aa3:f684])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7e54sm130111b3a.76.2025.02.05.17.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 17:43:42 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v3 1/1] diff: --patch-{modifies,grep} arg names for -S and -G
Date: Wed,  5 Feb 2025 17:43:16 -0800
Message-ID: <20250206014324.1839232-2-illia.bobyr@gmail.com>
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

Tests that check just the option parsing are duplicated to check both
short and long argument options.  But more complex tests are updated to
use the long argument in order to improve the test readability.
Assuming that the usage tests have already verified that both arguments
invoke the same underlying functionality.

Signed-off-by: Illia Bobyr <illia.bobyr@gmail.com>
---
 Documentation/diff-options.txt |  36 +++++------
 Documentation/git-blame.txt    |   2 +-
 Documentation/gitdiffcore.txt  |  48 ++++++++-------
 diff.c                         |  18 +++---
 diff.h                         |  11 +++-
 t/t4062-diff-pickaxe.sh        |   8 +--
 t/t4209-log-pickaxe.sh         | 106 +++++++++++++++++++++++----------
 7 files changed, 142 insertions(+), 87 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 640eb..c9f7c 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -650,6 +650,7 @@ Note that not all diffs can feature all types. For instance, copied and
 renamed entries cannot appear if detection for those types is disabled.
 
 `-S<string>`::
+`--patch-modifies=<string>`::
 	Look for differences that change the number of occurrences of
 	the specified _<string>_ (i.e. addition/deletion) in a file.
 	Intended for the scripter's use.
@@ -657,18 +658,19 @@ renamed entries cannot appear if detection for those types is disabled.
 It is useful when you're looking for an exact block of code (like a
 struct), and want to know the history of that block since it first
 came into being: use the feature iteratively to feed the interesting
-block in the preimage back into `-S`, and keep going until you get the
-very first version of the block.
+block in the preimage back into `--patch-modifies`, and keep going until
+you get the very first version of the block.
 +
 Binary files are searched as well.
 
 `-G<regex>`::
+`--patch-grep=<regex>`::
 	Look for differences whose patch text contains added/removed
 	lines that match _<regex>_.
 +
-To illustrate the difference between `-S<regex>` `--pickaxe-regex` and
-`-G<regex>`, consider a commit with the following diff in the same
-file:
+To illustrate the difference between `--patch-modifies=<regex>
+--pickaxe-regex` and `--patch-grep=<regex>`, consider a commit with the
+following diff in the same file:
 +
 ----
 +    return frotz(nitfol, two->ptr, 1, 0);
@@ -676,9 +678,9 @@ file:
 -    hit = frotz(nitfol, mf2.ptr, 1, 0);
 ----
 +
-While `git log -G"frotz\(nitfol"` will show this commit, `git log
--S"frotz\(nitfol" --pickaxe-regex` will not (because the number of
-occurrences of that string did not change).
+While `git log --patch-grep="frotz\(nitfol"` will show this commit, `git
+log --patch-modifies="frotz\(nitfol" --pickaxe-regex` will not (because the
+number of occurrences of that string did not change).
 +
 Unless `--text` is supplied patches of binary files without a textconv
 filter will be ignored.
@@ -687,22 +689,22 @@ See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
 information.
 
 `--find-object=<object-id>`::
-	Look for differences that change the number of occurrences of
-	the specified object. Similar to `-S`, just the argument is different
-	in that it doesn't search for a specific string but for a specific
-	object id.
+	Look for differences that change the number of occurrences of the
+	specified object. Similar to `--patch-modifies`, just the argument
+	is different in that it doesn't search for a specific string but
+	for a specific object id.
 +
 The object can be a blob or a submodule commit. It implies the `-t` option in
 `git-log` to also find trees.
 
 `--pickaxe-all`::
-	When `-S` or `-G` finds a change, show all the changes in that
-	changeset, not just the files that contain the change
-	in _<string>_.
+	When `--patch-modifies` or `--patch-grep` finds a change, show all
+	the changes in that changeset, not just the files that contain the
+	change in _<string>_.
 
 `--pickaxe-regex`::
-	Treat the _<string>_ given to `-S` as an extended POSIX regular
-	expression to match.
+	Treat the _<string>_ given to `--patch-modifies` as an extended
+	POSIX regular expression to match.
 
 endif::git-format-patch[]
 
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index b1d7fb..0f21d3 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -41,7 +41,7 @@ a text string in the diff. A small example of the pickaxe interface
 that searches for `blame_usage`:
 
 -----------------------------------------------------------------------------
-$ git log --pretty=oneline -S'blame_usage'
+$ git log --pretty=oneline --patch-modifies='blame_usage'
 5040f17eba15504bad66b14a645bddd9b015ebb7 blame -S <ancestry-file>
 ea4c7f9bf69e781dd0cd88d2bccb2bf5cc15c9a7 git-blame: Make the output
 -----------------------------------------------------------------------------
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 642c5..e4b18 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -245,33 +245,35 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 
 This transformation limits the set of filepairs to those that change
 specified strings between the preimage and the postimage in a certain
-way.  -S<block-of-text> and -G<regular-expression> options are used to
-specify different ways these strings are sought.
-
-"-S<block-of-text>" detects filepairs whose preimage and postimage
-have different number of occurrences of the specified block of text.
-By definition, it will not detect in-file moves.  Also, when a
-changeset moves a file wholesale without affecting the interesting
-string, diffcore-rename kicks in as usual, and `-S` omits the filepair
-(since the number of occurrences of that string didn't change in that
+way.  --patch-modifies=<block-of-text> and
+--patch-grep=<regular-expression> options are used to specify
+different ways these strings are sought.
+
+"-S<block-of-text>", or "--patch-modifies=<block-of-text>" detects
+filepairs whose preimage and postimage have different number of
+occurrences of the specified block of text.  By definition, it will
+not detect in-file moves.  Also, when a changeset moves a file
+wholesale without affecting the interesting string, diffcore-rename
+kicks in as usual, and `--patch-modifies` omits the filepair (since
+the number of occurrences of that string didn't change in that
 rename-detected filepair).  When used with `--pickaxe-regex`, treat
 the <block-of-text> as an extended POSIX regular expression to match,
 instead of a literal string.
 
-"-G<regular-expression>" (mnemonic: grep) detects filepairs whose
-textual diff has an added or a deleted line that matches the given
-regular expression.  This means that it will detect in-file (or what
-rename-detection considers the same file) moves, which is noise.  The
-implementation runs diff twice and greps, and this can be quite
-expensive.  To speed things up, binary files without textconv filters
-will be ignored.
-
-When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
-that match their respective criterion are kept in the output.  When
-`--pickaxe-all` is used, if even one filepair matches their respective
-criterion in a changeset, the entire changeset is kept.  This behavior
-is designed to make reviewing changes in the context of the whole
-changeset easier.
+"-G<regular-expression>", or "--patch-grep=<regular-expression>"
+(mnemonic: grep) detects filepairs whose textual diff has an added or
+a deleted line that matches the given regular expression.  This means
+that it will detect in-file (or what rename-detection considers the
+same file) moves, which is noise.  The implementation runs diff twice
+and greps, and this can be quite expensive.  To speed things up,
+binary files without textconv filters will be ignored.
+
+When `--patch-modifies` or `--patch-grep` are used without
+`--pickaxe-all`, only filepairs that match their respective criterion
+are kept in the output.  When `--pickaxe-all` is used, if even one
+filepair matches their respective criterion in a changeset, the entire
+changeset is kept.  This behavior is designed to make reviewing
+changes in the context of the whole changeset easier.
 
 diffcore-order: For Sorting the Output Based on Filenames
 ---------------------------------------------------------
diff --git a/diff.c b/diff.c
index d28b41..09beb 100644
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
+                        "--pickaxe-regex", "-S/--patch-modifies");
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK))
 		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s' and '%s'"),
-			"--pickaxe-all", "--find-object", "--pickaxe-all", "-G", "-S");
+			"--pickaxe-all", "--find-object",
+                        "--pickaxe-all", "-G/--patch-grep", "-S/--patch-modifies");
 
 	/*
 	 * Most of the time we can say "there are changes"
@@ -5862,17 +5864,17 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_SET_INT_F(0, "ita-visible-in-index", &options->ita_invisible_in_index,
 			      N_("treat 'git add -N' entries as real in the index"),
 			      0, PARSE_OPT_NONEG),
-		OPT_CALLBACK_F('S', NULL, options, N_("<string>"),
+		OPT_CALLBACK_F('S', "patch-modifies", options, N_("<string>"),
 			       N_("look for differences that change the number of occurrences of the specified string"),
 			       0, diff_opt_pickaxe_string),
-		OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
-			       N_("look for differences that change the number of occurrences of the specified regex"),
+		OPT_CALLBACK_F('G', "patch-grep", options, N_("<regex>"),
+			       N_("look for differences where a patch contains the specified regex"),
 			       0, diff_opt_pickaxe_regex),
 		OPT_BIT_F(0, "pickaxe-all", &options->pickaxe_opts,
-			  N_("show all changes in the changeset with -S or -G"),
+			  N_("show all changes in the changeset with -S/--patch-modifies or -G/--patch-grep"),
 			  DIFF_PICKAXE_ALL, PARSE_OPT_NONEG),
 		OPT_BIT_F(0, "pickaxe-regex", &options->pickaxe_opts,
-			  N_("treat <string> in -S as extended POSIX regular expression"),
+			  N_("treat <string> in -S/--patch-modifies as extended POSIX regular expression"),
 			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
 		OPT_FILENAME('O', NULL, &options->orderfile,
 			     N_("control the order in which files appear in the output")),
diff --git a/diff.h b/diff.h
index 6e6007..247ac 100644
--- a/diff.h
+++ b/diff.h
@@ -598,9 +598,16 @@ void diffcore_fix_diff_index(void);
 "                try unchanged files as candidate for copy detection.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
-"  -S<string>    find filepair whose only one side contains the string.\n" \
+"  -G<regex>\n" \
+"  --patch-grep=<regex>\n" \
+"                find differences whose patch contains the regex.\n" \
+"  -S<string>\n" \
+"  --patch-modifies=<string>\n" \
+"                find filepair who differ in the number of occurrences of string.\n" \
+"  --pickaxe-grep\n" \
+"                treat <string> as regex in the -S/--patch-modifies argument.\n" \
 "  --pickaxe-all\n" \
-"                show all files diff when -S is used and hit is found.\n" \
+"                show all files diff for -G/--patch-grep and -S/--patch-modifies.\n" \
 "  -a  --text    treat all files as text.\n"
 
 int diff_queue_is_empty(struct diff_options *o);
diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
index 8ad3d7..805e0f 100755
--- a/t/t4062-diff-pickaxe.sh
+++ b/t/t4062-diff-pickaxe.sh
@@ -16,13 +16,13 @@ test_expect_success setup '
 '
 
 # OpenBSD only supports up to 255 repetitions, so repeat twice for 64*64=4096.
-test_expect_success '-G matches' '
-	git diff --name-only -G "^(0{64}){64}$" HEAD^ >out &&
+test_expect_success '--patch-grep matches' '
+	git diff --name-only --patch-grep "^(0{64}){64}$" HEAD^ >out &&
 	test 4096-zeroes.txt = "$(cat out)"
 '
 
-test_expect_success '-S --pickaxe-regex' '
-	git diff --name-only -S0 --pickaxe-regex HEAD^ >out &&
+test_expect_success '--patch-modifies --pickaxe-regex' '
+	git diff --name-only --patch-modifies 0 --pickaxe-regex HEAD^ >out &&
 	test 4096-zeroes.txt = "$(cat out)"
 '
 
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index a675ac..5f4d6 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='log --grep/--author/--regexp-ignore-case/-S/-G'
+test_description='log --grep/--author/--regexp-ignore-case/--patch-{modifies,grep}'
 
 . ./test-lib.sh
 
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
 
-	test_expect_code 128 git log -Gstring --no-pickaxe-regex 2>err &&
+	test_expect_code 128 git log --patch-modifies string --no-pickaxe-regex 2>actual &&
+	test_cmp expect actual &&
+
+	test_expect_code 128 git log -Gregex --no-pickaxe-regex 2>err &&
+	test_cmp expect actual &&
+
+	test_expect_code 128 git log --patch-grep regex --no-pickaxe-regex 2>err &&
 	test_cmp expect actual
 '
 
@@ -104,47 +134,59 @@ test_log_icase	expect_second	--author person
 test_log_icase	expect_nomatch	--author spreon
 
 test_log	expect_nomatch	-G picked
+test_log	expect_nomatch	--patch-grep picked
 test_log	expect_second	-G Picked
+test_log	expect_second	--patch-grep Picked
 test_log_icase	expect_nomatch	-G pickle
+test_log_icase	expect_nomatch	--patch-grep pickle
 test_log_icase	expect_second	-G picked
+test_log_icase	expect_second	--patch-grep picked
 
-test_expect_success 'log -G --textconv (missing textconv tool)' '
+test_expect_success 'log --patch-grep --textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-	test_must_fail git -c diff.test.textconv=missing log -Gfoo &&
+	test_must_fail git -c diff.test.textconv=missing log --patch-grep foo &&
 	rm .gitattributes
 '
 
-test_expect_success 'log -G --no-textconv (missing textconv tool)' '
+test_expect_success 'log --patch-grep --no-textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-	git -c diff.test.textconv=missing log -Gfoo --no-textconv >actual &&
+	git -c diff.test.textconv=missing log --patch-grep foo --no-textconv >actual &&
 	test_cmp expect_nomatch actual &&
 	rm .gitattributes
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
 
-test_expect_success 'log -S --textconv (missing textconv tool)' '
+test_expect_success 'log --patch-modifies --textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-	test_must_fail git -c diff.test.textconv=missing log -Sfoo &&
+	test_must_fail git -c diff.test.textconv=missing log --patch-modifies foo &&
 	rm .gitattributes
 '
 
-test_expect_success 'log -S --no-textconv (missing textconv tool)' '
+test_expect_success 'log --patch-modifies --no-textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-	git -c diff.test.textconv=missing log -Sfoo --no-textconv >actual &&
+	git -c diff.test.textconv=missing log --patch-modifies foo --no-textconv >actual &&
 	test_cmp expect_nomatch actual &&
 	rm .gitattributes
 '
 
-test_expect_success 'setup log -[GS] plain & regex' '
+test_expect_success 'setup log --patch{-modifies,-grep} plain & regex' '
 	test_create_repo GS-plain &&
 	test_commit -C GS-plain --append A data.txt "a" &&
 	test_commit -C GS-plain --append B data.txt "a a" &&
@@ -159,31 +201,31 @@ test_expect_success 'setup log -[GS] plain & regex' '
 	git -C GS-plain log >full-log
 '
 
-test_expect_success 'log -G trims diff new/old [-+]' '
-	git -C GS-plain log -G"[+-]a" >log &&
+test_expect_success 'log --patch-grep trims diff new/old [-+]' '
+	git -C GS-plain log --patch-grep "[+-]a" >log &&
 	test_must_be_empty log &&
-	git -C GS-plain log -G"^a" >log &&
+	git -C GS-plain log --patch-grep "^a" >log &&
 	test_cmp log A-to-B-then-E-log
 '
 
-test_expect_success 'log -S<pat> is not a regex, but -S<pat> --pickaxe-regex is' '
-	git -C GS-plain log -S"a" >log &&
+test_expect_success 'log --patch-modifies <pat> is not a regex, but --patch-modifies <pat> --pickaxe-regex is' '
+	git -C GS-plain log --patch-modifies "a" >log &&
 	test_cmp log A-to-B-then-E-log &&
 
-	git -C GS-plain log -S"[a]" >log &&
+	git -C GS-plain log --patch-modifies "[a]" >log &&
 	test_must_be_empty log &&
 
-	git -C GS-plain log -S"[a]" --pickaxe-regex >log &&
+	git -C GS-plain log --patch-modifies "[a]" --pickaxe-regex >log &&
 	test_cmp log A-to-B-then-E-log &&
 
-	git -C GS-plain log -S"[b]" >log &&
+	git -C GS-plain log --patch-modifies "[b]" >log &&
 	test_cmp log D-then-E-log &&
 
-	git -C GS-plain log -S"[b]" --pickaxe-regex >log &&
+	git -C GS-plain log --patch-modifies "[b]" --pickaxe-regex >log &&
 	test_cmp log C-to-D-then-E-log
 '
 
-test_expect_success 'setup log -[GS] binary & --text' '
+test_expect_success 'setup log --patch{-modifies,-grep} binary & --text' '
 	test_create_repo GS-bin-txt &&
 	test_commit -C GS-bin-txt --printf A data.bin "a\na\0a\n" &&
 	test_commit -C GS-bin-txt --append --printf B data.bin "a\na\0a\n" &&
@@ -191,36 +233,36 @@ test_expect_success 'setup log -[GS] binary & --text' '
 	git -C GS-bin-txt log >full-log
 '
 
-test_expect_success 'log -G ignores binary files' '
-	git -C GS-bin-txt log -Ga >log &&
+test_expect_success 'log --patch-grep ignores binary files' '
+	git -C GS-bin-txt log --patch-grep a >log &&
 	test_must_be_empty log
 '
 
-test_expect_success 'log -G looks into binary files with -a' '
-	git -C GS-bin-txt log -a -Ga >log &&
+test_expect_success 'log --patch-grep looks into binary files with -a' '
+	git -C GS-bin-txt log -a --patch-grep a >log &&
 	test_cmp log full-log
 '
 
-test_expect_success 'log -G looks into binary files with textconv filter' '
+test_expect_success 'log --patch-grep looks into binary files with textconv filter' '
 	test_when_finished "rm GS-bin-txt/.gitattributes" &&
 	(
 		cd GS-bin-txt &&
 		echo "* diff=bin" >.gitattributes &&
-		git -c diff.bin.textconv=cat log -Ga >../log
+		git -c diff.bin.textconv=cat log --patch-grep a >../log
 	) &&
 	test_cmp log full-log
 '
 
-test_expect_success 'log -S looks into binary files' '
-	git -C GS-bin-txt log -Sa >log &&
+test_expect_success 'log --patch-modifies looks into binary files' '
+	git -C GS-bin-txt log --patch-modifies a >log &&
 	test_cmp log full-log
 '
 
-test_expect_success 'log -S --pickaxe-regex looks into binary files' '
-	git -C GS-bin-txt log --pickaxe-regex -Sa >log &&
+test_expect_success 'log --patch-modifies --pickaxe-regex looks into binary files' '
+	git -C GS-bin-txt log --pickaxe-regex --patch-modifies a >log &&
 	test_cmp log full-log &&
 
-	git -C GS-bin-txt log --pickaxe-regex -S"[a]" >log &&
+	git -C GS-bin-txt log --pickaxe-regex --patch-modifies "[a]" >log &&
 	test_cmp log full-log
 '
 
-- 
2.45.2

