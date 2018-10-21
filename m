Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A72321F453
	for <e@80x24.org>; Sun, 21 Oct 2018 08:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeJUQzA (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 12:55:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45581 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeJUQzA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 12:55:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id j4-v6so34250821ljc.12
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 01:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jkaHtjwOUnHpk+jBvNS31Hz2s2FAw1Dwj894NF/kKCY=;
        b=LsbOmuUyHplJKLyNh91N4S3//D/+AfFGy3S3BI5eTvAnEw++P+AJBlqi9rqzT4muKM
         pEVbgeUrYL3TnPNIr1AjGaxP5e3VH/tLOO5eut2nxJ7TnkDH/gMhGxvKCnW45LqqtmFR
         NercSo4XCyqIWR+6u3Bomp81TS+bHGFA9dklDDQDS7Oqvb1JzLdqhd+a0DWW+uCCUmES
         31osO6KDIICzIMnUb/ecVHNKPeTvmB9sqWS8D4LKO2RH2eJN5HF+4wgFFGz/sg+z0fYB
         3ftJ4eR2YBpK/W3aJstdRmD2E4Damf/dJqM82L6j5qRv/aZ8A8e233zLkrzxpMdLaNV0
         chAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jkaHtjwOUnHpk+jBvNS31Hz2s2FAw1Dwj894NF/kKCY=;
        b=AgZPvmlhPHWDBAxsZZt9/LECvo9ibjY/Jax1jO9jCROlcuJCbxVCP0ATn/LyL9GAaE
         1OSAeJ9pD4CFp3cqrvGYcqKrdzSt7mfULPcTU4mTZiy0xRBcB9Tlwmo3kf6Pl+kd+ev7
         4eZZuzvaj/v+kDMFRb0a5izZJ1kxD+JxeWI/tNJl9i7pt068kCxc4tE0eUUZoU1cGhJk
         FaI4PGBfXx/il06LDw7ZEYK4j1aETUcUqQt6bV9FP0ftfttyIgFtjgcYnFPiCMUZq6Vm
         oDS8zIeczlepkdbkIHhNxCY2wxjEBwZfLyecdB51JLasL8Tz3fNk86wSACT+bWtAbrka
         e3kg==
X-Gm-Message-State: ABuFfogRbpJat39eygYYWFsPPTLHm1bfAZn61CfVUoBaxLzNN//NdcP/
        f4Xfcrt8TvwoQn3M4ZfGxjpNhr17
X-Google-Smtp-Source: ACcGV61+nmjsriqSN0UavB/CpcvkOi9UuS+r27P0OwbIzva5uigUIMeclk0PZtD6LK/u4nDGihuwPQ==
X-Received: by 2002:a2e:47:: with SMTP id 68-v6mr28840876lja.123.1540111284069;
        Sun, 21 Oct 2018 01:41:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d126-v6sm6163918lfe.75.2018.10.21.01.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 01:41:23 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] completion: use __gitcomp_builtin for format-patch
Date:   Sun, 21 Oct 2018 10:41:02 +0200
Message-Id: <20181021084102.8318-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This helps format-patch gain completion for a couple new options,
notably --range-diff.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Of course it will be even better if I could complete the ref for
 --range-diff=, but maybe another day.

 contrib/completion/git-completion.bash | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c8fdcf8644..065b922777 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1533,12 +1533,8 @@ _git_fetch ()
 }
 
 __git_format_patch_options="
-	--stdout --attach --no-attach --thread --thread= --no-thread
-	--numbered --start-number --numbered-files --keep-subject --signoff
-	--signature --no-signature --in-reply-to= --cc= --full-index --binary
-	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
-	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
-	--output-directory --reroll-count --to= --quiet --notes
+	--full-index --not --all --no-prefix --src-prefix=
+	--dst-prefix= --notes
 "
 
 _git_format_patch ()
@@ -1551,7 +1547,7 @@ _git_format_patch ()
 		return
 		;;
 	--*)
-		__gitcomp "$__git_format_patch_options"
+		__gitcomp_builtin format-patch "$__git_format_patch_options"
 		return
 		;;
 	esac
-- 
2.19.1.647.g708186aaf9

