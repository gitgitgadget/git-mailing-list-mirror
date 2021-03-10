Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD77C433E9
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A9464FD0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhCJTpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhCJToz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:44:55 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AEAC061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:44:55 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y67so12880549pfb.2
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqyQqnN/r9Yp2nVabx5VAmks8N5fv9M2AVAwzn2f2LI=;
        b=OD4YmdMHvNWz6Oap7/3vBnqz8FVpS1JVsAZMaE9x8RuvM1lPPWsKvNFCargvwZpXF3
         irbD++mKpO9ZtQTCWkSIi/KtCy5qof5MjSohs0MBgu+XkdBY7H3oB7n3d+pfHfUsFe7G
         zCiprLNK251uWmWJmsXFTORZYgnNgEP/C+HPawKZyyixxybPSBTrLiAvFIYpqF4ot+lH
         IzpDJ6TDLomvfG6FTV1+AtY3BXe1ftqfxixvBMgzr4vRkonwy4whf6Oa6JADBmPV0COi
         y1p5FFOZDcBoQVWvkyXRtgHbq+bmpcru0D4vQ4sBzsBvD5j3SxQDMGFpFaMghsbtSoix
         maGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqyQqnN/r9Yp2nVabx5VAmks8N5fv9M2AVAwzn2f2LI=;
        b=nVTS2swZC0Fz+TBF9NBC/qVWRMoLQrRzf1Ci/d1dHalkqPMgMcxP9ERfKSHGSlI3NP
         bi8rZ8RG/r3aZPx/gbFS177HRG4IcFhaLtMss0PDKl3rfedvlSc9OPa9LnG0QAaxPAc3
         GbJXoKpjhxPSx4V3295PvfTQm5wcHXYVACf8J+9421+1vjdkZVR5A820b2jIJHfa8p96
         z0mh+BIYXXHDudsr4nd98YzLs+4nJGUZkXu5xel7BY/drbFfMw38XeieuRzv5mWK4TpN
         EFQlQxwhsdRi4wIKwZBZ+9DrGgkDG+SWsjN2ydUHDyQgHKJTVdl3rm+UUEo+zkO2636a
         E6fw==
X-Gm-Message-State: AOAM531GAvqhHEgUI4M2DUD9dHay1WVmKZEGQJ0mY1VlnHblUZvoxVmG
        J4qq0WsRSi26ygzFuQhvzXSk7rZAwrM02A==
X-Google-Smtp-Source: ABdhPJxQltRfcWqEWW4n5wHxJcMLEqUxe1PbH0h7UEUfWSe6Bg+9DUpeUgzEbwqnKrq9WOxGDxRbNw==
X-Received: by 2002:a63:6dca:: with SMTP id i193mr4111857pgc.81.1615405495269;
        Wed, 10 Mar 2021 11:44:55 -0800 (PST)
Received: from localhost.localdomain ([2405:204:130f:1562:5082:417f:76e8:c75])
        by smtp.googlemail.com with ESMTPSA id p5sm296480pfq.56.2021.03.10.11.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:44:54 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v4 5/6] t3437: use --fixup with options to create amend! commit
Date:   Thu, 11 Mar 2021 01:13:09 +0530
Message-Id: <20210310194306.32565-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com>
References: <20210301084512.27170-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We taught `git commit --fixup` to create "amend!" commit. Let's also
update the tests and use it to setup the rebase tests.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index a5a20354e3..d0bdc7ed02 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -72,40 +72,16 @@ test_expect_success 'setup' '
 	git commit --fixup=HEAD -a &&
 	git tag B1 &&
 	test_tick &&
-	git commit --allow-empty -F - <<-EOF &&
-	amend! B
-	$EMPTY
-	B
-	$EMPTY
-	edited 1
-	EOF
+	FAKE_COMMIT_AMEND="edited 1" git commit --fixup=reword:B &&
 	test_tick &&
-	git commit --allow-empty -F - <<-EOF &&
-	amend! amend! B
-	$EMPTY
-	B
-	$EMPTY
-	edited 1
-	$EMPTY
-	edited 2
-	EOF
+	FAKE_COMMIT_AMEND="edited 2" git commit --fixup=reword:HEAD &&
 	echo B2 >B &&
 	test_tick &&
 	FAKE_COMMIT_AMEND="edited squash" git commit --squash=HEAD -a &&
 	git tag B2 &&
 	echo B3 >B &&
 	test_tick &&
-	git commit -a -F - <<-EOF &&
-	amend! amend! amend! B
-	$EMPTY
-	B
-	$EMPTY
-	edited 1
-	$EMPTY
-	edited 2
-	$EMPTY
-	edited 3
-	EOF
+	FAKE_COMMIT_AMEND="edited 3" git commit -a --fixup=amend:HEAD^ &&
 	git tag B3 &&
 
 	GIT_AUTHOR_NAME="Rebase Author" &&
-- 
2.29.0.rc1

