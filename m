Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB3EC43217
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353620AbiBKU5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353582AbiBKU4v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E6AD6D
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m14so17131256wrg.12
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vgvbERnFn+BkBE8Ws/kesSOKfvUq9LjeYGgZa1AhAmE=;
        b=N5CdKQhIMwJ2JsUa5sBC66HDyTqDuoAr8TCmgtpPpthoqk9arDeHWISO6jwXbJ01al
         cLmROEL+CTiW7jIHWXKFg21/h1DT1nigSSQLsJ+zPDo92P5PgIAWpAjWcuUOf+G6LSJ/
         tr9mkqMtYnkMSkUumJWxCDXScBfcqsdC5wNitrxVQE4A3wX7IrZEWvZE91MFETGC7PBZ
         CnGzMR9LDpqup9t+v2jfR2t89H8NafaGtCjg+EoQsO0cx7hj7lu+tD9oh2hmYCq1Obas
         8tSYjwcx8K9JDNXZqKVcxfViLnIxNlWUgmZR4gP0SdT10a8mdy/FAV0eBHtCJqgKxZCi
         OIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vgvbERnFn+BkBE8Ws/kesSOKfvUq9LjeYGgZa1AhAmE=;
        b=G/nnMpHT9trjuQgcBi79ZGE/3IsUFrdT0AP+/RJj/igqgsXfFsxH97zkFfC+9uEW81
         94xMvBPfhQMu6Wm3Bikligy1PSroZlWbsA1ctmNQsqZUJGtKnpfXWe6tC/rDxYOTdPqZ
         G/LYeHa5+lUq1dqJ9Kv6CjcWQY0WvfZ+eGesDnOg+/RMt6L1inT3RkRXqAv2pRjicTv8
         GLXtTS+yWU9zeoMYAKgULYtD+6gtAWDpYT58ISeY0KKqD0kD/GRCKp92xbsZIl+oECT8
         ufDMJrVRAObgROhHJJ8YnRPBf8JtBxvZfihm+m4H9nftyX91+bR5Tb9t1SsCyg7Irmod
         c5gQ==
X-Gm-Message-State: AOAM532O8zKxgYoYYdwhxuHphRMpxGKCc7xUxjCKcbUaafBAcDMP/oVI
        MsSKh83RikN90npjr6NjBk6FVSbQKDk=
X-Google-Smtp-Source: ABdhPJz8LNskJMmWM9Go74yb7JOmy1y1MJTX0Xn51Vyp9ksLFvXwilPC5A8Iae53xh4BcdInnviVeg==
X-Received: by 2002:a5d:47a8:: with SMTP id 8mr2618476wrb.475.1644612996752;
        Fri, 11 Feb 2022 12:56:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k34sm4048728wms.35.2022.02.11.12.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:36 -0800 (PST)
Message-Id: <3517c4a3c1322f07252f63204d60ace9cbb6b1b0.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:08 +0000
Subject: [PATCH v5 19/30] help: include fsmonitor--daemon feature flag in
 version info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
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
index 71444906ddf..9112a51e84b 100644
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
index e4716b0b867..46cd596e7f5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1799,3 +1799,9 @@ test_lazy_prereq SHA1 '
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

