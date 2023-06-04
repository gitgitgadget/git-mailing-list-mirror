Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA47C7EE29
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 21:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjFDVTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 17:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDVTv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 17:19:51 -0400
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1727FB8
        for <git@vger.kernel.org>; Sun,  4 Jun 2023 14:19:50 -0700 (PDT)
Received: from [2400:4160:1877:2b00:2001:ee63:a520:4d09] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <glandium@glandium.org>)
        id 1q5v8b-005BfR-1r;
        Sun, 04 Jun 2023 21:19:46 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <glandium@goemon>)
        id 1q5v8U-005jBO-Ge; Mon, 05 Jun 2023 06:19:38 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Mike Hommey <mh@glandium.org>
Subject: [PATCH] Use lowercase includes for some Windows headers
Date:   Mon,  5 Jun 2023 06:19:34 +0900
Message-ID: <20230604211934.1365289-1-mh@glandium.org>
X-Mailer: git-send-email 2.41.0.6.ge371d37104
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cross-compiling with the mingw toolchain on a system with a case
sensitive filesystem, the mixed case (which is technically correct as
per the contents of MS Visual C++) doesn't work (the corresponding mingw
headers are all lowercase for some reason).

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 compat/win32/trace2_win32_process_info.c | 4 ++--
 wrapper.c                                | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
index a4e33768f4..438af8f818 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -3,8 +3,8 @@
 #include "../../repository.h"
 #include "../../trace2.h"
 #include "lazyload.h"
-#include <Psapi.h>
-#include <tlHelp32.h>
+#include <psapi.h>
+#include <tlhelp32.h>
 
 /*
  * An arbitrarily chosen value to limit the size of the ancestor
diff --git a/wrapper.c b/wrapper.c
index 67f5f5dbe1..5dc48e815a 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -17,7 +17,7 @@ static intmax_t count_fsync_hardware_flush;
 #ifdef HAVE_RTLGENRANDOM
 /* This is required to get access to RtlGenRandom. */
 #define SystemFunction036 NTAPI SystemFunction036
-#include <NTSecAPI.h>
+#include <ntsecapi.h>
 #undef SystemFunction036
 #endif
 
-- 
2.41.0.6.ge371d37104

