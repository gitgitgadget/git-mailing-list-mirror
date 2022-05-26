Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA517C43217
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349396AbiEZVuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349266AbiEZVtf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB00EAD28
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o29-20020a05600c511d00b00397697f172dso2956587wms.0
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kUTb3iU8XWgR798P6YdKsfHBU+ci261+gHJ9yA28Wks=;
        b=UPtswUzs7oUOT24aeIi5DwPitUxp5q1CKj0G5nF94E2iGX7O6UA/Pc18Zb8/qiasDB
         SmR6gx218F8Q2KOt4mx/VBWPV+26uque1UpBOK8qiSeqczIeWDXnVoTzlmH5IfxVSC5Y
         ms32dkjianP6ar6L30o7jfsRvMtjdbhT4kzGLvu1bl5Y/j7WCNIbIQ758J9Am0VZv1ph
         vCI8JrVPwiIT94u1XlxLi2aWWR0IpssS7sZZrYNWQTjpDzshqM8AycjIrYkZQLXWjk51
         v6CGfAduxR52blFZH8wPzHZ3FVw0Qnzw8ct46FgJiwKGxJ+nb49/bTXzGLHvs8pSHRaR
         P+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kUTb3iU8XWgR798P6YdKsfHBU+ci261+gHJ9yA28Wks=;
        b=hzqzfHzfxl7RZNVjbVGjUhdkHq167XEV8Wm07EraNnFDtkp5W5lXILx0daXhZ/FipJ
         22VK/lCL3VgJStL1LLwqkf9xZaim78Ps9gRypL+y6M8YHf5ziSqDORXrFz/ay+BZboWN
         uEIVTZFHkGMMU6UjhRVDLMGBlGWQAS9rph+Ogrws1QKI0uhJKGnnMttjuA0rh6dEdg5E
         yUICj2UOwr7xzNjlRnMx9cJBwXf6BVOX2IEpEjLYkmVF9NWkCyi+ExFcMDCMuFAA24y/
         HlXTAzRjYs2vZ4eMWnHFUAoPbPiMtWZujdgqzcur4GzGNITbaaWwMQZwmyBQx4dnhbwm
         IvHQ==
X-Gm-Message-State: AOAM530rbxhbESwCwQrJZcD2GTr2roLVzbRbLLAyMFra+ORvV8Zbot6g
        K8l/u3kfcqVVd4waNQh1lmWtz3lYPkQ=
X-Google-Smtp-Source: ABdhPJw+KxC2QfVR/8IVksdF0iXpg7or2zd7CSMW+PH1K9JmiJWEQCjxYMRUbH4uMfxAJM/XKJtJrQ==
X-Received: by 2002:a05:600c:1986:b0:394:77a3:bfa9 with SMTP id t6-20020a05600c198600b0039477a3bfa9mr4049875wmq.142.1653601767328;
        Thu, 26 May 2022 14:49:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m23-20020a05600c3b1700b003976525c38bsm413885wms.3.2022.05.26.14.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:26 -0700 (PDT)
Message-Id: <6976f1d45eacf03bd0936c80d875b4dc8b745879.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:15 +0000
Subject: [PATCH v9 21/30] t7527: FSMonitor tests for directory moves
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create unit tests to move a directory.  Verify that `git status`
gives the same result with and without FSMonitor enabled.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 12655958e71..3bc335b891d 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -274,6 +274,16 @@ test_expect_success 'setup' '
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
@@ -356,6 +366,19 @@ directory_to_file () {
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
@@ -660,6 +683,10 @@ do
 		matrix_try $uc_val $fsm_val file_to_directory
 		matrix_try $uc_val $fsm_val directory_to_file
 
+		matrix_try $uc_val $fsm_val move_directory_contents_deeper
+		matrix_try $uc_val $fsm_val move_directory_up
+		matrix_try $uc_val $fsm_val move_directory
+
 		if test $fsm_val = true
 		then
 			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor at end" '
-- 
gitgitgadget

