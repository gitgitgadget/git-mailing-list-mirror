Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9E5C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 11:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiBVLnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiBVLnv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 06:43:51 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747BE13981F
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:43:26 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v4so18206526pjh.2
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gu3I9eF0G05hd9Xrwvw/ENDIenth6ufpdtGUa2Mnd/A=;
        b=Pe//Ef70ur/3BNUidWcn+VqD2MGK/BS9ZVCHcp3PWYsZTvAzLbRTmll9H85QeQdZ54
         YM6/xOAVHWcWN9egBOJBv4N/XQUYgrF9qehqqZzx4dg+z2cj5tRjkBPBAa0V/JFckr0p
         ZXf6D4Ao01ehY35hmTNcju+RiGciBTL+6Ll/7ttni3LFcboMD0y6HadUhT4VgzzaRdJF
         d0kTaYa5J47MgZtWTYv6DWc6OV1hWuoTPWuhyNJEZ1Teii+l3pp2D5Djoz1ZvcIXnASu
         5SxzxSNlGRXCWP/LtEnq6B0KBnZ5OtESEEPudYPkkApQ11IJeJxy9AduESz/oUFd4xxv
         UbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gu3I9eF0G05hd9Xrwvw/ENDIenth6ufpdtGUa2Mnd/A=;
        b=bxjFvAm60JEoFccQPTlELZoBtBbYvKRvZFFfCeY6rK1sSBHJHFV/TO3ZwWwGZm50Ah
         EFmR6O+jikPp47lgK06frSbkiNTIGg+AvolLogOHEU2uKeFp9ziXdoIrhkWv/S6jcFGA
         cN/06ovg5qYPVJVRzFc1ligF05h9pHA9UVn+sQCY4jYoCjhRklI5Aw9JxEFO1pULsqkv
         kHf3jMRLLECQlZCjj0CxqN4TVTC4VNlr4rF1/4jShSBJxT2pYq7kE92yiil/gX0BcKOd
         EdGzPP8VebUUI2mhohQcrTLc4BjmECHzkdATrMcDs1C4eJFPk/rDVoAh/aQp5prqTb2T
         vOlw==
X-Gm-Message-State: AOAM532iGNEKaXRFJAt+dKI8xUkiDjChyvemc2uIP4itXtb94FGE8Tch
        mjuEejXJZKH/ukGTtn/By4LD/0OlnTYR5/Twdns=
X-Google-Smtp-Source: ABdhPJxoprH3GwWoiHausnIbHG3Np48pEjdqEXa4yhUAxnNvq/RJR3arP0OyVF45ELrTY2OV443Vog==
X-Received: by 2002:a17:90b:19c7:b0:1bc:6002:7c5a with SMTP id nm7-20020a17090b19c700b001bc60027c5amr3777984pjb.179.1645530205653;
        Tue, 22 Feb 2022 03:43:25 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.196])
        by smtp.gmail.com with ESMTPSA id p14sm12372430pgs.46.2022.02.22.03.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:43:25 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH 0/2] microproject: avoid using pipes in test
Date:   Tue, 22 Feb 2022 17:13:11 +0530
Message-Id: <20220222114313.14921-1-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pipes doesn't care about error codes and ignore them thus we should not use them in tests.
As an easy alternative, I am using a tmp file to write from git command so we can test the exit code.

This is my first contribution that's why I am keeping diff short with an intention to understand the process instead of making impactful change in first attempt. Later, I will send more patches to fix the issue for other files.
Shubham Mishra (2):
  t0001: remove pipes
  t0003: remove pipes

 t/t0001-init.sh       | 4 ++--
 t/t0003-attributes.sh | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
-- 
2.25.1

