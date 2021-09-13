Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618D0C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49AF5603E8
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347019AbhIMSN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346893AbhIMSNt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 14:13:49 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E50CC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 11:12:33 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ib9-20020a0562141c8900b003671c3a1243so56478320qvb.21
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hy2fjb6p6+BvE64Mta7TV9v7wszaIBvq4gH9B4CczUI=;
        b=s1g2se8h29NhY70612yEV+9KkV1KrB7as8FAHP/PaqBVjQ91bezzFmetDq1abGWDq8
         /RF33c6066aybCqDvU7Vmg7IiPbkqzsPRr1JJOj8BHVeve1p2HrVgcKbDn3a/NjEqKkD
         APIzmMqIBkI40UMH5nN9GoF0lzXcoZUz3c1xnmLg83NYsuxWjMxfZjgIck8+4tMTSch1
         qpBFiF794Kp6VsUfr14tyFjsrjKHMP+3XICj2sCOxACRledVv4U1FsGqLYwuAFPhbp5K
         upX/Q3SGc2p7zvQvWj72wDGsOeza/I2d7LmpgRprOesI7GsMaEPtDsGlgJ+8lactGYy2
         9TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hy2fjb6p6+BvE64Mta7TV9v7wszaIBvq4gH9B4CczUI=;
        b=lpbEruhMgCQXqDRlVeiDM7YPK/SEI3IPLhSzFjRVi+yvzgMY/CyjXFO1JIpVCpgLtF
         UDvH/R8KW26qv3KKP0BKuBYGzkRNdmGVIUIGoCdXvWPAmRiTQ4sxaDFCs2ZXHF+7o0Ra
         tTXYbIyr1k9qz5D14nN5ygD9jxfV+fH5VWlPoVd5YnwJNogAV3p8u+hFrxg5yEIADuCa
         K31acqVrDBCpAnr1VRXuzgtXsed/BPArmQJdlIshItn5Wp3HOzewtaEGQlyZfCE3n0CF
         q+jSwFiRHDJT21R6cDjT4cbPdJP/2YOw/lN+YrysKdxzXowpxfHY3BgKVBYXM2enG8W5
         XU1Q==
X-Gm-Message-State: AOAM5306sTTohPVda2w8L3ndcszwMdS8c/heX5it/ob7KHLV/UyI3NvA
        ZcdVX7nqAgH/98JRaQFjYGzS32cIeDMSdfnM2L97kYJW8W2Xted2H1fApVBAdyiLz4H1pQSJelV
        v2Re1SZVAXr6MjD4LFF1hfD3xiguiQjk3HVNJMrVEBs+7HprG+Lz4OJF0kUiWAFM=
X-Google-Smtp-Source: ABdhPJxF0XaE5TmO/e2JK7uQHrztPV71+aD6AOrSaBtQoDFp+UWOG1AkuhlB2x7aRR/2o6bfh/G8H3fa+3GGEA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a0c:fdc8:: with SMTP id
 g8mr1026074qvs.12.1631556752732; Mon, 13 Sep 2021 11:12:32 -0700 (PDT)
Date:   Mon, 13 Sep 2021 11:12:20 -0700
In-Reply-To: <20210913181221.42635-1-chooglen@google.com>
Message-Id: <20210913181221.42635-3-chooglen@google.com>
Mime-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 2/3] fsck: verify multi-pack-index when implictly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like the previous commit, the_repository->settings.core_multi_pack_index
is preferable to reading "core.multiPackIndex" from the config because
prepare_repo_settings() sets a default value for
the_repository->settings.

Replace git_config_get_bool("core.multiPackIndex") in fsck with the
equivalent call to the_repository->settings.multi_pack_index.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fsck.c              |  2 +-
 t/t5319-multi-pack-index.sh | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1c4e485b66..5bbe8068ec 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -925,7 +925,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (!git_config_get_bool("core.multipackindex", &i) && i) {
+	if (the_repository->settings.core_multi_pack_index) {
 		struct child_process midx_verify = CHILD_PROCESS_INIT;
 		const char *midx_argv[] = { "multi-pack-index", "verify", NULL, NULL, NULL };
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 3d4d9f10c3..1a17446cf0 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -404,12 +404,25 @@ test_expect_success 'verify incorrect offset' '
 		"incorrect object offset"
 '
 
-test_expect_success 'git-fsck incorrect offset' '
+test_expect_success 'git-fsck incorrect offset (config set to true)' '
 	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
 		"incorrect object offset" \
 		"git -c core.multipackindex=true fsck"
 '
 
+test_expect_success 'git-fsck incorrect offset (config set to false)' '
+	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
+		"incorrect object offset" \
+		"git -c core.multipackindex=true fsck" &&
+		git -c core.multipackindex=false fsck
+'
+
+test_expect_success 'git-fsck incorrect offset (config unset)' '
+	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
+		"incorrect object offset" \
+		"git fsck"
+'
+
 test_expect_success 'corrupt MIDX is not reused' '
 	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
 		"incorrect object offset" &&
-- 
2.33.0.309.g3052b89438-goog

