Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FB6C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiDVWjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbiDVWiR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E7D2C334B
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so6062082wmq.3
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sT0c8aXec7Qd7Uz+VPv4R8t01CAoi+Z9hzDzbefQ1wY=;
        b=QBYJUQOtlmzTk+C7Wss6/fRQA4VCqLY8WzgSfptoKwoCnh2rzR0dwVi9zuBTF0WB/U
         xKQcNd/5nka7pTdROae6k8s6duEEu1GJZAIm4v+2c5ad3DF6t+rk6adoBJvMmd8nPTB6
         EMJ1I3oj6t2P+mrRGLn4wStXx14QpPfCLm2rsKGG+ULplzUngUbBJZnxRo5dNCniZx0M
         PXNVvlS0HHf6dXO4zojyEaj0umGuGMxI0m2Rn3uHU/0TsEEV88LlvbzvWTRcj7QceEkP
         7fubXxigmVaEiiDb/mlA2quT+1PZclmwqxywuyEWzFMLc9cWBeVbQoTaTZujKuppprbS
         7YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sT0c8aXec7Qd7Uz+VPv4R8t01CAoi+Z9hzDzbefQ1wY=;
        b=hiMsRH1PHPrkBKKXeKINUBip/vHX6mDUCPEFynPzR4cch7CMqcXppzrUQyfPnrdPEt
         Lzwb5uZcXBLmo9svBYFp+4hOkvDU8ZX+JFk/nRIMzD6KMLsHJtLq7B+E0U6tR+16KBoO
         hXTCSfWc4AdilchEhU3p/fJL269MHzOCfkn76Mv+g9PhATlrvIi3nEfShQocAWXRr+21
         hyjO8mbZbdSaJVlEqV6pL7DKm4szuxiX02ms7ipYWd1eLbVmwRWqzqJZ4vUMnFXd4Qtj
         dS1VkieeUBiv8YiIEoM0q6NB2Q/6+09kPRXaj4K7Qd5QMKWZNMM8HMG2ipY8xE10ZzHO
         zn4g==
X-Gm-Message-State: AOAM533r4kAnnFoO8ZljP91O4ueHUI7CdROez/kCLwO69zNZ49PbZvFc
        WUYZg4O9TQSP5M5EgxKBgULw22SXewc=
X-Google-Smtp-Source: ABdhPJzDd7a1Xob7DiWetIyvtgHzw+TE6d2dbMjAQCEPnCj7VHkAB5ULu8mg2z/0Kv54gKZzYXVs5g==
X-Received: by 2002:a7b:ce83:0:b0:37b:f1f1:3a0c with SMTP id q3-20020a7bce83000000b0037bf1f13a0cmr5861762wmj.10.1650663021898;
        Fri, 22 Apr 2022 14:30:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d6d04000000b0020a8bbbb72bsm3330261wrq.97.2022.04.22.14.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:21 -0700 (PDT)
Message-Id: <410dd2d2920eb6086378119765737dda7f3c7c29.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:50 +0000
Subject: [PATCH v6 24/28] t7527: test FSMonitor on case insensitive+preserving
 file system
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
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Test that FS events from the OS are received using the preserved,
on-disk spelling of files/directories rather than spelling used
to make the change.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 4c49ae5a684..1cdbacdbfb0 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -832,4 +832,40 @@ test_expect_success "Submodule always visited" '
 	my_match_and_clean
 '
 
+# On a case-insensitive file system, confirm that the daemon
+# notices when the .git directory is moved/renamed/deleted
+# regardless of how it is spelled in the the FS event.
+# That is, does the FS event receive the spelling of the
+# operation or does it receive the spelling preserved with
+# the file/directory.
+#
+test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
+#	test_when_finished "stop_daemon_delete_repo test_insensitive" &&
+
+	git init test_insensitive &&
+
+	start_daemon -C test_insensitive --tf "$PWD/insensitive.trace" &&
+
+	mkdir -p test_insensitive/abc/def &&
+	echo xyz >test_insensitive/ABC/DEF/xyz &&
+
+	test_path_is_dir test_insensitive/.git &&
+	test_path_is_dir test_insensitive/.GIT &&
+
+	# Rename .git using an alternate spelling to verify that that
+	# daemon detects it and automatically shuts down.
+	mv test_insensitive/.GIT test_insensitive/.FOO &&
+	sleep 1 &&
+	mv test_insensitive/.FOO test_insensitive/.git &&
+	test_must_fail git -C test_insensitive fsmonitor--daemon status &&
+
+	# Verify that events were reported using on-disk spellings of the
+	# directories and files that we touched.  We may or may not get a
+	# trailing slash on modified directories.
+	#
+	egrep "^event: abc/?$"       ./insensitive.trace &&
+	egrep "^event: abc/def/?$"   ./insensitive.trace &&
+	egrep "^event: abc/def/xyz$" ./insensitive.trace
+'
+
 test_done
-- 
gitgitgadget

