Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5272120A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLIKpM (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39649 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLIKpL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so7091730ljh.6
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhSawnj4lHNNdHg0HZ0HV8Nsq1q+aWi7PewLmXdquq8=;
        b=Wi+bg4pgt85iSGUzVoxxNFKE/cuyR0uOx6yVto7+Du+mVQa34GbkvYEbQcgwawLRhm
         JDcFBtQwcFlwzLteRuiwvDff/L7U5Cv7KcT4mVXgiZ4ZdaAs8I6PwrRiSJiA95KtPfat
         1L44G2atOq5rw8Isp77Qu9UOoLMsmS9hRMMwvQLYs9O73NRFKErW6C3RXSQzjpUfg+GS
         3Mql9ce/Ma2c8ZRpVCUQg4a9q6FTj+DBrdVS2S4SouHKqMOTYqx1zaPyCb61iQMpMJka
         Rpg9DHO/S0Wi3L+V02cDLbifU93dJ7584k2hmoZ1ZDjmSkIQ2pEJwjDN+eH6B3BX1ZBF
         U82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhSawnj4lHNNdHg0HZ0HV8Nsq1q+aWi7PewLmXdquq8=;
        b=Ak3V6knECAncu48PNmKzkHhVNyUdU/Skz/sbUvt5NItF9KqKIDz4kvQofwcrPShOr8
         qMvmgFmSl0YzMw/MHykBcwQnf2eX9bzGHF6pMG3AoImRdpO4xhcT6DiLUwt5zGqwPJtv
         +/NmVGATwKy4rWlEWnOW7PK9pVEKU9j3DHz4gcGqEktY8aKv8NZZQ6MQ7tlm4hwlVxMz
         0JYU/5YL6INPY8DQRaC6EtnJvYZRssCO0Mgz2yoXQx9h3Nzpf5W5c712Gl3aknShatIU
         aIQJx3NXEQ03mY4wqXufuXV7aspPvc69YYj/BfVz72jt7lGmwMXRPKZrOXVZyXsAyDrm
         7haA==
X-Gm-Message-State: AA+aEWZYVPJs20cqc6bPMSDqhGE//+hS9zgOvvoM0oW/v2HGyQmqCqIh
        jPLHANz0WXdIz5NMmq1i4z8ZAmnz
X-Google-Smtp-Source: AFSGD/V1MdhKTHrvm37bCdzvwJP2MWL/RcXzWLAUpmxO6CgTy5jmdqwqhaT3jqJcbBqc5yWqoycgFw==
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr5342294ljj.18.1544352307719;
        Sun, 09 Dec 2018 02:45:07 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:06 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/24] commit: support backup log
Date:   Sun,  9 Dec 2018 11:44:01 +0100
Message-Id: <20181209104419.12639-7-pclouds@gmail.com>
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
 builtin/commit.c      | 16 +++++++++++-----
 t/t2080-backup-log.sh | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c021b119bb..2bdbeff4a2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -268,7 +268,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 	return ret;
 }
 
-static void add_remove_files(struct string_list *list)
+static void add_remove_files(struct string_list *list, int flags)
 {
 	int i;
 	for (i = 0; i < list->nr; i++) {
@@ -280,7 +280,7 @@ static void add_remove_files(struct string_list *list)
 			continue;
 
 		if (!lstat(p->string, &st)) {
-			if (add_to_cache(p->string, &st, 0))
+			if (add_to_cache(p->string, &st, flags))
 				die(_("updating files failed"));
 		} else
 			remove_file_from_cache(p->string);
@@ -331,8 +331,14 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	struct string_list partial = STRING_LIST_INIT_DUP;
 	struct pathspec pathspec;
 	int refresh_flags = REFRESH_QUIET;
+	int add_flags = 0;
+	int core_backup_log = 0;
 	const char *ret;
 
+	repo_config_get_bool(the_repository, "core.backuplog", &core_backup_log);
+	if (core_backup_log)
+		add_flags = ADD_CACHE_LOG_UPDATES;
+
 	if (is_status)
 		refresh_flags |= REFRESH_UNMERGED;
 	parse_pathspec(&pathspec, 0,
@@ -391,7 +397,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	 */
 	if (all || (also && pathspec.nr)) {
 		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
-		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
+		add_files_to_cache(also ? prefix : NULL, &pathspec, add_flags);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, 0))
@@ -460,7 +466,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		die(_("cannot read the index"));
 
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
-	add_remove_files(&partial);
+	add_remove_files(&partial, add_flags);
 	refresh_cache(REFRESH_QUIET);
 	update_main_cache_tree(WRITE_TREE_SILENT);
 	if (write_locked_index(&the_index, &index_lock, 0))
@@ -472,7 +478,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 				  LOCK_DIE_ON_ERROR);
 
 	create_base_index(current_head);
-	add_remove_files(&partial);
+	add_remove_files(&partial, 0);
 	refresh_cache(REFRESH_QUIET);
 
 	if (write_locked_index(&the_index, &false_lock, 0))
diff --git a/t/t2080-backup-log.sh b/t/t2080-backup-log.sh
index 6b3814c172..b19e26a807 100755
--- a/t/t2080-backup-log.sh
+++ b/t/t2080-backup-log.sh
@@ -39,4 +39,28 @@ test_expect_success 'update-index --keep-backup writes backup log' '
 	test_cmp expected actual
 '
 
+test_expect_success 'commit -a writes backup log' '
+	test_tick &&
+	echo update-again >>initial.t &&
+	OLD=$(git rev-parse :./initial.t) &&
+	NEW=$(git hash-object initial.t) &&
+	git -c core.backupLog=true commit -am update-again &&
+	echo "$OLD $NEW $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $test_tick -0700	initial.t" >expected &&
+	tail -n1 .git/index.bkl >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'partial commit writes backup log' '
+	rm -f .git/index.bkl &&
+	test_tick &&
+	echo rising >>new-file &&
+	git add -N new-file &&
+	OLD=$EMPTY_BLOB &&
+	NEW=$(git hash-object new-file) &&
+	git -c core.backupLog=true commit -m update-once-more -- new-file initial.t &&
+	echo "$OLD $NEW $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $test_tick -0700	new-file" >expected &&
+	# expect file deletion to not log anything &&
+	test_cmp expected .git/index.bkl
+'
+
 test_done
-- 
2.20.0.rc2.486.g9832c05c3d

