Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537153D5674
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091902; cv=none; b=dVLJax2zh6wijy1MNlPuhtCwaXoVVChgfbjyGB9TqnwvwgXAHBIb++WbUmnqsW2Nd9pDjaFUf5WX2lbRahB44jL068FqeZud231f4CuU6JTt5fA0ZLn1a1lEVPN03OgIxOHw628zdkRjHlUeeEjVxh8R+uhseHDF4Ef9rKvV/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091902; c=relaxed/simple;
	bh=iH8V+ORmVm2DGs60rY6wg/Vw16ZNpfIO8Ku55CRTkW8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f/27e5gHsnDYbs74+QGLTT73eM7+lN5uRJPMoVL4XITGc9y62LsdcVqKTwoWje0Pn+UdcMA5Agm+hnw6/7ibXnahv2dHOwmRHI3+PmWeAwve6HTJHgD3uZTSgDjWvoJQrzAKwdf2h6m0z9LwVqc8n7CGeMtZ6KPXY/fkUaiZqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI8Aguty; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI8Aguty"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso2033895a91.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 11:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785091901; x=1785696701; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aeAVsRd1f76dy3d/+Jahyd1tMJ2T1eJU8ftf2DMNF20=;
        b=BI8Agutyj1ues9u1hG924nRN7JPPbFSS6Od4NXCeMEzmB+D6xvcs4c3FbBKxdeENK5
         weL4lQGVVEAjZmfu9CE/pnT43lspn6mtQJ7Uwolbj8g75lYdzVlLFzbJnm2RwXC9G7RO
         eKm5iYFnSZgU67aplGIKS5leLtvjPuU13+nrXk0BeGOKMXGZZpBibgHK6TEiJedelcbA
         8K4cGzxVj1B3HcFA11neiBDSahBKYqV9PI9ojso4DqvDzQxjPM+ALy7K0gt4G6mWINaZ
         HZDMKU67jBh4EVyDCamU/fiya2vcoBE88/EagMmmuEG3qIuSFRWagHXGBemIjlRvFJlO
         CUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785091901; x=1785696701;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aeAVsRd1f76dy3d/+Jahyd1tMJ2T1eJU8ftf2DMNF20=;
        b=FDLClFuk91lecsjt+1BO/yUx/FMWRBUqeGv0C7QQH1DjXHdJatkBydPDvYR9gyTx3T
         vas+m3qchJO9RbZVA2r7Q5IcH89oWHU0+WZltnOecFT37j1/Cj8kzGKeeCfxNX2kIOMv
         tp2mI6i+bhSNYD0U3De2crXASMErpUJqeghI1FugIXwQOLTkD+xRs2e8owdr41dU1+nU
         vHlYchNjfTqKOozyAC9YIZ1bxViDZuHmiJ7gGb3zjYuu4t6FZS+YknnsHYALqCfTgLNR
         je73z7G45xFrT9bgx6oHQq1EbzhK3NrUAzsIjnVIapjxhe6U7zZq0F5xCPGPm+KXMcwR
         FQOA==
X-Gm-Message-State: AOJu0YzNsyqEG5oJmfUF6LGqd0ySCE7XCKxbPRTO+PD3lgVdlQFh141t
	Je9jjLigH+TyQpDz9r4hJhYyFPVT+vr0+2JUQ9wla1wxniJbzKxPzOjfiLcJXw==
X-Gm-Gg: AR+sD12FB3nYAaLg2pGxTdwSVPLcHh/EwJhkGsvmj2CTHbZkiGiZFgC8q/hWElwuMLQ
	vjxdmkYXdSreNxwR879h058TZMSybvaP+FC6sgjADBme7fWSZXQu00gZwH0VMDL5ojAH+yEGII+
	NvlnltMKjhDAN7PWtsKyuw9yhP9fVLJXUx6e4RoVBvHLE2SEbFmFYQQHBelD5Rq7R4+WOyZJdXC
	chyz9jZz1UOHx9M8jOHPUaiEAT7Jp99EAxp9XaFzklGH3YQTNPuxVjAF2DXR/LG0UTqgl5SIZho
	z8joq4IxeZ4nvJK/88N+FLzeWyoiLa99J4pq2F1pNJvrdBcR5kFsWP5RwON4Bv5EDSTlyOH+mZR
	3mnd3w4jji0xpuWfVR/IMusX7ZZ6Pkavkxn/EejNrThBWWZuVkg3AoYXceHq8lWe2NzORoSyGfj
	eTmFIE2WShWmO8htrtIRLJFDw6BQ==
X-Received: by 2002:a17:90b:180c:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-38f2926696bmr5469517a91.0.1785091900529;
        Sun, 26 Jul 2026 11:51:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.229.50])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2eb01aa0sm32953268c88.3.2026.07.26.11.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:51:40 -0700 (PDT)
Message-Id: <4795743ab97a690b0a3544071acf7b417f571e75.1785091889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
References: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
	<pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Jul 2026 18:51:25 +0000
Subject: [PATCH v6 6/9] diff: bypass diff process with --no-ext-diff and in
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
index 8a63b5e164..18b8b0ed24 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -825,7 +825,9 @@ endif::git-format-patch[]
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
index e464b30af4..363052f468 100644
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
index aab012f922..1a487bb353 100644
--- a/diff.c
+++ b/diff.c
@@ -6071,6 +6071,17 @@ static int diff_opt_submodule(const struct option *opt,
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
@@ -6401,8 +6412,9 @@ struct option *add_diff_options(const struct option *opts,
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

