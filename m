Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70865C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 14:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbiF3Of6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbiF3Ofn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 10:35:43 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078224D17D
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 07:24:56 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g4so11734058pgc.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFixnbNtSDyZVnQkArejGYyoVvy/v/rAqdLmvOS/dzc=;
        b=ot0yNRZP7R6ojT7YRJ3cG8tMJaHwkvWVXDljRl+rfZnaqlU1m0vC3koxO5Mb2dvITC
         p9AM9pLmRIwIEzkhW441xd3kXGdvj7WmEMbLmqdHAKX+MRyLVAHcXfDGmLm5Op5B+24o
         k+zqjII1gfApOHcSvgrjrR8ICvBPbk6zaXXGnP4rOmnnBpjg4YqablwDq76SwrIhWFo4
         OxbIXLWeTQDRLnpUtifsZ+jvuJIRniNk0oDMEUjp2ZvcDH0LEO9Wu/GhaLFoy1BFXN/u
         xN9k/xPCUD5EDNVNocfo2glqPaG/9ANOUtdCu2I7uTikOhduzGmFdtHPvtZe1FmsnSwq
         bHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFixnbNtSDyZVnQkArejGYyoVvy/v/rAqdLmvOS/dzc=;
        b=P8iIFBZDD54OBCzCoL46tl9CqBTpChp69Z3z33itcXgNFVu3AQHgkXxPRCUXz2Unct
         AWtt3YCTYhMOlJMu1WV8DTUmNsUKy5U/41W3CKQt4+o5O9kxtPFYycb24L+q6ZQmF5Sw
         fMHv/KwxBPBohQseLuHylmxLIV+XmeIeEzZ6bxH5Rr5SZy+tQNNOLLbQw3jqbh/HtB25
         uQe89jojTA4hFkj7r+pJkqD5LQeG5uRdTudk1JFzTlJTlPYY0REGuiD0t5pNzq6Ly9Sw
         bFzNxVzcLshX0xC9sIasc5w1bMB/j2y2+zI33S+XSZ1XAdi0XOGoGmMLo9DKZGzlbBMD
         u3Ew==
X-Gm-Message-State: AJIora+sHqClwTsc843n2h3Gn7PeKlPhu20lInLbyGLu5e8aCO1FCr+i
        W8FNitjs/C3KR1D6tDYNk1lQRjx1wllIYw==
X-Google-Smtp-Source: AGRyM1tFO+BBVmU1syxSwOh1yAO3mL9HKcV3kC2AlbiI0s+QvSftKLpbtwizsLA7Vh9dp5IVEaaMMg==
X-Received: by 2002:a05:6a00:1394:b0:525:2dc4:cff2 with SMTP id t20-20020a056a00139400b005252dc4cff2mr16321130pfg.5.1656599094933;
        Thu, 30 Jun 2022 07:24:54 -0700 (PDT)
Received: from HB2.. ([106.212.243.72])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b0016909678e2csm13647377ple.292.2022.06.30.07.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 07:24:54 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 0/3] Add support for mailmap in cat-file
Date:   Thu, 30 Jun 2022 19:54:41 +0530
Message-Id: <20220630142444.651948-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.3.gdab82d6f0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone!

I am working as a GSoC mentee with GitLab organization. My project is
to add mailmap support in GitLab. GitLab uses git cat-file to get
commit and tag contents that are then displayed to the users. This
content which has author, committer or tagger information, could benefit
from passing through the mailmap mechanism, before being sent or
displayed.

So, this patch series adds mailmap support to the git cat-file command.
It does that by adding --[no-]use-mailmap command line option to the
git cat-file command. It also adds --[no-]mailmap option as an alias to
--[no-]use-mailmap.

I would like to thank my mentors, Christian Couder and John Cai, for all
of their help!
Looking forward to the reviews!

Siddharth Asthana (3):
  ident: move commit_rewrite_person() to ident.c
  ident: rename commit_rewrite_person() to rewrite_ident_line()
  cat-file: add mailmap support

 Documentation/git-cat-file.txt |  6 +++++
 builtin/cat-file.c             | 32 +++++++++++++++++++++-
 cache.h                        |  8 ++++++
 ident.c                        | 45 +++++++++++++++++++++++++++++++
 revision.c                     | 49 ++--------------------------------
 t/t4203-mailmap.sh             | 30 +++++++++++++++++++++
 6 files changed, 122 insertions(+), 48 deletions(-)


base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
-- 
2.37.0.3.g2093cce7fe.dirty

