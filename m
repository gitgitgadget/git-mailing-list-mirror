Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C678C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 06:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiGTGfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 02:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGTGfG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 02:35:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4EF57259
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 23:35:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bu1so24672935wrb.9
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 23:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wdPAa1mglnbjf6qY22aqShXosfeLHQpm9jsjkurnmbE=;
        b=BhjZHHZb4ODoZCzIJc4F2NulxhxVkGQJG6trqn/UyVE+HrFzlFYZ8oeccrqDZxiAyD
         eAXGxm0FI//LOs7zo+N9rksqVidEQ5vWRYQHWNOYL7CT9VpXyfrQnXqrvjDoVDhXraUt
         Trm2OSb6SZgZ94uERkSOjrUjGICwTjGjM6geYuboua4YlzHlgps2qKacVoIaYgdwZeCV
         t/XDN3CTAINv5nOgKEVtKST0d2sHja50qTlLfpc7VREs1JIlkAhwtNz8hto4JUX6NC4M
         6hDJVESB7qYcsfWEPmgM9MCLoklLDp/R1HPuSqO2bgN8UkDPsJDZTYaQ6gVU1AqALN5C
         oyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wdPAa1mglnbjf6qY22aqShXosfeLHQpm9jsjkurnmbE=;
        b=FgGkJ7IQbzNuDOWJn4Tyy0XO3f6BmIT5x9emm3BWwh7bAHt86Br/sHR0kdgFgaCBPD
         tx4j/hwczo2SoDlJnVmwdkNlaf9stEcX3u+hvi2seIKrRB6wSAqrXvhQDnI0L+6E+MNm
         nJSJzpM5g85LELAt/Zb3jWrv9UBC6m5FB23+QpU3poMXChtIZQ/fwIQPsvK1UlHRIAx7
         otVAKL62JrlJ+4q3rIidTIjjhp8aQRD2/+WTAC/x+3hg2G5qGnLrvsNs9t6YvIqZwoSG
         DuYMoUo/EpL/7NiL+p9DUjNpdEZFL10yf1WIm1jH1FVlyNgt0j3g4hew7B8gLopSuA9Z
         BBtA==
X-Gm-Message-State: AJIora9+YuutTOAi7ZpM9FOIShfx/GhEq+Bsag6Xz3w3WfF8gf3Bv9qL
        mEKJOXM6npdPWAFIflPkpFIE/fHqCn4=
X-Google-Smtp-Source: AGRyM1u92zWm/97t1ScXFFe2ypefGIYcXbsdluJjFijn2qEzgIH3FK5M2SAX4T3IU4U1J9eB+EzvAw==
X-Received: by 2002:a05:6000:1446:b0:21d:cfe1:67a0 with SMTP id v6-20020a056000144600b0021dcfe167a0mr19584803wrx.91.1658298901114;
        Tue, 19 Jul 2022 23:35:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7-20020a1cf607000000b003a31f1edfa7sm1200622wmc.41.2022.07.19.23.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 23:35:00 -0700 (PDT)
Message-Id: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
From:   "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 06:34:57 +0000
Subject: [PATCH 0/2] git-p4: fix two undefined variables
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>,
        Moritz Baumann <moritz.baumann@sap.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Moritz Baumann (2):
  git-p4: fix typo in P4Submit.applyCommit()
  git-p4: fix error handling in P4Unshelve.renameBranch()

 git-p4.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)


base-commit: bbea4dcf42b28eb7ce64a6306cdde875ae5d09ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1297%2Fmbs-c%2Ffix-undefined-variables-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1297/mbs-c/fix-undefined-variables-v1
Pull-Request: https://github.com/git/git/pull/1297
-- 
gitgitgadget
