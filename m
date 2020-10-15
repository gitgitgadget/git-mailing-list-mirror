Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AF3C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193FA2145D
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8RZG+iR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbgJOR5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbgJOR5r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:57:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA1BC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:57:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v12so2003360ply.12
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NdQu4jg06JjyPIfMSt1Iad2x8+XOvGZtyNdFrhaQWVM=;
        b=n8RZG+iRgtR7bfWxAPqLjLXZz7cLgeLhGscu5TEH+TaBCSjPeaj/39sSPIGjMLAnFM
         yQmlmlZcGKcjzuo+fQJAu0v7+ROTzW9gY6tzIkKlyvi3NYAj7GLgLKbKXpGIxfDaw13o
         VcRol8WezJkMd/8slXTHx/o/7nzSeKv/6sSdXO6/menAVTx7wAZnsROVYaxcEEENbarb
         ekOLS5yI8UtpgJgPVOljulgS0Qg62nYmjakQ1wLlAH3SdRwFD5xGrniAVBIdTYLZIvqV
         arHu8ZClPUTz0/5SVxBPY7VP/MSTkueylaZtyunEf0KSoR/XXGvQqsjTkqDVYCbV/YGT
         6XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NdQu4jg06JjyPIfMSt1Iad2x8+XOvGZtyNdFrhaQWVM=;
        b=sz8c751fwQ4hik79R/OIcZHRf9QJX+O/19GKwut+Yf6BQaO+6oKsyOKGxJQjYBcyZU
         Bd2gwz/l65CBG6mAMmj7p7hLjXvMMyA1r/Tj4nAphKciCpnwP4DJTMrBxRgP/TocqOT8
         veGRYk4L9JNt3C/rT0YB7mR4u0+Bsk2duU942qcOZTcGLZrll/bf+KKbVB0lja573MaK
         rx5jmAp0QRLzs8m7WvZKjglHWLRfZSNtUbhuRbsBNeCXHzjpvir0ZJRlj5u9PajZ4zrm
         u/7iRcjlmaiWKiucKagXWxzekBP4qK9xDWUrPA8+SJFt2BIua20x86PGXNmfD3b0lOGe
         EYzw==
X-Gm-Message-State: AOAM532KKE3kI8nF+7IXUrY1ZM01s6Olec5rjEVly/CZ/2YDjzR5d7LZ
        tPP6L0RP7tWSMGqrmtJjxOTLtgDrjmXdJMzn
X-Google-Smtp-Source: ABdhPJxgxv84qHvEqzxN7qNKOehH2VkAzsca8VCA6su5/67W2+LynDDclfMZN5Biv9g3LFxxYRgz9w==
X-Received: by 2002:a17:902:bb88:b029:d3:d3c7:15d5 with SMTP id m8-20020a170902bb88b02900d3d3c715d5mr4716092pls.49.1602784666412;
        Thu, 15 Oct 2020 10:57:46 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:1309:c8:79e1:6677:5d35:9a95])
        by smtp.gmail.com with ESMTPSA id n139sm3945930pfd.167.2020.10.15.10.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:57:45 -0700 (PDT)
From:   charvi-077 <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        sunshine@sunshineco.com, charvi-077 <charvi077@gmail.com>
Subject: [PATCH 0/5][Outreachy] modernizing the test scripts 
Date:   Thu, 15 Oct 2020 23:27:04 +0530
Message-Id: <20201015175709.20121-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is my first patch series to the GIT mailing list. I followed the
link[1] and t7001 patches to modernize and clean up the test scripts.

This patch series : 
 -modernize the three test scripts : t7101 , t7201 and t102. 
 - cleans up with 5 types of changes in all the three scripts.
   1. Converting the old old style test format to new one
   2. Removing blankspaces in test bodies 
   3. Removing whitespaces after the redirect operator, according to
      Codingguidelines .  
   4. Using git -C instead of cd 
   5. Placing all commands in seperate lines. 

Also, I have tested the scripts and set up travis CI[2].
[1]https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/
[2]https://travis-ci.org/github/charvi-077/git/branches


charvi-077 (5):
  t7101,t7102,t7201: modernize test formatting
  t7102,t7201: remove unnecessary blank spaces in test body
  t7102,t7201: remove whitespace after redirect operator
  t7201: avoid using cd outside of subshells
  t7201: place each command in its own line

 t/t7101-reset-empty-subdirs.sh |  66 ++++++++++-----------
 t/t7102-reset.sh               |  63 ++++++++------------
 t/t7201-co.sh                  | 102 +++++++++++++--------------------
 3 files changed, 96 insertions(+), 135 deletions(-)

-- 
2.29.0.rc1

