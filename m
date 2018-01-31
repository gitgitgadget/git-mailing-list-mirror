Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A283F1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbeAaLJF (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:09:05 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42984 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbeAaLJC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:09:02 -0500
Received: by mail-pf0-f195.google.com with SMTP id b25so12237800pfd.9
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=My1viQBPMb0uN56IKYUwGTC7gGR/C61OH5za/h24KKw=;
        b=meXyg9RBFvJ03Z3TEXDnXV1gmZNNTC2PhV3/zTM7p7ZTjp4N9GMiVC8Yh5NW39K9mq
         3XwP/+Lvz9Dgfb/r6i0JkP+uJbU/rt4w49H4bvbdWVo7fv7JAdRRKBgCZflR6dF5U0F5
         VanCkJf8/rtMxyOANwh+oSQjQMuAPiFvi6d6rcowtZtrVLO3cOraV9kpWhsNrPZeyHOu
         S/OjI5TR5DCSQel9O4WH6Job197Hr9wwn1Wg5xTOy4Z9YayXQ529AdWH2/zUVZLyN8bU
         1B0ZOTtNrLLnPUM53xVakjO9tjNf7GuzbrQ6D1X2F/hJYzyqTTeShc37IMDbm14BnrQk
         xshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=My1viQBPMb0uN56IKYUwGTC7gGR/C61OH5za/h24KKw=;
        b=Y2GjEivpUbF+LdmPGSwqdFYhk9ZnGsAFkozaoDYoXpysPsu82YGKsi/zUBWX6tyBVq
         DgXhjkAxELnH3ZLpMjsR+8eJv7vTBYiQ/GRMSfGAL1XYxwSZumQXTg3KZXoIzo5w1pir
         VgL2uWkcl7+M+pYQWn+FTBdfqcC/OAVnBAvqUq8BD6j/1dd98/EZl50kwq8kSDQOW73B
         FPSFEcDPGp1lECrjxDmZSWW0Ke6ZvYHBaHazmKNGMUUAlpjk+TT3hY8RQTwRRIL9AbA3
         0GHAHLIdJXCdGOpoH0aiXO0F5EFOSeNQZ16+AGz9iP3xz6OyvyzMVxpJHe0/W3ff0Sqj
         QvQg==
X-Gm-Message-State: AKwxytc+lrrT9ijrqqv7b7vVzEp6Firub4LNAJu6CjAbUUPaZdlsqt8t
        +WOH1+EYptb4wRlNA35R2Ys2Ww==
X-Google-Smtp-Source: AH8x224qvJKO09IB4tc6iB6dFvi7cNQOVwOq9aj6fe2w1Fq7e5BkmE1T1Baz8fFnNRzzgbor904X9w==
X-Received: by 2002:a17:902:7c97:: with SMTP id y23-v6mr28367476pll.439.1517396941545;
        Wed, 31 Jan 2018 03:09:01 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id s80sm42841047pfj.179.2018.01.31.03.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:09:01 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 41/41] completion: use __gitcomp_builtin in _git_worktree
Date:   Wed, 31 Jan 2018 18:05:47 +0700
Message-Id: <20180131110547.20577-42-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options for "worktree add" are:

--checkout
--guess-remote
--lock
--track

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c                     | 2 +-
 contrib/completion/git-completion.bash | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4d3422f62e..76dc6b8cb5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -367,7 +367,7 @@ static int add(int ac, const char **av, const char *prefix)
 	struct option options[] = {
 		OPT__FORCE(&opts.force,
 			   N_("checkout <branch> even if already checked out in other worktree"),
-			   0),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
 			   N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 179ddd8c44..cfd24c5764 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3004,16 +3004,16 @@ _git_worktree ()
 	else
 		case "$subcommand,$cur" in
 		add,--*)
-			__gitcomp "--detach"
+			__gitcomp_builtin worktree_add
 			;;
 		list,--*)
-			__gitcomp "--porcelain"
+			__gitcomp_builtin worktree_list
 			;;
 		lock,--*)
-			__gitcomp "--reason"
+			__gitcomp_builtin worktree_lock
 			;;
 		prune,--*)
-			__gitcomp "--dry-run --expire --verbose"
+			__gitcomp_builtin worktree_prune
 			;;
 		*)
 			;;
-- 
2.16.1.205.g271f633410

