Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03716208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 19:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733255AbeHFVmZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 17:42:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33384 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbeHFVmG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 17:42:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id x5-v6so5748875edr.0
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YWgnzV0IaQhISv5dwksze/i56FvFfsuVu/YruN9TCPY=;
        b=LTSUF5M8WvgNR9rtOaLIirlOykGZrAz+9BQwc03SicO9FjSSHii+Vja/0g/IFQPVtU
         9Tncrcx6iDPAUoT8TdlivPtG5c+Uzb3cxC/zdgR3Hr5+XR+nLGOc4vcp7oCeFbO45QSs
         S0BOdIummuhaVfELejpBPw1TxpEHQzOmXSzVKSWRrCC0cvnRld6XP8S6blHGk2dWgL7X
         ZRa2zpfIbzFtG2okJI0mH4xMNNMktv/lbbK8PD+tOX9IM2LRIGMsT3wIppNkYB0wa1s3
         dfWloHxZDoUNUXry37Kj9DM6xX9huHgOzjgygVSmAUg+03WjWkfqELa4p3JMaLNtK0qe
         ONRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YWgnzV0IaQhISv5dwksze/i56FvFfsuVu/YruN9TCPY=;
        b=ryEcU/Go0I5R264y+zwyHLhbPUwI0VszFIOBpwvr5U6lMVnkaoqrJnHH917Nw1uUnp
         YezCj/Aaq+ZPDTJ0Kb/ZOoRhS2EwJsMJsfxVtBnqAWDmet+vRqVhFU4wOqwUlPDun8z3
         0H7f5oErcAw7Dl1NSK1cyqDrDHgOW5S74pXVjzC8Q3fXRFiR7PRjZq2Rz0p8fFlq6lFq
         YB+XWUwpqN7qReCBW9at11qvbM0bvbzh2i7rUKmx+Bs5XBx1mZlT458OKFcQiqNFf82L
         R7bUXBZggRzk/5j7O0PBhAcQpD1hzpC33gEBtkSnOVVGxV0FiRS0EpXpWtYwW4zm4WEC
         +ZlA==
X-Gm-Message-State: AOUpUlG0xeoGusycRgG8my6mYgMs01GYzlbx4D3wQZLu59uDcJ53yLJy
        Dr3JPZGn1hxa2vnELgyt698zpKJE
X-Google-Smtp-Source: AAOMgpfMfv1waYD8eRcbYGMSj9QOZhtv7gAkYR36RVdeEAJZl3GE+V8cPvdtP12AQkfK6++EAOrpXw==
X-Received: by 2002:a50:9704:: with SMTP id c4-v6mr19574442edb.246.1533583890885;
        Mon, 06 Aug 2018 12:31:30 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.100])
        by smtp.gmail.com with ESMTPSA id x13-v6sm15485811edx.17.2018.08.06.12.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 12:31:30 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH v6 1/3] rebase: start implementing it as a builtin
Date:   Tue,  7 Aug 2018 01:16:09 +0545
Message-Id: <20180806193111.12229-2-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806193111.12229-1-predatoramigo@gmail.com>
References: <20180730162920.20318-1-predatoramigo@gmail.com>
 <20180806193111.12229-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit imitates the strategy that was used to convert the
difftool to a builtin. We start by renaming the shell script
`git-rebase.sh` to `git-legacy-rebase.sh` and introduce a
`builtin/rebase.c` that simply executes the shell script version,
unless the config setting `rebase.useBuiltin` is set to `true`.

The motivation behind this is to rewrite all the functionality of the
shell script version in the aforementioned `rebase.c`, one by one and
be able to conveniently test new features by configuring
`rebase.useBuiltin`.

In the original difftool conversion, if sane_execvp() that attempts to
run the legacy scripted version returned with non-negative status, the
command silently exited without doing anything with success, but
sane_execvp() should not return with non-negative status in the first
place, so we use die() to notice such an abnormal case.

We intentionally avoid reading the config directly to avoid
messing up the GIT_* environment variables when we need to fall back to
exec()ing the shell script. The test of builtin rebase can be done by
`git -c rebase.useBuiltin=true rebase ...`

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
Unchanged since v5.

 .gitignore                            |  1 +
 Makefile                              |  3 +-
 builtin.h                             |  1 +
 builtin/rebase.c                      | 58 +++++++++++++++++++++++++++
 git-rebase.sh => git-legacy-rebase.sh |  0
 git.c                                 |  6 +++
 6 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 builtin/rebase.c
 rename git-rebase.sh => git-legacy-rebase.sh (100%)

diff --git a/.gitignore b/.gitignore
index 3284a1e9b1..ec23959014 100644
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
index bc4fc8eeab..c311532791 100644
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
@@ -1063,6 +1063,7 @@ BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
+BUILTIN_OBJS += builtin/rebase.o
 BUILTIN_OBJS += builtin/rebase--helper.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
diff --git a/builtin.h b/builtin.h
index 0362f1ce25..44651a447f 100644
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
index 0000000000..c44addb2a4
--- /dev/null
+++ b/builtin/rebase.c
@@ -0,0 +1,58 @@
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
+	if (capture_command(&cp, &out, 6)) {
+		strbuf_release(&out);
+		return 0;
+	}
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
+	 * NEEDSWORK: Once the builtin rebase has been tested enough
+	 * and git-legacy-rebase.sh is retired to contrib/, this preamble
+	 * can be removed.
+	 */
+
+	if (!use_builtin_rebase()) {
+		const char *path = mkpath("%s/git-legacy-rebase",
+					  git_exec_path());
+
+		if (sane_execvp(path, (char **)argv) < 0)
+			die_errno(_("could not exec %s"), path);
+		else
+			BUG("sane_execvp() returned???");
+	}
+
+	if (argc != 2)
+		die(_("Usage: %s <base>"), argv[0]);
+	prefix = setup_git_directory();
+	trace_repo_setup(prefix);
+	setup_work_tree();
+
+	die("TODO");
+}
diff --git a/git-rebase.sh b/git-legacy-rebase.sh
similarity index 100%
rename from git-rebase.sh
rename to git-legacy-rebase.sh
diff --git a/git.c b/git.c
index fc7d15d549..2c6b188c77 100644
--- a/git.c
+++ b/git.c
@@ -521,6 +521,12 @@ static struct cmd_struct commands[] = {
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
+	/*
+	 * NEEDSWORK: Until the rebase is independent and needs no redirection
+	 * to rebase shell script this is kept as is, then should be changed to
+	 * RUN_SETUP | NEED_WORK_TREE
+	 */
+	{ "rebase", cmd_rebase },
 	{ "rebase--helper", cmd_rebase__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
-- 
2.18.0

