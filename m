Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7A7C433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 18:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbiBRSlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:41:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbiBRSlH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 13:41:07 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B841E2A0720
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:40:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so9256518wml.0
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=o8fUL6IoW2tclo0KrCYCel5nEgK5TOCquqvY73K1+6w=;
        b=erT0MFgRtxmZyTg/PJEBPcrUA7f4dDTf1lb55DElWzcJMaAyKAj5xGqA7pmFpCL56Z
         nMtT8GIW2SK+GtRKcfR8LwHVwnwjGghmdnKnIccNb4/EufMcV/t/kW++6X/FhDA4L2wF
         KQVFDe4+gIN0qPQrFs+1LBf7wHBjKuDnOVx8fL1FNmRcp+ebxzkXNx/QPbOv12M3qcSQ
         +vPniOWqqdcXq28xi7rFd/4TZ/uv29BAS+liBW4rNbcxEdChLz291c2cSnOuQGutuy6d
         RinUc0MTnWms8h4g69B7j6pLmPqdqAnDR34YwbF5FR4nUNTTcPy6K5ThEPw5Ph0Cc5Q8
         uX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=o8fUL6IoW2tclo0KrCYCel5nEgK5TOCquqvY73K1+6w=;
        b=Xo1a8Uxzi3AYq93d35v1BMwXvc5pRfnxoGfzIUrobmEyfNX7uprgS5GYWSjLVZzePf
         S0nUx7t4/B/xl39IrGB7uH9PXm0663tsekaOLURPBMUqPZNMlcOxSAJWl4afKUOzXb1j
         LDCJosdCd6gT5xPPK6VkV6FLHzMlvA81Sug8uzcTMckpr/HMXmLxnjPiHYplMnZu637Y
         bV8BMi/mtVhUticeUa8jx8ZUtkLMFAd8ovmlQTo55FMCL1P59PeY+COxmxyUdmEce4de
         CFBzBwSEt2bOEgUEuuh+YBMjTGJeTI4mT7Te5t6fFsq3tXYcrujTiqlQ0ihzwHIWFGpd
         ANPg==
X-Gm-Message-State: AOAM533RvzaIEbXViPWlREdLelMtZ45pm7ZtaQ8iQoHoOVBSh34JWV3Y
        uGDUsOEff1us+iMfhf/ANPAktMczsdY=
X-Google-Smtp-Source: ABdhPJx29anrB0LgkYcbBdIELXV079WhdDBWcBWKDuWUZn+vH0/zcsQ0f+Q06DeFWiSwv//RfnVSLg==
X-Received: by 2002:a1c:4e08:0:b0:37b:ddc5:dca7 with SMTP id g8-20020a1c4e08000000b0037bddc5dca7mr8433873wmh.100.1645209649149;
        Fri, 18 Feb 2022 10:40:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c3b8f00b0037bc64fbd17sm178586wms.11.2022.02.18.10.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:40:48 -0800 (PST)
Message-Id: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Feb 2022 18:40:44 +0000
Subject: [PATCH 0/3] libify reflog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1], there was a discussion around a bug report of stash not recovering
in the middle of the process. It turned out to not be a bug we need to fix.
However, out of that discussion came the idea of libifying reflog. This can
stand alone as a code improvement.

stash.c currently shells out to call reflog to delete reflogs. Libify reflog
delete and call it from both builtin/reflog.c and builtin/stash.c.

This patch has three parts:

 * libify reflog's delete functionality and move some of the helpers into a
   reflog.c library and export them
 * call reflog_delete from builtin/reflog.c
 * call reflog_delete from builtin/stash.c

 1. https://lore.kernel.org/git/220126.86h79qe692.gmgdl@evledraar.gmail.com/

John Cai (3):
  reflog: libify delete reflog function and helpers
  reflog: call reflog_delete from reflog.c
  stash: call reflog_delete from reflog.c

 Makefile         |   1 +
 builtin/reflog.c | 451 +----------------------------------------------
 builtin/stash.c  |  16 +-
 reflog.c         | 432 +++++++++++++++++++++++++++++++++++++++++++++
 reflog.h         |  49 +++++
 5 files changed, 490 insertions(+), 459 deletions(-)
 create mode 100644 reflog.c
 create mode 100644 reflog.h


base-commit: b80121027d1247a0754b3cc46897fee75c050b44
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1218%2Fjohn-cai%2Fjc-libify-reflog-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1218/john-cai/jc-libify-reflog-v1
Pull-Request: https://github.com/git/git/pull/1218
-- 
gitgitgadget
