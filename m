Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C244C64C
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791096; cv=none; b=WCdO9CieCgtG5LYeXe5JJRLTPJWEuUQlKp6fSjV+xm7eBupd81Ilzqp4PXNOmBSPS6IzRvMSeou7TiEFeGM+scl/+VU/e372jDGSACI9AaraubZqPzSwxAJyg4WbpmAxLfwtYoToSkUt8vSD10siTS34wjLTauFOalJLcQd6zjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791096; c=relaxed/simple;
	bh=AVRaJkbJfpBfhmM2jX5uAfw3OKYXumV8gi7g2KjCTb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjeZ9N2NoIr6lQY5GVtjUiNrnwMsXUgVg1vGRQKxQxmoMnmyKialmfvtzZNC4iALhYbWUIJL33EUS0I57cdGJ9UgqT7A2BPdfllYrBV+JdQa3GNS+fDqAb+SErs+5+9ZyNFQZS35R/L3cZK08OJ/5cVJNXHjMp/2KagbxGIDUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kahU1eEJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kahU1eEJ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so1486440f8f.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791791092; x=1792395892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jdREUBiwqV7v0yla+wGV7xrjvqPI4K7uDQmO3hiKW5E=;
        b=kahU1eEJlogmypA6MP6u+W4N9C6mzUPhYzDbEHY6vR2OU7qSIvNJuY4iiSjAodCWXx
         32UMf30ZzNCRZrEo7SPmisbF5PO0teXlhsnZkO8p+PnMVxxu7XjtvvRRwp/OGRaJvnW2
         JZqd1MvAzPIbeESXM0GocvWrCKGBBjYZk4Pp4QWvi28DmKOMFPGWmzvdllOnZcK/bcgZ
         taI19J5/KHI5RwARhRkRHHKcv5xP4ZD+9zXHNTH3RNOI8yoPcwH+cTsvtvl5kQnGxtwX
         PoqbtwIr71nMo9H3idI5VAXeLQJTpP0knyM4GeMK4lJvWhB36UMp3mf69dHwYQxFOjoF
         kwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791791092; x=1792395892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jdREUBiwqV7v0yla+wGV7xrjvqPI4K7uDQmO3hiKW5E=;
        b=RNV9kIhvISnpedNLma1Py2zhOknihf9MXX5CZThKyWkrW/NdKnVvJEGNYLeKyuhZ/o
         WAPRSjAfsTOQKOjUO/qJzyX1eovZj7fLBcga8iSUDrDKeizV8pfl187toMmPAVzxb72i
         4dWCaBq1b9dwewiXyVH62768zLfOxkVGJUh2B9X68zuBEFScVIT8bY3+QEYE9VKSNCPk
         CgYQzIQAeo+Mi2PyiNRrQUTAV59kZfmfIRg17ODfq4rOa2GfkZEoUZ7rW3aBXS2O37CJ
         Id86TEnAo/rzF0SW3gPBrnEaZnEzAu325QSFh2PIXMv+7+ISV+8aBKfknnV+GQoWfNM5
         f3kg==
X-Gm-Message-State: AFq9FYIS9yEtHe/uBxIKYBL1eEDkQsDbFPsn5CeRdVUdVL7iAy48O6nv
	nho/bC5LyhCrVnc3EsUuMDfeSIQW0rwkQVl51+8PEBOMPK2QyemCLCKi9muXOA==
X-Gm-Gg: AYBFou3ooBdo0m+QL4Azv8kW6TRZbCSwqSpuRlb+9jkNOnMRgC7iN1Nvh7h9kcmsFAb
	nwIOpKkRunZ1uKvX6cFxHqR4SNEi19skJbCQ94qMlNyiP8YTATMv5MM6v7M8Klrq5uxPP+HKtWo
	OOhe9yaHzqwKeML97Dg8vFZTiiPz8yQq/5yOhtB8H7yh/rwXlIzzugo7N+nxW6MMYNBJILWXYdj
	3PDxVdVleGdgJo4W2rg8DVsMdxZm+IfHawJorn9cV535cJnYzGyBKUGGHtHcpekNTIzQvWQvJAO
	r0K87mSb5K0RAQMqwyYodZGRj1QBJfH7r4F2zJ5W6ZEYc7SDcEy6U2si5ij7SAt4EX2yEsEKJ86
	EdiH/zyHWvIl5pngPeLtn9UpUBGDijvkq18DblFF7NYCKs7/p4kQ08G04UwrXqwPQqeXt+eOL5L
	EDJ2/b0HL0lp4pXDdBdFvO0HnMj9jlnzrVYtOt5vBysik1Zt2DmPyAu4qnfnBSbAdKXSQxIm2b9
	IKMxiZvw7ko0jJEbmxAnA5hIDJFR53ruZXsl51WLYYbHRZbctNrDqVQvfjDEN8P2ZmkoD2/B6Tv
	M/AP6nyMvWJYOb7+ceKm/r7NXc3lPqJeMVO54BpT32SBRb1BN6IL3h4PgQWaM9OIku8E9m0UHyx
	AFjm1Uavn
X-Received: by 2002:adf:efc3:0:b0:48b:6f3:667f with SMTP id ffacd0b85a97d-48dbacef900mr11882776f8f.56.1791791091401;
        Mon, 12 Oct 2026 00:44:51 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db99b800asm17680723f8f.22.2026.10.12.00.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:44:49 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Standardize early option scanning
Date: Mon, 12 Oct 2026 09:44:09 +0200
Message-ID: <20261012074413.337183-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f6092
In-Reply-To: <20260923080928.1534413-1-christian.couder@gmail.com>
References: <20260923080928.1534413-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A number of commands perform an early scan of their arguments to look
for specific flags or structural separators (like `--`).

These hand-rolled early scans are often fragile. They especially fail
to account for options that take their value as a separate
argument. This leads to disagreements between the early scan and the
actual parse_options() pass. For example, the early scanner might miss
a special option entirely, or mistakenly treat an option's value as
the `--` path separator.

To allow these commands to safely skip option values during their
early scans, this series introduces a new "early-scan" sub-API into
the existing "parse-options" API.

This is deliberately implemented as a new simple and fast scan. A full
'dry run' of parse_options() would have to avoid writing through
`opt->value`, calling callbacks or dying. Instead, the scan reuses
only the long option lookup of parse_options(), and stops when unsure.

This allows negated options ("--no-..."), unambiguous abbreviated
options and aliases to be properly handled. The early scan also agrees
with parse_options() on which options take a value, including those
with PARSE_OPT_OPTARG or PARSE_OPT_LASTARG_DEFAULT.

To never misinterpret an option's value as an option though, it stops
at any argument it cannot reliably skip:

 1. a short option, or a bundle of them,

 2. an unknown option, or an ambiguous or disallowed abbreviation,

 3. an option with a low-level callback, as such a callback may
 consume any number of arguments,

 4. an option with a missing or stuck value that parse_options() would
 reject, like "--no-<name>=<value>".

So the scan may fail to see an option that parse_options() would
accept, but it doesn't report an option that parse_options() would
not, and callers can safely err on the side of not having seen it.

This holds as long as the scan is told how the later parse_options()
call treats its arguments: EARLY_SCAN_STOP_AT_NON_OPTION should be
passed when parse_options() stops at non-options or has subcommands,
and the scan should not be used with PARSE_OPT_KEEP_UNKNOWN_OPT, which
disables abbreviations in parse_options() only.

The early scan is performed by a new early_scan_options() function
which takes a regular `const struct option *option` array as
argument.

This requires that the command already uses `struct option` and the
parse-options API to parse its arguments. As the majority of commands
performing an early scan don't use the parse-options API yet, they
will have to be converted to use it before they can use
early_scan_options().

In this series, only `git fast-import` is converted to the early-scan
API. Its hand-rolled scan disagreed with parse_options() in both
directions:

  - `git fast-import --depth 5 --allow-unsafe-features` silently
    ignored `--allow-unsafe-features`, refusing unsafe features from
    the stream, and so did `--allow-unsafe`, its abbreviation,

  - `git fast-import --quiet --export-pack --allow-unsafe-features`
    and `git fast-import --end-of-options --allow-unsafe-features`
    allowed unsafe features from the stream, while parse_options()
    takes `--allow-unsafe-features` as the value of
    `--export-pack-edges` in the first case, and as a non-option
    argument in the second one.

All these cases now agree with parse_options().

Overview of the patches
=======================

 - Patch 1/4 refactors some existing code into a new
   parse_options_takes_argument() helper that will be used in patch
   3/4.

 - Patch 2/4 is new in this v3. It extracts the long option lookup
   code from parse_long_opt() into a new lookup_long_opt() function,
   so that the function can be reused in the next patch.

 - Patch 3/4 introduces early_scan_options(), the early scanner that
   will be used instead of hand-rolled ones, along with the
   PARSE_OPT_EARLY flag and tests.

 - Patch 4/4 uses early_scan_options() to fix the early scan for
   `--allow-unsafe-features` in `git fast-import`.

Changes since v2
================

Thanks a lot to Junio and Kaartic who reviewed previous versions.

Rebased on top of a018953688 (Git 2.56, 2026-09-27) to start from a
stable base.

There are a number of important changes since v2:

 - In patch 1/4, parse_options_takes_argument() now considers
   PARSE_OPT_LASTARG_DEFAULT options as taking a value. This allows us
   to remove a limitation that was in v2 as these options now consume
   the next argument when there is one, like in parse_options().

 - Patch 2/4 is new, see above.

 - In patch 3/4, we reuse the new lookup_long_opt() function extracted
   by patch 2/4. This removes a number of limitations (around negated
   forms, unambiguous abbreviations and aliases) that were in v2, as
   the early scan now behaves in a similar way as parse_options()
   regarding long options. A number of tests have been added to ensure
   that.

 - In patch 3/4, the scan now stops at short options, unknown options,
   ambiguous or disallowed abbreviations, options with a low-level
   callback, and value-taking options given as the last argument,
   instead of skipping over them, as it could otherwise take an
   option's value for an option.

 - In patch 3/4, early_scan_fn() has a new `unset` argument for
   negated options, and early_scan_options() now returns the index of
   the first argument not consumed also when the callback stops the
   scan.

 - In patch 4/4, the commit message and documentation are updated to
   account for the better behavior of the early scan. A related
   NEEDSWORK comment is also removed, and some tests added.

CI tests:
=========

They all pass, see:

https://github.com/chriscool/git/actions/runs/37965635739

Range-diff since v2
===================

1:  32adff46ce ! 1:  57c48ab0fe parse-options: add parse_options_takes_argument()
    @@ Commit message
         function, and let's use it in show_gitcomp().
     
         Note that an option with PARSE_OPT_LASTARG_DEFAULT only consumes the
    -    next argument when it isn't the last one, so it is not considered as
    -    taking a value, which is what show_gitcomp() already did.
    +    next argument when it isn't the last one. It is considered as taking a
    +    value by parse_options_takes_argument(), as an early scan can easily
    +    check whether there is a next argument, and would otherwise wrongly
    +    take that argument for an option. show_gitcomp() keeps not appending
    +    an '=' to such an option though, as it already did, since its value is
    +    optional.
     
         Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
    @@ parse-options.c: static void show_negated_gitcomp(const struct option *opts, int
     +		return 0;
     +	}
     +
    -+	if (opt->flags & (PARSE_OPT_NOARG | PARSE_OPT_OPTARG |
    -+			  PARSE_OPT_LASTARG_DEFAULT))
    ++	if (opt->flags & (PARSE_OPT_NOARG | PARSE_OPT_OPTARG))
     +		return 0;
     +
     +	return 1;
    @@ parse-options.c: static int show_gitcomp(const struct option *opts, int show_all
     -			suffix = "=";
     -			break;
      		default:
    -+			if (parse_options_takes_argument(opts))
    ++			if (parse_options_takes_argument(opts) &&
    ++			    !(opts->flags & PARSE_OPT_LASTARG_DEFAULT))
     +				suffix = "=";
      			break;
      		}
    @@ parse-options.h: int parse_options(int argc, const char **argv, const char *pref
     + * Return non-zero if `opt` takes a value, which means that it consumes
     + * the next argument when that value is not stuck to it with an '='.
     + *
    -+ * Note that an option with PARSE_OPT_LASTARG_DEFAULT only consumes the
    -+ * next argument when it isn't the last one, so it is not considered as
    -+ * taking a value here.
    ++ * Note that an option with PARSE_OPT_LASTARG_DEFAULT is considered as
    ++ * taking a value here, even though it only consumes the next argument
    ++ * when it isn't the last one. Callers that care have to check for that
    ++ * flag themselves.
     + */
     +int parse_options_takes_argument(const struct option *opt);
     +
-:  ---------- > 2:  38243ce8bf parse-options: extract lookup_long_opt() from parse_long_opt()
2:  82569fa602 ! 3:  c36cae4e44 parse-options: add early_scan_options()
    @@ Commit message
     
         Let's add early_scan_options() to help with this. It walks the
         arguments using the very same `struct option` array that the command
    -    already passes to parse_options(), and uses the
    -    parse_options_takes_argument() helper added in a previous commit, so
    -    that the scan and the actual parsing agree on which options take a
    -    value.
    +    already passes to parse_options(). It looks up long options with the
    +    lookup_long_opt() helper extracted from parse_long_opt() in a previous
    +    commit, so that negated forms, unambiguous abbreviations and aliases
    +    are recognized the same way, and it uses the
    +    parse_options_takes_argument() helper added in another previous
    +    commit, so that the scan and the actual parsing agree on which options
    +    take a value.
     
         The options the caller wants to be told about are marked with a new
         PARSE_OPT_EARLY flag, so that nothing has to be spelled out a second
    @@ Commit message
         the commands converted now would keep both their option array and their
         PARSE_OPT_EARLY marks, so their conversion would not have to be redone.
     
    -    One consequence of staying simple is that abbreviated options are
    -    still not matched, even though the scan is now given the command's
    -    full option array. Resolving them the way parse_options() does would
    -    mean duplicating the ambiguity detection that parse_long_opt()
    -    performs. So the scan can fail to see an option that parse_options()
    -    would accept, and its callers have to cope with that, typically by
    -    erring on the safe side. This and the other differences with
    -    parse_options() are documented in "parse-options.h".
    +    One consequence of staying simple is that the scan doesn't try to
    +    handle what it cannot reliably skip, like short options, unknown
    +    options, ambiguous abbreviations or options with a low-level callback,
    +    which may consume any number of arguments. It stops at them instead,
    +    so that it never takes an option's value for an option. This matters,
    +    as for example with:
    +
    +      git fast-import --quiet --export-pack --allow-unsafe-features
    +
    +    parse_options() takes `--allow-unsafe-features` as the value of
    +    `--export-pack-edges`, which `--export-pack` abbreviates. A scan that
    +    just skipped `--export-pack` as an unknown option would wrongly see
    +    `--allow-unsafe-features` there.
    +
    +    So the scan can fail to see an option that parse_options() would
    +    accept, but it doesn't report an option that parse_options() would
    +    not, and its callers can safely err on the side of not having seen an
    +    option. The differences with parse_options() are documented in
    +    "parse-options.h".
     
         In practice, despite these limitations, early scans using
         early_scan_options() should still be safer and cleaner than the
    @@ Commit message
         about option values at all and therefore disagree with
         parse_options() in ways that create plain bugs.
     
    +    Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
         Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## Documentation/technical/api-parse-options.adoc ##
    @@ parse-options.c: int parse_options(int argc, const char **argv,
      }
      
     +/*
    -+ * Look for `arg` among `option`. On success, return the matching option
    -+ * and set `value` to the value stuck to it, if any, or to NULL.
    ++ * Look for `name`, a long option without its leading "--", among
    ++ * `option`, the way parse_options() would. Return true if it names an
    ++ * option exactly, or as an unambiguous abbreviation that is not
    ++ * disallowed, with `found` set to that option and its flags, and
    ++ * `stuck` to the value stuck to it, if any, or to NULL.
    ++ */
    ++static bool find_early_scan_option(struct parse_opt_ctx_t *p,
    ++				   const char *name,
    ++				   const struct option *option,
    ++				   bool disallow_abbrev,
    ++				   struct parsed_option *found,
    ++				   const char **stuck)
    ++{
    ++	struct parsed_option other;
    ++	enum long_opt_lookup result = lookup_long_opt(p, name, option,
    ++						      found, &other, stuck);
    ++
    ++	switch (result) {
    ++	case LONG_OPT_EXACT:
    ++		return true;
    ++	case LONG_OPT_ABBREV:
    ++		return !disallow_abbrev;
    ++	case LONG_OPT_AMBIGUOUS:
    ++	case LONG_OPT_UNKNOWN:
    ++		return false;
    ++	}
    ++
    ++	BUG("unknown enum long_opt_lookup value '%d'", result);
    ++}
    ++
    ++struct early_scan_state {
    ++	struct parse_opt_ctx_t ctx;
    ++	const struct option *option;
    ++	enum early_scan_flags flags;
    ++	early_scan_fn *fn;
    ++	void *data;
    ++	bool disallow_abbrev;
    ++};
    ++
    ++/*
    ++ * Look at argv[*i]. Return 'true' to go on scanning, with *i on the
    ++ * last argument consumed. Return 'false' to stop, with *i set to the
    ++ * first argument not consumed.
     + */
    -+static const struct option *find_early_scan_option(const char *arg,
    -+						   const struct option *option,
    -+						   const char **value)
    ++static bool early_scan_one_option(struct early_scan_state *s,
    ++				  int argc, const char **argv, int *i)
     +{
    -+	if (!skip_prefix(arg, "--", &arg))
    -+		return NULL;
    -+
    -+	for (const struct option *opt = option; opt->type != OPTION_END; opt++) {
    -+		const char *rest;
    -+
    -+		if (opt->type == OPTION_SUBCOMMAND)
    -+			continue;
    -+		if (!opt->long_name)
    -+			continue;
    -+		if (!skip_prefix(arg, opt->long_name, &rest))
    -+			continue;
    -+
    -+		if (!*rest) {
    -+			*value = NULL;
    -+			return opt;
    -+		}
    -+		/* Only an option that can take a value may have one stuck to it. */
    -+		if (*rest == '=' && !(opt->flags & PARSE_OPT_NOARG)) {
    -+			*value = rest + 1;
    -+			return opt;
    -+		}
    ++	const char *name;
    ++	const char *value;
    ++	struct parsed_option found;
    ++	bool unset;
    ++	int pos = *i;
    ++	const char *arg = argv[pos];
    ++
    ++	/*
    ++	 * parse_options() always stops parsing options at these,
    ++	 * whatever its flags, so nothing after them is an option.
    ++	 */
    ++	if (!strcmp(arg, "--") || !strcmp(arg, "--end-of-options"))
    ++		return false;
    ++
    ++	/* non-option */
    ++	if (*arg != '-' || !arg[1])
    ++		return !(s->flags & EARLY_SCAN_STOP_AT_NON_OPTION);
    ++
    ++	/* short option */
    ++	if (!skip_prefix(arg, "--", &name))
    ++		return false;
    ++
    ++	/* unknown, ambiguous or disallowed abbreviation */
    ++	if (!find_early_scan_option(&s->ctx, name, s->option,
    ++				    s->disallow_abbrev, &found, &value))
    ++		return false;
    ++
    ++	/* A low-level callback may consume any number of arguments. */
    ++	if (found.option->ll_callback)
    ++		return false;
    ++
    ++	unset = !!(found.flags & OPT_UNSET);
    ++
    ++	/* parse_options() rejects these, so don't go further. */
    ++	if (value && (unset || (found.option->flags & PARSE_OPT_NOARG)))
    ++		return false;
    ++
    ++	/*
    ++	 * Like get_arg(), take the next argument as the value when it is
    ++	 * not stuck to the option. When there is no next argument,
    ++	 * parse_options() uses the default value of an option with
    ++	 * PARSE_OPT_LASTARG_DEFAULT, but errors out for other options.
    ++	 */
    ++	if (!value && !unset && parse_options_takes_argument(found.option)) {
    ++		if (pos + 1 < argc)
    ++			value = argv[++*i];
    ++		else if (!(found.option->flags & PARSE_OPT_LASTARG_DEFAULT))
    ++			return false;
    ++	}
    ++
    ++	if ((found.option->flags & PARSE_OPT_EARLY) &&
    ++	    s->fn(found.option, value, unset, pos, s->data)) {
    ++		/* the option, and its value if any, have been consumed */
    ++		++*i;
    ++		return false;
     +	}
     +
    -+	return NULL;
    ++	return true;
     +}
     +
     +int early_scan_options(int argc, const char **argv,
    @@ parse-options.c: int parse_options(int argc, const char **argv,
     +		       enum early_scan_flags flags,
     +		       early_scan_fn *fn, void *data)
     +{
    -+	for (int i = 0; i < argc; i++) {
    -+		const char *arg = argv[i];
    -+		const char *value;
    -+		const struct option *opt;
    -+		int pos = i;
    -+
    -+		/*
    -+		 * parse_options() always stops parsing options at these,
    -+		 * whatever its flags, so nothing after them is an option.
    -+		 */
    -+		if (!strcmp(arg, "--") || !strcmp(arg, "--end-of-options"))
    -+			return i;
    -+
    -+		opt = find_early_scan_option(arg, option, &value);
    -+		if (!opt) {
    -+			if ((flags & EARLY_SCAN_STOP_AT_NON_OPTION) &&
    -+			    (*arg != '-' || !arg[1]))
    -+				return i;
    -+			continue;
    -+		}
    -+
    -+		/*
    -+		 * When an option takes a value, but that value is not
    -+		 * stuck to it with '=', then the next argument is the
    -+		 * value and it has to be skipped so that it isn't
    -+		 * taken for an option itself.
    -+		 */
    -+		if (parse_options_takes_argument(opt) && !value && i + 1 < argc)
    -+			value = argv[++i];
    -+
    -+		if (opt->flags & PARSE_OPT_EARLY && fn(opt, value, pos, data))
    -+			return i;
    -+	}
    ++	struct early_scan_state s = {
    ++		.flags = flags,
    ++		.fn = fn,
    ++		.data = data,
    ++		.disallow_abbrev =
    ++			git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0),
    ++	};
    ++	struct option *real_option = preprocess_options(&s.ctx, option);
    ++	int i;
    ++
    ++	s.option = real_option ? real_option : option;
    ++
    ++	for (i = 0; i < argc; i++)
    ++		if (!early_scan_one_option(&s, argc, argv, &i))
    ++			break;
     +
    -+	return argc;
    ++	free_preprocessed_options(real_option);
    ++	free(s.ctx.alias_groups);
    ++	return i;
     +}
     +
      static int usage_argh(const struct option *opts, FILE *outfile)
    @@ parse-options.h: static inline void die_for_incompatible_opt2(int opt1, const ch
     + * Called by early_scan_options() for each argument matching a
     + * `struct option` with PARSE_OPT_EARLY set.
     + *
    -+ * `option` is the matching option, `value` its value or NULL if it
    -+ * doesn't take one, and `pos` the index of the option in argv.
    ++ * - `option` is the matching option,
    ++ * - `value` its value, or NULL if it doesn't take one or if its value
    ++ *   is optional and wasn't given, as with PARSE_OPT_OPTARG, or with
    ++ *   PARSE_OPT_LASTARG_DEFAULT when the option is the last argument,
    ++ * - `unset` is 'true' for the negated form of the option (like
    ++ *   for parse_opt_cb()), in which case `value` is always NULL, and
    ++ * - `pos` the index of the option in argv.
     + *
    -+ * Returning a non-zero value stops the scan.
    ++ * Returning a non-zero value stops the scan right after the option and
    ++ * its value, if any.
     + */
     +typedef int early_scan_fn(const struct option *option, const char *value,
    -+			  int pos, void *data);
    ++			  bool unset, int pos, void *data);
     +
     +enum early_scan_flags {
     +	EARLY_SCAN_STOP_AT_NON_OPTION = 1 << 0, /* Stop at any non option */
    @@ parse-options.h: static inline void die_for_incompatible_opt2(int opt1, const ch
     + * flags. PARSE_OPT_KEEP_DASHDASH and PARSE_OPT_KEEP_UNKNOWN_OPT only
     + * decide if the terminator is left in argv, not if it terminates.
     + *
    -+ * Returns the index at which the scan stopped, which is `argc` when the
    -+ * whole array was scanned.
    ++ * Returns the index of the first argument not consumed by the scan,
    ++ * which is `argc` when the whole array was scanned.
    ++ *
    ++ * Long options are looked up the same way as parse_options() does,
    ++ * so their negated forms, their unambiguous abbreviations, unless
    ++ * GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS is set, and the OPTION_ALIAS
    ++ * entries standing for them are all recognized, and their value is
    ++ * skipped when they take one.
    ++ *
    ++ * To never misinterpret an option value as an option though, the scan
    ++ * stops at any argument it cannot reliably skip, that is:
     + *
    -+ * This scan is for now deliberately much simpler than
    -+ * parse_options(), so it differs from it in the following ways:
    ++ *  - a short option, or a bundle of them,
     + *
    -+ *  - Only the long form of an option is matched, and it has to be
    -+ *    spelled in full: short options and abbreviations are ignored.
    ++ *  - an unknown option, or an ambiguous or disallowed abbreviation,
     + *
    -+ *  - Negated forms ("--no-<name>") are not matched. This is harmless,
    -+ *    as they never take a value to skip.
    ++ *  - an option with a low-level callback, as such a callback may
    ++ *    consume any number of arguments,
     + *
    -+ *  - Options with PARSE_OPT_OPTARG or PARSE_OPT_LASTARG_DEFAULT are
    -+ *    treated as not taking a separate value.
    ++ *  - an option with a value stuck to it that parse_options() would
    ++ *    reject, like a negated option or a PARSE_OPT_NOARG one,
     + *
    -+ *  - OPTION_SUBCOMMAND entries are skipped.
    ++ *  - an option requiring a value when it is the last argument, which
    ++ *    parse_options() would also reject.
     + *
    -+ *  - OPTION_ALIAS entries are not resolved to the option they stand
    -+ *    for.
    ++ * In all these cases, the scan can fail to see an option that
    ++ * parse_options() would accept, but it doesn't report an option that
    ++ * parse_options() would not, so that callers err on the safe side.
     + *
    -+ * So the scan can fail to see an option that parse_options() would
    -+ * accept, and callers have to cope with that, typically by erring on
    -+ * the safe side.
    ++ * This requires the scan to be told about the way the later
    ++ * parse_options() call treats its arguments though: callers should
    ++ * pass EARLY_SCAN_STOP_AT_NON_OPTION when parse_options() is called
    ++ * with PARSE_OPT_STOP_AT_NON_OPTION or with subcommands, and should
    ++ * not use the scan when parse_options() is called with
    ++ * PARSE_OPT_KEEP_UNKNOWN_OPT, which disables abbreviations there but
    ++ * not here.
     + */
     +int early_scan_options(int argc, const char **argv,
     +		       const struct option *option,
    @@ t/helper/test-parse-options.c: int cmd__parse_subcommand(int argc, const char **
      	return parse_subcommand__cmd(argc, argv, test_flags);
      }
     +
    ++static enum parse_opt_result early_ll_callback(struct parse_opt_ctx_t *ctx UNUSED,
    ++					       const struct option *opt UNUSED,
    ++					       const char *arg UNUSED,
    ++					       int unset UNUSED)
    ++{
    ++	return 0;
    ++}
    ++
     +static int show_early_option(const struct option *opt, const char *value,
    -+			     int pos, void *data UNUSED)
    ++			     bool unset, int pos, void *data)
     +{
    ++	int *stop_at_found = data;
    ++
     +	printf("found: %s at %d", opt->long_name, pos);
    ++	if (unset)
    ++		printf(" unset");
     +	if (value)
     +		printf(" value: %s", value);
     +	putchar('\n');
    -+	return 0;
    ++	return *stop_at_found;
     +}
     +
     +int cmd__early_scan_options(int argc, const char **argv)
    @@ t/helper/test-parse-options.c: int cmd__parse_subcommand(int argc, const char **
     +			     PARSE_OPT_EARLY),
     +		OPT_STRING(0, "skipped-value", &a_string, "str",
     +			   "option whose value has to be skipped"),
    ++		OPT_ALIAS(0, "alias-of-skipped", "skipped-value"),
     +		OPT_INTEGER(0, "number", &an_int,
     +			    "option taking an integer value"),
     +		OPT_STRING_F(0, "optarg", &a_string, "str",
    @@ t/helper/test-parse-options.c: int cmd__parse_subcommand(int argc, const char **
     +		OPT_STRING_F(0, "early-lastarg", &a_string, "str",
     +			     "early option with a last argument default",
     +			     PARSE_OPT_EARLY | PARSE_OPT_LASTARG_DEFAULT),
    ++		OPT_BOOL_F(0, "no-early", &a_bool,
    ++			   "early option whose name starts with 'no-'",
    ++			   PARSE_OPT_EARLY),
     +		OPT_BOOL('s', NULL, &a_short, "short only option"),
    ++		{
    ++			.type = OPTION_LOWLEVEL_CALLBACK,
    ++			.long_name = "low-level",
    ++			.help = "option with a low-level callback",
    ++			.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG,
    ++			.ll_callback = early_ll_callback,
    ++		},
    ++		{
    ++			.type = OPTION_CALLBACK,
    ++			.long_name = "ll-value",
    ++			.argh = "str",
    ++			.help = "option with a value and a low-level callback",
    ++			.flags = PARSE_OPT_NONEG,
    ++			.ll_callback = early_ll_callback,
    ++		},
     +		OPT_END()
     +	};
     +
     +	enum early_scan_flags flags = 0;
    ++	int stop_at_found = 0;
     +	int stopped;
     +
     +	while (argc > 1 && *argv[1] == '-') {
     +		if (!strcmp(argv[1], "--stop-at-non-option"))
     +			flags |= EARLY_SCAN_STOP_AT_NON_OPTION;
    ++		else if (!strcmp(argv[1], "--stop-at-found"))
    ++			stop_at_found = 1;
     +		else
     +			break;
     +		argc--;
    @@ t/helper/test-parse-options.c: int cmd__parse_subcommand(int argc, const char **
     +	}
     +
     +	stopped = early_scan_options(argc - 1, argv + 1, option, flags,
    -+				     show_early_option, NULL);
    ++				     show_early_option, &stop_at_found);
     +	printf("stopped at: %d of %d\n", stopped, argc - 1);
     +
     +	return 0;
    @@ t/t0040-parse-options.sh: test_expect_success 'u16 limits range' '
     +	found: wanted at 2
     +	stopped at: 3 of 3
     +	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --number --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 2 of 2
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() stops at a last option missing its value' '
    ++	test-tool early-scan-options --wanted-value >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 0 of 1
    ++	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --wanted --skipped-value >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: wanted at 0
    ++	stopped at: 1 of 2
    ++	EOF
     +	test_cmp expect actual
     +'
     +
    @@ t/t0040-parse-options.sh: test_expect_success 'u16 limits range' '
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'early_scan_options() ignores abbreviated options' '
    -+	test-tool early-scan-options --want >actual &&
    ++test_expect_success 'early_scan_options() matches unambiguous abbreviations' '
    ++	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    ++	test-tool early-scan-options --wanted-v=x >actual &&
     +	cat >expect <<-\EOF &&
    ++	found: wanted-value at 0 value: x
     +	stopped at: 1 of 1
     +	EOF
    ++	test_cmp expect actual &&
    ++	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    ++	test-tool early-scan-options --wanted-v x --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: wanted-value at 0 value: x
    ++	found: wanted at 2
    ++	stopped at: 3 of 3
    ++	EOF
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'early_scan_options() takes values from struct option' '
    -+	test-tool early-scan-options --number --wanted >actual &&
    ++test_expect_success 'early_scan_options() skips the value of an abbreviation' '
    ++	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    ++	test-tool early-scan-options --skipped --wanted >actual &&
     +	cat >expect <<-\EOF &&
     +	stopped at: 2 of 2
     +	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() stops at an ambiguous abbreviation' '
    ++	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    ++	test-tool early-scan-options --want --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 0 of 2
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() stops at disallowed abbreviations' '
    ++	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
    ++	test-tool early-scan-options --wanted-v=x >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 0 of 1
    ++	EOF
     +	test_cmp expect actual &&
    -+	test-tool early-scan-options --number=5 --wanted >actual &&
    ++	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
    ++	test-tool early-scan-options --skipped --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 0 of 2
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() stops at an unknown option' '
    ++	test-tool early-scan-options --bogus --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 0 of 2
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() resolves aliases' '
    ++	test-tool early-scan-options --alias-of-skipped --wanted >actual &&
     +	cat >expect <<-\EOF &&
    -+	found: wanted at 1
     +	stopped at: 2 of 2
     +	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --alias-of-skipped x --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: wanted at 2
    ++	stopped at: 3 of 3
    ++	EOF
     +	test_cmp expect actual
     +'
     +
    @@ t/t0040-parse-options.sh: test_expect_success 'u16 limits range' '
     +	stopped at: 2 of 2
     +	EOF
     +	test_cmp expect actual &&
    -+	test-tool early-scan-options --lastarg --wanted >actual &&
    ++	test-tool early-scan-options --optarg=5 --wanted >actual &&
     +	cat >expect <<-\EOF &&
     +	found: wanted at 1
     +	stopped at: 2 of 2
    @@ t/t0040-parse-options.sh: test_expect_success 'u16 limits range' '
     +	test_cmp expect actual
     +'
     +
    ++test_expect_success 'early_scan_options() skips a last argument default value' '
    ++	test-tool early-scan-options --lastarg --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 2 of 2
    ++	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --wanted --lastarg >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: wanted at 0
    ++	stopped at: 2 of 2
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
     +test_expect_success 'early_scan_options() matches a stuck optional value' '
     +	test-tool early-scan-options --early-optarg=one >actual &&
     +	cat >expect <<-\EOF &&
    @@ t/t0040-parse-options.sh: test_expect_success 'u16 limits range' '
     +	found: wanted at 1
     +	stopped at: 2 of 2
     +	EOF
    -+	test_cmp expect actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() takes a last argument default value' '
     +	test-tool early-scan-options --early-lastarg --wanted >actual &&
     +	cat >expect <<-\EOF &&
    -+	found: early-lastarg at 0
    -+	found: wanted at 1
    ++	found: early-lastarg at 0 value: --wanted
     +	stopped at: 2 of 2
     +	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --early-lastarg >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: early-lastarg at 0
    ++	stopped at: 1 of 1
    ++	EOF
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'early_scan_options() ignores options without a long name' '
    ++test_expect_success 'early_scan_options() stops at short options' '
     +	test-tool early-scan-options -s --wanted >actual &&
     +	cat >expect <<-\EOF &&
    -+	found: wanted at 1
    -+	stopped at: 2 of 2
    ++	stopped at: 0 of 2
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() stops at low-level callbacks' '
    ++	test-tool early-scan-options --low-level --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 0 of 2
    ++	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --ll-value x --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 0 of 3
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() stops after what the callback consumed' '
    ++	test-tool early-scan-options --stop-at-found --wanted --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: wanted at 0
    ++	stopped at: 1 of 2
    ++	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --stop-at-found \
    ++		--wanted-value x --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: wanted-value at 0 value: x
    ++	stopped at: 2 of 3
     +	EOF
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'early_scan_options() ignores negated options' '
    ++test_expect_success 'early_scan_options() reports negated options' '
     +	test-tool early-scan-options --no-wanted >actual &&
     +	cat >expect <<-\EOF &&
    ++	found: wanted at 0 unset
     +	stopped at: 1 of 1
     +	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --early >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: no-early at 0 unset
    ++	stopped at: 1 of 1
    ++	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --no-early >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: no-early at 0
    ++	stopped at: 1 of 1
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'early_scan_options() does not take a value for negated options' '
    ++	test-tool early-scan-options --no-wanted-value --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	found: wanted-value at 0 unset
    ++	found: wanted at 1
    ++	stopped at: 2 of 2
    ++	EOF
    ++	test_cmp expect actual &&
    ++	test-tool early-scan-options --no-wanted-value=x --wanted >actual &&
    ++	cat >expect <<-\EOF &&
    ++	stopped at: 0 of 2
    ++	EOF
     +	test_cmp expect actual
     +'
     +
3:  8e5092d421 ! 4:  515f13df83 fast-import: use early_scan_options() for --allow-unsafe-features
    @@ Commit message
         `--allow-unsafe-features` with PARSE_OPT_EARLY so that the scan
         reports it.
     
    -    Note that the scan still only matches the exact option spelling, while
    -    parse_options() also accepts unambiguous abbreviations, so the two still
    -    disagree for a command line like "--allow-unsafe". This errs on the safe
    -    side, and is now documented as a restriction.
    +    As early_scan_options() looks up long options the same way as
    +    parse_options(), the two also agree on abbreviations now. So
    +    `--allow-unsafe` allows unsafe "feature" commands, while
    +    "--quiet --export-pack --allow-unsafe-features" refuses them, as
    +    parse_options() takes `--allow-unsafe-features` there as the value of
    +    `--export-pack-edges`. (The old scan wrongly allowed them in this
    +    case, as all the arguments start with a dash.)
     
    +    The note about having to spell the option in full in the
    +    documentation is therefore removed, and so is the NEEDSWORK comment
    +    about it.
    +
    +    Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
         Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## Documentation/git-fast-import.adoc ##
    -@@ Documentation/git-fast-import.adoc: fast-import stream! This option is enabled automatically for
    +@@ Documentation/git-fast-import.adoc: Only enable this option if you trust the program generating the
    + fast-import stream! This option is enabled automatically for
      remote-helpers that use the `import` capability, as they are
      already trusted to run their own code.
    - +
    +-+
     -Note that this option has to be spelled in full, and has to appear
     -before any option whose value is separated from it by a space, for
     -the unsafe `feature` commands in the stream to be allowed. So
     -`--allow-unsafe` or `--depth 5 --allow-unsafe-features` still refuse
     -them, while `--allow-unsafe-features --depth 5` and
     -`--depth=5 --allow-unsafe-features` allow them.
    -+Note that this option has to be spelled in full for the unsafe
    -+`feature` commands in the stream to be allowed. So `--allow-unsafe`
    -+is accepted as an unambiguous abbreviation of this option, but the
    -+unsafe `feature` commands are still refused.
      
      `--signed-tags=<mode>`::
      	Specify how to handle signed tags. Behaves in the same way as
    @@ builtin/fast-import.c: static int option_parse_quiet(const struct option *opt UN
      
     +static int option_parse_early_allow_unsafe(const struct option *option,
     +					   const char *value UNUSED,
    -+					   int pos UNUSED, void *data)
    ++					   bool unset, int pos UNUSED,
    ++					   void *data)
     +{
     +	struct fast_import_state *state = data;
     +
     +	if (!strcmp(option->long_name, "allow-unsafe-features"))
    -+		state->allow_unsafe_features = 1;
    ++		state->allow_unsafe_features = !unset;
     +	return 0;
     +}
     +
    @@ builtin/fast-import.c: int cmd_fast_import(int argc,
     -	 * this scan doesn't see it, so unsafe features from the stream are
     -	 * still refused. This errs on the safe side, but should be fixed by
     -	 * teaching this scan about the options that take a value.
    -+	 * NEEDSWORK: This scan only matches the exact
    -+	 * "--allow-unsafe-features" spelling, while parse_options() below
    -+	 * also accepts unambiguous abbreviations, so the two disagree for
    -+	 * a command line like "--allow-unsafe": parse_options() accepts
    -+	 * the option, but this scan doesn't see it, so unsafe features
    -+	 * from the stream are still refused. This errs on the safe side.
    ++	 * The scan uses the same options as parse_options() below, so the
    ++	 * two agree on which options take a value and on abbreviations. In
    ++	 * case of doubt, the scan stops early, so unsafe features are then
    ++	 * refused rather than wrongly allowed.
      	 */
     -	for (int i = 1; i < argc; i++) {
     -		const char *arg = argv[i];
    @@ t/t9300-fast-import.sh: test_expect_success 'R: export-marks options can be over
     +	git fast-import --date-format raw --allow-unsafe-features <input
     +'
     +
    -+test_expect_success 'R: --allow-unsafe-features has to be spelled in full' '
    ++test_expect_success 'R: --allow-unsafe-features can be abbreviated' '
    ++	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    ++	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    ++	git fast-import --allow-unsafe <input
    ++'
    ++
    ++test_expect_success 'R: disallowed abbreviation of --allow-unsafe-features' '
    ++	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    ++	test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
    ++		git fast-import --allow-unsafe <input 2>err &&
    ++	test_grep "forbidden in input without --allow-unsafe-features" err
    ++'
    ++
    ++test_expect_success 'R: --allow-unsafe-features as the value of an abbreviation' '
     +	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
    -+	test_must_fail git fast-import --allow-unsafe <input 2>err &&
    ++	test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
    ++		git fast-import --quiet --export-pack \
    ++		--allow-unsafe-features <input 2>err &&
     +	test_grep "forbidden in input without --allow-unsafe-features" err
     +'
     +

Christian Couder (4):
  parse-options: add parse_options_takes_argument()
  parse-options: extract lookup_long_opt() from parse_long_opt()
  parse-options: add early_scan_options()
  fast-import: use early_scan_options() for --allow-unsafe-features

 Documentation/git-fast-import.adoc            |   7 -
 .../technical/api-parse-options.adoc          |   5 +
 builtin/fast-import.c                         |  37 +-
 parse-options.c                               | 278 +++++++++++++--
 parse-options.h                               | 102 ++++++
 t/helper/test-parse-options.c                 |  96 ++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t0040-parse-options.sh                      | 321 ++++++++++++++++++
 t/t9300-fast-import.sh                        |  29 ++
 10 files changed, 816 insertions(+), 61 deletions(-)


base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.56.0.116.g6de20f6092

