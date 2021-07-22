Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3558AC6377A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 01:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFF861263
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 01:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhGVAqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 20:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhGVAqi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 20:46:38 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC26C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 18:27:14 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 8-20020a3704080000b02903b914d9e335so2951695qke.17
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 18:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LLvu2s/f72TrXPcz6t9Qh1FmpNV0+vZy6aEo6LyAWqI=;
        b=OtPo1xcCezVuTf67pPmcJGOzb+X8PrwsCkRbAeHa2cWGmOSkI2hs7jrV8cjOBVR+q9
         EFFnc0sJM39jiFSK3weWiRaTfyqwmHY3fq7T8MtASJu7ESuCSeiK03Lu/tRAKTUrVfjB
         V7HyTi/LrUm+kjHIVIGeXAU4BRh0mAMPE3wcV9yWY3UFbZlI2hd8uhSGy092yjPe7LBn
         zPIIjx5T3mkjRBMpObQ/aoXnhCNG58oEER3zj0yw7IKdmMRzzarfBq6R/ZChGgrbwQeJ
         mqbSLQkX9YV1RaluDeDabv3w/UePfjgX+W7+i42ySO8O0D+KsU2ojlRl+Vy2qQtMgTY6
         DyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LLvu2s/f72TrXPcz6t9Qh1FmpNV0+vZy6aEo6LyAWqI=;
        b=ob1jnHxJX4DTZt9rELGszuklpJOMLdMXF1svatXpAi18+9oGk6jenW+qMKA8Z+eqyo
         hPWrAlFkcmK7pTryAt1ekRJlZ7NTV814llkXjwb8Fwotn3ieP2eK1/5rFU09J8tXsObU
         bAzxDa2BIp3OQNGnKYlEb7iMjyFmvdr2lRTzBosZeRTVrq4zXpZ2jH/AbBkedfAAJ7FU
         dYEJvg6dLL72GvHtKzAniKE9XVnjvEORAyrVFDG28RN/3LIa67yUsIX/H9r2HtDeeeO9
         xNUHMKZVG69DslUP+vrZDcbAV6D1/Gfbe4lK8iJOKLkD23SpWwMdIFnQEboDlw7vmUVH
         TxNg==
X-Gm-Message-State: AOAM531J05H95Y3gNzkFO2ViEB51NwGUrvJETRBiBbbdTHfYzXoSQ0H6
        N9nLzLKcqWbuAVb10/YvYeWTIieex/kEIRA+zpRL+iZkUccFdypOqojZmhch3RDpMBfTldpCfgw
        ic9CDa4Tj3N/MwIBcgrGD4F5SmoRyDkdMv4Wnhrg4XeWfX2PQWvTR/1r6dh2Su+hal4KmOJCa6w
        ==
X-Google-Smtp-Source: ABdhPJyNHPbwNAynB63Ww3O2jM5Etbtur0MxLrLM6oJxgin92+26FVy0CuhB5oxqkeWh1lwpCVfvc8quVGL+6TfBwDc=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:83f3:cefc:ff34:3095])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:10c8:: with SMTP id
 r8mr38942345qvs.28.1626917233122; Wed, 21 Jul 2021 18:27:13 -0700 (PDT)
Date:   Wed, 21 Jul 2021 18:27:06 -0700
In-Reply-To: <20210722012707.205776-1-emilyshaffer@google.com>
Message-Id: <20210722012707.205776-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210722012707.205776-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v6 1/2] tr2: make process info collection platform-generic
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To pave the way for non-Windows platforms to define
trace2_collect_process_info(), reorganize the stub-or-definition schema
to something which doesn't directly reference Windows.

Platforms which want to collect parent process information in the
future should:

 1. Add an implementation to compat/ (e.g. compat/somearch/procinfo.c)
 2. Add that object to COMPAT_OBJS to config.mak.uname
    (e.g. COMPAT_OBJS += compat/somearch/procinfo.o)
 3. Define HAVE_PLATFORM_PROCINFO in config.mak.uname

In the Windows case, this definition lives in
compat/win32/trace2_win32_process_info.c, which is already conditionally
added to COMPAT_OBJS; so let's add HAVE_PLATFORM_PROCINFO to hint to the
build that compat/stub/procinfo.c should not be used.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile               |  4 ++++
 compat/stub/procinfo.c | 11 +++++++++++
 config.mak.uname       |  1 +
 trace2.h               |  6 ------
 4 files changed, 16 insertions(+), 6 deletions(-)
 create mode 100644 compat/stub/procinfo.c

diff --git a/Makefile b/Makefile
index 93664d6714..bd76689c79 100644
--- a/Makefile
+++ b/Makefile
@@ -1889,6 +1889,10 @@ ifneq ($(PROCFS_EXECUTABLE_PATH),)
 	BASIC_CFLAGS += '-DPROCFS_EXECUTABLE_PATH="$(procfs_executable_path_SQ)"'
 endif
 
+ifndef HAVE_PLATFORM_PROCINFO
+	COMPAT_OBJS += compat/stub/procinfo.o
+endif
+
 ifdef HAVE_NS_GET_EXECUTABLE_PATH
 	BASIC_CFLAGS += -DHAVE_NS_GET_EXECUTABLE_PATH
 endif
diff --git a/compat/stub/procinfo.c b/compat/stub/procinfo.c
new file mode 100644
index 0000000000..12c0a23c9e
--- /dev/null
+++ b/compat/stub/procinfo.c
@@ -0,0 +1,11 @@
+#include "git-compat-util.h"
+
+#include "trace2.h"
+
+/*
+ * Stub. See sample implementations in compat/linux/procinfo.c and
+ * compat/win32/trace2_win32_process_info.c.
+ */
+void trace2_collect_process_info(enum trace2_process_info_reason reason)
+{
+}
diff --git a/config.mak.uname b/config.mak.uname
index cb443b4e02..185ff79b14 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -612,6 +612,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	ETAGS_TARGET = ETAGS
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
+	HAVE_PLATFORM_PROCINFO = YesPlease
 	BASIC_LDFLAGS += -municode
 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
diff --git a/trace2.h b/trace2.h
index ede18c2e06..0d990db817 100644
--- a/trace2.h
+++ b/trace2.h
@@ -492,13 +492,7 @@ enum trace2_process_info_reason {
 	TRACE2_PROCESS_INFO_EXIT,
 };
 
-#if defined(GIT_WINDOWS_NATIVE)
 void trace2_collect_process_info(enum trace2_process_info_reason reason);
-#else
-#define trace2_collect_process_info(reason) \
-	do {                                \
-	} while (0)
-#endif
 
 const char *trace2_session_id(void);
 
-- 
2.32.0.402.g57bb445576-goog

