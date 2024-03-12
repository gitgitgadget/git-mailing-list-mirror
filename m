Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0F13B2BF
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280027; cv=none; b=fqg59rifcp0WuVd2KmjOPgj0ESXm5+zjAZTL++5DHvmPEZG5Ajv5gTe6OQtXWe0DC3vraAgBS2mk6gVvRKG3lz9NCjA95v0pSDhy2xf/jTFXiSh6JqT345GuRNuIuAZ3DjD9L42P1TnjgBTFrqC0jDB4eHBm+ztL+WmrE9ePqZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280027; c=relaxed/simple;
	bh=KZULn9B1A+ExMODnP6e0jbs/+Yy5MRiGNF9uT3tbkJY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QDBHX029351QXXwmGVJQHU7eKPCDTf5u6OoT7RWvdDx6rgs7OE+fa9+WfpopatEUzsVZk8UNS01Sj+Ja4/s/ZBPrwnX7zS1H/Tp9qwlTeOas8XO0uKgz7Pl2uLf0l321I44mQgfRrRTGh9vXwHFCElDS8+kcC7fxe7Ibaa/E0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlaegY+c; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlaegY+c"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4132f37e170so12940045e9.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710280022; x=1710884822; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOyMU49xVuD+QY1t7MgdXapZC8/nYvVCcVal4OImOjM=;
        b=nlaegY+cLvBhg8DR1b8WcJyrV1dB4Yl/YRIyvRFIAzxv5fjcSXzE14IE5mbsDtXnSf
         E3rw9CU+NbjqmouEu7G8C3vFoDTK6A+gfUYfHVhT+meY9e6uSfRgTFAjzVkKq6ECJp+a
         ga2mTkGWJyT9nTwpw3qyGWcImbTNAkZ459x5FSToporgAFckUcz4aGw9NlRgfbqAEsym
         tDT25XF//AwBjCp2RKqLjY6KbXauJoXV4Dr1lFGJNWw7BEJUleLHKoogyMWg8+hf/4Hu
         VO+Ozn2psJAnz3gowzuNLvJJvzL4GHKM22l/OHQkvMvUWzheaYRMxrH5ium+0q8OpGdn
         2exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280022; x=1710884822;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOyMU49xVuD+QY1t7MgdXapZC8/nYvVCcVal4OImOjM=;
        b=ZaDlU9YIXLamF3EgftVh7+pNvVGxCo5t9a8xE5XwSXAmtaMA5NX8HBU+rIM89vzkPr
         Pv8esgHESEynZvmWKDWDdp3G8FnuUugczVK8+jIkG0bw0toP3BxPs56NxMGrJ9yinVdZ
         fvqjJG21YsmQu3+ocmR1mBLGgVNV05toUvR8WHP7i1EjdV80mM8w9zDqvq4sTiB3fs+8
         mUqW4WP5spMowC13vaoT1jS5/qPouOyI9X1EmFn2iaSCdAjuyb0sY2+vRk4YvBdvQD50
         bfUtzyNy/TUIMNaR4MLoOGru8isV+nIi7mq2xoTsyiHgIkgOSDtcJAvDRBv8mSB9rwvj
         VBmA==
X-Gm-Message-State: AOJu0YwqPxw94tq93/Wfa4UOouFQ/2XSDePqBy+ZyTN7Ttrju9xEZCWd
	J5xEfUC2E84pLLSgYY28CPQGPClrmC89MbB0c0ZHuintl2IatfAAc9MLbIIO
X-Google-Smtp-Source: AGHT+IFIcgtAirRUKb+qYlIr81ZH2knOi3s0Dbtr8gfmFAC+UU2alXK6PCJy/XmbwBIfmURgVUDvhg==
X-Received: by 2002:a05:600c:4747:b0:412:f196:c1f3 with SMTP id w7-20020a05600c474700b00412f196c1f3mr1020491wmo.6.1710280021921;
        Tue, 12 Mar 2024 14:47:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c314a00b004133825e649sm174676wmo.33.2024.03.12.14.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:47:01 -0700 (PDT)
Message-ID: <pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com>
In-Reply-To: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
References: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
From: "Ralph Seichter via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Mar 2024 21:47:00 +0000
Subject: [PATCH v3] config: add --comment option to add a comment
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: rsbecker@nexbridge.com,
    Dragan Simic <dsimic@manjaro.org>,
    Chris Torek <chris.torek@gmail.com>,
    Ralph Seichter <github@seichter.de>,
    Ralph Seichter <github@seichter.de>

From: Ralph Seichter <github@seichter.de>

Introduce the ability to append comments to modifications
made using git-config. Example usage:

  git config --comment "changed via script" \
    --add safe.directory /home/alice/repo.git

based on the proposed patch, the output produced is:

  [safe]
    directory = /home/alice/repo.git #changed via script

Users need to be able to distinguish between config entries made
using automation and entries made by a human. Automation can add
comments containing a URL pointing to explanations for the change
made, avoiding questions from users as to why their config file
was changed by a third party.

The implementation ensures that a # character is unconditionally
prepended to the provided comment string, and that the comment
text is appended as a suffix to the changed key-value-pair in the
same line of text. Multi-line comments (i.e. comments containing
linefeed) are rejected as errors, causing Git to exit without
making changes.

Comments are aimed at humans who inspect or change their Git
config using a pager or editor. Comments are not meant to be
read or displayed by git-config at a later time.

Signed-off-by: Ralph Seichter <github@seichter.de>
---
    config: add --comment option to add a comment
    
    Changes since v2:
    
     * Address reviewers' remarks.
    
    Changes since v1:
    
     * Rewrite commit message to address reviewers' questions.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1681%2Frseichter%2Fissue-1680-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1681/rseichter/issue-1680-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1681

Range-diff vs v2:

 1:  1e6ccc81685 ! 1:  99cc839a115 config: add --comment option to add a comment
     @@ Commit message
            [safe]
              directory = /home/alice/repo.git #changed via script
      
     -    * Motivation:
     +    Users need to be able to distinguish between config entries made
     +    using automation and entries made by a human. Automation can add
     +    comments containing a URL pointing to explanations for the change
     +    made, avoiding questions from users as to why their config file
     +    was changed by a third party.
      
     -    The use case which triggered my submitting this patch is
     -    my need to distinguish between config entries made using
     -    automation and entries made by a human. Automation can
     -    add comments containing a URL pointing to explanations
     -    for the change made, avoiding questions from users as to
     -    why their config file was changed by a third party.
     +    The implementation ensures that a # character is unconditionally
     +    prepended to the provided comment string, and that the comment
     +    text is appended as a suffix to the changed key-value-pair in the
     +    same line of text. Multi-line comments (i.e. comments containing
     +    linefeed) are rejected as errors, causing Git to exit without
     +    making changes.
      
     -    * Design considerations and implementation details:
     -
     -    The implementation ensures that a # character is always
     -    prepended to the provided comment string, and that the
     -    comment text is appended as a suffix to the changed key-
     -    value-pair in the same line of text. Multiline comments
     -    are deliberately not supported, because their usefulness
     -    does not justifiy the possible problems they pose when
     -    it comes to removing ML comments later.
     -
     -    * Target audience:
     -
     -    Regarding the intended consumers of the comments made:
     -    They are aimed at humans who inspect or change their Git
     -    config using a pager or editor. Comments are not meant
     -    to be read or displayed by git-config at a later time.
     +    Comments are aimed at humans who inspect or change their Git
     +    config using a pager or editor. Comments are not meant to be
     +    read or displayed by git-config at a later time.
      
          Signed-off-by: Ralph Seichter <github@seichter.de>
      
     @@ Documentation/git-config.txt: OPTIONS
       	values.  This is the same as providing '^$' as the `value-pattern`
       	in `--replace-all`.
       
     -+--comment::
     -+	Append a comment to new or modified lines. A '#' character
     -+	will be automatically prepended to the value.
     ++--comment <value>::
     ++	Append a comment to new or modified lines. A '#' character will be
     ++	unconditionally prepended to the value. The value must not contain
     ++	linefeed characters (no multi-line comments are permitted).
      +
       --get::
       	Get the value for a given key (optionally filtered by a regex
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix
       		usage_builtin_config();
       	}
       
     -+	if (comment && !(actions & (ACTION_ADD|ACTION_SET|ACTION_SET_ALL|ACTION_REPLACE_ALL))) {
     -+		error(_("--comment is only applicable to add/set/replace operations"));
     -+		usage_builtin_config();
     ++	if (comment &&
     ++		!(actions & (ACTION_ADD|ACTION_SET|ACTION_SET_ALL|ACTION_REPLACE_ALL))) {
     ++			error(_("--comment is only applicable to add/set/replace operations"));
     ++			usage_builtin_config();
      +	}
      +
       	/* check usage of --fixed-value */
     @@ config.c: static ssize_t write_pair(int fd, const char *key, const char *value,
       			break;
       		}
      -	strbuf_addf(&sb, "%s\n", quote);
     -+	if (comment)
     -+		strbuf_addf(&sb, "%s #%s\n", quote, comment);
     -+	else
     ++
     ++	if (comment) {
     ++		if (strchr(comment, '\n'))
     ++			die(_("multi-line comments are not permitted: '%s'"), comment);
     ++		else
     ++			strbuf_addf(&sb, "%s #%s\n", quote, comment);
     ++	} else
      +		strbuf_addf(&sb, "%s\n", quote);
       
       	ret = write_in_full(fd, sb.buf, sb.len);
     @@ t/t1300-config.sh: test_expect_success 'replace with non-match (actually matchin
      -	penguin = kingpin
      +	penguin = gentoo #Pygoscelis papua
      +	disposition = peckish #find fish
     ++	foo = bar ## abc
       [Sections]
       	WhatEver = Second
       EOF
      +test_expect_success 'append comments' '
      +	git config --replace-all --comment="Pygoscelis papua" section.penguin gentoo &&
      +	git config --comment="find fish" section.disposition peckish &&
     ++	git config --comment="# abc" section.foo bar &&
      +	test_cmp expect .git/config
     ++'
     ++
     ++test_expect_success 'Prohibited LF in comment' '
     ++	test_must_fail git config --comment="a${LF}b" section.k v
      +'
       
       test_expect_success 'non-match result' 'test_cmp expect .git/config'


 Documentation/git-config.txt | 11 ++++++++---
 builtin/config.c             | 22 +++++++++++++++-------
 builtin/gc.c                 |  4 ++--
 builtin/submodule--helper.c  |  2 +-
 builtin/worktree.c           |  4 ++--
 config.c                     | 25 +++++++++++++++++--------
 config.h                     |  4 ++--
 sequencer.c                  | 28 ++++++++++++++--------------
 submodule-config.c           |  2 +-
 submodule.c                  |  2 +-
 t/t1300-config.sh            | 15 +++++++++++++--
 worktree.c                   |  4 ++--
 12 files changed, 78 insertions(+), 45 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index dff39093b5e..e608d5ffef2 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,9 +9,9 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
-'git config' [<file-option>] [--type=<type>] --add <name> <value>
-'git config' [<file-option>] [--type=<type>] [--fixed-value] --replace-all <name> <value> [<value-pattern>]
+'git config' [<file-option>] [--type=<type>] [--comment=<value>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
+'git config' [<file-option>] [--type=<type>] [--comment=<value>] --add <name> <value>
+'git config' [<file-option>] [--type=<type>] [--comment=<value>] [--fixed-value] --replace-all <name> <value> [<value-pattern>]
 'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get <name> [<value-pattern>]
 'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all <name> [<value-pattern>]
 'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp <name-regex> [<value-pattern>]
@@ -87,6 +87,11 @@ OPTIONS
 	values.  This is the same as providing '^$' as the `value-pattern`
 	in `--replace-all`.
 
+--comment <value>::
+	Append a comment to new or modified lines. A '#' character will be
+	unconditionally prepended to the value. The value must not contain
+	linefeed characters (no multi-line comments are permitted).
+
 --get::
 	Get the value for a given key (optionally filtered by a regex
 	matching the value). Returns error code 1 if the key was not
diff --git a/builtin/config.c b/builtin/config.c
index b55bfae7d66..c54e9941a5f 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -44,6 +44,7 @@ static struct config_options config_options;
 static int show_origin;
 static int show_scope;
 static int fixed_value;
+static const char *comment;
 
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -173,6 +174,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
 	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree, local, global, system, command)")),
 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
+	OPT_STRING(0, "comment", &comment, N_("value"), N_("human-readable comment string (# will be prepended automatically)")),
 	OPT_END(),
 };
 
@@ -797,6 +799,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_builtin_config();
 	}
 
+	if (comment &&
+		!(actions & (ACTION_ADD|ACTION_SET|ACTION_SET_ALL|ACTION_REPLACE_ALL))) {
+			error(_("--comment is only applicable to add/set/replace operations"));
+			usage_builtin_config();
+	}
+
 	/* check usage of --fixed-value */
 	if (fixed_value) {
 		int allowed_usage = 0;
@@ -880,7 +888,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1], &default_kvi);
-		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
+		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], comment, value);
 		if (ret == CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
 			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
@@ -891,7 +899,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		value = normalize_value(argv[0], argv[1], &default_kvi);
 		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
 							     argv[0], value, argv[2],
-							     flags);
+							     comment, flags);
 	}
 	else if (actions == ACTION_ADD) {
 		check_write();
@@ -900,7 +908,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
 							     argv[0], value,
 							     CONFIG_REGEX_NONE,
-							     flags);
+							     comment, flags);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
@@ -908,7 +916,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		value = normalize_value(argv[0], argv[1], &default_kvi);
 		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
 							     argv[0], value, argv[2],
-							     flags | CONFIG_FLAGS_MULTI_REPLACE);
+							     comment, flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_GET) {
 		check_argc(argc, 1, 2);
@@ -936,17 +944,17 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (argc == 2)
 			return git_config_set_multivar_in_file_gently(given_config_source.file,
 								      argv[0], NULL, argv[1],
-								      flags);
+								      NULL, flags);
 		else
 			return git_config_set_in_file_gently(given_config_source.file,
-							     argv[0], NULL);
+							     argv[0], NULL, NULL);
 	}
 	else if (actions == ACTION_UNSET_ALL) {
 		check_write();
 		check_argc(argc, 1, 2);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], NULL, argv[1],
-							      flags | CONFIG_FLAGS_MULTI_REPLACE);
+							      NULL, flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		check_write();
diff --git a/builtin/gc.c b/builtin/gc.c
index cb80ced6cb5..342907f7bdb 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1553,7 +1553,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 			die(_("$HOME not set"));
 		rc = git_config_set_multivar_in_file_gently(
 			config_file, "maintenance.repo", maintpath,
-			CONFIG_REGEX_NONE, 0);
+			CONFIG_REGEX_NONE, NULL, 0);
 		free(global_config_file);
 
 		if (rc)
@@ -1620,7 +1620,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		if (!config_file)
 			die(_("$HOME not set"));
 		rc = git_config_set_multivar_in_file_gently(
-			config_file, key, NULL, maintpath,
+			config_file, key, NULL, maintpath, NULL,
 			CONFIG_FLAGS_MULTI_REPLACE | CONFIG_FLAGS_FIXED_VALUE);
 		free(global_config_file);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fda50f2af1e..e4e18adb575 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1283,7 +1283,7 @@ static void sync_submodule(const char *path, const char *prefix,
 	submodule_to_gitdir(&sb, path);
 	strbuf_addstr(&sb, "/config");
 
-	if (git_config_set_in_file_gently(sb.buf, remote_key, sub_origin_url))
+	if (git_config_set_in_file_gently(sb.buf, remote_key, NULL, sub_origin_url))
 		die(_("failed to update remote for submodule '%s'"),
 		      path);
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9c76b62b02d..a20cc8820e5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -365,12 +365,12 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
 		if (!git_configset_get_bool(&cs, "core.bare", &bare) &&
 			bare &&
 			git_config_set_multivar_in_file_gently(
-				to_file, "core.bare", NULL, "true", 0))
+				to_file, "core.bare", NULL, "true", NULL, 0))
 			error(_("failed to unset '%s' in '%s'"),
 				"core.bare", to_file);
 		if (!git_configset_get(&cs, "core.worktree") &&
 			git_config_set_in_file_gently(to_file,
-							"core.worktree", NULL))
+							"core.worktree", NULL, NULL))
 			error(_("failed to unset '%s' in '%s'"),
 				"core.worktree", to_file);
 
diff --git a/config.c b/config.c
index 3cfeb3d8bd9..2f3f6d123c6 100644
--- a/config.c
+++ b/config.c
@@ -3001,6 +3001,7 @@ static ssize_t write_section(int fd, const char *key,
 }
 
 static ssize_t write_pair(int fd, const char *key, const char *value,
+			  const char *comment,
 			  const struct config_store_data *store)
 {
 	int i;
@@ -3041,7 +3042,14 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
 			strbuf_addch(&sb, value[i]);
 			break;
 		}
-	strbuf_addf(&sb, "%s\n", quote);
+
+	if (comment) {
+		if (strchr(comment, '\n'))
+			die(_("multi-line comments are not permitted: '%s'"), comment);
+		else
+			strbuf_addf(&sb, "%s #%s\n", quote, comment);
+	} else
+		strbuf_addf(&sb, "%s\n", quote);
 
 	ret = write_in_full(fd, sb.buf, sb.len);
 	strbuf_release(&sb);
@@ -3130,9 +3138,9 @@ static void maybe_remove_section(struct config_store_data *store,
 }
 
 int git_config_set_in_file_gently(const char *config_filename,
-				  const char *key, const char *value)
+				  const char *key, const char *comment, const char *value)
 {
-	return git_config_set_multivar_in_file_gently(config_filename, key, value, NULL, 0);
+	return git_config_set_multivar_in_file_gently(config_filename, key, value, NULL, comment, 0);
 }
 
 void git_config_set_in_file(const char *config_filename,
@@ -3153,7 +3161,7 @@ int repo_config_set_worktree_gently(struct repository *r,
 	if (r->repository_format_worktree_config) {
 		char *file = repo_git_path(r, "config.worktree");
 		int ret = git_config_set_multivar_in_file_gently(
-					file, key, value, NULL, 0);
+					file, key, value, NULL, NULL, 0);
 		free(file);
 		return ret;
 	}
@@ -3195,6 +3203,7 @@ void git_config_set(const char *key, const char *value)
 int git_config_set_multivar_in_file_gently(const char *config_filename,
 					   const char *key, const char *value,
 					   const char *value_pattern,
+					   const char *comment,
 					   unsigned flags)
 {
 	int fd = -1, in_fd = -1;
@@ -3245,7 +3254,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		free(store.key);
 		store.key = xstrdup(key);
 		if (write_section(fd, key, &store) < 0 ||
-		    write_pair(fd, key, value, &store) < 0)
+		    write_pair(fd, key, value, comment, &store) < 0)
 			goto write_err_out;
 	} else {
 		struct stat st;
@@ -3399,7 +3408,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 				if (write_section(fd, key, &store) < 0)
 					goto write_err_out;
 			}
-			if (write_pair(fd, key, value, &store) < 0)
+			if (write_pair(fd, key, value, comment, &store) < 0)
 				goto write_err_out;
 		}
 
@@ -3444,7 +3453,7 @@ void git_config_set_multivar_in_file(const char *config_filename,
 				     const char *value_pattern, unsigned flags)
 {
 	if (!git_config_set_multivar_in_file_gently(config_filename, key, value,
-						    value_pattern, flags))
+						    value_pattern, NULL, flags))
 		return;
 	if (value)
 		die(_("could not set '%s' to '%s'"), key, value);
@@ -3467,7 +3476,7 @@ int repo_config_set_multivar_gently(struct repository *r, const char *key,
 	int res = git_config_set_multivar_in_file_gently(file,
 							 key, value,
 							 value_pattern,
-							 flags);
+							 NULL, flags);
 	free(file);
 	return res;
 }
diff --git a/config.h b/config.h
index 5dba984f770..a85a8271696 100644
--- a/config.h
+++ b/config.h
@@ -290,7 +290,7 @@ int git_config_pathname(const char **, const char *, const char *);
 
 int git_config_expiry_date(timestamp_t *, const char *, const char *);
 int git_config_color(char *, const char *, const char *);
-int git_config_set_in_file_gently(const char *, const char *, const char *);
+int git_config_set_in_file_gently(const char *, const char *, const char *, const char *);
 
 /**
  * write config values to a specific config file, takes a key/value pair as
@@ -336,7 +336,7 @@ int git_config_parse_key(const char *, char **, size_t *);
 int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
 void git_config_set_multivar(const char *, const char *, const char *, unsigned);
 int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
-int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
+int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, const char *, unsigned);
 
 /**
  * takes four parameters:
diff --git a/sequencer.c b/sequencer.c
index f49a871ac06..4c91ca5a844 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3460,54 +3460,54 @@ static int save_opts(struct replay_opts *opts)
 
 	if (opts->no_commit)
 		res |= git_config_set_in_file_gently(opts_file,
-					"options.no-commit", "true");
+					"options.no-commit", NULL, "true");
 	if (opts->edit >= 0)
-		res |= git_config_set_in_file_gently(opts_file, "options.edit",
+		res |= git_config_set_in_file_gently(opts_file, "options.edit", NULL,
 						     opts->edit ? "true" : "false");
 	if (opts->allow_empty)
 		res |= git_config_set_in_file_gently(opts_file,
-					"options.allow-empty", "true");
+					"options.allow-empty", NULL, "true");
 	if (opts->allow_empty_message)
 		res |= git_config_set_in_file_gently(opts_file,
-				"options.allow-empty-message", "true");
+				"options.allow-empty-message", NULL, "true");
 	if (opts->keep_redundant_commits)
 		res |= git_config_set_in_file_gently(opts_file,
-				"options.keep-redundant-commits", "true");
+				"options.keep-redundant-commits", NULL, "true");
 	if (opts->signoff)
 		res |= git_config_set_in_file_gently(opts_file,
-					"options.signoff", "true");
+					"options.signoff", NULL, "true");
 	if (opts->record_origin)
 		res |= git_config_set_in_file_gently(opts_file,
-					"options.record-origin", "true");
+					"options.record-origin", NULL, "true");
 	if (opts->allow_ff)
 		res |= git_config_set_in_file_gently(opts_file,
-					"options.allow-ff", "true");
+					"options.allow-ff", NULL, "true");
 	if (opts->mainline) {
 		struct strbuf buf = STRBUF_INIT;
 		strbuf_addf(&buf, "%d", opts->mainline);
 		res |= git_config_set_in_file_gently(opts_file,
-					"options.mainline", buf.buf);
+					"options.mainline", NULL, buf.buf);
 		strbuf_release(&buf);
 	}
 	if (opts->strategy)
 		res |= git_config_set_in_file_gently(opts_file,
-					"options.strategy", opts->strategy);
+					"options.strategy", NULL, opts->strategy);
 	if (opts->gpg_sign)
 		res |= git_config_set_in_file_gently(opts_file,
-					"options.gpg-sign", opts->gpg_sign);
+					"options.gpg-sign", NULL, opts->gpg_sign);
 	for (size_t i = 0; i < opts->xopts.nr; i++)
 		res |= git_config_set_multivar_in_file_gently(opts_file,
 				"options.strategy-option",
-				opts->xopts.v[i], "^$", 0);
+				opts->xopts.v[i], "^$", NULL, 0);
 	if (opts->allow_rerere_auto)
 		res |= git_config_set_in_file_gently(opts_file,
-				"options.allow-rerere-auto",
+				"options.allow-rerere-auto", NULL,
 				opts->allow_rerere_auto == RERERE_AUTOUPDATE ?
 				"true" : "false");
 
 	if (opts->explicit_cleanup)
 		res |= git_config_set_in_file_gently(opts_file,
-				"options.default-msg-cleanup",
+				"options.default-msg-cleanup", NULL,
 				describe_cleanup_mode(opts->default_msg_cleanup));
 	return res;
 }
diff --git a/submodule-config.c b/submodule-config.c
index 54130f6a385..11428b4adad 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -978,7 +978,7 @@ int config_set_in_gitmodules_file_gently(const char *key, const char *value)
 {
 	int ret;
 
-	ret = git_config_set_in_file_gently(GITMODULES_FILE, key, value);
+	ret = git_config_set_in_file_gently(GITMODULES_FILE, key, NULL, value);
 	if (ret < 0)
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not update .gitmodules entry %s"), key);
diff --git a/submodule.c b/submodule.c
index 213da79f661..86630932d09 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2052,7 +2052,7 @@ void submodule_unset_core_worktree(const struct submodule *sub)
 	submodule_name_to_gitdir(&config_path, the_repository, sub->name);
 	strbuf_addstr(&config_path, "/config");
 
-	if (git_config_set_in_file_gently(config_path.buf, "core.worktree", NULL))
+	if (git_config_set_in_file_gently(config_path.buf, "core.worktree", NULL, NULL))
 		warning(_("Could not unset core.worktree setting in submodule '%s'"),
 			  sub->path);
 
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 31c38786870..ac7b02e6b07 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -69,13 +69,24 @@ test_expect_success 'replace with non-match (actually matching)' '
 
 cat > expect << EOF
 [section]
-	penguin = very blue
 	Movie = BadPhysics
 	UPPERCASE = true
-	penguin = kingpin
+	penguin = gentoo #Pygoscelis papua
+	disposition = peckish #find fish
+	foo = bar ## abc
 [Sections]
 	WhatEver = Second
 EOF
+test_expect_success 'append comments' '
+	git config --replace-all --comment="Pygoscelis papua" section.penguin gentoo &&
+	git config --comment="find fish" section.disposition peckish &&
+	git config --comment="# abc" section.foo bar &&
+	test_cmp expect .git/config
+'
+
+test_expect_success 'Prohibited LF in comment' '
+	test_must_fail git config --comment="a${LF}b" section.k v
+'
 
 test_expect_success 'non-match result' 'test_cmp expect .git/config'
 
diff --git a/worktree.c b/worktree.c
index b02a05a74a3..cf5eea8c931 100644
--- a/worktree.c
+++ b/worktree.c
@@ -807,9 +807,9 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
 static int move_config_setting(const char *key, const char *value,
 			       const char *from_file, const char *to_file)
 {
-	if (git_config_set_in_file_gently(to_file, key, value))
+	if (git_config_set_in_file_gently(to_file, key, NULL, value))
 		return error(_("unable to set %s in '%s'"), key, to_file);
-	if (git_config_set_in_file_gently(from_file, key, NULL))
+	if (git_config_set_in_file_gently(from_file, key, NULL, NULL))
 		return error(_("unable to unset %s in '%s'"), key, from_file);
 	return 0;
 }

base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
-- 
gitgitgadget
