Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50ECC53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 08:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjAHIYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 03:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAHIYE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 03:24:04 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C296815712
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 00:24:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w1so5206869wrt.8
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 00:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GytMGzeU9Ftz/VwQoyMsmg5ZVkFot3TInWqxth3UwvI=;
        b=YedzKteKgH/zZimZeQrlJK6wPI7hXfKx4W65EvY1Ia4zxipdiSsWnRk5Bdm8B0dwRC
         zc08UOqE8+9OZGmbDdz7nKrt+/E2yO8m8hBtYibsIpNXu7qknUonYQnoRJQl6QJDpveF
         akVzHS9LrqSUY/+6nBX6piN6ahLhuMvEni0W44/Sg6R74lnZS0mZ/U0FH+iifTgEnOWp
         OXsZGhyXfBt62DOqEPYggGNvYYYhp96e2etBAcaKV49I8hJr5IR1wrDZ8XxQifK44po1
         tHvBwjYsXNoLj1pxUYVmQedqO5CXovCKBJ6e6Bwkjx2HO6J5cDzGa8aDiIdcuWOl0Qy7
         0TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GytMGzeU9Ftz/VwQoyMsmg5ZVkFot3TInWqxth3UwvI=;
        b=roHNj3Ddy1W6OkEzUluPV6c1fL3dePqPeyCzSt/nxN0VENAQ2zxKAsY6fo95r0kAWA
         i0KWGnSQcOHPVehii5gLGrOq8+quSuCS6EF6J8vKE4/MhqGv8i1TM/hVf3o4zRO9XW+B
         781uRkEmSbmhKRsGiIGxhKoM8Yc8femBhcqTFjL5BeIcartcCSLGiToYMIOwpMVOBc+q
         IblFmueXWn3CDg6NDC7WjlefTzOjfLlr9rDqPMLzmh8hBySRDqq7WN0roxFf81/IldbO
         Nt9irxONkdNfnZ3hycKtwq9ZMffMp/TamYdrR/josm368uF8yUlRdZtE2cULIq1hvZWH
         ZN9g==
X-Gm-Message-State: AFqh2kqywO6VTr/bRHbZDOLihTkgBv7YlJoxWsOyZdAI33c00L+dhjBX
        G2+CpFDwe58pzZzSVYq/s50FWu38Nkg=
X-Google-Smtp-Source: AMrXdXuQ9Q1IV8XsIU9FNVfMqs67TVrKRUe0F5ADlGUJf/+IpTi3mUXkQ7EREMWeXPPF/JGfUzAVxQ==
X-Received: by 2002:adf:f402:0:b0:24c:f1ac:9a3 with SMTP id g2-20020adff402000000b0024cf1ac09a3mr34944957wro.27.1673166242220;
        Sun, 08 Jan 2023 00:24:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11-20020adf9dcb000000b00268aae5fb5bsm5637069wre.3.2023.01.08.00.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 00:24:01 -0800 (PST)
Message-Id: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com>
From:   "Yutaro Ohno via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Jan 2023 08:24:01 +0000
Subject: [PATCH] doc: use "git switch -c" rather than "git checkout -b"
 consistently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Yutaro Ohno <yutaro.ono.418@gmail.com>,
        Yutaro Ohno <yutaro.ono.418@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Yutaro Ohno <yutaro.ono.418@gmail.com>

In the "DETACHED HEAD" section in the git-checkout doc, it suggests
using "git checkout -b <branch-name>" to create a new branch on the
detached head.

On the other hand, when you checkout a commit that is not at the tip of
any named branch (e.g., when you checkout a tag), git suggests using
"git switch -c <branch-name>".

Use "git switch -c" and fix this inconsistency.

Signed-off-by: Yutaro Ohno <yutaro.ono.418@gmail.com>
---
    doc: use "git switch -c" rather than "git checkout -b" consistently

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1422%2Fohno418%2Fimprove-git-checkout-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1422/ohno418/improve-git-checkout-doc-v1
Pull-Request: https://github.com/git/git/pull/1422

 Documentation/git-checkout.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4cb9d555b4b..ba3d6164847 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -477,9 +477,9 @@ before that happens. If we have not yet moved away from commit `f`,
 any of these will create a reference to it:
 
 ------------
-$ git checkout -b foo   <1>
-$ git branch foo        <2>
-$ git tag foo           <3>
+$ git switch -c foo   <1>
+$ git branch foo      <2>
+$ git tag foo         <3>
 ------------
 
 <1> creates a new branch `foo`, which refers to commit `f`, and then

base-commit: 2b4f5a4e4bb102ac8d967cea653ed753b608193c
-- 
gitgitgadget
