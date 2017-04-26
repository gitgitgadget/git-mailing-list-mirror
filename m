Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EC02207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966069AbdDZTPx (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:15:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34110 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966058AbdDZTPt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:15:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id z129so3786728wmb.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 12:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u+kM6ioVWQciVK5LIWt26AhtU1T/5wAYGNNNFUv4Hq0=;
        b=ZQrchfv/HiZp9s8vTQzZ5iPiQnQ5e3O5dFShfTjjvJ+n3fnq1zmRWZulftF5AJ5mw2
         ukuLwo+OzWNB6hJkdTO1uidT5i4eFpFn9q3wBRRBi1acVpDSUCv2D0THCQj4wNPwc/gT
         AsFtk9PZrduo4PrfTeE+lmNKvfEgorhdNaKejLsWkOYdjWbkXCjoBh0FMjV5iNNZAfjE
         NrK8UlJkt3UDyuRxXXheQ4B4TJPfPFP3R/GoPGZvqyERx7htm80raK2Wl+5qw81Srx5X
         B/uv1Cz1RRjm+hXpD9fINIvw5hqxT0OnwkvkrR78blOcCN4ydrSB+AS+/g1bC9E71QWn
         DWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u+kM6ioVWQciVK5LIWt26AhtU1T/5wAYGNNNFUv4Hq0=;
        b=orMEH40G60zt/N915bovGO0/MrrlRY/W/YrVhIOYtPI6e8XJu2cMiQwUx7QavRoEce
         gvexuLk5DmJgO0KxcHb7U/Ca54SZ8CUGl44ZsbYwW802vl9Nxi//wuy3UJs3z9QMtol6
         bTnxnlB9Gkl7UMqUas/JQU+UhAO6PqOnR6IG/8/HKPpEIH9Y5Kl+ryNIXGYyeymz2n2g
         7F55gR/W6XNFjK2WvsrC0b/Q838/zB+hfs+XhpAnuTf4Z8wwXVAaK0TPWQjlc/spFP0Q
         I2uWnQ5r2f4iwMhvDTI2TSwsod+XgQ6ON6OaFaPx7tp8/HuWuE1wgNFR87IHe6HrsyC8
         t3vQ==
X-Gm-Message-State: AN3rC/7iH5xOWRdn11efciQUy30xV6P3Ra59Tu/aKTMruZOGfbv9mV8i
        7V1LQ63zSKXc9A==
X-Received: by 10.80.137.215 with SMTP id h23mr2119694edh.32.1493234148497;
        Wed, 26 Apr 2017 12:15:48 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id n40sm275426edd.12.2017.04.26.12.15.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 12:15:47 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, gitster@pobox.com
Subject: [PATCH v2 1/4] travis-ci: build documentation with AsciiDoc and Asciidoctor
Date:   Wed, 26 Apr 2017 21:15:42 +0200
Message-Id: <20170426191545.27552-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170426191545.27552-1-larsxschneider@gmail.com>
References: <20170426191545.27552-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ec3366e introduced a knob to enable the use of Asciidoctor in addition
to AsciiDoc. Build the documentation on TravisCI with this knob to
reduce the likeliness of breaking Asciidoctor support in the future.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml              |  2 +-
 ci/test-documentation.sh | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 591cc57b80..c26f3bf789 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -69,7 +69,7 @@ matrix:
           - asciidoc
           - xmlto
       before_install:
-      before_script:
+      before_script: gem install asciidoctor
       script: ci/test-documentation.sh
       after_failure:
 
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 579d540d32..bf23b2caea 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -7,8 +7,16 @@ set -e
 
 make check-builtins
 make check-docs
-make doc
 
+# Build docs with AsciiDoc
+make doc
 test -s Documentation/git.html
 test -s Documentation/git.xml
 test -s Documentation/git.1
+grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html
+
+# Build docs with AsciiDoctor
+make clean
+make USE_ASCIIDOCTOR=1 doc
+test -s Documentation/git.html
+grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
-- 
2.12.2

