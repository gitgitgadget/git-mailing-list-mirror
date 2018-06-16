Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 577DD1F403
	for <e@80x24.org>; Sat, 16 Jun 2018 20:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeFPUdZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 16:33:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36177 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPUdY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 16:33:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id v131-v6so9143845wma.1
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EYFEOlcOs1IRE/QQJj4p/RoNJuZAKRnjiiBX+n7qJIo=;
        b=cxnMO8yS3FwwgiiwAt3IkHu4pNWwXFIeF/sbLn19m0g8HKH0RyB8pWM27gvozzFGLd
         rV/7uVRG0cURBDj+8eSfzHuIMYwhK2+JBRCtCwWmRvf23Tgne1qEotEEb6S3narXGjR6
         RB1/25FNMkuTWJTOE62hgWKcDCt9+/Zw3ytTvg8lCPmHHf3uLJWTMZAiWAM/rr+51wMg
         nEs4fme12qMrWYhU4KDMui3jk1ngRU5xTqY6HhVrJNxCOS5q33ELZgz1okJLiOjXjZvB
         AJqM+O5quaotcE9dMRKZvd0uoAuQ2cjWqq26UQ0PPNPGPxivOxZzOMqRB+GQaD0s4Pdc
         SVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EYFEOlcOs1IRE/QQJj4p/RoNJuZAKRnjiiBX+n7qJIo=;
        b=I41pTj9X0TlUKreuDogOyUSbQ/zSNomggDOMv1369Hzglu/ttyYyM94ljP46qn+tt0
         v8OSJTIB/mQyPaWXlnJMQ2ZbXjbzrfcvikM6zC18FXItF5X0+6cywBwwab0tR3Qt+OkN
         DUYpofRL7wGqw9KbbzVwAKzmHwT6nzVktsvMp+28CsoOljYWX8G1Ium7YOWMVrNNbedE
         qjWjS1wJTkk80kd1m51ApvcP8JDgauLBvhsyMaNOcW+b9T6JZfVA9VPnPsl3t/Q7Mvwr
         R/vb/bzN5TSe/cfwPpc6Rj3nx+x6el+36rw5J+42nzBx1nibXX7HrKJ48ENylJgtKWmm
         DJsA==
X-Gm-Message-State: APt69E1riw91XVm/ZD9kCMx09Y3tmV4RjBZ2zS3lCAJ0aiIjyCrl6N+z
        K8BsnL1hcJGZahhfqoiTFWE=
X-Google-Smtp-Source: ADUXVKLmJ5YD3E45aatMWV4ek5ExQBd8NrLMZ3YzjzTvkcNPqCEXHh+fv2DB4jVzlSAnWImW5G+nOg==
X-Received: by 2002:a1c:124f:: with SMTP id 76-v6mr4717355wms.29.1529181203421;
        Sat, 16 Jun 2018 13:33:23 -0700 (PDT)
Received: from localhost.localdomain (x4db06e4b.dyn.telefonica.de. [77.176.110.75])
        by smtp.gmail.com with ESMTPSA id o13-v6sm3899442wmc.33.2018.06.16.13.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Jun 2018 13:33:22 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t7406-submodule-update: fix broken &&-chains
Date:   Sat, 16 Jun 2018 22:33:19 +0200
Message-Id: <20180616203319.9558-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three tests in 't7406-submodule-update' contain broken &&-chains, but
since they are all in subshells, chain-lint couldn't notice them.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t7406-submodule-update.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 6f083c4d68..9e0d31700e 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -65,7 +65,7 @@ test_expect_success 'setup a submodule tree' '
 	 git commit -m "none"
 	) &&
 	git clone . recursivesuper &&
-	( cd recursivesuper
+	( cd recursivesuper &&
 	 git submodule add ../super super
 	)
 '
@@ -245,13 +245,13 @@ test_expect_success 'submodule update --remote should fetch upstream changes wit
 	(
 		cd super &&
 		git submodule update --remote --force submodule &&
-		git -C submodule log -1 --oneline >actual
-		git -C ../submodule log -1 --oneline master >expect
+		git -C submodule log -1 --oneline >actual &&
+		git -C ../submodule log -1 --oneline master >expect &&
 		test_cmp expect actual &&
 		git checkout -b test-branch &&
 		git submodule update --remote --force submodule &&
-		git -C submodule log -1 --oneline >actual
-		git -C ../submodule log -1 --oneline test-branch >expect
+		git -C submodule log -1 --oneline >actual &&
+		git -C ../submodule log -1 --oneline test-branch >expect &&
 		test_cmp expect actual &&
 		git checkout master &&
 		git branch -d test-branch &&
@@ -891,7 +891,7 @@ test_expect_success 'submodule update properly revives a moved submodule' '
 	 rm -rf submodule2 &&
 	 mkdir -p "moved/sub module" &&
 	 git update-index --add --cacheinfo 160000 $H "moved/sub module" &&
-	 git config -f .gitmodules submodule.submodule2.path "moved/sub module"
+	 git config -f .gitmodules submodule.submodule2.path "moved/sub module" &&
 	 git commit -am "post move" &&
 	 git submodule update &&
 	 git status | sed "s/$H2/XXX/" >actual &&
-- 
2.18.0.rc0.207.ga6211da864

