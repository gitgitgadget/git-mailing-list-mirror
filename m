Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870A3C433FE
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbiCVS0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbiCVS0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:26:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA458FE45
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:24:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id q20so11867388wmq.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fpp+VSFtO8Ks/JINfvbBSypJdw7fJ1NuYrbBZJ7ri20=;
        b=CObvgVuLO5hAI02DWKcFva6SDl73muVO1/i0cPqgcd8SQryab/pJarv2Tt0NjTCY/0
         lkIMEC19fGMWuqjWKzR2AgbF4dDaYV2Xt1BoJl3X9TbiFvG3d9u/AVOhjEMJNCI0LjQ4
         v/feF2v2VXLlz5jI7Rjk8OcOuGCGBhFw6hSRjUjJP0Rrrc9tmS2xOluDi0mOeC1iOQSS
         SDDwkmd2hPsBd8/N3imSbtWSWOboV8cZ/rpTcoI50UkBAT+BV4fwF9mq20oRZ6B48zko
         bgub7WHRnzxfN+pGH4RaMPFCNZvcPcDYH4yuJqOllTIjgWWnC0Ef+90kWbS2wkEmxMRF
         C0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fpp+VSFtO8Ks/JINfvbBSypJdw7fJ1NuYrbBZJ7ri20=;
        b=02GdpKvdC84Ed34aBNEbXfVtGyutTEaSTlJFiTpJRe+kP2zVCbdS9vofgz4PqiXwjF
         irtAJOrDdXMUilcQ1yipVJ6/dF1y+P0M6lSZEqb15UFOrUP/9Zl3pK7WgqqN70RQV9GP
         kGQ8njR+0w+3rdVubm1FYtkgHxANh1Dptt/q9CdzLM3zFTmg9j0DPk0f7jr3am8I41/B
         4mDZDaD99wJN3wt7FkVLGbM7xwrffWEZI/U1Tv9ACUp5m4q63RcOwK+IAIlxfgDun9rz
         4hWVW2KM8w4hUDSW8+KBGOUc9f3qEAICz+VjXPoOCscpn0mHsIluw00xF7ciISEOF5Wd
         aJPA==
X-Gm-Message-State: AOAM532UW4lJCEeHKLAY69L9Za5jVGK1uxa9S+3jej/NaVFVzYPqZzio
        jDJNja2PJzNCxmqMWlT5kUn75Y7pUN0=
X-Google-Smtp-Source: ABdhPJx9oKSlH/KxwUlGj2XKc/BUBpn0iMJcmFWEUqdJwJ5PTuy2bww0d8/ZqGNk4Ru+3zX87NynDA==
X-Received: by 2002:a05:600c:22c4:b0:38c:70f5:25a9 with SMTP id 4-20020a05600c22c400b0038c70f525a9mr5078963wmg.119.1647973443287;
        Tue, 22 Mar 2022 11:24:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d4d0c000000b002057d6f7053sm1203356wrt.47.2022.03.22.11.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:24:01 -0700 (PDT)
Message-Id: <5d0fa19929d8b326786f967f8e7ba40b2bc834d2.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:57 +0000
Subject: [PATCH v3 24/27] t7527: test FSMonitor on case insensitive+preserving
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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
index 39efed42a69..51cdf05e7ec 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -811,4 +811,40 @@ test_expect_success "Submodule" '
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
+	start_daemon -C test_insensitive -tf "$PWD/insensitive.trace" &&
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

