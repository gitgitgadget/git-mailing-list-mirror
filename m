Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E2CC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5BE6120F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhJUO2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhJUO1m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41921C061230
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k7so1323273wrd.13
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BKYDjV95m/phfY7cx0ODjQfqbfbv9AMbr4AopT+7xzU=;
        b=pHfuYzDSGvCopZWS/OAoCel72RQo7QIL6KTKjMdh1IB2OSLhD7HO7MKYUVbIBgEAgP
         sFZeYObjbSen/iYv8wA0sIfpPAU0eqCVGQ/KjUIGD8y9+GOg2evcXEzARA9VoASiSTAA
         1TPi7Iv788WNctLk9/6G3hejYHNpH7blklfqzaOiJMqlfwS0h9uRQ/ibUU3rFwQxwVZX
         lC1KAksi9D2/pcMnp9g0ipMITs8/4/COtBdnNqsgl3mYASzvZ1R9jI5H8X3U5Jh8NuqW
         sgP/ZfHUtlehJ2SxKoR7RqvsQhRQfytM/mG488qfXByzJZFmH/S9AwRm2Tacvl7c8fgo
         +Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BKYDjV95m/phfY7cx0ODjQfqbfbv9AMbr4AopT+7xzU=;
        b=5rNbAv0+ncUdyfOQT7owJsh/t5q0Fbur+yuhscfeUXl2kYuGY5mOApEeLGmOBajBVY
         nUYVs0znHA+zQFPgq6OvfAQMYMR4UBd7bcbMRAymkGSGl3PxL5gZxWI8RgSDkBvFgvyj
         U76foMg7IACxGqirdCl3QALhDyKy7WWOuaDxHP29JopL98b80uOEBbf02wVNH9Xe8HIO
         mBtk+Ng0Aa1boSS0MlDHHUlqk826clvhNhdcoxz+jrsV0R0DZ0j999uy5DRdO2QW4VLW
         ee6wACAm+bzf0FvSNo1ZaQev6/nDKZW7ckwnc+ffbE9wCzmBR022bTsQ9iB+vukNy3TU
         MDjQ==
X-Gm-Message-State: AOAM531Ijr8rGiJv4JYMw/eSy+1jTSKcUNzt4gCSgh9FPJfMrt5zUm2O
        j2I5UmF7OH3VeCJiEHUdEWolc8RvHvo=
X-Google-Smtp-Source: ABdhPJzd9tIs80KhcU/4ITbBSYSO2kslmKK8lqJqn+AhMVouCAG/+E42Z4cee0TPYZBFKMS9Yaz1eg==
X-Received: by 2002:a05:6000:1549:: with SMTP id 9mr7855905wry.274.1634826322916;
        Thu, 21 Oct 2021 07:25:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm5107893wrr.75.2021.10.21.07.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:22 -0700 (PDT)
Message-Id: <704d37d2033d423c5eecda6cd5b97aacaca130c1.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:24:59 +0000
Subject: [PATCH v4 19/29] help: include fsmonitor--daemon feature flag in
 version info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add the "feature: fsmonitor--daemon" message to the output of
`git version --build-options`.

The builtin FSMonitor is only available on certain platforms and
even then only when certain Makefile flags are enabled, so print
a message in the verbose version output when it is available.

This can be used by test scripts for prereq testing.  Granted, tests
could just try `git fsmonitor--daemon status` and look for a 128 exit
code or grep for a "not supported" message on stderr, but this is
rather obscure.

The main advantage is that the feature message will automatically
appear in bug reports and other support requests.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 help.c        | 4 ++++
 t/test-lib.sh | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/help.c b/help.c
index 973e47cdc30..708eed5d9ad 100644
--- a/help.c
+++ b/help.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "parse-options.h"
 #include "prompt.h"
+#include "fsmonitor-ipc.h"
 
 struct category_description {
 	uint32_t category;
@@ -695,6 +696,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
 		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
+
+		if (fsmonitor_ipc__is_supported())
+			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
 	}
 }
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 151da80c561..4013ef8906e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1736,3 +1736,9 @@ test_lazy_prereq SHA1 '
 # Tests that verify the scheduler integration must set this locally
 # to avoid errors.
 GIT_TEST_MAINT_SCHEDULER="none:exit 1"
+
+# Does this platform support `git fsmonitor--daemon`
+#
+test_lazy_prereq FSMONITOR_DAEMON '
+	git version --build-options | grep "feature:" | grep "fsmonitor--daemon"
+'
-- 
gitgitgadget

