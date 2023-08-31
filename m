Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E60C83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245185AbjHaGPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjHaGPi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:15:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E661E0
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:15:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31ad9155414so267470f8f.3
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693462534; x=1694067334; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WnV4930Mlnb8nRtj/B9aSUtfUl1xGgJ91IU//vKyOEg=;
        b=OHxl135nNn5swWzHXxoB3H9O6zo91fcLOxc+v5X4EUWBm3IB63F/MzJpjehBtVbXWG
         DHNtkP0XpdYvdTLViUmTZFcTJfK2b2GOkopU8hVISIbhWN8V/RfY+LYQMv1StjuZ56xc
         CxqGCHD4LmWgCW0yPyys+FoDhTQkEOiZ3aIev47ekO+iUzEdWlio+l2EFvUyOGcANfBo
         8WF12eB3PLEyYytjx/0n6bii1Zhd0ER+F+173SV7YIlIWbYBaG6zliX1KAtvfqQ43nw5
         kLj9OUzZYUE93sgtWyel0W79vKOcB+AwoWe1H18nxO0k9RDEp7uVV2Wo2Gaaf/JkfvAc
         /wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693462534; x=1694067334;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnV4930Mlnb8nRtj/B9aSUtfUl1xGgJ91IU//vKyOEg=;
        b=WgavSncDNcUnQbCfTS/Wx3TuzShhhZ7KNTCAmEE9lIpcdJBy7KPro8NrDtu49sERYn
         GnG3lT9HbqfIo7vq+Ci8RNpmJXopMf/MAwhRKi2KHlxeZV6FH5azUVLjasb3u3CPYTMj
         09XlBQtLYij0Uy0ec3wEdl25bYWdoJVyN0gbg6IPAID/SO6t+wvM8Guuv+hbZK6uaDgH
         PG330jM117Ic0bhsN4K2SHKrIWadZYahEXB8xfXKM/pjLOgZpQmvYSgFeULrdI5C9cq+
         +4QqHKk4CNmLywjIyx9j1Q3K6O4hJ6EdIuddsHQpxioiwKlGF+gFvBHKIuxt2+lXWjC3
         3X/w==
X-Gm-Message-State: AOJu0YwncXUUIpgjj6AtA1XjAqeAJ66brHb+d3vAfcctiBQ/hzaTjExQ
        lWXkDQ0KslUuYVOF4s3PuzE/nQ0lBsk=
X-Google-Smtp-Source: AGHT+IE5HiSBxf7d0Jrf2gSPtZH5r2GuhAQpX2KtudCF4qAJ2dHepeQv9MwOz1MZJPjpUyNgDhF0Rw==
X-Received: by 2002:a5d:6b81:0:b0:314:3ad6:2327 with SMTP id n1-20020a5d6b81000000b003143ad62327mr3057789wrx.12.1693462534057;
        Wed, 30 Aug 2023 23:15:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17-20020adff191000000b003180fdf5589sm1013352wro.6.2023.08.30.23.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 23:15:33 -0700 (PDT)
Message-ID: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Aug 2023 06:15:28 +0000
Subject: [PATCH 0/4] CMake(Visual C) support for js/doc-unit-tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent patch series that adds proper unit testing to Git requires a
couple of add-on patches to make it work with the CMake build on Windows
(Visual C). This patch series aims to provide that support.

This patch series is based on js/doc-unit-tests.

Johannes Schindelin (4):
  cmake: also build unit tests
  unit-tests: do not mistake `.pdb` files for being executable
  unit-tests: do show relative file paths
  artifacts-tar: when including `.dll` files, don't forget the
    unit-tests

 Makefile                            |  2 +-
 contrib/buildsystems/CMakeLists.txt | 18 +++++++++++
 t/Makefile                          |  2 +-
 t/unit-tests/test-lib.c             | 48 ++++++++++++++++++++++++++---
 4 files changed, 64 insertions(+), 6 deletions(-)


base-commit: 03f9bc407975bba86d1d1807519d76e1693ff66f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1579%2Fdscho%2Fdoc-unit-tests-and-cmake-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1579/dscho/doc-unit-tests-and-cmake-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1579
-- 
gitgitgadget
