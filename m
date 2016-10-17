Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B5FE2098B
	for <e@80x24.org>; Mon, 17 Oct 2016 00:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756519AbcJQA0E (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 20:26:04 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35990 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756171AbcJQA0C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 20:26:02 -0400
Received: by mail-pa0-f67.google.com with SMTP id os4so4493506pac.3
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 17:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fs9PlhXrJgEaZ07Fjuuj5K+QMAfd4xxTWaEKUnbK6AI=;
        b=RjRPirIMu2QDcfm/gJk2VHWRMf/ayLnwNfGpglevXZ9y2U4PpU+3OJI2LjmfTwHUUv
         AswqNU/eRlxnexPs9ckDLdLd2J8POshJ3gPQ5Y8xHHHhPxWeoQNBmOvE5oeRo532ozFe
         0HIU98GoLDCsliUx09Szde15Px+vM2QNoKl0rkleSs2H5ZG7g3CT1kxLsPVbtLYIsgTx
         JKh9LrQunvchAbiWQcrDBo3er+QH8Q8Hg1pqHRdMuHFMtZvURQ0X8oaYhiBXkD7Z2wJf
         5duh6U66rVC+SfuLj93DCAcTNOtO0TvpdKUKqX3S1eiyTiOIKpIp3K8sDvzOm8EJoRME
         CvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fs9PlhXrJgEaZ07Fjuuj5K+QMAfd4xxTWaEKUnbK6AI=;
        b=gn24PoZkO3KC3h4R9dYZ6iuUXqJ+qh6aib/MgbTUYxJzfKQrMqepdwAb0yb8/Ucdfj
         Xlcaj2OBUo0ykv7iGITcBUUlSiFPR27Ppq/2NbXegxk38ytz69nS3b16ZWZskkGuk7GT
         pHYfWuxIdnJHMm2jcssZLGUcM27PVy7nLZQ/iddcPEr0N30Nco25scb9WBAYW1TXhPjH
         LeAy5GQOUPA3UC59rzPm0RjsTKzSTfx58HSZipaVSidqVGDEmAl2O4Qdf5UKwmBfGTh0
         tgwFVAud7fgkoaZDNOU954JWClUMEwnlYCng/4CneP4f9Bg/4502Mt+9UNTA4y+c0/m5
         gnlQ==
X-Gm-Message-State: AA6/9RmogG8ottX15jrVG/jNWPWcKpar7/5q2iQQEndsB99H/O8+ikWNbHKgF8XIhHSg3Q==
X-Received: by 10.66.190.201 with SMTP id gs9mr28762080pac.42.1476663961032;
        Sun, 16 Oct 2016 17:26:01 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id 3sm42882343pfo.31.2016.10.16.17.25.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 17:26:00 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     tboegi@web.de, gitster@pobox.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
Date:   Sun, 16 Oct 2016 17:25:50 -0700
Message-Id: <20161017002550.88782-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161017002550.88782-1-larsxschneider@gmail.com>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

TravisCI changed their default macOS image from 10.10 to 10.11 [1].
Unfortunately the HTTPD tests do not run out of the box using the
pre-installed Apache web server anymore. Therefore we enable these
tests only for Linux and disable them for macOS.

[1] https://blog.travis-ci.com/2016-10-04-osx-73-default-image-live/

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 37a1e1f..d752447 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -32,7 +32,6 @@ env:
     - DEFAULT_TEST_TARGET=prove
     - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
     - GIT_TEST_OPTS="--verbose --tee"
-    - GIT_TEST_HTTPD=true
     - GIT_TEST_CLONE_2GB=YesPlease
     # t9810 occasionally fails on Travis CI OS X
     # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
@@ -57,6 +56,8 @@ before_install:
   - >
     case "${TRAVIS_OS_NAME:-linux}" in
     linux)
+      export GIT_TEST_HTTPD=YesPlease
+
       mkdir --parents custom/p4
       pushd custom/p4
         wget --quiet http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION/bin.linux26x86_64/p4d
-- 
2.10.0

