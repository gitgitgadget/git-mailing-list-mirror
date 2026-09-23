Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88344C4F2
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150992; cv=none; b=Kok2HSoR5I2r7QXAR0maKTFxyjzhd12CA8mmMxIAjrJkNhKDap3cTrLAUafaWCR+t7ZTDz1FDQgkH9suesw8jdFOx2DSVbHR6/84yCer/8rcrPuKnuQvUzt6yiBJ0GH6od9Nbrerj0VJ+ykOZ2GJiXr9LFn82Dat981mDEJZRrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150992; c=relaxed/simple;
	bh=9NEH81qPDMh5TR7Xv5eQiExZjbvn0YKhOq5qs5c7+BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgtXRwdlSp3HIZ0vw2vkWbYKLZFOuYmgt2TMK4EYVcMZv4MJ8lfDQra8m2otYeDHUm2omoCNdiAEr4IrcxjM60Yu4teSq1j5eqUXWfbkPJdDaoysfZIgN/gnEJbgvugFkUpDUzV/y9pxnK3a+A+14xaWYBeh1ffxK1ivphr7YQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k78nriz4; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k78nriz4"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so432804f8f.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 01:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790150988; x=1790755788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNVLVpjEPilBo5bO3Be8mO82x+AkL+qsoBqtF9Sp7XE=;
        b=k78nriz447B1xsXqLl9aE34RGdicjANiAPxVefDlwXCWG2to9cOV9jIPNNS9KtIA0n
         SOWh1EBSiwueGo6ng8p7YMbN0bduLLncW2VT49zTdk8BJwbCrYgk7gOOd8BGvooGW5zY
         H8iW0/I4uPRUXLsUTg88FWidEz9Gk20ASmbKNJNUsa+umU7UA5REhwjMgh167TdNW0Wt
         x4phITSMFrApzE46lWHNMeg4UteyzXxbfIPn66y9s8m6Rb7o0ankjhCq7f6i7wQHO2j4
         2CScPpqUis+F9P36VtcRzOvApY9rJ+VH++XZ6CO0kL44sy2e9F5vCm+NZBQicqda1GTF
         grcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790150988; x=1790755788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNVLVpjEPilBo5bO3Be8mO82x+AkL+qsoBqtF9Sp7XE=;
        b=YX28M/UYrOqug81v5nNFpeBxBZSq0InUXZFBbk0ojiDjW3Wk6KnyC0Zr8Ek3kozccl
         eWzCcxCJGysOG4Bozp9GyqFFB8FuKkqvnP5My+l2hM7qaSxUwFGrUcWQ41Qy/ST+qevU
         N4kSXA1YMRbi+7K9Z8lXHGzWxUfed8PM0CVvtJ+D1XcfhP9Frur3AOl2HZgjcwktaVZ7
         ROdKxHasCwQPUfArnrBno3cLKZ3cJN2Ic4NfRjsR875AannND3uEtPOW9BbzVz5PM0GO
         AZuYKXwzYbAyM0jsZ6pQUik2DkyedHp90qQwPZXyYAeIBAg3CKeKJwhgnni+kWCp22rf
         IP+w==
X-Gm-Message-State: AFuF++me8ghOtPxh8gyusjN3IG/BQasAR4H8lfXSEJe3E30jFb4DbINV
	HxvNRwSOReu4gvdKtAX3GmGIQM0s+F1sikakauaMCMb3SsMLIxjJu18wwAx4Jw==
X-Gm-Gg: AYBFou3S8IEJAKY31SyBSrSFNeDjF3A6DiAkn7rvQa4nAV2TffMyQMQR6ld5NqKLtCb
	avXmqmVvA4u4f5SAXPvXZ8Yx6wDyV9pkHz7I5DOcGchXCdIT80DqJ3t5dv0/QONy+9iNH/LK+A2
	ejcUpMiwRiaqEIQ0LzOE1d27vOUp9bHKMdT76tEzFwJMgeagjUc7anL5XduwPFmrtJUs9a0DLOU
	RyWxqfl4AzUkc/5DuvdiZTQnOtIegcUlLoR8l/BhJMQNOU2ohAPAb/qHlES+bCkqOZfVF0YesZe
	8cEh0E/4WqgTkvtL7oT1A/5N+5fsSvECpomYSaz3Yzx/JJJ3BerRaY9S6drGC4xpGRkp3OLDNqt
	5lHVMW5SSIA4qRlqZBtRyZrvZzy2wBuZ73/S9wcxysZp9JSWMrs8s+o2TrIZ5hkS6lkY9AqsKhH
	UWpjSShQUkZpzsQ7zFEQc4dBSywdQoVB8odiQjFnbR9Yr3dkHriwrw5P1Fl3WvvDfjHXQWJz6v0
	2rI2z9I6UT3o2sDFYgHELV1jboLLjao8zI3ACdre8514GNZqfNJvbFqQcw1P0eOONXW6KppqN+N
	QFk1oDvdBP6b+ojGQTfhKuZZsIdY+5yKUoG1zy5CTNPs+bbwRYQTJgUP0ov0epXGq8/72Ys67mi
	vGDywLd6S
X-Received: by 2002:a05:6000:4b16:b0:487:27f6:a4dc with SMTP id ffacd0b85a97d-48867096460mr2511290f8f.44.1790150988217;
        Wed, 23 Sep 2026 01:09:48 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682673bdsm5037470f8f.2.2026.09.23.01.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:09:47 -0700 (PDT)
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
Subject: [PATCH v2 2/3] parse-options: add early_scan_options()
Date: Wed, 23 Sep 2026 10:09:27 +0200
Message-ID: <20260923080928.1534413-3-christian.couder@gmail.com>
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

Some commands need to look at a few of their options before they can
parse their command line for real, for example because the result
decides whether a repository is needed at all, or how the beginning of
their input should be interpreted.

Such an early scan has to know which options take their value as a
separate argument, or it mistakes such a value for an option. Several
commands get this wrong, as they just walk their arguments comparing
them to the few option names they care about.

Let's add early_scan_options() to help with this. It walks the
arguments using the very same `struct option` array that the command
already passes to parse_options(), and uses the
parse_options_takes_argument() helper added in a previous commit, so
that the scan and the actual parsing agree on which options take a
value.

The options the caller wants to be told about are marked with a new
PARSE_OPT_EARLY flag, so that nothing has to be spelled out a second
time, and so that the mark cannot drift away from the option it refers
to.

Using a per-option flag for this is not new as that flag space already
holds flags that the parsing loop itself ignores, like
PARSE_OPT_NOCOMPLETE and PARSE_OPT_COMP_ARG, which only the completion
helper looks at, or PARSE_OPT_HIDDEN and PARSE_OPT_LITERAL_ARGHELP,
which only the usage output looks at.

The scan is deliberately kept much simpler than parse_options(),
instead of teaching the latter to perform a side effect free "dry
run". Such a dry run would have to avoid writing through `opt->value`,
calling option callbacks, dying on an invalid value, handling `--help`
and tracking command mode conflicts, so it would be a much larger
refactoring. If parse_options() learns to do it in the future though,
the commands converted now would keep both their option array and their
PARSE_OPT_EARLY marks, so their conversion would not have to be redone.

One consequence of staying simple is that abbreviated options are
still not matched, even though the scan is now given the command's
full option array. Resolving them the way parse_options() does would
mean duplicating the ambiguity detection that parse_long_opt()
performs. So the scan can fail to see an option that parse_options()
would accept, and its callers have to cope with that, typically by
erring on the safe side. This and the other differences with
parse_options() are documented in "parse-options.h".

In practice, despite these limitations, early scans using
early_scan_options() should still be safer and cleaner than the
ad-hoc hand-rolled scans they are meant to replace, which don't know
about option values at all and therefore disagree with
parse_options() in ways that create plain bugs.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 .../technical/api-parse-options.adoc          |   5 +
 parse-options.c                               |  81 ++++++++
 parse-options.h                               |  72 ++++++++
 t/helper/test-parse-options.c                 |  62 +++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t0040-parse-options.sh                      | 173 ++++++++++++++++++
 7 files changed, 395 insertions(+)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index 95b7924e84..f59d8e90a5 100644
--- a/Documentation/technical/api-parse-options.adoc
+++ b/Documentation/technical/api-parse-options.adoc
@@ -197,6 +197,11 @@ are the bitwise-or of:
 	Internal flag, set on options that were expanded from a
 	configured alias. It should not be set by callers.
 
+`PARSE_OPT_EARLY`::
+	Report this option to `early_scan_options()`, which looks at a
+	few options before parsing the command line for real. Ignored
+	by `parse_options()` itself.
+
 `PARSE_OPT_NOCOMPLETE`::
 	Do not offer this option for completion.
 
diff --git a/parse-options.c b/parse-options.c
index a132c1ea12..559dad9061 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -669,6 +669,8 @@ static void parse_options_check(const struct option *opts)
 		     opts->long_name))
 			optbug(opts, "uses feature "
 			       "not supported for dashless options");
+		if ((opts->flags & PARSE_OPT_EARLY) && !opts->long_name)
+			optbug(opts, "uses PARSE_OPT_EARLY, which needs a long name");
 		if (opts->type == OPTION_SET_INT && !opts->defval &&
 		    opts->long_name && !(opts->flags & PARSE_OPT_NONEG))
 			optbug(opts, "OPTION_SET_INT 0 should not be negatable");
@@ -706,6 +708,8 @@ static void parse_options_check(const struct option *opts)
 		case OPTION_SUBCOMMAND:
 			if (!opts->value || !opts->subcommand_fn)
 				optbug(opts, "OPTION_SUBCOMMAND needs a value and a subcommand function");
+			if (opts->flags & PARSE_OPT_EARLY)
+				optbug(opts, "OPTION_SUBCOMMAND does not support PARSE_OPT_EARLY");
 			if (!subcommand_value)
 				subcommand_value = opts->value;
 			else if (subcommand_value != opts->value)
@@ -1253,6 +1257,83 @@ int parse_options(int argc, const char **argv,
 	return parse_options_end(&ctx);
 }
 
+/*
+ * Look for `arg` among `option`. On success, return the matching option
+ * and set `value` to the value stuck to it, if any, or to NULL.
+ */
+static const struct option *find_early_scan_option(const char *arg,
+						   const struct option *option,
+						   const char **value)
+{
+	if (!skip_prefix(arg, "--", &arg))
+		return NULL;
+
+	for (const struct option *opt = option; opt->type != OPTION_END; opt++) {
+		const char *rest;
+
+		if (opt->type == OPTION_SUBCOMMAND)
+			continue;
+		if (!opt->long_name)
+			continue;
+		if (!skip_prefix(arg, opt->long_name, &rest))
+			continue;
+
+		if (!*rest) {
+			*value = NULL;
+			return opt;
+		}
+		/* Only an option that can take a value may have one stuck to it. */
+		if (*rest == '=' && !(opt->flags & PARSE_OPT_NOARG)) {
+			*value = rest + 1;
+			return opt;
+		}
+	}
+
+	return NULL;
+}
+
+int early_scan_options(int argc, const char **argv,
+		       const struct option *option,
+		       enum early_scan_flags flags,
+		       early_scan_fn *fn, void *data)
+{
+	for (int i = 0; i < argc; i++) {
+		const char *arg = argv[i];
+		const char *value;
+		const struct option *opt;
+		int pos = i;
+
+		/*
+		 * parse_options() always stops parsing options at these,
+		 * whatever its flags, so nothing after them is an option.
+		 */
+		if (!strcmp(arg, "--") || !strcmp(arg, "--end-of-options"))
+			return i;
+
+		opt = find_early_scan_option(arg, option, &value);
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
+		if (parse_options_takes_argument(opt) && !value && i + 1 < argc)
+			value = argv[++i];
+
+		if (opt->flags & PARSE_OPT_EARLY && fn(opt, value, pos, data))
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
index f29e73f85c..3ef64744a4 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -51,6 +51,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NODASH = 1 << 5,
 	PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
 	PARSE_OPT_FROM_ALIAS = 1 << 7,
+	PARSE_OPT_EARLY = 1 << 8,	/* only for early_scan_options() */
 	PARSE_OPT_NOCOMPLETE = 1 << 9,
 	PARSE_OPT_COMP_ARG = 1 << 10,
 	PARSE_OPT_CMDMODE = 1 << 11,
@@ -501,6 +502,77 @@ static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
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
+ * separate argument, or it could mistake such a value for an
+ * option. The functions below allow performing such early scans
+ * without being fooled by option values.
+ */
+
+/*
+ * Called by early_scan_options() for each argument matching a
+ * `struct option` with PARSE_OPT_EARLY set.
+ *
+ * `option` is the matching option, `value` its value or NULL if it
+ * doesn't take one, and `pos` the index of the option in argv.
+ *
+ * Returning a non-zero value stops the scan.
+ */
+typedef int early_scan_fn(const struct option *option, const char *value,
+			  int pos, void *data);
+
+enum early_scan_flags {
+	EARLY_SCAN_STOP_AT_NON_OPTION = 1 << 0, /* Stop at any non option */
+};
+
+/*
+ * Scan `argv` for the options described by `option`, calling `fn` for
+ * each of those that have PARSE_OPT_EARLY set. `argv` is not
+ * modified.
+ *
+ * `fn` may be NULL when no option has PARSE_OPT_EARLY set, which is
+ * useful to only find out where the scan stops.
+ *
+ * The scan always stops at "--" and at "--end-of-options", as
+ * parse_options() always stops parsing options there too, whatever its
+ * flags. PARSE_OPT_KEEP_DASHDASH and PARSE_OPT_KEEP_UNKNOWN_OPT only
+ * decide if the terminator is left in argv, not if it terminates.
+ *
+ * Returns the index at which the scan stopped, which is `argc` when the
+ * whole array was scanned.
+ *
+ * This scan is for now deliberately much simpler than
+ * parse_options(), so it differs from it in the following ways:
+ *
+ *  - Only the long form of an option is matched, and it has to be
+ *    spelled in full: short options and abbreviations are ignored.
+ *
+ *  - Negated forms ("--no-<name>") are not matched. This is harmless,
+ *    as they never take a value to skip.
+ *
+ *  - Options with PARSE_OPT_OPTARG or PARSE_OPT_LASTARG_DEFAULT are
+ *    treated as not taking a separate value.
+ *
+ *  - OPTION_SUBCOMMAND entries are skipped.
+ *
+ *  - OPTION_ALIAS entries are not resolved to the option they stand
+ *    for.
+ *
+ * So the scan can fail to see an option that parse_options() would
+ * accept, and callers have to cope with that, typically by erring on
+ * the safe side.
+ */
+int early_scan_options(int argc, const char **argv,
+		       const struct option *option,
+		       enum early_scan_flags flags,
+		       early_scan_fn *fn, void *data);
+
 /*----- incremental advanced APIs -----*/
 
 struct parse_opt_cmdmode_list;
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index f181f0c02d..83522714c8 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -383,3 +383,65 @@ int cmd__parse_subcommand(int argc, const char **argv)
 
 	return parse_subcommand__cmd(argc, argv, test_flags);
 }
+
+static int show_early_option(const struct option *opt, const char *value,
+			     int pos, void *data UNUSED)
+{
+	printf("found: %s at %d", opt->long_name, pos);
+	if (value)
+		printf(" value: %s", value);
+	putchar('\n');
+	return 0;
+}
+
+int cmd__early_scan_options(int argc, const char **argv)
+{
+	char *a_string = NULL;
+	int an_int = 0, a_bool = 0, a_short = 0;
+
+	const struct option option[] = {
+		OPT_GROUP("early scan test options"),
+		OPT_BOOL_F(0, "wanted", &a_bool,
+			   "wanted option taking no value",
+			   PARSE_OPT_EARLY),
+		OPT_STRING_F(0, "wanted-value", &a_string, "str",
+			     "wanted option taking a value",
+			     PARSE_OPT_EARLY),
+		OPT_STRING(0, "skipped-value", &a_string, "str",
+			   "option whose value has to be skipped"),
+		OPT_INTEGER(0, "number", &an_int,
+			    "option taking an integer value"),
+		OPT_STRING_F(0, "optarg", &a_string, "str",
+			     "option with an optional value",
+			     PARSE_OPT_OPTARG),
+		OPT_STRING_F(0, "lastarg", &a_string, "str",
+			     "option with a last argument default",
+			     PARSE_OPT_LASTARG_DEFAULT),
+		OPT_STRING_F(0, "early-optarg", &a_string, "str",
+			     "early option with an optional value",
+			     PARSE_OPT_EARLY | PARSE_OPT_OPTARG),
+		OPT_STRING_F(0, "early-lastarg", &a_string, "str",
+			     "early option with a last argument default",
+			     PARSE_OPT_EARLY | PARSE_OPT_LASTARG_DEFAULT),
+		OPT_BOOL('s', NULL, &a_short, "short only option"),
+		OPT_END()
+	};
+
+	enum early_scan_flags flags = 0;
+	int stopped;
+
+	while (argc > 1 && *argv[1] == '-') {
+		if (!strcmp(argv[1], "--stop-at-non-option"))
+			flags |= EARLY_SCAN_STOP_AT_NON_OPTION;
+		else
+			break;
+		argc--;
+		argv++;
+	}
+
+	stopped = early_scan_options(argc - 1, argv + 1, option, flags,
+				     show_early_option, NULL);
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
index 449fff4d34..b796d96b9a 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -845,4 +845,177 @@ test_expect_success 'u16 limits range' '
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
+test_expect_success 'early_scan_options() always stops at "--"' '
+	test-tool early-scan-options -- --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --stop-at-non-option -- --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --skipped-value -- --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 2
+	stopped at: 3 of 3
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() always stops at "--end-of-options"' '
+	test-tool early-scan-options --end-of-options --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --stop-at-non-option \
+		--end-of-options --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 2
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
+test_expect_success 'early_scan_options() takes values from struct option' '
+	test-tool early-scan-options --number --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --number=5 --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 1
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() does not skip an optional value' '
+	test-tool early-scan-options --optarg --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 1
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --lastarg --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 1
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() matches a stuck optional value' '
+	test-tool early-scan-options --early-optarg=one >actual &&
+	cat >expect <<-\EOF &&
+	found: early-optarg at 0 value: one
+	stopped at: 1 of 1
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --early-lastarg=two >actual &&
+	cat >expect <<-\EOF &&
+	found: early-lastarg at 0 value: two
+	stopped at: 1 of 1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() does not take a separate optional value' '
+	test-tool early-scan-options --early-optarg --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: early-optarg at 0
+	found: wanted at 1
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --early-lastarg --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: early-lastarg at 0
+	found: wanted at 1
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() ignores options without a long name' '
+	test-tool early-scan-options -s --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 1
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() ignores negated options' '
+	test-tool early-scan-options --no-wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 1 of 1
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.56.0.rc2

