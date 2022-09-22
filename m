Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575AFC6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 13:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiIVNiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiIVNiC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 09:38:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CAFF1626
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 06:37:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso1362769wmq.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=+wfgInJm6w/BE/avCK/39XOq++2Nf2TlMT5gggZ1o1U=;
        b=AqTiDFA4mDZy6AWqoa9bOS//30lIE2QEfLgjs2pR/LHxT7gro6vGyJgRx36ECzZ71k
         eLyzjogJ6bUwdUmpZS1B983wJcQR36MVs5fJTXu0VSe33+oH3u62a6LhqxPzy/iGLFni
         IM9oVHDVGHL6kKgqR9e7qFzebKmcxWX9UScyNCv2gZHWM79KUj6WzLDUldm3xpebqAHs
         S+CYJtXS0U9QH87vvKcvkOZ+vbX51HV3oO+YIlX2WyuzaFa1HbvJzZlhfjrPsO01uFP3
         CyeWc3P0hSIdxFzIOeWoZ5ChgAzTGKPzD338E+OCEjvTqtc53xkbk/x8BAgB5hldcxCk
         O0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+wfgInJm6w/BE/avCK/39XOq++2Nf2TlMT5gggZ1o1U=;
        b=DVlRW4dGc2rHA5/Lx7a9tVNhO68faRQyOFwGZxaFpi6XxCda6Mg9si+Hje1YA1n3Iw
         1wZERKHjhUBZ9setHYKYNUZZX+2egghNCt/ReD5oNhSmQg+cd+dBOcYnG3a7LYqVpBAx
         AOcnO9bgYzTn0dCJ5Os+0YANI1hpWXuof/3PSqZTT6+uIBHVGBd5EeOQyzTaRoN0yPYp
         js/iudolzl8VZuBm9UjPfarOXrfX8YEIOfr6I73eNYNb9BTVM29LMnQGcGTXczz9Tw0e
         RLUEPeyQeOg/cBVuk+YqCd97ZB2ejiVfyKFWB7iDsngJVxVRKZLj+F1YFDxM3LBsW0Yk
         FFcA==
X-Gm-Message-State: ACrzQf11I6YbOFf0FaqftXSl9okei9UjS1BpMKtlTE/vFBrn4LajniNF
        0DT6P57xX/WyYb6Cob5icEjVBwWPjXY=
X-Google-Smtp-Source: AMsMyM4SyKA6qhKZ2ANqVCPbZZ7jfH+BrKqanoz4MaVGRXbFjQY1ZhB6ryCIzYhkdw9n2c6tIXPimA==
X-Received: by 2002:a05:600c:a4c:b0:3b4:fc1b:81 with SMTP id c12-20020a05600c0a4c00b003b4fc1b0081mr2410973wmq.125.1663853840931;
        Thu, 22 Sep 2022 06:37:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3-20020a5d63c3000000b0021e51c039c5sm5024166wrw.80.2022.09.22.06.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 06:37:20 -0700 (PDT)
Message-Id: <f5d8d6e490102202147c965a4d50c4f3b02d4a5d.1663853837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
References: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
        <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Sep 2022 13:37:17 +0000
Subject: [PATCH v2 2/2] scalar: make 'unregister' idempotent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'scalar unregister' command removes a repository from the list of
registered Scalar repositories and removes it from the list of
repositories registered for background maintenance. If the repository
was not already registered for background maintenance, then the command
fails, even if the repository was still registered as a Scalar
repository.

After using 'scalar clone' or 'scalar register', the repository would be
enrolled in background maintenance since those commands run 'git
maintenance start'. If the user runs 'git maintenance unregister' on
that repository, then it is still in the list of repositories which get
new config updates from 'scalar reconfigure'. The 'scalar unregister'
command would fail since 'git maintenance unregister' would fail.

Further, the add_or_remove_enlistment() method in scalar.c already has
this idempotent nature built in as an expectation since it returns zero
when the scalar.repo list already has the proper containment of the
repository.

The previous change added the 'git maintenance unregister --force'
option, so use it within 'scalar unregister' to make it idempotent.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 scalar.c          | 5 ++++-
 t/t9210-scalar.sh | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scalar.c b/scalar.c
index c5c1ce68919..6de9c0ee523 100644
--- a/scalar.c
+++ b/scalar.c
@@ -207,7 +207,10 @@ static int set_recommended_config(int reconfigure)
 
 static int toggle_maintenance(int enable)
 {
-	return run_git("maintenance", enable ? "start" : "unregister", NULL);
+	return run_git("maintenance",
+		       enable ? "start" : "unregister",
+		       enable ? NULL : "--force",
+		       NULL);
 }
 
 static int add_or_remove_enlistment(int add)
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 14ca575a214..be51a8bb7a4 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -116,7 +116,10 @@ test_expect_success 'scalar unregister' '
 	test_must_fail git config --get --global --fixed-value \
 		maintenance.repo "$(pwd)/vanish/src" &&
 	scalar list >scalar.repos &&
-	! grep -F "$(pwd)/vanish/src" scalar.repos
+	! grep -F "$(pwd)/vanish/src" scalar.repos &&
+
+	# scalar unregister should be idempotent
+	scalar unregister vanish
 '
 
 test_expect_success 'set up repository to clone' '
-- 
gitgitgadget
