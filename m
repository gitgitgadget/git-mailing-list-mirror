Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6984AC32771
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 10:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1192072A
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 10:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsgy8HiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgAIKQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:16:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47033 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgAIKQr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 05:16:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so6679803wrl.13
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 02:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e3iNfPoLg5p7Xd6ILLhG2eUsBcVzvNePOauHv/icdkY=;
        b=Xsgy8HiHUjAOqpCzUOgfg7JNORzRbxjx29v77iVzsJDjNaWIt8T5LWZ+0VGNV2uhz0
         QkKjsNlchEtxkcg47skoIC2A3P3YTUhpbbJDcVR47bQAvfSPS52rjyzihwLWhgK8rccy
         pSsAwKOqu4pKH7z1dEqEbPIst0qNIGOWcWi7NysNgCDR0wyxG8vFSv/QqYrcTwA4i9gw
         sDkhh0md9hW6blcSnvT8Npgsc8kEsEm4tsxXWPFTX1btoTz+HFlxOkonp4qKXMEWUxkL
         tTTUmdyc06KhVfYVllKa8MBLeLvbMayd+bAhaRxIwdvD5KxFn1aLHi9fBNzCVT0Dr/P7
         1gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e3iNfPoLg5p7Xd6ILLhG2eUsBcVzvNePOauHv/icdkY=;
        b=NYX//nh3ruzsrBrQflhom2Uzxm2EKgSJCOqTn7lUZELa5QG47gyYZx/nAH66aDgjIj
         p8Xn/xzXF0xuVpB9Hyu59Lr9XgHaZIbUKHC4DvQk5449AKBhxY04qMRtP2rmzGCh33/e
         cXX2XMquttPdVAeOQCSg1M0jurC2Q1E+H9nOVJcVKXtCNEM9JVZIhOjobBlIvK8bK1iR
         bpnF0CXTQ+mzh8UCql8YrgecdAO36oxxkkECHSgeEyCJBlizBFfmDBVnKCVBmg6dMvOE
         TsaJrE1EFagND7G/qdlC1bkcAO/5enxVGy8ONGWrkDNHn+utLQyDp31CZ7US73JLM1Ji
         mpPw==
X-Gm-Message-State: APjAAAXMVN1d4PFvV9PP9ulwmX5ZgoYLLjUzeNslRbNecmDv7UUvjQ0E
        4aZgZ4ZkHKV1ahAXWVzOH/ypyn1v
X-Google-Smtp-Source: APXvYqyB8IJhPAFT67zIaITkT47Gc067YaDeBscT0NbLf14C0OElWHR+G9zxN4wetOaeEkW9B4K84g==
X-Received: by 2002:adf:f311:: with SMTP id i17mr9975821wro.81.1578565003715;
        Thu, 09 Jan 2020 02:16:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm7809143wra.83.2020.01.09.02.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:16:43 -0800 (PST)
Message-Id: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.git.1576631464.gitgitgadget@gmail.com>
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jan 2020 10:16:37 +0000
Subject: [PATCH v2 0/4] config: allow user to know scope of config options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was originally a pull request to the git-for-windows repository
[https://github.com/git-for-windows/git/pull/2399]. It adds a new option
--show-scope which would allow a user to see what scope a given
configuration value has (sytem, local, global, etc.).

changes since v1:

 * Cleaned up meaning of scoping, specifically separating "repo" into
   "local" and "worktree" as well as expanding "cmdline" into "command"
   scoping, added submodule scoping
 * Taught struct git_config_source to remember the scope of the command that
   is filling it out
 * do_git_config_sequence() now remembers the previous scope so that if it
   is called recursively it can remember where it was.
 * Added documentation for this new option

Matthew Rogers (4):
  config: fix typo in variable name
  config: fix config scope enum
  config: clarify meaning of command line scoping
  config: add '--show-scope' to print the scope of a config value

 Documentation/git-config.txt | 15 +++++---
 builtin/config.c             | 66 ++++++++++++++++++++++++++++++------
 config.c                     | 15 ++++----
 config.h                     | 19 ++++++-----
 remote.c                     |  3 +-
 submodule-config.c           |  4 ++-
 t/helper/test-config.c       |  8 +++--
 t/t1300-config.sh            | 50 +++++++++++++++++++++++++++
 upload-pack.c                |  3 +-
 9 files changed, 148 insertions(+), 35 deletions(-)


base-commit: 7a6a90c6ec48fc78c83d7090d6c1b95d8f3739c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-478%2FROGERSM94%2Fadd-config-flags-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-478/ROGERSM94/add-config-flags-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/478

Range-diff vs v1:

 -:  ---------- > 1:  b40480f03a config: fix typo in variable name
 -:  ---------- > 2:  e8e05f3940 config: fix config scope enum
 -:  ---------- > 3:  8225273546 config: clarify meaning of command line scoping
 1:  ec699bb3e6 ! 4:  92ce9b7824 config: allow user to know scope of config options
     @@ -1,21 +1,62 @@
      Author: Matthew Rogers <mattr94@gmail.com>
      
     -    config: allow user to know scope of config options
     +    config: add '--show-scope' to print the scope of a config value
      
     -    Add new option --show-scope which allows a user to know what the scope
     -    of listed config options are (local/global/system/etc.).
     +    When a user queries config values with --show-origin, often it's
     +    difficult to determine what the actual "scope" (local, global, etc.) of
     +    a given value is based on just the origin file.
     +
     +    Teach 'git config' the '--show-scope' option to print the scope of all
     +    displayed config values.  Note that we should never see anything of
     +    "submodule" scope as that is only ever used by submodule-config.c when
     +    parsing the '.gitmodules' file.
      
          Signed-off-by: Matthew Rogers <mattr94@gmail.com>
      
     + diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
     + --- a/Documentation/git-config.txt
     + +++ b/Documentation/git-config.txt
     +@@
     + SYNOPSIS
     + --------
     + [verse]
     +-'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] name [value [value_regex]]
     ++'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
     + 'git config' [<file-option>] [--type=<type>] --add name value
     + 'git config' [<file-option>] [--type=<type>] --replace-all name value [value_regex]
     +-'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get name [value_regex]
     +-'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get-all name [value_regex]
     +-'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
     ++'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get name [value_regex]
     ++'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get-all name [value_regex]
     ++'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
     + 'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
     + 'git config' [<file-option>] --unset name [value_regex]
     + 'git config' [<file-option>] --unset-all name [value_regex]
     + 'git config' [<file-option>] --rename-section old_name new_name
     + 'git config' [<file-option>] --remove-section name
     +-'git config' [<file-option>] [--show-origin] [-z|--null] [--name-only] -l | --list
     ++'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
     + 'git config' [<file-option>] --get-color name [default]
     + 'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
     + 'git config' [<file-option>] -e | --edit
     +@@
     + 	the actual origin (config file path, ref, or blob id if
     + 	applicable).
     + 
     ++--show-scope::
     ++	Similar to `--show-origin` in that it augments the output of
     ++	all queried config options with the scope of that value 
     ++	(local, global, system, command).
     ++
     + --get-colorbool name [stdout-is-tty]::
     + 
     + 	Find the color setting for `name` (e.g. `color.diff`) and output
     +
       diff --git a/builtin/config.c b/builtin/config.c
       --- a/builtin/config.c
       +++ b/builtin/config.c
      @@
     - static struct git_config_source given_config_source;
     - static int actions, type;
     - static char *default_value;
     --static int end_null;
     -+static int end_nul;
       static int respect_includes_opt = -1;
       static struct config_options config_options;
       static int show_origin;
     @@ -24,69 +65,41 @@
       #define ACTION_GET (1<<0)
       #define ACTION_GET_ALL (1<<1)
      @@
     - 	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
     - 	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
     - 	OPT_GROUP(N_("Other")),
     --	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
     -+	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
       	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
       	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
       	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
     -+	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (system, global, local, command line)")),
     ++	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree, local, global, system, command)")),
       	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
       	OPT_END(),
       };
      @@
     - 
     - static void show_config_origin(struct strbuf *buf)
     - {
     --	const char term = end_null ? '\0' : '\t';
     -+	const char term = end_nul ? '\0' : '\t';
     - 
     - 	strbuf_addstr(buf, current_config_origin_type());
     - 	strbuf_addch(buf, ':');
     --	if (end_null)
     -+	if (end_nul)
     - 		strbuf_addstr(buf, current_config_name());
     - 	else
     - 		quote_c_style(current_config_name(), buf, NULL, 0);
       	strbuf_addch(buf, term);
       }
       
      +static const char *scope_to_string(enum config_scope scope) {
     -+	/*
     -+	 * --local, --global, and --system work the same as --file so there's
     -+	 * no easy way for the parser to tell the difference when it is
     -+	 * setting the scope, so we use our information about which options
     -+	 * were passed
     -+	 */
     -+	if (use_local_config || scope == CONFIG_SCOPE_REPO) {
     ++	switch (scope) {
     ++	case CONFIG_SCOPE_LOCAL:
      +		return "local";
     -+	} else if (use_global_config || scope == CONFIG_SCOPE_GLOBAL) {
     ++	case CONFIG_SCOPE_GLOBAL:
      +		return "global";
     -+	} else if (use_system_config || scope == CONFIG_SCOPE_SYSTEM) {
     ++	case CONFIG_SCOPE_SYSTEM:
      +		return "system";
     -+	} else if (given_config_source.use_stdin ||
     -+		given_config_source.blob ||
     -+		given_config_source.file ||
     -+		scope == CONFIG_SCOPE_CMDLINE) {
     -+		return "command line";
     -+	} else {
     ++	case CONFIG_SCOPE_WORKTREE:
     ++		return "worktree";
     ++	case CONFIG_SCOPE_COMMAND:
     ++		return "command";
     ++	case CONFIG_SCOPE_SUBMODULE:
     ++		return "submodule";
     ++	default:
      +		return "unknown";
      +	}
      +}
      +
     -+static void show_config_scope(struct strbuf *buf)
     -+{
     ++static void show_config_scope(struct strbuf *buf) {
      +	const char term = end_nul ? '\0' : '\t';
      +	const char *scope = scope_to_string(current_config_scope());
      +
     -+	strbuf_addch(buf, '(');
     -+	if (end_nul)
     -+		strbuf_addstr(buf, N_(scope));
     -+	else
     -+		quote_c_style(scope, buf, NULL, 0);
     -+	strbuf_addch(buf, ')');
     ++	strbuf_addstr(buf, N_(scope));
      +	strbuf_addch(buf, term);
      +}
      +
     @@ -96,33 +109,188 @@
      +	if (show_origin || show_scope) {
       		struct strbuf buf = STRBUF_INIT;
      -		show_config_origin(&buf);
     --		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
      +		if (show_scope)
      +			show_config_scope(&buf);
      +		if (show_origin)
      +			show_config_origin(&buf);
     -+		/* Use fwrite as "buf" can contain \0's if "end_nul" is set. */
     + 		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
       		fwrite(buf.buf, 1, buf.len, stdout);
       		strbuf_release(&buf);
     - 	}
      @@
       
       static int format_config(struct strbuf *buf, const char *key_, const char *value_)
       {
      +	if (show_scope)
     -+		show_config_scope(buf);
     ++		show_config_origin(buf);
       	if (show_origin)
       		show_config_origin(buf);
       	if (show_keys)
      @@
     - 		config_options.git_dir = get_git_dir();
     + 	int nongit = !startup_info->have_repository;
     + 	char *value;
     + 
     ++
     ++
     + 	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
     + 
     + 	argc = parse_options(argc, argv, prefix, builtin_config_options,
     +@@
     + 			!strcmp(given_config_source.file, "-")) {
     + 		given_config_source.file = NULL;
     + 		given_config_source.use_stdin = 1;
     ++		given_config_source.scope = CONFIG_SCOPE_COMMAND;
     + 	}
     + 
     + 	if (use_global_config) {
     +@@
     + 			 */
     + 			die(_("$HOME not set"));
     + 
     ++		given_config_source.scope = CONFIG_SCOPE_GLOBAL;
     ++
     + 		if (access_or_warn(user_config, R_OK, 0) &&
     + 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
     + 			given_config_source.file = xdg_config;
     +@@
     + 			free(xdg_config);
     + 		}
     + 	}
     +-	else if (use_system_config)
     ++	else if (use_system_config) {
     + 		given_config_source.file = git_etc_gitconfig();
     +-	else if (use_local_config)
     ++		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
     ++	} else if (use_local_config) {
     + 		given_config_source.file = git_pathdup("config");
     +-	else if (use_worktree_config) {
     ++		given_config_source.scope = CONFIG_SCOPE_LOCAL;
     ++	} else if (use_worktree_config) {
     + 		struct worktree **worktrees = get_worktrees(0);
     + 		if (repository_format_worktree_config)
     + 			given_config_source.file = git_pathdup("config.worktree");
     +@@
     + 			      "section in \"git help worktree\" for details"));
     + 		else
     + 			given_config_source.file = git_pathdup("config");
     ++		given_config_source.scope = CONFIG_SCOPE_LOCAL;
     + 		free_worktrees(worktrees);
     + 	} else if (given_config_source.file) {
     + 		if (!is_absolute_path(given_config_source.file) && prefix)
     + 			given_config_source.file =
     + 				prefix_filename(prefix, given_config_source.file);
     ++		given_config_source.scope = CONFIG_SCOPE_COMMAND;
     ++	} else if (given_config_source.blob) {
     ++		given_config_source.scope = CONFIG_SCOPE_COMMAND;
     + 	}
     + 
     ++
     + 	if (respect_includes_opt == -1)
     + 		config_options.respect_includes = !given_config_source.file;
     + 	else
     +
     + diff --git a/config.c b/config.c
     + --- a/config.c
     + +++ b/config.c
     +@@
     + 	char *xdg_config = xdg_config_home("config");
     + 	char *user_config = expand_user_path("~/.gitconfig", 0);
     + 	char *repo_config;
     ++	enum config_scope prev_parsing_scope = current_parsing_scope;
     + 
     + 	if (opts->commondir)
     + 		repo_config = mkpathdup("%s/config", opts->commondir);
     +@@
     + 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
     + 		die(_("unable to parse command-line config"));
     + 
     +-	current_parsing_scope = CONFIG_SCOPE_UNKNOWN;
     ++	current_parsing_scope = prev_parsing_scope;
     + 	free(xdg_config);
     + 	free(user_config);
     + 	free(repo_config);
     +@@
     + 		data = &inc;
       	}
       
     --	if (end_null) {
     -+	if (end_nul) {
     - 		term = '\0';
     - 		delim = '\n';
     - 		key_delim = '\n';
     ++	if (config_source)
     ++		current_parsing_scope = config_source->scope;
     ++
     + 	/*
     + 	 * If we have a specific filename, use it. Otherwise, follow the
     + 	 * regular lookup sequence.
     +
     + diff --git a/config.h b/config.h
     + --- a/config.h
     + +++ b/config.h
     +@@
     + 
     + #define CONFIG_REGEX_NONE ((void *)1)
     + 
     ++enum config_scope {
     ++	CONFIG_SCOPE_UNKNOWN = 0,
     ++	CONFIG_SCOPE_SYSTEM,
     ++	CONFIG_SCOPE_GLOBAL,
     ++	CONFIG_SCOPE_LOCAL,
     ++	CONFIG_SCOPE_WORKTREE,
     ++	CONFIG_SCOPE_COMMAND,
     ++	CONFIG_SCOPE_SUBMODULE,
     ++};
     ++
     + struct git_config_source {
     + 	unsigned int use_stdin:1;
     + 	const char *file;
     + 	const char *blob;
     ++	enum config_scope scope;
     + };
     + 
     + enum config_origin_type {
     +@@
     + 
     + int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
     + 
     +-enum config_scope {
     +-	CONFIG_SCOPE_UNKNOWN = 0,
     +-	CONFIG_SCOPE_SYSTEM,
     +-	CONFIG_SCOPE_GLOBAL,
     +-	CONFIG_SCOPE_LOCAL,
     +-	CONFIG_SCOPE_WORKTREE,
     +-	CONFIG_SCOPE_COMMAND,
     +-};
     +-
     + enum config_scope current_config_scope(void);
     + const char *current_config_origin_type(void);
     + const char *current_config_name(void);
     +
     + diff --git a/submodule-config.c b/submodule-config.c
     + --- a/submodule-config.c
     + +++ b/submodule-config.c
     +@@
     + static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
     + {
     + 	if (repo->worktree) {
     +-		struct git_config_source config_source = { 0 };
     ++		struct git_config_source config_source = {
     ++			0, .scope = CONFIG_SCOPE_SUBMODULE
     ++		};
     + 		const struct config_options opts = { 0 };
     + 		struct object_id oid;
     + 		char *file;
     +
     + diff --git a/t/helper/test-config.c b/t/helper/test-config.c
     + --- a/t/helper/test-config.c
     + +++ b/t/helper/test-config.c
     +@@
     + 		return "repo";
     + 	case CONFIG_SCOPE_WORKTREE:
     + 		return "worktree";
     ++	case CONFIG_SCOPE_SUBMODULE:
     ++		return "submodule";
     + 	case CONFIG_SCOPE_COMMAND:
     +-		return "command";
     ++		return "cmdline";
     + 	default:
     + 		return "unknown";
     + 	}
      
       diff --git a/t/t1300-config.sh b/t/t1300-config.sh
       --- a/t/t1300-config.sh
     @@ -131,18 +299,17 @@
       	test_cmp expect output
       '
       
     -+
      +test_expect_success '--show-scope with --list' '
      +	cat >expect <<-EOF &&
     -+		(global)	user.global=true
     -+		(global)	user.override=global
     -+		(global)	include.path=$INCLUDE_DIR/absolute.include
     -+		(global)	user.absolute=include
     -+		(local)	user.local=true
     -+		(local)	user.override=local
     -+		(local)	include.path=../include/relative.include
     -+		(local)	user.relative=include
     -+		(command line)	user.cmdline=true
     ++		global	user.global=true
     ++		global	user.override=global
     ++		global	include.path=$INCLUDE_DIR/absolute.include
     ++		global	user.absolute=include
     ++		local	user.local=true
     ++		local	user.override=local
     ++		local	include.path=../include/relative.include
     ++		local	user.relative=include
     ++		command	user.cmdline=true
      +	EOF
      +	git -c user.cmdline=true config --list --show-scope >output &&
      +	test_cmp expect output
     @@ -151,16 +318,16 @@
      +test_expect_success !MINGW '--show-scope with --blob' '
      +	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
      +	cat >expect <<-EOF &&
     -+		(command line)	user.custom=true
     ++		command	user.custom=true
      +	EOF
      +	git config --blob=$blob --show-scope --list >output &&
      +	test_cmp expect output
      +'
      +test_expect_success '--show-scope with --local' '
      +	cat >expect <<-\EOF &&
     -+		(local)	user.local=true
     -+		(local)	user.override=local
     -+		(local)	include.path=../include/relative.include
     ++		local	user.local=true
     ++		local	user.override=local
     ++		local	include.path=../include/relative.include
      +	EOF
      +	git config --local --list --show-scope >output &&
      +	test_cmp expect output
     @@ -168,15 +335,15 @@
      +
      +test_expect_success '--show-scope with --show-origin' '
      +	cat >expect <<-EOF &&
     -+		(global)	file:$HOME/.gitconfig	user.global=true
     -+		(global)	file:$HOME/.gitconfig	user.override=global
     -+		(global)	file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
     -+		(global)	file:$INCLUDE_DIR/absolute.include	user.absolute=include
     -+		(local)	file:.git/config	user.local=true
     -+		(local)	file:.git/config	user.override=local
     -+		(local)	file:.git/config	include.path=../include/relative.include
     -+		(local)	file:.git/../include/relative.include	user.relative=include
     -+		(command line)	command line:	user.cmdline=true
     ++		global	file:$HOME/.gitconfig	user.global=true
     ++		global	file:$HOME/.gitconfig	user.override=global
     ++		global	file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
     ++		global	file:$INCLUDE_DIR/absolute.include	user.absolute=include
     ++		local	file:.git/config	user.local=true
     ++		local	file:.git/config	user.override=local
     ++		local	file:.git/config	include.path=../include/relative.include
     ++		local	file:.git/../include/relative.include	user.relative=include
     ++		command	command line:	user.cmdline=true
      +	EOF
      +	git -c user.cmdline=true config --list --show-origin --show-scope >output &&
      +	test_cmp expect output

-- 
gitgitgadget
