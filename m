Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78803C76188
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjDDBXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjDDBXN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:23:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5A43A93
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i9so31149368wrp.3
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571367;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLKg0DwoqjoHtaoct0QH6EK00i9tJDM3G325lXtJOdw=;
        b=IkmsxbWAv1EWnc473dN0FT0jMUef+q3xo7jXa5bpK/2lDRuV3y8+kTiSWjycU3Ak2z
         r5safOT6Zk0ZayyUv31rICotjW0Nt2A1Zq7xGP5KcXbqCc4vPsb3xW8ZrsSy6kvzlPXo
         KG1HiLvQJwfhBtdlGUBogGJ66E+xxzFj4/r2uT+Hf3Kav8xisJPzZK+GmkVUctWmevva
         35v9xcaFeEy8Cc6yHzSynj0fsXAwQV2pBO6QEpqoUucN0U3/h88mNLDiyIu3y+Xwm+BS
         ca4NvVojrFvHsyX90skX7uCKDpodYPcPv7EtMZ1AES/e8RONg5P/dDaF6/b3t/OrN5ct
         fw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571367;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLKg0DwoqjoHtaoct0QH6EK00i9tJDM3G325lXtJOdw=;
        b=d4K/2ORhUXU2divuGBHbJ4zhmN2HFKPE+eSh+BUQREoMgOL+WXVRT0A7+PssC89t2+
         /cz/69eHrHhu7LCJluPtMY2gt6oc8Nky+3SdpKv4s758CycECqhJnZe0FVM933jZO2KS
         MoouaEzuQpZRYvX6DwrPJxEKkfarp39q4sPM7vljDPrjy/D/oGEBd8RceUzmWQlJUgMI
         n4FU71rxTEIcsbxNwGilsl6ITmpKC4qZKOi1OYGnZ7jWpYTrwpjIax9RuAuTvPDFCmC+
         fFd8XHCBxEYtV0bet31Qdj57Y0LgXrqWxvZlTo1l5WQmg9htAzm3530XJ2V0pkiOuq6y
         Ee+w==
X-Gm-Message-State: AAQBX9ePprlUX0Tt9s7aXjJ9EtAb02LKhtvgpNl1jRR0n39oe0UmYEOS
        RNc6S9OP+1gWYNW8b5cW8kOxih90Lmo=
X-Google-Smtp-Source: AKy350ZNhay3Wfx7i/dBSRvk2+p+xtk6jZ6q6XaPnEerbuG2vdX2ywlB5OQagSoxRxiiFcYtl2ZStQ==
X-Received: by 2002:a5d:53c2:0:b0:2c7:d6a:d7fa with SMTP id a2-20020a5d53c2000000b002c70d6ad7famr274615wrw.25.1680571367327;
        Mon, 03 Apr 2023 18:22:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y13-20020adff14d000000b002c55306f6edsm10953245wro.54.2023.04.03.18.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:47 -0700 (PDT)
Message-Id: <07d1a65a0ecd04ccd24d198ae805fac6c76a52f2.1680571352.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:23 +0000
Subject: [PATCH v2 19/24] treewide: remove cache.h inclusion due to pager.h
 changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 column.c   | 2 +-
 editor.c   | 2 +-
 pager.c    | 2 +-
 pretty.c   | 2 +-
 progress.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/column.c b/column.c
index c89c90328a6..ff2f0abf399 100644
--- a/column.c
+++ b/column.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "column.h"
 #include "string-list.h"
diff --git a/editor.c b/editor.c
index 7c796385493..b34e10606d2 100644
--- a/editor.c
+++ b/editor.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
diff --git a/pager.c b/pager.c
index be78c706644..63055d0873f 100644
--- a/pager.c
+++ b/pager.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "editor.h"
 #include "pager.h"
diff --git a/pretty.c b/pretty.c
index c4671603b56..0bb938021ba 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
 #include "commit.h"
diff --git a/progress.c b/progress.c
index 96a8e36a52f..72d5e0c73c1 100644
--- a/progress.c
+++ b/progress.c
@@ -9,7 +9,7 @@
  */
 
 #define GIT_TEST_PROGRESS_ONLY
-#include "cache.h"
+#include "git-compat-util.h"
 #include "pager.h"
 #include "progress.h"
 #include "strbuf.h"
-- 
gitgitgadget

