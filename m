Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7757FC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbiBJJaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:30:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbiBJJ3b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:31 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB6310FD
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:29 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id w12-20020aa7858c000000b004e02ef665e7so3968986pfn.15
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PimCtu4h/hGqS09q6THQe+qzeegstCZeV0OHpeR3Y1Q=;
        b=FRGb+ZPWbwPXKwmj3K6Z10/VkQIQmVvn6/4YCoX9HfVPJQBHMNN+R/h4K9z7x8JKdv
         pOBkc3OPVz1f4ROem88BE6h8AEm8rLCwCyTozYw2Wh6jQm08k+yCkjGjblJ9hWlGDG8O
         HM/jB65o2ngzvLBHZ/D6t1NtmbiJKS57anEiYv9/YGLLAUYHeaPJ2TbhAiTP87iQ6s+a
         3WJjQZFIuVoeVwKlFmna6SLy2jtuwKVcZFWPXEQz7KdtuWBSfnCR/cfnhLzo3jHVmokA
         K9wCJK4LU8bAM/bE4tkRVv1frrB+xUb4UNLc5b+R042jCuXsVDg086S/m98k1FOn4QhN
         KOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PimCtu4h/hGqS09q6THQe+qzeegstCZeV0OHpeR3Y1Q=;
        b=JajDq0bCJKP1PRm6GCDcVR4CGShK9YT+0Ht5j37NMOddAFN4o5r+CTCrOLy/5eEgUP
         a+K+U4dSUg1otk36pEETEbkVUXDrXcD+4/6PdhQ0fNUSoYlbX7XXcNpK4I6qXRyoulMH
         Pt+sVpYko5mhYAXM0yKdr6izsG7ixrrPfibPdxbuf3ULJNkvcYCTI9nigpa+tZ4jn7QC
         jrEDyREssucocjG/meVAtVjM4Cm/3yhy/LJ3kZACtMglW0EicXQh/RAeIFFS3uHwA/iu
         TITGnZp/7RpsxBUi5YMErXLnVfi4S9vMjgy3yvINQNI+PeLOidU84z1IrZwjAjh3ZwrN
         L5TA==
X-Gm-Message-State: AOAM533KvfAHZGqPq49NdkgrMKEbd/omk/0f0S3L8YR7+trOba9pvGBR
        JKMbtrb/qsmAjlAwNNFMB68uLo6WkBovP6YcXIz11pnbU2J8ZKtr9HoCh82KDwxqWbRr4I4BpP+
        mlY39A9FMzm0ysENzJamk5LuvYeyBbgZi4vxjtruqqAO/ft11nWhPMbdnFapezDM=
X-Google-Smtp-Source: ABdhPJzokLNBne3NGRIXcZtfiatvOiX7EgRw5+e4VKjihssUmWyaTKOnsiNEiZkV4vB67i7ydhTLvGAbi7Qj8A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:7e06:: with SMTP id
 z6mr6603743pfc.60.1644485368912; Thu, 10 Feb 2022 01:29:28 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:32 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-20-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 19/20] fixup! submodule--helper run-update-procedure: learn --remote
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 98d8910930..5d5302b50b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2516,23 +2516,6 @@ static const char *remote_submodule_branch(const char *path)
 	return branch;
 }
 
-static int resolve_remote_submodule_branch(int argc, const char **argv,
-		const char *prefix)
-{
-	const char *ret;
-	struct strbuf sb = STRBUF_INIT;
-	if (argc != 2)
-		die("submodule--helper remote-branch takes exactly one arguments, got %d", argc);
-
-	ret = remote_submodule_branch(argv[1]);
-	if (!ret)
-		die("submodule %s doesn't exist", argv[1]);
-
-	printf("%s", ret);
-	strbuf_release(&sb);
-	return 0;
-}
-
 static int push_check(int argc, const char **argv, const char *prefix)
 {
 	struct remote *remote;
@@ -3484,8 +3467,6 @@ static struct cmd_struct commands[] = {
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, 0},
 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
-	/* NEEDSWORK: remote-branch is also obsolete */
-	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 	{"is-active", is_active, 0},
-- 
2.33.GIT

