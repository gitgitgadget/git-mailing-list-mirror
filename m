Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9734EC433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbiCVS0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbiCVSZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:25:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3B715FEC
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j18so15004410wrd.6
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c9U8uQ8YcJe+AKnqA/7k7C5uEO6mNcd8TsCgZ3bkj2s=;
        b=CzsvLWT7fRvUNnqhjMcujjBdxX675DlRPzOM+sUNlp6kYO5Mb1Wie0R9e3Z0gDebLa
         gya5r/dAPM0e7u4NTX4zitO5AlPAGEsNOF07v847b9N37jLmtwAIH8V+KN4ckgEuf5sC
         g+5H66wYHpAwKVoaLjtWNtFBk7jrHSEUlZjrZqxcXxBkCQJVgTsuBmwIWHlMylGlW9CG
         SEpctWPI7qgj2qXCwfstU5tRPVP3n9G7npmwTPHTX0EMmEpk4WFPco0/QEqxOy7F5QpG
         jAnrg7NxHTAYyQ7dwVF77I4kAWFgOCXmc215KMxX50jh6WO9C9baKvbkooE5UNOkwd5O
         6JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c9U8uQ8YcJe+AKnqA/7k7C5uEO6mNcd8TsCgZ3bkj2s=;
        b=bcrvYO+dES4I/GtYH47+M4vfFP9Q0rorrpS4dUDgjEiboRiQ/JJMojrvAnWip2T+Tv
         t4K/v43F+0BBAzMKeLv6zdLkyM6Fn4SVgH4ogehQwvDMB0acYD6MIY+4PuJcLtlV2VfJ
         fdQlclLjK0ygnSdcsbZ4PyZD9t045JmnHiB+bfoGaM5q6rXISb33YmrY4r29Y4tsU9Y5
         rPNuiNcAhc69npag/7Lmoed5pLFcEcvF9+JtHkY4YkPMl2bqRgViHb9ijS4RqaNyUMKH
         Z5NPCmyqntGHiM3VgwccZqd9+WuYeRN6SYxkqMz88so+mbi8Bu2GmKomwGELWxTDn198
         OpNQ==
X-Gm-Message-State: AOAM530sBPusxg+UjwdIbUkhnDV1Dbch46KNKpi8qbeMB+QQAqvxmXeQ
        RM8JbvybYhDaZczD5TRbLGpfB/ICvSg=
X-Google-Smtp-Source: ABdhPJxeexjXLhSr8Yg8Qf+Vfa/SDfmhvAApcnimYI4CfbVCJGOiUSFAeuUcqTm7+2FXGL0DSD4cWw==
X-Received: by 2002:a05:6000:178e:b0:205:7acf:8fb1 with SMTP id e14-20020a056000178e00b002057acf8fb1mr3465031wrg.499.1647973436499;
        Tue, 22 Mar 2022 11:23:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d64e5000000b00203914f5313sm16277535wri.114.2022.03.22.11.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:55 -0700 (PDT)
Message-Id: <d8218d197adb18d2034d21a0881cf05442c32680.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:54 +0000
Subject: [PATCH v3 21/27] t7527: FSMonitor tests for directory moves
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create unit tests to move a directory.  Verify that `git status`
gives the same result with and without FSMonitor enabled.

NEEDSWORK: This test exposes a bug in the untracked-cache on
Windows when FSMonitor is disabled.  These are commented out
for the moment.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 429029fcadd..bc66d8285a3 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -281,6 +281,16 @@ test_expect_success 'setup' '
 	trace*
 	EOF
 
+	mkdir -p T1/T2/T3/T4 &&
+	echo 1 >T1/F1 &&
+	echo 1 >T1/T2/F1 &&
+	echo 1 >T1/T2/T3/F1 &&
+	echo 1 >T1/T2/T3/T4/F1 &&
+	echo 2 >T1/F2 &&
+	echo 2 >T1/T2/F2 &&
+	echo 2 >T1/T2/T3/F2 &&
+	echo 2 >T1/T2/T3/T4/F2 &&
+
 	git -c core.fsmonitor=false add . &&
 	test_tick &&
 	git -c core.fsmonitor=false commit -m initial &&
@@ -363,6 +373,19 @@ directory_to_file () {
 	echo 1 >dir1
 }
 
+move_directory_contents_deeper() {
+	mkdir T1/_new_ &&
+	mv T1/[A-Z]* T1/_new_
+}
+
+move_directory_up() {
+	mv T1/T2/T3 T1
+}
+
+move_directory() {
+	mv T1/T2/T3 T1/T2/NewT3
+}
+
 # The next few test cases confirm that our fsmonitor daemon sees each type
 # of OS filesystem notification that we care about.  At this layer we just
 # ensure we are getting the OS notifications and do not try to confirm what
@@ -645,6 +668,22 @@ do
 		matrix_try $uc_val $fsm_val file_to_directory
 		matrix_try $uc_val $fsm_val directory_to_file
 
+		# NEEDSWORK: On Windows the untracked-cache is buggy when FSMonitor
+		# is DISABLED.  Turn off a few test that cause it problems until
+		# we can debug it.
+		#
+		try_moves="true"
+		test_have_prereq UNTRACKED_CACHE,WINDOWS && \
+			test $uc_val = true && \
+			test $fsm_val = false && \
+			try_moves="false"
+		if test $try_moves = true
+		then
+			matrix_try $uc_val $fsm_val move_directory_contents_deeper
+			matrix_try $uc_val $fsm_val move_directory_up
+			matrix_try $uc_val $fsm_val move_directory
+		fi
+
 		if test $fsm_val = true
 		then
 			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor at end" '
-- 
gitgitgadget

