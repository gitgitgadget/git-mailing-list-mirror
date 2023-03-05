Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B505DC678DB
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 01:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCEBiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 20:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCEBiE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 20:38:04 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664127A9A
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 17:38:03 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-176b48a9a05so140741fac.0
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 17:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr4oacVXQPSAnjsqNipDBtUlWv51IlFrOHqyjbdkDh4=;
        b=VCPRjGl0ii8bO9iZx1wgX0kjJLW4YbBYLd4nhSSih3MRd/Sr9Cyq5m4C0xmH1sJsIu
         QzDrlCIIXMd9KnyNnhLc0EynQmbxjmQSGK9lEqDabum/5EQvK8+L/D6cXd6lyiAcRdP+
         q5WLMHTfL2WwYJl2W6gH4hogU207RwXnps8cTXUiIbs5Z3eBzEBPkzxpZDBWco61nHXC
         CzsMSSlPKGj6JPisFDErrR/oocQix/iDsJCuM8gkgaFfoPX+xgA6Qn4Y64hmfi6rsL5k
         /JAKytc8hiN/xAhHuYWa8GtIuDWKtNPWhNGXEzKVBgAqx68kaRvo6U5c/9zw2y8xE1RB
         ddVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr4oacVXQPSAnjsqNipDBtUlWv51IlFrOHqyjbdkDh4=;
        b=Q/mFIK8lcaPxBv9sdeZrzkjftLySpr0yeVHmRY5C6h3U+nbsr0pzSMN8X2iRPidCFw
         lcB97y7YLnFav+ksyyIOzEfn87hPH2081yc/an/rji6AfQ4Jjk+yWn7lXxQ4WyyKWZ8n
         ZVsAdn76TPn6VMWIX0DfbfpWyjrA9NRAP8i4N/22pa6d1IOFlx8Xst5s/V1Z74AmhzXz
         ohYHjDMpciDCEoFKReW1+bM+qtxHi9tFCOrQwWXLpgobkxzZGhipm6+n1eL6M2BsHnch
         Bub3JacLp/4YgqlNXu8w2mqbr974Hh+MBgBeii/L3nfufG4E1fMHWprv2E+sXQ8h8hn4
         tNOw==
X-Gm-Message-State: AO0yUKXLMSztlSpafLzG59T7QHV47VJDfz48e8M5NBYdMm316bAybpND
        LEpvm0G2jzMgJUmYS8CmxM4OUGkhsOQ=
X-Google-Smtp-Source: AK7set81gYK3g0XavzEFxymWlT/H1hPRm08tdrqgxT3ZPlGadgHjBx2cE017487wux5jHtMKUhFnPQ==
X-Received: by 2002:a05:6870:2198:b0:16d:eaa7:66d7 with SMTP id l24-20020a056870219800b0016deaa766d7mr4295717oae.2.1677980282405;
        Sat, 04 Mar 2023 17:38:02 -0800 (PST)
Received: from localhost ([2806:2f0:4060:3465:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id w9-20020a9d5a89000000b0068bc8968753sm2690819oth.17.2023.03.04.17.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 17:38:02 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] doc: rev-list: simplify literals
Date:   Sat,  4 Mar 2023 19:37:58 -0600
Message-Id: <20230305013758.344573-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305013758.344573-1-felipe.contreras@gmail.com>
References: <20230305013758.344573-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need to put special HTML escapes for ' and `.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 84c742aaac..df08a9e393 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -969,7 +969,7 @@ used to combined several filters, but this is harder than just repeating
 the '--filter' flag and is usually not necessary. Filters are joined by
 '{plus}' and individual filters are %-encoded (i.e. URL-encoded).
 Besides the '{plus}' and '%' characters, the following characters are
-reserved and also must be encoded: `~!@#$^&*()[]{}\;",<>?`+&#39;&#96;+
+reserved and also must be encoded: `~!@#$^&*()[]{}\;",<>?'``
 as well as all characters with ASCII code \<= `0x20`, which includes
 space and newline.
 +
-- 
2.39.2

