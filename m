Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A00C433EF
	for <git@archiver.kernel.org>; Sat,  9 Apr 2022 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbiDISqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Apr 2022 14:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbiDISqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Apr 2022 14:46:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D80714A6CE
        for <git@vger.kernel.org>; Sat,  9 Apr 2022 11:44:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y8so6022409pfw.0
        for <git@vger.kernel.org>; Sat, 09 Apr 2022 11:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/C8GbcySVuwAK9iEGzr4CAGx5R7dwp+CssfKDa+svN4=;
        b=dlsturglbzLniSSV+Omf1pKvv1X8aEM4LiDL3daFlNvmkKHL2PO2VaZm16EurMDH8y
         sHoVK1CpBuGktRWtqxtivnjk3/O4etz0kMuUpuM2QSEVcQHfcmHviKaQUOrI79vdFweg
         0zFgu5DjOmYpIcNCb1uPLxJwS9i4vh/gOkv/IknXJLuLznct68DolyMn5V0EnPJbcIp3
         +KrvrQhOMyjSXYxEtctmMlWrJ7a4Vt5zeWWCpfP7/sELl89AT93YtqQqCb4j45jdL27f
         gNLYyxi855xqr1pJUMBJeL1RARD5PzmLOnMjXb+b91T+7LnxO/6n9Slo6HKUJv1oQU1A
         JLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/C8GbcySVuwAK9iEGzr4CAGx5R7dwp+CssfKDa+svN4=;
        b=Sn+EF+w/Ob8gtRc4De5tQIr1g6aVYSJKWvZI4+O3F4rG+ybxGCx1e1BLp3veTCiZsF
         SkHEbGpeIlywuIttft76VORNc/qHBQLMx387mO8ergQmNamrMUDijlhYwrYiqWfHCAJl
         hlzEO3AsqMbTbGfyiP7Jxz50Axq5Yl3hzmzQ80X6QPEwmhnqzEzABrSE37wGAnT6IOTF
         1tQ2jROH1VvhBJ++zm+f6BMJCfYUHzimAgvfXZxl+gi1K8j0qYwytLobYeNCMLq5WzJK
         S3EqCqRgLXLwZZYVcUqGhP6OdQVSqICqnGKG+axJ0AxSpW3sgncuuJuu9iviAbcQ8l5v
         y7WA==
X-Gm-Message-State: AOAM530BNIUaxfjvtmIqvxDk8qHfYLw9KRMPG4V1dF428OhTJMKDTAh9
        7KPHtsTSdy+OywasP5F6Js5/fST9RD5G3w==
X-Google-Smtp-Source: ABdhPJxEqptLFcpQegEddV5aqBSfQcbDyzQF/NhjD1Yx5Mf1I27/M85b54MFDay96Q70WtWVnsppNA==
X-Received: by 2002:a62:f20d:0:b0:505:6ec8:4ee6 with SMTP id m13-20020a62f20d000000b005056ec84ee6mr12599666pfh.5.1649529845198;
        Sat, 09 Apr 2022 11:44:05 -0700 (PDT)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.39])
        by smtp.gmail.com with ESMTPSA id mu1-20020a17090b388100b001c77e79531bsm15898739pjb.50.2022.04.09.11.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 11:44:04 -0700 (PDT)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, kaartic.sivaraam@gmail.com,
        Shubham Mishra <shivam828787@gmail.com>
Subject: [GSoC] [PATCH 0/1] draft proposal for reachability bitmap
Date:   Sun, 10 Apr 2022 00:13:48 +0530
Message-Id: <20220409184350.1124-1-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Community,
I am sharing draft for my proposal on reachability bitmap. I am looking
to get your reviews on proposal on every aspect that includes planning,
grammar, or anything I might missed to mention.

Thanks, looking forward to get some comments and improve the initial
version.

google doc link - https://docs.google.com/document/d/1Zei9g3mYa0SAz6Z94cIx_1tgFeID6xIL5Qb3Un_itVQ

Thanks,
Shubham


Shubham Mishra (1):
  Initial draft proposal

 proposal.txt | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 proposal.txt


base-commit: bf23fe5c37d62f37267d31d4afa1a1444f70cdac
-- 
2.25.1

