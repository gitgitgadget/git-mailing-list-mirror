Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31C7EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjFZQZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjFZQZK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0071991
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa74d06d72so35724375e9.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796705; x=1690388705;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwdBHjtyfV6rzWA+n0nevSP5WiAcFN9wTHLE8sRr1Vs=;
        b=hgAA+iDTOEHagm3Dvq/xp6sRrzaIHFFtKyDEsyRs2lFEcl5JPv/HJimVyvIre2mJCF
         pR79Eb0/zJWCAA322TuqoJ1mXW2FTzG1RnHp6MxfuQwS0Z1/qLZ6Xd+pnahaDMSV5hw4
         1FN2Sl1aKSdK9R1HvoNKmLxq7OjvMd/pomZQ2I5h4xOVYJU2Ox0dGXOZT52CrpbECkxb
         52cW9XQCDLwz8Mv4R2J7ZldzeMOVBOEX9v1xNv79qBfEa8Ufw1cMnHkKA1cit+jz2Taa
         YVAY8jjTI5mdWuLvDyaaqk2hpavU5VAszZYbL73eZFT/v9R0t7C7/9oY6FZ9mM6XT1oZ
         0GSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796705; x=1690388705;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwdBHjtyfV6rzWA+n0nevSP5WiAcFN9wTHLE8sRr1Vs=;
        b=i/Iq5n/Ce9dPMtmJVMFA5Kr+2fra1vx5cZh7FhFuW8wsfhGNSZ66mhvNxEyrIvU1VP
         HRlMAvPsS4sDAgiHZhYXGy8oYXQ7QYtQQn7Z5u9OpiuBfWa/da89ls0vWKhUZnhX0J2i
         DKW/3GsGYBMV6DplIGqLGVSOuM5u+SLpemIY1DdrTDmTSOFGSJS4sPj4wmORUls3tlOO
         t8obI8JOBqSFyGhGyMY9+s6kz2w/DnMPUuOX6BWA6dxDe1JBwVSNxNmrIrGOOE3pbQ8e
         pM7lgjQ/AtXiMkBOou+gNRLx4hdfHmY8gyD74d0SdfHaClqYIZuaIuz2zXHVUdvPreNL
         34Kg==
X-Gm-Message-State: AC+VfDwQrbiEzsPyyROEJVfOxLymrbgZ74y+1vPHnbOM/ho+ZbHO8t3Y
        TDD1uEYTz51cD7QixMy9q7WIQynnoWE=
X-Google-Smtp-Source: ACHHUZ6E0nQTqn/91+rMgkJx92Nc+pt3vIi+WvGmheCD39Iv1d6G3BPeAb7ZPJijSkDo4Ml5Ht9UfQ==
X-Received: by 2002:a7b:ce0b:0:b0:3f9:b7cc:723 with SMTP id m11-20020a7bce0b000000b003f9b7cc0723mr13421290wmc.21.1687796705456;
        Mon, 26 Jun 2023 09:25:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bce13000000b003f41bb52834sm11053737wmc.38.2023.06.26.09.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:04 -0700 (PDT)
Message-Id: <cbf2e59cbea00e631637958efd964a004af0efba.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:43 +0000
Subject: [PATCH v3 19/24] completion: complete --unified
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
index a69421cd740..7babd95d844 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1745,7 +1745,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-			--quiet --ext-diff --no-ext-diff
+			--quiet --ext-diff --no-ext-diff --unified=
 			--no-prefix --src-prefix= --dst-prefix=
 			--inter-hunk-context= --function-context
 			--patience --histogram --minimal
-- 
gitgitgadget

