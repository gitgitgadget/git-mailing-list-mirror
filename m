Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A56F1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 16:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbdL0Qgd (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 11:36:33 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45171 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdL0Qgb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 11:36:31 -0500
Received: by mail-wm0-f68.google.com with SMTP id 9so40211713wme.4
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 08:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txflTBn3uktIGcxn9vRaR+HIP9TUW0RSyiZBSo7Vwh8=;
        b=kdsk97MaxFtgyGy062NZ/3/exZR9oJKHxsNOaAWoHag7pGnP7wNWlrfIdt2dZY/GUu
         5j8MkJlCHWPmGby8uqk5N/IfRu3T5ubAtAs2RI9UeOviZAKxyyCF85HDGv8QiigiPHYX
         AiKaFeMLp5Q/3kAWR2G6MLejrjj4BOO50iray+oCxZny9lEZmAKKzOGwEk4GpvrskuwH
         N4LASZtAyDd2+QHLKhDZ6Qr6bEgRUdpwXhpt7bsJaxIADXXd1jYf4xHmwJDT2npmHnXQ
         k2wEkn/kZ5CveMjOvxlbKoU9BFCaOHBlpWEjsokmGewS1Lxwjq1etoCh6opzY3SKh7tt
         SY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=txflTBn3uktIGcxn9vRaR+HIP9TUW0RSyiZBSo7Vwh8=;
        b=bxTyXKBjenwmjOGlBWPRcWSEkHFjCUn1YqghgR8CQ7dz3ZGiDz5DFVAb8Szxh1j9ne
         /8tpx66dfdLL8/rxqFYwETKQaMl0Wd4irg92VV8KSTP5lyT7bmpnDqN0BNWHqgo2n86w
         0+5dieQVQl5xms9gcqCR6e9qD1KjqCtp6kfId8qJVeA005L1m8i9vr6F9OAQHRyGl9j+
         QNI5wAeFS0OKu9SgeYKFObiBIrrlX1TX2CGou8+5SfTkA6v91zMrZdehiyhjGqVLI1oC
         ahKcTVlmWA2tmxz03hz+XWTWYnQDI5fHwCHibowIbpykMVdJqRmEUTbUi443MmGq4d8B
         zSUA==
X-Gm-Message-State: AKGB3mKyzB8t/OCHWs3OBO/fEHeIaFsKJwBiBNzb4UWrpcNlBKXBNUXi
        3fUwaZiNXS0MF+OIcFodrtmFbA==
X-Google-Smtp-Source: ACJfBosT3Nk+cL2hqEm84hXPZQR3DkbJDHniJ8vgF4OMpdswd2J3dJG+vNvNYgK1Z716w/kc3XQ7yQ==
X-Received: by 10.28.109.139 with SMTP id b11mr22789663wmi.85.1514392590625;
        Wed, 27 Dec 2017 08:36:30 -0800 (PST)
Received: from localhost.localdomain (62-165-236-58.pool.digikabel.hu. [62.165.236.58])
        by smtp.gmail.com with ESMTPSA id l1sm8400557wmh.13.2017.12.27.08.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Dec 2017 08:36:30 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 3/4] travis-ci: save prove state for the 32 bit Linux build
Date:   Wed, 27 Dec 2017 17:36:02 +0100
Message-Id: <20171227163603.13313-4-szeder.dev@gmail.com>
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

This change follows suit of 6272ed319 (travis-ci: run previously
failed tests first, then slowest to fastest, 2016-01-26), which did
this for the Linux and OSX build jobs.  Travis CI build jobs run the
tests parallel, which is sligtly faster when tests are run in slowest
to fastest order, shortening the overall runtime of this build job by
about a minute / 10%.

Note, that the 32 bit Linux build job runs the tests suite in a Docker
container and we have to share the Travis CI cache directory with the
container as a second volume.  Otherwise we couldn't use a symlink
pointing to the prove state file in the cache directory, because
that's outside of the directory hierarchy accessible from within the
container.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-linux32-build.sh  | 1 +
 ci/run-linux32-docker.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index a8518eddf..c19c50c1c 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -27,6 +27,7 @@ test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER) &&
 # Build and test
 linux32 --32bit i386 su -m -l $CI_USER -c '
     cd /usr/src/git &&
+    ln -s /tmp/travis-cache/.prove t/.prove &&
     make --jobs=2 &&
     make --quiet test
 '
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 0edf63acf..3a8b2ba42 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -19,5 +19,6 @@ docker run \
 	--env GIT_TEST_OPTS \
 	--env GIT_TEST_CLONE_2GB \
 	--volume "${PWD}:/usr/src/git" \
+	--volume "${HOME}/travis-cache:/tmp/travis-cache" \
 	daald/ubuntu32:xenial \
 	/usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
-- 
2.15.1.500.g54ea76cc4

