Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6414C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1F261221
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhJUUAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJUUAU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 16:00:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD112C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o20so1260969wro.3
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fPIVmQjHILM2UWOANfemmF0RSWM+pYxrIykt/+UUb2U=;
        b=M5NO7kV4gnsN0TW52kOQZ+fSiUSZ3GegocgQFkKh7lv77WpKXEjcaau0fcXhhU3W7I
         Iv2N2GZwLRixshsa1Jdiwl9Zx1qS84PtZTNO0xdiecgzA128ZDtURWc2Mp/ZQNoIny19
         mZgJOCrr1ennOvGVNQJS9sAsmbhN9nRhpVsZJS+w6Xm6Kd8xR5eIXdOTKAZnmDpY2pY2
         NUUWc67TAED31yD4yU/GhMfyoaGgq5aumzDfFkF+LVXHA1IzNMNnVpb0OIrCuXmC9Cyg
         vgX2MymVD5hkAWqfRz3GIIKlZTn5qQA+36swoSqcjR2np5YHWXlU0igtcKkgSa5qcijY
         jFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fPIVmQjHILM2UWOANfemmF0RSWM+pYxrIykt/+UUb2U=;
        b=agvDFTRlyFeAdTyUmaNpl19aN97lFPZyuSBgOsUvjO9M4zTp8rZJAWNSHDmEWNtPCH
         eWDdcBo98ec5dGCs/7dD3wc8q9sKPekxgIPsJWyK+dYY9/9+BNITxOhapea7VgpeIZfL
         68lFQwr28Gmk1u1TspbJZ2yo6UI9RFBssAHPibjZECRIg36vBT9BEsGmLLSBet2knN9O
         gVGVECMigiCn5zazv4DYTYuyEx0KHT62uGzeh+TLnI95jMFTnMCStO/uATzach6P1fdZ
         8S0lN5CxIFyhIyEFu5QLcOWyrZWACEvlnsdd3/3l0EjXHVd8ig6lhXoOiaBFVAvchRnI
         St6w==
X-Gm-Message-State: AOAM530xS9hgEnTd2lcIzDk9EQtQFxg8si8NA8Bl0xScqjWHO45dVPZw
        GKxWXZLEey0D27tFB7Xz20525o5MVctJkQ==
X-Google-Smtp-Source: ABdhPJxg+tdVl1vQAOtimf92AV1OtMIPrb1wRKJ/P/2dVA7260L49QtDUny4u4q0nTfSayQrDPzJ4A==
X-Received: by 2002:adf:f192:: with SMTP id h18mr9885647wro.33.1634846282121;
        Thu, 21 Oct 2021 12:58:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40sm388765wms.10.2021.10.21.12.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:58:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] Makefile: be less eager to re-build, *.sh code cleanups
Date:   Thu, 21 Oct 2021 21:57:54 +0200
Message-Id: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the dependency of our built *.sh on $(GIT_VERSION), which
as noted in 2/6 looks to have been the intention back in 2012, but
didn't happen then.

The rest of the series removes more dead code related to our
$(SCRIPT_DEFINES), some of it it not used or needed for 5-15ish years.

Ævar Arnfjörð Bjarmason (6):
  Makefile: move git-SCRIPT-DEFINES adjacent to $(SCRIPT_DEFINES)
  Makefile: remove $(GIT_VERSION) from $(SCRIPT_DEFINES)
  Makefile: remove $(NO_CURL) from $(SCRIPT_DEFINES)
  git-instaweb: unconditionally assume that gitweb is mod_perl capable
  git-sh-setup: remove unused sane_egrep() function
  git-sh-setup: remove "sane_grep", it's not needed anymore

 Makefile                            | 26 ++++++++++----------------
 config.mak.uname                    |  1 -
 configure.ac                        |  8 --------
 contrib/buildsystems/CMakeLists.txt |  1 -
 git-filter-branch.sh                |  2 +-
 git-instaweb.sh                     |  9 +++------
 git-sh-setup.sh                     |  8 --------
 7 files changed, 14 insertions(+), 41 deletions(-)

-- 
2.33.1.1494.g88b39a443e1

