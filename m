Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1423C5837
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149339; cv=none; b=foIq8LgpcuE+ridFfyOVpBjovD/FtBgDBe7zM/37vvG3ysrRUM2/hzZj0B1VeTAUpjQ3SBpCDqpUiM9cet3k5HLhLvArBkU5oao9SpNPWecKox3kdaHg3JbnoU/wPERk57esqkfQkA+bCr/99oS2KY1ZByNWUi/QusYKpzY9RUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149339; c=relaxed/simple;
	bh=NmkSPKHE3e+WLG16OcmedZX71lbGxW+Hh1d5DD29zPM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WkRGyRlGqKaUZuhzj9FqFR9zJeMjplr3kV4p7n+GDsfM8FDbfw4rNqDSr188eaq7yoajShCq73dufvtMPnZY2Ilfn1X+MKB2z0c+ipRXRcXcz57gY7pp10KT1wtiLCeRJbggMmdVZdkOCKI/xglYOdqKY7Xq9MF/soRvB5ARMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jr0Phzh8; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr0Phzh8"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so18230336d6.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784149336; x=1784754136; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LU4MJbBxAEIO3KtzzWJATYQFZOl2y/O/d7noHxf/0Yk=;
        b=Jr0Phzh8+M4Sz5uvnsExRIDekrm7pkKMlq5TNeAnBfV7BWrXYGMXJb6GgdNjsrnu+J
         a6A5KENj3KG2WXVaMnUui820MWCl8y5qL7vnIEj+hV/DDVN2TIvfuLSHFCS4uviKc4J3
         aXTSuKcofgdAcL5vxfmu8YUP2AndZFlpjAhc6jz5tUiTUReACgm737lPPfjHPQd1akob
         /RXAurN3PYMh5X5xWBHoVgg41QRUaHg5a9PQtEZX7cYJaYlGhBcEdHs8tlFJ7OnnLVcb
         iM0z325aVqavDle/utFeATUgGteZFM3tqlCZb040mbaVgkXm042SntVBoxlhUDPn75Qp
         29jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149336; x=1784754136;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LU4MJbBxAEIO3KtzzWJATYQFZOl2y/O/d7noHxf/0Yk=;
        b=BtbyiU2JHayDngJ1AKfWdxN1nyFYSdY1fqMKyi5mSfgSPWoxo4uvh180a5i5CoXKCY
         Bp3VP1a16ZD7EX7Ew9LIlaVQkVcAQ6PsDI/ynupdIZClJBQzWBQ63Z5HHj59hN7Pmfp5
         6B0jX5EB+T65+EYXJr8MJa4ssBdQO3o7k3QfQFdkrDAGFfe1Px3RNqRx72pZyuvJW6vX
         nfSvdP/5cAVuco5s0tbu2Ai/ld5FEXuAVeW5ia3bED/9FSjmtVYReZJiYrYP2II/g6/U
         QCZKBYPayioPW6HW4VRemZ4wWb7CkQPMRq4iWaxXOyLx3hWhP46tSmtg1lPHiK7plY++
         Pcdg==
X-Gm-Message-State: AOJu0YzyztRAy5tUO4/tJfw32OT4sl8xHX/U8dwwb0wzWM4ZOUqdg2jX
	UJo2j8U931RfD6J+sQXz4LZxSs5xPYIEknfiHQVnbjOmdLBYcJw+7cC2/MhN9g==
X-Gm-Gg: AfdE7cl2GECc1tVfxDAnLPHVRh0dWOYarFsRSbrklosDTwalhA3Xd0XEDK/tGJD3/99
	/ULNM8krbLGlXUgJi0khTzRgvURwytLCByoGLKm31RuDZc/vRGNNJ8q9/1rast288EAzs/JGlPE
	K0rdNNLD3ieykbBfBLoeOng1terM458nFzatAXcggJTG/ScKF6aBQk/c1bXzrIRceR3ZwJXI+XT
	/Tt2gMNEoCvGE/zAxF84pV2da2hitSzj0aPRO5p3+HgUpw8fnHmG+4ym6W3i83twk5WTf4LKySS
	b1fBd3CxLSM50015njaxq5Sop/bVFlLI4ZlH2QfDxuNZJmMikHOyoQidZZcL9cO1EYrbhHULzTO
	HsinMo0iKcniL1QUVfltBYuZrIlhnuQsIQ+HK2C+tTM59ZA6dVIwT4ClhwqK1+fTR5d/wrgMa90
	D2nvLmhA==
X-Received: by 2002:a05:6214:5285:b0:8dd:ae5b:f422 with SMTP id 6a1803df08f44-903fe4513c0mr207792096d6.12.1784149336248;
        Wed, 15 Jul 2026 14:02:16 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.193.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c8d4csm219607996d6.44.2026.07.15.14.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:02:15 -0700 (PDT)
Message-Id: <b2e80f014e7a0aaf54dfafda8ef1ffa5b118fb1b.1784149323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
References: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
	<pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 21:01:59 +0000
Subject: [PATCH v5 6/9] diff: bypass diff process with --no-ext-diff and in
 format-patch
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Make --no-ext-diff disable diff.<driver>.process in addition to
diff.<driver>.command.  Although the two mechanisms work differently
(command replaces Git's output, process feeds hunks back into the
pipeline), both invoke external tools and --no-ext-diff means
"no external tools."

Replace the OPT_BOOL for --ext-diff with an OPT_CALLBACK that
sets both allow_external and no_diff_process, so a single option
controls both.  Passing --ext-diff explicitly clears
no_diff_process, so a later --ext-diff overrides an earlier
--no-ext-diff.

Disable the diff process unconditionally in format-patch so that
generated patches are always based on the builtin diff algorithm
and can be applied reliably by recipients who do not have the
external tool.

Document that --diff-algorithm also bypasses the diff process,
since it forces the builtin algorithm.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/diff-algorithm-option.adoc |  3 +++
 Documentation/diff-options.adoc          |  4 +++-
 Documentation/gitattributes.adoc         |  6 +++---
 builtin/log.c                            |  7 +++++++
 diff.c                                   | 16 ++++++++++++++--
 diff.h                                   |  5 ++++-
 t/t4080-diff-process.sh                  | 16 ++++++++++++++++
 7 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-algorithm-option.adoc b/Documentation/diff-algorithm-option.adoc
index 8e3a0b63d7..4d7e2ec35f 100644
--- a/Documentation/diff-algorithm-option.adoc
+++ b/Documentation/diff-algorithm-option.adoc
@@ -18,3 +18,6 @@
 For instance, if you configured the `diff.algorithm` variable to a
 non-default value and want to use the default one, then you
 have to use `--diff-algorithm=default` option.
++
+If you explicitly choose a diff algorithm, it also bypasses
+`diff.<driver>.process` (see linkgit:gitattributes[5]).
diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index c8242e2462..a884445211 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -833,7 +833,9 @@ endif::git-format-patch[]
 	to use this option with linkgit:git-log[1] and friends.
 
 `--no-ext-diff`::
-	Disallow external diff drivers.
+	Disallow external diff helpers, including
+	`diff.<driver>.command` and `diff.<driver>.process`
+	(see linkgit:gitattributes[5]).
 
 `--textconv`::
 `--no-textconv`::
diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index f4ca4a8c7e..a03fb9deb1 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -1073,9 +1073,9 @@ display, which is covered above); and combined diffs (`--cc` and merge
 diffs), whose protocol would have to be extended from a single old/new
 pair to one comparison per merge parent.
 
-`--diff-algorithm` bypasses the process entirely, for every feature
-listed above.  The whitespace-ignoring options (`-w`,
-`--ignore-space-change`, `--ignore-blank-lines`, and the like),
+`--no-ext-diff` and `--diff-algorithm` bypass the process entirely,
+for every feature listed above.  The whitespace-ignoring options
+(`-w`, `--ignore-space-change`, `--ignore-blank-lines`, and the like),
 `-I<regex>`, and `--anchored` also bypass it for the affected files:
 the tool is never told about these options, so it could not honor
 them, and Git falls back to the builtin diff, which does.
diff --git a/builtin/log.c b/builtin/log.c
index d027ce1e0b..7821a61143 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2217,6 +2217,13 @@ int cmd_format_patch(int argc,
 	if (argc > 1)
 		die(_("unrecognized argument: %s"), argv[1]);
 
+	/*
+	 * Disable diff.<driver>.process so that patches generated by
+	 * format-patch are always based on the builtin diff algorithm
+	 * and can be applied reliably.
+	 */
+	rev.diffopt.flags.no_diff_process = 1;
+
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME)
 		die(_("--name-only does not make sense"));
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME_STATUS)
diff --git a/diff.c b/diff.c
index af31072858..a9a732629e 100644
--- a/diff.c
+++ b/diff.c
@@ -5948,6 +5948,17 @@ static int diff_opt_submodule(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_ext_diff(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	options->flags.allow_external = !unset;
+	options->flags.no_diff_process = unset;
+	return 0;
+}
+
 static int diff_opt_textconv(const struct option *opt,
 			     const char *arg, int unset)
 {
@@ -6278,8 +6289,9 @@ struct option *add_diff_options(const struct option *opts,
 			 N_("exit with 1 if there were differences, 0 otherwise")),
 		OPT_BOOL(0, "quiet", &options->flags.quick,
 			 N_("disable all output of the program")),
-		OPT_BOOL(0, "ext-diff", &options->flags.allow_external,
-			 N_("allow an external diff helper to be executed")),
+		OPT_CALLBACK_F(0, "ext-diff", options, NULL,
+			       N_("allow an external diff helper to be executed"),
+			       PARSE_OPT_NOARG, diff_opt_ext_diff),
 		OPT_CALLBACK_F(0, "textconv", options, NULL,
 			       N_("run external text conversion filters when comparing binary files"),
 			       PARSE_OPT_NOARG, diff_opt_textconv),
diff --git a/diff.h b/diff.h
index 7dc157968d..ee034d240d 100644
--- a/diff.h
+++ b/diff.h
@@ -173,7 +173,10 @@ struct diff_flags {
 	 */
 	unsigned allow_external;
 
-	/** Disables diff.<driver>.process. */
+	/**
+	 * Disables diff.<driver>.process.  Set by --no-ext-diff and by
+	 * format-patch.
+	 */
 	unsigned no_diff_process;
 
 	/**
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
index 3b75df082e..7e71b70ab9 100755
--- a/t/t4080-diff-process.sh
+++ b/t/t4080-diff-process.sh
@@ -398,6 +398,22 @@ test_expect_success 'diff process bypassed by --diff-algorithm' '
 	test_path_is_missing backend.log
 '
 
+test_expect_success 'diff process bypassed by --no-ext-diff' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff --no-ext-diff worddiff.c >actual &&
+	test_grep "return 999" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'diff process not used by format-patch' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		format-patch -1 --stdout -- logtest.c >actual &&
+	test_grep "return 2" actual &&
+	test_path_is_missing backend.log
+'
+
 test_expect_success 'diff process bypassed under whitespace-ignoring flags' '
 	test_when_finished "rm -f backend.log" &&
 	printf "a\nb\nc\n" >wsbypass.c &&
-- 
gitgitgadget

