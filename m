Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777B7C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352968AbiETSlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352875AbiETSk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:40:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F5E26AC7
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h5so11495702wrb.11
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f0iVJT7Y8vKkooPdmjmZPR0Zb8U1/HDQXQB5i1LGtXA=;
        b=BnxNfzFU+iIdTnju32E0a4tHho6ABBkPsd0wA7j7ooS7LPApKG3ih6AaeaSIeAsTmc
         jQLNcdv+bOJ3+Su7QbSD/Ooa6hZYTs4GlrXPOAcX8cCeJAfu6n4Vhx8BNjnk0JQGIY5X
         vBwi2DeEPiaKWTaYbqdEGejdcXgAkAQnU3gTZsBb/5/tgCk3KiwtDqtl4YHs8Zq63RdK
         8IhGZMSG6eqxw3gBNnGQ7l90nSxaE6ooYxOe3QopHDvroz6XsQDmGn67lOXHIDeTwl4y
         /LP2JJswY4MGo85hrDHzdZudUnaHPb84lHy/uYMlreGfUk8JXbZzyz63quF0BLOR1AIB
         DHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f0iVJT7Y8vKkooPdmjmZPR0Zb8U1/HDQXQB5i1LGtXA=;
        b=4UKPJTjyTQmCfbhVH5+moSy6qjWIo6pq6vGoDHDV+W4D5sfY+Z/sSp5UpfOhSRVxA6
         2oqgOmthYwsjiqt4I0BanOFdeK4/397BeMt2O+504cOxUMNXcrc32MHhBieEJJydyDgX
         B5fb2JNqWef3eGe5efBiI10hKhHtP7C1aopMExmhdSs811tlDnkh569WfV7i7ELbRlgl
         dRjyz8XcZIH4/CZCo1vnJm9xB3H6yfXwXO5D3GbwCAPdKYJXy32W7KsX2rk80v/+mKLC
         pTGu3AeD715yAvuLIpuoRWxIp/1kfSuqAOV2HtDP92Qs8cbLC0zqBKGpTvsf/kdrqIha
         0E2g==
X-Gm-Message-State: AOAM533Sac9yw6dYWs5n5SwvPJUhCdjv3IuECxIIcexRyGCALvAWNQgs
        rZWRVJEacdLznmv8LyOnr04QSeCK3lM=
X-Google-Smtp-Source: ABdhPJwdk3/6MfetM0Y8jdfCjt7i4cOU0yGUknQmLZCaHMFtE1ncz4cqfApCm4ngf6BXICD4aPfaRw==
X-Received: by 2002:a5d:650f:0:b0:20d:77b:702b with SMTP id x15-20020a5d650f000000b0020d077b702bmr9491181wru.78.1653072051230;
        Fri, 20 May 2022 11:40:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3-20020a05600c218300b003942a244edfsm2608686wme.36.2022.05.20.11.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:50 -0700 (PDT)
Message-Id: <701a983eed2e695e91b7a9abc50c64b25415d8a6.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:24 +0000
Subject: [PATCH 06/24] fetch: add 'refs/bundle/' to log.excludeDecoration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When fetching from a bundle URI, the branches of that bundle are stored
in a different ref namespace: refs/bundles/. This namespace is intended
to assist with later 'git fetch' negotiations with a Git server,
allowing the client to advertise which data it already has from a bundle
URI.

These references can be confusing for a user when they appear as a
decoration in 'git log' output. Add "refs/bundles/" to the multi-valued
log.excludeDecoration config value. This is similar to the way
"refs/prefetch/" is hidden by background prefetch operations in 'git
maintenance' as added by 96eaffebb (maintenance: set
log.excludeDecoration durin prefetch, 2021-01-19).

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/fetch-options.txt | 3 ++-
 bundle-uri.c                    | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 09bd1feeed8..8b801bcc2f3 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -321,4 +321,5 @@ endif::git-pull[]
 --bundle-uri=<uri>::
 	Instead of fetching from a remote, fetch a bundle from the given
 	`<uri>` and unbundle the data into the local repository. The refs
-	in the bundle will be stored under the `refs/bundle/*` namespace.
+	in the bundle will be stored under the hidden `refs/bundle/*`
+	namespace.
diff --git a/bundle-uri.c b/bundle-uri.c
index 08de7257c74..0692a62071a 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "bundle-uri.h"
 #include "bundle.h"
+#include "config.h"
 #include "object-store.h"
 #include "refs.h"
 #include "run-command.h"
@@ -148,6 +149,12 @@ int fetch_bundle_uri(struct repository *r, const char *uri)
 	if ((result = unbundle_from_file(r, filename.buf)))
 		goto cleanup;
 
+	git_config_set_multivar_gently("log.excludedecoration",
+					"refs/bundle/",
+					"refs/bundle/",
+					CONFIG_FLAGS_FIXED_VALUE |
+					CONFIG_FLAGS_MULTI_REPLACE);
+
 cleanup:
 	unlink(filename.buf);
 	strbuf_release(&filename);
-- 
gitgitgadget

