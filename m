Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2E7C433FE
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 06:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbiCSGUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Mar 2022 02:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiCSGUq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Mar 2022 02:20:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA6297290
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 23:19:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d18so8717144plr.6
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 23:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erwUNhpeQul5HChGhDh7zhg2SeViV3UsSWauYr1O3l0=;
        b=ZDQxMuqcXTWwu0W8586Bz+LWI6/jDZAd6+Kgr1zaSDOxlXhXN1HWskXvJ6k+FmSnd5
         o2Gso5QUpWIFwGbH36Y06+S+rB61U1z3wjFx1wd07dOY+151enqCPcIN3sLLRvy0y/og
         oLzh+Q+YybWdLDavBdA4yY5lAuPP3QbYahJvMWrJnv5H5CWIlsWO9wpLaOj68hQPAPy1
         ubK1FFvOveDdAs1+/01hR91V/m0LdPgKFTwd4rORaH8fZzTNyCBp3P7cdd9RdQNw7B79
         DPmK5+/6i/ogZqjF3wB7zK7jfENugkwV44RiMbj/W9P4AXlcEAh49jkeemxY7Zmpgciy
         A7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erwUNhpeQul5HChGhDh7zhg2SeViV3UsSWauYr1O3l0=;
        b=z52xG/cEHdUISy3D7NkC47Jf/mV/SLgFMdoNrIVB5EunZBUMcfdqYLtEO24SLQY4JL
         zuK63bDsnARj0T5JTYJPGvhnER7sNTUaXnBSX5PMzwfkDxQCDtl3jOAyiJs4OrLFZ2hw
         Wt7ayFGxl+LffYdEHmQrFeognxCIqlHPp3PiM3kFI2n/eH4FKMan9mur3pT9yoyNPEXh
         6HK2jONXR3ahdSg7exk4EjXLjhVtl+iFz4vYujAFVlFCSKGYXceEAs5J5I+6UF0iLA2/
         GKiZAhkYq4UxL8jZg38ERdLxCmPgR1EPuHhQImamYtV4Fu2W7dASL6Nr/T4KY9Bh7L6F
         BRsg==
X-Gm-Message-State: AOAM532Eh6XEFkChT5ZZ44FdzPafKG9CRfX8sRsEiQ59wmk0nwHXvc7e
        vWgwj9Nsl7bzeeoiOnoB/c0=
X-Google-Smtp-Source: ABdhPJwSqfpfVOm1NIRMluGJo2RiNJJLWOwrTSS5/U0rKmqrkjBzsHIx5SECF536DO7o2HyvDz+npA==
X-Received: by 2002:a17:90b:250f:b0:1bc:e520:91e6 with SMTP id ns15-20020a17090b250f00b001bce52091e6mr25706750pjb.43.1647670765661;
        Fri, 18 Mar 2022 23:19:25 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.152.89])
        by smtp.gmail.com with ESMTPSA id b2-20020a639302000000b003808dc4e133sm9235950pge.81.2022.03.18.23.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 23:19:25 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     gitster@pobox.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 0/4] Documentation/git-sparse-checkout.txt: add an OPTIONS section
Date:   Sat, 19 Mar 2022 14:19:06 +0800
Message-Id: <20220319061910.786850-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Updates Log ==

Changes since v4

 * ship a multi-patch series to reflect the history
 * base on Elijah's series [1]
 * changes according to Junio [2]

[1] https://lore.kernel.org/git/pull.1148.v2.git.1647054681.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/xmqqfsnfb42c.fsf@gitster.g/

== Overview ==

Add an OPTIONS section to the manual. Also provide corresponding text changes
for better understanding the topic.

Shaoxuan Yuan (4):
  Documentation/git-sparse-checkout.txt: add an OPTIONS section
  Documentation/git-sparse-checkout.txt: move OPTIONS after COMMANDS
  Documentation/git-sparse-checkout.txt: some reword and modifications
  Documentation/git-sparse-checkout.txt: some reword and modifications

 Documentation/git-sparse-checkout.txt | 88 +++++++++++++--------------
 1 file changed, 44 insertions(+), 44 deletions(-)


base-commit: 4b89a3392b04acccf28f09f90e26715140461373
-- 
2.35.1

