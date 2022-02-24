Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E185C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiBXJqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiBXJqN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:46:13 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC2927DF33
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:45:44 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p4so767512wmg.1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=az2W3f24aofQMN06tQK0E2B1Jt/IJeHT7w5Vk9gWAWc=;
        b=b0QsW6RbBmdy2fnseFeWKJM87HitWjDxhZzRT2ydtfqSJX9tES3Xmg1sJNB1EiD/Uw
         sCh8TgNut+HJkH6h8mp/UfJhvQVesAreRqIdS3Xwpm9lJ10g00mSs1QhS4kx5ML+cMS0
         5rqvIHQbp91M6eIQ0ixirOc1z3wRwDkcvBsXWRERj4hQGcaoGsaGeuzCKQvBaB7dgjlG
         ERo2eNQw49NnKNMCh6lVvQnrwDSryxvbWeGLF2b8qCiMtXZGzkiCXKoCZwwQkbYTDkhn
         u8hKpMXaYnerOpZ7zwxzc2f51wOXIgAJ0i/zs64Trwh27AyiLWLAxWTSYw0qqzAWD0Ev
         86EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=az2W3f24aofQMN06tQK0E2B1Jt/IJeHT7w5Vk9gWAWc=;
        b=GbkUNrrtdS7gPsLbT4LW3VnN6nKGMG3YswOD8HQGk203DD54IuSrpn+NOxNVTT8E2L
         ym9odIyNsLkaZOK+/WlWnhIBjTnODhrFMSn8sn8UHT2U4XsJY6c+77VwLbbi2p1UiyO/
         m4Epx+Sx/3yrse+gGvUPuuvvdUSvfVsTTpeHoeXgl8Ng6c4IAuyg1cf8sCFjF4Z0R3oD
         06e7lSsQs5nnXDcKE3RMooofMX+Wu477tKDUY0kycu2uI9OGbCsqhqbcUHak8EGAehcs
         Pux2tGI5Zbf982Z/W7ky++8/TlMZeXPqjxayeZuEzES7U3/wmtEkq2hOoQk8EstqjOh8
         RuCw==
X-Gm-Message-State: AOAM533Jja6fyFVShSkYOAxJtFBpouv3msEyk03f9bZcOiyNHmgeOp2M
        zgq979Z3zOw4+IXADGWjgR4JZkqqfC4=
X-Google-Smtp-Source: ABdhPJyttgV5zzhi+JYy8LFONpuBmZbJQ1R94Y5F+QrX/UTfIPjq2972dbbMhfGt52HdR28mm+uHAA==
X-Received: by 2002:a05:600c:3009:b0:381:194a:8cb5 with SMTP id j9-20020a05600c300900b00381194a8cb5mr903718wmh.43.1645695942510;
        Thu, 24 Feb 2022 01:45:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az7sm2296332wmb.14.2022.02.24.01.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:45:42 -0800 (PST)
Message-Id: <89efc1e15646599753baeab38ba2399dcbe868f1.1645695940.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
References: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 09:45:38 +0000
Subject: [PATCH 1/3] merge: new autosetupmerge option 'simple' for matching
 branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

The push.defaut option "simple" helps produce
predictable/understandable behavior for beginners,
where they don't accidentally push to the
"wrong" branch in centralized workflows. If they
create a local branch with a different name
and then try to do a plain push, it will
helpfully fail and explain why.

However, such users can often find themselves
confused by the behavior of git after they first
branch, and before they push. At that stage,
their upstream tracking branch is the original
remote branch, and pull (for example) behaves
very differently to how it later does when they
create their own same-name remote branch.

This commit introduces a new option to the
branch.autosetupmerge setting, "simple",
which is intended to be consistent with and
complementary to the push.default "simple"
option.

It will set up automatic tracking for a new
branch only if the remote ref is a branch and
that remote branch name matches the new local
branch name. It is a reduction in scope of
the existing default option, "true".

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 branch.c | 9 +++++++++
 branch.h | 1 +
 config.c | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/branch.c b/branch.c
index 6b31df539a5..246bc82ce3c 100644
--- a/branch.c
+++ b/branch.c
@@ -256,6 +256,15 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		die(_("not tracking: ambiguous information for ref %s"),
 		    orig_ref);
 
+	if (track == BRANCH_TRACK_SIMPLE) {
+		// only track if remote branch name matches
+		// (tracking.srcs must contain only one entry from find_tracked_branch with this config)
+		if (strncmp(tracking.srcs->items[0].string, "refs/heads/", 11))
+			return;
+		if (strcmp(tracking.srcs->items[0].string + 11, new_ref))
+			return;
+	}
+
 	if (tracking.srcs->nr < 1)
 		string_list_append(tracking.srcs, orig_ref);
 	if (install_branch_config_multiple_remotes(config_flags, new_ref,
diff --git a/branch.h b/branch.h
index 04df2aa5b51..560b6b96a8f 100644
--- a/branch.h
+++ b/branch.h
@@ -12,6 +12,7 @@ enum branch_track {
 	BRANCH_TRACK_EXPLICIT,
 	BRANCH_TRACK_OVERRIDE,
 	BRANCH_TRACK_INHERIT,
+	BRANCH_TRACK_SIMPLE,
 };
 
 extern enum branch_track git_branch_track;
diff --git a/config.c b/config.c
index e0c03d154c9..cc586ac816c 100644
--- a/config.c
+++ b/config.c
@@ -1673,6 +1673,9 @@ static int git_default_branch_config(const char *var, const char *value)
 		} else if (value && !strcmp(value, "inherit")) {
 			git_branch_track = BRANCH_TRACK_INHERIT;
 			return 0;
+		} else if (value && !strcmp(value, "simple")) {
+			git_branch_track = BRANCH_TRACK_SIMPLE;
+			return 0;
 		}
 		git_branch_track = git_config_bool(var, value);
 		return 0;
-- 
gitgitgadget

