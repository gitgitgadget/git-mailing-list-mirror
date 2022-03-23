Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E56C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 06:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbiCWGev (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 02:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbiCWGeu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 02:34:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504734B873
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 23:33:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w8so635580pll.10
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 23:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9bSLfyM/s0aCWLB3L3RWu5jNJykDFslGVphN4I9dfkw=;
        b=cXlkV9yEkSqpVptcARGtAzP9DKR6oqbVB1jMArw8NGcPak1JYq8RJj1XN8hCITHMDJ
         ISB+bmS/bMawnrV/GNpdvqxh8kcE/SMQ/aNVjQMPrrMni00RUvPc4EIIDSfpNNJo39Is
         ls2QU+EHs3UNFhkncwMOaAMbPi2GWZQnkgPy5+P5mXAjADHuId9z+vU0dVgwV4HWwwnm
         sOlDsMxTK+KcXguFUB30VcwBob9inccrgKiiCWlzt7roezQXeEk/BkJ6YtS9gyoymoO1
         CtYuQZfeQpKQ0pKx7gDExFs0hZ0MXrmxjzaQlzDlCnSCbikbesggEo5PFZk4swcgnUq2
         suqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9bSLfyM/s0aCWLB3L3RWu5jNJykDFslGVphN4I9dfkw=;
        b=zMVlDEhbYtGbVfzNWJgLYK35kNG32/TFcUaXI5JGaKoQUGUebzp9YF5d2I2qCH0nCl
         lCymTwNYBTCgO/wuQRuWb6Ep0A81Tvy1o6fIkYRiGXVF7DBJKi2d/ptQA/yhYFRwyoxg
         m9r9hMOeI+41j6XLosGzcH8zMb8pyJl0Hlho6frz62iIf03XsIIXJlHzMeG/yZT5ye4L
         l7Z4n08n4rf/SLG03HIRM50qSHh/JvAyuCAjCC2lV65ZjcdPgWViHiMs/17OMM7e5UbX
         PVsP0E+08gz50/nwsBBjyvwvf82pMrqI3pQ0+9AmpeHWFC0EvMtXPjTROsO9/IeuzJpu
         6aPw==
X-Gm-Message-State: AOAM5325S4Tqfc+5n0hHk+pTg7dsUwMwE/xXUshaB0cUHQbGzouzWcv7
        QWgMF2Gz/yg1TfudYKn+7FE=
X-Google-Smtp-Source: ABdhPJwysBPDgvSmk+Wgwb2TJ0MErtqZiV8NCJZCPUPBixp2czHp6xN9IUHfqToz8zyP23ecz624/Q==
X-Received: by 2002:a17:90b:4c8e:b0:1c6:8dfb:3cb6 with SMTP id my14-20020a17090b4c8e00b001c68dfb3cb6mr9731608pjb.72.1648017199628;
        Tue, 22 Mar 2022 23:33:19 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id k6-20020a056a00134600b004faba67f9d4sm5192512pfu.197.2022.03.22.23.33.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Mar 2022 23:33:19 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [RFC PATCH 0/1] invalid outdated temporary files
Date:   Wed, 23 Mar 2022 14:33:12 +0800
Message-Id: <cover.1648007488.git.hanxin.hx@alibaba-inc.com>
X-Mailer: git-send-email 2.35.1.55.gde4365fc52.agit.6.5.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

When I use git on network storage, there may be some temporary files left in
git repositories due to the program quitting unexpectedly, and they also
prevent me from continuing to use the git command line until I manually
delete them.

For some obviously expired temporary files, manual deletion is an extra
expensive job, and one that I think can be avoided. So I wrote this patch.
When creating a temporary file with the same name, if the mtime of the target
file exceeds one day, unlink it first, and then try to recreate it.

Han Xin (1):
  tempfile: invalid outdated temporary files

 Documentation/config/core.txt |  6 ++++++
 cache.h                       |  1 +
 config.c                      |  5 +++++
 environment.c                 |  1 +
 t/t3210-pack-refs.sh          | 10 ++++++++++
 tempfile.c                    | 21 +++++++++++++++++++++
 6 files changed, 44 insertions(+)

-- 
2.35.1.55.gde4365fc52.agit.6.5.7

