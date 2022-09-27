Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66BCC6FA83
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 14:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiI0OIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiI0OIh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 10:08:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9521B349E
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:08:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z6so15229279wrq.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=2LnkrF7wZvAUjHOAV4MDlUElfsPcr97qDn/gglcyRks=;
        b=TgmNeLSvVpicxoyxVd2wq+o8hX3b0VyTG+qtpzxHifALw9hvTJA26+6bW5HQBl6wf/
         bBI6o1+2OiaCYhuiUpMVOwk7OzwVaGXHzm0XSbmBA7X+umePZ4RC9P+Z9k+S7+cQ31QJ
         KST32uYPus/2lbjob0bI+qlOxsvhh/zRotUu4BQrhs9SyGcwmnWW/J6vz1OZ2aO8eAsk
         GsNSlZcYVRzHwWS4Ds+ikjV1GzceHnvPTqhao/VK09CwI4fhqTFiyZSbllzGREMZRtmX
         MEcr6W/o//CFnBgBWDxhLRif+hJ7QAVNdydMqnlYT2w+NVsiiLAMxi0f+DLAJgm7ng4H
         pghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=2LnkrF7wZvAUjHOAV4MDlUElfsPcr97qDn/gglcyRks=;
        b=2oF0CoMoBdEgOK05/EimytJRXTR0Fydk5F4kGbBYWn73cD0sAGlcaEPrDdRXHp8eyk
         KGx1DD8wUswD1CezkynqwFloHdlml6lJqWgT+ZpnAAp4hlph5kRTtM0lZyxttC28sLDU
         /CEZNzEmXB+PBjrYWqs5tfHwSMWaTOi6kHr91oKp5BbfDhJDu/SWl2bl5nxIByIuttsc
         WFnmtz29HVFVKctkXozJgB2yVboCxagn8QGMaJbbnJxmGvmK3q9R9wJb6rRunCOUkxoW
         seRsHnb3eM6v7ftY6ovVQTYx16FkI8ek9gExPbASo1GVYHJFT5Ylju1dJN+4aTocx3oI
         sphA==
X-Gm-Message-State: ACrzQf30R0z2USdXKNHnCokWAsJGH0nAOvryU3MhdNX7QbMkuMko9S7r
        8fBJWApcS/RAJhR77gXzFjo8Hzi3iS4=
X-Google-Smtp-Source: AMsMyM5HBzymalNVWkhddDydUnsQidGtcEKqvHzEk047JjtDNkKl8V+6Cy3GhIQUVSOZx/e8/hCtSA==
X-Received: by 2002:adf:e78b:0:b0:228:614c:33a6 with SMTP id n11-20020adfe78b000000b00228614c33a6mr16056757wrm.504.1664287713021;
        Tue, 27 Sep 2022 07:08:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15-20020adff14f000000b00224f7c1328dsm1871159wro.67.2022.09.27.07.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:08:32 -0700 (PDT)
Message-Id: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 14:08:26 +0000
Subject: [PATCH 0/5] [RFC] config API: return empty list, not NULL
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This work changes the behavior of asking for a multi-valued config key to
return an empty list instead of a NULL value. This simplifies the handling
of the result and is safer for development in the future.

This is based on v4 of my unregister series [1]

[1]
https://lore.kernel.org/git/pull.1358.v4.git.1664287021.gitgitgadget@gmail.com/

This idea came about due to a bug in the git maintenance unregister work
where the result from git_config_get_value_multi() was sent directly to
for_each_string_list_item() without checking for a NULL value first.

I'm sending this as an RFC mostly because I'm not 100% sure this shift is
worth the refactoring pain and effort. I personally think getting an empty
list is a safer choice, but I can also understand if someone has a different
opinion.

Thanks, -Stolee

Derrick Stolee (5):
  config: relax requirements on multi-value return
  *: relax git_configset_get_value_multi result
  config: add BUG() statement instead of possible segfault
  config: return an empty list, not NULL
  *: expect a non-NULL list of config values

 builtin/for-each-repo.c     |  8 --------
 builtin/gc.c                | 20 ++++++++------------
 builtin/log.c               | 10 ++++------
 builtin/pack-objects.c      |  3 ---
 builtin/repack.c            | 13 +++++--------
 builtin/submodule--helper.c |  4 ++--
 config.c                    | 15 ++++++++++-----
 config.h                    |  6 +++---
 pack-bitmap.c               |  3 ---
 submodule.c                 |  2 +-
 t/helper/test-config.c      |  4 ++--
 versioncmp.c                |  8 ++++----
 12 files changed, 39 insertions(+), 57 deletions(-)


base-commit: 73a262cdca46a45aeeda6f47ea3357aaeb937e7b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1369%2Fderrickstolee%2Fconfig-empty-list-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1369/derrickstolee/config-empty-list-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1369
-- 
gitgitgadget
