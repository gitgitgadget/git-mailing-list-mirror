Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A4C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiCYTk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiCYTi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:38:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C8E1DA8CE
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:11:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a8so17160014ejc.8
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i8AAWLIhTvBsJbUUWF9sVC+yslqp1BHv6rf37oWZ/I8=;
        b=T+1rvMWFXy5lRUKR2nQm4RGbAJVKszNtv6ROqNqgv/ILoIqVVBFnnLdlzPIhLYevkT
         Z+rGezA1lRT3D1D3WhmKhYOXjM3ThtN+iLrVmLufSs/wd7l5NkOwd5YSm22k2Bk8pDBa
         hoUqu6etURBSqyEYcUqUTja/Ct47y4wBxyaSrc8ApUBtoHTTMw7HT17uzmz03yrEg2cq
         7cOZVEUR05cWJJauBN1VSfjACCfVj056O6MY11hRA1bFKGSZBTrgBPX1ta+yw6QSYv1K
         CSZg1MckxV70jvim/iA+mtBAaI7kQ34aH9TIOkYHqTLr4kU3eZZEmmt5sUbQeCUn/Lft
         w/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i8AAWLIhTvBsJbUUWF9sVC+yslqp1BHv6rf37oWZ/I8=;
        b=oLgd1DwyAoO5W8VdP5TAI1Z+28pk6GSI3CpOhR6sPXcc35sTCgOPbQ4kl9wB/otMyJ
         4JVlaX/46wN1Z7VvhcZnPFfWbfrI8sJ+ML7Trt6Qx1qG/xYe1VnWEF3JYZtGiixLkpf9
         2YSc0BqLXo1NlB4V5BtiD7mCH1DZcKLl3qH2jD+0f/NH4eF9aWSM2pLOMnjTKu0onr+T
         JexhgMq+yqVXDB9xzXGwdHKvNuMdxiDt3e9QTrqRVSrsehgHzeqyHuBneG8bxrUyGUvx
         EGx+ZLPLacIt2km7uEGJmDj8U6ySOjpo/5W2aa0pBzb814mz6MQjgDGDsQoVOC8UUO90
         0hFw==
X-Gm-Message-State: AOAM532aGCl253swSIWyCvW4B4TMZDBarIiPg1h/wsS4JDF/JWRK1krR
        Izq+pbt0ymIJkzKAYrGSsOe0oES6TWw=
X-Google-Smtp-Source: ABdhPJx/rg4cW6nz8o0HdJvqRf1VFGpKg/EzPMKOqhRjVnlG/PNcjxaV+zr1tskQhcSZTBqkDc7O/g==
X-Received: by 2002:adf:d4c2:0:b0:203:da50:12c5 with SMTP id w2-20020adfd4c2000000b00203da5012c5mr10425516wrk.100.1648231423486;
        Fri, 25 Mar 2022 11:03:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0038cb8b38f9fsm8662165wmq.21.2022.03.25.11.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:43 -0700 (PDT)
Message-Id: <5b18e3b692661010387b3438e86238dbf0fa2eb2.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:03:09 +0000
Subject: [PATCH v9 26/30] t/perf/p7519: add fsmonitor--daemon test cases
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
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Repeat all of the fsmonitor perf tests using `git fsmonitor--daemon` and
the "Simple IPC" interface.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/perf/p7519-fsmonitor.sh | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index a6c2a910e70..0b9129ca7bc 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -141,7 +141,7 @@ test_expect_success "one time repo setup" '
 	fi
 '
 
-setup_for_fsmonitor () {
+setup_for_fsmonitor_hook () {
 	# set INTEGRATION_SCRIPT depending on the environment
 	if test -n "$INTEGRATION_PATH"
 	then
@@ -182,7 +182,11 @@ test_perf_w_drop_caches () {
 }
 
 test_fsmonitor_suite () {
-	if test -n "$INTEGRATION_SCRIPT"; then
+	if test -n "$USE_FSMONITOR_DAEMON"
+	then
+		DESC="builtin fsmonitor--daemon"
+	elif test -n "$INTEGRATION_SCRIPT"
+	then
 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
 	else
 		DESC="fsmonitor=disabled"
@@ -261,11 +265,11 @@ test_fsmonitor_suite () {
 trace_start fsmonitor-watchman
 if test -n "$GIT_PERF_7519_FSMONITOR"; then
 	for INTEGRATION_PATH in $GIT_PERF_7519_FSMONITOR; do
-		test_expect_success "setup for fsmonitor $INTEGRATION_PATH" 'setup_for_fsmonitor'
+		test_expect_success "setup for fsmonitor $INTEGRATION_PATH" 'setup_for_fsmonitor_hook'
 		test_fsmonitor_suite
 	done
 else
-	test_expect_success "setup for fsmonitor" 'setup_for_fsmonitor'
+	test_expect_success "setup for fsmonitor hook" 'setup_for_fsmonitor_hook'
 	test_fsmonitor_suite
 fi
 
@@ -293,4 +297,30 @@ test_expect_success "setup without fsmonitor" '
 test_fsmonitor_suite
 trace_stop
 
+#
+# Run a full set of perf tests using the built-in fsmonitor--daemon.
+# It does not use the Hook API, so it has a different setup.
+# Explicitly start the daemon here and before we start client commands
+# so that we can later add custom tracing.
+#
+if test_have_prereq FSMONITOR_DAEMON
+then
+	USE_FSMONITOR_DAEMON=t
+
+	test_expect_success "setup for builtin fsmonitor" '
+		trace_start fsmonitor--daemon--server &&
+		git fsmonitor--daemon start &&
+
+		trace_start fsmonitor--daemon--client &&
+
+		git config core.fsmonitor true &&
+		git update-index --fsmonitor
+	'
+
+	test_fsmonitor_suite
+
+	git fsmonitor--daemon stop
+	trace_stop
+fi
+
 test_done
-- 
gitgitgadget

