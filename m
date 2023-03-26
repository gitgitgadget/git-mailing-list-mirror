Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4C2C74A5B
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 17:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCZRcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 13:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCZRcB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 13:32:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5B849C8
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 10:32:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n19so3762767wms.0
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679851918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ai+St72kXz2f11Mk3Qs4dsZklacxa7e0DdmMD8Qsctk=;
        b=m/dCE1dr8Vf6hz52VXdUa7/+I4GxOnDLhRfon58rBdXfBeUzMDbMhgU4vWuedxLNtE
         5tzl/jPtwREmx/HTFJj20BgcvlL6rmOqVVfaPRwU0pNkgbYl5UAuom023FfwHME2J1Qx
         uKvTwt8InFzvsec5YY4MClFX3niFs3EwggNmh95TDdl8EAASAasn+Q9L8FGIB55cp0F7
         IlVRIRrdqx1FiXzyK55A9t84IMmYzot/1sDU/dEuy38eM/79DvsWA30WJy77eP0Tu2w8
         0SiFEmYfvrz2i23hxdi8FfTfs4oAkbXX3ePpeXd9SqD35xLmJt1WiGtZe1beraCmEymF
         3RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679851918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ai+St72kXz2f11Mk3Qs4dsZklacxa7e0DdmMD8Qsctk=;
        b=bgp2TjFALVOyNHncYDFMiFGyjgC+P7Lzh2v6BZgqp3xMnjx1aKLLqZSBT0kRLj9vWV
         kxVxv58BlSPItSrmWMcvqbmYcALiu9eVj1QW3d0w68lTgKRVN5FpKWQPRp9/28wTzo9d
         vN+933wOljQFyVISp0BrAKmIU1pdbbGiLyFnBUi4znP09aZZKi+UjCAtK6nh756Qg+PZ
         p9rMovn9uGnBxgawR2tkxGhrprcmvt2NmW1cFOVcdTVdtwCXYqLVPRYBihHTRWHkAlyu
         JPnrfrF1J64MVJXjay0NT7PySQ8Cz71/TFcgMRflLNwFnO7+CnAM97WGinm5+eAPBcrQ
         pR9A==
X-Gm-Message-State: AO0yUKUIYuJpqViBzQqAYl1y60oU7lCFLSmxQO7CBtujesNTWAwM+JHE
        Uxsjya035Ep7kpAKXun/uCINqCfQIZOGFBGc
X-Google-Smtp-Source: AK7set9e5I1b/kuHl2s5k6tO7IVXIKO7lRcM8yMGLEXAgjsA6uNNjoaHrvKAtK4mDEaf5xQYTxSbVw==
X-Received: by 2002:a1c:6a13:0:b0:3ed:aa63:43c7 with SMTP id f19-20020a1c6a13000000b003edaa6343c7mr7060983wmc.35.1679851918635;
        Sun, 26 Mar 2023 10:31:58 -0700 (PDT)
Received: from localhost.localdomain ([2a0c:5bc0:40:2e25:76c6:3bff:fe8a:46ba])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b003eb5ce1b734sm11103919wmk.7.2023.03.26.10.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 10:31:58 -0700 (PDT)
From:   Edwin Fernando <edwinfernando734@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.org, Edwin Fernando <edwinfernando734@gmail.com>
Subject: [GSOC][PATCH 0/1] Avoid suppression of git's exit code in tests
Date:   Sun, 26 Mar 2023 18:31:46 +0100
Message-Id: <20230326173147.39626-1-edwinfernando734@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a GSOC microproject. Address the problem of errors resulting
from calling git in the test scripts being suppressed. Suppressions
due to pipes and command substitution were encountered in this 
file (t/t3701). These regexs where used to search for such occurences
.*\<git\>.*|.* and .*$(.*git.*).* respectively (in vim).
Both types have been resolved and the tests pass as before commit.

Edwin Fernando (1):
  t3701: Avoid suppression of exit status of git

 t/t3701-add-interactive.sh | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)


base-commit: d15644fe0226af7ffc874572d968598564a230dd
-- 
2.40.0

