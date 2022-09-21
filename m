Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1E4ECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 13:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIUNDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 09:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiIUNC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 09:02:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BC88E4D7
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 06:02:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d82so5820605pfd.10
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 06:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nXysgNlNcBOCIHOuekj3dPtTooffc+8050pI04x5D7U=;
        b=VwxSoK61CUIjqfMTb+FfEcb9vQCCkKiRRLbfiERhFcm+XU0Wg6CMnLQ9M19xK377xQ
         b8an2tcnU1HVAcQZcRM305da2Z2J9BgjRwNA7z/0aGjifTbFoC4AyDZF4hZhZMP79pPt
         c1LiQcoqMVQwJ62Mt3OTYsN0T5HnJxgcT/Pv3iI76Rrzjmq5NOJYbWYIayD6VQcBv17x
         oQXV2eNOQPjrZO59oVzVnfRa4XiqhdfdLPUVX3UDKU5v9ZANpufipUodYF763P1jzVMf
         6V+4iuiSCSmp3FdfnAtocYOQkdTmbaPe78g8M9eiEZAt3v/YLQFj7HDhaRFxsVddVCmL
         S2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nXysgNlNcBOCIHOuekj3dPtTooffc+8050pI04x5D7U=;
        b=H8kXfZZnHvHZy3RrvDfiFqdlPYySUJPm7Suz6uzuFlFrL+d/57t7ahTP/ZGaeyz/DI
         PTXik3IUZj4sBeXxESAlDUA376/KE0z7CqVp1OMbtLEix8s2Is1rj0h4j91sBjFpBXYt
         ri9YkUgn8FI4W64oP83iyDW3tCZsMc0Aj1w+tcFaIef3UQ2+LkhBzV3W2hMqKb7Qcn02
         4w533t3GSXobHmFk1rwroBHTHQxe7ElvLC0soR7XRlKc1tCCuCd2YX5qKTvG6WEmboxM
         MtdmuW5+sF4/DyXQPcm3Pwwt55lY7VHnr4wyumlk6NYV3m/3oAfOCrLANRyX5+l3sUpc
         8+Xw==
X-Gm-Message-State: ACrzQf1Qzvvdxm4UBdo7JlprM/cekU3QPOBMAjGiZKWUKoeLk5Eyaw1+
        Enfdi/zvtLAxphZTbQaAhN0oiEoN0aQ=
X-Google-Smtp-Source: AMsMyM54tLCZSCmtr5sWgWkoH4OCubRQnvPu0seEV9hHic3Plo9XmCsh0XcSyQKKSMM8cIRiJE+DNw==
X-Received: by 2002:a63:fe02:0:b0:438:703b:5309 with SMTP id p2-20020a63fe02000000b00438703b5309mr25189283pgh.370.1663765377088;
        Wed, 21 Sep 2022 06:02:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:5008:db00:84c8:158c:9494:ee57])
        by smtp.gmail.com with ESMTPSA id i64-20020a625443000000b0053e5daf1a25sm2084332pfb.45.2022.09.21.06.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 06:02:56 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] CodingGuidelines: allow grep -E
Date:   Wed, 21 Sep 2022 20:02:29 +0700
Message-Id: <4ad1ac9d9b25f2fc5a2ada28cae0413c04b07e21.1663765176.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.0.rc0
In-Reply-To: <cover.1663765176.git.congdanhqx@gmail.com>
References: <cover.1663765176.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Despite forbidden by CodingGuidelines, our usage of 'grep -E' has been
increased over the years, and noone has come and complained.

Let's lift the restriction.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/CodingGuidelines | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 9fca21cc5f..cb7a367ea0 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -162,8 +162,6 @@ For shell scripts specifically (not exhaustive):
 
    - We do not use \{m,n\};
 
-   - We do not use -E;
-
    - We do not use ? or + (which are \{0,1\} and \{1,\}
      respectively in BRE) but that goes without saying as these
      are ERE elements not BRE (note that \? and \+ are not even part
-- 
2.38.0.rc0

