Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DD021F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJSW70 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34800 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeJSW7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id n26-v6so6772551lfl.1
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8krwI8jazZwikTc1uSFZPWbRtvj66KR4JS+8LcmKRtY=;
        b=p1AnLZBjibJTI8RcYRq31xxeZ+UruJykUjxaL64d1N4IiP6a87GhuW3hcxa/1TJsJ/
         vHOZSoPEqC49cNTIhZRYREYEnX7rLDPfVaUL++kiicOfSh4MVQRE/2GYK5uurxxbAhXn
         MzALHiYtQH/eIJtOqvAXtxJ8PGffF8f7uNtbU6uB7puNmT8l0p/Jzc2otqVNAWIRLyU4
         CGO9kcQDJhvvWRYAn96X136/6QA4WLot9O+jGvPUY1u3Fa55MgmOS+Zx2/FIK+y+nI1W
         9Buz79oySm9tpNQJ26rfXNUFMU1jvkKl7ztTWrU6zmF1PsywEXxySMHA2klAaPvkglJx
         281A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8krwI8jazZwikTc1uSFZPWbRtvj66KR4JS+8LcmKRtY=;
        b=Qe3IHec3HYZtVPkS+jMne0Nwe9vIDKGS2pAPz6OmmCDrz8toJe0bv/5x7+vJApFP8o
         QW9KPLGEOICe3NUYihUpEGjHUU6LrTBX8nQtvye+BYT9FwHphUIJ7bSM1og9zmVmzxOy
         L1R5bTJYYDuVLgjxRFqUm5e1PDaWrJzlaUreBM1slXMaF1UNM+wjZVokdXYdn/rNBTjz
         vOEiSOIi9KADbzzEizrctw4s7LVYm4DIYSBcLcIm40AfFjsL0GRzg85A1rN1lqHPurzU
         HD5IBLmEBndVxYIOOW7iv3hgDTYJY2OOREb00eu1j1Hvpaw+hVjqtT7t62KSMD5KCKbU
         WYOg==
X-Gm-Message-State: ABuFfoiezFNzoRTJOqVj7uVeqfSDy3TlQqRfb0KDoswqSOVh+MTAdcTc
        AqEUFys9ev5Pzfg3mfj3ZTKnz/Xh
X-Google-Smtp-Source: ACcGV61YkousLGV0uKeobO5wlsHfmcFp4hLFUZ8Cvev59J2IBSo1RWEJU12yeFp2OqAxsFsSCWMwPg==
X-Received: by 2002:a19:d0c2:: with SMTP id h185-v6mr3160989lfg.81.1539960776389;
        Fri, 19 Oct 2018 07:52:56 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/19] read-cache.c: replace update_index_if_able with repo_&
Date:   Fri, 19 Oct 2018 16:52:30 +0200
Message-Id: <20181019145237.16079-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/commit.c   |  2 +-
 builtin/describe.c |  2 +-
 builtin/diff.c     |  2 +-
 cache.h            |  6 ------
 read-cache.c       | 14 ++++++++------
 repository.h       |  6 ++++++
 wt-status.c        |  2 +-
 7 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7eda5e4b7e..d7afaa9ed4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1392,7 +1392,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	wt_status_collect(&s);
 
 	if (0 <= fd)
-		update_index_if_able(&the_index, &index_lock);
+		repo_update_index_if_able(the_repository, &index_lock);
 
 	if (s.relative_paths)
 		s.prefix = prefix;
diff --git a/builtin/describe.c b/builtin/describe.c
index c48c34e866..cff8ec3d65 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -634,7 +634,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 				      NULL, NULL, NULL);
 			fd = hold_locked_index(&index_lock, 0);
 			if (0 <= fd)
-				update_index_if_able(&the_index, &index_lock);
+				repo_update_index_if_able(the_repository, &index_lock);
 
 			repo_init_revisions(the_repository, &revs, prefix);
 			argv_array_pushv(&args, diff_index_args);
diff --git a/builtin/diff.c b/builtin/diff.c
index f0393bba23..ec78920ee2 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -212,7 +212,7 @@ static void refresh_index_quietly(void)
 	discard_cache();
 	read_cache();
 	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
-	update_index_if_able(&the_index, &lock_file);
+	repo_update_index_if_able(the_repository, &lock_file);
 }
 
 static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv)
diff --git a/cache.h b/cache.h
index d9303ae25f..73bf68d8a5 100644
--- a/cache.h
+++ b/cache.h
@@ -816,12 +816,6 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
 extern struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
 
-/*
- * Opportunistically update the index but do not complain if we can't.
- * The lockfile is always committed or rolled back.
- */
-extern void update_index_if_able(struct index_state *, struct lock_file *);
-
 extern void set_alternate_index_output(const char *);
 
 extern int verify_index_checksum;
diff --git a/read-cache.c b/read-cache.c
index 8844f723e9..46e5e4000a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2661,9 +2661,9 @@ static int verify_index_from(const struct index_state *istate, const char *path)
 	return 0;
 }
 
-static int verify_index(const struct index_state *istate)
+static int repo_verify_index(struct repository *repo)
 {
-	return verify_index_from(istate, get_index_file());
+	return verify_index_from(repo->index, repo->index_file);
 }
 
 static int has_racy_timestamp(struct index_state *istate)
@@ -2679,11 +2679,13 @@ static int has_racy_timestamp(struct index_state *istate)
 	return 0;
 }
 
-void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
+void repo_update_index_if_able(struct repository *repo,
+			       struct lock_file *lockfile)
 {
-	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
-	    verify_index(istate))
-		write_locked_index(istate, lockfile, COMMIT_LOCK);
+	if ((repo->index->cache_changed ||
+	     has_racy_timestamp(repo->index)) &&
+	    repo_verify_index(repo))
+		write_locked_index(repo->index, lockfile, COMMIT_LOCK);
 	else
 		rollback_lock_file(lockfile);
 }
diff --git a/repository.h b/repository.h
index cc3879add4..6fe1c089db 100644
--- a/repository.h
+++ b/repository.h
@@ -140,5 +140,11 @@ int repo_read_index_preload(struct repository *,
 			    const struct pathspec *pathspec,
 			    unsigned refresh_flags);
 int repo_read_index_unmerged(struct repository *);
+/*
+ * Opportunistically update the index but do not complain if we can't.
+ * The lockfile is always committed or rolled back.
+ */
+void repo_update_index_if_able(struct repository *, struct lock_file *);
+
 
 #endif /* REPOSITORY_H */
diff --git a/wt-status.c b/wt-status.c
index da28921772..bdc4c36f93 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2374,7 +2374,7 @@ int require_clean_work_tree(struct repository *r,
 	fd = repo_hold_locked_index(r, &lock_file, 0);
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
-		update_index_if_able(r->index, &lock_file);
+		repo_update_index_if_able(r, &lock_file);
 	rollback_lock_file(&lock_file);
 
 	if (has_unstaged_changes(r, ignore_submodules)) {
-- 
2.19.1.647.g708186aaf9

