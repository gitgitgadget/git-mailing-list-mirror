Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C9EC19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 22:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242445AbiHGWeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 18:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbiHGWds (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 18:33:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74148F4C
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 15:22:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p10so8985473wru.8
        for <git@vger.kernel.org>; Sun, 07 Aug 2022 15:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=CJrHJwWAWQLZK9wbBV1D6QVaQ0YF3LQfpFn02+7oa/c=;
        b=ox8ih2KrnmiJN+F+sXRhvNC67nxMiAyz7Zdd26oQHTXa1aigS9YjZHRrubz756lcxd
         VfqnBIQVCo+fxLhu7Urs4S7XoJ7Y0bAaro+CfplWYT4q9SRj82TYf76dVKbzmLK0IXTZ
         Wc29fTwMlW5pbGPH8CJs5gdWouFELex6kx4CHNDnxEGIvEuAY2gSyKdLjr/VFKpsu4Aj
         seP5G65WrKwTMAWsEKKMcZ7HHJHt4l+Hyisw7MOe3JOQ2NKJCYt/SAhr38z7CdUVUFrs
         FTXzn/UAhM8WbaCpRAZ8oaqXbo/1tW9q1LOKxq4aQOQqDFaJNUTT7pRdw9IKVoB1KjBP
         BwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=CJrHJwWAWQLZK9wbBV1D6QVaQ0YF3LQfpFn02+7oa/c=;
        b=AWBHqjfTpRC33a9mXCUoobksUpvevS9OQdkqWrrvdCoWyS23OvLGlgJ3Ac07+ia5YX
         CqIZ3nd4Ksn6xpUD6lQWhNPEcZqRZiXKkzypmfNMCe4DazLJa4nnbqYaOFGVtO2Ah+CO
         eQVCOzw2D9TD96kuEHp3q3VJVsIb3WMQiJZ8xq5tS5ibgqcr0rC9f2edVvpH+D1Bib6Y
         ByP/o6U1HEtMGUR5ZzGTMryY+Myus8Y7XowvZH1vCRNUWUlMopB/ui3ybMRE4ZujU34X
         +JFhiqfK9vYf6Lz6ovEqQPkFsguyl1Vik5Sgr9et0W1DXSNZhW+BTEAbLSBRu7t5NwBU
         +Emw==
X-Gm-Message-State: ACgBeo3unhOYJWfuTM2HbRx7vkFmEfeIBZeX8iJI8zkVMFEkzq3S8DSC
        670N2JKqOoUaD/VARFkaL0JcrcVSi/s=
X-Google-Smtp-Source: AA6agR50p0JLI/AdEo1jWyc+bUbmqPt/gi9GJ9EMekqAVibfNntPzm07dgtDSq6+kEQw4UrS+BZ5Pw==
X-Received: by 2002:a05:6000:61c:b0:220:6425:c113 with SMTP id bn28-20020a056000061c00b002206425c113mr10304579wrb.612.1659910950752;
        Sun, 07 Aug 2022 15:22:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003a501ad8648sm12487430wmq.40.2022.08.07.15.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 15:22:30 -0700 (PDT)
Message-Id: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Rub=C3=A9n?= Justo via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 07 Aug 2022 22:22:29 +0000
Subject: [PATCH] branch: allow "-" as a short-hand for "previous branch"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        rjusto <rjusto@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: rjusto <rjusto@gmail.com>

Align "branch" with the intuitive use of "-" as a short-hand
for "@{-1}", like in "checkout" and "merge" commands.

$ git branch -d -      # short-hand for: "git branch -d @{-1}"
$ git branch -D -      # short-hand for: "git branch -D @{-1}"

Signed-off-by: rjusto <rjusto@gmail.com>
---
    branch: allow "-" as a short-hand for "previous branch"
    
    Align "branch" with the intuitive use of "-" as a short-hand for
    "@{-1}", like in "checkout" and "merge" commands.
    
    $ git branch -d - # short-hand for: "git branch -d @{-1}" $ git branch
    -D - # short-hand for: "git branch -D @{-1}"
    
    Signed-off-by: rjusto rjusto@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1315%2Frjusto%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1315/rjusto/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1315

 builtin/branch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e998..59c19f38d2e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -241,6 +241,10 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			die(_("Couldn't look up commit object for HEAD"));
 	}
 
+	if ((argc == 1) && !strcmp(argv[0], "-")) {
+		argv[0] = "@{-1}";
+	}
+
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
 		int flags = 0;

base-commit: 679aad9e82d0dfd8ef3d1f98fa4629665496cec9
-- 
gitgitgadget
