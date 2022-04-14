Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F12C433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 02:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbiDNC1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 22:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiDNC1n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 22:27:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFB440E7D
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 19:25:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c64so4590674edf.11
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 19:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+K+d+09fQgmKSh6N2piHmC/2GvGbRmQsIy0AGy9osG0=;
        b=ZCNT5fhXIUOwH1X/m+tQeSdceY0y6kySQIOqdeD43A8T67WHiHb/TNIKHHvHJr3d0/
         IUln4j4LrCHfSCu92a9SmI7TafpUUEBvAmA5qDGJh2+SM+Y+KnWwPW1qZzPvUiwC53LE
         00n+XVCely8+l7pE6vke6/lj9Ikuxdiw3W4hIa8aeKTgdZzpKu3jBU8Pz+vZ3b0lSb0n
         IIc0Y2fXZ9sL5Lh62BLWJprKv+x+4X5q+KsHIs0gI945cSCZ8zKAyxShf3FAqe6TLS1x
         5LKr1J+fwYupIrM8EGvfCbYX8P5dq2Et6yDM5plK48POgHHlCf2QeiMFSeh0HihBPEth
         nMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+K+d+09fQgmKSh6N2piHmC/2GvGbRmQsIy0AGy9osG0=;
        b=6+7qvoswiPYYfX9W9rAdSA++Ie24tcd34zfXgVrSeloWbeU0FQchFm1PCScfOZHsd/
         SeCbvuPDSUKbJOVMvwcHm8EQesH2aTgB7XI/QOSIu7PrZs2+Xin14k92S8mgMSupTDId
         CIojAy/L8hQCQ9VkH4hzFki1h0D7Uamv3/SdRnD40p1WNdqFufQWKyA5EcrVk3ukaKk+
         4AmI1S4t8XtKN2CATB34H6fXsz0JNrGmZ89YEcB7ZF3vAcQQPyAllU0FE5m4yScXZzO2
         AN9qjMF3pOh8bNwgK1Yor6n/k4UAmAPZgvsK1YcgQUxTqNLAWxt7XHbxw8Gfab3e6gcn
         31oQ==
X-Gm-Message-State: AOAM5306GRL7bBUNU10Yr8GSyP7/NZm+mxl3DoLTh6Wc1FSvfR9O2mHf
        qW6qkNCVZOqjYEavvENvzy/+blxUu4s=
X-Google-Smtp-Source: ABdhPJxn3t0GAjslQycHX8lBQUIgAiu1WLhzl9bC7OPWPhtfqICDgLCJGUBVyj/mblhYdvGprzea3g==
X-Received: by 2002:a05:6402:3548:b0:419:6a02:c5cd with SMTP id f8-20020a056402354800b004196a02c5cdmr598997edd.290.1649903118465;
        Wed, 13 Apr 2022 19:25:18 -0700 (PDT)
Received: from fedora35.example.com ([151.27.151.62])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906604a00b006e07c76f3d7sm183898ejj.210.2022.04.13.19.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 19:25:17 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v3] Makefile: add a prerequisite to the coverage-report target
Date:   Thu, 14 Apr 2022 02:25:13 +0000
Message-Id: <20220414022513.31465-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Directly invoking make coverage-report as a target results in an error because
its prerequisites are missing,

This patch adds the compile-test prerequisite, which is run only once each time
the compile-report target is invoked. In practice, the developer may decide to
review the coverage-report results without necessarily rerunning for this
coverage-test, if it has already been run.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is the third revision of the patch. Compared to the second:

- deleted the Makefile coverage-test.file variable, replaced directly by the
  coverage-test.made file
- added in coverage-compile as last command the touch of coverage-test.made, so
  that even if coverage-test is run first, invoking indirectly it by the first coverage-report does not
  call coverage-test and so the test suite gain.

 Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f8bccfab5e..d6ae228c74 100644
--- a/Makefile
+++ b/Makefile
@@ -3407,6 +3407,7 @@ coverage-clean-results:
 	$(RM) coverage-untested-functions
 	$(RM) -r cover_db/
 	$(RM) -r cover_db_html/
+	$(RM) coverage-test.made
 
 coverage-clean: coverage-clean-results
 	$(RM) $(addsuffix *.gcno,$(object_dirs))
@@ -3421,13 +3422,18 @@ coverage-compile:
 coverage-test: coverage-clean-results coverage-compile
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
 		DEFAULT_TEST_TARGET=test -j1 test
+	touch coverage-test.made
+
+coverage-test.made:
+	@make coverage-test
+	touch coverage-test.made
 
 coverage-prove: coverage-clean-results coverage-compile
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
 		DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="$(GIT_PROVE_OPTS) -j1" \
 		-j1 test
 
-coverage-report:
+coverage-report: coverage-test.made
 	$(QUIET_GCOV)for dir in $(object_dirs); do \
 		$(GCOV) $(GCOVFLAGS) --object-directory=$$dir $$dir*.c || exit; \
 	done
-- 
2.35.1

