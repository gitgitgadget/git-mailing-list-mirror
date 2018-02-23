Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65351F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeBWXk0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:40:26 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37190 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeBWXkU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:40:20 -0500
Received: by mail-wr0-f194.google.com with SMTP id z12so15694474wrg.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c2O22oZNqsdz5SYH8tsm/BqUz/deoDouS8hzRvsXMxQ=;
        b=Td0rR8RbQBLO3sXom7QNQHqsEiDGaJETRGfZAH7vjb2u88go/2qH77QYZX6Uvvfcd4
         WP4AIOROh610inIkRSPSnvh2KvUZ1DyUZ1ozrS4sXwQ/y9hsBexSUXfwvX6FIL2pW0nU
         a6LDKjONHd+BHy/cs4Th4fCks7twUMuMi76+i0d8AwHO+RzRpdJ22fKhbVMREvF8T3MF
         OxZbXGsE7XfI0k5Hn5aK96hVrKldDOry0kDkGtWAvwwk2wCYmVprpCiqbQOSHOLXVD/t
         3lcmKPOGaag/JjX+uiJs0yaHbzkMAu+QFTSceCJyNjDEhdEXarBFhX3k2a96LeHI/UMx
         ERUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c2O22oZNqsdz5SYH8tsm/BqUz/deoDouS8hzRvsXMxQ=;
        b=QSOrQl7PuCfJP0w1Wo07Ov+C0ifSqD9yeYH6a2T9equbi4robrPt2Zyq0eXsuZPy2H
         glXTmrDYwk/2UQ/Wm5fJYuSQcX81cOPw/10twXNbJ+ru1wL1YBDvm2gHphohLmf1wTg9
         Am8GRRcmoxXdwkWzSc8mPCALYq5Nb/wneoGLVNpAR2lIOmsZHAs/BYe0HhBlx42EcOm8
         05fnNPYld2O/nALk1+9FNtmlYyyePra/y2HYcSzYSFZgKrz7LRKu9w5DNl3dgqCe2jIE
         U3hn4eJSF6andvAAEAOVajM+Uzl8LyAuSBpQKeOnvxwWsXYu2eTfkYE7riIj2dIbPFPP
         CMqg==
X-Gm-Message-State: APf1xPA4ZlP0NVhP+yYdjTot8GHkgaptxaims1G5kcQmrOjyPvBA9hxE
        CVtQ7ebqRTQ5i3LH8C/Ky6sEsQ==
X-Google-Smtp-Source: AH8x227KmfiJcC0RX2GiKXUcRRZZiP1AGe91+OQZqj4kumpbKdhHlpP1ueYVx2Qin1pPEmgyx2xmWw==
X-Received: by 10.223.129.33 with SMTP id 30mr2829013wrm.91.1519429218723;
        Fri, 23 Feb 2018 15:40:18 -0800 (PST)
Received: from localhost.localdomain (x590e551c.dyn.telefonica.de. [89.14.85.28])
        by smtp.gmail.com with ESMTPSA id c14sm7028939wmh.2.2018.02.23.15.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 15:40:18 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 11/11] travis-ci: run tests with '-x' tracing
Date:   Sat, 24 Feb 2018 00:39:51 +0100
Message-Id: <20180223233951.11154-12-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.400.g911b7cc0da
In-Reply-To: <20180223233951.11154-1-szeder.dev@gmail.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the test suite runs successfully with '-x' tracing even with
/bin/sh, enable it on Travis CI in order to

  - get more information about test failures, and

  - catch constructs breaking '-x' with /bin/sh sneaking into our test
    suite.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 1efee55ef7..109ef280da 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -97,7 +97,7 @@ fi
 export DEVELOPER=1
 export DEFAULT_TEST_TARGET=prove
 export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
-export GIT_TEST_OPTS="--verbose-log"
+export GIT_TEST_OPTS="--verbose-log -x"
 export GIT_TEST_CLONE_2GB=YesPlease
 
 case "$jobname" in
-- 
2.16.2.400.g911b7cc0da

