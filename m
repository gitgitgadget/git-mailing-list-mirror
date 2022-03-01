Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FFBC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 07:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiCAHDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 02:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiCAHDj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 02:03:39 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6D545AD3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:02:59 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id q11so12722038pln.11
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkXgrubMT9IY9DSuEwmimPkONA7W1nUCGEv6W4taAdY=;
        b=KlswekYJjhvb19kNWOuRbmaZVUndUCzqWeg+zi6hG9XSEZZ+k3MXLMLqzffd2tUbdf
         lDWxSLQk7bA8rkg+0Fsjfrdub0aXcJJrqblhnTH0RAQJ/H1kHGn+VkFex0rBOfylIDeN
         LZSe+cJOa/DOJ37RzyW5+R1gHP2VUKO1OU6JJjHE8DjA4Ghj2I0JM3n0QI1LUw5TJpfm
         yrqWViInQCUZrxFQo9+5o2mnwQ3snaENhjqQeoKlAb+4TDqIuScNn2FqfVhOt5FYEoEl
         kOHOc4/9SM+pjo8j2PaRhjkHmmf3E/UmA+0UGLEKByE3utExopm1nNf5qCpGkILw8Q33
         YoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkXgrubMT9IY9DSuEwmimPkONA7W1nUCGEv6W4taAdY=;
        b=sjZJcXrBMXJpjlf1vQzr5rOOD0wJxlAAixkABnnk/ev9EmkP1YOfSAlcmDBhqUAKG1
         ALDl3pz87s9GEmdYntxuDsaSy5syJ8g0f/OR+TsHqyjZnZP6UtYO9n0R6M5+LVUMdhaf
         It/oyAvQz8Oy1SR4D3Q4CpAPxvpRTQQ3hvk7Pr72H2FlAZh6i8FJ/s/amVaPXWCVLuon
         AsQYCkQgdFl2P/bKbCNyZ5LEfjc9qFmp2QIB+to8LrZVfEL8MzKr5jon3JU/e212RTh4
         uYERI4UBZletiyFtivyJ+epCV36Bqa8mIDLxNhWQHOQ+CPgD4n1Si2gDYuVy4vPyMm6p
         hkPA==
X-Gm-Message-State: AOAM531lhOKFGU/APXrdAzdro2yaUD78LFLLAiWFkLsTgKeH1ZYvOp0B
        srjdfYjkEHCl9Z6DzUWUh1tqy5xCPQYR0G5X
X-Google-Smtp-Source: ABdhPJwUoJago2UufX6JLEqim84/94ReIFQcfqnMRjKJEUSdl89HA0cHmf2nDWTr9vtePuUcSpo7ag==
X-Received: by 2002:a17:90a:e50c:b0:1bc:ae25:3b5c with SMTP id t12-20020a17090ae50c00b001bcae253b5cmr20635979pjy.173.1646118178424;
        Mon, 28 Feb 2022 23:02:58 -0800 (PST)
Received: from localhost.localdomain ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id q2-20020a056a00084200b004f0fea7d3c8sm16171833pfk.26.2022.02.28.23.02.56
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:02:58 -0800 (PST)
From:   Jaydeep P Das <jaydeepjd.8914@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH] userdiff: Add diff driver for Kotlin lang and tests
Date:   Tue,  1 Mar 2022 12:32:25 +0530
Message-Id: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds diff driver for kotlin lang and some test cases for it.
Also, modifies `Documentation/.gitattributes.txt` to state the same


