Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C691F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 08:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdBBIul (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 03:50:41 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33654 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdBBIuk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 03:50:40 -0500
Received: by mail-pf0-f196.google.com with SMTP id e4so1019549pfg.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 00:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4Fs9bUnG77snWZeeGnishAB11JLXughrg/zdcw7kcY=;
        b=jWMVqu95I6a6qh5amJAHgEZuUqk3Nb+IyF/oKoARGtl2M9FDxGJk3WBxOVeEwciRBT
         IQc6RoIAQSr/6Dh7m5GhG9DwNbYNDL+yAOxinXpjmgmFuE3XcZzzG/+QzNcplywRWfLE
         TANanbPsEPkZWcJ+iTtheordmfoaNopVxHV9DMdGbMzehy+GxThJfpb0pO8eC2VxCOBd
         yNhmAH3WhAp47rSdGJdVdbbK9KRffsu+1A8bf5gcdk+30Fo99zPFEt5vGmCUevEOj1f1
         n6gFjsnCzV9xCixgInwWkWt8Zy6+bNKcnip2Ri33PWka4Zx4xHg5laRzvO9GxzFn5DrR
         5EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4Fs9bUnG77snWZeeGnishAB11JLXughrg/zdcw7kcY=;
        b=YI1MF0h4g3uabKzW2UsTH//YFFZu/uHilef9eXwnG0jLG0Ct3ADTW1TUohWPmONl1g
         FMZd/3k1J9JfIVLg9JJe961nfERDMKeGUFv6O2XBJ8vbb/PWZy1jMyZSP8RGOFSYGnEr
         YR1ZJi79u/XuGiUXI0PKB4IqYMCuZHu/1vdTiLYSFPjJD4T7Qp1VQi40H1fC2jaBX2Q0
         dzpk1T4Ymig3L1PgezGTiKkKrcmtMQXsG9+cq6FU/Dm4Suyc1HroQtnyOcowdZkKDMdN
         763ORp9isNHZfVBE1gsaVuBk43NAXc1FXreMF81DRmczrupihKDyD47RYhGzrj8byium
         acMA==
X-Gm-Message-State: AIkVDXICpSvHvBxOI1bWJJJxMoCr06CcDu4ANDs9Sm0H8+x9zYSHe5UG4OfbzhqOsPbkxw==
X-Received: by 10.98.76.132 with SMTP id e4mr9155218pfj.24.1486025434708;
        Thu, 02 Feb 2017 00:50:34 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id q19sm56128628pfl.21.2017.02.02.00.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 00:50:33 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 02 Feb 2017 15:50:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/11] worktree.c: get_worktrees() takes a new flag argument
Date:   Thu,  2 Feb 2017 15:50:00 +0700
Message-Id: <20170202085007.21418-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170202085007.21418-1-pclouds@gmail.com>
References: <20170202085007.21418-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another no-op patch, in preparation for get_worktrees() to do
optional things, like sorting.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 branch.c           | 2 +-
 builtin/branch.c   | 2 +-
 builtin/worktree.c | 6 +++---
 worktree.c         | 4 ++--
 worktree.h         | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index 0d459b3cfe..c431cbf6a9 100644
--- a/branch.c
+++ b/branch.c
@@ -348,7 +348,7 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
 int replace_each_worktree_head_symref(const char *oldref, const char *newref)
 {
 	int ret = 0;
-	struct worktree **worktrees = get_worktrees();
+	struct worktree **worktrees = get_worktrees(0);
 	int i;
 
 	for (i = 0; worktrees[i]; i++) {
diff --git a/builtin/branch.c b/builtin/branch.c
index 60cc5c8e8d..475707528a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -531,7 +531,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 
 static void reject_rebase_or_bisect_branch(const char *target)
 {
-	struct worktree **worktrees = get_worktrees();
+	struct worktree **worktrees = get_worktrees(0);
 	int i;
 
 	for (i = 0; worktrees[i]; i++) {
diff --git a/builtin/worktree.c b/builtin/worktree.c
index b835b91f63..d7d195cd95 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -447,7 +447,7 @@ static int list(int ac, const char **av, const char *prefix)
 	if (ac)
 		usage_with_options(worktree_usage, options);
 	else {
-		struct worktree **worktrees = get_worktrees();
+		struct worktree **worktrees = get_worktrees(0);
 		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
 
 		if (!porcelain)
@@ -478,7 +478,7 @@ static int lock_worktree(int ac, const char **av, const char *prefix)
 	if (ac != 1)
 		usage_with_options(worktree_usage, options);
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees(0);
 	wt = find_worktree(worktrees, prefix, av[0]);
 	if (!wt)
 		die(_("'%s' is not a working tree"), av[0]);
@@ -511,7 +511,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 	if (ac != 1)
 		usage_with_options(worktree_usage, options);
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees(0);
 	wt = find_worktree(worktrees, prefix, av[0]);
 	if (!wt)
 		die(_("'%s' is not a working tree"), av[0]);
diff --git a/worktree.c b/worktree.c
index 3145522536..ead088e43c 100644
--- a/worktree.c
+++ b/worktree.c
@@ -160,7 +160,7 @@ static void mark_current_worktree(struct worktree **worktrees)
 	free(git_dir);
 }
 
-struct worktree **get_worktrees(void)
+struct worktree **get_worktrees(unsigned flags)
 {
 	struct worktree **list = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -327,7 +327,7 @@ const struct worktree *find_shared_symref(const char *symref,
 
 	if (worktrees)
 		free_worktrees(worktrees);
-	worktrees = get_worktrees();
+	worktrees = get_worktrees(0);
 
 	for (i = 0; worktrees[i]; i++) {
 		struct worktree *wt = worktrees[i];
diff --git a/worktree.h b/worktree.h
index 90e1311fa7..2e68d4ad86 100644
--- a/worktree.h
+++ b/worktree.h
@@ -23,7 +23,7 @@ struct worktree {
  * The caller is responsible for freeing the memory from the returned
  * worktree(s).
  */
-extern struct worktree **get_worktrees(void);
+extern struct worktree **get_worktrees(unsigned flags);
 
 /*
  * Return git dir of the worktree. Note that the path may be relative.
-- 
2.11.0.157.gd943d85

