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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC5CC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B733960F6B
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbhIQW4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 18:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhIQW4k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 18:56:40 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17620C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 15:55:18 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id bi14-20020a05620a318e00b00432f0915dd6so15290468qkb.6
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 15:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4fxB2XIL1ZHFgU/RXDqhdfCDSd3gH6+YoOzl2ySGjkw=;
        b=ZgmxSdq8QrbqlcdbVIwcegC+MSasbX01GzFeu12x5CBAHCtOJw/Sf1YQYjX109Aw9b
         pMhaYzw6sXW0XXFjGThuhMOFieKvp7ERb1qis72LOkKbjlpYBEQwvcL7Wj8JnNO9+q0Z
         Z4tLXW/WEk+Nq7lqDYcqBZQGsLwYHcLT167ZHnWR+aJCs/iaLFhVgRLCk6GYb5egfTs9
         pLGC1Nwz5zVGN4OuLE/jskPVFy6J6sF9AFEoYlvL8vACX09Iwro6cLxYJoRFoL8b8vvS
         N7QdRgtxxQnHpPdb53VHOh+N1VzeuAc3vMqjGt2qWq1k8PllLtO5fA/UPM0Vz9kUYtSB
         h8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4fxB2XIL1ZHFgU/RXDqhdfCDSd3gH6+YoOzl2ySGjkw=;
        b=AFQ869HwnwHlGaFY4UF0F6w+RmLaJmBsNkw/izynE43WcmCho0F3iZelctfck/vwj6
         zAKj6JThbVyGPryKalN+TYn363F/WI5CxjIQBRPgjp1A2y/2oEYUO1FuF+o3q8Ofe3oO
         u73foTIUeVm4PpbE8izhATR5j1Qn05QTurmby7JpfYH7OlhX3oo09gRjDQObWwj4cqmM
         3pImvt7Mioj1qKnxixgE8q3nKiylF4GtGoFsVnSG+5SWSlRgqiEwmDrT7t3h4Pb0rc07
         F96wJ2z++F5DrgGdUSGU/8zwfuR5FGDK1BqdH0UcAuGOLN5/HbczmHrLEKbMtYE3UwS+
         l80A==
X-Gm-Message-State: AOAM531zj+EskQUzGsCjFOsP+iYgTSj3SMomVppdmyos8N9bLIygWcBL
        PQ9+ht2iPYRQKX4aDa5+Xa+J5gGjhT4WfZszPyM5Z2/UMHO9ilbtSrJPklBqrbotmFuhGtJpqrN
        R66wvRyNltt6CXqaFbSi0O5HaAAXYSX5ef8kMg8rJ47qbm/QkrNgA7HVLD1vQYM0=
X-Google-Smtp-Source: ABdhPJwVN6ax+pH5uqdfZ2SwPbELIbBcBR13p5zBFjx29o3d2SadttYaRsFdM2VykQogCSpWmzkoz87ZVsnDqw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6214:56a:: with SMTP id
 cj10mr13877690qvb.60.1631919317287; Fri, 17 Sep 2021 15:55:17 -0700 (PDT)
Date:   Fri, 17 Sep 2021 15:54:58 -0700
In-Reply-To: <20210917225459.68086-1-chooglen@google.com>
Message-Id: <20210917225459.68086-3-chooglen@google.com>
Mime-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210917225459.68086-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 2/3] fsck: verify multi-pack-index when implictly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like the previous commit, the_repository->settings.core_multi_pack_index
is preferable to reading "core.multiPackIndex" from the config because
prepare_repo_settings() sets a default value for
the_repository->settings. This worked fine until core.multiPackIndex was
enabled by default in 18e449f86b (midx: enable core.multiPackIndex by
default, 2020-09-25).

Replace git_config_get_bool("core.multiPackIndex") in fsck with the
equivalent call to the_repository->settings.multi_pack_index.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fsck.c              | 2 +-
 t/t5319-multi-pack-index.sh | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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
index 3d4d9f10c3..704db122b1 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -407,7 +407,9 @@ test_expect_success 'verify incorrect offset' '
 test_expect_success 'git-fsck incorrect offset' '
 	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
 		"incorrect object offset" \
-		"git -c core.multipackindex=true fsck"
+		"git -c core.multipackindex=true fsck" &&
+		test_must_fail git fsck &&
+		git -c core.multipackindex=false fsck
 '
 
 test_expect_success 'corrupt MIDX is not reused' '
-- 
2.33.0.464.g1972c5931b-goog

