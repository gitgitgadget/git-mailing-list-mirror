Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C890DC433EF
	for <git@archiver.kernel.org>; Sat,  9 Apr 2022 03:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiDIDyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 23:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiDIDyF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 23:54:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3DB339FD8
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 20:51:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h16so6750674wmd.0
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 20:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sNuvm1cgsqTMHoI6F+iEz2tiwzLnODUVPZvNC53miJ4=;
        b=OtZ8KN1q6nYHf7W6d6q01UcYxnwsyIcFf6uUY8qIXqn0SmFGBEZB373K7esAuHwZuj
         lUk0joy/wiyFVts6yNbg85sRQm2JTTAH2Hl8vdPpDlnNPBfH53cxdwnrZ3qoB09Ewttp
         wgwl6c0/C/bIwjSFlix/riJfvAT6ypbd7n9MBoFOzJX/pUn8d+Dip3DuoiWeWB/c6wXH
         DdGIIPRTx3fwUMgDxpvov1YVXeHL0+GdRvUF8RdE9sjQNr+FVwSxhh3pwtvG2NaH/IEP
         MKfYfch35C0r72rAl4KMRDoGZKHvFOylwsXpwKsrfbcb2ApgTW/XLxioZhUAaj/Hbl2P
         a3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sNuvm1cgsqTMHoI6F+iEz2tiwzLnODUVPZvNC53miJ4=;
        b=EIszZbgnbIYtvPQlSpXKs7tyBTGdWbtiyUboZTM0CmN6Ro0nFa/O6lUp0PJ0CXn7o+
         0QbOV5w6IwG+KK21NqNxMncYROQATLS7O5rAP5y0s0XWjTWCV9zJ9U2xW8yiRJNUu9fS
         5Y/arYCvPT9ZHyQjhpIm4Qww9VLw4kC/FQHRSJnhLsb/eVteg5n7Y6RqIRwZLySCRR1y
         aL4FtDjsYqGsoAZgVOEX2AuYqn7PdVk0R1rBHC3+h3JaOjXWfNAwWFxkvvgTl6poVMCz
         nFBqzL8P64yXrQsSgbUVkuKj8fOg09ZxIVW8RG1PZI8Fophtwd30RLzhXTLI5SHBVjtz
         hWTA==
X-Gm-Message-State: AOAM531b9m8BKTelOEMndBOc9gZ/L3PuNqPpsXtxIqraTadohsYdB0tC
        +Krbjf/BhOWexAbkGFoNWCM=
X-Google-Smtp-Source: ABdhPJzdCn8ViPDXrYZGW/dZ3AQCKe8W8j2UDAydZyaXJcX3j0FjXzyLB+lAPSCMEh8EbfKitMN6Nw==
X-Received: by 2002:a1c:7519:0:b0:38e:6bc6:ec7f with SMTP id o25-20020a1c7519000000b0038e6bc6ec7fmr19604706wmc.53.1649476318057;
        Fri, 08 Apr 2022 20:51:58 -0700 (PDT)
Received: from fedora35.example.com ([151.24.233.140])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm11634984wmq.46.2022.04.08.20.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 20:51:57 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitter.spiros@gmail.com
Subject: [PATCH v2 1/1] Makefile: add a prerequisite to the coverage-report target
Date:   Sat,  9 Apr 2022 03:51:45 +0000
Message-Id: <20220409035145.1256570-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqpmlrl4j2.fsf@gitster.g>
References: <xmqqpmlrl4j2.fsf@gitster.g>
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
This is the second version of the patch.

With respect to the first version, we tried to eliminate the inefficient
coverage-test invocation if the target is coverage-report, introducing a more
useful invocation order

 Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e8aba291d7..eacdffd748 100644
--- a/Makefile
+++ b/Makefile
@@ -3378,6 +3378,8 @@ check-builtins::
 .PHONY: coverage-untested-functions cover_db cover_db_html
 .PHONY: coverage-clean-results
 
+coverage-test.file?=coverage-test.file
+
 coverage:
 	$(MAKE) coverage-test
 	$(MAKE) coverage-untested-functions
@@ -3389,6 +3391,7 @@ coverage-clean-results:
 	$(RM) coverage-untested-functions
 	$(RM) -r cover_db/
 	$(RM) -r cover_db_html/
+	$(RM) -f $(coverage-test.file)
 
 coverage-clean: coverage-clean-results
 	$(RM) $(addsuffix *.gcno,$(object_dirs))
@@ -3404,12 +3407,16 @@ coverage-test: coverage-clean-results coverage-compile
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
 		DEFAULT_TEST_TARGET=test -j1 test
 
+$(coverage-test.file):
+	@make coverage-test
+	touch $(coverage-test.file)
+
 coverage-prove: coverage-clean-results coverage-compile
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
 		DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="$(GIT_PROVE_OPTS) -j1" \
 		-j1 test
 
-coverage-report:
+coverage-report: $(coverage-test.file)
 	$(QUIET_GCOV)for dir in $(object_dirs); do \
 		$(GCOV) $(GCOVFLAGS) --object-directory=$$dir $$dir*.c || exit; \
 	done
-- 
2.35.1

