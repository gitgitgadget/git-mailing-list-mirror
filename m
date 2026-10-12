Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1417244F545
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791100; cv=none; b=ebm+tULxtGUhPM4M6wZnTTTmag8fdehegP/d/hiIyIxhA60H9IErK7oV8P8BNsTr+8U2hf6Dg6k2BLjxeJId+pcqwuJCA+Qy6bbwGZLBGe2iDsuLadHqFkohT8iCRZjhERQAqprYjR/LEtsZwpxr6MBGCqZXOOXswvwd/W4Amqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791100; c=relaxed/simple;
	bh=OsE14wuKmbflWJfgZCT5EdBfTGFtREXYm68NuPOqhO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EO6pF77rVOFfzFJEW0NhMdGcI9ZU6Q8kBGnf5APGdR2wM1+8e98OUKRh7QZgkTwWnrta5nz/HKhdpNTXEUowGyVscwsIRsQdPlnbfeRDAxUmNyYdyIHLKa+sPgahBHm2rldAxr7j2aIlJNluYLeN+6h27c9fB62BaV+8Q1ot8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaYfdNDG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaYfdNDG"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c6955a7c3so229900f8f.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 00:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791791096; x=1792395896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jGzQ1JlQ2lPwpzzGAK21rfKZ8V/uDvvAAN7bRbQCaTo=;
        b=KaYfdNDGORoWaoht8hmRtifCQGrZ6pFwLVLaUxXgJyEfZORRJXMLNhQrtLcW40G+IM
         /LhIT7n92row3qNnyg2wEEtdkBHfDbsOdPwtETwUr4aBiluZKaLuqW3mtJIvuM7UQp/E
         pmrrfcghlVPWDBsoPXcF0VMzaAyaMYaKlN7aoOf5QUu53CqeNXyVQmbQ6EusdVzK4vak
         fO+2G3QqkvbxJ0l8bwgFV90dafWQJnXvJyE20EuPAxm2wRDz9yBa4Cxzo9vVRc6urvTt
         tM0NjhXJaeOVy0Yuk5vXBaO/LaXDsQVktYosSXHqsClodzGPBQEHHgXSxGzxs6usSGVq
         baGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791791096; x=1792395896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jGzQ1JlQ2lPwpzzGAK21rfKZ8V/uDvvAAN7bRbQCaTo=;
        b=MlFSKzBr7uQAepS9+JS5fmOa1dbdipMOXkiGtx9Pkr428MS8J66xLyY41mvqJx2KkE
         Pyw59F75pA/pDq3YJgL5h1itEjYj8R5xe1N80rXkuvr4E/NoenzJgjm+Qb4uB3b6pWcL
         xQwF+l8m+Q9KWJr8RTT8ynX+CVG+2eEoCKvEMCC+hjjJna6cEpjkoBQ3SfsUHu2SIlqI
         fm2d/8iYmz5mORgjvWxBiuf/M+Jhr1b+gZ860jYvrYhh9hefTY1OXZ8Lr1ooOs83ebDJ
         dxklqMhFA+VYh917ggeeeKKfiMvLNKR2J2yDMYvGALFsHtx727tJWWSB92XwNOLiav7S
         hNXQ==
X-Gm-Message-State: AFq9FYJ+tnSF9pDBd1a/btjjT44ymfcPCEhJpQr5wUPb22kVr9uQ+vh2
	GbJWzBWfjcbx+x6rfLVLN2/HHuhMrV7wVnXoaRgn3G1M5jCjPYsKvrAKJnUfNg==
X-Gm-Gg: AYBFou1z8Mk0AoTFbfUf91sexhMaKpb3cUF0vFS6HFiUOfrV6a3isnfbZWNsC6RZJIg
	hRwtzKdmGRL/JuVUHDEOHirzLNy9eQjVX9HNjiGw+NmGki+bxVMrBjdXMezltZg0hzA+MOuAjZZ
	ZjuA+cTbeSJiNrjJzJUMOYHWNxv+4s4T6bwHPxNiwFXLwkfoSr5sYx3F6K1gSHa4ubhxoMgaxnk
	PjpgA3pSn91ogrCHdZdS3rFbfRDDYbWFJQZveoqAZ5f1t541WWvJIJk0kp1qqGHxkq40drLkAae
	NtbzvXv0RkGGcblq6y6QcV4cXJKQ8pR80fHovHLz41G7zT1KQvi7iRPECyzPr7Bmp/mhJhJeaxn
	py/WnuSFaLO7xLdftpe1d9SXMCDKEYqA0X+7aun1cGT+wHxmmZZ+38wGdUBb/wCLnloWtL9OoH4
	ltxhlrSvEHBhsYeXbRpDasmRbPSQrFlbPvoKFSp4Cdm16cfW+A7dnlA3uvZJdvpLnvt4XUx/enT
	SPKR/heKviM6M8HWUtleNQt3Nevb1xOOIDS60Apgj9gOtObHdkH41osp8OM7OQfKXiW4Ov6owgX
	pPW1ItOkqnr3fFNSYTb5VrQel4sUbL/onA7YA+C/ThzhB0O/vv8+B6wQ3Daq6u5Mf7EfTwf0f70
	LQiBEJrc4
X-Received: by 2002:a05:6000:29d1:b0:48d:c178:f6e9 with SMTP id ffacd0b85a97d-48dc178f70emr8251406f8f.20.1791791095825;
        Mon, 12 Oct 2026 00:44:55 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db99b800asm17680723f8f.22.2026.10.12.00.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:44:55 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 3/4] parse-options: add early_scan_options()
Date: Mon, 12 Oct 2026 09:44:12 +0200
Message-ID: <20261012074413.337183-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f6092
In-Reply-To: <20261012074413.337183-1-christian.couder@gmail.com>
References: <20260923080928.1534413-1-christian.couder@gmail.com>
 <20261012074413.337183-1-christian.couder@gmail.com>
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
already passes to parse_options(). It looks up long options with the
lookup_long_opt() helper extracted from parse_long_opt() in a previous
commit, so that negated forms, unambiguous abbreviations and aliases
are recognized the same way, and it uses the
parse_options_takes_argument() helper added in another previous
commit, so that the scan and the actual parsing agree on which options
take a value.

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

One consequence of staying simple is that the scan doesn't try to
handle what it cannot reliably skip, like short options, unknown
options, ambiguous abbreviations or options with a low-level callback,
which may consume any number of arguments. It stops at them instead,
so that it never takes an option's value for an option. This matters,
as for example with:

  git fast-import --quiet --export-pack --allow-unsafe-features

parse_options() takes `--allow-unsafe-features` as the value of
`--export-pack-edges`, which `--export-pack` abbreviates. A scan that
just skipped `--export-pack` as an unknown option would wrongly see
`--allow-unsafe-features` there.

So the scan can fail to see an option that parse_options() would
accept, but it doesn't report an option that parse_options() would
not, and its callers can safely err on the side of not having seen an
option. The differences with parse_options() are documented in
"parse-options.h".

In practice, despite these limitations, early scans using
early_scan_options() should still be safer and cleaner than the
ad-hoc hand-rolled scans they are meant to replace, which don't know
about option values at all and therefore disagree with
parse_options() in ways that create plain bugs.

Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 .../technical/api-parse-options.adoc          |   5 +
 parse-options.c                               | 138 ++++++++
 parse-options.h                               |  91 +++++
 t/helper/test-parse-options.c                 |  96 ++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t0040-parse-options.sh                      | 321 ++++++++++++++++++
 7 files changed, 653 insertions(+)

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
index a98b958423..c03c396aa6 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -726,6 +726,8 @@ static void parse_options_check(const struct option *opts)
 		     opts->long_name))
 			optbug(opts, "uses feature "
 			       "not supported for dashless options");
+		if ((opts->flags & PARSE_OPT_EARLY) && !opts->long_name)
+			optbug(opts, "uses PARSE_OPT_EARLY, which needs a long name");
 		if (opts->type == OPTION_SET_INT && !opts->defval &&
 		    opts->long_name && !(opts->flags & PARSE_OPT_NONEG))
 			optbug(opts, "OPTION_SET_INT 0 should not be negatable");
@@ -763,6 +765,8 @@ static void parse_options_check(const struct option *opts)
 		case OPTION_SUBCOMMAND:
 			if (!opts->value || !opts->subcommand_fn)
 				optbug(opts, "OPTION_SUBCOMMAND needs a value and a subcommand function");
+			if (opts->flags & PARSE_OPT_EARLY)
+				optbug(opts, "OPTION_SUBCOMMAND does not support PARSE_OPT_EARLY");
 			if (!subcommand_value)
 				subcommand_value = opts->value;
 			else if (subcommand_value != opts->value)
@@ -1310,6 +1314,140 @@ int parse_options(int argc, const char **argv,
 	return parse_options_end(&ctx);
 }
 
+/*
+ * Look for `name`, a long option without its leading "--", among
+ * `option`, the way parse_options() would. Return true if it names an
+ * option exactly, or as an unambiguous abbreviation that is not
+ * disallowed, with `found` set to that option and its flags, and
+ * `stuck` to the value stuck to it, if any, or to NULL.
+ */
+static bool find_early_scan_option(struct parse_opt_ctx_t *p,
+				   const char *name,
+				   const struct option *option,
+				   bool disallow_abbrev,
+				   struct parsed_option *found,
+				   const char **stuck)
+{
+	struct parsed_option other;
+	enum long_opt_lookup result = lookup_long_opt(p, name, option,
+						      found, &other, stuck);
+
+	switch (result) {
+	case LONG_OPT_EXACT:
+		return true;
+	case LONG_OPT_ABBREV:
+		return !disallow_abbrev;
+	case LONG_OPT_AMBIGUOUS:
+	case LONG_OPT_UNKNOWN:
+		return false;
+	}
+
+	BUG("unknown enum long_opt_lookup value '%d'", result);
+}
+
+struct early_scan_state {
+	struct parse_opt_ctx_t ctx;
+	const struct option *option;
+	enum early_scan_flags flags;
+	early_scan_fn *fn;
+	void *data;
+	bool disallow_abbrev;
+};
+
+/*
+ * Look at argv[*i]. Return 'true' to go on scanning, with *i on the
+ * last argument consumed. Return 'false' to stop, with *i set to the
+ * first argument not consumed.
+ */
+static bool early_scan_one_option(struct early_scan_state *s,
+				  int argc, const char **argv, int *i)
+{
+	const char *name;
+	const char *value;
+	struct parsed_option found;
+	bool unset;
+	int pos = *i;
+	const char *arg = argv[pos];
+
+	/*
+	 * parse_options() always stops parsing options at these,
+	 * whatever its flags, so nothing after them is an option.
+	 */
+	if (!strcmp(arg, "--") || !strcmp(arg, "--end-of-options"))
+		return false;
+
+	/* non-option */
+	if (*arg != '-' || !arg[1])
+		return !(s->flags & EARLY_SCAN_STOP_AT_NON_OPTION);
+
+	/* short option */
+	if (!skip_prefix(arg, "--", &name))
+		return false;
+
+	/* unknown, ambiguous or disallowed abbreviation */
+	if (!find_early_scan_option(&s->ctx, name, s->option,
+				    s->disallow_abbrev, &found, &value))
+		return false;
+
+	/* A low-level callback may consume any number of arguments. */
+	if (found.option->ll_callback)
+		return false;
+
+	unset = !!(found.flags & OPT_UNSET);
+
+	/* parse_options() rejects these, so don't go further. */
+	if (value && (unset || (found.option->flags & PARSE_OPT_NOARG)))
+		return false;
+
+	/*
+	 * Like get_arg(), take the next argument as the value when it is
+	 * not stuck to the option. When there is no next argument,
+	 * parse_options() uses the default value of an option with
+	 * PARSE_OPT_LASTARG_DEFAULT, but errors out for other options.
+	 */
+	if (!value && !unset && parse_options_takes_argument(found.option)) {
+		if (pos + 1 < argc)
+			value = argv[++*i];
+		else if (!(found.option->flags & PARSE_OPT_LASTARG_DEFAULT))
+			return false;
+	}
+
+	if ((found.option->flags & PARSE_OPT_EARLY) &&
+	    s->fn(found.option, value, unset, pos, s->data)) {
+		/* the option, and its value if any, have been consumed */
+		++*i;
+		return false;
+	}
+
+	return true;
+}
+
+int early_scan_options(int argc, const char **argv,
+		       const struct option *option,
+		       enum early_scan_flags flags,
+		       early_scan_fn *fn, void *data)
+{
+	struct early_scan_state s = {
+		.flags = flags,
+		.fn = fn,
+		.data = data,
+		.disallow_abbrev =
+			git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0),
+	};
+	struct option *real_option = preprocess_options(&s.ctx, option);
+	int i;
+
+	s.option = real_option ? real_option : option;
+
+	for (i = 0; i < argc; i++)
+		if (!early_scan_one_option(&s, argc, argv, &i))
+			break;
+
+	free_preprocessed_options(real_option);
+	free(s.ctx.alias_groups);
+	return i;
+}
+
 static int usage_argh(const struct option *opts, FILE *outfile)
 {
 	const char *s;
diff --git a/parse-options.h b/parse-options.h
index 589f8d9008..f39b9a779a 100644
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
@@ -502,6 +503,96 @@ static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
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
+ * - `option` is the matching option,
+ * - `value` its value, or NULL if it doesn't take one or if its value
+ *   is optional and wasn't given, as with PARSE_OPT_OPTARG, or with
+ *   PARSE_OPT_LASTARG_DEFAULT when the option is the last argument,
+ * - `unset` is 'true' for the negated form of the option (like
+ *   for parse_opt_cb()), in which case `value` is always NULL, and
+ * - `pos` the index of the option in argv.
+ *
+ * Returning a non-zero value stops the scan right after the option and
+ * its value, if any.
+ */
+typedef int early_scan_fn(const struct option *option, const char *value,
+			  bool unset, int pos, void *data);
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
+ * Returns the index of the first argument not consumed by the scan,
+ * which is `argc` when the whole array was scanned.
+ *
+ * Long options are looked up the same way as parse_options() does,
+ * so their negated forms, their unambiguous abbreviations, unless
+ * GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS is set, and the OPTION_ALIAS
+ * entries standing for them are all recognized, and their value is
+ * skipped when they take one.
+ *
+ * To never misinterpret an option value as an option though, the scan
+ * stops at any argument it cannot reliably skip, that is:
+ *
+ *  - a short option, or a bundle of them,
+ *
+ *  - an unknown option, or an ambiguous or disallowed abbreviation,
+ *
+ *  - an option with a low-level callback, as such a callback may
+ *    consume any number of arguments,
+ *
+ *  - an option with a value stuck to it that parse_options() would
+ *    reject, like a negated option or a PARSE_OPT_NOARG one,
+ *
+ *  - an option requiring a value when it is the last argument, which
+ *    parse_options() would also reject.
+ *
+ * In all these cases, the scan can fail to see an option that
+ * parse_options() would accept, but it doesn't report an option that
+ * parse_options() would not, so that callers err on the safe side.
+ *
+ * This requires the scan to be told about the way the later
+ * parse_options() call treats its arguments though: callers should
+ * pass EARLY_SCAN_STOP_AT_NON_OPTION when parse_options() is called
+ * with PARSE_OPT_STOP_AT_NON_OPTION or with subcommands, and should
+ * not use the scan when parse_options() is called with
+ * PARSE_OPT_KEEP_UNKNOWN_OPT, which disables abbreviations there but
+ * not here.
+ */
+int early_scan_options(int argc, const char **argv,
+		       const struct option *option,
+		       enum early_scan_flags flags,
+		       early_scan_fn *fn, void *data);
+
 /*----- incremental advanced APIs -----*/
 
 struct parse_opt_cmdmode_list;
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index f181f0c02d..de3dd5751c 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -383,3 +383,99 @@ int cmd__parse_subcommand(int argc, const char **argv)
 
 	return parse_subcommand__cmd(argc, argv, test_flags);
 }
+
+static enum parse_opt_result early_ll_callback(struct parse_opt_ctx_t *ctx UNUSED,
+					       const struct option *opt UNUSED,
+					       const char *arg UNUSED,
+					       int unset UNUSED)
+{
+	return 0;
+}
+
+static int show_early_option(const struct option *opt, const char *value,
+			     bool unset, int pos, void *data)
+{
+	int *stop_at_found = data;
+
+	printf("found: %s at %d", opt->long_name, pos);
+	if (unset)
+		printf(" unset");
+	if (value)
+		printf(" value: %s", value);
+	putchar('\n');
+	return *stop_at_found;
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
+		OPT_ALIAS(0, "alias-of-skipped", "skipped-value"),
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
+		OPT_BOOL_F(0, "no-early", &a_bool,
+			   "early option whose name starts with 'no-'",
+			   PARSE_OPT_EARLY),
+		OPT_BOOL('s', NULL, &a_short, "short only option"),
+		{
+			.type = OPTION_LOWLEVEL_CALLBACK,
+			.long_name = "low-level",
+			.help = "option with a low-level callback",
+			.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			.ll_callback = early_ll_callback,
+		},
+		{
+			.type = OPTION_CALLBACK,
+			.long_name = "ll-value",
+			.argh = "str",
+			.help = "option with a value and a low-level callback",
+			.flags = PARSE_OPT_NONEG,
+			.ll_callback = early_ll_callback,
+		},
+		OPT_END()
+	};
+
+	enum early_scan_flags flags = 0;
+	int stop_at_found = 0;
+	int stopped;
+
+	while (argc > 1 && *argv[1] == '-') {
+		if (!strcmp(argv[1], "--stop-at-non-option"))
+			flags |= EARLY_SCAN_STOP_AT_NON_OPTION;
+		else if (!strcmp(argv[1], "--stop-at-found"))
+			stop_at_found = 1;
+		else
+			break;
+		argc--;
+		argv++;
+	}
+
+	stopped = early_scan_options(argc - 1, argv + 1, option, flags,
+				     show_early_option, &stop_at_found);
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
index 449fff4d34..c44b12e46d 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -845,4 +845,325 @@ test_expect_success 'u16 limits range' '
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
+	test_cmp expect actual &&
+	test-tool early-scan-options --number --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() stops at a last option missing its value' '
+	test-tool early-scan-options --wanted-value >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 1
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --wanted --skipped-value >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 0
+	stopped at: 1 of 2
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
+test_expect_success 'early_scan_options() matches unambiguous abbreviations' '
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	test-tool early-scan-options --wanted-v=x >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted-value at 0 value: x
+	stopped at: 1 of 1
+	EOF
+	test_cmp expect actual &&
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	test-tool early-scan-options --wanted-v x --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted-value at 0 value: x
+	found: wanted at 2
+	stopped at: 3 of 3
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() skips the value of an abbreviation' '
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	test-tool early-scan-options --skipped --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() stops at an ambiguous abbreviation' '
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	test-tool early-scan-options --want --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() stops at disallowed abbreviations' '
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
+	test-tool early-scan-options --wanted-v=x >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 1
+	EOF
+	test_cmp expect actual &&
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
+	test-tool early-scan-options --skipped --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() stops at an unknown option' '
+	test-tool early-scan-options --bogus --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() resolves aliases' '
+	test-tool early-scan-options --alias-of-skipped --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --alias-of-skipped x --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 2
+	stopped at: 3 of 3
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
+	test-tool early-scan-options --optarg=5 --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 1
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() skips a last argument default value' '
+	test-tool early-scan-options --lastarg --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --wanted --lastarg >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 0
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
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() takes a last argument default value' '
+	test-tool early-scan-options --early-lastarg --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: early-lastarg at 0 value: --wanted
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --early-lastarg >actual &&
+	cat >expect <<-\EOF &&
+	found: early-lastarg at 0
+	stopped at: 1 of 1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() stops at short options' '
+	test-tool early-scan-options -s --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() stops at low-level callbacks' '
+	test-tool early-scan-options --low-level --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --ll-value x --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 3
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() stops after what the callback consumed' '
+	test-tool early-scan-options --stop-at-found --wanted --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 0
+	stopped at: 1 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --stop-at-found \
+		--wanted-value x --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted-value at 0 value: x
+	stopped at: 2 of 3
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() reports negated options' '
+	test-tool early-scan-options --no-wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted at 0 unset
+	stopped at: 1 of 1
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --early >actual &&
+	cat >expect <<-\EOF &&
+	found: no-early at 0 unset
+	stopped at: 1 of 1
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --no-early >actual &&
+	cat >expect <<-\EOF &&
+	found: no-early at 0
+	stopped at: 1 of 1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'early_scan_options() does not take a value for negated options' '
+	test-tool early-scan-options --no-wanted-value --wanted >actual &&
+	cat >expect <<-\EOF &&
+	found: wanted-value at 0 unset
+	found: wanted at 1
+	stopped at: 2 of 2
+	EOF
+	test_cmp expect actual &&
+	test-tool early-scan-options --no-wanted-value=x --wanted >actual &&
+	cat >expect <<-\EOF &&
+	stopped at: 0 of 2
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.56.0.116.g6de20f6092

