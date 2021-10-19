Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC205C433FE
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D460561183
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJSXXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhJSXXm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:23:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D811EC061749
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y74-20020a1c7d4d000000b00322f53b9bbfso6277003wmc.3
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QkZyUfssWfQRqYPef0YK56m6opUNzDnl5f4nD5ey0xI=;
        b=fOxQXfEChGVjibxJJe9pRL8jQWWI1Sb0GAoTp5k2QbYSuovkKPt1OL9k2PQf9mLZZX
         9EkZ5nd/bQmlI7dRMNEPCuCZnrN+7hAv6+3huUXRFl2PPdXOz/cefDPfvTo89xhbi9Gd
         L/CEUX/kdtgRn6alj9M+IMJ3nDvToD6P8rECgoD7Ou2Duuvi/MEaQNN8eD9K7im9wmu/
         qhst0S8QbaGAmtJ6sJtAETbbipLBQJQbKoiF8rpugGz2VC7kApLbD35TTaVHlbj28nss
         HarAH6B7QqvMXH7aaDmyENXT+nL1XlSega2cDBcNg9yuxUYVnl75AVeBAEXsNnkU1Utg
         G49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkZyUfssWfQRqYPef0YK56m6opUNzDnl5f4nD5ey0xI=;
        b=r1uNEkOtm3GdK8+PjoUglifDAa+D8cCUuiKxQZFLT03HiHLlgUaEOiBCR3xH1ovlZC
         8mVYFHfcJ02QAEVM9bXlTpb5WexwTgDAk7XA3/81Z7V1OmiHp4fFczTRHofFimfum4e9
         gzY36xN8agQjhFlgdewqSrC08Rscmrvmouh+zaOAQPkXk55/DSrRZ/R8CljAJ+ujJqWQ
         Bi2TQlPIAUPbDTN0N8tsc849Mnod9nK/kVLRkcfkmNRwU1rtj77Zf2Mit/FrAK9WIC4V
         CemhVicXdOtRMcbNmdWO1zIU1MnQkFy9UgbNbu0VDGXEjlX5HV6+mJdA3pgBWUSE7OVt
         UFFw==
X-Gm-Message-State: AOAM5300/EtVa1c493qA9PgILYLWNpbZmiIopa4ExpnfczNHbwhwgN78
        BjApV21Ziw8Yk84pr0cx9Bg1PbtbvRAzgA==
X-Google-Smtp-Source: ABdhPJwMuH5QArdGmCKbgPt/QVUrGBc2RSDBouLAIsk4UpHKCCMV+RUnRs11NTFIf62jPr7WTX3QAA==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr47232832wrp.143.1634685687206;
        Tue, 19 Oct 2021 16:21:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g25sm304644wrc.88.2021.10.19.16.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:21:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/13] gc: use hook library for pre-auto-gc hook
Date:   Wed, 20 Oct 2021 01:20:40 +0200
Message-Id: <patch-v3-02.13-42cc4d2c3c6-20211019T231647Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the pre-auto-gc hook away from run-command.h to and over to the
new hook.h library.

To do this introduce a simple run_hooks_oneshot() wrapper, we'll be
using it extensively for these simple cases of wanting to run a single
hook under a given name, and having it free the memory we allocate for
us.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c |  3 ++-
 hook.c       | 20 ++++++++++++++++++++
 hook.h       | 13 +++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6b3de3dd514..95939e77f53 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "object-store.h"
 #include "exec-cmd.h"
+#include "hook.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -394,7 +395,7 @@ static int need_to_gc(void)
 	else
 		return 0;
 
-	if (run_hook_le(NULL, "pre-auto-gc", NULL))
+	if (run_hooks_oneshot("pre-auto-gc", NULL))
 		return 0;
 	return 1;
 }
diff --git a/hook.c b/hook.c
index 20a1a4fec33..9951015dc66 100644
--- a/hook.c
+++ b/hook.c
@@ -131,3 +131,23 @@ int run_hooks(const char *hook_name, const char *hook_path,
 
 	return cb_data.rc;
 }
+
+int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
+{
+	const char *hook_path;
+	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
+	int ret = 0;
+
+	if (!options)
+		options = &hook_opt_scratch;
+
+	hook_path = find_hook(hook_name);
+	if (!hook_path)
+		goto cleanup;
+
+	ret = run_hooks(hook_name, hook_path, options);
+cleanup:
+	run_hooks_opt_clear(options);
+
+	return ret;
+}
diff --git a/hook.h b/hook.h
index a9317c3f95e..9e4d10df63e 100644
--- a/hook.h
+++ b/hook.h
@@ -44,7 +44,20 @@ void run_hooks_opt_clear(struct run_hooks_opt *o);
 /**
  * Takes an already resolved hook found via find_hook() and runs
  * it. Does not call run_hooks_opt_clear() for you.
+ *
+ * See run_hooks_oneshot() for the simpler one-shot API.
  */
 int run_hooks(const char *hookname, const char *hook_path,
 	      struct run_hooks_opt *options);
+
+/**
+ * Calls find_hook() on your "hook_name" and runs the hooks (if any)
+ * with run_hooks().
+ *
+ * If "options" is provided calls run_hooks_opt_clear() on it for
+ * you. If "options" is NULL the default options from
+ * RUN_HOOKS_OPT_INIT will be used.
+ */
+int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options);
+
 #endif
-- 
2.33.1.1338.g20da966911a

