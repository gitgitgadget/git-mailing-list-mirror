Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A0C204A1
	for <e@80x24.org>; Mon, 28 Nov 2016 09:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbcK1Jhy (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:37:54 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34246 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932372AbcK1Jhk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:37:40 -0500
Received: by mail-pg0-f65.google.com with SMTP id e9so12654743pgc.1
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6fAXbKpuivV3wjei0z3J1ijF4GGrcMYv60CFDyuAUM=;
        b=VFzPpWmGjXdCS1rVhOJsSKSCnUHD+wMG/7nJoILNvD4WuiLnArAZE/skR65NPnvoC2
         e8yA6LJ7UebnEpUp+pVW4JfpWCqxasZgd6IsCwJCs6iGVDm+7lWvT7S+5qMZRbD09R51
         sswupqxD5k9d/5xReG+tfW1m8wBAl+JV165a2StBrgYMRxCDOdBDTaoqTnakGUGWS7tV
         hso2hrUBGWbAKGm8NxPTCGtG7RNbksL9yUmTsK72SFbLLRLxQ5BQMibKuQVbm8Tgm1P2
         BZ/ppWu/aOX8DuV9YWkPu7QktcAD5Zxa71FRbQpjsHrJmStlutdhpoVajm6s8XUsZYiR
         DRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6fAXbKpuivV3wjei0z3J1ijF4GGrcMYv60CFDyuAUM=;
        b=CXZEnNaOx9gesQyIrJ/az+JL1A11V1k9vtp9eGJu9ILE1tH4Fk/LDyyL56lj3SCB6F
         B37endtUQ1MYV0II/vvNsz3rqWyjIM/b3gSHzTeKggjhAnPZD5/GIGlh5zmvRlPpul73
         mE0YWUfhJDJB6aUIwBouphGTJb1PoP6S3iHVRrM9EG9udAwa2OO1BKYPzS4H0L7NMsPs
         QoyRRgEsGgTuUp8deX8rsCSgPvIhNto8HTWOlt1Q63uwYlZDIFXNZihyVCiU/pZ2uyE4
         Z1UsFtjaaGvRrCfyz1z7y9CvoVSR+OtoGWylWZ2c1Eq7bJCmG8E+ai8JPB3dVt43b1g1
         JhEg==
X-Gm-Message-State: AKaTC02wqrzQm1qy2a1Inq9MsCofEoce7n+ukdNlvK8T0+++YRDm1x70V53FXzeKI+7TJA==
X-Received: by 10.99.48.68 with SMTP id w65mr38102068pgw.68.1480325859296;
        Mon, 28 Nov 2016 01:37:39 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id v1sm67880296pgv.33.2016.11.28.01.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:37:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:37:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rappazzo@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 4/5] worktree.c: get_worktrees() takes a new flag argument
Date:   Mon, 28 Nov 2016 16:36:55 +0700
Message-Id: <20161128093656.15744-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161128093656.15744-1-pclouds@gmail.com>
References: <20161122100046.8341-1-pclouds@gmail.com>
 <20161128093656.15744-1-pclouds@gmail.com>
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
---
 branch.c           | 2 +-
 builtin/branch.c   | 2 +-
 builtin/worktree.c | 6 +++---
 worktree.c         | 4 ++--
 worktree.h         | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index 0d459b3..c431cbf 100644
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
index 60cc5c8..4757075 100644
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
index b835b91..d7d195c 100644
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
index 3145522..ead088e 100644
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
index 90e1311..2e68d4a 100644
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
2.8.2.524.g6ff3d78

