Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD05720A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLIKpL (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:11 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39648 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeLIKpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so7091694ljh.6
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VtCudZs25EvP4TA9r6EAKEgjGUWmJ8uuY/GyEJGkByU=;
        b=vYV44Lzf0nruso3VTVnLUkjSWYE8JL19jSWZQo2HIMFvdXeWgSSkYOAzpQ9UFqt4j0
         my8bYiJgqgDvQIZx+AnFth/1OUkcJ4q3KN1TeZ9ui2m+oz0mEH6/XxLg7FkkTjb1Uy1B
         7CLfEZ1GiPIHo0gvbL2NLpaDIhVxErtLm3QiX8g/1aoTv+4Tpzel2ztMYEy0WgzTur94
         GuUllGdf+Tfl2+uq/+7tvaumaaIOdfgmrH4OS7VQettKXuvLn9dvZmfYlf4GusEJR2jG
         v5WBEnS2V/Jf5zmL8PGjGEGWvJUf5euikwSj95ZLtucgM5l2Lxgubk0eQQsA5uDR/lye
         FHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VtCudZs25EvP4TA9r6EAKEgjGUWmJ8uuY/GyEJGkByU=;
        b=mTwvRbx59mLf2SgmgJM4EfTBxbxVwl373VEfSpyWX0OkUrVBR3ysLXn21Zxwvzt1ZG
         Y0/U66/WTpXuRT3dpjZG0VjW86R99oXt7AOnshX33J4iusRmL4YFQ+pPd94dFA/tFAUC
         yONJn0ASn3vsnyBU+1iC6/kp06QTfveFwQzXjbluyh9InC1HMBRa9Q7b0vzn8pSp3RW2
         apMwLxQUrger78SngQrxU0FkeQQ+zXv/EpxDPdDMz89s0HfYsiknVGabXDLjUOGu9yZC
         xYPZxfrnkeDoP7eUOSbGTcjiDlC4WjZRauZpaf4ZjnxZsCAfhirwAk+o03Lu9QZ9b5EO
         IIow==
X-Gm-Message-State: AA+aEWa5++l6kQ5JnvG2To3b1t9EmlGenxNb5oGhpoRUs7V8i2xNHvh1
        drVWSOxm6ws76NQLTc+opQqWlfsR
X-Google-Smtp-Source: AFSGD/X3/Zl7sfN1yLOOIpQS/uGeZqrbauLU+ZtJQYFKjhj9MSSYVTB5dQwQdEUFURqON96ao7sECQ==
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr4802841ljh.63.1544352306623;
        Sun, 09 Dec 2018 02:45:06 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:05 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/24] update-index: support backup log with --keep-backup
Date:   Sun,  9 Dec 2018 11:44:00 +0100
Message-Id: <20181209104419.12639-6-pclouds@gmail.com>
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

Since this is a plumbing command, backup log support remains off by
default and only active when both --keep-backup and core.backupLog=true
are specified.

The check of core.backupLog is mostly for convenient, the calling script
does not have to explicitly check core.backupLog every time it executes
update-index. Truly disabling backup log must be done with something
like

    git -c core.backupLog=false update-index ...

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-update-index.txt |  3 +++
 builtin/update-index.c             |  7 +++++++
 t/t2080-backup-log.sh              | 11 +++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1c4d146a41..31fe330c88 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -218,6 +218,9 @@ will remove the intended effect of the option.
 	the configured value will take effect next time the index is
 	read and this will remove the intended effect of the option.
 
+--keep-backup::
+	Enable index backup log.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 31e7cce301..295b5f5277 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -28,6 +28,8 @@
 static int allow_add;
 static int allow_remove;
 static int allow_replace;
+static int update_backup_log;
+static int core_backup_log;
 static int info_only;
 static int force_remove;
 static int verbose;
@@ -289,6 +291,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	}
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
+	option |= update_backup_log && core_backup_log ? ADD_CACHE_LOG_UPDATES : 0;
 	if (add_cache_entry(ce, option)) {
 		discard_cache_entry(ce);
 		return error("%s: cannot add to the index - missing --add option?", path);
@@ -419,6 +422,7 @@ static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 		ce->ce_flags |= CE_VALID;
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
+	option |= update_backup_log && core_backup_log ? ADD_CACHE_LOG_UPDATES : 0;
 	if (add_cache_entry(ce, option))
 		return error("%s: cannot add to the index - missing --add option?",
 			     path);
@@ -969,6 +973,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			N_("let files replace directories and vice-versa"), 1),
 		OPT_SET_INT(0, "remove", &allow_remove,
 			N_("notice files missing from worktree"), 1),
+		OPT_SET_INT(0, "keep-backup", &update_backup_log,
+			N_("update index backup log if core.backupLog is set"), 1),
 		OPT_BIT(0, "unmerged", &refresh_args.flags,
 			N_("refresh even if index contains unmerged entries"),
 			REFRESH_UNMERGED),
@@ -1060,6 +1066,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		usage_with_options(update_index_usage, options);
 
 	git_config(git_default_config, NULL);
+	repo_config_get_bool(the_repository, "core.backupLog", &core_backup_log);
 
 	/* we will diagnose later if it turns out that we need to update it */
 	newfd = hold_locked_index(&lock_file, 0);
diff --git a/t/t2080-backup-log.sh b/t/t2080-backup-log.sh
index f7bdaaa3f6..6b3814c172 100755
--- a/t/t2080-backup-log.sh
+++ b/t/t2080-backup-log.sh
@@ -28,4 +28,15 @@ test_expect_success 'add writes backup log' '
 	test_cmp expected actual
 '
 
+test_expect_success 'update-index --keep-backup writes backup log' '
+	test_tick &&
+	echo update-index >>initial.t &&
+	OLD=$(git rev-parse :./initial.t) &&
+	git -c core.backupLog=true update-index --keep-backup initial.t &&
+	NEW=$(git hash-object initial.t) &&
+	echo "$OLD $NEW $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $test_tick -0700	initial.t" >expected &&
+	tail -n1 .git/index.bkl >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.20.0.rc2.486.g9832c05c3d

