Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F11C74A5B
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 15:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCRPdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 11:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCRPdK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 11:33:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2E62364F
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:33:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r29so6779223wra.13
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679153587;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=86V7KqPQGpP3EPs+NqEzDuvwYPzPHuCMIGQDog1q7DM=;
        b=ReOHq2WrQq0wt3RBMml0vGD25R3Lj5cGwh3hvkcyl10aIcek5gNKiFNcXmyhXWUQUQ
         djXgZHEf4+Y+L13MoKk/qdnD3fLcArF+7hgaVS7qgLhQp90QrcMCNXW1FyxhB+3Lxrz5
         rBwVr2mPxugWgo0lEwhutkmFxAklJ2R3nv9CRZwq+eCb+AaL5N7P3Np6UK+GN9ExgoJj
         48O9u5pz6nnkJJ2FqhJYN1RjlXipesf6GmjhLLj3uOZh8p8c9grkdiMVDIbjbSIXHt46
         EERR2PIl8Axcjnmz02c20pi4TW/zzvnfc25sy81OMAyAgoiJtwiHhEGecESuq/OlgmQz
         rJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679153587;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86V7KqPQGpP3EPs+NqEzDuvwYPzPHuCMIGQDog1q7DM=;
        b=fHlU4XwEdO9tdfExD3YBRv8vvMiZv2nbmei15YLlRlTRgKhNZ1GPGIH5H/X5Leh+t1
         HKjo7YFqt7VDKc6sbg/QP0q0XnIpHKqvE04xNbSxoo9y6G4vhOS1ek9zd0MOAiayrrWb
         rxKRPCRS88itVi+Jrw8LUlx32PZ2prrTAphXB7xrEtaPwbrfAwSYR/rn+QUKOKoEqbc7
         0/hgj31pf9C6ecHkhMf2F+2lpx2Maqk6SQylYonVJSLxn297BsuaR00gQJAxFPaNnDEe
         eY0rH8BPM2T+qmNbGZ1WQtIg0WqjVV9dE/6621uY5E10ep8TkApy/5Zf7SeVIz31kg0L
         gmgg==
X-Gm-Message-State: AO0yUKWiz7PysQcurnnv1E5EX1njXNBSQyi8L8HvtuF5VK+Ic7erBJsv
        ysXvskWLnu7zqlLy5XIMXz03ut9+WC0=
X-Google-Smtp-Source: AK7set+JA9iT2dOaWe1/qpyuFw4jLiCOSY6BiCj1XKCMUzx0oCXbu/csiZrAjPlldNy1Quuq0+UFFw==
X-Received: by 2002:a05:6000:1111:b0:2cf:e315:10b8 with SMTP id z17-20020a056000111100b002cfe31510b8mr10658916wrw.10.1679153587655;
        Sat, 18 Mar 2023 08:33:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17-20020a056000011100b002d30fe0d2fcsm4580722wrx.13.2023.03.18.08.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:33:07 -0700 (PDT)
Message-Id: <pull.1471.git.git.1679153586903.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Mar 2023 15:33:06 +0000
Subject: [PATCH] Document the output format of ls-remote
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

While well-established, the output format of ls-remote was not actually
documented. This patch adds an OUTPUT section to the documentation
following the format of git-show-ref.txt (which has similar semantics).

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
    Document the output format of ls-remote

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1471%2Fvermiculus%2Fsa%2Fdoc-ls-remote-output-format-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1471/vermiculus/sa/doc-ls-remote-output-format-v1
Pull-Request: https://github.com/git/git/pull/1471

 Documentation/git-ls-remote.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index ff3da547ddb..04cdd933b0a 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -96,6 +96,24 @@ OPTIONS
 	separator (so `bar` matches `refs/heads/bar` but not
 	`refs/heads/foobar`).
 
+OUTPUT
+------
+
+The output is in the format: '<SHA-1 ID>' '<tab>' '<reference>'.
+
+----
+$ git ls-remote
+950264636c68591989456e3ba0a5442f93152c1a	refs/heads/main
+73876f4861cd3d187a4682290ab75c9dccadbc56	refs/heads/maint
+d9ab777d41f92a8c1684c91cfb02053d7dd1046b	refs/heads/next
+74a0ffe000da036ce4ca843d991a7c6b8c246a08	refs/heads/seen
+860bc4360c4fcba0fe2df942984d87f8467af3df	refs/heads/todo
+d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
+8810a79228a149a9773bf9c75f381fca27a6a80e	refs/tags/v2.40.0-rc0
+f899c182d0bffb6e915da7c8db9be202b144c098	refs/tags/v2.40.0-rc1
+6bed3304b2b2f1cf440ca3050b57a7cf3a3fe687	refs/tags/v2.40.0-rc2
+----
+
 EXAMPLES
 --------
 

base-commit: 950264636c68591989456e3ba0a5442f93152c1a
-- 
gitgitgadget
