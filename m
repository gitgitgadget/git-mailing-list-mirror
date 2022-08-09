Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282A7C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 12:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbiHIMJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241483AbiHIMJu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 08:09:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5B24BE3
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 05:09:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f30so10221311pfq.4
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 05:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3DdkBLkm5Ldmt/BWfrdxFk0g0Ma19fIrmqwg6thbro=;
        b=IbNempg97z0BKaRGqTpRKttaKKXaIUfmlrViAo83q+sQiHt1ZVqVKkpp6M3N1MjZzS
         OhfzR+eW6v8JmZB53qn3m2bGNs/e8/p1jH8WNFYdSr47Mcsfhm0X4XODWZ2M/Y1qXHXl
         2+wifjF+a4YFvBSkiUGIg4hwDN+AJOSdEyHmLsaO96GH9qqu/Mz+W4BILob0wU+JzXO7
         RAh050xzAwEKuCQ3pzYmQx8t3AB0r2XUTRpBeFxYATWnffPojiMJK88TcKpGjF+RtFtB
         U+TBPRJemFGGe6ve1uD8xS73WYj8x7I2A10HB1K4rMbvymSgIqKa78EDZZpKlZFWHhKb
         47+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3DdkBLkm5Ldmt/BWfrdxFk0g0Ma19fIrmqwg6thbro=;
        b=Y30DsQJuYlPxLp/moXk2J0DQxVKa9FL212TMKUuKbEofeBM0j84/LMOZoQi2DIaeKK
         mwryLBOuTWKEcE9Zt8BC4sXFE0vXt3N6pfy6nS/qtr6Ak3Y5ZTiXzrkanl12EEARf9Hp
         +7JELK3tS/Y5vC7rKJxWx7U3DScV+0Qn0ewbWUZObC9yzO0I2fNEcSavF4A5uRCVx0Ut
         JeKRlwJwCPH6bRTPa1Vlzdv+gKnSd5vmbr7NWEvZ48B2qK+vZZVNReLHZQqSnMRaR0DI
         sCnF+iVoLwTtyUIwVqOKS9VyuQkB/URzJ8xUOU7eSBobWzJhQ2OVxxSJzPFEti/CAdF4
         b4vg==
X-Gm-Message-State: ACgBeo1iscFVmMDu86tyLKm2fPebBFQ34EiR10X7UZfz/64b77cQSW31
        ANJUcW7f5Nd/YQZrEDuYAN5ufOyJLt1teA==
X-Google-Smtp-Source: AA6agR4CKZOnb3r3aKdJXj2lR4iM8jOX26zt5k7ENoHs/E77FEUgiRmMjuR6AGURRwy37DrXW8I7Ng==
X-Received: by 2002:a63:82c2:0:b0:41b:c0f0:9cee with SMTP id w185-20020a6382c2000000b0041bc0f09ceemr19407581pgd.412.1660046981330;
        Tue, 09 Aug 2022 05:09:41 -0700 (PDT)
Received: from ffyuanda.localdomain ([120.239.67.140])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b0016d10267927sm10511485pll.203.2022.08.09.05.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 05:09:41 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v3 5/9] mv: remove BOTH from enum update_mode
Date:   Tue,  9 Aug 2022 20:09:06 +0800
Message-Id: <20220809120910.2021413-6-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since BOTH is not used anywhere in the code and its meaning is unclear,
remove it.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index f213a92bf6..1dc55153ed 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -21,7 +21,6 @@ static const char * const builtin_mv_usage[] = {
 };
 
 enum update_mode {
-	BOTH = 0,
 	WORKING_DIRECTORY = (1 << 1),
 	INDEX = (1 << 2),
 	SPARSE = (1 << 3),
-- 
2.37.0

