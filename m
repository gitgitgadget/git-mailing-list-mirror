Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BD7C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7878760F46
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhHPVKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhHPVKg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:10:36 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2FCC061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:05 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 61-20020a17090a09c3b029017897f47801so351164pjo.8
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=687v8D5TYXa4xyKEui7hwtnSNbZL7ND1Y9SjR+Ep8vE=;
        b=jeMLwhkSx/FdiMmF9yKWxUIjG/vBMAxOsncR1tpeiWzS3+H2ej2TqcfkWnN1z5yt3X
         VGh58WfaoclW6qoT6RAWLEh4WqWYNUbESr769GfHJbDXZSeKSqB4Sn9S7QX/ecCLLYbN
         jdQlKnItFnLDmpQxgBv/DToGPUVXxjoI06gEOscqshvzlNOVq6RtrVujdO1EiRyMrJVm
         2GmPIxVudiGYrPE9MJtAkYnuZ7ryXrFhYHHmB3FTCep5WfMktn7X4/IgjadRLQEUX1vN
         0gN/sLK4nnn9twtJx9wIGq0xsglGCFjA7QTlr1WqADGquDUaWscWZIB6TUFXmxFusRWC
         ROcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=687v8D5TYXa4xyKEui7hwtnSNbZL7ND1Y9SjR+Ep8vE=;
        b=SQ1ULkX8kzPWGL0CqbjDHj43JyQYpjCSXhbZlCOkDd9In6V4Zj6+E0P+ecKSIQTN4J
         HSGbhsCJMeEI6wRByPO1ut7bru33QoJaqjSC4bOBM0HN0K36g209YajOrkgNMwW8eKjd
         7RK6Tg6fd1lkTQ5xyjVkkSEu7oUKIyJ4qTDkTIs5BKFGgaCJwR99M2czrzElziJfsGix
         PjQelP35bEnxzjtT51MlTiBOkIhhUATMsPO+sSxxnOrD86dJKoTdNyUpYLvyWiqm/GJo
         lsHEVP0JZOHwqTLBdqYQcxauAz6lOP6h+EbtPdq6zSLZTas9/YX6U41nCUwBfz84uow8
         NzWA==
X-Gm-Message-State: AOAM5334g3LLFRNx73a8xnjdYIqz1Y6MBx9Ytp1Yu/QY20M3LhvITq5i
        yOFDMp9tz4+TBW9WqSedqJSQcY6btOokdK6bCWGRP1/ZECwkq9Qu+2LgV81YdAZq8RrGj9SfT16
        yXRTfeDX5wfrbtqvneD8Mxnth4batjdOr4FovpTX5JHINoD37deqzcrYryWp7JshrF0ka+WscJu
        gU
X-Google-Smtp-Source: ABdhPJxexvKnQ1uz9gNElLr7Pruc73po2qdtNwN2XhACgw6cbDF42UrKL99bBxKN383amETwoIYUpWDbYPv66stIwFUN
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:e90f:0:b029:307:8154:9ff7 with
 SMTP id j15-20020a62e90f0000b029030781549ff7mr421497pfh.79.1629148204472;
 Mon, 16 Aug 2021 14:10:04 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:09:52 -0700
In-Reply-To: <cover.1629148153.git.jonathantanmy@google.com>
Message-Id: <31e9b914c4bb500a98fbb14674c93a0d8ece47a2.1629148153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1629148153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v3 2/8] grep: use submodule-ODB-as-alternate lazy-addition
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the parent commit, Git was taught to add submodule ODBs as alternates
lazily, but grep does not use this because it computes the path to add
directly, not going through add_submodule_odb(). Add an equivalent to
add_submodule_odb() that takes the exact ODB path and teach grep to use
it.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/grep.c | 2 +-
 submodule.c    | 5 +++++
 submodule.h    | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 7d2f8e5adb..87bcb934a2 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -450,7 +450,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 * store is no longer global and instead is a member of the repository
 	 * object.
 	 */
-	add_to_alternates_memory(subrepo.objects->odb->path);
+	add_submodule_odb_by_path(subrepo.objects->odb->path);
 	obj_read_unlock();
 
 	memcpy(&subopt, opt, sizeof(subopt));
diff --git a/submodule.c b/submodule.c
index 8fde90e906..8de1aecaeb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -187,6 +187,11 @@ int add_submodule_odb(const char *path)
 	return ret;
 }
 
+void add_submodule_odb_by_path(const char *path)
+{
+	string_list_insert(&added_submodule_odb_paths, xstrdup(path));
+}
+
 int register_all_submodule_odb_as_alternates(void)
 {
 	int i;
diff --git a/submodule.h b/submodule.h
index c252784bc2..17a06cc43b 100644
--- a/submodule.h
+++ b/submodule.h
@@ -104,6 +104,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags);
  * the_repository.
  */
 int add_submodule_odb(const char *path);
+void add_submodule_odb_by_path(const char *path);
 int register_all_submodule_odb_as_alternates(void);
 
 /*
-- 
2.33.0.rc1.237.g0d66db33f3-goog

