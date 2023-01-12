Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B544C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 09:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbjALJUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbjALJT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 04:19:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1A45130B
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:46 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so20136533pjj.4
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=crDlLo4A12xfg9Ugzv5xX3pBU7c6tv//rcLyu3Ubb4o=;
        b=AiQyPniaP07QrBblXV+aBTkBMFgisiRdmklUES7B8XA5lYHG6ZH2Fr/GAWloioWzcR
         6eiSCiRUTKjz8A591gFrsBffs4CGKQme+3HJ+R+lJGbztLOTqu7gWN0Ke1kgdfSTpTfH
         zh3zTdZfPAzYdOk3HMwX0yPET6YPGDK+dmOfLKCrMii84j/i7XAaJGL2T5A+okDoNknO
         +OzltnCJh53Z0WoeHPyodNBiXe7bAQdpr/hmuk2CdY4Tg07zkv7vR78glGnoSSSq8Zad
         oHKmXdgazHlnwy09NQVk8ApNVexMKcnUfZjaVwLjX27PyA/p+G4Fd085VG8LvINCe2wp
         Zpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crDlLo4A12xfg9Ugzv5xX3pBU7c6tv//rcLyu3Ubb4o=;
        b=Y1X4sG+d7UXkKI9ise+2buvLk0nsQJH/PM39+38LZk2YmVg178BP41tQHSRcyaD1H6
         mTzYLQ5vu+EZezfNy6SuF45elODbwUx1Q89sNDJmdS7le6FnNjrinxEAQaHU0sk/Pna3
         OpzUHMzNG81zM9jr/fD1sotdh/PyjxT5WDV9RUZl6Fbkim7gdhhl2609v6Min5CwnTJj
         oio79Kx2qsSONifk47R06McMkdS6bpQRhkWBesjGBopdfLNIir6VodGs7ZXtl3XC6oXa
         U+/WqkOpZ5ZpfkHoe48v1sen1uJJA66JxMe2aXfZ03FLFFR9n5jeAYv0F59NnJ1gsx5L
         QRWw==
X-Gm-Message-State: AFqh2kqkuW6EAmQoutiWb3BNNzVTH22fvUTsLdmCS/ZMsZcG1BhFJyAg
        +I8YRQA7rcwwLl2jhg59M9L1oMxcCG4yPeYa
X-Google-Smtp-Source: AMrXdXu9P5ywV6qUS1zy8fdtMEYrbml54XUkaOpOYgR84CiXiHbKp2r7GsCGklUNz1Jv6gqZMvFW0Q==
X-Received: by 2002:a05:6a20:8346:b0:a7:8ce5:6fc6 with SMTP id z6-20020a056a20834600b000a78ce56fc6mr71482570pzc.13.1673514705674;
        Thu, 12 Jan 2023 01:11:45 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id d126-20020a623684000000b0058426d9db66sm11257069pfa.218.2023.01.12.01.11.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2023 01:11:45 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dyroneteng@gmail.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH 0/6] ls-tree.c: clean-up works
Date:   Thu, 12 Jan 2023 17:11:29 +0800
Message-Id: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.98.g174eaa53973.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

This patchset aims to do works on refactoring and cleanup
of ls-tree.c.

The patches can be viewed as two parts:

      * Part 1: from Ævar Arnfjörð Bjarmason which mentioned in
      his RFC patchset[1] and Ævar suggests to submit a separate clean-up
      series. After I read them, I accept them all.

      * Part 2: fÆvarrom me which introduced in my RFC patchset[2] and after
      I accepted Ævar's patches, I keep two patches from [2], the left
      patches in [2] may no longer be needed.

[1] https://public-inbox.org/git/RFC-cover-0.4-00000000000-20221117T134528Z-avarab@gmail.com/
[2] https://public-inbox.org/git/20221117113023.65865-1-tenglong.tl@alibaba-inc.com/

Thanks.

Teng Long (2):
  ls-tree: cleanup the redundant SPACE
  t3104: remove shift code in 'test_ls_tree_format'

Ævar Arnfjörð Bjarmason (4):
  ls-tree: don't use "show_tree_data" for "fast" callbacks
  ls-tree: use a "struct options"
  ls-tree: fold "show_tree_data" into "cb" struct
  ls-tree: make "line_termination" less generic

 builtin/ls-tree.c         | 257 ++++++++++++++++++++++----------------
 t/t3104-ls-tree-format.sh |   1 -
 2 files changed, 150 insertions(+), 108 deletions(-)

-- 
2.39.0.98.g174eaa53973.dirty

