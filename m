Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E8DC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 18:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbiC3SKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349707AbiC3SKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 14:10:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309B0DFBC
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 11:08:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so532685wme.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=R+Gy/Zx+GgSuQ7ycdlKmJQbai7TbTAkZJFKd6RrKb8U=;
        b=fZTGpwqiYEgoLpeTWFjD/VcVto9SZ+7m6rlaJwbqikihJMJLUhfGv+LkE0p9TDcZ0K
         zD0ZHHSetTs/EdNfh9FCdM/6tTk3bGRUSIJdabbk35ncbqnvAJHCCNll5ydLspMPc7H6
         PmhnXFSs5pj1muef8FG189bDxvURgh2N739+MCQdT/Fgr3TzdCOLecy+vOQQ07epJqSp
         530L5izpUohAm1gRSTjOMPxKIY5X0ghvLbMrnED35DZfUSZym6mF99iYa0AZwnsFOHUI
         BwEwkhTTYVbCE/TOpkrh0HZcR+20JU6dANyoudOkJPC3LVfavA6MMmRYj0FTC9IRgNuQ
         nkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R+Gy/Zx+GgSuQ7ycdlKmJQbai7TbTAkZJFKd6RrKb8U=;
        b=0re+McZDZA43zYzUPs8vVvGm3jyQmdG9zuR9zP6w6THmY3IIaBkE9j+e0mY6DjASvH
         /YIEBBbyyaAr4rtJD6hxzDoK5z8qGchb+RuQK5pRVL2W+ftMWoFjyalEINcLXSxunUDI
         BPhHt1mQhVEIn3W3To0XS+CU3f0S675miwZuIlhz+iDb3lD/jEJRcwVLUz7WeQfiEfgX
         /+ppx97MSzlwQ/z7rRWGqYDslT36XOenbz4et4tCSfVauWMdXvzGTkLZX7rd+RysfYIt
         ab4DC6RP3C/XhPW3x2JpmZUg2IFXNsCAQbe4tDVY3G8LNIMWI60SiaDHkoj4gulU9iqC
         CirA==
X-Gm-Message-State: AOAM532k7+oLEr90eXw1yPvs0B/mUOKVkIKnSsbOWtDylEOYLiz22gJN
        yHB4idIO2gSXyZ1v/qLejCQNPzFONv0=
X-Google-Smtp-Source: ABdhPJzJR4QLzJ9PoFvL6OtHJmNmCk+vrUo5dc1pL0jHwWHYGZ6wAlhiKP/6iqCBaOjIB1ABqa3sqw==
X-Received: by 2002:a7b:c925:0:b0:38c:82d7:868d with SMTP id h5-20020a7bc925000000b0038c82d7868dmr662386wml.100.1648663718100;
        Wed, 30 Mar 2022 11:08:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a056000144f00b002057eac999fsm18583279wrx.76.2022.03.30.11.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:08:37 -0700 (PDT)
Message-Id: <pull.1193.git.1648663716891.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 18:08:36 +0000
Subject: [PATCH] core.fsyncmethod: correctly camel-case warning message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The warning for an unrecognized fsyncMethod was not
camel-cased.

Reported-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
    core.fsyncmethod: correctly camel-case warning message
    
    The warning for an unrecognized fsyncMethod was not camel-cased.
    
    Reported-by: Jiang Xin worldhello.net@gmail.com Signed-off-by: Neeraj
    Singh neerajsi@microsoft.com
    
    ------------------------------------------------------------------------
    
    See
    https://lore.kernel.org/git/CANYiYbFjRMV-_opvFn78mq7tgtZFMrfPyDjDa+kyaZZfk_LmWQ@mail.gmail.com/
    where this was reported.
    
    This fixes a problem in ns/core-fsyncmethod. Please apply to 'master'.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1193%2Fneerajsi-msft%2Fns%2FcamelCase-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1193/neerajsi-msft/ns/camelCase-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1193

 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 3c9b6b589ab..9eb0dbb448b 100644
--- a/config.c
+++ b/config.c
@@ -1695,7 +1695,7 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 
 	if (!strcmp(var, "core.fsyncobjectfiles")) {
 		if (fsync_object_files < 0)
-			warning(_("core.fsyncobjectfiles is deprecated; use core.fsync instead"));
+			warning(_("core.fsyncObjectFiles is deprecated; use core.fsync instead"));
 		fsync_object_files = git_config_bool(var, value);
 		return 0;
 	}

base-commit: 1d4f13e63720fb8eae39afa215199f7d77662dba
-- 
gitgitgadget
