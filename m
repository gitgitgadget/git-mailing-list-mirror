Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4185EC6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 09:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCVJmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCVJmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 05:42:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C43638E8D
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:42:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so6140124wmq.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679478128;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ/jU7pqf8b3xIDwzh02sNUpWUuaw9LgZDliARc62d4=;
        b=kXiNbls0wHUo9AJSCy2y4gorxl9rEGrfFR2uOUzTdTWY2LXPqwy+dZmcALCLK1Llph
         BnQ175nU38eNxSXNXacnBWRa2bAdgf2rPVbwt3eEKMyNpCP5OrMl1Qddb5cdZdb1IAvb
         L+BkZHuHdYVHOZP8TTynxnkyXkUYxq9pLaz9yESTYA72JxOW9leZY1+VEkMfsDe7aLMg
         jnuXAKv5dZ0K1CIqtu89bo/JSnkdEtKSKB9NrS0w9/7Zma4tVXR+luTPaRlyy+Sy3Xg2
         b1yQODT0DqvIa9s94ddIp9tdRNXEa7Iw9eGxJiISHJ0XeBHVX9hFyHmttmWoSwxPgTkw
         KBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679478128;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZ/jU7pqf8b3xIDwzh02sNUpWUuaw9LgZDliARc62d4=;
        b=X2eZAZjp2nWcbP/wKBE7LiJLrhvHL9B4+dBZbviKfqYMDX4WPI0QjJU2e5DkhXCRUc
         dbK0sNPRTuynGKu6O+oendZ0IDeOV9V2/WQ3Mcfb86zpTuhnUwYWSgkXcWHzpBwtp1hZ
         xSA40nTzL7NawEWb1kqhTIEWhLbn5z3mj+W93xmOopSwVfQNeQHqBNf9yz+WWXGtVfF8
         KYtGOT/KaLFGM68cZreHa60rxYfnBLKoFJCbNAjF2GiiKRk/VX/p4fGvQKuPbxkyaiTB
         cGT1CH+aPN+OmDRN3CIq1eIFpnejuiUh/LmJo2eW8i0Yx2ZN0AMrYzCORBSbYq9MAkoK
         Vsyg==
X-Gm-Message-State: AO0yUKUW0XirJCYBXbDRKtV7lIpL6ypTuuUDdE2KQbjTvkeo2Zcf+DtL
        wwdEahk0QujRrw82X+bq4l+lNgg+TVk=
X-Google-Smtp-Source: AK7set/9slH249eefUtje7GxvEl6Vu9FEgiFetz674hNzc83gNFLmY6enmRTVVWskVW286ld0XBq2Q==
X-Received: by 2002:a05:600c:3782:b0:3eb:3104:efef with SMTP id o2-20020a05600c378200b003eb3104efefmr4832083wmr.31.1679478128366;
        Wed, 22 Mar 2023 02:42:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d5646000000b002d2f0e23acbsm13405451wrw.12.2023.03.22.02.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:42:08 -0700 (PDT)
Message-Id: <27f27f3afd76fc974350c0c94e20307879eead84.1679478126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
References: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
From:   "ctmbl via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 09:42:06 +0000
Subject: [PATCH 2/2] Fix mem leak in branch.c due to not-free newly added
 virtual_name variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ClementMabileau <mabileau.clement@gmail.com>,
        ctmbl <mabileau.clement@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ctmbl <mabileau.clement@gmail.com>

Previous commit introduced virtual_name variable which is the name of
the branch in case it has been a remote ref (used to check whether the
user simply forgot `--remote` flag) but didn't free it.
Call FREE_AND_NULL(virtual_name) to solve it.

Signed-off-by: Clement Mabileau <mabileau.clement@gmail.com>
---
 builtin/branch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 8e768761b9b..697636e2874 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -279,6 +279,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 							| RESOLVE_REF_NO_RECURSE
 							| RESOLVE_REF_ALLOW_BAD_NAME,
 							&oid, &flags);
+				FREE_AND_NULL(virtual_name);
 				if (virtual_target)
 					error(_(MISSING_BRANCH_HINT_MSG), bname.buf);
 				else
-- 
gitgitgadget
