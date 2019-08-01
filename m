Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA851F731
	for <e@80x24.org>; Thu,  1 Aug 2019 00:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfHAAgY (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 20:36:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36603 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfHAAgX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 20:36:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so57386262wme.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 17:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Ok3ViFL5+5HNYjfHj4lk4Adcg4N9W/nMrp45LUmh9vo=;
        b=In8AX8z93XIqVZq2N3YffsodIAGVmoVoT5JpjGCMiAfSoL6riZUQJmU9x3QMJSX/Sh
         rKIBozK49Bd1yLERTckXnrMPeML5sCH4k3gNcyz0vqgKinkbU3NuhQiNrA1lPLmOS8sa
         zBgzC3yCwM9seav9pf0JXahNYqZrnceGcTsZXREk9tj8FEgAuy7ABTWl/MM60BNdGyKT
         3C36FXUAn6tdNV5QVkK4rpqvpqPQCzDcmhzFNQyewtFMaUvjPXT6aAVJ3Mfx9cjwGk9i
         XDxVl2gks3xQ9vN2cQ1GwPECDCVtnccYD2MA9P9hgq0rZkvRwg7PnOaBv2+U/wZs6Gal
         3zYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ok3ViFL5+5HNYjfHj4lk4Adcg4N9W/nMrp45LUmh9vo=;
        b=WDlcRgXZ/RsrTQKbDOzQdq3TPh6u1Gw1sH+IgbpvDLki7B14vtCVU15Xlkv2r0E74T
         PPwZ6jOqq/T1rZ6FWT0pY/6ea/v6Y9EutISqe9853kRiI/I8eQ/khTCJO49W8R+ckWXs
         estTQw0b8wuntB2R30YTNntpSttvF7iYHhtOnHv3SePz/gr4fOzxxy2Xtty0nGOPACwr
         S9sP0Z6HmavRDKyTdrW5SHEIH2crs2bdefTKF5d8pr3IjS5lzq23ycStFSmk/wla+BT3
         xKMfl0ujfpH+ZEvY+e4pkINnOooE17BVAEb45ixq5ioMZ7cwhWJFegn7kMsuKaqLTrUT
         LV1Q==
X-Gm-Message-State: APjAAAV3wrQTHT0V2gk+n2h/c52YQv/fSCCsX8Awk6RmKpZP6NPYdNcM
        l8X4rwzhiBTWxWUI6OrLYmg2+CJP
X-Google-Smtp-Source: APXvYqx2vEEnOQ+mF0RjfQcvDj9gunsSGIU7b/tOlEK8fl/xjt+VhbpBWuQhG71egGINlE+ZsS2G8Q==
X-Received: by 2002:a05:600c:21d4:: with SMTP id x20mr103688749wmj.61.1564619781929;
        Wed, 31 Jul 2019 17:36:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7sm56124362wrx.65.2019.07.31.17.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 17:36:21 -0700 (PDT)
Date:   Wed, 31 Jul 2019 17:36:21 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Aug 2019 00:36:19 GMT
Message-Id: <pull.301.git.gitgitgadget@gmail.com>
From:   "Philip McGraw via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] git-p4: close temporary file before removing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

python os.remove() throws exceptions on Windows platform when attempting to
remove file while still open.

Add local allocateTempFileName() to clarify that only the name is being
allocated by NamedTemporaryFile(); file and handle are closed (but not
deleted) when leave scope. Subsequent file deletion will succeed since file
was closed.

Also print error details after resulting IOError to make debugging cause of
exception less mysterious when it has nothing to do with "git version recent
enough."

Philip.McGraw (1):
  git-p4: close temporary file before removing

 git-p4.py | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)


base-commit: 026dd738a6e5f1e42ef0f390feacb5ed6acc4ee8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-301%2Fphilip-mcgraw%2Fgit-p4-close-temporary-file-before-remove-v2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-301/philip-mcgraw/git-p4-close-temporary-file-before-remove-v2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/301
-- 
gitgitgadget
