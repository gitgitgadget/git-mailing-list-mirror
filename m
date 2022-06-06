Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63D5C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 19:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiFFTzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 15:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiFFTzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 15:55:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BE07983F
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 12:55:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q26so10857814wra.1
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 12:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tJAYv2N4IRoqgWVKReeL+zXTG1mmfKgd5arVI+g3Idg=;
        b=GnhEQ61SHKX1xWCfNHHRyynBGE2dh/aDoaTo6Na3Ty3LhzIEnI5hZmDX7krBOGEW6p
         +9DabT+CWfw9+E+zasNbrilYgG2dDSjfqy1EzANb6IsVzthwUozkfsxOB+xPldN2/aak
         q+J4BFT7g5idSkRDLLqiHDn4UwjQPTFaajQJD4hwgYCNM0Hx+Lj5TOiusO5OEGs88cy9
         DKForcGuj7S61LZgOyPBEtr6HNMBeZJkn3tY0zZqUiTLsKXr2x/hDG/vXajJCu9nwGh4
         lvURRP+IbbHOfHNz7lB40N5ifwG0GEcidP3Y/tZAmgdkLXBOFEGqvWBx0DbMCrEvITFa
         YsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tJAYv2N4IRoqgWVKReeL+zXTG1mmfKgd5arVI+g3Idg=;
        b=lThvtSckNvSyYpzYM+vfIU5TMUk6nzj/HfhYdFjp2gYvg5U7sApTkD93aZCXclU1Yp
         HOUe/OlUFGpfaBeXIfFAjWlWognMqgWsieVQTCjx/YhKHQt5z3J8Q7AquyZww2LfQ3Jy
         THyQmIwyqUuA4UZcJdjVClWLgQkpPksX2+IjjTiMnMq9tsfpSXwGlCzfDdSYP6Ha9MJ1
         CzEuzMDOte/ZmpI3C5DKyeK+YVH09heiF/LaNWV8OcoB7XDLstiLvtiklJoRMBazhUrP
         J0j3W7rU2Fd0cbk/VNzewuaTWfqnHj/We5KmWtI5uQjn0rlSA4fhc0ync8cMOR9i+RgD
         P3KQ==
X-Gm-Message-State: AOAM532wU4sgfyD+IO5aS/gghPwCDBEEHEY8gSUgZzFa0mSsObjk6PsH
        3tkCOifZU4hU8W+sBiQMMA73AiugzQPSwKDV
X-Google-Smtp-Source: ABdhPJzIr1PDCe0s4aBmRoxuY/c2I8v1u41AIgkW8qESZ1WxMrHhmEvXrGdc91Vf9VC4+VemGDHWmg==
X-Received: by 2002:a5d:4fc8:0:b0:210:3520:7479 with SMTP id h8-20020a5d4fc8000000b0021035207479mr23853719wrw.610.1654545333323;
        Mon, 06 Jun 2022 12:55:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1-20020adfea81000000b00210320d9fbfsm19373924wrm.18.2022.06.06.12.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:55:32 -0700 (PDT)
Message-Id: <5ca02b841dbdb6392370797f3c5dace46d1e70ef.1654545325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 19:55:25 +0000
Subject: [PATCH 6/6] fetch: add 'refs/bundle/' to log.excludeDecoration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
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
 Documentation/fetch-options.txt |  3 ++-
 bundle-uri.c                    |  7 +++++++
 t/t5558-fetch-bundle-uri.sh     | 12 +++++++++---
 3 files changed, 18 insertions(+), 4 deletions(-)

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
index 576ced271cb..a3ffe0d129e 100644
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
@@ -152,6 +153,12 @@ int fetch_bundle_uri(struct repository *r, const char *uri)
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
diff --git a/t/t5558-fetch-bundle-uri.sh b/t/t5558-fetch-bundle-uri.sh
index 919db6f4551..563df6de5e3 100755
--- a/t/t5558-fetch-bundle-uri.sh
+++ b/t/t5558-fetch-bundle-uri.sh
@@ -28,7 +28,9 @@ test_expect_success 'fetch file bundle' '
 	git -C fetch-to fetch --bundle-uri="$(pwd)/fetch-from/B.bundle" &&
 	git -C fetch-to rev-parse refs/bundles/topic >actual &&
 	git -C fetch-from rev-parse topic >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	test_config log.excludedecoration refs/bundle/
 '
 
 test_expect_success 'fetch file:// bundle' '
@@ -36,7 +38,9 @@ test_expect_success 'fetch file:// bundle' '
 	git -C fetch-file fetch --bundle-uri="file://$(pwd)/fetch-from/B.bundle" &&
 	git -C fetch-file rev-parse refs/bundles/topic >actual &&
 	git -C fetch-from rev-parse topic >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	test_config log.excludedecoration refs/bundle/
 '
 
 #########################################################################
@@ -62,7 +66,9 @@ test_expect_success 'fetch HTTP bundle' '
 	git -C fetch-http fetch --bundle-uri="$HTTPD_URL/B.bundle" &&
 	git -C fetch-http rev-parse refs/bundles/topic >actual &&
 	git -C fetch-from rev-parse topic >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	test_config log.excludedecoration refs/bundle/
 '
 
 # Do not add tests here unless they use the HTTP server, as they will
-- 
gitgitgadget
