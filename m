Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300ECC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbjELHFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbjELHEr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:04:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAF08A56
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3063b5f32aaso6207607f8f.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875084; x=1686467084;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBdU8QJhKCk1B/G4eOQLm2KmxA0Lmdg83Sx6v70jfHg=;
        b=EFhKeJqpqfvA2j5cnc5eI3TGZuU0OCnknJTunzMHyrzwrupA/HIXVjXLN3iBMwNwuu
         QUqn7rgpuXdaGkc/3TH/Klcyu7zwD3xPRoOgeFwsIj/s7O8awcScbxnQyJSl2cUSn5BU
         CYeZAAbhyG6RI3OeibNAdGZIL5npBJssjaIZ7Lybed7eK5QURdCq39/hNv6gyAWiQKsI
         rgKSHS7nKDxFA1rY1JK/tNSGOj2FcEJ15qO/vBTq6RT1cy1P8Cg3AooGezPbWOuIDXGX
         MHwK2/6Jrp/7WSymMuK0KCKn8pKXZgKCqjY7cZmAHXL0C8Yvl1TnNK+uB0kfz9SmXdU2
         8vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875084; x=1686467084;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBdU8QJhKCk1B/G4eOQLm2KmxA0Lmdg83Sx6v70jfHg=;
        b=O3nHsk0N4PBc7TXCH/bgIoY3N7kUOgM2PCgLSq6tOpfxS4dYB2fyvwk/Ht5SwtVMO0
         izHGskvnN+kaib1IFTdMBcrUqiuPqLCKqBdGExYEP/uAxV4/QA25VYxNt9hpr2CfqgSU
         4i9stQ+y9duVGZX9KThQkLbbwiQsrAxQhALF7pme93igdCmTQ4u1CUjuXIf3qFdrAKhz
         dOrxOZOhd9LV1VsrVP5eg1PWezj34yz+gcdfy2YZycnFKIaTiCAllGIpZ2Ew9oFakIGH
         OiFChesbBX/oY54mnyjdxUTKl2X8hkniHHuOkpq1nnMWZiZT4F+g6hikVGclfrwYsW1g
         /Ahg==
X-Gm-Message-State: AC+VfDzSsOADaTT1DJHGTRDFEysr9Ebz11IkWnxfmOvR515tF11QMbKx
        Qp71XEluSJRkcVO5+dDWl35n5AlzCi4=
X-Google-Smtp-Source: ACHHUZ6U19iqto+EoD3SVSF4iiG4ntYSbq754gFs5Dm7LIuOFYZzRQ2B1sn68DlZgKMha9auxkFI3Q==
X-Received: by 2002:adf:f188:0:b0:306:37ac:ef8e with SMTP id h8-20020adff188000000b0030637acef8emr16567943wro.56.1683875084059;
        Fri, 12 May 2023 00:04:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f24-20020a1cc918000000b003f0ad8d1c69sm27573352wmb.25.2023.05.12.00.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:43 -0700 (PDT)
Message-Id: <f56714080b13f110d4bc996cdff09295f7715a25.1683875070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:10 +0000
Subject: [PATCH v2 09/27] run-command.h: move declarations for run-command.c
 from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h       | 3 ---
 exec-cmd.c    | 3 ++-
 run-command.c | 2 +-
 run-command.h | 2 ++
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 891e5fec744..d31b1515069 100644
--- a/cache.h
+++ b/cache.h
@@ -555,7 +555,4 @@ int checkout_fast_forward(struct repository *r,
 			  const struct object_id *to,
 			  int overwrite_ignore);
 
-
-int sane_execvp(const char *file, char *const argv[]);
-
 #endif /* CACHE_H */
diff --git a/exec-cmd.c b/exec-cmd.c
index 1e34e48c0e4..1d597e84ea7 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -1,10 +1,11 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "path.h"
 #include "quote.h"
+#include "run-command.h"
 #include "strvec.h"
 #include "trace.h"
 #include "trace2.h"
diff --git a/run-command.c b/run-command.c
index d4247d5fcc6..1873d0ba8e7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "run-command.h"
 #include "environment.h"
 #include "exec-cmd.h"
diff --git a/run-command.h b/run-command.h
index 072db56a4df..9e47f91d462 100644
--- a/run-command.h
+++ b/run-command.h
@@ -564,4 +564,6 @@ enum start_bg_result start_bg_command(struct child_process *cmd,
 				      void *cb_data,
 				      unsigned int timeout_sec);
 
+int sane_execvp(const char *file, char *const argv[]);
+
 #endif
-- 
gitgitgadget

