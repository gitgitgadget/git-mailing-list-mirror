Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 969341F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbeGBAZX (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:23 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46773 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752888AbeGBAZG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:06 -0400
Received: by mail-io0-f195.google.com with SMTP id p7-v6so860696ioh.13
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K/AKEWNYO/1JE+6zzfNUGbmHT/8wKGHzQcgglt2kJh0=;
        b=Vrjc2jfCWuuIZn8H1hoHwWr6ytbVSOGt3TovgJZDSRLfNJ2GnPG/euZZxSKaPZp7eM
         fmO22Ekl3DMmZjWXtAugZoXPwX2WP6NUX1uJRLdXt+1pS1Y2QgHnb/cv4yTQynq2ttR6
         PCVQV4xeYBECGqruvFZ0leqdv0slIoTPMV3tfQnzkx6sl75aTwM36EwumWfcXefmnHjA
         WhqSRmdyaZ9RbPAxrE1n61a7dEE9XpzP554Cz0tp/tacIjeDbzorE8ERvHyQeD/8G2Ce
         fbGesjm2NFA9d7tmD+bMGDmMihDDN6xOSuidjfPGurog+XXtwIJe1y/Ow3sVSFmtJsvX
         +Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=K/AKEWNYO/1JE+6zzfNUGbmHT/8wKGHzQcgglt2kJh0=;
        b=JUzPXFCFnnUXX6TRGQPPp7nC74afyqU8LNbC11XO2Vr4lSZctbFrqFKaOw+eBYETVZ
         vzQ48FtOJqdEMT/Cxh6ZaFi55SDwf/e84r/VCZbzTl5CRTQGhHmOugxyCvll+RRZvziL
         jRKBaP8opPeQsJ6vDrZ6dAD0VxOXICJ6h8hvlDWIwPm2sGgYfIM2PnCIhOy6HcGXv+ls
         NtMR72/4Ur0D2f2DwsDEi8OhxIb/k7AbouPM1ICEyvDO7ie/zJwfMjcJopnsU0t7q+yN
         4PvLyNa3LKJcxTpRG3rrlityOgP7Ge//WMNLBezR2+FRDfyRo86RkaJtT4NpTunseElG
         oZ6Q==
X-Gm-Message-State: APt69E1pldwr3m2xWn9OvelQwZrWHCXzvHWxmuIFNfusjq5zTiIL+Hqw
        eaAlWJb1YaWfJdAZBEWbz4KEMQ==
X-Google-Smtp-Source: AAOMgpcJ2cK+3hBgKzk/X6r5qIF/O2uWb+oJb1CRNrxdbvBhQZvr1kXg2EYP3a9McWeoIOUh33XUgw==
X-Received: by 2002:a6b:6607:: with SMTP id a7-v6mr5386990ioc.145.1530491105611;
        Sun, 01 Jul 2018 17:25:05 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.25.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:25:05 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 17/25] t2000-t2999: fix broken &&-chains
Date:   Sun,  1 Jul 2018 20:23:57 -0400
Message-Id: <20180702002405.3042-18-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t2103-update-index-ignore-missing.sh |  2 +-
 t/t2202-add-addremove.sh               | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
index 332694e7d3..0114f05228 100755
--- a/t/t2103-update-index-ignore-missing.sh
+++ b/t/t2103-update-index-ignore-missing.sh
@@ -32,7 +32,7 @@ test_expect_success basics '
 		test_create_repo xyzzy &&
 		cd xyzzy &&
 		>file &&
-		git add file
+		git add file &&
 		git commit -m "sub initial"
 	) &&
 	git add xyzzy &&
diff --git a/t/t2202-add-addremove.sh b/t/t2202-add-addremove.sh
index 6a5a3166b1..17744e8c57 100755
--- a/t/t2202-add-addremove.sh
+++ b/t/t2202-add-addremove.sh
@@ -6,12 +6,12 @@ test_description='git add --all'
 
 test_expect_success setup '
 	(
-		echo .gitignore
+		echo .gitignore &&
 		echo will-remove
 	) >expect &&
 	(
-		echo actual
-		echo expect
+		echo actual &&
+		echo expect &&
 		echo ignored
 	) >.gitignore &&
 	git --literal-pathspecs add --all &&
@@ -25,10 +25,10 @@ test_expect_success setup '
 
 test_expect_success 'git add --all' '
 	(
-		echo .gitignore
-		echo not-ignored
-		echo "M	.gitignore"
-		echo "A	not-ignored"
+		echo .gitignore &&
+		echo not-ignored &&
+		echo "M	.gitignore" &&
+		echo "A	not-ignored" &&
 		echo "D	will-remove"
 	) >expect &&
 	>ignored &&
-- 
2.18.0.203.gfac676dfb9

