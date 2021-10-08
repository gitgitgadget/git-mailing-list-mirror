Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08377C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD4F60F9D
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbhJHVKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243398AbhJHVKc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:10:32 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83D8C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 14:08:36 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id n7-20020a17090aab8700b0019fb1ee78e3so6331320pjq.6
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mKIEFC+0c8za1wT1qlFOq/rs+zQroefTv/ez3t5+n5g=;
        b=j9kkpFaMXgD8apyO6BwkCI2t5RkLufIXUzElh7PBUXGhSn3QAgRYLV/magbzo7374d
         FxqwW0+WUsFZSqW7b2lVVZiwS4mhc8u3nlNL5mshZm8/gpnsvfHdcHKVby+sgrzxa3SQ
         gKPFiLomK2xvwl5HpNDVE5Q6Gl7CPYkvKA/GMsRu3PpyWNClMD6LjIEpec47iJjGHfeZ
         p4cCVNAk0b0G+JBdI9V+ZT8MxRfCKj/ivIVJv+tAnEV4tpHR/qwryXBb8Zi8GcQDqd4M
         ySlEQ9y2DdlNSCI1lTYPmELkq9bmoTG3PxeWcTxvOyy+s0z7ySr8hrwX+NNFbITPMbfa
         qYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mKIEFC+0c8za1wT1qlFOq/rs+zQroefTv/ez3t5+n5g=;
        b=rzVNUCtK4Aoh41no7pU1y8DKShqgTYbSQZXReBpKuosk9WMOSYJJFg69bHzSVjWQDX
         NxaU/SVXYJqf69GzpRD2RzYVRbF1eW9h7J5xKynD3GlGSsfh3POx8QBqTgEUnBTbCYdi
         gfvT/koNqZ6TL21p8/9lTkeK6wR4aq9KK5o7M+xeEGEwIEKdj1ghjZmI3FZiHs9QX7Ci
         rkQNY64OLBhK6tJV5k4X7hIb894C5aPhlwM9bmsTU07toKNpVAjIQmf8qSRTZZnGTqT8
         JJTykS3O4VUa2n84YZOi9nW2OQC9LmWER/acd6urZq8g+5Brb8N1+HSF70RTY6Vi5JNY
         04OQ==
X-Gm-Message-State: AOAM532Yqv/pc2h8QRIjO5x5R2Csj68XBIH1pqYX4i8OHoLWyMh40b8c
        Bg8xCwtWozpTUlMmI2Up9CwUtgdy9hF3YgV5mFv4yOaDqFpu4ilawB/iXOhwp7rcdsFYmJNnZmz
        LLbn4SNPs3yyJFEoB7hM9t29v7dtrr+UzPKj8PCDl6372yDoWFBqfyMzHocYyRz/qRmfIFlxJr/
        DA
X-Google-Smtp-Source: ABdhPJxDXlVuqTCedQFmpMdPU7D5FPS+1Wsjv7oo9glRQFRQPwl+FQ1CuTEIWbg0Zilo1Udrt5f35VgdPhNfQgQO+ZTy
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1585:b0:44c:ea04:26d4 with
 SMTP id u5-20020a056a00158500b0044cea0426d4mr2494189pfk.31.1633727315906;
 Fri, 08 Oct 2021 14:08:35 -0700 (PDT)
Date:   Fri,  8 Oct 2021 14:08:20 -0700
In-Reply-To: <cover.1633727270.git.jonathantanmy@google.com>
Message-Id: <8922bf48a2fcecfba0030c66f5ea7204b2600181.1633727270.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1633727270.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v4 7/7] submodule: trace adding submodule ODB as alternate
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, carenas@gmail.com,
        chooglen@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodule ODBs are never added as alternates during the execution of the
test suite, but there may be a rare interaction that the test suite does
not have coverage of. Add a trace message when this happens, so that
users who trace their commands can notice such occurrences.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 2 ++
 t/README    | 7 ++-----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 4bf552b0e5..61575e5a56 100644
--- a/submodule.c
+++ b/submodule.c
@@ -201,6 +201,8 @@ int register_all_submodule_odb_as_alternates(void)
 		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
 	if (ret) {
 		string_list_clear(&added_submodule_odb_paths, 0);
+		trace2_data_intmax("submodule", the_repository,
+				   "register_all_submodule_odb_as_alternates/registered", ret);
 		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
 			BUG("register_all_submodule_odb_as_alternates() called");
 	}
diff --git a/t/README b/t/README
index 51065d0800..b677caaf68 100644
--- a/t/README
+++ b/t/README
@@ -456,11 +456,8 @@ GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=<boolean>, when true, makes
 registering submodule ODBs as alternates a fatal action. Support for
 this environment variable can be removed once the migration to
 explicitly providing repositories when accessing submodule objects is
-complete (in which case we might want to replace this with a trace2
-call so that users can make it visible if accessing submodule objects
-without an explicit repository still happens) or needs to be abandoned
-for whatever reason (in which case the migrated codepaths still retain
-their performance benefits).
+complete or needs to be abandoned for whatever reason (in which case the
+migrated codepaths still retain their performance benefits).
 
 Naming Tests
 ------------
-- 
2.33.0.882.g93a45727a2-goog

