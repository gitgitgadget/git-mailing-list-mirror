Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792614AA1DC
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365495; cv=none; b=AXgEe6t3GcqpxTc/J6Q9SXacNGV7l/qgbtj3tWmd3jK6wSVH5gnpymu/5LyWZUdCcugogbuZXt2chfbGSuStkx7CBrITPf0aOEZolhIeRtwrLbodHrIKowO9aF3MjI+8/K1SPtxH1MiFt3BGkxTtt3PH6e3inWhJzJAMB4o93hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365495; c=relaxed/simple;
	bh=LIk5h+aODf6yvDCGPuWcdTFhEoq2BZbj1J3tg+f1Mpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzeL7wBBcLE5y641xcE0MbfIqZrc74+2QPuto1ET//UsEr0kTfNHIOEmMmhTow6VVjBH9raghJO4wpkjXApI3g4MKKvnbK+iBXzjZS2bkbxMT5cAzo6dY3QiNL2+eNmvnqrlsCLqH3JDSXq0aABqtMKOzxyqLhtvLmHJoohptw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgLRbCYV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgLRbCYV"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48442ea8f59so12322f8f.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 09:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788365490; x=1788970290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzXw2QXhh7uDtEOKDWVSszSnVQ3pBCguqXpoVwJMotU=;
        b=MgLRbCYV6AUgEcDsWpOZ/HVkmTDCX4x2jZba+iS7JnI8iwnKhPm1cec5uZZiRCgovl
         I04q3Jie3czzZir4Ue32WyN3HJjWCD97x6kwEpADXw9KRI6J8+b+kr3vrsUf5waSvSWt
         2HdGVP7aTUb88VcI8icrTi87oNVtLzEm7vfRQ90KapDxkd+5iklpCvcH2iwn/eMMW674
         B7JFEd6qq8pbljDJJ5/payy6sFLVfhDibYR6xgF3PPQTbebchJe0cTY4OWZhPedLdwdw
         A6ls8G4T7Lr9FZGQOUY+k/VyGXGqHy55ckHJly7m7+r8CC0dbSjWfpbTXT2WFnNqGDpO
         GIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365490; x=1788970290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BzXw2QXhh7uDtEOKDWVSszSnVQ3pBCguqXpoVwJMotU=;
        b=O+mVtdSeX7hb83c3YrWiyznS7Db12DWZvJphBatBtN+ygYN1YPSLv6IH0nHXh+O53o
         KjxK1y/IDwXm1gtHs2c/bEFCxGjcQIvzBRMYTUSrx/ujfig542RPLFBkzbB1isv/5fAe
         bVQ0SEsCoRe5d4n/qJV0gAEGfBiLmopuZ44rGBSUWoHPgu6ArgelAL6OAce0HFD/sxLZ
         g26gRbZ/4byUE283Wsjsrn+WjKeLE3FM+xODwK+I44/24g91z1DJKjVmBGUW0oYQwcdv
         aEtibboCkx+WqJZpn1c+3vJkF6cDkR/QIWU9JSM5TzD/EbIffwKy9WnlC+0hzNrGidyA
         dFDg==
X-Gm-Message-State: AFuF++nHIR3/BpVqHAy27jD9hVLmSwoTtPzHHQdMYCWWKCAUzMyaAb1f
	R2rpTDmFcarL1qHAoJ8CTeIJj2ZNU0LDXY34iJxCzZY3AL+BVOyKDblcqbFdC1jx
X-Gm-Gg: AR+sD10bnoC2q7cCkvEbzDbV1OVkRJs0hKV25Nry1NiIj5NPOKfAa1N6LxurU0VeTta
	9sVyLX1SYzXh+esFwJTqvtVbenij7d7yzJVddX/71C72Id+4X3SrwW1JxYdvXa3ARwhYGIrcano
	1wPs0X13tMxhJT9U4SCbDjxs5gfjc3fOTXu7rI3zLjsIA4JDai9h2Qk1BMCgaCBvy1jcgXm5edj
	3CvluJXtjXtP7PsJOymAz4rfKCIIIxIgJq3e+K2dMwduzG89I9QgooedxmBL0plmrM4UC6QdIre
	ZZXn6x57XCiTNE+DeukD9TWgXlZJImEd4FX2v8reXjbSGBh+lkym37zVs3YnLsPqH4TPHMXbcdx
	pOnwtjV8EwADLsF1ioyQHCGYakrnn8Lv4aUQo/6f3zaggEMf+NBHlmHW/xhiivdWe+nC+8uS/NW
	x7vmksgW6wCVClTs7GoNRU5aZDOvfhj0E500m1Y8V91JDc4anuwbk/nu8XQxScO4MBDywyvQqg/
	mZYmse5Pwa0Ft8DQPlLefUMhPy8MYWd9mWFn+60cw6fQSCOyVtVNo5O4NMP+Gp8sBDiOemDwVx5
	zgLb8ih83HqMWsNWTP6C/FoIPWieSI0t0UNlrszV7FVgkp1CV43aN6SKM92QaeFbaGI5lsoVPiY
	=
X-Received: by 2002:a05:600c:19c8:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49cee5e8fe7mr5241605e9.6.1788365489541;
        Wed, 02 Sep 2026 09:11:29 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5563c6csm50938075e9.4.2026.09.02.09.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:27 -0700 (PDT)
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
Subject: [PATCH 6/6] fast-import: use early_scan_options() for --allow-unsafe-features
Date: Wed,  2 Sep 2026 18:10:47 +0200
Message-ID: <20260902161047.476753-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.787.g3f9e2241eb.dirty
In-Reply-To: <20260902161047.476753-1-christian.couder@gmail.com>
References: <20260902161047.476753-1-christian.couder@gmail.com>
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

Let's fix this by building the options for the scan from the same
`struct option` array that parse_options() uses, so that both agree on
which options take a value.

Note that the scan still only matches the exact option spelling, while
parse_options() also accepts unambiguous abbreviations, so the two still
disagree for a command line like "--allow-unsafe". This errs on the safe
side, and is now documented as a restriction.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/git-fast-import.adoc | 10 +++----
 builtin/fast-import.c              | 46 +++++++++++++++++++-----------
 t/t9300-fast-import.sh             | 14 +++++++++
 3 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index fd165e11d2..9758ba5275 100644
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
+`feature` commands in the stream to be allowed. So while
+`--allow-unsafe` is accepted as an unambiguous abbreviation of this
+option, it still refuses them.
 
 `--signed-tags=<mode>`::
 	Specify how to handle signed tags. Behaves in the same way as
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index fbd919982c..cf0504f01c 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -4120,12 +4120,29 @@ static int option_parse_quiet(const struct option *opt UNUSED,
 	return 0;
 }
 
+/*
+ * The only option the early scan below is interested in, as it decides
+ * whether unsafe "feature" commands from the stream are allowed.
+ */
+static const char *early_wanted[] = { "allow-unsafe-features", NULL };
+
+static int option_parse_early_allow_unsafe(
+		const struct early_scan_option *opt UNUSED,
+		const char *value UNUSED, int pos UNUSED, void *data)
+{
+	struct fast_import_state *state = data;
+
+	state->allow_unsafe_features = 1;
+	return 0;
+}
+
 int cmd_fast_import(int argc,
 		    const char **argv,
 		    const char *prefix,
 		    struct repository *repo)
 {
 	struct fast_import_state state;
+	struct early_scan_option *early;
 
 	struct option fast_import_options[] = {
 		OPT_GROUP(N_("Common")),
@@ -4218,23 +4235,20 @@ int cmd_fast_import(int argc,
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
+	early = early_scan_options_from_options(fast_import_options,
+						early_wanted);
+	early_scan_options(argc - 1, argv + 1, early,
+			   EARLY_SCAN_STOP_AT_DASHDASH |
+			   EARLY_SCAN_STOP_AT_NON_OPTION,
+			   option_parse_early_allow_unsafe, &state);
+	free(early);
 
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
2.55.0.787.g3f9e2241eb.dirty

