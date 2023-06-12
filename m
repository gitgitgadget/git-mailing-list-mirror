Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CC7C7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjFLMyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjFLMxS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7773710F4
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f736e0c9a8so31755335e9.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574389; x=1689166389;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C4+Z+JYxHOHgPNO9HRTisJPCa1ZLhtMUtS+8PzVvZc=;
        b=kz+CjkjF7E8vTwPiU7zCTzFTJbKviGa/GOiH2co7KjSlbmBvgRl6hnqeIop793JbTo
         2djXY+J75kjzOVcw4W9hW6+vMoOORd41+hSbuBIbmVFGNNfd/yo4J7sLYADwMZ4LVd9Q
         mxjt9wn3A6xeBHb/Sb0XxyaVmIe/M3WXelax1O5R8Y8mA36bXUEEtXYOy7Gsi7DGkLPI
         MNycIh6RwD+3MZQeDlnJ0DxTbbOw/ZAa/CqFgUCFKOYWmYyvXMK/2iPFB6EcZhQxwcaG
         YhillyvCDY7TB1jVJBoeNE14qqoyDKx9NzGMe/HCrncZfgAjlrVrmOmPlCXVH4tzyGvk
         hcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574389; x=1689166389;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C4+Z+JYxHOHgPNO9HRTisJPCa1ZLhtMUtS+8PzVvZc=;
        b=EZ2rR7xCJkFmXd+Z0DvoVC9oIq8GlWAkvHKez9KnRjALq8aPVros/2+hkLQ5Dvlz1H
         gpL/x4FHK/FgRArl+T55RZsAWvHYQWPZB4NvF5aRVKiniyIUR5zQ7j36YwqkRghUKwhe
         yZEGEMaMxIqlAXREZn72KPItV0+N7oOTXJE+x0AT7aUrElco3zMV0rvHnJ6k5Rzuuo1a
         8SHFVntP6zE7cnQGJSM6gpJcu6d6gGsytLxQqEjCWPVrl+Ey1gg86A1W9mJc4sEZ75yf
         9Asgb7VNaHvQPaWy9y0ghBUkyY9iRlccFLY9XJ7FfJAVJ27seuo2YX9uLAMrlVuy+9Df
         d5tQ==
X-Gm-Message-State: AC+VfDwxghA48pOR1F5CiDO8hEfb1DTkrrJTUNj+sxkhZs7H1rabQBwA
        PGKKWkS8toGJ+QAhCS5CFI1RDH1Zb/s=
X-Google-Smtp-Source: ACHHUZ6+6CKoxLU731pyQ/a4404iF2ViciNXfI1Rx3ZQanbe6vqKzASb0EOW01FyttWaYcRyOJ3OUg==
X-Received: by 2002:a7b:ce88:0:b0:3f7:f4bc:ebe7 with SMTP id q8-20020a7bce88000000b003f7f4bcebe7mr6197270wmj.37.1686574388716;
        Mon, 12 Jun 2023 05:53:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003f7ff520a14sm11301554wmj.22.2023.06.12.05.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:08 -0700 (PDT)
Message-Id: <0f16a466fd9bdafe0365ee9cf1bce81fc11767d1.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:44 +0000
Subject: [PATCH v2 16/25] completion: complete --no-stat
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f4e773cb997..ec2e4c9e711 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1758,7 +1758,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--textconv --no-textconv --break-rewrites
 			--patch --no-patch --cc --combined-all-paths
 			--anchored= --compact-summary --ignore-matching-lines=
-			--irreversible-delete --line-prefix
+			--irreversible-delete --line-prefix --no-stat
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

