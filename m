Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AACA420A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeLIKpR (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:17 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44683 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeLIKpP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so5936978lfe.11
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0cUQFxViNI2pf1g2oXp914WPAbAq3+xy9Dtuo+Wrroc=;
        b=TCi2nT+mU4soffEKz/RO6OhdqNyg3xCh3m0GOQPT+/XDJRZBPj6Y4dMTDaBEadZBgN
         SBqPS7N/9TGSJKLjKqIiPp//rCXS+ewd3aAzmLINIl9hKPCTN9CSlO1BW3TcH9e0n3rS
         cGYAit8pfIqaaQRqgY9rQeyvXNW7QL85GW+qozrR9INtWn7/nIuGcBVXBdSUmVqFY3Jk
         RS9ZvcJMZEPho+GLp7LE6GrywGMSavgZF4rZjkiTKj4i5Y75+y0x2mhOLkbzVr9Ml6T/
         1quwPssjkh/G7tIqUN1zOXkF2sejteYrSyTN0ah4DO3QSCIe/ZqnjkL9WnNeg3NMoDP6
         AvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0cUQFxViNI2pf1g2oXp914WPAbAq3+xy9Dtuo+Wrroc=;
        b=Ry90KRJd4/9qUCVQYBryN3yxVixsz6Ot0scBOBfn4xJC7c5KcPuKB1ImCVNpONrUjJ
         QF9ajZ9nbV27KAeBQdMTLK9CJeVqyHJuLlNYwIJbBQlP+DyE/WJB7pobD4nEKGNnbyti
         SmWlNx+I+82RVFK6uHiRLBpc6y+Bec/lSqF3NtVvadfmWuhGOL9IWaGpRCS90eSbeZP4
         zy+bnmVoamA/5KYPU0i25Q8jEjADKr9cWE1Vpmv1PdPBZS/FGgyHE9ihVwzCD+6SJDnJ
         yslqdhKDtUzhnDjbi7+DWgq/OAtZI14CtnUxgAOk9zZr0uVY6u17ZZMpLuzDXx4g1N1F
         pkpA==
X-Gm-Message-State: AA+aEWacCe5wiq3aEAXau7dTxyvQ7pNlbWoj0pgIsqVLCi/3WlWkGWeT
        nE7HwYoaGSf6M7r4YvRuAdMlUdj4
X-Google-Smtp-Source: AFSGD/U36T7EJHJN/mUOCvIOTWzP8zWauv0zb2KUAjDGh3+00onSI33wU9tIGYYRuB7Ahju3r2AKQw==
X-Received: by 2002:a19:920a:: with SMTP id u10mr4534885lfd.122.1544352312997;
        Sun, 09 Dec 2018 02:45:12 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:12 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/24] backup-log: add diff command
Date:   Sun,  9 Dec 2018 11:44:06 +0100
Message-Id: <20181209104419.12639-12-pclouds@gmail.com>
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

This gives you a patch so you can apply if you want.

FIXME pathspec support?

PS. the file list in diff queue is not sorted like a normal "git
diff". If this is a big deal, we probably can sort it later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/backup-log.c  | 100 ++++++++++++++++++++++++++++++++++++++++++
 t/t2080-backup-log.sh |  25 +++++++++++
 2 files changed, 125 insertions(+)

diff --git a/builtin/backup-log.c b/builtin/backup-log.c
index b370ff9d27..f8029e0011 100644
--- a/builtin/backup-log.c
+++ b/builtin/backup-log.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "builtin.h"
 #include "backup-log.h"
+#include "diff.h"
+#include "diffcore.h"
 #include "dir.h"
 #include "object-store.h"
 #include "parse-options.h"
@@ -8,6 +10,7 @@
 static char const * const backup_log_usage[] = {
 	N_("git backup-log [--path=<path> | --id=<id>] update <path> <old-hash> <new-hash>"),
 	N_("git backup-log [--path=<path> | --id=<id>] cat [<options>] <change-id> <path>"),
+	N_("git backup-log [--path=<path> | --id=<id>] diff [<diff-options>] <change-id>"),
 	NULL
 };
 
@@ -115,6 +118,101 @@ static int cat(int argc, const char **argv,
 	return ret - 1;
 }
 
+static void queue_blk_entry_for_diff(const struct bkl_entry *e)
+{
+	unsigned mode = canon_mode(S_IFREG | 0644);
+	struct diff_filespec *one, *two;
+	const struct object_id *old, *new;
+
+	if (is_null_oid(&e->old_oid))
+		old = the_hash_algo->empty_blob;
+	else
+		old = &e->old_oid;
+
+	if (is_null_oid(&e->new_oid))
+		new = the_hash_algo->empty_blob;
+	else
+		new = &e->new_oid;
+
+	if (oideq(old, new))
+		return;
+
+	one = alloc_filespec(e->path);
+	two = alloc_filespec(e->path);
+
+	fill_filespec(one, old, 1, mode);
+	fill_filespec(two, new, 1, mode);
+	diff_queue(&diff_queued_diff, one, two);
+}
+
+static int diff_parse(struct strbuf *line, void *data)
+{
+	timestamp_t id = *(timestamp_t *)data;
+	struct bkl_entry entry;
+
+	if (bkl_parse_entry(line, &entry))
+		return -1;
+
+	if (entry.timestamp < id)
+		return 1;
+
+	if (entry.timestamp > id)
+		return 0;
+
+	queue_blk_entry_for_diff(&entry);
+	return 0;
+}
+
+static int diff(int argc, const char **argv,
+		const char *prefix, const char *log_path)
+{
+	char *end = NULL;
+	struct diff_options diffopt;
+	timestamp_t id = -1;
+	int ret, i, found_dash_dash = 0;
+
+	repo_diff_setup(the_repository, &diffopt);
+	i = 1;
+	while (i < argc) {
+		const char *arg = argv[i];
+
+		if (!found_dash_dash && *arg == '-') {
+			if (!strcmp(arg, "--")) {
+				found_dash_dash = 1;
+				i++;
+				continue;
+			}
+			ret = diff_opt_parse(&diffopt, argv + i, argc - i, prefix);
+			if (ret < 0)
+				exit(128);
+			i += ret;
+			continue;
+		}
+
+		id = strtol(arg, &end, 10);
+		if (!end || *end)
+			die(_("not a valid change id: %s"), arg);
+		i++;
+		break;
+	}
+	if (!diffopt.output_format)
+		diffopt.output_format = DIFF_FORMAT_PATCH;
+	diff_setup_done(&diffopt);
+	if (i != argc || id == -1)
+		usage_with_options(backup_log_usage, NULL);
+
+	ret = bkl_parse_file_reverse(log_path, diff_parse, &id);
+	if (ret < 0)
+		die(_("failed to parse '%s'"), log_path);
+
+	if (ret == 1) {
+		setup_pager();
+		diffcore_std(&diffopt);
+		diff_flush(&diffopt);
+	}
+	return ret - 1;
+}
+
 static char *log_id_to_path(const char *id)
 {
 	if (!strcmp(id, "index"))
@@ -156,6 +254,8 @@ int cmd_backup_log(int argc, const char **argv, const char *prefix)
 		return update(argc, argv, prefix, log_path);
 	else if (!strcmp(argv[0], "cat"))
 		return cat(argc, argv, prefix, log_path);
+	else if (!strcmp(argv[0], "diff"))
+		return diff(argc, argv, prefix, log_path);
 	else
 		die(_("unknown subcommand: %s"), argv[0]);
 
diff --git a/t/t2080-backup-log.sh b/t/t2080-backup-log.sh
index 9c004c9727..cd4288d386 100755
--- a/t/t2080-backup-log.sh
+++ b/t/t2080-backup-log.sh
@@ -105,4 +105,29 @@ test_expect_success 'backup-log cat' '
 	test_cmp expected actual
 '
 
+test_expect_success 'backup-log diff' '
+	echo first >initial.t &&
+	git add initial.t &&
+	echo second >initial.t &&
+	test_tick &&
+	git -c core.backupLog=true add initial.t &&
+	git backup-log --id=index diff $test_tick >actual &&
+	cat >expected <<-\EOF &&
+	diff --git a/initial.t b/initial.t
+	index 9c59e24..e019be0 100644
+	--- a/initial.t
+	+++ b/initial.t
+	@@ -1 +1 @@
+	-first
+	+second
+	EOF
+	test_cmp expected actual &&
+	git backup-log --id=index diff --stat $test_tick >stat.actual &&
+	cat >stat.expected <<-\EOF &&
+	 initial.t | 2 +-
+	 1 file changed, 1 insertion(+), 1 deletion(-)
+	EOF
+	test_cmp stat.expected stat.actual
+'
+
 test_done
-- 
2.20.0.rc2.486.g9832c05c3d

