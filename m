Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1DAA1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753461AbeAaLIY (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:24 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:38021 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeAaLIW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:22 -0500
Received: by mail-it0-f65.google.com with SMTP id k6so341885ita.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F3FAKGWFdfOyGtg21/BjMbmLQUSGJAb4+pX1sIUCcgI=;
        b=HgloZrG2UBrD5L5unh5Yz+RZCwq9337/SAfdBmd2mEwtw0ZfXgq+tKuXJaI94YSIGR
         R6cdD9QwSKlPhHfKt3j/PQ6zfgMjmklkt28pEiyxHsUc6Gi3L/KkEvTcO4u8520nkoY4
         U+9T/ex8Jgb+STWyjqC6rbEvuVC4ri6G88MMqOY0Xl8I/aISKihNX/8k7Dm21D5eoe5h
         kQ9MIbe0SZdXs8jTptmspT5ApY/MLatA8ST11HWx8Uu2hJa5VBgZJXRTZ/OoR7AeaUdm
         hDE+xg3gYOHshZumjJEHeMJZY7x6u/PIsUhnaOdznexSA5ISq2giCU9yfBMOfTWfPNwP
         yHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F3FAKGWFdfOyGtg21/BjMbmLQUSGJAb4+pX1sIUCcgI=;
        b=Id4XKaSwzRgeAKuYVWjQ+FRoL7ZYwcRVp9j8G+AYbNT5IMG521MN0zTntM3RyaTNbL
         cFA5ojFpSf5bhyK4+dLvAs6Iif+AlBbkncqt2mmTFHvBaDyP8jDbCM1oI5vPUPrfuUu6
         U49m9QiM8kCq5n9/HN2YH0oIWmphIqZiaZjjrfiXrLfIOJ4Zc/qPYpIiz5lkLBlRpxa8
         LyLavKXEGlV3aqJE567dPgEqU4UwIhDaLrTHX0lHX6/EeyvmRkziIi5cu/UfOhoO3sPW
         wlFl1hxe/HSyNKERfq5BZ/eH9N7xb4ynYUSByMCBlW665cc9qqRubBgZnT5iqfNCop4z
         zheg==
X-Gm-Message-State: AKwxytezKd5dUXsidLmkrR+/BFtYYnnYIixht1O9yMCqGeJ7g+lvTw+m
        JhKJMRj5TwCuBKFjF+jUk6rFLQ==
X-Google-Smtp-Source: AH8x226JH7UOcFvjcxteSbA0QE6zkwY9wh5xJTgjotd8TLJKqIE9j7XQMapDRkctHPUItaiA06qokA==
X-Received: by 10.36.249.129 with SMTP id l123mr22745749ith.30.1517396901826;
        Wed, 31 Jan 2018 03:08:21 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id n202sm9166658itn.24.2018.01.31.03.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:08:21 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 32/41] completion: use __gitcomp_builtin in _git_remote
Date:   Wed, 31 Jan 2018 18:05:38 +0700
Message-Id: <20180131110547.20577-33-pclouds@gmail.com>
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

No new completable options!

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8233dede74..7431ffc750 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2598,7 +2598,7 @@ _git_remote ()
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-			__gitcomp "--verbose"
+			__gitcomp_builtin remote
 			;;
 		*)
 			__gitcomp "$subcommands"
@@ -2609,33 +2609,33 @@ _git_remote ()
 
 	case "$subcommand,$cur" in
 	add,--*)
-		__gitcomp "--track --master --fetch --tags --no-tags --mirror="
+		__gitcomp_builtin remote_add "--no-tags"
 		;;
 	add,*)
 		;;
 	set-head,--*)
-		__gitcomp "--auto --delete"
+		__gitcomp_builtin remote_set-head
 		;;
 	set-branches,--*)
-		__gitcomp "--add"
+		__gitcomp_builtin remote_set-branches
 		;;
 	set-head,*|set-branches,*)
 		__git_complete_remote_or_refspec
 		;;
 	update,--*)
-		__gitcomp "--prune"
+		__gitcomp_builtin remote_update
 		;;
 	update,*)
 		__gitcomp "$(__git_get_config_variables "remotes")"
 		;;
 	set-url,--*)
-		__gitcomp "--push --add --delete"
+		__gitcomp_builtin remote_set-url
 		;;
 	get-url,--*)
-		__gitcomp "--push --all"
+		__gitcomp_builtin remote_get-url
 		;;
 	prune,--*)
-		__gitcomp "--dry-run"
+		__gitcomp_builtin remote_prune
 		;;
 	*)
 		__gitcomp_nl "$(__git_remotes)"
-- 
2.16.1.205.g271f633410

