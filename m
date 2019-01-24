Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71CD1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 08:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfAXI3x (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 03:29:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46235 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXI3w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 03:29:52 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so2333796pgp.13
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 00:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YL2Kt0dGrUtWFOKzFsijWY0N236Y1bIaCd2k+5sEaAI=;
        b=oC8z5yP9bs6zQWPb689H42kRju1fmaI4BjRSIeRIzb45yppU67FA3GxY5oQJUmi1lX
         Wcs0QGvrXqwp5vDO4KXMtiHK8+8BLaBmzmo2U6wH6GHZLxkpOBhs9H3RwJqGomz3QSgY
         RjKkw4M4THDzEArPULFUJ36/F8wP9xSbpcey8Be5/qTOleZ/TNOPPkt5E9VWAv65Bnv2
         z7HFekLUnKC1BZ8IZXbd/VzmSjZv/0+Uwg/Du9pfLy94ar7NxQ4T7BXzrjeOQZN4lNCu
         V4ZMVoPN6yadNdvNZtkBYPV6JB0YhoaMXlCGMPAIW1QQEOo4T4W1On+MZNoWDrRbRGne
         +H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YL2Kt0dGrUtWFOKzFsijWY0N236Y1bIaCd2k+5sEaAI=;
        b=rktAVuIQNk+GZSCHcnkUXR1HZ0QwsWiKZoBVG763kVt4xFzvjostRX4cBUCGAMyYlS
         OcIM35+ANVzscP3zuOgDRp8Mck/bA+HGJ9+p1rn4vFc1MSreH7MXCymMtvaaQOS5Vgyq
         Gzdmq3DInwCJBksDijLpmrusm7NRhp30Y4XopPgvgXzswjqr7kDj6zscz4TtFlxdv9cB
         C3c5HlyJb/vqiwqxs98SzdYqBz+5biktnJnmwMysRnhvSp1Eb2TGD1w6mt4TNmCeYd/p
         pK1aicLbmLib/kA55C7Z13aDJYSCJrKded3SPi0exUB5ZpNkxGXl9N67P3ASQrgUQebC
         lpRg==
X-Gm-Message-State: AJcUukcEFnWl2/3hPo4pZOtDOhlGUTUyz3PR9st/JxKpB4HZG0Ko4LJQ
        JH9LzYJRPmljAg3dwP1tHWolhb7pEZg=
X-Google-Smtp-Source: ALg8bN6C+fmR2BZn8cAW5BRrJZacjkIUaA4MX7lQQK1ecDgVbaSjghM3drOdFuWhWIYBQwGeoknf0g==
X-Received: by 2002:a63:fb15:: with SMTP id o21mr5089474pgh.211.1548318591595;
        Thu, 24 Jan 2019 00:29:51 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id v12sm24411242pgg.41.2019.01.24.00.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:29:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 24 Jan 2019 15:29:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/11] read-cache.c: replace update_index_if_able with repo_&
Date:   Thu, 24 Jan 2019 15:29:07 +0700
Message-Id: <20190124082912.24401-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190124082912.24401-1-pclouds@gmail.com>
References: <20190124082912.24401-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c   |  2 +-
 builtin/describe.c |  2 +-
 builtin/diff.c     |  2 +-
 builtin/rebase.c   |  5 ++---
 cache.h            |  6 ------
 read-cache.c       | 14 ++++++++------
 repository.h       |  6 ++++++
 wt-status.c        |  2 +-
 8 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 19eb6cff86..d3f1234bf0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1396,7 +1396,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	wt_status_collect(&s);
 
 	if (0 <= fd)
-		update_index_if_able(&the_index, &index_lock);
+		repo_update_index_if_able(the_repository, &index_lock);
 
 	if (s.relative_paths)
 		s.prefix = prefix;
diff --git a/builtin/describe.c b/builtin/describe.c
index cc118448ee..bc97e50650 100644
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
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ce5f5b5a17..7124e66d00 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1020,8 +1020,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL,
 			      NULL);
 		if (0 <= fd)
-			update_index_if_able(the_repository->index,
-					     &lock_file);
+			repo_update_index_if_able(the_repository, &lock_file);
 		rollback_lock_file(&lock_file);
 
 		if (has_unstaged_changes(the_repository, 1)) {
@@ -1378,7 +1377,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		fd = hold_locked_index(&lock_file, 0);
 		refresh_cache(REFRESH_QUIET);
 		if (0 <= fd)
-			update_index_if_able(&the_index, &lock_file);
+			repo_update_index_if_able(the_repository, &lock_file);
 		rollback_lock_file(&lock_file);
 
 		if (has_unstaged_changes(the_repository, 1) ||
diff --git a/cache.h b/cache.h
index 3715808f52..702c5bfbb3 100644
--- a/cache.h
+++ b/cache.h
@@ -823,12 +823,6 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
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
index afbf976107..61cc0571da 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2654,9 +2654,9 @@ static int verify_index_from(const struct index_state *istate, const char *path)
 	return 0;
 }
 
-static int verify_index(const struct index_state *istate)
+static int repo_verify_index(struct repository *repo)
 {
-	return verify_index_from(istate, get_index_file());
+	return verify_index_from(repo->index, repo->index_file);
 }
 
 static int has_racy_timestamp(struct index_state *istate)
@@ -2672,11 +2672,13 @@ static int has_racy_timestamp(struct index_state *istate)
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
index becf78b04f..1f564b12d2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2378,7 +2378,7 @@ int require_clean_work_tree(struct repository *r,
 	fd = repo_hold_locked_index(r, &lock_file, 0);
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
-		update_index_if_able(r->index, &lock_file);
+		repo_update_index_if_able(r, &lock_file);
 	rollback_lock_file(&lock_file);
 
 	if (has_unstaged_changes(r, ignore_submodules)) {
-- 
2.20.1.560.g70ca8b83ee

