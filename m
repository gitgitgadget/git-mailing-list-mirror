Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098EB205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 11:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935738AbdAJL1s (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 06:27:48 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34682 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935165AbdAJL1r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 06:27:47 -0500
Received: by mail-pf0-f194.google.com with SMTP id y143so7513920pfb.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 03:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DR+rnfQcjDqi0YJFbtO1AQBve0ZMW4MW1+nAug7vBeU=;
        b=WOraGAI+qixKjgF3+QTxHgjjX7Ym8wdl/QO9vJIssaGg+wMaz8zEe/HjBaElB2l6W8
         TOUh9pNoo4xszm1cas/Wt19dbsfAkmLIEV7KOatdNnPlcKAHZ7fiqIh6zhOoP0tREJzJ
         TYgjJrUQV0hS3BsVZ8dapmvC9NvdX0R4rgoNCcBIpvNGVg4wC8LV+8Eu6Mossm7/I7m8
         gk+5kqr7uqbnGRy6HnUd2frSJCFIMBz3n1FThe8T6lgEETwVPk+9CFoIKcC7yowXFT5p
         M0Emvdv5uBxa4N+etykU4SR5hC2liQ7rhAPoeMiE1E+ZSnfBA2KS8ezE5IcWYEUwwfAC
         rw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DR+rnfQcjDqi0YJFbtO1AQBve0ZMW4MW1+nAug7vBeU=;
        b=dBKnzDa7cKWlIP/vwUOihmqlwWMTFAim5RVr0T+sMLHqYZirJL8lrvQv/EzRHg0stk
         Sv+imN21Pb5uk0gS7me6+T6YsvG/lI4F7YXDw0dXPGHFR3mu1+qUGTj0GQtT/32XsbHO
         9QDfheg9jfcoxBO4znpnmf3vsHu5JGqK7KnW/fiEJLiKEqUZhFaGfKUnxasU8DBywncU
         //W9NTf+CaB7I01YtycgtlGzNdn2Y0FfjCezEaGx+ybcHCMsYbLzf4vHm1cv7lE3+V8V
         W8daDbGlvAnrrjoaanDbgbZvlpiJJ0rRaR1Ro/uXOGwL0vWDcApfuiVWB1EQEgJ1Ep7R
         b5Ew==
X-Gm-Message-State: AIkVDXKlk50NzpI5CqM1WND1628z1KDRvvFjOrCgKal3I090KAgC187pBBskewZxW3roDA==
X-Received: by 10.84.232.67 with SMTP id f3mr4205473pln.55.1484047666813;
        Tue, 10 Jan 2017 03:27:46 -0800 (PST)
Received: from ash ([115.73.174.142])
        by smtp.gmail.com with ESMTPSA id e11sm4978306pgp.10.2017.01.10.03.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 03:27:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 10 Jan 2017 18:27:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
        Jens.Lehmann@web.de, larsxschneider@gmail.com, sbeller@google.com,
        mhagger@alum.mit.edu, max@max630.net,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 2/4] config: --worktree for manipulating per-worktree config file
Date:   Tue, 10 Jan 2017 18:25:22 +0700
Message-Id: <20170110112524.12870-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170110112524.12870-1-pclouds@gmail.com>
References: <20170110112524.12870-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in the previous commit, "git config" without options will read
both per-worktree and per-repo by default. --worktree is needed to read
just per-worktree config. Writing goes to per-repo by default though,
unless --worktree is given.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-config.txt | 22 +++++++++++++++-------
 builtin/config.c             | 15 ++++++++++++++-
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 806873c..ead33a8 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -47,13 +47,15 @@ checks or transformations are performed on the value.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
-`--system`, `--global`, `--local` and `--file <filename>` can be
-used to tell the command to read from only that location (see <<FILES>>).
+`--system`, `--global`, `--local`, `--worktree` and
+`--file <filename>` can be used to tell the command to read from only
+that location (see <<FILES>>).
 
 When writing, the new value is written to the repository local
 configuration file by default, and options `--system`, `--global`,
-`--file <filename>` can be used to tell the command to write to
-that location (you can say `--local` but that is the default).
+`--worktree`, `--file <filename>` can be used to tell the command to
+write to that location (you can say `--local` but that is the
+default).
 
 This command will fail with non-zero status upon error.  Some exit
 codes are:
@@ -133,6 +135,11 @@ from all available files.
 +
 See also <<FILES>>.
 
+--worktree::
+	Similar to `--local` except that `.git/config.worktree` is
+	read from or written to if `extensions.worktreeConfig` is
+	present. If not it's the same as `--local`.
+
 -f config-file::
 --file config-file::
 	Use the given config file instead of the one specified by GIT_CONFIG.
@@ -275,9 +282,10 @@ configuration file. Note that this also affects options like `--replace-all`
 and `--unset`. *'git config' will only ever change one file at a time*.
 
 You can override these rules either by command-line options or by environment
-variables. The `--global` and the `--system` options will limit the file used
-to the global or system-wide file respectively. The `GIT_CONFIG` environment
-variable has a similar effect, but you can specify any filename you want.
+variables. The `--global`, `--system` and `--worktree` options will limit
+the file used to the global, system-wide or per-worktree file respectively.
+The `GIT_CONFIG` environment variable has a similar effect, but you
+can specify any filename you want.
 
 
 ENVIRONMENT
diff --git a/builtin/config.c b/builtin/config.c
index 05843a0..7d390af 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -4,6 +4,7 @@
 #include "parse-options.h"
 #include "urlmatch.h"
 #include "quote.h"
+#include "worktree.h"
 
 static const char *const builtin_config_usage[] = {
 	N_("git config [<options>]"),
@@ -23,6 +24,7 @@ static char key_delim = ' ';
 static char term = '\n';
 
 static int use_global_config, use_system_config, use_local_config;
+static int use_worktree_config;
 static struct git_config_source given_config_source;
 static int actions, types;
 static int end_null;
@@ -56,6 +58,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
 	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
 	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
+	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config file")),
 	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
 	OPT_GROUP(N_("Action")),
@@ -490,6 +493,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (use_global_config + use_system_config + use_local_config +
+	    use_worktree_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
 		error("only one config file at a time.");
 		usage_with_options(builtin_config_usage, builtin_config_options);
@@ -524,7 +528,16 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		given_config_source.file = git_etc_gitconfig();
 	else if (use_local_config)
 		given_config_source.file = git_pathdup("config");
-	else if (given_config_source.file) {
+	else if (use_worktree_config) {
+		struct worktree **worktrees = get_worktrees(0);
+		if (repository_format_worktree_config)
+			given_config_source.file = git_pathdup("config.worktree");
+		else if (worktrees[0] && worktrees[1]) {
+			die("BUG: migration is not supported yet");
+		} else
+			given_config_source.file = git_pathdup("config");
+		free_worktrees(worktrees);
+	} else if (given_config_source.file) {
 		if (!is_absolute_path(given_config_source.file) && prefix)
 			given_config_source.file =
 				xstrdup(prefix_filename(prefix,
-- 
2.8.2.524.g6ff3d78

