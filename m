Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3B71F453
	for <e@80x24.org>; Sat, 16 Feb 2019 12:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfBPLtq (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:49:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36046 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfBPLtq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:49:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id n22so6153185pfa.3
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIT+JOOAUFGBiIifXgn1wZwSRORzRISK/Fts3NFDijQ=;
        b=mHTek/3OVF/h8Hu5U2m3WorLYsJz0SUbMEk78dVZXtmHa7FQB7tjMFuLi54qLtuL0Z
         kKmpXbxFqQZaejEpS5Qkye0iuUQsyiCXRlP6f0V/lQVYdpSIVZIeHad0Euar1p1BVBC4
         v/Z3U/AgGgCbpJ38nBYPkP2AYZV4qn2ZUOAUjsasbI45s9F7RM+THS7YFmNn3iE/f5sn
         nPWdRxabwYTjsuDRrIN+zpRi0WpEklzuClG30PjiebJEA2Q+BK8VfUFMalxWI3wEMOS0
         UhybHAMbt43I/s6nvpfAn56Cjx9NWTtFwiyIvqFlGheFLXQ3yT3xOrP+/TYqTGunz9oI
         dRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIT+JOOAUFGBiIifXgn1wZwSRORzRISK/Fts3NFDijQ=;
        b=uQL94fd9gh+N/ZMvNBpyGgA/KJMmtxS+NvW8tyECcA6NADe5pUvnEvanogKKtfFo0i
         +BMfByeDM2znTD23WcBRdbJ4YIkN80NO/tC1E8lu5P52KsClcDSfM2C7epDtWEE1MVcL
         GkRPuP3lc7f1zG4c/neDk4gVrHhMXrCn1xzEzyQqTSyASFwolUN5La8nNRk4+7NjdJ88
         aySCwVQrW93Xbhv6yLnxOckiNF8F06o2UAFdwzHSw+OZKaYNqUjO7bzISVjdC82hPoTP
         L2U2a9wFCE7dGJxjskC+uZPvFJS7/YJsvk1YFlb7+ArCKXPEV5YsmcqeIvxerrdMe657
         QWHg==
X-Gm-Message-State: AHQUAuboDLoJfVtJgFKceUsWhBwT/mr+CDKiCkvvvFDK4lbi1Y22gwQl
        m5rs3IEEcXdWdDfx8j4Zfo8/0sKo
X-Google-Smtp-Source: AHgI3IZAOn9kEjlxAfD/14HinQI+FMkI4WZhrkgCYWJPDaWRSzwwudWQOnSCOXftZi2k7rxu7h42UA==
X-Received: by 2002:a62:2f87:: with SMTP id v129mr970243pfv.220.1550317785651;
        Sat, 16 Feb 2019 03:49:45 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s6sm9865691pgm.90.2019.02.16.03.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:49:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:49:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/1] Introduce "precious" file attribute
Date:   Sat, 16 Feb 2019 18:49:37 +0700
Message-Id: <20190216114938.18843-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to the last round [1], the "precious" attribute is now only
used by "git clean". "git merge" and "git checkout" will not abort when
they are about to overwrite precious files.

[1] https://public-inbox.org/git/20181126193804.30741-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (1):
  Introduce "precious" file concept

 Documentation/git-clean.txt     |  3 ++-
 Documentation/gitattributes.txt | 11 +++++++++++
 Documentation/gitignore.txt     |  4 ++++
 attr.c                          | 12 ++++++++++++
 attr.h                          |  2 ++
 builtin/clean.c                 | 20 +++++++++++++++++---
 t/t7300-clean.sh                | 29 +++++++++++++++++++++++++++++
 7 files changed, 77 insertions(+), 4 deletions(-)

-- 
2.21.0.rc0.328.g0e39304f8d

