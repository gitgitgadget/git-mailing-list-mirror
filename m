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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286E2C49EA3
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 00:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC0F613BD
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 00:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhFSAdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 20:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbhFSAdg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 20:33:36 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E34DC06175F
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 17:31:24 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id r1-20020ac85c810000b02901fa9798cdb5so8856439qta.8
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 17:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FD5hcH6TGsKG1jGfaoqsS6DaiS/WNMR5Nj45sxbaHSE=;
        b=tH2nP0bdTSRdMQc2278lvbAp/ayo5cYjoHCjGJFggcrVdJaeFM161PnQviDM/HfePT
         Vidn1deJyY7o/3RZvWbeo30/9vY4wu5GyqpP2PMf0EheOv9mcp3LWT7SXXcUcfLPsKwh
         w29eVjpm/4/tVdMr4X+E5nea2W4lheJKQKoOpaGxXiORUbBTQJb8oF0GPG4Z9+jN9AVk
         nPY1yMiHtq6wNGiD9hEZ2DhR3hH8UMRTr8LVYKnRXiyhP6z4EYfH8AAr5BrAzuUBEpcq
         LMU9ob4QdpAIYGzVDWbYXAK+eeP0cdyp/LAYQKP8IsnRuHgNpHEEAkjwXIOnvmlqsb7o
         +IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FD5hcH6TGsKG1jGfaoqsS6DaiS/WNMR5Nj45sxbaHSE=;
        b=DjI+CeMSEDnvd+Z8itUdcuzPGnImssl3LnWYyPS3DdSKQYGSQccLSDBPfUoKZ404TO
         TtHlCAOL7rJp1DPNlY9BwRhEzncjUnZWPNBkEItKdXx2YyOTmeTGcniu7MW3/kdGAC8l
         Is3FN2YOLSYZ9A57ANOA/q2h6Ed6Pr5vW7XSbdptio8GCqAQ4GeRHJ9Guu1HykG8o/Vu
         qhtoPtrbHP2QhynZbe+a4R/fxNkh865n5HQl6ptw+No6tWSx6/iAInpv52Pj3RHL2e9p
         rzH1VCVRHBmC9GWlDFhu+NnGhxgrocda3eYbPSJQKoGA8mmvyaU79jdgfI1kGWJsqdKW
         H/lA==
X-Gm-Message-State: AOAM532alafFnx6P9jdjTJy+izW2DimdGHhDAmwDlYDzE/XffoH9wDym
        7iLGi0bzsCg9aLr12mmbfiXL96Hi9YeXJleHN53e+qXio6QcEhOS5ISAQeS2nosFK6dzxSkzYDH
        Y2N8MjXq/lYQp8mIJ6TUet+n1JUB2UErNodEEm1N4ZFzCxhXUqmEQwBea+i6NaL27wFFRx2mpUg
        ==
X-Google-Smtp-Source: ABdhPJwo86avQyP29adO9ZSfehxyzWauVDO3kyxumP9vBanEBJTTAScCwxiHuAaq0x6MZKDU3Punr4xRjCVJUNoliGc=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:551d:e7ea:4a2f:6667])
 (user=emilyshaffer job=sendgmr) by 2002:a25:888e:: with SMTP id
 d14mr16019401ybl.443.1624062683386; Fri, 18 Jun 2021 17:31:23 -0700 (PDT)
Date:   Fri, 18 Jun 2021 17:31:16 -0700
In-Reply-To: <20210619003118.1352300-1-emilyshaffer@google.com>
Message-Id: <20210619003118.1352300-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210619003118.1352300-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v3 1/2] config: rename "submodule" scope to "gitmodules"
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prepare for the addition of a new config scope which only applies to
submodule projects, disambiguate "CONFIG_SCOPE_SUBMODULES". This scope
refers to configs gathered from the .gitmodules file in the
superproject, so just call it "gitmodules."

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 config.c           | 4 ++--
 config.h           | 2 +-
 submodule-config.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index f9c400ad30..a5fc4cacd5 100644
--- a/config.c
+++ b/config.c
@@ -3516,8 +3516,8 @@ const char *config_scope_name(enum config_scope scope)
 		return "worktree";
 	case CONFIG_SCOPE_COMMAND:
 		return "command";
-	case CONFIG_SCOPE_SUBMODULE:
-		return "submodule";
+	case CONFIG_SCOPE_GITMODULES:
+		return "gitmodules";
 	default:
 		return "unknown";
 	}
diff --git a/config.h b/config.h
index 9038538ffd..5faa72f3f5 100644
--- a/config.h
+++ b/config.h
@@ -42,7 +42,7 @@ enum config_scope {
 	CONFIG_SCOPE_LOCAL,
 	CONFIG_SCOPE_WORKTREE,
 	CONFIG_SCOPE_COMMAND,
-	CONFIG_SCOPE_SUBMODULE,
+	CONFIG_SCOPE_GITMODULES,
 };
 const char *config_scope_name(enum config_scope scope);
 
diff --git a/submodule-config.c b/submodule-config.c
index 2026120fb3..ed8e671d17 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -637,7 +637,7 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 {
 	if (repo->worktree) {
 		struct git_config_source config_source = {
-			0, .scope = CONFIG_SCOPE_SUBMODULE
+			0, .scope = CONFIG_SCOPE_GITMODULES
 		};
 		const struct config_options opts = { 0 };
 		struct object_id oid;
-- 
2.32.0.288.g62a8d224e6-goog

