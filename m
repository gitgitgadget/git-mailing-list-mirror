Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE8FC6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDVUSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjDVURx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF222707
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f1950f569eso10529395e9.2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194668; x=1684786668;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA5UfHMctKekDPwKcFA+N+t+HiWPoN5Gn7rqJ+1psEM=;
        b=MlRE+RXU4qmurHOQw1ZzX7gCPyXVWF3M/mWNqs9QXylIISxxQMBi1dUUvNbMFAMf5A
         mjKHk18il66D1LudQo2awnaGh+0P2AIPcS92HJ1pPWQi2aVTj5FXO6OXKzG7HQIv1AiF
         53UPsyPUwBylQ8gTbaHus43IWTIvV2OsIn2M4iOhUT6jcUiNFXcGfHPZ3Thnp2CWl4O+
         5LGLnwfxEuazIKoH5ejKIJGmsH5JBfnvzWTRQzoWL9EoCryaxdmcwv/KJqBwWk8va8QW
         s43Xt7e+OdD4svBo8xc5DtgDkR85Alwc+cgV4LtqPgXo+SQr1VrWvPAWRPYCmC82J0mx
         ICIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194668; x=1684786668;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA5UfHMctKekDPwKcFA+N+t+HiWPoN5Gn7rqJ+1psEM=;
        b=eR5lmbcdOCzZiFO9E0YJzJuH8IKedEBus1DLdE1FcMCP3SpoEjLLWKLb+LeLdnj8Lr
         CM+wAIq2tEwEzod46dq19Gkv/v+v82lSGMT8rw9F0nVG0o6G+4I/lD7PqVj1+Lou7N4G
         hsG/7X89mBOlFeKPbA4sHpuaqiiUGLOvHltlR4myaqa4oyUfKuaZPybNjScgBkyHpLJq
         SPToBw+ykiK97frzAY2dx7lnvLor3+x0Bpq9LkUc/MswcPl534bdOEw8ZLzqCtxmrf5q
         WGg7yzy0B0BWE7zkRtExCpERirKUfbjPz7/64+WzyUmDI14WijAnd8NPZF9OcSLQHmgm
         9GIA==
X-Gm-Message-State: AAQBX9eS69p+aImR4hM/JI5i0rWWMRlYT1f2un9aErbwd/4JJ+XDTnSn
        IFPY3Fw9DaRhnuNGQcbLvMqoZZd0zkg=
X-Google-Smtp-Source: AKy350Yp10azjKDRjpSm+XMj/lIValaI1C2HC5Zo+3KIG/lN2V0RiQTftZxL+9Kg71T82lxdteFAHA==
X-Received: by 2002:a5d:4b91:0:b0:2f9:61d4:1183 with SMTP id b17-20020a5d4b91000000b002f961d41183mr6351891wrt.45.1682194668442;
        Sat, 22 Apr 2023 13:17:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6-20020adfee46000000b002f0442a2d3asm7224269wro.48.2023.04.22.13.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:48 -0700 (PDT)
Message-Id: <7705cbc2733a52cbaa53adc3dffab58f41eb4105.1682194652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:27 +0000
Subject: [PATCH v2 20/22] object-store.h: reduce unnecessary includes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 object-file.c      | 1 +
 object-name.c      | 1 +
 object-store.h     | 8 ++++----
 submodule-config.c | 1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 8e0df7360ae..921a717d8a5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -38,6 +38,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-store.h"
+#include "oidtree.h"
 #include "promisor-remote.h"
 #include "setup.h"
 #include "submodule.h"
diff --git a/object-name.c b/object-name.c
index 5ccbe854b60..88d839f70bc 100644
--- a/object-name.c
+++ b/object-name.c
@@ -14,6 +14,7 @@
 #include "remote.h"
 #include "dir.h"
 #include "oid-array.h"
+#include "oidtree.h"
 #include "packfile.h"
 #include "pretty.h"
 #include "object-store.h"
diff --git a/object-store.h b/object-store.h
index f9d225783ae..23ea86d3702 100644
--- a/object-store.h
+++ b/object-store.h
@@ -2,16 +2,16 @@
 #define OBJECT_STORE_H
 
 #include "object.h"
-#include "oidmap.h"
 #include "list.h"
-#include "oid-array.h"
-#include "strbuf.h"
 #include "thread-utils.h"
 #include "khash.h"
 #include "dir.h"
-#include "oidtree.h"
 #include "oidset.h"
 
+struct oidmap;
+struct oidtree;
+struct strbuf;
+
 struct object_directory {
 	struct object_directory *next;
 
diff --git a/submodule-config.c b/submodule-config.c
index 7fc0812b644..58dfbde9ae5 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -12,6 +12,7 @@
 #include "object-name.h"
 #include "object-store.h"
 #include "parse-options.h"
+#include "thread-utils.h"
 #include "tree-walk.h"
 
 /*
-- 
gitgitgadget

