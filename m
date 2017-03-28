Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F95D1FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 13:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932189AbdC1NON (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 09:14:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32926 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932608AbdC1NOH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 09:14:07 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18so3156137wrc.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :references:content-transfer-encoding;
        bh=UOcvalMshnNGp6LfUyyRkuQfXP+B9c/80VCBjahNzng=;
        b=ttULHh7U0yfPQHcYF4UVUOmzMwIrkAvOms1wt16qf6xmUHhZfv1/E98i2kDFMwaqhB
         YxK5Fl4zko8eouGCwnC7dSVJQndK5D4F7P5xUa2e1V+VI311s6KIu6S9hsUZv7Hao7ec
         GW1eYE3Zu+FY3RzDTM6eW5schGBV3E3oGWNg77D6VRBB3uxQNSghtVtb/XrVXm5aQgri
         aIhpfZPnqLIQEWu10iN37sbLuUEuRfI41Xc0zchBdWYWN9D357giC3jBK4AjDlVJ2mpN
         lvUcMyKLrCQuiPFNWuTR0Ra9JAopHFIz2/dkGxJN10ga3mgsdGbMveUkivBArhi72ED+
         VFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:references:content-transfer-encoding;
        bh=UOcvalMshnNGp6LfUyyRkuQfXP+B9c/80VCBjahNzng=;
        b=po+nSlDd0oHRgrpsHt63JUay/q+DIXleQplDpIvyGmMMLtyHYGXDn1hSRbOUR1OjLT
         gaJMD1LxaOzN2iOqE6saO2PVNul2ri3OrLsgiayED0GP5X/YIN4v/5en8nRUwG+8bwa6
         n0RA7rcQdVge10EVMIPLPirrAIXQNgghkUeM9oNW/xdz0zpgylmS4wKXSf87qBoC68JO
         qwLEpBXMhcLERqgMyfgePKUacmnzn3Oo92Rn4U7d9kd29yhLZanPc4YBeswWTciiNHTu
         Ue/PbqCy2aTonYLGhHJjTjgV+oXH0lRJRk5Yw+ej0viKAYRP4p+eJtckaGPKgXh0Y0xc
         DBsw==
X-Gm-Message-State: AFeK/H3/rYKMFPdhmuy6M1SGPPsQIwa+dwm3hRT4oEjY99aF/+Pww/0vWLXwq3cMNYsEsA==
X-Received: by 10.28.152.11 with SMTP id a11mr14565835wme.64.1490706810690;
        Tue, 28 Mar 2017 06:13:30 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g23sm3605875wme.8.2017.03.28.06.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2017 06:13:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH/RFC v2] WIP configurable options facility
Date:   Tue, 28 Mar 2017 13:13:16 +0000
Message-Id: <20170328131316.32516-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <20170328051723.h2xi2do6iclm64pi@sigill.intra.peff.net>
References: <20170328051723.h2xi2do6iclm64pi@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---

FWIW here's the current state of this WIP hack which I worked a bit on
yesterday. I converted it to use a hashmap and got rid of the need to
s/const // the options struct.

I've either converted options that read the config to this already, or
left TODO comments on those that are candidates for migration.

All tests pass with this, but as the various TODO comments note
there's some problems. It's leaking memory currently, and as the
comment in parse_options_step() notes due to how this options code is
called I've had to sprinkle some boilerplate in several parse_*_opt()
functions.

This is getting rid of less code than I'd hoped at first, although
it'll be made up if we make more stuff configurable.

On Tue, Mar 28, 2017 at 7:17 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 25, 2017 at 11:32:02PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> > So hopefully it's clear that the two are functionally equivalent, and
>> > differ only in syntax (in this case we manually decided which options
>> > are safe to pull from the config, but we'd have to parse the options.log
>> > string, too, and we could make the same decision there).
>>
>> I like the simplicity of this approach a lot. I.e. (to paraphrase it
>> just to make sure we're on the same page): Skip all the complexity of
>> reaching into the getopt guts, and just munge argc/argv given a config
>> we can stick ahead of the getopt (struct options) spec, inject some
>> options at the beginning if they're in the config, and off we go
>> without any further changes to the getopt guts.
>
> Yep, I think that's an accurate description.
>
>> There's two practical issues with this that are easy to solve with my
>> current approach, but I can't find an easy solution to using this
>> method.
>>
>> The first is that we're replacing the semantics of:
>>
>> "If you're specifying it on the command-line, we take it from there,
>> otherwise we use your config, if set, regardless of how the option
>> works"
>>
>> with:
>>
>> "We read your config, inject options implicitly at the start of the
>> command line, and then append whatever command-line you give us"
>>
>> These two are not the same. Consider e.g. the commit.verbose config.
>> With my current patch if have commit.verbose=1 in your config and do
>> "commit --verbose" you just end up with a result equivalent to not
>> having it in your config, but since the --verbose option can be
>> supplied multiple times to increase verbosity with the injection
>> method you'd end up with the equivalent of commit.verbose=2.
>
> Right, for anything where multiple options are meaningful, they'd have
> to give "--no-verbose" to reset the option. In a sense that's less
> friendly, because it's more manual. But it's also less magical, because
> the semantics are clear: the config option behaves exactly as if you
> gave the option on the command line. So for an OPT_STRING_LIST(), you
> could append to the list, or reset it to empty, etc, as you see fit.
>
> But I do agree that it's more manual, and probably would cause some
> confusion.

And some slight breakage of backwards compatibiilty for things that
supply the option on the CLI now, although it wouldn't be a huge deal.

>> I can't think of a good way around that with your proposed approach
>> that doesn't essentially get us back to something very similar to my
>> patch, i.e. we'd need to parse the command-line using the options spec
>> before applying our implicit config.
>
> Yes, the semantics you gave require parsing the options first. I think
> it would be sufficient to just give each "struct option" a "seen" flag
> (rather than having it understand the config mechanism), having
> parse_options() set the flag, and then feeding the result to a separate
> config/cmdline mapping mechanism. That keeps the complexity out of the
> options code.

Right, would require s/const // on the struct though like in my v1, or
keeping this info in some datastructure on the side.

> It does tie us back in to requiring parse-options, which not all the
> options use.

I think if we do keep something like this patch it's fair enough to
say it won't work for everything. It's just there to make it easier
for us to add configuration for options in the common case, but
there's going to be various special cases (e.g. currently the options
synonyms, and I think I'll leave that) that we won't be able to
handle.

> In a lot of cases that "seen" flag is effectively a sentinel value in
> whatever variable the option value is stored in. But some of the options
> don't have reasonable sentinel values (as you noticed with the "revert
> -m" handling recently).
>
>> The second issue is related, i.e. I was going to add some flag an
>> option could supply to say "if I'm provided none of these other
>> maybe-from-config options get to read their config". This is needed
>> for hybrid plumbing/porcelain like "git status --porcelain".
>
> Yeah, I agree you can't make that decision until you've seen the
> command-line options. I think we currently do some hairy stuff where we
> speculatively read config into a variable, and then apply the
> config-based defaults only when we know we're in non-porcelain mode (see
> status_deferred_config in builtin/commit.c).
>
> That came about because we didn't want to parse the config a second
> time. These days the deferred config should probably just be read from
> the cached configset, after we've read the other options.
>
> But I think this can be done after the full option-parsing is finished
> by applying the mapping then.  I.e., something like:
>
>     parse_options(argc, argv, options, ...);
>     if (status_format != STATUS_FORMAT_PORCELAIN)
>         apply_config_mapping(status_mapping, options);
>
> -Peff

 builtin/add.c      |   1 +
 builtin/am.c       |  16 +++----
 builtin/blame.c    |  16 +++----
 builtin/clean.c    |   8 +---
 builtin/commit.c   |  40 +++++++++-------
 builtin/difftool.c |  12 ++---
 builtin/fetch.c    |   1 +
 builtin/grep.c     |   1 +
 builtin/help.c     |   1 +
 builtin/log.c      |   1 +
 builtin/merge.c    |   2 +
 builtin/notes.c    |   1 +
 builtin/pull.c     |   2 +
 builtin/push.c     |   3 ++
 builtin/repack.c   |   3 ++
 builtin/tag.c      |  19 ++++++--
 parse-options-cb.c |  62 ++++++++++++++++++++++++
 parse-options.c    | 138 +++++++++++++++++++++++++++++++++++++++++++++++------
 parse-options.h    |  26 +++++++++-
 19 files changed, 283 insertions(+), 70 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 9f53f020d0..a1a9d7cd97 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -286,6 +286,7 @@ static struct option builtin_add_options[] = {
 
 static int add_config(const char *var, const char *value, void *cb)
 {
+	/* NOTE: No support for option synonyms. Probably not worth it. */
 	if (!strcmp(var, "add.ignoreerrors") ||
 	    !strcmp(var, "add.ignore-errors")) {
 		ignore_add_errors = git_config_bool(var, value);
diff --git a/builtin/am.c b/builtin/am.c
index f7a7a971fb..b82f81e70a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -147,13 +147,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 	state->dir = xstrdup(dir);
 
 	state->prec = 4;
-
-	git_config_get_bool("am.threeway", &state->threeway);
-
 	state->utf8 = 1;
 
-	git_config_get_bool("am.messageid", &state->message_id);
-
 	state->scissors = SCISSORS_UNSET;
 
 	argv_array_init(&state->git_apply_opts);
@@ -947,6 +942,7 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 {
 	if (keep_cr < 0) {
 		keep_cr = 0;
+		/* TODO: This is --keep-cr */
 		git_config_get_bool("am.keepcr", &keep_cr);
 	}
 
@@ -2240,8 +2236,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("run interactively")),
 		OPT_HIDDEN_BOOL('b', "binary", &binary,
 			N_("historical option -- no-op")),
-		OPT_BOOL('3', "3way", &state.threeway,
-			N_("allow fall back on 3way merging if needed")),
+		OPT_BOOL_C('3', "3way", &state.threeway,
+			N_("allow fall back on 3way merging if needed"),
+			"am.threeway", parse_opt_confkey_bool),
 		OPT__QUIET(&state.quiet, N_("be quiet")),
 		OPT_SET_INT('s', "signoff", &state.signoff,
 			N_("add a Signed-off-by line to the commit message"),
@@ -2252,8 +2249,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("pass -k flag to git-mailinfo"), KEEP_TRUE),
 		OPT_SET_INT(0, "keep-non-patch", &state.keep,
 			N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
-		OPT_BOOL('m', "message-id", &state.message_id,
-			N_("pass -m flag to git-mailinfo")),
+		OPT_BOOL_C('m', "message-id", &state.message_id,
+			N_("pass -m flag to git-mailinfo"),
+			"am.messageid", parse_opt_confkey_bool),
 		{ OPTION_SET_INT, 0, "keep-cr", &keep_cr, NULL,
 		  N_("pass --keep-cr flag to git-mailsplit for mbox format"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
diff --git a/builtin/blame.c b/builtin/blame.c
index f7aa95f4ba..b7eec51d0a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2193,14 +2193,7 @@ static const char *add_prefix(const char *prefix, const char *path)
 
 static int git_blame_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "blame.showroot")) {
-		show_root = git_config_bool(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "blame.blankboundary")) {
-		blank_boundary = git_config_bool(var, value);
-		return 0;
-	}
+	/* TODO: The --show-email option (bit) */
 	if (!strcmp(var, "blame.showemail")) {
 		int *output_option = cb;
 		if (git_config_bool(var, value))
@@ -2209,6 +2202,7 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 			*output_option &= ~OUTPUT_SHOW_EMAIL;
 		return 0;
 	}
+	/* TODO: The --date option (string, date format) */
 	if (!strcmp(var, "blame.date")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -2571,8 +2565,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	const char *contents_from = NULL;
 	const struct option options[] = {
 		OPT_BOOL(0, "incremental", &incremental, N_("Show blame entries as we find them, incrementally")),
-		OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
-		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
+		OPT_BOOL_C('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)"),
+		           "blame.blankboundary", parse_opt_confkey_bool),
+		OPT_BOOL_C(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)"),
+		           "blame.showroot", parse_opt_confkey_bool),
 		OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),
 		OPT_BOOL(0, "progress", &show_progress, N_("Force progress reporting")),
 		OPT_BIT(0, "score-debug", &output_option, N_("Show output score for blame entries"), OUTPUT_SHOW_SCORE),
diff --git a/builtin/clean.c b/builtin/clean.c
index d861f836a2..3922e146ad 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -119,11 +119,6 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 		return color_parse(value, clean_colors[slot]);
 	}
 
-	if (!strcmp(var, "clean.requireforce")) {
-		force = !git_config_bool(var, value);
-		return 0;
-	}
-
 	/* inspect the color.ui config variable and others */
 	return git_color_default_config(var, value, cb);
 }
@@ -874,7 +869,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
-		OPT__FORCE(&force, N_("force")),
+		OPT__FORCE_C(&force, N_("force"),
+		            "clean.requireForce", parse_opt_confkey_bool_neg),
 		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
 		OPT_BOOL('d', NULL, &remove_directories,
 				N_("remove whole directories")),
diff --git a/builtin/commit.c b/builtin/commit.c
index 4e288bc513..9f11f41be3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1493,28 +1493,30 @@ static void print_summary(const char *prefix, const struct object_id *oid,
 	strbuf_release(&format);
 }
 
+int parse_opt_confkey_verbose_bool_or_int(const struct option *opt, const char *arg, int unset) {
+	const char *value;
+	int is_bool;
+
+	if (git_config_get_value(opt->conf_key, &value))
+		return 0;
+
+	config_commit_verbose = git_config_bool_or_int(opt->conf_key, value, &is_bool);
+
+	trace_printf("getopt/parse_opt_confkey_verbose_bool_or_int: Parsed bool_or_int value for %s got %d\n", opt->long_name, config_commit_verbose);
+
+	return 0;
+}
+
 static int git_commit_config(const char *k, const char *v, void *cb)
 {
 	struct wt_status *s = cb;
 	int status;
 
-	if (!strcmp(k, "commit.template"))
-		return git_config_pathname(&template_file, k, v);
-	if (!strcmp(k, "commit.status")) {
-		include_status = git_config_bool(k, v);
-		return 0;
-	}
-	if (!strcmp(k, "commit.cleanup"))
-		return git_config_string(&cleanup_arg, k, v);
+	/* TODO: The --gpg-sign option (string or bool? confusing) */
 	if (!strcmp(k, "commit.gpgsign")) {
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
-	if (!strcmp(k, "commit.verbose")) {
-		int is_bool;
-		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
-		return 0;
-	}
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
@@ -1580,7 +1582,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	static struct wt_status s;
 	static struct option builtin_commit_options[] = {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
-		OPT__VERBOSE(&verbose, N_("show diff in commit message template")),
+		OPT__VERBOSE_C(&verbose, N_("show diff in commit message template"),
+			      "commit.verbose", parse_opt_confkey_verbose_bool_or_int),
 
 		OPT_GROUP(N_("Commit message options")),
 		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
@@ -1593,10 +1596,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
-		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
+		OPT_FILENAME_C('t', "template", &template_file, N_("use specified template file"),
+			       "commit.template", parse_opt_confkey_pathname),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
-		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
-		OPT_BOOL(0, "status", &include_status, N_("include status in commit message template")),
+		OPT_STRING_C(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message"),
+			     "commit.cleanup", parse_opt_confkey_string),
+		OPT_BOOL_C(0, "status", &include_status, N_("include status in commit message template"),
+		           "commit.status", parse_opt_confkey_bool),
 		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		/* end commit message options */
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 25e54ad3ed..6ca258eec3 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -36,11 +36,6 @@ static int difftool_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!strcmp(var, "difftool.trustexitcode")) {
-		trust_exit_code = git_config_bool(var, value);
-		return 0;
-	}
-
 	return git_default_config(var, value, cb);
 }
 
@@ -680,9 +675,10 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "tool-help", &tool_help,
 			 N_("print a list of diff tools that may be used with "
 			    "`--tool`")),
-		OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
-			 N_("make 'git-difftool' exit when an invoked diff "
-			    "tool returns a non - zero exit code")),
+		OPT_BOOL_C(0, "trust-exit-code", &trust_exit_code,
+			   N_("make 'git-difftool' exit when an invoked diff "
+			      "tool returns a non - zero exit code"),
+			   "difftool.trustexitcode", parse_opt_confkey_bool),
 		OPT_STRING('x', "extcmd", &extcmd, N_("<command>"),
 			   N_("specify a custom command for viewing diffs")),
 		OPT_END()
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b5ad09d046..084019cf93 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -69,6 +69,7 @@ static int option_parse_recurse_submodules(const struct option *opt,
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
+	/* TODO: The --prune option. Non-trivial to migrate due to tri-state interaction. Debug it */
 	if (!strcmp(k, "fetch.prune")) {
 		fetch_prune_config = git_config_bool(k, v);
 		return 0;
diff --git a/builtin/grep.c b/builtin/grep.c
index 837836fb3e..3fee3ac121 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -284,6 +284,7 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 	if (git_color_default_config(var, value, cb) < 0)
 		st = -1;
 
+	/* TODO: The --threads option (int) */
 	if (!strcmp(var, "grep.threads")) {
 		num_threads = git_config_int(var, value);
 		if (num_threads < 0)
diff --git a/builtin/help.c b/builtin/help.c
index 49f7a07f85..790a934a46 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -251,6 +251,7 @@ static int git_help_config(const char *var, const char *value, void *cb)
 {
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "help", &colopts);
+	/* TODO: Corresponds to multiple options. I.e. --man, --html etc.*/
 	if (!strcmp(var, "help.format")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/builtin/log.c b/builtin/log.c
index 670229cbb4..bf6dbb3c94 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -390,6 +390,7 @@ static int git_log_config(const char *var, const char *value, void *cb)
 {
 	const char *slot_name;
 
+	/* TODO: Hard to untangle the below, but it's all/most overrides for one option or other */
 	if (!strcmp(var, "format.pretty"))
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
diff --git a/builtin/merge.c b/builtin/merge.c
index 7554b8d412..544b616f77 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -557,6 +557,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	/* TODO: --stat, documented in git-config. This has *no* tests (bool) */
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
 		show_diffstat = git_config_bool(k, v);
 	else if (!strcmp(k, "pull.twohead"))
@@ -565,6 +566,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_octopus, k, v);
 	else if (!strcmp(k, "merge.renormalize"))
 		option_renormalize = git_config_bool(k, v);
+	/* TODO: --ff option, bool + custom values (bool + str) */
 	else if (!strcmp(k, "merge.ff")) {
 		int boolval = git_config_maybe_bool(k, v);
 		if (0 <= boolval) {
diff --git a/builtin/notes.c b/builtin/notes.c
index 0513f7455d..248a8cd714 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -834,6 +834,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&merge_key, "notes.%s.mergeStrategy", short_ref);
 
 		if (git_config_get_notes_strategy(merge_key.buf, &o.strategy))
+			/* TODO: The -s option (str) */
 			git_config_get_notes_strategy("notes.mergeStrategy", &o.strategy);
 
 		strbuf_release(&merge_key);
diff --git a/builtin/pull.c b/builtin/pull.c
index 3ecb881b0b..65ed5c3a47 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -36,6 +36,7 @@ enum rebase_type {
 static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		int fatal)
 {
+	/* TODO: The --rebase[=...] option (bool & str) */
 	int v = git_config_maybe_bool("pull.rebase", value);
 
 	if (!v)
@@ -271,6 +272,7 @@ static const char *config_get_ff(void)
 	if (git_config_get_value("pull.ff", &value))
 		return NULL;
 
+	/* TODO: The --ff option (bool?) */
 	switch (git_config_maybe_bool("pull.ff", value)) {
 	case 0:
 		return "--no-ff";
diff --git a/builtin/push.c b/builtin/push.c
index 5c22e9f2e5..947737c28a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -471,12 +471,14 @@ static int git_push_config(const char *k, const char *v, void *cb)
 	if (status)
 		return status;
 
+	/* TODO: The --follow-tags option (bool?) */
 	if (!strcmp(k, "push.followtags")) {
 		if (git_config_bool(k, v))
 			*flags |= TRANSPORT_PUSH_FOLLOW_TAGS;
 		else
 			*flags &= ~TRANSPORT_PUSH_FOLLOW_TAGS;
 		return 0;
+	/* TODO: The --sign option? (bool & str) */
 	} else if (!strcmp(k, "push.gpgsign")) {
 		const char *value;
 		if (!git_config_get_value("push.gpgsign", &value)) {
@@ -494,6 +496,7 @@ static int git_push_config(const char *k, const char *v, void *cb)
 					return error("Invalid value for '%s'", k);
 			}
 		}
+	/* TODO: The --recurse-submodules option (bool & str?) */
 	} else if (!strcmp(k, "push.recursesubmodules")) {
 		const char *value;
 		if (!git_config_get_value("push.recursesubmodules", &value))
diff --git a/builtin/repack.c b/builtin/repack.c
index 677bc7c81a..ff3a0be619 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -26,14 +26,17 @@ static const char incremental_bitmap_conflict_error[] = N_(
 
 static int repack_config(const char *var, const char *value, void *cb)
 {
+	/* TODO: The --delta-base-offset option passed to pack-objects (bool) */
 	if (!strcmp(var, "repack.usedeltabaseoffset")) {
 		delta_base_offset = git_config_bool(var, value);
 		return 0;
 	}
+	/* TODO: The --pack-kept-objects option, not documented in the git-repack manpage, just git-config (bool) */
 	if (!strcmp(var, "repack.packkeptobjects")) {
 		pack_kept_objects = git_config_bool(var, value);
 		return 0;
 	}
+	/* TODO: The --write-bitmap-index option (bool). Has synonym */
 	if (!strcmp(var, "repack.writebitmaps") ||
 	    !strcmp(var, "pack.writebitmaps")) {
 		write_bitmaps = git_config_bool(var, value);
diff --git a/builtin/tag.c b/builtin/tag.c
index ad29be6923..8f5621b72f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -165,6 +165,7 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	int status;
 	struct ref_sorting **sorting_tail = (struct ref_sorting **)cb;
 
+	/* TODO: The --sort option (bool / str) */
 	if (!strcmp(var, "tag.sort")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -175,10 +176,6 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	status = git_gpg_config(var, value, cb);
 	if (status)
 		return status;
-	if (!strcmp(var, "tag.forcesignannotated")) {
-		force_sign_annotate = git_config_bool(var, value);
-		return 0;
-	}
 
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "tag", &colopts);
@@ -379,6 +376,17 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 	return check_refname_format(sb->buf, 0);
 }
 
+static int parse_opt_confkey_sign_bool(const struct option *opt, const char *arg, int unset) {
+	const char *value;
+
+	if (git_config_get_value(opt->conf_key, &value))
+		return 0;
+
+	force_sign_annotate = git_config_bool(opt->conf_key, value);
+
+	return 0;
+}
+
 int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -413,7 +421,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK('m', "message", &msg, N_("message"),
 			     N_("tag message"), parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
-		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
+		OPT_BOOL_C('s', "sign", &opt.sign, N_("annotated and GPG-signed tag"),
+		           "tag.forcesignannotated", parse_opt_confkey_sign_bool),
 		OPT_STRING(0, "cleanup", &cleanup_arg, N_("mode"),
 			N_("how to strip spaces and #comments from message")),
 		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
diff --git a/parse-options-cb.c b/parse-options-cb.c
index b7d8f7dcb2..9b6d967cf5 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -236,3 +236,65 @@ int parse_opt_passthru_argv(const struct option *opt, const char *arg, int unset
 
 	return 0;
 }
+
+/* Does it suck that I have to use the cache interface to the config
+ * here? Should we somehow unroll this whole thing so
+ * parse_options_step loops over the config values, and maybe
+ * populates opt->conf_key (which we'd need to add) for all the
+ * options that need it?
+ *
+ * I.e. should we make this more complex because this one-shot
+ * interface is expensive, or is it just fine?
+*/ 
+
+int parse_opt_confkey_bool(const struct option *opt, const char *arg, int unset) {
+	const char *value;
+
+	if (git_config_get_value(opt->conf_key, &value))
+		return 0;
+
+	*(int *)opt->value = git_config_bool(opt->conf_key, value);
+
+	trace_printf("getopt/parse_opt_confkey_bool: Parsed bool value for %s got %d\n", opt->long_name, *(int*)opt->value);
+
+	return 0;
+}
+
+int parse_opt_confkey_bool_neg(const struct option *opt, const char *arg, int unset) {
+	const char *value;
+
+	if (git_config_get_value(opt->conf_key, &value))
+		return 0;
+
+	*(int *)opt->value = !git_config_bool(opt->conf_key, value);
+
+	trace_printf("getopt/parse_opt_confkey_bool_neg: Parsed bool value for %s got %d\n", opt->long_name, *(int*)opt->value);
+
+	return 0;
+}
+
+int parse_opt_confkey_string(const struct option *opt, const char *arg, int unset) {
+	const char *value;
+
+	if (git_config_get_value(opt->conf_key, &value))
+		return 0;
+
+	git_config_string((const char **)opt->value, opt->conf_key, value);
+
+	trace_printf("getopt/parse_opt_confkey_string: Parsed string value for %s got %s\n", opt->long_name, *(char**)opt->value);
+
+	return 0;
+}
+
+int parse_opt_confkey_pathname(const struct option *opt, const char *arg, int unset) {
+	const char *value;
+
+	if (git_config_get_value(opt->conf_key, &value))
+		return 0;
+
+	git_config_pathname((const char **)opt->value, opt->conf_key, value);
+
+	trace_printf("getopt/parse_opt_confkey_pathname: Parsed pathname value for %s got %s\n", opt->long_name, *(char**)opt->value);
+
+	return 0;
+}
diff --git a/parse-options.c b/parse-options.c
index a23a1e67f0..b7bd0b950e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -3,11 +3,40 @@
 #include "cache.h"
 #include "commit.h"
 #include "color.h"
+#include "hashmap.h"
 #include "utf8.h"
 
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
+struct option_hash_entry
+{
+	struct hashmap_entry ent; /* must be the first member! */
+
+	char option[FLEX_ARRAY]; /* NUL-terminated canonical option name: */
+};
+
+static int option_hash_cmp(const void *entry, const void *entry_or_key,
+			   const void *keydata)
+{
+	const struct option_hash_entry *e1 = entry, *e2 = entry_or_key;
+	const char *option = keydata ? keydata : e2->option;
+
+	return strcmp(e1->option, option);
+}
+
+/* TODO: This is just something I copied from 7d4558c462, but I could
+ * skip this alloc indirection since I'm malloc-ing the key with
+ * xstrfmt */
+static struct option_hash_entry *alloc_option_hash_entry(const char *option)
+{
+	struct option_hash_entry *entry;
+
+	FLEX_ALLOC_STR(entry, option, option);
+	hashmap_entry_init(entry, strhash(option));
+	return entry;
+}
+
 int optbug(const struct option *opt, const char *reason)
 {
 	if (opt->long_name) {
@@ -200,15 +229,24 @@ static int get_value(struct parse_opt_ctx_t *p,
 	}
 }
 
-static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *options)
+static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *options,
+                           struct hashmap *options_map)
 {
 	const struct option *all_opts = options;
 	const struct option *numopt = NULL;
+	int ret;
+	char *hkey = NULL;
 
 	for (; options->type != OPTION_END; options++) {
 		if (options->short_name == *p->opt) {
 			p->opt = p->opt[1] ? p->opt + 1 : NULL;
-			return get_value(p, options, all_opts, OPT_SHORT);
+			ret = get_value(p, options, all_opts, OPT_SHORT);
+
+			if (!ret && options->flags & PARSE_OPT_CONFIGURABLE) {
+				hkey = xstrfmt("%d:%s", options->short_name, options->long_name);
+				hashmap_put(options_map, alloc_option_hash_entry(hkey));
+			}
+			return ret;
 		}
 
 		/*
@@ -228,6 +266,10 @@ static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *optio
 		arg = xmemdupz(p->opt, len);
 		p->opt = p->opt[len] ? p->opt + len : NULL;
 		rc = (*numopt->callback)(numopt, arg, 0) ? (-1) : 0;
+		if (!rc && numopt->flags & PARSE_OPT_CONFIGURABLE) {
+			hkey = xstrfmt("%d:%s", numopt->short_name, numopt->long_name);
+			hashmap_put(options_map, alloc_option_hash_entry(hkey));
+		}
 		free(arg);
 		return rc;
 	}
@@ -235,12 +277,15 @@ static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *optio
 }
 
 static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
-                          const struct option *options)
+                          const struct option *options,
+                          struct hashmap *options_map)
 {
 	const struct option *all_opts = options;
 	const char *arg_end = strchrnul(arg, '=');
 	const struct option *abbrev_option = NULL, *ambiguous_option = NULL;
 	int abbrev_flags = 0, ambiguous_flags = 0;
+	int ret;
+	char *hkey = NULL;
 
 	for (; options->type != OPTION_END; options++) {
 		const char *rest, *long_name = options->long_name;
@@ -313,7 +358,14 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 				continue;
 			p->opt = rest + 1;
 		}
-		return get_value(p, options, all_opts, flags ^ opt_flags);
+		ret = get_value(p, options, all_opts, flags ^ opt_flags);
+		if (!ret && options->flags & PARSE_OPT_CONFIGURABLE) {
+			/* TODO: This leaks memory. See:
+			   valgrind --tool=memcheck --leak-check=yes ./git commit --status */
+			hkey = xstrfmt("%d:%s", options->short_name, options->long_name);
+			hashmap_put(options_map, alloc_option_hash_entry(hkey));
+		}
+		return ret;
 	}
 
 	if (ambiguous_option)
@@ -330,15 +382,24 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 }
 
 static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg,
-			    const struct option *options)
+			    const struct option *options,
+			    struct hashmap *options_map)
 {
 	const struct option *all_opts = options;
+	int ret;
+	char *hkey = NULL;
 
 	for (; options->type != OPTION_END; options++) {
 		if (!(options->flags & PARSE_OPT_NODASH))
 			continue;
-		if (options->short_name == arg[0] && arg[1] == '\0')
-			return get_value(p, options, all_opts, OPT_SHORT);
+		if (options->short_name == arg[0] && arg[1] == '\0') {
+			ret = get_value(p, options, all_opts, OPT_SHORT);
+			if (!ret && options->flags & PARSE_OPT_CONFIGURABLE) {
+				hkey = xstrfmt("%d:%s", options->short_name, options->long_name);
+				hashmap_put(options_map, alloc_option_hash_entry(hkey));
+			}
+			return ret;
+		}
 	}
 	return -2;
 }
@@ -434,6 +495,21 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 {
 	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
 	int err = 0;
+	struct hashmap options_map;
+	struct option_hash_entry *entry;
+	char *hkey = NULL;
+
+	/* TODO: This hashmap init would be so much less painful in
+	 * parse_options(), but blame/shortlog/update-index call
+	 * parse_options_step() directly. Maybe we should just
+	 * simplify this and say they can't use this config interface
+	 * unless they're refactored to behave like everything else
+	 *
+	 * TODO: Does I think hashmap_free(..., 1) doesn't free my
+	 * xstrfmt'd strings. Do I need to iter over the hashmap to
+	 * properly free it?
+	 */
+	hashmap_init(&options_map, option_hash_cmp, 0);
 
 	/* we must reset ->opt, unknown short option leave it dangling */
 	ctx->opt = NULL;
@@ -442,10 +518,12 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		const char *arg = ctx->argv[0];
 
 		if (*arg != '-' || !arg[1]) {
-			if (parse_nodash_opt(ctx, arg, options) == 0)
+			if (parse_nodash_opt(ctx, arg, options, &options_map) == 0)
 				continue;
-			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
+			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION) {
+				hashmap_free(&options_map, 1);
 				return PARSE_OPT_NON_OPTION;
+			}
 			ctx->out[ctx->cpidx++] = ctx->argv[0];
 			continue;
 		}
@@ -456,7 +534,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
-			switch (parse_short_opt(ctx, options)) {
+			switch (parse_short_opt(ctx, options, &options_map)) {
 			case -1:
 				goto show_usage_error;
 			case -2:
@@ -469,7 +547,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			if (ctx->opt)
 				check_typos(arg + 1, options);
 			while (ctx->opt) {
-				switch (parse_short_opt(ctx, options)) {
+				switch (parse_short_opt(ctx, options, &options_map)) {
 				case -1:
 					goto show_usage_error;
 				case -2:
@@ -497,11 +575,13 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			break;
 		}
 
-		if (internal_help && !strcmp(arg + 2, "help-all"))
+		if (internal_help && !strcmp(arg + 2, "help-all")) {
+			hashmap_free(&options_map, 1);
 			return usage_with_options_internal(ctx, usagestr, options, 1, 0);
+		}
 		if (internal_help && !strcmp(arg + 2, "help"))
 			goto show_usage;
-		switch (parse_long_opt(ctx, arg + 2, options)) {
+		switch (parse_long_opt(ctx, arg + 2, options, &options_map)) {
 		case -1:
 			goto show_usage_error;
 		case -2:
@@ -509,16 +589,46 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		}
 		continue;
 unknown:
-		if (!(ctx->flags & PARSE_OPT_KEEP_UNKNOWN))
+		if (!(ctx->flags & PARSE_OPT_KEEP_UNKNOWN)) {
+			hashmap_free(&options_map, 1);
 			return PARSE_OPT_UNKNOWN;
+		}
 		ctx->out[ctx->cpidx++] = ctx->argv[0];
 		ctx->opt = NULL;
 	}
+
+	/* The loop above is driven by the argument vector, so we need
+	 * to make a second pass and find those options that are
+	 * configurable, and haven't been set via the command-line */
+	for (; options->type != OPTION_END; options++) {
+		if (!(options->flags & PARSE_OPT_CONFIGURABLE))
+			continue;
+
+		/* In some cases options->long_name is null, then we
+		 * just use :(null) as part of the key, it's
+		 * harmless
+		 */
+		hkey = xstrfmt("%d:%s", options->short_name, options->long_name);
+		entry = hashmap_get_from_hash(&options_map, strhash(hkey), hkey);
+		if (entry) {
+			free(hkey);
+			continue;
+		}
+
+		trace_printf("getopt/parse_options_step: Calling callback for configurable option %s\n", options->long_name);
+		if ((*options->conf_callback)(options, NULL, 1))
+			trace_printf("getopt/parse_options_step: Callback for configurable option %s gave us a value\n", options->long_name);
+		else
+			trace_printf("getopt/parse_options_step: Callback for configurable option %s gave us NO value\n", options->long_name);
+	}
+
+	hashmap_free(&options_map, 1);
 	return PARSE_OPT_DONE;
 
  show_usage_error:
 	err = 1;
  show_usage:
+	hashmap_free(&options_map, 1);
 	return usage_with_options_internal(ctx, usagestr, options, 0, err);
 }
 
diff --git a/parse-options.h b/parse-options.h
index dcd8a0926c..8d048c74bd 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -38,7 +38,8 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 16,
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
-	PARSE_OPT_SHELL_EVAL = 256
+	PARSE_OPT_SHELL_EVAL = 256,
+	PARSE_OPT_CONFIGURABLE = 512
 };
 
 struct option;
@@ -110,6 +111,9 @@ struct option {
 	int flags;
 	parse_opt_cb *callback;
 	intptr_t defval;
+
+	const char *conf_key;
+	parse_opt_cb *conf_callback;
 };
 
 #define OPT_END()                   { OPTION_END }
@@ -122,9 +126,17 @@ struct option {
 				      (h), PARSE_OPT_NOARG, NULL, (b) }
 #define OPT_COUNTUP(s, l, v, h)     { OPTION_COUNTUP, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG }
+#define OPT_COUNTUP_C(s, l, v, h, ck, cb) \
+				      { OPTION_COUNTUP, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG | PARSE_OPT_CONFIGURABLE, \
+				      NULL, 0, ck, cb }
 #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (i) }
+#define OPT_SET_INT_C(s, l, v, h, i, ck, cb) \
+				    { OPTION_SET_INT, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG | PARSE_OPT_CONFIGURABLE, NULL, (i), ck, cb }
 #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
+#define OPT_BOOL_C(s, l, v, h, ck, cb) OPT_SET_INT_C(s, l, v, h, 1, ck, cb)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
 #define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
@@ -133,6 +145,8 @@ struct option {
 #define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), (v), \
 				      N_("n"), (h), PARSE_OPT_NONEG }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
+#define OPT_STRING_C(s, l, v, a, h, ck, cb)   { OPTION_STRING,  (s), (l), (v), (a), (h), \
+			                        PARSE_OPT_CONFIGURABLE, NULL, 0, ck, cb }
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
@@ -151,6 +165,9 @@ struct option {
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
 #define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), \
 				       N_("file"), (h) }
+#define OPT_FILENAME_C(s, l, v, h, ck, cb) { OPTION_FILENAME, (s), (l), (v), \
+			                     N_("file"), (h), PARSE_OPT_NOARG | PARSE_OPT_CONFIGURABLE, \
+			                     NULL, 0, ck, cb }
 #define OPT_COLOR_FLAG(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("when"), (h), PARSE_OPT_OPTARG, \
 		parse_opt_color_flag_cb, (intptr_t)"always" }
@@ -231,8 +248,13 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
 extern int parse_opt_unknown_cb(const struct option *, const char *, int);
 extern int parse_opt_passthru(const struct option *, const char *, int);
 extern int parse_opt_passthru_argv(const struct option *, const char *, int);
+extern int parse_opt_confkey_bool(const struct option *, const char *, int);
+extern int parse_opt_confkey_bool_neg(const struct option *, const char *, int);
+extern int parse_opt_confkey_string(const struct option *, const char *, int);
+extern int parse_opt_confkey_pathname(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
+#define OPT__VERBOSE_C(var, h, ck, cb)  OPT_COUNTUP_C('v', "verbose", (var), (h), ck, cb)
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
 #define OPT__VERBOSITY(var) \
 	{ OPTION_CALLBACK, 'v', "verbose", (var), NULL, N_("be more verbose"), \
@@ -241,6 +263,8 @@ extern int parse_opt_passthru_argv(const struct option *, const char *, int);
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
 #define OPT__DRY_RUN(var, h)  OPT_BOOL('n', "dry-run", (var), (h))
 #define OPT__FORCE(var, h)    OPT_COUNTUP('f', "force",   (var), (h))
+#define OPT__FORCE_C(var, h, ck, cb) \
+	OPT_COUNTUP_C('f', "force", (var), (h), ck, cb)
 #define OPT__ABBREV(var)  \
 	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
 	  N_("use <n> digits to display SHA-1s"),	\
-- 
2.11.0

