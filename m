Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE206C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 15:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA87C64DAF
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 15:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhCAPCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 10:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbhCAPCo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 10:02:44 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E2AC061788
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 07:02:03 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n4so13393046wmq.3
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 07:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/cJ68HCByhmRS58sXQ/dXg3YUEWKZcFWw+kbFFvspjM=;
        b=GXN2hO4RMzaXQAH9eA/ny2ZYEh+TcFfVJAn5PJtcuvHi4BwomI7JnjPWiMWI7uDS3Y
         Ufx7qXWioM/N9m1a2QALd3k2yHAhIHHQiEwotBquDQ2aJ/InrvTd8BEJ0GnZHqNLISHM
         QeE7ecnON0fuR0T+ZndpZ/XVe8k5Xwfuen5ryYsjGL/qocle7dl10OF8ZZY1t5Z8y7np
         iUyruDo/xKUN8fvOaAPaz+l8mBZNkBtnLEKW5Sohl4xkbY0EgOXri3wd3zkdAgE+dBUC
         NbN80Nu78SW8Rq4zPwOccTzwclPCEvig1OlSF3FmgQAB/IB51xd3sZmxXdwDYSEVOh5h
         zCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/cJ68HCByhmRS58sXQ/dXg3YUEWKZcFWw+kbFFvspjM=;
        b=m1FrwfDwK10oDKnmr35AUNRSYJwsro8F1RTI4ppr5iUVjzj9gND4euS1g4G0vuBFol
         mEGQpZ6rQTJnvjwpoa1cSp/cB5sYjr/GKoBdsKWA5WAYfq5vEuMds2My0ruBAszXnYHU
         ohUuv6dy2BiSSAL7tiMHZcXxGAdgD2N3dIj75wrhJea10W976p5BCXNx/DT7WXomOujM
         k8srcalnqxf4RPeidUJeGKZmLfEI0ev57NV+EGvs9M9ewC+KwDk/G99VCsTauDPfAuo9
         Cv0jxv1EWrKJCa+f0nOVfcosq7ZrwijgPpqc2Jy1J+NTlqOtFonhcBum5HJW017nb/Eq
         kzAQ==
X-Gm-Message-State: AOAM533ReLI4Bu8uqUWUJjeESAuAmuaybIVvQAOM5U7x0Z+X1NYOoyyK
        oyJi9ntGAH9GkVEIqMUOt9QVXSfPNfM=
X-Google-Smtp-Source: ABdhPJzIrD24I1xxLSWkPoTGXX0FWiuHkk5vgl9AEwc6VpQgUd8PV/uOaTZtNSmxE4dAt3Nl+cQJaA==
X-Received: by 2002:a7b:c44a:: with SMTP id l10mr15919172wmi.179.1614610922524;
        Mon, 01 Mar 2021 07:02:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11sm12702788wrs.80.2021.03.01.07.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 07:02:01 -0800 (PST)
Message-Id: <pull.970.git.git.1614610921331.gitgitgadget@gmail.com>
From:   "Marco Luzzara via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Mar 2021 15:02:00 +0000
Subject: [PATCH] docs: clarified that --lost-found implies --no-reflogs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marco Luzzara <marco.luzzara@hotmail.it>,
        Marco Luzzara <marco.luzzara@hotmail.it>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marco Luzzara <marco.luzzara@hotmail.it>

git fsck --lost-found does not look for references in the reflog. If not specified, it could create misunderstandings like this one: https://stackoverflow.com/questions/66401232/git-fsck-combining-lost-found-and-unreachable

Signed-off-by: Marco Luzzara <marco.luzzara@hotmail.it>
---
    docs: clarified that --lost-found implies --no-reflogs
    
    git fsck --lost-found does not look for references in the reflog. If not
    specified, it could create misunderstandings like this one: git fsck
    combining --lost-found and --unreachable
    [https://stackoverflow.com/questions/66401232/git-fsck-combining-lost-found-and-unreachable]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-970%2Fmarco-luzzara%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-970/marco-luzzara/master-v1
Pull-Request: https://github.com/git/git/pull/970

 Documentation/git-fsck.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index bd596619c0d3..9f1db29042f0 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -89,7 +89,7 @@ care about this output and want to speed it up further.
 	Write dangling objects into .git/lost-found/commit/ or
 	.git/lost-found/other/, depending on type.  If the object is
 	a blob, the contents are written into the file, rather than
-	its object name.
+	its object name. This option implies `--no-reflogs`.
 
 --name-objects::
 	When displaying names of reachable objects, in addition to the

base-commit: 225365fb5195e804274ab569ac3cc4919451dc7f
-- 
gitgitgadget
