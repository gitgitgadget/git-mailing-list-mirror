Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E031F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbeAaLH1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:07:27 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38375 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbeAaLH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:07:26 -0500
Received: by mail-pg0-f67.google.com with SMTP id y27so9769543pgc.5
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lE2KJRArnawI+qb6frgVsk+vneSp0v/lHW/aq8Spv2Y=;
        b=m2x/5IkWfqDO75l7UTLas5oEEhNgA9lXVD8uIgUc3buz94EEg/7HUlf4BWv4xF2YTO
         pRcQfW103paehUxrrDU1fKq6miwPfarUOgfANjpd0Qe04T8F4rXuyHxk2eKiA2pOrkG9
         5aGqYlwXhCdX65/xlIJxmKKk7qCKH72QyT6dQn8Ou8mbZeaLoduy7xfynlC1W/r3VKoj
         WmZ8ne5LuaDk2K4aBbcBJwQZhkMDr8TBJZfDZq4HJVTzl0BmJ+PfasGVq+IauFGOaQyC
         9sOhfOKYzpvDy/CqFaa3IZ4nF4eYutxC9x74xOA98z1N+nCO54ztOigkHb89Oy0u/0Au
         PnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lE2KJRArnawI+qb6frgVsk+vneSp0v/lHW/aq8Spv2Y=;
        b=rupItV2W2eKh406HTVfMQKnNRbnDe/9YqwYWrw5uRNinJdACCNcs+C6fxBlaaMC/AY
         z8s4YiqHibS8AabgmAkPB5/dtKggqtmflO7igEUj2lz8yrMQ21piI0ZPvB4rRdGplfeN
         m+RxUs+2ooqtLeKOfAQAavzC7RdlbGpivB1yuypjZBy308BNad3iF6RLLhHJsI6nTp/j
         hvP04aXi2iha9k/W9V6X/E7jbUrT+xEdFk49DHum0KE/20gVsROQ1c1FKg4cARZA3ABU
         XHWRUAuxvzVtEPB95w7m0bjwdcOuphZKQpRJGD5IeKqqtnk80Lj4nCSFvsvRKJ4WyA4r
         dk9w==
X-Gm-Message-State: AKwxytdczj/faX0NvDx1kdHQi/AuVR/FcXnns+d8/NYlAg3sX86ytPPg
        4vTwmlpib20QbA9EZEqhdQFqLw==
X-Google-Smtp-Source: AH8x226sBmnkBbXhTnIoYiafe6QsyAi7mfpqfSe++rKRrFsXIXD0agTUvd+Ha1ToD3mZJwZLzsTFCQ==
X-Received: by 2002:a17:902:8c81:: with SMTP id t1-v6mr27705102plo.363.1517396845559;
        Wed, 31 Jan 2018 03:07:25 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id q24sm25137389pgn.15.2018.01.31.03.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:07:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 19/41] completion: use __gitcomp_builtin in _git_gc
Date:   Wed, 31 Jan 2018 18:05:25 +0700
Message-Id: <20180131110547.20577-20-pclouds@gmail.com>
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

The new completable option is --quiet.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/gc.c                           | 7 +++++--
 contrib/completion/git-completion.bash | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3c5eae0edf..7fc5c16254 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -360,8 +360,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			N_("prune unreferenced objects"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
-		OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
-		OPT_BOOL(0, "force", &force, N_("force running gc even if there may be another gc running")),
+		OPT_BOOL_F(0, "auto", &auto_gc, N_("enable auto-gc mode"),
+			   PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL_F(0, "force", &force,
+			   N_("force running gc even if there may be another gc running"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4d25cfa047..f694331cfc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1495,7 +1495,7 @@ _git_gc ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--prune --aggressive"
+		__gitcomp_builtin gc
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

