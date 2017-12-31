Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDFB11F404
	for <e@80x24.org>; Sun, 31 Dec 2017 10:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbdLaKM0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 05:12:26 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35342 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbdLaKMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 05:12:25 -0500
Received: by mail-wr0-f195.google.com with SMTP id l19so32460771wrc.2
        for <git@vger.kernel.org>; Sun, 31 Dec 2017 02:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pKO/mZ0CUrcgfv+TCZ4S1ZdkAYSzAppIdAqx/WnAqd4=;
        b=ogDZVKFx3npzwXBRYmyJpvnJ1hEp+PH+lEvJoeBeJ1SoBl511D+goX5gouUtxfHjav
         fs1f1tsm051wFT50ROkB13TBiLcx74rqhJQSDR2TBTxNQL2z/Mkjhfv0JpczkpllIgMp
         UIGeEIl2kIuadYPub20CPydUx7mE5jDuesIb3yFH4TN95VpJ3bm0ScBGgUMJUQtOVTrU
         87wn18o3zd1XE17R3G4iUZMn/bEpz4a/3FeQEAxSDJv9IImfBXyXYU4ek5WMFXLYjws9
         LBmfslr4i+lCDw42pcOa/ZaLo9ij27t2bHMVfpNWAEfGedAR6aC6g9Vx0i8ZgXujtyil
         mImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKO/mZ0CUrcgfv+TCZ4S1ZdkAYSzAppIdAqx/WnAqd4=;
        b=aIXQ7FbZL5gbJV64MONE9efxa+BjLB4w2/oCau+4EKnOR27FeEgwYTAn1kuBtGexYK
         wDU02UJMX50secPOamdx3lHcP3TKJHUoPSDFhl1/btFGPGBVO7zzN9dfCxNMqm6CwiFS
         f4lmTHVQbBu6i5weSwijTZoVFTRqvqC2ZBpc4OiMqTMieFKoV/4ayOMnOY5VKrNvZ0Z9
         oRbBWbBr0vKeqZXIe7NupmrwcWwMK20ampt2grzF6uHjq+3pLEDo131eiP5frjLwTci5
         5cCZEHJ4XAbnXqDbDPaOS7H1y22X2wpU8hwEzoaIw3/9czDiND3kQ2M41HTE2gMeKB7y
         Mfhw==
X-Gm-Message-State: AKGB3mK36bKhcwFn8JUiIkMEF4Toiu8M+ZdSNi1TG7vF90jpArY2eDkv
        tw06FuIgqehmj1Tmb6diRsg=
X-Google-Smtp-Source: ACJfBos4u+ZwlTsY2onpCFBbtZ3lR+/G3D49yeM9eph58HY/yy11zrVCJKoYEAY/YAGLAG5RKwEWYg==
X-Received: by 10.223.150.108 with SMTP id c41mr38488103wra.119.1514715144442;
        Sun, 31 Dec 2017 02:12:24 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id 11sm16357779wrx.73.2017.12.31.02.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Dec 2017 02:12:24 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 1/3] travis-ci: print the "tip of branch is exactly at tag" message in color
Date:   Sun, 31 Dec 2017 11:12:03 +0100
Message-Id: <20171231101205.7466-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.g3a46dbca7
In-Reply-To: <20171231101205.7466-1-szeder.dev@gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com>
 <20171231101205.7466-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make this info message stand out from the regular build job trace
output.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 348fe3c3c..9d379db8a 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -16,7 +16,7 @@ skip_branch_tip_with_tag () {
 	if TAG=$(git describe --exact-match "$TRAVIS_BRANCH" 2>/dev/null) &&
 		test "$TAG" != "$TRAVIS_BRANCH"
 	then
-		echo "Tip of $TRAVIS_BRANCH is exactly at $TAG"
+		echo "$(tput setaf 2)Tip of $TRAVIS_BRANCH is exactly at $TAG$(tput sgr0)"
 		exit 0
 	fi
 }
-- 
2.16.0.rc0.67.g3a46dbca7

