Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786841F404
	for <e@80x24.org>; Wed, 27 Dec 2017 16:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbdL0Qga (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 11:36:30 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33132 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdL0Qg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 11:36:29 -0500
Received: by mail-wm0-f66.google.com with SMTP id g130so40152207wme.0
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 08:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHSwjW02oGmQW9XYBwdnqDzxYCgv4nzhve6wRuOSK9c=;
        b=tm3MAcTL2vUfGF57Q4Brs4uxir02Xv6nqCgDc8nK1BCVVzT8Qgj212Xe4JhU/AS1kX
         ROvAUASLS1zmK8KRmMBcQvVNkyZMb2IZ9EHsKkbostBV2SUMp/ItpjCplhqHeHmHJpND
         v158nN4LdjlEDXJcoTEdPmpk8l7CxXAXvHCIP5elb7qEoAEfC4cwjjSXQFH0psIpMzuv
         LAQr83n3u5gh2y3uO4FF+uf2CCNvPXIAIC/TQBtTTqoQViVga+b5JFZpdS/MKtkuyjSV
         6Y9W2SoNbhhAKED9NH5paYbPiht6HmknU9+G6tRu95h02zlje7NA67kyWq43oWkz0Cef
         CUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHSwjW02oGmQW9XYBwdnqDzxYCgv4nzhve6wRuOSK9c=;
        b=tFsNjXwDlzK2TSnYivyfcwXKhfxQysGsOfGoaRZ7DTtThqE6sV+QYNS3veKKAKSrBt
         brQcZsFAyZu8Ij0CK9PmjUsAAENiXvH/cLnnQqCnNcbRh6dSEaXkxi5wLqHC4Tuh2dN8
         5QLCc1FYN0CqCaIVDPQboGI2uP34RgvbFI9HEtH6Y7Wk8goiWvnFnDVrjiJ61HUHrPYJ
         OyrPNdaYKs23eMH8ipJ65pEGLEo17pXzopEnwqX6hlQeuyNvb1XqZh8UbTPsj0f/B6Dr
         GCLNFzmNDwDD6OypmPcUn6k25S1eTGGuESf2ZIHnyqIoFAxgr6G2qUusi1ZItEIT8LXn
         /b1A==
X-Gm-Message-State: AKGB3mI58r8vkrT1+5TZUoTdcaZQbdCVCdX8iRI7X6IJJqjRdo8lIJaK
        6s2oQdhJdWvfcUHPpHVMkeo=
X-Google-Smtp-Source: ACJfBovqZPBxbZcF3eq3hIdjxBr89OvFLKZUR/bFrI8Xku3czKcOGk7nYfTQ3d1llqwlHmKo1foNtw==
X-Received: by 10.28.181.209 with SMTP id e200mr23175444wmf.68.1514392588219;
        Wed, 27 Dec 2017 08:36:28 -0800 (PST)
Received: from localhost.localdomain (62-165-236-58.pool.digikabel.hu. [62.165.236.58])
        by smtp.gmail.com with ESMTPSA id l1sm8400557wmh.13.2017.12.27.08.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Dec 2017 08:36:27 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 2/4] travis-ci: don't install default addon packages for the 32 bit Linux build
Date:   Wed, 27 Dec 2017 17:36:01 +0100
Message-Id: <20171227163603.13313-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.500.g54ea76cc4
In-Reply-To: <20171227163603.13313-1-szeder.dev@gmail.com>
References: <20171216125418.10743-1-szeder.dev@gmail.com>
 <20171227163603.13313-1-szeder.dev@gmail.com>
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
2.15.1.500.g54ea76cc4

