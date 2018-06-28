Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F31E11F516
	for <e@80x24.org>; Thu, 28 Jun 2018 07:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965082AbeF1Hsc (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 03:48:32 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39095 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964960AbeF1Hsa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 03:48:30 -0400
Received: by mail-pg0-f66.google.com with SMTP id n2-v6so2103679pgq.6
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 00:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uYX+R1N557z1XeIAZ/hGbFMKXpmKOxjhGNXt+73oKs8=;
        b=nTFUHZrGZbxlLjwA2Y61yMTHvfT2i09YQBMlcnQFDJRr88zrHIDi5cjdOnG8d9hRQj
         /MAqRmYYTMYaUE6iPIAt0GkcN0wsVlZq+jwxJ/b+k1RxU6KS6n3HcHTAO1bl4XKr5zPG
         CWD9TYsx+EuszBeNGITCfZlw3m23bgsUEAVvVkI/c5Pz560kFVQf3rMiaDDZwzEKaw6j
         Fu6xfkdZknmxsYMzJ/49tNrf3dV2IDS5B3zu3ic2+3QJT5NK7+S1J8egMhmwmrWsOixd
         NV0kLSH3B5OPwi/PDIVC5P77Zzd3RwesUb+XeZCmjqISTPerxmrBwDNCkC8OA2Apqoui
         gYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uYX+R1N557z1XeIAZ/hGbFMKXpmKOxjhGNXt+73oKs8=;
        b=jwvUQ5Enr+8DxWi1Grl7SqxNkuaCNOqGCrY2B01nV1rO50gsp9i9MnBWVBW+M5mecg
         Pplh2qShgvM+2f1pijKPJr5jptRaWHXtYyGPwzFcX4Omg4K6ShqcNt3CD3xX7g8yHe4h
         2FTLHAnH4fXIKBgoI84r+AQ1Sgp5cW4Cf27lPV0/0y9pFMOH8Nrxn+a+w6nHgjoMZthw
         0jdIrU9SEgrH7Gj8yYSte10d4iHQ+CMVe1C4VdQFkj6Gsm3lyrFU5eSUYGDySEwvBlPF
         ahXFzRqfZic4bk2JAzJR57poIDUPUrUQ0ys7UTYRbaMbOmqKYEumvJXdYXLOJ9mkZpYk
         jx/w==
X-Gm-Message-State: APt69E27Y96EHWIfl99I+MLK01Q3HCtXh/n75tV+QWb1WRwmpbLs6V0Q
        +zGKSzwWmyhTRdE+MsaQRuGASBAH+Wg=
X-Google-Smtp-Source: AAOMgpcW7qRG/+VUvvli7L0/Ia7SvzFfNVdUZYTITvf7BU48OilLh+0AKZu/xxsHp4agD83eRes3Ow==
X-Received: by 2002:a65:510c:: with SMTP id f12-v6mr7797346pgq.288.1530172109435;
        Thu, 28 Jun 2018 00:48:29 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.160])
        by smtp.gmail.com with ESMTPSA id x90-v6sm23416168pfk.151.2018.06.28.00.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 00:48:28 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 2/5] rebase: start implementing it as a builtin
Date:   Thu, 28 Jun 2018 13:31:52 +0545
Message-Id: <20180628074655.5756-3-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628074655.5756-1-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit imitates the strategy that was used to convert the
difftool to a builtin, see be8a90e (difftool: add a skeleton for the
upcoming builtin, 2017-01-17) for details: This commit renames the
shell script `git-rebase.sh` to `git-legacy-rebase.sh` and hands off to
it by default.

The current version of the builtin rebase does not, however, make full
use of the internals but instead chooses to spawn a couple of Git
processes to find out if we run the builtin or legacy rebase as that
keeps the directory that we are in correct. There remains a lot
of room for improvement, left for a later date. The following commits
will recreate the functionality of the shell script, in pure C.

We intentionally avoid reading the config directly to avoid
messing up the GIT_* environment variables when we need to fall back to
exec()ing the shell script. The test of builtin rebase can be done by
`git -c rebase.useBuiltin=true rebase ...`

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 .gitignore                            |  1 +
 Makefile                              |  3 +-
 builtin.h                             |  1 +
 builtin/rebase.c                      | 55 +++++++++++++++++++++++++++
 git-rebase.sh => git-legacy-rebase.sh |  0
 git.c                                 |  6 +++
 6 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 builtin/rebase.c
 rename git-rebase.sh => git-legacy-rebase.sh (100%)

diff --git a/.gitignore b/.gitignore
index 3284a1e9b..ec2395901 100644
--- a/.gitignore
+++ b/.gitignore
@@ -78,6 +78,7 @@
 /git-init-db
 /git-interpret-trailers
 /git-instaweb
+/git-legacy-rebase
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Makefile b/Makefile
index 0cb6590f2..e88fe2e5f 100644
--- a/Makefile
+++ b/Makefile
@@ -609,7 +609,7 @@ SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
-SCRIPT_SH += git-rebase.sh
+SCRIPT_SH += git-legacy-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-stash.sh
@@ -1059,6 +1059,7 @@ BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
+BUILTIN_OBJS += builtin/rebase.o
 BUILTIN_OBJS += builtin/rebase--helper.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
diff --git a/builtin.h b/builtin.h
index 0362f1ce2..44651a447 100644
--- a/builtin.h
+++ b/builtin.h
@@ -202,6 +202,7 @@ extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_pull(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_rebase(int argc, const char **argv, const char *prefix);
 extern int cmd_rebase__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
diff --git a/builtin/rebase.c b/builtin/rebase.c
new file mode 100644
index 000000000..1152b7229
--- /dev/null
+++ b/builtin/rebase.c
@@ -0,0 +1,55 @@
+/*
+ * "git rebase" builtin command
+ *
+ * Copyright (c) 2018 Pratik Karki
+ */
+
+#include "builtin.h"
+#include "run-command.h"
+#include "exec-cmd.h"
+#include "argv-array.h"
+#include "dir.h"
+
+static int use_builtin_rebase(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+	int ret;
+
+	argv_array_pushl(&cp.args,
+			 "config", "--bool", "rebase.usebuiltin", NULL);
+	cp.git_cmd = 1;
+	if (capture_command(&cp, &out, 6))
+		return 0;
+
+	strbuf_trim(&out);
+	ret = !strcmp("true", out.buf);
+	strbuf_release(&out);
+	return ret;
+}
+
+int cmd_rebase(int argc, const char **argv, const char *prefix)
+{
+	/*
+	* NEEDSWORK: Once the builtin rebase has been tested enough
+	* and git-legacy-rebase.sh is retired to contrib/, this preamble
+	* can be removed.
+	*/
+	if (!use_builtin_rebase()) {
+		const char *path = mkpath("%s/git-legacy-rebase",
+					  git_exec_path());
+
+		if (sane_execvp(path, (char **)argv) < 0)
+			die_errno("could not exec %s", path);
+
+		return 0;
+	}
+
+	if (argc != 2)
+		die("Usage: %s <base>", argv[0]);
+	prefix = setup_git_directory();
+	trace_repo_setup(prefix);
+	setup_work_tree();
+
+	die("TODO");
+}
\ No newline at end of file
diff --git a/git-rebase.sh b/git-legacy-rebase.sh
similarity index 100%
rename from git-rebase.sh
rename to git-legacy-rebase.sh
diff --git a/git.c b/git.c
index 9dbe6ffaa..bacfefb2d 100644
--- a/git.c
+++ b/git.c
@@ -518,6 +518,12 @@ static struct cmd_struct commands[] = {
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
+	/*
+	 *NEEDSWORK: Until the rebase is independent and needs no redirection
+	 to rebase shell script this is kept as is, then should be changed to
+	 RUN_SETUP | NEED_WORK_TREE
+	*/
+	{ "rebase", cmd_rebase },
 	{ "rebase--helper", cmd_rebase__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
-- 
2.18.0

