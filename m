Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D962FC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 19:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbiCaTR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239574AbiCaTR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 15:17:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5970F232101
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:15:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h1so464731edj.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFJr7/6eZiD1jqROkOEcrhj1XGgNaE8VQbBdLPtIfCs=;
        b=p4Idpfa8qusYC2i75+6FR/hyl/byOq0BIjJ4tTqYz8ZybupCtTnbFg/4rAj9ddPpje
         RjNDgYfyG2MI2UiMbp8MjkdJjtrE88M2fHH/f2ycb5AAReaBUx3Aw7D+S4nFx0JcE407
         RNfpo7Wf4kUIKLoqTxfXEcjRbtXZZOBANA/UnoTL4fXqmEvu9lHo2hsXG03NZSHplDEA
         /yxaftouE3dyxd0cg9Xc9nAFjqS/0ynPj/2PZiADfFudLG6J0HUn73gKlXV7IY51WEhN
         dniqFhBWy6mOdHGEkbQId4zCWKw4IekXfiqkGf706MS+xxHD+GVHpCaYOSrQgRmxJD0h
         U0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFJr7/6eZiD1jqROkOEcrhj1XGgNaE8VQbBdLPtIfCs=;
        b=jgaAzg2rYvHDWqZra1zppDxdNNTjeNL4B5muj5X6APnHB+lF230OdjSst11m8crbVP
         OSJF/0kw8CDkO0x/sHe2tejqJEyOw3RKSVXzDvt5pSPRZ19BT3m8Lix2k0Tzo17vTsJ0
         CXABOqKM44Q6SuzWM0HTV3OqF+q8nL3xCymZqCHPA0XHDk+VbPHp3wWQfot06OgoDfeD
         tSTuOdkaPcmRr7ZWLNbWOQpcKantqW5GPkzHJix7nplMwwJin7UDCfVM7AAzbaGgsyJp
         8LDJAlCNfr82WwZmg/fA1K5rj1nP8Y/jCqtdOnhLRggpGRK7LUnVCTaTEOTvuG8JTqkT
         a/DQ==
X-Gm-Message-State: AOAM532TFozFTiXev2C5xJXWoUqrAnxd3qvxXo8y2/2dIX7uda8UjSkO
        O5b6DMVvC9uO2I26fL29PEzMyGU8B1w4ndHzJ8Q9Ng==
X-Google-Smtp-Source: ABdhPJwPlKO85WNFwVfbD/j/IwBOLZcrJUwgM2DfRqYmUlCrT/ACmq82D8KfPVP9eVzZ9kLbMzYWfQ==
X-Received: by 2002:aa7:c881:0:b0:419:1a3d:4437 with SMTP id p1-20020aa7c881000000b004191a3d4437mr18071648eds.378.1648754137792;
        Thu, 31 Mar 2022 12:15:37 -0700 (PDT)
Received: from a35b75bc573c.europe-west4-b.c.codatalab-user-runtimes.internal (81.245.204.35.bc.googleusercontent.com. [35.204.245.81])
        by smtp.gmail.com with ESMTPSA id hp12-20020a1709073e0c00b006e02924bf20sm106181ejc.117.2022.03.31.12.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 12:15:37 -0700 (PDT)
From:   Labnann <khalid.masum.92@gmail.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        khalid.masum.92@gmail.com
Subject: [PATCH v2 1/3] t3501: use test_path_is_* functions
Date:   Thu, 31 Mar 2022 19:15:23 +0000
Message-Id: <20220331191525.17927-2-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331191525.17927-1-khalid.masum.92@gmail.com>
References: <220331.86bkxnt77a.gmgdl@evledraar.gmail.com>
 <20220331191525.17927-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two test -f are present in t3501. They can be replaced with appropriate
helper function: test_path_is_file

Signed-off-by: Labnann <khalid.masum.92@gmail.com>
---
 t/t3501-revert-cherry-pick.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 8617efaaf1..45492a7ed0 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -67,7 +67,7 @@ test_expect_success 'cherry-pick after renaming branch' '
 	git checkout rename2 &&
 	git cherry-pick added &&
 	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
-	test -f opos &&
+	test_path_is_file opos &&
 	grep "Add extra line at the end" opos &&
 	git reflog -1 | grep cherry-pick
 
@@ -78,7 +78,7 @@ test_expect_success 'revert after renaming branch' '
 	git checkout rename1 &&
 	git revert added &&
 	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
-	test -f spoo &&
+	test_path_is_file spoo &&
 	! grep "Add extra line at the end" spoo &&
 	git reflog -1 | grep revert
 
-- 
2.35.1

