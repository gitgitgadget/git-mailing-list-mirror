Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2208BC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0477460F23
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbhJLNdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbhJLNdD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:33:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A791CC061745
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g8so81215018edt.7
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=azapiTOO/bu5iHFIX+c8E6p12RQzoBrZPHSKEVG+ifg=;
        b=Z4UoxxqLWXhI+NfnZHnS4q+D/w1AW8mqM5nXOgGiceZ14r3kLOYF2d9jjiXyu9gLtF
         wJtRLyMx3bh5Tje2lX0+qrZ5p/hrdb6WSb9hrLZ03zc45ar1sX9UL/sKDJBWs/EE3Asv
         ju1jc/9VVXe+5HMYyYvscvjzkwEBcptQyrwYpPwlJD1maphfCC9YCCPY5iQxBvFIlO4g
         nYDLokd+9Ri9b5Pc3vwQUbUg429n7IU4V/ob6n+eboNYqCNP4yz8RYfierW9mRFfjXj9
         Z7SA4uLlcgIAxx2y+lzxbSbLcnRQ+to/ZD3wx4yWA/OWHeDEBlbyZ1W7pMBXy0QHl6rN
         EAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azapiTOO/bu5iHFIX+c8E6p12RQzoBrZPHSKEVG+ifg=;
        b=vaBB7+faJZVp+NRZnKOb3uLNwGAcdfnP538AO9w45Po7n/8SIwnoxxFz+qqVXq/u8W
         o+n/fMtkibr1YkDPFbQZZSdLgIpEieLU+O87DV49Zg1JDT7hV6zUdGYkLFc4y3zPx5LX
         DFx+eMlZmhwU6wp81dZ6tgCJEFWxPHnUOdxDwtryXX7E1zfEXg4uvCP9sKpfa0tFsTU/
         lvCzW3ndn71pFDqPWfOa7FfgAaPQdSwT0cPQnw99XAcDF8LeDBV4JyN71ex+Fr8bPhAz
         Q8ffv1NWl8cPozxPAKo2RTlrdiVt8hg2opTmQVVbZv+B4o5zagtXWEc0csBEsBrQxmL1
         qNSQ==
X-Gm-Message-State: AOAM533AInUmcjmbOspPtqetfQyHjLxBVDOYXevgLQRO3lgSONBfydQU
        6YEVCgBfBEVFovjyCTSmuF5kCXBbmjrc5Q==
X-Google-Smtp-Source: ABdhPJwAiotxBvWO3veQIkUB1GWeBqEpXEcTV5WDgI9ouiazXFW/sCyG6A/XfOLBzla+vDQYBidK5w==
X-Received: by 2002:a50:d84e:: with SMTP id v14mr50298879edj.85.1634045452740;
        Tue, 12 Oct 2021 06:30:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:30:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/13] gc: use hook library for pre-auto-gc hook
Date:   Tue, 12 Oct 2021 15:30:27 +0200
Message-Id: <patch-02.13-dbac4204f7b-20211012T131934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
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
index 240270db64e..bfdc79e2f1a 100644
--- a/hook.c
+++ b/hook.c
@@ -141,3 +141,23 @@ int run_hooks(const char *hook_name, const char *hook_path,
 
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
index 111c5cf9296..a2b8d4fc6bd 100644
--- a/hook.h
+++ b/hook.h
@@ -49,7 +49,20 @@ void run_hooks_opt_clear(struct run_hooks_opt *o);
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
2.33.0.1567.g7b23ce7ed9e

