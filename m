Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86478C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6D061251
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhJUUAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhJUUAV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 16:00:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B82BC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:04 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j205so50188wmj.3
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PTerwBoOMyvE6PWHsCUv1F71NFEMg8doanmTpdDNI8=;
        b=T5DStPqG9RGWcD0G3QyeMsB6rbfrer36DHvWyagG3KO95B3ibIezPFp24lakPJeBiv
         eWpQHq3UqcFoyrFZw+YcTDC8aftzJCXmqEmvpSbmOYEontgA3abmbFmzVq5ZzgIAYN+c
         5QpjsTph7QmSCyQCs5uYsdcG2sE7ACehcq9PTzIKqQtW95zKum7AxRBkcn98OdkXTxU5
         qsVX51CK3GWzoVP/fwVsZG9U/KD09dto9i9cQhskWfIXXnwE9UG/Ya07IWb0MF8gAEjk
         KyAxmKpZCx2lW3OmLlkZs9EbxEXdR+gnF4Qx/BBDI0/6b6zeMeoCyJhNTCzRfonO8Uvn
         j3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PTerwBoOMyvE6PWHsCUv1F71NFEMg8doanmTpdDNI8=;
        b=CLz3zgwFiz6ZlYOUkIpN3qwV3ON2cNhdGBieSEwYxGxWl7H9QwvYxZnMJfnlwUGNmh
         PPCqjEAtQlhWCY7vnO/Hz8MXtzxQnZ7M5gYC4vvGvRCa+LT0og+LHbpqtcsArcStv7pn
         FFYCcUU7XMB0Y+UQcYVezZtgqkkJnKekcF+EHMC9Ue+mpzPqjEwPCFWzQxyLl1zo7IPv
         5Oew134g90mDVeHERYjETnZjN0/pvbexzcJp0bXoZgM+Or6o0W/eBuD+2dUvoA/iFdRM
         ySl2T4PxpFNLdciyZmLsGe5A3XwQvofw1Mo65zt56J4jTvKwLY35iiO6kR5bWHVzi9Gd
         pksg==
X-Gm-Message-State: AOAM532efR8i9x1Zcm7e+MkTF8jlutwAeUk/MZwIg+hiqpd9hR9QTLLK
        bccBLMC6fxl9qEM1GXlPmHmoPHo4erDX/g==
X-Google-Smtp-Source: ABdhPJx23NvHBhohgIiLTjlQw4Tyybs5D+0zBUqIG1w/CH8d1mEv642nxgVI2JdLpWLk5CBzJfgqUg==
X-Received: by 2002:a05:600c:358b:: with SMTP id p11mr9048560wmq.88.1634846282853;
        Thu, 21 Oct 2021 12:58:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40sm388765wms.10.2021.10.21.12.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:58:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] Makefile: move git-SCRIPT-DEFINES adjacent to $(SCRIPT_DEFINES)
Date:   Thu, 21 Oct 2021 21:57:55 +0200
Message-Id: <patch-1.6-2a7b5de44a8-20211021T195538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "GIT-SCRIPT-DEFINES" was added in e4dd89ab984 (Makefile: update
scripts when build-time parameters change, 2012-06-20) the rules for
generating the scripts themselves were moved further away from the
"cmd_munge_script" added in 46bac904581 (Do not install shell
libraries executable, 2010-01-31).

Let's move these around so that the variables and defines needed by
given targets immediately precede them. This is not needed for any
subsequent changes to work, but makes the code consistent with how
GIT-PERL-DEFINES is structured.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 381bed2c1d2..f52402b24d8 100644
--- a/Makefile
+++ b/Makefile
@@ -2256,6 +2256,13 @@ SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
 	$(perllibdir_SQ)
+GIT-SCRIPT-DEFINES: FORCE
+	@FLAGS='$(SCRIPT_DEFINES)'; \
+	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
+		echo >&2 "    * new script parameters"; \
+		echo "$$FLAGS" >$@; \
+            fi
+
 define cmd_munge_script
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
@@ -2271,14 +2278,6 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     $@.sh >$@+
 endef
 
-GIT-SCRIPT-DEFINES: FORCE
-	@FLAGS='$(SCRIPT_DEFINES)'; \
-	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
-		echo >&2 "    * new script parameters"; \
-		echo "$$FLAGS" >$@; \
-            fi
-
-
 $(SCRIPT_SH_GEN) : % : %.sh GIT-SCRIPT-DEFINES
 	$(QUIET_GEN)$(cmd_munge_script) && \
 	chmod +x $@+ && \
-- 
2.33.1.1494.g88b39a443e1

