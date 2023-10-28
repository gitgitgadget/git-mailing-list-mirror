Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFFAB65D
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="R7Kex3J0"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8698FE5
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698493982; x=1699098782; i=l.s.r@web.de;
	bh=ZB/NM6UY+RNDou+YEieD0pazBnbGgF4b6U90Xof2Txk=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=R7Kex3J0P44O41i5JlLYV9BH3qoNU9bKY5PVjuzFIjK6TOz34WfLKOEQbh800U1x
	 yL5eRhtrDKls7mR4kAWl6SfOFh5ioGnwcy5biFIXq1viJTmfwXiT6iUEw5uwXoLwC
	 ORWVaNqyjqZzKZ1c+lcBVkPasgf5ng5eHBwAJSDcZSQnuqrWN8oK3CcM+CVaophB2
	 0xxuUNXZCyDLOAXj5v1dZllihUnca37BSY4I0ZfDTZgvyBD2NKuNM9I+1R66Au81o
	 zQ9WZrvsQzxmyIANRo32NG/IwRu+uhc/cekgZmNn06o1Ls6tjrBK+KYCHKWPLxDhC
	 IMQrI/jU99h5JvRBCA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.209]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsrhK-1rl6fN3rOy-00t6pc; Sat, 28
 Oct 2023 13:53:01 +0200
Message-ID: <cefdba32-db0b-4f68-954e-9d31fc12b1a0@web.de>
Date: Sat, 28 Oct 2023 13:53:01 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] parse-options: make CMDMODE errors more precise
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0AZT+5YN2Kho70mIVd4OAYZ2V5JNq8Sm/VM1876mCIu3nHOCgSN
 pV87upWfpXI+HcrekWCkzqxVtUj8gbcSmCoW/oM55HWutfpCDhgf1LljNM5YPWnAfBzUcgd
 JHNx2TfFs01hqJnuLbyziqtY7hdJPtYG37I1UaCraCxOt1Yilp9EL+6Xqofwi/E8kznyMxP
 r3jzV9kt8dA1WbKrRm+9g==
UI-OutboundReport: notjunk:1;M01:P0:MX5OZpz8RrI=;oKVxAVX/Qrpc2egdUrkz4JF/I7S
 +iFG+c9c1k8zYUsZ52WtMuOP2tK+89B/Q8fvNtwnXSZef2NRTS1PTkXh59wZSq0bO3lP99wsr
 bkZ6w5Ys3jIKi8mFcPo/5zaRCzM8+MWyii2gnDc2Hl1fZq1Kj9v1XuTRyxS5LB3onekV+RAjL
 MEFA0PtOh0LtfvhmIfxlvPV42pTBmoJVLFG0fdiOWwzTmJ2DqAOPi9Lc2b+EuB8+aMeeRsQW7
 yVcfFNJn0KDgzA0gMjbquPEvVJNt0vUY2QvLgQPx0sGrQl9Dihi2k7ZEfwYye9k8MDkH8HjAh
 Fwr7/Xj2/8el+oaS4/FTbHOu6rK/h+BxMuwWO0hbgY4ZJOei/lrgkCnG5VLAmHHmvvmRwUcE0
 4Xf36JV3LBjxf2nY3b/d7b5bUAAI0WBbvrG8pWQ2AryH4MiVUQI5nVjx6cxA2of5W5/Yr74to
 lzjtO/3+tHKlgBzlN+jsh+vzN42onW253MVpSCgKg81nX1wzlXqvk91XtxA618zKq4a0b059v
 FWKFEYeE00Oz166cpaC9RubFd4sQCOpqhtQnkaF52Isxq06rKuVCeB8V0/t7v/ptCv7WUIBQM
 1GlEtLuimjh2u14NL1uZZ4pbnTTroZb3rxobQ5gsuWXg4ssf82yy/ko2H/g5ljy/4oWiaiVHL
 SWjUmo4KvX/MMheZnAbtHxyHaz3kA2YI8fSbBgDlj+wn27PcYWJGUQ8Z9RGJAdx0Uc6ekfR3D
 mw4ttllmjF8PlMBIjCLURPQkCR18aeq2xQk9ctATIun0HEbD9IevlCaEf3HJNVtYeebiCZ2wj
 vuZO2lRVO1IhAnILFIRggyuJUXEKlrZc7sRUif3L2c977b9qka+xoAtJfpbQqFFE50vS62r+O
 aAMEp2tIRDlP7dZvwEcHrYY5Gk0/pfVGqiRjuLSgOTbWNoqiOXgTvFk725m/m8LfmHi/0sqSA
 iCh1lMsxhFrmgMfoiE7b7zbxXoU=

Only a single PARSE_OPT_CMDMODE option can be specified for the same
variable at the same time.  This is enforced by get_value(), but the
error messages are imprecise in three ways:

1. If a non-PARSE_OPT_CMDMODE option changes the value variable of a
PARSE_OPT_CMDMODE option then an ominously vague message is shown:

   $ t/helper/test-tool parse-options --set23 --mode1
   error: option `mode1' : incompatible with something else

Worse: If the order of options is reversed then no error is reported at
all:

   $ t/helper/test-tool parse-options --mode1 --set23
   boolean: 0
   integer: 23
   magnitude: 0
   timestamp: 0
   string: (not set)
   abbrev: 7
   verbose: -1
   quiet: 0
   dry run: no
   file: (not set)

Fortunately this can currently only happen in the test helper; actual
Git commands don't share the same variable for the value of options with
and without the flag PARSE_OPT_CMDMODE.

2. If there are multiple options with the same value (synonyms), then
the one that is defined first is shown rather than the one actually
given on the command line, which is confusing:

   $ git am --resolved --quit
   error: option `quit' is incompatible with --continue

3. Arguments of PARSE_OPT_CMDMODE options are not handled by the
parse-option machinery.  This is left to the callback function.  We
currently only have a single affected option, --show-current-patch of
git am.  Errors for it can show an argument that was not actually given
on the command line:

   $ git am --show-current-patch --show-current-patch=3Ddiff
   error: options '--show-current-patch=3Ddiff' and '--show-current-patch=
=3Draw' cannot be used together

The options --show-current-patch and --show-current-patch=3Draw are
synonyms, but the error accuses the user of input they did not actually
made.  Or it can awkwardly print a NULL pointer:

   $ git am --show-current-patch=3Ddiff --show-current-patch
   error: options '--show-current-patch=3D(null)' and '--show-current-patc=
h=3Ddiff' cannot be used together

The reasons for these shortcomings is that the current code checks
incompatibility only when encountering a PARSE_OPT_CMDMODE option at the
command line, and that it searches the previous incompatible option by
value.

Fix the first two points by checking all PARSE_OPT_CMDMODE variables
after parsing each option and by storing all relevant details if their
value changed.  Do that whether or not the changing options has the flag
PARSE_OPT_CMDMODE set.  Report an incompatibility only if two options
change the variable to different values and at least one of them is a
PARSE_OPT_CMDMODE option.  This changes the output of the first three
examples above to:

   $ t/helper/test-tool parse-options --set23 --mode1
   error: --mode1 is incompatible with --set23
   $ t/helper/test-tool parse-options --mode1 --set23
   error: --set23 is incompatible with --mode1
   $ git am --resolved --quit
   error: --quit is incompatible with --resolved

Store the argument of PARSE_OPT_CMDMODE options of type OPTION_CALLBACK
as well to allow taking over the responsibility for compatibility
checking from the callback function.  The next patch will use this
capability to fix the messages for git am --show-current-patch.

Use a linked list for storing the PARSE_OPT_CMDMODE variables.  This
somewhat outdated data structure is simple and suffices, as the number
of elements per command is currently only zero or one.  We do support
multiple different command modes variables per command, but I don't
expect that we'd ever use a significant number of them.  Once we do we
can switch to a hashmap.

Since we no longer need to search the conflicting option, the all_opts
parameter of get_value() is no longer used.  Remove it.

Extend the tests to check for both conflicting option names, but don't
insist on a particular order.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c               | 144 ++++++++++++++++++++++------------
 parse-options.h               |   3 +
 t/helper/test-parse-options.c |  16 ++++
 t/t0040-parse-options.sh      |  33 ++++++--
 4 files changed, 139 insertions(+), 57 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 093eaf2db8..e0c94b0546 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -70,42 +70,10 @@ static void fix_filename(const char *prefix, char **fi=
le)
 		*file =3D prefix_filename_except_for_dash(prefix, *file);
 }

-static enum parse_opt_result opt_command_mode_error(
-	const struct option *opt,
-	const struct option *all_opts,
-	enum opt_parsed flags)
-{
-	const struct option *that;
-	struct strbuf that_name =3D STRBUF_INIT;
-
-	/*
-	 * Find the other option that was used to set the variable
-	 * already, and report that this is not compatible with it.
-	 */
-	for (that =3D all_opts; that->type !=3D OPTION_END; that++) {
-		if (that =3D=3D opt ||
-		    !(that->flags & PARSE_OPT_CMDMODE) ||
-		    that->value !=3D opt->value ||
-		    that->defval !=3D *(int *)opt->value)
-			continue;
-
-		if (that->long_name)
-			strbuf_addf(&that_name, "--%s", that->long_name);
-		else
-			strbuf_addf(&that_name, "-%c", that->short_name);
-		error(_("%s is incompatible with %s"),
-		      optname(opt, flags), that_name.buf);
-		strbuf_release(&that_name);
-		return PARSE_OPT_ERROR;
-	}
-	return error(_("%s : incompatible with something else"),
-		     optname(opt, flags));
-}
-
-static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
-				       const struct option *opt,
-				       const struct option *all_opts,
-				       enum opt_parsed flags)
+static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
+					  const struct option *opt,
+					  enum opt_parsed flags,
+					  const char **argp)
 {
 	const char *s, *arg;
 	const int unset =3D flags & OPT_UNSET;
@@ -118,14 +86,6 @@ static enum parse_opt_result get_value(struct parse_op=
t_ctx_t *p,
 	if (!(flags & OPT_SHORT) && p->opt && (opt->flags & PARSE_OPT_NOARG))
 		return error(_("%s takes no value"), optname(opt, flags));

-	/*
-	 * Giving the same mode option twice, although unnecessary,
-	 * is not a grave error, so let it pass.
-	 */
-	if ((opt->flags & PARSE_OPT_CMDMODE) &&
-	    *(int *)opt->value && *(int *)opt->value !=3D opt->defval)
-		return opt_command_mode_error(opt, all_opts, flags);
-
 	switch (opt->type) {
 	case OPTION_LOWLEVEL_CALLBACK:
 		return opt->ll_callback(p, opt, NULL, unset);
@@ -200,6 +160,8 @@ static enum parse_opt_result get_value(struct parse_op=
t_ctx_t *p,
 			p_unset =3D 0;
 			p_arg =3D arg;
 		}
+		if (opt->flags & PARSE_OPT_CMDMODE)
+			*argp =3D p_arg;
 		if (opt->callback)
 			return (*opt->callback)(opt, p_arg, p_unset) ? (-1) : 0;
 		else
@@ -247,16 +209,91 @@ static enum parse_opt_result get_value(struct parse_=
opt_ctx_t *p,
 	}
 }

+struct parse_opt_cmdmode_list {
+	int value, *value_ptr;
+	const struct option *opt;
+	const char *arg;
+	enum opt_parsed flags;
+	struct parse_opt_cmdmode_list *next;
+};
+
+static void build_cmdmode_list(struct parse_opt_ctx_t *ctx,
+			       const struct option *opts)
+{
+	ctx->cmdmode_list =3D NULL;
+
+	for (; opts->type !=3D OPTION_END; opts++) {
+		struct parse_opt_cmdmode_list *elem =3D ctx->cmdmode_list;
+		int *value_ptr =3D opts->value;
+
+		if (!(opts->flags & PARSE_OPT_CMDMODE) || !value_ptr)
+			continue;
+
+		while (elem && elem->value_ptr !=3D value_ptr)
+			elem =3D elem->next;
+		if (elem)
+			continue;
+
+		CALLOC_ARRAY(elem, 1);
+		elem->value_ptr =3D value_ptr;
+		elem->value =3D *value_ptr;
+		elem->next =3D ctx->cmdmode_list;
+		ctx->cmdmode_list =3D elem;
+	}
+}
+
+static char *optnamearg(const struct option *opt, const char *arg,
+			enum opt_parsed flags)
+{
+	if (flags & OPT_SHORT)
+		return xstrfmt("-%c%s", opt->short_name, arg ? arg : "");
+	return xstrfmt("--%s%s%s%s", flags & OPT_UNSET ? "no-" : "",
+		       opt->long_name, arg ? "=3D" : "", arg ? arg : "");
+}
+
+static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
+				       const struct option *opt,
+				       enum opt_parsed flags)
+{
+	const char *arg =3D NULL;
+	enum parse_opt_result result =3D do_get_value(p, opt, flags, &arg);
+	struct parse_opt_cmdmode_list *elem =3D p->cmdmode_list;
+	char *opt_name, *other_opt_name;
+
+	for (; elem; elem =3D elem->next) {
+		if (*elem->value_ptr =3D=3D elem->value)
+			continue;
+
+		if (elem->opt &&
+		    (elem->opt->flags | opt->flags) & PARSE_OPT_CMDMODE)
+			break;
+
+		elem->opt =3D opt;
+		elem->arg =3D arg;
+		elem->flags =3D flags;
+		elem->value =3D *elem->value_ptr;
+	}
+
+	if (result || !elem)
+		return result;
+
+	opt_name =3D optnamearg(opt, arg, flags);
+	other_opt_name =3D optnamearg(elem->opt, elem->arg, elem->flags);
+	error(_("%s is incompatible with %s"), opt_name, other_opt_name);
+	free(opt_name);
+	free(other_opt_name);
+	return -1;
+}
+
 static enum parse_opt_result parse_short_opt(struct parse_opt_ctx_t *p,
 					     const struct option *options)
 {
-	const struct option *all_opts =3D options;
 	const struct option *numopt =3D NULL;

 	for (; options->type !=3D OPTION_END; options++) {
 		if (options->short_name =3D=3D *p->opt) {
 			p->opt =3D p->opt[1] ? p->opt + 1 : NULL;
-			return get_value(p, options, all_opts, OPT_SHORT);
+			return get_value(p, options, OPT_SHORT);
 		}

 		/*
@@ -318,7 +355,6 @@ static enum parse_opt_result parse_long_opt(
 	struct parse_opt_ctx_t *p, const char *arg,
 	const struct option *options)
 {
-	const struct option *all_opts =3D options;
 	const char *arg_end =3D strchrnul(arg, '=3D');
 	const struct option *abbrev_option =3D NULL, *ambiguous_option =3D NULL;
 	enum opt_parsed abbrev_flags =3D OPT_LONG, ambiguous_flags =3D OPT_LONG;
@@ -387,7 +423,7 @@ static enum parse_opt_result parse_long_opt(
 				continue;
 			p->opt =3D rest + 1;
 		}
-		return get_value(p, options, all_opts, flags ^ opt_flags);
+		return get_value(p, options, flags ^ opt_flags);
 	}

 	if (disallow_abbreviated_options && (ambiguous_option || abbrev_option))
@@ -405,7 +441,7 @@ static enum parse_opt_result parse_long_opt(
 		return PARSE_OPT_HELP;
 	}
 	if (abbrev_option)
-		return get_value(p, abbrev_option, all_opts, abbrev_flags);
+		return get_value(p, abbrev_option, abbrev_flags);
 	return PARSE_OPT_UNKNOWN;
 }

@@ -413,13 +449,11 @@ static enum parse_opt_result parse_nodash_opt(struct=
 parse_opt_ctx_t *p,
 					      const char *arg,
 					      const struct option *options)
 {
-	const struct option *all_opts =3D options;
-
 	for (; options->type !=3D OPTION_END; options++) {
 		if (!(options->flags & PARSE_OPT_NODASH))
 			continue;
 		if (options->short_name =3D=3D arg[0] && arg[1] =3D=3D '\0')
-			return get_value(p, options, all_opts, OPT_SHORT);
+			return get_value(p, options, OPT_SHORT);
 	}
 	return PARSE_OPT_ERROR;
 }
@@ -574,6 +608,7 @@ static void parse_options_start_1(struct parse_opt_ctx=
_t *ctx,
 	    (flags & PARSE_OPT_KEEP_ARGV0))
 		BUG("Can't keep argv0 if you don't have it");
 	parse_options_check(options);
+	build_cmdmode_list(ctx, options);
 }

 void parse_options_start(struct parse_opt_ctx_t *ctx,
@@ -1006,6 +1041,11 @@ int parse_options(int argc, const char **argv,
 	precompose_argv_prefix(argc, argv, NULL);
 	free_preprocessed_options(real_options);
 	free(ctx.alias_groups);
+	for (struct parse_opt_cmdmode_list *elem =3D ctx.cmdmode_list; elem;) {
+		struct parse_opt_cmdmode_list *next =3D elem->next;
+		free(elem);
+		elem =3D next;
+	}
 	return parse_options_end(&ctx);
 }

diff --git a/parse-options.h b/parse-options.h
index 4a66ec3bf5..bd62e20268 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -445,6 +445,8 @@ static inline void die_for_incompatible_opt3(int opt1,=
 const char *opt1_name,

 /*----- incremental advanced APIs -----*/

+struct parse_opt_cmdmode_list;
+
 /*
  * It's okay for the caller to consume argv/argc in the usual way.
  * Other fields of that structure are private to parse-options and should=
 not
@@ -459,6 +461,7 @@ struct parse_opt_ctx_t {
 	unsigned has_subcommands;
 	const char *prefix;
 	const char **alias_groups; /* must be in groups of 3 elements! */
+	struct parse_opt_cmdmode_list *cmdmode_list;
 };

 void parse_options_start(struct parse_opt_ctx_t *ctx,
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index a4f6e24b0c..ded8116cc5 100644
=2D-- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -21,6 +21,19 @@ static struct {
 	int unset;
 } length_cb;

+static int mode34_callback(const struct option *opt, const char *arg, int=
 unset)
+{
+	if (unset)
+		*(int *)opt->value =3D 0;
+	else if (!strcmp(arg, "3"))
+		*(int *)opt->value =3D 3;
+	else if (!strcmp(arg, "4"))
+		*(int *)opt->value =3D 4;
+	else
+		return error("invalid value for '%s': '%s'", "--mode34", arg);
+	return 0;
+}
+
 static int length_callback(const struct option *opt, const char *arg, int=
 unset)
 {
 	length_cb.called =3D 1;
@@ -124,6 +137,9 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
 		OPT_CMDMODE(0, "mode1", &integer, "set integer to 1 (cmdmode option)", =
1),
 		OPT_CMDMODE(0, "mode2", &integer, "set integer to 2 (cmdmode option)", =
2),
+		OPT_CALLBACK_F(0, "mode34", &integer, "(3|4)",
+			"set integer to 3 or 4 (cmdmode option)",
+			PARSE_OPT_CMDMODE, mode34_callback),
 		OPT_CALLBACK('L', "length", &integer, "str",
 			"get length of <str>", length_callback),
 		OPT_FILENAME('F', "file", &file, "set file to <file>"),
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index a0ad6192d6..06fb9e6457 100755
=2D-- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -28,6 +28,7 @@ usage: test-tool parse-options <options>
     --[no-]set23          set integer to 23
     --mode1               set integer to 1 (cmdmode option)
     --mode2               set integer to 2 (cmdmode option)
+    --[no-]mode34 (3|4)   set integer to 3 or 4 (cmdmode option)
     -L, --[no-]length <str>
                           get length of <str>
     -F, --[no-]file <file>
@@ -366,19 +367,41 @@ test_expect_success 'OPT_NEGBIT() works' '
 '

 test_expect_success 'OPT_CMDMODE() works' '
-	test-tool parse-options --expect=3D"integer: 1" --mode1
+	test-tool parse-options --expect=3D"integer: 1" --mode1 &&
+	test-tool parse-options --expect=3D"integer: 3" --mode34=3D3
 '

-test_expect_success 'OPT_CMDMODE() detects incompatibility' '
+test_expect_success 'OPT_CMDMODE() detects incompatibility (1)' '
 	test_must_fail test-tool parse-options --mode1 --mode2 >output 2>output.=
err &&
 	test_must_be_empty output &&
-	test_i18ngrep "incompatible with --mode" output.err
+	test_i18ngrep "mode1" output.err &&
+	test_i18ngrep "mode2" output.err &&
+	test_i18ngrep "is incompatible with" output.err
 '

-test_expect_success 'OPT_CMDMODE() detects incompatibility with something=
 else' '
+test_expect_success 'OPT_CMDMODE() detects incompatibility (2)' '
 	test_must_fail test-tool parse-options --set23 --mode2 >output 2>output.=
err &&
 	test_must_be_empty output &&
-	test_i18ngrep "incompatible with something else" output.err
+	test_i18ngrep "mode2" output.err &&
+	test_i18ngrep "set23" output.err &&
+	test_i18ngrep "is incompatible with" output.err
+'
+
+test_expect_success 'OPT_CMDMODE() detects incompatibility (3)' '
+	test_must_fail test-tool parse-options --mode2 --set23 >output 2>output.=
err &&
+	test_must_be_empty output &&
+	test_i18ngrep "mode2" output.err &&
+	test_i18ngrep "set23" output.err &&
+	test_i18ngrep "is incompatible with" output.err
+'
+
+test_expect_success 'OPT_CMDMODE() detects incompatibility (4)' '
+	test_must_fail test-tool parse-options --mode2 --mode34=3D3 \
+		>output 2>output.err &&
+	test_must_be_empty output &&
+	test_i18ngrep "mode2" output.err &&
+	test_i18ngrep "mode34.3" output.err &&
+	test_i18ngrep "is incompatible with" output.err
 '

 test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
=2D-
2.42.0
