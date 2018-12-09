Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D645720A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeLIKpY (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33488 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeLIKpW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:22 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so5975591lfc.0
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Ia0HHX05uAXH8ke9B7WaA3Z7QbM5iE5942eEs5jprs=;
        b=orDgaxDslKo8CJQ6iq0UeTxFzuBQWPfCdB0TMHaXJnQYyl1DWxW283Rc0WJTNMbYoQ
         +59niAjLII4C9PzwNaWVWKiUYRSQ9EW4YRJHdFHfvDLxSOImFFNV+xUzXnqEYZM26sMn
         TrcCwKlNAlRMsvscujD29ag8now1ZWI2oT5AW7KOssxL+O31EaxXh1GkVTRWs8FB4mI5
         ZSZzAfSz9ZguC45yXlJj9gq4I/duO1OWIr4TQ/o394/aCOzpBq48/HO2z/TWY6dSS0im
         yDPYRDZbwZuJcqoZ6IJGJbIQTHqMT/nzfyxATGN8VoRrrENcY6ZTM3tB8QuO4sQVM9Nb
         oLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Ia0HHX05uAXH8ke9B7WaA3Z7QbM5iE5942eEs5jprs=;
        b=EVxTHGM0Xl+o9WPmpthWNtZEV53Od0jV8enkGaJQB+PJHNTTPEyR1bPzMcdK268p/R
         fDdiddxUQw7iFU624Hx5FrVUlVCDv0N6Rju+dLtKsdjdkA2qUD2M08EZhbDWG9srwXLj
         uUv6vp2CBgTkoN0pBpST9U3V7DkcSQN2Kz+YtMft4L0WLdDmC5eCVQoNzWRQ8ZV/xAY6
         R3ZSvF3J1miegXenbCGuew/c2EEM+QF51QnHg0/+TlpGGM+qnXVfNA+NoH5bqGYLthH9
         0kmOFk0LZ2Ov3VHo/Idaz/Kqy+t6YPLBQIjR5ZOjRrLEGmsxbGUfYt/E5t3pzQ5stFM0
         XwCA==
X-Gm-Message-State: AA+aEWYeVq+Iwggd9Q9IQ49tylbpu8Cf4ov8gwASUHjZUe2gGXqyVxFf
        7SUHriOeD/vquWQKjwS5NydbLccr
X-Google-Smtp-Source: AFSGD/VEeoK0ZTHWymN+ehVKYP2KXmhxUyX3H5DL8gigR2pB0s1YjXvRzse9+7JP1RC8UvpWVKK+jQ==
X-Received: by 2002:a19:5e5d:: with SMTP id z29mr4496041lfi.105.1544352319722;
        Sun, 09 Dec 2018 02:45:19 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:19 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/24] config --edit: support backup log
Date:   Sun,  9 Dec 2018 11:44:12 +0100
Message-Id: <20181209104419.12639-18-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/config.c      | 27 ++++++++++++++++++++++++++-
 t/t2080-backup-log.sh | 14 ++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 84385ef165..a42044d03e 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "backup-log.h"
 #include "config.h"
 #include "color.h"
 #include "parse-options.h"
@@ -593,6 +594,15 @@ static char *default_user_config(void)
 	return strbuf_detach(&buf, NULL);
 }
 
+static void hash_one_path(const char *path, struct object_id *oid)
+{
+	struct stat st;
+
+	if (lstat(path, &st) ||
+	    index_path(NULL, oid, path, &st, HASH_WRITE_OBJECT))
+		oidclr(oid);
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = !startup_info->have_repository;
@@ -735,6 +745,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 	else if (actions == ACTION_EDIT) {
 		char *config_file;
+		int core_backup_log = 0;
+		struct object_id old, new;
 
 		check_argc(argc, 0, 0);
 		if (!given_config_source.file && nongit)
@@ -747,6 +759,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		config_file = given_config_source.file ?
 				xstrdup(given_config_source.file) :
 				git_pathdup("config");
+		repo_config_get_bool(the_repository, "core.backuplog",
+				     &core_backup_log);
+		oidclr(&old);
 		if (use_global_config) {
 			int fd = open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
 			if (fd >= 0) {
@@ -757,9 +772,19 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			}
 			else if (errno != EEXIST)
 				die_errno(_("cannot create configuration file %s"), config_file);
-		}
+		} else if (!given_config_source.file && core_backup_log)
+			hash_one_path(git_path("config"), &old);
 		launch_editor(config_file, NULL, NULL);
 		free(config_file);
+		if (!is_null_oid(&old)) {
+			struct strbuf sb = STRBUF_INIT;
+
+			hash_one_path(git_path("config"), &new);
+			bkl_append(&sb, "config", &old, &new);
+			mkdir(git_path("common"), 0777);
+			bkl_write(git_path("common/gitdir.bkl"), &sb);
+			strbuf_release(&sb);
+		}
 	}
 	else if (actions == ACTION_SET) {
 		int ret;
diff --git a/t/t2080-backup-log.sh b/t/t2080-backup-log.sh
index 3cdabc2ba2..dbd19db757 100755
--- a/t/t2080-backup-log.sh
+++ b/t/t2080-backup-log.sh
@@ -164,4 +164,18 @@ test_expect_success 'backup-log log' '
 	test_cmp expected actual
 '
 
+test_expect_success 'config --edit makes a backup' '
+	cat >edit.sh <<-EOF &&
+	#!$SHELL_PATH
+	echo ";Edited" >>"\$1"
+	EOF
+	chmod +x edit.sh &&
+	OLD=$(git hash-object .git/config) &&
+	EDITOR=./edit.sh git -c core.backupLog=true config --edit &&
+	NEW=$(git hash-object .git/config) &&
+	grep config .git/common/gitdir.bkl &&
+	grep ^$OLD .git/common/gitdir.bkl &&
+	grep $NEW .git/common/gitdir.bkl
+'
+
 test_done
-- 
2.20.0.rc2.486.g9832c05c3d

