Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CACC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbhKWLtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbhKWLtn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:43 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F93C061714
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:35 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 137so14928642wma.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XClPV9UvuYLHNhiCToui77MfusE8z4zix1BfHfSjHQ4=;
        b=hvhovHVTPUgV9zEecE1wL4i7IYnsfy1yzeo0lzZFwxIqDT6Loz2bjsrRlP3dB+yDNw
         MxAmmimB5EV4iyd30RakExzJLBZnfVWQLPV2ii/uFj25QRBb88pWWPgUjt9mCwJgtx/6
         MVMmovZNIJxSQQZYFuXW4jCYzFwbW1z3RRVq+te4Gb6+lqBGYlM4RLjPikaftr1PIiMW
         0ht25IpJ0wn6vtAZTFGVvHwAN1LxBajBDCJvGHilo3DiwB6kfa0jwqjqFkAwn4ncZIs7
         iS/Ll+Ribl0xsMNggURpldmk9DP3Dw73wpqqbjYtfl4DH85YZ6RUxKrwcPIs34vkX1qC
         goSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XClPV9UvuYLHNhiCToui77MfusE8z4zix1BfHfSjHQ4=;
        b=br6YFDDQhL1chDIiF6f/kMtHoqlbxD+J1j/LM+2W6/PqC305CPLGLG7CzbBkOY8EVb
         X3tyaEDeIUyLb/mQG8VgVK5x/RANHYf21tEywzQ6/CBBlIanTw5fp+tn8uaXKtWffOzq
         x8xKs9HDdP+kERdjATvzwWbsMb1aI4p9Rk7UljOQTCiLX9FBk+TRJdZOVkIngrfrpiKK
         IgF/aM09slg8cF0WjAtlOCEnqJuOeG7Wogoow9YpV3cgmVtWgNQ0nt3jj7m6ld0W3CKJ
         vL6t3eXXRq3Uvok0OwbAxAtUl+qXbvrRp+/8VP29lvtQBAc7Flm5hRka/Kq/WFNnh3Zr
         q+NA==
X-Gm-Message-State: AOAM531pFL8rsWiUUFMh3qhgdhAAXS7NcrGHfjFsl4Why43Al071FTCX
        FDzSOPN0ZMkJLXARUfgSxrn2raKdVbSkhw==
X-Google-Smtp-Source: ABdhPJwwXEF//lqWXUvRmj7thB34Zy+yxGzha03NAsFjg1vdB3oxRlke+hW9JqquJ15QnZ4z7uES7Q==
X-Received: by 2002:a05:600c:1549:: with SMTP id f9mr2317661wmg.118.1637667994007;
        Tue, 23 Nov 2021 03:46:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 15/17] read-cache: convert post-index-change to use hook.h
Date:   Tue, 23 Nov 2021 12:46:14 +0100
Message-Id: <patch-v5-15.17-6fd47c4c499-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the post-index-change hook away from run-command.h to and over to
the new hook.h library.

This removes the last direct user of "run_hook_ve()" outside of
run-command.c ("run_hook_le()" still uses it). So we can make the
function static now. A subsequent commit will remove this code
entirely when "run_hook_le()" itself goes away.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c  | 3 ++-
 run-command.c | 2 +-
 run-command.h | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f3986596623..4352661549f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -28,6 +28,7 @@
 #include "sparse-index.h"
 #include "csum-file.h"
 #include "promisor-remote.h"
+#include "hook.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -3129,7 +3130,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	else
 		ret = close_lock_file_gently(lock);
 
-	run_hook_le(NULL, "post-index-change",
+	run_hooks_l("post-index-change",
 			istate->updated_workdir ? "1" : "0",
 			istate->updated_skipworktree ? "1" : "0", NULL);
 	istate->updated_workdir = 0;
diff --git a/run-command.c b/run-command.c
index f40df01c772..d7d64701ede 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1323,7 +1323,7 @@ int async_with_fork(void)
 #endif
 }
 
-int run_hook_ve(const char *const *env, const char *name, va_list args)
+static int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
 	struct child_process hook = CHILD_PROCESS_INIT;
 	const char *p;
diff --git a/run-command.h b/run-command.h
index 49878262584..3fa7454cf8a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -239,7 +239,6 @@ int run_command(struct child_process *);
  */
 LAST_ARG_MUST_BE_NULL
 int run_hook_le(const char *const *env, const char *name, ...);
-int run_hook_ve(const char *const *env, const char *name, va_list args);
 
 /*
  * Trigger an auto-gc
-- 
2.34.0.831.gd33babec0d1

