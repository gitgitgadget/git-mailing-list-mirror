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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8FCC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 00:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00060613D8
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 00:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhDWAQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 20:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhDWAQV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 20:16:21 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA25C061574
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 17:15:45 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id n18-20020a05620a1532b02902e4141f2fd8so6547553qkk.0
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 17:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8g6eVnz6G2/KSY/HPB+pN5ILrUJHZvXaEYO/mDwxxaI=;
        b=kDsp6eg2paxhqqEXdpTVNjkXOIqrYGwpO5NR5BsRYr8wDNT0RXIT1C4p10RWOtbr20
         FVOHROD+DEpmlBqe64itMes4gDjPfbeQpdZPM7pZ4wCt0ueXQ/+5GhYISF3z2wQEUxt0
         1+pml8a6+V9MW+5VNf3Ko1cU7x+C3bVL0h8p//ukhzFH8BsZRH1RAo32xL53/eIm95fd
         YvdFgOappDcMlqvZ0IhbLNBMzGuoQjroeAAapIu5LTpABJ5E3NM5TUJuWQPmQ3qeHKmv
         i4HXT/qkj4uQgGLt5JcuGfVZMR1Cb0g/xKfF4LT+vLpQIJ4hEpQN/aqMPCVH31wd7Wmz
         yFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8g6eVnz6G2/KSY/HPB+pN5ILrUJHZvXaEYO/mDwxxaI=;
        b=oQY0rCfBoIfIrQ7J6CeVcdOp9Csg85ocYl2znU3aEtldSZpPcdegHnzU8xskmsCjFe
         REqg23OxfoumuD3tcz/xqbmfTq23aQh4E5juCCDPT1rrzkPpUH1MTC7X3DyMsll/AH4y
         rIwYwJ9WWmeaCKdELeKoO9qh01/K4GDmPBC9Pri2cn/S78Efl4ktpkKousQy8jmRabV1
         fQJvfaDCoq5/aGkRe+adlIByhozFLAFGwzwv8sPxPkEb0rPZaOeCGWabEDBKgJbC0vsc
         DMfryTbG8fi6BIP10JPIwqN+fBhxEBpQstrXv04xp/C0AMA4g7UGx6/QIp9vWXcnH1cd
         i2iw==
X-Gm-Message-State: AOAM533utbQ7LNxTNnODY5ZMw/+I/UPPv1Zf+qD+bGGidxix3LjHpi/G
        xEO9syZLllztR++P014MaQUWBthkzGZ8jxxbKp5OtxOboXVfKQBjqfLB+A4o2tVZYkFizEzgezr
        6IXr3aGqbAA0I160QmVIxhCJ1SDD2HYBSgOolR6JuzidmkD7SkG7q/ynb6T6PWzVJ2U29ZRaabw
        ==
X-Google-Smtp-Source: ABdhPJz1ExnH73VKg5RnWQAjzjc3Dl+4LImhFWgnbZ1QUSghsbkAdOYTY52s0gQRmyyRAm98BfG4G477c+zjU+nspU0=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:fe4e:1417:67a4:42aa])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:db82:: with SMTP id
 m2mr1247011qvk.37.1619136944817; Thu, 22 Apr 2021 17:15:44 -0700 (PDT)
Date:   Thu, 22 Apr 2021 17:15:36 -0700
In-Reply-To: <20210423001539.4059524-1-emilyshaffer@google.com>
Message-Id: <20210423001539.4059524-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210423001539.4059524-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [RFC PATCH v2 1/4] config: rename "submodule" scope to "gitmodules"
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
index 870d9534de..c8426ef3f3 100644
--- a/config.c
+++ b/config.c
@@ -3499,8 +3499,8 @@ const char *config_scope_name(enum config_scope scope)
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
index 19a9adbaa9..535f5517b8 100644
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
index f502505566..0e435e6fdd 100644
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
2.31.1.498.g6c1eba8ee3d-goog

