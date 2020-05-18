Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1E3C433E2
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2112081A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker-net.20150623.gappssmtp.com header.i=@dtucker-net.20150623.gappssmtp.com header.b="MclH/Y7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgERKES (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 06:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgERKEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 06:04:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2014CC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w19so2250432ply.11
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dtucker-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKVmbmNzkaxn/8C3Iw6aDQpVn2ZuFWYfmTfStr4MBnY=;
        b=MclH/Y7IRULCg2Zxd4uFgau9UJtoxjZy0n5nL6ilP/qJu9N16CoPGE0fumyJCR3XjA
         LgvXKkPof9CrkIu6U+ADKx5Q2DJeNPQ/0KUAcrctAMTL3Bu1Kq7+eSBFV6gvS2T1tpoo
         JDH6yJxs3meLzn74LcR8/IyCDknZs55zjwZzCH1u6ZYEMZiA0BzOICvqLUNqwLdKVx2J
         7DTMLTaHHBtj6VfGJCY+LZjZcREj9zbVkLv1N9Eh4E34zj9rYFITW4WhJ6exzChnVuZP
         g11sVkfUtTyhHNodHDgkXARFrZD/zySOVlfmRIStH+dxeT+NULn/om7zlnTctI7WmiNl
         5RYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKVmbmNzkaxn/8C3Iw6aDQpVn2ZuFWYfmTfStr4MBnY=;
        b=GB3+mGbsWnDRWBwKSZcdJdRAEbz+tgHcIZzlVG0YZ6Jtd55HEkXc1F6UFm+XfDbl49
         FukFYRstCjZXqLC+xTSMZIdflYScz456XbM2Zjj0c5MCqRqj0ig+U2U2DeOuU0ezxW1G
         PIsr4IJ61zukRLWi4xdsYUAzody35v77SjycIRivFghCkCyQ6/RTWiZp30G9SLWU9PGT
         Uso4q/J6lEHZ4YYolcb7jcXVl145aTTIAv/vqHufMnwNLWgPFFfThjKk33pjqXpGRswu
         POl22focVteboNdLIXJyHloolPHBLm7Q07NUiCcPHg3l/LsqSAVZe9uiebkIrlRM4C6N
         GSZQ==
X-Gm-Message-State: AOAM532aEWSfpg5ELgc98KCpcE1g+lzl3tHpIqmBLKEwxprb8AH/6ehl
        nQl7jm/mpVLgxF85jzO7JBHSxAvmfp2N6NrSSitdMtCGv3zEitWeCYc/WKKmq8scbe4xIrqFhDc
        CoIzPkhTcixJvbD73JTzkSUjdGKP6QPACw73K88sirxGFP/aXsLr0qupJT7bPYm4=
X-Google-Smtp-Source: ABdhPJx2Fcd+DMRYly6MS9NlmYerocJ63MQ86xRUUNqahU48ae3a3kw3kj+yOhLJ6GULscB5C+nrUQ==
X-Received: by 2002:a17:902:8d87:: with SMTP id v7mr15249338plo.153.1589796254157;
        Mon, 18 May 2020 03:04:14 -0700 (PDT)
Received: from fw.dtucker.net (2001-44b8-3110-fb00-0000-0000-0000-0248.static.ipv6.internode.on.net. [2001:44b8:3110:fb00::248])
        by smtp.gmail.com with ESMTPSA id k24sm8331507pfk.134.2020.05.18.03.04.12
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 03:04:13 -0700 (PDT)
Received: from gate.dtucker.net (2001-44b8-3110-fb01-0000-0000-0000-0001.static.ipv6.internode.on.net [2001:44b8:3110:fb01::1])
        by fw.dtucker.net (OpenSMTPD) with ESMTP id 02394daf
        for <git@vger.kernel.org>;
        Mon, 18 May 2020 20:04:02 +1000 (AEST)
Received: from gate.dtucker.net (localhost.localdomain [127.0.0.1])
        by gate.dtucker.net (8.15.2/8.15.2) with ESMTP id 04IA41AG029445;
        Mon, 18 May 2020 20:04:01 +1000
Received: (from dtucker@localhost)
        by gate.dtucker.net (8.15.2/8.15.2/Submit) id 04IA41DD029439;
        Mon, 18 May 2020 20:04:01 +1000
From:   Darren Tucker <dtucker@dtucker.net>
To:     git@vger.kernel.org
Cc:     Darren Tucker <dtucker@dtucker.net>
Subject: [PATCH 1/7] Redirect grep's stderr top null too.
Date:   Mon, 18 May 2020 20:03:50 +1000
Message-Id: <20200518100356.29292-1-dtucker@dtucker.net>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prevents pollution of configure output on platforms that don't have
grep -a.

Signed-off-by: Darren Tucker <dtucker@dtucker.net>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 66aedb9288..4effc82b76 100644
--- a/configure.ac
+++ b/configure.ac
@@ -526,7 +526,7 @@ if test -n "$ASCIIDOC"; then
 	esac
 fi
 
-if grep -a ascii configure.ac >/dev/null; then
+if grep -a ascii configure.ac >/dev/null 2>&1; then
   AC_MSG_RESULT([Using 'grep -a' for sane_grep])
   SANE_TEXT_GREP=-a
 else
-- 
2.21.3

