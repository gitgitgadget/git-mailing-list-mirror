Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 602FF1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 03:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750952AbeCCDjZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 22:39:25 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39384 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeCCDjY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 22:39:24 -0500
Received: by mail-pl0-f66.google.com with SMTP id s13-v6so6795337plq.6
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 19:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xATd6IFdsIWk/+/kCgn8pA3G5RnxqDAGxc1e7rUlLgs=;
        b=uNxBlucoaF/kLGmlXYnx2rLuC8laJkuRlOdWFZ6pay808ptzrE+Ni3b0GkH9Kk+ZNQ
         DzEA3drWklP5fesbWDNKl0vfTaGRQ0AkY5n0lK3tXymZFAJoYDqvSkUFB25Fqokye1Wp
         bm0yOJGYvMGlZpSgN1VshBpyoDE4dGNBbkICsFX2xP73jkTsZ1ng4RrFbXaXz397L2kG
         lPah6qiNZV375QeYIvXiBvol1FukBxQTSAw8fBKFPQefuqXRETiHSMHuvQaI9+ZYMDbu
         T8kdqoCixlkb0Jydt5cUXTnoxBsgYhmYe+dm0BbXbLa51pCieBMlNJ+zCTTvtmjdKBVV
         /epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xATd6IFdsIWk/+/kCgn8pA3G5RnxqDAGxc1e7rUlLgs=;
        b=OO6TL0L2yxkzCajsMq19xQLsjLgGS1u67CHVYRC+XBsAg4sqajTBBz8O0QVMRxhLoy
         lEe11FQYXyHrOHXSRSYa4W27GQXpR9A5dF4Ra/Xf5DUkmPoDdFLRTgY9TSAsm5iy3vqW
         rKmSGALRyn83xPBnS9OLOi+HJLvZlIz1/0RnelFEIgHRa4p5WydYXP27gPPaA3r7JeLB
         p0zDeZO+ZQiVclCkW88QoxUIT5uPxwAJzsJ2xbfMWFQsCKH0RyT7jRy329K5HXFRRWCH
         SNYlXZtsIgMVgaWvAnZC3MgYRiVJmk+S9SvP0/D0+khRjqI3ZkIBn9LTp7/xEqVweoD4
         GgZw==
X-Gm-Message-State: APf1xPD9fluewQ+O0ptuM4yAalWfyE+yRAWfZ3mui+AMfCorM1x4AJFK
        38tYjliARUPHZrU9LEW94+Ahdg==
X-Google-Smtp-Source: AG47ELtm446hzahHpMbwhmrb702WEKEHxT8NFZ6jI2CcsMdQtOaGbNNJ+m1vG3M4LZCLYzeJmZbKnA==
X-Received: by 2002:a17:902:968e:: with SMTP id n14-v6mr7244131plp.21.1520048363788;
        Fri, 02 Mar 2018 19:39:23 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id x123sm12079789pgb.5.2018.03.02.19.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 19:39:23 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 10:39:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/3] git worktree prune improvements
Date:   Sat,  3 Mar 2018 10:39:15 +0700
Message-Id: <20180303033918.15751-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is something we could do to improve the situation when a user
manually moves a worktree and not follow the update process (we have
had the first reported case [1]). Plus a bit cleanup in gc.

I think this is something we should do until we somehow make the user
aware that the worktree is broken as soon as they move a worktree
manually. But there's some more work to get there.

[1] http://public-inbox.org/git/%3Caa98f187-4b1a-176d-2a1b-826c995776cd@aegee.org%3E

Nguyễn Thái Ngọc Duy (3):
  gc.txt: more details about what gc does
  worktree: delete dead code
  worktree prune: improve prune logic when worktree is moved

 Documentation/git-gc.txt               | 12 ++++++++++--
 Documentation/gitrepository-layout.txt |  5 -----
 builtin/worktree.c                     | 11 +++--------
 3 files changed, 13 insertions(+), 15 deletions(-)

-- 
2.16.1.435.g8f24da2e1a

