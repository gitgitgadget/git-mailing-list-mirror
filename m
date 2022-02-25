Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A274C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 11:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiBYLov (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 06:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbiBYLop (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 06:44:45 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907431E14B2
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:44:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l2-20020a7bc342000000b0037fa585de26so4823606wmj.1
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pWOANChktqXZqyD503SAEm/0ScvOHwxy0awSpFK8YUE=;
        b=FJlsmP7kymDpH6NVskdzTo9ZiLorB2GthK8JbFNkDGnoZcZyea5k6Z+r2PswR6E0xx
         qIZIDKaQ6pJYDHqS+N5qKlKrazE+K0RdgwdEGft91JMQAKDDDz64WH5Ox4nyM2CqGWs2
         VefNLiGrHBinZf+2FIPVQ8GOWBO1KJeyUzwxyNr92lTluFZylexrzoucJeG7NjTBipmi
         4vlkQ3tpqq/3VZY9HBr1qQJgk3ObOb3dlqFrdL+X8xSlDG+z+iPOccaQXv+ysKbo2ljg
         yk0YcQ+oNJF2PHdJpqiQGmY/Gu6isx4FHHJYrmYAY8LKJ8fwrSDzn+Ywrsu3Ttxi+On+
         wzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pWOANChktqXZqyD503SAEm/0ScvOHwxy0awSpFK8YUE=;
        b=Yebwy+jWTCaR4jLJMrBX0M3FDsN+yllMGITt0Cjy63GtBg4e8XUWmkc3CfYvWHKTpC
         MPUwOdMNYtURLbfsmOAHMGfsq2WpSY4fukrCiouaXLqBd3EDEK00A321BWff1gC/Sze6
         gieBowiOmvA3+zd+FPfgUuuXoV8lUtjHaXSPqqy8w1Qvcni2Kxl0tBBPCr9z7F7dIz6/
         0d8SW6bgFyI6YIhstd5ZxRLzigg0GYyVWINH7GSN/GHXblIuBj+atS5I3+2tcvbvqm8t
         EeOp2BlHEUn0w9LYabbxteNy6pud4FkREjcOdW3FLjYu1YOXiYj4rcFs+qId3VvTQ560
         y4mA==
X-Gm-Message-State: AOAM530pvv3rI+0lKne8oCOJ/iWVVF2h389TpdHraPfBclEbtIC6RTw5
        C2wOYqJDyiqAHAd7NgHYnil9NJkeZuk=
X-Google-Smtp-Source: ABdhPJx+XWH8He2ChBJ8OzHZ3CUMtn3BgrD74Ak0+xtx/OVI5N2tnpX7bgDTIwkOa1kyeiB19w35VA==
X-Received: by 2002:a1c:4d0e:0:b0:37c:b85:5404 with SMTP id o14-20020a1c4d0e000000b0037c0b855404mr2325308wmh.184.1645789449879;
        Fri, 25 Feb 2022 03:44:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b0037e9868e364sm5827091wmq.33.2022.02.25.03.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 03:44:09 -0800 (PST)
Message-Id: <83766e33614dbb90c1162bd9f6d7fc9c11cd2f60.1645789446.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
From:   "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 11:44:05 +0000
Subject: [PATCH 3/4] git-prompt: make long upstream state indicator consistent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Justin Donnelly <justinrdonnelly@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Justin Donnelly <justinrdonnelly@gmail.com>

Use a pipe as a delimiter between short state indicators and long
upstream state indicator (e.g. `(main *|u+2-1 origin/main)` instead of
`(main * u+2-1 origin/main)`) . This is consistent with long state
indicators for sparse and in-progress operations (e.g. merge).

Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
---
 contrib/completion/git-prompt.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 613389a53bc..2772f990888 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -109,7 +109,7 @@
 __git_printf_supports_v=
 printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 
-# stores the divergence from upstream in $p (for short status) or $upstream (for verbose status)
+# stores the divergence from upstream in $p
 # used by GIT_PS1_SHOWUPSTREAM
 __git_ps1_show_upstream ()
 {
@@ -219,13 +219,13 @@ __git_ps1_show_upstream ()
 		"") # no upstream
 			upstream="" ;;
 		"0	0") # equal to upstream
-			upstream=" u=" ;;
+			upstream="|u=" ;;
 		"0	"*) # ahead of upstream
-			upstream=" u+${count#0	}" ;;
+			upstream="|u+${count#0	}" ;;
 		*"	0") # behind upstream
-			upstream=" u-${count%	0}" ;;
+			upstream="|u-${count%	0}" ;;
 		*)	    # diverged from upstream
-			upstream=" u+${count#*	}-${count%	*}" ;;
+			upstream="|u+${count#*	}-${count%	*}" ;;
 		esac
 		if [[ -n "$count" && -n "$name" ]]; then
 			__git_ps1_upstream_name=$(git rev-parse \
-- 
gitgitgadget

