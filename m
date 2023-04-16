Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E274EC77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjDPDE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjDPDEE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:04:04 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DD235A9
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so10093076wmb.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614220; x=1684206220;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caqEkUUJKCXtt2lsnjPJjPm3xKgdR7jcbub+VtGBaIg=;
        b=Ns0gV6R6fQMjkWulnWiuwh62Vuq8xKdFRuf9u5jk1EIpEAtl0I/PunzCw7CWmKTwTN
         reKEXc50K57mCXARnX/NJ+CqU7wJm3quoZ7wVphXHMiWtFC9JJtEg1RxZ6ASOyI9f/uF
         AE+qcdXgTFZljdmfCqq6wHccCb7igdL7VJUROqJEqMhLRRquedShE/myojfT6LInn94z
         WNfQN48uVF1O2WiyrcAZwI21dusyZJAWdMgMDppMiSWQzTQ2r7kceBSD9sXjH5RsPZgv
         1JAwZwV/7bD/+weSTv4DnxVopKGPAbKmxVYuwx8M801ITXbmw21KSoica0eG7JAm4JeZ
         KCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614220; x=1684206220;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caqEkUUJKCXtt2lsnjPJjPm3xKgdR7jcbub+VtGBaIg=;
        b=ecHigAZiXSWyMD5UYKh4PFpjbxqYwKdujayKlXJqefIgKS+QRXCKrbWOOcIpBWPT5S
         gCDGmZUloW5pDM4eJIS4/0pwfyJpIVBpHur2mYLzCYUUCdpcTj/QNH0fJMR8gIqfZ1/u
         xREv4QG99hWzXF1hULWfP5ZA5lflfaccID1XmtqCi0TCBeNuvgzn72WsM2S0hgGLzbeX
         YR9TY9n/Sk+OfCdJjiKxDX5WnELawgl7ZAZfdL+U6cwlQmY/z7SXofhU2nrChyWMmaIW
         kw4BJuK1OPhvjqtTvmaomYjtjof0ZQW6SZgjLKiydn2JReKqx+7y3TlDKDC6q0NGAcT3
         14TA==
X-Gm-Message-State: AAQBX9c+gB8s00CHGPi/bWgC/cPPUn4RnSqAS+8IJKBKxXhzb2eUAwxv
        4Qw095wUab8voExuSGS5zu0ti/J+S4U=
X-Google-Smtp-Source: AKy350aE0cTUcD92mGkz+e/Qn9DsmQtVc3TvB1Ilpqm/vy74UBNICqlGia56Wn3wzWWGIVWJpRgYrw==
X-Received: by 2002:a05:600c:21c4:b0:3f1:6ef6:c9d6 with SMTP id x4-20020a05600c21c400b003f16ef6c9d6mr1815154wmj.32.1681614220067;
        Sat, 15 Apr 2023 20:03:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1-20020a1c4b01000000b003ef5f77901dsm8061741wma.45.2023.04.15.20.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:39 -0700 (PDT)
Message-Id: <8e747e889fbe680e83cd9880cc4b0ff1430eb93b.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:21 +0000
Subject: [PATCH 19/23] fsmonitor: reduce includes of cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 compat/fsmonitor/fsm-health-darwin.c | 2 +-
 compat/fsmonitor/fsm-ipc-darwin.c    | 2 +-
 compat/fsmonitor/fsm-listen-darwin.c | 2 +-
 fsmonitor--daemon.h                  | 1 -
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-darwin.c
index b9f709e8548..4c291f8a066 100644
--- a/compat/fsmonitor/fsm-health-darwin.c
+++ b/compat/fsmonitor/fsm-health-darwin.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "fsmonitor.h"
 #include "fsm-health.h"
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
index bc68dca0cae..793073aaa72 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 18c0e3913dc..23e24b4b374 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -23,7 +23,7 @@
 #endif
 #endif
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "fsmonitor.h"
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index e24838f9a86..70d776c54f6 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -3,7 +3,6 @@
 
 #ifdef HAVE_FSMONITOR_DAEMON_BACKEND
 
-#include "cache.h"
 #include "dir.h"
 #include "run-command.h"
 #include "simple-ipc.h"
-- 
gitgitgadget

