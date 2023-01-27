Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989B3C38142
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 20:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjA0UH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 15:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjA0UHd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 15:07:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA78088F1B
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 12:06:09 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h16so5923743wrz.12
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfX3lc/XiAOcU9xX1dRHC4SL+HBuaAQND5EObLBEmac=;
        b=pOUpQGYVDUrW3P6na3RDsM7suH3MbeJhl0/bkrhDGJt4sTk7ws7Rxz+db0h5/27zon
         WTkf3VmqYe8Yt/AVEdP8ugnZx6ESEwoL0m4TLq7E2CSIX+Cpj89Yita0gp87llqhlpSC
         ++UcsTmfVSSsh83L/P54MAK7G+N2KlPMpchrT5lBoul1W038UOOzxz9JHWKJJg/XOKpL
         i93L/wV9SUKg4PRNYmz62X9Q/sIAoGpTJ2mjHlOkGd4WjwDlw5p26avMHM3s71T7mqYw
         I1IFfl8tl/4VNvsNsX3RnBCSYq0Q2V9FGGul0fBWuGXp6YaJXnlgd8pxFwXjs+cLU4Pq
         dlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfX3lc/XiAOcU9xX1dRHC4SL+HBuaAQND5EObLBEmac=;
        b=ZemvrwiioRwm7pABUdSPOVi/SFeLyl/xtATHof7G+wRETsoGpg/hEwOE3tV945u6s3
         HYCldkV4NztIT7Echrrgu3dfWdkLWHpTLTIFOO1hYKBSpkLN1oFOSM6BuqAbSR9yZ30B
         xgMZMTciUrm0EIL4B4fW4d1KwCMR5Kj7mEQQkS9KqnB1G1oWCYUVOwFCZ3oGCTIKaVEf
         f9U8SJ3fQZET2Jo6iv8Q9tGJHZ4jiUmjazu8w36LQKE+Bjw7EIEw/Y619Cw1aglX9sg/
         FN6l4Kc7NqvOnAzJ16n5ykIAsxTak26OZQKRaWr4dmet33/ZbBFgNWgRa6/VpRvtD2uG
         99Pw==
X-Gm-Message-State: AFqh2krhXk72wRRt7NYT35S0kLQF6PS26dQJMRwonMIj9V6IKI1ZUhys
        QAL7c2JuaUvP12Gu9uKDr7N3t9COgsc=
X-Google-Smtp-Source: AMrXdXvZkGNx0X6v2j0mgRGyem8N5RHH6qc9uYBaZoQ3qG21cZ48xLydrz248iW0a7+HuPsv8W5OgQ==
X-Received: by 2002:adf:b604:0:b0:242:1809:7e17 with SMTP id f4-20020adfb604000000b0024218097e17mr34399128wre.6.1674849966684;
        Fri, 27 Jan 2023 12:06:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2-20020a056000180200b002bfb5618ee7sm4835144wrh.91.2023.01.27.12.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 12:06:06 -0800 (PST)
Message-Id: <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Jan 2023 20:06:03 +0000
Subject: [PATCH 3/3] scalar: only warn when background maintenance fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

A user reported issues with 'scalar clone' and 'scalar register' when
working in an environment that had locked down the ability to run
'crontab' or 'systemctl' in that those commands registered as _failures_
instead of opportunistically reporting a success with just a warning
about background maintenance.

As a workaround, they can use GIT_TEST_MAINT_SCHEDULER to fake a
successful background maintenance, but this is not a viable strategy for
long-term.

Update 'scalar register' and 'scalar clone' to no longer fail by
modifying register_dir() to only warn when toggle_maintenance(1) fails.

Since background maintenance is a "nice to have" and not a requirement
for a working repository, it is best to move this from hard error to
gentle warning.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 scalar.c                | 2 +-
 t/t9210-scalar.sh       | 4 ++--
 t/t9211-scalar-clone.sh | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/scalar.c b/scalar.c
index f25d5f1d0ef..ca19b95ce46 100644
--- a/scalar.c
+++ b/scalar.c
@@ -262,7 +262,7 @@ static int register_dir(void)
 		return error(_("could not set recommended config"));
 
 	if (toggle_maintenance(1))
-		return error(_("could not turn on maintenance"));
+		warning(_("could not turn on maintenance"));
 
 	if (have_fsmonitor_support() && start_fsmonitor_daemon()) {
 		return error(_("could not start the FSMonitor daemon"));
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 13a4f6dbcf4..4432a30d10b 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -104,10 +104,10 @@ test_expect_success FSMONITOR_DAEMON 'scalar register starts fsmon daemon' '
 	test_cmp_config -C test/src true core.fsmonitor
 '
 
-test_expect_success 'scalar register fails when background maintenance fails' '
+test_expect_success 'scalar register warns when background maintenance fails' '
 	git init register-repo &&
 	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
-		test_must_fail scalar register register-repo 2>err &&
+		scalar register register-repo 2>err &&
 	grep "could not turn on maintenance" err
 '
 
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index a6156da29ac..872ad1c9c2b 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -174,9 +174,9 @@ test_expect_success 'progress without tty' '
 	cleanup_clone $enlistment
 '
 
-test_expect_success 'scalar clone fails when background maintenance fails' '
+test_expect_success 'scalar clone warns when background maintenance fails' '
 	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
-		test_must_fail scalar clone "file://$(pwd)/to-clone" maint-fail 2>err &&
+		scalar clone "file://$(pwd)/to-clone" maint-fail 2>err &&
 	grep "could not turn on maintenance" err
 '
 
-- 
gitgitgadget
