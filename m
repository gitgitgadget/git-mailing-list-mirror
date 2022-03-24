Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90310C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347009AbiCXFAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 01:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345848AbiCXFAM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 01:00:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23A02AC68
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so1940771wmb.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hg8plsugjefXxhMhSvzABM0c1aAu2C8TxytBC4+PwWI=;
        b=ElIyKQkVTvLZAPH30rX17lO4UK/VA0bS8CH8nyrkFiqmrWUEPZTXQyqdk7WEfCF+o8
         j7Eodr1wM3e65Kljzji9mApGh15I+JBth2ekSw1TxcFTN9tFJagNCZas1evoc+wuVISL
         JKZzEc2RiYiTeZe4B0CxVQbk5HBa1I9YVaEzfVcNY1asqb6YE/N5NXSMibZP2nvoyuJg
         vNEdBHDjJmJa57Y4Jl472UMknptG+oor4g/FxRH+X6dHkFTQkwpP7Uj50/ISVVneLLX1
         I+vTWzBxefN+Fhf+6hYsq6Wi4ULXeEsHjgbb4WN1KK3izX9GM2RMMqVgtc7aLbh+G0St
         lbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hg8plsugjefXxhMhSvzABM0c1aAu2C8TxytBC4+PwWI=;
        b=S7Qv3AA11xhTLQK2hg/Vk+dQ/FYLbVepi4KPBdgR+4rvxj9GY+xQbvPvgLL0sodBgp
         2Grk9ZXmH3qZGd8fQQlVzsdf1qGEGHTiVPdsChsc1tLuqAgSe8yuWHXG9LoQ5Bs48v6D
         eCfvBrGFGwnvMOGcYObGDlK1VUwlkaatPyBTqwKATaqzpQiGUWy9Y3OHDOLMnDZfwwz5
         HEB4gs+qq3aZbaw6WtOsSaWJvjzUuSSub9c4EoctIpJDsy8ODL+SPzBCBaY89xBqaYUY
         kgo6jvmFOPrMXEtrSTPXgW6sbTEnMygbZk8p7ttrPnvM1gdRsM+Nl6zfQeHXNF7tzF0V
         JC7w==
X-Gm-Message-State: AOAM530Eeq/XH3olR2DmulqCOjbJz4tiL3e2iGHknWjpsLKNphVlnUUO
        MM1oC2skPj99jE+PDRVG/du3Iq11ccs=
X-Google-Smtp-Source: ABdhPJx6Dx0egO6gInE/n0JpIi+sLd5yGzI+4vDE1XcdGCq6Jn6HdoP8AhTfjd4QPXc8mkI30m2xdw==
X-Received: by 2002:a05:600c:3487:b0:38c:9a42:4d49 with SMTP id a7-20020a05600c348700b0038c9a424d49mr3067487wmq.29.1648097919074;
        Wed, 23 Mar 2022 21:58:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm1719918wri.48.2022.03.23.21.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 21:58:38 -0700 (PDT)
Message-Id: <447263e8ef14021714976e489248cdcc48ec0303.1648097906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 04:58:22 +0000
Subject: [PATCH v3 07/11] core.fsync: use batch mode and sync loose objects by
 default on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Git for Windows has defaulted to core.fsyncObjectFiles=true since
September 2017. We turn on syncing of loose object files with batch mode
in upstream Git so that we can get broad coverage of the new code
upstream.

We don't actually do fsyncs in the most of the test suite, since
GIT_TEST_FSYNC is set to 0. However, we do exercise all of the
surrounding batch mode code since GIT_TEST_FSYNC merely makes the
maybe_fsync wrapper always appear to succeed.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 cache.h           | 4 ++++
 compat/mingw.h    | 3 +++
 config.c          | 2 +-
 git-compat-util.h | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index a5bf15a5131..7f6cbb254b4 100644
--- a/cache.h
+++ b/cache.h
@@ -1031,6 +1031,10 @@ enum fsync_component {
 			      FSYNC_COMPONENT_INDEX | \
 			      FSYNC_COMPONENT_REFERENCE)
 
+#ifndef FSYNC_COMPONENTS_PLATFORM_DEFAULT
+#define FSYNC_COMPONENTS_PLATFORM_DEFAULT FSYNC_COMPONENTS_DEFAULT
+#endif
+
 /*
  * A bitmask indicating which components of the repo should be fsynced.
  */
diff --git a/compat/mingw.h b/compat/mingw.h
index 6074a3d3ced..afe30868c04 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -332,6 +332,9 @@ int mingw_getpagesize(void);
 int win32_fsync_no_flush(int fd);
 #define fsync_no_flush win32_fsync_no_flush
 
+#define FSYNC_COMPONENTS_PLATFORM_DEFAULT (FSYNC_COMPONENTS_DEFAULT | FSYNC_COMPONENT_LOOSE_OBJECT)
+#define FSYNC_METHOD_DEFAULT (FSYNC_METHOD_BATCH)
+
 struct rlimit {
 	unsigned int rlim_cur;
 };
diff --git a/config.c b/config.c
index 511f4584eeb..e9cac5f4707 100644
--- a/config.c
+++ b/config.c
@@ -1342,7 +1342,7 @@ static const struct fsync_component_name {
 
 static enum fsync_component parse_fsync_components(const char *var, const char *string)
 {
-	enum fsync_component current = FSYNC_COMPONENTS_DEFAULT;
+	enum fsync_component current = FSYNC_COMPONENTS_PLATFORM_DEFAULT;
 	enum fsync_component positive = 0, negative = 0;
 
 	while (string) {
diff --git a/git-compat-util.h b/git-compat-util.h
index 0892e209a2f..fffe42ce7c1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1257,11 +1257,13 @@ __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
 
+#ifndef FSYNC_METHOD_DEFAULT
 #ifdef __APPLE__
 #define FSYNC_METHOD_DEFAULT FSYNC_METHOD_WRITEOUT_ONLY
 #else
 #define FSYNC_METHOD_DEFAULT FSYNC_METHOD_FSYNC
 #endif
+#endif
 
 enum fsync_action {
 	FSYNC_WRITEOUT_ONLY,
-- 
gitgitgadget

