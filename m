Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00EFC201A4
	for <e@80x24.org>; Tue, 16 May 2017 07:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdEPHgL (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 03:36:11 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36102 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdEPHgK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 03:36:10 -0400
Received: by mail-qk0-f196.google.com with SMTP id y128so21244352qka.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PyVzxIPbNktEYUiN5d7cQtg3HomaBdnsbNa0CmKwJco=;
        b=KWu6zoSRWeTKVqdYQMH7BFe+gIVwUYtMzA0Hqu5aV55c/4kwhINmEGL3QeeWRBQOpf
         AXooHxspG39ts4Z3dxNm8ivsWI4SLyyAk8wcXgp99q+dQMfVVVoIcBssCw3F4ErfZSKa
         gc1N9iNmiiJwTjpqwzO30re6J7qnJvIVAnnLBIdGEQ+C0tVLdjYzVI3TO0QV9EbxebdY
         kMWwetnz0/csqFjLFZf8CnQs+YPUCQi7WEr5qGL1ckW7jV88b91ctEB+Iv6dhqR6B9Bw
         7guqqcyLtB3qLSUmJLqL4VSjjAPvCLkbz40nxRnRShFkEDrlnPEgfecnG4XjkcoRc2sc
         v6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PyVzxIPbNktEYUiN5d7cQtg3HomaBdnsbNa0CmKwJco=;
        b=iLKPOTyMpkIh3BOM3IvIVOqO3b2OWSlantRao6i3tU2ChnLTBdd0Or+Cc83d+fDWtA
         0NDpTRyUE+aAQ7EfZgoZ4S4UEtwVUYB1uWvCF+ludsFy1JEMW9n/azCNwbTX57Z22kjx
         FDcALAHR3BO3KHtcuTcfAADd52Oydn/VjtNcJDVjeLk/T0PQp+KwSy8mCBqcRkQIAXHo
         IfiyboPIMnBTQGVBiaakUmSyDeb6YpBSVnQJWdMRj2eNArZ4RvtirroykAyKIvM+DUCe
         VeZZYCMY4zhmbHySPQwZWxmL0DQEouStWQvZk8z+FATBWK2idA4LKlS/VskQ1iq3/EQr
         a0Ww==
X-Gm-Message-State: AODbwcDBKy3BCu3wSUb+hEI3oVHJYLSriyGs/FqxqQ4sxTNGy3sjOE0k
        PaHnIEf3o4VhWA==
X-Received: by 10.55.25.80 with SMTP id k77mr8536510qkh.294.1494920169817;
        Tue, 16 May 2017 00:36:09 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id i51sm10374103qte.28.2017.05.16.00.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 00:36:08 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v3 0/8] Fix clean -d and status --ignored
Date:   Tue, 16 May 2017 03:34:15 -0400
Message-Id: <20170516073423.25762-1-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Restructures the patch series so that everything works properly.

I also noticed while redoing it that I didn't properly fix the clean -d bug
before; while it wouldn't remove a directory with only untracked and ignored
files, it would miss the untracked contents of such a directory. That's now been
fixed.

Samuel Lijin (8):
  t7300: clean -d should skip dirs with ignored files
  t7061: status --ignored should search untracked dirs
  dir: recurse into untracked dirs for ignored files
  dir: hide untracked contents of untracked dirs
  dir: expose cmp_name() and check_contains()
  clean: teach clean -d to skip dirs containing ignored files
  t7300: clean -d now skips untracked dirs containing ignored files
  t7061: status --ignored now searches untracked dirs

 builtin/clean.c            | 32 ++++++++++++++++++++--
 dir.c                      | 67 +++++++++++++++++++++++++++++++++++++++++++---
 dir.h                      |  6 ++++-
 t/t7061-wtstatus-ignore.sh |  1 +
 t/t7300-clean.sh           | 11 ++++++++
 5 files changed, 110 insertions(+), 7 deletions(-)

-- 
2.12.2

