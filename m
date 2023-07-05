Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096E6EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 18:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjGESAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjGESAR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 14:00:17 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E2F7
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 11:00:17 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso7954606276.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688580016; x=1691172016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Qw3RFET07bsYvVXJlt8V8vZ7PCL1MrgEcmaW5uLmz0=;
        b=B9lxnE1lhY1wYiKFRp5pj/1C0eQew31S0W8c2MRxGy1miyZ8yC1frYaNbxeeIyiTiv
         VHB3jHlwfXx04vh1+syiiISZpg2P3SCP9lh3jRI78YajjO2jILssQZ+zW0hzK+o5EXXM
         CgTe1caXrRpKo6KdRQew/euYMfQaMeoXaqHoSc0cvekcM7mD54+e7bSME4Gp/3Iddw4e
         yXKQHNxt8A2gJNcpvFggvwTEtDVuSbB0LQ1RvOpRfe3Wy8qyjHk9AVMh1VPOHMNURp7Q
         z5Fq2cArDgIuRvcSgi2PabMyZ1FCi/CM7C6PUFDWVZNxTwvSq3ieJ8gEDS+weuutwADv
         ITWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688580016; x=1691172016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Qw3RFET07bsYvVXJlt8V8vZ7PCL1MrgEcmaW5uLmz0=;
        b=HXXyziCkDdd9GFe1dkFTQ3BaqaducL6QCfS6GhPCuS8Eiu3mmFXy4gBk4ALZi56h84
         6LfRWUR+swE9Y7Sps0pIA1Z6EtEO75wBb1g8I41inDGfeUSLxtdM7zCc1olD3EiQT9zV
         MLPqXJk13yexu2COSEBb9FtG5zq1zjtXBWiZIKT3V1FKa15rjCz2bbFKXr55O5EW1bci
         1E8sKf20Wlz1x7QEu9DDINJ1oGyagALx3U/Vys5/M4mb27x1Xp5vqm/LfjUoeXWNkzfz
         88/23BUYKznBOmzcjJ2vSFYVE0C5k1UQguRlogWaJV/KLH0JZu97uBwYcRqMMMXLzRFA
         08cA==
X-Gm-Message-State: ABy/qLZShRQU2HkwdD6pEdpq1Oqsv1PMT5PgNbaiwBt9PpbFzwcrrVmS
        0ne+mBbrGUFWj8oCDE4x6xCJ94PrfUE=
X-Google-Smtp-Source: APBJJlG+oti4HAEeEqWvfH8xTGJ5h0Ovw063SyR99jCCAVEY0HMfGSkYk/UAAw6wIwR6XhU4qPAelw==
X-Received: by 2002:a05:6902:24d:b0:c61:a1a8:d0b3 with SMTP id k13-20020a056902024d00b00c61a1a8d0b3mr2719554ybs.53.1688580015914;
        Wed, 05 Jul 2023 11:00:15 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.158.68])
        by smtp.gmail.com with ESMTPSA id 18-20020a631452000000b005539d676060sm18194010pgu.29.2023.07.05.11.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 11:00:15 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Rene Scharfe <l.s.r@web.de>,
        Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH 0/2] Add new "describe" atom 
Date:   Wed,  5 Jul 2023 23:27:10 +0530
Message-ID: <20230705175942.21090-1-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.29.g8148156d44.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
This patch series focuses on duplicating the implementation of
%(describe) and its friends from pretty to ref-filter, with the end goal
of making ref-filter do everything that pretty is doing.

PATCH 1/2 - This patch is the duplication of the placeholder from pretty
	    ref-filter.

PATCH 2/2 - This is an interesting case, where the tests written for the
	    above duplication are successful but another test below, in
	    t6300, "Verify sorts with raw:size" fails on linux-sha256 (CI).

Kousik Sanagavarapu (2):
  ref-filter: add new "describe" atom
  t6300: run describe atom tests on a different repo

 Documentation/git-for-each-ref.txt |  19 ++++
 ref-filter.c                       | 144 +++++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            |  98 ++++++++++++++++++++
 3 files changed, 261 insertions(+)

-- 
2.41.0.237.g2d10a112d6.dirty

