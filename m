Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A27C21F597
	for <e@80x24.org>; Sun, 22 Jul 2018 05:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeGVGoZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 02:44:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39905 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeGVGoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 02:44:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so14740986wre.6
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 22:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uZmBjDypfUhMIcn2VQhvJIhxhbC/lKnKT14sE10Y66A=;
        b=B/7O4tFtfmhOArETY9i50jf5wUWhO60I3yiQRYrbBJ9+SkgYeihyv4aTjLtNJkTAO8
         bH+xI7cEFd7d3FcuHcVtCm5VAxx5ESYbCB3ZVpwwQtgXinJybqHiJgPFRkrx14ebzV2Y
         C2DXHHDIOxoBULq4yOJOYFaF4bfapGIvRqyf1xGLSphePRFlzBjB7W2c6D4sD3UGwCh0
         XOmnaBpeN0LtD3D7jV61KLawbyjoOJ2D3PpQLmUP0djUnasV4fvO1hq79UNaO/bmp8I1
         7FZQRx+C+tw0IS42yBqxzlD8tAdX17mmSmgV6F0KbzfuCOvPfIGbLlB2j07wrNREgr23
         Wpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uZmBjDypfUhMIcn2VQhvJIhxhbC/lKnKT14sE10Y66A=;
        b=F8OPs/AJ2tqDUuNCajce4COh+9LXFUHHgGee/HJRW1VID54KAPqG/nVzCQGm5rNEcg
         h+G/bQ/CkowQUXD8TDIocpyjdXkHq/IVFt0Cww6CZr52i/sRXi2SZy7e9wY6pH6hdsDi
         QRhapxPLrW7jexV5vefNUoRSO6kh0i9MRRgU+Su3vKnzIA011sbz8iDhZyg9s3gPciXF
         ZnRZQpJlNMYHWWIxuuAjz0V9aaPREaKeY18HXzTc4L+eBUbVaDZz8of8fif7i0kb5rOf
         h5XQ5H2U1AxwToU07PoqnLbSL7IvbcMJtSfSmdw1cxBWC7bo7pLuQ19ajjHu9Q6quWaV
         JNLA==
X-Gm-Message-State: AOUpUlF3NKj/D9aOqaqC4D5FQN6pTKyu0yECSXFZAR+ZwBTHpVMvJU/d
        iz2wdibENBe7G7/56CEeDHFvMh/g
X-Google-Smtp-Source: AAOMgpegSn8wCkPxP0ZNwHeNhW3HcuK4kzwFzhJPPXOFY58t1BOpcA6+EDVb4nkZuXLfy4Dv9Erd4A==
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr5239809wra.19.1532238537338;
        Sat, 21 Jul 2018 22:48:57 -0700 (PDT)
Received: from localhost.localdomain (188.10.112.78.rev.sfr.net. [78.112.10.188])
        by smtp.gmail.com with ESMTPSA id d102-v6sm10591856wma.10.2018.07.21.22.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 22:48:56 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 0/5] Add delta islands support
Date:   Sun, 22 Jul 2018 07:48:31 +0200
Message-Id: <20180722054836.28935-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.237.gffdb1dbdaa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is upstreaming work made by GitHub and available in:

https://github.com/peff/git/commits/jk/delta-islands

The patch in the above branch has been split into 5 patches with their
own new commit message, but no other change has been made.

I kept Peff as the author and took the liberty to add his
Signed-off-by to all the patches.

The patches look good to me except perhaps that "pack.islandCore" is
not documented. Maybe something could be added in
Documentation/technical/ too, or maybe improving commit messages could
be enough.

Anyway I wanted to send this nearly "as is" first to get early
feedback about what should be done.

This patch series is also available on GitHub in:

https://github.com/chriscool/git/commits/delta-islands

Jeff King (5):
  packfile: make get_delta_base() non static
  Add delta-islands.{c,h}
  pack-objects: add delta-islands support
  repack: add delta-islands support
  t: add t9930-delta-islands.sh

 Documentation/config.txt           |   8 +
 Documentation/git-pack-objects.txt |  88 ++++++
 Documentation/git-repack.txt       |   5 +
 Makefile                           |   1 +
 builtin/pack-objects.c             | 130 +++++---
 builtin/repack.c                   |   9 +
 delta-islands.c                    | 490 +++++++++++++++++++++++++++++
 delta-islands.h                    |  11 +
 pack-objects.h                     |   4 +
 packfile.c                         |  10 +-
 packfile.h                         |   3 +
 t/t9930-delta-islands.sh           | 143 +++++++++
 12 files changed, 856 insertions(+), 46 deletions(-)
 create mode 100644 delta-islands.c
 create mode 100644 delta-islands.h
 create mode 100755 t/t9930-delta-islands.sh

-- 
2.18.0.237.gffdb1dbdaa

