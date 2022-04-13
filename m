Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22505C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 15:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiDMPe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiDMPe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 11:34:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B5437A2B
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:32:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so221248wms.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5WelDWdS0YCxvO3xHTz/Y/PzKz07eKfx9uPNixS+Nt0=;
        b=oKPam1RcG2NH99l3aI4Hh1tORTjN66BfKLFD1xSimSkxT1V9IPsXJX6m6WxZ7SluHn
         2a1XIE7/1pKNASgyA1i2rUqMJ/LmK8d0iXswKQb97qfheExDrGAggAWY344iYeTLgasG
         dwVrwBNcfu0Ox8oXSRsJIwfDs6vEdkFoVb/aM6fqBqmuB3Javl61vbP2WYrCj7FCP84R
         wDeiHaYBJZ0XDZmCTYcxl+38mDPynfPbEDQtnmg9glcSadRfztEqMkiYXdfFHZhkBiiz
         AbgJMTZZuANKeqET2NmaxiYeuBc6SlZ1e0jVXOKO5+DqzFBNXSsSFYvW1xIW5WOXAajg
         LbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5WelDWdS0YCxvO3xHTz/Y/PzKz07eKfx9uPNixS+Nt0=;
        b=Q3PDOJHdhXe5xl97k5rLCjaU/XzmdcvznWfY0USsZNejx4+ChGBO0v9+lTfxbVmR59
         Grd6WyiBI9YR7mlBpMAbsXV9mfW4x5BjOjL9h+XQiedWOSkGGZufnNEhv8FRIx6bfA+E
         eDxnvOgmYL3rpucCFaMMrRZbJuoJz87YHCvL6QisctUFmGoWWMhMK/Enf/XAPDIeMUJO
         ZI/LUWRTGHV7nt41pV09SVA3mzsns0rn898cHt9LnWGcFRiZ1rAEivyyJp2u8oHcMqpN
         pPzDYXZ9YRHAO9iNJ6OUNcu94z7oIcUHxUvdLmbtYVrmjeJVen6hjlqIummnmelwylff
         B5Bw==
X-Gm-Message-State: AOAM532zW6bHi9YjEAKVp7ngSOfcFHAhgmYygvJIf6goVmyW+KNd6SgM
        UYZwXPxInfcWt8zjdy9WSfmTzB9GCDA=
X-Google-Smtp-Source: ABdhPJy+S6RI9x6dJzNbcRNtStdO2X//4rQZUmhda5Aw1oC5TVQUkZR99PWtuy+cOGbRRAENVisHAQ==
X-Received: by 2002:a05:600c:4f49:b0:38e:d622:de14 with SMTP id m9-20020a05600c4f4900b0038ed622de14mr3265313wmq.178.1649863953318;
        Wed, 13 Apr 2022 08:32:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a056000144f00b002079acb2349sm13711858wrx.1.2022.04.13.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:32:32 -0700 (PDT)
Message-Id: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Apr 2022 15:32:28 +0000
Subject: [PATCH 0/3] Updates to the safe.directory config option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a very fast response to the security release yesterday.

The second patch here is an adaptation from a contributor who created a pull
request against git/git [1]. I augmented the patch with a test (the test
infrastructure is added in patch 1).

The third patch is a change to the safe.directory config option to include a
possible "*" value to completely opt-out of the check. This will be
particularly helpful for cases where users run Git commands within a
container. This container workflow always runs as a different user than the
host, but also the container does not have access to the host's system or
global config files. It's also helpful for users who don't want to set the
config for a large number of shared repositories [2].

Thanks, -Stolee

[1] https://github.com/git/git/pull/1235 [2]
https://github.com/git-for-windows/git/issues/3787 [3]
https://github.com/desktop/desktop/issues/14336

Derrick Stolee (2):
  t0033: add tests for safe.directory
  setup: opt-out of check with safe.directory=*

Matheus Valadares (1):
  setup: fix safe.directory key not being checked

 Documentation/config/safe.txt |  7 +++++
 setup.c                       | 12 ++++++---
 t/t0033-safe-directory.sh     | 49 +++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 3 deletions(-)
 create mode 100755 t/t0033-safe-directory.sh


base-commit: 11cfe552610386954886543f5de87dcc49ad5735
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1215%2Fderrickstolee%2Fsafe-directories-star-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1215/derrickstolee/safe-directories-star-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1215
-- 
gitgitgadget
