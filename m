Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F0BC54EBC
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 19:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjAGTj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 14:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjAGTjX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 14:39:23 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B8340C27
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 11:39:22 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so1081550wma.1
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 11:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyUgHjw8gfloEMDd5GGwhkVmyVlOEUAhR1Crsh4GblQ=;
        b=PHITxyQEBvwS/hT5G3rViHH3mH401cw8GzFG4rezBHpsNxbNE8KR61f14fwkTdlgJf
         UMhE7vW7RHhfhJT266gXkHkp3IoMh0xSvZyhOG/PqFn4dmS8TjJIDfCvh4J/MjsGm7H3
         z1jY++m7GxqbCbezo1dRVRpTTsQgBx3Klzlqq1s5DCeUnXCtu40VtTzykgTtHvkiCtBn
         ckTWC5nQhHj6Tq+Fe0lwLX4AQbB39QQaXaKC2w8z82E+C8v6IVuKOgQW9ijoUWOnY24b
         3fsH+Q54/1HNKXpR7nsIYq6dYRV2PInIE9Lqnm1xkzMCYGOY0MPSRNWfMGVRpUy9bSt3
         0YEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyUgHjw8gfloEMDd5GGwhkVmyVlOEUAhR1Crsh4GblQ=;
        b=UOp8WibqsFyJpdvBcZfzKSXTwX1x0PO0XpbuZNLQ3gor0dfm+hV8S+HWpNJfyrVyec
         gnKSQrgl+cv++0LhS+eB8yOSaCefhe8hQNFquoa60fCOZGkjnqnXbyDNlSgReMOltJ9d
         7UKeJGvM1MgshfXEzgpAddRUH89mlurhybsTUrc6flPB4FYo0fPJkdG8TKuCXa3zLHuW
         EVzXXjKBYWhOJ71yTmE2D0CywVjG3IdAXoe6mgnRRKTG1wIWviWxDAVVxegOTQK4Z1y8
         O6+sepge1TPF9ID/g1RmcuobWArQ8bt3JbA2gw1JkwphusdIjwRdQ2u1DI/GyGHj+KGR
         U2BQ==
X-Gm-Message-State: AFqh2kpwF/kO8tJLdGTreyunNUOc45a5/Uv9c6okmbC0Gjl1KJ057fY9
        L9SZflBsajGyMytu4nYIivdxRe8+39g=
X-Google-Smtp-Source: AMrXdXu4sbArJ2XGu0eHjJ293QiPjgQwZJS9Cx/HhrVt8akTjA7k49PKc2+eX+peutbK0fSuE5mEHg==
X-Received: by 2002:a05:600c:3844:b0:3d3:4406:8a3a with SMTP id s4-20020a05600c384400b003d344068a3amr51429471wmr.30.1673120361296;
        Sat, 07 Jan 2023 11:39:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c198c00b003d9de0c39fasm7269223wmq.36.2023.01.07.11.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:39:21 -0800 (PST)
Message-Id: <74b2d5a9144e4893311d9acfb0b5e8268da6f0f0.1673120359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Jan 2023 19:39:15 +0000
Subject: [PATCH 1/5] git-cherry-pick.txt: do not use 'ORIG_HEAD' in example
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Commit 67ac1e1d57 (cherry-pick/revert: add support for
-X/--strategy-option, 2010-12-10) added an example to the documentation
of 'git cherry-pick'. This example mentions how to abort a failed
cherry-pick and retry with an additional merge strategy option.

The command used in the example to abort the cherry-pick is 'git reset
--merge ORIG_HEAD', but cherry-pick does not write 'ORIG_HEAD' before
starting its operation. So this command would checkout a commit
unrelated to what was at HEAD when the user invoked cherry-pick.

Use 'git cherry-pick --abort' instead.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-cherry-pick.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 1e8ac9df602..fdcad3d2006 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -219,7 +219,7 @@ again, this time exercising more care about matching up context lines.
 ------------
 $ git cherry-pick topic^             <1>
 $ git diff                           <2>
-$ git reset --merge ORIG_HEAD        <3>
+$ git cherry-pick --abort            <3>
 $ git cherry-pick -Xpatience topic^  <4>
 ------------
 <1> apply the change that would be shown by `git show topic^`.
-- 
gitgitgadget

