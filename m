Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CD4C32772
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352788AbiHSQcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353103AbiHSQah (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF5109A3D
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e21so1362813edc.7
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=llEufo6BWiDVrARDpOKAkn4H1UBQDHJCSULJkhFwyjA=;
        b=kVqP9Fy4ODqT09MYAcYX/jGj285HT9xFiEp6VySbCZBVTpVKk4Qh56BgtqDxl+id8s
         PhuLsczDkM4jii20TKPZAPDJZnWqSBlUbyzZDHn3uFWb28lbVNQxYK3c6PjeenUQe7L0
         STGQjUK5HzYOonpOjyWfYHNlVXIre2yK5fMAlVu+3FJ8mDzxladnUE446vA2pDUoqSNr
         YH2bjAYZsZovN84cpeR55ZSEJsioR4QacMqqpbpXtGkmc7AHx0ZYLkKR5joKKXO1Gmxs
         SmL6y+lYEwFoRxvP/XLip2M4iVGLP4mWQCWWQmVF5Mcg+58BrODWDb4yod6p5gNJt/jm
         JooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=llEufo6BWiDVrARDpOKAkn4H1UBQDHJCSULJkhFwyjA=;
        b=iTZv3Jxb93edwG/toDsuPiYE2XCqg5tKw5X+D4CmAOoQ4+MfqsZok2kHbOINTR3Um9
         FR9btr0ZmMVPXMu5dkki7g+m8hyEuT6GsIQE/F8DMKiaX5X4OcVt5V/ks456xZGYjgtW
         +NGKJr/wCT0VZeQFLGxqZUL3EbAk6/NP3DQlo1fSchI/JWquFpQ1mptsqHr7yPm3mwZd
         LeIbzL7s1tKNJoTG/QzG6GcGRlnYGcD/ZnffFl6PyhjI9/kob1J7BbDKrAt11B1txRC/
         k6lTo03iNa9th/AHEs6/blQFFh3bg3nmHZ8Tw7Y6sHBc22OlMXXvD6o5h2jwrFT5syYm
         AWZg==
X-Gm-Message-State: ACgBeo2gai8kP6IOEnw73S8r4S42t4WCww7mD8NNTUVl5tA9/dgRLk8N
        nrVLH4ptUHGNIQMV+smQnmoWZK4NJTM=
X-Google-Smtp-Source: AA6agR5TohQvPDRV0GN5GowofHBj7yYBxn6PIyz9AMZGU86jowczcwBwIZVPMzKlIAwcEn5mBBL6VQ==
X-Received: by 2002:a05:6402:2753:b0:43a:d6f2:9839 with SMTP id z19-20020a056402275300b0043ad6f29839mr6412836edd.73.1660925089345;
        Fri, 19 Aug 2022 09:04:49 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090631cc00b0073c1e339a37sm2182771ejf.149.2022.08.19.09.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:48 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 09/20] parse-options: add support for parsing subcommands
Date:   Fri, 19 Aug 2022 18:04:00 +0200
Message-Id: <20220819160411.1791200-10-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several Git commands have subcommands to implement mutually exclusive
"operation modes", and they usually parse their subcommand argument
with a bunch of if-else if statements.

Teach parse-options to handle subcommands as well, which will result
in shorter and simpler code with consistent error handling and error
messages on unknown or missing subcommand, and it will also make
possible for our Bash completion script to handle subcommands
programmatically.

The approach is guided by the following observations:

  - Most subcommands [1] are implemented in dedicated functions, and
    most of those functions [2] either have a signature matching the
    'int cmd_foo(int argc, const char **argc, const char *prefix)'
    signature of builtin commands or can be trivially converted to
    that signature, because they miss only that last prefix parameter
    or have no parameters at all.

  - Subcommand arguments only have long form, and they have no double
    dash prefix, no negated form, and no description, and they don't
    take any arguments, and can't be abbreviated.

  - There must be exactly one subcommand among the arguments, or zero
    if the command has a default operation mode.

  - All arguments following the subcommand are considered to be
    arguments of the subcommand, and, conversely, arguments meant for
    the subcommand may not preceed the subcommand.

So in the end subcommand declaration and parsing would look something
like this:

    parse_opt_subcommand_fn *fn = NULL;
    struct option builtin_commit_graph_options[] = {
        OPT_STRING(0, "object-dir", &opts.obj_dir, N_("dir"),
                   N_("the object directory to store the graph")),
        OPT_SUBCOMMAND("verify", &fn, graph_verify),
        OPT_SUBCOMMAND("write", &fn, graph_write),
        OPT_END(),
    };
    argc = parse_options(argc, argv, prefix, options,
                         builtin_commit_graph_usage, 0);
    return fn(argc, argv, prefix);

Here each OPT_SUBCOMMAND specifies the name of the subcommand and the
function implementing it, and the address of the same 'fn' subcommand
function pointer.  parse_options() then processes the arguments until
it finds the first argument matching one of the subcommands, sets 'fn'
to the function associated with that subcommand, and returns, leaving
the rest of the arguments unprocessed.  If none of the listed
subcommands is found among the arguments, parse_options() will show
usage and abort.

If a command has a default operation mode, 'fn' should be initialized
to the function implementing that mode, and parse_options() should be
invoked with the PARSE_OPT_SUBCOMMAND_OPTIONAL flag.  In this case
parse_options() won't error out when not finding any subcommands, but
will return leaving 'fn' unchanged.  Note that if that default
operation mode has any --options, then the PARSE_OPT_KEEP_UNKNOWN_OPT
flag is necessary as well (otherwise parse_options() would error out
upon seeing the unknown option meant to the default operation mode).

Some thoughts about the implementation:

  - The same pointer to 'fn' must be specified as 'value' for each
    OPT_SUBCOMMAND, because there can be only one set of mutually
    exclusive subcommands; parse_options() will BUG() otherwise.

    There are other ways to tell parse_options() where to put the
    function associated with the subcommand given on the command line,
    but I didn't like them:

      - Change parse_options()'s signature by adding a pointer to
        subcommand function to be set to the function associated with
        the given subcommand, affecting all callsites, even those that
        don't have subcommands.

      - Introduce a specific parse_options_and_subcommand() variant
        with that extra funcion parameter.

  - I decided against automatically calling the subcommand function
    from within parse_options(), because:

      - There are commands that have to perform additional actions
        after option parsing but before calling the function
        implementing the specified subcommand.

      - The return code of the subcommand is usually the return code
        of the git command, but preserving the return code of the
        automatically called subcommand function would have made the
        API awkward.

  - Also add a OPT_SUBCOMMAND_F() variant to allow specifying an
    option flag: we have two subcommands that are purposefully
    excluded from completion ('git remote rm' and 'git stash save'),
    so they'll have to be specified with the PARSE_OPT_NOCOMPLETE
    flag.

  - Some of the 'parse_opt_flags' don't make sense with subcommands,
    and using them is probably just an oversight or misunderstanding.
    Therefore parse_options() will BUG() when invoked with any of the
    following flags while the options array contains at least one
    OPT_SUBCOMMAND:

      - PARSE_OPT_KEEP_DASHDASH: parse_options() stops parsing
        arguments when encountering a "--" argument, so it doesn't
        make sense to expect and keep one before a subcommand, because
        it would prevent the parsing of the subcommand.

        However, this flag is allowed in combination with the
        PARSE_OPT_SUBCOMMAND_OPTIONAL flag, because the double dash
        might be meaningful for the command's default operation mode,
        e.g. to disambiguate refs and pathspecs.

      - PARSE_OPT_STOP_AT_NON_OPTION: As its name suggests, this flag
        tells parse_options() to stop as soon as it encouners a
        non-option argument, but subcommands are by definition not
        options...  so how could they be parsed, then?!

      - PARSE_OPT_KEEP_UNKNOWN: This flag can be used to collect any
        unknown --options and then pass them to a different command or
        subsystem.  Surely if a command has subcommands, then this
        functionality should rather be delegated to one of those
        subcommands, and not performed by the command itself.

        However, this flag is allowed in combination with the
        PARSE_OPT_SUBCOMMAND_OPTIONAL flag, making possible to pass
        --options to the default operation mode.

  - If the command with subcommands has a default operation mode, then
    all arguments to the command must preceed the arguments of the
    subcommand.

    AFAICT we don't have any commands where this makes a difference,
    because in those commands either only the command accepts any
    arguments ('notes' and 'remote'), or only the default subcommand
    ('reflog' and 'stash'), but never both.

  - The 'argv' array passed to subcommand functions currently starts
    with the name of the subcommand.  Keep this behavior.  AFAICT no
    subcommand functions depend on the actual content of 'argv[0]',
    but the parse_options() call handling their options expects that
    the options start at argv[1].

  - To support handling subcommands programmatically in our Bash
    completion script, 'git cmd --git-completion-helper' will now list
    both subcommands and regular --options, if any.  This means that
    the completion script will have to separate subcommands (i.e.
    words without a double dash prefix) from --options on its own, but
    that's rather easy to do, and it's not much work either, because
    the number of subcommands a command might have is rather low, and
    those commands accept only a single --option or none at all.  An
    alternative would be to introduce a separate option that lists
    only subcommands, but then the completion script would need not
    one but two git invocations and command substitutions for commands
    with subcommands.

    Note that this change doesn't affect the behavior of our Bash
    completion script, because when completing the --option of a
    command with subcommands, e.g. for 'git notes --<TAB>', then all
    subcommands will be filtered out anyway, as none of them will
    match the word to be completed starting with that double dash
    prefix.

[1] Except 'git rerere', because many of its subcommands are
    implemented in the bodies of the if-else if statements parsing the
    command's subcommand argument.

[2] Except 'credential', 'credential-store' and 'fsmonitor--daemon',
    because some of the functions implementing their subcommands take
    special parameters.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/technical/api-parse-options.txt |  41 +++-
 builtin/blame.c                               |   1 +
 builtin/shortlog.c                            |   1 +
 parse-options.c                               | 113 ++++++++++-
 parse-options.h                               |  24 ++-
 t/helper/test-parse-options.c                 |  61 ++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t0040-parse-options.sh                      | 185 ++++++++++++++++++
 9 files changed, 419 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 4412377fa3..c2a5e42914 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -8,7 +8,8 @@ Basics
 ------
 
 The argument vector `argv[]` may usually contain mandatory or optional
-'non-option arguments', e.g. a filename or a branch, and 'options'.
+'non-option arguments', e.g. a filename or a branch, 'options', and
+'subcommands'.
 Options are optional arguments that start with a dash and
 that allow to change the behavior of a command.
 
@@ -48,6 +49,33 @@ The parse-options API allows:
   option, e.g. `-a -b --option -- --this-is-a-file` indicates that
   `--this-is-a-file` must not be processed as an option.
 
+Subcommands are special in a couple of ways:
+
+* Subcommands only have long form, and they have no double dash prefix, no
+  negated form, and no description, and they don't take any arguments, and
+  can't be abbreviated.
+
+* There must be exactly one subcommand among the arguments, or zero if the
+  command has a default operation mode.
+
+* All arguments following the subcommand are considered to be arguments of
+  the subcommand, and, conversely, arguments meant for the subcommand may
+  not preceed the subcommand.
+
+Therefore, if the options array contains at least one subcommand and
+`parse_options()` encounters the first dashless argument, it will either:
+
+* stop and return, if that dashless argument is a known subcommand, setting
+  `value` to the function pointer associated with that subcommand, storing
+  the name of the subcommand in argv[0], and leaving the rest of the
+  arguments unprocessed, or
+
+* stop and return, if it was invoked with the `PARSE_OPT_SUBCOMMAND_OPTIONAL`
+  flag and that dashless argument doesn't match any subcommands, leaving
+  `value` unchanged and the rest of the arguments unprocessed, or
+
+* show error and usage, and abort.
+
 Steps to parse options
 ----------------------
 
@@ -110,6 +138,13 @@ Flags are the bitwise-or of:
 	turns it off and allows one to add custom handlers for these
 	options, or to just leave them unknown.
 
+`PARSE_OPT_SUBCOMMAND_OPTIONAL`::
+	Don't error out when no subcommand is specified.
+
+Note that `PARSE_OPT_STOP_AT_NON_OPTION` is incompatible with subcommands;
+while `PARSE_OPT_KEEP_DASHDASH` and `PARSE_OPT_KEEP_UNKNOWN_OPT` can only be
+used with subcommands when combined with `PARSE_OPT_SUBCOMMAND_OPTIONAL`.
+
 Data Structure
 --------------
 
@@ -241,7 +276,11 @@ There are some macros to easily define options:
 	can be given by the user. `int_var` is set to `enum_val` when the
 	option is used, but an error is reported if other "operating mode"
 	option has already set its value to the same `int_var`.
+	In new commands consider using subcommands instead.
 
+`OPT_SUBCOMMAND(long, &fn_ptr, subcommand_fn)`::
+	Define a subcommand.  `subcommand_fn` is put into `fn_ptr` when
+	this subcommand is used.
 
 The last element of the array must be `OPT_END()`.
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 02e39420b6..a9fe8cf7a6 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -920,6 +920,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			break;
 		case PARSE_OPT_HELP:
 		case PARSE_OPT_ERROR:
+		case PARSE_OPT_SUBCOMMAND:
 			exit(129);
 		case PARSE_OPT_COMPLETE:
 			exit(0);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 086dfee45a..7a1e1fe7c0 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -381,6 +381,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			break;
 		case PARSE_OPT_HELP:
 		case PARSE_OPT_ERROR:
+		case PARSE_OPT_SUBCOMMAND:
 			exit(129);
 		case PARSE_OPT_COMPLETE:
 			exit(0);
diff --git a/parse-options.c b/parse-options.c
index 8748f88e6f..a1ec932f0f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -324,6 +324,8 @@ static enum parse_opt_result parse_long_opt(
 		const char *rest, *long_name = options->long_name;
 		enum opt_parsed flags = OPT_LONG, opt_flags = OPT_LONG;
 
+		if (options->type == OPTION_SUBCOMMAND)
+			continue;
 		if (!long_name)
 			continue;
 
@@ -419,6 +421,19 @@ static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *p,
 	return PARSE_OPT_ERROR;
 }
 
+static enum parse_opt_result parse_subcommand(const char *arg,
+					      const struct option *options)
+{
+	for (; options->type != OPTION_END; options++)
+		if (options->type == OPTION_SUBCOMMAND &&
+		    !strcmp(options->long_name, arg)) {
+			*(parse_opt_subcommand_fn **)options->value = options->subcommand_fn;
+			return PARSE_OPT_SUBCOMMAND;
+		}
+
+	return PARSE_OPT_UNKNOWN;
+}
+
 static void check_typos(const char *arg, const struct option *options)
 {
 	if (strlen(arg) < 3)
@@ -442,6 +457,7 @@ static void check_typos(const char *arg, const struct option *options)
 static void parse_options_check(const struct option *opts)
 {
 	char short_opts[128];
+	void *subcommand_value = NULL;
 
 	memset(short_opts, '\0', sizeof(short_opts));
 	for (; opts->type != OPTION_END; opts++) {
@@ -489,6 +505,14 @@ static void parse_options_check(const struct option *opts)
 			       "Are you using parse_options_step() directly?\n"
 			       "That case is not supported yet.");
 			break;
+		case OPTION_SUBCOMMAND:
+			if (!opts->value || !opts->subcommand_fn)
+				optbug(opts, "OPTION_SUBCOMMAND needs a value and a subcommand function");
+			if (!subcommand_value)
+				subcommand_value = opts->value;
+			else if (subcommand_value != opts->value)
+				optbug(opts, "all OPTION_SUBCOMMANDs need the same value");
+			break;
 		default:
 			; /* ok. (usually accepts an argument) */
 		}
@@ -499,6 +523,14 @@ static void parse_options_check(const struct option *opts)
 	BUG_if_bug("invalid 'struct option'");
 }
 
+static int has_subcommands(const struct option *options)
+{
+	for (; options->type != OPTION_END; options++)
+		if (options->type == OPTION_SUBCOMMAND)
+			return 1;
+	return 0;
+}
+
 static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
 				  int argc, const char **argv, const char *prefix,
 				  const struct option *options,
@@ -515,6 +547,19 @@ static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
 	ctx->prefix = prefix;
 	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
 	ctx->flags = flags;
+	ctx->has_subcommands = has_subcommands(options);
+	if (!ctx->has_subcommands && (flags & PARSE_OPT_SUBCOMMAND_OPTIONAL))
+		BUG("Using PARSE_OPT_SUBCOMMAND_OPTIONAL without subcommands");
+	if (ctx->has_subcommands) {
+		if (flags & PARSE_OPT_STOP_AT_NON_OPTION)
+			BUG("subcommands are incompatible with PARSE_OPT_STOP_AT_NON_OPTION");
+		if (!(flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)) {
+			if (flags & PARSE_OPT_KEEP_UNKNOWN_OPT)
+				BUG("subcommands are incompatible with PARSE_OPT_KEEP_UNKNOWN_OPT unless in combination with PARSE_OPT_SUBCOMMAND_OPTIONAL");
+			if (flags & PARSE_OPT_KEEP_DASHDASH)
+				BUG("subcommands are incompatible with PARSE_OPT_KEEP_DASHDASH unless in combination with PARSE_OPT_SUBCOMMAND_OPTIONAL");
+		}
+	}
 	if ((flags & PARSE_OPT_KEEP_UNKNOWN_OPT) &&
 	    (flags & PARSE_OPT_STOP_AT_NON_OPTION) &&
 	    !(flags & PARSE_OPT_ONE_SHOT))
@@ -589,6 +634,7 @@ static int show_gitcomp(const struct option *opts, int show_all)
 	int nr_noopts = 0;
 
 	for (; opts->type != OPTION_END; opts++) {
+		const char *prefix = "--";
 		const char *suffix = "";
 
 		if (!opts->long_name)
@@ -598,6 +644,9 @@ static int show_gitcomp(const struct option *opts, int show_all)
 			continue;
 
 		switch (opts->type) {
+		case OPTION_SUBCOMMAND:
+			prefix = "";
+			break;
 		case OPTION_GROUP:
 			continue;
 		case OPTION_STRING:
@@ -620,8 +669,8 @@ static int show_gitcomp(const struct option *opts, int show_all)
 			suffix = "=";
 		if (starts_with(opts->long_name, "no-"))
 			nr_noopts++;
-		printf("%s--%s%s", opts == original_opts ? "" : " ",
-		       opts->long_name, suffix);
+		printf("%s%s%s%s", opts == original_opts ? "" : " ",
+		       prefix, opts->long_name, suffix);
 	}
 	show_negated_gitcomp(original_opts, show_all, -1);
 	show_negated_gitcomp(original_opts, show_all, nr_noopts);
@@ -744,10 +793,38 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (*arg != '-' || !arg[1]) {
 			if (parse_nodash_opt(ctx, arg, options) == 0)
 				continue;
-			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
-				return PARSE_OPT_NON_OPTION;
-			ctx->out[ctx->cpidx++] = ctx->argv[0];
-			continue;
+			if (!ctx->has_subcommands) {
+				if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
+					return PARSE_OPT_NON_OPTION;
+				ctx->out[ctx->cpidx++] = ctx->argv[0];
+				continue;
+			}
+			switch (parse_subcommand(arg, options)) {
+			case PARSE_OPT_SUBCOMMAND:
+				return PARSE_OPT_SUBCOMMAND;
+			case PARSE_OPT_UNKNOWN:
+				if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
+					/*
+					 * arg is neither a short or long
+					 * option nor a subcommand.  Since
+					 * this command has a default
+					 * operation mode, we have to treat
+					 * this arg and all remaining args
+					 * as args meant to that default
+					 * operation mode.
+					 * So we are done parsing.
+					 */
+					return PARSE_OPT_DONE;
+				error(_("unknown subcommand: `%s'"), arg);
+				usage_with_options(usagestr, options);
+			case PARSE_OPT_COMPLETE:
+			case PARSE_OPT_HELP:
+			case PARSE_OPT_ERROR:
+			case PARSE_OPT_DONE:
+			case PARSE_OPT_NON_OPTION:
+				/* Impossible. */
+				BUG("parse_subcommand() cannot return these");
+			}
 		}
 
 		/* lone -h asks for help */
@@ -775,6 +852,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 					goto show_usage;
 				goto unknown;
 			case PARSE_OPT_NON_OPTION:
+			case PARSE_OPT_SUBCOMMAND:
 			case PARSE_OPT_HELP:
 			case PARSE_OPT_COMPLETE:
 				BUG("parse_short_opt() cannot return these");
@@ -800,6 +878,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 					*(char *)ctx->argv[0] = '-';
 					goto unknown;
 				case PARSE_OPT_NON_OPTION:
+				case PARSE_OPT_SUBCOMMAND:
 				case PARSE_OPT_COMPLETE:
 				case PARSE_OPT_HELP:
 					BUG("parse_short_opt() cannot return these");
@@ -831,6 +910,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 		case PARSE_OPT_HELP:
 			goto show_usage;
 		case PARSE_OPT_NON_OPTION:
+		case PARSE_OPT_SUBCOMMAND:
 		case PARSE_OPT_COMPLETE:
 			BUG("parse_long_opt() cannot return these");
 		case PARSE_OPT_DONE:
@@ -840,6 +920,18 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 unknown:
 		if (ctx->flags & PARSE_OPT_ONE_SHOT)
 			break;
+		if (ctx->has_subcommands &&
+		    (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL) &&
+		    (ctx->flags & PARSE_OPT_KEEP_UNKNOWN_OPT)) {
+			/*
+			 * Found an unknown option given to a command with
+			 * subcommands that has a default operation mode:
+			 * we treat this option and all remaining args as
+			 * arguments meant to that default operation mode.
+			 * So we are done parsing.
+			 */
+			return PARSE_OPT_DONE;
+		}
 		if (!(ctx->flags & PARSE_OPT_KEEP_UNKNOWN_OPT))
 			return PARSE_OPT_UNKNOWN;
 		ctx->out[ctx->cpidx++] = ctx->argv[0];
@@ -885,7 +977,14 @@ int parse_options(int argc, const char **argv,
 	case PARSE_OPT_COMPLETE:
 		exit(0);
 	case PARSE_OPT_NON_OPTION:
+	case PARSE_OPT_SUBCOMMAND:
+		break;
 	case PARSE_OPT_DONE:
+		if (ctx.has_subcommands &&
+		    !(flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)) {
+			error(_("need a subcommand"));
+			usage_with_options(usagestr, options);
+		}
 		break;
 	case PARSE_OPT_UNKNOWN:
 		if (ctx.argv[0][1] == '-') {
@@ -1010,6 +1109,8 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 		size_t pos;
 		int pad;
 
+		if (opts->type == OPTION_SUBCOMMAND)
+			continue;
 		if (opts->type == OPTION_GROUP) {
 			fputc('\n', outfile);
 			need_newline = 0;
diff --git a/parse-options.h b/parse-options.h
index 8cbfc7e8bf..b6ef86e0d1 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -11,6 +11,7 @@ enum parse_opt_type {
 	OPTION_GROUP,
 	OPTION_NUMBER,
 	OPTION_ALIAS,
+	OPTION_SUBCOMMAND,
 	/* options with no arguments */
 	OPTION_BIT,
 	OPTION_NEGBIT,
@@ -34,6 +35,7 @@ enum parse_opt_flags {
 	PARSE_OPT_NO_INTERNAL_HELP = 1 << 4,
 	PARSE_OPT_ONE_SHOT = 1 << 5,
 	PARSE_OPT_SHELL_EVAL = 1 << 6,
+	PARSE_OPT_SUBCOMMAND_OPTIONAL = 1 << 7,
 };
 
 enum parse_opt_option_flags {
@@ -56,6 +58,7 @@ enum parse_opt_result {
 	PARSE_OPT_ERROR = -1,	/* must be the same as error() */
 	PARSE_OPT_DONE = 0,	/* fixed so that "return 0" works */
 	PARSE_OPT_NON_OPTION,
+	PARSE_OPT_SUBCOMMAND,
 	PARSE_OPT_UNKNOWN
 };
 
@@ -67,6 +70,9 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
 					      const struct option *opt,
 					      const char *arg, int unset);
 
+typedef int parse_opt_subcommand_fn(int argc, const char **argv,
+				    const char *prefix);
+
 /*
  * `type`::
  *   holds the type of the option, you must have an OPTION_END last in your
@@ -76,7 +82,8 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *   the character to use as a short option name, '\0' if none.
  *
  * `long_name`::
- *   the long option name, without the leading dashes, NULL if none.
+ *   the long option (without the leading dashes) or subcommand name,
+ *   NULL if none.
  *
  * `value`::
  *   stores pointers to the values to be filled.
@@ -93,7 +100,7 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *
  * `help`::
  *   the short help associated to what the option does.
- *   Must never be NULL (except for OPTION_END).
+ *   Must never be NULL (except for OPTION_END and OPTION_SUBCOMMAND).
  *   OPTION_GROUP uses this pointer to store the group header.
  *   Should be wrapped by N_() for translation.
  *
@@ -131,6 +138,9 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  * `ll_callback`::
  *   pointer to the callback to use for OPTION_LOWLEVEL_CALLBACK
  *
+ * `subcommand_fn`::
+ *   pointer to a function to use for OPTION_SUBCOMMAND.
+ *   It will be put in value when the subcommand is given on the command line.
  */
 struct option {
 	enum parse_opt_type type;
@@ -145,6 +155,7 @@ struct option {
 	intptr_t defval;
 	parse_opt_ll_cb *ll_callback;
 	intptr_t extra;
+	parse_opt_subcommand_fn *subcommand_fn;
 };
 
 #define OPT_BIT_F(s, l, v, h, b, f) { OPTION_BIT, (s), (l), (v), NULL, (h), \
@@ -206,6 +217,14 @@ struct option {
 #define OPT_ALIAS(s, l, source_long_name) \
 	{ OPTION_ALIAS, (s), (l), (source_long_name) }
 
+#define OPT_SUBCOMMAND_F(l, v, fn, f) { \
+	.type = OPTION_SUBCOMMAND, \
+	.long_name = (l), \
+	.value = (v), \
+	.flags = (f), \
+	.subcommand_fn = (fn) }
+#define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
+
 /*
  * parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[]. argv0 is assumed program name and
@@ -295,6 +314,7 @@ struct parse_opt_ctx_t {
 	int argc, cpidx, total;
 	const char *opt;
 	enum parse_opt_flags flags;
+	unsigned has_subcommands;
 	const char *prefix;
 	const char **alias_groups; /* must be in groups of 3 elements! */
 	struct option *updated_options;
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 99ad6fa4f0..aa0ad45851 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -238,6 +238,9 @@ static const struct option test_flag_options[] = {
 	OPT_BIT(0, "no-internal-help", &test_flags,
 		"pass PARSE_OPT_NO_INTERNAL_HELP to parse_options()",
 		PARSE_OPT_NO_INTERNAL_HELP),
+	OPT_BIT(0, "subcommand-optional", &test_flags,
+		"pass PARSE_OPT_SUBCOMMAND_OPTIONAL to parse_options()",
+		PARSE_OPT_SUBCOMMAND_OPTIONAL),
 	OPT_END()
 };
 
@@ -258,3 +261,61 @@ int cmd__parse_options_flags(int argc, const char **argv)
 
 	return parse_options_flags__cmd(argc, argv, test_flags);
 }
+
+static int subcmd_one(int argc, const char **argv, const char *prefix)
+{
+	printf("fn: subcmd_one\n");
+	print_args(argc, argv);
+	return 0;
+}
+
+static int subcmd_two(int argc, const char **argv, const char *prefix)
+{
+	printf("fn: subcmd_two\n");
+	print_args(argc, argv);
+	return 0;
+}
+
+static int parse_subcommand__cmd(int argc, const char **argv,
+				 enum parse_opt_flags test_flags)
+{
+	const char *usage[] = {
+		"<...> cmd subcmd-one",
+		"<...> cmd subcmd-two",
+		NULL
+	};
+	parse_opt_subcommand_fn *fn = NULL;
+	int opt = 0;
+	struct option options[] = {
+		OPT_SUBCOMMAND("subcmd-one", &fn, subcmd_one),
+		OPT_SUBCOMMAND("subcmd-two", &fn, subcmd_two),
+		OPT_INTEGER('o', "opt", &opt, "an integer option"),
+		OPT_END()
+	};
+
+	if (test_flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
+		fn = subcmd_one;
+	argc = parse_options(argc, argv, NULL, options, usage, test_flags);
+
+	printf("opt: %d\n", opt);
+
+	return fn(argc, argv, NULL);
+}
+
+int cmd__parse_subcommand(int argc, const char **argv)
+{
+	const char *usage[] = {
+		"test-tool parse-subcommand [flag-options] cmd <subcommand>",
+		NULL
+	};
+
+	argc = parse_options(argc, argv, NULL, test_flag_options, usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc == 0 || strcmp(argv[0], "cmd")) {
+		error("'cmd' is mandatory");
+		usage_with_options(usage, test_flag_options);
+	}
+
+	return parse_subcommand__cmd(argc, argv, test_flags);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 6e62282b60..49b30057f6 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -53,6 +53,7 @@ static struct test_cmd cmds[] = {
 	{ "parse-options", cmd__parse_options },
 	{ "parse-options-flags", cmd__parse_options_flags },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
+	{ "parse-subcommand", cmd__parse_subcommand },
 	{ "partial-clone", cmd__partial_clone },
 	{ "path-utils", cmd__path_utils },
 	{ "pcre2-config", cmd__pcre2_config },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index d8e8403d70..487d84da60 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -43,6 +43,7 @@ int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_options_flags(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
+int cmd__parse_subcommand(int argc, const char **argv);
 int cmd__partial_clone(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__pcre2_config(int argc, const char **argv);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 264b737309..b19b8d3486 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -526,4 +526,189 @@ test_expect_success 'KEEP_UNKNOWN_OPT | NO_INTERNAL_HELP works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'subcommand - no subcommand shows error and usage' '
+	test_expect_code 129 test-tool parse-subcommand cmd 2>err &&
+	grep "^error: need a subcommand" err &&
+	grep ^usage: err
+'
+
+test_expect_success 'subcommand - subcommand after -- shows error and usage' '
+	test_expect_code 129 test-tool parse-subcommand cmd -- subcmd-one 2>err &&
+	grep "^error: need a subcommand" err &&
+	grep ^usage: err
+'
+
+test_expect_success 'subcommand - subcommand after --end-of-options shows error and usage' '
+	test_expect_code 129 test-tool parse-subcommand cmd --end-of-options subcmd-one 2>err &&
+	grep "^error: need a subcommand" err &&
+	grep ^usage: err
+'
+
+test_expect_success 'subcommand - unknown subcommand shows error and usage' '
+	test_expect_code 129 test-tool parse-subcommand cmd nope 2>err &&
+	grep "^error: unknown subcommand: \`nope$SQ" err &&
+	grep ^usage: err
+'
+
+test_expect_success 'subcommand - subcommands cannot be abbreviated' '
+	test_expect_code 129 test-tool parse-subcommand cmd subcmd-o 2>err &&
+	grep "^error: unknown subcommand: \`subcmd-o$SQ$" err &&
+	grep ^usage: err
+'
+
+test_expect_success 'subcommand - no negated subcommands' '
+	test_expect_code 129 test-tool parse-subcommand cmd no-subcmd-one 2>err &&
+	grep "^error: unknown subcommand: \`no-subcmd-one$SQ" err &&
+	grep ^usage: err
+'
+
+test_expect_success 'subcommand - simple' '
+	test-tool parse-subcommand cmd subcmd-two >actual &&
+	cat >expect <<-\EOF &&
+	opt: 0
+	fn: subcmd_two
+	arg 00: subcmd-two
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'subcommand - stop parsing at the first subcommand' '
+	test-tool parse-subcommand cmd --opt=1 subcmd-two subcmd-one --opt=2 >actual &&
+	cat >expect <<-\EOF &&
+	opt: 1
+	fn: subcmd_two
+	arg 00: subcmd-two
+	arg 01: subcmd-one
+	arg 02: --opt=2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'subcommand - KEEP_ARGV0' '
+	test-tool parse-subcommand --keep-argv0 cmd subcmd-two >actual &&
+	cat >expect <<-\EOF &&
+	opt: 0
+	fn: subcmd_two
+	arg 00: cmd
+	arg 01: subcmd-two
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'subcommand - SUBCOMMAND_OPTIONAL + subcommand not given' '
+	test-tool parse-subcommand --subcommand-optional cmd >actual &&
+	cat >expect <<-\EOF &&
+	opt: 0
+	fn: subcmd_one
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'subcommand - SUBCOMMAND_OPTIONAL + given subcommand' '
+	test-tool parse-subcommand --subcommand-optional cmd subcmd-two branch file >actual &&
+	cat >expect <<-\EOF &&
+	opt: 0
+	fn: subcmd_two
+	arg 00: subcmd-two
+	arg 01: branch
+	arg 02: file
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'subcommand - SUBCOMMAND_OPTIONAL + subcommand not given + unknown dashless args' '
+	test-tool parse-subcommand --subcommand-optional cmd branch file >actual &&
+	cat >expect <<-\EOF &&
+	opt: 0
+	fn: subcmd_one
+	arg 00: branch
+	arg 01: file
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'subcommand - SUBCOMMAND_OPTIONAL + subcommand not given + unknown option' '
+	test_expect_code 129 test-tool parse-subcommand --subcommand-optional cmd --subcommand-opt 2>err &&
+	grep "^error: unknown option" err &&
+	grep ^usage: err
+'
+
+test_expect_success 'subcommand - SUBCOMMAND_OPTIONAL | KEEP_UNKNOWN_OPT + subcommand not given + unknown option' '
+	test-tool parse-subcommand --subcommand-optional --keep-unknown-opt cmd --subcommand-opt >actual &&
+	cat >expect <<-\EOF &&
+	opt: 0
+	fn: subcmd_one
+	arg 00: --subcommand-opt
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'subcommand - SUBCOMMAND_OPTIONAL | KEEP_UNKNOWN_OPT + subcommand ignored after unknown option' '
+	test-tool parse-subcommand --subcommand-optional --keep-unknown-opt cmd --subcommand-opt subcmd-two >actual &&
+	cat >expect <<-\EOF &&
+	opt: 0
+	fn: subcmd_one
+	arg 00: --subcommand-opt
+	arg 01: subcmd-two
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'subcommand - SUBCOMMAND_OPTIONAL | KEEP_UNKNOWN_OPT + command and subcommand options cannot be mixed' '
+	test-tool parse-subcommand --subcommand-optional --keep-unknown-opt cmd --subcommand-opt branch --opt=1 >actual &&
+	cat >expect <<-\EOF &&
+	opt: 0
+	fn: subcmd_one
+	arg 00: --subcommand-opt
+	arg 01: branch
+	arg 02: --opt=1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'subcommand - SUBCOMMAND_OPTIONAL | KEEP_UNKNOWN_OPT | KEEP_ARGV0' '
+	test-tool parse-subcommand --subcommand-optional --keep-unknown-opt --keep-argv0 cmd --subcommand-opt branch >actual &&
+	cat >expect <<-\EOF &&
+	opt: 0
+	fn: subcmd_one
+	arg 00: cmd
+	arg 01: --subcommand-opt
+	arg 02: branch
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'subcommand - SUBCOMMAND_OPTIONAL | KEEP_UNKNOWN_OPT | KEEP_DASHDASH' '
+	test-tool parse-subcommand --subcommand-optional --keep-unknown-opt --keep-dashdash cmd -- --subcommand-opt file >actual &&
+	cat >expect <<-\EOF &&
+	opt: 0
+	fn: subcmd_one
+	arg 00: --
+	arg 01: --subcommand-opt
+	arg 02: file
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'subcommand - completion helper' '
+	test-tool parse-subcommand cmd --git-completion-helper >actual &&
+	echo "subcmd-one subcmd-two --opt= --no-opt" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'subcommands are incompatible with STOP_AT_NON_OPTION' '
+	test_must_fail test-tool parse-subcommand --stop-at-non-option cmd subcmd-one 2>err &&
+	grep ^BUG err
+'
+
+test_expect_success 'subcommands are incompatible with KEEP_UNKNOWN_OPT unless in combination with SUBCOMMAND_OPTIONAL' '
+	test_must_fail test-tool parse-subcommand --keep-unknown-opt cmd subcmd-two 2>err &&
+	grep ^BUG err
+'
+
+test_expect_success 'subcommands are incompatible with KEEP_DASHDASH unless in combination with SUBCOMMAND_OPTIONAL' '
+	test_must_fail test-tool parse-subcommand --keep-dashdash cmd subcmd-two 2>err &&
+	grep ^BUG err
+'
+
 test_done
-- 
2.37.2.817.g36f84ce71d

