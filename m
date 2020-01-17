Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F86C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCD42073A
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUDuC1xZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgAQPbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:31:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50333 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgAQPbr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 10:31:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so7872043wmb.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 07:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+4/0dIYZ7kCBco6IlkCI9kkI7auTuZXDgQMRPQv7stM=;
        b=fUDuC1xZICJSDoBgKipiIBPM4nuC6R4oXIDmjXJ8VEQDGGUh+o6XOCGmKqztwxSOx5
         a1lJeAtGYXEeVpidADA3LNyvDfH70tGQ6xcyHuY5ksypZ4wxOW01NB3F4YvJfhTaWP8l
         RViHlW3grou9yktb4QbPBBp4frrx97q4+Lfay85NJNC3KaIr6zB8ARocfN/Vms2ZHObD
         W9dQmcPxGh5D+GszBX67SXKz6b2I8kG6GLOrPdcHtEagZz3k1lb8Vdxo4pg7ctJRb8iD
         F4R8cfab96CrDY6JpEyNGYdQh0NR9L2es1HILbnqYbSiTVMyIGrAW/W3mCfBdHrxg77S
         Z1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+4/0dIYZ7kCBco6IlkCI9kkI7auTuZXDgQMRPQv7stM=;
        b=lWWW85mWTbVZiW93YxoVO5qNE0u889YNkj+Dxm1kJhfEOwBaBpj1/1uq88aExWivXF
         FQsErB1lf8GZ3HlmSUy6FyHDpu2oSKCn1JKEIwFMFF76eQCcqau9zHw9cVD5aXiRbFzJ
         3nkBXuvC5j8Ivvo2VH4mOprBIygRsCfhtyvCKgwbme9tNYZzLL0RybqpEyryUomyszib
         ihYwAXaltvD3+mNwPIf5RQzeeIOV0/qPlvGRCO/xo/e19mgJn5uWZbONRcfA7NIYYAJJ
         hDwjC701L/kM9bWnwb+znawqrZeUgpBx/2R/VQQZ50g4kFYct3eL1fVKuBUbiWJ+qfkf
         QxBw==
X-Gm-Message-State: APjAAAVWEe922VUtZZj2WknXw7+FLDfD5ZWalaVSCJtR9eZNJJErrIVX
        6E7hTIcqQEE9jQMRZgylZPjQJHJk
X-Google-Smtp-Source: APXvYqyK9go/J/zzztJMCuG7j1Xant0u3KAB3SiIu48e3XGJwoK0VfRO2kaCpDhyKtDfB23CqiOIZQ==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr5322689wmi.46.1579275103677;
        Fri, 17 Jan 2020 07:31:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm34922700wra.83.2020.01.17.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 07:31:43 -0800 (PST)
Message-Id: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
References: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 15:31:38 +0000
Subject: [PATCH v3 0/4] config: allow user to know scope of config options
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

changes since v2:

 * Redid commit messages for content/clarity
 * Minor fixes around using --show-scope with a single value (format_config)

Matthew Rogers (4):
  config: fix typo in variable name
  config: refine config scope enum
  config: clarify meaning of command line scoping
  config: add '--show-scope' to print the scope of a config value

 Documentation/git-config.txt | 15 +++++---
 builtin/config.c             | 66 ++++++++++++++++++++++++++++++------
 config.c                     | 15 ++++----
 config.h                     | 19 ++++++-----
 remote.c                     |  3 +-
 submodule-config.c           |  4 ++-
 t/helper/test-config.c       | 10 ++++--
 t/t1300-config.sh            | 58 +++++++++++++++++++++++++++++++
 t/t1308-config-set.sh        |  2 +-
 upload-pack.c                |  3 +-
 10 files changed, 158 insertions(+), 37 deletions(-)


base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-478%2FROGERSM94%2Fadd-config-flags-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-478/ROGERSM94/add-config-flags-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/478

Range-diff vs v2:

 1:  b40480f03a = 1:  f5a81a4d25 config: fix typo in variable name
 2:  e8e05f3940 ! 2:  f06f9291b7 config: fix config scope enum
     @@ -1,14 +1,21 @@
      Author: Matthew Rogers <mattr94@gmail.com>
      
     -    config: fix config scope enum
     +    config: refine config scope enum
      
          Previously when iterating through git config variables, worktree config
          and local config were both considered "CONFIG_SCOPE_REPO".  This was
          never a problem before as no one had needed to differentiate between the
     -    two cases.
     +    two cases, but future functionality may care whether or not the config
     +    options come from a worktree or from the repository's actual local
     +    config file.  For example, the planned feature to add a '--show-scope'
     +    to config to allow a user to see which scope listed config options come
     +    from would confuse users if it just printed 'repo' rather than 'local'
     +    or 'worktree' as the documentation would lead them to expect.  As well
     +    as the additional benefit of making the implementation look more like
     +    how the documentation describes the interface.
      
     -    Additionally we rename what was CONFIG_SCOPE_REPO to CONFIG_SCOPE_LOCAL
     -    to reflect its new, more specific meaning.
     +    To accomplish this we split out what was previously considered repo
     +    scope to be local and worktree.
      
          The clients of 'current_config_scope()' who cared about
          CONFIG_SCOPE_REPO are also modified to similarly care about
     @@ -82,6 +89,19 @@
       		return "cmdline";
       	default:
      
     + diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
     + --- a/t/t1308-config-set.sh
     + +++ b/t/t1308-config-set.sh
     +@@
     + 	value=from-cmdline
     + 	origin=command line
     + 	name=
     +-	scope=cmdline
     ++	scope=command
     + 	EOF
     + 	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
     + 	test_cmp expect actual
     +
       diff --git a/upload-pack.c b/upload-pack.c
       --- a/upload-pack.c
       +++ b/upload-pack.c
 3:  8225273546 ! 3:  97b8a7641d config: clarify meaning of command line scoping
     @@ -3,11 +3,13 @@
          config: clarify meaning of command line scoping
      
          CONFIG_SCOPE_CMDLINE is generally used in the code to refer to config
     -    values passed in via the -c option.  This is a little bit too specific
     -    as there are other methods to pass config values so that the last for a
     -    single command (namely --file and --blob).  As the "visibility" of config
     -    values passed by these situations is common, we unify them as having a
     -    scope of "command" rather than "command line".
     +    values passed in via the -c option.  Options passed in using this
     +    mechanism share similar scoping characteristics with the --file and
     +    --blob options of the 'config' command, namely that they are only in use
     +    for that single invocation of git, and that they supersede the normal
     +    system/global/local hierarchy.  This patch introduces
     +    CONFIG_SCOPE_COMMAND to reflect this new idea, which also makes
     +    CONFIG_SCOPE_CMDLINE redundant.
      
          Signed-off-by: Matthew Rogers <mattr94@gmail.com>
      
 4:  92ce9b7824 ! 4:  61ff3c64b5 config: add '--show-scope' to print the scope of a config value
     @@ -76,7 +76,8 @@
       	strbuf_addch(buf, term);
       }
       
     -+static const char *scope_to_string(enum config_scope scope) {
     ++static const char *scope_to_string(enum config_scope scope)
     ++{
      +	switch (scope) {
      +	case CONFIG_SCOPE_LOCAL:
      +		return "local";
     @@ -95,7 +96,8 @@
      +	}
      +}
      +
     -+static void show_config_scope(struct strbuf *buf) {
     ++static void show_config_scope(struct strbuf *buf)
     ++{
      +	const char term = end_nul ? '\0' : '\t';
      +	const char *scope = scope_to_string(current_config_scope());
      +
     @@ -121,19 +123,10 @@
       static int format_config(struct strbuf *buf, const char *key_, const char *value_)
       {
      +	if (show_scope)
     -+		show_config_origin(buf);
     ++		show_config_scope(buf);
       	if (show_origin)
       		show_config_origin(buf);
       	if (show_keys)
     -@@
     - 	int nongit = !startup_info->have_repository;
     - 	char *value;
     - 
     -+
     -+
     - 	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
     - 
     - 	argc = parse_options(argc, argv, prefix, builtin_config_options,
      @@
       			!strcmp(given_config_source.file, "-")) {
       		given_config_source.file = NULL;
     @@ -286,11 +279,8 @@
      +	case CONFIG_SCOPE_SUBMODULE:
      +		return "submodule";
       	case CONFIG_SCOPE_COMMAND:
     --		return "command";
     -+		return "cmdline";
     + 		return "command";
       	default:
     - 		return "unknown";
     - 	}
      
       diff --git a/t/t1300-config.sh b/t/t1300-config.sh
       --- a/t/t1300-config.sh
     @@ -333,6 +323,14 @@
      +	test_cmp expect output
      +'
      +
     ++test_expect_success '--show-scope getting a single value' '
     ++	cat >expect <<-\EOF &&
     ++		local	true
     ++	EOF
     ++	git config --show-scope --get user.local >output &&
     ++	test_cmp expect output
     ++'
     ++
      +test_expect_success '--show-scope with --show-origin' '
      +	cat >expect <<-EOF &&
      +		global	file:$HOME/.gitconfig	user.global=true

-- 
gitgitgadget
