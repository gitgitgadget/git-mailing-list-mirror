Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110D8C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 17:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8C761A48
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 17:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCZRFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 13:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCZRF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 13:05:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB62C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 10:05:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x13so6308769wrs.9
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6a0LWYZrPVMBOiXcl24qmQoIQcc/dhN/H/d4nMQg3ik=;
        b=ACo2BmHcdjx/ThkGdLxEGxEUAOITN5aY/mAQvjFtPGVhekhv61iphemXKSRBBrXWV8
         cjieTKt4by+J8f7UIJohblU2YvdUJmsSxW7/EaXauyO720UGY+LrV3gOPyhPAymA1ZjR
         jvWv7rTd/MGLex8e5kZ9D3B6EnSfal++P8nHA7XtlKXEG82qQv+3fpUqROWdOIsQ4drO
         JWWdwwKlc/pAnkn4uJtdlwHxz7kzncivjXAGV0bpUf1CuCnIPl9xrWrrCQaxDqWE9UvQ
         cc7te+ON9YSCmRK3ofKBGWIBnwWvZGbLBLEULYJhC+ux/XeDGk9Dq6Fn/QHxsLF09bkM
         t7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6a0LWYZrPVMBOiXcl24qmQoIQcc/dhN/H/d4nMQg3ik=;
        b=ibnQbL9hHV1NMAVr9dlpOmVBNg27gXl2F9j03NDeUxteUwYrxgjZCiYTX07LQ2u2Ww
         r6cp3aM9Wa4xiKdXupgzAKWAO1RFqoVWwDJFMPmWc7dPDtMGy/Kq7/xMj5+1JBjmZI47
         l9CW5oQdjVTOXvkXVlqFnulrtl0e/bn7s6+H2F/rXtWiflnFzB0k6Pph6gNDgARS8ps2
         JZl94ZaKGvuA4XHWHNCvM8UhPrCa2J63F1IGs2pVzEnAU7CsgchSLlWGtXt0cdsW1hkY
         1qZib44T4ngQnB/2HhrRm2oMcZ6Rwe8biDZrUaoTVeEv2e+gusdgDGQ5dzLEZqk+fLaZ
         8VZA==
X-Gm-Message-State: AOAM532JB39rUjkkK0p/vqMvV2xS1+Cq+3uO2A5G2WwJvXlIxwFCB3Pz
        dmAVZi4rxmbCrLB/0vAVP93Qw7U/PWH3r3ho3ag=
X-Google-Smtp-Source: ABdhPJzOL03wdNWqhZUs+TsBsL3DXiDCJj/pPhmPmsvn4gfFXG+W8/LJmJNHdCM/KlT6XU0c5DegNQ==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr15658316wrd.132.1616778325056;
        Fri, 26 Mar 2021 10:05:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id n6sm13982958wrt.1.2021.03.26.10.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 10:05:24 -0700 (PDT)
From:   "=?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?=" 
        <stdedos@gmail.com>
X-Google-Original-From: =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= <stdedos+git@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= 
        <stdedos+git@gmail.com>, gitster@pobox.com,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [PATCH v1 0/1] ci: facilitate dev to mimic a CI environment
Date:   Fri, 26 Mar 2021 19:05:04 +0200
Message-Id: <20210326170505.7771-1-stdedos+git@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>

While trying to mimic a CI environment (to be able to
locally run tests in isolation), I didn't find enough
instructions how to do so - even though the project has CI set up.

Attempt to bridge the gap, by providing a starting/discussion point.

Stavros Ntentos (1):
  ci: facilitate dev to mimic a CI environment

 .../setup-local-dev-environment-docker.sh     | 43 +++++++++++++++++++
 ci/setup-local-dev-environment-docker.sh      |  1 +
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/howto/setup-local-dev-environment-docker.sh
 create mode 120000 ci/setup-local-dev-environment-docker.sh

--
2.31.0

