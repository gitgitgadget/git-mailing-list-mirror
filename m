Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981F78F4C
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722297; cv=none; b=EvWJjj39icJx/7mRAMi7XuzuKCfXpQ2IrndmbDwwd+cu9iDTEGXyGltlOjG+l+IgqIXxOvpjykllqns8Zsu+84h2TTsxzqU2S20GI+51gfNOYoRzKkpLWHyzEzTPF3vz4QrZzb1slKnBXrm4HwSUhHXfDJtlyUpGcC5Tay43ot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722297; c=relaxed/simple;
	bh=1YDgvHqyhZEJ/v6fnVcEeLRMEC1UojpeSCkQtc03G6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyGFRyX1wa7RIOsuHtfSIu5N8mlYwE47mqRjMMyUkOAoeuXW7yjN9zFKde5GSO+WxwglUiE2tA2XEqlciAtdV9e7baQDCM+SQymfZcaFdlhjq4ia3BPhO0XpG4wwQ2HRhgNWLPo6LXwPmd3z+IkdMkyuemNTEmNMcVdNV7TiW28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcvlvoBS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcvlvoBS"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9d9f14a74so1229911a91.0
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 18:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738722294; x=1739327094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5IRS7YtNk7yd5XCn5c1jnLLDsoARcy5ZO8U0mTq1ZI=;
        b=HcvlvoBSe9Z10KoOP1doGRpweV7ruJ2PnTaqwrjyhjlfd8MvlwvHXVBMwwTSC0uogE
         E8HfaRfgUItQ7VotczLmNy+RtVJ6UtEa3RI1EnPgMj30KNHG7Let7wlhJRtf1t/0rmLD
         mhVx3VA75zsfj1OEIi8Li6qMc2eHlCB4+l5mnAg0pjYItzwTPzhErUzx8fwD8ux7Yrb7
         8xAt5V098e8PyGytfzpM0Dm++9gqYM/kxoWXB6kwHBVwP5bTVpk0OR8WmUVZ/lme9zao
         AHuCmbi5yU5PNuBWo4Yet1Mimy0nJmXcnyVZMYpw/nw68Z+tWGPuQzs06r/uCJXL//Ao
         PFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738722294; x=1739327094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5IRS7YtNk7yd5XCn5c1jnLLDsoARcy5ZO8U0mTq1ZI=;
        b=GdLeAVhm1j/PU6c8rVAbf2uBRkkerZvnm68PemwTYD3gYjOtK7b2KeV6gl3OkL8uld
         Cv1x4aeEkn6aKh3dkkjVEgAKm6vLcK/p1PrSZkpq7qx+yO9CV6LC/Vm2FDTwaJw2ay0S
         +fxN7gl3jXWo/pG4Bdhhwn6HU454EgLf3cRLroonT5aPl4l+5plQsKr8vzuSfprwMbxE
         gB7FNvaL7LFz6eIgHPoduOI4wYmMdnIAUA4rOumdn1V3mGqNep32qV03pgYn8Pi/8yyV
         cMGjkPekLr99+Q0kbmpcIIYFXnmZXR7yvVEQT38yTLvndvKBZ7r5TpZ9lnxX0ru0Efq6
         DjYA==
X-Forwarded-Encrypted: i=1; AJvYcCV8I0gfdSHzXzIQDCmHr2fwoEP7iAJWoVXJptYKR7qDTr9/jfXQqCJCH1+O4hp8OILgMDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvn7w62h0RDKkI5s05bq0pCPtdAFkIuhWMHxuufLn2KPPOL2v
	p1a3KwCj6OvrJeE+XkoFbYWDd1YcVICxKyTcf3/t1Fq0ZYLbxnLw
X-Gm-Gg: ASbGncsmzuvILkr7CGhvxrR7kjM5qiOrX0JdlEmvKmpOEnog1O0nR07QFqHkeGfR4r7
	SYysqKOjPTXJQoSFbmn3rHn0HTsfdCu2UmXRljGVCdPLAhOwd5CV+czsTK8AlztnI1+FV+RxbKH
	mzAUqZoosAqjwqboJwHrcTeLNPTcqpqbzLA/WBJ/bRMuiHhzGxOHYbrhfcMHgwr6uvcoS0Ox8Lu
	g8vFu59t9ejCEuL2119SFzpYlLDNdIQK5255Dwu/wLpdsfzsqkxV/WB3SuODFa/XXSLXq89Iqb0
	ca1icmQsj5HjKx8yQg1AqccT+R/TuGsyYUiXWg==
X-Google-Smtp-Source: AGHT+IFZgO5clgF/EyMXZim+m9Wri9XLvcLXxuidDCNFhzOwUELOPJFfBCupXU4Dy9uf76f+y8Jryw==
X-Received: by 2002:a05:6a00:114e:b0:72d:56d6:a7a7 with SMTP id d2e1a72fcca58-730351eab7amr1443945b3a.15.1738722294072;
        Tue, 04 Feb 2025 18:24:54 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:d50a:b267:8bd1:adc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ce054sm11642894b3a.132.2025.02.04.18.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 18:24:53 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v2 1/1] diff: --patch{-modifies,grep} arg names for -S and -G
Date: Tue,  4 Feb 2025 18:24:20 -0800
Message-ID: <20250205022422.2019929-2-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <xmqqserjsfrq.fsf@gitster.g>
References: <xmqqserjsfrq.fsf@gitster.g>
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
 gitk-git/gitk                  |  10 +++-
 t/t4062-diff-pickaxe.sh        |   8 +--
 t/t4209-log-pickaxe.sh         | 106 +++++++++++++++++++++++----------
 8 files changed, 151 insertions(+), 88 deletions(-)

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
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 47a7c1..52516 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -228,7 +228,15 @@ proc parseviewargs {n arglist} {
             "--until=*" - "--before=*" - "--max-age=*" - "--min-age=*" -
             "--author=*" - "--committer=*" - "--grep=*" - "-[iE]" -
             "--remove-empty" - "--first-parent" - "--cherry-pick" -
-            "-S*" - "-G*" - "--pickaxe-all" - "--pickaxe-regex" -
+            "-S*" - "--patch-modifies=*" -
+            "--patch-modifies" {
+              set nextisval 1
+            }
+            "-G*" - "--patch-grep=*" -
+            "--patch-grep" {
+              set nextisval 1
+            }
+            "--pickaxe-all" - "--pickaxe-regex" -
             "--simplify-by-decoration" {
                 # These mean that we get a subset of the commits
                 set filtered 1
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

