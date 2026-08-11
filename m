Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93941A542
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437237; cv=none; b=gzztBvzH7UwKj1ia2F1o7fPsVBGO8EqP1+M7WddOiRDq6lQ33pzgm8jhVXGJ3/30hBvJ+K1EAog1onGVgIUZm9CLSsr+ThOY3BUc/5Qz67kPUYA+zsfDZcT1bi6OBQp8Yft2yTDwV/vy0xaXSutD408tFsm8XLawlHUTPWLZDTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437237; c=relaxed/simple;
	bh=1Xy2nGxcOUyFelKS8v5subvEA7rrHzLe/PflzCBYK+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewgIWX69/tmQIXZB1fLL8idwra2FZ2Aqluw8D+5s9LLToC8kgFi0xy7FXC283pHwocglB6nsJiQSs2Yi9384ltfshKeKwq++JN3c+yNVa4SDjXTrWakk970jPQq5ZKkIrSy6GBQILWLcg7U/APsg9uqwpsrvPWCJX9rC9AwvHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlFsEQc4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlFsEQc4"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso26378225e9.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437234; x=1787042034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sqaems2Ld4anMGKyv7ivDdRfBIte8pkuUDJWIdWZoDg=;
        b=UlFsEQc4Sht82tFzKJIx1xon/Etu2ULsiDxSS0e5bDZ8hFO02HzTLlgj9QoJ3DsTRn
         HItdzHL/siRm+l3B1p7VG8J4XDGupYUe3hVtKtGAJvJFjSAr8ULhhwdC4FORmbwNMM9q
         TPWf3lksJzZ0Qjuxud+YdNAyGPoUn9lgAIYOEnjFWBGdzqduKIruIv3shbqan2jiVYRR
         LlPAF86qaDTbS8HMEFKq2JEzi8l13GH3LkaHEW3ez25Rx7+cMJkvpzjBkzQC0RWTBFVN
         3e61EQiJupetkWzjEKDKGZbk0h5QduYJeFZcfJw3uRpuEGCWnNM3IeuixCAR9/4Sc8n/
         RGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437234; x=1787042034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sqaems2Ld4anMGKyv7ivDdRfBIte8pkuUDJWIdWZoDg=;
        b=G4gUhr5d2KaCYYT6+1XH3jCkI98YgzuXGYQI0VN2tzreBnujGjL+yy/OZu+wBJOJ9e
         iYZyp50uRvIXdM2gl2n1Lim2uxz8uPfGkz71++DBht7l2RZ2YAJEVd5J5o9gpQrep6Nz
         UVMi+NNiGMgHRrCSxg0tABIu/bOIRlVJrBt/zdV9UeXSXlxK0caFJKZGB+Odvj8q6C6u
         NCJAEhvoki91splWvHrYJzcqEqsmJwZGMnO6urQdxJCvrV2y0eHbeNzAZII4AxGMoH10
         v+mdC2koL0DX7BKkKVqWFsG1sseiiiwJCVAjsIa7vyIvNH9dDmLkZ8SPATTQhlHH7qtK
         Bt3w==
X-Gm-Message-State: AOJu0Yy74DTH8HBfOiPnhPBfTNCkUH7d8wQ0SdwQZQiNvZ8i16/+BMSN
	zMRLCqvoZZkCZwzgCrElRdaWPHFjIfZ+xOcjfkJYgb4dSrcr0qudr3yBwchf+Q==
X-Gm-Gg: AR+sD13aIk7BFo0VA7c2FBXYtmIwQ5ldU3xprifEY7bZvucxjUJXUjPVLUWVmrDZAiG
	HMCymRcgge6SDBIbclXQDVWEz+ik+KiF+7xw44MRceDSDL8wVSsIow9tu5k6pM6KfJA+5G/JM9U
	i95jW7zpHI1xFrQdAhDUSYQsmeghZ7V381anelo9GkE2/X4apV8wtAhcsdHIFIkajIajP887Gqs
	khtGSCyrAz/V+GQAtieHwzVoFWy+KyjYEZfN4AyN7FGyK0OVVSZ0r/Ak3v76dt2PAr/yViaNiol
	uLieM4daa9EQwPmtXfXuGqdizBVFk1HJCmGwk8Ix21IknGmP1SFbCH+dM2UxpNEtqMfht0A5C3o
	AiQ4JsXOQdqEtnkdkBYktWV8Uf1S0vxyNky/wvRKOmD1sXwXTnx6lMU/xwcgdAuVFaSmByt5UgC
	wGvZSfMl91loNqfckBaN0Ojq7ekszOrM0tPo6ULG2KrkuIYYYSaNx5mQk/hJarsvACvxKDNk/pu
	BVStMuWUtGXtZnbREYp2VTO06RNJIIDu50skPAL0Eholt2I7eQWuJ+4mHGSR6sm/x0AH+C1k5lp
	uDU=
X-Received: by 2002:a05:600c:8488:b0:499:49f2:bb86 with SMTP id 5b1f17b1804b1-4997841e807mr28574635e9.6.1786437233355;
        Tue, 11 Aug 2026 01:33:53 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c3:4d0d:8be2:b2d7:3667:a5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c302sm18728075e9.1.2026.08.11.01.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:33:52 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 11/12] fast-import: use parse_options() for command line options
Date: Tue, 11 Aug 2026 10:33:13 +0200
Message-ID: <20260811083314.2023489-12-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260811083314.2023489-1-christian.couder@gmail.com>
References: <20260804100355.1299498-1-christian.couder@gmail.com>
 <20260811083314.2023489-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commits have started to use the parse-options API to display
output from `git fast-import -h` and `git fast-import --help-all` and
to prepare for parsing the command line options using this API.

Let's now actually use the API to parse command line options.

This brings a number of changes that are mostly beneficial:

  - The `--alias`, `--get-mark`, `--cat-blob`, `--ls` and `--notes`
    options are no longer accepted on the command line. They were
    previously accepted as no-ops because parse_argv() fell through to
    parse_one_feature(). They are not documented in the OPTIONS section
    and are only meaningful as in-stream feature assertions, so
    accepting them on the command line was an accident of code sharing
    dating back to 9c8398f0c9 (fast-import: add option command,
    2009-12-04).

  - Abbreviated options like `--dep=5` now work since parse_options()
    allows unambiguous prefixes.

  - As `--cat-blob` is an abbreviation of `--cat-blob-fd`, using the
    former on the command line will fail with "option `cat-blob-fd'
    requires a value" unlike the other four options that are not
    accepted anymore on the command line (see above).

  - Value-taking options now also accept the space-separated
    `--opt value` form, like `--depth 5`, in addition to the
    `--opt=value` form.

  - A bare or trailing `--` is now accepted and the stream is read
    normally, while it used to be a usage error.

  - The error messages for some options might differ a bit.

  - The code is shorter and more standard.

Note that parse_one_feature() is now always called with its
`from_stream` argument set to 1, but the code simplifications that
can be made are left for a following clean-up commit.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/git-fast-import.adoc |  7 +++++
 builtin/fast-import.c              | 43 ++++++++++--------------------
 t/t9300-fast-import.sh             |  7 +++++
 3 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 7c5900e048..fd165e11d2 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -65,6 +65,13 @@ Only enable this option if you trust the program generating the
 fast-import stream! This option is enabled automatically for
 remote-helpers that use the `import` capability, as they are
 already trusted to run their own code.
++
+Note that this option has to be spelled in full, and has to appear
+before any option whose value is separated from it by a space, for
+the unsafe `feature` commands in the stream to be allowed. So
+`--allow-unsafe` or `--depth 5 --allow-unsafe-features` still refuse
+them, while `--allow-unsafe-features --depth 5` and
+`--depth=5 --allow-unsafe-features` allow them.
 
 `--signed-tags=<mode>`::
 	Specify how to handle signed tags. Behaves in the same way as
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 40cc9c4a23..dd873ec433 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3975,31 +3975,11 @@ static const char *const fast_import_usage[] = {
 
 static void parse_argv(struct fast_import_state *state)
 {
-	unsigned int i;
-
-	for (i = 1; i < state->argc; i++) {
-		const char *a = state->argv[i];
-
-		if (*a != '-' || !strcmp(a, "--"))
-			break;
-
-		if (!skip_prefix(a, "--", &a))
-			die(_("unknown option %s"), a);
-
-		if (parse_one_option(state, a))
-			continue;
-
-		if (parse_one_feature(state, a, 0))
-			continue;
-
-		if (skip_prefix(a, "cat-blob-fd=", &a)) {
-			option_cat_blob_fd(state, a);
-			continue;
-		}
+	int argc = parse_options(state->argc, state->argv, state->prefix,
+				 state->option, fast_import_usage,
+				 PARSE_OPT_KEEP_ARGV0);
 
-		die(_("unknown option --%s"), a);
-	}
-	if (i != state->argc)
+	if (argc > 1)
 		usage_with_options(fast_import_usage, state->option);
 
 	state->seen_data_command = 1;
@@ -4135,11 +4115,6 @@ int cmd_fast_import(int argc,
 {
 	struct fast_import_state state;
 
-	/*
-	 * NEEDSWORK: For now this is used only to render
-	 * `-h`/`--help-all` usage messages. The actual parsing is
-	 * done by parse_one_option()/parse_one_feature().
-	 */
 	struct option fast_import_options[] = {
 		OPT_GROUP(N_("Common")),
 		OPT_CALLBACK_F(0, "date-format", NULL, N_("fmt"),
@@ -4230,6 +4205,16 @@ int cmd_fast_import(int argc,
 	 * "feature" lines at the start of the stream (which allows the command
 	 * line to override stream data). But we must do an early parse of any
 	 * command-line options that impact how we interpret the feature lines.
+	 *
+	 * NEEDSWORK: This scan only matches the exact "--allow-unsafe-features"
+	 * spelling and stops at the first argument that doesn't start with a
+	 * dash. As parse_options() below also accepts unambiguous abbreviations
+	 * and values separated by a space from their option, the two disagree
+	 * for command lines like "--allow-unsafe" or "--depth 5
+	 * --allow-unsafe-features": parse_options() accepts the option, but
+	 * this scan doesn't see it, so unsafe features from the stream are
+	 * still refused. This errs on the safe side, but should be fixed by
+	 * teaching this scan about the options that take a value.
 	 */
 	for (int i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index fe6c2617ac..d9de2ef0d8 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2827,6 +2827,13 @@ test_expect_success 'R: unknown commandline options are rejected' '\
 	test_must_fail git fast-import --non-existing-option < /dev/null
 '
 
+test_expect_success 'R: feature-only names are rejected on the command line' '
+	for opt in --alias --get-mark --ls --notes
+	do
+		test_must_fail git fast-import "$opt" </dev/null || return 1
+	done
+'
+
 test_expect_success 'R: die on invalid option argument' '
 	echo "option git active-branches=-5" |
 	test_must_fail git fast-import &&
-- 
2.55.0.530.gdb3615d990.dirty

