Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EFBC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjC1UJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjC1UJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:09:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88AA1FE6
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:09:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so4854497wmq.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680034163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=53Td0ywuPXLNOZJZ6rlx5Uie/Q7eVxLiPd+drJocGKM=;
        b=Bgkpluvzp3P+kzgYnvTkqT0Tn5doR66ZfVaGg0jnP0mRpKEiVAWH7qQpieFFbN1b7H
         Y4aQCmP9qWPFME2KYtTd/3qkx/W4nXyMVmPA9f2oQUXxR2iiGJo1EXU3EEoLdm8wAqTJ
         e7jWxYFqSKFcgvGBFebPkKHME9+WBYUe9Y3ETLkOvrGxTFrs2NfZQhVXi/qlvKftvZVG
         TmHF4s4GbYlDE573sKmAVgi6LEbZpGlZR1yP+G98+00CwlHXjW7qkmG4rjoyQzAquj0h
         vdyo3/BPGoCs12wlPcEuApVDqaZZhNifIZ9F2ZwL848Ci1gR6KdpUDnWl6+YLiIZrG2B
         iluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680034163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53Td0ywuPXLNOZJZ6rlx5Uie/Q7eVxLiPd+drJocGKM=;
        b=O5dMzQBzOM1sIHFIQmcv/zXqID1XvkGkNH/8ZF/bYAeWsq5nmMsa/pJjs7zCe00P48
         suto6rCaoVURo4FYYg9IqakHX/51IL6awnSMhk9jK7YSt7uMIiMV3pkatpOSeEP+cGTy
         rnQWMxiKccuvSYrZ089xUDq6xPce/4ferJsfrhHsqOK7Ze16uFVI5Mw5dGByrBs+xI4i
         +1OgGFF6Vs0QyIruV4uwsOCwyzokV6ncr7yn+nKmz5cQ/9ApBBna1hTIIr+z+elCuC5Q
         Ib9rfyhxwZ3ZVBu5TQOP18CdJ86vVHHTkroB4Vt/P6Wqp0XqVSjM6Lb/m780Dzr19ZEZ
         VQ8g==
X-Gm-Message-State: AO0yUKU6uhZjtG/VxdN+6rkPKc4Cp9iVAV9LQxsG3UVSmd9P6eHp/n6W
        rqmSRe4XNAdM6AaXh339M6om8S9wewc=
X-Google-Smtp-Source: AK7set/IlK70WvhmWX4gM+4RxHEehGwYSQ33R/dVrIIq+zYojAVfRc7d/QNb53/CGkJj/fL+hYUE2w==
X-Received: by 2002:a05:600c:204:b0:3ea:d620:57a7 with SMTP id 4-20020a05600c020400b003ead62057a7mr13582280wmi.8.1680034163143;
        Tue, 28 Mar 2023 13:09:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003ef71d541cbsm6286587wmq.1.2023.03.28.13.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 13:09:22 -0700 (PDT)
Message-Id: <pull.1505.git.1680034162144.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Mar 2023 20:09:22 +0000
Subject: [PATCH] p2000: remove stray '--sparse' flag from test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, nanth.raghul@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This argument was added in 7cae7627c45 (builtin/grep.c: integrate with
sparse index, 2022-09-22), but it was a carry-over from an earlier
version where the --sparse flag was added to the 'git grep' builtin.
This argument does not exist, so currently the
p2000-sparse-operations.sh performance test script fails when reaching
this step.

With this fix, the script works with these numbers for my copy of the
Git source code repository:

Test                                         HEAD
------------------------------------------------------------
2000.30: git grep --cached ... (full-v3)     0.34(1.20+0.14)
2000.31: git grep --cached ... (full-v4)     0.31(1.15+0.13)
2000.32: git grep --cached ... (sparse-v3)   0.26(1.13+0.12)
2000.33: git grep --cached ... (sparse-v4)   0.27(1.13+0.12)

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    p2000: remove stray '--sparse' flag from test
    
    I noticed this while testing Raghul's patch [1].
    
    [1]
    https://lore.kernel.org/git/pull.1480.git.git.1679926829475.gitgitgadget@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1505%2Fderrickstolee%2Fp2000-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1505/derrickstolee/p2000-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1505

 t/perf/p2000-sparse-operations.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a0..e4a132f5934 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -124,6 +124,6 @@ test_perf_on_all git read-tree -mu HEAD
 test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
-test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all git grep --cached bogus -- "f2/f1/f1/*"
 
 test_done

base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e
-- 
gitgitgadget
