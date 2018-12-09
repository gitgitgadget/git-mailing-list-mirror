Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B237020A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLIKpH (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44867 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeLIKpG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so7056541lji.11
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K33wJAFxgFtzfMk6+AXD8ZcCih/FKPBYiilnwbTFjFo=;
        b=SklqBSAuSyj9vZz6i3QXjzh0Y7KnQ3UqdTLV7aDFzO3gBn/rTzzM+vsLYeGibjTu40
         OhvV52D1dsIRMhI35JM+cF5fGx0AAsb4viYXhiYCEDrfHoXJRaTqJM5rWzN42ay3uJ6e
         2OSadQeHvdeIq/FRWs3Yu8BbhrFL8M4XSOAZvhy9DHI3riAUjpUTQEorxGUZ0aKXPuiL
         JNEf3NW+3DTB6/Da8lk6UMnkA5Qll/tC2IsuFNSy9fIUpymXdy0Nh0KSVXxD0ksaWSpd
         +p+KS/8BY8qQxgbS+bc8iaaLQRDch3WHQ6P6uEuQTd8a3SMlFY3BRAlFF3V2UTCGk3sH
         SDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K33wJAFxgFtzfMk6+AXD8ZcCih/FKPBYiilnwbTFjFo=;
        b=LGa8mgfzU46QuKLCZqd0g5hgd1N0NNRZpAufYRmOcR4Pfa8kawN4QkflKsj/BSY+A4
         XbxM5l+uHnl/1CQ5/wh0ERwOhJPfxc5lt4Z+WiJPuraWbWi1hLTOh3R18DelOXtIA0x7
         rxrBMBnxkGlBMrqJ8KEyle4VBw4dtpJond9w43I4JXj29DPa7Zapo4jpOA50T6DjttKf
         V6sPdnycdDNmVOeQo6phNsFASOIy6u8rU9Ju88EtOhNvgG9GINYZlfCcxETweNeT4ZPT
         dnaoH3ZQHCBYV13cA9KOUUClChuib9F73D/a7QHIwz2o2sk1RFvzcvwC7K6tL0C9cxqe
         LkqQ==
X-Gm-Message-State: AA+aEWYO+uE3dHWkuVjDVHdFbIpZLsLiPMrrSuGZta83c/nI5t1eqpG6
        uK5rgdrQIgymInLlHf9oJwXhRjkY
X-Google-Smtp-Source: AFSGD/V1YUs6vnCZQPMzGBkM3sXT2dG3Dn0rA28toWFs/ANvO3goJ6IfIgH9VR26Gc/1OWGJvFe6xA==
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr4797886ljp.12.1544352302562;
        Sun, 09 Dec 2018 02:45:02 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:01 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/24] backup-log: add "update" subcommand
Date:   Sun,  9 Dec 2018 11:43:57 +0100
Message-Id: <20181209104419.12639-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This defines backup log file format and adds basic support for writing
new entries to backup log files. The format is the same as reflog
except that "message" field becomes "path".

Similar to reflog, updating is done by appending to the end of the file
instead of creating a branch new file and do an atomic rename. If the
backup log file gets large, regenerating whole file could take longer,
and we should keep backup log overhead to minimum since it will be
called by a bunch of commands later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 .gitignore            |  1 +
 Makefile              |  2 ++
 backup-log.c          | 46 ++++++++++++++++++++++++
 backup-log.h          | 13 +++++++
 builtin.h             |  1 +
 builtin/backup-log.c  | 81 +++++++++++++++++++++++++++++++++++++++++++
 command-list.txt      |  1 +
 git.c                 |  1 +
 parse-options.c       |  2 +-
 t/t2080-backup-log.sh | 20 +++++++++++
 10 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 backup-log.c
 create mode 100644 backup-log.h
 create mode 100644 builtin/backup-log.c
 create mode 100755 t/t2080-backup-log.sh

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..9c0427c709 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,6 +20,7 @@
 /git-apply
 /git-archimport
 /git-archive
+/git-backup-log
 /git-bisect
 /git-bisect--helper
 /git-blame
diff --git a/Makefile b/Makefile
index 1a44c811aa..d1e1a925c3 100644
--- a/Makefile
+++ b/Makefile
@@ -836,6 +836,7 @@ LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
 LIB_OBJS += argv-array.o
 LIB_OBJS += attr.o
+LIB_OBJS += backup-log.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blame.o
@@ -1027,6 +1028,7 @@ BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
+BUILTIN_OBJS += builtin/backup-log.o
 BUILTIN_OBJS += builtin/bisect--helper.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
diff --git a/backup-log.c b/backup-log.c
new file mode 100644
index 0000000000..c1e805b09e
--- /dev/null
+++ b/backup-log.c
@@ -0,0 +1,46 @@
+#include "cache.h"
+#include "backup-log.h"
+#include "lockfile.h"
+#include "strbuf.h"
+
+void bkl_append(struct strbuf *output, const char *path,
+		const struct object_id *from,
+		const struct object_id *to)
+{
+	if (oideq(from, to))
+		return;
+
+	strbuf_addf(output, "%s %s %s\t%s\n", oid_to_hex(from),
+		    oid_to_hex(to), git_committer_info(0), path);
+}
+
+static int bkl_write_unlocked(const char *path, struct strbuf *new_log)
+{
+	int fd = open(path, O_CREAT | O_WRONLY | O_APPEND, 0666);
+	if (fd == -1)
+		return error_errno(_("unable to open %s"), path);
+	if (write_in_full(fd, new_log->buf, new_log->len) < 0) {
+		close(fd);
+		return error_errno(_("unable to update %s"), path);
+	}
+	close(fd);
+	return 0;
+}
+
+int bkl_write(const char *path, struct strbuf *new_log)
+{
+	struct lock_file lk;
+	int ret;
+
+	ret = hold_lock_file_for_update(&lk, path, LOCK_REPORT_ON_ERROR);
+	if (ret == -1)
+		return -1;
+	ret = bkl_write_unlocked(path, new_log);
+	/*
+	 * We do not write the the .lock file and append to the real one
+	 * instead to reduce update cost. So we can't commit even in
+	 * successful case.
+	 */
+	rollback_lock_file(&lk);
+	return ret;
+}
diff --git a/backup-log.h b/backup-log.h
new file mode 100644
index 0000000000..5e475d6f35
--- /dev/null
+++ b/backup-log.h
@@ -0,0 +1,13 @@
+#ifndef __BACKUP_LOG_H__
+#define __BACKUP_LOG_H__
+
+struct object_id;
+struct strbuf;
+
+void bkl_append(struct strbuf *output, const char *path,
+		const struct object_id *from,
+		const struct object_id *to);
+
+int bkl_write(const char *path, struct strbuf *new_log);
+
+#endif
diff --git a/builtin.h b/builtin.h
index 6538932e99..4e16c52bfa 100644
--- a/builtin.h
+++ b/builtin.h
@@ -132,6 +132,7 @@ extern int cmd_am(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
 extern int cmd_archive(int argc, const char **argv, const char *prefix);
+extern int cmd_backup_log(int argc, const char **argv, const char *prefix);
 extern int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_blame(int argc, const char **argv, const char *prefix);
 extern int cmd_branch(int argc, const char **argv, const char *prefix);
diff --git a/builtin/backup-log.c b/builtin/backup-log.c
new file mode 100644
index 0000000000..75a02c8878
--- /dev/null
+++ b/builtin/backup-log.c
@@ -0,0 +1,81 @@
+#include "cache.h"
+#include "builtin.h"
+#include "backup-log.h"
+#include "parse-options.h"
+
+static char const * const backup_log_usage[] = {
+	N_("git backup-log [--path=<path> | --id=<id>] update <path> <old-hash> <new-hash>"),
+	NULL
+};
+
+static int update(int argc, const char **argv,
+		  const char *prefix, const char *log_path)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct object_id oid_from, oid_to;
+	const char *path;
+	int ret;
+
+	if (argc != 4)
+		usage_with_options(backup_log_usage, NULL);
+
+	path = argv[1];
+
+	if (get_oid(argv[2], &oid_from))
+		die(_("not a valid object name: %s"), argv[2]);
+
+	if (get_oid(argv[3], &oid_to))
+		die(_("not a valid object name: %s"), argv[3]);
+
+	bkl_append(&sb, path, &oid_from, &oid_to);
+	ret = bkl_write(log_path, &sb);
+	strbuf_release(&sb);
+
+	return ret;
+}
+
+static char *log_id_to_path(const char *id)
+{
+	if (!strcmp(id, "index"))
+		return git_pathdup("index.bkl");
+	else if (!strcmp(id, "worktree"))
+		return git_pathdup("worktree.bkl");
+	else if (!strcmp(id, "gitdir"))
+		return git_pathdup("common/gitdir.bkl");
+	else
+		die(_("backup log id '%s' is not recognized"), id);
+}
+
+int cmd_backup_log(int argc, const char **argv, const char *prefix)
+{
+	const char *log_id = NULL;
+	const char *log_path = NULL;
+	char *to_free = NULL;
+	struct option common_opts[] = {
+		OPT_STRING(0, "id", &log_id, N_("id"), N_("backup log file id")),
+		OPT_FILENAME(0, "path", &log_path, N_("backup log file path")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, common_opts,
+			     backup_log_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (!argc)
+		die(_("expected a subcommand"));
+
+	if (log_id) {
+		if (log_path)
+			die(_("--id and --path are incompatible"));
+		log_path = to_free = log_id_to_path(log_id);
+	}
+	if (!log_path)
+		die(_("either --id or --path is required"));
+
+	if (!strcmp(argv[0], "update"))
+		return update(argc, argv, prefix, log_path);
+	else
+		die(_("unknown subcommand: %s"), argv[0]);
+
+	free(to_free);
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index 3a9af104b5..d4162f73d5 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -51,6 +51,7 @@ git-annotate                            ancillaryinterrogators
 git-apply                               plumbingmanipulators            complete
 git-archimport                          foreignscminterface
 git-archive                             mainporcelain
+git-backup-log                          plumbinginterrogators
 git-bisect                              mainporcelain           info
 git-blame                               ancillaryinterrogators          complete
 git-branch                              mainporcelain           history
diff --git a/git.c b/git.c
index 2f604a41ea..d46d22c8b1 100644
--- a/git.c
+++ b/git.c
@@ -447,6 +447,7 @@ static struct cmd_struct commands[] = {
 	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
+	{ "backup-log", cmd_backup_log, RUN_SETUP_GENTLY },
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
diff --git a/parse-options.c b/parse-options.c
index 3b874a83a0..e1fc080cc3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -705,7 +705,7 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 
 	need_newline = 1;
 
-	for (; opts->type != OPTION_END; opts++) {
+	for (; opts && opts->type != OPTION_END; opts++) {
 		size_t pos;
 		int pad;
 
diff --git a/t/t2080-backup-log.sh b/t/t2080-backup-log.sh
new file mode 100755
index 0000000000..267c34bb25
--- /dev/null
+++ b/t/t2080-backup-log.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+test_description='backup-log'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit initial &&
+	mkdir sub
+'
+
+test_expect_success 'backup-log add new item' '
+	ID=$(git rev-parse HEAD:./initial.t) &&
+	test_tick &&
+	git -C sub backup-log --id=index update foo $ZERO_OID $ID &&
+	echo "$ZERO_OID $ID $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $test_tick -0700	foo" >expected &&
+	test_cmp expected .git/index.bkl
+'
+
+test_done
-- 
2.20.0.rc2.486.g9832c05c3d

