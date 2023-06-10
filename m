Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5907CC7EE2E
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjFJUVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjFJUVi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FE03C12
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so2909747f8f.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428491; x=1689020491;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=con+oNf6coEKJAsHN/zehDywaFXb8TeuAbNFWjVUlrU=;
        b=j9EbZBhPBITAnM87qD9fnP0XL1Y1FjYfghVZ77jVFoH5gkJjKNolbbaNsMASea/414
         d/kW4yJ7LeaRX2nmItRrTRExpbcPJuBG6V/L0eUoT4Q0wBiq9SQg2++FR6A+sWp1GoCg
         fendjvjaU+W4qAgK46MSLtmVZZgbAJkB425pzdBRQH9/qvkgGRcAwBTmqqB+rvEz89MW
         o8a5MK/drhSZw/VX1nT4gLN9YNNq8oQ00L3L3zncLPjQDXpcDbgOlOvX56Cct4ko3dUe
         xipmaTs21g+oGHDgVnIWpD8T+ROEPkkhL4/oGGEDXLrRagIHZmK0bB8gjZp5/OF1Pof1
         tILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428491; x=1689020491;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=con+oNf6coEKJAsHN/zehDywaFXb8TeuAbNFWjVUlrU=;
        b=AK2EvA9+PdeReCVM0qZPjK6LhZixwMaJhIgvotGH8Jf4644iCjrLkEodkwm+S5PmFr
         9m0lF9j9p4UiHwDvLjVyFyufw/79X9R0vKq+feOOIRzncHGeqORz9078Gz8KHK5EQtMY
         YHb89RxrhxqnEhqR3f0awH3w9oMBi9OUAgEdDj273JF+I9zZSOETgrmLwBznYo74hfks
         5uvT0Y+vsQsGGn3QCJjLh4Eo9t4mazo3S/xhK/ZVYemRSsrFhuOVvSJ81vBzXBiozmMm
         EhGQR/wTVnxvxiHujRzerjfUsls2SUQ3f/svSHhh2woiedn+aJrm9CDl35UPNvVVja1l
         mM5w==
X-Gm-Message-State: AC+VfDy0mUtngVoz6Kk0QWIzWqcIYxiEt05UlqwlZlWvD+rzvC0SsXAY
        OfzLuYXQnzeRxshGLNtov8C+xvgJ0sk=
X-Google-Smtp-Source: ACHHUZ5Ck6aIh0YhJ+auWSYLno4VcOL6YT7XzEeDeLDvX7wWZgYorL9fG7R/aEuVoq7P9t8FGm3V5Q==
X-Received: by 2002:a5d:4c4f:0:b0:309:49e6:d1af with SMTP id n15-20020a5d4c4f000000b0030949e6d1afmr2098585wrt.2.1686428490936;
        Sat, 10 Jun 2023 13:21:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003095bd71159sm7956270wrz.7.2023.06.10.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:30 -0700 (PDT)
Message-Id: <1f9b213cee5a4c6325c7fa9528180e46aab7805a.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:06 +0000
Subject: [PATCH 07/25] completion: complete --find-copies
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6af04932a0a..dd6e12ad8f6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1740,6 +1740,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--color-moved --color-moved= --no-color-moved
 			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
+			--find-copies
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-- 
gitgitgadget

