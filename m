Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF93ECAAD3
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 19:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiINTbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 15:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiINTbP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 15:31:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5386DAD8
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 12:31:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q21so26879900lfo.0
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 12:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=HSx5mTYPh4yVsws4WDsBLGUDrWLI5clhBVM+aT+gchI=;
        b=PZ6dW9maQAfTGclLp+ZkCslBhUxBafLlTzT2fqrY8isLeo/dn/7WJZAE0aOczDoZtl
         mbIyD7ZNvKVRf8VxgCTpavxzhPj5knkl0vEqkwbUltmev/9gEeQqgiv+17SQu337e5T/
         q9Y5oT2CLzLop++b1HUnqHIoSE2/AlLTJlwrz5XNmgy5vdhhMQ0QR8fhXF23irdjJ4Qt
         0t6DEi9xpRnULu/kP3fzx3YF15LnNVbeP3BHL8xjREk8sg6s4kewZcp+ZUsF2wF4rAih
         U3INYtaDMAw18hRyJYRQy0VZGNZFI/4ZqU/OQWGqZUln9XjBiDfN2o3IweP5vkdH/RYY
         Gbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HSx5mTYPh4yVsws4WDsBLGUDrWLI5clhBVM+aT+gchI=;
        b=QN7CyY/2ZnMKwrCiG8k0W4TX3ZLok26DWYii++LQ42Sq5IMvQqFQOekSxiUNZ1GZZd
         cj0RIdGPRkJD7Zo19tCFdjw2X9KyGhUpK6/FAzkZ8Emf/HKXOIGyQpkQEGOE6Tu/EHrs
         B3yuEavltmaj4RaV9gBa/IQPCqRpt7bSNlkcODnq6zQfKdRpdu93Jc8qZXII430xiIWm
         sCj+rvPcqwNcg0BsnrPl8iHQT2I5DUaj189v/BCVMPalcVu0cffQzP9Hnr48JTayQa4I
         PhLOwGUQ+hwqAA7MwcMPHcIvx/jzzoKYHvIaNQZBK6arSDVkJ9yPclWXsRo+aruUWJg0
         9ctw==
X-Gm-Message-State: ACgBeo1YXW+IT2jCtjRBj7w+0oEckc5GsIrr2+cG4FmwsR/aKPsSrch5
        4JL/mvl9jFgcoAU8z0EAXSqQYqHHZVs=
X-Google-Smtp-Source: AMsMyM53S2PBHKu9tBP+eypAAJR7bROCd8Kb80MHkmUTrTqrroA/3IgFAN2+ORrHxXtctm7Jl4RULw==
X-Received: by 2002:a05:6512:2205:b0:49d:a7e9:455c with SMTP id h5-20020a056512220500b0049da7e9455cmr1424204lfu.296.1663183873402;
        Wed, 14 Sep 2022 12:31:13 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u3-20020a05651220c300b0048ad4c718f3sm2522305lfr.30.2022.09.14.12.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 12:31:12 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 0/3] diff-merges: minor cleanups
Date:   Wed, 14 Sep 2022 22:30:59 +0300
Message-Id: <20220914193102.5275-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are pure cleanups. Expect no changes of behavior.

Signed-off-by: Sergey Organov <sorganov@gmail.com>

Sergey Organov (3):
  diff-merges: cleanup func_by_opt()
  diff-merges: cleanup set_diff_merges()
  diff-merges: clarify log.diffMerges documentation

 Documentation/config/log.txt |  6 +++---
 diff-merges.c                | 40 +++++++++++++++++++++---------------
 2 files changed, 27 insertions(+), 19 deletions(-)

-- 
2.25.1

