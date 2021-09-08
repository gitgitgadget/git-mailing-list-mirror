Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9D3C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E218E60555
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346925AbhIHBo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346841AbhIHBo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:44:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0617EC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:43:49 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t18so816386wrb.0
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Ml+DxmMjPRRmiIxVKwhQgQKJob1LUsMkf8hcXY1YWlA=;
        b=bPhQeiRI/U2DCyz1z7x/gyjAnaQusQkoeTvBenDSj6trWTxVo9LpcF29/HMou/8ZXm
         siUB9I3gf/6UBfMEp31ne3pRsjF7CEAbkWDOWFvSJjSIzSmrbyXWAU9zxKL78n9NpSvN
         6Y+NrtO1VOFoUbDZ3nDhFOf9j/z0mBUMnzZG7fdCEfkxioDZRAiTfyv4HtIYF3uWLb2N
         dg92KrNf38I1inJ9noZRmKUeq9i95cdBU02bDNwPsrvrXgu8msxgS2CjfW8sm4J1G9Q1
         3jh1IqyeXSFdO4JD5TSam1ZQ0Ob+K9l8O1i4fHHd77mtu3GEbCuZzRFJf1quW44vAh+m
         1vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ml+DxmMjPRRmiIxVKwhQgQKJob1LUsMkf8hcXY1YWlA=;
        b=Hy/XE7tsa2fgwaiVLE2VBUirbdLczZv+c+rxzyXyogfB/V2kC/g01ZtVa+o8QTyY1N
         50NOC4dXZAM/olBspDEJpKRgCOOoWOswM8ccaECWWA03wwJ2MYZwFBzxNnQNUsC8ndZX
         aHRXxSKLza3NPBgbqsHu06JnVUfbrHOirYUjVfXZs2xy3tb1BZR1fbb5S87YZHzU4AsZ
         Sa0a199JZZpHPeCyFF+Itu1RTKfPOpzza+UJTRhMtHzhvySpKz0ewBqF6sd4R+ivdcER
         +gd/htM7iXsWhp8YrOpopxMYAh6C6h0VoNP/qkxY9366gVQp7FeCmOxDq2Sg5jyoN0CN
         Dyyg==
X-Gm-Message-State: AOAM530q+x5Fo4Onxe7vBXC/jkBSTkpXSzBQyR8Uzz454RWmftChzRUw
        0Z+HzOz6JefGv+iTdrjGb8NjlO11kU0=
X-Google-Smtp-Source: ABdhPJwYwCXVtekE9z3S1u4lhNstAEEOIsfaFDtsHt4AG/1/T/ty5WEfgUo5udrD2f/jvG31DVajpQ==
X-Received: by 2002:a5d:6486:: with SMTP id o6mr1061016wri.193.1631065427683;
        Tue, 07 Sep 2021 18:43:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 19sm599239wmo.39.2021.09.07.18.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:43:47 -0700 (PDT)
Message-Id: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 01:43:43 +0000
Subject: [PATCH 0/3] Fix D/F issues in stash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a few D/F issues in the stash command. These were some
issues I found while working on unintentional removal of untracked
files/directories and the current working directory, and I'm just submitting
them separately.

Elijah Newren (3):
  t3903: document a pair of directory/file bugs
  stash: avoid feeding directories to update-index
  stash: restore untracked files AFTER restoring tracked files

 builtin/stash.c  | 15 ++++++++++++---
 t/t3903-stash.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 3 deletions(-)


base-commit: e0a2f5cbc585657e757385ad918f167f519cfb96
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1086%2Fnewren%2Fstash-df-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1086/newren/stash-df-fixes-v1
Pull-Request: https://github.com/git/git/pull/1086
-- 
gitgitgadget
