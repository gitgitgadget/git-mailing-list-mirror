Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AF0C77B70
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjDPDEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjDPDEE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:04:04 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244DE35BB
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bd13-20020a05600c1f0d00b003f14c42cc99so2431629wmb.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614219; x=1684206219;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkh3h+0otRtSW4DljvrgG6353s+aSsn0CnyhephkYW4=;
        b=AHxJG13w0uo5Coe4gugI3PpK7I/Wc/9aqpZVKFiuJG9cX8rmfa0NoNk127LZCtjZ52
         AbqlNyma4C7mlSzmZzYoayjRp3IosbY6wCHvjzMP3kh6YmZExFRdXl/Rt7i1KrLMhQn+
         8sTIguZf5G/JQDHDocNTu66EyBAwXfQ7DXPyoagz11/RDkczoLq2Gyz/0VRBIDP32zJN
         YHIqbld9ZpCqch6l64sZH4BTEkhGiZMIqomPGycVK+cqbVnhEAA5l0I7OtrI5lFQOUas
         aUpN6LI/C4f9oBMHkX/svPcaWP1N1tRKdKjGtM3XYGpExGqvSVLGI4TtCtk2wUdwY5tv
         mIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614219; x=1684206219;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkh3h+0otRtSW4DljvrgG6353s+aSsn0CnyhephkYW4=;
        b=We+DijjjJe3YQVwTRj4meCxlq54kg4rX37H7ywkYrW6DNhRf+B51yLzihepNuVWtbG
         smA4lly/ascIfoZ8212fo2DT+0jreudxBEDy4h+DaylwUfqQN+9AzI/irb5BjEih8mmk
         9GsKcgksgt1Hyf6Bb8WIxLhHuI13zQ4QGk6mVB3SVYr4WkAer8BiJ7DVI8yYbPXfGdsJ
         rhB0Ny1w9sn9NTKKIo2qJhRARW3QKOi721ZdBvB6qk8NLZM8amhBVKxqmCWszkhHzqH0
         gi5QVXq15O+9T3/aV/+wFhOKOdj+mrH2SKdrg7x0DCUg2NJk6/MtXvIdl64EvQY0js8Y
         b1Vw==
X-Gm-Message-State: AAQBX9cnC3RfXZEbOoEgfXeP2TqTfQEwxAmNP+7rQB4+8Uy76yFXZ8yh
        ohamBNgdl63ikLHEakvlMBv1OgF43Ag=
X-Google-Smtp-Source: AKy350aFqdzX+ZrJRMxwFmmdfJNTcVpDX1r2DOv0Kh+EQ3IdAfObJHv33sLAuYsr3Wlbl3DAA9i2dA==
X-Received: by 2002:a05:600c:254:b0:3ed:4416:d2ff with SMTP id 20-20020a05600c025400b003ed4416d2ffmr7257887wmj.28.1681614219488;
        Sat, 15 Apr 2023 20:03:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b003f0a007b802sm10777336wmq.12.2023.04.15.20.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:39 -0700 (PDT)
Message-Id: <34c9034e8edb997cfd38a69dd71bfa41070f4397.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:20 +0000
Subject: [PATCH 18/23] cache.h: remove unnecessary headers
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
 cache.h                              | 2 --
 compat/fsmonitor/fsm-ipc-darwin.c    | 1 +
 compat/fsmonitor/fsm-listen-darwin.c | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 591c67b0595..bdedb87e83b 100644
--- a/cache.h
+++ b/cache.h
@@ -4,8 +4,6 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "hashmap.h"
-#include "gettext.h"
-#include "string-list.h"
 #include "pathspec.h"
 #include "object.h"
 #include "statinfo.h"
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
index e62f093cc19..bc68dca0cae 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "strbuf.h"
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 5eb6402ab82..18c0e3913dc 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -29,6 +29,7 @@
 #include "fsmonitor--daemon.h"
 #include "fsmonitor-path-utils.h"
 #include "gettext.h"
+#include "string-list.h"
 
 struct fsm_listen_data
 {
-- 
gitgitgadget

