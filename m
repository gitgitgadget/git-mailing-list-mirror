Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AC47ECC2
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365479; cv=none; b=h8k6j/xBom5bZbaRbAKOQ3GL5q4oBfWu9aq5S756nAkbsh34NjDpFyRB0w/FursGM0i81SiIcWtyiPqHPFnvzCG/XlNEt1NJ2hadRU2CTdx+JbK2GsS/CdUU0cj1Nf5istDgBQreJB/McBVDzipix8tj8USXX9fLDa9plsL9zrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365479; c=relaxed/simple;
	bh=2n82NqYflBdkKtj5I+YzOzJjFps1VNBni9wAB/18FrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgeXaaSP53mn7xPF1TXT0h3CsDCBHl4xBFzA72daOJwQcK0eAJre+UQmd3SwewZrchxouh+RBHtcB7DL05TM0vVeXA31oIni0q3zQQ58dIEluLIjQM1YA54y5CvkJ6y0u9gqGaPfWHig7JzY62q7f9P+IU0JRxnQETTjdu+JzZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hnnw/IA7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnnw/IA7"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so13735055e9.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788365476; x=1788970276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWYA7QpGRtbpgr91oZ+Mvez8vGEB0Od/lhryFTD57e4=;
        b=Hnnw/IA7a7d9XEW9NssREBsRaYZvliGTUpFT5BjxAf1Lz4JI0aIcUWSnNKHVdFK/LX
         +i5pMpWVKWphBZ/GChwBSPRxCpRtBT7KTiJ62Dp4uPNh0+mrVlWruhSkwmeT2sn8MJAz
         hKRDnQEoou7xIqkAFS8w6AUNx6GnAfOMdtegByzPeKMKm3cNaPgBDLczSjmz6Tp6F5eq
         MDsgDkhV8B/178cgqZYuXDBG6wGxZDfKwG6a0ndBUeiFp+NU8k3sQOEiskirjSdK3fh+
         oh7MaoN7aVAwfQwf/rGVYxylKKIK8+6h+o/k/mZ8h2GpvBUTF5rVZAhkJkR82HXkWAuy
         3mlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365476; x=1788970276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aWYA7QpGRtbpgr91oZ+Mvez8vGEB0Od/lhryFTD57e4=;
        b=gR/bwsHgEzWGy6oyb4QVtsteNdaZswOExjTFkGRfyzEyIA3PJYwq2GvHf+K8WBvpws
         b6uOOeQBIAqo5tbr/WpLc9rLEps4zvjkTRzpnK2aSxPaEt1DNxMOzKxsP9sWF/qeewBZ
         3ikuYTQgWk5A3I00NG2ZlUXCFxjekzsYsaczT5NCikfr7j0PS29UTh4b1ZJRJpKwUUtT
         Wr807/XIKbXBP52P5byx4YADR9phf1FrOT+VoFoCZz3cZIYSJqyl0j/YII57e+Q0HKFb
         0sC2hTGA5dnR9zV/NQdu6OZA+4OT13qGlhruq2Aw7DIf97QtEqsIWOgF6nDYOCmnVjyB
         mZYQ==
X-Gm-Message-State: AFuF++kmCNkkmSUOt/wS7q39YJuMiUBSkHxlLdIjojrns+DC4V1Ej65h
	xEpf2xzEqA/tSYnUpWx0RMfj83uNpQvzBtqjYnG8t4Qg2rXWUsQRQ0FE6lIJ2dhT
X-Gm-Gg: AR+sD107zN62bnAzg51eFPaITDLj01/tr98D6OAgrRVx5P1aHlPGi3n5kzDe+YmxgjK
	um6+FXqt3g3prgr7DuZSderero0ea8P9xeTQt43E3uHBhFtlggpX0m8WO5N99gXrQ9mEBbdtaSX
	kPOZQaGmQI+lBCEhDTK4+wwf7FDy8D1J+qiGlWmQP9VgE/xyJO87zGNgTwEPH2BO8S4ZA8+F+/U
	kSZkKai8Mg9sh03NFK/crNbOvziIaKqc7qouuNd4g9rcnLn4Yq0e6LNivNmaQNuUZIN+GM3XISe
	fQStFwtnJXa4h5bPEvQNRnOQQpQOS/gIFH40PiEGNGeu72U/GxF03uw41zZMyCarh6LVyRkyPGG
	w5CLtJxiOs5nGpVeWql20osJGBMd6T/tgbV/32OEGFiW6pufBbKpjiaeOnY85Mm/m36z9AzMAy2
	FVbvOXe8Te0zWXdCWsc4t2eN/WMkmuU7BzMWmsOSCrOUiq8oGcJmTd2TI96BfHjcaEze4cCsEz7
	eU/GYSSJ1L/M121B5aMzGLJ/4frH5B7Ulf6xPNn0iYqB/Xn/nIVhpGtUxZACLMUsfpt/CpeLkul
	wvsf7nXCsJzAnGP/CgX4pAA7+g6Hr8GkZueASmBhsCM6noHXFaziNlZOoKwHLnNw0oYhTMbW27w
	=
X-Received: by 2002:a05:600c:4ed0:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-49ce57ec163mr113691895e9.1.1788365475280;
        Wed, 02 Sep 2026 09:11:15 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5563c6csm50938075e9.4.2026.09.02.09.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:14 -0700 (PDT)
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
Subject: [PATCH 1/6] parse-options: add early_scan_options()
Date: Wed,  2 Sep 2026 18:10:42 +0200
Message-ID: <20260902161047.476753-2-christian.couder@gmail.com>
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

Some commands need to look at a few of their options before they can
parse their command line for real, for example because the result
decides whether a repository is needed at all, or how the beginning of
their input should be interpreted.

Such an early scan has to know which options take their value as a
separate argument, or it mistakes such a value for an option. Several
commands get this wrong, as they just walk their arguments comparing
them to the few option names they care about.

Let's add early_scan_options() to help with this. Its callers describe
the options to look for, but also the ones that merely have to be
skipped along with their value, so that the scan can walk the arguments
without being fooled by option values.

Note that abbreviated options are deliberately not recognized, as a
scan cannot know about the options it hasn't been told about, and would
then resolve abbreviations differently from the actual option parsing.

So users must spell these specific options in full. This restriction
could be lifted in the future though, once the scanner is adapted to
accept a command's full option array, as this would give it the
complete context needed for safe abbreviation matching.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 parse-options.c               | 70 +++++++++++++++++++++++++++++++
 parse-options.h               | 60 +++++++++++++++++++++++++++
 t/helper/test-parse-options.c | 39 ++++++++++++++++++
 t/helper/test-tool.c          |  1 +
 t/helper/test-tool.h          |  1 +
 t/t0040-parse-options.sh      | 77 +++++++++++++++++++++++++++++++++++
 6 files changed, 248 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 4519ead9dc..b3d19446cd 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1244,6 +1244,76 @@ int parse_options(int argc, const char **argv,
 	return parse_options_end(&ctx);
 }
 
+/*
+ * Look for `arg` among `options`. On success, return the matching option
+ * and set `value` to the value stuck to it, if any, or to NULL.
+ */
+static const struct early_scan_option *
+find_early_scan_option(const char *arg,
+		       const struct early_scan_option *options,
+		       const char **value)
+{
+	if (!skip_prefix(arg, "--", &arg))
+		return NULL;
+
+	for (; options->name; options++) {
+		const char *rest;
+
+		if (!skip_prefix(arg, options->name, &rest))
+			continue;
+		if (!*rest) {
+			*value = NULL;
+			return options;
+		}
+		/* Only an option taking a value can be stuck to one. */
+		if (*rest == '=' && options->takes_value) {
+			*value = rest + 1;
+			return options;
+		}
+	}
+
+	return NULL;
+}
+
+int early_scan_options(int argc, const char **argv,
+		       const struct early_scan_option *options,
+		       enum early_scan_flags flags,
+		       early_scan_fn *fn, void *data)
+{
+	for (int i = 0; i < argc; i++) {
+		const char *arg = argv[i];
+		const char *value;
+		const struct early_scan_option *opt;
+		int pos = i;
+
+		if ((flags & EARLY_SCAN_STOP_AT_DASHDASH) &&
+		    !strcmp(arg, "--"))
+			return i;
+
+		opt = find_early_scan_option(arg, options, &value);
+		if (!opt) {
+			if ((flags & EARLY_SCAN_STOP_AT_NON_OPTION) &&
+			    (*arg != '-' || !arg[1]))
+				return i;
+			continue;
+		}
+
+		/*
+		 * When an option takes a value, but that value is not
+		 * stuck to it with '=', then the next argument is the
+		 * value and it has to be skipped so that it isn't
+		 * taken for an option itself.
+		 */
+		if (opt->takes_value && !value && i + 1 < argc)
+			value = argv[++i];
+
+		if (opt->wanted && fn(opt, value, pos, data))
+			return i;
+	}
+
+	return argc;
+}
+
 static int usage_argh(const struct option *opts, FILE *outfile)
 {
 	const char *s;
diff --git a/parse-options.h b/parse-options.h
index d7f896a933..abc73d8399 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -491,6 +491,66 @@ static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
 		BUG("option callback expects an argument"); \
 } while(0)
 
+/*----- Early scan: scanning argv before the actual option parsing -----*/
+
+/*
+ * Some commands need to look at a few options before they can parse
+ * their command line for real, for example because the result decides
+ * whether a repository is needed at all.
+ *
+ * Such an early scan has to know which options take their value as a
+ * separate argument, or it could mistake such a value for an option. The
+ * `struct early_scan_option` array passed to early_scan_options() below
+ * describes the options to look for, as well as the ones that only need
+ * to be skipped along with their value.
+ */
+struct early_scan_option {
+	const char *name; 	/* Option name, without the leading dashes */
+	unsigned takes_value:1; /* "--option=value" or "--option value" expected? */
+	unsigned wanted:1;      /* Report option to callback? */
+};
+
+#define EARLY_SCAN_SKIP_VALUE(n) { .name = (n), .takes_value = 1 }
+#define EARLY_SCAN_WANT(n) { .name = (n), .wanted = 1 }
+#define EARLY_SCAN_WANT_VALUE(n) { .name = (n), .takes_value = 1, .wanted = 1 }
+#define EARLY_SCAN_END() { NULL }
+
+/*
+ * Called by early_scan_options() for each argument matching a
+ * `struct early_scan_option` that has its `wanted` bit set.
+ *
+ * `option` is the matching option, `value` its value or NULL if it
+ * doesn't take one, and `pos` the index of the option in argv.
+ *
+ * Returning a non-zero value stops the scan.
+ */
+typedef int early_scan_fn(const struct early_scan_option *option,
+			  const char *value, int pos, void *data);
+
+enum early_scan_flags {
+	EARLY_SCAN_STOP_AT_DASHDASH = 1 << 0, /* Stop at "--" */
+	EARLY_SCAN_STOP_AT_NON_OPTION = 1 << 1,
+};
+
+/*
+ * Scan `argv` for the options described by `options`, calling `fn`
+ * for each of those that are `wanted`. `argv` is not modified.
+ *
+ * `fn` may be NULL when no option is `wanted`, which is useful to only
+ * find out where the scan stops.
+ *
+ * Note that abbreviated options are not recognized, as a scan cannot
+ * know about the options it hasn't been told about, and would then
+ * resolve abbreviations differently from the actual option parsing.
+ *
+ * Returns the index at which the scan stopped, which is `argc` when the
+ * whole array was scanned.
+ */
+int early_scan_options(int argc, const char **argv,
+		       const struct early_scan_option *options,
+		       enum early_scan_flags flags,
+		       early_scan_fn *fn, void *data);
+
 /*----- incremental advanced APIs -----*/
 
 struct parse_opt_cmdmode_list;
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index f181f0c02d..96ab941d29 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -383,3 +383,42 @@ int cmd__parse_subcommand(int argc, const char **argv)
 
 	return parse_subcommand__cmd(argc, argv, test_flags);
 }
+
+static int show_early_option(const struct early_scan_option *opt,
+			     const char *value, int pos, void *data UNUSED)
+{
+	printf("found: %s at %d", opt->name, pos);
+	if (value)
+		printf(" value: %s", value);
+	putchar('\n');
+	return 0;
+}
+
+int cmd__early_scan_options(int argc, const char **argv)
+{
+	static const struct early_scan_option options[] = {
+		EARLY_SCAN_WANT("wanted"),
+		EARLY_SCAN_WANT_VALUE("wanted-value"),
+		EARLY_SCAN_SKIP_VALUE("skipped-value"),
+		EARLY_SCAN_END()
+	};
+	enum early_scan_flags flags = 0;
+	int stopped;
+
+	while (argc > 1 && *argv[1] == '-') {
+		if (!strcmp(argv[1], "--stop-at-dashdash"))
+			flags |= EARLY_SCAN_STOP_AT_DASHDASH;
+		else if (!strcmp(argv[1], "--stop-at-non-option"))
+			flags |= EARLY_SCAN_STOP_AT_NON_OPTION;
+		else
+			break;
+		argc--;
+		argv++;
+	}
+
+	stopped = early_scan_options(argc - 1, argv + 1, options, flags,
+				    show_early_option, NULL);
+	printf("stopped at: %d of %d\n", stopped, argc - 1);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b71a22b43b..5d2f5877d9 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -50,6 +50,7 @@ static struct test_cmd cmds[] = {
 	{ "pack-mtimes", cmd__pack_mtimes },
 	{ "parse-options", cmd__parse_options },
 	{ "parse-options-flags", cmd__parse_options_flags },
+	{ "early-scan-options", cmd__early_scan_options },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "parse-subcommand", cmd__parse_subcommand },
 	{ "partial-clone", cmd__partial_clone },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f2885b33d5..071306d52d 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -43,6 +43,7 @@ int cmd__pack_deltas(int argc, const char **argv);
 int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_options_flags(int argc, const char **argv);
+int cmd__early_scan_options(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__parse_subcommand(int argc, const char **argv);
 int cmd__partial_clone(int argc, const char **argv);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 449fff4d34..d760d8cfbd 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -845,4 +845,81 @@ test_expect_success 'u16 limits range' '
 	test_grep "value 65536 for option .u16. not in range \[0,65535\]" err
 '
 
+test_expect_success 'early_scan_options() finds a wanted option' '
+	test-tool early-scan-options --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 0
+	stopped at: 1 of 1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() reads a stuck or separate value' '
+	test-tool early-scan-options --wanted-value=one >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted-value at 0 value: one
+	stopped at: 1 of 1
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --wanted-value two >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted-value at 0 value: two
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() skips the value of other options' '
+	test-tool early-scan-options --skipped-value --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --skipped-value one --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 2
+	stopped at: 3 of 3
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() can stop at "--"' '
+	test-tool early-scan-options --stop-at-dashdash -- --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --stop-at-dashdash \
+		--skipped-value -- --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 2
+	stopped at: 3 of 3
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() can stop at a non-option' '
+	test-tool early-scan-options --stop-at-non-option \
+		arg --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --stop-at-non-option \
+		--skipped-value arg --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 2
+	stopped at: 3 of 3
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() ignores abbreviated options' '
+	test-tool early-scan-options --want >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 1 of 1
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.55.0.787.g3f9e2241eb.dirty

