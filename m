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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E26AC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879E6613BF
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhFQRPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhFQRPn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 13:15:43 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3CDC061760
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:13:35 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id e14-20020a170902784eb0290102b64712f9so2060196pln.10
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Wezj+RNfRGs1nzz2/Vtw8tnsSdlZvdY/E3su3aS8IPY=;
        b=qFscNkddpXgeXs7xdfGVHCfB5DB9eHq7wHDYyA/IAKiGYxVooqAmxIKGKXQe4ofsf0
         n8a2UH05IdpmZZLa1r+spPdKuvnwNF/NVj1CLwKhYqpQu9VYrMIRTqQ4c7bJO8cQbr2a
         XH2k8YlMEoQQOFw8Wp/hwDOrzC48NyATTga2GzPJVjPdO9VSHMkdBOS0jy9vjU67aLuM
         HcUDGKqx1wjJmq4GMBueoWvnDm94pCWrsfRHJNk6FJGrpIrPJcWmIcA0FmHuWN6dOaR5
         3jpNJBdMGpnOPKZCS18uk6PldGAEZk/2HmSjpDLvZtgRKiqEo8i5ZfAjPwm78LeOlA9Z
         Z/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wezj+RNfRGs1nzz2/Vtw8tnsSdlZvdY/E3su3aS8IPY=;
        b=bFGumk5+KVXwAJhZQoNlZUB3FBXe2qKw4FRbTftoFHCMcw8nCGxIHLOut8jpmftbn9
         6KKQt8DWmAdAb4XnRA4Cc9t3WglEzwUbU6zboI3FMAmHuD2hHz5UamWEfHqBwzY/D5Ab
         3LsYN6HWQZsdZFBrgAZ+zQlQGSQVPw/EL5+Z3ovUh65pIckFBwCXaH2DqGEQcyCEl6/p
         IrbyJ6d4/NpLinphp/u9hLFCO7fzIT8tOm2wv9zn+5kKO4Rw8UoOQkJhKlDzrzy9Wt5K
         nO26lyVO1MHYuzdPL2cJ3+D80uQqaqFPM7g6mqDV0FJlULK4+Q/S8+Tx9u5OqBxvJUgX
         GCtQ==
X-Gm-Message-State: AOAM530SJexx09eavjqlOF5GvXDgFyL3E3DAPVky/Si+JKndxZbJwxo9
        eOJ7rf9b9zjgiJF6Kbf0xG3svIA+7QdE5RxpZbZFmWvQ1VSAUGQWfleCPw+dihEu0zRCb++RG9k
        tfl5TmFgLnv57uYpuCwiO4YWMPNMpB39Zc3zZjxuXTydfC9smGuvitD0mY0UJlWzLlFnTwjM36V
        ad
X-Google-Smtp-Source: ABdhPJyec1kIe6DrzbFiW1zjAvBeLNE5byJga3RdMUYbwlQt5DuCyIJeLjf0RFS3QWTV7Be2Xg6Fg5a0XPE4U1326oES
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:b618:0:b029:2f9:f3b1:8afd with
 SMTP id j24-20020a62b6180000b02902f9f3b18afdmr767153pff.81.1623950015197;
 Thu, 17 Jun 2021 10:13:35 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:13:24 -0700
In-Reply-To: <cover.1623949899.git.jonathantanmy@google.com>
Message-Id: <78b4108ae17f8ebd0113bffc736a7ac4c62c3adf.1623949899.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623949899.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v4 3/5] submodule: refrain from filtering GIT_CONFIG_COUNT
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, newren@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

14111fc492 ("git: submodule honor -c credential.* from command line",
2016-03-01) taught Git to pass through the GIT_CONFIG_PARAMETERS
environment variable when invoking a subprocess on behalf of a
submodule. But when d8d77153ea ("config: allow specifying config entries
via envvar pairs", 2021-01-15) introduced support for GIT_CONFIG_COUNT
(and its associated GIT_CONFIG_KEY_? and GIT_CONFIG_VALUE_?), the
subprocess mechanism wasn't updated to also pass through these
variables.

Since they are conceptually the same (d8d77153ea was written to address
a shortcoming of GIT_CONFIG_PARAMETERS), update the submodule subprocess
mechanism to also pass through GIT_CONFIG_COUNT.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 0b1d9c1dde..f09031e397 100644
--- a/submodule.c
+++ b/submodule.c
@@ -489,7 +489,8 @@ static void prepare_submodule_repo_env_no_git_dir(struct strvec *out)
 	const char * const *var;
 
 	for (var = local_repo_env; *var; var++) {
-		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
+		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
+		    strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
 			strvec_push(out, *var);
 	}
 }
-- 
2.32.0.272.g935e593368-goog

