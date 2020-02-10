Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A46C352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4B0208C4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxyfJqwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgBJAbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:31:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36180 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgBJAbF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 19:31:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so5431371wru.3
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 16:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jd9DN3bvs8ygoVZclbo3F/QdjEiaVQ+PZRNFTBuHDcM=;
        b=nxyfJqwry/RXgTCTLFXlLUNC+S3wTsRCJaPQui8+hL8xtiRVGReMrmVT+jF16WWzQO
         viKmJLJOhoUpLUd6dzPUz8evyU3Ex4Nxf+ydAekB6sIgdmwJHpoSWu83EORsxIurkIXP
         d0D3gLXXjGKaLXtlchF3RSilrR//URJCV1iZ0asmCrDLCTNGMfBnEX497BXh426kTJ9k
         8vLFj4vQZX55yaiOovYWM5ez/6R1twmJGVQP2Y6203THYt7g/3HPjwQ+XyXw1kqc3aNg
         7rMGkirfSKuJa1z2nj9d8tEnx+MxCbeFmTywP4Sak6GYMuZqFoHfcs2D8q+T98qqavPW
         3ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jd9DN3bvs8ygoVZclbo3F/QdjEiaVQ+PZRNFTBuHDcM=;
        b=sGURkSJwhM6NFrJ6/ckozpoGXDO6P0vJHn4/hN4pa3vUEDtmBreAsNkJJp15zhQn7+
         K+gv+AQ1VL1PWVDweZUPofGc5X8yutBKzQklQvAer0DDNzvZqCcfkDym35xCkbQoPn99
         KAASwXGdZe0zccU1JmhhPLYovPa21cqEPvTcM86WpFwvTqMgM+rz0MJII/P9NM6Qd8Yu
         jRvX21zyh4OhCc2WTen5Kf+Rg/US/Z7+lBsFkd5hm32erLRiUTJf8MjUxQCtmh4A0VVG
         /wzlOcArMpZSYfXGUItiHO1Pq5o+Jia3QdLRU+Noqpb6Z+FHlKOclH6SFcoWF0h3+n3l
         ZMtA==
X-Gm-Message-State: APjAAAVBWOf9SDv4A2fC+kn1jYWgVszQoqKhXU3NJSXjusKqrI6H+1xl
        vtRPsXbf4kl8+iDCgf0Vu1lo85Ef
X-Google-Smtp-Source: APXvYqzsykB/HeBE1kygZzBqznAHeNEQcqXNi8sghlVtfd3iPvgkMP8jtoQa84Lw0Bfp6v/HTS/dzQ==
X-Received: by 2002:adf:f182:: with SMTP id h2mr13082816wro.364.1581294661493;
        Sun, 09 Feb 2020 16:31:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm14503806wrw.36.2020.02.09.16.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:31:00 -0800 (PST)
Message-Id: <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 00:30:49 +0000
Subject: [PATCH v7 00/10] config: allow user to know scope of config options
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

changes since v6: Split patch 6: config: add '--show-scope'... into several
parts, including moving the exposure of config_scope_name into its own
commit earlier in the series.

Matthew Rogers (10):
  config: fix typo in variable name
  t1300: fix over-indented HERE-DOCs
  t1300: create custom config file without special characters
  config: make scope_name non-static and rename it
  config: split repo scope to local and worktree
  config: clarify meaning of command line scoping
  config: preserve scope in do_git_config_sequence
  config: teach git_config_source to remember its scope
  submodule-config: add subomdule config scope
  config: add '--show-scope' to print the scope of a config value

 Documentation/git-config.txt |  15 ++-
 builtin/config.c             |  46 +++++--
 config.c                     |  35 ++++-
 config.h                     |  20 +--
 remote.c                     |   3 +-
 submodule-config.c           |   4 +-
 t/helper/test-config.c       |  17 +--
 t/t1300-config.sh            | 240 ++++++++++++++++++++++-------------
 t/t1308-config-set.sh        |   4 +-
 upload-pack.c                |   3 +-
 10 files changed, 248 insertions(+), 139 deletions(-)


base-commit: de93cc14ab7e8db7645d8dbe4fd2603f76d5851f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-478%2FROGERSM94%2Fadd-config-flags-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-478/ROGERSM94/add-config-flags-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/478

Range-diff vs v6:

  1:  18f92f70cf =  1:  1c4faa7a36 config: fix typo in variable name
  2:  dc7b3f3b96 =  2:  2c38c72f89 t1300: fix over-indented HERE-DOCs
  3:  975e652368 =  3:  c832293ca7 t1300: create custom config file without special characters
  -:  ---------- >  4:  14b0f27819 config: make scope_name non-static and rename it
  4:  1e406ba430 !  5:  1af0237b8e config: split repo scope to local and worktree
     @@ -45,6 +45,19 @@
       	if (!opts->ignore_worktree && repository_format_worktree_config) {
       		char *path = git_pathdup("config.worktree");
       		if (!access_or_die(path, R_OK, 0))
     +@@
     + 		return "system";
     + 	case CONFIG_SCOPE_GLOBAL:
     + 		return "global";
     +-	case CONFIG_SCOPE_REPO:
     +-		return "repo";
     ++	case CONFIG_SCOPE_LOCAL:
     ++		return "local";
     ++	case CONFIG_SCOPE_WORKTREE:
     ++		return "worktree";
     + 	case CONFIG_SCOPE_CMDLINE:
     + 		return "command line";
     + 	default:
      
       diff --git a/config.h b/config.h
       --- a/config.h
     @@ -58,7 +71,7 @@
      +	CONFIG_SCOPE_WORKTREE,
       	CONFIG_SCOPE_CMDLINE,
       };
     - 
     + const char *config_scope_name(enum config_scope scope);
      
       diff --git a/remote.c b/remote.c
       --- a/remote.c
     @@ -74,23 +87,6 @@
       	if (!strcmp(subkey, "mirror"))
       		remote->mirror = git_config_bool(key, value);
      
     - diff --git a/t/helper/test-config.c b/t/helper/test-config.c
     - --- a/t/helper/test-config.c
     - +++ b/t/helper/test-config.c
     -@@
     - 		return "system";
     - 	case CONFIG_SCOPE_GLOBAL:
     - 		return "global";
     --	case CONFIG_SCOPE_REPO:
     --		return "repo";
     -+	case CONFIG_SCOPE_LOCAL:
     -+		return "local";
     -+	case CONFIG_SCOPE_WORKTREE:
     -+		return "worktree";
     - 	case CONFIG_SCOPE_CMDLINE:
     - 		return "cmdline";
     - 	default:
     -
       diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
       --- a/t/t1308-config-set.sh
       +++ b/t/t1308-config-set.sh
  5:  936ce91c62 !  6:  64c20d0556 config: clarify meaning of command line scoping
     @@ -26,6 +26,17 @@
       	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
       		die(_("unable to parse command-line config"));
       
     +@@
     + 		return "local";
     + 	case CONFIG_SCOPE_WORKTREE:
     + 		return "worktree";
     +-	case CONFIG_SCOPE_CMDLINE:
     +-		return "command line";
     ++	case CONFIG_SCOPE_COMMAND:
     ++		return "command";
     + 	default:
     + 		return "unknown";
     + 	}
      
       diff --git a/config.h b/config.h
       --- a/config.h
     @@ -37,23 +48,8 @@
      -	CONFIG_SCOPE_CMDLINE,
      +	CONFIG_SCOPE_COMMAND,
       };
     + const char *config_scope_name(enum config_scope scope);
       
     - enum config_scope current_config_scope(void);
     -
     - diff --git a/t/helper/test-config.c b/t/helper/test-config.c
     - --- a/t/helper/test-config.c
     - +++ b/t/helper/test-config.c
     -@@
     - 		return "local";
     - 	case CONFIG_SCOPE_WORKTREE:
     - 		return "worktree";
     --	case CONFIG_SCOPE_CMDLINE:
     --		return "cmdline";
     -+	case CONFIG_SCOPE_COMMAND:
     -+		return "command";
     - 	default:
     - 		return "unknown";
     - 	}
      
       diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
       --- a/t/t1308-config-set.sh
     @@ -62,7 +58,7 @@
       	value=from-cmdline
       	origin=command line
       	name=
     --	scope=cmdline
     +-	scope=command line
      +	scope=command
       	EOF
       	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
  -:  ---------- >  7:  f61985375c config: preserve scope in do_git_config_sequence
  -:  ---------- >  8:  6c59c5cace config: teach git_config_source to remember its scope
  -:  ---------- >  9:  dd376246ec submodule-config: add subomdule config scope
  6:  fc141e8689 ! 10:  f76463ee90 config: add '--show-scope' to print the scope of a config value
     @@ -12,7 +12,6 @@
          parsing the '.gitmodules' file.
      
          Signed-off-by: Matthew Rogers <mattr94@gmail.com>
     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
       --- a/Documentation/git-config.txt
     @@ -108,212 +107,6 @@
       	if (show_origin)
       		show_config_origin(buf);
       	if (show_keys)
     -@@
     - 			!strcmp(given_config_source.file, "-")) {
     - 		given_config_source.file = NULL;
     - 		given_config_source.use_stdin = 1;
     -+		given_config_source.scope = CONFIG_SCOPE_COMMAND;
     - 	}
     - 
     - 	if (use_global_config) {
     -@@
     - 			 */
     - 			die(_("$HOME not set"));
     - 
     -+		given_config_source.scope = CONFIG_SCOPE_GLOBAL;
     -+
     - 		if (access_or_warn(user_config, R_OK, 0) &&
     - 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
     - 			given_config_source.file = xdg_config;
     -@@
     - 			free(xdg_config);
     - 		}
     - 	}
     --	else if (use_system_config)
     -+	else if (use_system_config) {
     - 		given_config_source.file = git_etc_gitconfig();
     --	else if (use_local_config)
     -+		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
     -+	} else if (use_local_config) {
     - 		given_config_source.file = git_pathdup("config");
     --	else if (use_worktree_config) {
     -+		given_config_source.scope = CONFIG_SCOPE_LOCAL;
     -+	} else if (use_worktree_config) {
     - 		struct worktree **worktrees = get_worktrees(0);
     - 		if (repository_format_worktree_config)
     - 			given_config_source.file = git_pathdup("config.worktree");
     -@@
     - 			      "section in \"git help worktree\" for details"));
     - 		else
     - 			given_config_source.file = git_pathdup("config");
     -+		given_config_source.scope = CONFIG_SCOPE_LOCAL;
     - 		free_worktrees(worktrees);
     - 	} else if (given_config_source.file) {
     - 		if (!is_absolute_path(given_config_source.file) && prefix)
     - 			given_config_source.file =
     - 				prefix_filename(prefix, given_config_source.file);
     -+		given_config_source.scope = CONFIG_SCOPE_COMMAND;
     -+	} else if (given_config_source.blob) {
     -+		given_config_source.scope = CONFIG_SCOPE_COMMAND;
     - 	}
     - 
     -+
     - 	if (respect_includes_opt == -1)
     - 		config_options.respect_includes = !given_config_source.file;
     - 	else
     -
     - diff --git a/config.c b/config.c
     - --- a/config.c
     - +++ b/config.c
     -@@
     - 	char *xdg_config = xdg_config_home("config");
     - 	char *user_config = expand_user_path("~/.gitconfig", 0);
     - 	char *repo_config;
     -+	enum config_scope prev_parsing_scope = current_parsing_scope;
     - 
     - 	if (opts->commondir)
     - 		repo_config = mkpathdup("%s/config", opts->commondir);
     -@@
     - 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
     - 		die(_("unable to parse command-line config"));
     - 
     --	current_parsing_scope = CONFIG_SCOPE_UNKNOWN;
     -+	current_parsing_scope = prev_parsing_scope;
     - 	free(xdg_config);
     - 	free(user_config);
     - 	free(repo_config);
     -@@
     - 		data = &inc;
     - 	}
     - 
     -+	if (config_source)
     -+		current_parsing_scope = config_source->scope;
     -+
     - 	/*
     - 	 * If we have a specific filename, use it. Otherwise, follow the
     - 	 * regular lookup sequence.
     -@@
     - 	}
     - }
     - 
     -+const char *config_scope_name(enum config_scope scope)
     -+{
     -+	switch (scope) {
     -+	case CONFIG_SCOPE_SYSTEM:
     -+		return "system";
     -+	case CONFIG_SCOPE_GLOBAL:
     -+		return "global";
     -+	case CONFIG_SCOPE_LOCAL:
     -+		return "local";
     -+	case CONFIG_SCOPE_WORKTREE:
     -+		return "worktree";
     -+	case CONFIG_SCOPE_COMMAND:
     -+		return "command";
     -+	case CONFIG_SCOPE_SUBMODULE:
     -+		return "submodule";
     -+	default:
     -+		return "unknown";
     -+	}
     -+}
     -+
     - const char *current_config_name(void)
     - {
     - 	const char *name;
     -
     - diff --git a/config.h b/config.h
     - --- a/config.h
     - +++ b/config.h
     -@@
     - 
     - #define CONFIG_REGEX_NONE ((void *)1)
     - 
     -+enum config_scope {
     -+	CONFIG_SCOPE_UNKNOWN = 0,
     -+	CONFIG_SCOPE_SYSTEM,
     -+	CONFIG_SCOPE_GLOBAL,
     -+	CONFIG_SCOPE_LOCAL,
     -+	CONFIG_SCOPE_WORKTREE,
     -+	CONFIG_SCOPE_COMMAND,
     -+	CONFIG_SCOPE_SUBMODULE,
     -+};
     -+const char *config_scope_name(enum config_scope scope);
     -+
     - struct git_config_source {
     - 	unsigned int use_stdin:1;
     - 	const char *file;
     - 	const char *blob;
     -+	enum config_scope scope;
     - };
     - 
     - enum config_origin_type {
     -@@
     - 
     - int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
     - 
     --enum config_scope {
     --	CONFIG_SCOPE_UNKNOWN = 0,
     --	CONFIG_SCOPE_SYSTEM,
     --	CONFIG_SCOPE_GLOBAL,
     --	CONFIG_SCOPE_LOCAL,
     --	CONFIG_SCOPE_WORKTREE,
     --	CONFIG_SCOPE_COMMAND,
     --};
     --
     - enum config_scope current_config_scope(void);
     - const char *current_config_origin_type(void);
     - const char *current_config_name(void);
     -
     - diff --git a/submodule-config.c b/submodule-config.c
     - --- a/submodule-config.c
     - +++ b/submodule-config.c
     -@@
     - static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
     - {
     - 	if (repo->worktree) {
     --		struct git_config_source config_source = { 0 };
     -+		struct git_config_source config_source = {
     -+			0, .scope = CONFIG_SCOPE_SUBMODULE
     -+		};
     - 		const struct config_options opts = { 0 };
     - 		struct object_id oid;
     - 		char *file;
     -
     - diff --git a/t/helper/test-config.c b/t/helper/test-config.c
     - --- a/t/helper/test-config.c
     - +++ b/t/helper/test-config.c
     -@@
     -  *
     -  */
     - 
     --static const char *scope_name(enum config_scope scope)
     --{
     --	switch (scope) {
     --	case CONFIG_SCOPE_SYSTEM:
     --		return "system";
     --	case CONFIG_SCOPE_GLOBAL:
     --		return "global";
     --	case CONFIG_SCOPE_LOCAL:
     --		return "local";
     --	case CONFIG_SCOPE_WORKTREE:
     --		return "worktree";
     --	case CONFIG_SCOPE_COMMAND:
     --		return "command";
     --	default:
     --		return "unknown";
     --	}
     --}
     - static int iterate_cb(const char *var, const char *value, void *data)
     - {
     - 	static int nr;
     -@@
     - 	printf("value=%s\n", value ? value : "(null)");
     - 	printf("origin=%s\n", current_config_origin_type());
     - 	printf("name=%s\n", current_config_name());
     --	printf("scope=%s\n", scope_name(current_config_scope()));
     -+	printf("scope=%s\n", config_scope_name(current_config_scope()));
     - 
     - 	return 0;
     - }
      
       diff --git a/t/t1300-config.sh b/t/t1300-config.sh
       --- a/t/t1300-config.sh

-- 
gitgitgadget
