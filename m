Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE3CEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjFZQZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjFZQZE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7FC10FE
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31297125334so3033025f8f.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796698; x=1690388698;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2WpL2LnEIDybO0wRqkmHT0eENwkULnxZnfbhvEDvYk=;
        b=rvNgAwP27v4SIx2Vmyle8J8G+f8HNbo/2g4iLNuFiJ+HBYs8Bho9+tAMMyhmMQZqFS
         P1su9CtdoY06vxW/AyH82NWVUv1o7SBP4g2Au/QCdvRr1tkqLW3bcrG+Rrb4fEZur7CW
         Ow0CIAoFE5XtzqAOrrZE8pHRn/Eq8eWEFbeDtuOi/BxHJEopHFSH7wjKW807MVttFvkA
         XExiGSpPaJjE3+2ivaaxN16LWcEuTYjRIlxWoy9635IdCb9o1TP82QLFFhgxIQSUaglr
         w2eQzoo5ZroQLn6jaTTNP5CZcP0Rr6pHM1QKxSelTn9i4yJ6Oz2Tc3jwv6fDMfnDN4Tl
         7Euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796698; x=1690388698;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2WpL2LnEIDybO0wRqkmHT0eENwkULnxZnfbhvEDvYk=;
        b=TI+is40qqOFoQybGZXROFFT1+0c34bZkTJjtpPh0p50iMTr+Sfjm0IWj7WCHtlZuVi
         PfBhnkTOf9nL5w2V+jKkIgCVJaOJYb2FGBB6P59DVob8T6KT+GTU8I/KAeOUr0/cri8z
         sVggroc41WI+oWHdHhku+Sa+LuD5U08zA7cFC50UyEl1EDSUjkh5D9byTtY2bgqnPMbS
         aIQgGVOJ2lLcjgTdHh7x7DGuYXrkd95uc7MgfKirTYFQ02hOUmXLlElYtKIW3N/ndoVH
         dVOJOACgSV/C6adFaev1dn8dYBInTkY/h0qEuO9gA2lovKIpOQ3JN27y2e3LKwNmQ3R6
         ryGA==
X-Gm-Message-State: AC+VfDxq4sxeAY5vksj0Az9ymew8T1SGFcyAT2I/R0QafBR+MxJH2yY4
        wmJ4Kdcz0eenIQTFEfKKrzlXyAeJpBY=
X-Google-Smtp-Source: ACHHUZ66O3CDLD5J0RYghcEvn2db7ZaTLg/+ll/dEEF8qsmfVS/NHR4uTBTB1T0gthKgj33YaA/CSA==
X-Received: by 2002:a5d:45c9:0:b0:313:e88d:e6d3 with SMTP id b9-20020a5d45c9000000b00313e88de6d3mr5942094wrs.14.1687796698008;
        Mon, 26 Jun 2023 09:24:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm7919013wri.73.2023.06.26.09.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:57 -0700 (PDT)
Message-Id: <053f9e8620aa369f04eff8f1235eb57d15fe8755.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:33 +0000
Subject: [PATCH v3 09/24] completion: complete --find-renames
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
index 392fdbedd9f..0fa86dcde6f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1740,7 +1740,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--color-moved --color-moved= --no-color-moved
 			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
-			--find-copies --find-object
+			--find-copies --find-object --find-renames
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-- 
gitgitgadget

