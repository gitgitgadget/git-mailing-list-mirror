Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6670BC001B5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 16:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiIBQFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238334AbiIBQEj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 12:04:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A370043605
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 08:58:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so3580549wmk.3
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=34CmBf8CuIsfMqN+5OEJmvDj0KavnYpIi3zcg1sxGUQ=;
        b=DYL8HHe5hMzVpwzE6iy87hPMW4p8Hm4ZY/SXA9QURDrwTgcGx8kWaZqL8JmAUBFdib
         lEl1s6oJZh3ykqb+YlOKcnKPJ36b0k4YU5hV+kqUd9f+q0eWZ4j5pE1KMmGcPfw1J/Cs
         p+87FzFA+FsfqYvrJj1jrYpV9KhffosNUt0I20BzJXLEkZM0k2VrNabwlBV7tvtuEwj1
         sbpNOjKKHZbKPnE3eQv9RamGUf8+W1rr6ffJYOFPxRzid+YIUi8nD0GvsnTHYTlw2FGT
         YuVZuzIS2j0JLqyxuMTjxOQHGd1CdNqWdZLxpyICWZtDqsC+qz6DphWNXWrHc1h25zrL
         jwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=34CmBf8CuIsfMqN+5OEJmvDj0KavnYpIi3zcg1sxGUQ=;
        b=XvsbVB0nc5dgzrZNaZGlryN29Nq7YYYMi7x8FJjXo5KWXxK21tYcz8GxuPVgjQbgV1
         UBYCzeswLNhzT9iah/WStdd3PMu2f2nOjy5FCc7X59OhS4gqEjEASuX1vv5eTdUMKRIh
         ltBbBrd7cSPkQo5XsvFqNZ5XdWJUioMARjDvTZlX496UFhoemaOpALVgxrKBZrwfgtJD
         j2hVCAIZcm62NtI9B9PFbX6N8QXWZgWmGb+XjpGUWy9t7VNUVTGigORS2ybhIs0F6PAd
         9tHwt7wcgzbM3+oz37bNclsQyEqt7NtmuKW3RwSztcGvIZakfmKraYpYZgEXwe7MXoVW
         Q5gw==
X-Gm-Message-State: ACgBeo0ML99bNdGshhqLsNi2vkF2UFBEnbrvHnFfQS6IWBB5vRGB8znA
        MV2RXtQVHkZylVerXEZU91C++/IG5V8=
X-Google-Smtp-Source: AA6agR595xcyLS2m6+PPO+DZwVIsKnZqBi2+9bO9ynImeflMq3O/RpOrP22D9yMdup1Si7JmeQ+A0g==
X-Received: by 2002:a05:600c:1546:b0:3a6:a99:aa7 with SMTP id f6-20020a05600c154600b003a60a990aa7mr3167185wmg.109.1662134215753;
        Fri, 02 Sep 2022 08:56:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bk23-20020a0560001d9700b002252884cc91sm1826205wrb.43.2022.09.02.08.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:56:55 -0700 (PDT)
Message-Id: <eb8663e0300784cc211e02b2590d38d4c4ac610b.1662134210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
        <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 15:56:44 +0000
Subject: [PATCH v2 3/9] git help: special-case `scalar`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With this commit, `git help scalar` will open the appropriate manual
or HTML page (instead of looking for `gitscalar`).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/help.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/help.c b/builtin/help.c
index 09ac4289f13..6f2796f211e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -440,6 +440,8 @@ static const char *cmd_to_page(const char *git_cmd)
 		return git_cmd;
 	else if (is_git_command(git_cmd))
 		return xstrfmt("git-%s", git_cmd);
+	else if (!strcmp("scalar", git_cmd))
+		return xstrdup(git_cmd);
 	else
 		return xstrfmt("git%s", git_cmd);
 }
-- 
gitgitgadget

