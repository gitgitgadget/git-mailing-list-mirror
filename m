Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775EAC433EF
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 00:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbiCSA31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiCSA30 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 20:29:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729C012AC9
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:28:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j18so4096930wrd.6
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lu67AZN6CzwrIsYwaxjVYlcmAQrpO6X2bTdbJkyu3CE=;
        b=RxQtP25h/Z7RY+VXLKrO8EH5+x1aNPHg7ogGfeZrxnZ+zoJt+VYcyoUhdAwwgoP1oZ
         cdOUmxRhJEV3LGrwpkol47JMEVoJCuhZPpRqIoAfHcmhSqB/7++kin37PTa6itFE7JsJ
         OnZ1EcOPEIIxmecYsXw64P6TRp/MT0/pBhlkzV2wCc5EETadRXhVa6FFIHGNsGfobIpp
         e3873UpCjpJy3BKdRFqACQSZtYAVmpaqOJtWBQ7GnmsVWJ7v/fK1PaoqE36yKNpngNfX
         ioEz47+49XJkdtnKjjnv+ODPHTwUezAnv3dWXLySZro6hu/PdYbAqd527b9Qo0YeLMzA
         pzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lu67AZN6CzwrIsYwaxjVYlcmAQrpO6X2bTdbJkyu3CE=;
        b=GK6RHqpCI6Krl+us2FupRxKfPnLcrxN1SjeTVY8TW+u2Ml2TAPL51WMIfr6wADWn0S
         dm4BzZOCyfY3LFN0ESO1D5YegBCuVZ4guQbnc6/+3Ll20qxC/kxGYQcVL5OjcINUiPge
         npgswzkbEPCFSs6Xn+CpmKdSUP33N7gmrYeVvxiL+Fq+MSdwXrSA3WDW0/ne+aB9FB+j
         cm581IATJrr8SND3gFpHScmopBQNjAtYsWvWZ2GC1Q49j/sIehNFPx3jFIc1w4UtvlXb
         AmltJCl1EmkwXeWBhOQqm49o1khOLaI7aNx8Xl4Xadf/as3OWUJncBIxJ5eJGme+HJ3f
         g6pQ==
X-Gm-Message-State: AOAM5306gLePeTNs8ZAQEsqmS0d7hsndcKW7uuje1Srsgb5qK2oQClbF
        tWIzkqplrJAPazlk2Al3HrJKkO4S7paK+g==
X-Google-Smtp-Source: ABdhPJw8nRsq+WIP3g7cpvrYZ+h8/byW3cdY3Vk1G+KsTeYEXIQ1h8fz2Zm+U/9Z03dJanKo/l6mUw==
X-Received: by 2002:adf:d84e:0:b0:203:d515:6e0b with SMTP id k14-20020adfd84e000000b00203d5156e0bmr9692708wrl.443.1647649683813;
        Fri, 18 Mar 2022 17:28:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v10-20020a056000144a00b00203df06cf9bsm7435964wrx.106.2022.03.18.17.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 17:28:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: use '   ', not non-existing $(wspfx_SQ)
Date:   Sat, 19 Mar 2022 01:27:59 +0100
Message-Id: <patch-1.1-05949221e3f-20220319T002715Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1438.g8874c8eeb35
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the use of a non-existing variable added in my
0b6d0bc9246 (Makefiles: add and use wildcard "mkdir -p" template,
2022-03-03) to use the hardcoded whitespace padding for "QUIET" rules
instead. The wspfx_SQ was left from an earlier (rebased out) commit
preceding 0b6d0bc9246[1].

1. https://lore.kernel.org/git/patch-v4-8.9-3733b0c8df1-20220302T124320Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A trivial fix-up for a topic already on "master".
 shared.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/shared.mak b/shared.mak
index 4e1b62ee99e..50d4596f0d6 100644
--- a/shared.mak
+++ b/shared.mak
@@ -53,7 +53,7 @@ ifndef V
 	QUIET          = @
 	QUIET_GEN      = @echo '   ' GEN $@;
 
-	QUIET_MKDIR_P_PARENT  = @echo $(wspfx_SQ) MKDIR -p $(@D);
+	QUIET_MKDIR_P_PARENT  = @echo '   ' MKDIR -p $(@D);
 
 ## Used in "Makefile"
 	QUIET_CC       = @echo '   ' CC $@;
-- 
2.35.1.1438.g8874c8eeb35

