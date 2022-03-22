Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EA0C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbiCVSDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbiCVSCW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:02:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D8067D09
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a1so23179920wrh.10
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6IMoORViExxPGOqXM0jiWHBPtgaquTlkmrPOCTiquVM=;
        b=MMOTonpu7htu38RV4R0ZQ+Obdm08pyKeI8BKO6D1HiMBK/fQqvUVdcsikKwsLd2wx6
         /oczmXz0KDs3FM4DIVhZOyepSZN7YupjVeFHEBJiMgoUXH/9hMYs6DpQo3+KKwdrNtCZ
         JtOex2T2FH3qQT8X8bCWJsal4M0lxucvcYe3+54RJGQoP2TdQE/ymKw8kTjNq+XKt+SN
         apHfifQsu5wQiph0ht01J0nyXHGIckqvbU91vOBbDLLhLYOwOkW/ACpde83cBOrTfgWh
         hhCPinHcG5WcxCSHIQVLwnTrt8QGc6tO+A3TSyf9Rh9UMCTqP3kbF8Sg/qaN8UOLDBOU
         /UBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6IMoORViExxPGOqXM0jiWHBPtgaquTlkmrPOCTiquVM=;
        b=WuzQuTUi43WjtdbXMSStwPPIQ1D09BydrlVvIzedvUUmeuQPy21zBjSqYXfA3IbXUa
         eDJv0F03G5Dm+UQyM3SG2Y1IfrCcGSLvhETNNsF3/vYaZZubnDSXqDQDAhTE1hpNnJKL
         DjBodbFkm0UuP1K1i3fXHKRnQTvO1SGDJNh56KKc3ltZFe37Aoqn3Ktlf/Rz9gZ6Vs6p
         FWl4IlrpNHaGxs//bXoSfuEQ/8GwaHZgWXV/FzP7pv1tpVLrP5weXhvo0Uh2O2/rh4la
         VTwFuA+CsNBDvhxLZFMdCucSmBSvKR/cjrmEEW5t/W5GVEDnLPBvnQndBYR9KzwBBIYf
         IFow==
X-Gm-Message-State: AOAM532KXZJZQJL6eHaEG4401DAp8NJwdLkdPs2fwLrXLTdrTwzYRPW2
        Azshh3fqL3dbnOSMZ+dfy5cTKSzDKEg=
X-Google-Smtp-Source: ABdhPJyKA3SveHy2UsPvfPlbZhC3zeR7gl9Yk4Tk5y+v4wUMpShLiVEFh8AYojFcPRTXYiGb71uFgw==
X-Received: by 2002:a5d:6092:0:b0:203:f860:a84 with SMTP id w18-20020a5d6092000000b00203f8600a84mr16958344wrt.160.1647972044250;
        Tue, 22 Mar 2022 11:00:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0038cbcbcf994sm1425293wmq.36.2022.03.22.11.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:43 -0700 (PDT)
Message-Id: <8cf62c9fc6f07980d35138b4be9cacbf007cd32a.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:00:00 +0000
Subject: [PATCH v7 19/29] help: include fsmonitor--daemon feature flag in
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
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
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
code or grep for a "not supported" message on stderr, but these
methods are rather obscure.

The main advantage is that the feature message will automatically
appear in bug reports and other support requests.

This concept was also used during the development of Scalar for
similar reasons.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 help.c        | 4 ++++
 t/test-lib.sh | 7 +++++++
 2 files changed, 11 insertions(+)

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
index e4716b0b867..5d819c1bc11 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1799,3 +1799,10 @@ test_lazy_prereq SHA1 '
 # Tests that verify the scheduler integration must set this locally
 # to avoid errors.
 GIT_TEST_MAINT_SCHEDULER="none:exit 1"
+
+# Does this platform support `git fsmonitor--daemon`
+#
+test_lazy_prereq FSMONITOR_DAEMON '
+	git version --build-options >output &&
+	grep "feature: fsmonitor--daemon" output
+'
-- 
gitgitgadget

