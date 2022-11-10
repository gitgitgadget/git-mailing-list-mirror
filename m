Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965E5C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 07:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiKJH2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 02:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiKJH2w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 02:28:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F253C32066
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 23:28:49 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso3752297wmb.0
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 23:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iLl6/uSKX3R85XKZMNwxqiR2gzhUOi7T+1VTHRBXIAU=;
        b=Ay9qrq5ZnfxgJzv2T0y4bKqiyXXbPTes5urFF0IFc9hmNR1cnG8U7P7lFrnqjtZHSM
         iMo0yQwJCaviD6VXdKOT4ZY887uwe01KCc7Uq89g86mlcQsmcuSHRqLOoGrVjij9sth1
         YuujQdjl1c537bpJH0vH5dz7hthMs1eDxJB9U+p/55S1RPaYKn23cA9U7GErT3pB21X5
         y7CxtTUzJcl/Iavu5puKXRF7xNxjDJZ+eFKMUrChzXT00JAZlXKx4T7LmdXjhFy8s0cj
         VKlbc9t3ecHluok8a1qRmXhGBMsRGNOyplHfTXzyGqDFEbv4FvgdwH6fYaF0fJSdNBxX
         ZdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLl6/uSKX3R85XKZMNwxqiR2gzhUOi7T+1VTHRBXIAU=;
        b=AcWx9BWVyl+cDhpzSD9XF8hCIm2aC4mhfol8lOcdmz80gjj59li5/5j1e/tVE5VdY0
         v5Wmi0gpYB++J+VdOD33YYiuzCMLkv/cy8b3TFVlfE0o7LhApiNJxMAZDzMhYMrh5sX6
         GJ4DxGxBLIFmHKntPm0wPGjIJQlQNatK79ICDshmyuUcMGY1z1V8H+qGVGa380coap90
         XXJvncjZPG2VXMGbtz/2tpvxRDSJNM5OIO1XnuXD+Mw8MW65dThMAswyf5cvzjuD1jEF
         fL9vPQ/50y3l/mzZWVVN4BR3jgK4wFUaCS2CVthfPaFLxzl2DTQz9I9mty3dxe4qyGte
         jC4Q==
X-Gm-Message-State: ANoB5plTXdkVUXg6eZOf9W9BSrvEmB82cXanQp+I++f8n7uJIpnYNiXq
        2csxutF0L+0S+vgJeZR7KvC4BCLIIlQ=
X-Google-Smtp-Source: AA0mqf4RbPCHaZE/D0FHXDa4SdhY1W25J0KNil1/ljsm10OKye77PaTcs5FWnHV8eTRPtUubTvI0rA==
X-Received: by 2002:a05:600c:12ca:b0:3cf:a55a:20ea with SMTP id v10-20020a05600c12ca00b003cfa55a20eamr14832614wmd.77.1668065328277;
        Wed, 09 Nov 2022 23:28:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bo17-20020a056000069100b002366eb01e07sm15260398wrb.114.2022.11.09.23.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 23:28:47 -0800 (PST)
Message-Id: <pull.1415.git.1668065327120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 07:28:47 +0000
Subject: [PATCH] tests(scalar): tighten the stale `scalar.repo` test some
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As pointed out by Stolee, the previous incarnation of this test case was
not stringent enough: we want to verify that _only_ the stale entries
are removed (previously, the test case would have succeeded even if all
entries had been removed).

Let's rectify this and verify that the other entries are left intact.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    tests(scalar): tighten the stale scalar.repo test some
    
    A follow-up for a topic already in next.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1415%2Fdscho%2Ftighten-stale-scalar.repos-test-case-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1415/dscho/tighten-stale-scalar.repos-test-case-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1415

 t/t9210-scalar.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index c7f8a379108..25f500cf682 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -171,10 +171,13 @@ test_expect_success '`reconfigure -a` removes stale config entries' '
 	scalar register stale &&
 	scalar list >scalar.repos &&
 	grep stale scalar.repos &&
+
+	grep -v stale scalar.repos >expect &&
+
 	rm -rf stale &&
 	scalar reconfigure -a &&
 	scalar list >scalar.repos &&
-	! grep stale scalar.repos
+	test_cmp expect scalar.repos
 '
 
 test_expect_success 'scalar delete without enlistment shows a usage' '

base-commit: c90db53d203d7ade1dc7abe63857cfb5616fe34f
-- 
gitgitgadget
