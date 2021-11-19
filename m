Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4FBC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471CF61AD0
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbhKSMtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 07:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhKSMtf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 07:49:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3939C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:33 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u1so17932936wru.13
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IKV+W6b7K+MZ7mE1M53Gp9qOyoOGL63UHLsjkhHIZX4=;
        b=ffOs1lWZ4miFmGb0t3eOqW8pQsgm9JLKapmFl3oIhX7JAge3RGy5ObVkk2huj+i3pt
         hQpNN1FmsB+MQ5d9zQxJJtKmkXZ98rm0qglPo4dDG7puBeMihu1ST9dq5tuLXvxL46D5
         qFCwmSzu+eLMdpSjY3I217m4rCXBH6XeKitw+wEpTVOGZfWYO0lWgVGFdCS2ckdPFW09
         1+b26euZJmdYU228EQLM3p/bzQs3QEzrWxvA0Fhs+nkYKrxHaKrGP8Ao71+jaRn3uAYy
         +L5Wy6Oy5IJRxfmU+w6gX2WA0uxH3e+bRlyXJg9oQzc/duHiK5irtTYhGJ55HnXlO0oz
         B9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IKV+W6b7K+MZ7mE1M53Gp9qOyoOGL63UHLsjkhHIZX4=;
        b=r3qPU0Nq/hp+qnfxFr9En+pfsusAxBnAtJcdxMyNW6/WpHMSZe+n5zFQxLZLKb0q7u
         hKUf4LgInAND2ZArKwjwzuel1f1TFvXpZTlFV0nlIuQ4FGjuJ+ok2mIR98pk5cREJZ/2
         XblmzqBoR36Uls1XtWPj2+mwj+6VU3+XQlBeAeD27C73cprJDHV7YoyRqEj6JgyXKwsh
         RmbGY0+0DM3D+iSCPfkCrOe26eLV5Jo+xXf3yfqk7xoCAhH2r18WledXo319UaBFf2hy
         Se0QYVrBjTxZ8Tw/5jIL0Cw7sNHSJWScSx0+p4YKJ+f2d8BALTigiANa5eboWxP2ouqn
         l8Vw==
X-Gm-Message-State: AOAM532IwF0UODU26PQ/YuOFm8pX0/3oKdjF99vnPNbOs6SaSVqLg3EE
        ZTXm8l9pHTCxZj2xWdVIRSWBv37ZcjZddg==
X-Google-Smtp-Source: ABdhPJyBrm1GzwYpMIGHxTL7P+qyeulRzz+oo+715YkSp0YkNec3H1S3ZaTPBUUCEJ/3TfVCfMLSOg==
X-Received: by 2002:adf:ee4b:: with SMTP id w11mr6939454wro.115.1637325992271;
        Fri, 19 Nov 2021 04:46:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm2857567wru.51.2021.11.19.04.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:46:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] various: remove dead code
Date:   Fri, 19 Nov 2021 13:46:20 +0100
Message-Id: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.817.gb03b3d32691
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove various bits of dead code. These are unrelated things that I've
spotted here & there recently. Submitted now to clear out this batch
of dead code removal before it gets any larger.

Ævar Arnfjörð Bjarmason (6):
  xdiff/xmacros.h: remove unused XDL_PTRFREE
  pack-bitmap-write: remove unused bitmap_reset() function
  object-store.h: remove unused has_sha1_file*()
  alloc.[ch]: remove alloc_report() function
  strbuf: remove unused istarts_with() function
  json-writer.[ch]: remove unused formatting functions

 alloc.c                                       | 19 ---------------
 alloc.h                                       |  1 -
 .../coccinelle/the_repository.pending.cocci   | 15 ------------
 ewah/bitmap.c                                 |  5 ----
 ewah/ewok.h                                   |  1 -
 git-compat-util.h                             |  1 -
 json-writer.c                                 | 24 -------------------
 json-writer.h                                 |  3 ---
 object-store.h                                |  4 ----
 strbuf.c                                      |  9 -------
 xdiff/xmacros.h                               |  1 -
 11 files changed, 83 deletions(-)

-- 
2.34.0.817.gb03b3d32691

