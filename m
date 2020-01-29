Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3152C35240
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8178E20CC7
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUdEAby6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgA2Dea (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:34:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53723 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgA2Dea (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 22:34:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id s10so4700521wmh.3
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 19:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OZb8IkjcugDAEIWLQe9DuRCfRire0qjp8rF3yU+NiIM=;
        b=OUdEAby66lo56dwHdjuP7L66ZMM4uVdLV+JkbpXm9uKkHa9tQ1wmSF+qW5TgQqeNSr
         hUaOtTgcKHDqMRbxirSVDfS+r+WAbWydB93YV9D3Wk79oP64kcewxn59My+JanTja3Tz
         kdnKiMzL61V1sYyHA+J78Q5spooXovxi8g7Ty8YuK3cHeCPX+4U/UCjmZMYnK7z6zWLh
         Bfx5UweonHr+/LVSTCPPCzlXgvUbT66tTit6HsnWtF+E2to+CqWj+JvfK11ie69LTEtB
         XEUkoVB8aJSOY9Q0DReke4emOeQxyjxhR5wpF9PJ4+ZduDRB7eMYzoSFs9iO1pYx7fQX
         t3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OZb8IkjcugDAEIWLQe9DuRCfRire0qjp8rF3yU+NiIM=;
        b=ezfn+SVc/qeci0a1ceVCTrPaECIPjLe3fnPrLTEEw7fUVkwUNpilw1WcJDAehlsvo6
         6F38phqQzIooAhDxLx2QMUe1uBF17vQY4ul7QXcEAMCvUtDuc2iol6QtMWmtPhb1uSN3
         LJvluUKPpYotuslI+OTCOrhejwNsq/Wb95mKf4attZVORvTpk5qEzV8Cte2MpZ1oRoy1
         hkk9K48shAyBo9ISThU+e2zfmyhjsat19RwUkkBm3cDt5D2oIVu9zu3op0uGu6QH91KF
         zxbm3HtujmP7HGSg0SWYmtMYg8hp2BWUiJmhleX6YGGUtEDjccSLL3+HeLvNuSECJ8xe
         7xEg==
X-Gm-Message-State: APjAAAWkiAiftOdmeslnu/CE1kee0e/sTqL4xM7QNxEEeIvjUCgfCn1f
        hp42LgN8OK7vTearkK0HM9ab0JnI
X-Google-Smtp-Source: APXvYqx9XY2EJdd+Jees78ocr64txgIHnRMcU/b7X9X6JFtaHZuA8E+E4qKTQVV+//J+C51xE84t3Q==
X-Received: by 2002:a7b:c209:: with SMTP id x9mr930435wmi.0.1580268866993;
        Tue, 28 Jan 2020 19:34:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm949524wrv.96.2020.01.28.19.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 19:34:26 -0800 (PST)
Message-Id: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
References: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jan 2020 03:34:19 +0000
Subject: [PATCH v6 0/6] config: allow user to know scope of config options
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

changes since v4:

 * final cleanups

Matthew Rogers (6):
  config: fix typo in variable name
  t1300: fix over-indented HERE-DOCs
  t1300: create custom config file without special characters
  config: split repo scope to local and worktree
  config: clarify meaning of command line scoping
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


base-commit: c7a62075917b3340f908093f63f1161c44ed1475
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-478%2FROGERSM94%2Fadd-config-flags-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-478/ROGERSM94/add-config-flags-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/478

Range-diff vs v5:

 1:  f5a81a4d25 ! 1:  18f92f70cf config: fix typo in variable name
     @@ -8,6 +8,7 @@
          malapropism is being fixed.
      
          Signed-off-by: Matthew Rogers <mattr94@gmail.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       diff --git a/builtin/config.c b/builtin/config.c
       --- a/builtin/config.c
 2:  1b42f85399 ! 2:  dc7b3f3b96 t1300: fix over-indented HERE-DOCs
     @@ -6,6 +6,7 @@
          HERE-DOCs used in config tests.
      
          Signed-off-by: Matthew Rogers <mattr94@gmail.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       diff --git a/t/t1300-config.sh b/t/t1300-config.sh
       --- a/t/t1300-config.sh
 3:  9d19794dfd ! 3:  975e652368 t1300: create custom config file without special characters
     @@ -12,6 +12,7 @@
          appropriate for general use.
      
          Signed-off-by: Matthew Rogers <mattr94@gmail.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       diff --git a/t/t1300-config.sh b/t/t1300-config.sh
       --- a/t/t1300-config.sh
 4:  9f160e281a ! 4:  1e406ba430 config: split repo scope to local and worktree
     @@ -22,6 +22,7 @@
          CONFIG_SCOPE_WORKTREE and CONFIG_SCOPE_LOCAL to preserve previous behavior.
      
          Signed-off-by: Matthew Rogers <mattr94@gmail.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       diff --git a/config.c b/config.c
       --- a/config.c
     @@ -81,8 +82,9 @@
       	case CONFIG_SCOPE_GLOBAL:
       		return "global";
      -	case CONFIG_SCOPE_REPO:
     +-		return "repo";
      +	case CONFIG_SCOPE_LOCAL:
     - 		return "repo";
     ++		return "local";
      +	case CONFIG_SCOPE_WORKTREE:
      +		return "worktree";
       	case CONFIG_SCOPE_CMDLINE:
 5:  7f00f8559d ! 5:  936ce91c62 config: clarify meaning of command line scoping
     @@ -12,6 +12,7 @@
          CONFIG_SCOPE_CMDLINE redundant.
      
          Signed-off-by: Matthew Rogers <mattr94@gmail.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       diff --git a/config.c b/config.c
       --- a/config.c
     @@ -43,7 +44,7 @@
       --- a/t/helper/test-config.c
       +++ b/t/helper/test-config.c
      @@
     - 		return "repo";
     + 		return "local";
       	case CONFIG_SCOPE_WORKTREE:
       		return "worktree";
      -	case CONFIG_SCOPE_CMDLINE:
 6:  2e979d9fa5 ! 6:  fc141e8689 config: add '--show-scope' to print the scope of a config value
     @@ -12,6 +12,7 @@
          parsing the '.gitmodules' file.
      
          Signed-off-by: Matthew Rogers <mattr94@gmail.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
       --- a/Documentation/git-config.txt
     @@ -46,7 +47,7 @@
       
      +--show-scope::
      +	Similar to `--show-origin` in that it augments the output of
     -+	all queried config options with the scope of that value 
     ++	all queried config options with the scope of that value
      +	(local, global, system, command).
      +
       --get-colorbool name [stdout-is-tty]::
     @@ -79,7 +80,7 @@
      +static void show_config_scope(struct strbuf *buf)
      +{
      +	const char term = end_nul ? '\0' : '\t';
     -+	const char *scope = scope_to_string(current_config_scope());
     ++	const char *scope = config_scope_name(current_config_scope());
      +
      +	strbuf_addstr(buf, N_(scope));
      +	strbuf_addch(buf, term);
     @@ -195,7 +196,7 @@
       	}
       }
       
     -+const char *scope_to_string(enum config_scope scope)
     ++const char *config_scope_name(enum config_scope scope)
      +{
      +	switch (scope) {
      +	case CONFIG_SCOPE_SYSTEM:
     @@ -235,7 +236,7 @@
      +	CONFIG_SCOPE_COMMAND,
      +	CONFIG_SCOPE_SUBMODULE,
      +};
     -+const char *scope_to_string(enum config_scope scope);
     ++const char *config_scope_name(enum config_scope scope);
      +
       struct git_config_source {
       	unsigned int use_stdin:1;
     @@ -292,7 +293,7 @@
      -	case CONFIG_SCOPE_GLOBAL:
      -		return "global";
      -	case CONFIG_SCOPE_LOCAL:
     --		return "repo";
     +-		return "local";
      -	case CONFIG_SCOPE_WORKTREE:
      -		return "worktree";
      -	case CONFIG_SCOPE_COMMAND:
     @@ -309,7 +310,7 @@
       	printf("origin=%s\n", current_config_origin_type());
       	printf("name=%s\n", current_config_name());
      -	printf("scope=%s\n", scope_name(current_config_scope()));
     -+	printf("scope=%s\n", scope_to_string(current_config_scope()));
     ++	printf("scope=%s\n", config_scope_name(current_config_scope()));
       
       	return 0;
       }
     @@ -323,15 +324,15 @@
       
      +test_expect_success '--show-scope with --list' '
      +	cat >expect <<-EOF &&
     -+		global	user.global=true
     -+		global	user.override=global
     -+		global	include.path=$INCLUDE_DIR/absolute.include
     -+		global	user.absolute=include
     -+		local	user.local=true
     -+		local	user.override=local
     -+		local	include.path=../include/relative.include
     -+		local	user.relative=include
     -+		command	user.cmdline=true
     ++	global	user.global=true
     ++	global	user.override=global
     ++	global	include.path=$INCLUDE_DIR/absolute.include
     ++	global	user.absolute=include
     ++	local	user.local=true
     ++	local	user.override=local
     ++	local	include.path=../include/relative.include
     ++	local	user.relative=include
     ++	command	user.cmdline=true
      +	EOF
      +	git -c user.cmdline=true config --list --show-scope >output &&
      +	test_cmp expect output
     @@ -340,7 +341,7 @@
      +test_expect_success !MINGW '--show-scope with --blob' '
      +	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
      +	cat >expect <<-EOF &&
     -+		command	user.custom=true
     ++	command	user.custom=true
      +	EOF
      +	git config --blob=$blob --show-scope --list >output &&
      +	test_cmp expect output
     @@ -348,9 +349,9 @@
      +
      +test_expect_success '--show-scope with --local' '
      +	cat >expect <<-\EOF &&
     -+		local	user.local=true
     -+		local	user.override=local
     -+		local	include.path=../include/relative.include
     ++	local	user.local=true
     ++	local	user.override=local
     ++	local	include.path=../include/relative.include
      +	EOF
      +	git config --local --list --show-scope >output &&
      +	test_cmp expect output
     @@ -358,7 +359,7 @@
      +
      +test_expect_success '--show-scope getting a single value' '
      +	cat >expect <<-\EOF &&
     -+		local	true
     ++	local	true
      +	EOF
      +	git config --show-scope --get user.local >output &&
      +	test_cmp expect output
     @@ -366,15 +367,15 @@
      +
      +test_expect_success '--show-scope with --show-origin' '
      +	cat >expect <<-EOF &&
     -+		global	file:$HOME/.gitconfig	user.global=true
     -+		global	file:$HOME/.gitconfig	user.override=global
     -+		global	file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
     -+		global	file:$INCLUDE_DIR/absolute.include	user.absolute=include
     -+		local	file:.git/config	user.local=true
     -+		local	file:.git/config	user.override=local
     -+		local	file:.git/config	include.path=../include/relative.include
     -+		local	file:.git/../include/relative.include	user.relative=include
     -+		command	command line:	user.cmdline=true
     ++	global	file:$HOME/.gitconfig	user.global=true
     ++	global	file:$HOME/.gitconfig	user.override=global
     ++	global	file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
     ++	global	file:$INCLUDE_DIR/absolute.include	user.absolute=include
     ++	local	file:.git/config	user.local=true
     ++	local	file:.git/config	user.override=local
     ++	local	file:.git/config	include.path=../include/relative.include
     ++	local	file:.git/../include/relative.include	user.relative=include
     ++	command	command line:	user.cmdline=true
      +	EOF
      +	git -c user.cmdline=true config --list --show-origin --show-scope >output &&
      +	test_cmp expect output

-- 
gitgitgadget
