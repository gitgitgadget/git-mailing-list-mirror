Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716A446A5ED
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150993; cv=none; b=jeWWYziVhwAVJgWX/1CsTVcDMIWk427v7js54Kb9y4rQLywDCiQVGV60NMRpzAtQvq46KcRc5BPjJl8AUB6eyCXlv2373ebfq1JLooITZwc73CBrRGRbnEjSp3419blhFafSZxvb0P1y2DQnsEGReG1Fr2eoSq3DyPJEauYdI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150993; c=relaxed/simple;
	bh=8R6XMalBq9Kptv6935JzQ7T7M7kGIVhp9G78TzB6cLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puUhI1t0e9tjjKa0jqpr3dfoV3egeaksHVwHhbOgLkY+8+fJZ67DWxvqH1JlFInFW7l+vVp75Zs1Q7STTDzmZ9Iffvxh7CU/ZYd5wxY3M2y9/Z6sT1oyHHcig/opBhCVj9QbETbBAvVnMlRUs9DkyqlILbpcnu4x2uH5oDz8t1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+b3+Mxg; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+b3+Mxg"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-482f6351831so406456f8f.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 01:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790150990; x=1790755790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CkazDjxr43XDsA71lNYkJx+69iHYrM2dymz49CTsoLU=;
        b=S+b3+MxgKuILCEWlKtYsEgBwDfZSMmVedkECT1Un/kzw1pxM6Mr9vaZ8pz9kFoYcMe
         SU7uCMQ00OISDC+2HtopDk2RSUOabd1NNWP/Imx8B7b8VHh6Qd4IowfmI00TTWq8dGk8
         2hXMJqeJ0EyFzl+vjm2c8pjnZ20Hx2r6+cuyi62Fa1lJ1L8s2ITD/c6jxrRIu6eXvThB
         COWCSt21/XI9dRd5VG+SYbofk0DlAVCmWAUaj8zASPSOyK/4BcFMqCLkN2QFyHqFArHG
         KutIK9zs6fSt0fpXXs48GUohcgaJM7en0XRyarkgTh0HDK0RHduv/wprxWUUOw+bBFKg
         3w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790150990; x=1790755790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CkazDjxr43XDsA71lNYkJx+69iHYrM2dymz49CTsoLU=;
        b=KS7b05JkL7LJl2SRAInBPPBYdjmvy/cwg7LpYQYEj0mscbY77oEGZMRrUNFonYR3FO
         FMd3DMjzNMxgzjA4BcMFaP00AH9wXXb00cq1KIdm86j8vqTTvAPuXVxQhlYWzDMCTksF
         LHNy9rdJvLGU0prkWD5H3qMwwMccvMJ8PSHvmdWAywzEt9ubvjXulLMcg9hfPPDfhOg6
         Z9/EMnHnCGy1vBiIXbSwdxOraRLTz6YCwkhJaSuyYRudUE2esgTxKX7sEumcyeiz3/N7
         e/KlvzY6ZOTTkGAK9NmLBLst1vb6B9+PjzOZl6cCjLs1G7dlv8ZJsEO85lqwSCm4sg7U
         QNDA==
X-Gm-Message-State: AFuF++lF7U4zjE4Vwhq0C2btx7NG28erhO1S60BS8ajM6IQC6iFP4aog
	GyZXZ4sEWeXmCJfdj/Gd1no8jvpWhPKgCDOCqndiex4wLXOu/UTcXgvEEnf1/g==
X-Gm-Gg: AYBFou1bQCTpgS0AoshlJn0hZBL0/YKdfGDaQHi54ofKL8XEn/yceB7Kq/znqZ6VhNQ
	2dwfmVdGw1ftWtMlGA2jgGX3LRj/xRTxz/ittr6/Rr+gIPLgYr7+QfZ6jWO8INP/AK1Wx0r2YQV
	0mPSKSnmhi0dFpzfTYR6vcmjz79o0xrfPntIH931PyC9mTBuev7ZqNX8KXMqlmGoQ0TN0lOAxCN
	pokjMDya2GyS8oP0Rhb5prwMjBBAqRQ55cvYjT4wAJufXqGm+FIqjWLq6ef7dwH0fYm1pLLcURZ
	WVriPOFP17gdtdLNOzzslsfApIXPy5er4vcGUTTg2clErxWrJEmQaDouDlo78b5CUxGS0TZg6TZ
	XSAo48oN/VOZR8qZg07vw3KSk8rFm4820DGqcJ9hOtwit091YTIKgBL3SLBNzTgvZc7FcK8j3P/
	8Mryxp9Tvrudr7fgEtRnlcNYvHn2RueiVamfNF1Jb/+0lDNKFPLN38PmpWRKyW/3Cdkr+EisYsu
	ezscPNIXXRPE7Rk+lTzVawfyT0Lt0FP3xICf6yh+uTApdDrRhE16urDdLHWe+5FkKnewGjQXdiS
	oRhtdpvEADGUCYixRWL6Lnxap9HZd6Yq/+5F1pDUCY0aDPn2o3fpNzgA3Fqg4/SCULb6CvXlfdk
	KdfsUvwom5jf1yaRmFbI=
X-Received: by 2002:a05:600c:1daa:b0:49f:dd9f:6038 with SMTP id 5b1f17b1804b1-49fdf13b09cmr18239755e9.25.1790150989492;
        Wed, 23 Sep 2026 01:09:49 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682673bdsm5037470f8f.2.2026.09.23.01.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:09:48 -0700 (PDT)
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
Subject: [PATCH v2 3/3] fast-import: use early_scan_options() for --allow-unsafe-features
Date: Wed, 23 Sep 2026 10:09:28 +0200
Message-ID: <20260923080928.1534413-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2
In-Reply-To: <20260923080928.1534413-1-christian.couder@gmail.com>
References: <20260902161047.476753-1-christian.couder@gmail.com>
 <20260923080928.1534413-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "feature" lines at the start of the stream are processed before the
command line options are parsed, so cmd_fast_import() scans its
arguments early to find out if `--allow-unsafe-features` was given.

That scan doesn't know which options take their value as a separate
argument, and it stops at the first argument that doesn't start with a
dash. So it disagrees with parse_options(), which accepts values
separated from their option by a space, for a command line like
"--depth 5 --allow-unsafe-features": the scan stops at "5" and never
sees the option, so unsafe "feature" commands from the stream are
refused even though the option was given.

Let's fix this by using early_scan_options(), which scans the very
same `struct option` array that parse_options() uses, so that both
agree on which options take a value, and by marking
`--allow-unsafe-features` with PARSE_OPT_EARLY so that the scan
reports it.

Note that the scan still only matches the exact option spelling, while
parse_options() also accepts unambiguous abbreviations, so the two still
disagree for a command line like "--allow-unsafe". This errs on the safe
side, and is now documented as a restriction.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/git-fast-import.adoc | 10 ++++----
 builtin/fast-import.c              | 38 +++++++++++++++++-------------
 t/t9300-fast-import.sh             | 14 +++++++++++
 3 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index fd165e11d2..c04b8fe502 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -66,12 +66,10 @@ fast-import stream! This option is enabled automatically for
 remote-helpers that use the `import` capability, as they are
 already trusted to run their own code.
 +
-Note that this option has to be spelled in full, and has to appear
-before any option whose value is separated from it by a space, for
-the unsafe `feature` commands in the stream to be allowed. So
-`--allow-unsafe` or `--depth 5 --allow-unsafe-features` still refuse
-them, while `--allow-unsafe-features --depth 5` and
-`--depth=5 --allow-unsafe-features` allow them.
+Note that this option has to be spelled in full for the unsafe
+`feature` commands in the stream to be allowed. So `--allow-unsafe`
+is accepted as an unambiguous abbreviation of this option, but the
+unsafe `feature` commands are still refused.
 
 `--signed-tags=<mode>`::
 	Specify how to handle signed tags. Behaves in the same way as
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index fbd919982c..7f36b828ce 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -4120,6 +4120,17 @@ static int option_parse_quiet(const struct option *opt UNUSED,
 	return 0;
 }
 
+static int option_parse_early_allow_unsafe(const struct option *option,
+					   const char *value UNUSED,
+					   int pos UNUSED, void *data)
+{
+	struct fast_import_state *state = data;
+
+	if (!strcmp(option->long_name, "allow-unsafe-features"))
+		state->allow_unsafe_features = 1;
+	return 0;
+}
+
 int cmd_fast_import(int argc,
 		    const char **argv,
 		    const char *prefix,
@@ -4184,7 +4195,7 @@ int cmd_fast_import(int argc,
 		OPT_HIDDEN_GROUP(N_("Advanced")),
 		OPT_BOOL_F(0, "allow-unsafe-features", &state.allow_unsafe_features,
 			   N_("allow unsafe mark commands from the stream"),
-			   PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
+			   PARSE_OPT_HIDDEN | PARSE_OPT_NONEG | PARSE_OPT_EARLY),
 		OPT_CALLBACK_F(0, "export-pack-edges", &state, N_("file"),
 			       N_("dump edge commits to <file>"),
 			       PARSE_OPT_HIDDEN | PARSE_OPT_NONEG,
@@ -4218,23 +4229,16 @@ int cmd_fast_import(int argc,
 	 * line to override stream data). But we must do an early parse of any
 	 * command-line options that impact how we interpret the feature lines.
 	 *
-	 * NEEDSWORK: This scan only matches the exact "--allow-unsafe-features"
-	 * spelling and stops at the first argument that doesn't start with a
-	 * dash. As parse_options() below also accepts unambiguous abbreviations
-	 * and values separated by a space from their option, the two disagree
-	 * for command lines like "--allow-unsafe" or "--depth 5
-	 * --allow-unsafe-features": parse_options() accepts the option, but
-	 * this scan doesn't see it, so unsafe features from the stream are
-	 * still refused. This errs on the safe side, but should be fixed by
-	 * teaching this scan about the options that take a value.
+	 * NEEDSWORK: This scan only matches the exact
+	 * "--allow-unsafe-features" spelling, while parse_options() below
+	 * also accepts unambiguous abbreviations, so the two disagree for
+	 * a command line like "--allow-unsafe": parse_options() accepts
+	 * the option, but this scan doesn't see it, so unsafe features
+	 * from the stream are still refused. This errs on the safe side.
 	 */
-	for (int i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (*arg != '-' || !strcmp(arg, "--"))
-			break;
-		if (!strcmp(arg, "--allow-unsafe-features"))
-			state.allow_unsafe_features = 1;
-	}
+	early_scan_options(argc - 1, argv + 1, fast_import_options,
+			   EARLY_SCAN_STOP_AT_NON_OPTION,
+			   option_parse_early_allow_unsafe, &state);
 
 	rc_free = mem_pool_alloc(&fi_mem_pool, cmd_save * sizeof(*rc_free));
 	for (unsigned int i = 0; i < (cmd_save - 1); i++)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index d9de2ef0d8..1a37f2b8e6 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2344,6 +2344,20 @@ test_expect_success 'R: export-marks options can be overridden by commandline op
 	test_path_is_missing feature-sub
 '
 
+test_expect_success 'R: --allow-unsafe-features found after a value' '
+	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
+	git fast-import --allow-unsafe-features <input &&
+	git fast-import --depth=5 --allow-unsafe-features <input &&
+	git fast-import --depth 5 --allow-unsafe-features <input &&
+	git fast-import --date-format raw --allow-unsafe-features <input
+'
+
+test_expect_success 'R: --allow-unsafe-features has to be spelled in full' '
+	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
+	test_must_fail git fast-import --allow-unsafe <input 2>err &&
+	test_grep "forbidden in input without --allow-unsafe-features" err
+'
+
 test_expect_success 'R: catch typo in marks file name' '
 	test_must_fail git fast-import --import-marks=nonexistent.marks </dev/null &&
 	echo "feature import-marks=nonexistent.marks" |
-- 
2.56.0.rc2

