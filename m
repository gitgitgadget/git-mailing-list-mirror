Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3829C3DDDB4
	for <git@vger.kernel.org>; Tue, 26 May 2026 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792500; cv=none; b=NrG3oJ/l+LyG8WkoOyXc0W+tTNWt37kX4H5/VJ7RkirWhbh+2BpADlhdsktMVkgDQWVmEWkUes9uaEJUxTJa0FlBRXpBNbFSMtxye9CTrHaAjgfW373dLGOir0AAXNW8IML1CJaCFrtLYY+tnVsnmtXTwyQMNLSicbAkSAhKlxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792500; c=relaxed/simple;
	bh=T6QmWcG+Q+WZVy/B+sjT2YNkm4fP5slDAoZGyuxi0H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqwVlG/3NI0A3L3QnlOi6kfoMsgBY5eZT+eODXILGJvYIjVINHPlLVvqJJ4+GQWjT28wsUgSWYXf0PDILOdTcm2Ibw4e7Iigpzp4nEQFtmA0AeQ7rAWAAE+pGwn3n8uVMtfJR0e0eKiZyJ2+jhPA956iOhBmfxtLpECl4CE6fOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDnGxyhp; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDnGxyhp"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa474d3be0so281326e87.2
        for <git@vger.kernel.org>; Tue, 26 May 2026 03:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792494; x=1780397294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsikHIunNFVgrAvOdY1wiauoJVGD4RlTUbPJZ3cnUIU=;
        b=dDnGxyhpKJuKgmHvJpYBntLFnJ6yzS/u0PTLia0lIOaFc6Ls+ONV+Cdo6faHUAE2sp
         cZ0OtM0gnuza19Jijzct434l1h7kt6THhZROT/ND7soJ6tmFqsDpdxS5S4MGxvdXvx7N
         SDjjUWz53iinMt3mr8EhfPsPNPDgTWGGReEKhUjHFxYhHoBQ6oOeMizlbR29BulbBJbm
         NhkxIdhvUYtaoyQxPNIUoSksTC2FufKarGpYSpc+PvAtXO5fclA9YBdGUnaYcZNnmAgs
         C7MA6zUmnLL03vmnmgHh2tj/IV8LMFY+VbopcQVTUnMra6GCkaKZotEFaaT0qp4ugIk/
         MUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792494; x=1780397294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsikHIunNFVgrAvOdY1wiauoJVGD4RlTUbPJZ3cnUIU=;
        b=Id+1/OufiSt2d1YDx8oj6cW4VcZzg33wSGoa/8WlrRf7S2Z+QBTilqL5NA4OpiW5CD
         o/KGA3R66IjqQgvuRmtJ4I7l32rb71qR2iQsbFUk9suN528cJB4OW+N8WV4PuXpkWBgy
         wA3/7C1ipbkIpjjDJ9Xu/oQAshyIBV7/qTGUBqDVvgM2+odyC4C8jY5aez4Z84XuCcyF
         Ksdqk+uVaNJum1ahgMMmvTaMqB+1KrEHalrO8fHkQLtuu+tzxnyQEqeLozi2nfEZ60kT
         Sxej/3MzDUZUwx88/NEYpC5J42S5QkEH2IQ9OpXW66IpZbLEzYgq4S+ctS+RbRzFgA4v
         30Wg==
X-Gm-Message-State: AOJu0Yy8pP2DE50CJ2pubH+mMT2h/ShlkzaBui0NIL6f6i5Bn/rHnr17
	c/p5LPky6BQOeDWLGYz0amkBnMOBoxgpakhoWSaKEAsPx7K2Yg9B/wThu6Mavg==
X-Gm-Gg: Acq92OFdd49GF+AVdj19n5vuLsh/3lMXo4oWNnWXOfesDomLOZf64QezKS+ZRy70O0h
	Lou2O5jbRNl/4P7YuPPLT6NAL0vwdzCfFnF32irKnm+pvF0VJ/eqQ8Sw/1/Rbs8eGWdN/YMvQhj
	sRdbAPpCwq7bgBSswEjsegdlE4zwvmPwH0S8AA92+84+rRz7jPVf5M1PgY2yV0IG17+uPsScMZI
	+490Lb0BqB/H0dDTd7c2apfeRLVNPeIiEBHkIhkgNoniAF2oD0SPW8spS192PCVpixkAbo9CaU1
	/FlXMenlp84hLM7eOOetQuuRHvjK/5GNrUzqES4wiYVt954JIK9uPUOGs1n4NDmwR0IPGEmayNW
	2JhDHYM3bEMFsiHBz/qLNswQUi0BX9v5ksEdSD/H/0fADw44yY43SBQsz5RjpaJ0LwSkif8qLVo
	4qB4dfSrEs3vOaU81qD9+S7cvMSXNdCsWnnttVFfFTcUDHvMn/nbPVDGm7H+zDx66GHCzmX5XQG
	/I9GEs1DjUayDVQ+lXX/sQt1+ux9YAPYxtWnCrPyT61kSXL0wLXYzX7iIwBR6i3
X-Received: by 2002:ac2:53a6:0:b0:5a3:fe60:471c with SMTP id 2adb3069b0e04-5aa3237d834mr4605351e87.16.1779792493820;
        Tue, 26 May 2026 03:48:13 -0700 (PDT)
Received: from localhost ([2001:2043:be0a:d700:954c:d0e6:555c:211f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa462cf5f7sm358551e87.12.2026.05.26.03.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:48:13 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
From: erik@cervined.in
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	Erik Cervin-Edin <erik@cervined.in>
Subject: [PATCH v2 1/2] commit: allow -m/-F for all kinds of --fixup
Date: Tue, 26 May 2026 12:47:43 +0200
Message-ID: <e9f07d49ee2b4a19e7039b6da11be502a8d33fa8.1779792311.git.erik@cervined.in>
X-Mailer: git-send-email 2.54.0.1014.g842965a2d5
In-Reply-To: <cover.1779792311.git.erik@cervined.in>
References: <20260518112225.73172-2-erik@cervined.in> <cover.1779792311.git.erik@cervined.in>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erik Cervin-Edin <erik@cervined.in>

The ability to provide a commit message for git commit --fixup and its
variations is limited:

  * Plain --fixup only allows using the -m flag

  * The amend/reword --fixup variants only allow supplying the message
    using an editor

For amend/reword, the -m and -F flags are rejected: -m is caught by a
die() in prepare_to_commit(), and -F is caught by
die_for_incompatible_opt4() which groups -F with --fixup as mutually
exclusive.  This makes these modes poorly suited for non-interactive
workflows -- notably when using AI coding agents.

When support to use the -m option was introduced in [1] it was noted
that there could be support for other options but at the time the use
case was deemed too niche.  Later, when the amend suboption was
introduced in [2] -m support for amend fixups was discussed but not
pursued, and -F was already caught by the higher-layer incompatibility
check grouping it with --fixup.

The rejections of these options hark back to when --fixup was
introduced in [3] and as noted in [1] -- there's nothing inherently
preventing support for them.  The current patchwork of which flags
work with which --fixup variants has no strong logic to it, and
allowing all of them simplifies both the code and the interface.

Allow -m and -F to supply the message body for all --fixup variations,
mirroring the flow of a regular commit.  -c and -C, which are blocked
by the same incompatibility check, are handled in the next commit.

1. 30884c9afc (commit: add support for --fixup <commit> -m"<extra
   message>", 2017-12-22)

2. 494d314a05 (commit: add amend suboption to --fixup to create amend!
   commit, 2021-03-15)

3. d71b8ba7c9 (commit: --fixup option for use with rebase --autosquash,
   2010-11-02)

Helped-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
---
 Documentation/git-commit.adoc             | 19 ++++----
 builtin/commit.c                          | 34 +++++++-------
 t/t7500-commit-template-squash-signoff.sh | 56 +++++++++++++++++------
 3 files changed, 69 insertions(+), 40 deletions(-)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index 8329c1034b..61efd29e66 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -103,20 +103,21 @@ include::diff-context-options.adoc[]
 The commit created by plain `--fixup=<commit>` has a title
 composed of "fixup!" followed by the title of _<commit>_,
 and is recognized specially by `git rebase --autosquash`. The `-m`
-option may be used to supplement the log message of the created
-commit, but the additional commentary will be thrown away once the
-"fixup!" commit is squashed into _<commit>_ by
+or `-F` option may be used to supplement the log message
+of the created commit, but the additional commentary will be thrown
+away once the "fixup!" commit is squashed into _<commit>_ by
 `git rebase --autosquash`.
 +
 The commit created by `--fixup=amend:<commit>` is similar but its
 title is instead prefixed with "amend!". The log message of
 _<commit>_ is copied into the log message of the "amend!" commit and
-opened in an editor so it can be refined. When `git rebase
---autosquash` squashes the "amend!" commit into _<commit>_, the
-log message of _<commit>_ is replaced by the refined log message
-from the "amend!" commit. It is an error for the "amend!" commit's
-log message to be empty unless `--allow-empty-message` is
-specified.
+opened in an editor so it can be refined. The replacement message may
+also be supplied directly using `-m` or `-F`, bypassing the
+need to open an editor. When `git rebase
+--autosquash` squashes the "amend!" commit into _<commit>_, the log
+message of _<commit>_ is replaced by the refined log message from the
+"amend!" commit. It is an error for the "amend!" commit's log message
+to be empty unless `--allow-empty-message` is specified.
 +
 `--fixup=reword:<commit>` is shorthand for `--fixup=amend:<commit>
  --only`. It creates an "amend!" commit with only a log message
diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..3f1fca2919 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -804,18 +804,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (have_option_m && !fixup_message) {
 		strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
-	} else if (logfile && !strcmp(logfile, "-")) {
+	} else if (logfile && !fixup_message && !strcmp(logfile, "-")) {
 		if (isatty(0))
 			fprintf(stderr, _("(reading log message from standard input)\n"));
 		if (strbuf_read(&sb, 0, 0) < 0)
 			die_errno(_("could not read log from standard input"));
 		hook_arg1 = "message";
-	} else if (logfile) {
+	} else if (logfile && !fixup_message) {
 		if (strbuf_read_file(&sb, logfile, 0) < 0)
 			die_errno(_("could not read log file '%s'"),
 				  logfile);
 		hook_arg1 = "message";
-	} else if (use_message) {
+	} else if (use_message && !fixup_message) {
 		const char *buffer;
 		buffer = strstr(use_message_buffer, "\n\n");
 		if (buffer)
@@ -837,20 +837,21 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg1 = "message";
 
 		/*
-		 * Only `-m` commit message option is checked here, as
-		 * it supports `--fixup` to append the commit message.
-		 *
-		 * The other commit message options `-c`/`-C`/`-F` are
-		 * incompatible with all the forms of `--fixup` and
-		 * have already errored out while parsing the `git commit`
-		 * options.
+		 * Only `-m` and `-F` are handled here. `-c`/`-C` are
+		 * incompatible with --fixup and have already errored out
+		 * during option parsing.
 		 */
-		if (have_option_m && !strcmp(fixup_prefix, "fixup"))
+		if (have_option_m) {
 			strbuf_addbuf(&sb, &message);
-
-		if (!strcmp(fixup_prefix, "amend")) {
-			if (have_option_m)
-				die(_("options '%s' and '%s:%s' cannot be used together"), "-m", "--fixup", fixup_message);
+		} else if (logfile && !strcmp(logfile, "-")) {
+			if (isatty(0))
+				fprintf(stderr, _("(reading log message from standard input)\n"));
+			if (strbuf_read(&sb, 0, 0) < 0)
+				die_errno(_("could not read log from standard input"));
+		} else if (logfile) {
+			if (strbuf_read_file(&sb, logfile, 0) < 0)
+				die_errno(_("could not read log file '%s'"), logfile);
+		} else if (!strcmp(fixup_prefix, "amend")) {
 			prepare_amend_commit(commit, &sb, &ctx);
 		}
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
@@ -1338,9 +1339,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	}
 	if (fixup_message && squash_message)
 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
-	die_for_incompatible_opt4(!!use_message, "-C",
+	die_for_incompatible_opt3(!!use_message, "-C",
 				  !!edit_message, "-c",
-				  !!logfile, "-F",
 				  !!fixup_message, "--fixup");
 	die_for_incompatible_opt4(have_option_m, "-m",
 				  !!edit_message, "-c",
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 66aff8e097..01c7400136 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -384,18 +384,24 @@ test_expect_success '--fixup=reword: ignores staged changes' '
 	test_cmp foo actual
 '
 
-test_expect_success '--fixup=reword: error out with -m option' '
+test_expect_success 'commit --fixup=reword: works with -m' '
 	commit_for_rebase_autosquash_setup &&
-	echo "fatal: options '\''-m'\'' and '\''--fixup:reword'\'' cannot be used together" >expect &&
-	test_must_fail git commit --fixup=reword:HEAD~ -m "reword commit message" 2>actual &&
-	test_cmp expect actual
+	git commit --fixup=reword:HEAD~ -m "reword commit message" &&
+	test_commit_message HEAD <<-EOF
+	amend! $(git log -1 --format=%s HEAD~2)
+
+	reword commit message
+	EOF
 '
 
-test_expect_success '--fixup=amend: error out with -m option' '
+test_expect_success 'commit --fixup=amend: works with -m' '
 	commit_for_rebase_autosquash_setup &&
-	echo "fatal: options '\''-m'\'' and '\''--fixup:amend'\'' cannot be used together" >expect &&
-	test_must_fail git commit --fixup=amend:HEAD~ -m "amend commit message" 2>actual &&
-	test_cmp expect actual
+	git commit --fixup=amend:HEAD~ -m "amend commit message" &&
+	test_commit_message HEAD <<-EOF
+	amend! $(git log -1 --format=%s HEAD~2)
+
+	amend commit message
+	EOF
 '
 
 test_expect_success 'consecutive amend! commits remove amend! line from commit msg body' '
@@ -432,6 +438,13 @@ test_expect_success 'deny to create amend! commit if its commit msg body is empt
 	test_cmp expected actual
 '
 
+test_expect_success 'deny to create amend! commit if -m is empty' '
+	commit_for_rebase_autosquash_setup &&
+	echo "Aborting commit due to empty commit message body." >expect &&
+	test_must_fail git commit --fixup=amend:HEAD~ -m "" 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'amend! commit allows empty commit msg body with --allow-empty-message' '
 	commit_for_rebase_autosquash_setup &&
 	cat >expected <<-EOF &&
@@ -468,10 +481,26 @@ test_expect_success '--fixup=reword: give error with pathsec' '
 	test_cmp expect actual
 '
 
-test_expect_success '--fixup=reword: -F give error message' '
-	echo "fatal: options '\''-F'\'' and '\''--fixup'\'' cannot be used together" >expect &&
-	test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
-	test_cmp expect actual
+test_expect_success 'commit --fixup works with -F' '
+	commit_for_rebase_autosquash_setup &&
+	echo "message" >msgfile &&
+	git commit --fixup HEAD~ -F msgfile &&
+	test_commit_message HEAD <<-EOF
+	fixup! $(git log -1 --format=%s HEAD~2)
+
+	message
+	EOF
+'
+
+test_expect_success 'commit --fixup=reword: works with -F' '
+	commit_for_rebase_autosquash_setup &&
+	echo "message from file" >msgfile &&
+	git commit --fixup=reword:HEAD~ -F msgfile &&
+	test_commit_message HEAD <<-EOF
+	amend! $(git log -1 --format=%s HEAD~2)
+
+	$(cat msgfile)
+	EOF
 '
 
 test_expect_success 'commit --squash works with -F' '
@@ -526,8 +555,7 @@ test_expect_success 'invalid message options when using --fixup' '
 	git add foo &&
 	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2 &&
 	test_must_fail git commit --fixup HEAD~1 -C HEAD~2 &&
-	test_must_fail git commit --fixup HEAD~1 -c HEAD~2 &&
-	test_must_fail git commit --fixup HEAD~1 -F log
+	test_must_fail git commit --fixup HEAD~1 -c HEAD~2
 '
 
 cat >expected-template <<EOF
-- 
2.54.0.1014.g842965a2d5

