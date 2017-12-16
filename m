Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BED01F406
	for <e@80x24.org>; Sat, 16 Dec 2017 12:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756809AbdLPM5z (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 07:57:55 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:44069 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756320AbdLPM5y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 07:57:54 -0500
Received: by mail-wm0-f67.google.com with SMTP id t8so21893435wmc.3
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 04:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sv5mdyux1llliATX/fbmNJ6EI1IuUqW+bTjO8UjlFNk=;
        b=lc2GNg5/tFvMk2CynYCK0hNXGOg/XUn/1w8h0/6oiUN+CYooanA6EGvpxFseeg6lw/
         mogRE3qsqTUcKnIxz6DLZLhZTp6YnuG1lsXFJehByQcghAbWFYI/BO3ZxzJfX8dQ1D2S
         b4ecjXaiyfxNMStVnRALAVlEDw+BFQTSEJSVCjFrNC+3cxJq2j1nb/aiOFVRoM2X5Xe6
         HLyovJSOg8oYD9uVJ3nS34yKViGnkYs+aRSvyrqos3ER+QH/hvzre1Hzc4rwBCQlHlSZ
         P1Ae+gq0dfMYbWfoiC2aJ+93yjocV3oNNGqIMaULkbuzhlnKaAo/x5UhK3nuDwAUoXQL
         5POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sv5mdyux1llliATX/fbmNJ6EI1IuUqW+bTjO8UjlFNk=;
        b=sTAraxuiFz1mt98HrnFdz7qscZg0Cnbq0+miaLhnCOfllRw/PPdIUmkksOuUtoBT/H
         z37T4NAEOnCv0ouv6HealPEhkPA+qtr+HAK7hAG+1B6mSjqKoe6fB8jq2ebkKL+4pRk3
         dRQ0LjNEXUWGaoXuBoiHWko1h+NAvxGgdXGs+Z3BnROv5D7+/33PsZHfHaljc/bWPRjI
         7L4voTNsui4Pl2LV06vpL4k2uWDhKB+PTUXXlIoYJTeoneaB9zrbGk4ehZqcsI1ZMa96
         3jiyeePqVgSe2uCj+/B+2ltrrLHAXan/E/hM8WlL2UyKpJi3UVVzCDqxfnlNfoYHtNET
         rhvg==
X-Gm-Message-State: AKGB3mIuO8V0OQL2u0I+bvm61iisGlBT3bgEfl4ouX451l92DJRXj3Rf
        fnz5k2ed26iiU8z8OSACZ3c=
X-Google-Smtp-Source: ACJfBotlR7N5BSEaLUFcczCFrJWfSRW3IAgSbOF2l7srmkb+Xavs69CvU7ulc3LT8Azlq4pjm8ioUQ==
X-Received: by 10.28.184.209 with SMTP id i200mr7626486wmf.96.1513429073579;
        Sat, 16 Dec 2017 04:57:53 -0800 (PST)
Received: from localhost.localdomain (x590e5997.dyn.telefonica.de. [89.14.89.151])
        by smtp.gmail.com with ESMTPSA id 187sm16265182wmu.19.2017.12.16.04.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Dec 2017 04:57:53 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 5/8] travis-ci: don't install default addon packages for the 32 bit Linux build
Date:   Sat, 16 Dec 2017 13:57:50 +0100
Message-Id: <20171216125750.11048-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.429.ga000dd9c7
In-Reply-To: <20171216125418.10743-2-szeder.dev@gmail.com>
References: <20171216125418.10743-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 32 bit Linux build job compiles Git and runs the test suite in a
Docker container, while the additional packages (apache2, git-svn,
language-pack-is) are installed on the host, therefore don't have
any effect and are unnecessary.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 7c9aa0557..4684b3f4f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -42,6 +42,7 @@ matrix:
     - env: jobname=Linux32
       os: linux
       compiler:
+      addons:
       services:
         - docker
       before_install:
-- 
2.15.1.429.ga000dd9c7

