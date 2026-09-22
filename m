Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA2D24E016
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082445; cv=none; b=nEefvUC2tRlgyH7wJP7y5+mZZXCS/A5wZ+ArnmUyYWM6yvqFIxFsjoyQ/7McLI4/DeRwkyQS4l4fy5JmQ26KPVOjg9bsHPtmDS3cRYcwco828OiS4opTkuC2FxYGLBz2h6FQziYBf7DKAr2ssPaSRW4zfddn0OoQ5RHXmAcjv+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082445; c=relaxed/simple;
	bh=bzeb1+3vsmzwt50sKLHjueAqBqYggx3QjjKR8xF7Qf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBIFQlZa95rf/Mr7Re0eCLGuhgVUGNCZ+wQn0MN4l/G5QDKhnhYBb12k2CiXtsntsW3gdEyxR+rf8etSJKBf+RAqO2FOrQP6b+xd7o2xHwX2Yf8qAz3/OVCV7NrcRlJq66yZIWD5C3Oi2SSPoCdvJEWxSyl7ui13RDm5vGZbw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5g/N4Cr; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5g/N4Cr"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a3156692c6so28055601fa.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790082441; x=1790687241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GuWSNW+jVD3dcsb3upvVmAxyBrQYZXYSLqM5onTeEuo=;
        b=n5g/N4Cr5PRdKj74j6EUxJUJ/EdoC82nSo+P5KEqmflrNjWsGuISlSC6FhPW/h8wsd
         /FQbj3pRB1zvRTiF3fJiIEVOwElSgkdl7YcdwUeYDemKGUk4q5PQ5X/5uJTiQ695ALkl
         wJ3Tao/Cwh1ImT7X1VML1HRV1uHw6mtvP232OW9Bz6sLaaWq771JT9pbuDDaLyzCdNV6
         U5j/m4UqUbFDM0tWBPsdmMrPrk9uDA3Cp+j906tGb3zpKpVdBs8oi2fbyKZq6QEL/tWD
         GxT7JGZXT03g+2HU7j2rBHdjkb/erxryQtz5mECinBBFU5kh0kyn1s7PfpnVZtm8KlrW
         ZTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082441; x=1790687241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GuWSNW+jVD3dcsb3upvVmAxyBrQYZXYSLqM5onTeEuo=;
        b=XMGXHh7h5M06mbzdgtrzNijmn4c5vV+DYIUfOKe4KthssR+A1OujU2iVcPikUtSqOZ
         Ts8YUp8vsWlui9s5rRuRIXxZ48mHz+meeDvWGjyM8cbWZu0dDhZNLhiPtXqD0v+OaGCX
         Xr0nO+MrdOMzMv40ghwoGi7+hI8KyL3wAHQXN7Tl2Fs12fa/CJTt4/R0exByZNQfJ5h0
         R7TskdS8ONCQGz7Jx2drPDXiSB9YSEibW15XRHlE2GBvwqHcGwD09TqVzZsTnAPfVaqS
         QL/qiHcs9mKCjBEyYg5AmFJXxdE1MroBNCfpY4DunbuHD2INJ0zSBeFPB50iGgkmHrVK
         4XoQ==
X-Gm-Message-State: AFuF++lK9wNDSWZcvB5fVbMaKyuhqn+sVXB/e/k8EmZ4+LvSTYANoiad
	Pe1dTkZ8yh5fYSg5UjgZP49gFwv0oNu+bYENVJmtyxh41Q5+zmzqMsS3hCT7ug==
X-Gm-Gg: AYBFou2aZ/ZfL8kdE3dza27F861I0G0asaHF1oqQanUDvLrnSnCBGktfdu5r1NU/YaE
	Eqay+cK/acewRucO0SirsNzsHldUydJh5Fpdj8oaD/jM2fo9oL9HBVroGtYUlxk2L5l4AvxOEHy
	Pc6lCa5GzRYMJqEnFLylVuGQ9aQt040aM+x7whCHerHTvuiP5Jy1a4wF/0KNVP3YH0wvXdwjFIO
	A/sx5+Mh2IaIeMTZJXkWAm9sC7uiJFTYstba4jQa8CbRqCT+3MSYM4Z7N67lYWNiHGA+tr0xs8s
	0S8qWJoh7FgX+ZhhFvmaRk6drVI1bQOZoataNwpPjnwT52MVmHpTIgYR5TJTrjNeolvtysczPJ+
	it487IgDn9DKtpTjk6eznjeXJ8HrqJ8Y6pZnIWmvJJddHMFRJVMkdVxAHCfOaqmNnM/jyYIVElC
	worTl/7nr8ZU2Z8tDHWm3gszrtgRT6JIpxwFNM5zDDsrEzUyUSJpOdrKXEIlB4YQZo1RtLXPlsy
	8HDMLoePwdpJ8uhVoBop/+P/yGCOmUnZFkZ99iPayw3H2AJ4iUNeYIFDDDQ/jEs+czSYJB1fvU4
	hr8EMO7+0gN4ldrUzjtTejdeKhFeqGaZ1Q==
X-Received: by 2002:a05:651c:198e:b0:3a5:b782:ecb9 with SMTP id 38308e7fff4ca-3a5fbe4a1d2mr31841811fa.2.1790082440257;
        Tue, 22 Sep 2026 06:07:20 -0700 (PDT)
Received: from localhost ([185.104.15.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a627b7b7d9sm5783221fa.5.2026.09.22.06.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:07:19 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
From: erik@cervined.in
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	Erik Cervin-Edin <erik@cervined.in>
Subject: [PATCH v3 1/2] commit: allow -m/-F for all kinds of --fixup
Date: Tue, 22 Sep 2026 15:04:35 +0200
Message-ID: <4581f97cb737c701081614be0e222ee4c860ce1c.1790082176.git.erik@cervined.in>
X-Mailer: git-send-email 2.55.0.770.g0473647dd8
In-Reply-To: <cover.1790082176.git.erik@cervined.in>
References: <cover.1779792311.git.erik@cervined.in> <cover.1790082176.git.erik@cervined.in>
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
index 205fbd57e3..ffb8644653 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -816,18 +816,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
@@ -849,20 +849,21 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
@@ -1365,9 +1366,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
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
index 5e782ad8d7..9b2ecb1356 100755
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
2.55.0.770.g0473647dd8

