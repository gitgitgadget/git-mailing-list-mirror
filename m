Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF1BC00454
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1022C20692
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0DP0MDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfLIQKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:10:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36630 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfLIQKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:10:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so16858912wru.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 08:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i6FS5Z9erfGEDfl+U8ls7BzR3WgHycQ1uiew02661W4=;
        b=A0DP0MDpS/0GvxbUTIotai31DRsIJsUAtnkQww6NaDQdm+mBPN58XAxu9NUHSsmkRO
         IBU5xxp3NVdg0fRnmKsNpI7yvYqKSU36nOW9z8GgVIJs1Z3Vh8qojlFwbEHoS12lkzMU
         lx5UG8HgvTMcR4WUFRtBxP967QkxrqaRVo7+gpq1UjsMuDaSi/HtvKxLx6iDG4Ql5YuR
         8/eyu9m6WgUYOVNS0ovcaJojYq0qlKyodRofJLxuImkgciY/tXK8bDqTuYW5sF+2WYuW
         qnhgzTfzQEwx2GTRthY1qbBzAM6gVv+wb1kNoxrhWc0owpfmxsY954J7HdRGM77/OAM7
         jZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i6FS5Z9erfGEDfl+U8ls7BzR3WgHycQ1uiew02661W4=;
        b=HuZtL+trwLuzMX8JZIRjC/5lUaJmdFXvGH6rwbtsmpj98O93gbyBUEQ8WpF4IGdy5+
         R2p/MNV48YaE8WfgK5v+tiKA0uOwd4BULq53z+UiJn9keA03KvQwxJvdbTrHrNGhY2+f
         jeKJ490ihb/HaGMNSb8tnwZ3ZhgFKidGt4taOEEVMTP/9wGhUCYlMmK3WDTGDlr0F8g7
         PkqRDqB/70dw24lh8Dn/vNHucYQZTSiCg06ZCPNP2Y5ggXrao9ePKIxJmXR1XNEGhArL
         FQev+RtxhxxFd1YPoMP5u5Ak3A5rwHcz8fztx+o/1I4AQbQPwHrzWhUrEMZyeibENm9z
         djHQ==
X-Gm-Message-State: APjAAAV9jdFoMSwbY407jm7SEcPclbOU5B9Tm0v6zygTRmX0pk2Xs5fp
        1iPLi/SG5Jf10ZwHHnWhw0lfQ0VE
X-Google-Smtp-Source: APXvYqyl0cYzwBKn8D26AdNORNxnVw4ue38yRspCWlPfsL/6fqOr8F/zOaduZf8POtSsuzqoG8eJzA==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr3043997wro.202.1575907807687;
        Mon, 09 Dec 2019 08:10:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm26594450wru.44.2019.12.09.08.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:10:07 -0800 (PST)
Message-Id: <f9db0c3416ff50587bffe46bb00268d8094c1ad7.1575907804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
        <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 16:09:59 +0000
Subject: [PATCH v2 3/8] t1301-shared-repo.sh: disable FSMONITOR
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The fsmonitor feature allows an external tool such as watchman to
monitor the working directory. The direct test
t7619-status-fsmonitor.sh provides some coverage, but it would be
better to run the entire test suite with watchman enabled. This
would provide more confidence that the feature is working as
intended.

The test t1301-shared-repo.sh would fail when GIT_TEST_FSMONITOR
is set to t/t7519/fsmonitor-watchman because it changes permissions
in an incompatible way.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1301-shared-repo.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 2dc853d1be..665ade0cf2 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -128,6 +128,7 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 '
 
 test_expect_success POSIXPERM 'forced modes' '
+	GIT_TEST_FSMONITOR="" &&
 	mkdir -p templates/hooks &&
 	echo update-server-info >templates/hooks/post-update &&
 	chmod +x templates/hooks/post-update &&
-- 
gitgitgadget

