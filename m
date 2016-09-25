Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A17A1F935
	for <e@80x24.org>; Sun, 25 Sep 2016 03:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030341AbcIYDQe (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 23:16:34 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36802 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030181AbcIYDQd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 23:16:33 -0400
Received: by mail-pf0-f194.google.com with SMTP id n24so7198985pfb.3
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 20:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6ZAqgfdPP9Mt7yseGs3A2Rvi3FWSctypUfq1lnbqzg=;
        b=l1/nun3X8y3NqAYss6QHhpGXehQcHaIFi2M2pZ8tDlPWALp2RuLuindI1bPmWlNWDl
         wvT9FzEiXxbcBHzklHJh5WUCNx5aT20GuN3mFw/HN6443LhYR8TYzc6rzeUYBjXTaADn
         8gvphV9w8nZi5TPUTi82FxnrkOsGVy8c+aoLQPY48RK2X6jZbf/3uVXp6Dqm56TTpw3t
         S9EB1eqCq8agFDvzSc4mjfeD8FtMX0ddZlHqCCujsx1Of7cpd42MZpauuigsG8+YlRfR
         Z8JtWk7s1WvVj/5VKmTcyE/myDLmG4TcqXwvBr0Ogewdw9a/ja5hKYK17T85ymKZyCL3
         eAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6ZAqgfdPP9Mt7yseGs3A2Rvi3FWSctypUfq1lnbqzg=;
        b=EpshPtr4WVCbPzU51KU6JFuwBotOhb0dfiVxuMBf8mZhVs0acphH6cY+knrrJ/C+2m
         GUmM3xYRCk73kzggk4c1td4swRKTPRWdIu1EKO6/C0/zZS4mbxqnZwhzZShmbGW1LGGI
         MLgCqsl4zLxNU2kthTUugD3E1yX79ltEVbBxv0VnsvagdkejgQjSdOgJGmzR8SZuTJgE
         DNMI8Ws5ldS4FrOfSvCimTt6EwmdXAjS9L5dAKX6kHicGOAEzdyZQTXns44ArAqoA31F
         nupRFXH6iuyHOywLPd1UHQIrINQt/PZZPKsL1OSKkmDrtHv32Z7OyrtEose1h+4RdEct
         tEsQ==
X-Gm-Message-State: AE9vXwOxG/BxYnsJ9mY4LLDrxnPwsMetgDw2GAF65cpzx/3Ns1/S2St6I3fESkwukKdaAQ==
X-Received: by 10.98.204.207 with SMTP id j76mr26177222pfk.6.1474773388254;
        Sat, 24 Sep 2016 20:16:28 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id si1sm8700670pab.0.2016.09.24.20.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Sep 2016 20:16:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 25 Sep 2016 10:16:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 4/5] init: do not set unnecessary core.worktree
Date:   Sun, 25 Sep 2016 10:14:39 +0700
Message-Id: <20160925031440.10435-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160925031440.10435-1-pclouds@gmail.com>
References: <20160925031329.GA9124@ash>
 <20160925031440.10435-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function needs_work_tree_config() that is called from
create_default_files() is supposed to be fed the path to ".git" that
looks as if it is at the top of the working tree, and decide if that
location matches the actual worktree being used.  This comparison allows
"git init" to decide if core.worktree needs to be recorded in the
working tree.

In the current code, however, we feed the return value from
get_git_dir(), which can be totally different from what the function
expects when "gitdir" file is involved.  Instead of giving the path to
the ".git" at the top of the working tree, we end up feeding the actual
path that the file points at.

This original location of ".git" however is only known to init_db().
Make init_db() save it and have it passed to create_default_files() as a
new parameter, which passes the correct location down to
needs_work_tree_config() to fix this.

Noticed-by: Max Nordlund <max.nordlund@sqore.com>
Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/init-db.c | 9 ++++++---
 t/t0001-init.sh   | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 68c1ae3..8069cd2 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -171,7 +171,8 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 	return 1;
 }
 
-static int create_default_files(const char *template_path)
+static int create_default_files(const char *template_path,
+				const char *original_git_dir)
 {
 	struct stat st1;
 	struct strbuf buf = STRBUF_INIT;
@@ -263,7 +264,7 @@ static int create_default_files(const char *template_path)
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 			git_config_set("core.logallrefupdates", "true");
-		if (needs_work_tree_config(get_git_dir(), work_tree))
+		if (needs_work_tree_config(original_git_dir, work_tree))
 			git_config_set("core.worktree", work_tree);
 	}
 
@@ -337,6 +338,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
+	char *original_git_dir = xstrdup(real_path(git_dir));
 
 	if (real_git_dir) {
 		struct stat st;
@@ -375,7 +377,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 */
 	check_repository_format();
 
-	reinit = create_default_files(template_dir);
+	reinit = create_default_files(template_dir, original_git_dir);
 
 	create_object_directory();
 
@@ -412,6 +414,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
 	}
 
+	free(original_git_dir);
 	return 0;
 }
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 488564b..b8fc588 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -400,9 +400,11 @@ test_expect_success 're-init from a linked worktree' '
 		test_commit first &&
 		git worktree add ../linked-worktree &&
 		mv .git/info/exclude expected-exclude &&
+		cp .git/config expected-config &&
 		find .git/worktrees -print | sort >expected &&
 		git -C ../linked-worktree init &&
 		test_cmp expected-exclude .git/info/exclude &&
+		test_cmp expected-config .git/config &&
 		find .git/worktrees -print | sort >actual &&
 		test_cmp expected actual
 	)
-- 
2.8.2.524.g6ff3d78

